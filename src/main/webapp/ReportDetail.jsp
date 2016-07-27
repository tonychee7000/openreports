<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<s:include value="Banner.jsp" />

<div>  

<s:if test="!report.displayInline">  
  <a class="back-link" href="reportList.action">
  	<i class="fa fa-reply fa-fw"> </i>
  	<s:text name="link.back.reports"/>
  </a>
  <a class="back-link" href="reportGroup.action">
  	<i class="fa fa-reply fa-fw"> </i>
  	<s:text name="link.back.groups"/>
  </a>  

  <br/><br/>
   
  <div class="important" id="instructions" style="width: 70%;">
  	<i class="fa fa-terminal fa-fw"></i>
	<s:text name="reportDetail.title"/> <s:property value="report.name"/>
  </div> 

</s:if> 
<div class="panel panel-default container">
  <form action="reportDetail.action" name="reportDetail" method="post" class="" > 
  	<div class="form-group input-group"></div>
  	<s:iterator id="reportParameterMap" value="reportParameters"> 
    	<div class="form-group input-group">
    		<span class="input-group-addon">      	
    			<s:property value="reportParameter.description"/>
      			<s:if test="required">*</s:if>
      		</span>
      		<s:if test="reportParameter.type.equals('Text')">        
        		<input class="form-control" type="text" name="<s:property value="reportParameter.name"/>" value="<s:property value="reportParameter.defaultValue"/>" length="50">       
      		</s:if>    
      		<s:if test="reportParameter.type.equals('Date')">   
       			<s:if test="required && reportParameter.defaultValue == null">
      	 			<%-- s:datetimepicker name="%{reportParameter.name}" value="%{defaultDate}" theme="simple" displayFormat="%{dateFormat}"  /> --%>
      	 			<div class="input-append date" data-date-format="<s:property value="dateFormat"/>" id="<s:property value="reportParameter.name"/>">
  						<input name="<s:property value="reportParameter.name"/>" class="form-control" size="16" type="text" value="<s:property value="defaultDate"/>" placeholder="<s:property value="dateFormat"/>">
  						<span class="add-on"></span>
					</div>
        		</s:if>
       			<s:if test="reportParameter.defaultValue != null">
       				<%-- <s:datetimepicker name="%{reportParameter.name}" value="%{reportParameter.defaultValue}" theme="simple" displayFormat="%{dateFormat}" /> --%>
       				<div class="input-append date" data-date-format="<s:property value="dateFormat"/>" id="<s:property value="reportParameter.name"/>">
  						<input name="<s:property value="reportParameter.name"/>" class="form-control" size="16" type="text" value="<s:property value="reportParameter.defaultValue"/>" placeholder="<s:property value="dateFormat"/>">
  						<span class="add-on"></span>
					</div>
        		</s:if>
        		<s:if test="!required && reportParameter.defaultValue == null">
       				<%-- <s:datetimepicker name="%{reportParameter.name}" theme="simple" displayFormat="%{dateFormat}" /> --%>
       				<div class="input-append date" data-date-format="<s:property value="dateFormat"/>" id="<s:property value="reportParameter.name"/>"> 
  						<input name="<s:property value="reportParameter.name"/>" class="form-control" size="16" type="text"  placeholder="<s:property value="dateFormat"/>">
  						<span class="add-on"></span>
					</div>
        		</s:if>
        		<script>
var date_format = $('div#<s:property value="reportParameter.name"/>').data('date-format')
$('div#<s:property value="reportParameter.name"/>').datepicker({
	"format": date_format.toLowerCase()
})
				</script>         
      		</s:if>     
      		<s:if test="reportParameter.type.equals('Query') || reportParameter.type.equals('List') || reportParameter.type.equals('Boolean') ">              
        		<select class="form-control" name="<s:property value="reportParameter.name"/>"  <s:if test="reportParameter.multipleSelect">size="4" multiple</s:if> >        
		  			<s:if test="required && reportParameter.defaultValue == null !reportParameter.type.equals('Boolean') ">  
		    			<option value="" SELECTED>(None)</option>
		  			</s:if>
		  			<s:iterator id="value" value="reportParameter.values">		            
            			<option value="<s:property value="id"/>" <s:if test="description.equals(reportParameter.defaultValue)">SELECTED</s:if> ><s:property value="description"/></option>
          			</s:iterator>
        		</select>
      		</s:if>
    	</div>
    </s:iterator>
    <div class="form-group input-group" style="margin: auto;">
    	<input class="btn btn-primary" type="submit" value="Ok" name="submitType"> 
    </div>
    <div class="form-group input-group">       
       	<input type="hidden" name="reportId" value="<s:property value="reportId"/>">        
       	<input type="hidden" name="step" value="<s:property value="step"/>">      
       	<input type="hidden" name="displayInline" value="<s:property value="displayInline"/>">
  	</div>
  </form>  
</div>  
  <div class="importantSmall"><s:text name="reportDetail.requiredParameters"/></div>
  
  <br/>
  
  <div class="error">
  	<s:actionerror/>
  </div> 
 
</div>

<s:include value="Footer.jsp" />
