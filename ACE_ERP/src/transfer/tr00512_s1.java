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
public class tr00512_s1 extends HttpServlet {

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
					if (str1==null || str1.trim().length()==0 ) {   str1=null; }
				 

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CAR_TYPE","CAR_NAME","CAR_LENGTH","CAR_WIDTH","CAR_HEIGHT","CAR_CBM","CAR_TON",
																	"CAR_CLASS","CREATE_DT","CREATE_USR","UPDATE_DT","UPDATE_USR", "SECTION"}; 

				int[] intArrCN = new int[] { 4,30,7,7,7,7,7,4,10,10,10,10, 4 }; 
			
				int[] intArrCN2 = new int[]{ -1,-1,2,2,2,2,2,-1,-1,-1,-1,-1, -1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (isNotOnlyHeader) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT  \n " )  ; 
						sql.append( " CAR_TYPE,CAR_NAME,CAR_LENGTH,CAR_WIDTH, \n " )  ; 
						sql.append( " CAR_HEIGHT,CAR_CBM,CAR_TON,CAR_CLASS, \n " )  ; 
						sql.append( " CREATE_DT,CREATE_USR,UPDATE_DT,UPDATE_USR , SECTION \n " )  ; 
						sql.append( " FROM TRANSFER.LTCARTYPE ") ; 
						sql.append( " WHERE CAR_TYPE IS NOT NULL " ) ;
if(str1 != null ) sql.append( " AND CAR_NAME LIKE '%" + str1 + "%' " ) ; 
						sql.append( " ORDER BY CAR_TYPE " ) ;


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