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
public class a300070_s1 extends HttpServlet {
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
				String []  str	= new String [7];
				str[0] = req.getParameter("v_str1");	//지점코드
				str[1] = req.getParameter("v_str2");	//신청일FR
				str[2] = req.getParameter("v_str3");	//신청일TO
				str[3] = req.getParameter("v_str4");	//요청일
				str[4] = req.getParameter("v_str5");	//지급상태
				str[5] = req.getParameter("v_str6");	//전표상태
				str[6] = req.getParameter("v_str7");	//처리자
				
				for(int i=0;i<=6;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
						"CHKBOX",  "APPNO",    "FDCODE",  "APPDATE",   "REQDATE",   "PAYDATE",
						"ATCODE",  "ATKORNAM", "COSTGB",  "COSTBGT",   "COSTBGTNM", "VENDCD",  "VENDNM",
						"SUPAMT",  "SUPVATAMT","APPAMT",   "REMARK",   "PAYGB",     "PAYACCTNO",
						"FOUTAMT", "CURUNIT",  "EXRATE",  "PURGB",     "TAXNBR",
						"APPFSDAT","APPFSNBR", "PAYSTAT", "PAYFSDAT",  "PAYFSNBR",
						"APPEMPNO","PAYEMPNO",
						"WRID","WRDT","UPID","UPDT", "COCOMYN",
						"ATCODE2","ATKORNAM2","SSLIPNO","FSSTAT", "PAYKND", "FSLOCK"
				}; 

				int[] intArrCN = new int[] { 
					     1,  14,  2,  8,  8,  8,
					     7, 100,  1, 10,100, 13, 62,
					    15,  13, 15, 100,  1, 20,
					    15,   6,  6,  1, 11,
					     9,   6,  1,  9,  6,
					    10,  10,
					    10,  10, 10,  10, 1,
					     7, 100, 16,   1, 1, 1
				};      
			
				int[] intArrCN2 = new int[]{ 
						-1,  -1,  -1,  -1,  -1,  -1,
					    -1,  -1,  -1,  -1,  -1,  -1,  -1,
					     0,   0,  0,   -1,  -1,  -1,
					     2,  -1,   2,  -1,  -1,
					    -1,  -1,  -1,  -1,  -1,
					    -1,  -1,  
					    -1,  -1,  -1,  -1,  -1,
					    -1,  -1,  -1,  -1,  -1, -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						
						sql.append( " SELECT 'F'CHKBOX, A.APPNO,   A.FDCODE,   A.APPDATE,A.REQDATE, A.PAYDATE,      \n");
						sql.append( "        A.ATCODE,  B.ATKORNAM, A.COSTGB, A.COSTBGT,                 \n");
						sql.append( "        CASE WHEN A.COSTGB ='1' THEN C.CDNAM                        \n");
						sql.append( "             WHEN A.COSTGB ='2' THEN D.CDNAM                        \n");
						sql.append( "             ELSE 'XXXX' END COSTBGTNM,                             \n");
						sql.append( "        A.VENDCD,  A.VENDNM,                                        \n");
						sql.append( "        A.SUPAMT,  A.SUPVATAMT, A.SUPAMT+A.SUPVATAMT AS APPAMT,     \n");
						sql.append( "        A.REMARK, A.PAYGB,   A.PAYACCTNO,    \n");
						sql.append( "        A.FOUTAMT, A.CURUNIT,  A.EXRATE,                            \n");
						sql.append( "        CASE WHEN A.PURGB IS NULL THEN 'F' ELSE A.PURGB END PURGB,  \n");
						sql.append( "        A.TAXNBR,                                                   \n");
						sql.append( "        A.APPFSDAT,A.APPFSNBR, A.PAYSTAT,A.PAYFSDAT,A.PAYFSNBR,     \n");
						sql.append( "        A.APPEMPNO,A.PAYEMPNO,                                      \n");
						sql.append( "        A.WRID,A.WRDT,A.UPID,A.UPDT ,G.COCOMYN,                      \n");
                        
						sql.append( "        CASE WHEN SUBSTR(A.ATCODE,1,2)='44' THEN  '2100510'         \n");
						sql.append( "             ELSE '2100110' END  ATCODE2,                           \n");
						sql.append( "        CASE WHEN SUBSTR(A.ATCODE,1,2)='44' THEN  '미지급금'          \n");
						sql.append( "             ELSE '외상매입금' END  ATKORNAM2,                         \n");
						sql.append( "        CASE WHEN F.SSDAT IS NOT NULL THEN F.SSDAT||'-'||F.SSNBR END SSLIPNO, \n");
						sql.append( "        F.FSSTAT, A.PAYKND, F.FSLOCK                                \n");
						
						sql.append( "   FROM ACCOUNT.ACAPPFUND A, ACCOUNT.ACTCODE B,                     \n");
						sql.append( "        ACCOUNT.COMMDTIL C,  ACCOUNT.COMMDTIL D,                    \n");
						sql.append( "        ACCOUNT.GCZM_VENDER G, ACCOUNT.FSLIPMST F                   \n");
						sql.append( "  WHERE A.ATCODE = B.ATCODE(+) AND ATUSEYN(+) ='Y'                  \n");
						sql.append( "    AND A.COSTBGT= C.CDCODE(+) AND C.CMTYPE(+) ='0030'              \n");
						sql.append( "    AND A.COSTBGT= D.CDCODE(+) AND D.CMTYPE(+) ='0003'              \n");
						sql.append( "    AND A.VENDCD= G.VEND_CD(+)                                      \n");
						sql.append( "    AND A.FDCODE = F.FDCODE(+)                                      \n");
						sql.append( "    AND A.APPFSDAT  = F.FSDAT(+)                                    \n");
						sql.append( "    AND A.APPFSNBR  = F.FSNBR(+)                                    \n");
					
						if(!str[0].equals(""))sql.append( "    AND A.FDCODE  ='"+str[0]+"'       \n");
						if(!str[1].equals(""))sql.append( "    AND A.APPDATE >='"+str[1]+"' AND A.APPDATE<= '"+str[2]+"' \n");
						if(!str[3].equals(""))sql.append( "    AND A.REQDATE ='"+str[3]+"'       \n");
						if(!str[4].equals(""))sql.append( "    AND A.PAYGB   ='"+str[4]+"'       \n");
						if(!str[5].equals(""))sql.append( "    AND F.FSSTAT  ='"+str[5]+"'       \n");
						if(!str[6].equals(""))sql.append( "    AND A.APPEMPNO='"+str[6]+"'       \n");
						
						/*
						if(!str[0].equals(""))sql.append( "   AND A.FDCODE ='"+str[0]+"'                   \n");	
						if(!str[1].equals(""))sql.append( "   AND A.VENDCD ='"+str[1]+"'                   \n");
						if(!str[2].equals("")&&!str[3].equals(""))sql.append( "   AND A.FULDAT >='"+str[2]+"' AND A.FULDAT<='"+str[3]+"'  --만기일자   \n");
						else if(!str[2].equals("")&&str[3].equals(""))sql.append( "   AND A.FULDAT >='"+str[2]+"' --만기일자   \n");
						
						if(!str[4].equals("")&&!str[5].equals(""))sql.append( "   AND A.PAYDAT >='"+str[4]+"' AND A.PAYDAT<='"+str[5]+"'  --발행일자   \n");	
						else if(!str[4].equals("")&&str[5].equals(""))sql.append( "   AND A.PAYDAT >='"+str[4]+"'   --발행일자   \n");	
						if(!str[7].equals(""))sql.append( "   AND B.EMPNO IN ('"+str[7]+"')                \n");	
						sql.append( "   ORDER BY A.FULDAT, A.PAYDAT, C.VEND_NM                             \n");
						*/
						/*
						if(!str[0].equals(""))sql.append( "    AND X.FDCODE ='"+str[0]+"'       \n");
						if(!str[1].equals(""))sql.append( "    AND X.VENDCD ='"+str[1]+"'       \n");
						if(!str[2].equals(""))sql.append( "    AND X.ENDDT >='"+str[2]+"'       \n");
						if(!str[3].equals(""))sql.append( "    AND X.JOBDT='"+str[3]+"'         \n");
						sql.append( "  ORDER BY X.JOBDT, X.ENDDT, G.VEND_NM \n");
						*/
						/*
						if(!str[0].equals("")) sql.append( " AND A.FDCODE ='"+str[0]+"'							\n");	//지점
						if(!str[1].equals("")) sql.append( " AND A.FUNDDIV='"+str[1]+"' 							\n");	//자금구분
						if(!str[2].equals("")) sql.append( " AND A.ENDDATE BETWEEN '"+str[2]+"'	AND '"+str[3]+"'\n");	//만기일자
						if(!str[4].equals("")) sql.append( " AND C.CDNAM LIKE '"+str[4]+"%'						\n");	//은행명
						*/

						//System.out.println("# a300070_s1 Query : \n" + sql);
						
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