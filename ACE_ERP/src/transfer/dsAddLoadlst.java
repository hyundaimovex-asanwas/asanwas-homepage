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
public class dsAddLoadlst extends HttpServlet {
 
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

				String[] strArrCN = new String[]{"ORDER_NO","ORDER_SEQ","ARTC_NM","STN_SZNM","PUNIT_UNIT","INWRHS","LOAD","STOCK","PKG_CNT","PUNIT_WEIGHT","PKG_LNGTH","PKG_HEIGHT","PKG_WIDTH","PKG_CBM","PUNIT_WEIGHT"}; 

				int[] intArrCN = new int[] {10,4,30,50,10,10,13,13,13,13,13,13,13,13,13 }; 
			
				int[] intArrCN2 = new int[]{-1,-1,-1,-1,-1,2,2,2,2,2,2,2,2,2,2 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (isNotOnlyHeader) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT B.ORDER_NO, B.ORDER_SEQ, D.ARTC_NM, ") ; 
						sql.append( " D.STN_SZNM,D.PUNIT_UNIT , ") ; 
						sql.append( "(SELECT IFNULL(SUM(E.ARTC_CNT),0) FROM  ") ; 
						sql.append( " TRANSFER.LTINWRHS E WHERE E.ORDER_NO =D.ORDER_NO AND E.ORDER_SEQ = B.ORDER_SEQ) AS INWRHS,") ; 
						sql.append( "(SELECT IFNULL(SUM(K.ARTC_CNT),0) FROM  ") ; 
						sql.append( " TRANSFER.LTLOADLST K WHERE K.ORDER_NO =B.ORDER_NO AND K.ORDER_SEQ = B.ORDER_SEQ) AS LOAD, ") ; 
						sql.append( "(SELECT IFNULL(SUM(E.ARTC_CNT),0) FROM ") ;
						sql.append( " TRANSFER.LTINWRHS E WHERE E.ORDER_NO =B.ORDER_NO AND E.ORDER_SEQ = B.ORDER_SEQ) - ") ; 
						sql.append( "(SELECT IFNULL(SUM(K.ARTC_CNT),0) FROM ") ;
						sql.append( " TRANSFER.LTLOADLST K WHERE K.ORDER_NO =B.ORDER_NO AND K.ORDER_SEQ = B.ORDER_SEQ) AS STOCK,") ; 
						sql.append( "(SELECT IFNULL(SUM(E.PKG_CNT),0) FROM ") ;
						sql.append( " TRANSFER.LTINWRHS E WHERE E.ORDER_NO =B.ORDER_NO AND E.ORDER_SEQ = B.ORDER_SEQ) - ") ; 
						sql.append( "(SELECT IFNULL(SUM(K.PKG_CNT),0) FROM ") ;
						sql.append( " TRANSFER.LTLOADLST K WHERE K.ORDER_NO =B.ORDER_NO AND K.ORDER_SEQ = B.ORDER_SEQ) AS PKG_CNT,") ;  
						sql.append( " B.PUNIT_WEIGHT,B.PKG_LNGTH,B.PKG_HEIGHT, B.PKG_WIDTH,B.PKG_CBM,B.PUNIT_WEIGHT FROM  ") ;
						sql.append( " TRANSFER.LTINWRHS B , TRANSFER.LTORDERDTL D  ") ;
						sql.append( " WHERE B.ORDER_NO =  ") ;
						sql.append( " D.ORDER_NO AND B.ORDER_SEQ = D.ORDER_SEQ  ") ; 
						sql.append( " GROUP BY B.ORDER_NO, B.ORDER_SEQ,D.ARTC_NM, D.STN_SZNM, D.PUNIT_UNIT, ") ; 
						sql.append( " B.PUNIT_WEIGHT,B.PKG_LNGTH,B.PKG_HEIGHT, B.PKG_WIDTH, ") ; 
						sql.append( " B.PKG_CBM,B.PUNIT_WEIGHT HAVING (SELECT IFNULL(SUM(E.ARTC_CNT),0) FROM ") ; 
						sql.append( " TRANSFER.LTINWRHS E WHERE E.ORDER_NO =B.ORDER_NO AND E.ORDER_SEQ = B.ORDER_SEQ) ") ;
						sql.append( " - (SELECT IFNULL(SUM(K.ARTC_CNT),0) FROM ") ;
						sql.append( " TRANSFER.LTLOADLST K WHERE K.ORDER_NO =B.ORDER_NO AND K.ORDER_SEQ = B.ORDER_SEQ) <> 0 ") ; 
						sql.append( " ORDER BY B.ORDER_NO, B.ORDER_SEQ ") ; 

logger.dbg.println(this,sql.toString());

if (isDebug) {	
 GauceRes.writeException("Sql",":",sql.toString()); }
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