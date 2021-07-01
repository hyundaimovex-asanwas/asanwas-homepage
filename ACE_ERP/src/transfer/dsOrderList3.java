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
public class dsOrderList3 extends HttpServlet {

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
				
				String str0 = GauceReq.getParameter("gstr0");   
					if (str0==null || str0.trim().length()==0 ) {   str0=null; }
				String str1 = GauceReq.getParameter("gstr1");   
					if (str1==null || str1.trim().length()==0 ) {   str1=null; } //주문별/ 차량별
				String str2 = GauceReq.getParameter("gstr2");   
					if (str2==null || str2.trim().length()==0 ) {   str2=null; } //반출일자_from
				String str3 = GauceReq.getParameter("gstr3");   
					if (str3==null || str3.trim().length()==0 ) {   str3=null; } //반출일자_to
			  String str4 = GauceReq.getParameter("gstr4");   
					if (str4==null || str4.trim().length()==0 ) {   str4=null; } 
				String str5 = GauceReq.getParameter("gstr5");   
					if (str5==null || str5.trim().length()==0 ) {   str5=null; }  
			  String str6 = GauceReq.getParameter("gstr6");   
					if (str6==null || str6.trim().length()==0 ) {   str6=null; } 
 			  String str7 = GauceReq.getParameter("gstr7");   
					if (str7==null || str7.trim().length()==0 ) {   str7=null; } 
			  String str8 = GauceReq.getParameter("gstr8");   
					if (str8==null || str8.trim().length()==0 ) {   str8=null; } 
			  String str9 = GauceReq.getParameter("gstr9");   
					if (str9==null || str9.trim().length()==0 ) {   str9=null; } 
			  String str10 = GauceReq.getParameter("gstr10");   
					if (str10==null || str10.trim().length()==0 ) {   str10=null; } 
				String str11 = GauceReq.getParameter("gstr11");   
					if (str11==null || str11.trim().length()==0 ) {   str11=null; } 
				String str12 = GauceReq.getParameter("gstr12");   
					if (str12==null || str12.trim().length()==0 ) {   str12=null; } 

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ORDER_NO","CARGOODS", "IN_OUT","ORDER_STS","ETD_DT","LINE_PART", 
																					"PROJECT","CDNAM","CUST_CD","CUST_NM","CUST_PRSN",
																					"CUST_TELNO","CARGO_TYPE","DLVL_TYPE","DLVL_DATE","SHIPPER",
																					"SHIPPER_NM","SHIPPERPS","SHIPPERTEL","ETA_DT","ORDER_DATE",
																					"FEE_IN","FEE_OUT","GORDER_NO","RQST_NO","PL_TYPE",
																					"PL_SHIPPER","PL_SHPPRNM","PL_CSTM","PL_CSTMNM","PL_BRKR",
																					"PL_BRKRNM","RPST_GOODS","TOTAL_CNT","TOTAL_UNIT","TOTAL_WGHT",
																					"TOTAL_CBM","CANCLE_DATE","REMARK","PRICETYPE","SETTLETYPE",
																					"LC_NO","LC_DATE","LC_BANK","EXPRT_NO","EXPRT_DATE",
																					"LDCARGO","LDCARGONM","OFFCARGO","OFFCARGONM","CAR_SEQ_NO",
																					"CARTYPENO","CHECK","PL_NO","PL_DATE","ETD_DT1",
																					"ETD_DT2", 

																					"ORDER_SEQ","ARTC_NM","STN_SZNM","ARTC_CNT","ARTC_UNIT",
																					"UNIT_PRICE","PRICE","PUNIT_CNT","PUNIT_UNIT","PUNIT_WGHT",
																					"PKG_LNGTH","PKG_WIDTH","PKG_HEIGHT","PKG_CBM","PKG_CNT",
																					"CAL_DT","CAR_NAME","LDNM","OFFNM","OBJ_REMK"
																				}; 

				int[] intArrCN = new int[] {	10,	60,	1,	 4,	 8,	10, 
																			10,	 30,	13,	30,	20,
																			13,	 10,	10,	 8,	13,
																			20,	 30,	30,	 8,	 8,
																			 1,		1,	 9,	10,	10,
																			30,	 30,	30,	30,	30,
																			30,	 50,	13,	10,	13,
																			13,		8,	50,	10,	10,
																			10,		8,	20,	20,	 8,
																			20,	 50,	20,	50,	10,
																			10,		1,	20,	30,	 8,
																			 8,

																			 4, 100,  50, 13, 50,
																			13,  13,  13, 10, 13,
																			13,  13,  13, 13, 13,
																			 8,  30,  30, 30,100

																			}; 
			
				int[] intArrCN2 = new int[]{  -1, -1, -1, -1, -1, -1, 
																			-1, -1, -1, -1, -1,
																			-1, -1, -1, -1, -1,
																			-1, -1, -1, -1, -1,
																			-1, -1, -1, -1, -1,
																			-1, -1, -1, -1, -1,
																			-1, -1,  2, -1,  2,
																			 2, -1, -1, -1, -1,
																			-1, -1, -1, -1, -1,
																			-1, -1, -1, -1, -1,
																			-1, -1, -1, -1, -1,
																			-1,

																			-1, -1, -1,  2, -1,
																			 2,  2,  2, -1,  2,
																			 2,  2,  2,  2,  2,
																			-1, -1, -1, -1, -1, 

																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (isNotOnlyHeader) {
					StringBuffer sql = new StringBuffer();
						
					sql.append(" SELECT DISTINCT A.ORDER_NO,  F.CARGOODS,  A.IN_OUT,A.ORDER_STS,A.ETD_DT,A.LINE_PART, \n")
						 .append("				A.PROJECT,D.CDNAM,A.CUST_CD,B.VEND_NM  AS CUST_NM,A.CUST_PRSN,A.CUST_TELNO,A.CARGO_TYPE, \n")
						 .append("				A.DLVL_TYPE,A.DLVL_DATE,A.SHIPPER,C.VEND_NM AS SHIPPER_NM,A.SHIPPERPS ,A.SHIPPERTEL,A.ETA_DT, \n")
						 .append("				A.ORDER_DATE,A.FEE_IN,A.FEE_OUT,A.GORDER_NO,A.RQST_NO,A.PL_TYPE,A.PL_SHIPPER, \n")
						 .append("				A.PL_SHPPRNM,A.PL_CSTM,A.PL_CSTMNM,A.PL_BRKR,A.PL_BRKRNM,A.RPST_GOODS, \n")
						 .append("				A.TOTAL_CNT,A.TOTAL_UNIT,A.TOTAL_WGHT,A.TOTAL_CBM,A.CANCLE_DATE,A.REMARK, \n")
						 .append("				A.PRICETYPE,A.SETTLETYPE,A.LC_NO,A.LC_DATE,A.LC_BANK,A.EXPRT_NO,A.EXPRT_DATE, \n")
						 .append("				A.LDCARGO,A.LDCARGONM,A.OFFCARGO,A.OFFCARGONM ,'' AS CAR_SEQ_NO,'' AS CARTYPENO, \n")
						 .append("				'' AS CHECK,IFNULL(A.PL_NO,'') AS PL_NO ,IFNULL(PL_DATE,'00000101000000' ) AS PL_DATE, \n")
						 .append("				IFNULL(A.ETD_DT1,A.ETD_DT) ETD_DT1, IFNULL(E.APP_DT3,A.ETD_DT) ETD_DT2, \n")
						 .append("        '' AS ORDER_SEQ, '' AS ARTC_NM, '' AS STN_SZNM, 0 AS ARTC_CNT, '' AS ARTC_UNIT, \n")
						 .append("        0 AS UNIT_PRICE, 0 AS PRICE, 0 AS PUNIT_CNT, '' AS PUNIT_UNIT, 0 AS PUNIT_WGHT, \n")
						 .append("   	    0 AS PKG_LNGTH, 0 AS PKG_WIDTH, 0 AS PKG_HEIGHT, 0 AS PKG_CBM, 0 AS PKG_CNT, E.CAL_DT, \n")
						 .append("   	    F.CAR_NAME, F.LDNM, F.OFFNM, A.OBJ_REMK \n")
						 .append("	 FROM TRANSFER.LTORDERMST A \n")
						 .append("	      LEFT OUTER JOIN (SELECT A1.ORDER_NO, A1.CTN_STDRD CARGOODS, D1.CAR_NAME, B1.MINORNM LDNM, C1.MINORNM OFFNM \n")
						 .append("													 FROM TRANSFER.LTORDCAR A1 \n")
						 .append("													      LEFT OUTER JOIN TRANSFER.LTLCODE B1 ON A1.LD_CARGO = B1.MINORCD AND B1.MAJORCD = '0007' \n")
						 .append("													      LEFT OUTER JOIN TRANSFER.LTLCODE C1 ON A1.OFF_CARGO = C1.MINORCD AND C1.MAJORCD = '0007' \n")
						 .append("													      LEFT OUTER JOIN TRANSFER.LTCARTYPE D1 ON A1.CARTYPENO = D1.CAR_TYPE, \n")
						 .append("													      ( SELECT ORDER_NO, MIN(CAR_SEQ_NO) CAR_SEQ_NO FROM TRANSFER.LTORDCAR WHERE IN_OUT = '" + str0 + "' GROUP BY ORDER_NO) E1 \n")
						 .append("													WHERE A1.IN_OUT = '" + str0 + "' \n")
						 .append("													  AND A1.CAR_SEQ_NO = E1.CAR_SEQ_NO \n")
						 .append("													  AND A1.ORDER_NO = E1.ORDER_NO) F ON A.ORDER_NO = F.ORDER_NO \n")
						 .append("				LEFT OUTER JOIN (SELECT LINE_PART, APP_DT1, APP_DT3, MAX(CAL_DT) CAL_DT FROM TRANSFER.LTCALENDAR GROUP BY LINE_PART, APP_DT1, APP_DT3) E ON A.LINE_PART = E.LINE_PART AND A.ETD_DT = E.APP_DT1, \n")
						 .append("				ACCOUNT.GCZM_VENDER B, \n")
						 .append("				ACCOUNT.GCZM_VENDER C, \n")
						 .append("				ACCOUNT.COMMDTIL D, \n")
						 .append("				TRANSFER.LTUNTCOD G \n")
						 .append("	WHERE B.VEND_CD = A.CUST_CD \n")
						 .append("	  AND C.VEND_CD = A.SHIPPER \n")
						 .append("		AND A.LINE_PART = G.LINE_PART \n")
						 .append("		AND A.PROJECT = G.TR_PROJECT \n")
						 .append("		AND G.PROJECT = D.CDCODE \n")
						 .append("		AND D.CMTYPE = '0030' \n")
						 .append("		AND A.IN_OUT = '" + str0 + "' \n");

					if(str2  !=null && str3 !=null ) sql.append(" AND A.ETD_DT BETWEEN  '" +str2 + "' AND '" + str3 + "'");
					if(str4  !=null  ) sql.append(" AND A.LINE_PART = '" + str4 + "'" );
					if(str5  !=null  ) sql.append(" AND A.PROJECT = '" + str5 + "'" );
					if(str6  !=null  ) sql.append(" AND A.ORDER_NO LIKE '" + str6 + "%'" );
					if(str7  !=null  ) sql.append(" AND B.VEND_NM LIKE '%" + str7 + "%'" );
					if(str8  !=null  ) sql.append(" AND A.ORDER_STS = '" + str8 + "'" );
					if(str9  !=null  ) sql.append(" AND A.DLVL_TYPE = '" + str9 + "'" );
					if(str10 !=null  ) sql.append(" AND B.VEND_NM LIKE '%" + str10 + "%'" );
					if(str11 !=null  ) sql.append(" AND A.CREATE_USR = '" + str11 + "'" );

					sql.append(" ORDER BY ETD_DT DESC");
					//logger.dbg.println(this,"::::::::::::::::"+sql.toString());
					//logger.dbg.println(this,sql.toString());

					if (isDebug) {	
						GauceRes.writeException("Sql",":",sql.toString()); }

						stmt = conn.getGauceStatement(sql.toString());
		 				stmt.executeQuery(dSet);
					}
				
/*********************************************************************************************/

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