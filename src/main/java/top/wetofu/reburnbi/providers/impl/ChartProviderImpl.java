/*
 * Copyright (C) 2003 Erik Swenson - erik@oreports.com
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

package top.wetofu.reburnbi.providers.impl;

import java.util.List;

import org.apache.log4j.Logger;
import top.wetofu.reburnbi.objects.ReportChart;
import top.wetofu.reburnbi.providers.ChartProvider;
import top.wetofu.reburnbi.providers.HibernateProvider;
import top.wetofu.reburnbi.providers.ProviderException;
import top.wetofu.reburnbi.util.ConstraintException;
import top.wetofu.reburnbi.util.LocalStrings;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

public class ChartProviderImpl
	implements ChartProvider
{
	protected static Logger log =
		Logger.getLogger(ChartProviderImpl.class.getName());
	
	private HibernateProvider hibernateProvider;
	
	public ChartProviderImpl(HibernateProvider hibernateProvider) throws ProviderException
	{		
		this.hibernateProvider = hibernateProvider;
		log.info("Created");
	}

	public ReportChart getReportChart(Integer id)
		throws ProviderException
	{
		return (ReportChart) hibernateProvider.load(ReportChart.class, id);
	}
	
	public ReportChart getReportChart(String name)
		throws ProviderException
	{
		Session session = null;
		
		try
		{
			session = hibernateProvider.openSession();
			
			Criteria criteria = session.createCriteria(ReportChart.class);
			criteria.add(Restrictions.eq("name", name));
			
			return (ReportChart) criteria.uniqueResult();
		}
		catch (HibernateException he)
		{
			throw new ProviderException(he);
		}
		finally
		{
			hibernateProvider.closeSession(session);
		}
	}
	
	@SuppressWarnings("unchecked")
	public List<ReportChart> getReportCharts() throws ProviderException
	{
		String fromClause =
			"from top.wetofu.reburnbi.objects.ReportChart reportChart order by reportChart.name ";
		
		return (List<ReportChart>) hibernateProvider.query(fromClause);
	}
	
	public ReportChart insertReportChart(ReportChart reportChart)
		throws ProviderException
	{
		return (ReportChart) hibernateProvider.save(reportChart);
	}
	
	public void updateReportChart(ReportChart reportChart)
		throws ProviderException
	{
		hibernateProvider.update(reportChart);
	}
	
	public void deleteReportChart(ReportChart reportChart)
		throws ProviderException
	{
		try
		{
			hibernateProvider.delete(reportChart);
		}
		catch (ConstraintException ce)
		{
			throw new ProviderException(LocalStrings.ERROR_CHART_DELETION);
		}
	}	
}