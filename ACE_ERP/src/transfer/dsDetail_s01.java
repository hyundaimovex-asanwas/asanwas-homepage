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
public class dsDetail_s01 extends HttpServlet {
 
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
				
				String str1 = GauceReq.getParameter("v_str1");   
					if (str1==null || str1.trim().length()==0 ) str1="N";			
				String str2 = GauceReq.getParameter("v_str2");   
					if (str2==null || str2.trim().length()==0 ) str2="";			

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{	"ORDER_NO","ORDER_SEQ","ARTC_CD","ARTC_NM","STN_SZ",
																					"STN_SZNM","HSCODE","ARTC_CNT","ARTC_UNIT","UNIT_PRICE",
																					"PRICE","LDCARGO","LDCARGONM","OFFCARGO","OFFCARGONM",
																					"PUNIT_CNT","PUNIT_UNIT","PUNIT_WGHT","PKG_LNGTH","PKG_HEIGHT",
																					"PKG_WIDTH","PKG_CBM","PKG_CNT","MIX_OTHERS","SAMEAS",
																					"CANCLE_STS","CANCLE_DT","AUTH_NO","ORDER_STS","SETTLE_STS",
																					"REGFILE","REGFILENAME","CREATE_DT","CREATE_USR","UPDATE_DT",
																					"UPDATE_USR","CUR_CODE","VIN_CODE","FR_UNTPRCE","FR_PRICE",
																					"ENG_ARTCNM","EDI_STS","CAR_NO","CARTYPENO","CAR_WGHT",
																					"PKG_CBM_T","PUNIT_WGHT_T"
																				 }; 

				int[] intArrCN = new int[] {	 10,  4,  10, 100,   4,
																			 50, 10,  13,   4,  13,
																			 13, 10, 100,  10, 100,
																			 13, 10,  13,  13,  13,
																			 13, 13,  13,   1,   4,
																			 10, 10,  10,  10,   1,
																			200, 30,  10,  10,  10,
																			 10,  3,  20,  13,  13,
																			100,  1,  30,   4,  13,
																			 13, 13		
																		}; 
			
				int[] intArrCN2 = new int[]{	-1,-1,-1,-1,-1,-1,-1, 2,-1, 2,
																			 2,-1,-1,-1,-1, 2,-1, 2, 2, 2,
																			 2, 2, 2,-1,-1,-1,-1,-1,-1,-1,
																			-1,-1,-1,-1,-1,-1,-1,-1, 2, 2,
																			-1,-1,-1,-1, 2, 2, 2
																		}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (str1.equals("Y")){
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT	ORDER_NO,ORDER_SEQ,ARTC_CD,ARTC_NM,STN_SZ, \n")
						 .append( "					STN_SZNM,HSCODE,ARTC_CNT,ARTC_UNIT,UNIT_PRICE, \n")
						 .append( "					PRICE,LDCARGO,LDCARGONM,OFFCARGO,OFFCARGONM, \n")
						 .append( "					PUNIT_CNT,PUNIT_UNIT,PUNIT_WGHT,PKG_LNGTH,PKG_HEIGHT, \n")
						 .append( "					PKG_WIDTH,PKG_CBM,PKG_CNT,MIX_OTHERS,SAMEAS, \n")
						 .append( "					CANCLE_STS,CANCLE_DT,AUTH_NO,ORDER_STS,SETTLE_STS, \n")
						 .append( "					REGFILE,REGFILENAME,CREATE_DT,CREATE_USR,UPDATE_DT, \n")
						 .append( "					UPDATE_USR,CUR_CODE,VIN_CODE,FR_UNTPRCE,FR_PRICE, \n")
						 .append( "					ENG_ARTCNM,EDI_STS,CAR_NO,CARTYPENO,CAR_WGHT, \n")
						 .append( "					(PKG_CNT*PKG_CBM) PKG_CBM_T, (PUNIT_WGHT*PKG_CNT) PUNIT_WGHT_T \n")
						 .append( "	  FROM  TRANSFER.JTORDERDTL \n")
						 .append( "	 WHERE  ORDER_NO = '" + str2 + "'");

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