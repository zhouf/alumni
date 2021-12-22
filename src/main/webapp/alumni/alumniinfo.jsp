<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.alumni.util.Constants" %>
<%@ page import="javax.sql.rowset.WebRowSet"%>

<%@ page import="com.jufeng.util.filter.StringFilter"%>
<%@ page import="com.jufeng.database.DBManage"%>


<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//op 标明操作类型，是新增还是修改，如果有id传入页面，则判定为修改
String op = "create";
String id = (request.getParameter("id")==null? "" : request.getParameter("id"));
String stuNum="",stuName="",gender="",birthday="",nationality="",tel="",phone="",qq="",msn="",email="",workunit="",address="",area="",describe="";
int stuclass = -1;
stuNum = id;

if(id.length()>0){
	//如果是修改操作，则先要从数据库中获取该记录数据
	String sql = "SELECT * FROM TB_ALUMNI WHERE STUNUM='"+id+"'";
	System.out.println("修改校友记录，SQL:" + sql);
	WebRowSet rs = DBManage.getWRS(sql);
	if(rs.next()){
		stuName = StringFilter.cover2htmlBlank(rs.getString("STUNAME"));
		gender = StringFilter.cover2htmlBlank(rs.getString("GENDER"));
		birthday = rs.getString("BIRTHDAY");
		nationality = StringFilter.cover2htmlBlank(rs.getString("NATIONALITY"));
		stuclass = rs.getInt("CLASS");
		tel = StringFilter.cover2htmlBlank(rs.getString("TEL"));
		phone = StringFilter.cover2htmlBlank(rs.getString("PHONE"));
		qq = StringFilter.cover2htmlBlank(rs.getString("QQ"));
		msn = StringFilter.cover2htmlBlank(rs.getString("MSN"));
		email = StringFilter.cover2htmlBlank(rs.getString("EMAIL"));
		area = StringFilter.cover2htmlBlank(rs.getString("AREA"));
		workunit = StringFilter.cover2htmlBlank(rs.getString("WORKUNIT"));
		address = StringFilter.cover2htmlBlank(rs.getString("ADDRESS"));
		describe = StringFilter.cover2htmlBlank(rs.getString("DESCRIBE"));
	}
	rs.close();
	op="modify";
}else{
	//如果是新增校友记录
	birthday="2000-01-01";
}

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>校友信息</title>

    <link rel="stylesheet" type="text/css" href="styles.css">

  </head>
  
  <script language="JavaScript" src="include/popcalendar.js"></script>
  
 <body>
  
    <FORM ID="ALUMNI" NAME="ALUMNI" ACTION="DealAlumni" METHOD="POST" >
		<TABLE align="center" border="1" width="100%" class="tableinfo">
			<TR>
				<TH COLSPAN="2">校友详细信息</TH>
			</TR>
			<TR>
				<TD width="20%" class="label">学号</TD>
				<TD><INPUT TYPE="text" NAME="stunum"  ID="stunum" VALUE="<%=stuNum%>" "<%=("modify".equalsIgnoreCase(op)? "READONLY" : "")%>"></TD>
			</TR>
			<TR>
				<TD class="label">姓名</TD>
				<TD><INPUT TYPE="text" NAME="stuname"  ID="stuname" VALUE="<%=stuName%>"  ></TD>
			</TR>
			<TR>
				<TD class="label">性别</TD>
				<TD>
					<SELECT NAME="gender" ID="gender" >
						<OPTION VALUE="男" <%=(gender.equalsIgnoreCase("男")? "selected" : "")%>>男</OPTION>
						<OPTION VALUE="女" <%=(gender.equalsIgnoreCase("女")? "selected" : "")%>>女</OPTION>
					</SELECT> 
				</TD>
			</TR>
			<TR>
				<TD class="label">出生日期</TD>
				<TD>
					<INPUT TYPE="text" ID="birthday" NAME="birthday" STYLE="CURSOR: hand" onclick="popUpCalendar(this,document.forms[0].birthday,'yyyy-mm-dd')"  VALUE="<%=birthday%>" READONLY="TRUE">
				</TD>
			</TR>
			<TR>
				<TD class="label">民族</TD>
				<TD><SELECT NAME="nationality" ID="nationality" > 
				<%
				String nations = Constants.NATIONS;
				for(String nation : nations.split(";")){
					if(nation.equalsIgnoreCase(nationality)){
						out.println("<OPTION VALUE=\""+nation+"\" selected>"+nation+"</OPTION>");
					}else{
						out.println("<OPTION VALUE=\""+nation+"\">"+nation+"</OPTION>");
					}
				}
				%>
				</SELECT>
				</TD>
			</TR>
			<TR>
				<TD class="label">班级</TD>
				<TD>
					<SELECT NAME="stuclass" ID="stuclass" >
				<%String sqlclass = "SELECT ID,DEPTNAME+' => '+MAJORNAME+' => '+CLASSNAME FROM PUBLIC.TB_CLASS ORDER BY DEPTNAME,MAJORNAME";
				WebRowSet rs = DBManage.getWRS(sqlclass);
				while(rs.next()){
					int classid = rs.getInt("ID");
					String classinfo = rs.getString(2);
					if(classid==stuclass){
						out.println("<OPTION VALUE=\""+classid+"\" selected>"+classinfo+"</OPTION>");
					}else{
						out.println("<OPTION VALUE=\""+classid+"\">"+classinfo+"</OPTION>");
					}
				}
				rs.close();
				%>
					</SELECT>
				</TD>
			</TR>
			<TR>
				<TD class="label">所在地区</TD>
				<TD><SELECT NAME="area" ID="area" > 
				<%
				String areas = Constants.AREAS;
				for(String areaItem : areas.split(";")){
					if(areaItem.equalsIgnoreCase(area)){
						out.println("<OPTION VALUE=\""+areaItem+"\" selected>"+areaItem+"</OPTION>");
					}else{
						out.println("<OPTION VALUE=\""+areaItem+"\">"+areaItem+"</OPTION>");
					}
				}
				%>
				</SELECT>
				</TD>
			</TR>
			<TR>
				<TD class="label">电话</TD>
				<TD><INPUT TYPE="text" NAME="tel"  ID="tel" VALUE="<%=tel%>"  ></TD>
			</TR>
			<TR>
				<TD class="label">手机</TD>
				<TD><INPUT TYPE="text" NAME="phone"  ID="phone" VALUE="<%=phone%>"  ></TD>
			</TR>
			<TR>
				<TD class="label">QQ</TD>
				<TD><INPUT TYPE="text" NAME="qq"  ID="qq" VALUE="<%=qq%>"  ></TD>
			</TR>
			<TR>
				<TD class="label">MSN</TD>
				<TD><INPUT TYPE="text" NAME="msn"  ID="msn" VALUE="<%=msn%>" size=50 ></TD>
			</TR>
			<TR>
				<TD class="label">EMAIL</TD>
				<TD><INPUT TYPE="text" NAME="email"  ID="email" VALUE="<%=email%>" size=50 ></TD>
			</TR>
			<TR>
				<TD class="label">工作单位</TD>
				<TD><INPUT TYPE="text" NAME="workunit"  ID="workunit" VALUE="<%=workunit%>" size=50 ></TD>
			</TR>
			<TR>
				<TD class="label">联系地址</TD>
				<TD><INPUT TYPE="text" NAME="address"  ID="address" VALUE="<%=address%>" size=50 ></TD>
			</TR>
			<TR>
				<TD class="label">说明</TD>
				<TD><TEXTAREA NAME="describe" cols=60 rows=8><%=describe%></TEXTAREA></TD>
			</TR>

			<TR>
				<TD COLSPAN=2>
					<input type="submit" value="保存数据" />&nbsp;
					<input type="button" value="返回列表" onClick="history.back();" />
				</TD>
			</TR>
			
		</TABLE>
		
		<br>

		<%-- 用隐藏域把操作标记传递到下一个处理页面 --%>
		<input type="hidden" name="op" value="<%=op%>"/>
		</FORM>
	
		
	</body>
</html>
