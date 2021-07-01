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
public class a080003_s5 extends HttpServlet {
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
				str[0] = req.getParameter("v_str1");	//�����ڵ�
				str[1] = req.getParameter("v_str2");	//����⵵
				str[2] = req.getParameter("v_str3");	//�����
				str[3] = req.getParameter("v_str4");	//���꺻��
				str[4] = req.getParameter("v_str5");	//����μ�
				str[5] = req.getParameter("v_str6");	//��������
				str[6] = req.getParameter("v_str7");	//�����׸�
				str[7] = req.getParameter("v_str8");	//������
				str[8] = req.getParameter("v_str9");	//����Ÿ��

				for(int i=0;i<=8;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "JANAMT"	}; 

				int[] intArrCN = new int[] { 	15	}; 
			
				int[] intArrCN2 = new int[]{   0	}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT COALESCE(BRESULTS-RESULTS,0) JANAMT        		\n");
						sql.append( " FROM ACCOUNT.BGTDTL       												\n");
						sql.append( " WHERE FDCODE IS NOT NULL												\n");
						if(!str[0].equals("")) sql.append( " AND FDCODE  = '"+str[0]+"'	\n");
						if(!str[1].equals("")) sql.append( " AND BGTYY   = '"+str[1]+"'		\n");
						if(!str[2].equals("")) sql.append( " AND BGTMM   = '"+str[2]+"'	\n");
						if(!str[3].equals("")) sql.append( " AND BGTDIV  = '"+str[3]+"'		\n");
						if(!str[4].equals("")) sql.append( " AND BGTDPT  = '"+str[4]+"'		\n");
						if(!str[5].equals("")) sql.append( " AND ATCODE  = '"+str[5]+"'	\n");
						if(!str[6].equals("")) sql.append( " AND FSREFCD = '"+str[6]+"'	\n");
						if(!str[7].equals("")) sql.append( " AND SATCODE = '"+str[7]+"'	\n");
						if(!str[8].equals("")) sql.append( " AND BGTMACT = '"+str[8]+"'	\n");

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