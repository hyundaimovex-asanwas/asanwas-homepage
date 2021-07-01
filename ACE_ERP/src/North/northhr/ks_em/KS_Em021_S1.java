package North.northhr.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class KS_Em021_S1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");   //FROM
				String  str2	= req.getParameter("v_str2");   //TO
				
				if (str1==null) str1=""; 
				if (str2==null) str2=""; 
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "ATT_DT","DAY_CD", "DAY_GB", "REMARK",
					
																		"I_EMPNO",   "I_DATE",  "U_EMPNO",	"U_DATE"

                               
																		  	}; //

				int[] intArrCN = new int[] { 8, 1, 1, 50,
					
															10,10,10,10

																			}; 
			
				int[] intArrCN2 = new int[]{ -1,-1, -1, -1,

					                           -1,-1,-1,-1

																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append("	SELECT ATT_DT,			\n");
						sql.append("	DAY_CD,		 	\n");
						sql.append("	DAY_GB,		 	\n");
						sql.append("	REMARK,		 	\n");
						sql.append("	I_EMPNO,		 \n");
						sql.append("	I_DATE,			 \n");
						sql.append("	U_EMPNO,		 \n");
						sql.append("	U_DATE		 	\n");
						sql.append( "	   FROM ATP.KST130                                            \n");
						sql.append( "	   WHERE 1=1 \n");						
						if(!str1.equals("")&&!str2.equals(""))sql.append( "	  AND  (ATT_DT BETWEEN '" +str1+"' AND '"+str2+"') \n");

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