<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>footer</title>
    
	<link rel="stylesheet" type="text/css" href="styles.css">

  </head>
  
  <body>
    <div class="footer" oncontextmenu="return(false);">
		<!--
		Copyright®<a href="mailto:zhouf_t@swufe.edu.cn?subject=alumni">ZhouFeng</a>
		 -->
		 经济信息工程学院
		<br/>2011.4
	</div>
  </body>
</html>
