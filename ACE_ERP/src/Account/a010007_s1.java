package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class a010007_s1 extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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
				String  str1	= req.getParameter("v_str1"); // 테이블 구분

				if (str1 == null) str1 = "";

				String strTB_GCZM_VEND="";

				if(str1.equals("1")){
					strTB_GCZM_VEND="GCZM_VENDER_ALL";             			//통합
				}else if(str1.equals("2")){
					strTB_GCZM_VEND="GCZM_VENDER";                 			//서울
				}else if(str1.equals("3")){
					strTB_GCZM_VEND="GCZM_VENDER_KUMGANG";         		//금강산
				}else if(str1.equals("4")){
        			strTB_GCZM_VEND="GCZM_VENDER_KAESONG";         		//개성			
				}else if(str1.equals("5")){
					strTB_GCZM_VEND="GCZM_VENDER_KAESONG_080220";  //개성080222 	
				}else if(str1.equals("6")){
					strTB_GCZM_VEND="GCZM_VENDER_KAESONG080718";  //개성080718 	
				}
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "VEND_CD",     "VEND_NM",    "VEND_ID",    "VEND_NO",    "VD_DIRECT",  
				                                   "BSNS_CND",    "BSNS_KND",   "VD_TELNO",   "VD_FAXNO",   "POST_NO1",   
																					 "POST_NO2",    "ADDRESS1",   "ADDRESS2",   "C_BANKCD",   "C_ACCTNO",   
																					 "C_ACCTNO_NM", "C_ACCTNM",   "B_BANKCD",   "B_ACCTNO",   "B_ACCTNO_NM",
																					 "B_ACCTNM",    "O_VENDGB",   "O_VENDCD",   "VEND_MAG",   "USE_TAG",    
																					 "REMARK",      "CREAT_DT",   "CREAT_NM",   "MSN",        "MPWD",       
																					 "COCOMYN"                                                      
				                               }; 


				int[] intArrCN = new int[]{ 13, 62,15,13,62,
                                    62, 62,32,32,10,
					                          10,132,72, 5,22,
                                    32, 32, 5,22,32,
					                          32,  1,13,10, 1,
					                          66, 12,10,13,20,
					                           1
																 	}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1,
					                           -1
				                          }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT  																								\n");
					sql.append( " VEND_CD,     VEND_NM,    VEND_ID,    VEND_NO,    VD_DIRECT,  				\n");
					sql.append( " BSNS_CND,    BSNS_KND,   VD_TELNO,   VD_FAXNO,   POST_NO1,   			\n");
					sql.append( " POST_NO2,    ADDRESS1,   ADDRESS2,   C_BANKCD,   C_ACCTNO,   			\n");
					sql.append( " C_ACCTNO_NM, C_ACCTNM,   B_BANKCD,   B_ACCTNO,   B_ACCTNO_NM, 	\n");
					sql.append( " B_ACCTNM,    O_VENDGB,   O_VENDCD,   VEND_MAG,   USE_TAG,    			\n");
					sql.append( " REMARK,      CREAT_DT,   CREAT_NM,   MSN,        MPWD,       					\n");
					sql.append( " COCOMYN                                                      										\n");
					sql.append( " FROM ACCOUNT."+strTB_GCZM_VEND+"													\n");
					sql.append( " ORDER BY VEND_CD 																			\n");
						
					//logger.dbg.println( this, sql.toString() );
/*********************************************************************************************/

					stmt = conn.getGauceStatement(sql.toString());
					stmt.executeQuery(dSet);
				}
			} catch(Exception e) {
		  	logger.err.println(this,e);
		
		  
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