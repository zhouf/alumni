<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<jsp:include page="pagehead.jsp"></jsp:include>
  <body class="HeadBody">
  
    <div class="title">校友管理系统</div>
    
  	<div>
  		<ul>
  			<li><a href="Logout.html" target="_top">退出</a></li>
  			<li>当前用户:　<%=(String)session.getAttribute("userName")%></li>
  		</ul>
  	</div>
  </body>
<jsp:include page="pagetail.jsp"></jsp:include>
