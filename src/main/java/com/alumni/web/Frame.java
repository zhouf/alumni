/**
 * 
 */
package com.alumni.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author king
 * 2011-4-14
 */
@WebServlet("/Frame")
public class Frame extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public Frame() {
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
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<TITLE>校友管理系统</TITLE>");
		out.println("	<frameset frameborder=\"no\" rows=\"75,*\">");
		out.println("		<frame name=\"head\" src=\"head.jsp\" scrolling=\"no\" noresize>");
		out.println("		<frameset frameborder=\"no\" cols=\"200,*\">");
		out.println("			<frameset frameborder=\"no\" rows=\"*,60\">");
		out.println("				<frame name=\"left\" src=\"left.jsp\" noresize>");
		out.println("				<frame name=\"footer\" src=\"footer.jsp\" scrolling=\"no\" noresize>");
		out.println("			</frameset>");
		out.println("			<frame name=\"main\" src=\"main.jsp\">");
		out.println("		</frameset>");
		out.println("	</frameset>");
		out.flush();
		out.close();
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
