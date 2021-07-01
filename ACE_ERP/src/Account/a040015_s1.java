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
public class a040015_s1 extends HttpServlet {
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
				// 전체조회
				String  str1	= req.getParameter("v_str1");  //지점
				String  str2  = req.getParameter("v_str2");  //회계년도
				String  str3  = req.getParameter("v_str3");  //구분

				if(str1 == null) str1 = ""; //지점       
				if(str2 == null) str2 = ""; //회계년도  
				if(str3 == null) str3 = ""; //구분       

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{   "GUBUN", "FDCODE","ACTYYMM","UPSTS", "UPID", "UPDT", "EMPNMK"
																						
				}; 

				int[] intArrCN = new int[]{ 1, 2, 6, 1, 10,	19, 30
				}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1, -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				}
				
				if (!GauceReq.isBuilderRequest()) {
					StringBuffer sql = new StringBuffer();
						
					sql.append(" SELECT A.GUBUN, A.FDCODE, A.ACTYYMM, A.UPSTS, A.UPID, A.UPDT , B.EMPNMK \n");
					sql.append("   FROM ACCOUNT.UPSUMSTS A \n");
					sql.append("   LEFT JOIN PAYROLL.YIPERSON B ON A.UPID = B.EMPNO AND USESTS IN ('1','2','3') \n");
					sql.append("  WHERE 1=1 \n");
					if(!str1.equals("A"))sql.append(" AND A.FDCODE ='"+str1+"' \n");
					if(!str2.equals("")) sql.append(" AND A.ACTYYMM LIKE '"+str2+"%' \n");
					if(!str3.equals("A"))sql.append(" AND A.GUBUN ='"+str3+"' \n");
					sql.append("  ORDER BY A.ACTYYMM ASC \n");
						
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