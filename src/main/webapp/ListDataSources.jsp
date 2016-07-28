<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<s:include value="Banner.jsp" />

<s:actionerror/> 

<br/>

<div align="center">
  
   	<div class="instructions" id="instructions">
		<a href="editDataSource.action?command=add">
			<i class="fa fa-plus fa-fw"></i> <s:text name="link.admin.addDataSource"/>
		</a>
		<a href="reportAdmin.action?command=add">
  			<i class="fa fa-reply fa-fw"></i> <s:text name="link.back.admin"/>
  		</a>
	</div>
  	
  <br/>
  
  <s:set name="dataSourceNames" value="dataSourceNames" scope="request" />
  <div class="container">
  <display:table name="dataSourceNames" class="displaytag table table-striped" sort="list" requestURI="listDataSources.action" decorator="top.wetofu.reburnbi.util.HRefColumnDecorator">  	      
    <display:column property="name" href="editDataSource.action?command=edit" paramId="id" paramProperty="id" titleKey="label.name" sortable="true" headerClass="sortable"/>    	     	      	     
    <display:column property="removeLink" title="" href="deleteDataSource.action" paramId="id" paramProperty="id"/> 	     	     		
  </display:table>
  </div> 
  <br> 
</div>

<s:include value="Footer.jsp" />

