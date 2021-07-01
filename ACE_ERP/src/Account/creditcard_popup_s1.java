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
public class creditcard_popup_s1 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1"); //�μ��ڵ�
				String  str2	= req.getParameter("v_str2"); //ī���ȣ

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CANBR", "CADIV", "CACARDSPEC", "CADEPTCD", "CAEMPNO",
																					"CAISSYYMM", "CAUSEYYMM", "CASTTDAT", "CAACCBANK", "CABANKNO", 
				                                  "CACUST", "DSUDT", "BANNAM", "BANNA1", "EMPNMK"
				}; 

				int[] intArrCN = new int[]{16,  1,  3,  4,  7,
																		6,  6,  2,  4, 20, 
				                           16,  8, 30, 16, 20
				}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, 
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT RTRIM(A.CANBR) CANBR, RTRIM(A.CADIV) CADIV, RTRIM(A.CACARDSPEC) CACARDSPEC, ");
					sql.append( "        RTRIM(A.CADEPTCD) CADEPTCD, RTRIM(A.CAEMPNO) CAEMPNO, RTRIM(A.CAISSYYMM) CAISSYYMM, ");
					sql.append( "        RTRIM(A.CAUSEYYMM) CAUSEYYMM, RTRIM(A.CASTTDAT) CASTTDAT, RTRIM(A.CAACCBANK) CAACCBANK, ");
					sql.append( "        RTRIM(A.CABANKNO) CABANKNO, RTRIM(A.CACUST) CACUST, RTRIM(A.DSUDT) DSUDT, RTRIM(B.BANNAM) BANNAM, ");
					sql.append( "        RTRIM(B.BANNA1) BANNA1, RTRIM(C.EMPNMK) EMPNMK 								");
					sql.append( " FROM ACCOUNT.CARDCODE  A 																			");
					sql.append( " LEFT JOIN ACCOUNT.BANKCODE B ON RTRIM(B.BANCOD) = RTRIM(A.CAACCBANK) 	");
					sql.append( " LEFT JOIN PAYROLL.HIPERSON C ON RTRIM(C.EMPNO) = RTRIM(A.CAEMPNO) 		");
					sql.append( " WHERE  RTRIM(A.CANBR) IS NOT NULL 																");
					if(!str1.equals("")) sql.append( "  AND RTRIM(CADEPTCD) = '"+str1+"'        									" );
					if(!str2.equals("")) sql.append( "  AND RTRIM(CANBR) LIKE '"+str2+"%'       									" );
                    
					//System.out.println("# Query : \n" + sql);
					
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