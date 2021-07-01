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
public class asetdep_popup_sp2 extends HttpServlet {
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
		CallableStatement stmt =null;
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

				String  str1 = req.getParameter("v_str1");    //지점
				String  str2 = req.getParameter("v_str2");    //감가상각년월
				String  str3 = req.getParameter("v_str3");    //감가상각년
				String  str4 = req.getParameter("v_str4");    //감가상각월
				String  str5 = req.getParameter("v_str5");    //성공구분 Y/N

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				
				GauceRes.enableFirstRow(dSet);
        
				/* 
				logger.dbg.println(this,"str1:::"+str1);
				logger.dbg.println(this,"str2:::"+str2);
				logger.dbg.println(this,"str3:::"+str3);
				logger.dbg.println(this,"str4:::"+str4);
				logger.dbg.println(this,"str5:::"+str5);
				*/

				String[] strArrCN = new String[]{ "FDCODE", "ASTYM", "ASTYY", "ASTMM", "S_YN"}; 
				
				int[] intArrCN = new int[]{ 2, 6, 4, 2, 1}; 
					
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
				
					StringBuffer sql = new StringBuffer();
					sql.append( " CALL ACCOUNT.PR_CAL_DEPR_CANCEL(?,?,?,?,?) ");

					stmt = conn.prepareCall(sql.toString());

					stmt.setString(1,str1);
					stmt.setString(2,str2);
					stmt.setString(3,str3);
					stmt.setString(4,str4);
					stmt.registerOutParameter (5, Types.CHAR);

					stmt.execute();

					//logger.dbg.println( this, sql.toString() );
/*********************************************************************************************/
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