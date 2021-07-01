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
public class a090021_s3 extends HttpServlet {
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

				String[] strArrCN = new String[]{ "FDCODE",   "ATCODE",   "AST1ST",    "AST2ND",   "AST3RD",  
																					"ASTSEQ",   "ASTSTAT",  "MNGTYPE",   "ASCOSDIV", "COSTCD",  
																					"GODDIV",   "ASTCLASS", "ASTRIS",    "ASTUNIT",  "ASTSTD",  
																					"ASTAQAMT", "ASTYUSE",  "ASTVALYMD", "MNGDPT",   "USEDPT",  
																					"USELOC",   "BUYFROM",  "MAKER",     "ASAQSDIV", "ASTNOTE", 
																					"ASTQTY",   "VEND_NM",  "MNGDPTNM",  "USEDPTNM", "MAKERNM", 
																					"COSTNM",   "ASTUSER",  "ASTUSERNM", "ASTAQAMTY",
					                                "WRDT",     "WRID",     "UPDT",      "UPID" ,    "REGIGB",  "DEPRGB", "MORDT"
				};

      
				int[] intArrCN = new int[]{ 2,  7,  2,  2,   2,
					                          5,  1,  1,  1,   6,
					                          1,  1,  1, 10,  30,
				                           13,  5,  8,  4,   4,
					                         30, 13, 30,  1,  50,
					                         10, 40, 40, 40,  40,
					                         40, 20, 20, 10,
					                          8,  7,  8,  7,   1,  1, 8
				};
									
					
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1,
					                            0,  2, -1, -1, -1,
					                           -1, -1, -1, -1, -1,
					                            0, -1, -1, -1, -1,
                                     -1, -1, -1,  4,
					                           -1, -1, -1, -1, -1, -1,-1 
			 };
														

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	


					StringBuffer sql = new StringBuffer();
				/*						
					sql.append( " SELECT A.FDCODE,   A.ATCODE,   A.AST1ST,  A.AST2ND,   A.AST3RD,                                             \n"); 
					sql.append( " 	     A.ASTSEQ,   A.ASTSTAT,  A.MNGTYPE, A.ASCOSDIV, A.COSTCD,                                             \n"); 
					sql.append( " 	     A.GODDIV,   A.ASTCLASS, A.ASTRIS,  A.ASTUNIT,  A.ASTSTD,                                             \n"); 
					sql.append( " 	     nvl(A.ASTAQAMT,0) ASTAQAMT,  nvl(A.ASTYUSE,0) ASTYUSE,                                         \n"); 
					sql.append( " 	     A.ASTVALYMD,A.MNGDPT,   A.USEDPT,  A.USELOC,   A.BUYFROM,                                            \n"); 
					sql.append( " 	     A.MAKER,    A.ASAQSDIV, A.ASTNOTE, nvl(A.ASTQTY,0) ASTQTY,                                        \n"); 
					sql.append( " 	     TRIM(B.VEND_NM)VEND_NM, TRIM(C.DEPTNM)MNGDPTNM,TRIM(D.DEPTNM)USEDPTNM,                               \n"); 
					sql.append( " 	     TRIM(E.CDNAM)MAKERNM, TRIM(F.CDNAM)COSTNM, A.ASTUSER, TRIM(G.EMPNMK) ASTUSERNM,                      \n"); 
					sql.append( " 	     COALESCE(A.ASTAQAMTY,0) ASTAQAMTY, A.WRDT,A.WRID,A.UPDT,A.UPID, A.REGIGB, A.DEPRGB, X.MORDT                   \n"); 
					sql.append( "   FROM ACCOUNT.ASTBASICN A , ACCOUNT.ASTMSTN X                                                                \n"); 
					sql.append( "   LEFT JOIN ACCOUNT.GCZM_VENDER B ON B.VEND_CD = A.BUYFROM                                                  \n"); 
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT C ON A.MNGDPT = C.DEPTCD AND C.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)   \n"); 
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT D ON A.USEDPT = D.DEPTCD AND D.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)   \n"); 
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL E ON A.MAKER=E.CDCODE AND E.CMTYPE='2163'                                      \n"); 
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL F ON A.COSTCD=F.CDCODE AND F.CMTYPE='0030'                                     \n"); 
					sql.append( "   LEFT JOIN PAYROLL.CIPERSON G ON A.ASTUSER=G.EMPNO                                                         \n"); 
					sql.append( "  WHERE A.FDCODE = X.FDCODE                                                                                  \n"); 
					sql.append( "    AND A.AST1ST = X.AST1ST                                                                                  \n"); 
					sql.append( "    AND A.AST2ND = X.AST2ND                                                                                  \n"); 
					sql.append( "    AND A.AST3RD = X.AST3RD                                                                                  \n"); 
					sql.append( "    AND A.ATCODE = X.ATCODE                                                                                  \n"); 
					sql.append( "    AND A.ASTSEQ = X.ASTSEQ                                                                                  \n"); 
					if (!str1.equals("")) sql.append( "  AND X.ASTNBR ='"+str1+"'   \n"); 
				 */
					
					sql.append( " SELECT A.FDCODE,   A.ATCODE,   A.AST1ST,  A.AST2ND,   A.AST3RD,                           \n"); 
					sql.append( " 	     A.ASTSEQ,   A.ASTSTAT,  A.MNGTYPE, A.ASCOSDIV, A.COSTCD,                             \n"); 
					sql.append( " 	     A.GODDIV,   A.ASTCLASS, A.ASTRIS,  A.ASTUNIT,  A.ASTSTD,                                  \n"); 
					sql.append( " 	     nvl(A.ASTAQAMT,0) ASTAQAMT,  nvl(A.ASTYUSE,0) ASTYUSE,                                 \n"); 
					sql.append( " 	     A.ASTVALYMD,A.MNGDPT,   A.USEDPT,  A.USELOC,   A.BUYFROM,                          \n"); 
					sql.append( " 	     A.MAKER,    A.ASAQSDIV, A.ASTNOTE, nvl(A.ASTQTY,0) ASTQTY,                             \n"); 
					sql.append( " 	     TRIM(B.VEND_NM)VEND_NM,                               													\n"); 
					sql.append( " 	     ASNHR.SF_GET_DPTNAME0('01','A6',A.MNGDPT )  MNGDPTNM,                               	\n"); 
					sql.append( " 	     ASNHR.SF_GET_DPTNAME0('01','A6',A.USEDPT )  USEDPTNM,                               	\n"); 
					sql.append( " 	     TRIM(E.CDNAM)MAKERNM, TRIM(F.CDNAM)COSTNM, A.ASTUSER,                       		\n"); 
					sql.append( " 	     ASNHR.SF_GET_ENONAME('01',A.ASTUSER ) ASTUSERNM,                      				\n"); 
					sql.append( " 	     COALESCE(A.ASTAQAMTY,0) ASTAQAMTY, A.WRDT,A.WRID,A.UPDT,A.UPID, A.REGIGB, A.DEPRGB, X.MORDT                   \n"); 
					sql.append( "   FROM ACCOUNT.ASTBASICN A                                                              							\n"); 
					sql.append( "   LEFT JOIN ACCOUNT.ASTMSTN X ON A.FDCODE = X.FDCODE                                               \n"); 
					sql.append( "   		AND A.AST1ST = X.AST1ST AND A.AST2ND = X.AST2ND  AND A.AST3RD = X.AST3RD        \n");					
					sql.append( "   		AND A.ATCODE = X.ATCODE AND A.ASTSEQ = X.ASTSEQ                                            \n");					
					sql.append( "   LEFT JOIN ACCOUNT.GCZM_VENDER B ON B.VEND_CD = A.BUYFROM                                   \n"); 
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL E ON A.MAKER=E.CDCODE AND E.CMTYPE='2163'                 \n"); 
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL F ON A.COSTCD=F.CDCODE AND F.CMTYPE='0030'               \n"); 
					sql.append( "  WHERE 1 = 1                                                                                  \n"); 
					if (!str1.equals("")) sql.append( "  AND X.ASTNBR ='"+str1+"'   \n"); 
					
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