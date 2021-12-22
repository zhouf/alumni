package com.alumni.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alumni.util.Constants;
import com.jufeng.database.DBManage;

@WebServlet("/DealUser")
public class DealUser extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public DealUser() {
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
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		
		PrintWriter out = response.getWriter();
		
		String userId = (request.getParameter("userid")==null? "" : request.getParameter("userid").trim());
		String userName = (request.getParameter("username")==null? "" : request.getParameter("username").trim());
		//String role = (request.getParameter("role")==null? "" : request.getParameter("role").trim());
		String op = (request.getParameter("op")==null? "" : request.getParameter("op").trim());
		
		String sql = "";
		boolean needBack = false;

		if("create".equalsIgnoreCase(op)){
			
			//创建用户时,判断用户是否已存在
			String checkUserId = DBManage.changeID("SELECT COUNT(*) FROM TB_USERS WHERE USERID='"+userId+"'");
			if(!("0".equalsIgnoreCase(checkUserId))){
				//如果已存在
				out.println("<script>alert('该用户已存在');history.back();</script>");
				needBack = true;
			}
			sql = "INSERT INTO TB_USERS(USERID,USERNAME,PASSWORD,ROLE,LOCKED) VALUES('"+userId+"','"+userName+"','"+Constants.DEFAULT_PWD+"','Admin',0)";
		}else if("modify".equalsIgnoreCase(op)){
			sql = "UPDATE TB_USERS SET USERNAME='"+userName+"' WHERE USERID='" + userId + "'";
		}else if("del".equalsIgnoreCase(op)){
			//最后一个用户处理
			String userCount = DBManage.changeID("SELECT COUNT(*) FROM TB_USERS WHERE LOCKED=0 AND USERID!='"+userId+"'");
			if("0".equalsIgnoreCase(userCount)){
				out.println("<script>alert('不允许删除，系统至少保留一个登录用户');history.back();</script>");
				needBack = true;
			}
			sql = "DELETE FROM TB_USERS WHERE USERID='" + userId + "'";
		}else if("lock".equalsIgnoreCase(op)){
			//最后一个用户处理
			String userCount = DBManage.changeID("SELECT COUNT(*) FROM TB_USERS WHERE LOCKED=0 AND USERID!='"+userId+"'");
			System.out.println("userCount["+userCount+"]");
			if("0".equalsIgnoreCase(userCount)){
				out.println("<script>alert('不允许锁定，系统至少保留一个登录用户');history.back();</script>");
				needBack = true;
			}
			sql = "UPDATE TB_USERS SET LOCKED=1 WHERE USERID='" + userId + "'";
		}else if("unlock".equalsIgnoreCase(op)){
			sql = "UPDATE TB_USERS SET LOCKED=0 WHERE USERID='" + userId + "'";
		}else if("resetpwd".equalsIgnoreCase(op)){
			sql = "UPDATE TB_USERS SET PASSWORD='"+Constants.DEFAULT_PWD+"' WHERE USERID='" + userId + "'";
		}

		if(needBack){
			out.flush();
			out.close();
		}else{
			DBManage.doUpdate(sql);
			response.sendRedirect("user/userlist.jsp");	
		}
		return;
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
