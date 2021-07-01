package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class h060020_s0 extends HttpServlet {

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

				String [] str = new String[2];
        str[0] =  req.getParameter("v_str1"); // 고과년월  
				str[1] =  req.getParameter("v_str2"); // 사번   
				
        for(int i=0;i<=1;i++){
					if(str[i]==null) str[i]="";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EVAYM",		"EMPNO",		   "EMPNMK",	  "HEADCD",		"HEADNM",
																					"DIVCD",	  "DIVNM",		   "DEPTCD",	  "DEPTNMK",	"PAYGRD",	  "PAYGRDNM",	
																					"WORK_1",   "STARTDT_1",   "ENDDT_1",   "PLACE_1",  "REMARK_1",
																					"WORK_2",   "STARTDT_2",   "ENDDT_2",   "PLACE_2",  "REMARK_2",
																					"WORK_3",   "STARTDT_3",   "ENDDT_3",   "PLACE_3",  "REMARK_3",	
																					"WRDT",		  "WRID",			   "UPDT",		  "UPID"
																			  }; 

				int[] intArrCN = new int[]{ 6,  7, 30,  4,  50,
																		4, 50,  4, 50,  4, 50, 
																	 50,  8,  8, 50, 100,
					                         50,  8,  8, 50, 100,
					                         50,  8,  8, 50, 100,
				                            8, 10,  8,  10
																	}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1,
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

					  sql.append( " SELECT A.EVAYM,   A.EMPNO,                                                                                                                  \n");
						sql.append( "        CASE WHEN RTRIM(B.EMPNMK)='' OR B.EMPNMK IS NULL THEN F.EMPNMK ELSE B.EMPNMK END EMPNMK,                                             \n");
						sql.append( "        A.HEADCD, /* RTRIM(E.DEPTNM) AS HEADNM,*/  CASE WHEN A.EVAYM<'200801' THEN RTRIM(J.DEPTNM) ELSE  RTRIM(E.DEPTNM) END  AS HEADNM ,    \n");
						sql.append( "        A.DIVCD,  /* RTRIM(D.DEPTNM) AS DIVNM, */  CASE WHEN A.EVAYM<'200801' THEN RTRIM(I.DEPTNM) ELSE  RTRIM(D.DEPTNM) END  AS DIVNM ,     \n");
						sql.append( "        A.DEPTCD, /* RTRIM(C.DEPTNMK) AS DEPTNMK,*/ CASE WHEN A.EVAYM<'200801' THEN RTRIM(H.DEPTNM) ELSE RTRIM(C.DEPTNMK) END  AS DEPTNMK,   \n");
						sql.append( "        A.PAYGRD,  RTRIM(G.MINORNM) AS PAYGRDNM,                                                                                             \n");
						sql.append( "        A.WORK_1,  A.STARTDT_1, A.ENDDT_1, A.PLACE_1, A.REMARK_1,                                                                            \n");
						sql.append( "        A.WORK_2,  A.STARTDT_2, A.ENDDT_2, A.PLACE_2, A.REMARK_2,                                                                            \n");
						sql.append( "        A.WORK_3,  A.STARTDT_3, A.ENDDT_3, A.PLACE_3, A.REMARK_3,                                                                            \n");
						sql.append( "        A.WRDT,    A.WRID,      A.UPDT,    A.UPID                                                                                            \n");
						sql.append( "   FROM PAYROLL.HWORKMST A                                                                                                                   \n");
						sql.append( "   LEFT JOIN PAYROLL.HIPERSON B ON A.EMPNO = B.EMPNO                                                                                         \n");
						sql.append( "   LEFT JOIN PAYROLL.HCDEPT C ON A.DEPTCD = C.DEPTCD AND C.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT )                                  \n");
						sql.append( "   LEFT JOIN PAYROLL.HCDEPT D ON A.DIVCD = D.DEPTCD AND D.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT )                                   \n");
						sql.append( "   LEFT JOIN PAYROLL.HCDEPT E ON A.HEADCD = E.DEPTCD AND E.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT )                                  \n");
						sql.append( "   LEFT JOIN PAYROLL.T_HIPERSON F ON A.EMPNO = F.EMPNO                                                                                       \n");
						sql.append( "   LEFT JOIN PAYROLL.HCLCODE G ON A.PAYGRD = G.MINORCD AND G.MAJORCD='2002'                                                                  \n");
						sql.append( "   LEFT JOIN PAYROLL.HCDEPT_99 H ON A.DEPTCD = H.DEPTCD                                                                                      \n");
						sql.append( "   LEFT JOIN PAYROLL.HCDEPT_99 I ON A.DIVCD = I.DEPTCD                                                                                       \n");
						sql.append( "   LEFT JOIN PAYROLL.HCDEPT_99 J ON A.HEADCD = J.DEPTCD                                                                                      \n");
						
						if(!str[0].equals(""))sql.append( " WHERE  A.EVAYM ='"+str[0]+"'                     \n");
						if(!str[1].equals(""))sql.append( "   AND  A.EMPNO='"+str[1]+"'                      \n");
					  
						/**
						sql.append( "  SELECT A.EVAYM,   A.EMPNO,                                                                                 \n");
						sql.append( "         CASE WHEN RTRIM(B.EMPNMK)='' OR B.EMPNMK IS NULL THEN F.EMPNMK ELSE B.EMPNMK END EMPNMK,            \n");
						sql.append( "         A.HEADCD,  RTRIM(E.DEPTNM) AS HEADNM,                                                               \n");
						sql.append( "         A.DIVCD,   RTRIM(D.DEPTNM) AS DIVNM,                                                                \n");
						sql.append( "         A.DEPTCD,  RTRIM(C.DEPTNMK) AS DEPTNMK,                                                             \n");
						sql.append( "         A.PAYGRD,  RTRIM(G.MINORNM) AS PAYGRDNM,                                                            \n");
						sql.append( "         A.WORK_1,  A.STARTDT_1, A.ENDDT_1, A.PLACE_1, A.REMARK_1,                                           \n");
						sql.append( "         A.WORK_2,  A.STARTDT_2, A.ENDDT_2, A.PLACE_2, A.REMARK_2,                                           \n");
						sql.append( "         A.WORK_3,  A.STARTDT_3, A.ENDDT_3, A.PLACE_3, A.REMARK_3,                                           \n");
						sql.append( "         A.WRDT,    A.WRID,      A.UPDT,    A.UPID                                                           \n");
						sql.append( "    FROM PAYROLL.HWORKMST A                                                                                  \n");
						sql.append( "    LEFT JOIN PAYROLL.HIPERSON B ON A.EMPNO = B.EMPNO                                                        \n");
						sql.append( "    LEFT JOIN PAYROLL.HCDEPT C ON A.DEPTCD = C.DEPTCD AND C.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT ) \n");
						sql.append( "    LEFT JOIN PAYROLL.HCDEPT D ON A.DIVCD = D.DEPTCD AND D.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT )  \n");
						sql.append( "    LEFT JOIN PAYROLL.HCDEPT E ON A.HEADCD = E.DEPTCD AND E.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT ) \n");
						sql.append( "    LEFT JOIN PAYROLL.T_HIPERSON F ON A.EMPNO = F.EMPNO                                                      \n");
						sql.append( "    LEFT JOIN PAYROLL.HCLCODE G ON A.PAYGRD = G.MINORCD AND G.MAJORCD='2002'   \n");
						if(!str[0].equals(""))sql.append( " WHERE  A.EVAYM ='"+str[0]+"'                     \n");
						if(!str[1].equals(""))sql.append( "   AND  A.EMPNO='"+str[1]+"'                      \n");
						**/
					
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