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
public class tr00104_edi_22 extends HttpServlet {
 
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
        String [] str = new String[7];

				str[0] = GauceReq.getParameter("v_str0");   //프로젝트 구분
				str[1] = GauceReq.getParameter("v_str1");   //1.주문배정, 2.상차예정
				str[2] = GauceReq.getParameter("v_str2");   //반출일자
				str[3] = GauceReq.getParameter("v_str3");   //전송여부 EDI_STS --''^전체,'N'^미전송,S^전송중,Y^전송완료,A^재전송
				str[4] = GauceReq.getParameter("v_str4");   //반출입구분

				for (int s=0;s<=5;s++) {
					if(str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);


				String[] strArrCN = new String[]{	"CHK",        "INGGB",       "ING_STS",    "ING_STS2",  "EDI_STS",    
					                                "ETD_DT",     "ORDER_NO",    "CAR_SEQ_NO", "IN_OUT",    "ORDER_STS",  
					                                "LINE_PART",  "CARGO_TYPE",  "CUST_CD",    "CUSTNM",
				                                  "SHIPPER",    "SHIPPERNM",   "LD_CARGO",   "LD_CARGONM",
					                                "OFF_CARGO",  "OFF_CARGONM", "HL_EDI_STS"
																				}; 

				int[] intArrCN = new int[] {	1,  1,  1,  1,  1,
									                    8, 10, 10,  1,  4,
				                              4,  4, 13, 50, 
					                           13,100, 10, 100,  
					                           10,100,  1
																		}; 
			
				int[] intArrCN2 = new int[]{	0,  -1,  -1,  -1,  -1,
					                           -1,  -1,  -1,  -1,  -1,
					                           -1,  -1,  -1,  -1,  
																		 -1,  -1,  -1,  -1,  
					                           -1,  -1,  -1
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

            sql.append(" SELECT 0 CHK,      '1' INGGB,               A.ING_STS,          '' ING_STS2,                    \n")		 
 						   .append("        CASE WHEN IFNULL(Z.EDI_STS,'')='' THEN 'N' ELSE IFNULL(Z.EDI_STS,'') END EDI_STS,        \n")		 
							 .append("        A.ETD_DT,    A.ORDER_NO,             '' CAR_SEQ_NO,      A.IN_OUT,   A.ORDER_STS,        \n")		 
							 .append(" 	      A.LINE_PART, A.CARGO_TYPE,           A.CUST_CD,          V.VEND_NM AS CUSTNM,            \n")		 
						   .append("        A.SHIPPER,   W.VEND_NM AS SHIPPERNM, A.LDCARGO AS LD_CARGO, A.LDCARGONM AS LD_CARGONM,   \n")
							 .append(" 	      A.OFFCARGO AS OFF_CARGO,             A.OFFCARGONM AS OFF_CARGONM,  Z.HL_EDI_STS          \n")
							 .append("   FROM TRANSFER.LTORDERMST A,                                                                   \n")
               .append("        ACCOUNT.GCZM_VENDER V, ACCOUNT.GCZM_VENDER W                                             \n")		 
							 .append("        LEFT JOIN HDASAN_EDI.ETORDERMST Z ON A.ORDER_NO = Z.ORDER_NO                             \n")
							 .append("  WHERE A.ING_STS='C'                                                                            \n")		 
							 .append("    AND A.CUST_CD = V.VEND_CD                                                                    \n")		 
							 .append("    AND A.SHIPPER = W.VEND_CD                                                                    \n");		 
						if(!str[0].equals("")) sql.append (" AND A.LINE_PART = '" +str[0] + "' \n");  
						if(!str[2].equals("")) sql.append (" AND A.ETD_DT = '" +str[2] + "'  \n");  
						//if(str[3].equals("N")) sql.append (" AND (D.EDI_STS = '' OR D.EDI_STS IS NULL OR D.EDI_STS='N')   \n");  
						//else if(!str[3].equals("")) sql.append (" AND Z.EDI_STS = '" +str[3] + "' \n");  					
						if(!str[4].equals("")) sql.append (" AND A.IN_OUT = '" +str[4] + "' \n");  
						
						sql.append(" UNION ALL                                                                                       \n")		 
  						 .append(" SELECT 0 CHK,       '2' INGGB ,              '' ING_STS,        C.ING_STS AS ING_STS2,          \n")		 
							 .append("        CASE WHEN IFNULL(Z.EDI_STS,'')='' THEN 'N'  ELSE IFNULL(Z.EDI_STS,'') END EDI_STS,       \n")		 
               .append("        A.ETD_DT,     A.ORDER_NO,             C.CAR_SEQ_NO,      A.IN_OUT,    A.ORDER_STS,       \n")		 
							 .append("        A.LINE_PART,  A.CARGO_TYPE,           A.CUST_CD,         V.VEND_NM AS CUSTNM,            \n")		 
               .append("        A.SHIPPER,    W.VEND_NM AS SHIPPERNM, C.LD_CARGO,        C.LD_CARGONM,                   \n")		 
							 .append("        C.OFF_CARGO,  C.OFF_CARGONM,          Z.HL_EDI_STS                                       \n")		 
               .append("   FROM TRANSFER.LTORDCAR C,                                                                     \n")
							 .append("        ACCOUNT.GCZM_VENDER V, ACCOUNT.GCZM_VENDER W                                             \n")	 
							 .append("        LEFT JOIN TRANSFER.LTORDERMST A ON A.ORDER_NO = C.ORDER_NO                               \n")
							 .append("        LEFT JOIN HDASAN_EDI.ETORDCAR Z ON C.CAR_SEQ_NO = Z.CAR_SEQ_NO                           \n")
							 .append("  WHERE C.ING_STS='C'                                                                            \n")
							 .append("    AND A.CUST_CD = V.VEND_CD                                                                    \n")
							 .append("    AND A.SHIPPER = W.VEND_CD                                                                    \n");

						if(!str[0].equals("")) sql.append (" AND A.LINE_PART = '" +str[0] + "' \n");  
						if(!str[2].equals("")) sql.append (" AND A.ETD_DT = '" +str[2] + "'  \n");  
						//if(str[3].equals("N")) sql.append (" AND (D.EDI_STS = '' OR D.EDI_STS IS NULL OR D.EDI_STS='N')   \n");  
						//else if(!str[3].equals("")) sql.append (" AND Z.EDI_STS = '" +str[3] + "' \n");  					
						if(!str[4].equals("")) sql.append (" AND A.IN_OUT = '" +str[4] + "' \n");  

            sql.append("  ORDER BY ORDER_NO, CAR_SEQ_NO                                        	\n");		 
						
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