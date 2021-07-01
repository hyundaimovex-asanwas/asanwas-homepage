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
public class a030022_s1_old extends HttpServlet {
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
				str[5] = req.getParameter("v_str6");	//검색일자
				str[6] = req.getParameter("v_str7");	//전기이월

				for(int i=0;i<=6;i++) {
					if(str[i] == null) str[i] = ""; 
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ATDECR","ATCODE","ATKORNAM","ACTDAT","DETOT",
																					"CRTOT","SLPVLA","CUMULTAL","REMARK","VEND_CD","VENDER",
																					"LEVELS","FDCODE","FSDAT","FSNBR", "SSDAT", "SSNBR"
				}; 

				int[] intArrCN = new int[] {  1,   7,  66,   10,   9,
																			9,   9,   9, 132,  13, 32,
																			6,   2,   9,   6,   9,  6	}; 
			
				int[] intArrCN2 = new int[]{ -1,  -1,  -1,  -1,   0,
																			0,   0,   0,  -1,  -1, -1, 
																		 -1,  -1,  -1,  -1,  -1, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
sql.append( " SELECT X.ATDECR AS ATDECR, X.ATCODE AS ATCODE, X.ATKORNAM AS ATKORNAM, X.ACTDAT AS ACTDAT,               	\n");	
sql.append( "	        SUM(X.DETOT) AS DETOT,SUM(X.CRTOT) AS CRTOT,SUM(X.DETOT+X.CRTOT) AS SLPVLA,                      	\n");
sql.append( "         X.CUMULTAL AS CUMULTAL,X.REMARK AS REMARK, X.VEND_CD, X.VENDER AS VENDER, X.LEVELS AS LEVELS,                \n");
sql.append( "         X.FDCODE,X.FSDAT,X.FSNBR, ''SSDAT, ''SSNBR																												                  \n");
sql.append( "  FROM (                                                                                                  	\n");	
sql.append( "  SELECT RTRIM(B.ATDECR) ATDECR, RTRIM(B.ATCODE) ATCODE, RTRIM(B.ATKORNAM) ATKORNAM, '"+str[4]+"/00/00' AS ACTDAT,	\n");	
sql.append( "         SUM(A.DETOT) AS DETOT, SUM(A.CRTOT) AS CRTOT,                                                    	\n");
sql.append( "         SUM(CASE WHEN B.ATDECR='1' THEN A.DETOT-A.CRTOT ELSE A.CRTOT-A.DETOT END) AS SLPVLA,              \n");
sql.append( "         0 AS CUMULTAL,'' AS REMARK,'' AS VEND_CD, '' AS VENDER,SUBSTR('"+str[4]+"',3,2)||'0000' LEVELS,                  \n");
sql.append( "					'' AS FDCODE,'' AS FSDAT,'' AS FSNBR																															\n");
sql.append( "  FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                                              	\n");
sql.append( "  WHERE A.ATCODE=B.ATCODE                                                                                 	\n");
if(!str[0].equals(""))  sql.append( " AND A.FDCODE='"+str[0]+"'                                                         \n");
if(!str[1].equals(""))	sql.append( " AND A.ACTDAT BETWEEN '"+str[4]+"0100' AND '"+str[6]+"'                            \n");
if(!str[3].equals(""))	sql.append( " AND A.ATCODE BETWEEN '"+str[3]+"' AND '"+str[3]+"'                                \n");
sql.append( " GROUP BY B.ATDECR, B.ATCODE, B.ATKORNAM, ACTDAT                                                         	\n");
sql.append( " ) X                                                         																							\n");
sql.append( " GROUP BY X.ATDECR, X.ATCODE, X.ATKORNAM, X.ACTDAT, X.CUMULTAL,X.REMARK, X.VEND_CD, X.VENDER,X.LEVELS,X.FDCODE,X.FSDAT,X.FSNBR \n");

sql.append( " UNION ALL	\n");

sql.append( " SELECT G.ATDECR AS ATDECR, G.ATCODE AS ATCODE, G.ATKORNAM AS ATKORNAM, \n");  //G.ACTDAT AS ACTDAT,
sql.append( " SUBSTR(G.ACTDAT,1,4)||'/'||SUBSTR(G.ACTDAT,5,2)||'/'||SUBSTR(G.ACTDAT,7,2) AS ACTDAT, 				    										\n");
sql.append( "        G.DETOT AS DETOT,G.CRTOT AS CRTOT,G.SLPVLA AS SLPVLA,																													\n");
sql.append( "        G.CUMULTAL AS CUMULTAL,G.REMARK AS REMARK,H.VEND_CD AS VEND_CD, H.VEND_NM AS VENDER,G.LEVELS	AS LEVELS,															\n");
sql.append( "        G.FDCODE,G.FSDAT,G.FSNBR,	 G.SSDAT, G.SSNBR																																											\n");
sql.append( "	FROM (SELECT E.ATDECR, E.ATCODE, E.ATKORNAM,E.ACTDAT,E.DETOT,E.CRTOT,E.SLPVLA,																				\n");
sql.append( "	             E.CUMULTAL,E.REMARK,F.FSREFVAL,E.LEVELS,E.FDCODE,E.FSDAT,E.FSNBR	, E.SSDAT, E.SSNBR																				\n");
sql.append( "   FROM(SELECT C.ATDECR,C.ATCODE,C.ATKORNAM,C.ACTDAT,C.DETOT,C.CRTOT,C.SLPVLA,																					\n");
sql.append( "               C.CUMULTAL, D.REMARK, C.FDCODE,C.FSDAT,C.FSNBR,C.FSSEQ,C.LEVELS	, D.SSDAT, D.SSNBR																				\n");
sql.append( "       FROM ACCOUNT.FSLIPDTL D    /*전표Detail*/																																				\n");
sql.append( "       RIGHT JOIN (SELECT B.ATDECR AS ATDECR,B.ATCODE AS ATCODE,B.ATKORNAM AS ATKORNAM,A.ACTDAT AS ACTDAT,							\n");
sql.append( "             A.DEAMT AS DETOT, A.CRAMT AS CRTOT,SUBSTR(A.ACTDAT,3,4)||SUBSTR(A.ACTDAT,7,2) LEVELS,											\n");
sql.append( "	            CASE WHEN B.ATDECR='1' THEN A.DEAMT-A.CRAMT ELSE A.CRAMT-A.DEAMT END AS SLPVLA,														\n");
sql.append( "	            (SELECT SUM(DETOT) FROM ACCOUNT.TOTALBAL WHERE ATCODE='"+str[3]+"' AND SUBSTR(ACTDAT,7,8) <> '32'					\n");
sql.append( "             AND SUBSTR(ACTDAT,1,6)=SUBSTR(ACTDAT,1,6) AND ACTDAT BETWEEN '"+str[1]+"' AND '"+str[2]+"') AS CUMULTAL,	\n");
sql.append( "             A.FDCODE AS FDCODE,A.FSDAT AS FSDAT,A.FSNBR AS FSNBR,A.FSSEQ AS FSSEQ																			\n");
sql.append( "					FROM ACCOUNT.GENENLED A,ACCOUNT.ACTCODE B   /*총계정원장*/																										\n");
sql.append( "         WHERE A.ATCODE=B.ATCODE																																												\n");
if(!str[0].equals(""))  sql.append( " AND A.FDCODE='"+str[0]+"'																																			\n");
if(!str[1].equals(""))	sql.append( " AND A.ACTDAT BETWEEN '"+str[1]+"' AND '"+str[2]+"'																						\n");
if(!str[3].equals(""))	sql.append( " AND A.ATCODE BETWEEN '"+str[3]+"' AND '"+str[3]+"'																						\n");
sql.append( "         ) C ON C.FDCODE = D.FDCODE AND C.FSDAT = D.FSDAT AND C.FSNBR = D.FSNBR AND C.FSSEQ = D.FSSEQ									\n");
sql.append( "     ) E																																																								\n");
sql.append( "     LEFT JOIN ACCOUNT.GENENREF F ON E.FDCODE=F.FDCODE    /*관리항목원장*/																							\n");
sql.append( "                                  AND E.FSDAT=F.FSDAT AND E.FSNBR=F.FSNBR																							\n");
sql.append( "                                  AND E.FSSEQ=F.FSSEQ AND F.FSREFCD='0020'																							\n");
sql.append( "	 ) G																																																									\n");
sql.append( "	 LEFT JOIN ACCOUNT.GCZM_VENDER H ON G.FSREFVAL=H.VEND_CD    /*거래처코드*/																						\n");
sql.append( "  GROUP BY G.ATDECR,G.ATCODE,G.ATKORNAM,G.ACTDAT,G.DETOT,G.CRTOT,G.SLPVLA,G.CUMULTAL,G.REMARK,H.VEND_CD, H.VEND_NM,G.LEVELS,			\n");
sql.append( "  G.FDCODE,G.FSDAT,G.FSNBR,G.SSDAT, G.SSNBR																																															\n");

sql.append( " UNION ALL	\n");

sql.append( " SELECT RTRIM(B.ATDECR) ATDECR, RTRIM(B.ATCODE) ATCODE, RTRIM(B.ATKORNAM) ATKORNAM,										\n");		
sql.append( "        SUBSTR(A.ACTDAT,1,4)||'/'||SUBSTR(A.ACTDAT,5,2)||'/'||'32' AS ACTDAT,													\n");
sql.append( " SUM(A.DETOT) AS DETOT, SUM(A.CRTOT) AS CRTOT,																													\n");
sql.append( "        SUM(CASE WHEN B.ATDECR='1' THEN A.DETOT-A.CRTOT ELSE A.CRTOT-A.DETOT END) AS SLPVLA,           \n");
sql.append( "        0 AS CUMULTAL, '' AS REMARK, ''AS VEND_CD,'' AS VENDER, SUBSTR(A.ACTDAT,3,4)||'32' LEVELS,									\n");
sql.append( "        '' AS FDCODE,'' AS FSDAT,'' AS FSNBR, ''SSDAT, ''SSNBR																														\n");
sql.append( " FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                                            \n");
sql.append( " WHERE A.ATCODE=B.ATCODE                                                                               \n");
if(!str[0].equals(""))  sql.append( " AND A.FDCODE='"+str[0]+"'                                                     \n");
if(!str[1].equals(""))	sql.append( " AND A.ACTDAT BETWEEN '"+str[1]+"' AND '"+str[2]+"'                            \n");
if(!str[3].equals(""))	sql.append( " AND A.ATCODE BETWEEN '"+str[3]+"' AND '"+str[3]+"'                            \n");
sql.append( " GROUP BY B.ATDECR, B.ATCODE, B.ATKORNAM, ");
sql.append( " SUBSTR(A.ACTDAT,1,4)||'/'||SUBSTR(A.ACTDAT,5,2)||'/'||'32', SUBSTR(A.ACTDAT,3,4)||'32'								\n");

sql.append( " UNION ALL	\n");

sql.append( " SELECT X.ATDECR,X.ATCODE,X.ATKORNAM,X.ACTDAT,X.DETOT,X.CRTOT,																					\n");
sql.append( " CASE WHEN SUBSTR(X.ACTDAT,6,2) <= '01' THEN																														\n");
sql.append( "          (SELECT SUM(CASE WHEN BB.ATDECR='1' THEN AA.DETOT-AA.CRTOT ELSE AA.CRTOT-AA.DETOT END) AS SLPVLA	\n");
sql.append( "          FROM ACCOUNT.TOTALBAL AA,ACCOUNT.ACTCODE BB WHERE AA.ATCODE=BB.ATCODE												\n");
sql.append( "          AND SUBSTR(AA.ACTDAT,1,4)||SUBSTR(AA.ACTDAT,5,2) BETWEEN '"+str[4]+"01' AND '"+str[4]+"01' AND AA.ATCODE ='"+str[3]+"')									\n");
sql.append( "     WHEN SUBSTR(X.ACTDAT,6,2) <= '02' AND SUBSTR(X.ACTDAT,6,2) >= '01' THEN														\n");
sql.append( "          (SELECT SUM(CASE WHEN BB.ATDECR='1' THEN AA.DETOT-AA.CRTOT ELSE AA.CRTOT-AA.DETOT END) AS SLPVLA	\n");
sql.append( "          FROM ACCOUNT.TOTALBAL AA,ACCOUNT.ACTCODE BB WHERE AA.ATCODE=BB.ATCODE												\n");
sql.append( "          AND SUBSTR(AA.ACTDAT,1,4)||SUBSTR(AA.ACTDAT,5,2) BETWEEN '"+str[4]+"01' AND '"+str[4]+"02' AND AA.ATCODE ='"+str[3]+"')									\n");
sql.append( "     WHEN SUBSTR(X.ACTDAT,6,2) <= '03' AND SUBSTR(X.ACTDAT,6,2) >= '01' THEN														\n");
sql.append( "          (SELECT SUM(CASE WHEN BB.ATDECR='1' THEN AA.DETOT-AA.CRTOT ELSE AA.CRTOT-AA.DETOT END) AS SLPVLA	\n");
sql.append( "          FROM ACCOUNT.TOTALBAL AA,ACCOUNT.ACTCODE BB WHERE AA.ATCODE=BB.ATCODE												\n");
sql.append( "          AND SUBSTR(AA.ACTDAT,1,4)||SUBSTR(AA.ACTDAT,5,2) BETWEEN '"+str[4]+"01' AND '"+str[4]+"03' AND AA.ATCODE ='"+str[3]+"')									\n");
sql.append( "     WHEN SUBSTR(X.ACTDAT,6,2) <= '04' AND SUBSTR(X.ACTDAT,6,2) >= '01' THEN														\n");
sql.append( "          (SELECT SUM(CASE WHEN BB.ATDECR='1' THEN AA.DETOT-AA.CRTOT ELSE AA.CRTOT-AA.DETOT END) AS SLPVLA	\n");
sql.append( "          FROM ACCOUNT.TOTALBAL AA,ACCOUNT.ACTCODE BB WHERE AA.ATCODE=BB.ATCODE												\n");
sql.append( "          AND SUBSTR(AA.ACTDAT,1,4)||SUBSTR(AA.ACTDAT,5,2) BETWEEN '"+str[4]+"01' AND '"+str[4]+"04' AND AA.ATCODE ='"+str[3]+"')									\n");
sql.append( "     WHEN SUBSTR(X.ACTDAT,6,2) <= '05' AND SUBSTR(X.ACTDAT,6,2) >= '01' THEN														\n");
sql.append( "          (SELECT SUM(CASE WHEN BB.ATDECR='1' THEN AA.DETOT-AA.CRTOT ELSE AA.CRTOT-AA.DETOT END) AS SLPVLA	\n");
sql.append( "          FROM ACCOUNT.TOTALBAL AA,ACCOUNT.ACTCODE BB WHERE AA.ATCODE=BB.ATCODE												\n");
sql.append( "          AND SUBSTR(AA.ACTDAT,1,4)||SUBSTR(AA.ACTDAT,5,2) BETWEEN '"+str[4]+"01' AND '"+str[4]+"05' AND AA.ATCODE ='"+str[3]+"')									\n");
sql.append( "     WHEN SUBSTR(X.ACTDAT,6,2) <= '06' AND SUBSTR(X.ACTDAT,6,2) >= '01' THEN														\n");
sql.append( "          (SELECT SUM(CASE WHEN BB.ATDECR='1' THEN AA.DETOT-AA.CRTOT ELSE AA.CRTOT-AA.DETOT END) AS SLPVLA	\n");
sql.append( "          FROM ACCOUNT.TOTALBAL AA,ACCOUNT.ACTCODE BB WHERE AA.ATCODE=BB.ATCODE												\n");
sql.append( "          AND SUBSTR(AA.ACTDAT,1,4)||SUBSTR(AA.ACTDAT,5,2) BETWEEN '"+str[4]+"01' AND '"+str[4]+"06' AND AA.ATCODE ='"+str[3]+"')									\n");
sql.append( "     WHEN SUBSTR(X.ACTDAT,6,2) <= '07' AND SUBSTR(X.ACTDAT,6,2) >= '01' THEN														\n");
sql.append( "          (SELECT SUM(CASE WHEN BB.ATDECR='1' THEN AA.DETOT-AA.CRTOT ELSE AA.CRTOT-AA.DETOT END) AS SLPVLA	\n");
sql.append( "          FROM ACCOUNT.TOTALBAL AA,ACCOUNT.ACTCODE BB WHERE AA.ATCODE=BB.ATCODE												\n");
sql.append( "          AND SUBSTR(AA.ACTDAT,1,4)||SUBSTR(AA.ACTDAT,5,2) BETWEEN '"+str[4]+"01' AND '"+str[4]+"07' AND AA.ATCODE ='"+str[3]+"')									\n");
sql.append( "     WHEN SUBSTR(X.ACTDAT,6,2) <= '08' AND SUBSTR(X.ACTDAT,6,2) >= '01' THEN														\n");
sql.append( "          (SELECT SUM(CASE WHEN BB.ATDECR='1' THEN AA.DETOT-AA.CRTOT ELSE AA.CRTOT-AA.DETOT END) AS SLPVLA	\n");
sql.append( "          FROM ACCOUNT.TOTALBAL AA,ACCOUNT.ACTCODE BB WHERE AA.ATCODE=BB.ATCODE												\n");
sql.append( "          AND SUBSTR(AA.ACTDAT,1,4)||SUBSTR(AA.ACTDAT,5,2) BETWEEN '"+str[4]+"01' AND '"+str[4]+"08' AND AA.ATCODE ='"+str[3]+"')									\n");
sql.append( "     WHEN SUBSTR(X.ACTDAT,6,2) <= '09' AND SUBSTR(X.ACTDAT,6,2) >= '01' THEN														\n");
sql.append( "          (SELECT SUM(CASE WHEN BB.ATDECR='1' THEN AA.DETOT-AA.CRTOT ELSE AA.CRTOT-AA.DETOT END) AS SLPVLA	\n");
sql.append( "          FROM ACCOUNT.TOTALBAL AA,ACCOUNT.ACTCODE BB WHERE AA.ATCODE=BB.ATCODE												\n");
sql.append( "          AND SUBSTR(AA.ACTDAT,1,4)||SUBSTR(AA.ACTDAT,5,2) BETWEEN '"+str[4]+"01' AND '"+str[4]+"09' AND AA.ATCODE ='"+str[3]+"')									\n");
sql.append( "     WHEN SUBSTR(X.ACTDAT,6,2) <= '10' AND SUBSTR(X.ACTDAT,6,2) >= '01' THEN														\n");
sql.append( "          (SELECT SUM(CASE WHEN BB.ATDECR='1' THEN AA.DETOT-AA.CRTOT ELSE AA.CRTOT-AA.DETOT END) AS SLPVLA	\n");
sql.append( "          FROM ACCOUNT.TOTALBAL AA,ACCOUNT.ACTCODE BB WHERE AA.ATCODE=BB.ATCODE												\n");
sql.append( "          AND SUBSTR(AA.ACTDAT,1,4)||SUBSTR(AA.ACTDAT,5,2) BETWEEN '"+str[4]+"01' AND '"+str[4]+"10' AND AA.ATCODE ='"+str[3]+"')									\n");
sql.append( "     WHEN SUBSTR(X.ACTDAT,6,2) <= '11' AND SUBSTR(X.ACTDAT,6,2) >= '01' THEN														\n");
sql.append( "          (SELECT SUM(CASE WHEN BB.ATDECR='1' THEN AA.DETOT-AA.CRTOT ELSE AA.CRTOT-AA.DETOT END) AS SLPVLA	\n");
sql.append( "          FROM ACCOUNT.TOTALBAL AA,ACCOUNT.ACTCODE BB WHERE AA.ATCODE=BB.ATCODE												\n");
sql.append( "          AND SUBSTR(AA.ACTDAT,1,4)||SUBSTR(AA.ACTDAT,5,2) BETWEEN '"+str[4]+"01' AND '"+str[4]+"11' AND AA.ATCODE ='"+str[3]+"')									\n");
sql.append( "     WHEN SUBSTR(X.ACTDAT,6,2) <= '12' AND SUBSTR(X.ACTDAT,6,2) >= '01' THEN														\n");
sql.append( "          (SELECT SUM(CASE WHEN BB.ATDECR='1' THEN AA.DETOT-AA.CRTOT ELSE AA.CRTOT-AA.DETOT END) AS SLPVLA	\n");
sql.append( "          FROM ACCOUNT.TOTALBAL AA,ACCOUNT.ACTCODE BB WHERE AA.ATCODE=BB.ATCODE												\n");
sql.append( "          AND SUBSTR(AA.ACTDAT,1,4)||SUBSTR(AA.ACTDAT,5,2) BETWEEN '"+str[4]+"01' AND '"+str[4]+"12' AND AA.ATCODE ='"+str[3]+"')									\n");
sql.append( "     END AS SLPVLA,																																										\n");
sql.append( " X.CUMULTAL AS CUMULTAL,X.REMARK,X.VEND_CD, X.VENDER,X.LEVELS,X.FDCODE,X.FSDAT,X.FSNBR, ''SSDAT, ''SSNBR														\n");
sql.append( " FROM (																																																\n");
sql.append( "     SELECT RTRIM(B.ATDECR) ATDECR, RTRIM(B.ATCODE) ATCODE, '누계' AS ATKORNAM,												\n");
//sql.append( "             SUBSTR(A.ACTDAT,1,6)||'33' AS ACTDAT,																											\n");
sql.append( "             SUBSTR(A.ACTDAT,1,4)||'/'||SUBSTR(A.ACTDAT,5,2)||'/'||'33' AS ACTDAT,											\n");
sql.append( "             SUM(A.DETOT) AS DETOT, SUM(A.CRTOT) AS CRTOT,																							\n");
sql.append( "             SUM(CASE WHEN B.ATDECR='1' THEN A.DETOT-A.CRTOT ELSE A.CRTOT-A.DETOT END) AS SLPVLA,			\n");
sql.append( "             (SELECT COUNT(S.CUMULTAL)																																	\n");
sql.append( "             FROM (SELECT SUBSTR(H.ACTDAT,5,2) CUMULTAL																								\n");
sql.append( "             			FROM ACCOUNT.TOTALBAL H																															\n");
sql.append( "             			WHERE H.ACTDAT BETWEEN '"+str[1]+"' AND '"+str[2]+"'																\n");
sql.append( "										AND H.ATCODE ='"+str[3]+"'																													\n");
sql.append( "             			GROUP BY SUBSTR(H.ACTDAT,5,2)																												\n");
sql.append( "             ) S ) AS CUMULTAL,'' AS REMARK, '' AS VEND_CD, '' AS VENDER, SUBSTR(A.ACTDAT,3,4)||'33' LEVELS,					\n");
sql.append( "             '' AS FDCODE,'' AS FSDAT,'' AS FSNBR																											\n");
sql.append( "     FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B																												\n");
sql.append( "     WHERE A.ATCODE=B.ATCODE																																						\n");
if(!str[0].equals(""))  sql.append( " AND A.FDCODE='"+str[0]+"'																											\n");
if(!str[1].equals(""))	sql.append( " AND A.ACTDAT BETWEEN '"+str[1]+"' AND '"+str[2]+"'                            \n");
sql.append( "     AND A.ATCODE ='"+str[3]+"'																																				\n");
sql.append( "     GROUP BY B.ATDECR,B.ATCODE,B.ATKORNAM,																														\n");
sql.append( "     SUBSTR(A.ACTDAT,1,4)||'/'||SUBSTR(A.ACTDAT,5,2)||'/'||'33',																				\n");
//sql.append( "     SUBSTR(A.ACTDAT,1,6)||'33',																																			\n");
sql.append( "     SUBSTR(A.ACTDAT,3,4)||'33'																																				\n");
sql.append( " ) X																																																		\n");
sql.append( " GROUP BY X.ATDECR,X.ATCODE,X.ATKORNAM,X.ACTDAT,X.DETOT,X.CRTOT,X.SLPVLA,X.CUMULTAL,X.REMARK,X.VEND_CD, X.VENDER,X.LEVELS,	\n");
sql.append( " X.LEVELS,X.FDCODE,X.FSDAT,X.FSNBR																																			\n");

sql.append( " ORDER BY LEVELS \n");

logger.dbg.println(this, sql.toString());
		
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