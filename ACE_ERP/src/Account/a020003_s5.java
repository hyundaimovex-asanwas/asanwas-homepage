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
public class a020003_s5 extends HttpServlet {
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
			  
				String [] str = new String [11];
				str[0]	= req.getParameter("v_str1");		//지점
				str[1]	= req.getParameter("v_str2");		//처리기간FR
				str[2]	= req.getParameter("v_str3");		//처리기간TO
				str[3]	= req.getParameter("v_str4");		//구분
				str[4]	= req.getParameter("v_str5");		//거래처FR
				str[5]	= req.getParameter("v_str6");		//계정과목FR
				str[6]	= req.getParameter("v_str7");		//관리항목
				str[7]  = req.getParameter("v_str8");   //관리항목FR
				str[8]  = req.getParameter("v_str9");   //관리항목to
       
				for (int s=0;s<=10;s++) {
					if(str[s]==null) str[s] = "";
				}

				if(str[3].equals("N")){       //미결
					str[9] ="'Y'";
					str[10] ="'0'";
				}else if(str[3].equals("Y")){ //완료
					str[9] ="'9'";
					str[10] ="'1'";
				}else if(str[3].equals("A")){ //전체
					str[9] ="'Y','9'";
					str[10]="'0','1'";

				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CHK",	      "FDCODE",    "FSDAT",   "FSNBR",	 "FSSEQ", 
				                                  "ATCODE",     "ATKORNAM",  "SSDAT",   "SSNBR",   "FSNUM", 
					                                "GUBUN",      "REMARK",    "CHAAMT",	"DAEAMT" , "JANAMT", 
					                                "BANJAEAMT",  "VENDCD",    "VENDNM",  "DEPTCD",  "DEPTNM",
					                                "FSREFCD",    "FSREFVAL",  "FSREFNM",  "COCODE",  "DIVCD",  
																					"SSNBR1",     "ACTDAT",    "FSSTAT",   "FSREFCD2",    "FSREFVAL2",  "FSREFNM2"
					                                 }; 

				int[] intArrCN = new int[]{  1, 2,  9, 6, 5, 
					                           7, 66, 9, 6, 3, 
					                           10, 132,15,15,15,
					                          15, 20, 32,4, 30,
					                          4,  20, 40,2, 4, 
																		16, 8,  1 , 4,  20, 40,
					                        }; 
				int[] intArrCN2 = new int[]{ -1, -1,-1, -1, -1,
					                           -1, -1,-1, -1, -1,
					                           -1, -1, 0,  0,  0,
					                            0, -1,-1, -1, -1,
					                           -1, -1,-1, -1, -1, 
                                     -1 ,-1,-1, -1,-1, -1
					                           }; 
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( "  SELECT  ''CHK,    A.FDCODE,  A.FSDAT, A.FSNBR,  A.FSSEQ,                                            \n" );
					sql.append( "          A.ATCODE, C.ATKORNAM,M.SSDAT,  M.SSNBR, A.FSNUM,                                            \n" ); 
					sql.append( "          CASE WHEN '"+str[3]+"'='N' THEN 'N'                                                      \n" );
					sql.append( "               WHEN '"+str[3]+"'='Y' THEN 'Y' END GUBUN, A.REMARK,                                 \n" );
					sql.append( "          CASE WHEN A.ATDECR='1' THEN COALESCE(A.FSAMT,0)                                             \n" );
					sql.append( "               WHEN A.ATDECR='2' THEN 0 END CHAAMT,                                                   \n" );
					sql.append( "          CASE WHEN A.ATDECR='1' THEN 0                                                               \n" );
					sql.append( "               WHEN A.ATDECR='2' THEN COALESCE(A.FSAMT,0) END DAEAMT,                                 \n" );
					sql.append( "          CASE WHEN A.ATDECR='1' THEN COALESCE(A.FSAMT,0)                                             \n" );
					sql.append( "               WHEN A.ATDECR='2' THEN COALESCE(A.FSAMT,0) END JANAMT,                                 \n" );
					sql.append( "          0 BANJAEAMT,                                                                                \n" );
					sql.append( "          CASE WHEN B2.FSREFCD = '0002' THEN COALESCE(B2.FSREFVAL,'') END DEPTCD, E2.CDNAM DEPTNM,    \n" );
					sql.append( "          CASE WHEN B.FSREFCD = '0020'  THEN COALESCE(B.FSREFVAL,'')  END VENDCD, E.CDNAM VENDNM,     \n" );
					sql.append( "          '"+str[6]+"' FSREFCD,  \n" );
					sql.append( "          CASE WHEN B3.FSREFCD='"+str[6]+"' THEN COALESCE(B3.FSREFVAL,'') END FSREFVAL, E3.CDNAM FSREFNM, \n" );
					sql.append( "          M.COCODE, A.DIVCD,                            \n" );
					sql.append( "          M.SSDAT||'-'||M.SSNBR AS SSNBR1, M.ACTDAT, M.FSSTAT, \n" );
					sql.append( "          E4.CMTYPE FSREFCD2, E4.CDCODE FSREFVAL2, E4.CDNAM FSREFNM2 \n" );
					sql.append( "       FROM ACCOUNT.FSLIPDTL A, ACCOUNT.FSLIPREF B, ACCOUNT.ACTCODE C, ACCOUNT.FSLIPMST M             \n" );
					sql.append( "       LEFT JOIN ACCOUNT.FSLIPREF B2 ON A.FDCODE= B2.FDCODE                                           \n" );
					sql.append( "                                    AND A.FSDAT = B2.FSDAT                                            \n" );
					sql.append( "                                    AND A.FSNBR = B2.FSNBR                                            \n" );
					sql.append( "                                    AND A.FSSEQ = B2.FSSEQ                                            \n" );
					sql.append( "                                    AND B2.FSREFCD = '0002'                                           \n" );
					sql.append( "                                    AND A.FDCODE = '"+str[0]+"'                                       \n" );
					sql.append( "                                    AND A.ATCODE = '"+str[5]+"'                                          \n" );
					sql.append( "                                    AND A.BANJAEYN IN ("+str[9]+")                                                \n" );
					sql.append( "       LEFT JOIN ACCOUNT.FSLIPREF B3 ON A.FDCODE= B3.FDCODE                                           \n" );
					sql.append( "                                    AND A.FSDAT = B3.FSDAT                                            \n" );
					sql.append( "                                    AND A.FSNBR = B3.FSNBR                                            \n" );
					sql.append( "                                    AND A.FSSEQ = B3.FSSEQ                                            \n" );
					sql.append( "                                    AND B3.FSREFCD ='"+str[6]+"' \n" );
					if(!str[7].equals("")&&!str[8].equals(""))sql.append( "    AND B3.FSREFVAL>='"+str[7]+"' AND  B3.FSREFVAL<='"+str[8]+"'           \n" );					
					sql.append( "                                    AND A.FDCODE = '"+str[0]+"'   \n" );
					sql.append( "                                    AND A.ATCODE='"+str[5]+"'     \n" );
					sql.append( "                                    AND A.BANJAEYN IN ("+str[9]+")             \n" );
					sql.append( "       LEFT JOIN ACCOUNT.COMMDTIL E ON B.FSREFVAL = E.CDCODE AND E.CMTYPE='0020'         \n" );
					sql.append( "       LEFT JOIN ACCOUNT.COMMDTIL E2 ON B2.FSREFVAL = E2.CDCODE AND E2.CMTYPE='0002'     \n" );
					sql.append( "       LEFT JOIN ACCOUNT.COMMDTIL E3 ON B3.FSREFVAL = E3.CDCODE AND E3.CMTYPE='"+str[6]+"' \n" );
					sql.append( "       LEFT JOIN ACCOUNT.COMMDTIL E4 ON E4.CDCODE = E3.GBCD AND E4.CMTYPE=E3.CDREMARK \n");
					sql.append( "      WHERE A.FDCODE =B.FDCODE                                                                        \n" );
					sql.append( "        AND A.FSDAT = B.FSDAT                                                                         \n" );
					sql.append( "        AND A.FSNBR = B.FSNBR                                                                         \n" );
					sql.append( "        AND A.FSSEQ = B.FSSEQ                                                                         \n" );
					sql.append( "        AND A.FDCODE =M.FDCODE                                                                        \n" );
					sql.append( "        AND A.FSDAT = M.FSDAT                                                                         \n" );
					sql.append( "        AND A.FSNBR = M.FSNBR                                                                         \n" );
					sql.append( "        AND A.ATCODE = C.ATCODE                                                                       \n" );
					sql.append( "        AND M.FSSTAT='Y'                                                                              \n" );
					sql.append( "        AND A.BANJAEYN IN ("+str[9]+")                                                                            \n" );
					sql.append( "        AND B.FSREFCD = '0020'                                                                        \n" );
					if(!str[4].equals("All"))sql.append( "  AND B.FSREFVAL='"+str[4]+"'                                                          \n" );
					sql.append( "        AND A.FDCODE='"+str[0]+"'                                                                     \n" );
					sql.append( "        AND A.ATCODE='"+str[5]+"'                                                                      \n" );
					sql.append( "        AND M.ACTDAT >= '"+str[1]+"' AND  M.ACTDAT <= '"+str[2]+"'                                   \n" );
					if(!str[6].equals(""))sql.append( " AND B3.FSREFCD='"+str[6]+"'                                                              \n" );						
					if(!str[7].equals("")&&!str[8].equals(""))sql.append( " AND B3.FSREFVAL>='"+str[7]+"' AND  B3.FSREFVAL<='"+str[8]+"'           \n" );
					sql.append( "  UNION ALL                                                                                           \n" );		
					sql.append( "  SELECT ''CHK,     N.FDCODE,  N.TSDAT FSDAT, N.TSNBR FSNBR,  N.TSSEQ FSSEQ,                           \n" );
					sql.append( "          N.ATCODE, C.ATKORNAM,N.SSDAT,       N.SSNBR,  N.FSNUM,                                        \n" );
					sql.append( "          CASE WHEN N.STATUS='0' THEN 'N'                                                           \n" );
					sql.append( "               WHEN N.STATUS='1' THEN 'Y'  END  GUBUN, N.REMARK,                                    \n" );
					sql.append( "          N.DEAMT CHAAMT, N.CRAMT DAEAMT,                  \n" );
					sql.append( "          CASE WHEN C.ATDECR = '1' THEN  COALESCE(N.DEAMT,0)- COALESCE(N.CRAMT,0)                     \n" );
					sql.append( "               WHEN C.ATDECR = '2' THEN  COALESCE(N.CRAMT,0)- COALESCE(N.DEAMT,0) END  JANAMT,        \n" );
					sql.append( "          0 BANJAEAMT,                                                                                \n" );
					sql.append( "          N.DEPTCD, E2.CDNAM DEPTNM, N.VENDCD, E.CDNAM VENDNM,          \n" );
					sql.append( "          N.FSREFCD, N.FSREFVAL,  E3.CDNAM FSREFNM, ''COCODE, ''DIVCD,  \n" );
					sql.append( "          N.SSDAT||'-'||N.SSNBR AS SSNBR1 , SUBSTR(N.SSDAT,2,9) ACTDAT, 'Y' FSSTAT,  \n" );
					sql.append( "          E4.CMTYPE FSREFCD2, E4.CDCODE FSREFVAL2, E4.CDNAM FSREFNM2 \n" );
					sql.append( "       FROM ACCOUNT.BANJAEMST N ,ACCOUNT.ACTCODE C                      \n" );
					sql.append( "       LEFT JOIN ACCOUNT.COMMDTIL E ON N.VENDCD = E.CDCODE AND E.CMTYPE='0020'         \n" );   
					sql.append( "       LEFT JOIN ACCOUNT.COMMDTIL E2 ON N.DEPTCD = E2.CDCODE AND E2.CMTYPE='0002'      \n" );   
					sql.append( "       LEFT JOIN ACCOUNT.COMMDTIL E3 ON N.FSREFVAL = E3.CDCODE AND E3.CMTYPE='"+str[6]+"'\n" );   
					sql.append( "       LEFT JOIN ACCOUNT.COMMDTIL E4 ON E4.CDCODE = E3.GBCD AND E4.CMTYPE=E3.CDREMARK \n");
					sql.append( "      WHERE N.ATCODE = C.ATCODE                                                                       \n" );
					sql.append( "        AND N.STATUS IN ("+str[10]+")                                                                               \n" );
					sql.append( "        AND SUBSTR(N.SSDAT,2,9) >='"+str[1]+"' AND  SUBSTR(N.SSDAT,2,9)<='"+str[2]+"'                 \n" );
					sql.append( "        AND N.FDCODE='"+str[0]+"'                                                                     \n" );
					sql.append( "        AND N.ATCODE='"+str[5]+"'                                                                     \n" );

					if(!str[4].equals("All"))sql.append( "  AND N.VENDCD='"+str[4]+"'                                                            \n" );	
					if(!str[6].equals(""))sql.append( "  AND N.FSREFCD='"+str[6]+"'                                                              \n" );	
					if(!str[7].equals("")&&!str[8].equals(""))sql.append( " AND N.FSREFVAL>='"+str[7]+"' AND  N.FSREFVAL<='"+str[8]+"'           \n" );
										
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