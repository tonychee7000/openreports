<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<s:include value="Banner.jsp" />

<s:actionerror/> 

<div>  

  <a class="back-link" href="reportGroup.action">
  	<i class="fa fa-reply fa-fw"> </i>
  	<s:text name="link.back.groups"/>
  </a>	
  
  <br/>

  <div class="important" id="instructions">
  	<i class="fa fa-list-alt fa-fw"></i>
  	<s:text name="reportGroup.title"/>
  </div>
  
  <s:set name="reports" value="reports" scope="request" /> 
  <div class="container">
   <display:table name="reports" class="displaytag table table-striped" sort="list" requestURI="reportList.action" >                  
    <display:column property="name" titleKey="label.name" href="reportDetail.action" paramId="reportId" paramProperty="id" sortable="true" headerClass="sortable"/>        
    <display:column property="description" titleKey="label.description" sortable="true" headerClass="sortable"/>              
   </display:table> 
  </div>
  <br>
  
</div>

<s:include value="Footer.jsp" /> 

