<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<s:include value="Banner.jsp" />

<div class="col-md-4 col-md-offset-4 login-panel">
<div id="dialog" class="panel panel-default" align="center">

  <div class="panel-heading"><s:text name="login.title"/></div>
  <div class="panel-body">
  
  <form action="login.action" method="post" name="loginForm" >
    <div class="form-group input-group"></div>
  	<div class="form-group input-group">
  		<span class="input-group-addon">
  			<i class="fa fa-user fa-fw"></i>
  		</span>
  		<input type="text" name="userName" id="userName" class="form-control" size="45" placeholder="<s:text name="label.username"/>">
  	</div>
  	<div class="form-group input-group">
  	  	<span class="input-group-addon">
  			<i class="fa fa-key fa-fw"></i>
  		</span>
  		<input type="password"  name="password" class="form-control" size="45" placeholder="<s:text name="label.password"/>">
  	</div>
  	<div class="form-group input-group">
  		<input class="btn btn-success" type="submit" value="<s:text name="login.submit"/>">
  	</div>
  	<div class="form-group input-group">
		<s:actionerror/>
  	</div>
  </form>
  
  </div>
  
</div>
</div>
</body>

</html>

