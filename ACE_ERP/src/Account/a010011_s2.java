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
public class a010011_s2 extends HttpServlet {
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

				String  str1	= req.getParameter("v_str1");    //자산중분류     
				String  str2	= req.getParameter("v_str2");    //자산소분류
				String  str3	= req.getParameter("v_str3");    //자산명
				String  str4	= req.getParameter("v_str4");    //사용유무
			
				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";

				GauceRes.enableFirstRow(dSet);


				String[] strArrCN = new String[]{   "AST2ND",  "AST2NDNM",   "AST3RD",	   "AST3RDNM",  
													"ASTCD",   "ASTNM",      "ASTUSEDT",   "ASTCLSDT",   "ASTUSEYN",
					                                 "I_EMPNO", "U_EMPNO"
																				}; 												
 
				int[] intArrCN = new int[]{ 2, 60, 2, 60, 
					                          5, 100, 8,  8,  1,
					                          7,  7
				                          }; 
					
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1,
					                           -1, -1
					                         }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();
					
					sql.append( " SELECT A.AST2ND,   B.CDNAM AS AST2NDNM,   A.AST3RD,   C.CDNAM AS AST3RDNM,  	\n");
					sql.append( " 	     A.ASTCD,    A.ASTNM,   A.ASTUSEDT, A.ASTCLSDT, A.ASTUSEYN,           					\n");
					sql.append( " 	     ''I_EMPNO,  '' U_EMPNO                                               										\n");
					sql.append( "   FROM ACCOUNT.ASTNAME A                                                    								\n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL B ON A.AST2ND =B.CDCODE AND B.CMTYPE='2101'    	\n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL C ON A.AST3RD =C.CDCODE AND C.CMTYPE='2141'    	\n");
					sql.append( "  WHERE 1=1 																											\n");
					if (!str1.equals(""))  sql.append( "  AND  A.AST2ND = '"+str1+"'  															\n");
					if (!str2.equals(""))  sql.append( "  AND  A.AST3RD = '"+str2+"'  															\n");
					if (!str3.equals(""))  sql.append( "  AND  A.ASTNM  LIKE '%"+str3+"%'  													\n");
					if (!str4.equals(""))  sql.append( "  AND  A.ASTUSEYN = '"+str4+"'  														\n");
					sql.append( "	 ORDER BY A.AST2ND, A.AST3RD, A.ASTCD   																\n");	

					// logger.dbg.println( this, sql.toString() );
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