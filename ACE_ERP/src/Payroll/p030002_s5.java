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
public class p030002_s5 extends HttpServlet {

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
				str[2]  = req.getParameter("v_str3");		//�ۼ�����

				for (int s=0;s<=2;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);
				String[] strArrCN = new String[]{
						"YYYY",			/*�ͼӿ���*/
						"EMPNO",    /*���*/
						"EMPNMK",		/*����*/
						"RESINO",		/*�ֹε�Ϲ�ȣ*/
						"GIVSAUP",	/*�����ȣ*/
						"GIVCOMP",	/*��ȣ*/
						"GIVTYPE",	/*����*/
						"GIVCOD",		/*�ڵ�*/
						"GIVCNT",		/*�Ǽ�*/
						"GIVAMT",		/*�ݾ�*/
						"CURDT"			/*�ۼ�����*/
				};

				int[] intArrCN = new int[]{  
						4,					/*�ͼӿ���*/               
						7,					/*���*/             
						20,					/*����*/             
						13,					/*�ֹε�Ϲ�ȣ*/
						11,					/*�����ȣ*/
						100,				/*��ȣ*/    
						50,					/*����*/    
						2,					/*�ڵ�*/    
						2,					/*�Ǽ�*/    
						9,					/*�ݾ�*/    
         		8						/*�ۼ�����*/  
				};
				
				int[] intArrCN2 = new int[]{ 
					  -1,					/*�ͼӿ���*/                       
						-1,         /*���*/                         
						-1,         /*����*/                         
						-1,         /*�ֹε�Ϲ�ȣ*/                 
						-1,					/*�����ȣ*/
						-1,					/*��ȣ*/    
						-1,					/*����*/    
						-1,					/*�ڵ�*/    
						 0,					/*�Ǽ�*/    
						 0,					/*�ݾ�*/
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
						sql.append(" SELECT																																		\n");
						sql.append(" A.YYYY,																							/*�ͼӿ���*/				\n");
						sql.append(" A.EMPNO,																							/*���*/						\n");
						sql.append(" RTRIM(B.EMPNMK) EMPNMK,															/*����*/						\n");
						sql.append(" B.RESINO,																						/*�ֹε�Ϲ�ȣ*/		\n");
						sql.append(" A.GIVSAUP,																						/*����ڹ�ȣ*/			\n");
						sql.append(" A.GIVCOMP,																						/*����ڻ�ȣ*/			\n");
						sql.append(" A.GIVTYPE,																						/*����*/						\n");
						sql.append(" A.GIVCOD,																						/*�ڵ�*/						\n");
						sql.append(" COALESCE(A.GIVCNT,0) GIVCNT,													/*�Ǽ�*/						\n");
						sql.append(" COALESCE(A.GIVAMT,0) GIVAMT,													/*�ݾ�*/						\n");
						sql.append(" '"+str[2]+"' AS CURDT																/*�ۼ�����*/				\n");
						sql.append(" FROM PAYROLL.YCGIBU A																/*��αݸ���*/		\n");	
						sql.append(" LEFT JOIN PAYROLL.HIPERSON B ON A.EMPNO = B.EMPNO		/*�λ�⺻����*/		\n");
						//sql.append(" LEFT JOIN PAYROLL.HCDEPT   C ON B.DEPTCD = C.DEPTCD	/*�μ�����*/			\n");
						sql.append(" WHERE RTRIM(A.EMPNO) <> ''																								\n");
						
						if (!str[0].equals(""))	sql.append(" AND RTRIM(B.EMPNMK) LIKE '"+str[0]+"%'						\n"); 
						if (!str[1].equals(""))	sql.append(" AND RTRIM(A.YYYY)			= '"+str[1]+"'						\n");	
						//if (!str[3].equals(""))	sql.append(" AND RTRIM(C.DEPTCD)		= '"+str[3]+"'					\n");
						sql.append(" ORDER BY B.EMPNMK																												\n");

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