package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class h060004_p6 extends HttpServlet {

	// ���������� ���� ���۹���� Post Ÿ���� ���
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
	
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		//GauceDBConnection conn = null;
		Connection conn = null;
		CallableStatement stmt =null;
		GauceDataSet dSet = null;

		try {
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
			GauceResponse GauceRes = service.getGauceResponse();

			try {
				//conn = service.getDBConnection();

        String dbUrl    = "";
				String driver   = "";
				String userName = "";
				String userPass = "";

				//����ƻ�
				dbUrl    = "jdbc:as400://203.242.32.198";
				driver   = "com.ibm.as400.access.AS400JDBCDriver";
				userName = "QPILOT";
				userPass = "PILOT";

				Class.forName(driver);			
				conn = DriverManager.getConnection(dbUrl, userName, userPass);

				dSet = new GauceDataSet();

/**********************************************************************************************
	���� �������� �����Ͻ� �κ�
**********************************************************************************************/
				// ������������ ���ǰ��� �Ѱܹ���

				String  str1 = req.getParameter("v_str1");    //���
				String  str2 = req.getParameter("v_str2");    //�ǰ����
				String  str3 = req.getParameter("v_str3");    //�������� Y/N

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				
				GauceRes.enableFirstRow(dSet);
	    
				String[] strArrCN = new String[]{ "YEARNM","GOGAJA","RETCOD"}; 
				
				int[] intArrCN = new int[]{  6,  7,  1}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1}; 
     		
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();
					sql.append( " CALL PAYROLL.SP_CAL_REVISION(?,?,?) ");
          stmt = conn.prepareCall(sql.toString());

					stmt.setString(1,str1);
					stmt.setString(2,str2);
					stmt.registerOutParameter (3, Types.CHAR);
					stmt.execute();

					GauceDataRow row = dSet.newDataRow();
					dSet.addDataRow(row);

          row.addColumnValue(str1);
					row.addColumnValue(str2);

					for (int i=3;i<=3;i++) {					
						row.addColumnValue(stmt.getString(i));
						//logger.dbg.println(this,"str" + i + " : " + stmt.getString(i));
					}

					stmt.close();
					conn.close();
				
					//logger.dbg.println( this, sql.toString() );
/*********************************************************************************************/
				}
			} catch(Exception e) {
		  	logger.err.println(this,e);	
		  } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				//if (conn != null) try {conn.close(true);} catch (Exception e) {}
				if (conn != null) try {conn.close();} catch (Exception e) {}
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