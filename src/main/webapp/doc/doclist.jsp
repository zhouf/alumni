
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="javax.sql.rowset.WebRowSet"%>

<%@ page import="com.jufeng.util.filter.StringFilter"%>
<%@ page import="com.jufeng.database.DBManage"%>

<jsp:useBean id="pager" scope="page" class="com.jufeng.util.page.Pager">
</jsp:useBean>
<jsp:setProperty name="pager" property="*"/>
<jsp:setProperty name="pager" property="pageItem" value="13"/>


<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//这是一个显示文档列表的页面

String session_userid = (String)session.getAttribute("userID");

String sql = "";
sql = "SELECT * FROM TB_DOCS ORDER BY DOCID DESC";

pager.setWrs(DBManage.getWRS(sql));

WebRowSet rs = pager.getWrs();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>文档列表</title>
    
    
    <link rel="stylesheet" type="text/css" href="styles.css">
  </head>
  <script language="javascript">
  function goPage(page){
  	document.formsearch.currentPage.value = page;
  	document.formsearch.submit();
  }
  </script>
  
  <body>
    <h3>文档列表</h3>
    <FORM name="formsearch" method="post">
    <TABLE width="100%" align="center" border="0">
    	<tr>
    	<td>
    		<%=pager.firstPage()%>
    		<%=pager.forwardPage()%>
    		<%=pager.nextPage()%>
    		<%=pager.lastPage()%>
    		<%=pager.getState()%>
    	</td>
    	<td align="right">
    		<a class="newitem" href="doc/docinfo.jsp">在此添加新的文档</a>
    	</td></tr>
    </TABLE>
    <table border="1" align="center" width="100%" class="tablelist">
	    <tr>
	    	<th>标题</th>
	    	<th width="100">栏目</th>
	    	<th width="150">日期</th>
	    	<th width="100">作者</th>
	    	<th width="50">修改</th>
		    <th width="50">删除</th>
	    </tr>
	    <%while(rs.next() && rs.getRow()<=pager.getPageItem()*pager.getCurrentPage()){
	    	String docid = rs.getString("DOCID");
	    	%>
	    <tr onMouseOver="this.className='mouseover'" onMouseOut="this.className='mouseout'">
	    	<td><a href="showdoc.jsp?docid=<%=docid%>" target="_blank"><%=StringFilter.cover2htmlBlank(rs.getString("TITLE"))%></a></td>
	    	<td align="center"><%=StringFilter.cover2htmlBlank(rs.getString("ITEM"))%></td>
	    	<td align="center"><%=rs.getString("PUBDATE")%></td>
	    	<td align="center"><%=StringFilter.cover2htmlBlank(rs.getString("AUTHOR"))%></td>
	    	
			<td align="center"><a href="doc/docinfo.jsp?docid=<%=docid%>">修改</a></td>
			<td align="center"><a href="DealDoc?op=deldoc&docid=<%=docid%>" onClick="return confirm('请确认是否要删除该记录')">删除</a></td>
			
	    </tr>
	    <%}
	    rs.close();
	    %>
    </table>
    </FORM>
  </body>
</html>
