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
public class dsPlDetail extends HttpServlet {
 
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
				//logger.dbg.println(this,str1);
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

				String[] strArrCN = new String[]{ 
																					"PL_NO","PL_SEQNO","CAR_NO","CNTN_NO","CNTN_SDSZ",
																					"CNTN_SLNO","GOODS_CD","GOODS_NM","GOODS_ENM","PACKING_NO",
																					"PACKING_CNT","STDRD_SZ","HS_CODE","GOODS_CNT","CNT_UNIT",
																					"UNIT_PRICE","PRICE","PKC_CNT","PKG_WEIGHT","PKG_LNGTH",
																					"PKG_HEIGHT","PKG_WIDTH","PKG_CBM","PKG_UNIT","PR_WEIGHT",
																					"PT_WEIGHT","T_WEIGHT","T_CNT","T_CBM","ORDER_NO",
																					"ORDER_SEQ","REAMARK","CREATE_DT","CREATE_USR","UPDATE_DT",
																					"UPDATE_USR", "CUST_CD", "VEND_NM", "NAM", "HANGUL"
																				}; 

				int[] intArrCN = new int[] {	
																			20,   4,  16,  20,  4,
																			20,  10, 100, 100, 20,
																			13, 100, 100,  13, 10,
																			13,  13,  13,  13, 13,
																			13,  13,  13,  10, 13,
																			13,  13,  13,  13, 20,
																			 4,  20,  20,  10, 20,
																			10, 13, 62, 10, 100
																		}; 
			
				int[] intArrCN2 = new int[]{
																			-1, -1, -1, -1, -1,
																			-1, -1, -1, -1, -1,
																			 3, -1, -1,  2, -1,
																			 3,  3,  3,  3,  3,
																			 3,  3,  3, -1,  3,
																			 3,  3,  3,  3, -1,
																			-1, -1, -1, -1, -1,
																			-1, -1, -1, -1, -1
																		}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (isNotOnlyHeader) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT	A.PL_NO, A.PL_SEQNO, A.CAR_NO, A.CNTN_NO, A.CNTN_SDSZ, \n")
						 .append( "					A.CNTN_SLNO, A.GOODS_CD, A.GOODS_NM, A.GOODS_ENM, A.PACKING_NO, \n")
						 .append( "					A.PACKING_CNT, A.STDRD_SZ, A.HS_CODE, A.GOODS_CNT, A.CNT_UNIT, \n")
						 .append( "					A.UNIT_PRICE, A.PRICE, A.PKC_CNT, A.PKG_WEIGHT, A.PKG_LNGTH, \n")
						 .append( "					A.PKG_HEIGHT, A.PKG_WIDTH, A.PKG_CBM, A.PKG_UNIT, IFNULL(A.PR_WEIGHT,0) PR_WEIGHT, \n")
						 .append( "					IFNULL(A.PT_WEIGHT,0) PT_WEIGHT, IFNULL(A.T_WEIGHT,0) T_WEIGHT, IFNULL(A.T_CNT,0) T_CNT, IFNULL(A.T_CBM,0) T_CBM, A.ORDER_NO, \n")
						 .append( "					A.ORDER_SEQ, A.REAMARK, A.CREATE_DT, A.CREATE_USR, A.UPDATE_DT, \n")
						 //2007.11.21  정영식 수정
						 //.append( "					A.UPDATE_USR, B.CUST_CD, C.VEND_NM, '남측' AS NAM, '' AS HANGUL \n")
					   .append( "					A.UPDATE_USR, B.CUST_CD, '' VEND_NM, '남측' AS NAM, '' AS HANGUL \n")
						 .append( "	FROM TRANSFER.LTPCKLSDT A \n")
						 .append( " LEFT JOIN TRANSFER.LTORDERMST B ON A.ORDER_NO = B.ORDER_NO \n")
						 .append( " LEFT JOIN ACCOUNT.GCZM_VENDER C ON B.cust_cd = C.VEND_CD \n")
						
						 .append( "  WHERE A.PL_NO IS NOT NULL ");

					if(str1 != null ) sql.append( " AND A.PL_NO = '" + str1 + "' " );

					//logger.dbg.println(this,sql.toString());

					sql.append( " ORDER BY  A.CAR_NO, A.ORDER_NO, INTEGER(A.ORDER_SEQ)  " );

					

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