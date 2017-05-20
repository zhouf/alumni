package com.alumni.web.login;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.rowset.WebRowSet;

import org.apache.log4j.Logger;

import com.alumni.util.Constants;
import com.jufeng.database.DBManage;
import com.jufeng.util.PWD;

/**
 * 这是一个用于登录的用户及口令检查
 * 
 * @author zhoufeng
 * 
 */
public class Login extends HttpServlet {
	static Logger log = Logger.getLogger(Login.class.getName());

	/**
	 * Constructor of the object.
	 */
	public Login() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>无效的参数...</BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
	}

	/**
	 * The doPost method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");

		PrintWriter out = response.getWriter();
		Connection conn = null;
		
		try{
	
			boolean checkOK = false;
			String sql = "";
			String userID = request.getParameter("username");
			String password = request.getParameter("password");
			boolean allowDefaultPwd = ("true".equalsIgnoreCase(this.getInitParameter("allowDefaultPwd")));

			conn = DBManage.getConnection();
			log.info("获取连接:" + conn.toString());
			
		
			// 处理密码
			password = PWD.encode(password);
	
			log.info("get userID:" + userID);
			log.info("get Password:" + password);
			String userName = "", role = "";
			int locked = 0;
	
			log.info("普通用户登录");
			//sql = "SELECT USERID,USERNAME,PASSWORD,ROLE,LOCKED FROM TB_USERS UNION SELECT STUNUM AS USERID,STUNAME AS USERNAME,PASSWORD,'Alumni',0 FROM TB_ALUMNI WHERE PERMIT=1";
			//从用户和校友表中获取数据进行身份认证
			sql = "SELECT * FROM (SELECT USERID,USERNAME,PASSWORD,ROLE,LOCKED FROM TB_USERS UNION SELECT STUNUM AS USERID,STUNAME AS USERNAME,PASSWORD,'Alumni',0 FROM TB_ALUMNI WHERE PERMIT=1) WHERE USERID='" + userID + "' AND PASSWORD='" + password + "'";
	
			log.info("SQL:" + sql);
			log.info("SQL:=================================================================");
			WebRowSet wrsLogin = DBManage.getWRS(conn, sql);
			log.info("\n\n\nSQL:" + sql);
			try {
				if (wrsLogin.next()) {
					userName = wrsLogin.getString("USERNAME");
					role = wrsLogin.getString("ROLE");
					locked = wrsLogin.getInt("LOCKED");// 是否已被锁定
					checkOK = (locked == 1 ? false : true);
				}
				wrsLogin.close();
			} catch (SQLException e) {
				log.error("检查用户合法性时出现异常");
				e.printStackTrace();
			}
	
			log.info("用户" + userName + "登录系统");
	
			if (checkUserName(userID) == true && checkOK == true) {
				// 写登录日志
				//this.writeLog(request, userName, conn);
				// 写SESSION
				log.info("写SESSION");
				request.getSession().setAttribute("roleType", role);
				request.getSession().setAttribute("userName", userName);
				request.getSession().setAttribute("userID", userID);
				
				if (!allowDefaultPwd && Constants.DEFAULT_PWD.equalsIgnoreCase(password)) {
					DBManage.closeConnection(conn);
					// 如果还是默认的密码,则要求更改
					log.info("转入更改密码页面");
					response.sendRedirect("user/changepwd.jsp");
				} else {
					DBManage.closeConnection(conn);
					// 如果已经更改了密码,则进入系统
					log.info("通过验证,进入系统");
					if("Alumni".equalsIgnoreCase(role)){
						response.sendRedirect("classmate.jsp");
					}else{
						response.sendRedirect("Frame");
					}
				}
			} else {
				// 写登录日志,出错的也记录,此时就只能记录userID
				//this.writeLog(request, userID, conn);
				DBManage.closeConnection(conn);
				// 如果出错,则返回到登录页面
				response.sendRedirect("login.jsp?error=" + (locked == 0 ? 1 : 2));
			}
		}catch(NullPointerException e){
			
			out.println("<html><head>");
			out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\"styles.css\">");
			out.println("</head>");
			out.println("<br><br><br><br><br><br>");
			out.println("<center>");
			out.println("<h1><a href=\"login.jsp\">服务器繁忙,请按F5键刷新或稍后再试</a></h1>");
			out.println("</center>");
		}

		out.flush();
		out.close();
		return;
	}

	/**
	 * Initialization of the servlet. <br>
	 * 
	 * @throws ServletException
	 *             if an error occure
	 */
	public void init() throws ServletException {
		// Put your code here
	}

	/**
	 * 写日志记录
	 * 
	 * @param request
	 *            传入的request对象,以获取远端信息
	 * @param userName
	 *            记录登录人的名字
	 */
	private void writeLog(HttpServletRequest request, String userName, Connection conn) {
		// 记录日志
		String logStr = "INSERT INTO TS_LOG(USERNAME,LOGTIME,ADDRESS,HOST,PORT,USER)";
		logStr += " VALUES('" + userName + "',";
		logStr += "NOW(),";
		logStr += "'" + request.getRemoteAddr() + "',";
		logStr += "'" + request.getRemoteHost() + "',";
		logStr += "'" + request.getRemotePort() + "',";
		logStr += "'" + request.getRemoteUser() + "')";

		log.info("写日志的SQL:" + logStr);

		DBManage.doUpdate(conn, logStr);
		log.info("写日志操作结束");
	}

	/**
	 * 此函数用于检查用户名是否合法,防止SQL入注
	 * 
	 * @param userID
	 * @return
	 */
	private boolean checkUserName(String userID) {
		boolean retVal = true;
		// 如果输入的用户ID长度为0
		if (userID.length() == 0) {
			retVal = false;
		}
		// 如果用户ID包含空格
		if (userID.indexOf(" ") != -1) {
			retVal = false;
		}
		// 如果用户ID包含=
		if (userID.indexOf("=") != -1) {
			retVal = false;
		}
		// 如果用户ID包含%
		if (userID.indexOf("%") != -1) {
			retVal = false;
		}

		log.info("userID[" + userID + "] retVal[" + retVal + "]");
		return retVal;
	}

}
