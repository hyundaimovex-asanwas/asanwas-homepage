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
public class a030011_s1 extends HttpServlet {
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
				String []  str	= new String [10];
				str[0] = req.getParameter("v_str1");	//지점코드
				str[1] = req.getParameter("v_str2");	//회계기간 from
				str[2] = req.getParameter("v_str3");	//회계기간 to
				str[3] = req.getParameter("v_str4");	//현계정코드
				str[4] = req.getParameter("v_str5");	//검색년도
				str[5] = req.getParameter("v_str6");	//전기이월

				for(int i=0;i<=5;i++) {
					if(str[i] == null) str[i] = ""; 
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ATDECR","ATCODE","ATKORNAM","ACTDAT","DETOT",
																					"CRTOT","SLPVLA","CUMULTAL" 
				}; 

				int[] intArrCN = new int[] {  1,   7,  66,   10,   9,
																			9,   9,   9	}; 
			
				int[] intArrCN2 = new int[]{ -1,  -1,  -1,  -1,   0,
																			0,   0,   0	}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT X.ATDECR AS ATDECR, X.ATCODE AS ATCODE, X.ATKORNAM AS ATKORNAM,																		\n");	
						sql.append( "				 SUBSTR(X.ACTDAT,1,4)||'/'||SUBSTR(X.ACTDAT,5,2)||'/'||SUBSTR(X.ACTDAT,5,2) AS ACTDAT,							\n");	
						sql.append( "				 SUM(X.DETOT) AS DETOT,SUM(X.CRTOT) AS CRTOT,SUM(X.SLPVLA) AS SLPVLA,																\n");
						sql.append( "        X.CUMULTAL AS CUMULTAL																																							\n");
						sql.append( " FROM (																																																		\n");	
						sql.append( " SELECT RTRIM(B.ATDECR) ATDECR, RTRIM(B.ATCODE) ATCODE, RTRIM(B.ATKORNAM) ATKORNAM, '"+str[4]+"0000' AS ACTDAT,	\n");	
						sql.append( "        SUM(A.DETOT) AS DETOT, SUM(A.CRTOT) AS CRTOT,                                                    	\n");
						sql.append( "        SUM(CASE WHEN B.ATDECR='1' THEN A.DETOT-A.CRTOT ELSE A.CRTOT-A.DETOT END) AS SLPVLA,              	\n");
						sql.append( "        0 AS CUMULTAL																																											\n");
						sql.append( " FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                                              	\n");
						sql.append( " WHERE A.ATCODE=B.ATCODE                                                                                 	\n");
						if(!str[0].equals(""))  sql.append( " AND A.FDCODE='"+str[0]+"'                                                         \n");
						if(!str[1].equals(""))	sql.append( " AND A.ACTDAT BETWEEN '"+str[4]+"0100' AND '"+str[5]+"'                            \n");
						if(!str[3].equals(""))	sql.append( " AND A.ATCODE BETWEEN '"+str[3]+"' AND '"+str[3]+"'                                \n");
						sql.append( " GROUP BY B.ATDECR, B.ATCODE, B.ATKORNAM, ACTDAT                                                         	\n");
						sql.append( " ) X                                                         																							\n");
						sql.append( " GROUP BY X.ATDECR, X.ATCODE, X.ATKORNAM, X.ACTDAT, X.CUMULTAL                                            	\n");
						
						sql.append( " UNION ALL	\n");

						sql.append( " SELECT B.ATDECR AS ATDECR, RTRIM(B.ATCODE) AS ATCODE,RTRIM(B.ATKORNAM) AS ATKORNAM,												\n");
						sql.append( "				 SUBSTR(A.ACTDAT,1,4)||'/'||SUBSTR(A.ACTDAT,5,2)||'/'||SUBSTR(A.ACTDAT,7,2) AS ACTDAT,							\n");
						sql.append( "        SUM(A.DETOT) AS DETOT, SUM(A.CRTOT) AS CRTOT,																											\n");
						sql.append( "        SUM(CASE WHEN B.ATDECR='1' THEN A.DETOT-A.CRTOT ELSE A.CRTOT-A.DETOT END) AS SLPVLA,								\n");
						sql.append( "	(SELECT SUM(DETOT) FROM ACCOUNT.TOTALBAL WHERE ATCODE='"+str[3]+"' AND SUBSTR(ACTDAT,7,8) != '32'					\n");
						sql.append( "	AND SUBSTR(ACTDAT,1,6)=SUBSTR(ACTDAT,1,6) AND ACTDAT BETWEEN '"+str[1]+"' AND '"+str[2]+"') AS CUMULTAL		\n");
						sql.append( " FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B																																\n");
						sql.append( " WHERE A.ATCODE=B.ATCODE																																										\n");
						if(!str[0].equals(""))  sql.append( " AND A.FDCODE='"+str[0]+"'																													\n");
						if(!str[1].equals(""))	sql.append( " AND A.ACTDAT BETWEEN '"+str[1]+"' AND '"+str[2]+"'																\n");
						if(!str[3].equals(""))	sql.append( " AND A.ATCODE BETWEEN '"+str[3]+"' AND '"+str[3]+"'																\n");
						sql.append( " GROUP BY B.ATDECR,SUBSTR(A.ACTDAT,1,4)||'/'||SUBSTR(A.ACTDAT,5,2)||'/'||SUBSTR(A.ACTDAT,7,2),B.ATCODE,B.ATKORNAM	\n");
						
						sql.append( " UNION ALL	\n");
						
						sql.append( " SELECT RTRIM(B.ATDECR) ATDECR, RTRIM(B.ATCODE) ATCODE, RTRIM(B.ATKORNAM) ATKORNAM,										\n");		
						sql.append( "        SUBSTR(A.ACTDAT,1,4)||'/'||SUBSTR(A.ACTDAT,5,2)||'/'||'32' AS ACTDAT,												  \n");
						sql.append( "        SUM(A.DETOT) AS DETOT, SUM(A.CRTOT) AS CRTOT,																									\n");
						sql.append( "        SUM(CASE WHEN B.ATDECR='1' THEN A.DETOT-A.CRTOT ELSE A.CRTOT-A.DETOT END) AS SLPVLA,           \n");
						sql.append( "        0 AS CUMULTAL																																									\n");
						sql.append( " FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                                            \n");
						sql.append( " WHERE A.ATCODE=B.ATCODE                                                                               \n");
						if(!str[0].equals(""))  sql.append( " AND A.FDCODE='"+str[0]+"'                                                     \n");
						if(!str[1].equals(""))	sql.append( " AND A.ACTDAT BETWEEN '"+str[1]+"' AND '"+str[2]+"'                            \n");
						if(!str[3].equals(""))	sql.append( " AND A.ATCODE BETWEEN '"+str[3]+"' AND '"+str[3]+"'                            \n");
						sql.append( " GROUP BY B.ATDECR,B.ATCODE,B.ATKORNAM,SUBSTR(A.ACTDAT,1,4)||'/'||SUBSTR(A.ACTDAT,5,2)||'/'||'32'			\n");

						sql.append( " UNION ALL	\n");

						sql.append( " SELECT X.ATDECR,X.ATCODE,X.ATKORNAM,X.ACTDAT,X.DETOT,X.CRTOT,																					\n");
						sql.append( " CASE WHEN SUBSTR(X.ACTDAT,6,2) <= '01' THEN																														\n");
						sql.append( "          (SELECT SUM(CASE WHEN BB.ATDECR='1' THEN AA.DETOT-AA.CRTOT ELSE AA.CRTOT-AA.DETOT END) AS SLPVLA	\n");
						sql.append( "          FROM ACCOUNT.TOTALBAL AA,ACCOUNT.ACTCODE BB WHERE AA.ATCODE=BB.ATCODE												\n");
						sql.append( "          AND SUBSTR(AA.ACTDAT,5,2) BETWEEN '01' AND '01' AND AA.ATCODE ='"+str[3]+"')									\n");
						sql.append( "     WHEN SUBSTR(X.ACTDAT,6,2) <= '02' AND SUBSTR(X.ACTDAT,6,2) >= '01' THEN														\n");
						sql.append( "          (SELECT SUM(CASE WHEN BB.ATDECR='1' THEN AA.DETOT-AA.CRTOT ELSE AA.CRTOT-AA.DETOT END) AS SLPVLA	\n");
						sql.append( "          FROM ACCOUNT.TOTALBAL AA,ACCOUNT.ACTCODE BB WHERE AA.ATCODE=BB.ATCODE												\n");
						sql.append( "          AND SUBSTR(AA.ACTDAT,5,2) BETWEEN '01' AND '02' AND AA.ATCODE ='"+str[3]+"')									\n");
						sql.append( "     WHEN SUBSTR(X.ACTDAT,6,2) <= '03' AND SUBSTR(X.ACTDAT,6,2) >= '01' THEN														\n");
						sql.append( "          (SELECT SUM(CASE WHEN BB.ATDECR='1' THEN AA.DETOT-AA.CRTOT ELSE AA.CRTOT-AA.DETOT END) AS SLPVLA	\n");
						sql.append( "          FROM ACCOUNT.TOTALBAL AA,ACCOUNT.ACTCODE BB WHERE AA.ATCODE=BB.ATCODE												\n");
						sql.append( "          AND SUBSTR(AA.ACTDAT,5,2) BETWEEN '01' AND '03' AND AA.ATCODE ='"+str[3]+"')									\n");
						sql.append( "     WHEN SUBSTR(X.ACTDAT,6,2) <= '04' AND SUBSTR(X.ACTDAT,6,2) >= '01' THEN														\n");
						sql.append( "          (SELECT SUM(CASE WHEN BB.ATDECR='1' THEN AA.DETOT-AA.CRTOT ELSE AA.CRTOT-AA.DETOT END) AS SLPVLA	\n");
						sql.append( "          FROM ACCOUNT.TOTALBAL AA,ACCOUNT.ACTCODE BB WHERE AA.ATCODE=BB.ATCODE												\n");
						sql.append( "          AND SUBSTR(AA.ACTDAT,5,2) BETWEEN '01' AND '04' AND AA.ATCODE ='"+str[3]+"')									\n");
						sql.append( "     WHEN SUBSTR(X.ACTDAT,6,2) <= '05' AND SUBSTR(X.ACTDAT,6,2) >= '01' THEN														\n");
						sql.append( "          (SELECT SUM(CASE WHEN BB.ATDECR='1' THEN AA.DETOT-AA.CRTOT ELSE AA.CRTOT-AA.DETOT END) AS SLPVLA	\n");
						sql.append( "          FROM ACCOUNT.TOTALBAL AA,ACCOUNT.ACTCODE BB WHERE AA.ATCODE=BB.ATCODE												\n");
						sql.append( "          AND SUBSTR(AA.ACTDAT,5,2) BETWEEN '01' AND '05' AND AA.ATCODE ='"+str[3]+"')									\n");
						sql.append( "     WHEN SUBSTR(X.ACTDAT,6,2) <= '06' AND SUBSTR(X.ACTDAT,6,2) >= '01' THEN														\n");
						sql.append( "          (SELECT SUM(CASE WHEN BB.ATDECR='1' THEN AA.DETOT-AA.CRTOT ELSE AA.CRTOT-AA.DETOT END) AS SLPVLA	\n");
						sql.append( "          FROM ACCOUNT.TOTALBAL AA,ACCOUNT.ACTCODE BB WHERE AA.ATCODE=BB.ATCODE												\n");
						sql.append( "          AND SUBSTR(AA.ACTDAT,5,2) BETWEEN '01' AND '06' AND AA.ATCODE ='"+str[3]+"')									\n");
						sql.append( "     WHEN SUBSTR(X.ACTDAT,6,2) <= '07' AND SUBSTR(X.ACTDAT,6,2) >= '01' THEN														\n");
						sql.append( "          (SELECT SUM(CASE WHEN BB.ATDECR='1' THEN AA.DETOT-AA.CRTOT ELSE AA.CRTOT-AA.DETOT END) AS SLPVLA	\n");
						sql.append( "          FROM ACCOUNT.TOTALBAL AA,ACCOUNT.ACTCODE BB WHERE AA.ATCODE=BB.ATCODE												\n");
						sql.append( "          AND SUBSTR(AA.ACTDAT,5,2) BETWEEN '01' AND '07' AND AA.ATCODE ='"+str[3]+"')									\n");
						sql.append( "     WHEN SUBSTR(X.ACTDAT,6,2) <= '08' AND SUBSTR(X.ACTDAT,6,2) >= '01' THEN														\n");
						sql.append( "          (SELECT SUM(CASE WHEN BB.ATDECR='1' THEN AA.DETOT-AA.CRTOT ELSE AA.CRTOT-AA.DETOT END) AS SLPVLA	\n");
						sql.append( "          FROM ACCOUNT.TOTALBAL AA,ACCOUNT.ACTCODE BB WHERE AA.ATCODE=BB.ATCODE												\n");
						sql.append( "          AND SUBSTR(AA.ACTDAT,5,2) BETWEEN '01' AND '08' AND AA.ATCODE ='"+str[3]+"')									\n");
						sql.append( "     WHEN SUBSTR(X.ACTDAT,6,2) <= '09' AND SUBSTR(X.ACTDAT,6,2) >= '01' THEN														\n");
						sql.append( "          (SELECT SUM(CASE WHEN BB.ATDECR='1' THEN AA.DETOT-AA.CRTOT ELSE AA.CRTOT-AA.DETOT END) AS SLPVLA	\n");
						sql.append( "          FROM ACCOUNT.TOTALBAL AA,ACCOUNT.ACTCODE BB WHERE AA.ATCODE=BB.ATCODE												\n");
						sql.append( "          AND SUBSTR(AA.ACTDAT,5,2) BETWEEN '01' AND '09' AND AA.ATCODE ='"+str[3]+"')									\n");
						sql.append( "     WHEN SUBSTR(X.ACTDAT,6,2) <= '10' AND SUBSTR(X.ACTDAT,6,2) >= '01' THEN														\n");
						sql.append( "          (SELECT SUM(CASE WHEN BB.ATDECR='1' THEN AA.DETOT-AA.CRTOT ELSE AA.CRTOT-AA.DETOT END) AS SLPVLA	\n");
						sql.append( "          FROM ACCOUNT.TOTALBAL AA,ACCOUNT.ACTCODE BB WHERE AA.ATCODE=BB.ATCODE												\n");
						sql.append( "          AND SUBSTR(AA.ACTDAT,5,2) BETWEEN '01' AND '10' AND AA.ATCODE ='"+str[3]+"')									\n");
						sql.append( "     WHEN SUBSTR(X.ACTDAT,6,2) <= '11' AND SUBSTR(X.ACTDAT,6,2) >= '01' THEN														\n");
						sql.append( "          (SELECT SUM(CASE WHEN BB.ATDECR='1' THEN AA.DETOT-AA.CRTOT ELSE AA.CRTOT-AA.DETOT END) AS SLPVLA	\n");
						sql.append( "          FROM ACCOUNT.TOTALBAL AA,ACCOUNT.ACTCODE BB WHERE AA.ATCODE=BB.ATCODE												\n");
						sql.append( "          AND SUBSTR(AA.ACTDAT,5,2) BETWEEN '01' AND '11' AND AA.ATCODE ='"+str[3]+"')									\n");
						sql.append( "     WHEN SUBSTR(X.ACTDAT,6,2) <= '12' AND SUBSTR(X.ACTDAT,6,2) >= '01' THEN														\n");
						sql.append( "          (SELECT SUM(CASE WHEN BB.ATDECR='1' THEN AA.DETOT-AA.CRTOT ELSE AA.CRTOT-AA.DETOT END) AS SLPVLA	\n");
						sql.append( "          FROM ACCOUNT.TOTALBAL AA,ACCOUNT.ACTCODE BB WHERE AA.ATCODE=BB.ATCODE												\n");
						sql.append( "          AND SUBSTR(AA.ACTDAT,5,2) BETWEEN '01' AND '12' AND AA.ATCODE ='"+str[3]+"')									\n");
						sql.append( "     END AS SLPVLA,																																										\n");
						sql.append( " X.CUMULTAL AS CUMULTAL																																								\n");
						sql.append( " FROM (																																																\n");
						sql.append( "     SELECT RTRIM(B.ATDECR) ATDECR, RTRIM(B.ATCODE) ATCODE, '누계' AS ATKORNAM,												\n");
						sql.append( "             SUBSTR(A.ACTDAT,1,4)||'/'||SUBSTR(A.ACTDAT,5,2)||'/'||'33' AS ACTDAT,											\n");
						sql.append( "             SUM(A.DETOT) AS DETOT, SUM(A.CRTOT) AS CRTOT,																							\n");
						sql.append( "             SUM(CASE WHEN B.ATDECR='1' THEN A.DETOT-A.CRTOT ELSE A.CRTOT-A.DETOT END) AS SLPVLA,			\n");
						sql.append( "             (SELECT COUNT(S.CUMULTAL)																																	\n");
						sql.append( "             FROM (SELECT SUBSTR(H.ACTDAT,5,2) CUMULTAL																								\n");
						sql.append( "             			FROM ACCOUNT.TOTALBAL H																															\n");
						sql.append( "             			WHERE H.ACTDAT BETWEEN '"+str[1]+"' AND '"+str[2]+"'																\n");
						sql.append( "										AND H.ATCODE ='"+str[3]+"'																													\n");
						sql.append( "             			GROUP BY SUBSTR(H.ACTDAT,5,2)																												\n");
						sql.append( "             ) S ) AS CUMULTAL																																					\n");
						sql.append( "     FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B																												\n");
						sql.append( "     WHERE A.ATCODE=B.ATCODE																																						\n");
						if(!str[0].equals(""))  sql.append( " AND A.FDCODE='"+str[0]+"'																											\n");
						if(!str[1].equals(""))	sql.append( " AND A.ACTDAT BETWEEN '"+str[1]+"' AND '"+str[2]+"'                            \n");
						sql.append( "     AND A.ATCODE ='"+str[3]+"'																																				\n");
						sql.append( "     GROUP BY B.ATDECR, B.ATCODE,B.ATKORNAM,SUBSTR(A.ACTDAT,1,4)||'/'||SUBSTR(A.ACTDAT,5,2)||'/'||'33',  ");
						sql.append( "			SUBSTR(A.ACTDAT,5,2)																																							\n");
						sql.append( " ) X																																																		\n");
						sql.append( " GROUP BY X.ATDECR,X.ATCODE,X.ATKORNAM,X.ACTDAT,X.DETOT,X.CRTOT,X.SLPVLA,X.CUMULTAL										\n");
						sql.append( " ORDER BY ACTDAT \n");

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