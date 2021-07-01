package transfer;

import com.gauce.*;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;

import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class dsOrderList5 extends HttpServlet {

	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		Connection conn = null;
        ResultSet rs = null;
        Statement stmt = null;		
		GauceDataSet dSet = null;
		try {
			try {
				GauceInputStream gis  = ((HttpGauceRequest) req).getGauceInputStream();
	            GauceOutputStream gos = ((HttpGauceResponse) res).getGauceOutputStream();
						
				//JNDI connection 호출 : import javax.naming.*; 필요
	            Context initContext = (Context) new InitialContext();
	        	DataSource ds = (DataSource) initContext.lookup("CforTransfer");
	        	conn = ds.getConnection();
	            //JNDI connection 호출
	        	
	        	dSet = new GauceDataSet();	
				gos.fragment(dSet);
				
				//System.out.println("시작");

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
			//	boolean isNotOnlyHeader = false;
			//	boolean isDebug = false;
			//	if ( req.getParameter("NOH")!=null && req.getParameter("NOH").equals("Y") ) { isNotOnlyHeader = true; }
			//	if ( req.getParameter("DBG")!=null && req.getParameter("DBG").equals("Y") ) { isDebug = true; }
				
				String str0 = req.getParameter("gstr0");   
					if (str0==null || str0.trim().length()==0 ) {   str0=null; } //반출ㆍ반입 구분
				String str1 = req.getParameter("gstr1");   
					if (str1==null || str1.trim().length()==0 ) {   str1=null; } //주문별/ 차량별
				String str2 = req.getParameter("gstr2");   
					if (str2==null || str2.trim().length()==0 ) {   str2=null; } //반출일자_from
				String str3 = req.getParameter("gstr3");   
					if (str3==null || str3.trim().length()==0 ) {   str3=null; } //반출일자_to
			    String str4 = req.getParameter("gstr4");   
					if (str4==null || str4.trim().length()==0 ) {   str4=null; } 
				String str5 = req.getParameter("gstr5");   
					if (str5==null || str5.trim().length()==0 ) {   str5=null; }  
			    String str6 = req.getParameter("gstr6");   
					if (str6==null || str6.trim().length()==0 ) {   str6=null; } 
 			    String str7 = req.getParameter("gstr7");   
					if (str7==null || str7.trim().length()==0 ) {   str7=null; } 
			    String str8 = req.getParameter("gstr8");   
					if (str8==null || str8.trim().length()==0 ) {   str8=null; } 
			    String str9 = req.getParameter("gstr9");   
					if (str9==null || str9.trim().length()==0 ) {   str9=null; } 
			    String str10 = req.getParameter("gstr10");   
					if (str10==null || str10.trim().length()==0 ) {   str10=null; } 
				String str11 = req.getParameter("gstr11");   
					if (str11==null || str11.trim().length()==0 ) {   str11=null; } 
				String str12 = req.getParameter("gstr12");   
					if (str12==null || str12.trim().length()==0 ) {   str12=null; } 

				//System.out.println("para1");
				//if (isNotOnlyHeader) {
					StringBuffer sql = new StringBuffer();
				//	System.out.println("para2");
					
					//CHECK는 예약어로 CHK로 변경 2013.10.22
					//IFNULL은 NVL
					//IFNULL(PL_DATE,'00000101000000' ) 은  NVL(TO_CHAR(PL_DATE,'YYYY-MM-DD HH:MI:SSxFF'),'00000101000000')
					
					
					if(str1 != null && str1.equals("A")){
						/*
						sql.append(" SELECT DISTINCT A.ORDER_NO,A.IN_OUT,A.ORDER_STS,A.ETD_DT,A.LINE_PART, \n")
							 .append("				A.PROJECT,D.CDNAM,A.CUST_CD,B.VEND_NM  AS CUST_NM,A.CUST_PRSN,A.CUST_TELNO,A.CARGO_TYPE, \n")
							 .append("				A.DLVL_TYPE,A.DLVL_DATE,A.SHIPPER,C.VEND_NM AS SHIPPER_NM,A.SHIPPERPS ,A.SHIPPERTEL,A.ETA_DT, \n")
							 .append("				A.ORDER_DATE,A.FEE_IN,A.FEE_OUT,A.GORDER_NO,A.RQST_NO,A.PL_TYPE,A.PL_SHIPPER, \n")
							 .append("				A.PL_SHPPRNM,A.PL_CSTM,A.PL_CSTMNM,A.PL_BRKR,A.PL_BRKRNM,A.RPST_GOODS, \n")
							 .append("				A.TOTAL_CNT,A.TOTAL_UNIT,A.TOTAL_WGHT,A.TOTAL_CBM,A.CANCLE_DATE,A.REMARK, \n")
							 .append("				A.PRICETYPE,A.SETTLETYPE,A.LC_NO,A.LC_DATE,A.LC_BANK,A.EXPRT_NO,A.EXPRT_DATE, \n")
							 .append("				A.LDCARGO,A.LDCARGONM,A.OFFCARGO,A.OFFCARGONM ,'' AS CAR_SEQ_NO,'' AS CARTYPENO, \n")
							 .append("				'' AS CHK, NVL(A.PL_NO,'') AS PL_NO , \n")
							  .append("				NVL(TO_CHAR(PL_DATE,'YYYY-MM-DD HH:MI:SSxFF'),'00000101000000') AS PL_DATE, \n")
							 .append("				NVL(A.ETD_DT1,A.ETD_DT) ETD_DT1, \n")
							 .append("        '' AS ORDER_SEQ, '' AS ARTC_NM, '' AS STN_SZNM, 0 AS ARTC_CNT, '' AS ARTC_UNIT, \n")
							 .append("        0 AS UNIT_PRICE, 0 AS PRICE, 0 AS PUNIT_CNT, '' AS PUNIT_UNIT, 0 AS PUNIT_WGHT, \n")
							 .append("   	    0 AS PKG_LNGTH, 0 AS PKG_WIDTH, 0 AS PKG_HEIGHT, 0 AS PKG_CBM, 0 AS PKG_CNT, \n")
							 .append("   	    0 RATE_FLAG, X.ING_STS , X.EDI_STS, A.CREATE_DT\n")
							 .append("	 FROM TRANSFER.LTORDERMST A \n")
							 .append("				LEFT OUTER JOIN TRANSFER.LTCALENDAR E ON A.LINE_PART = E.LINE_PART AND A.ETD_DT = E.APP_DT1, \n")
							 .append("				ACCOUNT.GCZM_VENDER B, \n")
							 .append("				ACCOUNT.GCZM_VENDER C, \n")
							 .append("				ACCOUNT.COMMDTIL D, \n")
							 .append("				TRANSFER.LTUNTCOD G \n")
							 //추가
               				 .append("				LEFT JOIN (SELECT F.ORDER_NO, MAX(F.ING_STS)ING_STS, MAX(F.EDI_STS)EDI_STS   \n")
							 .append("				             FROM TRANSFER.LTORDERDTL F                                      \n")
							 .append("				            GROUP BY F.ORDER_NO                                              \n")
							 .append("				           ) X ON X.ORDER_NO = A.ORDER_NO                                    \n")
							 
							 .append("	WHERE B.VEND_CD = A.CUST_CD \n")
							 .append("	  AND C.VEND_CD = A.SHIPPER \n")
							 .append("		AND A.LINE_PART = G.LINE_PART \n")
							 .append("		AND A.PROJECT = G.TR_PROJECT \n")
							 .append("		AND G.PROJECT = D.CDCODE \n")
							 .append("		AND D.CMTYPE = '0030' ")
							 .append("		AND D.CMTYPE = '0030' \n")
							 .append("		AND A.IN_OUT = '" + str0 + "' \n");
							 
							 */
						
						  sql.append(" SELECT DISTINCT A.ORDER_NO,A.IN_OUT,A.ORDER_STS,A.ETD_DT,A.LINE_PART, \n")
							 .append("		  A.PROJECT,D.CDNAM,A.CUST_CD,B.VEND_NM  AS CUST_NM,A.CUST_PRSN,A.CUST_TELNO,A.CARGO_TYPE, \n")
							 .append("		  A.DLVL_TYPE,A.DLVL_DATE,A.SHIPPER,C.VEND_NM AS SHIPPER_NM,A.SHIPPERPS ,A.SHIPPERTEL,A.ETA_DT, \n")
							 .append("		  A.ORDER_DATE,A.FEE_IN,A.FEE_OUT,A.GORDER_NO,A.RQST_NO,A.PL_TYPE,A.PL_SHIPPER, \n")
							 .append("		  A.PL_SHPPRNM,A.PL_CSTM,A.PL_CSTMNM,A.PL_BRKR,A.PL_BRKRNM,A.RPST_GOODS, \n")
							 .append("		  A.TOTAL_CNT,A.TOTAL_UNIT,A.TOTAL_WGHT,A.TOTAL_CBM,A.CANCLE_DATE,A.REMARK, \n")
							 .append("		  A.PRICETYPE,A.SETTLETYPE,A.LC_NO,A.LC_DATE,A.LC_BANK,A.EXPRT_NO,A.EXPRT_DATE, \n")
							 .append("		  A.LDCARGO,A.LDCARGONM,A.OFFCARGO,A.OFFCARGONM ,'' AS CAR_SEQ_NO,'' AS CARTYPENO, \n")
							 .append("		  '' AS CHK, NVL(A.PL_NO,'') AS PL_NO , \n")
							 .append("		  NVL(TO_CHAR(PL_DATE,'YYYY-MM-DD HH:MI:SSxFF'),'00000101000000') AS PL_DATE, \n")
							 .append("		  NVL(A.ETD_DT1,A.ETD_DT) ETD_DT1, \n")
							 .append("        '' AS ORDER_SEQ, '' AS ARTC_NM, '' AS STN_SZNM, 0 AS ARTC_CNT, '' AS ARTC_UNIT, \n")
							 .append("        0 AS UNIT_PRICE, 0 AS PRICE, 0 AS PUNIT_CNT, '' AS PUNIT_UNIT, 0 AS PUNIT_WGHT, \n")
							 .append("   	  0 AS PKG_LNGTH, 0 AS PKG_WIDTH, 0 AS PKG_HEIGHT, 0 AS PKG_CBM, 0 AS PKG_CNT, \n")
							 .append("   	  0 RATE_FLAG, X.ING_STS , X.EDI_STS, A.CREATE_DT\n")
							 .append("	 FROM TRANSFER.LTORDERMST A, TRANSFER.LTCALENDAR E, \n")
							 .append("		  ACCOUNT.GCZM_VENDER B, \n")
							 .append("		  ACCOUNT.GCZM_VENDER C, \n")
							 .append("		  ACCOUNT.COMMDTIL D, \n")
							 .append("		  TRANSFER.LTUNTCOD G, \n")
							 //추가
	          				 .append("	      (SELECT F.ORDER_NO, MAX(F.ING_STS)ING_STS, MAX(F.EDI_STS)EDI_STS   \n")
							 .append("	         FROM TRANSFER.LTORDERDTL F                                      \n")
							 .append("		    GROUP BY F.ORDER_NO                                              \n")
							 .append("		   ) X                                                               \n")
							 .append("	WHERE A.LINE_PART = E.LINE_PART(+)  \n")
							 .append("	  AND A.ETD_DT    = E.APP_DT1(+)    \n")
							 .append("	  AND A.ORDER_NO  = X.ORDER_NO(+)   \n")
							 .append("	  AND B.VEND_CD   = A.CUST_CD \n")
							 .append("	  AND C.VEND_CD   = A.SHIPPER \n")
							 .append("	  AND A.LINE_PART = G.LINE_PART \n")
							 .append("    AND A.PROJECT = G.TR_PROJECT \n")
							 .append("	  AND G.PROJECT = D.CDCODE \n")
							 .append("	  AND D.CMTYPE = '0030' \n")
							 .append("	  AND A.IN_OUT = '" + str0 + "' \n");
					} else if(str1 != null && str1.equals("B")){
						  sql.append(" SELECT DISTINCT A.ORDER_NO,A.IN_OUT,A.ORDER_STS,A.ETD_DT,A.LINE_PART,  \n")
							 .append("				A.PROJECT,D.CDNAM,A.CUST_CD,B.VEND_NM AS CUST_NM, \n")
							 .append("				A.CUST_PRSN,A.CUST_TELNO,A.CARGO_TYPE, \n")
							 .append("				A.DLVL_TYPE,A.DLVL_DATE,A.SHIPPER,C.VEND_NM AS  \n")
							 .append("				SHIPPER_NM,A.SHIPPERPS,A.SHIPPERTEL,A.ETA_DT, \n")
							 .append("				A.ORDER_DATE,A.FEE_IN,A.FEE_OUT,A.GORDER_NO,A.RQST_NO,A.PL_TYPE,A.PL_SHIPPER, \n")
							 .append("				A.PL_SHPPRNM,A.PL_CSTM,A.PL_CSTMNM,A.PL_BRKR,A.PL_BRKRNM,A.RPST_GOODS, \n")
							 .append("				A.TOTAL_CNT,A.TOTAL_UNIT,A.TOTAL_WGHT,A.TOTAL_CBM,A.CANCLE_DATE,A.REMARK, \n")
							 .append("				A.PRICETYPE,A.SETTLETYPE,A.LC_NO,A.LC_DATE,A.LC_BANK,A.EXPRT_NO,A.EXPRT_DATE, \n")
							 .append("				D0.LDCARGO,'' as LDCARGONM,D0.OFFCARGO,'' as OFFCARGONM ,CAR.CAR_SEQ_NO,CAR.CARTYPENO, \n")
							 .append("				'' AS CHK  ,NVL(PL_NO,'') AS PL_NO , \n" )
							 .append("				NVL(TO_CHAR(PL_DATE,'YYYY-MM-DD HH:MI:SSxFF'),'00000101000000') AS PL_DATE, \n" )
							 .append("				NVL(A.ETD_DT1,A.ETD_DT) ETD_DT1, \n")
							 .append("        '' AS ORDER_SEQ, CAR.CTN_STDRD AS ARTC_NM, '' AS STN_SZNM, 0 AS ARTC_CNT, '' AS ARTC_UNIT, \n")
							 .append("        0 AS UNIT_PRICE, 0 AS PRICE, 0 AS PUNIT_CNT, '' AS PUNIT_UNIT, 0 AS PUNIT_WGHT, \n")
							 .append("   	    0 AS PKG_LNGTH, 0 AS PKG_WIDTH, 0 AS PKG_HEIGHT, 0 AS PKG_CBM, 0 AS PKG_CNT, \n")
							 .append("   	    0 RATE_FLAG, D0.ING_STS, D0.EDI_STS,A.CREATE_DT \n")
							 .append("   FROM TRANSFER.LTORDERMST A \n")
							 .append("				LEFT JOIN TRANSFER.LTORDCAR CAR ON A.ORDER_NO = CAR.ORDER_NO \n")
							 .append("				LEFT OUTER JOIN TRANSFER.LTCALENDAR E ON A.LINE_PART = E.LINE_PART AND A.ETD_DT = E.APP_DT1 \n")
							 .append("				LEFT OUTER JOIN TRANSFER.LTORDERDTL D0 ON A.ORDER_NO = D0.ORDER_NO, \n")
							 .append("				ACCOUNT.GCZM_VENDER B, \n")
							 .append("				ACCOUNT.GCZM_VENDER C, \n")
							 .append("				ACCOUNT.COMMDTIL D, \n")
							 .append("				TRANSFER.LTUNTCOD G \n")
							 .append("  WHERE B.VEND_CD = A.CUST_CD \n")
							 .append("		AND C.VEND_CD = A.SHIPPER \n")
							 .append("		AND A.LINE_PART = G.LINE_PART \n")
							 .append("		AND A.PROJECT = G.TR_PROJECT \n")
							 .append("		AND G.PROJECT = D.CDCODE \n")
							 .append("		AND D.CMTYPE = '0030' \n")
							 .append("		AND A.IN_OUT = '" + str0 + "' \n");
					} else if(str1 != null && str1.equals("C")){
						sql.append(" SELECT DISTINCT A.ORDER_NO AS ORDER_NO,A.IN_OUT,  \n")
							 .append("				'' AS IIN_OUT, \n")	
							 .append("				A.ORDER_STS,A.ETD_DT,A.LINE_PART,  \n")	
							 .append("				A.PROJECT,D.CDNAM,A.CUST_CD,B.VEND_NM AS CUST_NM, \n")
							 .append("				A.CUST_PRSN,A.CUST_TELNO,A.CARGO_TYPE, \n")
							 .append("				A.DLVL_TYPE,A.DLVL_DATE,A.SHIPPER,C.VEND_NM AS  \n")
							 .append("				SHIPPER_NM,A.SHIPPERPS,A.SHIPPERTEL,A.ETA_DT, \n")
							 .append("				A.ORDER_DATE,A.FEE_IN,A.FEE_OUT,A.GORDER_NO,A.RQST_NO,A.PL_TYPE,A.PL_SHIPPER, \n")
							 .append("				A.PL_SHPPRNM,A.PL_CSTM,A.PL_CSTMNM,A.PL_BRKR,A.PL_BRKRNM,A.RPST_GOODS, \n")
							 .append("				A.TOTAL_CNT,A.TOTAL_UNIT,A.TOTAL_WGHT,A.TOTAL_CBM,A.CANCLE_DATE,A.REMARK, \n")
							 .append("				A.PRICETYPE,A.SETTLETYPE,A.LC_NO,A.LC_DATE,A.LC_BANK,A.EXPRT_NO,A.EXPRT_DATE, \n")
							 .append("				D0.LDCARGO,D0.LDCARGONM,D0.OFFCARGO,D0.OFFCARGONM ,'' CAR_SEQ_NO,'' CARTYPENO, \n")
							 .append("				'' AS CHK  ,NVL(PL_NO,'') AS PL_NO , \n" )
							 .append("				NVL(TO_CHAR(PL_DATE,'YYYY-MM-DD HH:MI:SSxFF'),'00000101000000')AS PL_DATE, \n" )
							 .append("				NVL(A.ETD_DT1,A.ETD_DT) ETD_DT1, \n")
							 .append("        D0.ORDER_SEQ AS ORDER_SEQ,D0.ARTC_NM AS ARTC_NM,D0.STN_SZNM AS STN_SZNM, \n")
							 .append("   	    COALESCE(D0.ARTC_CNT,0) AS ARTC_CNT, \n")
							 .append("	      D0.ARTC_UNIT, COALESCE(D0.UNIT_PRICE,0) AS UNIT_PRICE,COALESCE(D0.PRICE,0) AS PRICE, \n")
							 .append("   	    COALESCE(D0.PUNIT_CNT,0) AS PUNIT_CNT,D0.PUNIT_UNIT AS PUNIT_UNIT, COALESCE(D0.PUNIT_WGHT,0) AS PUNIT_WGHT, \n")
							 .append("   	    COALESCE(D0.PKG_LNGTH,0) AS PKG_LNGTH,COALESCE(D0.PKG_WIDTH,0) AS PKG_WIDTH,COALESCE(D0.PKG_HEIGHT,0) AS PKG_HEIGHT, \n")
							 .append("   	    COALESCE(D0.PKG_CBM,0) AS PKG_CBM,COALESCE(D0.PKG_CNT,0) AS PKG_CNT, 0 RATE_FLAG, D0.ING_STS,D0.EDI_STS,A.CREATE_DT \n")
							 .append("   FROM TRANSFER.LTORDERMST A ")
//							 .append("				LEFT JOIN TRANSFER.LTORDCAR CAR ON A.ORDER_NO = CAR.ORDER_NO \n")
							 .append("				LEFT OUTER JOIN TRANSFER.LTCALENDAR E ON A.LINE_PART = E.LINE_PART AND A.ETD_DT = E.APP_DT1 \n")
							 .append("				LEFT OUTER JOIN TRANSFER.LTORDERDTL D0 ON A.ORDER_NO = D0.ORDER_NO, \n")
							 .append("				ACCOUNT.GCZM_VENDER B, \n")
							 .append("				ACCOUNT.GCZM_VENDER C, \n")
							 .append("				ACCOUNT.COMMDTIL D, \n")
							 .append("				TRANSFER.LTUNTCOD G \n")
							 .append("  WHERE B.VEND_CD = A.CUST_CD \n")
							 .append("		AND C.VEND_CD = A.SHIPPER ")
							 .append("		AND A.LINE_PART = G.LINE_PART \n")
							 .append("		AND A.PROJECT = G.TR_PROJECT \n")
							 .append("		AND G.PROJECT = D.CDCODE \n")
							 .append("		AND D.CMTYPE = '0030' \n")
							 .append("		AND A.IN_OUT = '" + str0 + "' \n");
					}

					if(str2 !=null && str3 !=null ){ sql.append(" AND A.ETD_DT BETWEEN  '" +str2 + "' AND '" + str3 + "'\n");}
					if(str4 !=null  ){ sql.append(" AND A.LINE_PART =   '" +str4 + "'\n" );}
					if(str5 !=null  ){ sql.append(" AND A.PROJECT =   '" +str5 + "'\n" );}
					if(str6 !=null  ){ sql.append(" AND A.ORDER_NO  like  '" +str6 + "%'\n" );}
					if(str7 !=null  ){ sql.append(" AND B.VEND_NM  like  '%" +str7 + "%'\n" );}

					if(str8 !=null  ){ sql.append(" AND A.ORDER_STS  =  '" +str8 + "'\n" );}

					if(str9 !=null  ){ sql.append(" AND A.CARGO_TYPE  =  '" +str9 + "'\n" );}
					if(str10 !=null  ){ sql.append(" AND B.VEND_NM  like  '%" +str10 + "%'\n" );}
					if(str11 !=null  ){ sql.append(" AND A.ETD_DT  =   '" +str11 + "'\n" );}
					if(str12 !=null  ){ sql.append(" AND A.IN_OUT  =   '" +str12 + "'\n" );}

					sql.append("ORDER BY A.ORDER_NO DESC, CAR_SEQ_NO ASC ");

					//System.out.println("sql.toString()"+sql.toString());
					stmt = conn.createStatement();
					rs = stmt.executeQuery(sql.toString());
					
					gos.write(sales.common.SuperServlet.getDataSet(rs, dSet));
					
		            rs.close();
		            stmt.close();
		            conn.close();

					//}
				
/*********************************************************************************************/

			} catch(Exception e) {
		  	//logger.err.println(this,e);
		  } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close();} catch (Exception e) {}
			}

		  //dSet.flush();
		  //GauceRes.commit();
		  //GauceRes.close();

		} catch (Exception e) {
			//logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
		} finally {
			//loader.restoreService(service);
  	}
	}
}