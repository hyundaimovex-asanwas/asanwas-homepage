package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class p050007_s6 extends HttpServlet {

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

				String [] str = new String [1];
				str[0]	= req.getParameter("v_str1"); ///년도           

				for (int s=0;s<1;s++) {
					if (str[s]==null) str[s] = "";
				}

			//	if (str1==null){str1="";}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "REASON",
					                                "DEPTCD","DEPTNM","TREECD","TR_DEPTCD","TR_DEPTNM",
					                                "TR_TREECD","PAYGRD","PAYGRDNM","EMPNO","EMPNMK",
					                                "APPDAY","APPAMT","ENDDT","APLAMT",
					                                "APPCNT","APLAMT_SUM","UNDER_2000","UP_2000","APLRAT",
					                                "APLRAT_SUM","APLAMT_APLRAT","BALANCE"	                               
					}; 

				int[] intArrCN = new int[]{ 30,
					                           4, 30,  8,  4,  30,
					                           8,  4, 30,  7,  20, 
					                           8,  9,  8,  9,   
					                           3, 10,  9,  9,   9, 
					                           9,  9,  10  }; 
			
				int[] intArrCN2 = new int[]{ -1, 
					                           -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1,
					                           -1,  0, -1,  0,
					                            0,  0,  0,  0,  0, 
					                            0,  0,  0}; 
			
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
          
					sql.append("  SELECT H.REASON,                                                                                           \n ");
					sql.append("         A.DEPTCD, RTRIM(D.DEPTNM)DEPTNM, D.TREECD, K.DEPTCD AS TR_DEPTCD, RTRIM(K.DEPTNM) AS TR_DEPTNM,      \n ");
					sql.append("         K.TREECD AS TR_TREECD, A.PAYGRD, RTRIM(E.MINORNM) AS PAYGRDNM, A.EMPNO, B.EMPNMK,                    \n ");
					sql.append("         C.APPDAY, C.APPAMT, H.MAX_APLDAY ENDDT, A.APLAMT,                                                    \n ");
					sql.append("         A.APPCNT, G.APLAMT_SUM,                                                                                        \n ");
					//sql.append("         CASE WHEN (C.APPAMT-G.APLAMT_SUM)>20000000 THEN ROUND((20000000*0.02)/12,0)                                    \n ");
					sql.append("         CASE WHEN (C.APPAMT-G.APLAMT_SUM+C.APLAMT)>20000000 THEN ROUND((20000000*0.02)/12,0)                                    \n ");
					                              
						
					sql.append("              ELSE A.APLRAT END UNDER_2000,                                                                             \n ");
					//sql.append("         CASE WHEN (C.APPAMT-G.APLAMT_SUM)>20000000 THEN ROUND((((C.APPAMT+A.APLAMT-G.APLAMT_SUM)-20000000)*0.03)/12,0) \n ");
					sql.append("         CASE WHEN (C.APPAMT-G.APLAMT_SUM+C.APLAMT)>20000000 THEN ROUND((((C.APPAMT+A.APLAMT-G.APLAMT_SUM)-20000000)*0.03)/12,0) \n ");
						
					sql.append("              ELSE 0 END UP_2000,                                                                                       \n ");
					sql.append("         A.APLRAT, G.APLRAT_SUM, A.APLAMT+A.APLRAT AS APLAMT_APLRAT, C.APPAMT-G.APLAMT_SUM  AS BALANCE       \n ");
					sql.append("    FROM PAYROLL.PBPAY A                                                                                                \n ");
					sql.append("    LEFT JOIN PAYROLL.HIPERSON B ON A.EMPNO = B.EMPNO                                                                   \n ");
					sql.append("    LEFT JOIN PAYROLL.PWRONPAY C ON A.EMPNO = C.EMPNO AND C.APLDAY LIKE '"+str[0]+"%'                                   \n ");
					sql.append("    LEFT JOIN PAYROLL.HCDEPT D ON A.DEPTCD = D.DEPTCD                                                                   \n ");
					sql.append("    LEFT JOIN PAYROLL.HCLCODE E ON A.PAYGRD = E.MINORCD AND E.MAJORCD = '2002'                                          \n ");
					sql.append("    LEFT JOIN ( SELECT EMPNO, IFNULL(SUM(APLAMT),0)APLAMT_SUM, IFNULL(SUM(APLRAT),0) APLRAT_SUM                         \n ");			
					sql.append("                  FROM PAYROLL.PBPAY                                                                                    \n ");
					sql.append("                 WHERE APPDT <='"+str[0]+"31'                                                                           \n ");
					sql.append("                   AND PAYDIV IN('1','4')                                                                                     \n ");	
					sql.append("                   AND APLRAT > 0                                                                                       \n ");
					sql.append("                 GROUP BY EMPNO                                                                                         \n ");
					sql.append("              ) G ON A.EMPNO = G.EMPNO                                                                                  \n ");
					sql.append("    LEFT JOIN ( SELECT EMPNO, APPDAY, MAX(APLDAY)AS MAX_APLDAY ,REASON                                                  \n ");
					sql.append("                  FROM PAYROLL.PWRONPAY                                                                                 \n ");
					sql.append("                 GROUP BY EMPNO, APPDAY ,REASON                                                                         \n ");
					sql.append("                 HAVING APPDAY<='"+str[0]+"31' AND MAX(APLDAY)>='"+str[0]+"31'                                          \n ");
					sql.append("               ) H ON A.EMPNO = H.EMPNO                                                                                 \n ");
					sql.append("    LEFT JOIN PAYROLL.HCDEPT K ON K.TREECD = SUBSTR(D.TREECD,1,6)||'00'                                                 \n ");
					sql.append("  WHERE A.APPDT LIKE '"+str[0]+"%'                                                                                      \n ");
					sql.append("    AND A.PAYDIV IN('1','4')                                                                                                   \n ");
					//sql.append("    AND A.APLRAT<>0                                                                                                     \n ");
					sql.append("    AND A.APJAMT<>0                                                                                                     \n ");
					sql.append("  ORDER BY H.MAX_APLDAY, A.PAYGRD, A.EMPNO                                                                              \n ");
					

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