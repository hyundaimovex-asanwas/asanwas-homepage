package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ��� �׻� �����ؾ� ��.
public class p020004_s1 extends HttpServlet {

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
				
				String dbUrl    = "jdbc:as400://218.145.103.181";
				String driver   = "com.ibm.as400.access.AS400JDBCDriver";
				String userName = "PAYROLL";
				String userPass = "PAY";

				Class.forName(driver);			
				conn = DriverManager.getConnection(dbUrl, userName, userPass);

				dSet = new GauceDataSet();

/**********************************************************************************************
	���� �������� �����Ͻ� �κ�
**********************************************************************************************/
				// ������������ ���ǰ��� �Ѱܹ���

				GauceRes.enableFirstRow(dSet);
					String [] str = new String [10];
					str[0]	= req.getParameter("v_str1");		//�޿����
					str[1]	= req.getParameter("v_str2");		//���ޱ���
					str[2]	= req.getParameter("v_str3");		//��������

					str[3]	= "X";		//��������
					str[4]	= req.getParameter("v_str4");		//���ν������� SP_P100002(���⼼��),SP_P200002(�ұ޼���),SP_P500002(�ұ޼���)

					for (int s=0;s<5;s++) {
						if (str[s]==null) str[s] = "";
					}

				String[] strArrCN = new String[]{ "YEARMM", "PAYREF", "PAYDAY", "RETCOD"
																				};

				int[] intArrCN = new int[]{ 6,  1,  8,  1
																	}; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
						StringBuffer query = new StringBuffer();	
						//logger.dbg.println(this,str[4]);

	 		      query.append("  CALL PAYROLL."+ str[4] +"(?,?,?,?) ");

						cstmt = conn.prepareCall(query.toString());

						cstmt.setString(1, str[0] );
 						cstmt.setString(2, str[1] );
   					cstmt.setString(3, str[2] );
   					cstmt.setString(4,str[3] );
   					
						//logger.dbg.println(this,"1");
						cstmt.registerOutParameter (1, Types.CHAR);
						//logger.dbg.println(this,"2");
						cstmt.registerOutParameter (2, Types.CHAR);
						//logger.dbg.println(this,"3");
						cstmt.registerOutParameter (3, Types.CHAR);
						//logger.dbg.println(this,"4");
						cstmt.registerOutParameter (4, Types.CHAR);

						cstmt.execute();					
						
						GauceDataRow row = dSet.newDataRow();
						row.addColumnValue(cstmt.getString(1));
						row.addColumnValue(cstmt.getString(2));
						row.addColumnValue(cstmt.getString(3));
						row.addColumnValue(cstmt.getString(4));
						//logger.dbg.println(this,cstmt.getString(4));

						dSet.addDataRow(row);

						cstmt.close();
						conn.close();

		/*********************************************************************************************/

				}
			} catch(Exception e) {
		  	logger.err.println(this,e);
		  } finally {
				if (cstmt != null) try { cstmt.close(); } catch (Exception e) {}
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