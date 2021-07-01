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
public class p050007_s4 extends HttpServlet {

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
				str[0]	= req.getParameter("v_str1"); ///현재년월         
				str[1]	= req.getParameter("v_str2"); ///이전년월           





				for (int s=0;s<2;s++) {
					if (str[s]==null) str[s] = "";
				}

			//	if (str1==null){str1="";}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"MEDSNO",  "EMPNMK",  "RESINO",
					"GRDCD",  "STDAMT",  "INSAMT", 
					"GRDCD2", "STDAMT2",  "INSAMT2",  
					"INSDIF","DEPTNM", "PRTNM"
					}; 

				int[] intArrCN = new int[]{ 20, 20, 13, 3,
					                        9,  9, 3, 9, 9,9, 70, 20
					                      }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, 0, 0, 0,0,0,0,0, -1,-1}; 
			
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();


sql.append(" SELECT C.MEDSNO,B.EMPNMK,B.RESINO,                                                             \n ");
sql.append(" COALESCE(C.GRDCD,0) AS GRDCD, COALESCE(C.STDAMT,0) AS STDAMT, COALESCE(C.INSAMT,0) AS INSAMT,  \n ");
sql.append(" COALESCE(F.GRDCD,0) AS GRDCD2,COALESCE(F.STDAMT,0) AS STDAMT2,COALESCE(F.INSAMT,0) AS INSAMT2, \n ");
sql.append(" COALESCE((F.INSAMT-C.INSAMT),0) AS INSDIF,G.DEPTNM, E.MINORNM AS PRTNM                       \n ");
sql.append(" FROM PAYROLL.PBPAY A                                                                           \n ");
sql.append(" LEFT JOIN PAYROLL.PBPAY D ON A.EMPNO=D.EMPNO AND D.APPDT='" +str[1] +"'                              \n ");
sql.append(" LEFT JOIN PAYROLL.HIPERSON B ON A.EMPNO=B.EMPNO                                                \n ");
sql.append(" LEFT JOIN                                                                                      \n ");
sql.append("          PAYROLL.PWINDIPN_H C ON A.EMPNO=C.EMPNO                                               \n ");
sql.append("                                 AND C.APPYM= D.APPDT --이전월                                  \n ");
sql.append(" LEFT JOIN                                                                                      \n ");
sql.append("          PAYROLL.PWINDIPN_H F ON A.EMPNO=F.EMPNO                                               \n ");
sql.append("                                 AND F.APPYM=A.APPDT  --현재월                                  \n ");

sql.append(" LEFT JOIN PAYROLL.HCDEPT G ON  A.DEPTCD = G.DEPTCD                           \n ");
sql.append(" LEFT JOIN PAYROLL.HCLCODE E ON  G.DEPTPRT = E.MINORCD AND E.MAJORCD='1111'   \n ");	
sql.append(" WHERE A.EMPNO <> ' '                                                                           \n ");
if (!str[0].equals("")&&!str[0].equals("0"))
sql.append("       AND A.APPDT ='" +str[0] +"'                                                         \n ");
sql.append(" ORDER BY B.EMPNMK ASC                                                               \n ");


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