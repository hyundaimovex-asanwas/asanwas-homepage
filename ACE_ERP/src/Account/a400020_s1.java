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
public class a400020_s1 extends HttpServlet {
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
				String []  str	= new String [5];
				str[0] = req.getParameter("v_str1");	//계좌코드
				str[1] = req.getParameter("v_str2");	//계좌번호
				str[2] = req.getParameter("v_str3");	//거래일자FR
				str[3] = req.getParameter("v_str4");	//거래일자TO
				str[4] = req.getParameter("v_str5");	//적요
				
				
			
				for(int i=0;i<=4;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"ACCTNO",   "DEALDT",    "ACCTCD",  "REMARK",  "INAMT",
					"OUTAMT",   "BALAMT",    "FINAMT",  "FOUTAMT", "FBALAMT",
					"CURUNIT",  "EXRATE",    "TRISSUE", "DEDATE",  "DETIME",
					"RESULT",   "RSTREMARK", "RSTSEQ",  "TEAM",    "TEAMNM", "INRATE",
					"WRID",     "WRDT",      "UPID",    "UPDT",    "BALAMT2", "COSTCD", "COSTNM" }; 

				int[] intArrCN = new int[] { 
				    30,  20,  10,  100,  15, 
				    15,  15,  15,   15,  15,
				     6,   6,  60,    8,   8,
				    10,  60,   3,   10,   60, 4,
				    10,  10,  10,   10,   15, 10, 100 
					
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  0, 
					 0,   0,   2,   2,  2, 
 					-1,   2,  -1,  -1, -1,
					-1,  -1,   0,  -1, -1, 2,
 					-1,  -1,  -1,  -1,  0, -1, -1  
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( "  SELECT A.ACCTNO,A.DEALDT,A.ACCTCD,A.REMARK,A.INAMT,      \n");
						sql.append( "         A.OUTAMT,A.BALAMT,A.FINAMT,A.FOUTAMT,A.FBALAMT,   \n");
						sql.append( "         A.CURUNIT,A.EXRATE,A.TRISSUE,A.DEDATE,A.DETIME,   \n");
						sql.append( "         A.RESULT,A.RSTREMARK,A.RSTSEQ,A.TEAM, B.DEPTNM AS TEAMNM ,A.INRATE,    \n");
						sql.append( "         A.WRID,   A.WRDT,   A.UPID,   A.UPDT, X.BALAMT2 , A.COSTCD , G.CDNAM AS COSTNM   \n");
						sql.append( "    FROM ACCOUNT.ACDEPOSIT A, PAYROLL.HCDEPT B, ACCOUNT.COMMDTIL G, \n");
						sql.append( "         (SELECT ACCTNO, \n");
						sql.append( "                 (SUM(CASE WHEN DEDATE='20160000' THEN (BALAMT) ELSE 0 END) + SUM(INAMT)-SUM(OUTAMT)) BALAMT2   \n");
						sql.append( "            FROM ACCOUNT.ACDEPOSIT  X \n");
						sql.append( "           WHERE DEDATE < '"+str[2]+"' AND CURUNIT !='WON'  \n");
						sql.append( "           GROUP BY ACCTNO )  X \n");
						sql.append( "   WHERE A.TEAM =B.DEPTCD(+) \n");
						sql.append( "     AND A.ACCTNO = X.ACCTNO (+)  \n");
						sql.append( "     AND A.COSTCD = G.CDCODE(+) AND G.CMTYPE(+)='0030'                   \n");
						if(!str[0].equals("")) sql.append( " AND A.ACCTCD = '"+str[0]+"'\n");
						if(!str[1].equals("")) sql.append( " AND A.ACCTNO = '"+str[1]+"'\n");
						if(!str[2].equals("")&&!str[3].equals("")) sql.append( " AND A.DEDATE BETWEEN '"+str[2]+"' AND '"+str[3]+"'\n");
						if(!str[4].equals("")) sql.append( " AND A.REMARK = '"+str[4]+"'	\n");
						
					

						System.out.println("# a400020_s1 Query : \n" + sql);
						
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