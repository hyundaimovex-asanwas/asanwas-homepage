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
public class h090001_s1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");		//부서
				String  str2  = req.getParameter("v_str2");		//년월
				String  str3  = req.getParameter("v_str3");		//사번

				if (str1 ==null)	{ str1 = ""; }
				if (str2 ==null)  { str2 = ""; }
				if (str3==null) 	{ str3 = ""; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO","EMPNMK", "ATTDAY","ATTTIME","CLODAY",
																					"CLOTIME","DEPTCD","OVERWK","DEPTNM" }; 

				int[] intArrCN = new int[] { 7,  20,	8,  6,  8,  6,  4,	4, 70 }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1,  -1, 1, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT " );	//U
						sql.append( " RTRIM(A.EMPNO) EMPNO, RTRIM(B.EMPNMK)  EMPNMK,  RTRIM(A.ATTDAY)  ATTDAY,  RTRIM(A.ATTTIME) ATTTIME, " );
						sql.append( " RTRIM(A.CLODAY) CLODAY, RTRIM(A.CLOTIME) CLOTIME, RTRIM(A.DEPTCD)  DEPTCD,  A.OVERWK, C.DEPTNM " );
						sql.append( " FROM PAYROLL.T_HLATTEND A, ");
						sql.append( " PAYROLL.T_HIPERSON B, ");
						sql.append( " PAYROLL.HCDEPT C ");
						sql.append( " WHERE A.EMPNO = B.EMPNO AND A.DEPTCD = C.DEPTCD " );

						if (str1.equals(""))	{
							sql.append( " AND A.EMPNO = '"+str3+"'" );
							sql.append( " AND A.DEPTCD LIKE '%' " );
						} else {
							sql.append( " AND A.EMPNO = '"+str3+"'" );
							sql.append( " AND A.DEPTCD = '" + str1 + "' " );
						}

						if (str2.equals("")) { 
							sql.append( " AND A.ATTDAY LIKE '%' ");
						}else{
							sql.append( " AND A.ATTDAY LIKE '"+str2+"%' ");
						}

						sql.append( " ORDER BY DEPTNM, ATTDAY DESC ");

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