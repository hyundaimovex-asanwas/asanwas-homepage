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
public class h010025_s1 extends HttpServlet {

	// ���������� ���� ���۹���� Post Ÿ���� ���
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
	���� �������� �����Ͻ� �κ�
**********************************************************************************************/
				// ������������ ���ǰ��� �Ѱܹ���

				String  str1	= req.getParameter("v_str1");
				String  str2	= req.getParameter("v_str2");
	

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO",  "REQDT",   "SEQ", "SUBJECT", "FRDT",
								                  "TODT",    "EDUDAY", "EDUPLC", "EDUINST", "SGDT",
								                  "SGID",    "APDT",    "APID", "MEMO"
				}; 

				int[] intArrCN = new int[]{ 7, 8, 1, 50, 8,
								            8, 3, 50, 30, 8,
								            7, 8, 7, 30 
											}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, 0, -1, -1,
								             -1,  0, -1, -1, -1,
								             -1, -1, -1, -1
}; 
			
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				
				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT ");
					sql.append( " RTRIM(EMPNO) EMPNO, RTRIM(REQDT) REQDT, SEQ, RTRIM(SUBJECT) SUBJECT, RTRIM(FRDT) FRDT, ");
					sql.append( " RTRIM(TODT) TODT, EDUDAY, RTRIM(EDUPLC) EDUPLC, RTRIM(EDUINST) EDUINST, RTRIM(SGDT) SGDT, ");
//					sql.append( " SGID, APDT, APID, MEMO     ");
					sql.append( " RTRIM(SGID) SGID, RTRIM(APDT) APDT, RTRIM(APID) APID, RTRIM(MEMO) MEMO     ");
					sql.append( " FROM PAYROLL.HEDUCATION ");
					sql.append( " WHERE REQDT BETWEEN '"+str1+"' AND '"+str2+"' " );
					sql.append( " ORDER BY REQDT, SEQ ");
					
					logger.dbg.println(this,sql.toString());
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