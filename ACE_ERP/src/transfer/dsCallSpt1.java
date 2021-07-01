package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ��� �׻� �����ؾ� ��.
public class dsCallSpt1 extends HttpServlet {

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
				
				String dbUrl    = "";
				String driver   = "";
				String userName = "";
				String userPass = "";

				//����ƻ�
				dbUrl    = "jdbc:as400://203.242.32.199";
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

				GauceRes.enableFirstRow(dSet);
				String [] str = new String [3];
				str[0]	= req.getParameter("v_str1");		//�μ�����
				str[1]	= req.getParameter("v_str2");		//�߷ɱ���
				str[2]	= "N";													//Default 'N'
               //  logger.dbg.println(this,"LLLLLLLL");
				for (int s=0;s<=2;s++) {
					if (str[s]==null) str[s] = "";
				}

				logger.dbg.println(this,"str[0]::"+str[0]);
				logger.dbg.println(this,"str[1]::"+str[1]);
                logger.dbg.println(this,"str[2]::"+str[2]);

				String[] strArrCN = new String[]{  "etddt","linepart","retcod" };

				int[] intArrCN = new int[] {  12,  4,  1 }; 

				int[] intArrCN2 = new int[]{ -1, -1, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
						StringBuffer query = new StringBuffer();
						logger.dbg.println(this,"SP_HDSSD11");
	 		           query.append("  CALL TRANSFER.SP_HDSSD11(?,?,?) ");
          

                        logger.dbg.println(this,"SP_HDSSD12");
						cstmt = conn.prepareCall(query.toString());
						logger.dbg.println(this,"SP_HDSSD13");

						cstmt.setString(1, str[0] );
 						cstmt.setString(2, str[1] );
   					    cstmt.setString(3, str[2] );
   					
						cstmt.registerOutParameter (1, Types.CHAR);
						cstmt.registerOutParameter (2, Types.CHAR);
						cstmt.registerOutParameter (3, Types.CHAR);

                        logger.dbg.println(this,"SP_HDSSD14");

						cstmt.execute();

						logger.dbg.println(this,"SP_HDSSD15");


						GauceDataRow row = dSet.newDataRow();
						for (int i=1;i<=3;i++) {
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