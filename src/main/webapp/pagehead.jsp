<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String sessionUserId = (String)session.getAttribute("userID");
String sessionUserName = (String)session.getAttribute("userName");
String sessionRoleType = (String)session.getAttribute("roleType");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>校友管理</title>
    
	<link rel="stylesheet" type="text/css" href="styles.css">

  </head>
