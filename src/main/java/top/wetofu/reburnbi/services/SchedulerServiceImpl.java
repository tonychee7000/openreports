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

import java.util.ArrayList;
import java.util.Iterator;

import org.apache.log4j.Logger;
import top.wetofu.reburnbi.objects.ReportSchedule;
import top.wetofu.reburnbi.objects.ReportUser;
import top.wetofu.reburnbi.providers.ProviderException;
import top.wetofu.reburnbi.providers.SchedulerProvider;
import top.wetofu.reburnbi.providers.UserProvider;
import top.wetofu.reburnbi.services.info.ReportScheduleInfo;
import top.wetofu.reburnbi.services.input.UserInput;
import top.wetofu.reburnbi.services.util.Converter;

/**
 * SchedulerService implementation using standard OpenReports providers. 
 * 
 * @author Erik Swenson
 */

public class SchedulerServiceImpl implements SchedulerService
{
	private static Logger log = Logger.getLogger(SchedulerServiceImpl.class.getName());

	private SchedulerProvider schedulerProvider;
	private UserProvider userProvider;
    private UserService userService;

	public SchedulerServiceImpl()
	{
		log.info("SchedulerService: Started");
	}		
	
	public ReportScheduleInfo[] getScheduledReports(UserInput userInput) throws ServiceException
	{
        userService.authenticate(userInput);        
        
		ReportUser user = null;
		
		try
		{
			user = userProvider.getUser(userInput.getUserName(), userInput.getPassword());
		}
		catch(ProviderException pe)
		{
			throw new ServiceException(pe);
		}			
		
		ArrayList<ReportScheduleInfo> schedules = new ArrayList<ReportScheduleInfo>();
		
		try
		{
			Iterator<ReportSchedule> iterator = schedulerProvider.getScheduledReports(user).iterator();	
			while(iterator.hasNext())
			{			
				ReportSchedule schedule = iterator.next();				
			
				ReportScheduleInfo scheduleInfo = new ReportScheduleInfo();
				scheduleInfo.setNextFireDate(schedule.getNextFireDate());
				scheduleInfo.setReportName(schedule.getReport().getName());
				scheduleInfo.setScheduleDescription(schedule.getScheduleDescription());
				scheduleInfo.setScheduleTypeName(schedule.getScheduleTypeName());

				if (schedule.getAlert() != null)
				{
					scheduleInfo.setAlert(Converter.convertToAlertInfo(schedule.getAlert()));
				}
				
				schedules.add(scheduleInfo);			
			}
		}
		catch(ProviderException pe)
		{
            throw new ServiceException(pe);
		}
		
		ReportScheduleInfo[] scheduleInfos = new ReportScheduleInfo[schedules.size()];
		schedules.toArray(scheduleInfos);
		
		return scheduleInfos;		
	}

	public void setUserProvider(UserProvider userProvider)
	{
		this.userProvider = userProvider;
	}

	public void setSchedulerProvider(SchedulerProvider schedulerProvider)
	{
		this.schedulerProvider = schedulerProvider;
	}
    
    public void setUserService(UserService userService) 
    {
        this.userService = userService;
    }	
    
    
}
