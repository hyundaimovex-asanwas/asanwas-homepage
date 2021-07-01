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
public class a400040_s1 extends HttpServlet {
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
				String []  str	= new String [2];
				str[0] = req.getParameter("v_str1");	//보고일자
				str[1] = req.getParameter("v_str2");	//거래일자
				
				
				
				for(int i=0;i<=1;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"CHKBOX",   "ACCTNO",    "REPTDT",   "DEDATE",   "INOUTGB",    "REMARK2",
					"PLAMT",    "REAMT",     "CUAMT",    "RESULT",   "REMARK",     "RSTSEQ",  "WRID", "RESYN", "DEALDT"
					 }; 

				int[] intArrCN = new int[] { 
					  1,  30,  8,   8,	10,  100,
				     15,  15, 15,  10,  60,    3,  10,  1,  20
				};  
			
				int[] intArrCN2 = new int[]{ 
				    -1,  -1,  -1,  -1, 	-1,  -1,	
					 0,   0,   0,  -1,  -1,   0,  -1,  -1,  -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						
						sql.append( "  SELECT '' CHKBOX, A.ACCTNO, '"+str[0]+"' AS REPTDT ,                \n");
						sql.append( "         A.DEDATE   ,                                                 \n");
						sql.append( "         CASE WHEN A.RESULT ='1' THEN '입금'                           \n");
						sql.append( "              WHEN A.RESULT='2' THEN '출금' ELSE '기타' END INOUTGB,    \n");
						sql.append( "         ''REMARK2,                                                   \n");
						sql.append( "         0 PLAMT, --ACREPLAN의 CUAMT 금액                                                               \n");
						sql.append( "         CASE WHEN A.RESULT='1' THEN A.INAMT                          \n");
						sql.append( "              WHEN A.RESULT='2' THEN A.OUTAMT ELSE 0 END REAMT,       \n");
						
						//sql.append( "         INAMT REAMT, --ACDEPOSIT에서 가져옴                                                          \n");
						sql.append( "         0 CUAMT,   --직접입력함.                                        \n");
						sql.append( "         CASE WHEN A.RESULT IS NULL THEN B.RESULT ELSE A.RESULT END RESULT,            \n");
						sql.append( "         CASE WHEN A.RSTREMARK IS NULL THEN B.RSTREMARK ELSE A.RSTREMARK END REMARK,   \n");
						sql.append( "         CASE WHEN A.RSTSEQ =0 THEN B.RSTSEQ ELSE A.RSTSEQ END RSTSEQ, A.WRID, A.RESYN , A.DEALDT \n");
						sql.append( "    FROM ACCOUNT.ACDEPOSIT A, ACCOUNT.ACCTINFO B                       \n");
						sql.append( "   WHERE A.ACCTNO = B.ACCTNO(+)                                        \n");
						sql.append( "     AND A.RESULT IN ('1','2')  -- 입금출금                                                             \n");
						sql.append( "     AND A.DEDATE ='"+str[1]+"' -- 거래일자                                                             \n");
						sql.append( "   ORDER BY RSTSEQ, ACCTNO                                             \n");
						
						
						/*
						sql.append( " SELECT ''CHKBOX, X.ACCTNO, X.REPTDT, X.DEDATE, X.INOUTGB, X.REMARK2, X.PLAMT, X.REAMT, X.CUAMT, \n");
						sql.append( "        X.RESULT, X.REMARK, X.RSTSEQ, ROWNUM AS SEQ , '' WRID \n");
						sql.append( "   FROM ( \n");
						
						sql.append( "  --전기이월                                                                                             \n");
						sql.append( "  SELECT '' ACCTNO,                                                                                       \n");
						sql.append( "         '20161004' AS REPTDT ,                                                                           \n");
						sql.append( "         '20161001' DEDATE ,                                                                              \n");
						sql.append( "         '전기이월' AS INOUTGB,                                                                             \n");
						sql.append( "         ''REMARK2 ,                                                                                        \n");
						sql.append( "         0 PLAMT, --ACREPLAN의 CUAMT 금액                                                               \n");
						sql.append( "         SUM(CASE WHEN DEDATE='20160000' THEN BALAMT ELSE 0 END) + SUM(INAMT)-SUM(OUTAMT) AS REAMT,     \n");
						sql.append( "         0 CUAMT,  -- 직접입력함.                                                                         \n");
						sql.append( "        ''RESULT,'' REMARK,1 RSTSEQ                                                                     \n");
						sql.append( "    FROM ACCOUNT.ACDEPOSIT                                                                                \n");
						sql.append( "   WHERE DEDATE <'20161001'                                                                               \n");
						sql.append( "   GROUP BY DEDATE                                                                                        \n");
						sql.append( "                                                                                                          \n");
						sql.append( "   UNION ALL                                                                                              \n");
						sql.append( "  --입금                                                                                                  \n");
						sql.append( "  SELECT A.ACCTNO, '20161004' AS REPTDT ,                                                                 \n");
						sql.append( "         A.DEDATE   ,                                                                              \n");
						sql.append( "         '입금'INOUTGB,                                                                                   \n");
						sql.append( "         ''REMARK2,                                                                                        \n");
						sql.append( "         0 PLAMT, --ACREPLAN의 CUAMT 금액                                                               \n");
						sql.append( "         SUM(INAMT)AS REAMT, --ACDEPOSIT에서 가져옴                                                     \n");
						sql.append( "         0 CUAMT    --직접입력함.                                                                         \n");
						sql.append( "         , B.RESULT, B.RSTREMARK AS REMARK, B.RSTSEQ                                                                \n");
						sql.append( "    FROM ACCOUNT.ACDEPOSIT A, ACCOUNT.ACCTINFO B                                                          \n");
						sql.append( "   WHERE A.ACCTNO = B.ACCTNO(+)                                                                           \n");
						sql.append( "     AND A.RESULT ='1'  -- 입금                                                                           \n");
						sql.append( "     AND A.DEDATE ='20161001' -- 거래일자                                                                 \n");
						sql.append( "  GROUP BY A.ACCTNO, A.DEDATE, B.RESULT, B.RSTREMARK, B.RSTSEQ                                            \n");
						sql.append( "  )X \n");
					    */
						
						
						
						System.out.println("# a400040_s1 Query : \n" + sql);
						
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