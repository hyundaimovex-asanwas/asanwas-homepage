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
public class comm_rate_chk_s1 extends HttpServlet {
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
			  
			  String [] str = new String [3];
				str[0]	= req.getParameter("v_str1");	//지점
				str[1]	= req.getParameter("v_str2");	//TO 년월
        str[2]=str[1].substring(0,4);  //from년

				for (int s=0;s<=2;s++) {
					if(str[s]==null || str[s]=="NaN") str[s] = "";
				}
      
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CNT"}; 

				int[] intArrCN = new int[]{ 10}; 
			
				int[] intArrCN2 = new int[]{ 0}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT COUNT(*) CNT FROM ACCOUNT.GENENLED                 " );
				  sql.append( " WHERE EXRATEGB IN ('1','4')                               " );
          //////sql.append( " WHERE EXRATEGB IN ('99')                               " );
					if(!str[0].equals(""))sql.append( "   AND FDCODE  ='"+str[0]+"'         " );
					sql.append( "   AND FODEAMT =0                                          " );
					sql.append( "   AND FOCRAMT =0                                          " );
				  //sql.append( "   AND SUBSTR(ACTDAT,1,6)>='"+str[2]+"01' AND  SUBSTR(ACTDAT,1,6) <='"+str[1]+"' " );
					sql.append( "   AND SUBSTR(ACTDAT,1,6) ='"+str[1]+"' " );
				
				  //logger.dbg.println(this , sql.toString());
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