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
public class tr00114_edi extends HttpServlet {
 
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


				String str0 = GauceReq.getParameter("v_str0");   
					if (str0==null || str0.trim().length()==0 ) {   str0=null; }
				String str1 = GauceReq.getParameter("v_str1");   
					if (str1==null || str1.trim().length()==0 ) {   str1=null; }
				String str2 = GauceReq.getParameter("v_str2");   
					if (str2==null || str2.trim().length()==0 ) {   str2=null; }
				String str3 = GauceReq.getParameter("v_str3");   
					if (str3==null || str3.trim().length()==0 ) {   str3=null; }
				String str4 = GauceReq.getParameter("v_str4");   
					if (str4==null || str4.trim().length()==0 ) {   str4=null; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{	"EDI_STS", "ORDER_NO","ETD_DT", "SHIPPER", "ARTC_NM","ARTC_CNT", "OBJ_REMK",
																					"CHECK"
																				}; 

				int[] intArrCN = new int[] {	10, 12,  12, 50,  100,  13,  20,
																			 1
																		}; 
			
				int[] intArrCN2 = new int[]{	-1, -1, -1, -1, -1,  2,  -1,
																			 0
																		};

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				StringBuffer sql = new StringBuffer();


						sql.append( " SELECT   \n")
							 .append("				CASE WHEN A.EDI_STS = ''  OR A.EDI_STS IS NULL THEN '미전송'  ELSE  '전송'  END AS EDI_STS, \n")		 
							 .append( "					A.ORDER_NO, A.ETD_DT, C.VEND_NM AS SHIPPER, a.artc_nm, a.artc_cnt, B.OBJ_REMK, 0 check \n")
						     .append( "				FROM TRANSFER.LTORDERDTL A,  TRANSFER.LTORDERMST B, \n")
							 .append("						ACCOUNT.GCZM_VENDER C , ACCOUNT.GCZM_VENDER D  \n ")
							 .append("				WHERE B.CUST_CD = C.VEND_CD \n ")
							 .append("							AND B.SHIPPER = D.VEND_CD \n ")
							 .append("							AND A.ORDER_NO = B.ORDER_NO \n ")
							 .append("							AND B.ORDER_STS = '0002' \n ")
							 .append( "							AND B.LINE_PART = '" + str1 + "' \n")			
							 .append("							AND B.IN_OUT = '" + str0 + "' ");				
				
				if(str2 !=null && str3 !=null ) sql.append    (" AND A.ETD_DT BETWEEN  '" +str2 + "' AND '" + str3 + "'")  ;   			
				if(str4 !=null &&  str4.equals("T") )    			         sql.append    (" AND  A.EDI_STS = '" + str4 + "' ") ;	 
			    if(str4 != null  &&  !str4.equals("T"))					 sql.append    (" AND  ( A.EDI_STS = '" + str4 + "'  OR A.EDI_STS IS NULL ) " ) ;	  
				

				

				logger.dbg.println(this,sql.toString());


				stmt = conn.getGauceStatement(sql.toString());
 				stmt.executeQuery(dSet);
				
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