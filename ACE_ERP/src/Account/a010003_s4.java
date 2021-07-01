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
public class a010003_s4 extends HttpServlet {
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
				str[0]	= req.getParameter("v_str1");	
				str[1]	= req.getParameter("v_str2");	
				str[2]	= req.getParameter("v_str3");	


				for (int s=0;s<=2;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "DEPTCD", "DEPTNMK", "BGTDIVCD", "BGTDEPT",
																					"BGTDIVCD1", "BGTDEPT1"
				}; 

				int[] intArrCN = new int[]{		4, 70,  4,  4,
																		 40, 40
				}; 
			
				int[] intArrCN2 = new int[]{	-1, -1, -1, -1,
																			-1, -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				}
				
				if (!GauceReq.isBuilderRequest()) {
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT A.DEPTCD DEPTCD, A.DEPTNMK DEPTNMK, A.BGTDIVCD BGTDIVCD, A.BGTDEPT BGTDEPT,	\n");
					sql.append( "				 B.CDNAM BGTDIVCD1, C.CDNAM BGTDEPT1																	\n");
					sql.append( "   FROM PAYROLL.HCDEPT A LEFT JOIN ACCOUNT.COMMDTIL B  													\n");
					sql.append( "   	ON A.BGTDIVCD = B.CDCODE AND B.CMTYPE='0004' 																\n");
					sql.append( "		LEFT JOIN ACCOUNT.COMMDTIL C ON A.BGTDEPT = C.CDCODE AND C.CMTYPE='0003'				\n");
					sql.append( "  WHERE USEYN='T'																													\n");
					sql.append( "   AND A.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT WHERE CHGYM<='"+str[2]+"') 		\n");
					if(!str[0].equals(""))sql.append( " AND A.DEPTCD = '"+str[0]+"' 																			\n");
					if(!str[1].equals(""))sql.append( " AND A.DEPTNMK LIKE '%"+str[1]+"%' 																	\n");

					//System.out.println("a010003_s4::"+sql.toString()); 
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