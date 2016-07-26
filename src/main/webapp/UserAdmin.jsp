<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<s:include value="Banner.jsp" />

<s:actionerror/> 

<script type="text/javascript">
  var userAdminReportTabs = new YAHOO.widget.TabView("userAdminReportTabs");
</script>

<style>
  .yui-navset ul {
    padding-right: 450px;
  }
</style>

<div align="center">

<br/>

<div class="panel panel-default" style="width: 800px;">
<div id="userAdminReportTabs" class="panel-body" >
  <ul class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active">
    	<a href="#preferences" aria-controls="preferences" role="tab" data-toggle="tab">
    		<em>
    			<s:text name="userAdmin.preferences"/>
    		</em>
    	</a>
    </li>
    <s:if test="user.alertUser">
    <li role="presentation">
    	<a href="#alerts" aria-controls="alerts" role="tab" data-toggle="tab">
    		<em>
    			<s:text name="userAdmin.alerts"/>
    		</em>
    	</a>
    </li>
    </s:if>
  </ul>            
  <div class="tab-content">
  
    <div id="preferences" role="tabpanel" class="tab-pane active"> 
  
    <form action="userAdmin.action">
   		<div class="form-group input-group"></div>
    	<div class="form-group input-group">
    		<span class="input-group-addon">
  				<i class="fa fa-user fa-fw"></i>
  			</span>
  			<input type="text" size="60" name="name" class="form-control" 
  				value="<s:property value="name"/>" 
  				placeholder="<s:text name="label.username"/>">
    	</div>
    	<div class="form-group input-group">
    		<span class="input-group-addon">
  				<i class="fa fa-key fa-fw"></i>
  			</span>
  			<input type="password" size="60" name="password" class="form-control"
  				value="<s:property value="password"/>"
  				placeholder="<s:text name="label.password"/>">
    	</div>
      	<div class="form-group input-group">
    		<span class="input-group-addon">
  				<i class="fa fa-check fa-fw"></i>
  			</span>
  			<input type="password" size="60" name="passwordConfirm" class="form-control"
  				value="<s:property value="passwordConfirm"/>"
  				placeholder="<s:text name="label.confirmPassword"/>">
    	</div>
    	<div class="form-group input-group">
    		<span class="input-group-addon">
  				<i class="fa fa-envelope fa-fw"></i>
  			</span>
  			<input type="text" size="60" name="email" class="form-control"
  				value="<s:property value="email"/>"
  				placeholder="<s:text name="label.email"/>"
  				>
    	</div>
    	<s:if test="#session.user.dashboardUser">  
    	    <div class="form-group input-group">
    	    	<span class="input-group-addon">
  					<i class="fa fa-dashboard fa-fw"></i>
  				</span>
  				<select name="reportId">    
    	    		<option disabled="disabled"><s:text name="label.dashboardReport"/></option>
   	      			<option value="-1">(None)</option>     
          			<s:iterator id="report" value="reports">
           				<option value="<s:property value="id"/>" <s:if test="id == reportId">selected="selected"</s:if> /><s:property value="name"/>
          			</s:iterator>
        		</select>
    	    </div>
   	  	</s:if>  
    	<div class="form-group input-group">
    		<input class="btn btn-primary" type="submit" name="submitType" value="<s:text name="button.save"/>">  
    	</div>   	  	
    
    </form>  
    
    </div>
  
    <s:if test="user.alertUser">   
  
    <div id="alerts" role="tabpanel" class="tab-pane"> 
    	<div class="form-group input-group"></div>
    	<div class="form-group input-group"></div>
    <table class="dialog">
      <tr>
        <td class="boldText" colspan="2"><s:text name="label.alert"/></td>
        <td class="boldText"><s:text name="label.operator"/>&nbsp;</td>     
        <td class="boldText"><s:text name="label.limit"/></td>     
        <td class="boldText"><s:text name="label.report"/></td>   
        <td class="boldText" colspan="2">&nbsp;</td>
      </tr>      
      <s:iterator id="alert" value="user.alerts" status="iteratorStatus">
      <form action="userAdminAlerts.action" class="alert-form" >
      <tr class="a">   	 
   	    <td colspan="2">
   	      <s:property value="alert.name"/>   	       	
   	    </td>     	     	      	  
   	    <td>
   	      <select name="alertOperator">        	   
           <s:iterator id="aOperator" value="operators">
           	<option value="<s:property/>" <s:if test="#aOperator.equals(#alert.operator)">selected="selected"</s:if> /><s:property/>
           </s:iterator>
          </select>   	    
   	    </td>  
   	    <td>
   	      <input type="text" size="6" name="alertLimit" value="<s:property value="limit"/>">   	    
   	    </td>  
   	    <td>
   	      <select name="reportId">    
   	      <option value="-1"> -- None -- </option>    
   	       <s:iterator id="report" value="reports">
           <option value="<s:property value="id"/>" <s:if test="id == report.id">selected="selected"</s:if> /><s:property value="name"/>
          </s:iterator>        
          </select>   	    
   	    </td>  
   	    <td class="dialogButtons">
   	  	 <input class="standardButton" type="submit" name="submitUpdate" value="<s:text name="button.update"/>">
   	    </td> 
   	    <td class="dialogButtons">
   	  	 <input class="standardButton" type="submit" name="submitDelete" value="<s:text name="button.delete"/>">
   	    </td> 
      </tr>   
      <input type="hidden" name="id" value="<s:property value="id"/>">
      <input type="hidden" name="alertId" value="<s:property value="#iteratorStatus.index + 1" />"/>
    </form>
    </s:iterator>   
    <form action="userAdminAlerts.action" class="alert-form">          
    <tr class="a">
      <td colspan="2">
        <select name="alertId">  
           <s:iterator id="alert" value="alerts">             
            <option value="<s:property value="id"/>"><s:property value="name"/></option>
          </s:iterator>
        </select>
      </td>   
      <td>
   	      <select name="alertOperator">         
          <s:iterator id="operator" value="operators">       
          <option value="<s:property value="operator"/>"><s:property value="operator"/> &nbsp;</option>
          </s:iterator>
        </select>   	    
   	  </td>  
   	  <td>
   	    <input type="text" size="6" name="alertLimit" value="0">   	    
   	  </td>  
   	  <td>
   	     <select name="reportId">    
   	      <option value="-1">(None)</option>     
          <s:iterator id="report" value="reports">
          <option value="<s:property value="id"/>"/><s:property value="name"/>
          </s:iterator>
        </select>   	    
   	  </td>     
      <td class="dialogButtons">
      	<input class="standardButton" type="submit" name="submitAdd" value="<s:text name="button.add"/>">
      </td>             
    </tr> 
  	<input type="hidden" name="id" value="<s:property value="id"/>"> 
  	<input type="hidden" name="command" value="<s:property value="command"/>"> 
  	</form>  
    
    </table>
  
    </div>
  
    </s:if>
  
  </div>
  
</div>
</div>
 
<s:include value="Footer.jsp" />

