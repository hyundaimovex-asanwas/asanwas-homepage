package purch.common;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.*;
import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import purch.common.HDConstant;
import purch.common.HDUtil;
//import purch.org.common.db.DBConnection;

import com.gauce.GauceContext;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.db.GauceDBConnection;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.Logger;

public class HDCookieManager {
	private String fAdminType = "한글";
	private String fEmpno = "한글명";
	public HDCookieManager(HttpServletRequest req, HttpServletResponse res) throws ServletException {
		fAdminType = req.getParameter("AdminType");
		fEmpno = req.getParameter("Empno");
		//creatCookie(req, res);
		
		
	}
	
	/**
	 * 모든 서블릿을 분기 및 처리
	 * @param req
	 * @param res
	 * @throws ServletException
	 */
	public void creatCookie(HttpServletRequest req, HttpServletResponse res) throws ServletException {
		
		StringUtil.printMsg("타입", fAdminType, this);
		StringUtil.printMsg("사번", fEmpno,this);
		
		res.setContentType("text/html;charset=ksc5601");
//		getUserInfo(req, res);
		try {
			Cookie name = new Cookie("name","한글"); 
			
			name.setMaxAge(0);
//			name.setMaxAge(0);
			res.addCookie(name);
			
			Cookie empno = new Cookie("empno",fEmpno);
			empno.setMaxAge(0);
			res.addCookie(empno);
			
			
			Cookie ip = new Cookie("ip","123.55.5.5.");
			ip.setMaxAge(0);
			res.addCookie(ip);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String[] getUserInfo(HttpServletRequest req, HttpServletResponse res) {
		String info[] = new String[10];
//		ServiceLoader loader = new ServiceLoader(req, res); 	// Service Loader
//		GauceService service = null;
//		GauceContext context = null;
//		Logger log = null;
//
//		GauceRequest gceReq = null; 							// Request
//		GauceResponse gceRes = null; 							// Response
//
//		/* DataBase */
//		GauceDBConnection conn = null; 	
		ResultSet rs = null;
		Connection conn= null;
		try {
//			service = loader.newService();
			
			// Database Connection
//			conn = service.getDBConnection();


/*		2011 - 08 - 03 DB 커넥션 우선 빼다~ 이동
			conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM SALES.TSY010");
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				StringUtil.printMsg(rs.getString(1),this);
				StringUtil.printMsg(rs.getString(2),this);
				StringUtil.printMsg(rs.getString(3),this);
				StringUtil.printMsg(rs.getString(4),this);
				StringUtil.printMsg(rs.getString(5),this);
				
			}
			
			rs.close();
			conn.close();
			
*/			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return info;
		
	}
	
	public String getCookieValue(String name, HttpServletRequest req) {
		String value = "";
		   Cookie cookie[] = req.getCookies();
		     try {
		     if (cookie != null) {
		     	for (int cok = 0 ; cok < cookie.length; cok++) {
		     		if (cookie[cok].getName().equals(name)) {
		     			value = cookie[cok].getValue();
		     		}
		     	}
		     }
		     } catch (Exception e) {
		    	 e.printStackTrace();
		     }
		     
		return value;     
	}
	
}
