<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.jufeng.database.DBManage"%>
<%@ page import="com.jufeng.util.PWD"%>


<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String sessionRoleType = (String)session.getAttribute("roleType");

String errStr = "", sqlStr = "";
String oldpwd = (request.getParameter("oldpwd")==null? "" : request.getParameter("oldpwd").trim());
String newpwd1 = (request.getParameter("newpwd1")==null? "" : request.getParameter("newpwd1").trim());
String newpwd2 = (request.getParameter("newpwd2")==null? "" : request.getParameter("newpwd2").trim());
String password = PWD.encode(oldpwd);

//验证原始密码
if("Admin".equalsIgnoreCase(sessionRoleType)){
	sqlStr = "SELECT COUNT(*) FROM TB_USERS WHERE USERID='"+session.getAttribute("userID")+"' AND PASSWORD='"+password+"'";
}else{
	sqlStr = "SELECT COUNT(*) FROM TB_ALUMNI WHERE STUNUM='"+session.getAttribute("userID")+"' AND PASSWORD='"+password+"'";
}
String ok = DBManage.changeID(sqlStr);

if("POST".equalsIgnoreCase(request.getMethod())){
	if("0".equals(ok)){
		errStr = "输入原始密码不正确";
	}else if(!newpwd1.equalsIgnoreCase(newpwd2)){
		//如果两次新密码不相等
		errStr = "输入的两次新密码不相等";
	}else if(oldpwd.equalsIgnoreCase(newpwd1)){
		//如果输入的新密码与原始密码相同
		errStr = "请输入与原始密码不同的新密码";
	}else{
		//如果两次密码相等,且与原始密码不同，则更新密码
		password = PWD.encode(newpwd1);
		if("Admin".equalsIgnoreCase(sessionRoleType)){
			sqlStr = "UPDATE TB_USERS SET PASSWORD='"+password.trim()+"' WHERE USERID='"+session.getAttribute("userID")+"'";
		}else{
			sqlStr = "UPDATE TB_ALUMNI SET PASSWORD='"+password.trim()+"' WHERE STUNUM='"+session.getAttribute("userID")+"'";
		}
		
		//DBManage.getConnection().createStatement().executeUpdate(sqlStr);
		DBManage.doUpdate(sqlStr);
		response.sendRedirect("changeok.jsp");
	}
}

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>请修改密码</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
  </head>
  
  <script src="include/jquery.js"></script>
  <script src="include/stuoa.js"></script>
  
  <body>
    <form method="post">
    <table width="60%" border="1" align="center" class="tableinfo">
    	<tr>
    		<th colspan="2">修改用户密码</th>
    	</tr>
    	<tr>
    		<td width="42%" class="label">请输入当前的用户密码</td>
    		<td><input type="password" name="oldpwd" value="<%=oldpwd%>"></td>
    	</tr>
    	<tr>
    		<td class="label">请输入新的用户密码</td>
    		<td><input type="password" name="newpwd1"></td>
    	</tr>
    	<tr>
    		<td class="label">请再输入一次新密码</td>
    		<td><input type="password" name="newpwd2"></td>
    	</tr>
    	<tr>
    		<td colspan="2" align="center"><input type="submit" value="确定"></td>
    	</tr>
    </table>
    </form>
    <div align="center" style="color:red"><%=errStr%></div>
  </body>
</html>
