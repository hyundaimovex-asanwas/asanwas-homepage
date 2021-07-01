package pms.news.pro;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ��� �׻� �����ؾ� ��.
public class empno_popup extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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
				String str1	= req.getParameter("v_str1");		//�����
				String str2 = req.getParameter("v_str2");		//��������

				if (str1==null) str1 = "";
				if (str2==null) str2 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO", "EMPNMK", "DPT_CD", "DEPTNM", "JOB_CD", "PAYGNM"};

				int[] intArrCN = new int[]{  7, 20, 5, 30, 30, 30 }; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT																			\n");
					sql.append( "		A.ENO_NO AS EMPNO,A.ENO_NM AS EMPNMK,										\n");
					sql.append( "       A.DPT_CD AS DPT_CD,															\n");
					sql.append( "       ASNHR.SF_GET_DPTNAME0('01','A4',A.DPT_CD) AS DEPTNM,						\n");
					sql.append( "       A.JOB_CD,																	\n");
					sql.append( "       ASNHR.SF_GET_JOBNAME('01',A.ENO_NO) AS PAYGNM								\n");					
					sql.append( "	FROM ASNHR.T_CM_PERSON A														\n");
					sql.append( " WHERE 1 = 1																		\n");
					sql.append( "   AND A.ENO_NM LIKE '" + str1 + "%' 												\n");
				

					//System.out.println("h030003_s2 : \n" + sql.toString());
					//logger.dbg.println( this, sql.toString() );

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