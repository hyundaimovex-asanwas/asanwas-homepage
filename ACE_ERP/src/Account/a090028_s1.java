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
public class a090028_s1 extends HttpServlet {
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
				// 감가상각 조회 쿼리

				String  str1 = req.getParameter("v_str1");    //소속
				String  str2 = req.getParameter("v_str2");    //자산분류
				String  str3 = req.getParameter("v_str3");    //자산코드
				String  str4 = req.getParameter("v_str4");    //자산명
				String  str5 = req.getParameter("v_str5");    //상태
				String  str6 = req.getParameter("v_str6");    //원가코드

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"CHK",      "ASTAMT",
					                               "ASTNBR",   "ASNAM",     "ASAQSDAT",  "ASTYUSE",  "ASTAQAMT", 
					                               "ABDEPRAMT","ACDEPRAMT", "ACDEPRSUM", "ASTRMAMT" ,"LASTYM",
					                               "ASTNUM",   "CDNAM",     "COSTCD",    "COSTNM",   "ASTDEPRST", "DEPRENDDT",
					                               "FDCODE",   "ATCODE",    "AST1ST",    "AST2ND",   "AST3RD",    "ASTSEQ",  "ACOSTCD",
					                               "ASTAQAMTY","FOBDAMT",   "FOCDAMT",   "FORMAMT",  "FOATAMT"
				                                }; 

				int[] intArrCN = new int[]{ 1, 13,
					                         11, 30,  8,  3, 13, 
					                         13, 13, 13, 13,  6, 
					                         11, 30, 20, 40,  2, 8,
					                          2,  7,  2,  2,  2, 5, 6,
                                   13, 13, 13, 13, 13
				                           }; 
					
				int[] intArrCN2 = new int[]{-1,  0,
					                          -1, -1, -1,  0,  0,
					                           0,  0,  0,  0, -1, 
					                          -1, -1, -1, -1, -1, -1,
					                          -1, -1, -1, -1, -1, -1, -1,
					                           0,  0,  0,  0,  0 
				                            }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();

					/*	
					취득금액     ASTAQAMT               ASTAQAMTY
					전기누계액   ABDEPRAMT              FOBDAMT
					당기상각액   ACDEPRAMT              FOCDAMT
					잔존가액     ASTRMAMT               FORMAMT
					감가상각액   ASTAMT                 0 FOATAMT
					*/

					sql.append( "SELECT  'F' CHK, 0 ASTAMT, B.ASTNBR,                                                  \n");
					sql.append( "        B.ASTNAME AS ASNAM, ASAQSDAT,                                                 \n");
					sql.append( "        COALESCE(C.ASTYUSE,0) AS ASTYUSE,     COALESCE(C.ASTAQAMT,0) AS ASTAQAMT,     \n");
					sql.append( "        COALESCE(A.ABDEPRAMT,0) AS ABDEPRAMT, COALESCE(A.ACDEPRAMT,0) AS ACDEPRAMT,   \n");
					sql.append( "        COALESCE(A.ABDEPRAMT,0)+COALESCE(A.ACDEPRAMT,0) AS ACDEPRSUM,                 \n");
					sql.append( "        COALESCE(A.ASTRMAMT,0) AS ASTRMAMT,                                           \n");
					sql.append( "        COALESCE(SUBSTR(A.DEPRENDDT,1,6),'') AS LASTYM,                               \n");
					sql.append( "       (B.AST1ST||B.AST2ND||B.AST3RD||B.ASTSEQ) AS ASTNUM, TRIM(X.ASTNM) AS CDNAM,    \n");
					sql.append( "        C.COSTCD, TRIM(Y.CDNAM) AS COSTNM, A.ASTDEPRST,  A.DEPRENDDT,                 \n");
					sql.append( "        B.FDCODE,B.ATCODE, B.AST1ST, B.AST2ND, B.AST3RD, B.ASTSEQ ,''ACOSTCD,         \n");
					//외화
					sql.append( "        COALESCE(C.ASTAQAMTY,0) AS ASTAQAMTY, COALESCE(A.FOBDAMT,0) AS FOBDAMT,       \n");
					sql.append( "        COALESCE(A.FOCDAMT,0) AS FOCDAMT,     COALESCE(A.FORMAMT,0) AS FORMAMT,       \n");
					sql.append( "        0 FOATAMT                                                                     \n");
					sql.append( "  FROM ACCOUNT.ASTMSTN B                                                              \n");
					sql.append( "  LEFT JOIN ACCOUNT.ASTDEPR A ON A.FDCODE=B.FDCODE AND A.ATCODE=B.ATCODE              \n");
					sql.append( "                             AND A.AST1ST=B.AST1ST AND A.AST2ND=B.AST2ND              \n");
					sql.append( "                             AND A.AST3RD=B.AST3RD AND A.ASTSEQ=B.ASTSEQ              \n");
					sql.append( "  LEFT JOIN ACCOUNT.ASTBASICN C ON B.FDCODE=C.FDCODE AND B.ATCODE=C.ATCODE            \n");
					sql.append( "                               AND B.AST1ST=C.AST1ST AND B.AST2ND=C.AST2ND            \n");
					sql.append( "                               AND B.AST3RD=C.AST3RD AND B.ASTSEQ=C.ASTSEQ            \n");
					//자산명 변경
					//sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL X ON B.ASTNAME=X.CDCODE AND X.CMTYPE='2161'              \n");
					sql.append( "  LEFT JOIN ACCOUNT.ASTNAME X ON B.AST2ND=X.AST2ND AND B.AST3RD = X.AST3RD AND B.ASTNAME = X.ASTCD \n"); 
					sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL Y ON C.COSTCD=Y.CDCODE AND Y.CMTYPE='0030'               \n");
					sql.append( " WHERE B.AST2ND>'11' \n"); //토지 :: 토지의 경우 감가상각하지 않음.
					sql.append( "   AND C.REGIGB ='2' \n"); //이체등록건
					sql.append( "	  AND NOT EXISTS ( SELECT * FROM ACCOUNT.ASTCHG G                                                       \n"); 
					sql.append( "	 									  WHERE G.FDCODE = A.FDCODE                                                           \n"); 
					sql.append( "										  	AND G.ATCODE = A.ATCODE                                                           \n"); 
					sql.append( "												AND G.AST1ST = A.AST1ST                                                           \n"); 
					sql.append( "												AND G.AST2ND = A.AST2ND                                                           \n"); 
					sql.append( "												AND G.AST3RD = A.AST3RD                                                           \n"); 
					sql.append( "												AND G.ASTSEQ = A.ASTSEQ                                                           \n"); 
					sql.append( "												AND G.CHGTYPE IN ('1','2')    --매각/폐기 건                                      \n"); 
					sql.append( "												AND SUBSTR(G.CHGDATE,1,4) < (SELECT SUBSTR(MAX(ASTYM),1,4) FROM ACCOUNT.ASTYEPR)  \n"); 
					sql.append( "										)                                                                                     \n");			
					if (!str1.equals("")) sql.append( " AND B.FDCODE = '" + str1 + "' \n");
					if (!str2.equals("")) sql.append( " AND B.AST2ND = '" + str2 + "' \n");
					if (!str3.equals("")||!str4.equals("")) sql.append( " AND ( B.ASTNAME ='" + str3 + "' AND TRIM(X.ASTNM) LIKE '"+str4+ "%' ) \n");
					if (!str6.equals("")) sql.append( " AND C.COSTCD = '" + str6 + "' \n");
					if (str5.equals("1")){ //감가상각 미등록건
						sql.append( "	  AND NOT EXISTS ( SELECT * FROM ACCOUNT.ASTDEPR G  \n"); 
						sql.append( "	 									  WHERE G.FDCODE = A.FDCODE       \n"); 
						sql.append( "										  	AND G.ATCODE = A.ATCODE       \n"); 
						sql.append( "												AND G.AST1ST = A.AST1ST       \n"); 
						sql.append( "												AND G.AST2ND = A.AST2ND       \n"); 
						sql.append( "												AND G.AST3RD = A.AST3RD       \n"); 
						sql.append( "												AND G.ASTSEQ = A.ASTSEQ       \n"); 
						sql.append( "										)                                 \n");			
					}else{                 //감가상각 등록건
						sql.append( "	  AND EXISTS ( SELECT * FROM ACCOUNT.ASTDEPR G  \n"); 
						sql.append( "	 							  WHERE G.FDCODE = A.FDCODE       \n"); 
						sql.append( "								  	AND G.ATCODE = A.ATCODE       \n"); 
						sql.append( "										AND G.AST1ST = A.AST1ST       \n"); 
						sql.append( "										AND G.AST2ND = A.AST2ND       \n"); 
						sql.append( "										AND G.AST3RD = A.AST3RD       \n"); 
						sql.append( "										AND G.ASTSEQ = A.ASTSEQ       \n"); 
						sql.append( "								)                                 \n");			
				  }

					sql.append( " ORDER BY  B.ASTNBR \n");
					
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