<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ page import="javax.sql.rowset.WebRowSet"%>

<%@ page import="com.jufeng.util.filter.StringFilter"%>
<%@ page import="com.jufeng.database.DBManage"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String id = (request.getParameter("id")==null? "" : request.getParameter("id").trim());
WebRowSet rs = DBManage.getWRS("SELECT * FROM TB_ALUMNI WHERE STUNUM='"+id+"'");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>校友信息</title>

    <link rel="stylesheet" type="text/css" href="styles.css">

  </head>

 <body>
    <%if(rs.next()){%>
		<TABLE align="center" border="1" width="100%" class="tableinfo">
			<TR>
				<TD width="20%" class="label">姓名</TD>
				<TD><%=rs.getString("STUNAME")%></TD>
				<TD width="20%" class="label">学号</TD>
				<TD><%=rs.getString("STUNUM")%></TD>
			</TR>
			<TR>
				<TD class="label">性别</TD>
				<TD><%=rs.getString("GENDER")%></TD>
				<TD class="label">出生日期</TD>
				<TD><%=rs.getString("BIRTHDAY")%></TD>
			</TR>
			<TR>
				<TD class="label">民族</TD>
				<TD><%=rs.getString("NATIONALITY")%></TD>
				<TD class="label">所在地区</TD>
				<TD><%=rs.getString("AREA")%></TD>
			</TR>
			<TR>
				<TD class="label">班级</TD>
				<TD colspan="3"><%=DBManage.changeID("SELECT DEPTNAME+' => '+MAJORNAME+' => '+CLASSNAME FROM TB_CLASS WHERE ID=" + rs.getInt("CLASS"))%></TD>
			</TR>
			<TR>
				<TD class="label">电话</TD>
				<TD><%=rs.getString("TEL")%></TD>
				<TD class="label">手机</TD>
				<TD><%=rs.getString("PHONE")%></TD>
			</TR>
			<TR>
				<TD class="label">QQ</TD>
				<TD colspan="3"><%=rs.getString("QQ")%></TD>
			</TR>
			<TR>
				<TD class="label">MSN</TD>
				<TD colspan="3"><%=rs.getString("MSN")%></TD>
			</TR>
			<TR>
				<TD class="label">EMAIL</TD>
				<TD colspan="3"><%=rs.getString("EMAIL")%></TD>
			</TR>
			<TR>
				<TD class="label">工作单位</TD>
				<TD colspan="3"><%=rs.getString("WORKUNIT")%></TD>
			</TR>
			<TR>
				<TD class="label">联系地址</TD>
				<TD colspan="3"><%=rs.getString("ADDRESS")%></TD>
			</TR>
			<TR>
				<TD class="label">说明</TD>
				<TD colspan="3"><%=(rs.getString("DESCRIBE")).replaceAll("\n","<br/>")%></TD>
			</TR>
			
		</TABLE>
	
		
		<%}else{
			out.println("找不到编号为"+id+"的记录");
		}%>
	
		
	</body>
</html>
