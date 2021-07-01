package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class H100012_s1 extends HttpServlet {

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

				String  str1	= req.getParameter("v_str1");	//
				if (str1==null) { str1 = ""; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO","EMPNMK","BCHK","PAYSEQ","DEPTCD","PAYGRD","GRDDIV","GRDDIV2"
																				}; //9

				int[] intArrCN = new int[]{ 7, 20, 1, 4 ,4 , 4, 4, 4
																	}; //9

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1,-1,-1
																	}; //9

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
                    sql.append( "     SELECT  \n");
                    sql.append( "           A.EMPNO, A.EMPNMK, \n");
                    sql.append( "           'F' AS BCHK , RTRIM(A.PAYSEQ) AS PAYSEQ, \n");
                    sql.append( "            RTRIM(A.DEPTCD) AS DEPTCD,RTRIM(A.PAYGRD) AS PAYGRD, RTRIM(A.GRDDIV) AS GRDDIV,  \n");
                    sql.append( "           (GRDDIV-1) AS GRDDIV2 \n");
                    sql.append( "            FROM PAYROLL.T_HIPERSON A  \n");                
                    sql.append( "           WHERE A.USESTS != '3'  \n");
										sql.append( "						AND a.empno!= '3090002' \n");
										sql.append( "						AND IFNULL(A.PAYSEQ,'')!='' \n");
										sql.append( "						AND IFNULL(A.GRDDIV,'')!='' \n");
                    sql.append( " ORDER BY A.EMPNO \n");

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