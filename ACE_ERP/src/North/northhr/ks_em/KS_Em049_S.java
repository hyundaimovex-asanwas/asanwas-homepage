package North.northhr.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class KS_Em049_S extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1"); if (str1 == null) { str1 = ""; } //급여년월
				String  str2	= req.getParameter("v_str2"); if (str2 == null) { str2 = ""; } //지급구분

				
								
				GauceRes.enableFirstRow(dSet);


				String[] strArrCN = new String[]{ "APPDT", "PAYDIV",  "PAYDT",  "PBDIV",   "PAYCD", "PAY_NM", 
					                                "FRDT",  "FRTM",    "TODT",   "TOTM",    "WRKSTS",
					                                "MEMO",  "I_EMPNO", "I_DATE", "U_EMPNO", "U_DATE"
				};  

				int[] intArrCN = new int[]{ 6, 1, 8, 1, 8, 50,
					                          8, 6, 8, 6, 1,
					                        100,10,10,10,10
				}; 
					
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1,
				                             -1, -1, -1, -1, -1,
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

						sql.append( "	SELECT A.APPDT,   A.PAYDIV,  A.PAYDT,   A.PBDIV,   A.PAYCD,  RTRIM(B.DETAIL_NM) AS PAY_NM,                  			\n");
						sql.append( "	       A.FRDT,    A.FRTM,    A.TODT,    A.TOTM,    A.WRKSTS,																				\n");
						sql.append( "	       A.MEMO,    A.I_EMPNO, A.I_DATE,  A.U_EMPNO, A.U_DATE                                                 							\n");
						sql.append( "	  FROM ATP.KST299 A																																		\n");
						sql.append( "	  LEFT JOIN ATP.TSY010 B ON RTRIM(B.DETAIL) = RTRIM(A.PAYCD) AND B.HEAD='KS025' AND RTRIM(B.DETAIL) IS NOT NULL    \n");
						sql.append( "	 WHERE 1=1                                                                                                  	\n");
						if(!str1.equals(""))sql.append( "	  AND A.APPDT = '"+str1+"'														\n");
						if(!str2.equals(""))sql.append( "	  AND A.PAYDIV = '"+str2+"'														\n");
						
						//logger.dbg.println(this,sql.toString());
					
						stmt = conn.getGauceStatement(sql.toString());
  	 					stmt.executeQuery(dSet);
  	 					
					}
				 
/*********************************************************************************************/

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