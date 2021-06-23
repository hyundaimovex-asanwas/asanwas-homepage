/*
 * Created on 2005. 8. 14.
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package kr.co.imjk.util;

import java.io.*;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.UnavailableException;
import javax.servlet.*;

public class SetCharacterEncodingFilter implements Filter {
protected String encoding = null;

/**
 * 
 * @uml.property name="filterConfig"
 * @uml.associationEnd 
 * @uml.property name="filterConfig" multiplicity="(0 1)"
 */
protected FilterConfig filterConfig = null;

protected boolean ignore = true;
public void destroy() {
	this.encoding = null;
	this.filterConfig = null;
	}
	public void doFilter(ServletRequest request, ServletResponse response,
	FilterChain chain)
		throws IOException, ServletException {
	//	 Conditionally select and set the character encoding to be used
		//if (ignore || (request.getCharacterEncoding() == null)) {
		   String encoding = selectEncoding(request);
			if (encoding != null){
			   request.setCharacterEncoding(encoding);
			   //System.out.println("############## DO encoding:"+encoding);
			}else{
			    System.out.println("############# DO encoding UTF-8:");
				//request.setCharacterEncoding("UTF-8");
		 
			}
		//}
	//	 Pass control on to the next filter
		chain.doFilter(request, response);
	} 
	  
	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
		this.encoding = filterConfig.getInitParameter("encoding");
		//System.out.println("encoding:"+encoding);
		String value = filterConfig.getInitParameter("ignore");
		//System.out.println("value:"+value);
		if (value == null)
			this.ignore = true;
		else if (value.equalsIgnoreCase("true"))
			this.ignore = true;
		else if (value.equalsIgnoreCase("yes"))
			this.ignore = true;
		else
			this.ignore = false;
		
		//System.out.println("this.ignore:"+this.ignore);
	}
	
	protected String selectEncoding(ServletRequest request) {
		return (this.encoding);
	}
}