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
public class a010002_s9 extends HttpServlet {
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
				str[0] = req.getParameter("v_str1");	//��±����ڵ�
				str[1] = req.getParameter("v_str2");	//��±����ڵ�

				for(int i=0;i<=1;i++) {
					if(str[i] == null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"CHK","PRTCODE","PRTACT","ATKORNAM","PRTACTREF",
					"WRDT","WRID","UPDT","UPID"
				}; 

				int[] intArrCN = new int[] { 
					1,  2,   7,  66,   7,
					8,  7,   8,  7
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
						
						sql.append( " SELECT																										\n");
						sql.append( " 'F' AS CHK,													/*üũ*/										\n");
						sql.append( " RTRIM(A.PRTCODE)	 PRTCODE,         /*��±����ڵ�*/									\n");
						sql.append( " RTRIM(A.PRTACT)		 PRTACT,          /*��°����ڵ�*/										\n");
						sql.append( " RTRIM(B.ATKORNAM)	 ATKORNAM,        /*��°��������*/								\n");
						sql.append( " RTRIM(A.PRTACTREF) PRTACTREF,       /*��¿������*/									\n");
						sql.append( " RTRIM(A.WRDT)			 WRDT,						/*�۾�����*/								\n");
						sql.append( " RTRIM(A.WRID)			 WRID,						/*�۾���*/	  									\n");
						sql.append( " RTRIM(A.UPDT)			 UPDT,						/*��������*/								\n");
						sql.append( " RTRIM(A.UPID)			 UPID 						/*������*/										\n");
						sql.append( " FROM ACCOUNT.RPTPRTREF A						/*��°�������*/							\n");
						sql.append( " LEFT JOIN ACCOUNT.ACTCODE B ON A.PRTACTREF=B.ATCODE	/*��������*/		\n");
						sql.append( " WHERE A.PRTCODE IS NOT NULL																	\n");

						if(!str[0].equals("")) sql.append( " AND A.PRTCODE = '"+str[0]+"'											\n");
						if(!str[1].equals("")) sql.append( " AND A.PRTACT  = '"+str[1]+"'												\n");

						sql.append( " ORDER BY PRTACT																						\n");						

						
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