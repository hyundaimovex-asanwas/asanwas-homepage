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
public class a010049_s2 extends HttpServlet {
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
				String [] str = new String [2];
				str[0]	= req.getParameter("v_str1");		//사업자등록번호
				str[1]	= req.getParameter("v_str2");		//사용자 ID

				for (int s=0;s<=1;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "FND_USER","FND_REGNO","FND_REGNO_NAME","FND_USER_NAME","SMART_ID","SMART_PASSWORD","SMART_EMAIL"  }; 
				int[] intArrCN = new int[]{ 30, 10, 40, 15, 12, 35,30 }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1,-1 };

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT A.FND_USER, A.FND_REGNO,                                               							\n");
					sql.append( "              CASE WHEN A.FND_REGNO='1018510695' THEN '현대아산주식회사(서울지점)'  	\n");
					sql.append( "             WHEN A.FND_REGNO='2218113834' THEN '현대아산주식회사(고성본사)'  				\n");
					sql.append( "             END FND_REGNO_NAME,                                            									\n");
					sql.append( "             A.FND_USER_NAME,   A.SMART_ID,    A.SMART_PASSWORD, B.EMAIL AS SMART_EMAIL  \n");
					sql.append( "   FROM HDASAN_EDI.XXSB_DTI_SM_USER A                                         						\n");
					sql.append( "  LEFT JOIN PAYROLL.V_HIPERSON B ON A.FND_USER = B.EMPNO  AND USESTS IN ('1','2','3')        \n");
					if(!str[0].equals(""))sql.append( " WHERE FND_REGNO='"+str[0]+"'														\n");
					if(!str[1].equals("6070001"))sql.append( " AND FND_USER='"+str[1]+"'													\n");
					sql.append( "  ORDER BY A.FND_USER_NAME, A.FND_USER																\n");
					
	
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