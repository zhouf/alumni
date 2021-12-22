package com.jufeng.util.log;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.PropertyConfigurator;

@WebServlet(urlPatterns={"/Log4jInit"},loadOnStartup=1)
public class Log4jInit extends HttpServlet {

	public void init() {
		String file = "/WEB-INF/log4j.properties";
		// if the log4j-init-file is not set, then no point in trying
		System.out.println("................log4j start");
		if (file != null) {
			PropertyConfigurator.configure(this.getServletContext().getRealPath("/")+file);
		}
		System.out.println("................log4j start over!");
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res) {
	}
	
}
