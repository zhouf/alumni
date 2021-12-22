<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%-- 这是一个提供用户前台登录的页面 --%>


<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<jsp:include page="webheader.jsp"></jsp:include>


	<div id="content-box">
		<div id="content-box-in">

			<a name="skip-menu"></a>
			<!-- Content left -->
			<div class="content-box-left">
				<div class="content-box-left-in">
					<h3>用户登录</h3>
					<div class="div-donate">
						<form action="Login.html" method="post">
							用户：<input type="text" maxlength="10" id="username" name="username"></p>
							口令：<input type="password" id="password" name="password"></p>
							<input type="submit" value="登录" name="submit">							
						</form>
					</div>
				</div>
			</div>
			<!-- Content left end -->

<hr class="noscreen" />

		
			<!-- Content right -->
			<!--
			<div class="content-box-right">
				
				<h4>Somthing</h4>
				<div class="content-box-right-in">
				......
				</div>
			<div id="column-right-bottom">&nbsp;</div>
			-->
			

			<!-- Content right end -->
			<div class="cleaner">&nbsp;</div>
		</div>
	</div>

<jsp:include page="webfooter.jsp"></jsp:include>
