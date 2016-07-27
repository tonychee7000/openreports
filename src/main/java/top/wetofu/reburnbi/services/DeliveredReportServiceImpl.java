/*
 * Copyright (C) 2007 Erik Swenson - erik@oreports.com
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

import org.apache.log4j.Logger;
import top.wetofu.reburnbi.ORException;
import top.wetofu.reburnbi.delivery.DeliveryException;
import top.wetofu.reburnbi.delivery.DeliveryMethod;
import top.wetofu.reburnbi.objects.DeliveredReport;
import top.wetofu.reburnbi.objects.ReportUser;
import top.wetofu.reburnbi.providers.UserProvider;
import top.wetofu.reburnbi.services.info.DeliveredReportInfo;
import top.wetofu.reburnbi.services.input.UserInput;
import top.wetofu.reburnbi.services.util.Converter;
import org.springframework.beans.factory.NoSuchBeanDefinitionException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

/**
 * GeneratedReportService implementation using standard OpenReports providers. 
 * 
 * @author Erik Swenson
 */

public class DeliveredReportServiceImpl implements DeliveredReportService, ApplicationContextAware
{
	private static Logger log = Logger.getLogger(DeliveredReportServiceImpl.class.getName());
	
    private ApplicationContext appContext;    
	
    private UserProvider userProvider;
    
    private UserService userService;

	public DeliveredReportServiceImpl()
	{
		log.info("GeneratedReportService: Started");
	}		
	
    public DeliveredReportInfo[] getDeliveredReports(UserInput user, String deliveryMethod) throws ServiceException
    {
        userService.authenticate(user);
        
        try
        {
            ReportUser reportUser = userProvider.getUser(user.getUserName(), user.getPassword());
        
            DeliveryMethod method = getDeliveryMethod(deliveryMethod);
            
            DeliveredReport[] reports = method.getDeliveredReports(reportUser);
            DeliveredReportInfo[] info = new DeliveredReportInfo[reports.length];           
            for(int i=0; i < reports.length; i++)
            {
                info[i] = Converter.convertToDeliveredReportInfo(reports[i]);
            }
            
            return info;
            
        }
        catch(ORException e)
        {
            throw new ServiceException(e);
        }
    }
    
    public byte[] getDeliveredReport(UserInput user, DeliveredReportInfo info) throws ServiceException
    {
        userService.authenticate(user);       
        
        try
        {    
            DeliveryMethod method = getDeliveryMethod(info.getDeliveryMethod());
            return method.getDeliveredReport(Converter.convertToDeliveredReport(info));
        }
        catch(DeliveryException e)
        {
            throw new ServiceException(e);
        }
    }    
    
    protected DeliveryMethod getDeliveryMethod(String deliveryMethodName) throws ServiceException
    {
        if (deliveryMethodName == null)
        {
          throw new ServiceException(ServiceMessages.DELIVERY_METHOD_REQUIRED);
        }
        
        try
        {       
            return (DeliveryMethod) appContext.getBean(deliveryMethodName, DeliveryMethod.class);
        }
        catch(NoSuchBeanDefinitionException e)
        {
            throw new ServiceException("DeliveryMethod not found: " + deliveryMethodName);
        }
    }
    
    public void setUserProvider(UserProvider userProvider)
    {
        this.userProvider = userProvider;
    }

    public void setUserService(UserService userService) 
    {
        this.userService = userService;
    }
    
    public void setApplicationContext(ApplicationContext appContext) 
    {
        this.appContext = appContext;
    }	
}
