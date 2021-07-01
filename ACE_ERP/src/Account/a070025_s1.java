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
public class a070025_s1 extends HttpServlet {
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
				// 감가상각 조회 쿼리

				String  str1 = req.getParameter("v_str1");    //지점
				String  str2 = req.getParameter("v_str2");    //회계년월FROM
				String  str3 = req.getParameter("v_str3");    //회계년월TO	
				
				String  str4 = req.getParameter("v_str4");    //정산일자
				String  str5 = req.getParameter("v_str5");    //거래처코드 
				String  str6 = req.getParameter("v_str6");    //거래처명 
								
				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				
				GauceRes.enableFirstRow(dSet);
				

				String[] strArrCN = new String[]{"CHK",
						                          "FDCODE",      "TSDAT",    "TSNBR",     "TSSEQ",    "SSDAT",
                                                 "SSNBR",       "FSNUM",    "ACTDAT",   "PAYDAT",   "ATCODE",
                                                 "ATKORNAM","VENDCD",   "VENDNM",  "DEAMT",    "CRAMT",
                                                  "JANAMT",     "BJANAMT", "FSREFCD", "FSREFVAL","FSREFNM","REMARK", 
                                                  "CHKCASH",  "CHKBILL",  "FULDAT",    "FSDAT",      "FSNBR" ,    "FSSTAT",
                                                  "I_EMPNO",   "I_DATE",     "U_EMPNO","U_DATE",  "GUBUN",
                                                  "EMPNO",     "EMPNMK",  "CREDGB", "FSLOCK"
                                                }; 

				int[] intArrCN = new int[]{1,
						                    2 ,  9,   6,   5,   9,
	                                        6,   3,   8,   8,   7, 
	                                       66, 13, 32, 15, 15,
	                                       15, 15,   4,  20, 40,  132,
	                                         1,   1,  8,    9,  6,  1,
	                                       10, 10,  10, 10, 1,
	                                        7,  32,   1, 1
	                        
	                                     }; 
					
				int[] intArrCN2 = new int[]{-1,
						                    -1,-1,-1,-1,-1,
											-1,-1,-1,-1,-1,
											-1,-1,-1,  0, 0,
											 0 , 0, -1, -1,-1,-1,
	                                        -1,-1,-1, -1,-1,-1,
											-1,-1,-1,-1, -1,
											-1, -1, -1, -1
                                           }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT 'F' CHK, N.FDCODE  ,N.TSDAT , N.TSNBR , N.TSSEQ ,                            		\n"); 
					sql.append( "        N.SSDAT   ,N.SSNBR , N.FSNUM, SUBSTR(N.SSDAT,2,9) ACTDAT, '' PAYDAT,           	\n"); 
					sql.append( "        N.ATCODE, C.ATKORNAM,                                                                                   \n"); 
					sql.append( "        N.VENDCD, E.CDNAM VENDNM,                                                                            \n"); 
					sql.append( "        N.DEAMT , N.CRAMT ,                                                                           				\n"); 
					sql.append( "        CASE WHEN C.ATDECR = '1' THEN  COALESCE(N.DEAMT,0)- COALESCE(N.CRAMT,0)                             	\n"); 
					sql.append( "                 WHEN C.ATDECR = '2' THEN  COALESCE(N.CRAMT,0)- COALESCE(N.DEAMT,0)   END  JANAMT,    		\n"); 
					sql.append( "        CASE WHEN C.ATDECR = '1' THEN  COALESCE(N.DEAMT,0)- COALESCE(Z.BJCRAMT,0)                         		\n"); 
					sql.append( "                 WHEN C.ATDECR = '2' THEN  COALESCE(N.CRAMT,0)- COALESCE(Z.BJDEAMT,0) END  BJANAMT, 		\n"); 
					sql.append( "        N.FSREFCD,  N.FSREFVAL,  P.CDNAM AS FSREFNM,                                                                                \n");  
					sql.append( "        N.REMARK,                                                                                                                                  		\n"); 
					sql.append( "        CASE WHEN (CASE WHEN C.ATDECR = '1' THEN  COALESCE(H.DEAMT,0)- COALESCE(H.CRAMT,0)  			\n");
					sql.append( "                                       WHEN C.ATDECR = '2' THEN  COALESCE(H.CRAMT,0)- COALESCE(H.DEAMT,0) END)<5000000 THEN 'T' ELSE 'F' END CHKCASH, \n");
					sql.append( "        CASE WHEN (CASE WHEN C.ATDECR = '1' THEN  COALESCE(H.DEAMT,0)- COALESCE(H.CRAMT,0)  			\n");
					sql.append( "                                       WHEN C.ATDECR = '2' THEN  COALESCE(H.CRAMT,0)- COALESCE(H.DEAMT,0) END)>=5000000 THEN 'T' ELSE 'F' END CHKBILL,  \n");
					sql.append( "        '' FULDAT, '' FSDAT, '' FSNBR, '' FSSTAT,                                              												\n"); 
					sql.append( "        ''I_EMPNO, ''I_DATE, ''U_EMPNO, ''U_DATE, 'A' AS GUBUN ,  M.EMPNO, Y.EMPNMK, T.CREDGB, M.FSLOCK   				\n"); 
					sql.append( "   FROM ACCOUNT.BANJAEMST N                                                                    												\n"); 
					sql.append( "   LEFT JOIN ACCOUNT.ACTCODE C ON N.ATCODE = C.ATCODE     																	\n"); 
					sql.append( "   LEFT JOIN (                                                                                                                                       		\n"); 
					sql.append( "             SELECT A.FDCODE, A.TSDAT, A.TSNBR, A.TSSEQ, SUM(A.BJDEAMT) BJDEAMT,                    				\n"); 
					sql.append( "                    SUM(A.BJCRAMT)BJCRAMT,D.ATCODE                                                                            			\n"); 
					sql.append( "               FROM ACCOUNT.BANJAEREL A                                                                                             		\n"); 
					sql.append( "               LEFT JOIN ACCOUNT.FSLIPMST B ON A.FDCODE = B.FDCODE                                              				\n"); 
					sql.append( " 			                              AND A.BTSDAT = B.FSDAT                                                                          		\n");   
					sql.append( " 			                              AND A.BTSNBR = B.FSNBR                                                                         			\n");   
					sql.append( "               LEFT JOIN ACCOUNT.FSLIPDTL D ON A.FDCODE = D.FDCODE                                               			\n"); 
					sql.append( " 			                              AND A.BTSDAT = D.FSDAT                               	\n");   
					sql.append( " 										  AND A.BTSNBR = D.FSNBR                               	\n");   
					sql.append( " 										  AND A.BTSSEQ = D.FSSEQ                               	\n");   
					sql.append( "              WHERE B.FSSTAT='Y'                                                                  	\n"); 
					sql.append( "                AND A.FDCODE ='02'                                                                  \n"); 
					//sql.append( "                AND SUBSTR(D.SSDAT,2,9) <='"+str3+"'                                     	\n");
					sql.append( "                AND D.SSDAT <='A"+str4+"'                                     	\n");
					sql.append( "                AND D.ATCODE IN ('2100110','2100510')                                     	\n"); 
					sql.append( "              GROUP BY A.FDCODE, A.TSDAT, A.TSNBR, A.TSSEQ, D.ATCODE                  				\n"); 
					sql.append( "            ) Z ON N.FDCODE = Z.FDCODE AND N.TSDAT = Z.TSDAT                                 			\n"); 
					sql.append( " 		      AND N.TSNBR = Z.TSNBR   AND N.TSSEQ = Z.TSSEQ                                    				\n");   
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL P ON N.FSREFVAL=P.CDCODE AND N.FSREFCD=P.CMTYPE     \n"); 
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL E ON N.VENDCD = E.CDCODE AND E.CMTYPE='0020'              \n");  
					sql.append( "   LEFT JOIN ACCOUNT.FSLIPMST M ON N.FDCODE = M.FDCODE AND N.TSDAT = M.FSDAT AND N.TSNBR =M.FSNBR \n");
					sql.append( "   LEFT JOIN PAYROLL.YIPERSON Y ON M.EMPNO = Y.EMPNO AND Y.USESTS IN ('1','2','3')  				\n");
					sql.append( "   LEFT JOIN ( SELECT N.FDCODE,N.VENDCD,           																		\n");
					sql.append( "  				   SUM(N.DEAMT)DEAMT , SUM(N.CRAMT)CRAMT,                                                         	\n");
					sql.append( "  				   SUM(CASE WHEN C.ATDECR = '1' THEN  COALESCE(N.DEAMT,0)- COALESCE(N.CRAMT,0)                    \n");
					sql.append( "  							WHEN C.ATDECR = '2' THEN  COALESCE(N.CRAMT,0)- COALESCE(N.DEAMT,0)   END)  JANAMT     \n");
					sql.append( "  			 FROM ACCOUNT.BANJAEMST N, ACCOUNT.ACTCODE C                                                          					\n");
					sql.append( "  		WHERE N.ATCODE = C.ATCODE                                                                             \n");
					sql.append( "  			  AND (( N.ATCODE='2100110' AND N.FSREFCD='1011' AND N.FSREFVAL='05')          \n");
					sql.append( "  		  	      OR( N.ATCODE='2100510' AND N.FSREFCD='1013' AND N.FSREFVAL='003'))       \n");
					sql.append( "  			  AND N.FDCODE ='"+str1+"'                                                                               \n");
					sql.append( "  			  AND N.SSDAT BETWEEN 'A"+str2+"01' AND 'A"+str3+"31'              					\n");
					sql.append( "  			  AND COALESCE(N.CRAMT,0)- COALESCE(N.DEAMT,0)!=0                                     \n");
					sql.append( "  			  AND NOT EXISTS ( SELECT K.FDCODE, K.TSDAT, K.TSNBR, K.TSSEQ                      \n");
					sql.append( "  								 FROM ACCOUNT.AETCPAY K                                                       \n");
					sql.append( "  								WHERE K.FDCODE = N.FDCODE                                                    \n");
					sql.append( "  								  AND K.TSDAT = N.TSDAT                                                           \n");
					sql.append( "  								  AND K.TSNBR = N.TSNBR                                                           \n");
					sql.append( "  								  AND K.TSSEQ = N.TSSEQ )                                                         \n");
					sql.append( "  			GROUP BY N.FDCODE, N.VENDCD                                                                    \n");
					sql.append( "  			ORDER BY N.VENDCD                                                                                       \n");
					sql.append( "  		 ) H ON N.FDCODE = H.FDCODE                                                                               \n");
					sql.append( "  			 AND N.VENDCD = H.VENDCD                                                                               \n");
					sql.append( "    LEFT JOIN ( SELECT U.VEND_CD, MAX(U.CREDGB)CREDGB 		\n");
					sql.append( "                          FROM ACCOUNT.BOND_ATTACH U                 	\n");
					sql.append( "                        WHERE U.CREDGB IN ('1','2')                           	\n");
					sql.append( "                        GROUP BY U.VEND_CD                                     	\n");
					sql.append( "                      ) T ON  N.VENDCD = T.VEND_CD                        		\n");
					sql.append( "  WHERE 1 = 1                                                                          \n"); 
					sql.append( "    AND (( N.ATCODE='2100110' AND N.FSREFCD='1011' AND N.FSREFVAL='05')                                     \n"); 
					sql.append( "        OR( N.ATCODE='2100510' AND N.FSREFCD='1013' AND N.FSREFVAL='003'))                                  \n"); 
					sql.append( "    AND N.FDCODE ='"+str1+"'                                                                   \n"); 
					sql.append( "    AND N.SSDAT BETWEEN 'A"+str2+"01' AND 'A"+str3+"31'          		\n"); 
					sql.append( "    AND COALESCE(N.CRAMT,0)- COALESCE(N.DEAMT,0)!=0                       \n"); 
					if(!str5.equals("")) sql.append( "    AND N.VENDCD = '"+str5+"' 											\n"); 
					if(!str6.equals("")) sql.append( "    AND E.CDNAM LIKE '"+str6+"%' 									\n"); 
					sql.append( "    AND NOT EXISTS ( SELECT K.FDCODE, K.TSDAT, K.TSNBR, K.TSSEQ   		\n");
					sql.append( "                                     FROM ACCOUNT.AETCPAY K                             \n");
					sql.append( "                                   WHERE K.FDCODE = N.FDCODE                             \n");
					sql.append( "                                        AND K.TSDAT = N.TSDAT                                   \n");
					sql.append( "                                        AND K.TSNBR = N.TSNBR                                  \n");
					sql.append( "                                        AND K.TSSEQ = N.TSSEQ )                               \n");				
					sql.append( "  ORDER BY N.ATCODE, E.CDNAM, N.SSDAT, N.SSNBR, N.FSNUM            		\n"); 
	
					//System.out.println("a070025_s1 : \n" + sql.toString());
					//logger.dbg.println( this, sql.toString() ); 
					
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