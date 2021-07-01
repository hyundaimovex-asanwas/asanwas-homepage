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
public class dsPerson extends HttpServlet {
 
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
					if (str1==null || str1.trim().length()==0 ) {   str1=null; }
				String str2 = GauceReq.getParameter("gstr2");   
					if (str2==null || str2.trim().length()==0 ) {   str2=null; }
				String str3 = GauceReq.getParameter("gstr3");   
					if (str3==null || str3.trim().length()==0 ) {   str3=null; }
			  String str4 = GauceReq.getParameter("gstr4");   
					if (str4==null || str4.trim().length()==0 ) {   str4=null; }
			  String str5 = GauceReq.getParameter("gstr5");   
					if (str5==null || str5.trim().length()==0 ) {   str5=null; }
			
				 

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"PERSON_NO","PSN_KNAME","PSN_ENAME","ZIPCODE","ADDRESS1","ADDRESS2","REG_NO","GENDER","COMPANY","POSITION","INVITENO","INVITESTS" }; 
/*,"APPRDATE","RENEWDATE","ENDDATE","PURPOSE","CREATE_DT","CREATE_USR","UPDATE_DT","UPDATE_USR" 
,8,8,8,256,8,10,8,10,-1,-1,-1,-1,-1,-1,-1,-1  */
				int[] intArrCN = new int[] {10,30,30,6,50,50,13,1,10,10,9,1}; 
			
				int[] intArrCN2 = new int[]{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (isNotOnlyHeader) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT "); 	
						sql.append( " IFNULL(PERSON_NO,'') AS PERSON_NO,IFNULL(PSN_KNAME,'') AS PSN_KNAME,") ; 
						sql.append( " IFNULL(PSN_ENAME,'') AS PSN_ENAME,") ; 
						sql.append( " IFNULL(ZIPCODE,'') AS ZIPCODE,IFNULL(ADDRESS1,'') AS ADDRESS1,") ; 
						sql.append( " IFNULL(ADDRESS2,'') AS ADDRESS2,IFNULL(REG_NO,'') AS REG_NO,IFNULL(GENDER,'') AS GENDER, ") ; 
						sql.append( " IFNULL(COMPANY,'') AS COMPANY,IFNULL(POSITION,'') AS POSITION,") ; 
						sql.append( " IFNULL(INVITENO,'') AS INVITENO,IFNULL(INVITESTS,'') AS INVITESTS");
						/*sql.append( " ,IFNULL(APPRDATE,'') AS APPRDATE, ") ; 
						sql.append( " IFNULL(RENEWDATE,'') AS RENEWDATE,IFNULL(ENDDATE,'') AS ENDDATE,") ; 
						sql.append( " IFNULL(PURPOSE,'') AS PURPOSE, ") ;
						sql.append( " IFNULL(CREATE_DT,'') AS CREATE_DT,IFNULL(CREATE_USR,'') AS CREATE_USR") ; 
						sql.append( " ,IFNULL(UPDATE_DT,'') AS UPDATE_DT,IFNULL(UPDATE_USR,'') AS UPDATE_USR " ) ; */
						sql.append( " FROM TRANSFER.LTPERSON " ) ; 
						sql.append( " WHERE PERSON_NO IS NOT NULL " ) ; 
if(str1 !=null)		sql.append( " AND  PERSON_NO = '" +str1 + "'" ) ; 



 if (isDebug) {	
 GauceRes.writeException("Sql",":",sql.toString()); }
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