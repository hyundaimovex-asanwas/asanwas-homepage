package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class dsUsrInfo extends HttpServlet {
 
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
				
				String str1 = GauceReq.getParameter("v_str1");
					if (str1==null || str1.trim().length()==0 ) {   str1 = ""; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{	"CUST_CD","CUST_CDNM","CUST_REGNM","CUST_TELNO","CUST_HPNO" }; 

				int[] intArrCN = new int[] {	10, 30, 20,  20,  20 }; 
			
				int[] intArrCN2 = new int[] {	-1, -1, -1, -1, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				StringBuffer sql = new StringBuffer();
				sql.append( " SELECT B.VEND_CD CUST_CD, B.VEND_NM CUST_CDNM, A.REGNM CUST_REGNM, \n")
					 .append( "				 CASE WHEN A.TEL1 IS NULL THEN '' WHEN A.TEL1 = '' THEN '' ELSE A.TEL1||'-'||A.TEL2||'-'||A.TEL3 END CUST_TELNO,  \n")
					 .append( "				 CASE WHEN A.MOBILE1 IS NULL THEN '' WHEN A.MOBILE1 = '' THEN '' ELSE A.MOBILE1||'-'||A.MOBILE2||'-'||A.MOBILE3 END CUST_HPNO \n")
					 .append( "   FROM TRANSFER.LTUSER A \n")
					 .append( "        LEFT OUTER JOIN ACCOUNT.GCZM_VENDER B ON A.REGNO = B.VEND_ID \n")
					 .append( "  WHERE A.USERID = UPPER('" + str1 + "') \n");

				stmt = conn.getGauceStatement(sql.toString());
	 			stmt.executeQuery(dSet);
				
/*********************************************************************************************/

			} catch(Exception e) {
		  	logger.err.println(this,e);
				GauceRes.writeException("Sql",":",e.toString());
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