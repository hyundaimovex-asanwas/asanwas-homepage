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
public class a030006_s1 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1"); //지점코드
				String  str2  = req.getParameter("v_str2"); //년초 일
				String  str3  = req.getParameter("v_str3"); //하루 전일
				String  str4  = req.getParameter("v_str4"); //FROM일자
				String  str5  = req.getParameter("v_str5"); //TO일자

				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";
				if(str3 == null) str3 = "";
				if(str4 == null) str4 = "";
				if(str5 == null) str5 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ACTDAT","ACTDAT2", "ATCODE", "ATKORNAM", "ATPRTSEQ", "DETOT", "DECRVAL",
												  "CRCASH", "DECASH", "CRDEVAL", "CRTOT", "CRCASH2", "DECASH2", "TOTAL" }; 

				int[] intArrCN = new int[]{   8, 8,  7,  66,  7,  15,  15,
												15, 15, 15, 15, 15, 15, 6 }; 
			
				int[] intArrCN2 = new int[]{ -1, -1,  -1,  -1,   0,   0,   0,
												0,  0,  0,  0, 0, 0, 0 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT A.ACTDAT             AS ACTDAT, A.ACTDAT  AS ACTDAT2,              \n" );
					sql.append( "         A.ATCODE            AS ATCODE,                                    \n" );
					sql.append( "         B.ATKORNAM          AS ATKORNAM,                                  \n" );
					sql.append( "         B.ATPRTSEQ          AS ATPRTSEQ,                                  \n" );
					sql.append( "         nvl(SUM(A.DETOT),0)  AS DETOT,             --차변합계               		\n" );
					sql.append( "         nvl(SUM(A.DETOT),0)  AS DECRVAL,           --차변대체               		\n" );
					sql.append( "         nvl(SUM(A.CRCASH),0) AS CRCASH,            --차변현금               		\n" );
					sql.append( "         nvl(SUM(A.DECASH),0) AS DECASH,            --대변현금               		\n" );
					sql.append( "         nvl(SUM(A.CRTOT),0)  AS CRDEVAL,           --대변대체               		\n" );
					sql.append( "         nvl(SUM(A.CRTOT),0)  AS CRTOT,             --대변합계               		\n" );
					sql.append( "         0 CRCASH2, 0 DECASH2, 0 TOTAL                                     \n" );
					sql.append( "  FROM ACCOUNT.TOTALBAL A,ACCOUNT.ACTCODE B                                \n" );
					sql.append( "  WHERE A.ATCODE = B.ATCODE                                                \n" );
					if(!str1.equals(""))sql.append( " AND A.FDCODE = '"+str1+"' 							\n" );
					sql.append( "    AND A.ACTDAT >= '"+str4+"'                                             \n" );
					sql.append( "    AND A.ACTDAT <= '"+str5+"'                                             \n" );
					sql.append( "    AND A.ATCODE NOT IN ('1110110')                               			\n" );
					sql.append( "    AND B.ATDAYBALYN = 'Y'                           --일계표출력             		\n" );
					sql.append( "    AND B.ATUSEYN = 'Y'                                                   	\n" );
					sql.append( "  GROUP BY A.ACTDAT, A.ATCODE, B.ATKORNAM, B.ATPRTSEQ                      \n" );
					sql.append( "  HAVING (nvl(SUM(A.DETOT),0)!=0 OR nvl(SUM(A.CRCASH),0)!=0 OR nvl(SUM(A.DECASH),0)!=0 OR nvl(SUM(A.CRTOT),0)!=0) \n" );
					sql.append( "  UNION ALL                                                              	\n" );
					sql.append( "   SELECT A.ACTDAT            AS ACTDAT, A.ACTDAT   AS ACTDAT2,           	\n" );
					sql.append( "         '8888888'           AS ATCODE,                                  	\n" );
					sql.append( "         '           금   일   소   계'          AS ATKORNAM,                 	\n" );
					sql.append( "         TO_NUMBER('77777')             AS ATPRTSEQ,                      	\n" );
					sql.append( "         nvl(SUM(A.DETOT),0)+nvl(MAX(D.CRCASH),0)  AS DETOT,            	\n" );
					sql.append( "         nvl(SUM(A.DETOT),0)-nvl(MAX(D.DECASH),0)  AS DECRVAL,          	\n" );
					sql.append( "         nvl(MAX(D.CRCASH),0)+nvl(MAX(D.DECASH),0) AS CRCASH,           	\n" );
					sql.append( "         nvl(MAX(D.CRCASH),0)+nvl(MAX(D.DECASH),0) AS DECASH,           	\n" );
					sql.append( "         nvl(SUM(CRTOT),0)-nvl(MAX(D.CRCASH),0)    AS CRDEVAL,          	\n" );
					sql.append( "         nvl(SUM(CRTOT),0)+nvl(MAX(D.DECASH),0)    AS CRTOT,            	\n" );
					sql.append( "         nvl(MAX(D.CRCASH),0) CRCASH2, nvl(MAX(D.DECASH),0) DECASH2,     	\n" );
					sql.append( "         nvl(MAX(F.TOTAL),0) TOTAL     									\n" );
					sql.append( "  FROM ACCOUNT.TOTALBAL A                                 					\n" );
					sql.append( "  LEFT JOIN ACCOUNT.ACTCODE B ON A.ATCODE = B.ATCODE                       \n" );
					sql.append( "  			AND B.ATDAYBALYN = 'Y' AND B.ATUSEYN = 'Y'                      \n" );										
					sql.append( "  LEFT JOIN (SELECT C.ACTDAT,                                              \n" );
					sql.append( "                    SUM(C.DETOT)CRCASH, SUM(C.CRTOT)DECASH                 \n" );
					sql.append( "               FROM ACCOUNT.TOTALBAL C                                     \n" );
					sql.append( "              WHERE C.ATCODE IN ('1110110')                                \n" );
					if(!str1.equals(""))sql.append( "      AND C.FDCODE = '"+str1+"' 						\n" );
					sql.append( "                AND C.ACTDAT >= '"+str4+"'                                 \n" );
					sql.append( "                AND C.ACTDAT <= '"+str5+"'                                 \n" );
					sql.append( "              GROUP BY C.ACTDAT) D ON D.ACTDAT = A.ACTDAT                  \n" );
					sql.append( "  LEFT JOIN (SELECT E.ACTDAT ACTDAT, COUNT(*) TOTAL     					\n" );
					sql.append( "  		        FROM ACCOUNT.FSLIPMST E                           	     	\n" );
					sql.append( "  		       WHERE E.FSSTAT='Y'                                			\n" );
					if(!str1.equals(""))sql.append( "      AND E.FDCODE = '"+str1+"'                        \n" );
					sql.append( "                AND E.ACTDAT >= '"+str4+"'                                 \n" );
					sql.append( "                AND E.ACTDAT <= '"+str5+"'                                 \n" );
					sql.append( "  		       GROUP BY E.ACTDAT ) F ON F.ACTDAT = A.ACTDAT       		    \n" );
					sql.append( "  WHERE 1 = 1                                                   			\n" );
					if(!str1.equals(""))sql.append( " AND A.FDCODE = '"+str1+"' 							\n" );
					sql.append( "    AND A.ACTDAT >= '"+str4+"'                                             \n" );
					sql.append( "    AND A.ACTDAT <= '"+str5+"'                                             \n" );
					sql.append( "    AND A.ATCODE NOT IN ('1110110')                                        \n" );
					sql.append( "  GROUP BY A.ACTDAT                                                        \n" );
					sql.append( "  HAVING (nvl(SUM(A.DETOT),0)!=0 OR nvl(SUM(A.CRCASH),0)!=0 OR nvl(SUM(A.DECASH),0)!=0 OR nvl(SUM(A.CRTOT),0)!=0) \n" );

					
					sql.append( "  UNION ALL                                                             	\n" );
					sql.append( "                                                                           \n" );
					sql.append( " SELECT C.ACTDAT                 AS ACTDAT,''  AS ACTDAT2,              	\n" );
					sql.append( "         '8999999'               AS ATCODE,                          	    \n" );
					sql.append( "         '           금일잔고/전일잔고'        AS ATKORNAM,                 	\n" );
					sql.append( "         TO_NUMBER('88888')              	AS ATPRTSEQ,                  	\n" );
					sql.append( "         0 AS DETOT,                                                     	\n" );
					sql.append( "         0                          AS DECRVAL,                          	\n" );
					sql.append( "         nvl((C.DEBF + C.DETO - C.CRTO),0) AS CRCASH,                      \n" );
					sql.append( "         nvl(DEBF,0)                       AS DECASH,                     	\n" );
					sql.append( "         0                          AS CRDEVAL,                            \n" );
					sql.append( "         0 AS CRTOT,                                                       \n" );
					sql.append( "         0 CRCASH2, 0 DECASH2 , 0 TOTAL                                    \n" );
					sql.append( "  FROM (                                                                   \n" );
					sql.append( "   SELECT '"+str4+"'  ACTDAT,                                              \n" );
					sql.append( "          SUM(CASE WHEN A.ACTDAT = '"+str4+"' THEN DETOT END) AS DETO,     \n" );
					sql.append( "          SUM(CASE WHEN A.ACTDAT = '"+str4+"' THEN CRTOT END) AS CRTO,     \n" );
					sql.append( "          SUM(CASE WHEN A.ACTDAT >= '"+str2+"' AND A.ACTDAT <= '"+str3+"'  \n" );
					sql.append( " 		            THEN A.DETOT - A.CRTOT ELSE 0 END) AS DEBF              \n" );
					sql.append( "     FROM ACCOUNT.TOTALBAL A,ACCOUNT.ACTCODE B                             \n" );
					sql.append( "    WHERE A.ATCODE = B.ATCODE                                              \n" );
					if(!str1.equals(""))sql.append( " AND A.FDCODE = '"+str1+"' 							\n" );
					sql.append( "      AND A.ACTDAT BETWEEN '"+str2+"' AND '"+str4+"'                       \n" );
					sql.append( "      AND A.ATCODE IN ('1110110')                                          \n" );
					sql.append( "      AND B.ATDAYBALYN = 'Y'                                               \n" );
					sql.append( "      AND B.ATUSEYN = 'Y'                                                  \n" );
					sql.append( "  ) C                                                                      \n" );
					
					
					sql.append( " UNION ALL                                                                 \n" );
					sql.append( " SELECT A.ACTDAT                    AS ACTDAT,''  AS ACTDAT2,              \n" );
					sql.append( "         '8999999'                  AS ATCODE,                             \n" );
					sql.append( "         '           금일잔고/전일잔고'        AS ATKORNAM,                   	\n" );
					sql.append( "         TO_NUMBER('88888')                AS ATPRTSEQ,                    \n" );
					sql.append( "         0 AS DETOT,                                                       \n" );
					sql.append( "         0 AS DECRVAL,                                                     \n" );
					sql.append( "         0 AS CRCASH,                                                      \n" );
					sql.append( "         0 AS DECASH,                                                      \n" );
					sql.append( "         0 AS CRDEVAL,                                                     \n" );
					sql.append( "         0 AS CRTOT,                                                       \n" );
					sql.append( "         0 CRCASH2, 0 DECASH2 , 0 TOTAL                                    \n" );
					sql.append( "   FROM ACCOUNT.TOTALBAL A,ACCOUNT.ACTCODE B                               \n" );
					sql.append( "  WHERE A.ATCODE = B.ATCODE                                                \n" );
					if(!str1.equals(""))sql.append( " AND A.FDCODE = '"+str1+"' 							\n" );
					sql.append( "    AND A.ACTDAT > '"+str4+"'                                          	\n" );
					sql.append( "    AND A.ACTDAT <= '"+str5+"'                                         	\n" );
					sql.append( "    AND B.ATDAYBALYN = 'Y'                                             	\n" );
					sql.append( "    AND B.ATUSEYN = 'Y'                                                	\n" );
					sql.append( "  GROUP BY A.ACTDAT                                                    	\n" );
					sql.append( "  HAVING (nvl(SUM(A.DETOT),0)!=0 OR nvl(SUM(A.CRCASH),0)!=0 OR nvl(SUM(A.DECASH),0)!=0 OR nvl(SUM(A.CRTOT),0)!=0) \n" );
					sql.append( "  ORDER BY 1,5                                                         	\n" );
				
					//System.out.println("# Query : " + sql);
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