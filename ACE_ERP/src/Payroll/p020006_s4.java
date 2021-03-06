package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class p020006_s4 extends HttpServlet {

	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement stmt =null;
		GauceDataSet dSet = null;

		try {
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
      GauceResponse GauceRes = service.getGauceResponse();

			try {
				conn = service.getDBConnection();
				dSet = new GauceDataSet();

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음

				String [] str= new String[5] ;
        str[0]  = req.getParameter("v_str1");   //사번
				str[1]	= req.getParameter("v_str2");		//년월
				str[2]	= req.getParameter("v_str3");		//급여구분

		  	for (int s=0;s<=2;s++) {
					if (str[s]==null) str[s] = "";
				}
             
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"PR0020","PR0030","PR0040",
																				 "BR0020","BR0030","BR0040" }; 
					                                             
				int[] intArrCN = new int[] {	20,  20,	20,		20,		20,		20	}; 
			
				int[] intArrCN2 = new int[]{	-1,	 -1,	-1,		-1,		-1,		-1	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT  DISTINCT ");
					sql.append( " RTRIM(A.PR0020) PR0020,RTRIM(A.PR0030) PR0030,RTRIM(A.PR0040) PR0040, ");
					sql.append( " RTRIM(A.BR0020) BR0020,RTRIM(A.BR0030) BR0030,RTRIM(A.BR0040) BR0040  ");
					sql.append( " FROM PAYROLL.PBPAY A" );
				//	sql.append( " WHERE A.EMPNO  = '" + str[0]+"'" );
					sql.append( " WHERE A.APPDT  = '" + str[1]+"'" );
					sql.append( " AND A.PAYDIV = '" + str[2]+"'");

					//logger.dbg.println(this, sql.toString());

/*********************************************************************************************/
					stmt = conn.getGauceStatement(sql.toString());
	 		    stmt.executeQuery(dSet);
				}
			} catch(Exception e) {
		  	logger.err.println(this,e);
		  } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close(true);} catch (Exception e) {}
			}

		  dSet.flush();
		  GauceRes.commit();
		  GauceRes.close();

		} catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		} finally {
			loader.restoreService(service);
  	}
	}
}