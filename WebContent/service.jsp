<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%-- 这是一个首页服务栏目页面 --%>
<%@ page import="javax.sql.rowset.WebRowSet"%>

<%@ page import="com.jufeng.util.filter.StringFilter"%>
<%@ page import="com.jufeng.database.DBManage"%>

<jsp:useBean id="pager" scope="page" class="com.jufeng.util.page.Pager">
</jsp:useBean>
<jsp:setProperty name="pager" property="*"/>
<jsp:setProperty name="pager" property="pageItem" value="10"/>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String sql = "SELECT * FROM TB_DOCS WHERE ITEM='服务' ORDER BY DOCID DESC";

pager.setWrs(DBManage.getWRS(sql));
WebRowSet rs = pager.getWrs();

WebRowSet rs2 = DBManage.getWRS(sql);
String docid[] = new String[2];
String title[] = new String[2];
String pubdate[] = new String[2];
String content[] = new String[2];

int rsIndex = 0;
while(rs2.next() && rsIndex<2){
	docid[rsIndex] = rs2.getString("DOCID");
	title[rsIndex] = StringFilter.dealShortTitle(rs2.getString("TITLE"));
	pubdate[rsIndex] = rs2.getString("PUBDATE");
	content[rsIndex] = StringFilter.dealShortContent(rs2.getString("CONTENT"));
	rsIndex++;
}
rs2.close();
%>
<jsp:include page="webheader.jsp"></jsp:include>

<script language="javascript">
  function goPage(page){
  	document.formsearch.currentPage.value = page;
  	document.formsearch.submit();
  }
</script>
  
	<div id="content-box">
		<div id="content-box-in">

			<a name="skip-menu"></a>
			<!-- Content left -->
			<div class="content-box-left">
				<div class="content-box-left-in">
					<h3>服务信息</h3>
					<dl>
						<%while(rs.next() && rs.getRow()<=pager.getPageItem()*pager.getCurrentPage()){%>
						<dd><a href="showdoc.jsp?docid=<%=rs.getInt("DOCID")%>"><%=rs.getString("TITLE")%></a></dd>
						<%}
						rs.close();%>
						<dd>
							<form name="formsearch" method="post">
								<%=pager.firstPageText()%>
								<%=pager.forwardPageText()%>
								<%=pager.nextPageText()%>
								<%=pager.lastPageText()%>
								<%=pager.getState()%>
							</form>
						</dd>
					</dl>
					
				</div>
			</div>
			<!-- Content left end -->

<hr class="noscreen" />

			<!-- Content right -->
			<div class="content-box-right">
				<h4>服务</h4>
				<div class="content-box-right-in">
					<dl>
						<dt><%=pubdate[0]%></dt>
							<dd class="heading"><a href="showdoc.jsp?docid=<%=docid[0]%>"><%=title[0]%></a></dd>
							<dd><%=content[0]%></dd>

						<dt><%=pubdate[1]%></dt>
							<dd class="heading"><a href="showdoc.jsp?docid=<%=docid[1]%>"><%=title[1]%></a></dd>
							<dd><%=content[1]%></dd>
					</dl>
				</div>
				<h4>联系方式</h4>
				<div class="content-box-right-in">
					<address>
					经济信息工程学院<br />
					温江柳台大道555号<br />
					611130<br />
					<br />
					E-mail: xxxy@swufe.edu.cn<br />
					Fax: 0 123 456 789<br />
					Tel: 0 123 456 789
					</address>
				</div>
			<div id="column-right-bottom">&nbsp;</div>
			</div>
			<!-- Content right end -->
			<div class="cleaner">&nbsp;</div>
		</div>
	</div>

<jsp:include page="webfooter.jsp"></jsp:include>
