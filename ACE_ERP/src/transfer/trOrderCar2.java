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
public class trOrderCar2 extends HttpServlet {

	// ���������� ���� ���۹���� Post Ÿ���� ���
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement gstmt =null;
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
				String str1 = GauceReq.getParameter("v_str1");
					if (str1==null || str1.trim().length()==0 ) {   str1=null; }
				String str2 = GauceReq.getParameter("v_str2");
					if (str2==null || str2.trim().length()==0 ) {   str2=null; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"RST"}; 

				int[] intArrCN = new int[] { 1}; 
			
				int[] intArrCN2 = new int[]{-1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				StringBuffer DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE  ")
								 .append( "   FROM TRANSFER.LTORDCAR ")
								 .append( "  WHERE CAR_SEQ_NO = '" + str2 + "' ");

				GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
				gsmt.executeUpdate();
				gsmt = null;
				DeleteSql = null;

				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE  ")
								 .append( "   FROM TRANSFER.LTCARGOODS ")
								 .append( "  WHERE ORDER_NO = '" + str1 + "' ")
								 .append("		 AND CAR_SEQ_NO = '" + str2 + "' ");

				gsmt = conn.getGauceStatement(DeleteSql.toString());
				gsmt.executeUpdate();
				gsmt.close();

	    	GauceDataRow row = null;
	    	row = dSet.newDataRow();

				row.addColumnValue("Y");
				dSet.addDataRow(row);
			
/*********************************************************************************************/

			} catch(Exception e) {
			GauceRes.writeException("Sql",":",e.toString());	
		  	logger.err.println(this,e);
		  } finally {
				if (gstmt != null) try { gstmt.close(); } catch (Exception e) {}
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