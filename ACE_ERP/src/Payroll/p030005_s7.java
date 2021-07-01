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
public class p030005_s7 extends HttpServlet {

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

				String [] str= new String[2] ;
				str[0] = req.getParameter("v_str1");	//귀속년도
				str[1] = req.getParameter("v_str2");	//사번

		  	for (int s=0;s<str.length;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "APPYY",	"EMPNO",	"EMPNMK",	"EMPJUNO",		"ADDRESS",		"TELNO",	 "SEQ",		"DUDGB",

																	"FINACD",	"FINANM",	"ACCNO",	"YEARLY",		"PAYAMT",		"DEDAMT",	"STATDT"
				};  
					                              
				int[] intArrCN = new int[]{ 4,		7,		20,		13,		50,	15,	4,		2,
														3,		30,		20,		2,		10,		10,	8
					}; 
			
				int[] intArrCN2 = new int[]{-1,	-1,	-1,	-1,	-1,	-1,	-1,	-1,
															-1,	-1,	-1,	0,		0,		0,		-1
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

				sql.append(" SELECT																																					\n ")
						 
					.append("  R1.APPYY    AS  APPYY,   R1.EMPNO AS EMPNO																							\n ")
					.append("  ,R2.EMPNMK    AS EMPNMK       ,R2.RESINO    AS EMPJUNO,	CONCAT(R2.CADDR01, R2.CADDR02) AS ADDRESS		\n ")
					.append("  ,R2.TELNO AS TELNO ,R1.SEQ		AS SEQ	 ,R1.DUDGB         AS  DUDGB															\n ")
					.append("  ,R1.FINACD		AS FINACD			,R1.FINANM		AS FINANM																			\n ")
					.append("  ,R1.ACCNO		AS ACCNO			,R1.YEARLY		AS YEARLY																			\n ")
					.append("  ,R1.PAYAMT            AS  PAYAMT     ,R1.DEDAMT            AS  DEDAMT     ,R1.STATDT		AS STATDT					\n ")

					.append("  FROM PAYROLL.YCPRSNPS R1 JOIN PAYROLL.YIPERSON R2 ON (R1.EMPNO = R2.EMPNO)										\n ")

					.append("  WHERE	 1   = 1																																	\n ");

					if (!str[0].equals("")) sql.append( " AND R1.APPYY = '" + str[0] + "'																			\n" );
					if (!str[1].equals("")) sql.append( " AND R1.EMPNO = '" + str[1] + "'																				\n" );

					sql.append("  AND R1.DUDGB IN ('11','12','21','22','41')																									\n ");					
						
					//.append("\n").append( " ORDER BY A.RELAT1																											\n");

					logger.dbg.println( this, sql.toString() );


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