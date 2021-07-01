package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class a010002_s6 extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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
				
				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ATCODE",	"ATKORNAM", "ARSEQ",	"CDCODE",	"CDNAM", "ARDEYN",	"ARCRYN",	"ARBALDIV",													 
																				  "ATUPCODE","ATDIV","ATDIVNM","ATGRP","ATGRPNM","ATPRTNAM","ATUSEYN", "ATDECRNM"}; 

				int[] intArrCN = new int[]{ 7, 66, 2, 4, 40, 6, 6, 6, 
					                          7,  1,40, 1, 40, 66, 1, 6 }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1, -1, -1,
                                     -1, -1, -1, -1, -1, -1, -1, -1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					
					sql.append( " SELECT A.ATCODE, A.ATKORNAM, B.ARSEQ,     B.CDCODE, C.CDNAM,              				\n");
					sql.append( "        CASE WHEN B.ARDEYN ='Y'   THEN '사용' ELSE  '미사용' END ARDEYN ,  					\n");
					sql.append( "        CASE WHEN B.ARCRYN ='Y'   THEN '사용' ELSE  '미사용' END ARCRYN ,  					\n");
					sql.append( "        CASE WHEN B.ARBALDIV ='Y' THEN '관리' ELSE  '미관리' END ARBALDIV, 					\n");
					sql.append( "        A.ATUPCODE, A.ATDIV, RTRIM(D.CDNAM) ATDIVNM, A.ATGRP,  								\n");
					sql.append( "        RTRIM(E.CDNAM) ATGRPNM, ATPRTNAM,A.ATUSEYN,  											\n");
					sql.append( "        CASE WHEN A.ATDECR ='1' THEN '차변' 																\n");
					sql.append( "             WHEN A.ATDECR ='2' THEN '대변' 																	\n");
					sql.append( "             ELSE  '' END ATDECRNM 																				\n");
					sql.append( " FROM ACCOUNT.ACTCODE A                                                   									\n");
					sql.append( " LEFT JOIN ACCOUNT.ACTREFCODE B ON A.ATCODE = B.ATCODE                    				\n");
					sql.append( " LEFT JOIN ACCOUNT.COMMDTIL C ON C.CDCODE = B.CDCODE AND C.CMTYPE='0050'  	\n");
					sql.append( " LEFT JOIN ACCOUNT.COMMDTIL D ON D.CDCODE = A.ATDIV AND D.CMTYPE='0033'   		\n");
					sql.append( " LEFT JOIN ACCOUNT.COMMDTIL E ON E.CDCODE = A.ATGRP AND E.CMTYPE='0034'   		\n");

					if (!str1.equals("")&&!str2.equals("")) {
						 sql.append( " WHERE A.ATCODE BETWEEN '" + str1 + "' AND '" + str2 + "'										\n");
					}

					sql.append( " ORDER BY A.ATCODE 		\n");
					//logger.dbg.println(this,sql.toString());
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
	} //public void
} //public class