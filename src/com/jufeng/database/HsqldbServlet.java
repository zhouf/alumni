package com.jufeng.database;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hsqldb.server.Server;

@WebServlet(urlPatterns={"/HsqldbServlet"},loadOnStartup=0)
public class HsqldbServlet extends HttpServlet {

	private Server server = new Server();
	
	/**
	 * Constructor of the object.
	 */
	public HsqldbServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		System.out.println("super.destroy() destroy222");
		server.shutdown();
		System.out.println("after server.shutdown() destroy333");
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

	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
		String path=this.getServletContext().getRealPath("/WEB-INF/db/alumni");
		
		System.out.println("path["+path+"]");
		
		server.setDatabaseName(0, "alumnidb");
		server.setDatabasePath(0, path);
		server.setPort(9001);
		server.setSilent(true);
		Thread thread=new Thread(new Runnable(){
			public void run() {
				server.start();
			}
		});
		thread.start();
	}

}
