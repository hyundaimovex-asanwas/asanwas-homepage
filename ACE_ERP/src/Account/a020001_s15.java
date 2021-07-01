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
public class a020001_s15 extends HttpServlet {
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
				String []  str	= new String [3];
				str[0] = req.getParameter("v_str1"); //fdcode	
				str[1] = req.getParameter("v_str2"); //fsdat	
				str[2] = req.getParameter("v_str3"); //fsnbr	 
				
				for (int s=0;s<=2;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE","FSDAT","FSNBR","FSSEQ","ATCODE",
					"COST","DEPTNM3"
				}; 

				int[] intArrCN = new int[] { 
					 2,  9,  6,  5,  7,
					40,  50
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,
					-1,  -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						
						sql.append( "	SELECT X2.FDCODE, X2.FSDAT, X2.FSNBR, X2.FSSEQ, X2.ATCODE, MAX(X2.COST) COST,MAX(X3.DEPTNM3) DEPTNM3                         	\n");	
						sql.append( "	FROM(SELECT A.FDCODE, A.FSDAT, A.FSNBR, B.FSSEQ, B.ATCODE, G.CDNAM AS DEPTNM3                                                				\n");	
						sql.append( "			 FROM ACCOUNT.FSLIPMST A                                                                                                 												\n");	
						sql.append( "			 LEFT JOIN ACCOUNT.FSLIPDTL B ON A.FDCODE = B.FDCODE AND A.FSDAT = B.FSDAT AND A.FSNBR = B.FSNBR                         	\n");	
						sql.append( "			 LEFT JOIN ACCOUNT.FSLIPREF C ON A.FDCODE = C.FDCODE AND A.FSDAT = C.FSDAT AND A.FSNBR = C.FSNBR  AND B.FSSEQ = C.FSSEQ  	\n");	
						sql.append( "			 LEFT JOIN ACCOUNT.COMMDTIL F ON C.FSREFCD = F.CDCODE AND F.CMTYPE='0050'                                                				\n");	
						sql.append( "			 LEFT JOIN ACCOUNT.COMMDTIL G ON C.FSREFVAL = G.CDCODE AND C.FSREFCD=G.CMTYPE                                            			\n");	
						sql.append( "			 WHERE B.FDCODE = '"+str[0]+"'                                                                                            												\n");	
						sql.append( "			 AND B.FSDAT = '"+str[1]+"'                                                                                               													\n");	
						sql.append( "			 AND B.FSNBR = '"+str[2]+"'                                                                                               													\n");	
						sql.append( "			 AND C.FSREFCD = '0002'                                                                                                  													\n");	
						sql.append( "	)X3                                                                                                                          																	\n");
						sql.append( "	LEFT JOIN (SELECT A.FDCODE, A.FSDAT, A.FSNBR, B.FSSEQ, B.ATCODE, G.CDNAM AS COST                                              				\n");	
						sql.append( "			 FROM ACCOUNT.FSLIPMST A                                                                                                												\n");	
						sql.append( "			 LEFT JOIN ACCOUNT.FSLIPDTL B ON A.FDCODE = B.FDCODE AND A.FSDAT = B.FSDAT AND A.FSNBR = B.FSNBR                        	\n");	
						sql.append( "			 LEFT JOIN ACCOUNT.FSLIPREF C ON A.FDCODE = C.FDCODE AND A.FSDAT = C.FSDAT AND A.FSNBR = C.FSNBR  AND B.FSSEQ = C.FSSEQ 	\n");	
						sql.append( "			 LEFT JOIN ACCOUNT.COMMDTIL F ON C.FSREFCD = F.CDCODE AND F.CMTYPE='0050'                                               					\n");	
						sql.append( "			 LEFT JOIN ACCOUNT.COMMDTIL G ON C.FSREFVAL = G.CDCODE AND C.FSREFCD=G.CMTYPE                                           			\n");	
						sql.append( "			 WHERE B.FDCODE = '"+str[0]+"'                                                                                            												\n");	
						sql.append( "			 AND B.FSDAT = '"+str[1]+"'                                                                                              													\n");	
						sql.append( "			 AND B.FSNBR = '"+str[2]+"'                                                                                               													\n");	
						sql.append( "			 AND C.FSREFCD = '0030'                                                                                                 													\n");	
						sql.append( "	) X2 ON X2.FDCODE = X3.FDCODE AND X2.FSDAT=X3.FSDAT AND X2.FSNBR=X3.FSNBR																		\n");	
						sql.append( "	GROUP BY X2.FDCODE, X2.FSDAT, X2.FSNBR, X2.FSSEQ, X2.ATCODE                                                                  								\n");	
						sql.append( " ORDER BY X2.FSSEQ																																									\n");		
						
						//logger.dbg.println(this, sql.toString());
						
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