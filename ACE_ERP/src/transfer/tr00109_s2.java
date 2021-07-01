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
public class tr00109_s2 extends HttpServlet {
 
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

				String str1 = GauceReq.getParameter("v_str1");   
					if (str1==null || str1.trim().length()==0 ) {   str1=null; }
				String str2 = GauceReq.getParameter("v_str2");   
					if (str2==null || str2.trim().length()==0 ) {   str2=null; }
				String str3 = GauceReq.getParameter("v_str3");   
					if (str3==null || str3.trim().length()==0 ) {   str3=null; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{	"ORDER_NO","ORDER_SEQ","STOCK_SEQ","ETD_DT","LINE_PART",
																					"CARGO_TYPE","DLVL_TYPE","ARTC_CD","ARTC_NM","ST_ARTCCNT",
																					"ST_PUNTCNT","ST_PUNTWGT","ST_PKGLNGT","ST_PKGHEGT","ST_PKGWIDT",
																					"ST_TOTCBM","ST_TOTWGT","ST_PKGCNT","ORDER_STS","STOCK_STS",
																					"CHECK"
																				}; 

				int[] intArrCN = new int[] {	12,  4,  4,  12,  4,
																			 4,  4, 10, 100, 13,
																			13, 13, 13,  13, 13,
																			13, 13, 13,   4,  4,
																			 1
																		}; 
			
				int[] intArrCN2 = new int[]{	-1, -1, -1, -1, -1,
																			-1, -1, -1, -1,  2,
																			 2,  2,  2,  2,  2,
																			 2,  2,  2, -1, -1,
																			 0
																		};

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				StringBuffer sql = new StringBuffer();
				sql.append( " SELECT T.* \n")
					 .append( "   FROM ( SELECT A.ORDER_NO, A.ORDER_SEQ, A.STOCK_SEQ, A.ETD_DT, A.LINE_PART, \n")
					 .append( "									A.CARGO_TYPE, A.DLVL_TYPE, A.ARTC_CD, A.ARTC_NM, A.ST_ARTCCNT, \n")
					 .append( "									A.ST_PUNTCNT, A.ST_PUNTWGT, A.ST_PKGLNGT, A.ST_PKGHEGT, A.ST_PKGWIDT, \n")
					 .append( "									A.ST_TOTCBM, A.ST_TOTWGT, A.ST_PKGCNT, A.ORDER_STS, A.STOCK_STS, \n")
					 .append( "									0 CHECK \n")
					 .append( "						 FROM TRANSFER.LTORDSTOCK A, \n")
					 .append( "									( SELECT ORDER_NO, ORDER_SEQ, MAX(INTEGER(STOCK_SEQ)) STOCK_SEQ FROM TRANSFER.LTORDSTOCK GROUP BY ORDER_NO, ORDER_SEQ) B \n")
					 .append( "						WHERE A.ORDER_NO  = B.ORDER_NO \n")
					 .append( "							AND A.ORDER_SEQ = B.ORDER_SEQ \n")
					 .append( "							AND A.STOCK_SEQ = B.STOCK_SEQ \n")
					 .append( "							AND A.LINE_PART = '" + str1 + "' \n");

				if(str2 != null)	sql.append( " AND A.ETD_DT = '" + str2 + "' ");
				if(str3 != null)	sql.append( " AND A.ARTC_NM LIKE '" + str2 + "%' ");

				sql.append( "				) T \n")
					 .append( "					LEFT OUTER JOIN TRANSFER.LTLOADLST S ON T.ORDER_NO = S.ORDER_NO AND T.ORDER_SEQ = S.ORDER_SEQ \n")
					 .append( "	 WHERE S.ORDER_NO IS NULL \n");

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