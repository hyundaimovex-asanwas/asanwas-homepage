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
public class a400110_s1 extends HttpServlet {
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
				String []  str	= new String [3];
				str[0] = req.getParameter("v_str1");	//���
				str[1] = req.getParameter("v_str2");	//����
				str[2] = req.getParameter("v_str3");	//���
				
				for(int i=0;i<=2;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"EMPID",   "EMPNO",   "EMPNMK",  "S_DATE",  "E_DATE", 
					"USEGB",   "REMARK",  
					"WRID",    "WRDT",    "UPID",    "UPDT" }; 

				int[] intArrCN = new int[] { 
				     5,  10,  10,   8,  8,
				     1, 100,  
				    10,  19,  10,  19 
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,
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
						sql.append( "  SELECT A.EMPID, A.EMPNO, B.ENO_NM AS EMPNMK, A.S_DATE, A.E_DATE, \n");
						sql.append( "         A.USEGB, A.REMARK,                        \n");
						sql.append( "         A.WRID,  A.WRDT,  A.UPID,  A.UPDT         \n");
						sql.append( "    FROM ACCOUNT.SIGNET_MGR A, ASNHR.T_CM_PERSON B \n");
						sql.append( "   WHERE A.EMPNO = B.ENO_NO(+)                     \n");
						if (!str[0].equals(""))sql.append( " AND A.EMPNO ='"+str[0]+"'  \n");
						if (!str[1].equals(""))sql.append( " AND B.ENO_NM LIKE '%"+str[1]+"%'  \n");
						if (!str[2].equals(""))sql.append( " AND A.USEGB ='"+str[2]+"'  \n");
						sql.append( "   ORDER BY A.EMPID                    \n");
						
						//System.out.println("# a400110_s1 Query : \n" + sql);
							
/*********************************************************************************************/
					
					stmt = conn.getGauceStatement(sql.toString());
		 			stmt.executeQuery(dSet);
				}
			} catch(Exception e) {
		  	//logger.err.println(this,e);
		  	System.err.println(e);
		  } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close(true);} catch (Exception e) {}
			}

		  dSet.flush();
		  GauceRes.commit();
		  GauceRes.close();

		} catch (Exception e) {
			//logger.err.println(this,e);
			System.err.println(e);
			//logger.dbg.println(this,e.toString());
			
		} finally {
			loader.restoreService(service);
  	}
	}
}