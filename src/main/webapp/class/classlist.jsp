<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="javax.sql.rowset.WebRowSet"%>

<%@ page import="com.jufeng.database.DBManage"%>
<jsp:include page="../pagehead.jsp"></jsp:include>
  <script src="include/jquery.js"></script>
  <script src="include/classlist.js"></script>
<%
WebRowSet rs = DBManage.getWRS("SELECT * FROM TB_CLASS ORDER BY ID");
%>
  <body>
	<h3>班级列表</h3>

    <table border="1" align="center" width="100%" class="tablelist">
	    <tr>
	    	<th>编号</th>
	    	<th>学院</th>
	    	<th>专业</th>
	    	<th>班级名</th>
	    	<th width="70">删除</th>
	    </tr>
	    <%while(rs.next()){
	    	String id= rs.getString("id");
	    	String deptName= rs.getString("deptname");
	    	String majorName= rs.getString("majorname");
	    	String className = rs.getString("classname");
	    	%>
	    <tr class="classdata" onMouseOver="this.className='mouseover'" onMouseOut="this.className='mouseout'">
	    	<td><%=id%></td>
	    	<td><%=deptName%></td>
	    	<td><%=majorName%></td>
	    	<td><%=className%></td>
	    	<td align="center"><a href="DealClass?op=del&id=<%=id%>" onClick="return confirm('请确认是否删除该项');">删除</a></td>
	    </tr>
	    <%}
	    rs.close();
	    %>
    </table>
   <br>
   <form action="DealClass" method="post">
		<table width="650" border="1" align="center" class="tableinfo">
		<tr><th colspan="2">数据的添加修改</th></tr>
		<tbody><tr>
			<td width="160" class="label">编号</td>
			<td><input type="text" size="7" maxlength="6" id="id" name="id" readonly="true"/>编码为只读项不能修改</td></tr>
			<tr>
			<td class="label">学院</td>
			<td><input type="text" maxlength="10" id="deptname" name="deptname"></td></tr>
			<tr>
			<td class="label">专业</td>
			<td><input type="text" maxlength="10" id="majorname" name="majorname"></td></tr>
			<tr>
			<td class="label">班级名</td>
			<td><input type="text" size="30" maxlength="20" id="classname" name="classname"></td></tr>
			<tr align="center">
				<td colspan="2">
					<input type="button" value="添加" name="button1">&nbsp;
					<input type="button" value="修改" name="button2">
				</td>
			</tr>
		</tbody></table>
		<input type="hidden" name="op" value=""/>
	</form>
</body>
</html>
