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

package top.wetofu.reburnbi.engine;

import java.util.List;

import top.wetofu.reburnbi.engine.input.ReportEngineInput;
import top.wetofu.reburnbi.engine.output.ReportEngineOutput;
import top.wetofu.reburnbi.objects.Report;
import top.wetofu.reburnbi.objects.ReportParameter;
import top.wetofu.reburnbi.providers.DataSourceProvider;
import top.wetofu.reburnbi.providers.DirectoryProvider;
import top.wetofu.reburnbi.providers.PropertiesProvider;
import top.wetofu.reburnbi.providers.ProviderException;
import org.springframework.context.ApplicationContext;

public abstract class ReportEngine
{	
	protected DataSourceProvider dataSourceProvider;
	protected DirectoryProvider directoryProvider;
	protected PropertiesProvider propertiesProvider;	
	
	protected ApplicationContext applicationContext;
	
	public ReportEngine(DataSourceProvider dataSourceProvider,
			DirectoryProvider directoryProvider, PropertiesProvider propertiesProvider)
	{
		this.dataSourceProvider = dataSourceProvider;
		this.directoryProvider = directoryProvider;
		this.propertiesProvider = propertiesProvider;
	}
	
	public abstract ReportEngineOutput generateReport(ReportEngineInput input)
			throws ProviderException;

	public abstract List<ReportParameter> buildParameterList(Report report) throws ProviderException;

	public void setApplicationContext(ApplicationContext applicationContext) 
	{
		this.applicationContext = applicationContext;
	}	
}