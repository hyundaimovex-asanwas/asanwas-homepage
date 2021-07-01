package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class p030001_s2 extends HttpServlet {

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
				
				String dbUrl    = "jdbc:as400://203.242.32.198";
				String driver   = "com.ibm.as400.access.AS400JDBCDriver";
				String userName = "QPILOT";
				String userPass = "PILOT";

				Class.forName(driver);			
				conn = DriverManager.getConnection(dbUrl, userName, userPass);

				dSet = new GauceDataSet();

/**********************************************************************************************
	���� �������� �����Ͻ� �κ�
**********************************************************************************************/
				// ������������ ���ǰ��� �Ѱܹ���

				GauceRes.enableFirstRow(dSet);
					String [] str = new String [4];
					str[0]	= req.getParameter("v_str1");		//����������
					str[1]	= req.getParameter("v_str2");		//�������걸��
					str[2]	= req.getParameter("v_str3");		//�ͼӳ⵵
					str[3]	= req.getParameter("v_str4");		//���ν�������  SP_Y100000 (�������� ���ʻ���)
				
					for (int s=0;s<4;s++) {
						if (str[s]==null) str[s] = "";
					}
        
				
					String[] strArrCN = new String[]{ "YEARMM", "PAYREF", "PAYDAY", "RETCOD"
																					};

					int[] intArrCN = new int[]{ 6,  1,  8,  1	}; 

					int[] intArrCN2 = new int[]{ -1, -1, -1, -1		}; 

					for (int i=0; i<strArrCN.length; i++) { // set column column 
						switch ( intArrCN2[i] ) { 
							case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
							default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
						} 
					} 
			
				if (!GauceReq.isBuilderRequest()) {					
						StringBuffer query = new StringBuffer();
			  		query.append("  CALL PAYROLL."+ str[3] +"(?,?,?,?) ");

						cstmt = conn.prepareCall(query.toString());

						cstmt.setString(1, str[2] ); //�ͼӳ⵵
 						cstmt.setString(2, "Y" );
						cstmt.setString(3, str[0] );
						cstmt.setString(4, "N" );
						logger.err.println(this,query.toString()); 

						cstmt.registerOutParameter (1, Types.CHAR);
						cstmt.registerOutParameter (2, Types.CHAR);
						cstmt.registerOutParameter (3, Types.CHAR);
						cstmt.registerOutParameter (4, Types.CHAR);

						cstmt.execute();					
						
						GauceDataRow row = dSet.newDataRow();
						row.addColumnValue(cstmt.getString(1));
						row.addColumnValue(cstmt.getString(2));
						row.addColumnValue(cstmt.getString(3));
						row.addColumnValue(cstmt.getString(4));

								  	logger.err.println(this,cstmt.getString(1));
								  	logger.err.println(this,cstmt.getString(2));
									logger.err.println(this,cstmt.getString(3));
									logger.err.println(this,cstmt.getString(4));
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