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
public class a090004_s13 extends HttpServlet {
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

				String  str1	= req.getParameter("v_str1");    //기준년월

				if (str1 == null) str1 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
		          "FDNAME","FDCODE","AST2ND","JSGUBUN","ASTYUSE","JUNCAMT",
		          "DANGCAMT","JUNMALSAMT","JUNDANGSAMT","DANGSAMT","JANJONAMT"
		        };  

				int[] intArrCN = new int[]{ 
		          10,2, 2, 40, 3, 12,
		          12, 13, 13, 13, 13
		        }; 
					
				int[] intArrCN2 = new int[]{ 
		          -1,-1, -1, -1, 0, 0,
		          -1, 0, 0, 0, 0
		        }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();
					sql.append("\n SELECT D.FDNAME, A.FDCODE AS FDCODE,                                                                                     ");
					sql.append("\n        A.AST2ND AS AST2ND,                                                                                     ");
					sql.append("\n        Z.CDNAM AS JSGUBUN,                                                                                     ");
					sql.append("\n        A.ASTYUSE AS ASTYUSE,                                                                                   ");
					sql.append("\n        SUM(A.JUNCAMT) AS JUNCAMT,                                                                              ");
					sql.append("\n        SUM(A.DANGCAMT) AS DANGCAMT,                                                                            ");
					sql.append("\n        SUM(A.JUNMALSAMT) AS JUNMALSAMT,                                                                        ");
					sql.append("\n        SUM(A.JUNDANGSAMT) AS JUNDANGSAMT,                                                                      ");
					sql.append("\n        SUM(A.DANGSAMT) AS DANGSAMT,                                                                            ");
					sql.append("\n 			 SUM(A.JUNCAMT) + SUM(A.DANGCAMT) - SUM(A.JUNMALSAMT) - SUM(A.JUNDANGSAMT) - SUM(A.DANGSAMT) AS JANJONAMT ");
					sql.append("\n   FROM (                                                                                                       ");
					sql.append("\n SELECT A.FDCODE AS FDCODE,                                                                                     ");
					sql.append("\n        A.AST2ND AS AST2ND,                                                                                     ");
					sql.append("\n        B.ASTYUSE AS ASTYUSE,                                                                                   ");
					sql.append("\n        CASE SUBSTR(A.ASAQSDAT,1,4) WHEN SUBSTR('"+str1+"',1,4) THEN 0 ELSE B.ASTAQAMT END AS JUNCAMT,          ");
					sql.append("\n        CASE SUBSTR(A.ASAQSDAT,1,4) WHEN SUBSTR('"+str1+"',1,4) THEN B.ASTAQAMT ELSE 0 END AS DANGCAMT,         ");
					sql.append("\n        0 AS JUNMALSAMT,                                                                                        ");
					sql.append("\n        0 AS JUNDANGSAMT,                                                                                       ");
					sql.append("\n        0 AS DANGSAMT                                                                                           ");
					sql.append("\n   FROM ACCOUNT.ASTMST A,ACCOUNT.ASTBASIC B                                                                     ");
					sql.append("\n  WHERE A.FDCODE = B.FDCODE AND A.ATCODE = B.ATCODE AND A.AST1ST = B.AST1ST                                     ");
					sql.append("\n    AND A.AST2ND = B.AST2ND AND A.AST3RD = B.AST3RD AND A.ASTSEQ = B.ASTSEQ                                     ");
					sql.append("\n    AND A.ASAQSDAT <= '"+str1+"'                                                                                ");
					sql.append("\n UNION ALL                                                                                                      ");
					sql.append("\n SELECT A.FDCODE AS FDCODE,                                                                                     ");
					sql.append("\n        A.AST2ND AS AST2ND,                                                                                     ");
					sql.append("\n        B.ASTYUSE AS ASTYUSE,                                                                                   ");
					sql.append("\n        0 AS JUNCAMT,                                                                                           ");
					sql.append("\n        0 AS DANGCAMT,                                                                                          ");
					sql.append("\n        A.ABDEPRAMT + A.ACDEPRAMT AS JUNMALSAMT,                                                                ");
					sql.append("\n        0 AS JUNDANGSAMT,                                                                                       ");
					sql.append("\n        0 AS DANGSAMT                                                                                           ");
					sql.append("\n   FROM ACCOUNT.ASTDEPR A,ACCOUNT.ASTBASIC B                                                                    ");
					sql.append("\n  WHERE A.FDCODE = B.FDCODE AND A.ATCODE = B.ATCODE AND A.AST1ST = B.AST1ST                                     ");
					sql.append("\n    AND A.AST2ND = B.AST2ND AND A.AST3RD = B.AST3RD AND A.ASTSEQ = B.ASTSEQ                                     ");
					sql.append("\n    AND A.DEPRENDDT = TRIM(CHAR(INTEGER(SUBSTR('"+str1+"',1,4))-1))||'12'                                       ");
					sql.append("\n UNION ALL                                                                                                      ");
					sql.append("\n SELECT A.FDCODE AS FDCODE,                                                                                     ");
					sql.append("\n        A.AST2ND AS AST2ND,                                                                                     ");
					sql.append("\n        C.ASTYUSE AS ASTYUSE,                                                                                   ");
					sql.append("\n        0 AS JUNCAMT,                                                                                           ");
					sql.append("\n        0 AS DANGCAMT,                                                                                          ");
					sql.append("\n        0 AS JUNMALSAMT,                                                                                        ");
					sql.append("\n        A.ABDEPRAMT + A.ACDEPRAMT AS JUNDANGSAMT,                                                               ");
					sql.append("\n        0 AS DANGSAMT                                                                                           ");
					sql.append("\n   FROM ACCOUNT.ASTDEPR A,ACCOUNT.ASTMST B,ACCOUNT.ASTBASIC C                                                   ");
					sql.append("\n  WHERE A.FDCODE = B.FDCODE AND A.ATCODE = B.ATCODE AND A.AST1ST = B.AST1ST                                     ");
					sql.append("\n    AND A.AST2ND = B.AST2ND AND A.AST3RD = B.AST3RD AND A.ASTSEQ = B.ASTSEQ                                     ");
					sql.append("\n    AND A.FDCODE = C.FDCODE AND A.ATCODE = C.ATCODE AND A.AST1ST = C.AST1ST                                     ");
					sql.append("\n    AND A.AST2ND = C.AST2ND AND A.AST3RD = C.AST3RD AND A.ASTSEQ = C.ASTSEQ                                     ");
					sql.append("\n    AND B.ASAQSDAT <= TRIM(CHAR(INTEGER(SUBSTR('"+str1+"',1,4))-1))||'1231'                                     ");
					sql.append("\n    AND A.DEPRENDDT = SUBSTR('"+str1+"',1,4)                                                                    ");
					sql.append("\n UNION ALL                                                                                                      ");
					sql.append("\n SELECT A.FDCODE AS FDCODE,                                                                                     ");
					sql.append("\n        A.AST2ND AS AST2ND,                                                                                     ");
					sql.append("\n        C.ASTYUSE AS ASTYUSE,                                                                                   ");
					sql.append("\n        0 AS JUNCAMT,                                                                                           ");
					sql.append("\n        0 AS DANGCAMT,                                                                                          ");
					sql.append("\n        0 AS JUNMALSAMT,                                                                                        ");
					sql.append("\n        0 AS JUNDANGSAMT,                                                                                       ");
					sql.append("\n        nvl(A.ABDEPRAMT,0) + nvl(A.ACDEPRAMT,0) AS DANGSAMT                                                                   ");
					sql.append("\n   FROM ACCOUNT.ASTDEPR A, ACCOUNT.ASTMST B,ACCOUNT.ASTBASIC C                                                 ");
					sql.append("\n  WHERE A.FDCODE = B.FDCODE AND A.ATCODE = B.ATCODE AND A.AST1ST = B.AST1ST                                     ");
					sql.append("\n    AND A.AST2ND = B.AST2ND AND A.AST3RD = B.AST3RD AND A.ASTSEQ = B.ASTSEQ                                     ");
					sql.append("\n    AND A.FDCODE = C.FDCODE AND A.ATCODE = C.ATCODE AND A.AST1ST = C.AST1ST                                     ");
					sql.append("\n    AND A.AST2ND = C.AST2ND AND A.AST3RD = C.AST3RD AND A.ASTSEQ = C.ASTSEQ                                     ");
					sql.append("\n    AND B.ASAQSDAT LIKE SUBSTR('"+str1+"',1,4)||'%'                                                                  ");
					sql.append("\n    AND A.DEPRENDDT LIKE SUBSTR('"+str1+"',1,4)||'%') A,ACCOUNT.COMMDTIL Z,ACCOUNT.FIELDCODE D                                              ");
					sql.append("\n  WHERE A.AST2ND = Z.CDCODE                                                                                     ");
					sql.append("\n    AND Z.CMTYPE = '2101'                                              ");
					sql.append("\n    AND A.FDCODE = D.FDCODE                                                                                       ");
					sql.append("\n GROUP BY D.FDNAME,A.FDCODE,A.AST2ND,Z.CDNAM,A.ASTYUSE                                                                   ");
					
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