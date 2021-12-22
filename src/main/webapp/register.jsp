<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.alumni.util.Constants" %>
<%@ page import="javax.sql.rowset.WebRowSet"%>
<%@ page import="com.jufeng.util.filter.StringFilter"%>
<%@ page import="com.jufeng.database.DBManage"%>
<%-- 这是一个提供校友前台注册的页面 --%>


<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String regok = request.getParameter("ret");
if("ok".equalsIgnoreCase(regok)){
	out.println("<script>alert('注册成功');</script>");
}
%>
<jsp:include page="webheader.jsp"></jsp:include>
<script language="JavaScript" src="include/popcalendar.js"></script>

	<div id="content-box">
		<div id="content-box-in">

			<a name="skip-menu"></a>
			<!-- Content left -->
			<div class="content-box-left">
				<div class="content-box-left-in">
					<h3>校友注册</h3>
					<div class="div-donate">
						<form ID="ALUMNI" NAME="ALUMNI" ACTION="DealAlumni" METHOD="POST" >
							<p>学　　号：<INPUT TYPE="text" NAME="stunum"  ID="stunum"/></p>
							<p>姓　　名：<INPUT TYPE="text" NAME="stuname"  ID="stuname"/></p>
							<p>性　　别：<SELECT NAME="gender" ID="gender" >
								<OPTION VALUE="男">男</OPTION>
								<OPTION VALUE="女">女</OPTION>
							</SELECT></p>
							
							<p>出生日期：<INPUT TYPE="text" ID="birthday" NAME="birthday" STYLE="CURSOR: hand" onclick="popUpCalendar(this,document.forms[0].birthday,'yyyy-mm-dd')"  VALUE="2000-01-01" READONLY></p>
							
							<p>民　　族：<SELECT NAME="nationality" ID="nationality" > 
							<%String nations = Constants.NATIONS;
							for(String nation : nations.split(";")){
								out.println("<OPTION VALUE=\""+nation+"\">"+nation+"</OPTION>");
							}%>
							</SELECT></p>
							
							<p>班　　级：<SELECT NAME="stuclass" ID="stuclass" >
							<%String sqlclass = "SELECT ID,DEPTNAME+' => '+MAJORNAME+' => '+CLASSNAME FROM PUBLIC.TB_CLASS ORDER BY DEPTNAME,MAJORNAME";
							WebRowSet rs = DBManage.getWRS(sqlclass);
							while(rs.next()){
								int classid = rs.getInt("ID");
								String classinfo = rs.getString(2);
								out.println("<OPTION VALUE=\""+classid+"\">"+classinfo+"</OPTION>");
							}
							rs.close();%>
							</SELECT></p>
							
							<p>所在地区：<SELECT NAME="area" ID="area" > 
							<%String areas = Constants.AREAS;
							for(String areaItem : areas.split(";")){
								out.println("<OPTION VALUE=\""+areaItem+"\">"+areaItem+"</OPTION>");
							}%>
							</SELECT></p>
							
							<p>电　　话：<INPUT TYPE="text" NAME="tel" ID="tel"/></p>
							<p>手　　机：<INPUT TYPE="text" NAME="phone" ID="phone"/></p>
							<p>QQ：&nbsp;　　<INPUT TYPE="text" NAME="qq" ID="qq"/></p>
							<p>MSN：　&nbsp;&nbsp;<INPUT TYPE="text" NAME="msn" ID="msn"/></p>
							<p>Email：&nbsp;　<INPUT TYPE="text" NAME="email" ID="email"/></p>
							<p>工作单位：<INPUT TYPE="text" NAME="workunit" ID="workunit"/></p>
							<p>联系地址：<INPUT TYPE="text" NAME="address" ID="address"/></p>
							<p>个人说明：<TEXTAREA NAME="describe" cols=60 rows=8></TEXTAREA></p>
							
							<input type="hidden" name="op" value="register"/>
							
							<input type="submit" value="注册" name="submit">					
						</form>
					</div>
				</div>
			</div>
			<!-- Content left end -->

<hr class="noscreen" />

			

			<div class="cleaner">&nbsp;</div>
		</div>
	</div>

<jsp:include page="webfooter.jsp"></jsp:include>
