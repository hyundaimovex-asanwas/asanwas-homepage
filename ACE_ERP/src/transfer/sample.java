package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class sample extends HttpServlet {

	// ���������� ���� ���۹���� Post Ÿ���� ���
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement gstmt =null;
		Statement stmt = null;
		GauceDataSet dSet = null;
		ServletOutputStream stream = null;

		try {
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
      GauceResponse GauceRes = service.getGauceResponse();

			try {
				conn = service.getDBConnection();
				dSet = new GauceDataSet();

				GauceRes.enableFirstRow(dSet);

				// ������ ��ȸ�� �ؾ� �� �÷��� Ÿ�Ժ��� ����
				dSet.addDataColumn(new GauceDataColumn("DISKET", GauceDataColumn.TB_STRING,1000));

/**********************************************************************************************
	���� �������� �����Ͻ� �κ�
**********************************************************************************************/
				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT DISKET FROM PAYROLL.YCDISKET  " );
//             .append( "   FROM PAYROLL.YCDISKET  " );
//					   .append( "  WHERE APPDT = '2005' AND CHKFLD = '1' AND RECGUB = 'A' \n " );

/*********************************************************************************************/

					logger.dbg.println(this,sql.toString());

					stmt = conn.createStatement();

					ResultSet rs = stmt.executeQuery(sql.toString());

					String nstring = "";
					GauceDataRow row = null;

					String ntemp = "";
					for (int a=0; a<73; a++) ntemp += "          ";

					while (rs.next()) {
						byte [] bdata = new byte[0];
						nstring = "";

						nstring = rs.getString(1);

						nstring = nstring + ntemp;

						bdata = nstring.getBytes(); 

						String sample = new String( bdata, 0, 730 ); 

						row = dSet.newDataRow();
						row.addColumnValue(new String(sample.getBytes("KSC5601"),"8859_1"));
						dSet.addDataRow(row);

					}

					rs.close();
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
	} //public void
} //public class