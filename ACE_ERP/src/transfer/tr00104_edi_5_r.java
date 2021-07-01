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
public class tr00104_edi_5_r extends HttpServlet {
 
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
				str[1] = GauceReq.getParameter("v_str1");   //1.주문배정, 2.배차, 3.입고, 4.상차
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

				String[] strArrCN = new String[]{ "CHK",
				                                  "CAR_SEQ_NO",    "ORDER_NO",   "ORDER_SEQ",  "ARTC_CNT",   "PUNIT_CNT",
																					"PUNIT_WEIGHT",  "PKG_LNGTH",  "PKG_HEIGHT", "PKG_WIDTH",  "TOTAL_CBM",
																					"TOTAL_WEIGHT",  "STS_CODE",   "UPEND_DT",   "UPEND_TIME", "REMARK",
																					"BAECHA_NO",     "ENTER_NO",   "CAR_NO",     "PKG_CNT",    "EDT_DATE",
					                                "LINE_PART",     "ARTC_NM",
																					"CREATE_DT",     "CREATE_USR", "UPDATE_DT",  "UPDATE_UST",
                                          "EDI_STS",       "ING_STS",    "EDI_USR",    "EDI_DT",     
																					"HL_EDI_STS",    "HL_ING_STS", "HL_EDI_USR", "HL_EDI_DT"
				
                               				  };

				int[] intArrCN = new int[] {	  1,
					                             10,  10,   4,  13,  13,  
					                             13,  13,  13,  13,  13,
					                             13,   1,   8,   4, 512,
                                       20,   8,  20,  13,   8,
                                        4, 100,         
				                               10,  10,  10,  10, 
					                              1,   1,  10,  10,
                                        1,   1,  10,  10
					                         	}; 
			
				int[] intArrCN2 = new int[]{  0,
					                           -1,  -1,  -1,   2,   2,
					                            2,   2,   2,   2,   2,
					                            2,  -1,  -1,  -1,  -1,
																		 -1,  -1,  -1,   3,  -1,  
                                     -1,  -1,
					                           -1,  -1,  -1,  -1,
					                           -1,  -1,  -1,  -1,
                                     -1,  -1,  -1,  -1
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

				//상차정보
        sql.append(" SELECT 0 CHK,           A.CAR_SEQ_NO, A.ORDER_NO,   A.ORDER_SEQ,  A.ARTC_CNT,   A.PUNIT_CNT, \n")		 
           .append("        A.PUNIT_WEIGHT,  A.PKG_LNGTH,  A.PKG_HEIGHT, A.PKG_WIDTH,  A.TOTAL_CBM,     \n")		 
					 .append("        A.TOTAL_WEIGHT,  A.STS_CODE,   A.UPEND_DT,   A.UPEND_TIME, A.REMARK,        \n")		 
					 .append("        A.BAECHA_NO,     A.ENTER_NO,   A.CAR_NO,     A.PKG_CNT,    A.EDT_DATE,      \n")		 
					 .append("        A.LINE_PART,     C.ARTC_NM,                                                 \n")		 
					 .append("        A.CREATE_DT,     A.CREATE_USR, A.UPDATE_DT,  A.UPDATE_UST,                  \n")		 
					 .append("        A.EDI_STS,       A.ING_STS,    A.EDI_USR,    A.EDI_DT,                      \n")		 
					 .append("        A.HL_EDI_STS,    A.HL_ING_STS, A.HL_EDI_USR, A.HL_EDI_DT                    \n")		 
					 .append("   FROM HDASAN_EDI.ETLOADLST A                                                      \n")		 
					 .append("   LEFT JOIN HDASAN_EDI.ETORDERMST B ON A.ORDER_NO = B.ORDER_NO                     \n")	 
				   .append("   LEFT JOIN HDASAN_EDI.ETORDERDTL C ON A.ORDER_NO = C.ORDER_NO AND A.ORDER_SEQ = C.ORDER_SEQ \n")		
				   .append("  WHERE 1=1  \n");		 
				if(!str[0].equals("")) sql.append (" AND A.LINE_PART  ='" +str[0] + "' \n");   // 프로젝트구분
				if(!str[2].equals("")) sql.append (" AND A.EDT_DATE   ='" +str[2] + "' \n");   // 반출일자,
				if(!str[3].equals("")) sql.append (" AND A.HL_EDI_STS ='" +str[3] + "' \n");   // 전송여부
				if(!str[4].equals("")) sql.append (" AND B.IN_OUT ='" +str[4] + "' \n");       // 반출입구분
				if(!str[5].equals("")) sql.append (" AND A.HL_ING_STS ='" +str[5] + "' \n");   // 상태여부 ING_STS
       
				//수신대상 건만 조회함.
				sql.append (" AND A.HL_EDI_STS IN ('S','A','Y')  \n");  //전송, 재전송, 전송완료
				sql.append (" ORDER BY  A.ORDER_NO, INTEGER(A.ORDER_SEQ), A.CAR_SEQ_NO \n"); 
				   
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