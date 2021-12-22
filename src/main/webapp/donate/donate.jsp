<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="javax.sql.rowset.WebRowSet"%>

<%@ page import="com.jufeng.database.DBManage"%>
<%-- 这是一个用于提供校友捐赠的一个页面，后台处理用  --%>
<jsp:include page="../pagehead.jsp"></jsp:include>
<script src="include/jquery.js"></script>
<script src="include/donate.js"></script>
  <body>
	<h3>校友捐赠</h3>
   <br>
   <form action="DealDonate" method="post">
		<table width="70%" border="1" align="center" class="tableinfo">
		<tr><th colspan="2">捐赠详细信息</th></tr>
		<tbody>
			<tr>
			<td class="label" width="30%">捐赠人</td>
			<td><input type="text" maxlength="10" id="username" name="username"></td></tr>
			<tr>
			<td class="label">班级名</td>
			<td>
				<SELECT NAME="classname" ID="classname" >
				<%String sqlclass = "SELECT ID,DEPTNAME+' => '+MAJORNAME+' => '+CLASSNAME FROM PUBLIC.TB_CLASS ORDER BY DEPTNAME,MAJORNAME";
				WebRowSet rs = DBManage.getWRS(sqlclass);
				while(rs.next()){
					//int classid = rs.getInt("ID");
					String classinfo = rs.getString(2);
					out.println("<OPTION VALUE=\""+classinfo+"\">"+classinfo+"</OPTION>");
				}
				rs.close();
				%>
				</SELECT>
			</td></tr>
			<tr>
			<td class="label">金额</td>
			<td><input type="text" id="amount" name="amount"></td></tr>
			<tr>
			<td class="label">附言</td>
			<td><TEXTAREA NAME="postscript" cols=60 rows=8></TEXTAREA></td></tr>
			<tr align="center">
				<td colspan="2">
					<input type="reset" value="重新填写" name="reset">&nbsp;
					<input type="submit" value="确定提交" name="submit">
				</td>
			</tr>
		</tbody></table>
	</form>
</body>
</html>
