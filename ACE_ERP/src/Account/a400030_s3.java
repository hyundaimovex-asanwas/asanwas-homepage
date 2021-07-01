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
public class a400030_s3 extends HttpServlet {
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
				String []  str	= new String [4];
				str[0] = req.getParameter("v_str1");	//계좌코드
				str[1] = req.getParameter("v_str2");	//계좌번호
				str[2] = req.getParameter("v_str3");	//거래일자
				str[3] = req.getParameter("v_str4");	//적요
				
				
				for(int i=0;i<=3;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"DEDATE",   "BRCHCD",    "ACCTGB",
					"BRCHNM",   "ACCTGBNM",  "CURUNIT",  "BALAMTS2", "BALAMTS",  "FBALAMTS",
					"REMARK",   "ACCTCD",    "ACCTNO",   "INRATE",   "ACCTUSE" ,  "CHKBOX", "CLOSEYN"
					 }; 

				int[] intArrCN = new int[] { 
					 8,   6,   2,	
				    60,  60,   6,   10,  15,  15, 
				   100,  10,  30,    4,  60,  1,  1
				}; 
			
				int[] intArrCN2 = new int[]{ 
				    -1,  -1,  -1, 		
					-1,  -1,  -1,   0,  0,  2,  
 					-1,  -1,  -1,   2, -1, -1, -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( "SELECT MAX(X.DEDATE)DEDATE,  MAX(X.BRCHCD)BRCHCD, MAX(X.ACCTGB)ACCTGB, MAX(X.BRCHNM)BRCHNM, MAX(X.ACCTGBNM)ACCTGBNM,           \n");
						sql.append( "       MAX(X.CURUNIT)CURUNIT,SUM(X.BALAMTS2)BALAMTS2, SUM(X.BALAMTS)BALAMTS, SUM(X.FBALAMTS)FBALAMTS, MAX(X.REMARK)REMARK,     \n");
						sql.append( "       X.ACCTCD, X.ACCTNO, MAX(X.INRATE)INRATE, MAX(X.ACCTUSE)ACCTUSE, '' CHKBOX , NVL(MAX(Y.CLOSEYN),'N')CLOSEYN              \n");
						sql.append( "  FROM (                                                                                                                       \n");
						sql.append( "        --시점잔액                                                                                                             \n");
						sql.append( "        SELECT                                                                                                                 \n");
						sql.append( "               -- 최종잔액 금액이 존재해야 함.                                                                                        \n");
						sql.append( "               '"+str[2]+"' DEDATE, B.BRCHCD, B.ACCTGB, (C.CDNAM) BRCHNM,  (D.CDNAM) ACCTGBNM,                                 \n");
						sql.append( "               A.CURUNIT,  ROUND((A.BALAMT)/1000000)BALAMTS2, (A.BALAMT)BALAMTS,                                               \n");
						/*
						sql.append( "               (CASE WHEN A.CURUNIT  = 'WON' THEN ROUND(BALAMT/1000000)                                                        \n");
						sql.append( "                     WHEN A.CURUNIT != 'WON' THEN ROUND(((FBALAMT)* A.EXRATE)/1000000)   ELSE 0 END) BALAMTS2,                 \n");
						sql.append( "               (CASE WHEN A.CURUNIT  = 'WON' THEN  BALAMT                                                                      \n");
						sql.append( "                     WHEN A.CURUNIT != 'WON' THEN (A.FBALAMT)* A.EXRATE   ELSE 0 END) BALAMTS,                                 \n");
						*/
						sql.append( "               (CASE WHEN A.CURUNIT != 'WON' THEN (A.FBALAMT) ELSE 0 END ) FBALAMTS,                                           \n");
						sql.append( "               B.REMARK,                                                                                                       \n");
						sql.append( "               A.ACCTCD, A.ACCTNO,                                                                                             \n");
						sql.append( "               CASE WHEN A.INRATE != 0 THEN  A.INRATE||'%' ELSE '' END AS INRATE,    B.ACCTUSE                                 \n");
						sql.append( "          FROM ACCOUNT.ACDEPOSIT A, ACCOUNT.ACCTINFO B,                                                                        \n");
						sql.append( "               ACCOUNT.COMMDTIL C,  ACCOUNT.COMMDTIL D                                                                         \n");
						sql.append( "         WHERE A.ACCTCD = B.ACCTCD(+)                                                                                          \n");
						sql.append( "           AND B.BRCHCD = C.CDCODE(+) AND C.CMTYPE(+) ='0022'                                                                  \n");
						sql.append( "           AND B.ACCTGB = D.CDCODE(+) AND D.CMTYPE(+) ='2250'                                                                  \n");
						sql.append( "           AND B.DEPOGB ='3'                                                                                                   \n");
						sql.append( "           AND A.DEDATE ='20160000'                                                                                            \n");
						sql.append( "                                                                                                                               \n");
						sql.append( "        UNION ALL                                                                                                              \n");
						sql.append( "        --입금-출금                                                                                                            \n");
						sql.append( "        SELECT                                                                                                                 \n");
						sql.append( "               -- 최종잔액 금액이 존재해야 함.                                                                                 \n");
						sql.append( "               '"+str[2]+"' DEDATE, MAX(B.BRCHCD)BRCHCD, MAX(B.ACCTGB)ACCTGB, MAX(C.CDNAM) BRCHNM,  MAX(D.CDNAM) ACCTGBNM,    \n");
						sql.append( "               MAX(A.CURUNIT) CURUNIT,  SUM(ROUND((A.INAMT-A.OUTAMT)/1000000))BALAMTS2, SUM(A.INAMT-A.OUTAMT)BALAMTS,          \n");
						sql.append( "               /*                                                                                                              \n");
						sql.append( "               SUM(CASE WHEN A.CURUNIT  = 'WON' THEN ROUND((A.INAMT - A.OUTAMT)/1000000)                                       \n");
						sql.append( "                        WHEN A.CURUNIT != 'WON' THEN ROUND(((A.FINAMT - A.FOUTAMT)* A.EXRATE)/1000000)   ELSE 0 END) BALAMTS2, \n");
						sql.append( "               SUM(CASE WHEN A.CURUNIT  = 'WON' THEN  A.INAMT - A.OUTAMT                                                       \n");
						sql.append( "                        WHEN A.CURUNIT != 'WON' THEN (A.FINAMT - A.FOUTAMT)* A.EXRATE   ELSE 0 END) BALAMTS,                   \n");
						sql.append( "               */                                                                                                              \n");
						sql.append( "               SUM(CASE WHEN A.CURUNIT != 'WON' THEN (A.FINAMT - A.FOUTAMT) ELSE 0 END ) FBALAMTS,                             \n");
						sql.append( "               MAX(B.REMARK)REMARK,                                                                                            \n");
						sql.append( "               A.ACCTCD, A.ACCTNO,                                                                                             \n");
						sql.append( "               MAX(CASE WHEN A.INRATE != 0 THEN  A.INRATE||'%' ELSE '' END )INRATE,    MAX(B.ACCTUSE)ACCTUSE                   \n");
						sql.append( "          FROM ACCOUNT.ACDEPOSIT A, ACCOUNT.ACCTINFO B,                                                                        \n");
						sql.append( "               ACCOUNT.COMMDTIL C,  ACCOUNT.COMMDTIL D                                                                         \n");
						sql.append( "         WHERE A.ACCTCD = B.ACCTCD(+)                                                                                          \n");
						sql.append( "           AND B.BRCHCD = C.CDCODE(+) AND C.CMTYPE(+) ='0022'                                                                  \n");
						sql.append( "           AND B.ACCTGB = D.CDCODE(+) AND D.CMTYPE(+) ='2250'                                                                  \n");
						sql.append( "           AND B.DEPOGB ='3'                                                                                                   \n");
						sql.append( "           AND A.DEDATE>'20160000' AND A.DEDATE <='"+str[2]+"'                                                                 \n");
						sql.append( "         GROUP BY A.ACCTNO, A.ACCTCD                                                                                           \n");
						sql.append( "       ) X, ACCOUNT.ACDPSUM Y                                                                                                  \n");
						sql.append( " WHERE X.ACCTNO =Y.ACCTNO(+) AND X.DEDATE=Y.DEDATE(+)                                                                          \n");
						sql.append( "GROUP BY X.ACCTNO, X.ACCTCD                                                                                                    \n");

						
						
						System.out.println("# a400030_s3 Query : \n" + sql);
						
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