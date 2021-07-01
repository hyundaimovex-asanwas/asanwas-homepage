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
public class a030004_s2 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1"); //지점
				String  str2    = req.getParameter("v_str2"); //년도
				String  str3    = req.getParameter("v_str3"); //기간 from 하루 전
				String  str4    = req.getParameter("v_str4"); //기간 from
				String  str5    = req.getParameter("v_str5"); //기간 to

				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";
				if(str3 == null) str3 = "";
				if(str4 == null) str4 = "";
				if(str5 == null) str5 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "FDCODE", "FSDAT", "FSNBR", "FSSEQ", "ATCODE" ,"ATKORNAM", "FSDATNBR"
												
				}; 

				int[] intArrCN = new int[]{  2, 9, 6, 5, 7,66, 15
											
				}; 
			
				int[] intArrCN2 = new int[]{  -1, -1, -1, -1, -1, -1, -1
										
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				}
				
				if (!GauceReq.isBuilderRequest()) {
					StringBuffer sql = new StringBuffer();
					 
					sql.append( " SELECT  DISTINCT A.FDCODE, A.FSDAT, A.FSNBR, MIN(A.FSSEQ)FSSEQ, MAX(A.ATCODE)ATCODE,  A.FSDAT||A.FSNBR FSDATNBR , D.ATKORNAM \n" );
					sql.append( "   FROM ACCOUNT.GENENLED A                                                             \n" );
					sql.append( "   RIGHT JOIN (SELECT DISTINCT C.FDCODE, C.FSDAT, C.FSNBR                             	\n" );
					sql.append( "                FROM ACCOUNT.GENENLED C                                               	\n" );
					sql.append( "               WHERE C.FDCODE ='"+str1+"'                                             	\n" );
					sql.append( "                 AND C.ATCODE IN ('1110110', '1110120')                               	\n" );
					sql.append( "                 AND C.ACTDAT BETWEEN '"+str4+"' AND '"+str5+"'                       	\n" );
					sql.append( "               )B ON A.FDCODE = B.FDCODE AND A.FSDAT = B.FSDAT AND A.FSNBR = B.FSNBR   \n" );
					sql.append( "   LEFT JOIN ACCOUNT.ACTCODE D ON A.ATCODE = D.ATCODE  							    \n" );
					sql.append( "  WHERE A.FDCODE ='"+str1+"'                                                          	\n" );
					if(str1.equals("03"))sql.append( "  AND A.ATCODE NOT IN ('1110120')                                 \n" );
					else sql.append( "  AND A.ATCODE NOT IN ('1110110')                                					\n" );
					sql.append( "    AND A.ACTDAT BETWEEN '"+str4+"' AND '"+str5+"'                                 	\n" );
					sql.append( "  GROUP BY A.FDCODE, A.FSDAT, A.FSNBR,A.FSDAT||A.FSNBR ,D.ATKORNAM                     \n" );
					sql.append( "  ORDER BY A.FSDAT,A.FSNBR, FSSEQ                    									\n" );			
				
					//logger.dbg.println(this,sql.toString());

					//System.out.println("a030004_s2:"+sql.toString()); 
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