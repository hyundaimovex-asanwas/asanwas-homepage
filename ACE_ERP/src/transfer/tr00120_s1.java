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
public class tr00120_s1 extends HttpServlet {

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
					if (str1==null || str1.trim().length()==0 ) {   str1=null; } //반출일자_from
				String str2 = GauceReq.getParameter("gstr2");   
					if (str2==null || str2.trim().length()==0 ) {   str2=null; } //반출일자_to
				String str3 = GauceReq.getParameter("gstr3");   
					if (str3==null || str3.trim().length()==0 ) {   str3=null; } //주문번호
			  String str4 = GauceReq.getParameter("gstr4");   
					if (str4==null || str4.trim().length()==0 ) {   str4=null; } //업체명
				String str5 = GauceReq.getParameter("gstr5");   
					if (str5==null || str5.trim().length()==0 ) {   str5=null; } //프로젝트구분 
			  String str6 = GauceReq.getParameter("gstr6");   
					if (str6==null || str6.trim().length()==0 ) {   str6=null; } //상차지
 			  String str7 = GauceReq.getParameter("gstr7");   
					if (str7==null || str7.trim().length()==0 ) {   str7=null; } //하차지
			  String str8 = GauceReq.getParameter("gstr8");   
					if (str8==null || str8.trim().length()==0 ) {   str8=null; } //적재구분
			  String str9 = GauceReq.getParameter("gstr9");   
					if (str9==null || str9.trim().length()==0 ) {   str9=null; } //납품구분
			  String str10 = GauceReq.getParameter("gstr10");   
					if (str10==null || str10.trim().length()==0 ) {   str10=null; } //물품명
				
				//String str11 = GauceReq.getParameter("gstr11");   
			//		if (str11==null || str11.trim().length()==0 ) {   str11=null; } 
			//	String str12 = GauceReq.getParameter("gstr12");   
			//		if (str12==null || str12.trim().length()==0 ) {   str12=null; } 

				
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ORDER_NO","ORDER_SEQ","IN_OUT", "ORDER_STS", "ETD_DT",
														"LINE_PART", "LDCARGO","OFFCARGO","PROJECT","CUST_NM",
																"CARGO_TYPE","DLVL_TYPE","ARTC_NM","STN_SZNM","ARTC_CNT",
																		"ARTC_UNIT","UNIT_PRICE","PRICE","PUNIT_CNT","PUNIT_UNIT",
																	"PUNIT_WGHT","PKG_LNGTH","PKG_WIDTH","PKG_HEIGHT","PKG_CBM",
															"PKG_CNT","LDCARGONM","OFFCARGONM"
													 }; 

				
						
				int[] intArrCN = new int[] { 10, 4, 6, 50, 8,
												50, 50, 50, 40, 62,
													50, 50, 100, 50, 13, 
														50, 13, 13, 13, 10, 
													  13, 13, 13, 13, 13, 
												   13, 100, 100
													}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
												-1, -1, -1, -1, -1,
													-1, -1, -1, -1, 2,
														-1, 2, 2, 2, -1,
													2, 2, 2, 2, 2,
												2, -1, -1
											}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (isNotOnlyHeader) {					
						StringBuffer sql = new StringBuffer();

							sql.append(" SELECT \n ") ; 
							sql.append(" M.ORDER_NO AS ORDER_NO, D.ORDER_SEQ AS ORDER_SEQ, \n ") ; 
							sql.append(" CASE WHEN M.IN_OUT ='O' \n ") ; 
							sql.append(" THEN '반출' ELSE '반입' END AS IN_OUT, \n ") ; 
							sql.append(" RTRIM(C.MINORNM) AS ORDER_STS, SUBSTRING(M.ETD_DT,1,8) AS ETD_DT, \n") ; 
							sql.append(" RTRIM(C2.MINORNM) AS LINE_PART, RTRIM(C5.MINORNM) AS LDCARGO, \n") ; 
							sql.append(" RTRIM(C6.MINORNM) AS OFFCARGO, RTRIM(A1.CDNAM) AS PROJECT, \n") ; 
							sql.append(" RTRIM(A2.VEND_NM) AS CUST_NM, RTRIM(C3.MINORNM) AS CARGO_TYPE, \n") ; 
							sql.append(" RTRIM(C4.MINORNM) AS DLVL_TYPE, \n") ; 

							sql.append(" D.ARTC_NM, D.STN_SZNM, D.ARTC_CNT, RTRIM(C7.MINORNM) AS ARTC_UNIT, D.UNIT_PRICE, D.PRICE, \n" ) ;
							sql.append(" D.PUNIT_CNT, D.PUNIT_UNIT, D.PUNIT_WGHT, D.PKG_LNGTH, D.PKG_WIDTH, \n" ) ; 
							sql.append(" D.PKG_HEIGHT, D.PKG_CBM, D.PKG_CNT, D.LDCARGONM, D.OFFCARGONM \n ") ; 
							
							sql.append(" FROM TRANSFER.LTORDERMST M, TRANSFER.LTORDERDTL D, TRANSFER.LTLCODE C, \n ") ; 
							sql.append(" TRANSFER.LTLCODE C2, TRANSFER.LTLCODE C3, TRANSFER.LTLCODE C4, TRANSFER.LTLCODE C5, \n ") ;
							sql.append(" TRANSFER.LTLCODE C6, TRANSFER.LTLCODE C7, ACCOUNT.COMMDTIL A1, ACCOUNT.GCZM_VENDER A2 \n") ;
							
							sql.append(" WHERE M.ORDER_NO = D.ORDER_NO AND M.ORDER_STS=C.MINORCD AND M.LINE_PART=C2.MINORCD \n") ;
							sql.append(" AND M.CARGO_TYPE=C3.MINORCD AND M.DLVL_TYPE=C4.MINORCD AND D.LDCARGO=C5.MINORCD \n") ;
							sql.append(" AND D.OFFCARGO=C6.MINORCD AND M.PROJECT=A1.CDCODE AND M.CUST_CD=A2.VEND_CD AND D.ARTC_UNIT =C7.MINORCD \n") ;
							sql.append(" AND C.MAJORCD='0009'  AND C2.MAJORCD='0002' AND C3.MAJORCD='0003'  \n") ;
							sql.append(" AND C4.MAJORCD='0001' AND C7.MAJORCD='0008' AND A1.CMTYPE='0030' \n") ;
							
						
						
if(str1 !=null && str2 !=null ){ sql.append(" AND M.ETD_DT BETWEEN  '" +str1 + "' AND '" + str2 + "'");}
if(str3 !=null  ){ sql.append(" AND M.ORDER_NO =   '" +str3 + "'" );}
if(str4 !=null  ){ sql.append(" AND A2.VEND_NM =   '" +str4 + "'" );}
if(str5 !=null  ){ sql.append(" AND M.LINE_PART =   '" +str5 + "'" );}
if(str6 !=null  ){ sql.append(" AND D.LDCARGO =  '" +str6 + "'" );}

//if(str8 !=null  ){ sql.append(" AND A.CARGO_TYPE  =  '" +str8 + "'" );}
if(str7 !=null  ){ sql.append(" AND D.OFFCARGO  =  '" +str7 + "'" );}

if(str8 !=null  ){ sql.append(" AND M.CARGO_TYPE  =  '" +str8 + "'" );}
if(str9 !=null  ){ sql.append(" AND M.DLVL_TYPE  = '" +str9 + "'" );}
if(str10 !=null  ){ sql.append(" AND ARTC_NM LIKE   '%" +str10 + "%'" );}

	sql.append(" ORDER BY M.ORDER_NO DESC, INT(D.ORDER_SEQ) ASC ");
//logger.dbg.println(this,sql.toString());

//if (isDebug) {	
// GauceRes.writeException("Sql",":",sql.toString()); }


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