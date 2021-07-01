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
public class a090026_s2 extends HttpServlet {
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
				// 자산 이체 및 이동

				String  str1 = req.getParameter("v_str1");    //자산번호    

				if (str1 == null) str1 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "FDCODE",	"ATCODE",	  "AST1ST",	  "AST2ND",	  "AST3RD",	
                                           "ASTSEQ",	"ASTMOVNO",	"MOVDATE",	"ASTGUBUN",	"AMNGDPT",	
                                           "AUSEDPT",	"ACOSTCD",	"AUSER",	  "BMNGDPT",	"BUSEDPT",	
                                           "BCOSTCD",	"BUSER",	  "MOVNOTE",  "ASTNBR",   "ASTNAME",
                                           "ASTNM",   "AMNGDPTNM","AUSEDPTNM","ACOSTNM",  "AUSERNM",
                                           "BMNGDPTNM","BUSEDPTNM","BCOSTNM", "BUSERNM",  "ASTSTAT", "AFDCODE"
				                                }; 

				int[] intArrCN = new int[]{ 2, 7, 2, 2, 2,
					                          5, 4, 8, 1, 4,
				                            4, 6,10, 4, 4,
					                          6,10,30, 8,30,
					                         60,50,50,40,20,
					                         50,50,40,20, 1, 2
				                           }; 
					
				int[] intArrCN2 = new int[]{-1, -1, -1, -1, -1,
					                          -1, -1, -1, -1, -1,
					                          -1, -1, -1, -1, -1,
                                    -1, -1, -1, -1, -1, 
					                          -1, -1, -1, -1, -1, 
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
/*
					sql.append( " SELECT A.FDCODE,   A.ATCODE,   A.AST1ST,   A.AST2ND,   A.AST3RD,                                          \n");
					sql.append( "        A.ASTSEQ,   A.ASTMOVNO, A.MOVDATE,  A.ASTGUBUN, A.AMNGDPT,                                         \n");
					sql.append( "        A.AUSEDPT,  A.ACOSTCD,  A.AUSER,    A.BMNGDPT,  A.BUSEDPT,                                         \n");
					sql.append( "        A.BCOSTCD,  A.BUSER,    A.MOVNOTE,  B.ASTNBR,   B.ASTNAME,                                         \n");
					sql.append( "        TRIM(X.ASTNM) AS ASTNM,                                                                            \n");
					sql.append( "        TRIM(C.DEPTNM) AS AMNGDPTNM,TRIM(D.DEPTNM) AS AUSEDPTNM,                                           \n");
					sql.append( "        TRIM(Y.CDNAM) AS ACOSTNM,  Z.EMPNMK AS AUSERNM,                                                    \n");
					sql.append( "        TRIM(E.DEPTNM) AS BMNGDPTNM,TRIM(F.DEPTNM) AS BUSEDPTNM,                                           \n");
					sql.append( "        TRIM(G.CDNAM) AS BCOSTNM,  H.EMPNMK AS BUSERNM, K.ASTSTAT, AFDCODE                                 \n");
					sql.append( "   FROM ACCOUNT.ASTMOVINGN A                                                                               \n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTMSTN B ON A.FDCODE = B.FDCODE                                                      \n");
					sql.append( "                              AND A.AST1ST = B.AST1ST                                                      \n");
					sql.append( "                              AND A.AST2ND = B.AST2ND                                                      \n");
					sql.append( "                              AND A.AST3RD = B.AST3RD                                                      \n");
					sql.append( "                              AND A.ASTSEQ = B.ASTSEQ                                                      \n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTBASICN K ON A.FDCODE = K.FDCODE                                                    \n");
					sql.append( "                                AND A.AST1ST = K.AST1ST                                                    \n");
					sql.append( "                                AND A.AST2ND = K.AST2ND                                                    \n");
					sql.append( "                                AND A.AST3RD = K.AST3RD                                                    \n");
					sql.append( "                                AND A.ASTSEQ = K.ASTSEQ                                                    \n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTNAME X ON B.AST2ND=X.AST2ND AND B.AST3RD = X.AST3RD AND B.ASTNAME = X.ASTCD        \n");
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT  C ON A.AMNGDPT=C.DEPTCD AND C.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) \n");
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT  D ON A.AUSEDPT=D.DEPTCD AND D.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) \n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL Y ON A.ACOSTCD=Y.CDCODE AND Y.CMTYPE='0030'                                  \n");
					sql.append( "   LEFT JOIN PAYROLL.YIPERSON Z ON A.AUSER = Z.EMPNO AND Z.USESTS IN ('1','2','3')                         \n");
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT  E ON A.BMNGDPT=E.DEPTCD AND E.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) \n");
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT  F ON A.BUSEDPT=F.DEPTCD AND F.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) \n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL G ON A.BCOSTCD=G.CDCODE AND G.CMTYPE='0030'                                  \n");
					sql.append( "   LEFT JOIN PAYROLL.YIPERSON H ON A.BUSER = H.EMPNO AND H.USESTS IN ('1','2','3')                         \n");
					sql.append( "  WHERE 1=1                                                                                                \n");
					if (!str1.equals(""))sql.append( "  AND  B.ASTNBR = '"+str1+"'    \n");		 //자산번호  
					sql.append( "  ORDER BY B.ASTNBR, A.ASTMOVNO                      \n");
*/					
					
					sql.append( " SELECT A.FDCODE,   A.ATCODE,   A.AST1ST,   A.AST2ND,   A.AST3RD,                                          \n");
					sql.append( "        A.ASTSEQ,   A.ASTMOVNO, A.MOVDATE,  A.ASTGUBUN, A.AMNGDPT,                                     \n");
					sql.append( "        A.AUSEDPT,  A.ACOSTCD,  A.AUSER,    A.BMNGDPT,  A.BUSEDPT,                                         \n");
					sql.append( "        A.BCOSTCD,  A.BUSER,    A.MOVNOTE,  B.ASTNBR,   B.ASTNAME,                                         	\n");
					sql.append( "        TRIM(X.ASTNM) AS ASTNM,                                                                            						\n");
					sql.append( "        ASNHR.SF_GET_DPTNAME0('01','A6',A.AMNGDPT ) AS AMNGDPTNM,                                           \n");
					sql.append( "        ASNHR.SF_GET_DPTNAME0('01','A6',A.AUSEDPT ) AS AUSEDPTNM,                                           \n");
					sql.append( "        TRIM(Y.CDNAM) AS ACOSTNM,                                                      										\n");
					sql.append( "        ASNHR.SF_GET_ENONAME('01',A.AUSER )  AS AUSERNM,                                                    \n");

					sql.append( "        ASNHR.SF_GET_DPTNAME0('01','A6',A.BMNGDPT ) AS BMNGDPTNM,                                           \n");
					sql.append( "        ASNHR.SF_GET_DPTNAME0('01','A6',A.BUSEDPT ) AS BUSEDPTNM,                                           \n");

					
					sql.append( "        TRIM(G.CDNAM) AS BCOSTNM,                                  									\n");
					sql.append( "        ASNHR.SF_GET_ENONAME('01',A.BUSER ) AS BUSERNM,                               \n");
					sql.append( "        K.ASTSTAT, A.AFDCODE                                 												\n");

					
					sql.append( "   FROM ACCOUNT.ASTMOVINGN A                                                                               \n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTMSTN B ON A.FDCODE = B.FDCODE                                                      \n");
					sql.append( "                              AND A.AST1ST = B.AST1ST                                                      \n");
					sql.append( "                              AND A.AST2ND = B.AST2ND                                                      \n");
					sql.append( "                              AND A.AST3RD = B.AST3RD                                                      \n");
					sql.append( "                              AND A.ASTSEQ = B.ASTSEQ                                                      \n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTBASICN K ON A.FDCODE = K.FDCODE                                                    \n");
					sql.append( "                                AND A.AST1ST = K.AST1ST                                                    \n");
					sql.append( "                                AND A.AST2ND = K.AST2ND                                                    \n");
					sql.append( "                                AND A.AST3RD = K.AST3RD                                                    \n");
					sql.append( "                                AND A.ASTSEQ = K.ASTSEQ                                                    \n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTNAME X ON B.AST2ND=X.AST2ND AND B.AST3RD = X.AST3RD AND B.ASTNAME = X.ASTCD        \n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL Y ON A.ACOSTCD=Y.CDCODE AND Y.CMTYPE='0030'                                  \n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL G ON A.BCOSTCD=G.CDCODE AND G.CMTYPE='0030'                                  \n");

					
					sql.append( "  WHERE 1=1                                                                                                \n");
					if (!str1.equals(""))sql.append( "  AND  B.ASTNBR = '"+str1+"'    \n");		 //자산번호  
					sql.append( "  ORDER BY B.ASTNBR, A.ASTMOVNO                      \n");

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