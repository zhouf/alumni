package com.alumni.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jufeng.database.DBManage;
import com.alumni.util.Constants;

@WebServlet("/DealAlumni")
public class DealAlumni extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public DealAlumni() {
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
		
		String stuNum = (request.getParameter("stunum")==null? "" : request.getParameter("stunum").trim());
		String stuName = (request.getParameter("stuname")==null? "" : request.getParameter("stuname").trim());
		String gender = (request.getParameter("gender")==null? "" : request.getParameter("gender").trim());
		String birthday = (request.getParameter("birthday")==null? "" : request.getParameter("birthday").trim());
		String nationality = (request.getParameter("nationality")==null? "" : request.getParameter("nationality").trim());
		String stuclass = (request.getParameter("stuclass")==null? "" : request.getParameter("stuclass").trim());
		String tel = (request.getParameter("tel")==null? "" : request.getParameter("tel").trim());
		String phone = (request.getParameter("phone")==null? "" : request.getParameter("phone").trim());
		String qq = (request.getParameter("qq")==null? "" : request.getParameter("qq").trim());
		String msn = (request.getParameter("msn")==null? "" : request.getParameter("msn").trim());
		String email = (request.getParameter("email")==null? "" : request.getParameter("email").trim());
		String area = (request.getParameter("area")==null? "" : request.getParameter("area").trim());
		String workunit = (request.getParameter("workunit")==null? "" : request.getParameter("workunit").trim());
		String address = (request.getParameter("address")==null? "" : request.getParameter("address").trim());
		String describe = (request.getParameter("describe")==null? "" : request.getParameter("describe").trim());

		//op取值为create 或 modify
		String op = (request.getParameter("op")==null? "" : request.getParameter("op").trim());
		
		String sql = "";
		String returnPage = "alumni/alumnilist.jsp";

		if("create".equalsIgnoreCase(op) || "register".equalsIgnoreCase(op)){
			
			//创建用户时,判断用户是否已存在
			String checkUserId = DBManage.changeID("SELECT COUNT(*) FROM TB_ALUMNI WHERE STUNUM='"+stuNum+"'");
			if(!("0".equalsIgnoreCase(checkUserId))){
				//如果已存在
				out.println("<script>alert('该校友已存在');history.back();</script>");
				out.flush();
				out.close();
				return;
			}
			sql = "INSERT INTO TB_ALUMNI(STUNUM,STUNAME,GENDER,BIRTHDAY,NATIONALITY,CLASS,TEL,PHONE,QQ,MSN,EMAIL,WORKUNIT,ADDRESS,DESCRIBE,AREA,PASSWORD) VALUES(";
			sql += "'"+stuNum+"',";
			sql += "'"+stuName+"',";
			sql += "'"+gender+"',";
			sql += "'"+birthday+"',";
			sql += "'"+nationality+"',";
			sql += stuclass+",";
			sql += "'"+tel+"',";
			sql += "'"+phone+"',";
			sql += "'"+qq+"',";
			sql += "'"+msn+"',";
			sql += "'"+email+"',";
			sql += "'"+workunit+"',";
			sql += "'"+address+"',";
			sql += "'"+describe+"',";
			sql += "'"+area+"',";
			sql += "'"+Constants.DEFAULT_PWD +"')";
			
			//如果是校友注册，则返回页面需要重新指定
			if("register".equalsIgnoreCase(op)){
				returnPage="register.jsp?ret=ok";
			}
			
		}else if("modify".equalsIgnoreCase(op)){
			//修改校友信息
			sql = "UPDATE TB_ALUMNI SET ";
			sql += "STUNAME='"+stuName+"',";
			sql += "GENDER='"+gender+"',";
			sql += "BIRTHDAY='"+birthday+"',";
			sql += "NATIONALITY='"+nationality+"',";
			sql += "CLASS="+stuclass+",";
			sql += "TEL='"+tel+"',";
			sql += "PHONE='"+phone+"',";
			sql += "QQ='"+qq+"',";
			sql += "MSN='"+msn+"',";
			sql += "EMAIL='"+email+"',";
			sql += "WORKUNIT='"+workunit+"',";
			sql += "ADDRESS='"+address+"',";
			sql += "DESCRIBE='"+describe+"',";
			sql += "AREA='"+area+"'";
			
			sql += " WHERE STUNUM='"+stuNum+"'";		
		}else if("delalumni".equalsIgnoreCase(op)){
			//删除校友记录
			sql = "DELETE FROM TB_ALUMNI WHERE STUNUM='" + request.getParameter("id") + "'";
		}else if("delalumni2".equalsIgnoreCase(op)){
			//删除校友记录,此处处理的是审核申请时的删除
			sql = "DELETE FROM TB_ALUMNI WHERE STUNUM='" + request.getParameter("id") + "'";
			returnPage="alumni/checklist.jsp";
		}else if("permit".equalsIgnoreCase(op)){
			//审核校友申请
			sql = "UPDATE TB_ALUMNI SET PERMIT=1 WHERE STUNUM='" + request.getParameter("id") + "'";
			returnPage="alumni/checklist.jsp";
		}else if("resetpwd".equalsIgnoreCase(op)){
			//重置密码操作
			sql = "UPDATE TB_ALUMNI SET PASSWORD='" + Constants.DEFAULT_PWD + "' WHERE STUNUM='" + request.getParameter("id") + "'";
		}

		System.out.println("校友操作sql:" + sql);
		DBManage.doUpdate(sql);
		response.sendRedirect(returnPage);	
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
