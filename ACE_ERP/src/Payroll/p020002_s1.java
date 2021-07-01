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
public class p020002_s1 extends HttpServlet {

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
				String DB_gubun="1"; //1->����ƻ�, 0->�׽�Ʈ
				String dbUrl    = "";
				String driver   = "";
				String userName = "";
				String userPass = "";

				if(DB_gubun.equals("1")) {
				//����ƻ�
					 dbUrl    = "jdbc:as400://203.242.32.198";
					 driver   = "com.ibm.as400.access.AS400JDBCDriver";
					 userName = "QPILOT";
					 userPass = "PILOT";
        }else{
        //�׽�Ʈ
					 dbUrl    = "jdbc:as400://218.145.103.181";
					 driver   = "com.ibm.as400.access.AS400JDBCDriver";
					 userName = "PAYROLL";
					 userPass = "PAY";
				}

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
					str[3]	= "X";													//���ϰ�
					str[4]	= req.getParameter("v_str4");		//���ν������� SP_P100000(����),SP_P200000(�ұ�),SP_P500000(��)
					str[5]	= req.getParameter("v_str5");		//�󿩱� �ۼ�Ʈ��
					
					for (int s=0;s<6;s++) {
						if (str[s]==null) str[s] = "";
					}
            if( !str[4].equals("SP_P500000"))
					{

					String[] strArrCN = new String[]{ "YEARMM", "PAYREF", "PAYDAY", "RETCOD"};

					int[] intArrCN = new int[]{ 6,  1,  8,  1}; 

					int[] intArrCN2 = new int[]{ -1, -1, -1, -1}; 

					for (int i=0; i<strArrCN.length; i++) { // set column column 
						switch ( intArrCN2[i] ) { 
							case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
							default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
						} 
					} 

				}else{

					String[] strArrCN = new String[]{ "YEARMM", "PAYREF", "PAYDAY","PAYRAT" , "RETCOD"};

					int[] intArrCN = new int[]{ 6,  1,  8, 4, 1}; 

					int[] intArrCN2 = new int[]{ -1, -1, -1,-1, -1}; 

					for (int i=0; i<strArrCN.length; i++) { // set column column 
						switch ( intArrCN2[i] ) { 
							case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
							default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
						} 
					} 
				}

				if (!GauceReq.isBuilderRequest()) {					
						StringBuffer query = new StringBuffer();
					if( !str[4].equals("SP_P500000"))   //�󿩰� �ƴҶ�
					{
						query.append(" CALL PAYROLL."+ str[4] +"(?,?,?,?) ");

						cstmt = conn.prepareCall(query.toString());

						cstmt.setString(1, str[0] );
 						cstmt.setString(2, str[1] );
						cstmt.setString(3, str[2] );
						cstmt.setString(4,str[3] );
   					
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
						dSet.addDataRow(row);
				}else{
						query.append("  CALL PAYROLL."+ str[4] +"(?,?,?,?,?) ");
						
						cstmt = conn.prepareCall(query.toString());

						cstmt.setString(1, str[0] );
 						cstmt.setString(2, str[1] );
						cstmt.setString(3, str[2] );
						cstmt.setString(4,str[5] );
						cstmt.setString(5,str[3] );

						cstmt.registerOutParameter (1, Types.CHAR);
						cstmt.registerOutParameter (2, Types.CHAR);
						cstmt.registerOutParameter (3, Types.CHAR);
						cstmt.registerOutParameter (4, Types.CHAR);
						cstmt.registerOutParameter (5, Types.CHAR);
						cstmt.execute();					
						
						GauceDataRow row = dSet.newDataRow();
						row.addColumnValue(cstmt.getString(1));
						row.addColumnValue(cstmt.getString(2));
						row.addColumnValue(cstmt.getString(3));
						row.addColumnValue(cstmt.getString(4));
						row.addColumnValue(cstmt.getString(5));
						dSet.addDataRow(row);
				}
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