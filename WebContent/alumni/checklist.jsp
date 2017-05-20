
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="javax.sql.rowset.WebRowSet"%>

<%@ page import="com.jufeng.util.filter.StringFilter"%>
<%@ page import="com.jufeng.database.DBManage"%>


<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//这是一个审核校友申请的列表页面

String session_userid = (String)session.getAttribute("userID");

String sql = "SELECT * FROM TB_ALUMNI WHERE PERMIT=0";


WebRowSet rs = DBManage.getWRS(sql);
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
    
    <table border="1" align="center" width="100%" class="tablelist">
	    <tr>
	    	<th width="150">学号</th>
	    	<th>姓名</th>
	    	<th>工作单位</th>
	    	<th>联系电话</th>
		    <th width="100">审核</th>
	    </tr>
	    <%if(rs.next()){
	    	do{
	    	String stuNum = rs.getString("STUNUM");
	    	%>
	    <tr onMouseOver="this.className='mouseover'" onMouseOut="this.className='mouseout'" onDblClick="ShowIframe('校友信息','alumni/alumnidetail.jsp?id=<%=stuNum%>',800,450)">
	    	<td align="center"><%=stuNum%></td>
	    	<td><%=StringFilter.cover2htmlBlank(rs.getString("STUNAME"))%></td>
	    	<td><%=StringFilter.cover2htmlBlank(rs.getString("WORKUNIT"))%></td>
	    	<td><%=rs.getString("PHONE")%></td>
	    	
			<td align="center"><a href="DealAlumni?op=permit&id=<%=stuNum%>">通过</a>&nbsp;<a href="DealAlumni?op=delalumni2&id=<%=stuNum%>">删除</a></td>
			
	    </tr>
	    <%}while(rs.next());
	    }else{
	    	out.println("<tr><td colspan='5'>暂无校友申请记录</td></tr>");
	    }
	    rs.close();
	    %>
    </table>
  </body>
</html>
