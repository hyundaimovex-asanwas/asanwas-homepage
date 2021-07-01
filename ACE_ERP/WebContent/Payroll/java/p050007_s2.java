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
public class p050007_s2 extends HttpServlet {

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
					"APPYY",  "APPMM",  "EMCOUNT", "STDAMT",  
					"INSSUM",  "INSAMT2", "INSAMT1", 
					}; 

				int[] intArrCN = new int[]{ 4, 2, 9, 9,
					                        9,  9, 9
					                      }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, 0, 0, 0, 0, 0}; 
			
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
sql.append(" SELECT                                                                                      \n ");
sql.append("       SUBSTR(B.APPDT,1,4) AS APPYY,                                                         \n ");
sql.append("       SUBSTR(B.APPDT,5,2) AS APPMM,                                                         \n ");
sql.append("       B.EMCOUNT,                       /*인원 */                                            \n ");
sql.append("       (COALESCE(C.STDAMT,0)*COALESCE(B.EMCOUNT,0)) AS STDAMT ,  /* 표준소득*/               \n ");
sql.append("       (COALESCE(C.INSSUM,0)*COALESCE(B.EMCOUNT,0)) AS INSSUM ,    /*각출료 */               \n ");
sql.append("       (COALESCE(C.INSAMT2,0)*COALESCE(B.EMCOUNT,0)) AS INSAMT2 ,  /* 국민연금(회사)*/  \n ");     
sql.append("       (COALESCE(C.INSAMT1,0)*COALESCE(B.EMCOUNT,0)) AS INSAMT1   /* 국민연금(회사)*/   \n ");     
sql.append(" FROM                                                                                        \n ");
sql.append("     (                                                                                       \n ");
sql.append("          SELECT                                                                             \n ");
sql.append("                COUNT(A.EMPNO) AS EMCOUNT, A.APPDT,                                          \n ");
sql.append("                (COALESCE(SUM(A.S92000),0)/COALESCE(COUNT(A.EMPNO),0)) AS PYOSOSUM           \n ");
sql.append("          FROM PAYROLL.PBPAY A                                                               \n ");
sql.append("          WHERE A.APPDT <> ' '                                                               \n ");
sql.append("          GROUP BY A.APPDT                                                                   \n ");
sql.append("          ORDER BY SUBSTR(A.APPDT,5,2)                                                       \n ");
sql.append("                                                                                             \n ");
sql.append("     )B                                                                                      \n ");
sql.append(" LEFT JOIN                                                                                   \n ");
sql.append("         (                                                                                   \n ");
sql.append("              SELECT                                                                         \n ");
sql.append("                    B.GRDCD, B.LOWAMT,B.HIGAMT ,STDAMT,INSAMT1,INSAMT2,INSSUM                \n ");
sql.append("              FROM                                                                           \n ");
sql.append("                  PAYROLL.PWPENTBL B                                                         \n ");
sql.append("              WHERE B.STDYM=(                                                                \n ");
sql.append("                             SELECT MAX(STDYM) FROM PAYROLL.PWPENTBL                         \n ");
sql.append("                             )                                                               \n ");
sql.append("              ORDER BY B.GRDCD                                                               \n ");
sql.append("         ) C ON  B.PYOSOSUM BETWEEN  C.LOWAMT AND C.HIGAMT                                   \n ");
sql.append("                                                                                             \n ");
sql.append(" WHERE B.APPDT <> ' '                                                                        \n ");
if (!str[0].equals("")&&!str[0].equals("0"))
sql.append("      AND SUBSTR(B.APPDT,1,4) ='" + str[0] + "'                                              \n ");
sql.append(" ORDER BY SUBSTR(B.APPDT,5,2)                                                                \n ");






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