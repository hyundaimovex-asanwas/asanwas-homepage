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
public class a400310_s3 extends HttpServlet {
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
				String []  str	= new String [2];
				str[0] = req.getParameter("v_str1");	//지점코드
				str[1] = req.getParameter("v_str2");	//신청번호
			 
				for(int i=0;i<=1;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
						 "APPNO",    "PURGB",    "PAYGB",  
						 "OUTAMT",   "SUPAMT",   "SUPVATAMT", "XSUPAMT", 
						 "FOUTAMT",  "XFOUTAMT"
				}; 

				int[] intArrCN = new int[] { 
					     14,   1,   1,   
					     15,  15,  13,  15,
					     15,  15
				};      
			
				int[] intArrCN2 = new int[]{ 
						 -1, -1, -1,
						  0,  0,  0,  0,
						  2,  2
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						
						sql.append( "  SELECT A.APPNO,                                                \n");
						sql.append( "         A.PURGB,  A.PAYGB,                                      \n");
						sql.append( "         A.OUTAMT, A.SUPAMT, A.SUPVATAMT, X.XSUPAMT,             \n");
						sql.append( "         A.FOUTAMT, X.XFOUTAMT                                   \n");
						sql.append( "    FROM ACCOUNT.ACAPPFUND A,                                    \n");
						sql.append( "         ( SELECT B.APPNO,                                       \n");
						sql.append( "                  SUM(B.SUPAMT) XSUPAMT, SUM(B.FOUTAMT) XFOUTAMT \n");
						sql.append( "             FROM ACCOUNT.ACAPPCOST B                            \n");
						sql.append( "            WHERE B.FDCODE = '"+str[0]+"'                        \n");
						sql.append( "              AND B.APPNO IN ("+str[1]+")                        \n");
						sql.append( "            GROUP BY B.APPNO                                     \n");
						sql.append( "         ) X                                                     \n");
						sql.append( "   WHERE A.APPNO = X.APPNO                                       \n");
						sql.append( "     AND A.FDCODE= '"+str[0]+"'                                  \n");
						sql.append( "     AND A.APPNO IN ("+str[1]+")                                 \n");
						sql.append( "   ORDER BY A.APPNO                                              \n");
						
					    //System.out.println("# a400310_s3 Query : \n" + sql);
						
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