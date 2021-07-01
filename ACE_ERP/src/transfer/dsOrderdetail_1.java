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
public class dsOrderdetail_1 extends HttpServlet {

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
				boolean isDebug = false;
				if ( GauceReq.getParameter("DBG")!=null && GauceReq.getParameter("DBG").equals("Y") ) { isDebug = true; }
				
				String str1 = GauceReq.getParameter("gstr1");   //order No
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

				String[] strArrCN = new String[]{ "ORDER_NO","ORDER_SEQ","ARTC_CD","ARTC_NM","STN_SZ","STN_SZNM","HSCODE","ARTC_CNT","ARTC_UNIT","UNIT_PRICE","PRICE","LDCARGO","LDCARGONM","OFFCARGO","OFFCARGONM","PUNIT_CNT","PUNIT_UNIT","PUNIT_WGHT","PKG_LNGTH","PKG_HEIGHT","PKG_WIDTH","PKG_CBM","PKG_CNT","MIX_OTHERS","SAMEAS","SETTLE_STS","CREATE_USR","UPDATE_USR","REGFILE","REGFILENAME","VEND_NM","CHECK","LINE_PART","T_CBM" ,"T_WEIGHT" }; 

				int[] intArrCN = new int[] {10,4,10,100,4,30,10,13,10,13,13,10,100,10,100,13,10,13,13,13,13,13,13,1,4,1,10,10,100,30,100 ,1,10,13,13 }; 
			
				int[] intArrCN2 = new int[]{ -1,-1,-1,-1,-1,-1,-1,0,-1,2,2,-1,-1,-1,-1,2,-1,2,2,2,2,2,2,-1,-1,-1,-1,-1,-2,-1,-1,-1,-1,2,2 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						case -2 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_URL)); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (isNotOnlyHeader) {		
					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT	D.ORDER_NO,D.ORDER_SEQ,D.ARTC_CD,D.ARTC_NM,D.STN_SZ, \n")
						 .append( "					D.STN_SZNM,D.HSCODE,D.ARTC_CNT,D.ARTC_UNIT, \n")
						 .append( "					D.UNIT_PRICE,D.PRICE,D.LDCARGO,D.LDCARGONM, \n")
						 .append( "					D.OFFCARGO,D.OFFCARGONM,D.PUNIT_CNT,D.PUNIT_UNIT, \n")
						 .append( "					D.PUNIT_WGHT,D.PKG_LNGTH,D.PKG_HEIGHT,D.PKG_WIDTH, \n")
						 .append( "					D.PKG_CBM,D.PKG_CNT,D.MIX_OTHERS,D.SAMEAS, \n")
						 .append( "					D.SETTLE_STS ,D.CREATE_USR,D.UPDATE_USR,'' AS REGFILE , IFNULL(D.REGFILENAME,'') AS REGFILENAME, \n")
						 .append( "					G.VEND_NM ,'' AS CHECK ,M.LINE_PART, \n")
						 .append( "					0 AS T_CBM,0 AS T_WEIGHT, 'C' BGTYPE \n")
						 .append( "		FROM TRANSFER.LTORDERDTL D, \n")
						 .append( "				 TRANSFER.LTORDERMST M, \n") 
						 .append( "				 ACCOUNT.GCZM_VENDER G \n")
						 .append( "  WHERE D.ORDER_NO IS NOT NULL \n")
						 .append( "		 AND M.ORDER_NO= D.ORDER_NO \n")
						 .append( "		 AND G.VEND_CD = M.CUST_CD \n");

					if(str1 != null ) {		sql.append( " AND D.ORDER_NO= '" + str1 + "'"   ) ;	 } 	 
					if(str2 != null ) {		sql.append( " AND M.ETD_DT= '" + str2 + "'"   ) ;	 } 	  //반출일자
					if(str3 != null ) {		sql.append( " AND M.LINE_PART= '" + str3 + "'"   ) ;	 } 	  //프로젝트 구분
					if(str4 != null ) {		sql.append( " AND M.IN_OUT= '" + str4 + "'"   ) ;	 } 	  //프로젝트 구분
					if(str5 != null ) {		sql.append( " AND G.VEND_NM LIKE  '%" + str5 + "%'"   ) ;	 } 	  //프로젝트 구분

					sql.append( " ORDER BY D.ORDER_NO, INTEGER(D.ORDER_SEQ) ASC " );

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