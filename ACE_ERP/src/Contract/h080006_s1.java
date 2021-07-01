package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class h080006_s1 extends HttpServlet {

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
				String [] str = new String [5];
				str[0]	= req.getParameter("v_str1");		//FROM
				str[1]	= req.getParameter("v_str2");		//TO
				str[2]	= req.getParameter("v_str3");		//��������
				str[3]	= req.getParameter("v_str4");		//�����
				str[4]	= req.getParameter("v_str5");		//���ID

				for (int k=0 ;k<4 ;k++ ) if (str[k]==null) str[k] = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO","EMPNMK", "PAYGNM","DEPTNM","CERTINO",
																					"CERDATE","CERKIND","CERUSE","CERNUM","CERETC",
																					"OADDR","CADDR","RESINO","STRTDT","ENDDT",
																					"CURDT","CERPLC","CERFR","CERTO","CERDAT",
																					"DEPTCD","PAYGRD","PREDEPT","JOBDTYNM","ORDDT",
																					"RCVNM","BIRDT"//,"PREDEPTNM"
																				};

				int[] intArrCN = new int[]{    7,  20,  30,  30,    8,
																			 8,   1,  30,   3,  100,
																		 200, 200,  13,   8,    8,
																			 8,  50,   8,   8,   16,
																			 4,   4,   4,  30,    8,
																			50,   8//,  50
				}; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
																		 -1, -1, -1,  0, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1//, -1
					}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT \n");
					sql.append( "				RTRIM(D.EMPNO) AS EMPNO,RTRIM(A.EMPNMK) AS EMPNMK,RTRIM(B.MINORNM) AS PAYGNM, \n");
					////2008.05.26 ������ �ӽ� �߰�
					sql.append( "				CASE WHEN (A.USESTS='3' AND SUBSTR(A.ENDDT,1,6)<'200801') THEN E.DEPTNMK ELSE C.DEPTNMK END DEPTNM, \n");
					
					sql.append( "				RTRIM(D.CERTINO) AS CERTINO, RTRIM(D.CERDATE) AS CERDATE, RTRIM(D.CERKIND) AS CERKIND, \n");
					sql.append( "				RTRIM(D.CERUSE) AS CERUSE,D.CERNUM, RTRIM(D.CERETC) AS CERETC, \n");
					sql.append( "				RTRIM(A.OADDR01) || ' ' || RTRIM(A.OADDR02) AS OADDR, RTRIM(A.CADDR01) || ' ' || RTRIM(A.CADDR02) AS CADDR, \n");
					sql.append( "				A.RESINO, RTRIM(A.STRTDT) AS STRTDT, \n");
					sql.append( "				RTRIM(A.ENDDT) AS ENDDT,'' AS CURDT, RTRIM(D.CERPLC) AS CERPLC, RTRIM(D.CERFR) AS CERFR, \n");
					sql.append( "				RTRIM(D.CERTO) AS CERTO, D.CERFR || D.CERTO AS CERDAT, \n");
					sql.append( "				RTRIM(D.DEPTCD) AS DEPTCD,RTRIM(D.PAYGRD) AS PAYGRD,RTRIM(D.PREDEPT) AS PREDEPT, \n");
					sql.append( "				RTRIM(D.JOBDTYNM) AS JOBDTYNM,RTRIM(D.ORDDT) AS ORDDT,RTRIM(D.RCVNM) AS RCVNM, RTRIM(A.BIRDT) AS BIRDT \n");					
					sql.append( "	FROM PAYROLL.T_HICERTI D \n");
					sql.append( "				LEFT JOIN PAYROLL.T_HIPERSON A ON D.EMPNO = A.EMPNO \n");
					sql.append( "				LEFT JOIN PAYROLL.HCLCODE B    ON B.MINORCD = A.PAYGRD  AND B.MAJORCD = '2002' \n");
					sql.append( "				LEFT JOIN PAYROLL.HCDEPT  C    ON C.DEPTCD = A.DEPTCD \n");
					//2008.05.26 ������ �ӽ� �߰�
					sql.append( "				LEFT JOIN PAYROLL.HCDEPT_99 E  ON E.DEPTCD = A.DEPTCD \n");

					sql.append( "	WHERE D.CERDATE BETWEEN '" + str[0] + "' AND '" + str[1] + "' \n");

					if (!str[2].equals("")) sql.append( "				 AND D.CERKIND = '" + str[2] + "' \n");
					sql.append( " AND A.EMPNMK LIKE '" + str[3] + "%' \n");

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