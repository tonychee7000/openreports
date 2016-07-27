<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@page import="top.wetofu.reburnbi.util.DisplayProperty"%>
<%@page import="top.wetofu.reburnbi.objects.Report"%>

<s:include value="Banner.jsp" />

<s:if test="report == null || !report.isDisplayInline()">

	<a class="back-link" href="reportList.action">
		<i class="fa fa-reply fa-fw"> </i>
		<s:text name="link.back.reports"/>
	</a>
	<a class="back-link" href="reportGroup.action">
		<i class="fa fa-reply fa-fw"> </i>
		<s:text name="link.back.groups"/>
	</a>  	

	<s:actionerror/>
	<div>  
  		<div class="important" id="instructions">
  			<i class="fa fa-list-alt fa-fw"></i>
  			<s:property value="report.name"/>
  		</div>  
	</div>
</s:if>

<div style="width: 98%; margin:auto;">   
    
  <s:set name="results" value="results" scope="request" />  
  <s:set name="properties" value="properties" scope="request" />
  <s:set name="report" value="report" scope="request" />
  
  <% DisplayProperty[] displayProperties = (DisplayProperty[]) request.getAttribute("properties");
  	 Report report = (Report) request.getAttribute("report");%>
  <display:table name="results" class="displaytag table table-striped" sort="list" export="true" pagesize="20" requestURI="queryReportResult.action">  
    <% for (int i=0; i < displayProperties.length; i++) { %>
      <display:column property="<%=displayProperties[i].getName()%>" title="<%=displayProperties[i].getDisplayName()%>" decorator="<%=displayProperties[i].getDecorator()%>" sortable="true" headerClass="sortable" />
    <% } %>
    <display:setProperty name="export.pdf" value="true"/>
	<display:setProperty name="export.xml" value="false"/>
	<display:setProperty name="export.pdf.filename" value="<%=report.getName() + \".pdf\"%>"/>
	<display:setProperty name="export.csv.filename" value="<%=report.getName() + \".csv\"%>"/>
	<display:setProperty name="export.excel.filename" value="<%=report.getName() + \".xls\"%>"/>	  
  </display:table>

  <s:if test="#session.user.scheduler">
  
    <s:text name="queryReport.scheduleReport"/>
    <a href="reportOptions.action?reportId=<%=report.getId()%>&submitSchedule=true&exportType=3">CSV</a> |
    <a href="reportOptions.action?reportId=<%=report.getId()%>&submitSchedule=true&exportType=1">Excel</a> |
    <a href="reportOptions.action?reportId=<%=report.getId()%>&submitSchedule=true&exportType=0">PDF</a>
  
  </s:if>  

</div>

<s:if test="report == null || !report.isDisplayInline()">

<s:include value="Footer.jsp" />

</s:if>



	
