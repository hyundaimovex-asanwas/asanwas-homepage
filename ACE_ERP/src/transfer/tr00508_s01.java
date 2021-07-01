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
public class tr00508_s01 extends HttpServlet {

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
				String[] strArrCN = new String[]{ "CHARGECODE", "EFF_DATE", "EXP_DATE", "LINE_PART", "CLASS"
																				, "SECTION", "CARGO", "LOGIS_TYPE", "LOGIS_UNIT", "UNIT_PRICE"
																				, "RQST_PRICE", "CANCEL1", "CANCEL1DAY", "CANCEL2", "CANCEL2DAY"
																				, "CANCEL3", "CANCEL3DAY", "CREATE_DT", "CREATE_USR", "UPDATE_DT"
																				, "UPDATE_USR"
																				}; 
				int[] intArrCN	= new int[]{  4,  8,  8,  4,  4,
																		  4,  4,  4,  4,  3,
																			3,  4,  8,  4,  8, 
																			4,  8,  8, 10,  8,
																		 10
																	 }; 
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1,  0,
																		  0, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1
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
					query.append(" SELECT CHARGECODE, EFF_DATE, EXP_DATE, LINE_PART, CLASS \n ")
							 .append(" 			, SECTION, CARGO, LOGIS_TYPE, LOGIS_UNIT, UNIT_PRICE \n ")
							 .append(" 			, RQST_PRICE, CANCEL1, SUBSTR(CHAR(CANCEL1DAY),1,4)||SUBSTR(CHAR(CANCEL1DAY),6,2)||SUBSTR(CHAR(CANCEL1DAY),9,2) CANCEL1DAY, CANCEL2, SUBSTR(CHAR(CANCEL2DAY),1,4)||SUBSTR(CHAR(CANCEL2DAY),6,2)||SUBSTR(CHAR(CANCEL2DAY),9,2) CANCEL2DAY \n ")
							 .append(" 			, CANCEL3, SUBSTR(CHAR(CANCEL3DAY),1,4)||SUBSTR(CHAR(CANCEL3DAY),6,2)||SUBSTR(CHAR(CANCEL3DAY),9,2) CANCEL3DAY, SUBSTR(CHAR(CREATE_DT),1,4)||SUBSTR(CHAR(CREATE_DT),6,2)||SUBSTR(CHAR(CREATE_DT),9,2) CREATE_DT, CREATE_USR, SUBSTR(CHAR(UPDATE_DT),1,4)||SUBSTR(CHAR(UPDATE_DT),6,2)||SUBSTR(CHAR(UPDATE_DT),9,2) UPDATE_DT \n ")
							 .append(" 			, UPDATE_USR \n ")
							 .append("	 FROM TRANSFER.LTCHARGE ");

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



