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
public class tr00109_s4_popup extends HttpServlet {
 
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

				String str1 = GauceReq.getParameter("v_str1");   //order_no
 			  String str2 = GauceReq.getParameter("v_str2");   //order_seq
				
				if (str2==null || str2.trim().length()==0 ) {   str2=null; }
				if (str1==null || str1.trim().length()==0 ) {   str1=null; } 
				
				GauceRes.enableFirstRow(dSet); 

				String[] strArrCN = new String[]{	"CHK", "ENTER_DATE", "ENTER_NO","ORDER_NO", "ORDER_SEQ" ,
					                                "CAR_SEQ_NO", "ARTC_CNT", "ENTER_STS"
				}; 

				int[] intArrCN = new int[] {	1,  8,  8,  10,  4,
					                           10, 13, 10 
																		}; 
			
				int[] intArrCN2 = new int[]{	-1, -1, -1, -1, -1,
					                            -1,  2, -1
																		};

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				StringBuffer sql = new StringBuffer();
				sql.append( " SELECT ''CHK, A.ENTER_DATE, A.ENTER_NO, A.ORDER_NO, A.ORDER_SEQ,                             \n");
				sql.append( "        B.CAR_SEQ_NO, A.ARTC_CNT, A.ENTER_STS                                                 \n");
				sql.append( "   FROM TRANSFER.LTINWRHS A                                                                   \n");
				sql.append( "   LEFT JOIN TRANSFER.LTCARGOODS B ON A.ORDER_NO = B.ORDER_NO AND A.ORDER_SEQ = B.ORDER_SEQ   \n");
				sql.append( "  WHERE (RTRIM(A.ENTER_STS)<>'' AND A.ENTER_STS IS NOT NULL)                                       \n");
				if(str1 != null)	sql.append( " AND A.ORDER_NO= '" + str1 + "' ");
				if(str2 != null)	sql.append( " AND A.ORDER_SEQ = '" + str2 + "' ");

				//logger.dbg.println(this,sql.toString());
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