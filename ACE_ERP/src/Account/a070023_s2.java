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
public class a070023_s2 extends HttpServlet {
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
			logger  = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
			GauceResponse GauceRes = service.getGauceResponse();

			try {
				conn = service.getDBConnection();
				dSet = new GauceDataSet();

/**********************************************************************************************
	���� �������� �����Ͻ� �κ�
**********************************************************************************************/
				// ������������ ���ǰ��� �Ѱܹ��� 
				String  str1 = req.getParameter("v_str1");    //�ŷ�ó��
				
				System.out.println("a070023_s2:str1:"+str1);

				if (str1 == null) str1 = "";
			
				GauceRes.enableFirstRow(dSet);			
				String[] strArrCN = new String[]{"VEND_CD", "VEND_NM" , "HIS_SEQ", "CERTI_EMPNO" ,  "ENO_NM",  "CERTI_DATE",
					                              "WRID",   "WRDT",    "UPID",     "UPDT" 
					                             }; 

				int[] intArrCN = new int[]{ 13,  62 ,  2,   10 ,  20,  8, 
					                         10,  10, 10,   10
					                       }; 
					
				int[] intArrCN2 = new int[]{ -1, -1 , 0, -1, -1, -1,
											  -1 ,-1, -1,-1 
				                             };  				                                           

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();
					 
					sql.append( " SELECT A.VEND_CD, B.VEND_NM, A.HIS_SEQ, A.CERTI_EMPNO, C.ENO_NM, A.CERTI_DATE, \n");
					sql.append( "        A.WRID, A.WRDT, A.UPID, A.UPDT  	                                     \n");
					sql.append( "   FROM ACCOUNT.BOND_ATTACH_HIS A, ACCOUNT.GCZM_VENDER B, ASNHR.T_CM_PERSON C   \n");
					sql.append( "  WHERE A.VEND_CD = B.VEND_CD(+)    	\n");									
					sql.append( "    AND A.CERTI_EMPNO = C.ENO_NO(+)  	\n");
					sql.append( "    AND A.VEND_CD = '"+str1+"'     	\n");
					sql.append( "  ORDER BY A.HIS_SEQ \n");	

					//System.out.println("a070023_s2::"+sql.toString());
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