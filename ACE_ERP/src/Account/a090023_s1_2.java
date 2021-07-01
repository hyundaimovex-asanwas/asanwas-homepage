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
public class a090023_s1_2 extends HttpServlet {
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

				String  str1 = req.getParameter("v_str1");    //소속
				String  str2 = req.getParameter("v_str2");    //원가
				String  str3 = req.getParameter("v_str3");    //자산명
				String  str4 = req.getParameter("v_str4");    //자산명코드
				String  str5 = req.getParameter("v_str5");    //자산중분류
				String  str6 = req.getParameter("v_str6");    //자산소분류
				String  str7 = req.getParameter("v_str7");    //상태구분  0-정상,  1-매각, 2-폐기, 3-자본적지출

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				if (str7 == null) str7 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ASTNBR",     "ASNAM",     "ASAQSDAT", "ASLIFYER", "ASTAQAMT", 
																				  "ABDEPRAMT", "ACDEPRAMT", "ASTRMAMT", "LASTYM",   "ASTNUM",   
																					"FDCODE",    "ATCODE",    "AST1ST",   "AST2ND",   "AST3RD", "ASTSEQ",
					                                "MODIFYGB"
                            						}; 

					
				int[] intArrCN = new int[]{  11, 30,  8,  3, 13, 
					                           13, 13, 13,  6, 11,  
					                            2,  7,  2,  2,  2,  5,
					                            1
				                         	}; 
					
				int[] intArrCN2 = new int[]{ -1, -1, -1,  0,  0,
					                            0,  0,  0, -1, -1, 
					                           -1, -1, -1, -1, -1, -1,
					                           -1
					                        }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT A.ASTNBR, TRIM(E.ASTNM) AS ASNAM, A.ASAQSDAT,                                                   \n");
					sql.append( "        COALESCE(B.ASTYUSE,0) AS ASLIFYER, COALESCE(B.ASTAQAMT,0) AS ASTAQAMT,                          \n");
					sql.append( "        0 AS ABDEPRAMT, 0 AS ACDEPRAMT, 0 AS ASTRMAMT, ''LASTYM,                                        \n");
					sql.append( "        (A.AST1ST||A.AST2ND||A.AST3RD||A.ASTSEQ) AS ASTNUM,                                             \n");
					sql.append( "        A.FDCODE, A.ATCODE, A.AST1ST, A.AST2ND, A.AST3RD, A.ASTSEQ, 'N' AS MODIFYGB                     \n");
					sql.append( "   FROM ACCOUNT.ASTMSTN A, ACCOUNT.ASTBASICN B                                                          \n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTNAME E ON A.AST2ND=E.AST2ND AND A.AST3RD = E.AST3RD AND A.ASTNAME = E.ASTCD     \n");
					sql.append( "  WHERE A.FDCODE = B.FDCODE                                                                             \n");
					sql.append( "    AND A.ATCODE = B.ATCODE                                                                             \n");
					sql.append( "    AND A.AST1ST = B.AST1ST                                                                             \n");
					sql.append( "    AND A.AST2ND = B.AST2ND                                                                             \n");
					sql.append( "    AND A.AST3RD = B.AST3RD                                                                             \n");
					sql.append( "    AND A.ASTSEQ = B.ASTSEQ                                                                             \n");
					sql.append( "    AND A.AST2ND='11'                                                                 \n");
					if (!str1.equals("")) sql.append( " AND A.FDCODE = '" + str1 + "' \n" );
					if (!str2.equals("")) sql.append( " AND B.COSTCD = '" + str2 + "' \n" );
					if (!str3.equals("")||!str4.equals("")) sql.append( " AND ( A.ASTNAME ='" + str4 + "' AND TRIM(E.ASTNM) LIKE '"+str3+ "%' ) \n" );
					if (!str5.equals("")) sql.append( " AND A.AST2ND = '" + str5 + "' \n" );
					if (!str6.equals("")) sql.append( " AND A.AST3RD = '" + str6 + "' \n" );
					sql.append( "    AND NOT EXISTS ( SELECT * FROM ACCOUNT.ASTDEPR C                                                    \n");
					sql.append( "                      WHERE A.FDCODE=C.FDCODE AND A.ATCODE=C.ATCODE                                     \n");
					sql.append( "                        AND A.AST1ST=C.AST1ST AND A.AST2ND=C.AST2ND                                     \n");
					sql.append( "                        AND A.AST3RD=C.AST3RD AND A.ASTSEQ=C.ASTSEQ                                     \n");
					sql.append( "                    )                                                                                   \n");
					sql.append( "    AND  EXISTS (   SELECT * FROM ACCOUNT.ASTCHG D                                                      \n");
					sql.append( "                     WHERE A.FDCODE=D.FDCODE AND A.ATCODE=D.ATCODE                                      \n");
					sql.append( "                       AND A.AST1ST=D.AST1ST AND A.AST2ND=D.AST2ND                                      \n");
					sql.append( "                       AND A.AST3RD=D.AST3RD AND A.ASTSEQ=D.ASTSEQ                                      \n");
					if (str7.equals("0")) sql.append( " AND D.CHGTYPE NOT IN ('1','2','3') \n" );                                     //정상건
					else if(str7.equals("1")||str7.equals("2")||str7.equals("3"))sql.append( " AND D.CHGTYPE = '" + str7 + "' \n" );  
					sql.append( "                  )  \n");
					sql.append( "    AND ASTSTAT <> '8'                                                                                   \n");
					sql.append( "                                                                                                        \n");

					if(str7.equals("")||str7.equals("0")){
						sql.append( " UNION ALL                                                                                              \n");
						sql.append( "                                                                                                        \n");
						sql.append( " SELECT A.ASTNBR, TRIM(E.ASTNM) AS ASNAM, A.ASAQSDAT,                                                   \n");
						sql.append( "        COALESCE(B.ASTYUSE,0) AS ASLIFYER, COALESCE(B.ASTAQAMT,0) AS ASTAQAMT,                          \n");
						sql.append( "        0 AS ABDEPRAMT, 0 AS ACDEPRAMT, 0 AS ASTRMAMT, ''LASTYM,                                        \n");
						sql.append( "        (A.AST1ST||A.AST2ND||A.AST3RD||A.ASTSEQ) AS ASTNUM,                                             \n");
						sql.append( "        A.FDCODE, A.ATCODE, A.AST1ST, A.AST2ND, A.AST3RD, A.ASTSEQ, 'Y' AS MODIFYGB                     \n");
						sql.append( "   FROM ACCOUNT.ASTMSTN A, ACCOUNT.ASTBASICN B                                                          \n");
						sql.append( "   LEFT JOIN ACCOUNT.ASTNAME E ON A.AST2ND=E.AST2ND AND A.AST3RD = E.AST3RD AND A.ASTNAME = E.ASTCD     \n");
						sql.append( "  WHERE A.FDCODE = B.FDCODE                                                                             \n");
						sql.append( "    AND A.ATCODE = B.ATCODE                                                                             \n");
						sql.append( "    AND A.AST1ST = B.AST1ST                                                                             \n");
						sql.append( "    AND A.AST2ND = B.AST2ND                                                                             \n");
						sql.append( "    AND A.AST3RD = B.AST3RD                                                                             \n");
						sql.append( "    AND A.ASTSEQ = B.ASTSEQ                                                                             \n");
						sql.append( "    AND A.AST2ND='11'                                                                 \n");
						if (!str1.equals("")) sql.append( " AND A.FDCODE = '" + str1 + "' \n" );
						if (!str2.equals("")) sql.append( " AND C.COSTCD = '" + str2 + "' \n" );
						if (!str3.equals("")||!str4.equals("")) sql.append( " AND ( B.ASTNAME ='" + str4 + "' AND TRIM(E.ASTNM) LIKE '"+str3+ "%' ) \n" );
						if (!str5.equals("")) sql.append( " AND B.AST2ND = '" + str5 + "' \n" );
						if (!str6.equals("")) sql.append( " AND B.AST3RD = '" + str6 + "' \n" );
						sql.append( "    AND NOT EXISTS ( SELECT * FROM ACCOUNT.ASTDEPR C                                                    \n");
						sql.append( "                      WHERE A.FDCODE=C.FDCODE AND A.ATCODE=C.ATCODE                                     \n");
						sql.append( "                        AND A.AST1ST=C.AST1ST AND A.AST2ND=C.AST2ND                                     \n");
						sql.append( "                        AND A.AST3RD=C.AST3RD AND A.ASTSEQ=C.ASTSEQ                                     \n");
						sql.append( "                    )                                                                                   \n");
						sql.append( "    AND NOT EXISTS ( SELECT * FROM ACCOUNT.ASTCHG D                                                         \n");
						sql.append( "                  WHERE A.FDCODE=D.FDCODE AND A.ATCODE=D.ATCODE                                         \n");
						sql.append( "                    AND A.AST1ST=D.AST1ST AND A.AST2ND=D.AST2ND                                         \n");
						sql.append( "                    AND A.AST3RD=D.AST3RD AND A.ASTSEQ=D.ASTSEQ                                         \n");
						sql.append( "                )                                                                                       \n");
						sql.append( "    AND ASTSTAT <> '8'                                                                                  \n");
					}
				
						sql.append( "  ORDER BY ASAQSDAT, ASTNBR \n");
		
						
						// logger.dbg.println( this, sql.toString() );
						
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