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
public class p030006_s3 extends HttpServlet {

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

				for (int s=0;s<=0;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);
				String[] strArrCN = new String[]{
						
						"CEONM","CEONO","HYCOUNT","JOCOUNT","PB10000",
						"PB41000","PB42000","PB43000","SUMAMT"
				};

				int[] intArrCN = new int[]{  

					 20,	//��ǥ��      
					 20,	//���ι�ȣ    
						9,	//���ο���	  
						9,	//�����ο���	
						9,	//�ҵ�ݾ��Ѱ�
						9,	//�����ҵ漼	
						9,	//�����ֹμ�	
						9,	//������Ư��	
						9		//�������հ�	
         }; 
				
				int[] intArrCN2 = new int[]{ 

					 -1,	//��ǥ��
				 	 -1,	//���ι�ȣ
						0,	//���ο���	
						0,	//�����ο���		
						0,	//�ҵ�ݾ��Ѱ�		
						0,	//�����ҵ漼	
						0,	//�����ֹμ�		
						0,	//������Ư��		
						0		//�������հ�								
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
						sql.append(" SELECT																																										\n"); 
						sql.append(" '������' AS CEONM,                                         /*��ǥ��*/										\n"); 
						sql.append(" '111-01-00111' AS CEONO,                                   /*���ι�ȣ*/									\n"); 
						sql.append(" (SELECT COUNT(*) FROM PAYROLL.YCPAYCOL) AS HYCOUNT,        /*���ο���*/									\n"); 
						sql.append(" (SELECT COUNT(*) FROM PAYROLL.YCBEFOFF) AS JOCOUNT,        /*�����ο���*/								\n"); 
						sql.append(" A.PB10000,                                                 /*�ҵ�ݾ��Ѱ�*/							\n"); 
						sql.append(" (SELECT SUM(PB41000) FROM PAYROLL.YCPAYCOL ) AS PB41000,   /*�����ҵ漼*/								\n"); 
						sql.append(" (SELECT SUM(PB42000) FROM PAYROLL.YCPAYCOL ) AS PB42000,   /*�����ֹμ�*/								\n"); 
						sql.append(" (SELECT SUM(PB43000) FROM PAYROLL.YCPAYCOL ) AS PB43000,   /*������Ư��*/								\n"); 
						sql.append(" (SELECT SUM(PB41000+PB42000+PB43000) FROM PAYROLL.YCPAYCOL ) AS SUMAMT   /*�������հ�*/	\n"); 
						sql.append(" FROM PAYROLL.YCPAYCOL A  /*�ҵ��ں��ٷμҵ��õ¡��*/																		\n"); 
						sql.append(" LEFT JOIN PAYROLL.YCBEFOFF B ON A.EMPNO = B.EMPNO  /*�����ٹ�������*/										\n"); 
						sql.append(" WHERE B.EMPNO = '2000001'																																\n"); 

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