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
public class a090006_down_s1 extends HttpServlet {
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

				String  str1	= req.getParameter("v_str1");    //지점코드     
				String  str2	= req.getParameter("v_str2");    //관리부서
				String  str3	= req.getParameter("v_str3");    //계정과목  
				String  str4	= req.getParameter("v_str4");    //자산중분류  
				String  str5	= req.getParameter("v_str5");    //자산소분류 
				String  str6	= req.getParameter("v_str6");    //취득일자  from
				String  str7	= req.getParameter("v_str7");    //취득일자  to    

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				if (str7 == null) str7 = "";
			
				GauceRes.enableFirstRow(dSet);


				String[] strArrCN = new String[]{  "AST1ST",   "AST2ND", "AST3RD",   "ASTSEQ", "ASTNAME",
												   "ASAQSDAT", "MNGDPT", "MNGDPTNM", "USEDPT", "USEDPTNM", 
					                               "MOVDT",    "AA"
													   }; 
 
				int[] intArrCN = new int[]{ 2, 2, 2,  5, 30,
			                   				8, 4, 50, 4, 50, 
					                        8, 1
					                          }; 
					
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
											 -1, -1, -1, -1, -1, 
					                         -1, -1//, -1
					                         }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();

				    sql.append( " SELECT					\n ");
					sql.append( " A.AST1ST,					\n ");
					sql.append( " A.AST2ND,					\n ");
					sql.append( " A.AST3RD,					\n ");
					sql.append( " A.ASTSEQ,					\n ");
					sql.append( " A.ASTNAME,				\n ");
					sql.append( " A.ASAQSDAT,				\n ");
					sql.append( " B.MNGDPT,					\n ");
					sql.append( " (SELECT RTRIM(DEPTNM) FROM PAYROLL.HCDEPT WHERE DEPTCD = B.MNGDPT) AS MNGDPTNM, \n ");
					sql.append( " B.USEDPT,					\n ");
					sql.append( " (SELECT RTRIM(DEPTNM) FROM PAYROLL.HCDEPT WHERE DEPTCD = B.USEDPT) AS USEDPTNM, \n ");
					sql.append( " CASE WHEN X.ASTMOVNO = '0000' THEN '' ELSE nvl(X.MOVDATE,'') END AS MOVDT,	  \n ");
					sql.append( " '' AS AA				\n ");
					sql.append( " FROM ACCOUNT.ASTMST A, ACCOUNT.ASTBASIC B, ACCOUNT.ASTMOVING X				  \n ");
					sql.append( " WHERE A.AST1ST = B.AST1ST 				\n ");  
					sql.append( " AND A.AST2ND = B.AST2ND					\n ");   
					sql.append( " AND A.AST3RD = B.AST3RD					\n ");   
					sql.append( " AND A.ASTSEQ = B.ASTSEQ					\n ");
					sql.append( " AND X.AST1ST = A.AST1ST					\n "); 	
					sql.append( " AND X.AST2ND = A.AST2ND					\n "); 
					sql.append( " AND X.AST3RD = A.AST3RD					\n "); 
					sql.append( " AND X.ASTSEQ = A.ASTSEQ					\n ");
					sql.append( " AND X.ASTMOVNO	= '0000'				\n "); 
					sql.append( " UNION						\n ");
					sql.append( " SELECT					\n ");                 
					sql.append( " C.AST1ST,					\n ");
					sql.append( " C.AST2ND,					\n ");
					sql.append( " C.AST3RD,					\n ");
					sql.append( " C.ASTSEQ,					\n ");
					sql.append( " C.ASTNAME,				\n ");
					sql.append( " C.ASAQSDAT,				\n ");
					sql.append( " CASE WHEN E.ASTMOVNO IS NULL OR E.ASTMOVNO = '' THEN D.MNGDPT ELSE E.AMNGDEPT END AS MNGDPT,	\n ");
					sql.append( " CASE WHEN E.ASTMOVNO IS NULL OR E.ASTMOVNO = '' THEN											\n ");
					sql.append( " 	 (SELECT RTRIM(DEPTNM) FROM PAYROLL.HCDEPT WHERE DEPTCD = D.MNGDPT)							\n "); 
					sql.append( " ELSE (SELECT RTRIM(DEPTNM) FROM PAYROLL.HCDEPT WHERE DEPTCD = E.AMNGDEPT) END AS MNGDPTNM,	\n ");
					sql.append( " CASE WHEN E.ASTMOVNO IS NULL OR E.ASTMOVNO = '' THEN D.USEDPT ELSE E.AUSEDEPT END AS USEDPT,	\n ");
					sql.append( " CASE WHEN E.ASTMOVNO IS NULL OR E.ASTMOVNO = '' THEN											\n ");
					sql.append( " 	 (SELECT RTRIM(DEPTNM) FROM PAYROLL.HCDEPT WHERE DEPTCD = D.USEDPT)							\n "); 
					sql.append( " ELSE (SELECT RTRIM(DEPTNM) FROM PAYROLL.HCDEPT WHERE DEPTCD = E.AUSEDEPT) END AS USEDPTNM,	\n ");
					sql.append( " nvl(E.MOVDATE,'') AS MOVDT,			\n ");
					sql.append( " '' AS AA				\n ");
					sql.append( " FROM ACCOUNT.ASTMST C, ACCOUNT.ASTBASIC D	\n ");
					sql.append( " LEFT OUTER JOIN ACCOUNT.ASTMOVING E ON E.AST1ST = C.AST1ST				\n "); 	
					sql.append( " 								   AND E.AST2ND = C.AST2ND					\n "); 
					sql.append( " 								   AND E.AST3RD = C.AST3RD					\n "); 
					sql.append( " 								   AND E.ASTSEQ = C.ASTSEQ					\n ");	
					sql.append( " 								   AND E.ASTMOVNO	<> '0000'				\n ");
					sql.append( " WHERE C.AST1ST = D.AST1ST					\n ");   
					sql.append( " AND C.AST2ND = D.AST2ND					\n ");   
					sql.append( " AND C.AST3RD = D.AST3RD					\n ");   
					sql.append( " AND C.ASTSEQ = D.ASTSEQ					\n ");
					if (!str1.equals(""))  sql.append( "  AND   C.FDCODE = '"+str1+"'  ");
					if (!str2.equals(""))  sql.append( "  AND   D.MNGDPT = '"+str2+"'   ");
					if (!str3.equals(""))  sql.append( "  AND   C.ATCODE = '"+str3+"'  ");
					if (!str4.equals(""))  sql.append( "  AND   C.AST2ND = '"+str4+"'  ");	
					if (!str5.equals(""))  sql.append( "  AND   C.AST3RD = '"+str5+"' ");
					if (!str6.equals(""))  sql.append( "  AND   C.ASAQSDAT BETWEEN  '"+str6+"' AND '"+str7+"' "); 
					sql.append( " ORDER BY AST1ST ASC, AST2ND ASC, AST3RD ASC, ASTSEQ ASC, MOVDT ASC    ");	
				
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