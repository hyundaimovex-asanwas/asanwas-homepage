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
public class a100002_s1 extends HttpServlet {
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
				String [] str = new String [9];
				str[0]	= req.getParameter("v_str1");		//지점                  
				str[1]	= req.getParameter("v_str2");		//당기기간fr            
				str[2]	= req.getParameter("v_str3");		//당기기간to            
				str[3]	= req.getParameter("v_str4");		//계정fr      
				str[4]	= req.getParameter("v_str5");		//계정to
				str[5]	= req.getParameter("v_str6");		//원가fr
				str[6]	= req.getParameter("v_str7");		//원가to
				
				for (int s=0;s<=8;s++) {
					if (str[s]==null) str[s] = "";
				}

				str[7]="A"+str[2].substring(0,4)+"1233";
				str[8]="A"+str[2].substring(0,4)+"1234";
		
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "GUBUN","FSREFVAL","COSTNM","ATCODE", "ATKORNAM", 
					                              "PRTSEQ","SSDAT","SSNBR","FSSEQ",
                                                  "DETOT","CRTOT","JANAMT","REMARK","VEND_CD","VEND_NM","FDCODE","FSDAT","FSNBR"
				}; 

				int[] intArrCN = new int[]{  1, 6, 40, 7, 66,
					                           5, 9,  6, 5,
					                          15,15, 15, 132, 13, 62, 2, 9, 6
				}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1,
					                            0,  0,  0, -1, -1, -1, -1, -1, -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT X.GUBUN ,X.FSREFVAL, F.CDNAM COSTNM, D.ATCODE AS ATCODE, E.ATKORNAM,                \n " );
					sql.append( "         D.PRTSEQ AS PRTSEQ,  X.SSDAT, X.SSNBR, X.FSSEQ,                                     \n " );
					sql.append( "         X.DETOT, X.CRTOT, X.JANAMT,X.REMARK, X.VEND_CD, X.VEND_NM, X.FDCODE, X.FSDAT, X.FSNBR                                                  \n " );
					sql.append( "    FROM ACCOUNT.RPTPRTACT D                                                                \n " );
					sql.append( "    INNER JOIN (                                                                                        \n " );
					sql.append( "      SELECT B.ATCODE ATCODE, A.SSDAT SSDAT, A.SSNBR SSNBR, A.FSSEQ,                         \n " );
					sql.append( "                   CASE WHEN B.ATDECR ='1' THEN COALESCE(SUM(B.FSAMT),0) ELSE 0 END DETOT,   \n " );
					sql.append( "                   CASE WHEN B.ATDECR ='2' THEN COALESCE(SUM(B.FSAMT),0) ELSE 0 END CRTOT,   \n " );
					sql.append( "                   0 JANAMT, B.REMARK, A.FSREFVAL FSREFVAL, ''GUBUN,                           \n " );
					sql.append( "                   C.FSREFVAL VEND_CD, D.VEND_NM, A.FDCODE, A.FSDAT, A.FSNBR \n " );
					sql.append( "      FROM ACCOUNT.GENENREF A                                            \n " );
					sql.append( "      LEFT JOIN ACCOUNT.FSLIPDTL B ON A.FDCODE = B.FDCODE   \n " );
					sql.append( "          											AND A.FSDAT = B.FSDAT                                                              \n " );
					sql.append( "          											AND A.FSNBR = B.FSNBR                                                              \n " );
					sql.append( "          											AND A.FSSEQ = B.FSSEQ                                                              \n " );
					sql.append( "      LEFT JOIN ACCOUNT.GENENREF C ON A.FDCODE =C.FDCODE   \n " );
					sql.append( "                                  AND A.FSDAT = C.FSDAT    \n " );
					sql.append( "                                  AND A.FSNBR = C.FSNBR    \n " );
					sql.append( "                                  AND A.FSSEQ = C.FSSEQ    \n " );
					if(!str[0].equals(""))sql.append( "            AND C.FDCODE = '"+str[0]+"'       \n " );
					sql.append( "                                  AND C.FSREFCD = ('0020') \n " );
					sql.append( "      LEFT JOIN ACCOUNT.GCZM_VENDER D ON D.VEND_CD =C.FSREFVAL \n " );				
					sql.append( "      WHERE 1 = 1                                                              \n " );
					if(!str[0].equals(""))sql.append( " AND A.FDCODE = '"+str[0]+"'                                                     \n " );
					sql.append( "          AND A.FSREFCD = '0030'                                                             \n " );
					if(!str[5].equals("")&&!str[6].equals(""))sql.append(" AND A.FSREFVAL BETWEEN '"+str[5]+"' AND '"+str[6]+"'         \n " );
					sql.append( "          AND B.ATCODE LIKE '43%'                                                            \n " );
					if(!str[3].equals("")&&!str[4].equals(""))sql.append(" AND B.ATCODE BETWEEN '"+str[3]+"' AND  '"+str[4]+"'          \n " );
					if(!str[1].equals("")&&!str[2].equals(""))sql.append(" AND A.SSDAT BETWEEN 'A"+str[1]+"' AND 'A"+str[2]+"'          \n " );
					sql.append( "      GROUP BY B.ATCODE, A.SSDAT, A.SSNBR, A.FSSEQ, B.ATDECR, B.REMARK ,A.FSREFVAL ,C.FSREFVAL, D.VEND_NM, A.FDCODE, A.FSDAT, A.FSNBR    \n " );
					sql.append( "      UNION ALL                                                                              \n " );
					sql.append( "      --월계                                                                                 \n " );
					sql.append( "      SELECT B.ATCODE ATCODE, SUBSTR(A.SSDAT,1,7)||'32' SSDAT, '' SSNBR, ''FSSEQ,            \n " );
					sql.append( "                   0 DETOT, 0 CRTOT, 0 JANAMT, '' REMARK , A.FSREFVAL FSREFVAL , 'M'GUBUN, '' VEND_CD,''VEND_NM, ''FDCODE, ''FSDAT, ''FSNBR    \n " );
					sql.append( "      FROM ACCOUNT.GENENREF A, ACCOUNT.FSLIPDTL B                                            \n " );
					sql.append( "      WHERE A.FDCODE = B.FDCODE                                                              \n " );
					sql.append( "          AND A.FSDAT = B.FSDAT                                                              \n " );
					sql.append( "          AND A.FSNBR = B.FSNBR                                                              \n " );
					sql.append( "          AND A.FSSEQ = B.FSSEQ                                                              \n " );
					if(!str[0].equals(""))sql.append( " AND A.FDCODE = '"+str[0]+"'                                                     \n " );
					sql.append( "          AND A.FSREFCD = '0030'                                                             \n " );
					if(!str[5].equals("")&&!str[6].equals(""))sql.append(" AND A.FSREFVAL BETWEEN '"+str[5]+"' AND '"+str[6]+"'         \n " );
					sql.append( "          AND B.ATCODE LIKE '43%'                                                            \n " );
					if(!str[3].equals("")&&!str[4].equals(""))sql.append(" AND B.ATCODE BETWEEN '"+str[3]+"' AND  '"+str[4]+"'          \n " );
					if(!str[1].equals("")&&!str[2].equals(""))sql.append(" AND A.SSDAT BETWEEN 'A"+str[1]+"' AND 'A"+str[2]+"'          \n " );
					sql.append( "      GROUP BY  B.ATCODE, SUBSTR(A.SSDAT,1,7)||'32' ,FSREFVAL                               \n " );
					sql.append( "      UNION ALL                                                                              \n " );
					sql.append( "      --누계                                                                                 \n " );
					sql.append( "      SELECT B.ATCODE ATCODE, '"+str[7]+"' SSDAT, '' SSNBR, ''FSSEQ,                          \n " );
					sql.append( "                   0 DETOT, 0 CRTOT, 0 JANAMT, '' REMARK ,A.FSREFVAL FSREFVAL ,'T'GUBUN,'' VEND_CD,''VEND_NM, ''FDCODE, ''FSDAT, ''FSNBR       \n " );
					sql.append( "      FROM ACCOUNT.GENENREF A, ACCOUNT.FSLIPDTL B                                            \n " );
					sql.append( "      WHERE A.FDCODE = B.FDCODE                                                              \n " );
					sql.append( "          AND A.FSDAT = B.FSDAT                                                              \n " );
					sql.append( "          AND A.FSNBR = B.FSNBR                                                              \n " );
					sql.append( "          AND A.FSSEQ = B.FSSEQ                                                              \n " );
					if(!str[0].equals(""))sql.append( " AND A.FDCODE = '"+str[0]+"'                                                     \n " );
					sql.append( "          AND A.FSREFCD = '0030'                                                             \n " );
					if(!str[5].equals("")&&!str[6].equals(""))sql.append(" AND A.FSREFVAL BETWEEN '"+str[5]+"' AND '"+str[6]+"'         \n " );
					sql.append( "          AND B.ATCODE LIKE '43%'                                                            \n " );
					if(!str[3].equals("")&&!str[4].equals(""))sql.append(" AND B.ATCODE BETWEEN '"+str[3]+"' AND  '"+str[4]+"'          \n " );
					if(!str[1].equals("")&&!str[2].equals(""))sql.append(" AND A.SSDAT BETWEEN 'A"+str[1]+"' AND 'A"+str[2]+"'          \n " );
					sql.append( "      GROUP BY  B.ATCODE ,FSREFVAL                                                          \n " );
					sql.append( "      --원가계                                                                               \n " );
					sql.append( "      UNION ALL                                                                              \n " );
					sql.append( "      SELECT  DISTINCT '4399999' ATCODE, '"+str[8]+"' SSDAT, '' SSNBR, ''FSSEQ,               \n " );
					sql.append( "                   0 DETOT, 0 CRTOT, 0 JANAMT, '' REMARK ,A.FSREFVAL FSREFVAL ,'C'GUBUN ,'' VEND_CD,''VEND_NM, ''FDCODE, ''FSDAT, ''FSNBR      \n " );
					sql.append( "      FROM ACCOUNT.GENENREF A, ACCOUNT.FSLIPDTL B                                            \n " );
					sql.append( "      WHERE A.FDCODE = B.FDCODE                                                              \n " );
					sql.append( "          AND A.FSDAT = B.FSDAT                                                              \n " );
					sql.append( "          AND A.FSNBR = B.FSNBR                                                              \n " );
					sql.append( "          AND A.FSSEQ = B.FSSEQ                                                              \n " );
					if(!str[0].equals(""))sql.append( " AND A.FDCODE = '"+str[0]+"'                                                     \n " );
					sql.append( "          AND A.FSREFCD = '0030'                                                             \n " );
					if(!str[5].equals("")&&!str[6].equals(""))sql.append(" AND A.FSREFVAL BETWEEN '"+str[5]+"' AND '"+str[6]+"'         \n " );
					sql.append( "          AND B.ATCODE LIKE '43%'                                                            \n " );
					if(!str[3].equals("")&&!str[4].equals(""))sql.append(" AND B.ATCODE BETWEEN '"+str[3]+"' AND  '"+str[4]+"'          \n " );
					if(!str[1].equals("")&&!str[2].equals(""))sql.append(" AND A.SSDAT BETWEEN 'A"+str[1]+"' AND 'A"+str[2]+"'          \n " );
					sql.append( "      GROUP BY FSREFVAL                                                                      \n " );
					sql.append( "      ORDER BY FSREFVAL,ATCODE, SSDAT                                                        \n " );
					sql.append( "  )X  ON  D.ATCODE = X.ATCODE                                                                                      \n " );
					sql.append( "  LEFT JOIN ACCOUNT.ACTCODE E ON D.ATCODE = E.ATCODE                                         \n " );
					sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL F ON X.FSREFVAL = F.CDCODE AND F.CMTYPE='0030'                  \n " );
					sql.append( "  WHERE                                                                  					\n " );
					sql.append( "    D.PRTCODE ='08'                                                                      \n " );				
					sql.append( "  ORDER BY X.FSREFVAL DESC ,D.PRTSEQ, X.SSDAT, X.SSNBR, X.FSSEQ                              \n " );
					
					//System.out.println("a100002_s1" + sql.toString());
					//	logger.dbg.println(this,sql.toString());
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