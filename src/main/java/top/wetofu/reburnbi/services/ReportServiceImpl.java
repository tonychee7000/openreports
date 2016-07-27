/*
 * Copyright (C) 2006 Erik Swenson - erik@oreports.com
 * 
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the Free
 * Software Foundation; either version 2 of the License, or (at your option)
 * any later version.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 * 
 * You should have received a copy of the GNU General Public License along with
 * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
 * Place - Suite 330, Boston, MA 02111-1307, USA.
 *  
 */

package top.wetofu.reburnbi.services;

import com.thoughtworks.xstream.XStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import org.apache.log4j.Logger;
import top.wetofu.reburnbi.ORStatics;
import top.wetofu.reburnbi.ReportConstants.DeliveryMethod;
import top.wetofu.reburnbi.engine.ReportEngine;
import top.wetofu.reburnbi.engine.ReportEngineHelper;
import top.wetofu.reburnbi.engine.input.ReportEngineInput;
import top.wetofu.reburnbi.engine.output.QueryEngineOutput;
import top.wetofu.reburnbi.engine.output.ReportEngineOutput;
import top.wetofu.reburnbi.objects.Report;
import top.wetofu.reburnbi.objects.ReportLog;
import top.wetofu.reburnbi.objects.ReportSchedule;
import top.wetofu.reburnbi.objects.ReportUser;
import top.wetofu.reburnbi.providers.DataSourceProvider;
import top.wetofu.reburnbi.providers.DirectoryProvider;
import top.wetofu.reburnbi.providers.ParameterProvider;
import top.wetofu.reburnbi.providers.PropertiesProvider;
import top.wetofu.reburnbi.providers.ProviderException;
import top.wetofu.reburnbi.providers.ReportLogProvider;
import top.wetofu.reburnbi.providers.ReportProvider;
import top.wetofu.reburnbi.providers.SchedulerProvider;
import top.wetofu.reburnbi.providers.UserProvider;
import top.wetofu.reburnbi.services.info.ReportInfo;
import top.wetofu.reburnbi.services.input.ParameterInput;
import top.wetofu.reburnbi.services.input.ReportServiceInput;
import top.wetofu.reburnbi.services.output.ReportServiceOutput;
import top.wetofu.reburnbi.services.util.Converter;
import top.wetofu.reburnbi.util.LocalStrings;
import top.wetofu.reburnbi.util.ORUtil;

/**
 * ReportService implementation using standard OpenReports providers. 
 * 
 * @author Erik Swenson
 */

public class ReportServiceImpl implements ReportService
{
	private static Logger log = Logger.getLogger(ReportServiceImpl.class.getName());

	private ReportProvider reportProvider;
	private ReportLogProvider reportLogProvider;	
	private SchedulerProvider schedulerProvider;
	private UserProvider userProvider;	
	private DirectoryProvider directoryProvider;
	private ParameterProvider parameterProvider;	
	private DataSourceProvider dataSourceProvider;
	private PropertiesProvider propertiesProvider;		
    private UserService userService;
    
    private XStream xStream;

	public ReportServiceImpl()
	{
        this.xStream = new XStream();
        
		log.info("ReportService: Started");
	}		
	
	/**
	 * Generate a Report and return a ReportEngineOutput. Contents of the
	 * ReportEngineOutput vary with the deliveryMethod and exportType of the
	 * ReportServiceInput.
	 * 
	 * Returns errors messages in the message field of the ReportServiceOutput.
	 * 
	 * Includes Report Logging functionality.
	 */
	public ReportServiceOutput generateReport(ReportServiceInput reportInput)
	{		        
		ReportServiceOutput reportOutput = new ReportServiceOutput();	        
                
        try
        {
           userService.authenticate(reportInput.getUser());        
        }
        catch(ServiceException e)
        {
            reportOutput.setContentMessage(e.getMessage());
            return reportOutput;
        }
        
		if (reportInput.getReportName() == null)
		{
            reportOutput.setContentMessage(ServiceMessages.REPORT_NAME_REQUIRED);
            return reportOutput;			
		}		
		
		try
		{
			Report report = reportProvider.getReport(reportInput.getReportName());
			if (report == null)
			{
				reportOutput.setContentMessage("Invalid ReportInput - Report not found: " + reportInput.getReportName());
				log.warn("generateReport: request :  " + reportInput.getRequestId() + " : " + reportOutput.getContentMessage());
				
				return reportOutput;
			}
			
			ReportUser user = userProvider.getUser(reportInput.getUser().getUserName(), reportInput.getUser().getPassword());
			if (user == null)
			{
				reportOutput.setContentMessage("Invalid ReportInput - User not found: " + reportInput.getUser().getUserName());
				log.warn("generateReport: request :  " + reportInput.getRequestId() + " : " + reportOutput.getContentMessage());
				
				return reportOutput;
			}
			
			if (!user.isValidReport(report))
			{
				reportOutput.setContentMessage("Invalid ReportInput - "
						+ user.getName() + " not authorized to run: "
						+ reportInput.getReportName());
				
				log.warn("generateReport: request :  " + reportInput.getRequestId() + " : " + reportOutput.getContentMessage());
				
				return reportOutput;	
			}		
			
			log.info("generateReport: received request :  " + reportInput.getRequestId() + " : for report : " + report.getName() + " : from : " +  user.getName());
			
            if (reportInput.getDeliveryMethods() == null || reportInput.getDeliveryMethods().length < 1)
            {
                ReportLog reportLog = null;
                
                try
                {
                    reportLog = new ReportLog(user, report, new Date());
                    reportLog.setExportType(reportInput.getExportType().getCode());
                    
                    reportLog = reportLogProvider.insertReportLog(reportLog);               
                                  
                    ReportEngine reportEngine = ReportEngineHelper.getReportEngine(report,
                            dataSourceProvider, directoryProvider, propertiesProvider);
                    
                    ReportEngineInput engineInput = new ReportEngineInput(report, buildParameterMap(reportInput, report));
                    engineInput.setExportType(reportInput.getExportType()); 
                    engineInput.setXmlInput(reportInput.getXmlInput());
                    engineInput.setLocale(ORUtil.getLocale(reportInput.getLocale()));
                    
                    ReportEngineOutput reportEngineOutput = reportEngine.generateReport(engineInput);
                    
                    reportOutput.setContent(reportEngineOutput.getContent());
                    reportOutput.setContentType(reportEngineOutput.getContentType());
                    reportOutput.setContentExtension(reportEngineOutput.getContentExtension());
                    
                    //convert List of Dynabeans to XML so that it can be serialized
                    if (reportEngineOutput instanceof QueryEngineOutput)
                    {
                        ByteArrayOutputStream out = new ByteArrayOutputStream();           
                                           
                        xStream.toXML(((QueryEngineOutput)reportEngineOutput).getResults(), out);                   
                        
                        reportOutput.setContent(out.toByteArray());
                        reportOutput.setContentType(ReportEngineOutput.CONTENT_TYPE_XML);
                        
                        out.close();                 
                    }                
                   
                    reportLog.setStatus(ReportLog.STATUS_SUCCESS);
                    reportLog.setEndTime(new Date());
                    
                    reportLogProvider.updateReportLog(reportLog); 
                }
                catch(Exception e)
                {
                    if (reportLog != null && reportLog.getId() != null)
                    {
                        reportLog.setStatus(ReportLog.STATUS_FAILURE);
                        reportLog.setMessage(e.getMessage());
                        reportLog.setEndTime(new Date());
                        
                        try
                        {
                            reportLogProvider.updateReportLog(reportLog);
                        }
                        catch (Exception ex)
                        {
                            log.error("Unable to update ReportLog: " + ex.getMessage());
                        }                       
                    }
                }
            }
            else           
            {           
				ReportSchedule schedule = new ReportSchedule();
				schedule.setReport(report);
				schedule.setUser(user);
				schedule.setReportParameters(buildParameterMap(reportInput, report));
				schedule.setExportType(reportInput.getExportType().getCode());				
				schedule.setScheduleName(report.getId() + "|" + new Date().getTime());
				schedule.setScheduleDescription(reportInput.getScheduleDescription());				
				schedule.setScheduleType(ReportSchedule.ONCE);
				schedule.setXmlInput(reportInput.getXmlInput());                
                schedule.setDeliveryReturnAddress(reportInput.getDeliveryReturnAddress());
                schedule.setRequestId(reportInput.getRequestId());
                schedule.setSchedulePriority(reportInput.getSchedulePriority());                
                schedule.setDeliveryMethods(convertDeliveryMethodsToNames(reportInput.getDeliveryMethods()));
                schedule.setLocale(ORUtil.getLocale(reportInput.getLocale()));
                
                if (reportInput.getDeliveryAddress() != null)
                {
                    schedule.setRecipients(reportInput.getDeliveryAddress());
                }
                else
                {
                    schedule.setRecipients(user.getEmail());
                }
				
				// advanced scheduling
				if (reportInput.getStartDate() != null)
				{
					if (!user.isAdvancedScheduler())
					{
						throw new ProviderException("Not Authorized: Advanced Scheduling permission required");					
					}
					
					schedule.setScheduleType(reportInput.getScheduleType().getCode());
					schedule.setStartDate(reportInput.getStartDate());
					schedule.setStartHour(reportInput.getStartHour());
					schedule.setStartMinute(reportInput.getStartMinute());
					schedule.setStartAmPm(reportInput.getStartAmPm().toString());
					schedule.setHours(reportInput.getHours());
					schedule.setCronExpression(reportInput.getCronExpression());					
				}
								
				schedulerProvider.scheduleReport(schedule);					
			}					
            
			reportOutput.setContentMessage(LocalStrings.SERVICE_REQUEST_COMPLETE);           	
		}
		catch (Exception e)
		{			
			log.error("generateReport: request : " + reportInput.getRequestId(), e);					
			reportOutput.setContentMessage(e.getMessage());				
		}
		
		log.info("generateReport: request : " + reportInput.getRequestId() + " : status : " + reportOutput.getContentMessage());	        
        		
		return reportOutput;
	}	  
    
	public ReportInfo getReportInfo(String reportName)
	{
		ReportInfo reportInfo = null;
		
		try
		{
			Report report = reportProvider.getReport(reportName);
			if (report != null)
			{
				reportInfo = Converter.convertToReportInfo(report);
			}
		}
		catch(ProviderException pe)
		{
			log.warn(pe);
		}
		
		return reportInfo;		
	}

	/**
	 * Builds report parameter map from incoming ReportServiceInput and adds
	 * standard report parameters.
	 */	
	private Map<String,Object> buildParameterMap(ReportServiceInput reportServiceInput, Report report) throws ProviderException
	{
		Map<String,Object> inputParameters = new HashMap<String,Object>();
		
		if (reportServiceInput.getParameters() != null)
		{
            ParameterInput[] parameters = reportServiceInput.getParameters();
            for (int i=0; i < parameters.length; i++)            
            {               
                inputParameters.put(parameters[i].getName(), parameters[i].getValues());
            }
        }
		
		Map<String,Object> parsedParameters = parameterProvider.getReportParametersMap(report.getParameters(), inputParameters);		
		parsedParameters.put(ORStatics.IMAGE_DIR, new File(directoryProvider.getReportImageDirectory()));		
		parsedParameters.put(ORStatics.REPORT_DIR, new File(directoryProvider.getReportDirectory()));		
			
		return parsedParameters;
	}
	
	private String[] convertDeliveryMethodsToNames(DeliveryMethod[] deliveryMethods) throws ServiceException
	{
		if (deliveryMethods == null || deliveryMethods.length < 1 || deliveryMethods[0] == null) 
		{
			throw new ServiceException("Delivery method not specified.");
		}
		
		String[] deliveryMethodNames = new String[deliveryMethods.length];
		for (int i=0; i < deliveryMethods.length; i++)
		{
			deliveryMethodNames[i] = deliveryMethods[i].getName();
		}
		
		return deliveryMethodNames;
	}

	public void setDirectoryProvider(DirectoryProvider directoryProvider)
	{
		this.directoryProvider = directoryProvider;
	}

	public void setParameterProvider(ParameterProvider parameterProvider)
	{
		this.parameterProvider = parameterProvider;
	}

	public void setReportLogProvider(ReportLogProvider reportLogProvider)
	{
		this.reportLogProvider = reportLogProvider;
	}

	public void setReportProvider(ReportProvider reportProvider)
	{
		this.reportProvider = reportProvider;
	}	

	public void setSchedulerProvider(SchedulerProvider schedulerProvider)
	{
		this.schedulerProvider = schedulerProvider;
	}

	public void setUserProvider(UserProvider userProvider)
	{
		this.userProvider = userProvider;
	}	

	public void setDataSourceProvider(DataSourceProvider dataSourceProvider)
	{
		this.dataSourceProvider = dataSourceProvider;
	}

	public void setPropertiesProvider(PropertiesProvider propertiesProvider)
	{
		this.propertiesProvider = propertiesProvider;
	}	
    
    public void setUserService(UserService userService) 
    {
        this.userService = userService;
    }	
}
