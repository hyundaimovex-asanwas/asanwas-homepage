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
public class a030035_s4 extends HttpServlet {
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

				String[] strArrCN = new String[]{   "FDCODE", "FSDAT","FSNBR","FSSEQ", "ATCODE", "SSDAT", "SSNBR",
					                                                    "DEAMT", "CRAMT"
				                                                   };  

				int[] intArrCN = new int[]{ 2,  9,   6,   5,  7,  9,  6,	
					                                      15, 15
				}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1, -1,
					                                          0, 0
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				}
				
				if (!GauceReq.isBuilderRequest()) {
                	StringBuffer sql = new StringBuffer();
                	
					sql.append( " SELECT A.FDCODE, A.FSDAT, A.FSNBR, A.FSSEQ, A.ATCODE, A.SSDAT,A.SSNBR,            \n");
					sql.append( "        CASE WHEN B.ATDECR ='2' AND A.DEAMT <>0  THEN A.DEAMT ELSE 0 END DEAMT,   \n");
					sql.append( "        CASE WHEN B.ATDECR ='1' AND A.CRAMT <>0  THEN A.CRAMT ELSE 0 END CRAMT   \n");
					sql.append( "   FROM ACCOUNT.GENENLED A                                                        \n");
					sql.append( "   LEFT JOIN ACCOUNT.ACTCODE B ON A.ATCODE = B.ATCODE         \n");
					sql.append( "  WHERE A.FDCODE ='"+str1+"'                                                            \n");
					sql.append( "    AND B.ATDEBTYN = 'Y'                                                                   \n");
					sql.append( "    AND A.ATCODE ='"+str4+"'                                                               \n");
					sql.append( "    AND A.ACTDAT BETWEEN  '"+str2+"'  AND '"+str3+"'                        \n");
					sql.append( "    AND ((CASE WHEN B.ATDECR ='2' AND A.DEAMT <>0  THEN A.DEAMT ELSE 0 END<>0)   \n");
					sql.append( "      OR (CASE WHEN B.ATDECR ='1' AND A.CRAMT <>0  THEN A.CRAMT ELSE 0 END<>0))  \n");
					sql.append( "    AND NOT EXISTS ( SELECT * FROM ACCOUNT.BANJAEREL C         \n");
					sql.append( "                      WHERE C.FDCODE = A.FDCODE                                    \n");
					sql.append( "                        AND C.BTSDAT = A.FSDAT                                          \n");		
					sql.append( "                        AND C.BTSNBR = A.FSNBR                                         \n");
					sql.append( "                        AND C.BTSSEQ = A.FSSEQ                                         \n");
					sql.append( "                     )                                                                                     \n");
					//sql.append( "    AND A.FSNBR<='100000'                                                                  \n");	
                         		
					//System.out.println("a030035_4::"+sql.toString());
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