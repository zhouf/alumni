
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>当前会话已失效</title>
    
    
    <link rel="stylesheet" type="text/css" href="styles.css">
  </head>
  
  <script>
  	if(window.top.location != this.location){
  		window.top.location = this.location;
  	}
  </script>
  
  <body>
    <br><br><br>
    <h3>
    	<a href="Logout.html" target="_top">当前会话已失效,请点击此处重新登录</a>
    </h3>
  </body>
</html>
