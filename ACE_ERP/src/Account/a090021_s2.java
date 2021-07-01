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
public class a090021_s2 extends HttpServlet {
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

				String  str1	= req.getParameter("v_str1");    //자산번호

				if (str1 == null) str1 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
																	"FDCODE", 	 "ATCODE",    "AST1ST",   "AST2ND",	  "AST3RD",
																	"ASTNAME",	 "ASAQSDAT",  "FSDAT",    "FSNBR",    "FSSEQ",  "DEPTCD",
																	"EMPNO",     "ASTSEQ",    "ASTNAME2", "ASTNAME3", "TAXNBR", 
																	"SEQ",       
																	"ASTNBR",	"H_ASTNBR", "DEPTNM", "ASTNAMENM", "ASTNAMENM2",
																	"EMPNMK", "WRDT", "WRID", "UPDT", "UPID", "S_ASTNBR","MORDT"
																	}; 

				int[] intArrCN = new int[]{ 2,  7,   2,  2,  2,
					                         30,  8,   9,  6,  5,   4,
                                    7,  5,  30, 30, 11,
					                         20,      											
											              8,  8,  30, 30, 30, 
					                         30,  10,  7, 10,  7, 8, 8 }; 
					
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1,
					                           -1,
											               -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1, -1, -1, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();
/*
					sql.append( "SELECT A.FDCODE,  A.ATCODE,   A.AST1ST,    A.AST2ND,    A.AST3RD,                                         \n");
					sql.append( "       A.ASTNAME, A.ASAQSDAT, A.FSDAT,     A.FSNBR,     A.FSSEQ,   A.DEPTCD,                              \n");
					sql.append( "       A.EMPNO,   A.ASTSEQ,   A.ASTNAME2,  A.ASTNAME3,  A.TAXNBR,                                         \n");
					sql.append( "      (A.AST1ST || A.AST2ND || A.AST3RD || A.ASTSEQ) AS SEQ,                                              \n");
					sql.append( "       A.ASTNBR, A.H_ASTNBR, TRIM(B.DEPTNM)DEPTNM, TRIM(C.ASTNM) ASTNAMENM, TRIM(D.CDNAM) ASTNAMENM2,     \n");
					sql.append( "       E.EMPNMK, A.WRDT, A.WRID, A.UPDT, A.UPID , A.S_ASTNBR,A.MORDT                                             \n");
					sql.append( "  FROM ACCOUNT.ASTMSTN A                                                                                   \n");
					sql.append( "  LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD=B.DEPTCD AND B.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT )  \n");
					sql.append( "  LEFT JOIN ACCOUNT.ASTNAME C ON A.AST2ND=C.AST2ND AND A.AST3RD=C.AST3RD AND A.ASTNAME=C.ASTCD            \n");
					sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL D ON A.ASTNAME2=D.CDCODE AND D.CMTYPE='2162'                                 \n");
					sql.append( "  LEFT JOIN PAYROLL.YIPERSON E ON A.EMPNO=E.EMPNO                                                         \n");
					sql.append( " WHERE 1=1                                                                                                \n");
					if (!str1.equals(""))sql.append( " AND A.ASTNBR  = '"+str1+"'  \n");
*/
					sql.append( "SELECT A.FDCODE,  A.ATCODE,   A.AST1ST,    A.AST2ND,    A.AST3RD,                                      \n");
					sql.append( "       A.ASTNAME, A.ASAQSDAT, A.FSDAT,     A.FSNBR,     A.FSSEQ,   A.DEPTCD,                         \n");
					sql.append( "       A.EMPNO,   A.ASTSEQ,   A.ASTNAME2,  A.ASTNAME3,  A.TAXNBR,                                        \n");
					sql.append( "      (A.AST1ST || A.AST2ND || A.AST3RD || A.ASTSEQ) AS SEQ,                                              	\n");
					sql.append( "       A.ASTNBR, A.H_ASTNBR,      																							\n");
					sql.append( "       ASNHR.SF_GET_DPTNAME0('01','A6',A.DEPTCD ) DEPTNM,      												\n");
					sql.append( "       TRIM(C.ASTNM) ASTNAMENM, TRIM(D.CDNAM) ASTNAMENM2,     											\n");
					sql.append( "       ASNHR.SF_GET_ENONAME('01',A.EMPNO ) EMPNMK,                                              			\n");
					sql.append( "       A.WRDT, A.WRID, A.UPDT, A.UPID , A.S_ASTNBR,A.MORDT                                             		\n");
					sql.append( "  FROM ACCOUNT.ASTMSTN A                                                                                   				\n");
					sql.append( "  LEFT JOIN ACCOUNT.ASTNAME C ON A.AST2ND=C.AST2ND AND A.AST3RD=C.AST3RD AND A.ASTNAME=C.ASTCD            \n");
					sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL D ON A.ASTNAME2=D.CDCODE AND D.CMTYPE='2162'                	\n");
					sql.append( " WHERE 1=1                                                                                                							\n");
					if (!str1.equals(""))sql.append( " AND A.ASTNBR  = '"+str1+"'  																			\n");
					
					
					//System.out.println("# Query : \n" + sql);
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