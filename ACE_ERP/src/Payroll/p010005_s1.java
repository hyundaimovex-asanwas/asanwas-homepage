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
public class p010005_s1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");		//적용년월
				String  str2	= req.getParameter("v_str2");		//급여이상
				String  str3	= req.getParameter("v_str3");		// 급여미만
				if (str1==null) { str1 = ""; }
				if (str2==null) { str2 = ""; }
				if (str3==null) { str3 = ""; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "APPYM", "FRAMT", "TOAMT", "FAMILY1", "FAMILY2", 
																					 "FAMILY3", "FAMILY4", "FAMILY5", "FAMILY6", "FAMILY7",
																					 "FAMILY8", "FAMILY9", "FAMILY10", "FAMILY11",
                                                                                     "FAMILY23", "FAMILY24", "FAMILY25", "FAMILY26", "FAMILY27",
                                                                                      "FAMILY28", "FAMILY29", "FAMILY30", "FAMILY31"
																				}; 

				int[] intArrCN = new int[] {  6,  9,  9,  9, 9, 
																			9,  9,  9,  9, 9,
																			9,  9,  9,  9,
                                 9,  9,  9,  9, 9,
                                 9,  9,  9,  9 
																		}; 
			
				int[] intArrCN2 = new int[]{ -1,  0,  0, 0, 0,
																			0,  0,  0, 0, 0,
																			0,  0,  0, 0,
                                0,  0,  0, 0, 0,
                                0,  0,  0, 0 
																		}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( " SELECT  ");
						sql.append( " APPYM, FRAMT, TOAMT, FAMILY1, FAMILY2, ");
						sql.append( " FAMILY3, FAMILY4, FAMILY5, FAMILY6, FAMILY7, ");
						sql.append( " FAMILY8, FAMILY9, FAMILY10, FAMILY11, ");
	sql.append( " FAMILY23, FAMILY24, FAMILY25, FAMILY26, FAMILY27, ");
	sql.append( " FAMILY28, FAMILY29, FAMILY30, FAMILY31 ");
						sql.append( " FROM PAYROLL.PWTAXTBL ");
						sql.append( " WHERE RTRIM(APPYM) <> ''  " );	
						
						if (!str1.equals("") && !str1.equals("0"))	
							sql.append( " AND APPYM ='"+ str1 + "'  " );
						if (!str2.equals("") && !str2.equals("0"))	
							sql.append( " AND  "+ Integer.parseInt(str2) + " BETWEEN FRAMT  AND  TOAMT  " );

						//sql.append( " order by PAYCD ASC ");

						//logger.err.println( this, sql.toString() );						

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