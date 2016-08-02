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

package top.wetofu.reburnbi.actions.admin;

import java.util.List;

import org.apache.log4j.Logger;

import top.wetofu.reburnbi.actions.DisplayTagAction;
import top.wetofu.reburnbi.objects.ORTag;
import top.wetofu.reburnbi.providers.ProviderException;
import top.wetofu.reburnbi.providers.TagProvider;

public class SearchAction extends DisplayTagAction  
{	
	private static final long serialVersionUID = 7643660200420455493L;

	protected static Logger log = Logger.getLogger(SearchAction.class);

    private String tags;
    private String search;
	private List results;

	private TagProvider tagProvider;

	public String execute()
	{
		try
		{            
            tags = tagProvider.getTagList(null, ORTag.TAG_TYPE_UI);
			results = tagProvider.getTaggedObjects(new String[]{search}, null, ORTag.TAG_TYPE_UI);
        }
		catch (ProviderException pe)
		{
			addActionError(pe.getMessage());
			return ERROR;
		}

		return SUCCESS;
	}
    
    public String getSearch() 
    {
        return search;
    }
    
    public void setSearch(String search) 
    {
        this.search = search;
    }    
    
    public String getTags() 
    {
        return tags;
    }

    public List getResults() 
    {
        return results;
    }
    
    public void setTagProvider(TagProvider tagProvider) 
    {
        this.tagProvider = tagProvider;
    }

}