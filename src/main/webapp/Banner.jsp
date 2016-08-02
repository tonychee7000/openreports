<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setCharacterEncoding("utf-8");%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html lang="zh-cn">

<head>
  <jsp:directive.page contentType="text/html; charset=UTF-8" /> 
  
  <meta HTTP-EQUIV="Pragma" CONTENT="public">
  <meta HTTP-EQUIV="Cache-Control" CONTENT="max-age=0">
  
  <meta charset="utf-8">
  <title><s:text name="application.title"/></title>
  <link rel="stylesheet" type="text/css" href="css/yui/reset-fonts-grids.css" />
  <link href="css/openreports.css" rel="stylesheet" type="text/css">
  <!-- YUI Dependencies -->
  <script type="text/javascript" src="js/yui/yahoo-min.js"></script>
  <script type="text/javascript" src="js/yui/dom-min.js"></script>
  <script type="text/javascript" src="js/yui/event-min.js"></script>
  <script type="text/javascript" src="js/yui/animation-min.js"></script>
  <script type="text/javascript" src="js/yui/dragdrop-min.js"></script>
  <script type="text/javascript" src="js/yui/connection-min.js"></script>
  <script type="text/javascript" src="js/yui/container-min.js"></script>
  <script type="text/javascript" src="js/yui/element-beta-min.js"></script>
  <script type="text/javascript" src="js/yui/tabview-min.js"></script>
  <script type="text/javascript" src="js/yui/button-beta-min.js"></script> 
  <link rel="stylesheet" type="text/css" href="css/yui/container.css" />
  <link rel="stylesheet" type="text/css" href="css/yui/tabview.css">
  <link rel="stylesheet" type="text/css" href="css/yui/button.css">    
  <!-- End YUI Dependencies -->
  <!-- Bower Dependencies -->
  <script type="text/javascript" src="bower/jquery/dist/jquery.min.js"></script>
  <script type="text/javascript" src="bower/bootstrap/dist/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="bower/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
  <link rel="stylesheet" type="text/css" href="bower/bootstrap/dist/css/bootstrap.min.css"/>
  <link rel="stylesheet" type="text/css" href="bower/bootstrap-datepicker/dist/css/bootstrap-datepicker3.standalone.min.css"/>
  <link rel="stylesheet" type="text/css" href="bower/font-awesome/css/font-awesome.min.css"/>
  <!-- END Bower Dependencies -->
  
  <script type="text/javascript" src="js/highlight.js"></script>
  <script type="text/javascript" src="js/openreports.js"></script>
</head>

<body>

<s:if test="report == null || !report.isDisplayInline()">

<nav class="navbar navbar-default navbar-static-top"> 

	<div>
		<ul class="vert">			
			<li class="navbar-brand">			  
				<s:text name="application.title"/>			
			</li>                     
		</ul>
	</div>   
	<s:if test="#session.breadcrumbs != null">  
	<div id="usermenu">	    
  		<ul class="vert">   	
  		  <s:if test="#session.user">	 
          <li>
          	<button class="btn" id="btn-logout">
          		<i class="fa fa-sign-out fa-fw"> </i>
          		<s:text name="banner.logoff"/>
          	</button>
          </li>         
          <li>
          	<button class="btn
          		<s:if test="#session.breadcrumbs.startsWith('userAdmin')">btn-primary</s:if>" id="btn-userAdmin">
          		<i class="fa fa-user fa-fw"> </i>
          		<s:text name="banner.preferences"/>
          	</button>             
          </li> 
          </s:if>
          <s:if test="#session.user.adminUser">
          	<li>
          		<button class="btn
          		<s:if test="#session.breadcrumbs.startsWith('reportAdmin')">btn-primary</s:if>" id="btn-admin">
          		<i class="fa fa-cog fa-fw"> </i>
          		<s:text name="banner.administration"/>
          		</button>
            </li>
          </s:if>  
          <s:if test="#session.user.scheduler">
          <li>
          	<button class="btn
          	<s:if test="#session.breadcrumbs.startsWith('listScheduledReports')">btn-primary</s:if>" id="btn-scheduler">
          	<i class="fa fa-tasks fa-fw"> </i>
          	<s:text name="banner.scheduledReports"/>
          	</button>
          </li> 
          </s:if>
          <s:if test="#session.user">
          <li>
          	<button class="btn
          	<s:if test="#session.breadcrumbs.startsWith('reportGroup')">btn-primary</s:if>" id="btn-reports">
          	<i class="fa fa-list-alt fa-fw"> </i>
          	<s:text name="banner.reports"/>
          </li>
          </s:if>
          <s:if test="#session.user.dashboardUser">
          <li>
          	<button class="btn
          	<s:if test="#session.breadcrumbs.startsWith('dashboard')">btn-primary</s:if>" id="btn-dashboard">
          	<i class="fa fa-dashboard fa-fw"> </i>
          	<s:text name="banner.dashboard"/>
          	</button>        
          </li>
          </s:if>      
        </ul>
    </div>
    </s:if>    
    
</nav> 

</s:if>