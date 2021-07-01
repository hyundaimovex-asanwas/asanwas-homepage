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
public class p050007_s1 extends HttpServlet {

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
					"APPYY",  "APPMM",  "B11000", "B12000",  
					"SODUK_SUM",  "SANG_SUM" ,"GO_TOTAL",  "BO_TOTAL"
					}; 

				int[] intArrCN = new int[]{ 4, 2, 9, 9,
					                        9,  9, 9, 9
					                      }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, 0, 0, 0, 0,
					0, 0 }; 
			
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
sql.append(" SELECT                                                                                                       \n ");  
sql.append("       SUBSTR(A.APPDT,1,4) AS APPYY,                                                                          \n ");
sql.append("       SUBSTR(A.APPDT,5,2) AS APPMM,                                                                          \n ");
sql.append("       COALESCE(SUM(A.B11000),0) AS B11000 ,  /* 건강보험료*/                                                 \n ");
sql.append("       COALESCE(SUM(A.B12000),0) AS B12000 ,  /* 국민연금*/                                                   \n ");
sql.append("       B.SODUK_SUM,     /*급여 소득 고용보험 */                                                               \n ");
sql.append("       COALESCE(C.SANG_SUM,0) AS SANG_SUM,     /*상여 소득 고용보험 */                                        \n ");
sql.append("       (COALESCE(B.SODUK_SUM,0)+COALESCE(C.SANG_SUM,0)) AS GO_TOTAL,   /* 고용보험합계*/                      \n ");
sql.append("       (COALESCE(SUM(A.B11000),0)+COALESCE(B.SODUK_SUM,0)+COALESCE(C.SANG_SUM,0)) AS BO_TOTAL   /* 보험합계*/ \n ");
sql.append(" FROM PAYROLL.PBPAY A                                                                                         \n ");
sql.append("      LEFT JOIN                                                                                               \n ");
sql.append("      (                                                                                                       \n ");
sql.append("            SELECT                                                                                            \n ");
sql.append("                  B.APPDT,                                                                                    \n ");
sql.append("                  SUM(B.S92000),    /* 급여(소득합계)=*/                                                      \n ");
sql.append("                  SUM(B.S92000)*A.INSRATE1 AS SODUK_SUM    /* 급여(소득합계) 고용보험*/                       \n ");
sql.append("            FROM PAYROLL.PBPAY B                                                                              \n ");
sql.append("                 LEFT JOIN (                                                                                  \n ");
sql.append("                            SELECT                                                                            \n ");
sql.append("                                  INSRATE1                                                                    \n ");
sql.append("                            FROM PAYROLL.PWRATE                                                               \n ");
sql.append("                            WHERE                                                                             \n ");
sql.append("                                 INSGB='3'                                                                    \n ");
sql.append("                                 AND APPYM=(SELECT MAX(APPYM) FROM PAYROLL.PWRATE)                            \n ");
sql.append("                            ) A ON A.INSRATE1 <> 0                                                            \n ");
sql.append("            WHERE   B.APPDT <> ' '                                                                                           \n ");
if (!str[0].equals("")&&!str[0].equals("0"))
sql.append("      		     AND SUBSTR(B.APPDT,1,4) ='" + str[0]+ "'                                                 \n ");
sql.append("                 AND PAYDIV NOT IN ('5') --상여급여 제외                                                      \n ");
sql.append("            GROUP BY B.APPDT,A.INSRATE1                                                                       \n ");
sql.append("            ORDER BY SUBSTR(B.APPDT,5,2)                                                                      \n ");
sql.append("       ) B ON A.APPDT=B.APPDT                                                                                 \n ");
sql.append("                                                                                                              \n ");
sql.append("      LEFT JOIN                                                                                               \n ");
sql.append("      (                                                                                                       \n ");
sql.append("      				SELECT                                                                                    \n ");
sql.append("      				      B.APPDT,                                                                            \n ");
sql.append("      				      SUM(B.S92000),    /* 상여(소득합계)=*/                                              \n ");
sql.append("      				      SUM(B.S92000)*A.INSRATE1 AS SANG_SUM    /* 상여(소득합계) 고용보험*/                \n ");
sql.append("      				FROM PAYROLL.PBPAY B                                                                      \n ");
sql.append("                  LEFT JOIN(                                                                                  \n ");
sql.append("                            SELECT                                                                            \n ");
sql.append("                                  INSRATE1                                                                    \n ");
sql.append("                            FROM PAYROLL.PWRATE                                                               \n ");
sql.append("                            WHERE                                                                             \n ");
sql.append("                                 INSGB='3'                                                                    \n ");
sql.append("                                 AND APPYM=(SELECT MAX(APPYM) FROM PAYROLL.PWRATE)                            \n ");
sql.append("                            ) A ON A.INSRATE1 <> 0                                                            \n ");
sql.append("      				WHERE  B.APPDT <> ' '                                                                     \n ");
if (!str[0].equals("")&&!str[0].equals("0"))
sql.append("      				     AND SUBSTR(B.APPDT,1,4) ='" + str[0]+ "'                                                 \n ");
sql.append("      				     AND PAYDIV IN ('5')    --상여급여 만                                                 \n ");
sql.append("      				GROUP BY B.APPDT,A.INSRATE1                                                               \n ");
sql.append("      				ORDER BY SUBSTR(B.APPDT,5,2)                                                              \n ");
sql.append("       ) C ON A.APPDT=C.APPDT                                                                                 \n ");
sql.append(" WHERE   A.EMPNO <> ' '                                                                                       \n ");
if (!str[0].equals("")&&!str[0].equals("0"))
sql.append("        AND SUBSTR(A.APPDT,1,4) ='" + str[0] + "'                                                                   \n ");
sql.append(" GROUP BY A.APPDT,B.SODUK_SUM,C.SANG_SUM                                                                      \n ");
sql.append(" ORDER BY SUBSTR(A.APPDT,5,2)                                                                                 \n ");



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