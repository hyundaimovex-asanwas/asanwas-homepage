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
public class dsCallSpTr00108 extends HttpServlet {
 
	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		CallableStatement cstmt =null;
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
				 
//				String str2 = "00HQKONIS1" ; 
				String str3 = "Y" ; 

				String str4 = GauceReq.getParameter("gstr4");   
					if (str4==null || str4.trim().length()==0 ) {   str4=null; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "PL_NO","PL1","PL2"  }; 
	
				int[] intArrCN = new int[] {20,20,20 }; 
			
				int[] intArrCN2 = new int[]{-1,-1,-1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				}  
	
				if (isNotOnlyHeader) {
					if(str4.equals("T")){
					StringBuffer sql = new StringBuffer();   					
					sql.append( "CALL TRANSFER.SP_TR00108(?,?,?) ") ;
			
					cstmt = conn.prepareCall(sql.toString());
					cstmt.setString(1, str1 );
 					cstmt.setString(2, str2 );
					cstmt.setString(3, str3 );
			  
				  cstmt.registerOutParameter (1, Types.CHAR );
				  cstmt.registerOutParameter (2, Types.CHAR );
				  cstmt.registerOutParameter (3, Types.CHAR ); 


					cstmt.execute();

					GauceDataRow row = dSet.newDataRow();
					row.addColumnValue(cstmt.getString(1));
					row.addColumnValue(cstmt.getString(2));
					row.addColumnValue(cstmt.getString(3));
					 
					dSet.addDataRow(row);

					cstmt.close();

					}

				}		
/*********************************************************************************************/
			 
			} catch(Exception e) {
		  	logger.err.println(this,e);
			GauceRes.writeException("Sql",":",e.toString());
		  } finally {
				if (cstmt != null) try { cstmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close();} catch (Exception e) {}
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