<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
  <head>
  	<base href="<%=basePath%>">
	<link rel="stylesheet" type="text/css" href="left.css">
  </head>
  <body onMouseOver="window.status='';return true;">
  

	<ul>
	    <li><a href="alumni/alumnilist.jsp" target="main">校友管理</a></li>
	    <li><a href="alumni/checklist.jsp" target="main">审核申请</a></li>
	    <li><a href="area/arealist.jsp" target="main">显示地区</a></li>
	    <li><a href="class/classlist.jsp" target="main">班级管理</a></li>
	    <li><a href="user/userlist.jsp" target="main">用户管理</a></li>
	    <li><a href="doc/doclist.jsp" target="main">文档管理</a></li>
	    <li><a href="donate/donatelist.jsp" target="main">查看捐赠</a></li>
	    <li><a href="user/changepwd.jsp" target="main">修改密码</a></li>
	</ul>
	<div class="search">
		<form action="Search" target="main" method="get">
			<input class="txt" type="text" name="searchkey"/><br/>
			<input class="btn" type="submit" value="查找"/>
		</form>
	</div>

  </body>
</html>
