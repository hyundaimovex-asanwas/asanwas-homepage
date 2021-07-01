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
public class dsMakePl3 extends HttpServlet {

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
				String str13 = GauceReq.getParameter("gstr13");   
					if (str13==null || str13.trim().length()==0 ) {   str13=null; } 
				
				GauceRes.enableFirstRow(dSet);




/*				String[] strArrCN = new String[]{ "ORDER_NO", "CTN_STDRD",  "CAR_NAME", "IN_OUT","ORDER_STS","ETD_DT","LINE_PART","PROJECT",
					"CDNAM","CUST_CD","CUST_NM","CUST_PRSN","CUST_TELNO","CARGO_TYPE","DLVL_TYPE","DLVL_DATE","SHIPPER","SHIPPER_NM",
					"SHIPPERPS","SHIPPERTEL","ETA_DT","ORDER_DATE","FEE_IN","FEE_OUT","GORDER_NO","RQST_NO","PL_TYPE","PL_SHIPPER",
					"PL_SHPPRNM","PL_CSTM","PL_CSTMNM","PL_BRKR","PL_BRKRNM","RPST_GOODS","TOTAL_CNT","TOTAL_UNIT","TOTAL_WGHT",
					"TOTAL_CBM","CANCLE_DATE","REMARK","PRICETYPE","SETTLETYPE","LC_NO","LC_DATE","LC_BANK","EXPRT_NO","EXPRT_DATE",
					"LDCARGO","LDCARGONM","OFFCARGO","OFFCARGONM","CAR_SEQ_NO","CARTYPENO","CHECK","PL_NO","PL_DATE","EDT_DATE" }; 

				int[] intArrCN = new int[] { 10, 60, 30, 1,4,8,10,10,30,13,30,20,13,10,10,8,13,20,30,30,8,8,1,1,9,10,10,30,30,30,30,30,30,50,13,10,13,13,8,50,10,10,10,8,20,20,8,20,50,20,50,10,10,1,20,30,8}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,2,-1,2,2,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}; 
*/

			String[] strArrCN = new String[]{ 
				"CHECK",
				"PL_NO",
				"ETD_DT",
				"CUST_NM",    //신청업체
				"SHIPPER_NM", // 실화주
				"CARGO_TYPE", //적재구분
				"IN_OUT",			//반입,반출
				"ORDER_STS",		//주문상태
				"LINE_PART",		//사업명
				"PL_TYPE",			// PL 타입??
				 "ORDER_NO"	//주문번호

				}; 

				int[] intArrCN = new int[] { 1, 20, 10, 30, 30, 4, 1, 4, 10, 10, 10 }; 
			
				int[] intArrCN2 = new int[]{ -1, -1,-1,-1,-1,-1,-1,-1,-1,-1,-1 }; 



				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (isNotOnlyHeader) {					
						StringBuffer sql = new StringBuffer(); 


						sql.append(" SELECT DISTINCT '' AS CHECK, IFNULL(A.PL_NO,'') AS PL_NO ,  A.ETD_DT,  \n")
							 .append("				C.VEND_NM  AS CUST_NM, \n")
							 .append("				C.VEND_NM AS SHIPPER_NM,  \n")
							 .append("				A.CARGO_TYPE, \n")
							 .append("				A.IN_OUT,  \n")
							 .append("				A.ORDER_STS, \n")
							 .append("				A.LINE_PART, \n")
							 .append("				A.PL_TYPE,   \n")
							 .append("				A.ORDER_NO \n")
					     .append("	 FROM TRANSFER.LTORDERMST A \n")
							 .append("				LEFT JOIN ACCOUNT.GCZM_VENDER C on A.CUST_CD = C.VEND_CD \n")
							 .append("			  LEFT JOIN TRANSFER.LTLOADLST B on B.ORDER_NO = A.ORDER_NO,\n")
					     .append("				TRANSFER.LTCARTYPE L \n")
							 .append("			  LEFT JOIN TRANSFER.LTORDCAR K on K.CARTYPENO = L.CAR_TYPE \n")
							 .append("  WHERE \n") ;
						// .append("				A.CUST_CD = C.VEND_CD \n");
							 
						if(str2 !=null && str3 !=null ) sql.append("  A.ETD_DT BETWEEN  '" +str2 + "' AND '" + str3 + "' \n");
						if(str4 !=null  ) sql.append(" AND A.LINE_PART =   '" +str4 + "' \n" );
						if(str6 !=null  ) sql.append(" AND A.ORDER_NO  like  '" +str6 + "%' \n" );
						if(str7 !=null  ) sql.append(" AND C.VEND_NM  like  '%" +str7 + "%' \n" );
						if(str8 !=null  ) sql.append(" AND A.ORDER_STS  =  '" +str8 + "' \n" );
						if(str9 !=null  ) sql.append(" AND A.DLVL_TYPE  =  '" +str9 + "' \n" );
						if(str10 !=null  ) sql.append(" AND C.VEND_NM  like  '%" +str10 + "%' \n" );
						if(str11 !=null  ) sql.append(" AND B.EDT_DATE  =   '" +str11 + "' \n" );
						if(str12 !=null  ) sql.append(" AND A.IN_OUT  =   '" +str12 + "' \n" );
						//if(str13 !=null  ) sql.append(" AND A.PL_TYPE  =   '" +str13 + "' \n" );
						if (str13 != null && !str13.equals("")) sql.append( " AND A.PL_TYPE  =   '" +str13 + "' \n");
						sql.append("  AND (A.PL_NO IS NULL OR  RTRIM(A.PL_NO)='' ) \n");

						logger.dbg.println(this,sql.toString());
/*
						sql.append(" SELECT DISTINCT A.ORDER_NO,  K.CTN_STDRD, L.CAR_NAME,  A.IN_OUT,A.ORDER_STS,A.ETD_DT,A.LINE_PART, \n")
							 .append("				A.PROJECT,D.CDNAM,A.CUST_CD,C.VEND_NM  AS CUST_NM,A.CUST_PRSN,A.CUST_TELNO,A.CARGO_TYPE, \n")
							 .append("				A.DLVL_TYPE,A.DLVL_DATE,A.SHIPPER,C.VEND_NM AS SHIPPER_NM,A.SHIPPERPS ,A.SHIPPERTEL,A.ETA_DT, \n")
							 .append("				A.ORDER_DATE,A.FEE_IN,A.FEE_OUT,A.GORDER_NO,A.RQST_NO,A.PL_TYPE,A.PL_SHIPPER, \n")
							 .append("				A.PL_SHPPRNM,A.PL_CSTM,A.PL_CSTMNM,A.PL_BRKR,A.PL_BRKRNM,A.RPST_GOODS, \n")
							 .append("				A.TOTAL_CNT,A.TOTAL_UNIT,A.TOTAL_WGHT,A.TOTAL_CBM,A.CANCLE_DATE,A.REMARK, \n")
							 .append("				A.PRICETYPE,A.SETTLETYPE,A.LC_NO,A.LC_DATE,A.LC_BANK,A.EXPRT_NO,A.EXPRT_DATE, \n")
							 .append("				A.LDCARGO,A.LDCARGONM,A.OFFCARGO,A.OFFCARGONM ,'' AS CAR_SEQ_NO,'' AS CARTYPENO, \n")
							 .append("				'' AS CHECK,IFNULL(A.PL_NO,'') AS PL_NO ,IFNULL(PL_DATE,'00000101000000' ) AS PL_DATE, \n")
							 .append("				B.EDT_DATE \n")
							 .append("	 FROM TRANSFER.LTLOADLST B, \n")
							 .append("				TRANSFER.LTORDERMST A ,\n")
							 .append("				TRANSFER.LTORDERDTL P ,\n")
							.append("				ACCOUNT.COMMDTIL D, \n")
							 .append("			       TRANSFER.LTCARTYPE L, \n")
							 .append("			       TRANSFER.LTORDCAR K, \n")
							 .append("				ACCOUNT.GCZM_VENDER C \n")
							 .append("  WHERE A.ORDER_NO = P.ORDER_NO \n") 
							 .append("		AND A.PROJECT = D.CDCODE \n")
							 .append("		AND D.CMTYPE = '0030' \n")
							 .append("		AND A.CUST_CD = C.VEND_CD \n")
							 .append("		AND K.CARTYPENO = L.CAR_TYPE \n")
							 .append("		AND K.ORDER_NO = A.ORDER_NO \n")
							 .append("		AND K.ORDER_NO = P.ORDER_NO \n");
							 
						if(str2 !=null && str3 !=null ) sql.append(" AND A.ETD_DT BETWEEN  '" +str2 + "' AND '" + str3 + "' \n");
						if(str4 !=null  ) sql.append(" AND A.LINE_PART =   '" +str4 + "' \n" );
						if(str5 !=null  ) sql.append(" AND A.PROJECT =   '" +str5 + "' \n" );
						if(str6 !=null  ) sql.append(" AND A.ORDER_NO  like  '" +str6 + "%' \n" );
						if(str7 !=null  ) sql.append(" AND C.VEND_NM  like  '%" +str7 + "%' \n" );

						//if(str8 !=null  ) sql.append(" AND A.CARGO_TYPE  =  '" +str8 + "'" );
						if(str8 !=null  ) sql.append(" AND A.ORDER_STS  =  '" +str8 + "' \n" );

						if(str9 !=null  ) sql.append(" AND A.DLVL_TYPE  =  '" +str9 + "' \n" );
						if(str10 !=null  ) sql.append(" AND C.VEND_NM  like  '%" +str10 + "%' \n" );
						if(str11 !=null  ) sql.append(" AND B.EDT_DATE  =   '" +str11 + "' \n" );
						if(str12 !=null  ) sql.append(" AND A.IN_OUT  =   '" +str12 + "' \n" );
						//if(str13 !=null  ) sql.append(" AND A.PL_TYPE  =   '" +str13 + "' \n" );
						if (str13 != null && !str13.equals("")) sql.append( " AND A.PL_TYPE  =   '" +str13 + "' \n");
*/						
						//logger.dbg.println(this,sql.toString());

						if (isDebug) GauceRes.writeException("Sql",":",sql.toString());

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