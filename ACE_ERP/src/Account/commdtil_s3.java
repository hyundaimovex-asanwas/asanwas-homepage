package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class commdtil_s3 extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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
				String [] str =new String[3];
				str[0] = req.getParameter("v_str1");
				str[1] = req.getParameter("v_str2");
				str[2] = req.getParameter("v_str3");
				
				for (int s=0;s<=2;s++ ){
					if(str[s]==null) str[s]="";
				}
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CMTYPE",	"CDCODE", "CDNAM",	"CDREMARK",	
				                                  "WRDT",   "WRID",  	"UPDT",	  "UPID",	"DSUDT", "GBCD", "PSEQ", "REMARK","FSREFCD" }; 

				int[] intArrCN = new int[]{ 4, 20, 40, 60, 
					                          8,  7,  8,  7, 8, 6, 5, 60, 4}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, 
					                           -1, -1, -1, -1, -1, -1, -1, -1, -1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT A.CMTYPE, A.CDCODE, A.CDNAM, A.CDREMARK,	 " );
					sql.append( "        A.WRDT,  A.WRID,	A.UPDT,	 A.UPID, RTRIM(A.DSUDT)DSUDT, A.GBCD,A.PSEQ, B.CDNAM REMARK, B.CMTYPE FSREFCD " );
					sql.append( " FROM ACCOUNT.COMMDTIL A " );
					sql.append( " LEFT JOIN ACCOUNT.COMMDTIL B ON B.CDCODE =A.GBCD AND B.CMTYPE=A.CDREMARK " );
				  sql.append( " WHERE A.CMTYPE = '" + str[0] + "'" );
					if (!str[1].equals(""))sql.append( " AND ( A.CDCODE LIKE '%"+str[1]+"%' OR A.CDNAM LIKE '%"+str[1]+"%')"  );
					if (!str[2].equals(""))sql.append( " AND ( B.CDNAM LIKE '%"+str[2]+"%')"  );
					
					//logger.dbg.println(this,sql.toString());
/*********************************************************************************************/

					stmt = conn.getGauceStatement(sql.toString());
	 		    stmt.executeQuery(dSet);
				}
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