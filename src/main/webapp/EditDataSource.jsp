<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<s:include value="Banner.jsp" />

<a class="back-link" href="listDataSources.action">
	<i class="fa fa-reply fa-fw"></i>
	<s:text name="link.back.dataSources"/>
</a>
 

<div align="center">

	  <div class="important" id="instructions" style="width: 80%;">
	  	<i class="fa fa-database fa-fw"></i>
	  	<s:if test="command.equals('add')">
		  	<s:text name="editDataSource.addDataSource"/>
	   	</s:if>
	   	<s:if test="!command.equals('add')">
	 		<s:text name="editDataSource.selectedDataSource"/> <s:property value="name"/>
	   	</s:if> 	
	  </div>
	  	
  <form action="editDataSource.action" name="dsForm"  style="width: 85%;">	 
  <div class="panel panel-default"><div class="panel-body">
  <table> 	
		<tr >
			<td class="boldText" width="20%"><s:text name="label.useJNDI"/></td>
			<td>
				<i  id="jndi" class="fa fa-question fa-fw" title="<s:text name="tooltip.datasource.jndi"/>">	</i>
							        
			</td>
			<td><s:checkbox name="jndi" fieldValue="true" theme="simple" /></td>
		</tr>  
		<tr id="dsName">
			<td class="boldText" width="20%"><s:text name="label.name"/></td>
			<td>&nbsp;</td>
			<td><input class="form-control" type="text" size="60" name="name" value="<s:property value="name"/>"></td>
		</tr>         
		<tr id="dsUrl">
			<td  class="boldText" width="20%"><s:text name="label.url"/></td>
			<td>
				<i  id="url" class="fa fa-question fa-fw" title="<s:text name="tooltip.datasource.url"/>">    </i>                  
			</td>
			<td><input class="form-control" type="text" size="60" name="url" value="<s:property value="url"/>"></td>
		</tr>	
		<tr id="dsDriver">
			<td class="boldText" width="20%"><s:text name="label.driver"/></td>
			<td>
				<i id="driver" class="fa fa-question fa-fw" title="<s:text name="tooltip.datasource.driver"/>">	</i>			        
			</td>
			<td><input class="form-control" id="testD" type="text" size="60" name="driver" value="<s:property value="driver"/>"></td>
		</tr>
		<tr id="dsUser">
			<td class="boldText" width="20%"><s:text name="label.username"/></td>
			<td>&nbsp;</td>
			<td><input type="text" class="form-control" size="60" name="userName" value="<s:property value="userName"/>"></td>
		</tr>
		<tr id="dsPassword">
			<td class="boldText" width="20%"><s:text name="label.password"/></td>
			<td>&nbsp;</td>
			<td><input type="password" class="form-control"  size="60" name="password" value="<s:property value="password"/>"></td>
		</tr>
		<tr id="dsMI">
			<td class="boldText" width="20%"><s:text name="label.maxIdle"/></td>
			<td>
				<i class="fa fa-question fa-fw" id="maxidle" src="images/help.gif" title="<s:text name="tooltip.datasource.maxIdle"/>">		</i>		        
			</td>
			<td><input type="text" size="60" class="form-control"  name="maxIdle" value="<s:property value="maxIdle"/>"></td>
		</tr>
		<tr id="dsMA">
			<td  class="boldText" width="20%"><s:text name="label.maxActive"/></td>
			<td>
				<i class="fa fa-question fa-fw" id="maxactive" src="images/help.gif" title="<s:text name="tooltip.datasource.maxActive"/>">		</i>		        
			</td>
			<td><input type="text" size="60" class="form-control"  name="maxActive" value="<s:property value="maxActive"/>"></td>     	
		</tr>
		<tr id="dsMW">
			<td class="boldText" width="20%"><s:text name="label.maxWait"/></td>
			<td>
				<i class="fa fa-question fa-fw" id="maxwait" src="images/help.gif" title="<s:text name="tooltip.datasource.maxWait"/>">			</i>	        
			</td>
			<td><input type="text" size="60" class="form-control" name="maxWait" value="<s:property value="maxWait"/>"></td>     	
		</tr>
		<tr id="dsQuery">
			<td class="boldText" width="20%"><s:text name="label.validationQuery"/></td>
			<td>
				<i class="fa fa-question fa-fw" id="query" src="images/help.gif" title="<s:text name="tooltip.datasource.query"/>">		</i>		        
			</td>
			<td><input type="text" size="60" class="form-control" name="validationQuery" value="<s:property value="validationQuery"/>"></td>     	
		</tr>   
    </table>    
    
      	 <div class="button-bar" id="buttons" >
			<input class="standardButton btn btn-primary" type="submit" name="submitOk" value="<s:text name="button.save"/>">
			<input class="standardButton btn" type="submit" name="submitDuplicate" value="<s:text name="button.duplicate"/>">
		</div>
	
   <input type="hidden" name="id" value="<s:property value="id"/>">
   <input type="hidden" name="command" value="<s:property value="command"/>">  
    </div> </div>
  </form>
  <br> 
  
  <div class="error"><s:actionerror/></div>  
  
</div>

<s:include value="Footer.jsp" />

<script type="text/javascript">
  var jndiTooltip = new YAHOO.widget.Tooltip("jndiTooltip", { context:"jndi" } );
  var urlTooltip = new YAHOO.widget.Tooltip("urlTooltip", { context:"url" } );
  var driverTooltip = new YAHOO.widget.Tooltip("driverTooltip", { context:"driver" } );
  var maxidleTooltip = new YAHOO.widget.Tooltip("maxidleTooltip", { context:"maxidle" } );
  var maxactiveTooltip = new YAHOO.widget.Tooltip("maxactiveTooltip", { context:"maxactive" } );
  var maxwaitTooltip = new YAHOO.widget.Tooltip("maxwaitTooltip", { context:"maxwait" } );
  var queryTooltip = new YAHOO.widget.Tooltip("queryTooltip", { context:"query" } );
</script>


