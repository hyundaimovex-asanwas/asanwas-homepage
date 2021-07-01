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
public class a050010_s2 extends HttpServlet {
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
				String  str1 = req.getParameter("v_str1");	//법인구분  
				String  str2 = req.getParameter("v_str2");	//귀속년도  
				String  str3 = req.getParameter("v_str3");	//반기구분  
				String  str4 = req.getParameter("v_str4");	//반기내순번
				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";
				if(str3 == null) str3 = "";
				if(str4 == null) str4 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
          "REFNO",	"FDCODE",	"RCDGB", 	 "ACCYY",	"ACCHF",	 "HALFNO",	"VENDID",
					"CARDGB",	"CARDNO",	"AFVENDID","VCNT",	"NUMEXP1", "REQAMT",	"NUMEXP2",	"TAXAMT",	"FILLER"
				}; 

				int[] intArrCN = new int[]{
          34, 2, 2, 4, 1, 1,10,
           1,20,10, 9, 1,13, 1, 13, 54 
				}; 
			
				int[] intArrCN2 = new int[]{     
					-1, -1, -1, -1, -1, -1, -1,
					-1, -1, -1,  0, -1,  0, -1, 0, -1 
          
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append(" SELECT REFNO,	FDCODE,	RCDGB,	  ACCYY,	ACCHF,	  HALFNO,	VENDID, \n");
					sql.append("        CARDGB,	CARDNO,	AFVENDID,	VCNT,	  NUMEXP1,	REQAMT,	NUMEXP2,	TAXAMT,	FILLER\n");
 					sql.append("   FROM ACCOUNT.AVATRPT82 \n");
 					sql.append("  WHERE RCDGB='DL' \n");
 					if(!str1.equals("")) sql.append(" AND FDCODE = '"+str1+"'");//법인구분        
 					if(!str2.equals("")) sql.append(" AND ACCYY = '"+str2+"' ");//귀속년도
 					if(!str3.equals("")) sql.append(" AND ACCHF = '"+str3+"' ");//반기구분
					if(!str4.equals("")) sql.append(" AND HALFNO= '"+str4+"' ");//반기내순번
					sql.append("  ORDER BY AFVENDID, CARDNO  ");//반기내순번
          
					//	logger.dbg.println(this, sql.toString());

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