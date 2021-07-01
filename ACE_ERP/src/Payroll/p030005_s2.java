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
public class p030005_s2 extends HttpServlet {

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
				str[1] = req.getParameter("v_str2");  //CURDT

		  	for (int s=0;s<=1;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO",	     "EMPNMK",		 "PAYGRD",      "PAYGRDNM",		"DEPTNM",	 
																					"BA0101YN",		 "BA0102CNT",	 "AD0103CNT",	  "AD0101CNT",  "AD0102CNT",	
																					"AD0105CNT",	 "AD0104YN",	 "BC10000",	    "BC20000",	  "PC10000",	
																					"PC20000",	   "FRE13001",	 "PC23000",			"FRE13005",		"PB10000",	  
																					"PB41000",		 "PB42000",		 "PB51000",	    "PB52000",	  "PB61000",	 
																					"PB62000",		 "PB71000",	   "PB72000",			"CURDT"
				};  
					                              
				int[] intArrCN = new int[]{ 7,	20,	 4,	30,	50,	
																		1,	2,	2,	2,	2,
																		2,	1,	9,	9,	9,	
																		9,	9,	9,	9,	9,	
																		9,	9,	9,	9,	9,	
																		9,	9,	9,	4
					}; 
			
				int[] intArrCN2 = new int[]{-1,	-1,	-1,	-1,	-1,	
																		 0,	 0,	 0,	 0,	 0,
																		 0,	 0,	 0,	 0,	 0,	
																		 0,	 0,	 0,	 0,	 0,	
																		 0,	 0,	 0,	 0,	 0,
																		 0,	 0,	 0,	-1
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
					sql.append("\n").append( " A.EMPNO,																																				");
					sql.append("\n").append( " CASE WHEN SUBSTR(A.EMPNO,1,1) <> 3 THEN RTRIM(B.EMPNMK) ELSE RTRIM(BB.EMPNMK) END AS EMPNMK, ");
					sql.append("\n").append( " RTRIM(A.PAYGRD) PAYGRD,  RTRIM(C.MINORNM) PAYGRDNM, RTRIM(D.DEPTNM) DEPTNM,		"); 
					sql.append("\n").append( " COALESCE(A.BA0101YN,0)		BA0101YN,			COALESCE(A.BA0102CNT,0) BA0102CNT,			");
					sql.append("\n").append( " COALESCE(A.AD0103CNT,0)	AD0103CNT,		COALESCE(A.AD0101CNT,0) AD0101CNT,			");
					sql.append("\n").append( " COALESCE(A.AD0102CNT,0)	AD0102CNT,		COALESCE(A.AD0105CNT,0) AD0105CNT,			"); 
					sql.append("\n").append( " COALESCE(A.AD0104YN,0)		AD0104YN,			COALESCE(A.BC10000,0)		BC10000,				");
					sql.append("\n").append( " COALESCE(A.BC20000,0)    BC20000,			COALESCE(A.PC10000,0)		PC10000,				"); 
					sql.append("\n").append( " COALESCE(A.PC20000,0)	  PC20000,			COALESCE(F.FRE13001,0)  FRE13001,				");
					sql.append("\n").append( " COALESCE(A.PC23000,0)		PC23000,			COALESCE(F.FRE13005,0)  FRE13005,				");
					sql.append("\n").append( " COALESCE(A.PB10000,0)		PB10000,			COALESCE(A.PB41000,0)		PB41000,				"); 
					sql.append("\n").append( " COALESCE(A.PB42000,0)		PB42000,			COALESCE(A.PB51000,0)		PB51000,				");
					sql.append("\n").append( " COALESCE(A.PB52000,0)    PB52000,			COALESCE(A.PB61000,0)		PB61000,				"); 
					sql.append("\n").append( " COALESCE(A.PB62000,0)    PB62000,			COALESCE(A.PB71000,0)   PB71000,				");
					sql.append("\n").append( " COALESCE(A.PB72000,0)    PB72000,			'"+str[1]+"'  AS CURDT									"); 
					sql.append("\n").append( " FROM PAYROLL.YCPAYCOL A																												"); 
					sql.append("\n").append( " LEFT JOIN PAYROLL.HIPERSON		B		ON A.EMPNO  = B.EMPNO													");
					sql.append("\n").append( " LEFT JOIN PAYROLL.T_HIPERSON BB	ON A.EMPNO  = BB.EMPNO												");
					sql.append("\n").append( " LEFT JOIN PAYROLL.HCLCODE		C		ON A.PAYGRD = C.MINORCD AND C.MAJORCD='2002'	");
					sql.append("\n").append( " LEFT JOIN PAYROLL.HCDEPT			D		ON A.DEPTCD = D.DEPTCD												");
					sql.append("\n").append( " LEFT JOIN PAYROLL.HCLCODE		E		ON A.PAYSEQ = E.MINORCD AND E.MAJORCD='1184'	");
					sql.append("\n").append( " LEFT JOIN PAYROLL.YCPERCOL		F		ON B.EMPNO  = F.EMPNO													");
					sql.append("\n").append( " WHERE A.EMPNO  <> ''	AND A.PAYGRD <> '890'																				");

					if(!str[0].equals("")) sql.append("\n").append( "AND A.APPDT='"+str[0]+"'																	");
					
					sql.append("\n").append( " ORDER BY C.SEQ, A.PAYSEQ DESC, B.STRTDT																				");

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