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
public class p060001_s3 extends HttpServlet {

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
				String  str4	= req.getParameter("v_str4");   //직위구분

				if (str1==null) { str1 = ""; }
				if (str2==null) { str2 = ""; }
				if (str3==null) { str3 = ""; }
				if (str4==null) { str4 = ""; }

				GauceRes.enableFirstRow(dSet);
				String[] strArrCN = new String[]{ "JOBGRPHNM"	,	"MINORCD"	,	"SEQ", "PAYGRDNM", "GUBUNSUM"	}; 

				int[] intArrCN = new int[]	{  30, 4, 3, 30,	9}; 

				int[] intArrCN2 = new int[]	{ -1, -1, 0, -1,	0	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append(" SELECT E.MINORNM AS JOBGRPHNM ,E.MINORCD, COALESCE(F.SEQ,0) AS SEQ, F.MINORNM AS PAYGRDNM, \n");

						if (!str3.equals("") && !str3.equals("0"))	{
							sql.append( " COALESCE(SUM(A."+ str3 +"),0) AS GUBUNSUM \n");
						}	else	{
							sql.append( " COALESCE(SUM(A.S91000),0)  AS GUBUNSUM \n");
						}
						sql.append("    FROM PAYROLL.PBPAY A  \n");
						sql.append("   LEFT JOIN PAYROLL.HCLCODE E ON  A.JOBGRPH = E.MINORCD  AND E.MAJORCD = '2000' \n");
						sql.append("   LEFT JOIN PAYROLL.HCLCODE F ON  A.PAYGRD = F.MINORCD  AND F.MAJORCD = '2002'  \n");

						sql.append(" WHERE A.APPDT <> ' ' \n");
						if ( (!str1.equals("") && !str1.equals("0")) && (!str2.equals("") && !str2.equals("0")) )
						sql.append( " AND SUBSTR(A.PAYDT,1,6) BETWEEN '" + str1 + "' AND  '" + str2 + "'  \n");

						sql.append(" GROUP BY E.MINORNM,E.MINORCD,F.MINORNM,F.SEQ  \n");
						sql.append(" ORDER BY E.MINORCD DESC, F.SEQ DESC  \n");

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