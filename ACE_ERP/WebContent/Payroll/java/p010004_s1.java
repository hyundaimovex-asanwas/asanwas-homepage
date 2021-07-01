package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class p010004_s1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");		//������
				String  str2	= req.getParameter("v_str2");		//�μ�
				String  str3	= req.getParameter("v_str3");		//����

				if (str1==null) { str1 = ""; }
				if (str2==null) { str2 = ""; }
				if (str3==null) { str3 = ""; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "STRDT", "STRTDT","EMPNO", "EMPNMK", "DEPTNM",
																					"CURYEAR","USEYEAR","PAYYEAR","CURMON","USEMON",
																					"PAYMON", "NOTQTY", "RESQTY"
																				}; 

				int[] intArrCN = new int[]{  6,	 8,  7,	 20,	70,	 
																		 3,  3,  3,   3,   3,	 
																		 3,  3,	 3 
																	}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, 
																			0,  0,  0,  0,  0,  
																			0,  0,  0
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT " );	//U
						sql.append( " RTRIM(A.STRDT) STRDT, RTRIM(B.STRTDT) STRTDT,RTRIM(B.EMPNO) EMPNO,RTRIM(B.EMPNMK) EMPNMK, RTRIM(C.DEPTNM) DEPTNM, " );
						sql.append( "  COALESCE(A.CURYEAR,0) AS CURYEAR, COALESCE(A.USEYEAR,0) AS USEYEAR,COALESCE(A.PAYYEAR,0) AS  PAYYEAR, ");
						sql.append( "  COALESCE(A.CURMON,0) AS CURMON, COALESCE(A.USEMON,0) AS USEMON , COALESCE(A.PAYMON,0) AS PAYMON, ");
						sql.append( "  COALESCE(A.NOTQTY,0) AS NOTQTY, COALESCE(A.RESQTY,0) AS RESQTY " );
						sql.append( " FROM PAYROLL.T_HIPERSON B ");
						sql.append( " LEFT JOIN PAYROLL.PCMONPAY A ON A.EMPNO = B.EMPNO ");
						sql.append( " LEFT JOIN PAYROLL.HCDEPT C ON C.DEPTCD = B.DEPTCD ");
						
						if (str1.equals("")) {
							sql.append( " WHERE A.STRDT LIKE '%' " );
						}else {
							sql.append( " WHERE A.STRDT = '" + str1 + "' " );
						}

						if (str2.equals("")) {
							sql.append( "AND C.DEPTCD LIKE '%' " );
						}else {
							sql.append( "AND C.DEPTCD = '" + str2 + "' " );
						}

						if (str3.equals("")) {
							sql.append( "AND B.EMPNO LIKE '%' " );
						}else {
							sql.append( "AND B.EMPNO = '" + str3 + "' " );
						}

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