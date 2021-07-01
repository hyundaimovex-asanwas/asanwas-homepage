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
public class a010003_s2 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1");
				String  str2	= req.getParameter("v_str2");


				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";

				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "COCODE", "CONAME", "COROWNO", "COSANG",	"COMANAGER",   
													"COID", "COTEL", "COFAX", "COUPTAI", 
														"COJONMOCK", "COADDRNO", "COADDR1", "COADDR2",
															"COSTRDAT",	"COMON", "COENDDAT", "COTAXCOD",
																"COTAXNAM", "WRDT",	"WRID", "UPDT", 
																	"UPID", "DSUDT" };
																
				int[] intArrCN = new int[]{ 2, 20, 13, 66, 26,
												10, 15, 15, 34,
													34, 6, 66, 66,
														8, 2, 8, 3,
															34, 8, 7, 8,
																7, 8 };
																 
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
												-1, -1, -1, -1,
													-1, -1, -1, -1,
														-1, -1, -1, -1,
															-1, -1, -1, -1, 
																-1, -1 };
															

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT COCODE, CONAME, COROWNO, COSANG,	COMANAGER,  				\n");
					sql.append( "		 COID, COTEL, COFAX, COUPTAI,															\n");
					sql.append( "		 COJONMOCK, COADDRNO, COADDR1, COADDR2, 									\n");
					sql.append( "		 COSTRDAT,  COMON, COENDDAT, COTAXCOD, 										\n");
					sql.append( "		 COTAXNAM, WRDT, WRID, UPDT,															\n");
					sql.append( "		 UPID, DSUDT																						\n");
					sql.append( " FROM ACCOUNT.COMPANY 																		\n");
					sql.append( " WHERE COCODE IS NOT NULL																	\n");
					if (!str1.equals("")) sql.append( " AND COCODE = '" + str1 + "'												\n");
					if (!str2.equals("")) sql.append( "  AND COSANG LIKE '" + str2 + "%'										\n");

					//logger.dbg.println( this, sql.toString() );
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