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
public class a030035_s3 extends HttpServlet {
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
				// ��ü��ȸ
				String  str1  = req.getParameter("v_str1");  //����
				String  str2  = req.getParameter("v_str2");  //ȸ������FR
				String  str3  = req.getParameter("v_str3");  //ȸ������TO
				String  str4  = req.getParameter("v_str4");  //�����ڵ�
				String  str5  = req.getParameter("v_str5");  //���뱸�� 	
			
				if(str1 == null) str1 = ""; //����       
				if(str2 == null) str2 = ""; //ȸ������ FR   
				if(str3 == null) str3 = ""; //ȸ������ TO        
				if(str4 == null) str4 = ""; //�����ڵ�
				if(str5 == null) str5 = ""; //���뱸��
				      					
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{   "FDCODE", "FSDAT","FSNBR","FSSEQ", "ATCODE",
					                                                    "M_DEAMT", "M_CRAMT", "DEAMT", "CRAMT"
				                                                   }; 

				int[] intArrCN = new int[]{ 2,  9,   6,   5,  7,	
					                                      15, 15, 15, 15
				}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
					                                          0, 0, 0, 0
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				}
				
				if (!GauceReq.isBuilderRequest()) {
                	StringBuffer sql = new StringBuffer();
                	
					sql.append( " SELECT  A.FDCODE, A.TSDAT AS FSDAT,  A.TSNBR AS FSNBR, A.TSSEQ AS FSSEQ, A.ATCODE,                    \n");
					sql.append( "         X.BJDEAMT AS M_DEAMT, X.BJCRAMT AS M_CRAMT,                        \n");
					sql.append( "         A.DEAMT,  A.CRAMT                                                  \n");
					sql.append( "   FROM ACCOUNT.BANJAEMST A                                                 \n");
					sql.append( "   LEFT JOIN ( SELECT B.FDCODE, B.TSDAT, B.TSNBR, B.TSSEQ,                  \n");
					sql.append( "                      SUM(B.BJDEAMT)BJDEAMT, SUM(B.BJCRAMT)BJCRAMT          \n");
					sql.append( "                 FROM ACCOUNT.BANJAEREL B, ACCOUNT.BANJAEMST A              \n");
					sql.append( "                WHERE A.FDCODE = B.FDCODE                                   \n");
					sql.append( "                  AND A.TSDAT = B.TSDAT                                     \n");
					sql.append( "                  AND A.TSNBR = B.TSNBR                                     \n");
					sql.append( "                  AND A.TSSEQ = B.TSSEQ                                     \n");
					sql.append( "                  AND B.FDCODE ='"+str1+"'                                      \n");
					sql.append( "                GROUP BY B.FDCODE, B.TSDAT, B.TSNBR, B.TSSEQ                \n");
					sql.append( "              ) X  ON X.FDCODE = A.FDCODE                                   \n");
					sql.append( "                  AND X.TSDAT = A.TSDAT                                     \n");
					sql.append( "                  AND X.TSNBR = A.TSNBR                                     \n");
					sql.append( "                  AND X.TSSEQ = A.TSSEQ                                     \n");
					sql.append( "  LEFT JOIN ACCOUNT.ACTCODE C ON A.ATCODE = C.ATCODE AND C.ATDEBTYN='Y'     \n");
					sql.append( "  WHERE A.FDCODE ='"+str1+"'                                                     \n");
					sql.append( "     AND A.ATCODE = '"+str4+"'                                               \n");
					if (str5.equals("1"))sql.append( "     AND A.CRAMT <> X.BJCRAMT               \n"); 
					if (str5.equals("2"))sql.append( "     AND A.DEAMT <> X.BJDEAMT               \n");

					//System.out.println("a030035_3::"+sql.toString());
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