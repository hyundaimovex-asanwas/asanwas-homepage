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
public class a400040_s2 extends HttpServlet {
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
				String []  str	= new String [2];
				str[0] = req.getParameter("v_str1");	//��������
				str[1] = req.getParameter("v_str2");	//�ŷ�����
				
				
				
				for(int i=0;i<=1;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"REPTDT",   "DEDATE",   "INOUTGB",    "REMARK",
					"PLAMT",    "REAMT",     "CUAMT",     "RSTSEQ", "SEQ",  "ACCTNO",  "WRID"
					 }; 

				int[] intArrCN = new int[] { 
					  8,   8,	10,  100,
				     15,  15,   15,    3,  3,  30,  10
				}; 
			
				int[] intArrCN2 = new int[]{ 
				    -1,  -1,  -1,  -1,	
					 0,   0,   0,   0,   0,  -1,  -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						
						sql.append( " SELECT X.REPTDT, X.DEDATE, X.INOUTGB, X.REMARK, X.PLAMT, X.REAMT, X.CUAMT, \n");
						sql.append( "        X.RSTSEQ, X.SEQ,    X.ACCTNO,  X.WRID \n");
						sql.append( "   FROM ACCOUNT.ACREPLAN X   \n");
						sql.append( "  WHERE X.REPTDT ='"+str[0]+"' \n");
						sql.append( "  ORDER BY X.RSTSEQ   \n");
							
						System.out.println("# a400040_s2 Query : \n" + sql);
						
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