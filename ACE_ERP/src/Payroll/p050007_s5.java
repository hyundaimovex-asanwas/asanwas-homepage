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
public class p050007_s5 extends HttpServlet {

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

				String [] str = new String [4];
				str[0]	= req.getParameter("v_str1"); ///년도           





				for (int s=0;s<1;s++) {
					if (str[s]==null) str[s] = "";
				}

			//	if (str1==null){str1="";}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"APPYM",  "DEPTNM",  "EMPNO", "FAMNM",  
					"REFCDNM",  "RESINO",  "SCHNM", "SCHYEAR",  
					"APPAMT", "PAYAMT", "SEQ"
					}; 

				int[] intArrCN = new int[]{ 6, 50, 7, 20,
					                        30,  13,40, 1,
					                        7,  7, 4
					                      }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1,
					                          -1, -1,-1,-1,
					                          0,0,-1}; 
			
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();


sql.append(" SELECT                                                                                                \n ");
sql.append(" 			A.APPYM, /*지급년월 */                                                                           \n ");
sql.append(" 			X.DEPTNM,                                                                                        \n ");
sql.append(" 			A.EMPNO,                                                                                         \n ");
sql.append(" 			(CASE   WHEN COALESCE(B.FAMNM,'0') = '0'   THEN C.EMPNMK  ELSE B.FAMNM  END) AS FAMNM,           \n ");
sql.append(" 			COALESCE(D.MINORNM,'본인')  AS  REFCDNM, /*가족관계*/                                            \n ");
sql.append(" 			A.RESINO,                                                                                        \n ");
sql.append(" 			A.SCHNM,  /*학교명 */                                                                            \n ");
sql.append(" 			A.SCHYEAR, /* 학년 */                                                                            \n ");
sql.append(" 			A.APPAMT, /* 신청금액 */                                                                         \n ");
sql.append(" 			A.PAYAMT, /* 지급금액 */                                                                         \n ");
sql.append(" 			COALESCE(D.MINORCD,'0') AS SEQ                                                                   \n ");
sql.append(" from  PAYROLL.PWSCHREQ A                                                                              \n ");
sql.append(" 			LEFT OUTER JOIN PAYROLL.HIFAMILY B ON  A.EMPNO = B.EMPNO  AND A.RESINO = B.RESINO                \n ");
sql.append(" 			LEFT OUTER JOIN PAYROLL.HIPERSON C ON  A.EMPNO = C.EMPNO                                         \n ");
sql.append(" 			LEFT OUTER JOIN PAYROLL.HCLCODE D ON   COALESCE(B.REFCD,'0') = D.MINORCD  AND D.MAJORCD = '1132' \n ");
sql.append(" 			LEFT OUTER JOIN PAYROLL.HCDEPT X ON X.DEPTCD=C.DEPTCD                                            \n ");
sql.append(" WHERE RTRIM(A.EMPNO) <> ' '                                                                           \n ");
if (!str[0].equals("")&&!str[0].equals("0"))
sql.append("       AND A.APPYM='" + str[0] + "'                                                                            \n ");
sql.append(" ORDER BY X.DEPTCD ASC, A.EMPNO ASC ,SEQ ASC                                                                         \n ");



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