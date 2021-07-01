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
public class tr00601_popup_s1 extends HttpServlet {

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
					if (str1==null || str1.trim().length()==0 ) {   str1=null; } //거래처 코드
				String str2 = GauceReq.getParameter("gstr2");   
					if (str2==null || str2.trim().length()==0 ) {   str2=null; }//거래처명
				String str3 = GauceReq.getParameter("gstr3");   
					if (str3==null || str3.trim().length()==0 ) {   str3=null; }//거래처명
				 

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"CORP_CD","VEND_GB","VEND_CD","VEND_NM","VD_DIRECT","BSNS_CND" , "VEND_PRS","VEND_PST","VEND_TEL","VEND_CPHN","VEND_FAX","VEND_EMAIL","VEND_LCT","PROJECT","EXT_TEX1","EXT_TEX2","EXT_TEX3","REMARK","ADDRESS1","ADDRESS2"}; 

				int[] intArrCN = new int[] { 6,1,13,32,12,22,20,20,13,13,13,20,10,10,20,20,20,20 ,35 ,35  }; 
			
				int[] intArrCN2 = new int[]{ -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1 ,-1,-1  }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (isNotOnlyHeader) {					
						StringBuffer sql = new StringBuffer();
						sql.append(" SELECT \n " )  ; 
						sql.append(" '' AS CORP_CD,'' AS VEND_GB,A.VEND_CD,\n " )  ; 
						sql.append(" A.VEND_NM,A.VD_DIRECT,A.BSNS_CND,\n " )  ; 
						sql.append(" B.VEND_PRS,B.VEND_PST,B.VEND_TEL,\n " )  ; 
						sql.append(" B.VEND_CPHN,B.VEND_FAX,B.VEND_EMAIL,B.VEND_LCT,B.PROJECT \n " )  ; 
						sql.append(" ,B.EXT_TEX1,B.EXT_TEX2,B.EXT_TEX3,B.REMARK " )  ; 
						sql.append(" ,IFNULL(A.ADDRESS1,'') AS ADDRESS1,IFNULL(A.ADDRESS2,'') AS ADDRESS2 ") ; 
						sql.append(" FROM  ACCOUNT.GCZM_VENDER A LEFT JOIN   TRANSFER.LTCUSTMST B " )  ; 
						sql.append(" ON " )  ; 
						//sql.append(" A.CORP_CD =B.CORP_CD AND " )  ; 
						//sql.append(" A.VEND_GB =B.VEND_GB AND " )  ; 
						sql.append(" A.VEND_CD = B.VEND_CD  " )  ; 
						sql.append(" WHERE A.VEND_CD IS NOT NULL \n " )  ; 
if(str1 != null )       sql.append( " AND A.VEND_CD = '" + str1 + "' \n" ) ; 
if(str2 != null )       sql.append( " AND A.VEND_NM LIKE '%" + str2 + "%' " ) ; 
if(str3 != null )       sql.append( " AND A.VEND_NM = '" + str3 + "' " ) ; 
 //GauceRes.writeException("Sql",":",sql.toString());


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