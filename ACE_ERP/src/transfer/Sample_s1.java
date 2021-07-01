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
public class Sample_s1 extends HttpServlet {

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
					if (str1==null || str1.trim().length()==0 ) {   str1=null; } //사용자 ID
				String str2 = GauceReq.getParameter("gstr2");   
					if (str2==null || str2.trim().length()==0 ) {   str2=null; } //사용자명
				String str3 = GauceReq.getParameter("gstr3");   
					if (str3==null || str3.trim().length()==0 ) {   str3=null; } //프로젝트
			    String str4 = GauceReq.getParameter("gstr4");   
					if (str4==null || str4.trim().length()==0 ) {   str4=null; } //담당자명

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "USERID","USERPW","USERNM","REGNO","ZIPCD",
														"ADDR1","ADDR2","REGNM","TEL1","TEL2",
																"TEL3","FAX1","FAX2","FAX3","MOBILE1",
																		"MOBILE2","MOBILE3","EMAIL","RELPART","CREATE_DT",
																			"CREATE_USR","UPDATE_DT", "UPDATE_UST",
																				"TEL", "MOBILE", "VEND_ID", "AAA"
												};
				int[] intArrCN = new int[] { 10, 10, 30, 13, 6,
												100, 100, 30, 4, 4,
													4, 4, 4, 4, 4,
														4, 4, 50, 4, 10,
															10, 10,10,
																30, 20, 20, 20
												}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
												-1, -1, -1, -1, -1,
													-1, -1, -1, -1, -1,
														-1, -1, -1, -1, -1,
															-1, -1, -1,
																-1, -1, -1, -1
												}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				

					if (isNotOnlyHeader) {		

 
						StringBuffer sql = new StringBuffer();
						sql.append(" SELECT DISTINCT " ) ; 
						sql.append(" A.USERID,A.USERPW,A.USERNM,A.REGNO,A.ZIPCD,    \n " ) ; 
						sql.append(" A.ADDR1,A.ADDR2,A.REGNM,A.TEL1,A.TEL2,    \n " ) ; 
						sql.append(" A.TEL3,A.FAX1,A.FAX2,A.FAX3,A.MOBILE1,    \n " ) ; 
						sql.append(" A.MOBILE2,A.MOBILE3,A.EMAIL,A.RELPART,A.CREATE_DT,    \n " ) ; 
						sql.append(" A.CREATE_USR,A.UPDATE_DT,A.UPDATE_UST,   \n " ) ; 
						sql.append(" A.TEL1||'-'||A.TEL2||'-'||A.TEL3 AS TEL,  \n " ) ; 
						sql.append(" A.MOBILE1||'-'||A.MOBILE2||'-'||A.MOBILE3 AS MOBILE, B.VEND_ID,  \n " ) ; 
						sql.append(" CASE WHEN A.REGNO = B.VEND_ID THEN 'Y' \n " ) ;
						sql.append(" ELSE 'N' END AAA \n " ) ;
					
						sql.append(" FROM TRANSFER.LTUSER A  \n " ) ; 
						sql.append(" LEFT JOIN ACCOUNT.GCZM_VENDER B ON A.REGNO= B.VEND_ID \n " ) ; 
						sql.append(" WHERE A.USERID IS NOT NULL " ) ; 
/*if (str1 !=null){		sql.append(" AND A.USERID = '" + str1 + "'") ;  }		
if (str2 !=null){       sql.append(" AND A.USERNM LIKE  '%" +str2 + "%'" );}
if (str3 !=null){       sql.append(" AND A.RELPART = '" +str3 + "'" );}
if (str4 !=null){       sql.append(" AND A.REGNM LIKE  '%" +str4 + "%'" );}*/
//logger.dbg.println(this,sql.toString());

//if (isDebug) {	
// GauceRes.writeException("Sql",":",sql.toString()); }


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