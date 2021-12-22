package com.alumni.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jufeng.database.DBManage;

@WebServlet("/DealDoc")
public class DealDoc extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public DealDoc() {
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

		String title = (request.getParameter("title")==null? "" : request.getParameter("title").trim());
		String author = (request.getParameter("author")==null? "" : request.getParameter("author").trim());
		String item = (request.getParameter("item")==null? "" : request.getParameter("item").trim());
		String content = (request.getParameter("content")==null? "" : request.getParameter("content").trim());
		String op = (request.getParameter("op")==null? "" : request.getParameter("op").trim());
		String docid = (request.getParameter("docid")==null? "" : request.getParameter("docid").trim());
		String sql = "";
		
		if("create".equalsIgnoreCase(op)){
			//创建文档
			sql = "INSERT INTO TB_DOCS(TITLE,AUTHOR,ITEM,CONTENT,PUBDATE) VALUES('"+title+"','"+author+"','"+item+"','"+content+"',CURDATE())";
		}else if("modify".equalsIgnoreCase(op)){
			//修改文档
			sql = "UPDATE TB_DOCS SET TITLE='"+title+"',AUTHOR='"+author+"',CONTENT='"+content+"',PUBDATE=CURDATE() WHERE DOCID=" + docid;
		}else if("deldoc".equalsIgnoreCase(op)){
			//删除文档
			sql = "DELETE FROM TB_DOCS WHERE DOCID=" + docid;
		}
		System.out.println("SQL:" + sql);
		DBManage.doUpdate(sql);
		
		response.sendRedirect("doc/doclist.jsp");
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
