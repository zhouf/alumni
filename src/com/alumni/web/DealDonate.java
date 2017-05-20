package com.alumni.web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jufeng.database.DBManage;

@WebServlet("/DealDonate")
public class DealDonate extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public DealDonate() {
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

		//response.setContentType("text/html");
		//PrintWriter out = response.getWriter();
		
		String userName = (request.getParameter("username")==null? "" : request.getParameter("username").trim());
		String className = (request.getParameter("classname")==null? "" : request.getParameter("classname").trim());
		String amount = (request.getParameter("amount")==null? "" : request.getParameter("amount").trim());
		String postscript = (request.getParameter("postscript")==null? "" : request.getParameter("postscript").trim());
		String op = (request.getParameter("op")==null? "create" : request.getParameter("op").trim());
		String sql = "";
		
		if("create".equalsIgnoreCase(op)){
			sql = "INSERT INTO TB_DONATE(USERNAME,DDATE,CLASSNAME,AMOUNT,POSTSCRIPT) VALUES('"+userName+"',CURDATE(),'"+className+"',"+amount+",'"+postscript+"')";
		}
		
		System.out.println("SQL:" + sql);
		DBManage.doUpdate(sql);


		response.sendRedirect("donate.jsp");
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
