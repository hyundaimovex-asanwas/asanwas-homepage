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
public class dsLoadlst3 extends HttpServlet {
 
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
				
				String str1 = GauceReq.getParameter("gstr1");                    //차량번호
					if (str1==null || str1.trim().length()==0 ) {   str1=null; } 
			 	String str2 = GauceReq.getParameter("gstr2");                    //주문번호 
					if (str2==null || str2.trim().length()==0 ) {   str2=null; }    
				String str3 = GauceReq.getParameter("gstr3");                    //반출일자
					if (str3==null || str3.trim().length()==0 ) {   str3=null; }
				String str4 = GauceReq.getParameter("gstr4");                    //업체명
					if (str4==null || str4.trim().length()==0 ) {   str4=null; }
				String str5 = GauceReq.getParameter("gstr5");                    //반입,반출
					if (str5==null || str5.trim().length()==0 ) {   str5=null; }
				String str6 = GauceReq.getParameter("gstr6");                    //사업명 
					if (str6==null || str6.trim().length()==0 ) {   str6=null; }
				String str7 = GauceReq.getParameter("gstr7");                    //배정번호
					if (str7==null || str7.trim().length()==0 ) {   str7=null; }

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
                                          "ARTC_UNIT","ARTC_UNITNM"
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
                                      4,  50

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
					                            -1, -1
																		}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (isNotOnlyHeader) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT '' CHK,  \n");
					sql.append( "         CASE WHEN B.ORDER_NO IS NULL OR RTRIM(A.ORDER_NO) = '' THEN '혼재'  \n");
					sql.append( "              WHEN C.CARGO_TYPE = '0001' THEN '일반(단독)'                   \n");
					sql.append( "              WHEN C.CARGO_TYPE = '0003' THEN '탁송'                         \n");
					sql.append( "              WHEN C.CARGO_TYPE = '0004' THEN '건설기계'                     \n");
					sql.append( "         ELSE '일반' END AS CARGO_TYPE,                                      \n");
					sql.append( "         B.CARTYPENO, E.CAR_NAME, A.CAR_NO, C.SHIPPER,D.VEND_NM AS SHIPPNM,  \n");
					sql.append( "         G.ARTC_NM, A.ARTC_CNT,                                            \n");
          sql.append( "       (SELECT IFNULL(SUM(Y.ARTC_CNT),0)                  \n");
					sql.append( "         FROM TRANSFER.LTINWRHS Y                         \n");
					sql.append( "        WHERE Y.ORDER_NO = A.ORDER_NO                     \n");
					sql.append( "          AND Y.ORDER_SEQ = A.ORDER_SEQ) AS IN_ARTC_CNT,  \n");
					sql.append( "         ((SELECT IFNULL(SUM(Y.ARTC_CNT),0)            \n");
					sql.append( "            FROM TRANSFER.LTINWRHS Y        \n");
					sql.append( "           WHERE Y.ORDER_NO = A.ORDER_NO     \n");
					sql.append( "             AND Y.ORDER_SEQ = A.ORDER_SEQ)- \n"); 
					sql.append( "         (SELECT IFNULL(SUM(X.ARTC_CNT),0)                      \n");
					sql.append( "            FROM TRANSFER.LTLOADLST X                            \n");
					sql.append( "           WHERE X.ORDER_NO = A.ORDER_NO                        \n");
					sql.append( "             AND X.ORDER_SEQ = A.ORDER_SEQ)) AS EXT_ARTC_CNT,    \n");
					sql.append( "         A.TOTAL_CBM, A.TOTAL_WEIGHT,                                        \n");
          sql.append( "         B.LD_CARGO, B.LD_CARGONM,B.OFF_CARGO, B.OFF_CARGONM,                \n");
					sql.append( "         A.ORDER_NO, A.ORDER_SEQ ,A.CAR_SEQ_NO, C.ETD_DT, F.PERSON_NO,        \n");
					sql.append( "         A.EDI_STS,                          \n");
					sql.append( "					A.PKG_LNGTH, A.PKG_HEIGHT,A.PKG_WIDTH, A.PUNIT_CNT,A.PUNIT_WEIGHT, \n");
					sql.append( "					A.STS_CODE,A.UPEND_DT,A.UPEND_TIME,A.REMARK,A.BAECHA_NO,        \n");
					sql.append( "					A.ENTER_NO,A.CREATE_DT,A.CREATE_USR,A.PKG_CNT,A.EDT_DATE,       \n");
					sql.append( "					A.UPDATE_DT,A.UPDATE_UST,    \n");
          sql.append( "					A.ORDER_NO, A.ORDER_SEQ, A.CAR_SEQ_NO,G.ARTC_UNIT, H.MINORNM AS ARTC_UNITNM \n");
					sql.append( "    FROM TRANSFER.LTLOADLST A                                                \n");
					sql.append( "    LEFT JOIN TRANSFER.LTORDCAR B ON A.CAR_SEQ_NO = B.CAR_SEQ_NO             \n");
					sql.append( "    LEFT JOIN TRANSFER.LTORDERMST C ON A.ORDER_NO = C.ORDER_NO               \n");
					sql.append( "    LEFT JOIN ACCOUNT.GCZM_VENDER D ON C.SHIPPER = D.VEND_CD                 \n");
					sql.append( "    LEFT JOIN TRANSFER.LTCARTYPE E ON B.CARTYPENO = E.CAR_TYPE               \n");
					sql.append( "    LEFT JOIN TRANSFER.LTCARACC F ON B.CAR_SEQ_NO = F.CAR_SEQ_NO AND B.IN_OUT = F.ACCSECTION   \n");
					sql.append( "    LEFT JOIN TRANSFER.LTORDERDTL G ON A.ORDER_NO = G.ORDER_NO AND A.ORDER_SEQ = G.ORDER_SEQ   \n");
					sql.append( "    LEFT JOIN TRANSFER.LTLCODE H ON G.ARTC_UNIT = H.MINORCD  AND H.MAJORCD='0008'              \n");
          sql.append( "   WHERE 1=1  \n");
					
					if(str1 != null ){ sql.append( "  AND A.CAR_NO = '" +str1 + "' \n" ) ;  }
					if(str2 != null ){ sql.append( "  AND A.ORDER_NO = '" + str2 + "' \n" ) ;  }
					if(str3 != null ){ sql.append( "  AND C.ETD_DT = '" + str3 + "' \n" ) ;  }
					if(str4 != null ){ sql.append( "  AND D.VEND_NM LIKE '%" + str4 + "%' \n" ) ;  }
					if(str5 != null ){ sql.append( "  AND B.IN_OUT = '" + str5 + "' \n" ) ; } 
					if(str6 != null ){ sql.append( "  AND C.LINE_PART = '" + str6 + "' \n" ) ; }
					if(str7 != null ){ sql.append( "  AND A.CAR_SEQ_NO = '" + str7 + "' \n" ) ; }

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