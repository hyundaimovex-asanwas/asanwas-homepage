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
public class dsMaster_s01 extends HttpServlet {
 
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

				String[] strArrCN = new String[]{	"ORDER_NO","IN_OUT","ORDER_STS","ETD_DT","LINE_PART",
																					"PROJECT","CUST_CD","CUST_PRSN","CUST_TELNO","CARGO_TYPE",
																					"DLVL_TYPE","DIV_IO","DLVL_DATE","SHIPPER","SHIPPERPS",
																					"SHIPPERTEL","ETA_DT","ORDER_DATE","FEE_IN","FEE_OUT",
																					"GORDER_NO","RQST_NO","PL_TYPE","PL_SHIPPER","PL_SHPPRNM",
																					"PL_SHIPADDR","PL_SHIPTEL","PL_CSTM","PL_CSTMNM","PL_CSTADDR",
																					"PL_CSTTEL","PL_BRKR","PL_BRKRNM","PL_BRKADDR","PL_BRKTEL",
																					"RPST_GOODS","TOTAL_CNT","TOTAL_UNIT","TOTAL_WGHT","TOTAL_CBM",
																					"CANCLE_DATE","REMARK","PRICETYPE","SETTLETYPE","LC_NO",
																					"LC_DATE","LC_BANK","EXPRT_NO","EXPRT_DATE","LDCARGO",
																					"LDCARGONM","OFFCARGO","OFFCARGONM","CONSIGNEE","CUST_HPNO",
																					"SHIPPERHP","CREATE_DT","CREATE_USR","UPDATE_DT","UPDATE_USR",
																					"PL_SHPADDR2","PL_SHPADDR3","PL_CSTADDR2","PL_CSTADDR3","PL_BRKADDR2",
																					"PL_BRKADDR3","PL_NO","PL_DATE","PL_CSN","PL_CSNNM",
																					"PL_CSNTEL","PL_CSNADDR","PL_CSNADDR2","PL_CSNADDR3","ETD_DT1",
																					"ATT_FILE","FAC_PERSON","FAC_PRSTEL","ATT_FILENM","OBJ_REMK",
																					"RECIPIENT","RECP_OWN","RECP_TEL","RECP_ADD","CUST_NM",
																					"CDATE"
																				 }; 

				int[] intArrCN = new int[] {	 10,   1,  4,  12,   4,
																			 10,  13, 50,  13,   4,
																				4,   1,  8,  13,  50,
																			 13,   8,  8,   1,   1,
																				8,  12,  1,  13,  35,
																			105,  25, 13,  35, 105,
																			 25,  13, 35, 105,  25,
																			 10,  13,  4,  13,  13,
																				8, 400,  4,   4,  20,
																				8,   4, 14,   8,  10,
																			 30,  10, 30,  35,  15,
																			 15,  10, 10,  10,  10,
																			 35,  35, 35,  35,  35,
																			 35,  20, 10,  13,  35,
																			 25,  35, 35,  35,   8,
																			200,  30, 20,   3, 100,
																			 50,  50, 20,  70,  60,
																			 10
																		}; 
			
				int[] intArrCN2 = new int[]{	-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
																			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
																			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
																			-1,-1,-1,-1,-1,-1, 2,-1, 2, 2,
																			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
																			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
																			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
																			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
																			-1,-1,-1,-1,-1,-1
																		}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (str1.equals("Y")){
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT	A.ORDER_NO,A.IN_OUT,A.ORDER_STS,A.ETD_DT,A.LINE_PART, \n")
						 .append( "					A.PROJECT,A.CUST_CD,A.CUST_PRSN,A.CUST_TELNO,A.CARGO_TYPE, \n")
						 .append( "					A.DLVL_TYPE,A.DIV_IO,A.DLVL_DATE,A.SHIPPER,A.SHIPPERPS, \n")
						 .append( "					A.SHIPPERTEL,A.ETA_DT,A.ORDER_DATE,A.FEE_IN,A.FEE_OUT, \n")
						 .append( "					A.GORDER_NO,A.RQST_NO,A.PL_TYPE,A.PL_SHIPPER,A.PL_SHPPRNM, \n")
						 .append( "					A.PL_SHIPADDR,A.PL_SHIPTEL,A.PL_CSTM,A.PL_CSTMNM,A.PL_CSTADDR, \n")
						 .append( "					A.PL_CSTTEL,A.PL_BRKR,A.PL_BRKRNM,A.PL_BRKADDR,A.PL_BRKTEL, \n")
						 .append( "					A.RPST_GOODS,IFNULL(A.TOTAL_CNT,0) TOTAL_CNT,A.TOTAL_UNIT,IFNULL(A.TOTAL_WGHT,0) TOTAL_WGHT,IFNULL(A.TOTAL_CBM,0) TOTAL_CBM, \n")
						 .append( "					A.CANCLE_DATE,A.REMARK,A.PRICETYPE,A.SETTLETYPE,A.LC_NO, \n")
						 .append( "					A.LC_DATE,A.LC_BANK,A.EXPRT_NO,A.EXPRT_DATE,A.LDCARGO, \n")
						 .append( "					A.LDCARGONM,A.OFFCARGO,A.OFFCARGONM,A.CONSIGNEE,A.CUST_HPNO, \n")
						 .append( "					A.SHIPPERHP,'' CREATE_DT,A.CREATE_USR,'' UPDATE_DT,A.UPDATE_USR, \n")
						 .append( "					A.PL_SHPADDR2,A.PL_SHPADDR3,A.PL_CSTADDR2,A.PL_CSTADDR3,A.PL_BRKADDR2, \n")
						 .append( "					A.PL_BRKADDR3, A.PL_NO, '' PL_DATE, A.PL_CSN, A.PL_CSNNM, \n")
						 .append( "					A.PL_CSNTEL, A.PL_CSNADDR, A.PL_CSNADDR2, A.PL_CSNADDR3,A.ETD_DT1, \n")
						 .append( "					'' ATT_FILE, A.FAC_PERSON,A.FAC_PRSTEL,A.ATT_FILENM,A.OBJ_REMK, \n")
						 .append( "					A.RECIPIENT,A.RECP_OWN,A.RECP_TEL,A.RECP_ADD, B.VEND_NM CUST_NM, \n")
						 .append( "					DATE(CURRENT TIMESTAMP) CDATE \n")
						 .append( "	  FROM  TRANSFER.JTORDERMST A \n")
						 .append( "					LEFT OUTER JOIN ACCOUNT.GCZM_VENDER B ON A.CUST_CD = B.VEND_CD \n")
						 .append( "	 WHERE  A.ORDER_NO = '" + str2 + "'");

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