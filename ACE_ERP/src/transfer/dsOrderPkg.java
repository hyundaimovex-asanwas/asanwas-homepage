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
public class dsOrderPkg extends HttpServlet {

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

				String[] strArrCN = new String[]{ "PORDER_NO","ORDER_DATE","WORK_FORM","CUST_CD","ARTC_CD","ARTC_NM","ENTER_STS","PKG_FORM","PKG_CNT","PKG_UNIT","WAREHOUSE","BFILE_NAME","REMARK","ORDER_STS","ORDER_CHK","END_DATE","END_TIME","AFILE_NAME","CREATE_DT","CREATE_USR","UPDATE_DT","UPDATE_USR","VEND_NM","BFILE","AFILE","PACK_TYPE","ACM_YM"}; 

				int[] intArrCN = new int[] { 12,8,10,13,10,60,10,10,13,10,10,60,512,10,10,8,6,60,10,10,10,10,60,100,100,10,1}; 
				int[] intArrCN2 = new int[]{ -1,-1,-1,-1,-1,-1,-1,-1,2,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-2,-2,-1,-1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						case -2 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_URL)); break; 			 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (isNotOnlyHeader) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT	A.PORDER_NO,A.ORDER_DATE,A.WORK_FORM,A.CUST_CD,A.ARTC_CD, \n")
						 .append( "					A.ARTC_NM,A.ENTER_STS,A.PKG_FORM,A.PKG_CNT,A.PKG_UNIT, \n")
						 .append( "					A.WAREHOUSE,A.BFILE_NAME,A.REMARK,A.ORDER_STS, \n")
						 .append( "					A.ORDER_CHK,A.END_DATE,A.END_TIME,A.AFILE_NAME, \n")
						 .append( "					A.CREATE_DT,A.CREATE_USR,A.UPDATE_DT,A.UPDATE_USR, \n")
						 .append( "					IFNULL(B.VEND_NM,'') AS VEND_NM,'' AS BFILE, '' AS AFILE, \n")
						 .append( "					IFNULL(A.PACK_TYPE,'') AS PACK_TYPE,IFNULL(A.ACM_YM,'') AS ACM_YM \n")
						 .append( "		FROM	TRANSFER.LTORDPACK A \n")
						 .append( "					LEFT JOIN ACCOUNT.GCZM_VENDER B ON A.CUST_CD = B.VEND_CD \n")
						 .append( "  WHERE A.PORDER_NO IS NOT NULL \n");

					if(str1 != null ){	  sql.append( " AND A.PORDER_NO = '" +str1 + "'" ) ;  }
					if(str2 != null ){	  sql.append( " AND B.VEND_NM LIKE '%" +str2 + "%'" ) ;  }
					if(str3 != null && str4 != null ) {sql.append ( "  AND A.ORDER_DATE BETWEEN '" + str3 + "' AND '" + str4 + "'" ) ; }						
					 
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