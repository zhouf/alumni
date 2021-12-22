<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="javax.sql.rowset.WebRowSet"%>

<%@ page import="com.jufeng.util.filter.StringFilter"%>
<%@ page import="com.jufeng.database.DBManage"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

WebRowSet rs = DBManage.getWRS("SELECT * FROM TB_DOCS WHERE ITEM='动态' ORDER BY DOCID DESC");
String docid[] = new String[3];
String title[] = new String[3];
String pubdate[] = new String[3];
String content[] = new String[3];
int indexOfRs = 0;
while(rs.next()&&indexOfRs<3){
	docid[indexOfRs] = rs.getString("DOCID");
	title[indexOfRs] = rs.getString("TITLE");
	pubdate[indexOfRs] = rs.getString("PUBDATE");
	content[indexOfRs] = rs.getString("CONTENT");
	
	indexOfRs++;
}
rs.close();

//对各部分单独处理
content[0] = content[0].replaceAll("\n","<p>");

title[1] = StringFilter.dealShortTitle(title[1]);
title[2] = StringFilter.dealShortTitle(title[2]);
content[1] = StringFilter.dealShortContent(content[1]);
content[2] = StringFilter.dealShortContent(content[2]);
%>
<jsp:include page="webheader.jsp"></jsp:include>

	<div id="content-box">
		<div id="content-box-in">

			<a name="skip-menu"></a>
			<!-- Content left -->
			<div class="content-box-left">
				<div class="content-box-left-in">
					<h3>近期动态</h3>
					<p class="text-content"></p>
					<p class="text-content"><%=content[0]%>(<%=pubdate[0]%>)</p>
					<h3>活动画面</h3>
					<div class="gallery">
					<marquee scrollamount="2">
					<%for(int i=1;i<=9;i++){%>
					<a href="img/pic<%=i%>.jpg" target="_blank"><img src="img/pic<%=i%>.jpg" width="120" height="90" alt="image<%=i%>" /></a>
					<%}%>
					</marquee>
					</div>
				</div>
			</div>
			<!-- Content left end -->

<hr class="noscreen" />

			<!-- Content right -->
			<div class="content-box-right">
				<h4>动态</h4>
				<div class="content-box-right-in">
					<dl>
						<dt><%=pubdate[1]%></dt>
							<dd class="heading"><a href="showdoc.jsp?docid=<%=docid[1]%>"><%=title[1]%></a></dd>
							<dd><%=content[1]%></dd>

						<dt><%=pubdate[2]%></dt>
							<dd class="heading"><a href="showdoc.jsp?docid=<%=docid[2]%>"><%=title[2]%></a></dd>
							<dd><%=content[2]%></dd>
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
