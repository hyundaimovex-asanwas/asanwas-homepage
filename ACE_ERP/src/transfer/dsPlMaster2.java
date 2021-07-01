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
public class dsPlMaster2 extends HttpServlet {

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
				
				String str0 = GauceReq.getParameter("gstr0");   
					if (str0==null || str0.trim().length()==0 ) {   str0=null; } //반출입구분
				String str1 = GauceReq.getParameter("gstr1");   
					if (str1==null || str1.trim().length()==0 ) {   str1=null; } //주문별/ 차량별
				String str2 = GauceReq.getParameter("gstr2");   
					if (str2==null || str2.trim().length()==0 ) {   str2=null; } //반출일자_from
				String str3 = GauceReq.getParameter("gstr3");   
					if (str3==null || str3.trim().length()==0 ) {   str3=null; } //반출일자_to
			  String str4 = GauceReq.getParameter("gstr4");   
					if (str4==null || str4.trim().length()==0 ) {   str4=null; } 
				String str5 = GauceReq.getParameter("gstr5");   
					if (str5==null || str5.trim().length()==0 ) {   str5=null; }  
			  String str6 = GauceReq.getParameter("gstr6");   
					if (str6==null || str6.trim().length()==0 ) {   str6=null; } 
 			  String str7 = GauceReq.getParameter("gstr7");   
					if (str7==null || str7.trim().length()==0 ) {   str7=null; } 
 			  String str8 = GauceReq.getParameter("gstr8");   
					if (str8==null || str8.trim().length()==0 ) {   str8=null; } 
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "PL_NO","IN_OUT","PL_SHIPPER","PL_SHPPRNM","PL_SHPADD1","PL_SHPADD2","PL_SHPADD3","PL_SHPTEL","PL_CSTM","PL_CSTMNM","PL_CSTADD1","PL_CSTADD2","PL_CSTADD3","PL_CSTTEL","PL_BRKR","PL_BRKRNM","PL_BRKADD1","PL_BRKADD2","PL_BRKADD3","PL_BRKTEL","PL_NOTICE","PLNOTICENM","START_LCT","REACH_LCT","TRANS_CAR","START_DT","INVOICE_NO","INVOICE_DT","REMARK","LCNO","LCDATE","LCBANK","WEIGHT","T_WEIGHT","T_CBM","GORDER_NO","PACKING_CNT","PACKING_UNIT","PACKING_CBM","TELEPHONE","RPR_GOODS","CARGO_TYPE","DNG_TYPE","CAR_TYPE","ORDER_NO","DCL_DATE","DCL_NO","CURRENCY","CREATE_DT","CREATE_USR","UPDATE_DT","UPDATE_USR" ,"START_TIME","LINE_PART","PL_CSN","PL_CSNNM","PL_CSNTEL","PL_CSNADDR","PL_CSNADDR2","PL_CSNADDR3"}; 

				int[] intArrCN = new int[] { 20,1,13,35,35,35,35,25,13,35,35,35,35,25,13,35,35,35,35,25,13,100,10,10,100,8,20,8,512,15,8,4,13,13,13,15,13,10,13,14,100,4,4,4,10,8,18,10,10,10,10,10,4,10,13,35,25,35,35,35}; 
			
				int[] intArrCN2 = new int[]{ -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,2,2,2,-1,2,-1,2,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (isNotOnlyHeader) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT	PL_NO,IN_OUT,PL_SHIPPER,PL_SHPPRNM,PL_SHPADD1,PL_SHPADD2, \n")
						 .append( "					PL_SHPADD3,PL_SHPTEL,PL_CSTM,PL_CSTMNM,PL_CSTADD1, \n")
						 .append( "					PL_CSTADD2,PL_CSTADD3,PL_CSTTEL,PL_BRKR,PL_BRKRNM, \n")
						 .append( "					PL_BRKADD1,PL_BRKADD2,PL_BRKADD3,PL_BRKTEL,'' AS PL_NOTICE, \n")
						 .append( "					'' AS PLNOTICENM,START_LCT,REACH_LCT,TRANS_CAR,START_DT, \n")
						 .append( "					INVOICE_NO,INVOICE_DT,REMARK,LCNO,LCDATE,LCBANK,WEIGHT, \n")
						 .append( "					T_WEIGHT,T_CBM,GORDER_NO,PACKING_CNT,PACKING_UNIT, \n")
						 .append( "					PACKING_CBM,TELEPHONE,RPR_GOODS,CARGO_TYPE,DNG_TYPE, \n")
						 .append( "					CAR_TYPE,ORDER_NO,DCL_DATE,DCL_NO,CURRENCY, \n")
						 .append( "					CREATE_DT,CREATE_USR,UPDATE_DT,UPDATE_USR,START_TIME,IFNULL(LINE_PART,'') AS LINE_PART,  \n")
						 .append(" 					IFNULL(PL_CSN,'') AS PL_CSN ,IFNULL(PL_CSNNM,'') AS PL_CSNNM ,IFNULL(PL_CSNTEL,'') AS PL_CSNTEL, \n")
						 .append(" 					IFNULL(PL_CSNADDR,'') AS PL_CSNADDR ,IFNULL(PL_CSNADDR2,'') AS PL_CSNADDR2, \n")
						 .append(" 					IFNULL(PL_CSNADDR3,'') AS PL_CSNADDR3 \n")
						 .append( "		FROM	TRANSFER.LTPCKLSCI \n")
						 .append( "	 WHERE	PL_NO IS NOT NULL \n")
						 .append( "    AND  IN_OUT = '" + str0 + "' \n");

					if (str8 !=null || str8.equals("F")) sql.append( "    AND  CREATE_USR = '" + str7 + "' \n");
					else sql.append( " AND  CREATE_USR IN (SELECT USERID FROM TRANSFER.LTCUSTOMS WHERE CUSTID = '" + str7 + "') ");

					if(str1 != null ){	   sql.append( " AND PL_NO = '" +str1 + "'" ) ;  }
					if(str2 != null ){	   sql.append( " AND PL_SHPPRNM LIKE '%" +str2 + "%'" ) ;  }
					if(str3 != null && str4 != null ) {sql.append ( "  AND START_DT BETWEEN '" + str3 + "' AND '" + str4 + "'" ) ; }
					if(str5 != null ){     sql.append( " AND LINE_PART ='" + str5 + "'" ) ;  }
					if(str6 != null ){     sql.append( " AND ORDER_NO ='" + str6 + "'" ) ;  }

logger.dbg.println(this,sql.toString());

					stmt = conn.getGauceStatement(sql.toString());
		 			stmt.executeQuery(dSet);
				}
				
/*********************************************************************************************/

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