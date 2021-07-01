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
public class dsSttmnt extends HttpServlet {
 
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

				String[] strArrCN = new String[]{"SETTLE_NO","CUST_CD","SETTLE_YM","SETTLE_CD","SETTLE_ITEMS","CAR_TYPE","PACKING_TYPE","LOAD_LCT","OFF_LCT","UNIT_CBM","UNIT","CNT","UNIT_PRICE","PRICE","REQ_PRICE1","REQ_PRICE2","VAT_AMT","REMARK","TR_PAPER","STM_ACCT","STTL_DATE","ORDER_NO","ORDER_SEQ","LINE","PROJECT","VEND_CD","CHARGE_RATE","ETD_DT","SELL_TYPE","ACC_CH","ACC_DATE","ACC_CODE","CREATE_DT","CREATE_USR","UPDATE_DT","UPDATE_USR","CUST_NM","VEND_NM"}; 

				int[] intArrCN = new int[] {10,13,8,10,100,10,10,10,10,13,10,13,13,13,13,13,13,500,10,10,8,10,5,10,10,13,13,8,10,1,8,10,10,10,10,10,50,50 }; 
			
				int[] intArrCN2 = new int[]{-1,-1,-1,-1,-1,-1,-1,-1,-1,2,-1,2,2,2,2,2,2,-1,-1,-1,-1,-1,-1,-1,-1,-1,2,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (isNotOnlyHeader) {					
						StringBuffer sql = new StringBuffer();
										sql.append( " SELECT A.SETTLE_NO,A.CUST_CD,A.SETTLE_YM,A.SETTLE_CD,A.SETTLE_ITEMS, ") ; 
										sql.append( " A.CAR_TYPE,A.PACKING_TYPE,A.LOAD_LCT,A.OFF_LCT,A.UNIT_CBM,A.UNIT,") ; 
										sql.append( " A.CNT,A.UNIT_PRICE,A.PRICE,A.REQ_PRICE1,A.REQ_PRICE2,A.VAT_AMT,") ;
										sql.append( " A.REMARK,A.TR_PAPER,A.STM_ACCT,A.STTL_DATE,A.ORDER_NO,A.ORDER_SEQ, ") ; 
										sql.append( " A.LINE,A.PROJECT,A.VEND_CD,A.CHARGE_RATE,A.ETD_DT,A.SELL_TYPE, ") ; 
										sql.append( " A.ACC_CH,A.ACC_DATE,A.ACC_CODE,A.CREATE_DT, ") ; 
										sql.append( " A.CREATE_USR,A.UPDATE_DT,A.UPDATE_USR,B.VEND_NM  AS CUST_NM, ") ; 
										sql.append( " C.VEND_NM AS VEND_NM ") ; 
										sql.append( " FROM TRANSFER.LTSTTMNT A,ACCOUNT.GCZM_VENDER B, ACCOUNT.GCZM_VENDER C") ; 
										sql.append( " WHERE SETTLE_NO IS NOT NULL") ; 
										sql.append( " AND B.VEND_CD = A.CUST_CD") ;
										sql.append( " AND C.VEND_CD = A.VEND_CD") ;
if(str1 !=null ) {  sql.append( " AND SETTLE_NO  = '"	+str1 + "'" ) ;  }	
if(str2 !=null && str3 !=null) {  sql.append(" AND SETTLE_YM BETWEEN '"	+str2 + "' AND '" +str3 + "'") ;  }	
if(str4 !=null ) {  sql.append(" AND A.LINE = '"	+str4 + "'") ;  }	
if(str5 !=null ) {  sql.append("  AND B.VEND_NM LIKE '%"+ str5  + "%' ") ; }
if(str6 !=null ) {  sql.append("  AND C.VEND_NM LIKE '%"+ str6  + "%' ") ; }
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