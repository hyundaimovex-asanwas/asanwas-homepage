package sales.menu.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class bm053i_s4 extends HttpServlet {

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
				String [] str = new String[6];
        str[0] =  req.getParameter("v_str1"); //
				str[1] =  req.getParameter("v_str2"); //
				str[2] =  req.getParameter("v_str3"); //
				str[3] =  req.getParameter("v_str4"); //
				str[4] =  req.getParameter("v_str5"); //
				str[5] =  req.getParameter("v_str6"); //

		
        for(int i=0;i<=5;i++){
					if(str[i]==null) str[i]="";
				} 
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "UP_SID"                
																		  	}; //

				int[] intArrCN = new int[] { 10
																	 }; 
			
				int[] intArrCN2 = new int[]{ 0
																	 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( "	 SELECT UP_SID              \n");
						sql.append( "	   FROM SALES.TCM090        \n");
						sql.append( "	   WHERE 1=1                \n");						
						if(!str[0].equals(""))sql.append( "	  AND UP_DATE = '"+str[0]+"'  \n");
						if(!str[1].equals(""))sql.append( "	  AND UP_NUM = '"+str[1]+"'    \n");
						if(!str[2].equals(""))sql.append( "	  AND TEL_NUM = '"+str[2]+"'   \n");
						if(!str[3].equals(""))sql.append( "	  AND END_TIME = '"+str[3]+"'  \n");
						if(!str[4].equals(""))sql.append( "	  AND TEL_DURA = '"+str[4]+"'  \n");
						if(!str[5].equals(""))sql.append( "	  AND TEL_FEE = "+str[5]+"     \n");

						//logger.dbg.println(this,sql.toString());
						
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