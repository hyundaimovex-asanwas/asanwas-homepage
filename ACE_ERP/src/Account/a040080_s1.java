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
public class a040080_s1 extends HttpServlet {
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
				String []  str	= new String [6];
				str[0] = req.getParameter("v_str1");		//지점
				str[1] = req.getParameter("v_str2");		//사번 
				str[2] = req.getParameter("v_str3");		//검수기간 FR
				str[3] = req.getParameter("v_str4");		//검수기간 TO
				str[4] = req.getParameter("v_str5");		//거래처코드 
				str[5] = req.getParameter("v_str6");		//거래처명
				
				
				for (int s=0;s<=5;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"CHK", "VEND_CD" , "VEND_NM" ,"RQST_NO", "CON_NO" ,
					"PU_SITE_NM", "DATE_CGC", "DATE_CGCD", "CGCD_NOW_AMT",
					"CGCD_SID","CON_SID"
				}; 

				int[] intArrCN = new int[] { 
					 1,  13 ,   60 ,  14,   9 , 
					50,   8,    8,   15,
					10,  10
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1 ,  -1,  -1,  -1, 
					-1,  -1,  -1,   0,
					0, 0
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( "  SELECT 'F' AS CHK, A.VEND_CD, G.VEND_NM, C.RQST_NO, A.CON_NO,        \n");
					sql.append( "                D.PU_SITE_NM, E.DATE_CGC, E.DATE_CGCD, E.CGCD_NOW_AMT,  \n");
					sql.append( "               E.CGCD_SID, A.CON_SID                                                                   \n");
					sql.append( "     FROM PMS.TPU410 A                                                                               \n");
					sql.append( "      LEFT JOIN (  SELECT M1.CON_SID, M1.DATE_CGC, M2.DATE_CGCD,                \n");
					sql.append( "                               M2.CGCD_SID,                                                                  \n");
					sql.append( "                               SUM(M2.CGCD_NOW_AMT)CGCD_NOW_AMT                   \n");
					sql.append( "                     FROM PMS.TPU510 M1, PMS.TPU520 M2                                   \n");
					sql.append( "                   WHERE M1.CGC_SID = M2.CGC_SID                                             \n");
					sql.append( "                        AND M2.PUB_TAX_YN = 'N'                                                      \n");
					sql.append( "  		                 AND M2.DATE_CGCD BETWEEN '"+str[2]+"'  AND '"+str[3]+"'  \n");
					sql.append( "                   GROUP BY M1.CON_SID, M1.DATE_CGC, M2.DATE_CGCD,            \n");
					sql.append( "                                     M2.CGCD_SID                                                             \n");
					sql.append( "                ) E  ON A.CON_SID = E.CON_SID                                                           \n");
					sql.append( "      LEFT JOIN PMS.TPU210 B ON A.EST_SID  = B.EST_SID                              \n");
					sql.append( "      LEFT JOIN PMS.TPU110 C ON B.RQST_SID = C.RQST_SID                         \n");
					sql.append( "      LEFT JOIN PMS.TSY110 D ON C.SITE_SID = D.SITE_SID                             \n");
					sql.append( "      LEFT JOIN ACCOUNT.GCZM_VENDER G ON G.VEND_CD = A.VEND_CD      \n");
					sql.append( "   WHERE E.CGCD_NOW_AMT<>0                                                                    \n");
					if (!str[1].equals("")) sql.append( "  AND A.U_EMPNO = '"+str[1]+"'                                    \n");
					if (!str[2].equals("")&&!str[3].equals("")) {
						sql.append( "    AND E.DATE_CGCD BETWEEN '"+str[2]+"' AND '"+str[3]+"'                     \n");
			    	}
			    	if (!str[4].equals("")) sql.append( "  AND A.VEND_CD = '"+str[4]+"'                                    \n");
			    	if (!str[5].equals("")) sql.append( "  AND G.VEND_NM  LIKE  '%"+str[5]+"%'                       \n");
									
			    	//System.out.println("# Query : \n" + sql);
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