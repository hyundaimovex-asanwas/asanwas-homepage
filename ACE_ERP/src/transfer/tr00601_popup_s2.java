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
public class tr00601_popup_s2 extends HttpServlet {

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
				if ( GauceReq.getParameter("NOH")!=null && GauceReq.getParameter("NOH").equals("Y") ) { isNotOnlyHeader = true; }
				
				
				String str1 = GauceReq.getParameter("gstr1");   
					if (str1==null || str1.trim().length()==0 ) {   str1=null; } //거래처명
				String str2 = GauceReq.getParameter("gstr2");   
					if (str2==null || str2.trim().length()==0 ) {   str2=null; }//거래처코드

				 

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"VEND_CD","VEND_NM","VD_TELNO","VD_FAXNO",
					
													"VEND_PRS","VEND_PST","VEND_TEL","VEND_CPHN","VEND_FAX",
													
														"VEND_EMAIL","PROJECT_CD","REMARK","ADDRESS1","ADDRESS2","ADDRESS3"
														
													}; 

				int[] intArrCN = new int[] { 13,62,25,25,30,30,25,25,25,50,4,100,35,35,35 }; 
			
				int[] intArrCN2 = new int[]{ -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (isNotOnlyHeader) {					
						StringBuffer sql = new StringBuffer();
						sql.append(" SELECT 																										\n " )  ;             

						sql.append(" A.VEND_CD,A.VEND_NM,A.VD_TELNO,A.VD_FAXNO,									\n " )  ; 
						sql.append(" B.VEND_PRS,B.VEND_PST,B.VEND_TEL,B.VEND_CPHN,B.VEND_FAX,		\n " )  ; 
						sql.append(" B.VEND_EMAIL,B.PROJECT_CD, B.REMARK 												\n " )  ; 
						sql.append(" ,IFNULL(B.VEND_ADD1,'') AS ADDRESS1,IFNULL(B.VEND_ADD2,'') AS ADDRESS2, 				\n " )  ; 
						sql.append(" IFNULL(B.VEND_ADD3,'') AS ADDRESS3 									\n " )  ; 
						sql.append(" FROM  ACCOUNT.GCZM_VENDER A " 												)  ; 
						sql.append(" LEFT JOIN TRANSFER.LTCUSTMST B ON " 										)  ; 
						 
						sql.append(" A.VEND_CD = B.VEND_CD  AND A.VEND_NM = B.VEND_NM" 			)  ; 
						sql.append(" WHERE A.VEND_NM IS NOT NULL 											\n " )  ; 
						
if(str1 != null )       sql.append( " AND A.VEND_NM LIKE '%" + str1 + "%' 				\n" ) ; 
if(str2 != null )       sql.append( " AND A.VEND_CD LIKE '%" + str2 + "%' 					" ) ; 


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