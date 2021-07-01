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
public class a020004_s2 extends HttpServlet {
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
				String [] str = new String [3];
				str[0]	= req.getParameter("v_str1");		//현장코드
				str[1]	= req.getParameter("v_str2");		//가전표일자
				str[2]	= req.getParameter("v_str3");		//가전표번호

				for (int s=0;s<=2;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "FDCODE",  "FSDAT",   "FSNBR",  "FSSEQ", "FSNUM", "CHAAMT", "DAEAMT", 
					                              "ATCODE",  "ATKORNAM","ATDECR", "REMARK",  
					                              "FSREFSEQ01","FSREFSEQ02","FSREFSEQ03","FSREFSEQ04","FSREFSEQ05", 
				                                  "FSREFSEQ06","FSREFSEQ07","FSREFSEQ08","FSREFSEQ09",
					                              "FSREFCD01", "FSREFCD02", "FSREFCD03", "FSREFCD04", "FSREFCD05",
                                                  "FSREFCD06", "FSREFCD07", "FSREFCD08", "FSREFCD09",
                                                  "FSREFVAL01","FSREFVAL02","FSREFVAL03","FSREFVAL04","FSREFVAL05",
					                              "FSREFVAL06","FSREFVAL07","FSREFVAL08","FSREFVAL09",
					                              "FSRVALNM01","FSRVALNM02","FSRVALNM03","FSRVALNM04","FSRVALNM05",
                                                  "FSRVALNM06","FSRVALNM07","FSRVALNM08","FSRVALNM09",
					                              "CNT", "DOCUMCD", "DOCUMNM", "FSWRKDIV",
					                              "WRDT",	"WRID",	"UPDT",	"UPID" , 
					                              "BANJAEYN","COCODE", "DIVCD", "DEPTCD","ACTDAT",
					                              "ACTYYMM","ATCURTYPE","BGTDIV","BGTDEPT","TYPE_FSREFCD",
					                              "TYPE_FSREFVAL", "FUNDDIV","BJFSREFCD"
																				};

  

				int[] intArrCN = new int[]{  2, 9,  6,  5,  3,  15, 15, 
					                           7, 66, 1, 66, 
					                           2, 2, 2, 2, 2, 
					                           2, 2, 2, 2,
                                               4, 4,  4,  4,  4,
					                           4, 4,  4,  4,  
					                          30,30, 30, 30, 30, 
					                          30,30, 30, 30, 
					                          40,40, 40, 40, 40, 
					                          40,40, 40, 40,
					                           1,3,40,2, 
                                               8, 7,  8,  7, 
					                           1, 2,  4,  4, 8,
											   6, 1,  4,  4,  20,
					                           20, 2, 4     
																	}; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, 0,  0, 
					                           -1, -1, -1, -1,
                                               -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1,  
					                           -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1,  
											   -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1, 
                                               -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1,  
					                            0, -1, -1, -1,
					                           -1, -1, -1, -1, 
					                           -1, -1, -1, -1, -1,
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
				
					sql.append( "	SELECT X.FDCODE, X.FSDAT, X.FSNBR, X.FSSEQ, X.FSNUM, X.CHAAMT,X.DAEAMT, \n "); 
					sql.append( "		   MAX(X.ATCODE)ATCODE,        MAX(X.ATKORNAM)ATKORNAM,             \n "); 
					sql.append( "          MAX(X.ATDECR)ATDECR,        MAX(X.REMARK)REMARK,                 \n ");
					sql.append( "		   MAX(FSREFSEQ01)FSREFSEQ01,  MAX(FSREFSEQ02)FSREFSEQ02,           \n "); 
					sql.append( "		   MAX(FSREFSEQ03)FSREFSEQ03,  MAX(FSREFSEQ04)FSREFSEQ04,           \n "); 
					sql.append( "		   MAX(FSREFSEQ05)FSREFSEQ05,  MAX(FSREFSEQ06)FSREFSEQ06,           \n "); 
					sql.append( "		   MAX(FSREFSEQ07)FSREFSEQ07,  MAX(FSREFSEQ08)FSREFSEQ08,           \n "); 
					sql.append( "		   MAX(FSREFSEQ09)FSREFSEQ09,                                       \n "); 
					sql.append( "		   MAX(FSREFCD01)FSREFCD01,	   MAX(FSREFVAL01)FSREFVAL01,           \n "); 
					sql.append( "		   MAX(FSREFCD02)FSREFCD02,    MAX(FSREFVAL02)FSREFVAL02,           \n "); 
					sql.append( "		   MAX(FSREFCD03)FSREFCD03,	   MAX(FSREFVAL03)FSREFVAL03,           \n "); 
					sql.append( "		   MAX(FSREFCD04)FSREFCD04,	   MAX(FSREFVAL04)FSREFVAL04,           \n "); 
					sql.append( "		   MAX(FSREFCD05)FSREFCD05,    MAX(FSREFVAL05)FSREFVAL05,           \n "); 
					sql.append( "		   MAX(FSREFCD06)FSREFCD06,	   MAX(FSREFVAL06)FSREFVAL06,           \n "); 
					sql.append( "		   MAX(FSREFCD07)FSREFCD07,	   MAX(FSREFVAL07)FSREFVAL07,           \n "); 
					sql.append( "		   MAX(FSREFCD08)FSREFCD08,    MAX(FSREFVAL08)FSREFVAL08,           \n "); 
					sql.append( "		   MAX(FSREFCD09)FSREFCD09,	   MAX(FSREFVAL09)FSREFVAL09,           \n "); 
					sql.append( "	       MAX(FSRVALNM01)FSRVALNM01,  MAX(FSRVALNM02)FSRVALNM02,           \n ");
					sql.append( "	       MAX(FSRVALNM03)FSRVALNM03,  MAX(FSRVALNM04)FSRVALNM04,           \n ");
					sql.append( "	       MAX(FSRVALNM05)FSRVALNM05,  MAX(FSRVALNM06)FSRVALNM06,           \n ");
					sql.append( "	       MAX(FSRVALNM07)FSRVALNM07,  MAX(FSRVALNM08)FSRVALNM08,           \n ");
					sql.append( "	       MAX(FSRVALNM09)FSRVALNM09,                                       \n ");
					sql.append( "			 (COUNT(X.FSREFCD01)+COUNT(X.FSREFCD02)+COUNT(X.FSREFCD03)+COUNT(X.FSREFCD04)+COUNT(X.FSREFCD05)  \n "); 
					sql.append( "			 +COUNT(X.FSREFCD06)+COUNT(X.FSREFCD07)+COUNT(X.FSREFCD08)+COUNT(X.FSREFCD09))CNT ,               \n "); 
					sql.append( "		   MAX(X.DOCUMCD) DOCUMCD, MAX(X.DOCUMNM) DOCUMNM, MAX(X.FSWRKDIV)FSWRKDIV,                           \n "); 
					sql.append( "		   MAX(X.WRDT)WRDT, MAX(X.WRID)WRID, MAX(X.UPDT)UPDT, MAX(X.UPID) UPID,                               \n "); 
					sql.append( "		   MAX(X.BANJAEYN)BANJAEYN,MAX(X.COCODE)COCODE, MAX(X.ACTDAT)ACTDAT, MAX(X.ACTYYMM)ACTYYMM,           \n "); 
					sql.append( "	       MAX(X.DIVCD)DIVCD,MAX(DEPT)DEPTCD, MAX(X.BGTDIV)BGTDIV,MAX(X.ATCURTYPE)ATCURTYPE,                  \n "); 
					sql.append( "		   MAX(BGTDEPT)BGTDEPT, MAX(TYPE_FSREFCD)TYPE_FSREFCD, MAX(TYPE_FSREFVAL)TYPE_FSREFVAL,               \n "); 
					sql.append( "		   MAX(X.FUNDDIV)FUNDDIV, MAX(X.BJFSREFCD) BJFSREFCD                                                  \n "); 
					sql.append( "	   FROM(                                                                                                  \n "); 
					sql.append( "	         SELECT A.FDCODE, A.FSDAT, A.FSNBR, B.FSSEQ, B.ATCODE,                           \n "); 
					sql.append( "	                CASE WHEN B.ATCODE='1' THEN '노무비'                                       \n "); 
					sql.append( "	                     WHEN B.ATCODE='2' THEN '외주비'                                       \n "); 
					sql.append( "	                     WHEN B.ATCODE='3' THEN '장비비'                                       \n "); 
					sql.append( "	                     WHEN B.ATCODE='4' THEN '자재비'                                       \n "); 
					sql.append( "	                     WHEN B.ATCODE='5' THEN '전도금(경비)'                                  \n "); 
					sql.append( "	                     WHEN B.ATCODE='6' THEN '외주비부가세'                                  \n "); 
					sql.append( "	                     WHEN B.ATCODE='7' THEN '장비비부가세'                                  \n "); 
					sql.append( "	                     WHEN B.ATCODE='8' THEN '자재비부가세'                                  \n "); 
					sql.append( "	                     WHEN B.ATCODE='9' THEN '경비부가세'                                    \n "); 
					sql.append( "	                ELSE D.ATKORNAM END  ATKORNAM ,D.ATDECR, B.REMARK,                        \n "); 
					sql.append( "	                CASE WHEN B.ATDECR='1' THEN B.FSAMT ELSE 0 END CHAAMT,                    \n "); 
					sql.append( "				    CASE WHEN B.ATDECR='2' THEN B.FSAMT ELSE 0 END DAEAMT,                    \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='01' THEN C.FSREFSEQ END FSREFSEQ01,                \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='02' THEN C.FSREFSEQ END FSREFSEQ02,                \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='03' THEN C.FSREFSEQ END FSREFSEQ03,                \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='04' THEN C.FSREFSEQ END FSREFSEQ04,                \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='05' THEN C.FSREFSEQ END FSREFSEQ05,                \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='06' THEN C.FSREFSEQ END FSREFSEQ06,                \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='07' THEN C.FSREFSEQ END FSREFSEQ07,                \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='08' THEN C.FSREFSEQ END FSREFSEQ08,                \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='09' THEN C.FSREFSEQ END FSREFSEQ09,                \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='01' THEN C.FSREFCD END FSREFCD01,                  \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='02' THEN C.FSREFCD END FSREFCD02,                  \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='03' THEN C.FSREFCD END FSREFCD03,                  \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='04' THEN C.FSREFCD END FSREFCD04,                  \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='05' THEN C.FSREFCD END FSREFCD05,                  \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='06' THEN C.FSREFCD END FSREFCD06,                  \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='07' THEN C.FSREFCD END FSREFCD07,                  \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='08' THEN C.FSREFCD END FSREFCD08,                  \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='09' THEN C.FSREFCD END FSREFCD09,                  \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='01' THEN C.FSREFVAL END FSREFVAL01,                \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='02' THEN C.FSREFVAL END FSREFVAL02,                \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='03' THEN C.FSREFVAL END FSREFVAL03,                \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='04' THEN C.FSREFVAL END FSREFVAL04,                \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='05' THEN C.FSREFVAL END FSREFVAL05,                \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='06' THEN C.FSREFVAL END FSREFVAL06,                \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='07' THEN C.FSREFVAL END FSREFVAL07,                \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='08' THEN C.FSREFVAL END FSREFVAL08,                \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='09' THEN C.FSREFVAL END FSREFVAL09,                \n "); 
					
					sql.append( "					CASE WHEN C.FSREFSEQ ='01' THEN RTRIM(G.CDNAM) END FSRVALNM01,            \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='02' THEN RTRIM(G.CDNAM) END FSRVALNM02,            \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='03' THEN RTRIM(G.CDNAM) END FSRVALNM03,            \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='04' THEN RTRIM(G.CDNAM) END FSRVALNM04,            \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='05' THEN RTRIM(G.CDNAM) END FSRVALNM05,            \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='06' THEN RTRIM(G.CDNAM) END FSRVALNM06,            \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='07' THEN RTRIM(G.CDNAM) END FSRVALNM07,            \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='08' THEN RTRIM(G.CDNAM) END FSRVALNM08,            \n "); 
					sql.append( "					CASE WHEN C.FSREFSEQ ='09' THEN RTRIM(G.CDNAM) END FSRVALNM09,            \n "); 
					
					sql.append( "					CASE WHEN C.FSREFCD ='0002' THEN RTRIM(C.FSREFVAL) END DEPT,                                                           \n "); 
					sql.append( "					CASE WHEN C.FSREFCD ='0003' THEN RTRIM(C.FSREFVAL) END BGTDEPT,                                                        \n "); 
					sql.append( "					CASE WHEN H.TYPE ='B' THEN RTRIM(C.FSREFCD) END  TYPE_FSREFCD,                                                         \n "); 
					sql.append( "					CASE WHEN H.TYPE ='B' THEN RTRIM(C.FSREFVAL) END TYPE_FSREFVAL,                                                        \n "); 
					sql.append( "	                                                                                                                                       \n "); 
					sql.append( "					B.DOCUMCD,RTRIM(E.CDNAM)DOCUMNM,B.FSWRKDIV, B.BANJAEYN, A.COCODE, NVL(B.DIVCD,' ')DIVCD,                               \n "); 
					sql.append( "					B.WRDT, B.WRID, B.UPDT, B.UPID, A.ACTDAT, SUBSTR(A.ACTDAT,1,6) ACTYYMM,                                                \n "); 
					sql.append( "					D.ATCURTYPE,B.BGTDIV, B.FSNUM , RTRIM(D.FUNDIV) AS FUNDDIV , D.FSREFCD AS BJFSREFCD                                    \n "); 
					sql.append( "			   FROM ACCOUNT.FSLIPMST A                                                                                                     \n "); 
					sql.append( "			   LEFT JOIN ACCOUNT.FSLIPDTL B ON A.FDCODE = B.FDCODE AND A.FSDAT = B.FSDAT AND A.FSNBR = B.FSNBR                             \n "); 
					sql.append( "			   LEFT JOIN ACCOUNT.FSLIPREF C ON A.FDCODE = C.FDCODE AND A.FSDAT = C.FSDAT AND A.FSNBR = C.FSNBR  AND B.FSSEQ = C.FSSEQ      \n "); 
					sql.append( "			   LEFT JOIN ACCOUNT.ACTCODE D ON D.ATCODE = B.ATCODE                                                                          \n "); 
					sql.append( "			   LEFT JOIN ACCOUNT.COMMDTIL E ON E.CDCODE= B.DOCUMCD AND E.CMTYPE='0052'                                                     \n "); 
					sql.append( "			   LEFT JOIN ACCOUNT.COMMDTIL F ON C.FSREFCD = F.CDCODE AND F.CMTYPE='0050'                                                    \n "); 
					sql.append( "			   LEFT JOIN ACCOUNT.COMMDTIL G ON C.FSREFVAL = G.CDCODE AND C.FSREFCD=G.CMTYPE                                                \n "); 
					sql.append( "			   LEFT JOIN ACCOUNT.ACTREFCODE H ON B.ATCODE = H.ATCODE AND CAST(C.FSREFSEQ AS NUMERIC) = H.ARSEQ                             \n "); 
					sql.append( "		  	  WHERE A.FDCODE IS NOT NULL                                                                                                   \n "); 
					if(!str[0].equals("")) { sql.append( " AND A.FDCODE = '"+str[0]+"'\n"); }                                                  
					if(!str[1].equals("")) { sql.append( " AND A.FSDAT = '"+str[1]+"' \n"); }                                                 
					if(!str[2].equals("")) { sql.append( " AND A.FSNBR = '"+str[2]+"' \n"); }                                                   
					sql.append( " 	 ) X  ");
					sql.append( "  GROUP BY X.FDCODE, X.FSDAT, X.FSNBR, X.FSNUM,X.FSSEQ,X.CHAAMT,X.DAEAMT \n ");
					sql.append( "  ORDER BY X.FDCODE, X.FSDAT, X.FSNBR, X.FSNUM,X.FSSEQ                   \n ");
				
					//System.out.println("a020004_s2"+sql.toString());
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