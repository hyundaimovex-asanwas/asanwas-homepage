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
public class p030002_s6 extends HttpServlet {

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
				String [] str = new String [10];
				str[0]	= req.getParameter("v_str1");		//���
				str[1]  = req.getParameter("v_str2");		//�ͼӳ⵵
				str[2]  = req.getParameter("v_str3");		//�μ�
				str[3]  = req.getParameter("v_str4");		//�ۼ�����

				for (int s=0;s<=3;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);
				String[] strArrCN = new String[]{
						"YYYY",			/*�ͼӿ���*/
						"EMPNO",    /*���*/
						"EMPNMK",		/*����*/
						"RESINO",		/*�ֹε�Ϲ�ȣ*/
						"EMPCNT",		/*�ѰǼ�*/
						"CURDT"			/*�ۼ�����*/
				};

				int[] intArrCN = new int[]{
						4,					/*�ͼӿ���*/
						7,					/*���*/             
						20,					/*����*/             
						13,					/*�ֹε�Ϲ�ȣ*/
						3,					/*�ѰǼ�*/
						8						/*�ۼ�����*/  
				};
				
				int[] intArrCN2 = new int[]{
						-1,					/*�ͼӿ���*/
						-1,         /*���*/                         
						-1,         /*����*/                         
						-1,         /*�ֹε�Ϲ�ȣ*/
						0,					/*�ѰǼ�*/
						-1					/*�ۼ�����*/
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
						sql.append(" SELECT	DISTINCT																													\n");
						sql.append(" A.YYYY,																							/*�ͼӿ���*/				\n");
						sql.append(" A.EMPNO,																							/*���*/						\n");
						sql.append(" RTRIM(B.EMPNMK) EMPNMK,															/*����*/						\n");
						sql.append(" B.RESINO,																					  /*�ֹε�Ϲ�ȣ*/		\n");
						sql.append(" (SELECT COUNT(EMPNO) FROM PAYROLL.YCGIBU WHERE A.EMPNO=EMPNO) EMPCNT,    \n");
						sql.append(" '"+str[3]+"' AS CURDT																/*�ۼ�����*/				\n");
						sql.append(" FROM PAYROLL.YCGIBU A																/*��αݸ���*/		\n");	
						sql.append(" LEFT JOIN PAYROLL.HIPERSON B ON A.EMPNO = B.EMPNO		/*�λ�⺻����*/		\n");
						sql.append(" LEFT JOIN PAYROLL.HCDEPT   C ON B.DEPTCD = C.DEPTCD  /*�μ�����*/        \n");
						sql.append(" WHERE RTRIM(A.EMPNO) <> ''																								\n");
						//if (!str[0].equals(""))	sql.append(" AND RTRIM(A.EMPNO)	= '"+str[0]+"'							\n"); 
						if (!str[0].equals(""))	sql.append(" AND RTRIM(B.EMPNMK) LIKE '"+str[0]+"%'						\n"); 
						if (!str[1].equals(""))	sql.append(" AND RTRIM(A.YYYY)		= '"+str[1]+"'							\n");	
						if (!str[2].equals(""))	sql.append(" AND RTRIM(C.DEPTCD)	= '"+str[2]+"'							\n");
						sql.append(" GROUP BY A.YYYY,A.EMPNO,B.EMPNMK,B.RESINO																\n");	
						sql.append(" ORDER BY EMPNMK	  																											\n");

						//logger.dbg.println(this, sql.toString());

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