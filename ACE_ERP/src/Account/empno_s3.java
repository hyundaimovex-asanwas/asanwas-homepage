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
public class empno_s3 extends HttpServlet {
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
				String str1 = req.getParameter("v_str1");		//성명  
				String str2 = req.getParameter("v_str2");		//재직구분 0 - 전체 , 1 - 재직자 , 2 - 퇴사자 

				if (str1==null) str1 = "";
				if (str2==null) str2 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CHK", "EMPNO", "EMPNMK", "PAYGNM", "DEPTNM"};

				int[] intArrCN = new int[]{  1, 7, 20, 30, 30 }; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT	'' AS CHK,																					    \n");
					sql.append( "				RTRIM(A.EMPNO) AS EMPNO,RTRIM(A.EMPNMK) AS EMPNMK,		\n");
					sql.append( "               RTRIM(B.MINORNM) AS PAYGNM,RTRIM(C.DEPTNM) AS DEPTNM	\n");
					sql.append( "	 FROM PAYROLL.YIPERSON A,																		\n");
					sql.append( "               PAYROLL.HCLCODE B,																		\n");
					sql.append( "				PAYROLL.HCDEPT C																		\n");
					sql.append( "  WHERE A.PAYGRD = B.MINORCD																	\n");
					sql.append( "		AND A.DEPTCD = C.DEPTCD																	\n");
					sql.append( "		AND B.MAJORCD = '2002'																		    \n");
                   
                    if(str2.equals("0")) {
						sql.append( "	AND A.USESTS IN ( '1', '2', '3')	\n");
                    }else if(str2.equals("1")) {
						sql.append( "	AND A.USESTS IN ( '1', '2')			\n");
					}else if(str2.equals("2")) {		
						sql.append( "	AND A.USESTS IN ( '3')				\n");
					}
					
					if(!str1.equals("")) {
						sql.append( "   AND A.EMPNMK LIKE  ('" + str1 + "%' )\n");
					}
				
				    logger.dbg.println(this,sql.toString());
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