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
public class dsLoadlst extends HttpServlet {
 
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
					String str7 = GauceReq.getParameter("gstr7");   
					if (str7==null || str7.trim().length()==0 ) {   str7=null; }


				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"CAR_SEQ_NO","ORDER_NO","ORDER_SEQ","ARTC_CNT","PUNIT_CNT","PUNIT_WEIGHT","PKG_LNGTH","PKG_HEIGHT","PKG_WIDTH","TOTAL_CBM","TOTAL_WEIGHT","STS_CODE","UPEND_DT","UPEND_TIME","REMARK" ,"BAECHA_NO","ENTER_NO","CAR_NO","CREATE_DT","CREATE_USR","UPDATE_DT","UPDATE_UST","ARTC_NM","STN_SZNM","VEND_NM","CAR_NO1" ,"PKG_CNT","TOTAL_WEIGHT2","ARTC_UNIT","ORG_CNT"}; 

				int[] intArrCN = new int[] {10,10,4,13,13,13,13,13,13,13,13,1,8,4,512,20,20,20,10,10,10,10 ,30,30,40,20,13,13,4,13}; 
			
				int[] intArrCN2 = new int[]{-1,-1,-1,2,2,2,2,2,2,2,2,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,2,2,-1,2}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (isNotOnlyHeader) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT DISTINCT \n")
							 .append( "				 A.CAR_SEQ_NO,A.ORDER_NO,RTRIM(A.ORDER_SEQ) ORDER_SEQ,A.ARTC_CNT, \n")
							 .append( "				 A.PUNIT_CNT,A.PUNIT_WEIGHT,A.PKG_LNGTH,A.PKG_HEIGHT, \n")
							 .append( "				 A.PKG_WIDTH,A.TOTAL_CBM,A.TOTAL_WEIGHT,A.STS_CODE,A.UPEND_DT, \n")
							 .append( "  			 A.UPEND_TIME,A.REMARK,A.BAECHA_NO,A.ENTER_NO,A.CAR_NO, \n")
							 .append( "				 A.CREATE_DT,A.CREATE_USR,A.UPDATE_DT,A.UPDATE_UST, \n")
							 .append( "				 B.ARTC_NM,B.STN_SZNM,D.VEND_NM,E.CAR_NO AS CAR_NO1, \n")
							 .append( "				 A.PKG_CNT, A.TOTAL_WEIGHT TOTAL_WEIGHT2 , B.ARTC_UNIT, F.ARTC_CNT ORG_CNT \n")
							 .append( "		FROM TRANSFER.LTLOADLST A , \n")
							 .append( "				 TRANSFER.LTORDERDTL B, \n")
							 .append( "				 TRANSFER.LTORDERMST C, \n")
							 .append( "				 ACCOUNT.GCZM_VENDER D, \n")
							 .append( " 			 TRANSFER.LTCARACC E, \n")
							 .append( " 			 TRANSFER.LTINWRHS F \n")
							 .append( "	 WHERE A.CAR_SEQ_NO IS NOT NULL \n")
							 .append( "		 AND A.ORDER_NO = B.ORDER_NO \n")
							 .append( "		 AND A.ORDER_SEQ = B.ORDER_SEQ \n")
							 .append( "		 AND C.ORDER_NO = B.ORDER_NO \n")
							 .append( "		 AND D.VEND_CD = C.CUST_CD \n")
							 .append( "		 AND E.CAR_SEQ_NO = A.CAR_SEQ_NO \n")
							 .append( "		 AND A.ORDER_NO = F.ORDER_NO \n")
							 .append( "		 AND A.ORDER_SEQ = F.ORDER_SEQ \n");

    //        sql.append( " AND C.IN_OUT = 'O' ") ; 

	if(str1 != null ){ sql.append( "  AND A.CAR_NO = '" +str1 + "' \n" ) ;  }
	if(str2 != null ){ sql.append( "  AND A.ORDER_NO = '" +str2 + "' \n" ) ;  }
	if(str3 != null ){ sql.append( "  AND C.ETD_DT = '" +str3 + "' \n" ) ;  }
  if(str4 != null ){ sql.append( "  AND D.VEND_NM LIKE '%" +str4 + "%' \n" ) ;  }
	if(str5 != null ){ sql.append( "  AND C.IN_OUT = '" + str5 + "' \n" ) ; } 
	if(str6 != null ){ sql.append( "  AND C.LINE_PART = '" + str6 + "' \n" ) ; }
	if(str7 != null ){ sql.append( "  AND A.CAR_SEQ_NO = '" + str7 + "' \n" ) ; }

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