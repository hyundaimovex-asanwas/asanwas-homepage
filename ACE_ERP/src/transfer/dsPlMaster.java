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
public class dsPlMaster extends HttpServlet {

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
			  String str9 = GauceReq.getParameter("gstr9");   
					if (str9==null || str9.trim().length()==0 ) {   str9=null; } 
			  String str10 = GauceReq.getParameter("gstr10");   
					if (str10==null || str10.trim().length()==0 ) {   str10=null; } 
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "PL_NO","IN_OUT","PL_SHIPPER","PL_SHPPRNM","PL_SHPADD1","PL_SHPADD2","PL_SHPADD3","PL_SHPTEL","PL_CSTM","PL_CSTMNM","PL_CSTADD1","PL_CSTADD2","PL_CSTADD3","PL_CSTTEL","PL_BRKR","PL_BRKRNM","PL_BRKADD1","PL_BRKADD2","PL_BRKADD3","PL_BRKTEL","PL_NOTICE","PLNOTICENM","START_LCT","REACH_LCT","TRANS_CAR","START_DT","INVOICE_NO","INVOICE_DT","REMARK","LCNO","LCDATE","LCBANK","WEIGHT","T_WEIGHT","T_CBM","GORDER_NO","PACKING_CNT","PACKING_UNIT","PACKING_CBM","TELEPHONE","RPR_GOODS","CARGO_TYPE","DNG_TYPE","CAR_TYPE","ORDER_NO","DCL_DATE","DCL_NO","CURRENCY","CREATE_DT","CREATE_USR","UPDATE_DT","UPDATE_USR" ,"START_TIME","LINE_PART","PL_CSN","PL_CSNNM","PL_CSNTEL","PL_CSNADDR","PL_CSNADDR2","PL_CSNADDR3",
					"START_LCTNM", "REACH_LCTNM"}; 

				int[] intArrCN = new int[] { 20,1,13,35,35,35,35,25,13,35,35,35,35,25,13,35,35,35,35,25,13,100,10,10,100,8,20,8,512,15,8,4,13,13,13,15,13,10,13,14,100,4,4,4,10,8,18,10,10,10,10,10,4,10,13,35,25,35,35,35,
					30, 30 }; 
			
				int[] intArrCN2 = new int[]{ -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,2,2,2,-1,2,-1,2,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
					-1, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (isNotOnlyHeader) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT	 A.PL_NO,A.IN_OUT,A.PL_SHIPPER,A.PL_SHPPRNM,A.PL_SHPADD1,A.PL_SHPADD2, \n")
						 .append( "					A.PL_SHPADD3,A.PL_SHPTEL,A.PL_CSTM,A.PL_CSTMNM,A.PL_CSTADD1, \n")
						 .append( "					A.PL_CSTADD2,A.PL_CSTADD3,A.PL_CSTTEL,A.PL_BRKR,A.PL_BRKRNM, \n")
						 .append( "					A.PL_BRKADD1,A.PL_BRKADD2,A.PL_BRKADD3,A.PL_BRKTEL,'' AS PL_NOTICE, \n")
						 .append( "					'' AS PLNOTICENM,A.START_LCT,A.REACH_LCT,A.TRANS_CAR,A.START_DT, \n")
						 .append( "					A.INVOICE_NO,A.INVOICE_DT,A.REMARK,A.LCNO,A.LCDATE,A.LCBANK,A.WEIGHT, \n")
						 .append( "					A.T_WEIGHT,A.T_CBM,A.GORDER_NO,A.PACKING_CNT,A.PACKING_UNIT, \n")
						 .append( "					A.PACKING_CBM,A.TELEPHONE,A.RPR_GOODS,A.CARGO_TYPE,A.DNG_TYPE, \n")
						 .append( "					A.CAR_TYPE,A.ORDER_NO,A.DCL_DATE,A.DCL_NO,A.CURRENCY, \n")
						 .append( "					A.CREATE_DT,A.CREATE_USR,A.UPDATE_DT,A.UPDATE_USR,A.START_TIME,IFNULL(A.LINE_PART,'') AS LINE_PART,  \n")
						 .append(" 					IFNULL(A.PL_CSN,'') AS PL_CSN ,IFNULL(A.PL_CSNNM,'') AS PL_CSNNM ,IFNULL(A.PL_CSNTEL,'') AS PL_CSNTEL, \n")
						 .append(" 					IFNULL(A.PL_CSNADDR,'') AS PL_CSNADDR ,IFNULL(A.PL_CSNADDR2,'') AS PL_CSNADDR2, \n")
						 .append(" 					IFNULL(A.PL_CSNADDR3,'') AS PL_CSNADDR3, B.MINORNM AS START_LCTNM, C.MINORNM AS REACH_LCTNM  \n")
						 .append( "		FROM	TRANSFER.LTPCKLSCI A \n")
						 .append( "		LEFT JOIN TRANSFER.LTLCODE B ON B.MINORCD = A.START_LCT   AND B.MAJORCD = '0007'  \n")
						 .append( "		LEFT JOIN TRANSFER.LTLCODE C ON C.MINORCD = A.REACH_LCT   AND C.MAJORCD = '0007' \n")		
						 .append( "	 WHERE	 A.PL_NO IS NOT NULL \n")
						 .append( "    AND  A.IN_OUT = '" + str0 + "' \n");

					if(str1 != null ){	   sql.append( " AND A.PL_NO = '" +str1 + "'" ) ;  }
					if(str2 != null ){	   sql.append( " AND A.PL_SHPPRNM LIKE '%" +str2 + "%'" ) ;  }
					if(str3 != null && str4 != null ) {sql.append ( "  AND A.START_DT BETWEEN '" + str3 + "' AND '" + str4 + "'" ) ; }
					if(str5 != null ){     sql.append( " AND A.LINE_PART ='" + str5 + "'" ) ;  }
					if(str6 != null ){     sql.append( " AND A.ORDER_NO ='" + str6 + "'" ) ;  }

					logger.dbg.println(this,sql.toString());

					if (isDebug) GauceRes.writeException("Sql",":",sql.toString());

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