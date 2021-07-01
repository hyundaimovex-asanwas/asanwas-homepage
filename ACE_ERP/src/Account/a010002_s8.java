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
public class a010002_s8 extends HttpServlet {
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
				String []  str	= new String [10];
				str[0] = req.getParameter("v_str1");	//��±���
				str[1] = req.getParameter("v_str2");	//��±���(üũ)

				for(int i=0;i<=1;i++) {
					if(str[i] == null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"PRTCODE","PRTNBR","ATCODE","PRTNAM","LRDIV",
					"PRTLT","PRTRT","PRTSEQ", "PRTNO"
				}; 

				int[] intArrCN = new int[] { 
					2,   5,   7,  66,  1,
					100,  100,  5,   5
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( " SELECT																						\n");
						sql.append( " RTRIM(A.PRTCODE)  PRTCODE,     /*��±����ڵ�*/							\n");
						sql.append( " RTRIM(A.PRTNBR)   PRTNBR,      /*��µ�Ϲ�ȣ*/							\n");
						sql.append( " RTRIM(A.ATCODE)   ATCODE,      /*��°����ڵ�*/							\n");
						sql.append( " RTRIM(A.PRTNAM)   PRTNAM,      /*��¸�*/										\n");
						sql.append( " RTRIM(A.LRDIV)		LRDIV,       /*�¿챸��*/									\n");
						sql.append( " RTRIM(A.PRTLT)		PRTLT,       /*�������*/									\n");
						sql.append( " RTRIM(A.PRTRT)		PRTRT,       /*��Ĵ뺯*/									\n");
						sql.append( " RTRIM(A.PRTSEQ)   PRTSEQ,      /*��¹�ȣ*/									\n");
						sql.append( " RTRIM(A.PRTNO)		PRTNO	       /*��������*/								\n");
						sql.append( " FROM ACCOUNT.RPTPRTACT A			 /*�繫��ǥ���*/					\n");
						sql.append( " WHERE A.PRTCODE IS NOT NULL													\n");
						
						if(!str[0].equals("")) sql.append( " AND A.PRTCODE='"+str[0]+"'								\n");
						if(str[1].equals("A")) sql.append( " AND A.PRTCODE IN ('03','04')							\n");

						sql.append( " ORDER BY PRTSEQ																		\n");						


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