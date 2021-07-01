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
public class p060002_s1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");   //지급년월부터
				String  str2	= req.getParameter("v_str2");   //지급년월까지
				String  str3	= req.getParameter("v_str3");   //항목구분
				String  str4	= req.getParameter("v_str4");   //항목적용년월

				if (str1==null) { str1 = ""; }
				if (str2==null) { str2 = ""; }
				if (str3==null) { str3 = ""; }
				if (str4==null) { str4 = ""; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "PAYCDNM", "PAYCD",	"SEQ", "PAYGRDNM", "GUBUNSUM"
				}; 

				int[] intArrCN = new int[]{  30,   8,  3, 30,9
					
				}; 
			
				int[] intArrCN2 = new int[]{ -1,     -1,   0,-1,0
				
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

 sql.append(" SELECT X.PAYCDNM AS PAYCDNM ,X.PAYCD, COALESCE(F.SEQ,999) AS SEQ, F.MINORNM AS PAYGRDNM,   \n ");
 sql.append("         COALESCE((CASE                                                                 \n ");
 sql.append("           WHEN X.PAYCD='P10000'                                                        \n ");
 sql.append("           THEN SUM(A.P10000)                                                           \n ");
 sql.append("           WHEN X.PAYCD='P11000'                                                        \n ");
 sql.append("           THEN SUM(A.P11000)                                                           \n ");
 sql.append("           WHEN X.PAYCD='P12000'                                                        \n ");
 sql.append("           THEN SUM(A.P12000)                                                           \n ");
 sql.append("           WHEN X.PAYCD='P21000'                                                        \n ");
 sql.append("           THEN SUM(A.P21000)                                                           \n ");
 sql.append("           WHEN X.PAYCD='P22000'                                                        \n ");
 sql.append("           THEN SUM(A.P22000)                                                           \n ");
 sql.append("           WHEN X.PAYCD='P23000'                                                        \n ");
 sql.append("           THEN SUM(A.P23000)                                                           \n ");
 sql.append("           WHEN X.PAYCD='P24000'                                                        \n ");
 sql.append("           THEN SUM(A.P24000)                                                           \n ");
 sql.append("           WHEN X.PAYCD='P25000'                                                        \n ");
 sql.append("           THEN SUM(A.P25000)                                                           \n ");
 sql.append("           WHEN X.PAYCD='P26000'                                                        \n ");
 sql.append("           THEN SUM(A.P26000)                                                           \n ");
 sql.append("           WHEN X.PAYCD='P27000'                                                        \n ");
 sql.append("           THEN SUM(A.P27000)                                                           \n ");
 sql.append("           WHEN X.PAYCD='P28000'                                                        \n ");
 sql.append("           THEN SUM(A.P28000)                                                           \n ");
 sql.append("           WHEN X.PAYCD='P29000'                                                        \n ");
 sql.append("           THEN SUM(A.P29000)                                                           \n ");
 sql.append("           WHEN X.PAYCD='P30000'                                                        \n ");
 sql.append("           THEN SUM(A.P30000)                                                           \n ");
 sql.append("           WHEN X.PAYCD='P31000'                                                        \n ");
 sql.append("           THEN SUM(A.P31000)                                                           \n ");
 sql.append("           WHEN X.PAYCD='P32000'                                                        \n ");
 sql.append("           THEN SUM(A.P32000)                                                           \n ");
 sql.append("           WHEN X.PAYCD='P36000'                                                        \n ");
 sql.append("           THEN SUM(A.P36000)                                                           \n ");
 sql.append("           WHEN X.PAYCD='P37000'                                                        \n ");
 sql.append("           THEN SUM(A.P37000)                                                           \n ");
 sql.append("           WHEN X.PAYCD='P38000'                                                        \n ");
 sql.append("           THEN SUM(A.P38000)                                                           \n ");
 sql.append("           WHEN X.PAYCD='PX0010'                                                        \n ");
 sql.append("           THEN SUM(A.PX0010)                                                           \n ");
 sql.append("           WHEN X.PAYCD='PX0020'                                                        \n ");
 sql.append("           THEN SUM(A.PX0020)                                                           \n ");
 sql.append("           WHEN X.PAYCD='PX0030'                                                        \n ");
 sql.append("           THEN SUM(A.PX0030)                                                           \n ");
 sql.append("           WHEN X.PAYCD='PX0040'                                                        \n ");
 sql.append("           THEN SUM(A.PX0040)                                                           \n ");
 sql.append("           END),0) AS GUBUNSUM                                                          \n ");
 sql.append("    FROM    (SELECT                                                                     \n ");
 sql.append("           PBDIV,PAYCD,PAYCDNM,PAYDIV  from PAYROLL.PCPAYCD                             \n ");
 sql.append("                                                         where PAYDIV='1' AND PBDIV='1' \n ");
 sql.append("                                                          AND PAYCD not in(             \n ");
 sql.append("                                                          'P39000', --전월소급          \n ");
 sql.append("                                                          'P33000', --월차수당          \n ");
 sql.append("                                                          'P34000', --연차수당          \n ");
 sql.append("                                                          'P35000' --상여금             \n ");
 sql.append("                                                          )                             \n ");
if (!str4.equals("") && !str4.equals("0"))	
	sql.append( " AND '" + str4 + "' BETWEEN SUBSTR(FRDT,1,6)  AND SUBSTR(TODT,1,6)                  \n ");  
 sql.append("                                                           ORDER BY PAYCD ASC  ) X    \n ");
 sql.append("   LEFT JOIN PAYROLL.PBPAY A ON A.APPDT <> ' '                                          \n ");
if ( (!str1.equals("") && !str1.equals("0")) && (!str2.equals("") && !str2.equals("0")) )
   sql.append( " AND SUBSTR(A.PAYDT,1,6) BETWEEN '" + str1 + "' AND  '" + str2 + "'  \n ");
if ( !str3.equals("") && !str3.equals("0") )
   sql.append( " AND A.JOBGRPH ='" + str3 + "'   \n ");
 sql.append("   LEFT JOIN PAYROLL.HCLCODE F ON  A.PAYGRD = F.MINORCD  AND F.MAJORCD = '2002'         \n ");
 sql.append(" GROUP BY X.PAYCDNM,X.PAYCD,F.SEQ,F.MINORNM                                             \n ");
 sql.append(" ORDER BY X.PAYCD ASC, F.SEQ DESC                                                      \n ");



				//logger.dbg.println( this, sql.toString() );


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