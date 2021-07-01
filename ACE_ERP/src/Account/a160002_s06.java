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
public class a160002_s06 extends HttpServlet {
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
				String [] str = new String [10];
				str[0]	= req.getParameter("v_str1");		//지점구분                  
				str[1]	= req.getParameter("v_str2");		//회계년도 from
				str[2]	= req.getParameter("v_str3");		//회계년도 to

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "FSAMT6" }; 

				int[] intArrCN = new int[] { 15 }; 
			
				int[] intArrCN2 = new int[]{ 0 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					}
				}

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					
			          sql.append("\n SELECT nvl(SUM(FSAMT),0) FSAMT6                                      ");
			          sql.append("\n   FROM ACCOUNT.FSLIPDTL A,ACCOUNT.FSLIPREF B                  ");
			          sql.append("\n  WHERE A.FDCODE = B.FDCODE                                    ");
			          sql.append("\n    AND A.SSDAT = B.SSDAT                                      ");
			          sql.append("\n    AND A.SSNBR = B.SSNBR                                      ");
			          sql.append("\n    AND A.FSSEQ = B.FSSEQ                                      ");
			          sql.append("\n    AND B.FSREFCD = '1103'                                     ");
			          sql.append("\n    AND B.FSREFVAL IN ('002','005','006','008')                ");
			          sql.append("\n    AND A.FDCODE LIKE '"+str[0]+"%'                            ");
			          sql.append("\n    AND A.SSDAT >= 'A"+str[1]+"'                                ");
			          sql.append("\n    AND A.SSDAT <= 'A"+str[2]+"'                                ");
			          sql.append("\n    AND A.ATCODE IN ('4331700','4331800')                      ");
			          sql.append("\n    AND A.FSAMT <= 50000                                       ");
          
			          //System.out.println("# Query : \n" + sql);
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