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
public class a020010_s1 extends HttpServlet {
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
				String [] str = new String [7];
				str[0]	= req.getParameter("v_str1");		//지점                  
				str[1]	= req.getParameter("v_str2");		//기간fr            
				str[2]	= req.getParameter("v_str3");		//기간to            
				str[3]	= req.getParameter("v_str4");		//계정FR    
				str[4]	= req.getParameter("v_str5");		//계정TO
				str[5]	= req.getParameter("v_str6");		//거래처FR
				str[6]	= req.getParameter("v_str7");		//거래처TO
				
				
				for (int s=0;s<=6;s++) {
					if (str[s]==null) str[s] = "";
				}

				
		
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "FDCODE","FDNAME","ATCODE","ATKORNAM", "VENDCD","VEND_NM",
					                                "FSREFCD","FSREFVAL","CDNAM",
					                                "DEAMT","CRAMT","JANAMT",
					                                "STATUS","SSDAT","SSNBR","SSDATNBR","REMARK"
				}; 

				int[] intArrCN = new int[]{  2, 20, 7, 66, 13, 62, 
					                           4, 20,40, 
					                          15, 15,15,
					                           1,  9, 6, 16, 132
				}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1, 
					                           -1, -1, -1, 
					                            0,  0,  0, 
					                            -1, -1, -1, -1, -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT A.FDCODE, B.FDNAME, A.ATCODE, C.ATKORNAM, A.VENDCD, D.VEND_NM,            	\n " );
					sql.append( "         A.FSREFCD,  A.FSREFVAL, E.CDNAM,                                          							\n " );
					sql.append( "         A.DEAMT,   A.CRAMT,                                                       										\n " );
					sql.append( "         CASE WHEN C.ATDECR='1' THEN COALESCE(A.DEAMT,0) - COALESCE(A.CRAMT,0)     \n " );
					sql.append( "              ELSE COALESCE(A.CRAMT,0) - COALESCE(A.DEAMT,0) END JANAMT,           			\n " );  
 					sql.append( "         A.STATUS,   A.SSDAT,  A.SSNBR, A.SSDAT||'-'||A.SSNBR SSDATNBR, A.REMARK   		\n " );  
					sql.append( "    FROM ACCOUNT.BANJAEMST A                                                       								\n " );  
					sql.append( "    LEFT JOIN ACCOUNT.FIELDCODE B ON A.FDCODE = B.FDCODE                           				\n " ); 
					sql.append( "    LEFT JOIN ACCOUNT.ACTCODE C ON A.ATCODE =C.ATCODE                              				\n " );
					sql.append( "    LEFT JOIN ACCOUNT.GCZM_VENDER D ON A.VENDCD =D.VEND_CD                         			\n " );
					sql.append( "    LEFT JOIN ACCOUNT.COMMDTIL E ON A.FSREFVAL = E.CDCODE AND A.FSREFCD = E.CMTYPE \n " );
					sql.append( "    \n " );  

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