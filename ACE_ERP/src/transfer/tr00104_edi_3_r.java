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
public class tr00104_edi_3_r extends HttpServlet {
 
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

				logger.dbg.println(this, "STEP1:::");

				str[0] = GauceReq.getParameter("v_str0");   //프로젝트 구분
				str[1] = GauceReq.getParameter("v_str1");   //1.주문배정, 2.상차예정
				str[2] = GauceReq.getParameter("v_str2");   //반출일자 / 반입일자
				str[3] = GauceReq.getParameter("v_str3");   //전송여부 EDI_STS
				str[4] = GauceReq.getParameter("v_str4");   //반출입구분
        str[5] = GauceReq.getParameter("v_str5");   //상태여부 ING_STS

				logger.dbg.println(this, "STEP2:::");

				for (int s=0;s<=5;s++) {
					if(str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				logger.dbg.println(this, "STEP3:::");

				String[] strArrCN = new String[]{	"CHK" ,
				                                  "CAR_SEQ_NO",	 "ACCSECTION",	"CAR_NO",	      "CAR_TYPE",	    "CAR_TYPE_NM", "PERSON_NO",	
																					"LD_CARGO",	   "LD_CARGONM",	"OFF_CARGO",	  "OFF_CARGONM",	"PURPOSE",	 	  
																					"LEAD_FEE",    "PERSON_CNT",	"START_DATE",  	"START_TIME",	  "RTRN_DATE",	  
																					"RTRN_TIME",	 "BAECHA_NO",	  "ACCESS_NO",	  "RDS_GOODS",	  "REMARK",	    
																				  "CREATE_DT",	 "CREATE_USR",	"UPDATE_DT",	  "UPDATE_UST",
																					"EDI_STS",     "ING_STS",     "EDI_USR",      "EDI_DT",     
																					"HL_EDI_STS",  "HL_ING_STS",  "HL_EDI_USR",   "HL_EDI_DT",
					                                "LD_CARGO_NM", "OFF_CARGO_NM",
                               				  };

				int[] intArrCN = new int[] {	  1,
					                             10,   1,  20,  20,  20, 20,
					                             10, 100,  10, 100, 100,
					                              1,   5,   8,   4,   8,
                                        4,  20,  10,  50, 512,
					                             10,  10,  10,  10,
					                              1,   1,  10,  10,
                                        1,   1,  10,  10,
					                             20,  20
																		}; 
			
				int[] intArrCN2 = new int[]{ 0 ,
					                           -1,  -1,  -1,  -1,  -1, -1,
					                           -1,  -1,  -1,  -1,  -1,
					                           -1,   0,  -1,  -1,  -1,
																		 -1,  -1,  -1,  -1,  -1,
					                           -1,  -1,  -1,  -1,
					                           -1,  -1,  -1,  -1,
                                     -1,  -1,  -1,  -1,
					                           -1,  -1
																		};
			
			 logger.dbg.println(this, "STEP4:::");

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				StringBuffer sql = new StringBuffer();

				logger.dbg.println(this, "STEP5:::");

				//배차정보
				sql.append(" SELECT 0 CHK,  A.CAR_SEQ_NO, A.ACCSECTION, A.CAR_NO,     A.CAR_TYPE,      C.V_NAME AS CAR_TYPE_NM, A.PERSON_NO,  \n")		 
					 .append("        A.LD_CARGO,   A.LD_CARGONM, A.OFF_CARGO,  A.OFF_CARGONM,   A.PURPOSE,    \n")		 
					 .append("        A.LEAD_FEE,   A.PERSON_CNT, A.START_DATE, A.START_TIME,    A.RTRN_DATE,  \n")
					 .append("        A.RTRN_TIME,  A.BAECHA_NO,  A.ACCESS_NO,  A.RDS_GOODS,     A.REMARK,     \n")
					 .append("        A.CREATE_DT,  A.CREATE_USR, A.UPDATE_DT,  A.UPDATE_UST,                  \n")
					 .append("        A.EDI_STS,    A.ING_STS,    A.EDI_USR,    A.EDI_DT,                      \n")
					 .append("        A.HL_EDI_STS, A.HL_ING_STS, A.HL_EDI_USR, A.HL_EDI_DT,                   \n")
					 .append("        L.MINORNM LD_CARGO_NM,  M.MINORNM OFF_CARGO_NM                           \n")
					 .append("   FROM HDASAN_EDI.ETCARACC A,  HDASAN_EDI.ETORDCAR B                            \n")
           .append("   LEFT JOIN HDASAN_EDI.V_ETCARTYPE C ON A.CAR_TYPE  = C.V_CODE                  \n")
					 .append("	 LEFT JOIN TRANSFER.LTLCODE L ON A.LD_CARGO = L.MINORCD AND L.MAJORCD='0007'   \n")
					 .append("	 LEFT JOIN TRANSFER.LTLCODE M ON A.OFF_CARGO = M.MINORCD AND M.MAJORCD='0007'  \n")
					 .append("  WHERE A.CAR_SEQ_NO = B.CAR_SEQ_NO                                              \n");		 
				if(!str[0].equals("")) sql.append (" AND B.LINE_PART  ='" +str[0] + "' \n");   // 프로젝트구분
				if(!str[2].equals("")) sql.append (" AND A.START_DATE ='" +str[2] + "' \n");   // 반출일자,
				if(!str[3].equals("")) sql.append (" AND A.HL_EDI_STS ='" +str[3] + "' \n");   // 전송여부
				if(!str[4].equals("")) sql.append (" AND A.ACCSECTION ='" +str[4] + "' \n");   // 반출입구분
				if(!str[5].equals("")) sql.append (" AND A.HL_ING_STS ='" +str[5] + "' \n");  

				//수신대상건만 조회함.
				sql.append (" AND A.HL_EDI_STS IN ('S','A','Y') \n");  //전송,재전송, 전송완료
				sql.append (" ORDER BY  A.CAR_SEQ_NO \n"); 
			
        logger.dbg.println(this, "sql.toString:::"+sql.toString());
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