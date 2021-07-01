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
public class p030005_s3 extends HttpServlet {

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

				String [] str= new String[10] ;
        str[0] = req.getParameter("v_str1");  //귀속년도
				str[1] = req.getParameter("v_str2");	//부서
				str[2] = req.getParameter("v_str3");	//성명
				str[3] = req.getParameter("v_str4");	//Level
				str[4] = req.getParameter("v_str5");	//treecd
				str[5] = req.getParameter("v_str6");	//귀속연도

		  	for (int s=0;s<=5;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO",	     "APPDT",	     "RELAT1",			"FAMNM1",      	"RESINO1",
																					"REF1",			"REF2",			"REF3",			"REF4",			
																					"REF11",	   "REF12",	   "REF13",		"REF14",		"REF15",	
																					"REF21",	   "REF22",	   "REF23",	    "REF24",		"REF25"	
																					
				};  
					                              
				int[] intArrCN = new int[]{ 7,	6,		1,		20,	13,	
																		1,	1,	1,	1,	
																		9,	9,	9,	9,	9,	
																		9,	9,	9,	9,	9
																		
																		
					}; 
			
				int[] intArrCN2 = new int[]{-1,	-1,	-1,	-1,	-1,	
																		-1,	-1,	-1,	-1,	
																		 0,	 0,	0,		0,		0,
																		 0,	 0,	0,		0,		0	
																		
					                         
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append(" SELECT ");
					sql.append("\n").append( " A.EMPNO, A.APPDT,      A.RELAT1,     A.FAMNM1,      A.RESINO1,  	"); 
					sql.append("\n").append( " A.REF1,		A.REF2,		A.REF3,		A.REF4,			");
					sql.append("\n").append( " COALESCE(A.REF11,0)  REF11,	COALESCE(A.REF12,0)  AS REF12,	A.REF13,	A.REF14,	A.REF15,	"); 
					sql.append("\n").append( " COALESCE(A.REF21,0) REF21, COALESCE(A.REF22,0) AS REF22,	COALESCE(A.REF23,0) AS REF23,	COALESCE(A.REF24,0) AS REF24,	COALESCE(A.REF25,0)  AS REF25	");
					sql.append("\n").append( " FROM PAYROLL.YCPRSN A																																	"); 
					sql.append("\n").append( " WHERE RTRIM(A.EMPNO) = '" + str[0] + "'						");
					//sql.append("\n").append( " AND A.EMPNMK  LIKE '" +str[2] + "%'																											");
					//sql.append("\n").append( " AND A.PAYDIV IN ('Y','T')																																");

					//if (str[3].equals("1")) sql.append("\n").append( " AND SUBSTR(D.TREECD,1,4)= '" + str[4] +"'");
					//if (str[3].equals("2")) sql.append("\n").append( " AND SUBSTR(D.TREECD,1,4)= '" + str[4] + "'");
					//if (str[3].equals("3")) sql.append("\n").append( " AND SUBSTR(D.TREECD,1,6)= '" + str[4] +"'");
					//if (str[3].equals("4")) sql.append("\n").append( " AND RTRIM(D.TREECD)= '" + str[4] + "'");

					//sql.append("\n").append( " ORDER BY D.TREECD, C.SEQ \n");
					sql.append("\n").append( " ORDER BY A.EMPNO \n");

					logger.dbg.println(this, sql.toString());

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