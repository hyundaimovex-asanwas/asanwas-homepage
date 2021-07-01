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
public class dsInWRHS extends HttpServlet {
 
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
				
				boolean isNotOnlyHeader = false;
				boolean isDebug = false;
				if ( GauceReq.getParameter("NOH")!=null && GauceReq.getParameter("NOH").equals("Y") ) { isNotOnlyHeader = true; }
				if ( GauceReq.getParameter("DBG")!=null && GauceReq.getParameter("DBG").equals("Y") ) { isDebug = true; }
				
				
				String str1 = GauceReq.getParameter("gstr1");   
					if (str1==null || str1.trim().length()==0 ) {   str1=null; }
				String str2 = GauceReq.getParameter("gstr2");   
					if (str2==null || str2.trim().length()==0 ) {   str2=null; }
				String str3 = GauceReq.getParameter("gstr3");   
					if (str3==null || str3.trim().length()==0 ) {   str3=null; }
				String str4 = GauceReq.getParameter("gstr4");   
					if (str4==null || str4.trim().length()==0 ) {   str4=null; }
				String str5 = GauceReq.getParameter("gstr5");   
					if (str5==null || str5.trim().length()==0 ) {   str5=null; }
				String str6 = GauceReq.getParameter("gstr6");   
					if (str6==null || str6.trim().length()==0 ) {   str6=null; }
				

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"ENTER_DATE","ENTER_NO","WAREHOUSE","GOODS_SEQ","ARTC_NM",
					                               "ARTC_CNT","PUNIT_CNT","PUNIT_WEIGHT","PKG_LNGTH","PKG_HEIGHT",
					                               "PKG_WIDTH","PKG_CBM","TOTAL_CBM","TOTAL_WEIGHT","ENTER_STS",
					                               "EXTRA_STS","ORDER_NO","ORDER_SEQ","PKG_CNT", "JAN_ARTC_CNT", "ORG_GOODS_SEQ"}; 

				int[] intArrCN = new int[] {8,10,10,4,50,13,13,13,13,13,13,13,13,13,10,10,10,4,13,13,4}; 
			
				int[] intArrCN2 = new int[]{-1,-1,-1,-1,-1,2,2,2,2,2,2,2,2,2,-1,-1,-1,-1,2,0,-1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (isNotOnlyHeader) {					

					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT ") ; 
					sql.append( " ENTER_DATE,ENTER_NO,WAREHOUSE, ") ; 
					sql.append( " GOODS_SEQ,ARTC_NM,ARTC_CNT,    ") ; 
					sql.append( " PUNIT_CNT,PUNIT_WEIGHT,        ") ; 
					sql.append( " PKG_LNGTH,PKG_HEIGHT,          ") ; 
					sql.append( " PKG_WIDTH,PKG_CBM,             ") ; 
					sql.append( " TOTAL_CBM,TOTAL_WEIGHT,        ") ; 
					sql.append( " ENTER_STS,EXTRA_STS,           ") ; 
					sql.append( " ORDER_NO,ORDER_SEQ,IFNULL(PKG_CNT,0) AS PKG_CNT, 0 JAN_ARTC_CNT,GOODS_SEQ AS ORG_GOODS_SEQ") ; 
					sql.append( " FROM TRANSFER.LTINWRHS         ") ; 
					sql.append( " WHERE ENTER_DATE IS NOT NULL   ") ; 
					if(str1 != null )sql.append( " AND ENTER_DATE  = '" + str1 + "'" ) ; 
					if(str2 != null )sql.append( " AND ENTER_NO = '" + str2 + "'   " ) ; 
					if(str3 != null )sql.append( " AND ARTC_NM LIKE '%" +str3 + "%'" ) ; 
					if(str4 != null )sql.append( " AND  ORDER_NO = '" +str4 + "'   " ) ; 
					if(str5 != null )sql.append( " AND  ORDER_SEQ = '" +str5 + "'  " ) ; 
					sql.append( " ORDER BY ENTER_DATE,ENTER_NO, INTEGER(GOODS_SEQ) " ) ; 

					//logger.dbg.println("SQL",sql.toString());
					if (isDebug) { GauceRes.writeException("Sql",":",sql.toString()); }
						stmt = conn.getGauceStatement(sql.toString());
		 				stmt.executeQuery(dSet);
					}
				
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