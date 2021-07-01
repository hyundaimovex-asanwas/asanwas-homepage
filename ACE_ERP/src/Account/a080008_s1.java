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
public class a080008_s1 extends HttpServlet {
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
				String [] str = new String [5];
				str[0]	= req.getParameter("v_str1");		//����                  
				str[1]	= req.getParameter("v_str2");		//from����        
				str[2]	= req.getParameter("v_str3");		//to����     
				str[3]	= req.getParameter("v_str4");		//����μ��ڵ�        
				str[4]	= req.getParameter("v_str5");		//����μ��� 
				
				
				for (int s=0;s<=4;s++) {
					if (str[s]==null) str[s] = "";
				}
		
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ATCODE","ATKORNAM","AMT"
				}; 

				int[] intArrCN = new int[]{  7,  66,  15
				}; 
			
				int[] intArrCN2 = new int[]{ -1,-1,   0
				                           
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT A.ATCODE, C.ATKORNAM , SUM(A.DEAMT) AMT                                    \n " );
					sql.append( "    FROM ACCOUNT.GENENLED A                                                  		\n " );
					sql.append( "     LEFT JOIN ACCOUNT.GENENREF B ON A.FDCODE = B.FDCODE        					\n " );
					sql.append( "      AND A.FSDAT = B.FSDAT                                                        \n " );
					sql.append( "      AND A.FSNBR = B.FSNBR                                                        \n " );
					sql.append( "      AND A.FSSEQ = B.FSSEQ                                                        \n " );
					sql.append( "     LEFT JOIN ACCOUNT.ACTCODE C ON A.ATCODE = C.ATCODE AND C.ATUSEYN='Y'         	\n " );
					sql.append( "     LEFT JOIN ACCOUNT.COMMDTIL E ON B.FSREFVAL = E.CDCODE AND E.CMTYPE='0003' 	\n " );
					sql.append( " WHERE 1 = 1                                                 						\n " );
					sql.append( "      AND B.FSREFCD ='0003'                                            \n " );
					sql.append( "      AND A.FDCODE ='"+str[0]+"'                                       \n " );
					
					//2016.04.22 jys Ʃ��. 
					//A.ACTDAT �� RTRIM ��  index range scan ��  index skip scan ���� ������Ѽ� �˻� �ӵ� ��� 
					
					sql.append( "      AND RTRIM(A.ACTDAT) BETWEEN '"+str[1]+"' AND '"+str[2]+"'        \n " );
					if(!str[3].equals(""))sql.append( " AND B.FSREFVAL = '"+str[3]+"'                   \n " );
                    if(!str[4].equals(""))sql.append( " AND E.CDNAM LIKE '%"+str[4]+"%'             	\n " );
					sql.append( "      AND A.ATCODE >'4400000' AND A.ATCODE < '4510000'                 \n " );
					//sql.append( "      AND E.DSUDT IS NOT NULL                     								\n " );
					sql.append( "  GROUP BY A.ATCODE, C.ATKORNAM    									\n " );
					sql.append( "  ORDER BY  A.ATCODE                           						\n " );
          
					//System.out.println("# Query : \n" + sql);
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