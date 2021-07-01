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
public class dsCargoMark extends HttpServlet {
 
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

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"ORDER_NO","PROJECT","CUST_NM","SHIPPER_NM","GOODS","CNT","REMARK","ETD_DT","SHIPPER","IMAGE","CONSIGNEE" }; 

				int[] intArrCN = new int[] {10,30,30,30,500,13,50,8,30,50,200 }; 
			
				int[] intArrCN2 = new int[]{-1,-1,-1,-1,-1,2,-1,-1,-1,-1,-1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (isNotOnlyHeader) {					
					StringBuffer sql = new StringBuffer();




				  sql.append( " SELECT	ORDER_NO, E.PROJECT_NM AS PROJECT, \n")
					 .append( "			B.VEND_NM AS CUST_NM ,C.VEND_NM AS SHIPPER_NM, \n")
					 .append( "			NVL((SELECT ARTC_NM || '외' \n")
					 .append( "		  		  FROM TRANSFER.LTORDERDTL D \n")
					 .append( "				 WHERE A.ORDER_NO  = D.ORDER_NO \n")
					 .append( "			   	   AND ORDER_SEQ = '1'),'')  AS GOODS, \n")
					 .append( "			NVL((SELECT ARTC_CNT \n")
					 .append( "			  	   FROM TRANSFER.LTORDERDTL D \n")
					 .append( "				  WHERE A.ORDER_NO  = D.ORDER_NO \n")
					 .append( "				    AND ORDER_SEQ = '1'),0) AS CNT, \n")
					 .append( "			A.REMARK ,A.ETD_DT ,'' AS SHIPPER ,'../img/ASAN_MARK.jpg' AS IMAGE, \n")
					 .append( "			A.CONSIGNEE \n")
					 .append( "	   FROM TRANSFER.LTORDERMST A, \n")
					 .append( "		    ACCOUNT.GCZM_VENDER B, \n")
					 .append( "			ACCOUNT.GCZM_VENDER C, \n")
					 .append( "		    TRANSFER.LTUNTCOD E \n")
					 .append( "   WHERE CUST_CD = B.VEND_CD \n")
					 .append( "	    AND SHIPPER =  C.VEND_CD \n")
					 .append( "		AND A.PROJECT = E.TR_PROJECT \n")
					 .append( "		AND A.LINE_PART=E.LINE_PART \n");

					if(str1 != null ) sql.append( " AND  A.ORDER_NO = '" + str1	+ "'" );

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