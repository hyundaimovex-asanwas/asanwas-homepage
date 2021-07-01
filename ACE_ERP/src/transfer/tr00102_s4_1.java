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
public class tr00102_s4_1 extends HttpServlet {

	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement gstmt =null;
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

				String str1 = GauceReq.getParameter("v_str1");   //order No
				if (str1==null || str1.trim().length()==0 ) {   str1=""; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ORDER_NO","ORDER_SEQ","ARTC_CD","VIN_CODE", "STN_SZ","ARTC_NM",
																					"HSCODE","STN_SZNM","UNIT_PRICE", "ARTC_CNT","ARTC_UNIT",
																					"PRICE","LDCARGONM","LDCARGO","OFFCARGONM","OFFCARGO",
																					"PUNIT_CNT","PUNIT_UNIT","PUNIT_WGHT","PKG_LNGTH","PKG_HEIGHT",
																					"PKG_WIDTH","PKG_CBM","PKG_CNT","MIX_OTHERS","SAMEAS" //,
																				/*	"SETTLE_STS","CREATE_USR","UPDATE_USR","REGFILE","REGFILENAME",
																					"PKG_CBM_T","PUNIT_WGHT_T","HSCODENM","ENG_ARTCNM","VIN_CODE",

																					"GBN_LDCARGO","GBN_OFFCARGO","GBN_ENG_ARTCNM","GBN_HSCODE",//"GBN_HSCODENM",
																					"GBN_ARTC_NM","GBN_STN_SZNM","GBN_ARTC_UNIT","GBN_ARTC_CNT","GBN_UNIT_PRICE",
																					"GBN_PRICE","GBN_CUR_CODE","GBN_FR_UNTPRCE","GBN_FR_PRICE","GBN_PUNIT_CNT",
																					"GBN_PUNIT_WGHT","GBN_PKG_LNGTH","GBN_PKG_WIDTH","GBN_PKG_HEIGHT","GBN_PKG_CBM",
																					"GBN_PKG_CNT","GBN_LDCARGONM","GBN_OFFCARGONM","GBN_MIX_OTHERS","GBN_SAMEAS",
																					"GBN_JEBSU","CANCLE_STS",
																					"DARM1", "DARM2", "DARM3", "DARM4", "DARM5",
																					"DARM6", "DARM7", "DARM8", "DARM9", "DARM10",
																					"DARM11", "DARM12", "DARM13", "DARM14", "DARM15",
																					"DARM16", "DARM17", "DARM18", "DARM19", "DARM20",
																					"DARM21", "DARM22", "DARM23", "DARM24",
																					"FR_UNTPRCE","FR_PRICE","CUR_CODE" */

																				}; 

				int[] intArrCN = new int[] { 10,  4,  10,  20, 4, 100,  
																		 10, 30,  13,  13, 10,  
																		 13, 100, 10,  100,  10, 
																		 13, 10,  13,  13,  13,
																		 13, 13,  13,   1,   4, 20//,
															/*				1, 10,  10, 100,  30,
																		 13, 13, 100, 100,  20,

																			1,  1,   1,   1,   //1,
																			1,  1,   1,   1,   1,
																			1,  1,   1,   1,   1,
																			1,  1,   1,   1,   1,
																			1,  1,   1,   1,   1,
																			1, 10,

																			1,  1,   1,   1,   1,
																			1,  1,   1,   1,   1,
																			1,  1,   1,   1,   1,
																			1,  1,   1,   1,   1,
																			1,  1,   1,   1,
																		 13, 13,  10
*/
																		}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1,
																		 -1, -1,  2,  0, -1,  
																			2, -1, -1, -1, -1,
																			2, -1,  2,  2,  2,
																			2,  2,  2, -1, -1//, -1//,
																		 /*-1, -1, -1, -2, -1,
																			2,  2, -1, -1, -1,

																		 -1, -1, -1, -1, //-1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1,

																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1,
																			2,  2, -1
																			*/
																		 
																		}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						case -2 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_URL)); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				StringBuffer sql = new StringBuffer();

				sql.append( " SELECT \n" )
					 .append( "		A.ORDER_NO, A.ORDER_SEQ, A.ARTC_CD, , A.VIN_CODE, A.STN_SZ, A.ARTC_NM, \n" )
					 .append( "		A.HSCODE, A.STN_SZNM, A.UNIT_PRICE, A.ARTC_CNT, A.ARTC_UNIT,  \n" )
					 .append( "		A.PRICE, A.LDCARGONM, A.LDCARGO, \n" )
					 .append( "		A.OFFCARGONM, A.OFFCARGO, A.PUNIT_CNT, A.PUNIT_UNIT, \n" )
					 .append( "		A.PUNIT_WGHT, A.PKG_LNGTH, A.PKG_HEIGHT, A.PKG_WIDTH, \n" )
					 .append( "		A.PKG_CBM, A.PKG_CNT, '' MIX_OTHERS, '' SAMEAS \n" )
					/* .append( "		'' SETTLE_STS, A.CREATE_USR, A.UPDATE_USR, '' AS REGFILE, IFNULL(A.REGFILENAME,'') AS REGFILENAME, \n" )
					 .append( "		(A.PKG_CNT*A.PKG_CBM) PKG_CBM_T, (A.PUNIT_WGHT*A.PKG_CNT) PUNIT_WGHT_T, IFNULL(B.MINOR_NM,'') HSCODENM, A.ENG_ARTCNM, A.VIN_CODE, \n" )
					 .append( "   CASE WHEN A.LDCARGO      = C.LDCARGO      THEN 'Y' ELSE 'N' END GBN_LDCARGO     , \n ")
					 .append( "   CASE WHEN A.OFFCARGO     = C.OFFCARGO     THEN 'Y' ELSE 'N' END GBN_OFFCARGO    , \n ")
					 .append( "   CASE WHEN A.ENG_ARTCNM	 = C.ENG_ARTCNM	  THEN 'Y' ELSE 'N' END GBN_ENG_ARTCNM	 , \n ")
					 .append( "   CASE WHEN A.HSCODE		   = C.HSCODE		    THEN 'Y' ELSE 'N' END GBN_HSCODE		   , \n ")
					 .append( "   CASE WHEN A.ARTC_NM      = C.ARTC_NM      THEN 'Y' ELSE 'N' END GBN_ARTC_NM     , \n ")
					 .append( "   CASE WHEN A.STN_SZNM     = C.STN_SZNM     THEN 'Y' ELSE 'N' END GBN_STN_SZNM    , \n ")
					 .append( "   CASE WHEN A.ARTC_UNIT    = C.ARTC_UNIT    THEN 'Y' ELSE 'N' END GBN_ARTC_UNIT   , \n ")
					 .append( "   CASE WHEN A.ARTC_CNT     = C.ARTC_CNT     THEN 'Y' ELSE 'N' END GBN_ARTC_CNT    , \n ")
					 .append( "   CASE WHEN A.UNIT_PRICE   = C.UNIT_PRICE   THEN 'Y' ELSE 'N' END GBN_UNIT_PRICE  , \n ")
					 .append( "   CASE WHEN A.PRICE        = C.PRICE        THEN 'Y' ELSE 'N' END GBN_PRICE       , \n ")
					 .append( "   CASE WHEN A.CUR_CODE     = C.CUR_CODE     THEN 'Y' ELSE 'N' END GBN_CUR_CODE    , \n ")
					 .append( "   CASE WHEN A.FR_UNTPRCE   = C.FR_UNTPRCE   THEN 'Y' ELSE 'N' END GBN_FR_UNTPRCE , \n ")
					 .append( "   CASE WHEN A.FR_PRICE     = C.FR_PRICE     THEN 'Y' ELSE 'N' END GBN_FR_PRICE    , \n ")
					 .append( "   CASE WHEN A.PUNIT_CNT	   = C.PUNIT_CNT	  THEN 'Y' ELSE 'N' END GBN_PUNIT_CNT	 , \n ")
					 .append( "   CASE WHEN A.PUNIT_WGHT   = C.PUNIT_WGHT   THEN 'Y' ELSE 'N' END GBN_PUNIT_WGHT  , \n ")
					 .append( "   CASE WHEN A.PKG_LNGTH    = C.PKG_LNGTH    THEN 'Y' ELSE 'N' END GBN_PKG_LNGTH   , \n ")
					 .append( "   CASE WHEN A.PKG_WIDTH    = C.PKG_WIDTH    THEN 'Y' ELSE 'N' END GBN_PKG_WIDTH   , \n ")
					 .append( "   CASE WHEN A.PKG_HEIGHT   = C.PKG_HEIGHT   THEN 'Y' ELSE 'N' END GBN_PKG_HEIGHT  , \n ")
					 .append( "   CASE WHEN A.PKG_CBM      = C.PKG_CBM      THEN 'Y' ELSE 'N' END GBN_PKG_CBM     , \n ")
					 .append( "   CASE WHEN A.PKG_CNT      = C.PKG_CNT      THEN 'Y' ELSE 'N' END GBN_PKG_CNT     , \n ")
					 .append( "   CASE WHEN A.LDCARGONM    = C.LDCARGONM    THEN 'Y' ELSE 'N' END GBN_LDCARGONM   , \n ")
					 .append( "   CASE WHEN A.OFFCARGONM   = C.OFFCARGONM   THEN 'Y' ELSE 'N' END GBN_OFFCARGONM  , \n ")
					 .append( "   CASE WHEN A.MIX_OTHERS   = C.MIX_OTHERS   THEN 'Y' ELSE 'N' END GBN_MIX_OTHERS  , \n ")
					 .append( "   CASE WHEN A.SAMEAS       = C.SAMEAS       THEN 'Y' ELSE 'N' END GBN_SAMEAS,      \n ")
					 .append( "   'N' AS GBN_JEBSU, E.ETD_DT CANCLE_STS,      \n ")
					 .append( "   'Y' DARM1,  'Y' DARM2,  'Y' DARM3,  'Y' DARM4,  'Y' DARM5,       \n ")
					 .append( "   'Y' DARM6,  'Y' DARM7,  'Y' DARM8,  'Y' DARM9,  'Y' DARM10,       \n ")
					 .append( "   'Y' DARM11, 'Y' DARM12, 'Y' DARM13, 'Y' DARM14, 'Y' DARM15,       \n ")
					 .append( "   'Y' DARM16, 'Y' DARM17, 'Y' DARM18, 'Y' DARM19, 'Y' DARM20,       \n ")
					 .append( "   'Y' DARM21, 'Y' DARM22, 'Y' DARM23, 'Y' DARM24, IFNULL(A.FR_UNTPRCE,0) FR_UNTPRCE, IFNULL(A.FR_PRICE,0) FR_PRICE, D.MINORNM CUR_CODE  \n ") */
					 .append( "		FROM TRANSFER.LTORDERDTL A \n" )
//					 .append( "				 LEFT OUTER JOIN TRANSFER.LTHSCODE B ON A.HSCODE = B.MINOR_CD AND STS_CD = '1' \n ")
	//				 .append( "				 LEFT OUTER JOIN TRANSFER.BTORDERDTL C ON A.ORDER_NO = C.ORDER_NO AND A.ORDER_SEQ = C.ORDER_SEQ \n ")
	//				 .append( "        LEFT OUTER JOIN TRANSFER.LTLCODE D ON A.CUR_CODE = D.MINORCD AND D.MAJORCD = '0022', \n ")
	//				 .append( "				 TRANSFER.LTORDERMST E \n")
					 .append( "  WHERE A.ORDER_NO IS NOT NULL \n" )
	//				 .append( "    AND A.ORDER_NO = E.ORDER_NO \n")
					 .append( "		 AND A.ORDER_NO || A.ORDER_SEQ IN (" + str1 + ") \n" )
					 .append( "	 ORDER BY A.ORDER_NO, INTEGER(A.ORDER_SEQ) ");

				gstmt = conn.getGauceStatement(sql.toString());
				gstmt.executeQuery(dSet);

				logger.dbg.println(this,sql.toString());
/*********************************************************************************************/

			} catch(Exception e) {
		  	logger.err.println(this,e);
		  } finally {
				if (gstmt != null) try { gstmt.close(); } catch (Exception e) {}
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