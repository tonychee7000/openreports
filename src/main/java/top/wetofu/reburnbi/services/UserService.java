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

import top.wetofu.reburnbi.services.info.ReportInfo;
import top.wetofu.reburnbi.services.info.UserInfo;
import top.wetofu.reburnbi.services.input.UserInput;

/**
 * Central Interface for external access into OpenReports user information
 * 
 * @author Erik Swenson
 * @see UserServiceImpl
 */

public interface UserService
{	
	/**
	 * authenticate user
	 */	
	public void authenticate(UserInput user) throws ServiceException;
	
	/**
	 * Get a list of reports for a given user
	 */	
	public ReportInfo[] getReports(UserInput user) throws ServiceException;
	
	/**
	 * Get user information for a given user
	 */	
	public UserInfo getUserInfo(UserInput user) throws ServiceException;
	
	/**
	 * Update user information
	 */	
	public void updateUserInfo(UserInput user, UserInfo userInfo) throws ServiceException;
}
