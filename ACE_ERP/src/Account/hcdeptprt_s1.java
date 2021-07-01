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
public class hcdeptprt_s1 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1"); //부서코드
				String  str2	= req.getParameter("v_str2"); //부서명
				String  str3	= req.getParameter("v_str3"); //조직도
				String  str4	= req.getParameter("v_str4"); //본부

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "DEPTCD","DEPTNM","TREECD" }; 

				int[] intArrCN = new int[] {  4, 50,  8 }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT RTRIM(DEPTCD)DEPTCD,RTRIM(DEPTNM)DEPTNM,RTRIM(TREECD)TREECD	 \n" );
					sql.append( " FROM PAYROLL.HCDEPT													 \n" );
					sql.append( " WHERE DEPTCD <> ''													 \n" );
					sql.append( " AND USEYN = 'T' AND LEVEL ='2'										 \n" );
					sql.append( " AND DEPTCD NOT IN ('A000','A050','A100','A200','A300','A400')			 \n" );
                    if (!str1.equals("")) sql.append( " AND DEPTCD ='" + str1 + "'						 \n" );
					if (!str2.equals("")) sql.append( " AND DEPTNM LIKE '%" + str2 + "%'			     \n" );
					if (!str3.equals("")) sql.append( " AND TREECD = '" + str3 + "'						 \n" );
					if (!str4.equals("")) sql.append( " AND DEPTCD LIKE '" + str4 + "%'					 \n" );
					sql.append( " ORDER BY DEPTCD														 \n" );

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