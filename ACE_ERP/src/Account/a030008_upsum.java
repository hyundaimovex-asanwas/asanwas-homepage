package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class a030008_upsum extends HttpServlet {
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
		Connection conn = null;
		CallableStatement cstmt =null;
		GauceDataSet dSet = null;

		try {
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
            GauceResponse GauceRes = service.getGauceResponse();

			try {
		      
               //JNDI로 변경
               /**
			   hdconn hcon = new hdconn();
               conn = hcon.getHdConnection();  
               **/
			
			   Context initContext = (Context) new InitialContext();
			   DataSource ds = (DataSource) initContext.lookup("CforAccount");
			   conn = ds.getConnection();	 
					
               dSet = new GauceDataSet();

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음

				GauceRes.enableFirstRow(dSet);
				String [] str = new String [4];
				str[0]	= req.getParameter("v_str1");		//지점
				str[1]	= req.getParameter("v_str2");		//년월
				str[2]	= req.getParameter("v_str3");		//사번
				str[3]	= "N";													//Default 'N'

				for (int s=0;s<=3;s++) {
					if (str[s]==null) str[s] = "";
				}

				String[] strArrCN = new String[]{ "FDCODE","YYYYMM","EMPNO", "RETURN" };

				int[] intArrCN = new int[] {  2,  6, 10, 1 }; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {		
						StringBuffer query = new StringBuffer();
	 		            query.append("  CALL ACCOUNT.PR_COMM_UPATCODE(?,?,?,?) ");
						cstmt = conn.prepareCall(query.toString());

						cstmt.setString(1, str[0] );
 						cstmt.setString(2, str[1] );
						cstmt.setString(3, str[2] );
						cstmt.registerOutParameter (4, Types.CHAR);	
						cstmt.executeUpdate();
						GauceDataRow row = dSet.newDataRow();
						for (int i=4;i<=4;i++) {
							row.addColumnValue(str[0]);
							row.addColumnValue(str[1]);
							row.addColumnValue(str[2]);
							row.addColumnValue(cstmt.getString(i));
							//logger.dbg.println(this,"str" + i + " : " + cstmt.getString(i));
						}
						dSet.addDataRow(row);
						cstmt.close();
						conn.close();
		/*********************************************************************************************/

				}
			} catch(Exception e) {
		  	logger.err.println(this,e);
			} finally {
				if (cstmt != null) try { cstmt.close(); } catch (Exception e) {}
				if (conn != null)  try { conn.close();} catch (Exception e) {}
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