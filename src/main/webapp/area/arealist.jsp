<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="javax.sql.rowset.WebRowSet"%>
<%@ page import="com.jufeng.util.filter.StringFilter"%>
<%@ page import="com.jufeng.database.DBManage"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//按地区显示校友数据,不显示待审核的数据
String sql = "SELECT AREA,COUNT(*) FROM PUBLIC.TB_ALUMNI WHERE PERMIT=1 GROUP BY AREA ORDER BY AREA DESC";
WebRowSet rs = DBManage.getWRS(sql);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>按地区显示</title>
	<link rel="stylesheet" type="text/css" href="styles.css">

  </head>
  
  <body>
    <h3>按地区显示</h3>
    <div class="areadiv">
    <%while(rs.next()){
    	String area = StringFilter.cover2html(rs.getString("AREA"));
    	%>
    <div><a href="ShowAreaAlumni?area=<%=area%>"><%=area +"(" + rs.getInt(2) + ")"%></a></div>
    <%}
    rs.close();%>
    </div>
  </body>
</html>
