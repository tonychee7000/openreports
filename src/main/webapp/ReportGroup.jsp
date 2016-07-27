<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<s:include value="Banner.jsp" />

<s:actionerror/> 

<div> 
  <div class="important" id="instructions">
  	<i class="fa fa-th-list fa-fw"></i>
  	<s:text name="reportGroup.title"/>
  </div>
  
  <s:set name="reportGroups" value="reportGroups" scope="request" />  	 
	<div class="container"> 
  		<display:table name="reportGroups" class="displaytag table table-striped" sort="list" requestURI="reportGroup.action" >  	      
    		<display:column property="name" titleKey="label.name" href="reportList.action" paramId="groupId" paramProperty="id" sortable="true" headerClass="sortable"/>  	     
    		<display:column property="description" titleKey="label.description" sortable="true" headerClass="sortable"/>  	     	     
  		</display:table>
   	</div>
</div>

<s:include value="Footer.jsp" />

