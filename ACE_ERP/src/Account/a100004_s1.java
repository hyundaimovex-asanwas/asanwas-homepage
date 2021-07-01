package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class a100004_s1 extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
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
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				String [] str = new String [6];
				str[0]	= req.getParameter("v_str1");		//지점                  
				str[1]	= req.getParameter("v_str2");		//fr년월            
				str[2]	= req.getParameter("v_str3");		//to년월            
				str[3]	= req.getParameter("v_str4");		//사업장      
				str[4]	= req.getParameter("v_str5");		//원가
				str[5]	= req.getParameter("v_str6");		//
			
				
				
				for (int s=0;s<=5;s++) {
					if (str[s]==null) str[s] = "";
				}
		
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ATCODE","PRTNAM","FSREFVAL","FSREFNM","PRTSEQ",
					                                "AMT"
				}; 

				int[] intArrCN = new int[]{  7, 66, 6, 66, 5,
					                          15
				}; 
			
				int[] intArrCN2 = new int[]{ -1,-1, -1, -1, -1,
					                            0
				                           
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT X.ATCODE,X.PRTNAM,X.FSREFVAL, X.FSREFNM,X.PRTSEQ, SUM(X.AMT) AMT                               \n " );
					sql.append( "  FROM(                                                                                                 											\n " );
					sql.append( "  	SELECT A.ATCODE, F.PRTNAM, A.FSREFVAL, C.CDNAM FSREFNM, F.PRTSEQ, B.ATDECR ,                        \n " );
					sql.append( "  				 CASE WHEN B.ATDECR='1' THEN SUM(A.DETOT)-SUM(A.CRTOT) ELSE SUM(A.CRTOT)-SUM(A.DETOT) END AMT \n " );
					sql.append( "  		FROM ACCOUNT.MFSREFTOT A                                   												\n " );
					sql.append( "  		LEFT JOIN ACCOUNT.ACTCODE B ON A.ATCODE = B.ATCODE                         				\n " );
					sql.append( "  		LEFT JOIN ACCOUNT.COMMDTIL C ON C.CDCODE = A.FSREFVAL AND C.CMTYPE='0030'   \n " );
					sql.append( "  		LEFT JOIN ACCOUNT.RPTPRTACT F ON B.ATCODE = F.ATCODE                        				\n " );
					sql.append( "  	 WHERE A.ATCODE LIKE '43%'                                                                          				\n " );
					sql.append( "  		 AND A.FSREFCD ='0030'                                                                            				\n " );
					if(!str[0].equals(""))sql.append( "  AND A.FDCODE ='"+str[0]+"'      					                                        \n " );
					if(!str[1].equals("")&&!str[2].equals("")) sql.append( " AND A.ACTYYMM BETWEEN '"+str[1]+"' AND '"+str[2]+"'    \n " );					
					if(!str[3].equals(""))sql.append( " AND C.GBCD='"+str[3]+"'                                                                   		\n " );					
					if(!str[4].equals(""))sql.append( " AND A.FSREFVAL ='"+str[4]+"'                                                               \n " );					
					sql.append( "  		 AND B.ATUSEYN='Y'                                                                                				\n " );
					sql.append( "  		 AND A.ATCODE = F.ATCODE                                                                          			\n " );
					sql.append( "  		 AND F.PRTCODE='08'                                                                               				\n " );
					sql.append( "  	 GROUP BY A.ATCODE,A.ACTYYMM, F.PRTNAM,F.PRTSEQ,B.ATDECR, A.FSREFVAL,C.CDNAM    \n " );
					sql.append( "  	) X                                                                                                 								\n " );
					sql.append( "  GROUP BY X.ATCODE,X.PRTNAM,X.FSREFVAL, X.FSREFNM,X.PRTSEQ                                   \n " );
					sql.append( "  ORDER BY X.PRTSEQ                                                                                     					\n " );
					
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