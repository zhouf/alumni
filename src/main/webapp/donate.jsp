<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%-- 这是一个提供用户捐赠的页面 --%>
<%@ page import="javax.sql.rowset.WebRowSet"%>

<%@ page import="com.jufeng.util.filter.StringFilter"%>
<%@ page import="com.jufeng.database.DBManage"%>


<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String sql = "SELECT * FROM TB_DONATE ORDER BY ID DESC";
WebRowSet rsDonate = DBManage.getWRS(sql);
%>
<jsp:include page="webheader.jsp"></jsp:include>
<script src="include/jquery.js"></script>
<script src="include/donate.js"></script>

	<div id="content-box">
		<div id="content-box-in">

			<a name="skip-menu"></a>
			<!-- Content left -->
			<div class="content-box-left">
				<div class="content-box-left-in">
					<h3>在线捐赠</h3>
					<div class="div-donate">
						<form action="DealDonate" method="post">
							<input type="text" maxlength="10" id="username" name="username">&nbsp;捐赠人</p>
							<input type="text" id="amount" name="amount">&nbsp;捐赠金额</p>
							<select name="classname" id="classname" >
								<%String sqlclass = "SELECT ID,DEPTNAME+' => '+MAJORNAME+' => '+CLASSNAME FROM PUBLIC.TB_CLASS ORDER BY DEPTNAME,MAJORNAME";
								WebRowSet rs = DBManage.getWRS(sqlclass);
								while(rs.next()){
									//int classid = rs.getInt("ID");
									String classinfo = rs.getString(2);
									out.println("<OPTION VALUE=\""+classinfo+"\">"+classinfo+"</OPTION>");
								}
								rs.close();
								%>
							</select>&nbsp;所在班级</p>
							附言:</p>
							<TEXTAREA NAME="postscript" cols=60 rows=8></TEXTAREA></p>
							<input type="submit" value="确定提交" name="submit">							
						</form>
					</div>
				</div>
			</div>
			<!-- Content left end -->

<hr class="noscreen" />

		
			<!-- Content right -->
			<div class="content-box-right">
				
				<h4>捐赠情况</h4>
				<div class="content-box-right-in">
				<marquee direction="up" scrollamount="1">
					<table width="100%">
						<%while(rsDonate.next()){%>
						<tr><td><%=rsDonate.getString("USERNAME")%></td><td><%=rsDonate.getString("DDATE")%></td><td><%=rsDonate.getString("AMOUNT")%></td></tr>
						<%}
						rsDonate.close();%>
					</table>
				</marquee>
				</div>
			<div id="column-right-bottom">&nbsp;</div>
			</div>
			<!-- Content right end -->
			<div class="cleaner">&nbsp;</div>
		</div>
	</div>

<jsp:include page="webfooter.jsp"></jsp:include>
