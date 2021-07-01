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
public class a090003_s1 extends HttpServlet {
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
				String  str2 = req.getParameter("v_str2");    //자산번호
				String  str3 = req.getParameter("v_str3");    //자산명
				String  str4 = req.getParameter("v_str4");    //자산중분류
				String  str5 = req.getParameter("v_str5");    //자산소분류
				String  str6 = req.getParameter("v_str6");    //규격
				String  str7 = req.getParameter("v_str7");    //소분류
				String  str8 = req.getParameter("v_str8");    //소분류

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				if (str7 == null) str7 = "";
				if (str8 == null) str8 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"ASNBR", "ASNAM", "ASAQSDAT","ASLIFYER", "ASTAQAMT", 
					"DSANGAMT", "JANAMT" ,"LASTYM", "ASTNUM", "CHGNO",
					 "CHGDATE", "CHGTYPE", "DECTYPE", "CHGWHAT", "CHGQTY",
						"CHGAMT", "CHGAMT2", "CHGAMT3", "RELFIRM" ,
					"FDCODE", "ATCODE", "AST1ST", "AST2ND", "AST3RD", "ASTSEQ"

						}; 

					
				int[] intArrCN = new int[]{11, 30, 8, 3, 13, 13, 13, 6, 11, 4,
														8, 1, 1, 30, 4,
					 13, 13, 13, 13 ,
					2, 7, 2, 2, 2, 5
					}; 
					
				int[] intArrCN2 = new int[]{-1, -1, -1, 0, 0, 0, 0, -1, -1, -1,
														-1, -1, -1, -1, 0,
				 0, 0, 0, -1,
					-1, -1, -1, -1, -1, -1
					}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT (CASE A.AST1ST WHEN '01' THEN 'S' WHEN '02' THEN 'S' \n");
					sql.append( " WHEN '03' THEN 'K' WHEN '04' THEN 'G' END|| \n");
					sql.append( " CASE A.AST2ND WHEN '11' THEN 'L'  WHEN '12' THEN 'B'  WHEN '13' THEN 'S' \n");
					sql.append( " WHEN '14' THEN 'V' WHEN '15' THEN 'I' WHEN '16' THEN 'F' WHEN '17' THEN 'E' \n");
					sql.append( " END||CASE A.AST3RD WHEN '01' THEN 'H' WHEN '02' THEN 'B' WHEN '03' THEN 'C' \n");
					sql.append( " WHEN '04' THEN 'O'  WHEN '05' THEN 'T' WHEN '06' THEN 'F' \n");
					sql.append( " WHEN '07' THEN 'E' WHEN '00' THEN '0' END||A.ASTSEQ) as ASNBR, \n");
					sql.append( " B.ASTNAME AS ASNAM, ASAQSDAT, \n");
					sql.append( " COALESCE(C.ASTYUSE,0) AS ASLIFYER, COALESCE(C.ASTAQAMT,0) AS ASTAQAMT, COALESCE(A.ACDEPRAMT,0) AS DSANGAMT, \n");
					sql.append( " (COALESCE(C.ASTAQAMT,0) - COALESCE(A.ABDEPRAMT,0) - COALESCE(A.ACDEPRAMT,0)) AS JANAMT, \n");
					sql.append( " COALESCE(SUBSTR(A.DEPRENDDT,1,6),'') AS LASTYM, \n");	    
					sql.append( " (A.AST1ST||A.AST2ND||A.AST3RD||A.ASTSEQ) AS ASTNUM, D.CHGNO, \n");
					sql.append( " D.CHGDATE, D.CHGTYPE, D.DECTYPE, D.CHGWHAT, COALESCE(D.CHGQTY, 0) CHGQTY, \n");
					sql.append( " COALESCE(D.CHGAMT,0) CHGAMT, COALESCE(D.CHGAMT2, 0) CHGAMT2, COALESCE(D.CHGAMT3, 0) CHGAMT3, D.RELFIRM, \n");
					sql.append( " B.FDCODE, B.ATCODE, B.AST1ST, B.AST2ND, B.AST3RD, B.ASTSEQ \n");
					sql.append( " FROM (ACCOUNT.ASTDEPR A LEFT OUTER JOIN ACCOUNT.ASTMST B ON  \n");
					sql.append( " A.FDCODE=B.FDCODE AND A.ATCODE=B.ATCODE AND A.AST1ST=B.AST1ST AND \n");
					sql.append( " A.AST2ND=B.AST2ND AND A.AST3RD=B.AST3RD AND A.ASTSEQ=B.ASTSEQ ) left outer join account.astbasic C on \n");
					sql.append( " A.FDCODE=C.FDCODE AND A.ATCODE=C.ATCODE AND A.AST1ST=C.AST1ST AND \n");
					sql.append( " A.AST2ND=C.AST2ND AND A.AST3RD=C.AST3RD AND A.ASTSEQ=C.ASTSEQ \n");
					sql.append( " LEFT OUTER JOIN ACCOUNT.ASTCHG D ON \n");
					sql.append( " A.FDCODE=D.FDCODE AND A.ATCODE=D.ATCODE AND A.AST1ST=D.AST1ST AND \n");
					sql.append( " A.AST2ND=D.AST2ND AND A.AST3RD=D.AST3RD AND A.ASTSEQ=D.ASTSEQ \n");
					sql.append( " WHERE A.AST2ND>'11' \n");
					if (!str1.equals("")) sql.append( " AND A.FDCODE = '" + str1 + "' \n" );
					if (!str2.equals("")) sql.append( " AND A.ASNBR = '" + str2 + "' \n" );
					if (!str3.equals("")) sql.append( " AND B.ASTNAME LIKE '" + str3 + "%' \n" );
					if (!str4.equals("")) sql.append( " AND B.AST2ND = '" + str4 + "' \n" );
					if (!str5.equals("")) sql.append( " AND B.AST3RD = '" + str5 + "' \n" );
					if (!str6.equals("")) sql.append( " AND B.AST3RD = '" + str6 + "' \n" );
					if (!str7.equals("")) sql.append( " AND B.AST3RD = '" + str7 + "' \n" );
					if (!str8.equals("")) sql.append( " AND D.CHGTYPE = '" + str8 + "' \n" );

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