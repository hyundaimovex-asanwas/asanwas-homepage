package purch;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;


// class �̸��� ȭ�ϸ��� �׻� �����ؾ� ��.
public class np00100_s1 extends HttpServlet {



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
				String  str1	= req.getParameter("v_str1");				// �����ڵ�
				String  str2	= req.getParameter("v_str2");				// û������
				String  str3	= req.getParameter("v_str3");				// û���Ⱓ from
				String  str4	= req.getParameter("v_str4");				// û���Ⱓ to  


				if (str1==null) str1=""; 
				if (str2==null) str2=""; 
				if (str3==null) str3=""; 
				if (str4==null) str4=""; 

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
																				"RQ_NO",	"RQ_NM",	"RQ_DT",	 "RQ_STEP"

																			}; 	


				int[] intArrCN = new int[] { 
																				20, 200, 8, 3																					
																			};  
			
				int[] intArrCN2 = new int[]{
																				-1, -1, -1, -1

																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();


										sql.append( "	SELECT  A.RQ_NO, A.RQ_NM, A.RQ_DT,  A.RQ_STEP           					\n");						
										sql.append( "		FROM PURCH.REQUEST_HEAD A                                                          	\n");
										sql.append( "	WHERE 1=1                           															\n");
				if(!str1.equals(""))sql.append( "		AND A.SITE_CD = '"+str1+"'															\n");
				if(!str2.equals(""))sql.append( "		AND A.RQ_STEP = '"+str2+"'															\n");
				if(!str3.equals("")&&!str4.equals(""))sql.append( "		AND A.RQ_DT BETWEEN '"+str3+"' AND '"+str4+"'		\n");

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