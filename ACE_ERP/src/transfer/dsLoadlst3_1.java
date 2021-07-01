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
public class dsLoadlst3_1 extends HttpServlet {
 
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
				
				String str1 = GauceReq.getParameter("gstr1");                    //배정번호
			 	String str2 = GauceReq.getParameter("gstr2");                    //반출일자 
				String str3 = GauceReq.getParameter("gstr3");                    //주문번호
				String str4 = GauceReq.getParameter("gstr4");                    //거래처
				String str5 = GauceReq.getParameter("gstr5");                    //사업명
				String str6 = GauceReq.getParameter("gstr6");                    //반출구분코드 

			  if(str1==null) str1="";
				if(str2==null) str2="";
				if(str3==null) str3="";
				if(str4==null) str4="";
				if(str5==null) str5="";
				if(str6==null) str6="";
			
				GauceRes.enableFirstRow(dSet);

       String[] strArrCN = new String[]{	"CHK","CARGO_TYPE","CARTYPENO","CAR_NAME","CAR_NO",
					                                "SHIPPER","SHIPPNM","ARTC_NM","ARTC_CNT","IN_ARTC_CNT","EXT_ARTC_CNT",
					                                "TOTAL_CBM","TOTAL_WEIGHT","LD_CARGO","LD_CARGONM","OFF_CARGO",
					                                "OFF_CARGONM","ORDER_NO","ORDER_SEQ","CAR_SEQ_NO","ETD_DT",
					                                "PERSON_NO", "EDI_STS", 
					                                "PKG_LNGTH","PKG_HEIGHT","PKG_WIDTH", "PUNIT_CNT","PUNIT_WEIGHT",
					                                "STS_CODE","UPEND_DT","UPEND_TIME","REMARK","BAECHA_NO",
					                                "ENTER_NO","CREATE_DT","CREATE_USR","PKG_CNT","EDT_DATE",
					                                "UPDATE_DT","UPDATE_UST",
                                          "ARTC_UNIT"
																				}; 

				int[] intArrCN = new int[] {	1, 20,  4, 30, 20, 
					                           13, 62,100, 13, 13, 13,
                                     13, 13, 10,150, 10,
                                    150, 10,  4, 10,  8,
					                           20,  1, 
					                           13, 13, 13, 13, 13,
					                            1,  8,  4,512, 20,
					                            8, 10, 10, 13, 10,
					                           10, 10,
                                      4

																		}; 
			
				int[] intArrCN2 = new int[]{	-1, -1, -1, -1, -1,
																			-1, -1, -1,  2,  2, 2,
																			 2,  2, -1, -1, -1,
																			-1, -1, -1, -1, -1,
																	  	-1, -1, 
					                             2,  2,  2,  2,  2,
					                            -1, -1, -1, -1, -1,
					                            -1, -1, -1,  3, -1, 
					                            -1, -1, 
					                            -1
																		}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (isNotOnlyHeader) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT    \n");
          sql.append( "  ''CHK,  ''CARGO_TYPE,'' CARTYPENO, ''CAR_NAME,'' CAR_NO,                                                                                                \n");
					sql.append( "  ''SHIPPER , ''SHIPPNM , G.ARTC_NM ,  COALESCE(SUM(A.ARTC_CNT),0) ARTC_CNT, COALESCE(MAX(X.IN_ARTC_CNT),0)IN_ARTC_CNT, COALESCE(MAX(X.IN_ARTC_CNT),0)-COALESCE(SUM(A.ARTC_CNT),0) EXT_ARTC_CNT,           \n");
          sql.append( "  0 TOTAL_CBM , COALESCE(MAX(A.TOTAL_WEIGHT),0)TOTAL_WEIGHT , ''LD_CARGO , ''LD_CARGONM , ''OFF_CARGO ,                                                               \n");
					sql.append( "  ''OFF_CARGONM , A.ORDER_NO, A.ORDER_SEQ, A.CAR_SEQ_NO , ''ETD_DT ,                                                                                      \n");
          sql.append( "  ''PERSON_NO , '' EDI_STS ,                                                                                                                              \n");
					sql.append( "  COALESCE(MAX(A.PKG_LNGTH),0)PKG_LNGTH, COALESCE(MAX(A.PKG_HEIGHT),0)PKG_HEIGHT, COALESCE(MAX(A.PKG_WIDTH),0)PKG_WIDTH,  0 PUNIT_CNT , 0 PUNIT_WEIGHT ,                                        \n");
					sql.append( "  ''STS_CODE , ''UPEND_DT , ''UPEND_TIME , ''REMARK , ''BAECHA_NO ,                                                                                       \n");
					sql.append( "  ''ENTER_NO , ''CREATE_DT , ''CREATE_USR , 0 PKG_CNT , '' EDT_DATE ,                                                                                     \n");
          sql.append( "  ''UPDATE_DT ,''UPDATE_UST ,                                                                                                                             \n");
					sql.append( "  G.ARTC_UNIT                                                                 \n");
          sql.append( "    FROM TRANSFER.LTLOADLST A                                                                                \n");
					sql.append( "    LEFT JOIN ( SELECT B.ORDER_NO, B.ORDER_SEQ, SUM(B.ARTC_CNT) IN_ARTC_CNT                                  \n");
          sql.append( "                  FROM TRANSFER.LTINWRHS B                                                                   \n");
					sql.append( "                  LEFT JOIN TRANSFER.LTCARGOODS Y ON B.ORDER_NO = Y.ORDER_NO AND B.ORDER_SEQ = Y.ORDER_SEQ   \n");
					sql.append( "                  LEFT JOIN TRANSFER.LTORDERMST C ON B.ORDER_NO = C.ORDER_NO   \n");
    			sql.append( "                  LEFT JOIN ACCOUNT.GCZM_VENDER D ON C.SHIPPER = D.VEND_CD     \n");
					sql.append( "                 WHERE 1=1                                                     \n");
					if(!str1.equals(""))sql.append( "  AND Y.CAR_SEQ_NO = '" + str1 + "'  \n");
					if(!str2.equals(""))sql.append( "  AND C.ETD_DT = '" + str2 + "'      \n");
					if(!str3.equals(""))sql.append( "  AND A.ORDER_NO = '" + str3 + "'    \n");
					if(!str4.equals(""))sql.append( "  AND D.VEND_NM LIKE '" + str4 + "%' \n"); 
          if(!str5.equals(""))sql.append( "  AND C.LINE_PART = '" + str5 + "'   \n");
					if(!str6.equals(""))sql.append( "  AND C.IN_OUT = '" + str6 + "'      \n"); 
					sql.append( "                 GROUP BY B.ORDER_NO, B.ORDER_SEQ                                                            \n");
          sql.append( "               ) X ON X.ORDER_NO = A.ORDER_NO AND X.ORDER_SEQ=A.ORDER_SEQ                                    \n");
					sql.append( "    LEFT JOIN TRANSFER.LTORDERDTL G ON A.ORDER_NO = G.ORDER_NO AND A.ORDER_SEQ = G.ORDER_SEQ                 \n");
          sql.append( "    LEFT JOIN TRANSFER.LTORDERMST C ON A.ORDER_NO = C.ORDER_NO \n");
					sql.append( "    LEFT JOIN ACCOUNT.GCZM_VENDER D ON C.SHIPPER = D.VEND_CD   \n");
					sql.append( "   WHERE 1=1                                                                                                 \n");
					if(!str1.equals(""))sql.append( "  AND A.CAR_SEQ_NO = '" + str1 + "'  \n");
					if(!str2.equals(""))sql.append( "  AND C.ETD_DT = '" + str2 + "'      \n" );
					if(!str3.equals(""))sql.append( "  AND A.ORDER_NO = '" + str3 + "'    \n");
					if(!str4.equals(""))sql.append( "  AND D.VEND_NM LIKE '" + str4 + "%' \n" ); 
          if(!str5.equals(""))sql.append( "  AND C.LINE_PART = '" + str5 + "'   \n" );
					if(!str6.equals(""))sql.append( "  AND C.IN_OUT = '" + str6 + "'      \n" ); 
					sql.append( "   GROUP BY A.CAR_SEQ_NO, A.ORDER_NO, A.ORDER_SEQ, G.ARTC_NM,G.ARTC_UNIT                                                  \n");

					sql.append( "   ORDER BY A.ORDER_NO, INTEGER(A.ORDER_SEQ), G.ARTC_NM                                                 \n");

          logger.dbg.println(this,"JYS:::"+sql.toString());

					stmt = conn.getGauceStatement(sql.toString());
	 				stmt.executeQuery(dSet);
				}
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