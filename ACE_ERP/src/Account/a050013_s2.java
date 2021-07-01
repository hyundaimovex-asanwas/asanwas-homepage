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
public class a050013_s2 extends HttpServlet {
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
				String  str1 = req.getParameter("v_str1");	//지점        
				String  str2 = req.getParameter("v_str2");	//년도        
				String  str3 = req.getParameter("v_str3");	//반기구분    

				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";
				if(str3 == null) str3 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
		 "FDCODE",	 "DATADIV",	  "ACCYM",	   "RPTGB",	  "VENDID",	
				 "CNT_SUM",  "FOAMT_SUM",	"KOAMT_SUM", "EXCNT",	  "EXFOAMT",	
				 "EXKOAMT",  "ETCNT",	    "ETFOAMT",	 "ETKOAMT", "FILLER"

				}; 

				int[] intArrCN = new int[]{
		  2, 1, 6, 1, 10, 
		  7,15,15, 7, 15,
		 15, 7,15,15, 51  
				}; 
			
				int[] intArrCN2 = new int[]{     
					-1, -1, -1, -1, -1,
					 0,  2,  0,  0,  2,
		   0 , 0,  2,  0,  -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append(" SELECT FDCODE,	 DATADIV,	  ACCYM,	    RPTGB,	  VENDID,	  \n");
					sql.append("        CNT_SUM, FOAMT_SUM,	KOAMT_SUM,	EXCNT,	  EXFOAMT,  \n");
					sql.append("        EXKOAMT, ETCNT,	    ETFOAMT,	  ETKOAMT,  FILLER    \n");
					sql.append("   FROM ACCOUNT.AVATRPT92 \n");
					sql.append("  WHERE 1=1 \n");
					if(!str1.equals("")) sql.append(" AND FDCODE  = '"+str1+"' \n");//        
					if(!str2.equals("")) sql.append(" AND DATADIV = '"+str2+"' \n");//
					if(!str3.equals("")) sql.append(" AND ACCYM   = '"+str3+"' \n");//
					
          
					//logger.dbg.println(this, sql.toString());

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