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
public class com_cartype extends HttpServlet {

	// ���������� ���� ���۹���� Get Ÿ���� ���
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection gconn = null;
		GauceStatement gstmt =null;
		GauceDataSet dSet = null;
		StringBuffer query = null;

		try {
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
      GauceResponse GauceRes = service.getGauceResponse();

			try {
				gconn = service.getDBConnection();
				dSet = new GauceDataSet();

/**********************************************************************************************
	���� �������� �����Ͻ� �κ�
**********************************************************************************************/
				// ������������ ���ǰ��� �Ѱܹ���
				String  gstr1	= req.getParameter("vstr1");

				GauceRes.enableFirstRow(dSet);

				// ������ ��ȸ�� �ؾ� �� �÷��� Ÿ�Ժ��� ����
				String[] strArrCN = new String[]{ "CAR_TYPE", "CAR_NAME", "CAR_LENGTH", "CAR_WIDTH", "CAR_HEIGHT"
																				, "CAR_CBM", "CAR_TON", "CAR_CLASS", "CREATE_DT", "CREATE_USR"
																				, "UPDATE_DT", "UPDATE_USR"
																				}; 
				int[] intArrCN	= new int[]{  4, 30,  7,  7,  7,
																		  7,  7,  4,  8, 10,
																			8, 10
																	 }; 
				int[] intArrCN2 = new int[]{ -1, -1,  2,  2,  2,
																		  2,  2, -1, -1, -1,
																		 -1, -1
																	 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING,intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				// ���� ������ �ۼ�
		   	if (!GauceReq.isBuilderRequest()) {
					query = new StringBuffer();
					query.append(" SELECT CAR_TYPE, CAR_NAME, CAR_LENGTH, CAR_WIDTH, CAR_HEIGHT \n ");
					query.append(" 			, CAR_CBM, CAR_TON, CAR_CLASS, SUBSTR(CHAR(CREATE_DT),1,4)||SUBSTR(CHAR(CREATE_DT),6,2)||SUBSTR(CHAR(CREATE_DT),9,2) CREATE_DT, CREATE_USR \n ");
					query.append(" 			, SUBSTR(CHAR(UPDATE_DT),1,4)||SUBSTR(CHAR(UPDATE_DT),6,2)||SUBSTR(CHAR(UPDATE_DT),9,2) UPDATE_DT, UPDATE_USR \n ");
					query.append("	 FROM TRANSFER.LTCARTYPE ");
					query.append("	 WHERE CAR_NAME <>'' ");


			 if (gstr1 != null && !gstr1.equals("")) query.append( "  AND CAR_NAME LIKE '"+gstr1+"%'  \n");//null�� üũ

/*********************************************************************************************/

					gstmt = gconn.getGauceStatement(query.toString());
	 		    gstmt.executeQuery(dSet);
				}
			} catch(Exception e) {
		  	logger.err.println(this,e);
		  } finally {
				if (gstmt != null) try { gstmt.close(); } catch (Exception e) {}
				if (gconn != null) try {gconn.close(true);} catch (Exception e) {}
			}

		  dSet.flush();
		  GauceRes.commit(query.toString());
		  GauceRes.close();

		} catch (Exception e) {

			// GAUCE30/LOG/ERROR.LOG ȭ�Ϸ� �޼��� Ȯ��
			logger.err.println(this,e);

			// GAUCE30/LOG/DEBUG.LOG ȭ�Ϸ� �޼��� Ȯ��
			logger.dbg.println(this,e.toString());

		} finally {

			loader.restoreService(service);
  	}
	}
}



