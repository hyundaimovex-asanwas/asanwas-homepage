package purch;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;


// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class np00010_s3 extends HttpServlet {



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
				String  str1	= req.getParameter("v_str1");				//�ڵ�

				if (str1==null) str1=""; 

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
																"CD_CLS","CD_CODE","CD_NAM","CD_NAM1"																			
																			
																			}; 	
																					
				int[] intArrCN = new int[] { 
																				10, 10, 60, 60																																											 	
																			};  
			
				int[] intArrCN2 = new int[]{
																				-1,-1, -1, -1																		
																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

							sql.append( "	SELECT  A.CD_CLS, A.CD_CODE, A.CD_NAM, A.CD_NAM1          										\n");
							sql.append( "		FROM PURCH.CD_COMM A                                                          							\n");	
							sql.append( "	WHERE 1=1                           																					\n");
							sql.append( "	AND  A.CD_CLS IN (SELECT CD_CODE FROM PURCH.CD_COMM WHERE CD_CLS = 'BIZ')          \n");
							sql.append( "	AND A.CD_CLS = '"+str1+"'																							\n");
							sql.append( "	 ORDER BY CD_CLS,CD_CODE                   																	\n");

		   				 //logger.dbg.println(this,sql.toString());
           
						stmt = conn.getGauceStatement(sql.toString());
						stmt.executeQuery(dSet);
		 				
					}
				
/*********************************************************************************************/

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
