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
public class h100002_s1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");		//���ޱ���
				String  str2	= req.getParameter("v_str2");		//�׸񱸺�
				String  str3	= req.getParameter("v_str3");		//������
				String  str4	= req.getParameter("v_str4");		//�μ�
				String  str5	= req.getParameter("v_str5");		//����(���)

				if (str1==null) { str1 = ""; }
				if (str2==null) { str2 = ""; }
				if (str3==null) { str3 = ""; }
				if (str4==null) { str4 = ""; }
				if (str5==null) { str5 = ""; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO", "EMPNMK", "DEPTNMK", "PAYDIV", "PBDIV", 
																					"PAYCD", "FRDT", "TODT", "PAYAMT" 
																					,"TREECD" }; 

				int[] intArrCN = new int[] {  7,  20,  70,  1,  1,  8,  8,  8,  9, 8 }; 
			
				int[] intArrCN2 = new int[]{ -1,  -1,  -1, -1, -1, -1,  -1, -1, 0, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( " SELECT RTRIM(A.EMPNO) EMPNO, RTRIM(D.EMPNMK) EMPNMK,RTRIM(C.DEPTNMK) DEPTNMK,RTRIM(A.PAYDIV) PAYDIV, ");
						sql.append( " RTRIM(A.PBDIV) PBDIV,RTRIM(A.PAYCD) PAYCD,RTRIM(A.FRDT) FRDT, RTRIM(A.TODT) TODT, A.PAYAMT ");
						sql.append( " ,C.TREECD ");
						sql.append( " FROM PAYROLL.PCEXCEPT A ");
						sql.append( " LEFT JOIN PAYROLL.T_HIPERSON D ON D.EMPNO   = A.EMPNO ");
						//sql.append( " LEFT JOIN PAYROLL.PCPAYCD  B ON B.PAYCD   = A.PAYCD ");
						sql.append( " LEFT JOIN PAYROLL.PCPAYCD BB ON BB.PAYDIV  = D.PAYDIV ");
						sql.append( " LEFT JOIN PAYROLL.HCDEPT   C ON C.DEPTCD  = D.DEPTCD ");
						sql.append( " LEFT JOIN PAYROLL.HCLCODE  E ON A.PAYDIV  = E.MINORCD AND E.MAJORCD = '1120' ");	//���ޱ���
						sql.append( " LEFT JOIN PAYROLL.HCLCODE  F ON A.PBDIV   = F.MINORCD AND F.MAJORCD = '1126' ");	//�޿��׸����
												
						sql.append( " WHERE A.PAYDIV = '" + str1 + "' " );	//���ޱ���
						
						if (!str2.equals("")) sql.append( " AND A.PBDIV = '" + str2 + "' " );		//�׸񱸺�
						if (!str3.equals("")) {
							sql.append( " AND '" + str3 + "' BETWEEN SUBSTR(A.FRDT,1,6) AND SUBSTR(A.TODT,1,6) " );
							//sql.append( " AND SUBSTR(A.FRDT,1,6) <= '"+str3+"' AND SUBSTR(A.TODT,1,6) <= '999912' ");
//							sql.append( " AND SUBSTR(A.FRDT,1,6) BETWEEN '" + str3 + "' AND SUBSTR(A.FRDT,1,6) ");
						}

						if (!str4.equals("") && !str4.equals("A000")) sql.append( " AND C.DEPTCD = '"+ str4 + "' " );		//�μ�

						if (!str5.equals(""))	sql.append( " AND D.EMPNO = '"+ str5 + "' " );

						sql.append( " AND D.EMPDIV ='3' ");	//�Ի籸��(3:�ѱ��� �����)

						sql.append( " ORDER BY TREECD ASC ");

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