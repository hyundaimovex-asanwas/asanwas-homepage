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
public class tr00104_edi_2_r extends HttpServlet {
 
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
        String [] str = new String[6];

				str[0] = GauceReq.getParameter("v_str0");   //프로젝트 구분
				str[1] = GauceReq.getParameter("v_str1");   //1.주문배정, 2.상차예정
				str[2] = GauceReq.getParameter("v_str2");   //반출일자
				str[3] = GauceReq.getParameter("v_str3");   //전송여부 EDI_STS
				str[4] = GauceReq.getParameter("v_str4");   //반출입구분
        str[5] = GauceReq.getParameter("v_str5");   //상태여부 ING_STS

				for (int s=0;s<=5;s++) {
					if(str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{	"CHK",        "INGGB",      "EDI_STS",    "ING_STS", "ETD_DT",
					                                "ORDER_NO",   "CAR_SEQ_NO", "CARGO_TYPE", "CARGONM", "CUST_CD",
					                                "CUSTNM",     "SHIPPER",    "SHIPPERNM",  "LDCARGO", "LDCARGONM",
					                                "OFFCARGO",   "OFFCARGONM", "ARTC_CD",    "ARTC_NM", "ORDER_SEQ" ,
					                                "HL_EDI_STS", "HL_ING_STS",
                                          "LD_CARGO",   "LD_CARGO_NM", "LD_CARGONM", "OFF_CARGO",  "OFF_CARGO_NM", "OFF_CARGONM",
					                                "SHIPPERTEL", "SHIPPERHP",   "RECP_TEL",   "UPDATE_USR"
				};

				int[] intArrCN = new int[] {	1, 30,  1,   1,   8,
					                           12, 12,  4,  30,  13, 
				                             50, 13, 50,  10, 100,
					                           10,100, 10, 100,   4,
					                            1,  1,
					                           10, 50, 100, 10,  50, 100,
					                           13, 15, 20,  10
																		}; 
			
				int[] intArrCN2 = new int[]{	0,  -1,  -1,  -1,  -1,
					                           -1,  -1,  -1,  -1,  -1,
					                           -1,  -1,  -1,  -1,  -1,
																		 -1,  -1,  -1,  -1,  -1,
					                           -1,  -1,
					                           -1,  -1,  -1,  -1,  -1, -1,
					                           -1,  -1,  -1,  -1
																		};

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				StringBuffer sql = new StringBuffer();

				//주문배정정보
        if(str[1].equals("1")){
            
            sql.append(" SELECT 0 CHK, '주문배정' INGGB,  IFNULL(D.EDI_STS,'N')EDI_STS,  D.ING_STS,  D.ETD_DT,        \n")		 
							 .append("         D.ORDER_NO, C.CAR_SEQ_NO,                                                            \n")		 
						   .append("         CASE WHEN C.ORDER_NO IS NULL OR RTRIM(C.ORDER_NO) = '' THEN '0002'                   \n")
							 .append("              ELSE RTRIM(A.CARGO_TYPE)                                                        \n")
							 .append("         END CARGO_TYPE,                                                                      \n")
							 .append("         '' AS CARGONM,                                                                       \n")
               .append("         A.CUST_CD,V.VEND_NM AS CUSTNM, A.SHIPPER, W.VEND_NM AS SHIPPERNM,                    \n")		 
							 .append("         D.LDCARGO,D.LDCARGONM,D.OFFCARGO,D.OFFCARGONM,                                       \n")
							 .append("         D.ARTC_CD,D.ARTC_NM, D.ORDER_SEQ,                                                    \n")		 
							 .append("         IFNULL(D.HL_EDI_STS,'N')HL_EDI_STS,  D.HL_ING_STS,                                 	\n")		 
							 .append("         C.LD_CARGO,E.MINORNM LD_CARGO_NM, C.LD_CARGONM, C.OFF_CARGO, F.MINORNM OFF_CARGO_NM, C.OFF_CARGONM, --상차지 하차지  	\n")		 
							 .append("         A.SHIPPERTEL,A.SHIPPERHP,A.RECP_TEL,''UPDATE_USR      --송하인전화번호, 송하인핸드폰, 수하인전화번호     	\n")		 
							 .append("    FROM HDASAN_EDI.ETORDERMST A, HDASAN_EDI.ETORDERDTL D,                                  	\n")		 
               .append("         HDASAN_EDI.ETORDCAR C,   HDASAN_EDI.ETCARGOODS B,                                  	\n")		 
							 .append("         ACCOUNT.GCZM_VENDER V,   ACCOUNT.GCZM_VENDER W                                     	\n")	
							 .append("	  LEFT JOIN TRANSFER.LTLCODE E ON E.MINORCD = C.LD_CARGO AND E.MAJORCD ='0007'  \n")	
               .append("	  LEFT JOIN TRANSFER.LTLCODE F ON F.MINORCD = C.OFF_CARGO AND F.MAJORCD ='0007' \n")	 
               .append("   WHERE D.ORDER_NO = A.ORDER_NO                                                            	\n")		 
							 .append("     AND B.CAR_SEQ_NO = C.CAR_SEQ_NO                                                        	\n")
							 .append("     AND B.ORDER_NO = D.ORDER_NO                                                              \n")
							 .append("     AND B.ORDER_SEQ = D.ORDER_SEQ                                                            \n")
               .append("     AND A.CUST_CD = V.VEND_CD                                                              	\n")		 
							 .append("     AND A.SHIPPER = W.VEND_CD                                                              	\n")
							 .append("     AND D.ORDER_STS = '0002'                                                                 \n");		
						
						if(!str[0].equals("")) sql.append (" AND A.LINE_PART = '" +str[0] + "' \n");  
						if(!str[2].equals("")) sql.append (" AND A.ETD_DT = '" +str[2] + "'  \n");  

						//if(str[3].equals("N")) sql.append (" AND (D.HL_EDI_STS = 'S' )     \n");  
						if(!str[3].equals("")) sql.append (" AND D.HL_EDI_STS = '" +str[3] + "' \n");  
            //else if(str[3].equals("")) sql.append (" AND (IFNULL(D.EDI_STS,'') <> 'S' AND IFNULL(D.EDI_STS,'') <> 'R') \n"); 
						
						if(!str[4].equals("")) sql.append (" AND A.IN_OUT = '" +str[4] + "' \n");  
					  if(!str[5].equals("")) sql.append (" AND D.HL_ING_STS='"+str[5]+"' \n");  
            
						//수신대상 건만 조회함.
						sql.append (" AND D.HL_EDI_STS IN ('S','A','Y') \n"); 

						sql.append (" ORDER BY  D.ORDER_NO, D.ORDER_SEQ, C.CAR_SEQ_NO \n"); 
				}

        logger.dbg.println(this, ":::"+sql.toString());

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