
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
//这是一个显示校友列表的页面

String session_userid = (String)session.getAttribute("userID");

String sql = "";
sql = "SELECT * FROM TB_ALUMNI WHERE PERMIT=1 ORDER BY STUNUM";

pager.setWrs(DBManage.getWRS(sql));

WebRowSet rs = pager.getWrs();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>校友列表</title>
    
    
    <link rel="stylesheet" type="text/css" href="styles.css">
  </head>
  <script type="text/javascript" src="include/popup.js"></script>
  <script type="text/javascript" src="include/popupclass.js"></script> 
  <script language="javascript">
  function goPage(page){
  	document.formsearch.currentPage.value = page;
  	document.formsearch.submit();
  }
  </script>
  
  <body>
    <h3>校友列表</h3>
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
    		<a class="newitem" href="alumni/alumniinfo.jsp">在此添加新的校友</a>
    	</td></tr>
    </TABLE>
    <table border="1" align="center" width="100%" class="tablelist">
	    <tr>
	    	<th width="150">学号</th>
	    	<th>姓名</th>
	    	<th>工作单位</th>
	    	<th>联系电话</th>
	    	<th width="50">修改</th>
	    	<th width="50">重置</th>
		    <th width="50">删除</th>
	    </tr>
	    <%while(rs.next() && rs.getRow()<=pager.getPageItem()*pager.getCurrentPage()){
	    	String stuNum = rs.getString("STUNUM");
	    	String stuName = StringFilter.cover2htmlBlank(rs.getString("STUNAME"));
	    	%>
	    <tr onMouseOver="this.className='mouseover'" onMouseOut="this.className='mouseout'" onDblClick="ShowIframe('校友信息','alumni/alumnidetail.jsp?id=<%=stuNum%>',800,450)">
	    	<td align="center"><%=stuNum%></td>
	    	<td><%=stuName%></td>
	    	<td><%=StringFilter.cover2htmlBlank(rs.getString("WORKUNIT"))%></td>
	    	<td><%=rs.getString("PHONE")%></td>
	    	
			<td align="center"><a href="alumni/alumniinfo.jsp?id=<%=stuNum%>">修改</a></td>
			<td align="center"><a href="DealAlumni?op=resetpwd&id=<%=stuNum%>" onClick="return confirm('请确认是否要对 [<%=stuName%>] 重置密码')">重置</a></td>
			<td align="center"><a href="DealAlumni?op=delalumni&id=<%=stuNum%>" onClick="return confirm('请确认是否要删除该记录')">删除</a></td>
			
	    </tr>
	    <%}
	    rs.close();
	    %>
    </table>
    </FORM>
  </body>
</html>
