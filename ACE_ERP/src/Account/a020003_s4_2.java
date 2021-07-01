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
public class a020003_s4_2 extends HttpServlet {
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
			  
				String [] str = new String [4];
				str[0]	= req.getParameter("v_str1");		//지점
				str[1]	= req.getParameter("v_str2");		//원전표 접수일자
				str[2]	= req.getParameter("v_str3");		//원전표 접수번호
				str[3]	= req.getParameter("v_str4");		//원전표 접수행번호
		
		
       
				for (int s=0;s<=3;s++) {
					if(str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "SSDAT", "SSNBR", "SSDATNBR",  "FSNUM",   "CHAAMT",
					                                "DAEAMT",  "JANAMT",  "REMARK",
					                                "DEPTCD",  "DEPTNM", "VENDCD", "VENDNM",  "FSREFCD",
					                                "FSREFVAL","FSREFNM", "FSREFCD2","FSREFVAL2","FSREFNM2"
				                 
				                                }; 
	

				int[] intArrCN = new int[]{  9,  6, 16,  2,  15,
					                          15, 15, 132,
					                           4, 50, 13, 62,   4,
					                          20, 40, 4,  30, 40
					                         }; 
			
				int[] intArrCN2 = new int[]{ -1,-1,-1,-1,  0, 
					                            0, 0, -1,
					                           -1,-1,-1,-1,-1,
					                           -1,-1,-1,-1,-1  
					                         }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
								
					sql.append( " SELECT A.SSDAT, A.SSNBR, A.SSDAT||'-'||A.SSNBR SSDATNBR, A.FSNUM,                      \n" );
					sql.append( "        A.DEAMT CHAAMT,   A.CRAMT DAEAMT,                                               \n" );
					sql.append( "        CASE WHEN B.ATDECR ='1' THEN COALESCE(A.DEAMT,0)-COALESCE(A.CRAMT,0)            \n" );
					sql.append( "             WHEN B.ATDECR ='2' THEN COALESCE(A.CRAMT,0)-COALESCE(A.DEAMT,0) END JANAMT,\n" );
					sql.append( "        A.REMARK, A.DEPTCD, C.DEPTNM, A.VENDCD, D.VEND_NM VENDNM,                       \n" );
					sql.append( "        A.FSREFCD, A.FSREFVAL, E.CDNAM FSREFNM,                                         \n" );
					sql.append( "        A.FSREFCD2, A.FSREFVAL2, F.CDNAM FSREFNM2,                                      \n" );
					sql.append( "        A.STATUS                                                                        \n" );
					sql.append( "   FROM ACCOUNT.BANJAEMST A                                                             \n" );
					sql.append( "   LEFT JOIN ACCOUNT.ACTCODE B ON A.ATCODE = B.ATCODE                                   \n" );
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT C ON A.DEPTCD = C.DEPTCD                                    \n" );
					sql.append( "   LEFT JOIN ACCOUNT.GCZM_VENDER D ON A.VENDCD = D.VEND_CD                              \n" );
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL E ON A.FSREFVAL = E.CDCODE AND E.CMTYPE=A.FSREFCD         \n" );
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL F ON A.FSREFVAL = F.CDCODE AND F.CMTYPE=A.FSREFCD2        \n" );				
					sql.append( "  WHERE A.FDCODE = '"+str[0]+"'                                               \n" );
					sql.append( "    AND A.TSDAT = '"+str[1]+"'                                               \n" );
					sql.append( "    AND A.TSNBR = '"+str[2]+"'                                               \n" );
					sql.append( "    AND A.TSSEQ = '"+str[3]+"'                                                \n" );
					
					System.out.println("a020003_s4:\n"+sql.toString());					
					//logger.dbg.println(this , sql.toString());
					
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