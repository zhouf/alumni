<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="javax.sql.rowset.WebRowSet"%>

<%@ page import="com.jufeng.database.DBManage"%>

<jsp:include page="../pagehead.jsp"></jsp:include>
<%
WebRowSet rs = DBManage.getWRS("SELECT * FROM TB_USERS ORDER BY USERID DESC");
%>
  <script src="include/jquery.js"></script>
  <script src="include/userlist.js"></script>

  <body>
	<h3>用户列表</h3>

    <table border="1" align="center" width="100%" class="tablelist">
	    <tr>
	    	<th>账号</th>
	    	<th>姓名</th>
	    	<th width="230">操作</th>

	    </tr>
	    <%while(rs.next()){
	    	String userId= rs.getString("userid");
	    	String userName= rs.getString("username");
	    	int locked = rs.getInt("locked");
	    	%>
	    <tr class="userdata" onMouseOver="this.className='mouseover'" onMouseOut="this.className='mouseout'">
	    	<td><%=userId%></td>
	    	<td><%=userName%></td>
	    	<td align="center">
	    		<a href="DealUser?op=resetpwd&userid=<%=userId%>" onClick="return confirm('请确认是否对该用户设置初始密码');">重置密码</a>
	    		&nbsp;
	    		<%if(0==locked){%>
	    			<a href="DealUser?op=lock&userid=<%=userId%>" title="点击将此项设置为禁用状态">设为禁用</a>
	    		<%}else{%>
	    			<a href="DealUser?op=unlock&userid=<%=userId%>" title="点击将此项设置为启用状态">设为启用</a>
	    		<%}%>
	    		&nbsp;
	    		<a href="DealUser?op=del&userid=<%=userId%>" onClick="return confirm('请确认是否删除该项');">删除</a>
	    	 </td>
	    </tr>
	    <%}
	    rs.close();
	    %>
    </table>
   <br>
   <form action="DealUser" method="post">
		<table width="650" border="1" align="center" class="tableinfo">
		<tr><th colspan="2">数据的添加修改</th></tr>
		<tbody><tr>
			<td width="160" class="label">账号</td>
			<td><input type="text" size="7" maxlength="6" id="userid" name="userid" />账号为只读项不能修改，初始密码:123</td></tr>
			<tr>
			<td class="label">姓名</td>
			<td><input type="text" maxlength="10" id="username" name="username"></td></tr>
			
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
