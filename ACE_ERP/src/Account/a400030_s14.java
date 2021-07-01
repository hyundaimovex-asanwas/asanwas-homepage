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
public class a400030_s14 extends HttpServlet {
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
				String []  str	= new String [4];
				str[0] = req.getParameter("v_str1");	//�����ڵ�
				str[1] = req.getParameter("v_str2");	//���¹�ȣ
				str[2] = req.getParameter("v_str3");	//�ŷ�����
				str[3] = req.getParameter("v_str4");	//����
				
				
				for(int i=0;i<=3;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"DEDATE",   "ACCTNO",    "ACCTCD",   "REMARK",   "BALAMTS",   "BALAMTS2",    
					"FBALAMTS", "CURUNIT",   "ACCTUSE",  "ACCTGB",   "BRCHCD", 
					"DEPOGB",   "INRATE",    "CHKBOX",   "CLOSEYN",
					"BRCHNM",   "ACCTGBNM",
					"WRID",     "WRDT",      "UPID",     "UPDT"
					 }; 

				int[] intArrCN = new int[] { 
					 8,   30,  10,	100,  15,  10,
				    15,    6,  60,    2,   6,  
				     1,    4,   1,    1,
				    60,   60, 
				    10,   10,  10,   10
				  
					
				}; 
			
				int[] intArrCN2 = new int[]{ 
				    -1,  -1,  -1,  -1,  0,  0,	
					 2,  -1,  -1,  -1, -1,
 					-1,   2,  -1,  -1, 
 					-1,  -1,
 					-1,  -1,  -1,  -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT A.DEDATE,  A.ACCTNO, A.ACCTCD, A.REMARK, A.BALAMTS,   ROUND(A.BALAMTS/1000000)BALAMTS2,         \n");
						sql.append( "        A.FBALAMTS,A.CURUNIT,A.ACCTUSE,A.ACCTGB, A.BRCHCD,           \n");
						sql.append( "        A.DEPOGB,  A.INRATE, A.CHKBOX, A.CLOSEYN,                    \n");
						sql.append( "        CASE WHEN ACCTNO='1' THEN '����(��ȭ)'                         \n");
						sql.append( "             WHEN ACCTNO IN ('2','3','4') THEN '����(��ȭ)'            \n");
						sql.append( "             ELSE C.CDNAM  END AS BRCHNM, D.CDNAM AS ACCTGBNM,       \n");
						sql.append( "        A.WRID,    A.WRDT,   A.UPID,   A.UPDT                        \n");
						sql.append( "   FROM ACCOUNT.ACDPSUM A, ACCOUNT.COMMDTIL C,  ACCOUNT.COMMDTIL D   \n");
						sql.append( "  WHERE A.DEPOGB ='4'                                                \n");
						sql.append( "    AND A.DEDATE ='"+str[2] +"'                                      \n");
						sql.append( "    AND A.BRCHCD = C.CDCODE(+) AND C.CMTYPE(+) ='0022'               \n");
						sql.append( "    AND A.ACCTGB = D.CDCODE(+) AND D.CMTYPE(+) ='2250'               \n");
						
						
						System.out.println("# a400030_s14 Query : \n" + sql);
						
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