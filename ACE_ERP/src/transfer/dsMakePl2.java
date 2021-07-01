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
public class dsMakePl2 extends HttpServlet {
 
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
					if (str0==null || str0.trim().length()==0 ) {   str0=null; }
				String str1 = GauceReq.getParameter("gstr1");   
					if (str1==null || str1.trim().length()==0 ) {   str1=null; }
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ORDER_NO","ORDER_SEQ","CAR_NO","ARTC_CD","ARTC_NM",
																					"PUNIT_CNT","STN_SZNM","HSCODE","ARTC_CNT","ARTC_UNIT",
																					"UNIT_PRICE","PRICE1","PUNIT_CNT1","PUNIT_WEIGHT","PKG_LNGTH",
																					"PKG_HEIGHT","PKG_WIDTH","CBM","PUNIT_UNIT","TOTAL_WEIGHT1",
																					"TOTAL_WEIGHT2","TOTAL_WEIGHT","PKG_CNT1","TOTAL_CBM"
																				}; 

				int[] intArrCN = new int[] {	10,  4, 20, 20, 50, 
																			13, 50, 10, 13, 10,
																			13, 13, 13, 13, 13, 
																			13, 13, 13, 10, 13,
																			13, 13, 13, 13 
																		}; 
			
				int[] intArrCN2 = new int[]{	-1, -1, -1, -1, -1,
																			 3, -1, -1,  3, -1,
																			 3,  3,  3,  3,  3,
																			 3,  3,  3, -1,  3,
																			 3,  3,  3,  3
																		}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (isNotOnlyHeader) {					
					StringBuffer sql = new StringBuffer();
					/****
					2008.04.02
					sql.append( " SELECT  A.ORDER_NO, A.ORDER_SEQ,IFNULL(C.CAR_NO,'') AS CAR_NO, \n")
						 .append( "					A.ARTC_CD, A.ARTC_NM , IFNULL(B.PUNIT_CNT,0) AS PUNIT_CNT, \n")
						 .append( "					A.STN_SZNM,A.HSCODE, \n")
						 .append( "					IFNULL(B.ARTC_CNT,0) AS ARTC_CNT,A.ARTC_UNIT,A.UNIT_PRICE, \n")
						//.append( "					A.PRICE AS PRICE1, \n")
						 .append( "					FLOAT(IFNULL(IFNULL(B.ARTC_CNT,0)*CASE WHEN A.UNIT_PRICE IS NULL OR A.UNIT_PRICE=0 THEN 1 ELSE A.UNIT_PRICE END,0)) AS PRICE1, \n")
						 .append( "					IFNULL(B.PUNIT_CNT,0) AS PUNIT_CNT1,IFNULL(B.PUNIT_WEIGHT,0) AS PUNIT_WEIGHT, \n")
						 .append( "					IFNULL(B.PKG_LNGTH,0) AS PKG_LNGTH, IFNULL(B.PKG_HEIGHT,0) AS PKG_HEIGHT, \n")
						 .append( "					IFNULL(B.PKG_WIDTH,0) AS PKG_WIDTH, \n")
						 .append( "					FLOAT(TRIM(T '0' FROM CHAR(IFNULL(ROUND(B.PKG_LNGTH * B.PKG_HEIGHT*B.PKG_WIDTH/1000000,2),0)))) AS CBM, \n")
						 .append( "					A.PUNIT_UNIT,B.TOTAL_WEIGHT AS  TOTAL_WEIGHT1,B.TOTAL_WEIGHT AS TOTAL_WEIGHT2, IFNULL(B.TOTAL_WEIGHT,0) AS TOTAL_WEIGHT, \n")
						 .append( "					FLOAT(TRIM(T '0' FROM CHAR(IFNULL(B.ARTC_CNT/CASE WHEN \n")
						 .append( "					B.PUNIT_CNT IS NULL OR B.PUNIT_CNT = 0 THEN 1 ELSE B.PUNIT_CNT END,0)))) AS PKG_CNT1, \n")
						 .append( "					IFNULL(B.TOTAL_CBM,0) AS TOTAL_CBM \n")
						 .append( "		FROM	TRANSFER.LTORDERDTL A , \n")
						 .append( "		 			TRANSFER.LTLOADLST B  , \n")
						 .append( "		 			TRANSFER.LTCARACC C \n")
						 .append( "	 WHERE A.ORDER_NO IS NOT NULL \n")
						 .append( "		 AND B.ORDER_NO IS NOT NULL \n")
						 .append( "		 AND B.ORDER_SEQ IS NOT NULL \n")
						 .append( "		 AND A.ORDER_NO = B.ORDER_NO \n")
						 .append( "		 AND A.ORDER_SEQ = B.ORDER_SEQ \n")
						 .append( "		 AND B.CAR_SEQ_NO = C.CAR_SEQ_NO \n")
						 .append( "		 AND ACCSECTION = '" + str0 + "' \n")
						 .append( "		 AND A.ORDER_NO = '" + str1 + "' \n");

           ***/

					//logger.dbg.println(this, sql.toString());

					sql.append( " SELECT  X.CAR_SEQ_NO,                                                                                                                                 \n")
						 .append( "	        A.ORDER_NO,                                                                                                                                   \n")
						 .append( "	        A.ORDER_SEQ,                                                                                                                                  \n")
						 .append( "	        IFNULL(C.CAR_NO,'') AS CAR_NO,                                                                                                                \n")
						 .append( "	        A.ARTC_CD,                                                                                                                                    \n")
						 .append( "	        A.ARTC_NM ,                                                                                                                                   \n")
						 .append( "	        IFNULL(X.PUNIT_CNT,0) AS PUNIT_CNT,                                                                                                           \n")
						 .append( "	        A.STN_SZNM,                                                                                                                                   \n")
						 .append( "	        A.HSCODE,                                                                                                                                     \n")
						 .append( "	        IFNULL(X.ARTC_CNT,0) AS ARTC_CNT,                                                                                                             \n")
						 .append( "	        A.ARTC_UNIT,                                                                                                                                  \n")
						 .append( "	        A.UNIT_PRICE,                                                                                                                                 \n")
						 .append( "	        FLOAT(IFNULL(IFNULL(X.ARTC_CNT,0)* CASE WHEN A.UNIT_PRICE IS NULL OR A.UNIT_PRICE=0 THEN 1 ELSE A.UNIT_PRICE END,0)) AS PRICE1,               \n")
						 .append( "	        IFNULL(X.PUNIT_CNT,0) AS PUNIT_CNT1,                                                                                                          \n")
						 .append( "	        IFNULL(X.PUNIT_WEIGHT,0) AS PUNIT_WEIGHT,                                                                                                     \n")
						 .append( "	        IFNULL(X.PKG_LNGTH,0) AS PKG_LNGTH,                                                                                                           \n")
						 .append( "	        IFNULL(X.PKG_HEIGHT,0) AS PKG_HEIGHT,                                                                                                         \n")
						 .append( "	        IFNULL(X.PKG_WIDTH,0) AS PKG_WIDTH,                                                                                                           \n")
						 .append( "	        FLOAT(TRIM(T '0' FROM CHAR(IFNULL(ROUND(X.PKG_LNGTH * X.PKG_HEIGHT*X.PKG_WIDTH/1000000,2),0)))) AS CBM,                                       \n")
						 .append( "	        A.PUNIT_UNIT,                                                                                                                                 \n")
						 .append( "	        X.TOTAL_WEIGHT AS  TOTAL_WEIGHT1,                                                                                                             \n")
						 .append( "	        X.TOTAL_WEIGHT AS TOTAL_WEIGHT2,                                                                                                              \n")
						 .append( "	        IFNULL(X.TOTAL_WEIGHT,0) AS TOTAL_WEIGHT,                                                                                                     \n")
						 .append( "	        FLOAT(TRIM(T '0' FROM CHAR(IFNULL(X.ARTC_CNT/CASE WHEN                                                                                        \n")
						 .append( "	        X.PUNIT_CNT IS NULL OR X.PUNIT_CNT = 0 THEN 1 ELSE X.PUNIT_CNT END,0)))) AS PKG_CNT1,                                                         \n")
						 .append( "	        IFNULL(X.TOTAL_CBM,0) AS TOTAL_CBM                                                                                                            \n")
						 .append( "	  FROM TRANSFER.LTORDERDTL A,                                                                                                                         \n")
						 .append( "	       ( SELECT CAR_SEQ_NO, ORDER_NO, ORDER_SEQ,                                                                                                      \n")
						 .append( "	            MAX(IFNULL(PUNIT_CNT,0)) AS PUNIT_CNT,                                                                                                    \n")
						 .append( "	            SUM(IFNULL(ARTC_CNT,0)) AS ARTC_CNT,                                                                                                      \n")
						 .append( "	            MAX(IFNULL(PUNIT_CNT,0)) AS PUNIT_CNT1,                                                                                                   \n")
						 .append( "	            MAX(IFNULL(PUNIT_WEIGHT,0)) AS PUNIT_WEIGHT,                                                                                              \n")
						 .append( "	            MAX(IFNULL(PKG_LNGTH,0)) AS PKG_LNGTH,                                                                                                    \n")
						 .append( "	            MAX(IFNULL(PKG_HEIGHT,0)) AS PKG_HEIGHT,                                                                                                  \n")
						 .append( "	            MAX(IFNULL(PKG_WIDTH,0)) AS PKG_WIDTH,                                                                                                    \n")
						 .append( "	            MAX(TOTAL_WEIGHT) AS  TOTAL_WEIGHT1,                                                                                                      \n")
						 .append( "	            MAX(TOTAL_WEIGHT) AS TOTAL_WEIGHT2,                                                                                                       \n")
						 .append( "	            MAX(IFNULL(TOTAL_WEIGHT,0)) AS TOTAL_WEIGHT,                                                                                              \n")
						 .append( "	            SUM(FLOAT(TRIM(T '0' FROM CHAR(IFNULL(ARTC_CNT/CASE WHEN PUNIT_CNT IS NULL OR PUNIT_CNT = 0 THEN 1 ELSE PUNIT_CNT END,0))))) AS PKG_CNT1, \n")
						 .append( "	            MAX(IFNULL(TOTAL_CBM,0)) AS TOTAL_CBM                                                                                                     \n")
						 .append( "	           FROM TRANSFER.LTLOADLST                                                                                                                    \n")
						 .append( "	          WHERE ORDER_NO = '" + str1 + "'                                                                                                              \n")
						 .append( "	          GROUP BY CAR_SEQ_NO, ORDER_NO, ORDER_SEQ                                                                                                    \n")
						 .append( "	       ) X,                                                                                                                                           \n")
						 .append( "	       TRANSFER.LTCARACC C                                                                                                                            \n")
						 .append( "	 WHERE A.ORDER_NO IS NOT NULL                                                                                                                         \n")
						 .append( "	   AND X.ORDER_NO IS NOT NULL                                                                                                                         \n")
						 .append( "	   AND X.ORDER_SEQ IS NOT NULL                                                                                                                        \n")
						 .append( "	   AND A.ORDER_NO = X.ORDER_NO                                                                                                                        \n")
						 .append( "	   AND A.ORDER_SEQ = X.ORDER_SEQ                                                                                                                      \n")
						 .append( "	   AND X.CAR_SEQ_NO = C.CAR_SEQ_NO                                                                                                                    \n")
						 .append( "		 AND ACCSECTION = '" + str0 + "' \n")
						 .append( "		 AND A.ORDER_NO = '" + str1 + "' \n");


						 
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