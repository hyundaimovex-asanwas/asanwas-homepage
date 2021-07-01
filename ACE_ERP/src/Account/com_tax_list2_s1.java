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
public class com_tax_list2_s1 extends HttpServlet {
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
				String  str2  = req.getParameter("v_str2");
				String  str3  = req.getParameter("v_str3");
				String  str4  = req.getParameter("v_str4");

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "TAXNBR","TAXDAT","VENDNM","REMARK","FSNBR" }; 

				int[] intArrCN = new int[] { 11, 8, 32, 132, 16 }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT A.TAXNBR AS TAXNBR, A.TAXDAT AS TAXDAT, B.VEND_NM AS VENDNM, A.REMARK AS REMARK, " );
					sql.append( "        CASE WHEN (A.FSNBR=''OR A.FSNBR IS NULL) THEN '' ELSE A.FSDAT||'-'||A.FSNBR END FSNBR " );
					sql.append( " FROM ACCOUNT.ATTAXMST A, ACCOUNT.GCZM_VENDER B " );
				  sql.append( " WHERE A.VEND_CD = B.VEND_CD " );
					//if (!str1.equals(""))
						sql.append( " AND B.VEND_NM LIKE '%" + str1 + "%' ");
					if (!str2.equals(""))
						sql.append( " AND A.TAXDAT = '" + str2 + "' " );
					//if (!str3.equals(""))
						sql.append( " AND A.REMARK LIKE '%" + str3 + "%' " );
					if (!str4.equals("")) {
						if(str4.equals("Y"))
							sql.append( " AND NOT(A.FSNBR IS NULL OR A.FSNBR = '') " );
						else
							sql.append( " AND (A.FSNBR IS NULL OR A.FSNBR = '') " );
					}
					sql.append( " AND A.TAXKND = '2' " );

					//logger.dbg.println(this,"sql::"+sql.toString());

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