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
public class a010010_s1 extends HttpServlet {
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
				// 전체조회
				
				String  str1  = req.getParameter("v_str1");  //성명
				String  str2  = req.getParameter("v_str2");  //사번
				String  str3  = req.getParameter("v_str3");  //화면명(PGMID)
				String  str4  = req.getParameter("v_str4");  //사용유뮤
				
				if(str1 == null) str1 = "";    
				if(str2 == null) str2 = "";    
				if(str3 == null) str3 = "";    
				if(str4 == null) str4 = "";    

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{   "RPGMID",   "PGMNM",	  "EMPNO",	  "EMPNMK",	  "AUTHGR",	            
        											"DEPTCD1",	"DEPTCD2",	"DEPTCD3",	"DEPTCD4",	          
													"DEPTCD5",	"DEPTCD6",	"DEPTCD7",	"DEPTCD8",	"DEPTCD9",
                                                    "DEPTCD10",	"DEPTCD11",	"DEPTCD12",	"DEPTCD13",	"DEPTCD14",
					                                "DEPTCD15",	"DEPTCD16",	"DEPTCD17",	"DEPTCD18",	"DEPTCD19", "DEPTCD20",
													"PEMPNO1",	"PEMPNO2",	"PEMPNO3",	"PEMPNO4",	"PEMPNO5",
					                                "ETC1",	    "ETC2",	    "ETC3",	    "ETC4",	    "ETC5", 
					                                "USEYN",    "PGMID"
				}; 

				int[] intArrCN = new int[]{ 10, 40, 7,  20, 1, 
				                              4,  4,  4,  4, 
					                          4,  4,  4,  4,  4,
					                          4,  4,  4,  4,  4, 
                                              4,  4,  4,  4,  4,  4,
					                          7,  7,  7,  7,  7,
					                          10, 10, 10, 10, 10,
					                          1,  10
 				}; 
			
				int[] intArrCN2 = new int[]{  -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1, 
					                           -1, -1, -1, -1, -1,
                                               -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1, -1, 
											   -1, -1, -1, -1, -1,
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
						
					sql.append(" SELECT A.RPGMID ,   C.PGMNM,      A.EMPNO,      B.EMPNMK ,    A.AUTHGR , \n ");
					sql.append("        COALESCE(A.DEPTCD1,'')DEPTCD1,   COALESCE(A.DEPTCD2,'')DEPTCD2,   \n ");
					sql.append("        COALESCE(A.DEPTCD3,'')DEPTCD3,   COALESCE(A.DEPTCD4,'')DEPTCD4,   \n ");
					sql.append("        COALESCE(A.DEPTCD5,'')DEPTCD5,   COALESCE(A.DEPTCD6,'')DEPTCD6,   \n ");
					sql.append("        COALESCE(A.DEPTCD7,'')DEPTCD7,   COALESCE(A.DEPTCD8,'')DEPTCD8,   \n ");
					sql.append("        COALESCE(A.DEPTCD9,'')DEPTCD9,   COALESCE(A.DEPTCD10,'')DEPTCD10, \n ");
					sql.append("        COALESCE(A.DEPTCD11,'')DEPTCD11, COALESCE(A.DEPTCD12,'')DEPTCD12, \n ");
					sql.append("        COALESCE(A.DEPTCD13,'')DEPTCD13, COALESCE(A.DEPTCD14,'')DEPTCD14, \n ");
					sql.append("        COALESCE(A.DEPTCD15,'')DEPTCD15, COALESCE(A.DEPTCD16,'')DEPTCD16, \n ");
					sql.append("        COALESCE(A.DEPTCD17,'')DEPTCD17, COALESCE(A.DEPTCD18,'')DEPTCD18, \n ");
					sql.append("        COALESCE(A.DEPTCD19,'')DEPTCD19, COALESCE(A.DEPTCD20,'')DEPTCD20, \n ");
					sql.append("        COALESCE(A.PEMPNO1,'')PEMPNO1,   COALESCE(A.PEMPNO2,'')PEMPNO2,   \n ");
					sql.append("        COALESCE(A.PEMPNO3,'')PEMPNO3,   COALESCE(A.PEMPNO4,'')PEMPNO4,   \n ");
					sql.append("        COALESCE(A.PEMPNO5,'')PEMPNO5,                                    \n ");
					sql.append("        COALESCE(A.ETC1,'')ETC1,         COALESCE(A.ETC2,'')ETC2,         \n ");
					sql.append("        COALESCE(A.ETC3,'')ETC3,         COALESCE(A.ETC4,'')ETC4,         \n ");
					sql.append("        COALESCE(A.ETC5,'')ETC5,                                          \n ");
					sql.append("        A.USEYN, A.PGMID                                                  \n ");
					sql.append("   FROM ACCOUNT.ACCAUTH A, PAYROLL.YIPERSON B ,COMMON.MENU_DETAIL C       \n ");
					//sql.append("   LEFT JOIN COMMON.PROGRAM C ON A.PGMID = C.PGMID                          \n ");
					sql.append("  WHERE A.EMPNO = B.EMPNO                                                 \n ");
					sql.append("    AND B.USESTS IN ('1','2','3')                                         \n ");
					sql.append("    AND UPPER(A.RPGMID) = UPPER(C.RPGMID(+))                              \n ");
					if(!str1.equals(""))sql.append("  AND B.EMPNMK = '"+str1+"' \n ");
					if(!str2.equals(""))sql.append("  AND A.EMPNO =  '"+str2+"' \n ");
					if(!str3.equals(""))sql.append("  AND UPPER(A.PGMID) =  UPPER('"+str3+"') \n ");
					if(!str4.equals(""))sql.append("  AND A.USEYN =  '"+str4+"' \n ");
						              				
					//System.out.println("a010010_s1::"+sql.toString());
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