package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class p030010_s1 extends HttpServlet {

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
	실제 업무에서 적용하실 부분  //2011.1.12   이 동 훈
**********************************************************************************************/

				// 웹페이지에서 조건값을 넘겨받음
				String  str1	= req.getParameter("v_str1");
				String  str2	= req.getParameter("v_str2");

				if (str1 == null){ str1 = "";}
				if (str2 == null){ str2 = "";}

		
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "GIVPRNM","GIVPRNO","GIVPRCD" }; //3

				int[] intArrCN = new int[] {  20, 13, 2 }; //3
				
				int[] intArrCN2 = new int[]{ -1, -1, 0 }; //3

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					}
				}

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT																																\n");
					sql.append( " RTRIM(FAMNM1) GIVPRNM,  RTRIM(RESINO1) GIVPRNO, RTRIM(RELAT1) GIVPRCD			 \n");
					sql.append( " FROM PAYROLL.YCPRSN 																									\n");

					if (str1!=null) {	sql.append( " WHERE EMPNO like '" + str1 + "%'															\n"); }
					if (str2!=null) {	sql.append( " AND  APPDT like '"  + str2 + "%'																\n"); }
					sql.append( " AND  RELAT1 in ( '0' ,'3' , '4', '5')																							\n");
					sql.append( " ORDER BY GIVPRNO ASC																										\n" );

					//logger.dbg.println( this, sql.toString() );

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