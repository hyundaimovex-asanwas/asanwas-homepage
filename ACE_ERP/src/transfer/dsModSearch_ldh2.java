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
public class dsModSearch_ldh2 extends HttpServlet {

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
				String  gstr1	= req.getParameter("v_str1");
				String  gstr2	= req.getParameter("v_str2");

				GauceRes.enableFirstRow(dSet);

				// ������ ��ȸ�� �ؾ� �� �÷��� Ÿ�Ժ��� ����
				String[] strArrCN = new String[]{ "ORDER_NO","IN_OUT","ETD_DT","REQ_DATE",
																					"MOD_REMARK","MODIFY_NO","LINE_PART","MOD_STS","REQ_USER",
																					"APP_USER" , "MODIFY"
																				}; 
				int[] intArrCN	= new int[]{  10,  1,  8,  8,  
																		 200, 10,  4,  1,  10,
																			10 ,10
																	 }; 
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, 
																		 -1, -1, -1, -1, -1,
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
					query.append(" SELECT DISTINCT B.ORDER_NO, B.IN_OUT, B.ETD_DT, SUBSTR(CHAR(DATE(B.REQ_DATE)),1,4)||SUBSTR(CHAR(DATE(B.REQ_DATE)),6,2)||SUBSTR(CHAR(DATE(B.REQ_DATE)),9,2) REQ_DATE,\n")
							 .append("				B.MOD_REMARK, B.MODIFY_NO, B.LINE_PART, B.MOD_STS, B.REQ_USER, \n")
							 .append("				B.APP_USER, \n")
							 .append("				CASE	 WHEN B.MOD_STS = 'A' THEN '����'  \n")
							 .append("						 WHEN B.MOD_STS = 'B' THEN '����'  \n")
							 .append("						 WHEN B.MOD_STS = 'C' THEN '����'  \n")
							 .append("				ELSE '����' END AS MODIFY \n")
							 .append("	 FROM TRANSFER.LTMODUSER A, \n")
							 .append("				TRANSFER.LTMODREQ B \n")
							 .append("	WHERE B.REQ_USER = '" + gstr1 + "' \n")
							 .append("	AND B.ETD_DT >= '" + gstr2 + "' \n");



//							logger.dbg.println(this,"::::::::::::::::"+query.toString());


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



