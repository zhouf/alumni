<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="javax.sql.rowset.WebRowSet"%>

<%@ page import="com.jufeng.database.DBManage"%>
<jsp:include page="../pagehead.jsp"></jsp:include>
<%
WebRowSet rs = DBManage.getWRS("SELECT * FROM TB_DONATE ORDER BY ID DESC");
%>
  <body>
	<h3>捐赠列表</h3>

    <table border="1" align="center" width="100%" class="tablelist">
	    <tr>
	    	<th>姓名</th>
	    	<th>班级</th>
	    	<th>金额</th>
	    	<th width="100">日期</th>
	    	<th width="70">附言</th>
	    </tr>
	    <%while(rs.next()){
	    	String postScript = rs.getString("POSTSCRIPT").replaceAll("\r\n","\\\\n");
	    	postScript = postScript.trim().length()==0? "(没有附言)" : postScript.trim();
	    	//System.out.println("postScript:" + postScript);
	    	%>
	    <tr class="classdata" onMouseOver="this.className='mouseover'" onMouseOut="this.className='mouseout'">
	    	<td><%=rs.getString("USERNAME")%></td>
	    	<td><%=rs.getString("CLASSNAME")%></td>
	    	<td><%=rs.getString("AMOUNT")%></td>
	    	<td align="center"><%=rs.getString("DDATE")%></td>
	    	<td align="center" onClick="alert('<%=postScript%>');">附言</td>
	    </tr>
	    <%}
	    rs.close();
	    %>
    </table>
</body>
</html>
