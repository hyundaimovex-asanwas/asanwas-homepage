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
public class dsStock extends HttpServlet {
 
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
				if ( GauceReq.getParameter("NOH")!=null && GauceReq.getParameter("NOH").equals("Y") ) { isNotOnlyHeader = true; }
				
				
				 
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
				
				 

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ORDER_NO","ORDER_SEQ","ARTC_NM","STN_SZNM","ARTC_CNT","IN_ARTC_CNT","PKG_CBM","IN_PKG_CBM","PKG_CNT","PUNIT_WGHT","IN_PKG_CNT","IN_PKG_WEIGHT","T_WEIGHT","T_CBM","IN_T_WEIGHT","IN_T_CBM","ENTER_CNT","L_ARTC_CNT","L_PUNIT_CNT","L_PUNIT_WEIHT","L_T_CBM","L_T_WEIHT","VEND_NM","L_PKG_CNT","ETD_DT"}; 

				int[] intArrCN = new int[] { 10,4,50,50,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,13,50,13,8}; 
			
				int[] intArrCN2 = new int[]{-1,-1,-1,-1,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,-1,3,-1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (isNotOnlyHeader) {					
						StringBuffer sql = new StringBuffer();
										sql.append(" SELECT ") ; 
										sql.append(" B.ORDER_NO,B.ORDER_SEQ ,B.ARTC_NM,B.STN_SZNM,") ; 
										sql.append(" B.ARTC_CNT,SUM(IFNULL(C.ARTC_CNT,0)) AS IN_ARTC_CNT,") ; 
										sql.append(" B.PKG_CBM,SUM(IFNULL(C.PKG_CBM,0)) AS IN_PKG_CBM, ") ; 
										sql.append(" B.PKG_CNT,B.PUNIT_WGHT,SUM(IFNULL(C.PKG_CNT,0)) AS IN_PKG_CNT,") ; 
										sql.append(" SUM(IFNULL(C.PUNIT_WEIGHT,0)) AS IN_PKG_WEIGHT,") ; 
										sql.append(" B.PKG_CNT * B.PUNIT_WGHT AS T_WEIGHT,B.PKG_CNT *B.PKG_CBM AS T_CBM,") ; 
										sql.append(" SUM(IFNULL(C.PKG_CNT * C.PUNIT_WEIGHT,0)) AS IN_T_WEIGHT,") ; 
										sql.append(" SUM(IFNULL(C.PKG_CNT * C.PKG_CBM,0)) AS IN_T_CBM,") ; 
										sql.append(" COUNT(C.ENTER_NO) AS ENTER_CNT,") ; 
										sql.append(" SUM(IFNULL(D.ARTC_CNT,0)) AS L_ARTC_CNT,") ; 
										sql.append(" SUM(IFNULL(D.PUNIT_CNT,0)) AS L_PUNIT_CNT,") ; 
										sql.append(" SUM(IFNULL(D.PUNIT_WEIGHT,0)) AS L_PUNIT_WEIHT,") ; 
										sql.append(" SUM(IFNULL(D.TOTAL_CBM,0)) AS L_T_CBM,") ; 
										sql.append(" SUM(IFNULL(D.TOTAL_WEIGHT,0)) AS L_T_WEIHT ,") ; 
										sql.append(" E.VEND_NM ,") ; 
										sql.append(" SUM(IFNULL(D.PKG_CNT,0)) AS L_PKG_CNT, A.ETD_DT ") ; 
										sql.append(" FROM TRANSFER.LTORDERMST A,") ; 
										sql.append(" (TRANSFER.LTORDERDTL B LEFT JOIN TRANSFER.LTINWRHS C ") ; 
										sql.append(" ON B.ORDER_NO =C.ORDER_NO AND B.ORDER_SEQ = C.ORDER_SEQ ) ") ; 
										sql.append(" LEFT JOIN TRANSFER.LTLOADLST D  ") ;  
										sql.append(" ON B.ORDER_NO =D.ORDER_NO AND B.ORDER_SEQ = D.ORDER_SEQ ,") ; 
										sql.append(" ACCOUNT.GCZM_VENDER E ") ; 
										sql.append(" WHERE A.ORDER_NO = B.ORDER_NO ") ; 
										sql.append(" AND E.VEND_CD =  A.CUST_CD ") ; 
if(str1 != null && str2 != null ){
										sql.append( "AND ETD_DT BETWEEN '" +str1 + "' AND  '" + str2 + "'" ) ; 	
}
if(str3 != null){		sql.append(  " AND A.ORDER_NO  = '"+ str3 + "'" ) ; }
if(str4 != null){		sql.append(  " AND A.LINE_PART =  '"+ str4 + "'" ) ; }
if(str5 != null){		sql.append(  " AND E.VEND_NM  LIKE  '%"+ str5 + "%'" ) ; }
						sql.append(" GROUP BY B.ORDER_NO,B.ORDER_SEQ ,B.ARTC_NM,B.STN_SZNM,") ;  
						sql.append("B.ARTC_CNT ,B.PKG_CBM,B.PKG_CNT,B.PUNIT_WGHT ,B.PKG_CNT * B.PUNIT_WGHT,E.VEND_NM , A.ETD_DT") ;  
						sql.append(" ORDER BY B.ORDER_NO,INT(B.ORDER_SEQ)") ;  



//GauceRes.writeException("Sql",":",sql.toString());
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