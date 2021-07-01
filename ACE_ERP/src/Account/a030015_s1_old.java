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
public class a030015_s1_old extends HttpServlet {
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
			  
			  String [] str = new String [8];
				str[0]	= req.getParameter("v_str1");		//지점
        str[1]	= req.getParameter("v_str2");		//계정FR
				str[2]	= req.getParameter("v_str3");		//계정TO
				str[3]	= req.getParameter("v_str4");		//회계일자FR
        str[4]	= req.getParameter("v_str5");		//회계일자TO
				str[5]	= req.getParameter("v_str6");		//거래처FR
				str[6]	= req.getParameter("v_str7");		//거래처TO
				str[7]	= req.getParameter("v_str8");		//정산완료1 미완료0
				
       
				for (int s=0;s<=7;s++) {
					if(str[s]==null) str[s] = "";
				}
        

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CHK",	      "FDCODE",    "FSDAT",   "FSNBR",	 "FSSEQ", 
				                                  "ATCODE",     "ATKORNAM",  "SSDAT",   "SSNBR",   "FSNUM", 
					                                "GUBUN",      "REMARK",    "CHAAMT",	"DAEAMT" , "JANAMT", 
					                                "BANJAEAMT",  "VENDCD",    "VENDNM",  "DEPTCD",  "DEPTNM",
					                                "FSREFCD",    "FSREFVAL",  "FSREFNM",  "COCODE",  "DIVCD",  
																					"SSNBR1",     "ACTDAT",    "FSSTAT",   "FSREFCD2", "FSREFVAL2",  "FSREFNM2", "ATDECR",
					                                "REFCD2",     "REFVAL2"
																		
																					 }; 

				int[] intArrCN = new int[]{  1,  2,  9, 6, 5, 
					                           7,  66, 9, 6, 2, 
					                           10, 132,15,15,15,
					                           15, 20, 32,4, 30,
					                            4, 20, 40,2, 4, 
																	 	 16, 8,  1 , 4,  20, 40, 1,
					                            4, 30

					                        }; 
				int[] intArrCN2 = new int[]{ -1, -1,-1, -1, -1,
					                           -1, -1,-1, -1, -1,
					                           -1, -1, 0,  0,  0,
					                            0, -1,-1, -1, -1,
					                           -1, -1,-1, -1, -1, 
                                     -1 ,-1,-1, -1,-1, -1, -1,
					                           -1, -1
					                           }; 
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					
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
				  sql.append( "          E4.CMTYPE FSREFCD2, E4.CDCODE FSREFVAL2, E4.CDNAM FSREFNM2 , C.ATDECR, \n" );
					sql.append( "          N.FSREFCD2 AS REFCD2, N.FSREFVAL2 AS REFVAL2 \n" ); //추가된필드임
					sql.append( "       FROM ACCOUNT.BANJAEMST N ,ACCOUNT.ACTCODE C                      \n" );
					sql.append( "       LEFT JOIN ACCOUNT.COMMDTIL E ON N.VENDCD = E.CDCODE AND E.CMTYPE='0020'         \n" );   
					sql.append( "       LEFT JOIN ACCOUNT.COMMDTIL E2 ON N.DEPTCD = E2.CDCODE AND E2.CMTYPE='0002'      \n" );     
					sql.append( "       LEFT JOIN ACCOUNT.COMMDTIL E3 ON N.FSREFVAL = E3.CDCODE AND E3.CMTYPE=N.FSREFCD \n" );  
					sql.append( "       LEFT JOIN ACCOUNT.COMMDTIL E4 ON E4.CDCODE = E3.GBCD AND E4.CMTYPE=E3.CDREMARK \n");
					sql.append( "      WHERE N.ATCODE = C.ATCODE                                                        \n" );
if(!str[0].equals(""))sql.append( "        AND N.FDCODE='"+str[0]+"'                                                     \n" );
if(!str[1].equals("")&&!str[2].equals(""))sql.append( " AND N.ATCODE>='"+str[1]+"' AND N.ATCODE<='"+str[2]+"'                          \n" );
if(!str[3].equals("")&&!str[4].equals(""))sql.append( " AND SUBSTR(N.SSDAT,2,9) >='"+str[3]+"' AND  SUBSTR(N.SSDAT,2,9)<='"+str[4]+"'                 \n" );
if(!str[5].equals("")&&!str[6].equals(""))sql.append( " AND N.VENDCD>='"+str[5]+"' AND N.VENDCD<='"+str[6]+"'                                                           \n" );	
					sql.append( "        AND N.STATUS='"+str[7]+"'                                                                               \n" );
	
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