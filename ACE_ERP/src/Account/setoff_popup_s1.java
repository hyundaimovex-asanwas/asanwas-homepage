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
public class setoff_popup_s1 extends HttpServlet {
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
			  
			  String [] str = new String [6];
				str[0]	= req.getParameter("v_str1");		//지점
        str[1]	= req.getParameter("v_str2");		//거래처
				str[2]	= req.getParameter("v_str3");		//계정
				str[3]	= req.getParameter("v_str4");		//기간FR
				str[4]	= req.getParameter("v_str5");		//기간TO
				
				for (int s=0;s<=5;s++) {
					if(str[s]==null) str[s] = "";
				}

				if(str[2].equals("2100110")||str[2].equals("2100510")){       //외상매입금 OR 미지급금 ==> 외상매출금 OR 미수금
					str[5] = "'1110310','1110610'";
				}else if(str[2].equals("1110310")||str[2].equals("1110610")){ //외상매출금 OR 미수금  ==> 외상매입금 OR 미지급금
					str[5] ="'2100110','2100510'";
				}else{
					str[5] ="";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CHK",	      "FDCODE",    "FSDAT",   "FSNBR",	 "FSSEQ", 
				                                  "ATCODE",     "ATKORNAM",  "SSDAT",   "SSNBR",   "FSNUM", 
					                                "REMARK",     "CHAAMT",	   "DAEAMT",  "JANAMT", 
					                                "DEPTCD",     "DEPTNM",    "VENDCD",  "VENDNM",    
					                                "FSREFCD",    "FSREFVAL",  "FSREFNM",  "COCODE",  "DIVCD",  
																					"SSNBR1",     "ACTDAT",    "FSSTAT",   "FSREFCD2",    "FSREFVAL2",  "FSREFNM2"
					                                 }; 

				int[] intArrCN = new int[]{  1,  2, 9, 6, 5, 
					                           7, 66, 9, 6, 3, 
					                         132, 15,15,15,
					                           4, 30,13,32,
					                           4, 20,40, 2, 4, 
																		16,  8, 1, 4,20, 40
																		
					                         }; 
				int[] intArrCN2 = new int[]{ -1, -1,-1, -1, -1,
					                           -1, -1,-1, -1, -1,
					                           -1,  0, 0,  0,
					                           -1, -1,-1, -1,
					                           -1, -1,-1, -1, -1, 
                                     -1 ,-1,-1, -1, -1, -1
																		 
					                           }; 
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT ''CHK, A.FDCODE, A.TSDAT FSDAT, A.TSNBR FSNBR,  A.TSSEQ FSSEQ,                     \n" );
					sql.append( "        A.ATCODE, C.ATKORNAM, A.SSDAT,A.SSNBR, A.FSNUM,                                    \n" );
					sql.append( "        A.REMARK,A.DEAMT CHAAMT, A.CRAMT DAEAMT,                                           \n" );
					sql.append( "        CASE WHEN C.ATDECR = '1' THEN  COALESCE(A.DEAMT,0)- COALESCE(A.CRAMT,0)            \n" );
					sql.append( "         		WHEN C.ATDECR = '2' THEN  COALESCE(A.CRAMT,0)- COALESCE(A.DEAMT,0) END JANAMT,\n" );
					sql.append( "        A.DEPTCD,  E2.CDNAM DEPTNM, A.VENDCD, E.CDNAM VENDNM,                              \n" );
					sql.append( "        A.FSREFCD, A.FSREFVAL,      E3.CDNAM FSREFNM, ''COCODE, XX.DEPTCD2 AS DIVCD,       \n" );
					sql.append( "        A.SSDAT||'-'||A.SSNBR AS SSNBR1, SUBSTR(A.SSDAT,2,9) ACTDAT, 'Y' FSSTAT,           \n" );
					sql.append( "        E4.CMTYPE FSREFCD2, E4.CDCODE FSREFVAL2, E4.CDNAM FSREFNM2                         \n" );
					sql.append( "   FROM ACCOUNT.BANJAEMST A, ACCOUNT.ACTCODE C                                       \n" );
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL E ON A.VENDCD = E.CDCODE AND E.CMTYPE='0020'           \n" );
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL E2 ON A.DEPTCD = E2.CDCODE AND E2.CMTYPE='0002'        \n" );
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL E3 ON A.FSREFVAL = E3.CDCODE AND E3.CMTYPE=''          \n" );
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL E4 ON E4.CDCODE = E3.GBCD AND E4.CMTYPE=E3.CDREMARK    \n" );
					
          sql.append( "  LEFT JOIN ( SELECT A.DEPTCD,A.DEPTNM,A.TREECD,X.TREECD2,Y.DEPTCD AS DEPTCD2,Y.DEPTNM AS DEPTNM2 \n" );
					sql.append( "                FROM PAYROLL.HCDEPT A                                                             \n" );
          sql.append( "                LEFT JOIN (SELECT B.DEPTCD,B.DEPTNM,SUBSTR(B.TREECD,1,4)TREECD1,                  \n" );
					sql.append( "                                  SUBSTR(B.TREECD,1,4)||'0000' TREECD2                            \n" );
					sql.append( "                             FROM PAYROLL.HCDEPT B                                                \n" );
					sql.append( "                           ) X ON SUBSTR(A.TREECD,1,4) = SUBSTR(X.TREECD1,1,4)                    \n" );
					sql.append( "                                AND A.DEPTCD =X.DEPTCD                                            \n" );
					sql.append( "                LEFT JOIN (SELECT C.DEPTCD,C.DEPTNM,C.TREECD                                      \n" );
					sql.append( "                             FROM PAYROLL.HCDEPT C                                                \n" );
					sql.append( "                            WHERE SUBSTR(C.TREECD,5,4) = '0000'                                   \n" );
					sql.append( "                          )Y ON Y.TREECD = X.TREECD2                                              \n" );
					sql.append( "               WHERE A.USEYN='T'                                                                  \n" );
					sql.append( "                 AND A.TREECD<>'99999999'                                                         \n" );
					sql.append( "              )XX ON XX.DEPTCD = A.DEPTCD                                                         \n" );
				
					sql.append( " WHERE A.ATCODE = C.ATCODE                                                           \n" );
					sql.append( "   AND A.FDCODE ='"+str[0]+"'           \n" );
if(!str[5].equals(""))sql.append( "   AND A.ATCODE IN ("+str[5]+")          \n" );
					sql.append( "   AND A.VENDCD ='"+str[1]+"'            \n" );
					sql.append( "   AND ( SUBSTR(A.SSDAT,2,9) >='"+str[3]+"' AND SUBSTR(A.SSDAT,2,9) <='"+str[4]+"')  \n" );
					sql.append( "   AND A.STATUS = '0' --진행중           \n" );
				
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