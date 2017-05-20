<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%-- 这是一个显示文档内容的页面 --%>
<%@ page import="javax.sql.rowset.WebRowSet"%>

<%@ page import="com.jufeng.util.filter.StringFilter"%>
<%@ page import="com.jufeng.database.DBManage"%>


<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String docid = (request.getParameter("docid")==null? "" : request.getParameter("docid").trim());
String sql = "";
sql = "SELECT * FROM TB_DOCS WHERE DOCID=" + docid;

WebRowSet rs = DBManage.getWRS(sql);

String title = "",content="",pubdate="";
if(rs.next()){
	title=StringFilter.cover2html(rs.getString("TITLE"));
	content = StringFilter.cover2html(rs.getString("CONTENT"));
	pubdate = StringFilter.cover2html(rs.getString("PUBDATE"));
}
rs.close();
content=content.replaceAll("\n","<p>");
%>
<jsp:include page="webheader.jsp"></jsp:include>

	<div id="content-box">
		<div id="content-box-in">

			<a name="skip-menu"></a>
			<!-- Content left -->
			<div class="content-box-left-in">
				<h3><%=title%></h3>
				<div class="doc-content">
					<%=content%>
				</div>
				<div class="turn-back" onClick="history.back()">&lt;&lt;&lt;返回</div>
			</div>
			<!-- Content left end -->

<hr class="noscreen" />

		
			<!-- Content right end -->
			<div class="cleaner">&nbsp;</div>
		</div>
	</div>

<jsp:include page="webfooter.jsp"></jsp:include>
