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
public class a400330_s1 extends HttpServlet {
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
				String []  str	= new String [8];
				str[0] = req.getParameter("v_str1");	//지점코드
				str[1] = req.getParameter("v_str2");	//신청일from
				str[2] = req.getParameter("v_str3");	//신청일to
				str[3] = req.getParameter("v_str4");	//요청일from
				str[4] = req.getParameter("v_str5");	//요청일to
				str[5] = req.getParameter("v_str6");	//처리자
				str[6] = req.getParameter("v_str7");	//지급종류
				str[7] = req.getParameter("v_str8");	//결재상태
				
			
				for(int i=0;i<=5;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
						"CHKBOX",  "APPNO",    "FDCODE",  "APPDATE",   "REQDATE",   "PAYDATE",
						"ATCODE",  "ATKORNAM", "COSTGB",  "COSTBGT",   "COSTBGTNM", "VENDCD",  "VENDNM", "VENDID", "VEND_ID_LEN",
						"SUPAMT",  "SUPVATAMT","REMARK",  "PAYGB",     "PAYACCTNO", "ACCT_AUTH",
						"FOUTAMT", "CURUNIT",  "EXRATE",  "PURGB",     "TAXNBR",
						"APPFSDAT","APPFSNBR", "PAYSTAT", "PAYFSDAT",  "PAYFSNBR",
						"APPEMPNO","PAYEMPNO",
						"WRID","WRDT","UPID","UPDT", "COCOMYN", "PAYKND", "CURUNITCD", "DOCUMCD", "DOCUMCD2", "OUTAMT","AP_M_SID", "AP_STATUS_M"
				}; 

				int[] intArrCN = new int[] { 
					     1,  14,  2,  8,  8,  8,
					     7, 100,  1, 10,100, 13, 62, 13, 13,
					    15,  13,100,  1, 20,100,
					    15,   6,  6,  1, 11,
					     9,   6,  1,  9,  6,
					    10,  10,
					    10,  10, 10,  10, 1, 1, 2, 3 , 3, 15, 10, 1
				};      
			
				int[] intArrCN2 = new int[]{ 
						-1,  -1,  -1,  -1,  -1,  -1,
					    -1,  -1,  -1,  -1,  -1,  -1,  -1, -1, -1,
					     0,   0,  -1,  -1,  -1,  -1,
					     2,  -1,   2,  -1,  -1,
					    -1,  -1,  -1,  -1,  -1,
					    -1,  -1,  
					    -1,  -1,  -1,  -1, -1, -1, -1, -1 , -1, 0, 0, -1
				 	 
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						
						sql.append( " SELECT 'F'CHKBOX, A.APPNO,   A.FDCODE,   A.APPDATE,A.REQDATE, A.PAYDATE, \n");
						sql.append( "        A.ATCODE,  B.ATKORNAM, A.COSTGB, A.COSTBGT,                 \n");
						sql.append( "        CASE WHEN A.COSTGB ='1' THEN C.CDNAM                        \n");
						sql.append( "             WHEN A.COSTGB ='2' THEN D.CDNAM                        \n");
						sql.append( "             ELSE 'XXXX' END COSTBGTNM,                             \n");
						sql.append( "        A.VENDCD,  A.VENDNM, G.VEND_ID AS VENDID, LENGTH(G.VEND_ID) VEND_ID_LEN, \n");
						sql.append( "        A.SUPAMT,  A.SUPVATAMT,A.REMARK, A.PAYGB,   A.PAYACCTNO,  A.ACCT_AUTH,   \n");
						sql.append( "        A.FOUTAMT, A.CURUNIT,  A.EXRATE,                            \n");
						sql.append( "        CASE WHEN A.PURGB IS NULL THEN 'F' ELSE A.PURGB END PURGB,  \n");
						sql.append( "        A.TAXNBR,                                                   \n");
						sql.append( "        A.APPFSDAT,A.APPFSNBR, A.PAYSTAT,A.PAYFSDAT,A.PAYFSNBR,     \n");
						sql.append( "        A.APPEMPNO,A.PAYEMPNO,                                      \n");
						sql.append( "        A.WRID,A.WRDT,A.UPID,A.UPDT ,G.COCOMYN,A.PAYKND,A.CURUNITCD,\n");
						sql.append( "        A.DOCUMCD, A.DOCUMCD AS DOCUMCD2, A.OUTAMT, A.AP_M_SID,     \n");
						sql.append( "        NVL(H.AP_STATUS_M,'0') AS AP_STATUS_M                       \n");
						sql.append( "   FROM ACCOUNT.ACAPPFUND A, ACCOUNT.ACTCODE B,                     \n");
						sql.append( "        ACCOUNT.COMMDTIL C,  ACCOUNT.COMMDTIL D,                    \n");
						sql.append( "        ACCOUNT.GCZM_VENDER G, COMMON.APPROVE_MASTER H              \n");
						sql.append( "  WHERE A.ATCODE = B.ATCODE(+) AND B.ATUSEYN(+) ='Y'                \n");
						sql.append( "    AND A.COSTBGT= C.CDCODE(+) AND C.CMTYPE(+) ='0030'              \n");
						sql.append( "    AND A.COSTBGT= D.CDCODE(+) AND D.CMTYPE(+) ='0003'              \n");
						sql.append( "    AND A.VENDCD= G.VEND_CD(+)                                      \n");
						sql.append( "    AND A.AP_M_SID = H.AP_M_SID(+)                                  \n");
						
						if(!str[0].equals(""))sql.append( " AND A.FDCODE  ='"+str[0]+"'                \n");
						if(!str[1].equals(""))sql.append( " AND A.APPDATE BETWEEN '"+str[1]+"' AND '"+str[2]+"' \n");
						if(!str[3].equals(""))sql.append( " AND A.REQDATE BETWEEN '"+str[3]+"' AND '"+str[4]+"' \n");
						if(!str[5].equals(""))sql.append( " AND A.APPEMPNO='"+str[5]+"'               \n");
						if(!str[6].equals(""))sql.append( " AND A.PAYKND  ='"+str[6]+"'               \n");
						
						if(!str[7].equals("A")){
							if(str[7].equals("1")){
								sql.append( "    AND (H.AP_STATUS_M ='1' OR H.AP_STATUS_M IS NULL )      \n");
							}else{
								sql.append( "    AND H.AP_STATUS_M  = '"+str[7]+"'          \n");
							}
						}
						
						sql.append( "   ORDER BY A.APPDATE, A.VENDNM                                \n");
						//System.out.println("# a400310_s1 Query : \n" + sql);
						
/*********************************************************************************************/
					
					stmt = conn.getGauceStatement(sql.toString());
		 			stmt.executeQuery(dSet);
				}
			} catch(Exception e) {
		  	//logger.err.println(this,e);
		  	System.err.println(e);
		  } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close(true);} catch (Exception e) {}
			}

		  dSet.flush();
		  GauceRes.commit();
		  GauceRes.close();

		} catch (Exception e) {
			//logger.err.println(this,e);
			System.err.println(e);
			//logger.dbg.println(this,e.toString());
			
		} finally {
			loader.restoreService(service);
  	}
	}
}