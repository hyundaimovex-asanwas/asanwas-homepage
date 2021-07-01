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
public class astMove_chk_s1 extends HttpServlet {
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

				String  str1 = req.getParameter("v_str1");    //�Ҽ�
				String  str2 = req.getParameter("v_str2");    //����

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"CYYMMDD"
				                                };  

				int[] intArrCN = new int[]{ 8
					                        }; 
					
				int[] intArrCN2 = new int[]{-1
				                            }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();

					//sql.append( " SELECT REPLACE(CHAR((DATE(MAX(YEAR||'-'||MONTH||'-'||'01')) + 1 MONTH),ISO),'-','') AS CYYMMDD  \n");

					sql.append( " SELECT TO_CHAR(ADD_MONTHS(MAX(YEAR||MONTH)||'01',1),'YYYYMMDD') AS CYYMMDD \n");					
					sql.append( "    FROM ACCOUNT.ASTCLOSE  								\n");
					sql.append( "  WHERE 1=1                                                      	\n");
					if (!str1.equals("")) sql.append( " AND FDCODE = '" + str1 + "'  		\n" );
					if (!str2.equals("")) sql.append( " AND GUBUN  = '" + str2 + "'   		\n" );
                    
					//System.out.println("# Query : \n" + sql);
                    /*
                    sql.append( " SELECT MAX(YEAR||MONTH) AS CYYMM    \n");
					sql.append( "   FROM ACCOUNT.ASTCLOSE                      \n");
					sql.append( "  WHERE 1=1                                                 \n");
					if (!str1.equals("")) sql.append( " AND FDCODE = '" + str1 + "' " );
					if (!str2.equals("")) sql.append( " AND GUBUN  = '" + str2 + "' " );
					*/
			 
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