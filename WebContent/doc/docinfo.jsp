<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="javax.sql.rowset.WebRowSet"%>
<%@ page import="com.jufeng.util.filter.StringFilter"%>

<%@ page import="com.jufeng.database.DBManage"%>
<%-- 这是一个用于显示发文信息的页面 --%>

<%
String docid = request.getParameter("docid");
String title="",author="",item="",content="";
String op = "create";
if(docid!=null){
//如果有docid,则说明是修改操作,先从数据库里获取数据
	WebRowSet rs = DBManage.getWRS("SELECT * FROM TB_DOCS WHERE DOCID=" + docid);
	if(rs.next()){
		title = StringFilter.cover2html(rs.getString("TITLE"));
		author = StringFilter.cover2html(rs.getString("AUTHOR"));
		item = StringFilter.cover2html(rs.getString("ITEM"));
		content = StringFilter.cover2html(rs.getString("CONTENT"));
	}
	rs.close();
	op = "modify";
}else{
	docid="";
}

%>
<jsp:include page="../pagehead.jsp"></jsp:include>

  <body>
  <!--
	<h3>文档信息</h3>
   <br>
   -->
   
   <form action="DealDoc" method="post">
		<table width="100%" border="1" align="center" class="tableinfo">
		<tr><th colspan="2">文档详细信息</th></tr>
		<tbody>
			<tr>
			<td class="label" width="200">标题</td>
			<td><input type="text" maxlength="30" size="50" id="title" name="title" value="<%=title%>"></td></tr>
			<tr>
			<td class="label">作者</td>
			<td><input type="text" maxlength="10" id="author" name="author" value="<%=author%>"></td></tr>
			<tr>
			<td class="label">栏目</td>
			<td>
				<select id="item" name="item">
					<option value="服务" <%=("服务".equalsIgnoreCase(item)? "SELECTED" : "")%>>服务</option>
					<option value="动态" <%=("动态".equalsIgnoreCase(item)? "SELECTED" : "")%>>动态</option>
				</select>
			</td></tr>
			<tr>
			<td class="label">文档内容</td>
			<td><TEXTAREA NAME="content" cols=100 rows=20><%=content%></TEXTAREA></td></tr>
			<tr align="center">
				<td colspan="2">
					<input type="reset" value="重新填写" name="reset">&nbsp;
					<input type="submit" value="确定提交" name="submit">
				</td>
			</tr>
		</tbody></table>
		<input type="hidden" name="op" value="<%=op%>"/>
		<input type="hidden" name="docid" value="<%=docid%>"/>
	</form>
</body>
</html>
