<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%-- 这是一个提供校友登录后查看本班联系方式的页面 --%>
<%@ page import="javax.sql.rowset.WebRowSet"%>

<%@ page import="com.jufeng.util.filter.StringFilter"%>
<%@ page import="com.jufeng.database.DBManage"%>


<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String sessionUserId = (String)session.getAttribute("userID");
String sessionUserName = (String)session.getAttribute("userName");
String sql = "SELECT * FROM TB_ALUMNI WHERE CLASS=(SELECT CLASS FROM TB_ALUMNI WHERE STUNUM='"+sessionUserId+"')";
WebRowSet rs = DBManage.getWRS(sql);
%>
<jsp:include page="webheader.jsp"></jsp:include>

	<div id="content-box">
		<div id="content-box-in">

			<a name="skip-menu"></a>
			<!-- Content left -->
			<div class="content-box-left">
				<div class="content-box-left-in">
					<h3>校友信息</h3>
					<div class="div-classmate">
						<table width="100%" border="0">
							<th>姓名</th><th>工作单位</th><th>联系电话</th>
							<%while(rs.next()){
								String classinfo = rs.getString(2);
								out.println("<tr><td>"+StringFilter.cover2html(rs.getString("STUNAME"))+"</td><td>"+StringFilter.cover2html(rs.getString("WORKUNIT"))+"</td><td>"+rs.getString("PHONE")+"</td></tr>");
							}
							rs.close();
							%>
						</table>

					</div>
				</div>
			</div>
			<!-- Content left end -->

<hr class="noscreen" />

			<!-- Content right -->
			<div class="content-box-right">
				
				<h4><%=sessionUserName%>&nbsp;相关操作</h4>
				<div class="content-box-right-in">
					&nbsp;<br/>
					<p><a href="user/changepwd.jsp">修改密码</a></p>
					<p><a href="Logout.html" target="_top">注销</a></p>
					<p>&nbsp;</p>
				</div>
			<div id="column-right-bottom">&nbsp;</div>
			</div>
			<!-- Content right end -->
			<div class="cleaner">&nbsp;</div>
		</div>
	</div>

<jsp:include page="webfooter.jsp"></jsp:include>
