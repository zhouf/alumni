package com.jufeng.util.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

import java.io.*;

@WebFilter("/*")
public class CharacterEncoding extends HttpServlet implements Filter {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private FilterConfig filterConfig;

	
	// Handle the passed-in FilterConfig
	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
	}

	// Process the request/response pair
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain filterChain) {
		try {
			//System.out.println("do Filter........" + encoding);
			
			request.setCharacterEncoding("utf-8");
			filterChain.doFilter(request, response);
		} catch (ServletException sx) {
			filterConfig.getServletContext().log(sx.getMessage());
		} catch (IOException iox) {
			filterConfig.getServletContext().log(iox.getMessage());
		}
	}

	// Clean up resources
	public void destroy() {
	}
	

}
