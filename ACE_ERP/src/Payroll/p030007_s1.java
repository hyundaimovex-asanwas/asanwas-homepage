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
public class p030007_s1 extends HttpServlet {

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

				if (str1==null) { str1 = ""; }
				if (str2==null) { str2 = ""; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "YYYY"		,"EMPNO"		,"INDNO"		,"INDNAME"	,"CARDCNT",
																					"CARDAMT"	,"CASHCNT"	,"CASHAMT"	,"RELATION"	,"JUMINNO",
																					"EMPCHK"	,"ADDCA"    ,"EMPNMK"		
																				}; 

				int[] intArrCN = new int[]{  4,	 7,	11, 100,  2, 
																		 9,  2,	 9,	  1,	 13, 
																		 1, 70, 20
																	}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1,  0, 
																			0,  0,  0, -1, -1,
																		 -1, -1, -1
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT																																											");	
						sql.append( " RTRIM(A.YYYY) YYYY, RTRIM(A.EMPNO) EMPNO, RTRIM(A.INDNO) INDNO, RTRIM(A.INDNAME) INDNAME,		");
						sql.append( " COALESCE(A.CARDCNT,0) CARDCNT,COALESCE(A.CARDAMT,0) CARDAMT, COALESCE(A.CASHCNT,0) CASHCNT,	");
						sql.append( " COALESCE(A.CASHAMT,0) CASHAMT, A.RELATION, A.JUMINNO,A.EMPCHK,															");
						sql.append( " RTRIM(B.CADDR01) || ' ' || RTRIM(B.CADDR02) AS ADDCA, B.EMPNMK															");
						sql.append( " FROM PAYROLL.YCINDIPN A																																			");
						sql.append( " LEFT JOIN PAYROLL.HIPERSON B ON A.EMPNO = B.EMPNO																						");
						sql.append( " WHERE RTRIM(A.YYYY) <> '' AND RTRIM(A.EMPNO) <> ''																					");
						
						if (!str1.equals(""))	sql.append(" AND A.YYYY = '"+ str1 + "' ");
						if (!str2.equals(""))	sql.append(" AND B.EMPNMK LIKE '" + str2 + "%'");

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