<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<s:include value="Banner.jsp" />

<script type="text/javascript" src="js/add-datasource.js"></script>
<script type="text/javascript" src="js/add-report-file.js"></script>
<script type="text/javascript" src="js/add-chart.js"></script>
<script type="text/javascript" src="js/add-parameter.js"></script>

<script type="text/javascript">
  var editReportTabs = new YAHOO.widget.TabView("editReportTabs");  
</script>

<div align="center">
  
  <a class="back-link" href="listReports.action">
  	<i class="fa fa-reply fa-fw"> </i>
  	<s:text name="link.back.reports"/>
  </a>
  
  <br/><br/>
  
  <div id="editReportTabs" class="panel panel-default" style="width: 675px;"><div class="panel-body">
    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation"  <s:if test="selectedTab == 1">class="active"</s:if> >
        	<a href="#tab1" aria-controls="preferences" role="tab" data-toggle="tab">
        		<em>
        			<s:text name="editReport.tab.reportDefinition"/>
        		</em>
        	</a>
        </li>
        <s:if test="!command.equals('add')">
        	<li role="presentation"  <s:if test="selectedTab == 2">class="active"</s:if> >
        		<a href="#tab2" aria-controls="preferences" role="tab" data-toggle="tab">
        			<em>
        				<s:text name="editReport.tab.reportParameters"/>
        			</em>
        		</a>
        	</li>
        </s:if>
        <s:if test="!command.equals('add') && report.jasperReport">       
        	<li role="presentation"  <s:if test="selectedTab ==3">class="active"</s:if> >
        		<a href="#tab3" aria-controls="preferences" role="tab" data-toggle="tab">
        			<em>
        				<s:text name="editReport.tab.jasperReportOptions"/>
        			</em>
        		</a>
        	</li>
        </s:if>
    </ul>            
    <div class="tab-content">
      
      <div id="tab1" role="tabpanel" class="tab-pane <s:if test="selectedTab == 1">active</s:if>">     
      
      <form action="editReport.action" method="post">
      <table>    
        <tr class="a">
          <td class="boldText"><s:text name="label.name"/></td>
          <td>
          	&nbsp;
          </td>
          <td colspan="2"><input class="form-control" type="text" size="60" name="name" value="<s:property value="name"/>"></td>
        </tr>
        <tr class="b">
          <td class="boldText"><s:text name="label.description"/></td>
          <td>
          	&nbsp;
          </td>
          <td colspan="2"><input class="form-control" type="text" size="60" name="description" value="<s:property value="description"/>"></td>
        </tr>     
        <tr>
          <td class="boldText"><s:text name="label.tags"/></td>
          <td>
            &nbsp;
          </td>
          <td colspan="2"><input class="form-control" type="text" size="60" name="tags" value="<s:property value="tags"/>"></td>
        </tr>   
        <tr class="a">
          <td class="boldText" width="20%"><s:text name="label.dataSource"/></td>
          <td>
          	&nbsp;
          </td>
          <td>
          	<s:select cssClass="form-control" id="datasourceSelect" name="dataSourceId" list="dataSources" listKey="id" listValue="name" theme="simple" headerKey="-1" headerValue=" -- None -- "/>    
          </td>
          <td>        
            <input class="btn btn-primary"  type="button" id="showAddDataSource" value="<s:text name="button.addDataSource"/>">    
          </td>
        </tr>       
        <tr>
          <td class="boldText"><s:text name="label.query"/></td>
          <td>
          	<i id="query" class="fa fa-question fa-fw" title="<s:text name="tooltip.report.query"/>"></i>     	
          </td>
          <td colspan="2">  	   
            <textarea class="form-control" rows="5" cols="70" name="query"><s:property value="query"/></textarea>
          </td>
        </tr>     
        <tr class="a">
          <td class="boldText" width="20%"><s:text name="label.chart"/></td>
          <td>
          	<i id="chart" class="fa fa-question fa-fw" title="<s:text name="tooltip.report.chart"/>"></i>      	
          </td>
          <td>
          	<s:select cssClass="form-control" id="chartSelect" name="reportChartId" list="reportCharts" listKey="id" listValue="name" theme="simple" headerKey="-1" headerValue=" -- None -- "/>    
          </td>
          <td>    
            <input class="btn btn-primary" type="button" id="showAddChart" value="<s:text name="button.addChart"/>">
          </td>
        </tr>       
        <tr class="b">
          <td class="boldText"><s:text name="label.reportFile"/></td>
          <td>
          	<i id="file" class="fa fa-question fa-fw" title="<s:text name="tooltip.report.file"/>"></i>    	              
          </td>
          <td>
          	<s:select cssClass="form-control" id="fileSelect" name="file" list="reportFileNames" theme="simple" headerKey="-1" headerValue=" -- None -- "/>     
          </td>
          <td>	     
            <input class="btn btn-primary" type="button" id="showAddReportFile" value="<s:text name="button.addReportFile"/>">
          </td>
        </tr>  
        <tr>
          <td class="boldText"><s:text name="label.hidden"/></td>
          <td>
          	<i id="hidden" class="fa fa-question fa-fw" title="<s:text name="tooltip.report.hidden"/>"></i>     	
          </td>
          <td>
          	<s:checkbox name="hidden" fieldValue="true" theme="simple"/>            	  	   
          </td>
        </tr>    
        <tr>
          <td class="boldText"><s:text name="label.virtualization"/></td>
          <td>
          	<i id="virtual" class="fa fa-question fa-fw" title="<s:text name="tooltip.report.virtualization"/>"></i>  	
          </td>
          <td><s:checkbox name="virtual" fieldValue="true" theme="simple"/></td>
        </tr> 
        <tr class="b">
          <td class="boldText"><s:text name="label.exportTypes"/></td>
          <td>
          	<i id="export" class="fa fa-question fa-fw" title="<s:text name="tooltip.report.export"/>"></i>     	
          </td>
          <td>
          	<s:checkbox name="pdfExportEnabled" fieldValue="true" theme="simple"/>PDF 
            <s:checkbox name="htmlExportEnabled" fieldValue="true" theme="simple"/>HTML
            <s:checkbox name="csvExportEnabled" fieldValue="true" theme="simple"/>CSV
            <s:checkbox name="xlsExportEnabled" fieldValue="true" theme="simple"/>XLS
            <br/>
            <s:checkbox name="rtfExportEnabled" fieldValue="true" theme="simple"/>RTF
            <s:checkbox name="textExportEnabled" fieldValue="true" theme="simple"/>TEXT
            <s:checkbox name="excelExportEnabled" fieldValue="true" theme="simple"/>EXCEL
            <s:checkbox name="imageExportEnabled" fieldValue="true" theme="simple"/>IMAGE                    
          </td>
        </tr>             
        <tr>
          <td align="center" class="dialogButtons" colspan="4">
          	<input class="standardButton btn btn-primary" type="submit" name="submitOk" value="<s:text name="button.save"/>">   
          	<input class="standardButton btn" type="submit" name="submitDuplicate" value="<s:text name="button.duplicate"/>">  
          </td>
        </tr> 
        </table>
        
        <input type="hidden" name="id" value="<s:property value="id"/>">
        <input type="hidden" name="command" value="<s:property value="command"/>">
        <input type="hidden" name="selectedTab" value="1">
        
        </form>
    
        </div>
        
        <s:if test="!command.equals('add')">
        <div id="tab2" role="tabpanel" class="tab-pane <s:if test="selectedTab == 2">active</s:if>">
        
        <table class="dialog">
        <tr>
          <th colspan="2"><s:text name="label.reportParameter"/></th>
          <th><s:text name="label.required"/></th>     
          <th><s:text name="label.step"/></th>
          <th><s:text name="label.sortOrder"/></th>
          <th colspan="2">&nbsp;</th>
        </tr>   
        <s:iterator id="parameterInReport" value="parametersInReport">          
        <form action="editReportParameterMap.action"  >
        <tr class="a">   	 
       	  <td colspan="2">
       	    <s:property value="reportParameter.name"/>
       	  </td>       
       	  <td>       	  	 
       	  	 <s:checkbox name="required" fieldValue="true" theme="simple"/>       	  
       	  </td>       	      	  
       	  <td>
       	    <input type="text" class="form-control" size="2" name="step" value="<s:property value="step"/>">   	    
       	  </td>  
       	  <td>
       	    <input type="text" class="form-control" size="2" name="sortOrder" value="<s:property value="sortOrder"/>">   	    
       	  </td>  
       	  <td class="dialogButtons">
       	  	<input class="standardButton btn btn-primary" type="submit" name="submitUpdate" value="<s:text name="button.update"/>">
       	  </td> 
       	  <td class="dialogButtons">
       	  	<input class="standardButton btn btn-danger" type="submit" name="submitDelete" value="<s:text name="button.delete"/>">
       	  </td> 
        </tr>   
        <input type="hidden" name="id" value="<s:property value="id"/>">
        <input type="hidden" name="command" value="<s:property value="command"/>"> 
        <input type="hidden" name="reportParameterId" value="<s:property value="reportParameter.id"/>"/>    
        <input type="hidden" name="selectedTab" value="2">
        </form>
        </s:iterator>   
        <form action="editReportParameterMap.action"  >     
        <tr class="a">
          <td colspan="7"><hr></td>
        </tr>
        <tr>
          <td colspan="2">
          	<s:select cssClass="form-control" name="reportParameterId" list="reportParameters" listKey="id" listValue="name" theme="simple"/>         
          </td>       
          <td class="dialogButtons" >        
          	<input class="standardButton btn btn-primary" type="submit" name="submitAdd" value="<s:text name="button.add"/>">            
          </td>             
        </tr>      
        <tr class="a">
          <td colspan="7"><hr></td>
        </tr>
        <tr>        
          <td colspan="6">
          	<s:text name="editReport.parameters.addNew"/>            
          </td>      
          <td colspan="1" class="dialogButtons" >           
            <input class="btn" type="button" id="showAddParameter" value="<s:text name="button.addNew"/>">
          </td>             
        </tr>
        <input type="hidden" name="id" value="<s:property value="id"/>"> 
      	<input type="hidden" name="command" value="<s:property value="command"/>"> 
        <input type="hidden" name="selectedTab" value="2">
      	</form>    
        </table>
        
        </div>
        </s:if>
        
        <s:if test="!command.equals('add') && report.jasperReport">
        <div id="tab3" role="tabpanel" class="tab-pane <s:if test="selectedTab == 3">active</s:if>">
        
        <form action="editExportOptions.action">	 
 
        <table class="table table-striped" >
        <thead>
      	<tr>	
      	  <th>
      	  	<s:text name="label.exportFormat"/>      	   
      	  </th>	
      	  <th colspan="2" nowrap>
      	  	<s:text name="label.exportOption"/>
      	  </th>	 
      	  <th></th>
      	</tr>
      	</thead>
      	<tbody>
      	<tr>
      	    <td >XLS</td>
            <td nowrap colspan="2" ><s:text name="editReport.jasperOption.removeEmptySpaceBetweenRows"/></td>
            <td width="50px"><s:checkbox name="xlsRemoveEmptySpaceBetweenRows" fieldValue="true" theme="simple"/></td>
          </tr>   
          <tr>
      	    <td >XLS</td>
      	  	<td nowrap colspan="2" ><s:text name="editReport.jasperOption.whitePageBackground"/></td>
            <td width="50px"><s:checkbox name="xlsWhitePageBackground" fieldValue="true" theme="simple"/></td>          
          </tr>  
          <tr>
            <td >XLS</td>
            <td nowrap colspan="2" ><s:text name="editReport.jasperOption.onePagePerSheet"/></td>
            <td width="50px"><s:checkbox name="xlsOnePagePerSheet" fieldValue="true" theme="simple"/></td>          
          </tr>        
          <tr>
            <td  >XLS</td>
            <td  nowrap colspan="2" ><s:text name="editReport.jasperOption.autoDetectCellType"/></td>
            <td  width="50px"><s:checkbox name="xlsAutoDetectCellType" fieldValue="true" theme="simple"/></td>          
          </tr>  
          <tr>
      	  <td  >HTML</td>
      	  	<td  nowrap colspan="2" ><s:text name="editReport.jasperOption.removeEmptySpaceBetweenRows"/></td>
            <td  width="50px"><s:checkbox name="htmlRemoveEmptySpaceBetweenRows" fieldValue="true" theme="simple"/></td>          
          </tr>   
          <tr>
            <td  >HTML</td>
            <td  nowrap colspan="2" ><s:text name="editReport.jasperOption.whitePageBackground"/></td>
            <td  width="50px"><s:checkbox name="htmlWhitePageBackground" fieldValue="true" theme="simple"/></td>           
          </tr>    
          <tr>
      	  <td  >HTML</td>
      	  	<td  nowrap colspan="2" ><s:text name="editReport.jasperOption.usingImagesToAlign"/></td>
            <td  width="50px"><s:checkbox name="htmlUsingImagesToAlign" fieldValue="true" theme="simple"/></td>           
          </tr>   
          <tr>
            <td  >HTML</td>
            <td  nowrap colspan="2" ><s:text name="editReport.jasperOption.wrapBreakWord"/></td>
            <td  width="50px"><s:checkbox name="htmlWrapBreakWord" fieldValue="true" theme="simple"/></td>     
          </tr>     
          <tr>
          	<hr>
            <td align="center" colspan="4" class="dialogButtons">
      		<input class="standardButton btn btn-primary" type="submit" name="submitType" value="<s:text name="button.save"/>">		
      	  </td>
          </tr>    
         </tbody>
         </table>
         <input type="hidden" name="id" value="<s:property value="id"/>">
         <input type="hidden" name="command" value="<s:property value="command"/>">    
         <input type="hidden" name="selectedTab" value="3">
        </form>  
   
        </div>
        </s:if>
        
    </div>
    
    		<div class="error"><s:actionerror/></div>
            <div id="response" class="error"></div>
          
</div>
</div>

<s:include value="AddDataSourceDialog.jsp"/>		
<s:include value="AddReportFileDialog.jsp"/>
<s:include value="AddChartDialog.jsp"/>
<s:include value="AddParameterDialog.jsp"/>

<s:include value="Footer.jsp" />

<script type="text/javascript">
  var fileTooltip = new YAHOO.widget.Tooltip("fileTooltip", { context:"file" } );
  var queryTooltip = new YAHOO.widget.Tooltip("queryTooltip", { context:"query" } );
  var chartTooltip = new YAHOO.widget.Tooltip("chartTooltip", { context:"chart" } );
  var hiddenTooltip = new YAHOO.widget.Tooltip("hiddenTooltip", { context:"hidden" } );
  var virtualTooltip = new YAHOO.widget.Tooltip("virtualTooltip", { context:"virtual" } );
  var exportTooltip = new YAHOO.widget.Tooltip("exportTooltip", { context:"export" } );
</script>

