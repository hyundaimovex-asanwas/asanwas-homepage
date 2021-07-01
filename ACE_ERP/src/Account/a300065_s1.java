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
public class a300065_s1 extends HttpServlet {
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
				String [] str = new String [5];
				str[0]	= req.getParameter("v_str1");		//지점코드
				str[1]	= req.getParameter("v_str2");		//접수일자
				str[2]	= req.getParameter("v_str3");		//접수번호
				str[3]	= req.getParameter("v_str4");		//회계일자
				str[4]	= req.getParameter("v_str5");		//APPNO

				int intyyyy=0;

				for (int s=0;s<=4;s++) {
					if (str[s]==null||str[s].equals("undefined")) str[s] = "";
				}
   
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "FDCODE",  "FSDAT",    "FSNBR",    "FSSEQ",    "FSNUM", 
						                          "SEQ",      "SEQ2",    "ATCODE",   "ATKORNAM", "ATDECR", 
					                              "DEAMT",    "CRAMT",   "VENDCD",   "VENDNM",     "REMARK", 
					                              "DOCUMCD",  "DOCUVAL", "ATDEBTYN", "BANJAEREF",
					                              
					                              "FSREFSEQ01","FSREFSEQ02","FSREFSEQ03","FSREFSEQ04","FSREFSEQ05", 
				                                  "FSREFSEQ06","FSREFSEQ07","FSREFSEQ08","FSREFSEQ09",
				                                  
					                              "FSREFCD01", "FSREFCD02", "FSREFCD03", "FSREFCD04", "FSREFCD05",
					                              "FSREFCD06", "FSREFCD07", "FSREFCD08", "FSREFCD09",
					                              
					                              "FSREFNM01","FSREFNM02","FSREFNM03","FSREFNM04","FSREFNM05",
					                              "FSREFNM06","FSREFNM07","FSREFNM08","FSREFNM09",
					                              
					                              "FSREFVAL01","FSREFVAL02","FSREFVAL03","FSREFVAL04","FSREFVAL05",
					                              "FSREFVAL06","FSREFVAL07","FSREFVAL08","FSREFVAL09",
					                             
					                              "FSRVALNM01","FSRVALNM02","FSRVALNM03","FSRVALNM04","FSRVALNM05",
					                              "FSRVALNM06","FSRVALNM07","FSRVALNM08","FSRVALNM09",
					                              "TYPE01",    "TYPE02",     "TYPE03",   "TYPE04",   "TYPE05",
					                              "TYPE06",    "TYPE07",     "TYPE08",   "TYPE09",
					                              "ARBALDIV01","ARBALDIV02","ARBALDIV03","ARBALDIV04","ARBALDIV05",
					                              "ARBALDIV06","ARBALDIV07","ARBALDIV08","ARBALDIV09",
					                              
					                              "COSTGB",  "COSTBGT",  "COSTBGTNM", "TAXNBR" , "TAXKND", "TAXDAT",
					                              "PAYGB",   "CURUNITCD","CURUNIT",   "FOUTAMT" 
					                             
																				};

				int[] intArrCN = new int[]{  2,  9,  6,  5,   3,  
						                      8,  4,  7, 66,   1,
						                     15, 15, 13, 62, 132, 
					                          3, 20,  1,  4, 
					                          2,  2,  2,  2,   2, 
					                          2,  2,  2,  2,
					                          4,  4,  4,  4,   4,
					                          4,  4,  4,  4,  
					                         40, 40, 40, 40,  40, 
						                     40, 40, 40, 40,
					                         30, 30, 30, 30,  30, 
					                         30, 30, 30, 30, 
					                         40, 40, 40, 40, 40, 
					                         40, 40, 40, 40,
					                          1,  1,  1,  1,  1,
					                          1,  1,  1,  1,  
					                          1,  1,  1,  1,  1,
					                          1,  1,  1,  1,  
					                           
					                          1,  6, 60, 11,  1,  8,  
					                          1,  2,  6, 15
					                         
																	}; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, 
						                      -1, -1, -1, -1, -1,
						                       0,  0, -1, -1, -1,
						                      -1, -1, -1, -1,
					                             
					                           -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1,  
					                           -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1,  
					                           -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1, 
					                           -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1, 
					                           -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1, 
					                           -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1, 
					                           -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1, 
					                       
					                           -1, -1, -1, -1, -1, -1,
					                           -1, -1, -1,  2
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					

					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT  '00'  AS FDCODE , 'A00000000'   AS FSDAT, '000000' AS FSNBR, '00000' AS FSSEQ, '000' AS FSNUM,             \n");
					sql.append( "        X.SEQ,X.SEQ2, X.ATCODE, C.ATKORNAM,  C.ATDECR,                                                               \n");
					sql.append( "        X.DEAMT, X.CRAMT ,X.VENDCD, X.VENDNM,  TRIM(SUBSTR(X.VENDREAMRK,INSTR(X.VENDREAMRK,'#-#')+3)) REMARK,        \n");
					sql.append( "        X.DOCUMCD, X.DOCUVAL, C.ATDEBTYN, COALESCE(MAX(C.FSREFCD),'')BANJAEREF,                                      \n");
					sql.append( "                                                                                                                     \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=1 THEN '0'||B.ARSEQ ELSE '' END) FSREFSEQ01,                                           \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=2 THEN '0'||B.ARSEQ ELSE '' END) FSREFSEQ02,                                           \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=3 THEN '0'||B.ARSEQ ELSE '' END) FSREFSEQ03,                                           \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=4 THEN '0'||B.ARSEQ ELSE '' END) FSREFSEQ04,                                           \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=5 THEN '0'||B.ARSEQ ELSE '' END) FSREFSEQ05,                                           \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=6 THEN '0'||B.ARSEQ ELSE '' END) FSREFSEQ06,                                           \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=7 THEN '0'||B.ARSEQ ELSE '' END) FSREFSEQ07,                                           \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=8 THEN '0'||B.ARSEQ ELSE '' END) FSREFSEQ08,                                           \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=9 THEN '0'||B.ARSEQ ELSE '' END) FSREFSEQ09,                                           \n");
					sql.append( "                                                                                                                     \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=1 THEN B.CDCODE ELSE '' END) FSREFCD01,                                                \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=2 THEN B.CDCODE ELSE '' END) FSREFCD02,                                                \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=3 THEN B.CDCODE ELSE '' END) FSREFCD03,                                                \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=4 THEN B.CDCODE ELSE '' END) FSREFCD04,                                                \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=5 THEN B.CDCODE ELSE '' END) FSREFCD05,                                                \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=6 THEN B.CDCODE ELSE '' END) FSREFCD06,                                                \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=7 THEN B.CDCODE ELSE '' END) FSREFCD07,                                                \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=8 THEN B.CDCODE ELSE '' END) FSREFCD08,                                                \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=9 THEN B.CDCODE ELSE '' END) FSREFCD09,                                                \n");
					sql.append( "                                                                                                                     \n");
					sql.append( "        MIN(CASE WHEN B.ARSEQ=1 THEN F.CDNAM ELSE '' END) FSREFNM01,                                                 \n");
					sql.append( "        MIN(CASE WHEN B.ARSEQ=2 THEN F.CDNAM ELSE '' END) FSREFNM02,                                                 \n");
					sql.append( "        MIN(CASE WHEN B.ARSEQ=3 THEN F.CDNAM ELSE '' END) FSREFNM03,                                                 \n");
					sql.append( "        MIN(CASE WHEN B.ARSEQ=4 THEN F.CDNAM ELSE '' END) FSREFNM04,                                                 \n");
					sql.append( "        MIN(CASE WHEN B.ARSEQ=5 THEN F.CDNAM ELSE '' END) FSREFNM05,                                                 \n");
					sql.append( "        MIN(CASE WHEN B.ARSEQ=6 THEN F.CDNAM ELSE '' END) FSREFNM06,                                                 \n");
					sql.append( "        MIN(CASE WHEN B.ARSEQ=7 THEN F.CDNAM ELSE '' END) FSREFNM07,                                                 \n");
					sql.append( "        MIN(CASE WHEN B.ARSEQ=8 THEN F.CDNAM ELSE '' END) FSREFNM08,                                                 \n");
					sql.append( "        MIN(CASE WHEN B.ARSEQ=9 THEN F.CDNAM ELSE '' END) FSREFNM09,                                                 \n");
					sql.append( "                                                                                                                     \n");
					sql.append( "        '' AS FSREFVAL01,'' AS FSREFVAL02,                                                                           \n");
					sql.append( "        '' AS FSREFVAL03,'' AS FSREFVAL04,                                                                           \n");
					sql.append( "        '' AS FSREFVAL05,'' AS FSREFVAL06,                                                                           \n");
					sql.append( "        '' AS FSREFVAL07,'' AS FSREFVAL08,                                                                           \n");
					sql.append( "        '' AS FSREFVAL09,                                                                                            \n");
					sql.append( "        '' AS FSRVALNM01,'' AS FSRVALNM02,                                                                           \n");
					sql.append( "        '' AS FSRVALNM03,'' AS FSRVALNM04,                                                                           \n");
					sql.append( "        '' AS FSRVALNM05,'' AS FSRVALNM06,                                                                           \n");
					sql.append( "        '' AS FSRVALNM07,'' AS FSRVALNM08,                                                                           \n");
					sql.append( "        '' AS FSRVALNM09,                                                                                            \n");
					sql.append( "                                                                                                                     \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=1 THEN B.TYPE ELSE '' END) TYPE01,                                                     \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=2 THEN B.TYPE ELSE '' END) TYPE02,                                                     \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=3 THEN B.TYPE ELSE '' END) TYPE03,                                                     \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=4 THEN B.TYPE ELSE '' END) TYPE04,                                                     \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=5 THEN B.TYPE ELSE '' END) TYPE05,                                                     \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=6 THEN B.TYPE ELSE '' END) TYPE06,                                                     \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=7 THEN B.TYPE ELSE '' END) TYPE07,                                                     \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=8 THEN B.TYPE ELSE '' END) TYPE08,                                                     \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=9 THEN B.TYPE ELSE '' END) TYPE09,                                                     \n");
					sql.append( "                                                                                                                     \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=1 THEN B.ARBALDIV ELSE '' END) ARBALDIV01,                                             \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=2 THEN B.ARBALDIV ELSE '' END) ARBALDIV02,                                             \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=3 THEN B.ARBALDIV ELSE '' END) ARBALDIV03,                                             \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=4 THEN B.ARBALDIV ELSE '' END) ARBALDIV04,                                             \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=5 THEN B.ARBALDIV ELSE '' END) ARBALDIV05,                                             \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=6 THEN B.ARBALDIV ELSE '' END) ARBALDIV06,                                             \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=7 THEN B.ARBALDIV ELSE '' END) ARBALDIV07,                                             \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=8 THEN B.ARBALDIV ELSE '' END) ARBALDIV08,                                             \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=9 THEN B.ARBALDIV ELSE '' END) ARBALDIV09,                                             \n");
					sql.append( "        X.COSTGB, X.COSTBGT,                                                                                         \n");
					sql.append( "        MAX(CASE WHEN X.COSTGB='1' THEN H.CDNAM                                                                      \n");
					sql.append( "                 WHEN X.COSTGB='2' THEN G.CDNAM ELSE '' END) COSTBGTNM,                                              \n");
					sql.append( "        X.TAXNBR, X.TAXKND, X.TAXDAT, X.PAYGB, X.CURUNITCD, X.CURUNIT, X.FOUTAMT                                     \n");
					sql.append( "  FROM (                                                                                                             \n");
					sql.append( "         --자금신청내역 ( 매출원가 또는 판매관리비 )                                                                           \n");
					sql.append( "         SELECT A.ATCODE||'1' AS SEQ, A.ATCODE,                                                                      \n");
					sql.append( "                CASE WHEN Z.ATDECR ='1' THEN A.SUPAMT ELSE 0 END AS DEAMT,                                           \n");
					sql.append( "                CASE WHEN Z.ATDECR ='2' THEN A.SUPAMT ELSE 0 END AS CRAMT,                                           \n");
					sql.append( "                A.VENDCD, A.VENDNM, A.COSTGB, A.COSTBGT,                                                             \n");
					sql.append( "                A.REMARK, '' DOCUMCD, '' DOCUVAL,   A.TAXNBR, B.TAXKND, B.TAXDAT,                                    \n");
					sql.append( "                (A.VENDCD||'#-#'||A.REMARK) VENDREAMRK, ROWNUM AS SEQ2, '' PAYGB , ''CURUNIT, 0 FOUTAMT, ''CURUNITCD \n");
					sql.append( "           FROM ACCOUNT.ACAPPFUND A, ACCOUNT.ATTAXMST B, ACCOUNT.ACTCODE Z                                           \n");
					sql.append( "          WHERE 1=1--( A.APPFSDAT='' OR A.APPFSDAT IS NULL )                                                              \n");
					sql.append( "            AND A.ATCODE = Z.ATCODE(+)                                                                               \n");
					sql.append( "            AND A.TAXNBR = B.TAXNBR(+)                                                                               \n");
					sql.append( "            AND A.APPNO IN ("+str[4]+")                                                                              \n");
					sql.append( "          UNION ALL                                                                                                  \n");
					sql.append( " 	        --상대계정 ( 외상매입금 또는 미지급금 )                                                                            \n");
					sql.append( "         SELECT A.ATCODE||'2' AS SEQ,                                                                                \n");
					sql.append( "                CASE WHEN SUBSTR(A.ATCODE,1,2)='44' THEN  '2100510' ELSE '2100110' END ATCODE,                       \n");
					sql.append( "                CASE WHEN Z.ATDECR ='1' THEN 0 ELSE A.SUPAMT+A.SUPVATAMT END AS DEAMT,                               \n");
					sql.append( "                CASE WHEN Z.ATDECR ='2' THEN 0 ELSE A.SUPAMT+A.SUPVATAMT END AS CRAMT,                               \n");
					sql.append( "                A.VENDCD,A.VENDNM, A.COSTGB, A.COSTBGT,                                                              \n");
					sql.append( "                A.REMARK, '' DOCUMCD, '' DOCUVAL,   A.TAXNBR,   '' TAXKND,  '' TAXDAT,                               \n");
					sql.append( "                (A.VENDCD||'#-#'||A.REMARK) VENDREAMRK, 9000 AS SEQ2,A.PAYGB , A.CURUNIT, A.FOUTAMT, A.CURUNITCD   \n");
					sql.append( "           FROM ACCOUNT.ACAPPFUND A,  ACCOUNT.ACTCODE Z                                                              \n");
					sql.append( "          WHERE 1=1--( A.APPFSDAT='' OR A.APPFSDAT IS NULL )                                                              \n");
					sql.append( "            AND A.ATCODE = Z.ATCODE(+)                                                                               \n");
					sql.append( "            AND A.APPNO IN ("+str[4]+")                                                                              \n");
					sql.append( "          UNION ALL                                                                                                  \n");
					sql.append( "                                                                                                                     \n");
					sql.append( "          --선급부가가치세                                                                                           \n");
					sql.append( "        SELECT A.ATCODE||'3' AS SEQ,                                                                                 \n");
					sql.append( "               '1112300' AS ATCODE,                                                                                  \n");
					sql.append( "               SUM(CASE WHEN ATDECR ='1' THEN A.SUPVATAMT ELSE 0 END) AS DEAMT,                                      \n");
					sql.append( "               SUM(CASE WHEN ATDECR ='2' THEN A.SUPVATAMT ELSE 0 END) AS CRAMT,                                      \n");
					sql.append( "               A.VENDCD, A.VENDNM,   ''COSTGB, '' COSTBGT,                                                           \n");
					sql.append( "                A.REMARK, '' DOCUMCD, '' DOCUVAL,  A.TAXNBR,B.TAXKND, B.TAXDAT,                                      \n");
					sql.append( "               MAX(A.VENDCD||'#-#'||A.REMARK) VENDREAMRK, 1000 AS SEQ2 , '' PAYGB , ''CURUNIT, 0 FOUTAMT, ''CURUNITCD\n");
					sql.append( "          FROM ACCOUNT.ACAPPFUND A, ACCOUNT.ATTAXMST B, ACCOUNT.ACTCODE Z                                            \n");
					sql.append( "         WHERE 1=1--( A.APPFSDAT='' OR A.APPFSDAT IS NULL )                                                               \n");
					sql.append( "           AND PURGB='T'                                                                                             \n");
					sql.append( "           AND A.ATCODE = Z.ATCODE(+)                                                                                \n");
					sql.append( "           AND A.TAXNBR = B.TAXNBR                                                                                   \n");
					sql.append( "           AND B.TAXKND IN ( '1','4')                                                                                \n");
					sql.append( "           AND A.APPNO IN ("+str[4]+")                                                                               \n");
					sql.append( "         GROUP BY  A.ATCODE, A.VENDCD, A.VENDNM, A.REMARK,  A.TAXNBR,B.TAXKND, B.TAXDAT                              \n");
					sql.append( "         ORDER BY SEQ2,SEQ                                                                                           \n");
					sql.append( "  )X                                                                                                                 \n");
					sql.append( "  LEFT JOIN ACCOUNT.ACTREFCODE B ON X.ATCODE = B.ATCODE                                                              \n");
					sql.append( "  LEFT JOIN ACCOUNT.ACTCODE C ON X.ATCODE = C.ATCODE                                                                 \n");
					sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL F ON F.CDCODE = B.CDCODE AND F.CMTYPE='0050'                                            \n");
					sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL G ON G.CDCODE = X.COSTBGT AND G.CMTYPE='0003'                                           \n");
					sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL H ON H.CDCODE = X.COSTBGT AND H.CMTYPE='0030'                                           \n");
					sql.append( "                                                                                                                     \n");
					sql.append( "  GROUP BY X.SEQ,X.SEQ2, X.ATCODE, C.ATKORNAM, C.ATDECR, X.DEAMT, X.CRAMT,                                           \n");
					sql.append( "           X.VENDCD, X.VENDNM, X.REMARK, C.ATDEBTYN, X.DOCUMCD, X.DOCUVAL,X.VENDREAMRK, X.COSTGB, X.COSTBGT,         \n");
					sql.append( "            X.TAXNBR,X.TAXKND, X.TAXDAT, X.PAYGB,    X.CURUNITCD, X.CURUNIT, X.FOUTAMT                               \n");
					sql.append( "  ORDER BY X.VENDCD, X.REMARK, X.SEQ2, X.SEQ          \n");
								
					//System.out.println("a300065_S1 : " + sql);
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