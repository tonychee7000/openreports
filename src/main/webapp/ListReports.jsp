<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<s:include value="Banner.jsp" />

<s:actionerror/> 

<br/>

<div align="center">
  
	<div class="instructions" id="instructions">
  		<a href="editReport.action?command=add">
  			<i class="fa fa-plus fa-fw"></i> <s:text name="link.admin.addReport"/>
  		</a>  	  
      	<s:if test="#session.user.uploader">      
  		<a href="reportUpload.action">
  			<i class="fa fa-upload fa-fw"></i> <s:text name="link.admin.uploadReport"/>
  		</a>
  		</s:if>
  		<a href="reportAdmin.action?command=add">
  			<i class="fa fa-reply fa-fw"></i> <s:text name="link.back.admin"/>
  		</a>
  	</div>
  		
  <br/>   
  
  <s:set name="reports" value="reports" scope="request" />  
  <div style="width: 98%; margin:auto;">
  <display:table name="reports" class="displaytag table table-striped" sort="list" requestURI="listReports.action" decorator="top.wetofu.reburnbi.util.HRefColumnDecorator">  	   	      
    <display:column property="name" href="editReport.action?command=edit" paramId="id" paramProperty="id" titleKey="label.name" sortable="true" headerClass="sortable"/>    	     	      	     
    <display:column property="description" titleKey="label.description" sortable="true" headerClass="sortable"/>  	 
    <display:column property="addToGroupLink" title="" href="editReportGroups.action" paramId="id" paramProperty="id"/>  	     	         	        	     	     
    <display:column property="removeLink" title="" href="deleteReport.action" paramId="id" paramProperty="id"/> 	     	     
  </display:table> 
  </div>
  <br>  
  
</div>

<s:include value="Footer.jsp" />


