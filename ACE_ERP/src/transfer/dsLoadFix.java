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
public class dsLoadFix extends HttpServlet {
 
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
				 
				String str1 = GauceReq.getParameter("gstr1");   
					if (str1==null || str1.trim().length()==0 ) {   str1 = ""; }
				String str2 = GauceReq.getParameter("gstr2");   
					if (str2==null || str2.trim().length()==0 ) {   str2 = ""; }
				String str3 = GauceReq.getParameter("gstr3");   
					if (str3==null || str3.trim().length()==0 ) {   str3 = ""; }
        String str4 = GauceReq.getParameter("gstr4");   
					if (str4==null || str4.trim().length()==0 ) {   str4 = ""; }
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
																					"CAR_SEQ_NO","ORDER_NO","ORDER_SEQ","ARTC_CNT","PUNIT_CNT",
																					"PUNIT_WEIGHT","PKG_LNGTH","PKG_HEIGHT","PKG_WIDTH","TOTAL_CBM",
																					"TOTAL_WEIGHT","STS_CODE","UPEND_DT","UPEND_TIME","REMARK",
																					"BAECHA_NO","ENTER_NO","CAR_NO","CREATE_DT","CREATE_USR",
																					"UPDATE_DT","UPDATE_UST","PKG_CNT","EDT_DATE"
																				}; 

				int[] intArrCN = new int[] {  
																			10,	10,	 4,	13,	 13,
																			13,	13,	13,	13,	 13,
																			13,	 1,	 8,	 4,	512,
																			20,	 8,	20,	10,	 10,
																			10,	10,	13,	 8
																		}; 
			
				int[] intArrCN2 = new int[]{
																			-1, -1, -1,  2,  2,
																			 2,  2,  2,  2,  2,
																			 2, -1,	-1, -1, -1,
																			-1, -1,	-1, -1, -1,
																			-1, -1,	 2, -1
																		}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				StringBuffer sql = new StringBuffer();
				sql.append(" SELECT CAR_SEQ_NO, ORDER_NO, ORDER_SEQ, ARTC_CNT, PUNIT_CNT, \n")
					 .append(" 				PUNIT_WEIGHT, PKG_LNGTH, PKG_HEIGHT, PKG_WIDTH, TOTAL_CBM,  \n")
					 .append(" 				TOTAL_WEIGHT, STS_CODE, UPEND_DT, UPEND_TIME, REMARK,  \n")
					 .append(" 				BAECHA_NO, ENTER_NO, CAR_NO, CREATE_DT, CREATE_USR,  \n")
					 .append(" 				UPDATE_DT, UPDATE_UST, PKG_CNT, EDT_DATE \n")
					 .append(" 	 FROM TRANSFER.LTLOADFIX \n")
					 .append("  WHERE EDT_DATE = '" + str1 + "' ");

				if (str2.equals("")) sql.append(" AND ORDER_NO = '" + str2 + "' \n");

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