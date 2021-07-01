package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class h080005_s1 extends HttpServlet {

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
				String str1	= req.getParameter("v_str1");		//부서코드

				if (str1 == null) str1 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO","REGDIV","EMPNMK","CARRDIV","RECDIV",         
                                          "EMPDIV","FRDT","TODT","PAYDIV","RESINO",             
                                          "PICTURE","GRSTRTDT","STRTDT","DEPTCD","PAYGRD",
                                          "JOBGRPH","JOBDTY","GRDDIV","PAYSEQ","FSAMDT",
                                          "ENDDT","USESTS","COSTDIV","DPOFFDT","LAMDT",
                                          "LRMDT","BIRDT","GLDIV","HOBBY","NMC",
                                          "RILIGN","NME","BIRCITY","SPECIAL","OZIPCD",
                                          "OADDR01","OADDR02","CZIPCD","CADDR01","CADDR02",
                                          "TELNO","HPNO","OFFTELNO","EMAIL","HDFAMNM",
                                          "HDFAMRET","HDFAMJOB","LABUNIYN","RELESAMT","MOVESAMT",
                                          "MRTDIV","MRTNO","REFCD","PAYBNKCD","PAYACNT",
                                          "HOUSDIV","MRYDT","ENGLVL","TOESCR","JPTSCR",
                                          "DELFSCR","TOFSCR","DALFSCR","TEPSSCR","ETCLNG",
                                          "HWGRDCD","EXGRDCD","PWGRDCD","ACGRDCD","DEPTNM",
																					"PAYGNM","GRDDNM","TREECD","LEVEL","JOBNM"
																				};

				int[] intArrCN = new int[]{    7,  4, 20,  1,  4,          
                                       4,  8,  8,  4, 13,          
                                      30,  8,  8,  4,  4,          
                                       4,  4,  4,  4,  8,           
                                       8,  4,  4,  8,  8,           
                                       8,  8,  1, 40, 20,         
                                       4, 40,  4, 40,  6,         
                                      70, 70,  6, 70, 70,       
                                      15, 15,  4, 30, 14,       
                                       4, 30,  1,  5,  5,      
                                       4, 20,  4,  4, 20,         
                                       4,  8,  1,  4,  4,       
                                       4,  4,  4,  4, 50, 
                                       1,  1,  1,  1, 70,
																		  30, 30,  8,  1, 30

																	}; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1,  0,  0,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1,  0,  0,
																		  0,  0,  0,  0, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT  \n");
					sql.append( "				A.EMPNO,A.REGDIV,A.EMPNMK,A.CARRDIV,A.RECDIV,           \n");
					sql.append( "				A.EMPDIV,A.FRDT,A.TODT,A.PAYDIV,A.RESINO,               \n");
					sql.append( "				A.PICTURE,RTRIM(A.GRSTRTDT) AS GRSTRTDT,RTRIM(A.STRTDT) AS STRTDT,A.DEPTCD,A.PAYGRD, \n");
					sql.append( "				A.JOBGRPH,A.JOBDTY,A.GRDDIV,A.PAYSEQ,A.FSAMDT,	        \n");
					sql.append( "				A.ENDDT,A.USESTS,A.COSTDIV,A.DPOFFDT,A.LAMDT,           \n");
					sql.append( "				A.LRMDT,A.BIRDT,A.GLDIV,A.HOBBY,A.NMC,                  \n");
					sql.append( "				A.RILIGN,A.NME,A.BIRCITY,A.SPECIAL,A.OZIPCD,            \n");
					sql.append( "				A.OADDR01,A.OADDR02,A.CZIPCD,A.CADDR01,A.CADDR02,       \n");
					sql.append( "				A.TELNO,A.HPNO,A.OFFTELNO,A.EMAIL,A.HDFAMNM,            \n");
					sql.append( "				A.HDFAMRET,A.HDFAMJOB,A.LABUNIYN,A.RELESAMT,A.MOVESAMT, \n");
					sql.append( "				A.MRTDIV,A.MRTNO,A.REFCD,A.PAYBNKCD,A.PAYACNT,          \n");
					sql.append( "				A.HOUSDIV,A.MRYDT,A.ENGLVL,A.TOESCR,A.JPTSCR,           \n");
					sql.append( "				A.DELFSCR,A.TOFSCR,A.DALFSCR,A.TEPSSCR,A.ETCLNG,        \n");
					sql.append( "				A.HWGRDCD,A.EXGRDCD,A.PWGRDCD,A.ACGRDCD,B.DEPTNM,				\n");
					sql.append( "				C.MINORNM AS PAYGNM, D.MINORNM AS GRDDNM,B.TREECD,B.LEVEL,	\n");
					sql.append( "				F.MINORNM AS JOBNM \n"); 
					sql.append( "	FROM PAYROLL.T_HIPERSON A \n");
					sql.append( "      LEFT JOIN PAYROLL.HCDEPT  B ON A.DEPTCD  = B.DEPTCD													\n");
					sql.append( "      LEFT JOIN PAYROLL.HCLCODE C ON A.PAYGRD  = C.MINORCD AND C.MAJORCD = '2002' \n");	//직위
					sql.append( "      LEFT JOIN PAYROLL.HCLCODE D ON A.GRDDIV  = D.MINORCD AND D.MAJORCD = '2001' \n");	
					sql.append( "      LEFT JOIN PAYROLL.HCLCODE F ON A.JOBKIND = F.MINORCD AND F.MAJORCD = '2037' \n");	//직종
		   		sql.append( " WHERE A.DEPTCD = '" + str1 + "' \n");
					sql.append( " AND A.USESTS IN ('1', '2')			\n");	//재직,휴직
					sql.append( " AND A.EMPDIV = '3'							\n");	//한국인계약직

					sql.append( " ORDER BY B.DEPTNM, C.SEQ \n");

					//logger.dbg.println(this,sql.toString());

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