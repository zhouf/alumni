<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>校友录</title>
	<meta http-equiv="description" content="created by zhoufeng">
	<meta name="author" content="zhoufeng">
	
	<link rel="stylesheet" href="css/style.css" type="text/css" media="screen, projection, tv" />
	<link rel="stylesheet" href="css/style-print.css" type="text/css" media="print" />

  </head>
  
 <body>
<div id="wrapper">

		<!-- Header -->
		<div id="header">

			<h1><a href="#">西财校友录</a></h1>
			<h2>Welcome back ...</h2>

			<div id="header-arrow"></div>
		</div>
		<!-- Header end -->

		<!-- Menu -->
		<a href="#skip-menu" class="hidden">Skip menu</a>
		<ul id="menu" class="cleaning-box">
			<li class="first"><a href="#">首页</a></li>
			<li><a href="service.jsp">服务</a></li>
			<li><a href="news.jsp">动态</a></li>
			<li><a href="donate.jsp">捐赠</a></li>
			<li><a href="weblogin.jsp">登录</a></li>
			<li><a href="register.jsp">注册</a></li>
		</ul>
		<!-- Menu end -->

<hr class="noscreen" />

