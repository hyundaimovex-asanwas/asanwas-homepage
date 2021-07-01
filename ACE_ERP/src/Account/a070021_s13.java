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
public class a070021_s13 extends HttpServlet {
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
				String  str2 = req.getParameter("v_str2");    //회계년월
				String  str3 = req.getParameter("v_str3");    //지급일자
				String  str4 = req.getParameter("v_str4");    //지급구분 1- 현금 , 2 - 어음 
				String  str5 = req.getParameter("v_str5");    //접수일자
				String  str6 = req.getParameter("v_str6");    //접수일자

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
		
				GauceRes.enableFirstRow(dSet);
				

				String[] strArrCN = new String[]{"FDCODE",      "FSDAT",      "FSNBR",       "FSSEQ",         "FSNUM",
                                                 "ATCODE",      "ATKORNAM",   "ATDECR",      "DEAMT",         "CRAMT",
                                                 "VEND_CD",     "VEND_NM",    "REMARK",      "DOCUMCD",       "DOCUVAL",
                                                 "ATDEBTYN" ,   "BANJAEREF",
												 "FSREFSEQ01",  "FSREFSEQ02", "FSREFSEQ03",  "FSREFSEQ04",    "FSREFSEQ05", 
												 "FSREFSEQ06",  "FSREFSEQ07", "FSREFSEQ08",  "FSREFSEQ09",
												 "FSREFCD01",   "FSREFCD02",  "FSREFCD03",   "FSREFCD04",     "FSREFCD05",
												 "FSREFCD06",   "FSREFCD07",  "FSREFCD08",   "FSREFCD09",
												 "FSREFNM01",   "FSREFNM02",  "FSREFNM03",   "FSREFNM04",     "FSREFNM05",
												 "FSREFNM06",   "FSREFNM07",  "FSREFNM08",   "FSREFNM09",   
												 "FSREFVAL01",  "FSREFVAL02", "FSREFVAL03",  "FSREFVAL04",    "FSREFVAL05",
												 "FSREFVAL06",  "FSREFVAL07", "FSREFVAL08",  "FSREFVAL09",
												 "FSRVALNM01",  "FSRVALNM02", "FSRVALNM03",  "FSRVALNM04",    "FSRVALNM05",
												 "FSRVALNM06",  "FSRVALNM07", "FSRVALNM08",  "FSRVALNM09",
												 "TYPE01",      "TYPE02",     "TYPE03",      "TYPE04",        "TYPE05",
												 "TYPE06",      "TYPE07",     "TYPE08",      "TYPE09",
												 "ARBALDIV01",  "ARBALDIV02", "ARBALDIV03",  "ARBALDIV04",    "ARBALDIV05",
												 "ARBALDIV06",  "ARBALDIV07", "ARBALDIV08",  "ARBALDIV09",
												 "PAYDAT",      "FULDAT"				                                          
                                                }; 

				int[] intArrCN = new int[]{ 2 ,  9,   6,   5,   3,
	                                        7,  66,  1,   15, 15,
	                                        13, 32,  132, 3, 20,
	                                        4 , 4,
											2, 2, 2, 2, 2, 
											2, 2, 2, 2,
											4, 4,  4,  4,  4,
											4, 4,  4,  4,  
											40,40, 40, 40, 40, 
											40,40, 40, 40,  
											30,30, 30, 30, 30, 
											30,30, 30, 30, 
											40,40, 40, 40, 40, 
											40,40, 40, 40,
											1, 1,  1,  1,  1,
											1, 1,  1,  1,  
											1, 1,  1,  1,  1,
											1, 1,  1,  1,
											8,8
					                      }; 
					
				int[] intArrCN2 = new int[]{-1,-1,-1,-1,-1,
											-1, -1,-1,  0, 0,
											-1,-1, -1,  -1,-1,
											-1, -1 ,
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
											-1,-1
                                           }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT  '"+str1+"'  AS FDCODE , '"+str5+"' AS FSDAT, '000000' AS FSNBR, '00000' AS FSSEQ, '000' AS FSNUM,    \n");
					
					sql.append( "        X.ATCODE, C.ATKORNAM, C.ATDECR,  X.DEAMT, X.CRAMT ,X.VEND_CD , D.VEND_NM ,  \n");
					sql.append( "        X.REMARK,X.DOCUMCD,X.DOCUVAL ,                                                          \n");
					sql.append( "        C.ATDEBTYN, COALESCE(MAX(C.FSREFCD),'')BANJAEREF,                                       \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=1 THEN '0'||B.ARSEQ ELSE '' END) FSREFSEQ01,                      \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=2 THEN '0'||B.ARSEQ ELSE '' END) FSREFSEQ02,                      \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=3 THEN '0'||B.ARSEQ ELSE '' END) FSREFSEQ03,                      \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=4 THEN '0'||B.ARSEQ ELSE '' END) FSREFSEQ04,                      \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=5 THEN '0'||B.ARSEQ ELSE '' END) FSREFSEQ05,                      \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=6 THEN '0'||B.ARSEQ ELSE '' END) FSREFSEQ06,                      \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=7 THEN '0'||B.ARSEQ ELSE '' END) FSREFSEQ07,                      \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=8 THEN '0'||B.ARSEQ ELSE '' END) FSREFSEQ08,                      \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=9 THEN '0'||B.ARSEQ ELSE '' END) FSREFSEQ09,                      \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=1 THEN B.CDCODE ELSE '' END) FSREFCD01,                           \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=2 THEN B.CDCODE ELSE '' END) FSREFCD02,                           \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=3 THEN B.CDCODE ELSE '' END) FSREFCD03,                           \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=4 THEN B.CDCODE ELSE '' END) FSREFCD04,                           \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=5 THEN B.CDCODE ELSE '' END) FSREFCD05,                           \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=6 THEN B.CDCODE ELSE '' END) FSREFCD06,                           \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=7 THEN B.CDCODE ELSE '' END) FSREFCD07,                           \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=8 THEN B.CDCODE ELSE '' END) FSREFCD08,                           \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=9 THEN B.CDCODE ELSE '' END) FSREFCD09,                           \n");
					sql.append( "        MIN(CASE WHEN B.ARSEQ=1 THEN F.CDNAM ELSE '' END) FSREFNM01,                            \n");
					sql.append( "        MIN(CASE WHEN B.ARSEQ=2 THEN F.CDNAM ELSE '' END) FSREFNM02,                            \n");
					sql.append( "        MIN(CASE WHEN B.ARSEQ=3 THEN F.CDNAM ELSE '' END) FSREFNM03,                            \n");
					sql.append( "        MIN(CASE WHEN B.ARSEQ=4 THEN F.CDNAM ELSE '' END) FSREFNM04,                            \n");
					sql.append( "        MIN(CASE WHEN B.ARSEQ=5 THEN F.CDNAM ELSE '' END) FSREFNM05,                            \n");
					sql.append( "        MIN(CASE WHEN B.ARSEQ=6 THEN F.CDNAM ELSE '' END) FSREFNM06,                            \n");
					sql.append( "        MIN(CASE WHEN B.ARSEQ=7 THEN F.CDNAM ELSE '' END) FSREFNM07,                            \n");
					sql.append( "        MIN(CASE WHEN B.ARSEQ=8 THEN F.CDNAM ELSE '' END) FSREFNM08,                            \n");
					sql.append( "        MIN(CASE WHEN B.ARSEQ=9 THEN F.CDNAM ELSE '' END) FSREFNM09,                            \n");
					sql.append( "        '' AS FSREFVAL01,'' AS FSREFVAL02,              \n");
					sql.append( "        '' AS FSREFVAL03,'' AS FSREFVAL04,              \n");
					sql.append( "        '' AS FSREFVAL05,'' AS FSREFVAL06,              \n");
					sql.append( "        '' AS FSREFVAL07,'' AS FSREFVAL08,              \n");
					sql.append( "        '' AS FSREFVAL09,                               \n");					
					sql.append( "        '' AS FSRVALNM01,'' AS FSRVALNM02,              \n");
					sql.append( "        '' AS FSRVALNM03,'' AS FSRVALNM04,              \n");
					sql.append( "        '' AS FSRVALNM05,'' AS FSRVALNM06,              \n");
					sql.append( "        '' AS FSRVALNM07,'' AS FSRVALNM08,              \n");
					sql.append( "        '' AS FSRVALNM09,                               \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=1 THEN B.TYPE ELSE '' END) TYPE01,                                \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=2 THEN B.TYPE ELSE '' END) TYPE02,                                \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=3 THEN B.TYPE ELSE '' END) TYPE03,                                \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=4 THEN B.TYPE ELSE '' END) TYPE04,                                \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=5 THEN B.TYPE ELSE '' END) TYPE05,                                \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=6 THEN B.TYPE ELSE '' END) TYPE06,                                \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=7 THEN B.TYPE ELSE '' END) TYPE07,                                \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=8 THEN B.TYPE ELSE '' END) TYPE08,                                \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=9 THEN B.TYPE ELSE '' END) TYPE09,                                \n");
					sql.append( "                                                                                                \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=1 THEN B.ARBALDIV ELSE '' END) ARBALDIV01,                        \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=2 THEN B.ARBALDIV ELSE '' END) ARBALDIV02,                        \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=3 THEN B.ARBALDIV ELSE '' END) ARBALDIV03,                        \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=4 THEN B.ARBALDIV ELSE '' END) ARBALDIV04,                        \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=5 THEN B.ARBALDIV ELSE '' END) ARBALDIV05,                        \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=6 THEN B.ARBALDIV ELSE '' END) ARBALDIV06,                        \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=7 THEN B.ARBALDIV ELSE '' END) ARBALDIV07,                        \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=8 THEN B.ARBALDIV ELSE '' END) ARBALDIV08,                        \n");
					sql.append( "        MAX(CASE WHEN B.ARSEQ=9 THEN B.ARBALDIV ELSE '' END) ARBALDIV09,                        \n");
					sql.append( "        X.PAYDAT, X.FULDAT                                                                      \n");
					sql.append( " FROM (                                                                                         \n");
					sql.append( "     SELECT '1' SEQ, A.ATCODE, A.VENDCD AS VEND_CD, 0 DEAMT,                                    \n");
					sql.append( "            0 CRAMT, MAX(A.REMARK)REMARK, '' DOCUMCD , '' DOCUVAL, ''PAYDAT, '' FULDAT          \n");
					sql.append( "       FROM ACCOUNT.AETCPAY A                                                                   \n");
					sql.append( "      WHERE A.CHKBILL ='T'                                                                      \n");
					sql.append( "        AND A.FDCODE =   '"+str1+"'                                                             \n");
					sql.append( "        AND (A.ACTDAT LIKE  '"+str2+"%' OR A.ACTDAT LIKE  '"+str6+"%')                          \n");
					sql.append( "        AND A.PAYDAT = '"+str3+"'                                                               \n");
					sql.append( "        AND RTRIM(A.FSDAT) IS NULL                                                              \n");
					sql.append( "      GROUP BY A.ATCODE, A.VENDCD                                                               \n");
					sql.append( "      UNION ALL                                                                                 \n");
					sql.append( "     SELECT '2' SEQ,            \n");
					sql.append( "            CASE WHEN A.ATCODE ='2100110' THEN '2100120' WHEN A.ATCODE ='2100510' THEN '2100530' END  ATCODE,    \n");
					sql.append( "            A.VENDCD VEND_CD, 0 DEAMT, SUM(A.JANAMT)CRAMT,           \n");
					sql.append( "            MAX(A.REMARK)REMARK, '' DOCUMCD , '' DOCUVAL , MAX(A.PAYDAT)PAYDAT, A.FULDAT        \n");
					sql.append( "       FROM ACCOUNT.AETCPAY A                                                                   \n");
					sql.append( "      WHERE A.CHKBILL ='T'                                                                      \n");
					sql.append( "        AND A.FDCODE ='"+str1+"'                                                                \n");
					sql.append( "        AND (A.ACTDAT LIKE  '"+str2+"%' OR A.ACTDAT LIKE  '"+str6+"%')                          \n");
					sql.append( "        AND A.PAYDAT =  '"+str3+"'                                                              \n");
					sql.append( "        AND RTRIM(A.FSDAT) IS NULL                                                              \n");
					sql.append( "      GROUP BY A.ATCODE, A.VENDCD,A.FULDAT                                                      \n");
					sql.append( "      ) X                                                                                       \n");
					sql.append( "  LEFT JOIN ACCOUNT.ACTREFCODE B ON X.ATCODE = B.ATCODE                                         \n");
					sql.append( "  LEFT JOIN ACCOUNT.ACTCODE C ON X.ATCODE = C.ATCODE                                            \n");
					sql.append( "  LEFT JOIN ACCOUNT.GCZM_VENDER D ON X.VEND_CD = D.VEND_CD                                      \n");
					sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL F ON F.CDCODE = B.CDCODE AND F.CMTYPE='0050'                       \n");
					sql.append( "                                                                                                \n");
					sql.append( "  GROUP BY  X.SEQ, X.ATCODE, C.ATKORNAM,C.ATDECR, X.DEAMT, X.CRAMT, X.VEND_CD, D.VEND_NM,       \n");
					sql.append( "            X.REMARK, C.ATDEBTYN, X.DOCUMCD, X.DOCUVAL, X.PAYDAT, X.FULDAT                      \n");
					sql.append( "  ORDER BY  D.VEND_NM, X.ATCODE,  X.FULDAT                                                      \n");

					//logger.dbg.println( this, sql.toString() ); 
					//System.out.println("a070021_s13:;"+sql.toString());				
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