package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class h030003_s2 extends HttpServlet {
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

				String[] strArrCN = new String[]{ "EMPNO", "EMPNMK", "PAYGNM", "DEPTNM"};

				int[] intArrCN = new int[]{  7, 20, 30, 30 }; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT																											\n");
					sql.append( "		 A.ENO_NO AS EMPNO,A.ENO_NM AS EMPNMK,												\n");
					sql.append( "       ASNHR.SF_GET_JOBNAME('01',A.ENO_NO) AS PAYGNM,									\n");
					sql.append( "       ASNHR.SF_GET_DPTNAME0('01','A4',A.DPT_CD) AS DEPTNM							\n");					
					sql.append( "	FROM ASNHR.T_CM_PERSON A																		\n");
					sql.append( " WHERE 1 = 1																									\n");
					
					//2014.07.17 JYS ������ ���� 0000001
					
					if(str2.equals("T")) {
						sql.append( "																													\n");
					}else{
						sql.append( "	AND ( A.RET_YMD IS NULL OR A.ENO_NO ='0000001' )																				\n");
					}
					sql.append( "   AND A.ENO_NM LIKE '" + str1 + "%' 																	\n");
				
				/*
				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT																											");
					sql.append( "				RTRIM(A.EMPNO) AS EMPNO,RTRIM(A.EMPNMK) AS EMPNMK,					");
					sql.append( "       RTRIM(B.MINORNM) AS PAYGNM,RTRIM(C.DEPTNM) AS DEPTNM						");
					sql.append( "	FROM PAYROLL.HIPERSON A,																			");
					sql.append( "       PAYROLL.HCLCODE B,																				");
					sql.append( "				PAYROLL.HCDEPT C																			");
					sql.append( " WHERE A.PAYGRD = B.MINORCD																		");
					sql.append( "		AND A.DEPTCD = C.DEPTCD																			");
					sql.append( "		AND B.MAJORCD = '2002'																				");
          if(str2.equals("T")) {
						sql.append( "	AND A.USESTS IN ( '1', '2', '3')																		");
					}else{
						sql.append( "	AND A.USESTS IN ( '1', '2')																			");
					}
					sql.append( "   AND A.EMPNMK LIKE '" + str1 + "%' 																	");
*/
					/*
					sql.append( "   UNION ALL ");


					sql.append( " SELECT																											");
					sql.append( "				RTRIM(A.EMPNO) AS EMPNO,RTRIM(A.EMPNMK) AS EMPNMK,					");
					sql.append( "       RTRIM(B.MINORNM) AS PAYGNM,RTRIM(C.DEPTNM) AS DEPTNM						");
					sql.append( "	FROM PAYROLL.T_HIPERSON A,																		");
					sql.append( "       PAYROLL.HCLCODE B,																				");
					sql.append( "				PAYROLL.HCDEPT C																			");
					sql.append( " WHERE A.PAYGRD = B.MINORCD																		");
					sql.append( "		AND A.DEPTCD = C.DEPTCD																			");
					sql.append( "		AND B.MAJORCD = '2002'																				");
          if(str2.equals("T")) {
						sql.append( "	AND A.USESTS IN ( '1', '2', '3')																		");
					}else{
						sql.append( "	AND A.USESTS IN ( '1', '2')																			");
					}
					sql.append( "   AND A.EMPNMK LIKE '" + str1 + "%' 																	");
					*/
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