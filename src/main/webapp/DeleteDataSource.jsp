<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<s:include value="Banner.jsp" />

<a class="back-link" href="listDataSources.action">
	<i class="fa fa-reply fa-fw"></i> <s:text name="link.back.dataSources"/></a>


<div align="center">

   	<div class="important" id="instructions" style="width: 70%;">
   		<i class="fa fa-warning fa-fw"></i><s:text name="deleteDataSource.title"/></div>
   
  <form action="deleteDataSource.action" class="" style="width: 75%;" >
  <div class="panel panel-warning"><div class="panel-body">
   <table  >   
    <tr>
      <td class="boldText" width="20%"><s:text name="label.name"/></td>
      <td><s:property value="name"/></td>
    </tr>  
   </table>
  
   <br>
    
   <div class="button-bar" id="buttons">
        <input class="standardButton btn btn-danger" type="submit" name="submitDelete" value="<s:text name="button.delete"/>">
        <input class="standardButton btn" type="submit" name="submitCancel" value="<s:text name="button.cancel"/>">
         <input type="hidden" name="id" value="<s:property value="id"/>"> 
   </div>
  </div></div>
  </form>
  <br> 
  
  <div class="error"><s:actionerror/></div> 
   
</div>

<s:include value="Footer.jsp" />


