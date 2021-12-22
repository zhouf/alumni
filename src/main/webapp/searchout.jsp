
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.alumni.entity.Alumni" %>


<%
//这是一个显示查询结果的一个页面
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

List<Alumni> alumniList = (List)request.getAttribute("alumnis");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>查看通知</title>
    
    
    <link rel="stylesheet" type="text/css" href="styles.css">
  </head>
  <script type="text/javascript" src="include/popup.js"></script>
  <script type="text/javascript" src="include/popupclass.js"></script> 
  <body onMouseOver="window.status='';return true;">

	<h3>查询结果</h3>
	<hr/>
		<%
		if(alumniList.isEmpty()){
			out.println("<UL><LI>无结果记录</LI></UL>");
		}else{%>
		<table border="1" align="center" width="100%" class="tablelist">
	    <tr>
	    	<th>姓名</th>
	    	<th>工作单位</th>
	    	<th>联系电话</th>
	    	<th>移动电话</th>
	    </tr>
		<%for(Alumni alumni : alumniList ){%>
    	<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className='mouseout'" onDblClick="ShowIframe('校友信息','alumni/alumnidetail.jsp?id=<%=alumni.getStuNum()%>',800,450)">
	    	<td align="center"><%=alumni.getStuName() %></td>
	    	<td><%=alumni.getWorkUnit()%></td>
	    	<td><%=alumni.getTel()%></td>
	    	<td><%=alumni.getPhone()%></td>
	    </tr>
    	<%}%><%-- end of for --%>
    	</table>
    	<div class="turn-back" onClick="history.back()">&lt;&lt;&lt;返回</div>
    	<%}%><%-- end of if else --%>
    
  </body>
</html>
