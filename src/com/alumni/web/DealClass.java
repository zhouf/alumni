/**
 * 
 */
package com.alumni.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jufeng.database.DBManage;

/**
 * @author king
 * 2011-4-14
 */
@WebServlet("/DealClass")
public class DealClass extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public DealClass() {
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

		String id = (request.getParameter("id")==null? "" : request.getParameter("id").trim());
		String deptName = (request.getParameter("deptname")==null? "" : request.getParameter("deptname").trim());
		String majorName = (request.getParameter("majorname")==null? "" : request.getParameter("majorname").trim());
		String className = (request.getParameter("classname")==null? "" : request.getParameter("classname").trim());
		String op = (request.getParameter("op")==null? "" : request.getParameter("op").trim());
		
		String sql = "";

		if("create".equalsIgnoreCase(op)){
			//do create
			sql = "INSERT INTO TB_CLASS(DEPTNAME,MAJORNAME,CLASSNAME) VALUES('"+deptName+"','"+majorName+"','"+className+"')";
		}else if("modify".equalsIgnoreCase(op)){
			//do modify
			sql = "UPDATE TB_CLASS SET DEPTNAME='"+deptName+"',MAJORNAME='"+majorName+"',CLASSNAME='"+className+"' WHERE ID=" + id;
		}else if("del".equalsIgnoreCase(op)){
			//do del
			sql = "DELETE FROM TB_CLASS WHERE ID=" + id;
		}

		System.out.println("SQL=" + sql);
		DBManage.doUpdate(sql);
		
		response.sendRedirect("class/classlist.jsp");
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
