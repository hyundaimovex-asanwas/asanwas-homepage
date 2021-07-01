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
public class p030007_s5 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");
				String  str2	= req.getParameter("v_str2");

				if (str1==null) { str1 = ""; }
				if (str2==null) { str2 = ""; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO"		,"APPDT"		,"RELAT1"		,"FAMNM1"	,"RESINO1",
																					"RELATION"	,"INDNO"	,"INDNAME"	,
																					"CARDCNTA"	,"CARDAMTA", "CASHCNTA", "CASHAMTA",
																					"CARDCNTB"	,"CARDAMTB", "CASHCNTB", "CASHAMTB",
																					"ADDCA"    ,"EMPNMK"		
																				}; 

				int[] intArrCN = new int[]{  7,	 4,	1,  20,  13, 
																		 1,  11,	100,	  
																		 2, 9, 2, 9, 
																		 2, 9, 2, 9,
																		 70, 20
																	}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1,  -1, 
																			-1, -1, -1,
																		 0,  0,  0, 0, 
																		 0,  0,  0, 0, 
																		 -1, -1
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT																																											\n ");	
						sql.append( " RTRIM(A.EMPNO) AS EMPNO, RTRIM(A.APPDT) AS APPDT, RTRIM(A.RELAT1) AS RELAT1, RTRIM(A.FAMNM1) AS FAMNM1, RTRIM(A.RESINO1) AS RESINO1,	 \n ");
						sql.append( " RTRIM(A.RELATION) AS RELATION, RTRIM(A.INDNO) AS INDNO, RTRIM(A.INDNAME) AS INDNAME, 	\n ");
						sql.append( " COALESCE(A.CARDCNTA,0) AS CARDCNTA, COALESCE(A.CARDAMTA,0) AS CARDAMTA, COALESCE(A.CASHCNTA,0) AS CASHCNTA, COALESCE(A.CASHAMTA,0) AS CASHAMTA,	");
						sql.append( " COALESCE(A.CARDCNTB,0) AS CARDCNTB, COALESCE(A.CARDAMTB,0) AS CARDAMTB, COALESCE(A.CASHCNTB,0) AS CASHCNTB, COALESCE(A.CASHAMTB,0) AS CASHAMTB,	");
						sql.append( " RTRIM(B.CADDR01) || ' ' || RTRIM(B.CADDR02) AS ADDCA, B.EMPNMK						");
						sql.append( " FROM PAYROLL.YCPRSNY A																																			");
						sql.append( " LEFT JOIN PAYROLL.HIPERSON B ON A.EMPNO = B.EMPNO																						");
						sql.append( " WHERE RTRIM(A.APPDT) <> '' AND RTRIM(A.EMPNO) <> ''							");
						
						if (!str1.equals(""))	sql.append(" AND A.APPDT = '"+ str1 + "' ");
						if (!str2.equals(""))	sql.append(" AND B.EMPNMK LIKE '" + str2 + "%'");

						//logger.dbg.println( this, sql.toString() );

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