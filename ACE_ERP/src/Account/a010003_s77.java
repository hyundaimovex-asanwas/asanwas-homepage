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
public class a010003_s77 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1"); //거래처 코드 
				String  str2	= req.getParameter("v_str2"); //거래처명
				String  str3	= req.getParameter("v_str3"); //사업자등록번호 
				String  str4	= req.getParameter("v_str4"); //담다자명
				String  str5	= req.getParameter("v_str5"); //사용구분 

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
	
					
				GauceRes.enableFirstRow(dSet);
	
				String[] strArrCN = new String[]{ "SEQ",   "VEND_CD",  "VEND_NM",  "VEND_ID",	 "EMPNM",   
												  "DEPTNM", "EMAIL",   "HPNO",    "TELNO", 
												  "USEGB",  "VEND_ID_LEN",
												  "BSNS_CND","BSNS_KND","ADDRESS1","ADDRESS2","VD_DIRECT",
												  "ORI_VEND_I", "COCOMYN", "CREDGB", 
												}; 

				int[] intArrCN = new int[]{ 2, 13, 62, 15, 30,
											30, 40, 15, 15,
											 1,  2,  
											30, 30, 132, 72, 62,
											15,  1,  1
				                            }; 

				int[] intArrCN2 = new int[]{  0, -1, -1, -1, -1,
											  -1, -1, -1, -1,
											  -1, -1,  
											  -1, -1, -1, -1, -1,
											  -1, -1, -1
			                             	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT C.SEQ, RTRIM(C.VEND_CD) VEND_CD, RTRIM(G.VEND_NM) VEND_NM, C.VEND_ID,   	\n");
					
					sql.append( "		 C.EMPNM, C.DEPTNM, C.EMAIL,    		        			                \n");
					sql.append( "		 C.HPNO, C.TELNO, C.USEGB, LENGTH(C.VEND_ID) VEND_ID_LEN,     				\n");
					sql.append( "		 G.BSNS_CND,  G.BSNS_KND,  G.ADDRESS1, G.ADDRESS2, G.VD_DIRECT,				\n");
					sql.append( "		 G.VEND_ID ORI_VEND_I, G.COCOMYN, T.CREDGB                     				\n");
					sql.append( "   FROM ACCOUNT.CUSTOMER C, ACCOUNT.GCZM_VENDER G 							        \n");
					sql.append( "   LEFT JOIN ( SELECT U.VEND_CD, MAX(U.CREDGB)CREDGB                               \n");
					sql.append( "                 FROM ACCOUNT.BOND_ATTACH U                                        \n");
					sql.append( "                WHERE U.CREDGB IN ('1','2')                                        \n");
					sql.append( "                GROUP BY U.VEND_CD ) T ON G.VEND_CD = T.VEND_CD                    \n");
					sql.append( "  WHERE C.VEND_CD = G.VEND_CD 														\n");
					sql.append( "    AND C.VEND_CD IS NOT NULL														\n");
					sql.append( "    AND C.STATUS ='Y'														        \n"); // 결재완료건.
					if (!str1.equals("")) sql.append( " AND C.VEND_CD LIKE '%" + str1 + "%'							\n");
					if (!str2.equals("")) sql.append( " AND G.VEND_NM LIKE '%" + str2 + "%'							\n");
					if (!str3.equals("")) sql.append( " AND C.VEND_ID LIKE '%" + str3 + "%'							\n");
					if (!str4.equals("")) sql.append( " AND C.EMPNM LIKE   '%" + str4 + "%'							\n");
					if (!str5.equals("")) sql.append( " AND C.USEGB = '"+str5+"'									\n");
					
					//System.out.println("a010003_s77"+sql.toString());
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