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
public class commdtil_cost_s1 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1");  //cmtype
				String  str2	= req.getParameter("v_str2");  //cdcode
				String  str3	= req.getParameter("v_str3");  //cdnam
				String  str4	= req.getParameter("v_str4");  //������� ���� C�̸� ������ڰ� ���°Ǹ� ������ 
				String  str5	= req.getParameter("v_str5");  //
				String  str6	= req.getParameter("v_str6");  //

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CMTYPE",	"CDCODE", "CDNAM",	"CDREMARK",	
				                                  "WRDT",   "WRID",  	"UPDT",	  "UPID",	"DSUDT","GBCD","PSEQ"}; 

				int[] intArrCN = new int[]{ 4, 20, 40, 60, 
					                          8,  7,  8,  7, 8, 6, 5}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, 
					                           -1, -1, -1, -1, -1, -1, -1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					
					sql.append( " SELECT CMTYPE, RTRIM(CDCODE) CDCODE, CDNAM, CDREMARK,	 								\n");
					sql.append( "        WRDT,  WRID,	UPDT,	 UPID, RTRIM(DSUDT)DSUDT, RTRIM(GBCD)GBCD,PSEQ		    \n");
					sql.append( "  FROM ACCOUNT.COMMDTIL															    \n");
					if (!str1.equals(""))sql.append( " WHERE CMTYPE = '" + str1 + "' 									\n");
					if (!str2.equals(""))sql.append( "   AND CDCODE LIKE '" + str2 + "%' 								\n");
					if (!str3.equals(""))sql.append( "   AND ( CDCODE LIKE '%"+str3+"%' OR CDNAM LIKE '%"+str3+"%')		\n");
					//if (!str4.equals(""))sql.append( "   AND (RTRIM(DSUDT) ='' OR RTRIM(DSUDT) IS NULL) 							\n");
					if (!str4.equals(""))sql.append( "   AND RTRIM(DSUDT) IS NULL                                       \n");
					if (!str5.equals(""))sql.append( "   AND PSEQ IS NOT NULL 											\n");
					if (!str6.equals(""))sql.append( "   AND GBCD = '"+ str6 +"' 										\n");
					sql.append( "  ORDER BY CDCODE      															    \n");
					
					System.out.println("commdtil_cost_s1"+ sql.toString() );					
					//logger.dbg.println(this,sql.toString());
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