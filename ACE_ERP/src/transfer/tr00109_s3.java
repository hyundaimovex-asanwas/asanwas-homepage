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
public class tr00109_s3 extends HttpServlet {
 
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

				String str1 = GauceReq.getParameter("v_str1");   //프로젝트 
					if (str1==null || str1.trim().length()==0 ) {   str1=null; } 
				String str2 = GauceReq.getParameter("v_str2");   //반출입일자 FR
					if (str2==null || str2.trim().length()==0 ) {   str2=null; }
				String str3 = GauceReq.getParameter("v_str3");   //반출입일자 TO
					if (str3==null || str3.trim().length()==0 ) {   str3=null; }
				String str4 = GauceReq.getParameter("v_str4");   //품명 
					if (str4==null || str4.trim().length()==0 ) {   str4=null; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{	"CRDT",        "ETD_DT",    "SHIPPER",    "SHIPPNM",  // "CAR_NO",
																				  "ARTC_NM",     "ARTC_CNT",  "ARTC_UNIT",  "ARTC_UNITNM","TOTAL_CBM",
					                                "TOTAL_WEIGHT","PKG_LNGTH", "PKG_HEIGHT", "PKG_WIDTH",  "ENTER_DATE", 
					                                "ENTER_NO",    "ORDER_NO",  "ORDER_SEQ",  "ENTER_STS", "CHK" ,
																					"CARTYPENO",   "CAR_NAME",  "CAR_SEQ_NO", "IN_ARTC_CNT","EXT_ARTC_CNT",
																				  "OLD_ARTC_CNT", "B_ARTC_CNT"
				}; 

				int[] intArrCN = new int[] {	8,  8, 13,  62, // 20,
																		 50, 13,  4,  50,  13,
																		 13, 13, 13,  13,   8,
																			8, 10,  4,  10,   1,  
																			4, 30, 10,  13,  13,
                                     13, 13
																		}; 
			
				int[] intArrCN2 = new int[]{	-1, -1, -1, -1, //-1,
																			-1,  2, -1, -1,  2,
																			 2,  2,  2,  2, -1,
																			-1, -1, -1, -1,  0,
																			-1, -1, -1,  2,  2,
                                       2,  2
																		};

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				StringBuffer sql = new StringBuffer();
				//주문번호 1건에 배정 1건인경우 
				sql.append( " SELECT REPLACE(CAST(CAST(C.CREATE_DT AS DATE) AS VARCHAR(10)),'-','') AS CRDT, \n");
				sql.append( "        B.ETD_DT, C.SHIPPER, G.VEND_NM AS SHIPPNM, --F.CAR_NO,                  \n");
				sql.append( "        A.ARTC_NM,            \n");
				sql.append( "        (SELECT IFNULL(SUM(Z.ARTC_CNT),0) FROM TRANSFER.LTINWRHS Z  \n");
				sql.append( "          WHERE Z.ORDER_NO = A.ORDER_NO                             \n");
				sql.append( "        	  AND Z.ORDER_SEQ = A.ORDER_SEQ) AS ARTC_CNT,             \n");
				sql.append( "        B.ARTC_UNIT, H.MINORNM AS ARTC_UNITNM, \n");

				sql.append( "        A.TOTAL_CBM, A.TOTAL_WEIGHT, A.PKG_LNGTH, A.PKG_HEIGHT, A.PKG_WIDTH,    \n");
				sql.append( "        A.ENTER_DATE, A.ENTER_NO, A.ORDER_NO, A.ORDER_SEQ,  A.ENTER_STS,        \n");
				sql.append( "        C.CARGO_TYPE, 0 CHK , J.CAR_SEQ_NO, J.CARTYPENO, K.CAR_NAME,            \n");
				sql.append( "        (SELECT IFNULL(SUM(Y.ARTC_CNT),0)                               \n");
				sql.append( "            FROM TRANSFER.LTLOADLST Y                                   \n");
				sql.append( "           WHERE Y.ORDER_NO = A.ORDER_NO                                \n");
				sql.append( "             AND Y.ORDER_SEQ = A.ORDER_SEQ) AS OLD_ARTC_CNT,             \n");
				sql.append( "        A.ARTC_CNT-(SELECT IFNULL(SUM(Y.ARTC_CNT),0)                    \n");
				sql.append( "                      FROM TRANSFER.LTLOADLST Y                         \n");
				sql.append( "                     WHERE Y.ORDER_NO = A.ORDER_NO                      \n");
				sql.append( "                       AND Y.ORDER_SEQ = A.ORDER_SEQ                    \n");
				sql.append( "                       AND Y.ENTER_NO = A.ENTER_NO) AS EXT_ARTC_CNT,   \n");
				sql.append( "        0 AS IN_ARTC_CNT, I.ARTC_CNT AS B_ARTC_CNT   \n");
				sql.append( "   FROM TRANSFER.LTINWRHS A                                                                  \n");
				sql.append( "   LEFT JOIN TRANSFER.LTORDERDTL B ON A.ORDER_NO = B.ORDER_NO AND A.ORDER_SEQ = B.ORDER_SEQ  \n");
				sql.append( "   LEFT JOIN TRANSFER.LTORDERMST C ON A.ORDER_NO = C.ORDER_NO                                \n");
				sql.append( "   LEFT JOIN TRANSFER.LTCUSTMST G ON C.SHIPPER = G.VEND_CD                                   \n");
				sql.append( "   LEFT JOIN TRANSFER.LTLCODE H ON B.ARTC_UNIT = H.MINORCD AND H.MAJORCD='0008'              \n");
				sql.append( "   LEFT JOIN TRANSFER.LTCARGOODS I ON A.ORDER_NO = I.ORDER_NO AND A.ORDER_SEQ = I.ORDER_SEQ \n");
				sql.append( "   LEFT JOIN TRANSFER.LTORDCAR J ON I.CAR_SEQ_NO = J.CAR_SEQ_NO  \n");
				sql.append( "   LEFT JOIN TRANSFER.LTCARTYPE K ON J.CARTYPENO = K.CAR_TYPE,  \n");
        sql.append( "   (SELECT I.ORDER_NO, I.ORDER_SEQ, COUNT(*) CNT                                               \n"); 
 				sql.append( "      FROM TRANSFER.LTCARGOODS I                                                               \n"); 
				sql.append( "      LEFT JOIN TRANSFER.LTORDERDTL B ON I.ORDER_NO = B.ORDER_NO AND I.ORDER_SEQ = B.ORDER_SEQ \n"); 
				sql.append( "     WHERE B.ETD_DT BETWEEN  '" +str2 + "' AND '" + str3 + "'                                  \n"); 
				sql.append( "     GROUP BY I.ORDER_NO, I.ORDER_SEQ                                                          \n"); 
				sql.append( "    HAVING COUNT(*)=1 ) W                                                                      \n"); 

			  //sql.append( "   LEFT JOIN TRANSFER.LTCARTYPE I ON E.CARTYPENO = I.CAR_TYPE                                \n");
				sql.append( "  WHERE A.ENTER_STS<>'99'                                                                     \n");
        sql.append( "    AND A.ORDER_NO = W.ORDER_NO AND A.ORDER_SEQ = W.ORDER_SEQ \n");
				if(str1 != null)	sql.append( " AND C.LINE_PART= '" + str1 + "' ");
				if(str2 !=null && str3 !=null ){ sql.append(" AND B.ETD_DT BETWEEN  '" +str2 + "' AND '" + str3 + "'");}
				if(str4 != null)	sql.append( " AND A.ARTC_NM LIKE '" + str4 + "%' ");

				sql.append( "   UNION ALL \n");
				sql.append( "   SELECT REPLACE(CAST(CAST(C.CREATE_DT AS DATE) AS VARCHAR(10)),'-','') AS CRDT,                         \n");
				sql.append( "           B.ETD_DT, C.SHIPPER, G.VEND_NM AS SHIPPNM, --F.CAR_NO,                                         \n");
				sql.append( "           A.ARTC_NM,                                   \n");
				sql.append( "        (SELECT IFNULL(SUM(Z.ARTC_CNT),0) FROM TRANSFER.LTINWRHS Z  \n");
				sql.append( "          WHERE Z.ORDER_NO = A.ORDER_NO                             \n");
				sql.append( "        	  AND Z.ORDER_SEQ = A.ORDER_SEQ) AS ARTC_CNT,             \n");
				sql.append( "           B.ARTC_UNIT, H.MINORNM AS ARTC_UNITNM,                                  \n");
				sql.append( "           A.TOTAL_CBM, A.TOTAL_WEIGHT, A.PKG_LNGTH, A.PKG_HEIGHT, A.PKG_WIDTH,                           \n");
				sql.append( "           A.ENTER_DATE, A.ENTER_NO, A.ORDER_NO, A.ORDER_SEQ,  A.ENTER_STS,                               \n");
				sql.append( "           C.CARGO_TYPE, 0 CHK , ''CAR_SEQ_NO, ''CARTYPENO, W.CAR_NAME||'외' CAR_NAME,                    \n");
				sql.append( "           (SELECT IFNULL(SUM(Y.ARTC_CNT),0)                                                              \n");
				sql.append( "               FROM TRANSFER.LTLOADLST Y                                                                  \n");
				sql.append( "              WHERE Y.ORDER_NO = A.ORDER_NO                                                               \n");
				sql.append( "                AND Y.ORDER_SEQ = A.ORDER_SEQ) AS OLD_ARTC_CNT,                                           \n");
				sql.append( "           A.ARTC_CNT-(SELECT IFNULL(SUM(Y.ARTC_CNT),0)                                                   \n");
				sql.append( "                         FROM TRANSFER.LTLOADLST Y                                                        \n");
				sql.append( "                        WHERE Y.ORDER_NO = A.ORDER_NO                                                     \n");
				sql.append( "                          AND Y.ORDER_SEQ = A.ORDER_SEQ                                                   \n");
				sql.append( "                          AND Y.ENTER_NO = A.ENTER_NO) AS EXT_ARTC_CNT,                                 \n");
				sql.append( "           0 AS IN_ARTC_CNT, W.ARTC_CNT AS B_ARTC_CNT                                                     \n");
				sql.append( "      FROM TRANSFER.LTINWRHS A                                                                            \n");
				sql.append( "      LEFT JOIN TRANSFER.LTORDERDTL B ON A.ORDER_NO = B.ORDER_NO AND A.ORDER_SEQ = B.ORDER_SEQ            \n");
				sql.append( "      LEFT JOIN TRANSFER.LTORDERMST C ON A.ORDER_NO = C.ORDER_NO                                          \n");
				sql.append( "      LEFT JOIN TRANSFER.LTCUSTMST G ON C.SHIPPER = G.VEND_CD                                             \n");
				sql.append( "      LEFT JOIN TRANSFER.LTLCODE H ON B.ARTC_UNIT = H.MINORCD AND H.MAJORCD='0008',                       \n");
				sql.append( "      (SELECT I.ORDER_NO, I.ORDER_SEQ, COUNT(*) CNT, MAX(K.CAR_NAME) CAR_NAME, SUM(I.ARTC_CNT) ARTC_CNT   \n");
				sql.append( "         FROM TRANSFER.LTCARGOODS I                                                                       \n");
				sql.append( "         LEFT JOIN TRANSFER.LTORDERDTL B ON I.ORDER_NO = B.ORDER_NO AND I.ORDER_SEQ = B.ORDER_SEQ         \n");
				sql.append( "         LEFT JOIN TRANSFER.LTORDCAR J ON I.CAR_SEQ_NO = J.CAR_SEQ_NO                                     \n");
				sql.append( "         LEFT JOIN TRANSFER.LTCARTYPE K ON J.CARTYPENO = K.CAR_TYPE                                       \n");
				sql.append( "        WHERE B.ETD_DT BETWEEN  '" +str2 + "' AND '" + str3 + "'                                          \n");
				sql.append( "        GROUP BY I.ORDER_NO, I.ORDER_SEQ                                                                  \n");
				sql.append( "      HAVING COUNT(*)>1                                                                                   \n");
				sql.append( "      ) W                                                                                                 \n");
			  sql.append( "  WHERE A.ENTER_STS<>'99'                                                                     \n");
        sql.append( "    AND A.ORDER_NO = W.ORDER_NO AND A.ORDER_SEQ = W.ORDER_SEQ \n");
				if(str1 != null)	sql.append( " AND C.LINE_PART= '" + str1 + "' ");
				if(str2 !=null && str3 !=null ){ sql.append(" AND B.ETD_DT BETWEEN  '" +str2 + "' AND '" + str3 + "'");}
				if(str4 != null)	sql.append( " AND A.ARTC_NM LIKE '" + str4 + "%' ");

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