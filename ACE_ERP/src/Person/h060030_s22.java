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
public class h060030_s22 extends HttpServlet {

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

				String [] str = new String[1];
        str[0] =  req.getParameter("v_str1"); // 고과년월  
				
        for(int i=0;i<=0;i++){
					if(str[i]==null) str[i]="";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO",	 "EMPNMK",	  "DEPTCD",	  "DEPTNMK",	
																					"DIVCD",	 "DIVNM",		  "HEADCD",		"HEADNM",  "PAYGRD",		"PAYGRDNM" , "JOBGRPH", "JOBRR", "JOBKIND" 
																			  }; 

				int[] intArrCN = new int[]{ 7, 30,  4,  50,
																		4, 50,  4, 50,  4, 50 ,20,20,20
																	}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1,
																		 -1, -1, -1, -1,  -1, -1,-1,  -1, -1
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					  //2008.11.12 JYS
					  // 재택 근무자 때문에 사내경력에서 재택을 제외하고 최근의 부서를 가져옴.
					
						sql.append( " SELECT B.EMPNO, B.EMPNMK,                                      \n");
						sql.append( "        C.DEPTCD, RTRIM(C.DEPTNMK)DEPTNMK,                      \n");
						sql.append( "        D.DEPTCD AS DIVCD, RTRIM(D.DEPTNM) AS DIVNM,            \n");
						sql.append( "        E.DEPTCD AS HEADCD, RTRIM(E.DEPTNM) AS HEADNM,          \n");
						sql.append( "        B.PAYGRD, RTRIM(F.MINORNM)PAYGRDNM, G.JOBGRPH, G.JOBRR, G.JOBKIND        \n");
						sql.append( "   FROM PAYROLL.HIPERSON B                                      \n");
						sql.append( "   LEFT JOIN ( SELECT X.EMPNO,                                        \n");
						sql.append( "                      CASE WHEN X.DEPTCD = 'U110' THEN 'J430'       \n");
						sql.append( "                           WHEN X.DEPTCD = 'Q000' THEN 'C000'       \n");
						sql.append( "                           WHEN X.DEPTCD = 'K110' THEN 'D110'       \n");
						sql.append( "                           WHEN X.DEPTCD = 'K100' THEN 'D100'       \n");
						sql.append( "                           WHEN X.DEPTCD = 'GC20' THEN 'I320'       \n");
						sql.append( "                           WHEN X.DEPTCD = 'GC10' THEN 'I310'       \n");
						sql.append( "                           WHEN X.DEPTCD = 'GC00' THEN 'I300'       \n");
						sql.append( "                           WHEN X.DEPTCD = 'G580' THEN 'I230'       \n");
						sql.append( "                           WHEN X.DEPTCD = 'G470' THEN 'I150'       \n");
						sql.append( "                           WHEN X.DEPTCD = 'G460' THEN 'I140'       \n");
						sql.append( "                           WHEN X.DEPTCD = 'E070' THEN 'F210'       \n");
						sql.append( "                           WHEN X.DEPTCD = 'D560' THEN 'E160'       \n");
						sql.append( "                           WHEN X.DEPTCD = 'D510' THEN 'E110'       \n");
						sql.append( "                           ELSE X.DEPTCD END DEPTCD                 \n");
						sql.append( "                   FROM PAYROLL.HOORDER X, PAYROLL.HIPERSON BB       \n");
						sql.append( "                  WHERE X.EMPNO = BB.EMPNO                           \n");
						sql.append( "                    AND X.ORDCD <> 'D7'                              \n");
						sql.append( "                    AND X.ORDDT = (SELECT MAX(K.ORDDT)               \n");
						sql.append( "                                      FROM PAYROLL.HOORDER K          \n");
						sql.append( "                                     WHERE K.EMPNO = X.EMPNO          \n");
						sql.append( "                                       AND K.ORDCD <>'D7'             \n");
						sql.append( "                                    )                                 \n");
						sql.append( "                  ) Y ON B.EMPNO = Y.EMPNO                            \n");
sql.append( "   LEFT JOIN PAYROLL.JOBSPEC G ON B.EMPNO = G.EMPNO   \n");
						sql.append( "   LEFT JOIN PAYROLL.HCDEPT C ON Y.DEPTCD = C.DEPTCD AND C.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT )                       \n");
						sql.append( "   LEFT JOIN PAYROLL.HCDEPT D ON D.TREECD = SUBSTR(C.TREECD,1,6)||'00' AND D.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT )     \n");
						sql.append( "   LEFT JOIN PAYROLL.HCDEPT E ON E.TREECD = SUBSTR(C.TREECD,1,4)||'0000' AND E.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT )   \n");
						sql.append( "   LEFT JOIN PAYROLL.HCLCODE F ON F.MINORCD = B.PAYGRD AND F.MAJORCD='2002'   \n");
						sql.append( "  WHERE B.USESTS IN ('1','2')                                   \n");
						if(!str[0].equals(""))sql.append( " AND  B.EMPNO ='"+str[0]+"'               \n");
						sql.append( "  UNION ALL                                                     \n");
						sql.append( "  SELECT B.EMPNO, B.EMPNMK,                                     \n");
						sql.append( "        C.DEPTCD, RTRIM(C.DEPTNMK)DEPTNMK,                      \n");
						sql.append( "        D.DEPTCD AS DIVCD, RTRIM(D.DEPTNM) AS DIVNM,            \n");
						sql.append( "        E.DEPTCD AS HEADCD, RTRIM(E.DEPTNM) AS HEADNM,          \n");
						sql.append( "        B.PAYGRD, RTRIM(F.MINORNM)PAYGRDNM, G.JOBGRPH, G.JOBRR, G.JOBKIND                       \n");
						sql.append( "   FROM PAYROLL.T_HIPERSON B                                    \n");
						sql.append( "   LEFT JOIN ( SELECT X.EMPNO,                                  \n");
						sql.append( "                      CASE WHEN X.DEPTCD = 'G810' THEN 'F330'   \n");
						sql.append( "                           WHEN X.DEPTCD = 'G820' THEN 'F310'   \n");
						sql.append( "                           WHEN X.DEPTCD = 'G830' THEN 'F320'   \n");
						sql.append( "                           WHEN X.DEPTCD = 'D140' THEN 'E220'   \n");
						sql.append( "                           ELSE X.DEPTCD END DEPTCD             \n");
						sql.append( "                 FROM PAYROLL.T_HOORDER X, PAYROLL.T_HIPERSON BB\n");
						sql.append( "                WHERE X.EMPNO = BB.EMPNO                        \n");
						sql.append( "                  AND X.ORDCD <> 'D7'                           \n");
						sql.append( "                  AND X.ORDDT = (SELECT MAX(K.ORDDT)            \n");
						sql.append( "                                   FROM PAYROLL.T_HOORDER K     \n");
						sql.append( "                                  WHERE K.EMPNO = X.EMPNO       \n");
						sql.append( "                                    AND K.ORDCD <>'D7'          \n");
						sql.append( "                                 )                              \n");
						sql.append( "                ) Y ON B.EMPNO = Y.EMPNO                        \n");
sql.append( "   LEFT JOIN PAYROLL.JOBSPEC G ON B.EMPNO = G.EMPNO   \n");
						sql.append( "   LEFT JOIN PAYROLL.HCDEPT C ON Y.DEPTCD = C.DEPTCD AND C.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT )                       \n");
						sql.append( "   LEFT JOIN PAYROLL.HCDEPT D ON D.TREECD = SUBSTR(C.TREECD,1,6)||'00' AND D.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT )     \n");
						sql.append( "   LEFT JOIN PAYROLL.HCDEPT E ON E.TREECD = SUBSTR(C.TREECD,1,4)||'0000' AND E.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT )   \n");
						sql.append( "   LEFT JOIN PAYROLL.HCLCODE F ON F.MINORCD = B.PAYGRD AND F.MAJORCD='2002'   \n");
						sql.append( "  WHERE B.USESTS IN ('1','2')                                                                                                     \n");
						if(!str[0].equals(""))sql.append( "  AND  B.EMPNO ='"+str[0]+"'                     \n");
					
					//  logger.dbg.println(this,sql.toString());
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