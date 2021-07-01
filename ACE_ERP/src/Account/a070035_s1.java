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
public class a070035_s1 extends HttpServlet {
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
				String  str2 = req.getParameter("v_str2");    //계정코드
				String  str3 = req.getParameter("v_str3");    //회계일자 
				String  str4 = req.getParameter("v_str4");    //회계일자 
				String  str5 = req.getParameter("v_str5");    //잠김구분 
				String  str6 = req.getParameter("v_str6");    //은행코드 

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				
				
				System.out.println("str5::" +str5+"::");
				
		
				GauceRes.enableFirstRow(dSet);
				

				String[] strArrCN = new String[]{
						                          
						                         "FDCODE",    "FSDAT",      "FSNBR",     "FSSEQ",      "ATCODE",
                                                 "ATKORNAM",  "DEPTCD",     "DEPTNMK",   "VENDCD",     "VEND_NM",
                                                 "FSREFCD",   "FSREFVAL",   "REMARK",    
                                                 "CARD_NO",   "GBCD",       "DEAMT",      "CRAMT",
                                                 "SSDAT",     "SSNBR",      "FSNUM",     "FSLOCK",     "EMPNO",  "EMPNMK" ,"SSDAT_NO"
                                                
                                                }; 

				int[] intArrCN = new int[]{  					                       
						                       2,   9,   6,   5,   7,
		                                       66,   4,  50,  13,  62, 
		                                        4,  30, 200,  
		                                       100,  3,  22,  22, 
		                                        9,    6,  3,   1,  10, 20, 16
		                                        
		                                    }; 
					
				int[] intArrCN2 = new int[]{ 
						                      -1,-1,-1,-1,-1,
											  -1,-1,-1,-1,-1,
											  -1,-1,-1,
											  -1,-1, 0, 0,
											  -1,-1,-1,-1,-1,-1,-1
										   }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();
					
					sql.append( "  SELECT A.FDCODE,    A.TSDAT AS FSDAT,      A.TSNBR AS FSNBR,     A.TSSEQ AS FSSEQ,     A.ATCODE,                   \n"); 
					sql.append( "         C.ATKORNAM, A.DEPTCD,     '' DEPTNMK,   A.VENDCD,    D.VEND_NM,                                            \n"); 
					sql.append( "         A.FSREFCD,  A.FSREFVAL,   A.REMARK,                                                                        \n");  
					sql.append( "         H.CDNAM  AS CARD_NO,      H.GBCD,                                                                          \n"); 
					sql.append( "         A.DEAMT,    A.CRAMT,                                                                                       \n"); 
					sql.append( "         A.SSDAT,    A.SSNBR,      A.FSNUM ,    B.FSLOCK,    B.EMPNO,   I.EMPNMK,                                   \n"); 
					sql.append( "         A.SSDAT||'-'||A.SSNBR AS SSDAT_NO                                                                          \n"); 
					sql.append( "    FROM ACCOUNT.BANJAEMST A                                                                                        \n"); 
					sql.append( "    LEFT JOIN ACCOUNT.FSLIPMST B ON A.FDCODE = B. FDCODE AND A.TSDAT = B.FSDAT AND A.TSNBR =B.FSNBR AND FSSTAT ='Y' \n"); 
					sql.append( "    LEFT JOIN ACCOUNT.ACTCODE C ON A.ATCODE =C.ATCODE AND ATUSEYN='Y'                                               \n"); 
					sql.append( "    LEFT JOIN ACCOUNT.GCZM_VENDER D ON A.VENDCD  = D.VEND_CD                                                        \n"); 
					sql.append( "    LEFT JOIN ACCOUNT.COMMDTIL H ON A.FSREFVAL = H.CDCODE AND CMTYPE ='1133'                                        \n"); 
					sql.append( "    LEFT JOIN PAYROLL.YIPERSON I ON B.EMPNO = I.EMPNO                                                               \n"); 
					sql.append( "   WHERE A.FDCODE ='"+str1+"'                                                                                       \n"); 
					sql.append( "     AND A.ATCODE ='"+str2+"'                                                                                       \n"); 
					sql.append( "     AND A.SSDAT BETWEEN 'A"+str3+"' AND 'A"+str4+"'                                                                \n");
					if (!str5.equals(""))sql.append( "    AND B.FSLOCK ='"+str5+"'                                                                   \n");
					sql.append( "     AND A.DEAMT < A.CRAMT                                                                                          \n"); 
					sql.append( "     AND H.GBCD ='"+str6+"'                                                                                         \n"); 
					sql.append( "   ORDER BY CARD_NO, A.SSDAT, A.SSNBR, A.FSNUM                                                                      \n"); 
					
					
                    /*
					sql.append( " SELECT A.FDCODE,   A.TSDAT AS FSDAT,      A.TSNBR AS FSNBR,     A.TSSEQ AS FSSEQ,     A.ATCODE,                    \n"); 
					sql.append( "        C.ATKORNAM, A.DEPTCD,     '' DEPTNMK,   A.VENDCD,    D.VEND_NM,                                              \n"); 
					sql.append( "        A.FSREFCD,  A.FSREFVAL,   A.REMARK,    E.CAACCBANK, G.BANNAM,                                               \n"); 
					sql.append( "        E.CABANKNO, E.CACARDSPEC, H.CDNAM,     A.DEAMT,     A.CRAMT,                                                \n"); 
					sql.append( "        A.SSDAT,    A.SSNBR,      A.FSNUM ,    B.FSLOCK,    B.EMPNO,   I.EMPNMK                                     \n"); 
					sql.append( "   FROM ACCOUNT.BANJAEMST A                                                                                         \n"); 
					sql.append( "   LEFT JOIN ACCOUNT.FSLIPMST B ON A.FDCODE = B. FDCODE AND A.TSDAT = B.FSDAT AND A.TSNBR =B.FSNBR AND FSSTAT ='Y'  \n"); 
					sql.append( "   LEFT JOIN ACCOUNT.ACTCODE C ON A.ATCODE =C.ATCODE AND ATUSEYN='Y'                                                \n"); 
					sql.append( "   LEFT JOIN ACCOUNT.GCZM_VENDER D ON A.VENDCD  = D.VEND_CD                                                         \n"); 
					sql.append( "   LEFT JOIN ACCOUNT.CARDCODE E ON A.FSREFVAL  = E.CANBR                                                            \n"); 
					
					sql.append( "   LEFT JOIN ACCOUNT.BANKCODE G ON E.CAACCBANK =G.BANCOD                                                            \n"); 
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL H ON E.CACARDSPEC = H.CDCODE AND CMTYPE ='1134'                                       \n");
					sql.append( "   LEFT JOIN PAYROLL.YIPERSON I ON B.EMPNO = I.EMPNO                                                                \n");
					sql.append( "  WHERE A.FDCODE ='"+str1+"'                                                                                         \n"); 
					sql.append( "    AND A.ATCODE ='"+str2+"'                                                                                         \n"); 
					sql.append( "    AND A.SSDAT BETWEEN 'A"+str3+"' AND 'A"+str4+"'                                                                  \n");
					if (!str5.equals(""))sql.append( "    AND B.FSLOCK ='"+str5+"'                                                                    \n");
					sql.append( "    AND A.DEAMT < A.CRAMT                                                                                           \n"); 
					sql.append( "  ORDER BY D.VEND_NM, A.SSDAT, A.SSNBR, A.FSNUM                                                                     \n"); 
                    */  
				 
					//System.out.println("a070035_s1::"+sql.toString());
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