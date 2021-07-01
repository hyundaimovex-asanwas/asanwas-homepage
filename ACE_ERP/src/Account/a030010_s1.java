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
public class a030010_s1 extends HttpServlet {
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
				String  str2    = req.getParameter("v_str2");
				String  str3    = req.getParameter("v_str3");
				String  str4    = req.getParameter("v_str4");
				String  str5    = req.getParameter("v_str5");

				if(str1 == null) str1 = ""; //지점코드
				if(str2 == null) str2 = ""; //계산서기간 from
				if(str3 == null) str3 = ""; //계산서기간 to
				if(str4 == null) str4 = ""; //계산서기간 마지막월
				if(str5 == null) str5 = ""; //보정구분

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "PRTDIV", "ATCODE", "ATKORNAM", "SLPTOT", "SETTOT"	}; 

				int[] intArrCN = new int[]{ 1, 7, 66, 15, 15	}; 
			
				int[] intArrCN2 = new int[]{-1, -1, -1, 0, 0	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				}
				
				if (!GauceReq.isBuilderRequest()) {
					
					StringBuffer sql = new StringBuffer();
					
					sql.append( " SELECT '2' AS PRTDIV, SUBSTR(A.ATCODE,1,2)||'00000' AS ATCODE, D.ATKORNAM AS ATKORNAM, " );
					sql.append( "			SUM(CASE WHEN A.ATDECR='1' THEN nvl(B.DEBTOT,0)-nvl(B.CRETOT,0) ELSE nvl(B.CRETOT,0)-nvl(B.DEBTOT,0) END) AS SLPTOT, " );
					sql.append( "			SUM(CASE WHEN A.ATDECR='1' THEN nvl(C.DEBSET,0)-nvl(C.CRESET,0) ELSE nvl(C.CRESET,0)-nvl(C.DEBSET,0) END) AS SETTOT " );
					sql.append( " FROM(ACCOUNT.ACTCODE A LEFT JOIN " );
					sql.append( "	(SELECT A.ATCODE, " );
					sql.append( "			nvl(SUM(A.DETOT),0) AS DEBTOT, " );
					sql.append( "			nvl(SUM(A.CRTOT),0) AS CRETOT " );
					sql.append( "	FROM ACCOUNT.TSLIPTOT A " );
					sql.append( "	WHERE A.ACTDAT BETWEEN '"+str2+"' AND '"+str3+"' " );
					if(!str1.equals("")) sql.append( "	AND A.FDCODE = '"+str1+"'      " );				
					sql.append( "	GROUP BY A.ATCODE " );
					sql.append( "	) B ON A.ATCODE=B.ATCODE AND A.ATUSEYN='Y' LEFT JOIN " );
					sql.append( "		(SELECT A.ATCODE, " );
					sql.append( "			SUM(CASE WHEN A.ATDECR='1' THEN A.SETAMT ELSE 0 END) AS DEBSET, " );
					sql.append( "			SUM(CASE WHEN A.ATDECR='2' THEN A.SETAMT ELSE 0 END) AS CRESET " );
					sql.append( "		FROM ACCOUNT.SETTLEDTL A 					" );
					sql.append( "		WHERE A.SETYYMM='"+str4+"' 					" );
					if(str5.equals("N")) sql.append(" AND 'N'='Y' 						"); //보정미포함
					else sql.append(" AND 'Y'='Y' 											"); //보정포함
					sql.append( "		GROUP BY A.ATCODE " );
					sql.append( "	) C ON A.ATCODE=C.ATCODE AND A.ATUSEYN='Y' " );
					sql.append( "	INNER JOIN ACCOUNT.ACTCODE D ON SUBSTR(A.ATCODE,1,2)||'00000'=D.ATCODE " );
					sql.append( " ) " );
					sql.append( " WHERE A.ATDIV>'4' AND A.ATGRP>'3' " );
					sql.append( " GROUP BY SUBSTR(A.ATCODE,1,2)||'00000',D.ATKORNAM " );
					sql.append( " UNION ALL " );
					sql.append( " SELECT '4' AS PRTDIV, SUBSTR(A.ATCODE,1,5)||'00' AS ATCODE, SPACE(3)||D.ATKORNAM AS ATKORNAM, " );
					sql.append( "			SUM(CASE WHEN A.ATDECR='1' THEN nvl(B.DEBTOT,0)-nvl(B.CRETOT,0) ELSE nvl(B.CRETOT,0)-nvl(B.DEBTOT,0) END) AS SLPTOT, " );
					sql.append( "			SUM(CASE WHEN A.ATDECR='1' THEN nvl(C.DEBSET,0)-nvl(C.CRESET,0) ELSE nvl(C.CRESET,0)-nvl(C.DEBSET,0) END) AS SETTOT " );
					sql.append( " FROM(ACCOUNT.ACTCODE A LEFT JOIN " );
					sql.append( "	(SELECT A.ATCODE, " );
					sql.append( "			nvl(SUM(A.DETOT),0) AS DEBTOT, " );
					sql.append( "			nvl(SUM(A.CRTOT),0) AS CRETOT " );
					sql.append( "	FROM ACCOUNT.TSLIPTOT A " );
					sql.append( "	WHERE A.ACTDAT BETWEEN '"+str2+"' AND '"+str3+"' " );
					if(!str1.equals("")) sql.append( "	AND A.FDCODE = '"+str1+"'      " );
					sql.append( "	GROUP BY A.ATCODE " );
					sql.append( "	) B ON A.ATCODE=B.ATCODE AND A.ATUSEYN='Y' LEFT JOIN " );
					sql.append( "		(SELECT A.ATCODE, " );
					sql.append( "			SUM(CASE WHEN A.ATDECR='1' THEN A.SETAMT ELSE 0 END) AS DEBSET, " );
					sql.append( "			SUM(CASE WHEN A.ATDECR='2' THEN A.SETAMT ELSE 0 END) AS CRESET " );
					sql.append( "		FROM ACCOUNT.SETTLEDTL A " );
					sql.append( "		WHERE A.SETYYMM='"+str4+"' " );
					if(str5.equals("N")) sql.append(" AND 'N'='Y' "); //보정미포함
					else sql.append(" AND 'Y'='Y' "); //보정포함
					sql.append( "		GROUP BY A.ATCODE " );
					sql.append( "	) C ON A.ATCODE=C.ATCODE AND A.ATUSEYN='Y' " );
					sql.append( "	INNER JOIN ACCOUNT.ACTCODE D ON SUBSTR(A.ATCODE,1,5)||'00'=D.ATCODE " );
					sql.append( " ) " );
					sql.append( " WHERE A.ATDIV>'4' AND A.ATGRP>'4' " );
					sql.append( " GROUP BY SUBSTR(A.ATCODE,1,5)||'00',D.ATKORNAM " );
					sql.append( " ORDER BY ATCODE " );

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