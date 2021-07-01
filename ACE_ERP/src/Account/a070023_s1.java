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
public class a070023_s1 extends HttpServlet {
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

				String  str1 = req.getParameter("v_str1");    //채권구분 A, 1, 3, 4
				String  str2 = req.getParameter("v_str2");    //거래처명
				String  str3 = req.getParameter("v_str3");    //거래처코드
				String  str4 = req.getParameter("v_str4");    //거래처코드
				String  str5 = req.getParameter("v_str5");    //거래처코드


				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				
		
				GauceRes.enableFirstRow(dSet);				

				String[] strArrCN = new String[]{"VEND_CD",      "VEND_SEQ",  "VEND_NM",      "VEND_ID",        "CREDITOR",   "DEMAMT",
				                                                 	 "RECDAT",        "DEPDAT",      "CANDAT",         "CREDGB",      "REMARK",
					                                                 "I_EMPNO",       "I_DATE",       "U_EMPNO",      "U_DATE", 
					                                                }; 

				int[] intArrCN = new int[]{ 13 ,   3,    62,     15,   100,  15,
					                                         8 ,    8,     8,       1,     32, 
					                                        10,   10,   10,     10
					                                    
					                                     }; 
					
				int[] intArrCN2 = new int[]{ -1,-1, -1,-1,-1, 0,
															 -1,-1,-1,-1,-1,
															 -1 ,-1,-1,-1
				                                           };  				                                           

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();
					 
					sql.append( " SELECT VEND_CD, VEND_SEQ,   VEND_NM, VEND_ID, CREDITOR, DEMAMT, \n");
					sql.append( "        RTRIM(RECDAT)RECDAT,  RTRIM(DEPDAT)DEPDAT,  RTRIM(CANDAT)CANDAT,  CREDGB,   REMARK,   	\n");
					sql.append( "               I_EMPNO, I_DATE,  U_EMPNO, U_DATE                      \n");
					sql.append( "    FROM ACCOUNT.BOND_ATTACH                                           \n");
					sql.append( "  WHERE 1=1																			\n");									
					if (str1.equals("1"))         sql.append( " AND CREDGB IN ('1','2')                     \n");
					else if (str1.equals("3"))sql.append( " AND CREDGB ='"+str1+"'                      	\n");
					else if (str1.equals("4"))sql.append( " AND CREDGB ='"+str1+"'                      	\n");	
					if (!str2.equals(""))          sql.append( " AND VEND_NM LIKE '%"+str2+"%'        	\n");
					if (!str3.equals(""))          sql.append( " AND VEND_CD = '"+str3+"'                   	\n");	
					
					sql.append( "  AND RECDAT BETWEEN  '"+str4+"'  AND   '"+str5+"'               	\n");
					sql.append( "  ORDER BY VEND_NM, RECDAT, VEND_SEQ \n");	

					//System.out.println("a070023_s1::"+sql.toString());
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