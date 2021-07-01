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
public class bills_popup_s2 extends HttpServlet {
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

				String  str1 = req.getParameter("v_str1");    //���� : ��ü - A 
				String  str2 = req.getParameter("v_str2");    //���
				String  str3 = req.getParameter("v_str3");    //��꼭���� fr
				String  str4 = req.getParameter("v_str4");    //��꼭���� to
				String  str5 = req.getParameter("v_str5");    //����
				String  str6 = req.getParameter("v_str6");    //���� ���� (1- �̿���, 2 -�� ����)

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "TAXNBR",  "TAXIODIV",  "TAXDAT",  "TAXSUM",  "TAXVATAMT",
					                                "REMARK"
                            					 	}; 
					
				int[] intArrCN = new int[]{  11,  1,  8,  15,  13, 
					                          132
				                         	}; 
					
				int[] intArrCN2 = new int[]{ -1, -1, -1,   0,   0, 
					                           -1
					                        }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT A.TAXNBR, A.TAXIODIV, A.TAXDAT, A.TAXSUM, A.TAXVATAMT, A.REMARK \n");
					sql.append( "   FROM ACCOUNT.ATTAXMST A                                              \n");
					sql.append( "   LEFT JOIN ( SELECT DISTINCT B.TAXNBR                                 \n"); 
					sql.append( "                 FROM ACCOUNT.ASTMSTN B                                 \n");
					sql.append( "                WHERE B.FDCODE =  '" + str5 + "'                        \n");
					sql.append( "              ) X ON A.TAXNBR = X.TAXNBR                                \n");
					sql.append( "  WHERE 1=1																													   \n"); 
					sql.append( "    AND A.TAXIODIV ='A'																							   \n"); // ����
					sql.append( "    AND RTRIM(A.FSDAT) IS NULL																							   \n");
					sql.append( "    AND RTRIM(A.FSNBR) IS NULL																							   \n");
					sql.append( "    AND RTRIM(A.FSNBR) IS NULL																							   \n");

					if (!str1.equals("A"))sql.append( " AND A.EMPNO = '" + str2 + "'              \n");
					if (!str5.equals("")) sql.append( " AND A.FDCODE = '" + str5 + "'             \n");
					if (!str3.equals("")) sql.append( " AND A.TAXDAT BETWEEN '" + str3 + "' AND '"+str4+"' \n" );
					if (str6.equals("1"))sql.append( "  AND NVL(X.TAXNBR,'') IS NULL              \n");
					if (str6.equals("2"))sql.append( "  AND NVL(X.TAXNBR,'') IS NOT NULL          \n");
					sql.append( "  ORDER BY A.TAXNBR \n");
				
					//System.out.println("bills_popup_s2 \n"+sql.toString() );
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