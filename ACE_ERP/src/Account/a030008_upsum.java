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

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class a030008_upsum extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// ���������� ���� ���۹���� Post Ÿ���� ���
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
		      
               //JNDI�� ����
               /**
			   hdconn hcon = new hdconn();
               conn = hcon.getHdConnection();  
               **/
			
			   Context initContext = (Context) new InitialContext();
			   DataSource ds = (DataSource) initContext.lookup("CforAccount");
			   conn = ds.getConnection();	 
					
               dSet = new GauceDataSet();

/**********************************************************************************************
	���� �������� �����Ͻ� �κ�
**********************************************************************************************/
				// ������������ ���ǰ��� �Ѱܹ���

				GauceRes.enableFirstRow(dSet);
				String [] str = new String [4];
				str[0]	= req.getParameter("v_str1");		//����
				str[1]	= req.getParameter("v_str2");		//���
				str[2]	= req.getParameter("v_str3");		//���
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