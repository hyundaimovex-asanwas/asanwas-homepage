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
public class a070022_s2 extends HttpServlet {
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

				String  str1 = req.getParameter("v_str1");    //지점
				String  str2 = req.getParameter("v_str2");    //회계년월
				String  str3 = req.getParameter("v_str3");    //지급일자FR
				String  str4 = req.getParameter("v_str4");    //지급일자TO
				String  str5 = req.getParameter("v_str5");    //지급구분  1 현금,  2 어음 
				String  str6 = req.getParameter("v_str6");    //회계년월 to


				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
		
				GauceRes.enableFirstRow(dSet);				

				String[] strArrCN = new String[]{
                                                	"GUBUN",        "VENDCD",   "VENDNM",     "VEND_ID",   "VENDID", 
                                             	    "BANKCD",      "BANNAM",   "ACCTNO",     "JANAMT",    "FULDAT", "EMPNMK", "ACCTNM","PAYDAT"
                                                }; 

				int[] intArrCN = new int[]{ 
		                                        5 ,  7,  66, 13,  15, 
		                                        6,  32, 22,  15, 8,  32, 21,8
		                                     }; 
					
				int[] intArrCN2 = new int[]{
											 -1,-1,-1,-1,-1,
	                                         -1,-1,-1, 0, -1, -1, -1,-1
                                           };  				                                           

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();
					 
					sql.append( "  SELECT CASE WHEN A.CHKCASH='T' THEN '현금'                                               			\n");
					sql.append( "              WHEN A.CHKBILL='T' THEN '어음' END GUBUN,                            			\n");
					sql.append( "         A.VENDCD, C.VEND_NM AS VENDNM,                                                    			\n");
					sql.append( "         C.VEND_ID,                                                                                            		\n");
					sql.append( "         CASE WHEN LENGTH(C.VEND_ID)=10 THEN SUBSTR(VEND_ID,1,3)||'-'||SUBSTR(VEND_ID,4,2)||'-'||SUBSTR(VEND_ID,6,5) \n");
					sql.append( "              WHEN LENGTH(C.VEND_ID)=13 THEN SUBSTR(VEND_ID,1,6)||'-'||SUBSTR(VEND_ID,7,7)                           \n");
					sql.append( "         END  VENDID,                                                                                               \n");
					sql.append( "         MAX(CASE WHEN A.CHKCASH='T' THEN  C.C_BANKCD                                   	\n");
					sql.append( "                  WHEN A.CHKBILL='T' THEN  C.B_BANKCD ELSE '' END) BANKCD, 		\n");
					sql.append( "         MAX(CASE WHEN A.CHKCASH='T' THEN  D.BANNAM                                       	\n");
					sql.append( "                  WHEN A.CHKBILL='T' THEN  E.BANNAM ELSE '' END) BANNAM,     		\n");
					sql.append( "         MAX(CASE WHEN A.CHKCASH='T' THEN  C.C_ACCTNO                                   	\n");
					sql.append( "                  WHEN A.CHKBILL='T' THEN  C.B_ACCTNO ELSE '' END) ACCTNO, 		\n");
					sql.append( "         SUM(A.JANAMT) JANAMT,   RTRIM(A.FULDAT)FULDAT ,                												\n");
					sql.append( "         MAX(ASNHR.SF_GET_ENONAME('01',X.EMPNO )) EMPNMK,              					\n");					
					sql.append( "         MAX(CASE WHEN A.CHKCASH='T' THEN  C.C_ACCTNM                                   	\n");
					sql.append( "                  WHEN A.CHKBILL='T' THEN  C.B_ACCTNM ELSE '' END) ACCTNM, 		\n");
					sql.append( "         MAX(PAYDAT) PAYDAT 																					\n");
					sql.append( "    FROM ACCOUNT.ACUSTPAY A                                                                              		\n");
					sql.append( "    LEFT JOIN ACCOUNT.GCZM_VENDER C ON A.VENDCD = C.VEND_CD                    				\n");
					sql.append( "    LEFT JOIN ACCOUNT.BANKCODE D ON C.C_BANKCD = D.BANCOD                        				\n");
					sql.append( "    LEFT JOIN ACCOUNT.BANKCODE E ON C.B_BANKCD = E.BANCOD                         			\n");
					sql.append( "    LEFT JOIN ( SELECT D.VENDCD, MAX(F.EMPNO) EMPNO                                    				\n");
					sql.append( "                          FROM ACCOUNT.ACUSTPAY D, ACCOUNT.FSLIPMST F                          	\n");
					sql.append( "                       WHERE 1=1                                                             								\n");
					sql.append( "                            AND D.FDCODE = F.FDCODE                                          						\n");
					sql.append( "                            AND D.TSDAT = F.FSDAT                                               						\n");
					sql.append( "                            AND D.TSNBR = F.FSNBR                                               						\n");
					if (str5.equals("1"))sql.append( "  AND D.CHKCASH ='T'                                                  						\n");
					if (str5.equals("2"))sql.append( "  AND D.CHKBILL ='T'                                                    						\n");
					sql.append( "                            AND D.FDCODE ='"+str1+"'                                              						\n");
					sql.append( "                            AND (D.ACTDAT LIKE '"+str2+"%' OR D.ACTDAT LIKE '"+str6+"%' )                                    						\n");
					sql.append( "                            AND D.PAYDAT BETWEEN'"+str3+"' AND '"+str4+"'           							\n");
					sql.append( "                       GROUP BY D.VENDCD,D.FULDAT, D.CHKCASH, D.CHKBILL  							\n");
					sql.append( "                   ) X ON X.VENDCD = A.VENDCD                                                						\n");
					sql.append( "  LEFT JOIN PAYROLL.YIPERSON Y ON X.EMPNO = Y.EMPNO AND Y.USESTS IN ('1','2','3')   	\n");
					sql.append( "   WHERE 1=1                                                                                          						\n");
					if (str5.equals("1"))sql.append( " AND A.CHKCASH ='T'                                                							\n");
					if (str5.equals("2"))sql.append( " AND A.CHKBILL ='T'                                                  							\n");	
					sql.append( "    AND A.FDCODE ='"+str1+"'                                                                   						\n");
					sql.append( "    AND (A.ACTDAT LIKE '"+str2+"%' OR A.ACTDAT LIKE '"+str6+"%' )                  \n");
					sql.append( "    AND A.PAYDAT BETWEEN'"+str3+"' AND '"+str4+"'                                							\n");
					sql.append( "   GROUP BY A.VENDCD, C.VEND_NM, C.VEND_ID, A.FULDAT, A.CHKCASH, A.CHKBILL   			\n");
					sql.append( "   ORDER BY C.VEND_NM                                                                                               	\n");

					//System.out.println("# Query : \n" + sql);
					//logger.dbg.println(this,"sql.toString()::"+sql.toString());
					
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