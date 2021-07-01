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
public class a090026_s5 extends HttpServlet {
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

				String[] strArrCN = new String[]{  "FDCODE",	 "FDNAME",  "BUSEDPT",	"BUSEDPTNM",
					                                 		"AFDCODE",  "AFDNAME", "AUSEDPT",  "AUSEDPTNM"
				                                }; 

				int[] intArrCN = new int[]{ 2, 20, 4, 100, 
					                          		2, 20, 4, 100
				                           }; 
					
				int[] intArrCN2 = new int[]{-1, -1, -1, -1,
					                          		-1, -1, -1, -1
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
					sql.append( " SELECT A.FDCODE,  TRIM(F.FDNAME) AS FDNAME,   A.BUSEDPT, TRIM(B.DEPTNM) AS BUSEDPTNM,                      \n");
					sql.append( "        A.AFDCODE, TRIM(G.FDNAME) AS AFDNAME,  A.AUSEDPT, TRIM(C.DEPTNM) AS AUSEDPTNM                       \n");
					sql.append( "   FROM ACCOUNT.ASTMOVINGN A, ACCOUNT.ASTMSTN D                                                             \n");
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT B ON A.BUSEDPT=B.DEPTCD AND B.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)   \n");
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT C ON A.AUSEDPT=C.DEPTCD AND C.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)   \n");
					sql.append( "   LEFT JOIN ACCOUNT.FIELDCODE F ON A.FDCODE=F.FDCODE                                                       \n");
					sql.append( "   LEFT JOIN ACCOUNT.FIELDCODE G ON A.AFDCODE=G.FDCODE                                                      \n");
					sql.append( "  WHERE A.ASTGUBUN IN ('8','9')                                                                             \n");
					sql.append( "    AND A.FDCODE = D.FDCODE                                                                                 \n");
					sql.append( "    AND A.AST1ST = D.AST1ST                                                                                 \n");
					sql.append( "    AND A.AST2ND = D.AST2ND                                                                                 \n");
					sql.append( "    AND A.AST3RD = D.AST3RD                                                                                 \n");
					sql.append( "    AND A.ASTSEQ = D.ASTSEQ                                                                                 \n");
					sql.append( "    AND A.ASTMOVNO = ( SELECT MAX(ASTMOVNO) FROM ACCOUNT.ASTMOVINGN E                                       \n");
					sql.append( "                        WHERE A.FDCODE = E.FDCODE                                                           \n");
					sql.append( "                          AND A.ATCODE = E.ATCODE                                                           \n");
					sql.append( "                          AND A.AST1ST = E.AST1ST                                                           \n");
					sql.append( "                          AND A.AST2ND = E.AST2ND                                                           \n");
					sql.append( "                          AND A.AST3RD = E.AST3RD                                                           \n");
					sql.append( "                          AND A.ASTSEQ = E.ASTSEQ                                                           \n");
					sql.append( "                     )                                                                                      \n");
					if (!str1.equals(""))sql.append( "  AND  D.ASTNBR = '"+str1+"'   \n");		 //자산번호  
				*/
					
					sql.append( " SELECT A.FDCODE,  TRIM(F.FDNAME) AS FDNAME,   A.BUSEDPT,       					\n");
					sql.append( " 		ASNHR.SF_GET_DPTNAME0('01','A6',A.BUSEDPT ) AS BUSEDPTNM,            		\n");
					sql.append( "        A.AFDCODE, TRIM(G.FDNAME) AS AFDNAME, A.AUSEDPT,                        		\n");
					sql.append( "       ASNHR.SF_GET_DPTNAME0('01','A6',A.AUSEDPT ) AS AUSEDPTNM                  \n");
					sql.append( "   FROM ACCOUNT.ASTMOVINGN A                                                             			\n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTMSTN D ON A.FDCODE = D.FDCODE   							\n");
					sql.append( "    									AND A.AST1ST = D.AST1ST                                           \n");
					sql.append( "    									AND A.AST2ND = D.AST2ND                                          \n");
					sql.append( "    									AND A.AST3RD = D.AST3RD                                          \n");
					sql.append( "    									AND A.ASTSEQ = D.ASTSEQ                                         \n");
					sql.append( "   LEFT JOIN ACCOUNT.FIELDCODE F ON A.FDCODE=F.FDCODE                                \n");
					sql.append( "   LEFT JOIN ACCOUNT.FIELDCODE G ON A.AFDCODE=G.FDCODE                             \n");
					sql.append( "  WHERE A.ASTGUBUN IN ('8','9')                                                                         \n");
					sql.append( "    AND A.ASTMOVNO = ( SELECT MAX(ASTMOVNO) FROM ACCOUNT.ASTMOVINGN E  \n");
					sql.append( "                        WHERE A.FDCODE = E.FDCODE                                                   \n");
					sql.append( "                          AND A.ATCODE = E.ATCODE                                                       \n");
					sql.append( "                          AND A.AST1ST = E.AST1ST                                                          \n");
					sql.append( "                          AND A.AST2ND = E.AST2ND                                                          \n");
					sql.append( "                          AND A.AST3RD = E.AST3RD                                                          \n");
					sql.append( "                          AND A.ASTSEQ = E.ASTSEQ                                                       	\n");
					sql.append( "                     )                                                                                      				\n");
					if (!str1.equals(""))sql.append( "  AND  D.ASTNBR = '"+str1+"'   														\n");		 //자산번호  
					
					System.out.println("# Query : \n" + sql);
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