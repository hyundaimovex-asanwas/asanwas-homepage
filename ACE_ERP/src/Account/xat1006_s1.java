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
public class xat1006_s1 extends HttpServlet {
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
				str[0] = req.getParameter("v_str1");	//매장코드
				str[1] = req.getParameter("v_str2");	//매출일자
				
				
			
				for(int i=0;i<=1;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
						"DFSCD",	"DFSNM",    "SALEDT",	"POSNO",	"RECNO",	"GUBUN",	
						"GUBUN2",	"ORDTM",	"APPTM",	"GOODCD",	"BARCD",	
						"GOODNM",	"GOODCNT",  "BUYAMT",	"TSALAMT",  "DISCAMT",	
						"DISGB",	"SALAMT",	"PRIAMT",	"VATAMT",	"ADJAMT",	
						"APPSUM",	"WONAMT",	"CARDAMT",  "CASHAMT",  "CNYAMT",	"CWONAMT",	
						"USDAMT",	"UWONAMT",  "PNTAMT",	"CARDCD",	"CARDNM",	
						"FDCODE",	"FSDAT",	"FSNBR",	"CHKBOX",
						"CREATE_ID",	"CREATE_DATE",	"UPDATE_ID",	"UPDATE_DATE"
				}; 

				int[] intArrCN = new int[] { 
						6,	50, 8,	2,	4,	4,	
						6,	8,	8,	26,	26,	
						50,	9,	10,	12,	12,	
						8,	12,	12,	12,	12,	
						12,	12,	12,	12,	12,	12,
						12,	12,	12,	3,	30,	
						2,	9,	6,	1,
						10,	10,	10,	10
					
				}; 
			
				int[] intArrCN2 = new int[]{ 
						-1,	-1,	-1,	-1,	-1, -1,	
						-1,	-1,	-1,	-1,	-1,	
						-1,	 0,	 0,	 0,	 0,	
						-1,	 0,	 0,	 0,	 0,	
					 	 0,	 0,	 0,	 0,  0,	0,
						 0,	 0,	 0,	-1,	-1,	
						-1,	-1,	-1,	-1,
						-1,	-1,	-1,	-1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						
						sql.append( " SELECT A.DFSCD,	B.DETAIL_NAME AS DFSNM, A.SALEDT,	A.POSNO,	A.RECNO,	A.GUBUN,      \n");
						sql.append( "        A.GUBUN2,	A.ORDTM,	A.APPTM,	A.GOODCD,	A.BARCD,	  \n");
						sql.append( "        A.GOODNM,	A.GOODCNT,	A.BUYAMT,	A.TSALAMT,	A.DISCAMT,    \n");
						sql.append( "        A.DISGB,	A.SALAMT,	A.PRIAMT,	A.VATAMT,	A.ADJAMT,     \n");
						sql.append( "        A.APPSUM,	A.WONAMT,	A.CARDAMT,	A.CASHAMT,  A.CNYAMT,	A.CWONAMT,    \n");
						sql.append( "        A.USDAMT,	A.UWONAMT,	A.PNTAMT,	A.CARDCD,	A.CARDNM,     \n");
						sql.append( "        A.FDCODE,	A.FSDAT,	A.FSNBR,    ''CHKBOX,                 \n");
						sql.append( "        A.CREATE_ID,	A.CREATE_DATE,	A.UPDATE_ID,	A.UPDATE_DATE \n");
						sql.append( "   FROM ACCOUNT.TBIF_POSDATA A   \n");
						sql.append( "   LEFT JOIN ACCOUNT.TBIF_COMSUB B ON A.DFSCD = B.DETAIL_CD AND B.HEAD_CD='001'   \n");
						sql.append( "  WHERE 1=1   \n");
						sql.append( "    AND A.FSDAT IS NULL    \n");
						if(!str[0].equals("")) sql.append( " AND A.SALEDT = '"+str[0]+"'			\n"); // 매출일자 
						if(!str[1].equals("")) sql.append( " AND A.DFSCD  IN ( '"+str[1]+"')		\n"); // 매장코드 
						
						sql.append( "  ORDER BY A.DFSCD, A.SALEDT, A.POSNO, A.RECNO   \n");
						
						
						/*
						sql.append( "  SELECT A.ACCTNO, A.BANKCD, B.CDNAM AS BANKNM,  A.ACCTCD,               \n");					
						sql.append( "         A.BRCHCD, C.CDNAM AS BRCHNM,  A.ACCTUSE, A.ACCTGB,  A.DEPOGB,   \n");
						sql.append( "         D.CDNAM AS ACCTGBNM , A.INRATE, A.REMARK, A.STATUS, A.ENDDAT,   \n");
						sql.append( "         A.TEAM,   E.DEPTNM AS TEAMNM, A.RESULT, A.RSTREMARK, A.RSTSEQ,  \n");
						sql.append( "         A.WRID,   A.WRDT,   A.UPID,   A.UPDT, A.COSTCD, G.CDNAM AS COSTNM \n");
						sql.append( "    FROM ACCOUNT.ACCTINFO A, ACCOUNT.COMMDTIL B,                         \n");
						sql.append( "         ACCOUNT.COMMDTIL C, ACCOUNT.COMMDTIL D,                         \n");
						sql.append( "         ACCOUNT.COMMDTIL G,                                             \n");
						sql.append( "         PAYROLL.HCDEPT E                                                \n");
						sql.append( "   WHERE A.BANKCD = B.CDCODE(+) AND B.CMTYPE(+)='2168'                   \n");
						sql.append( "     AND A.BRCHCD = C.CDCODE(+) AND C.CMTYPE(+)='0022'                   \n");
						sql.append( "     AND A.ACCTGB = D.CDCODE(+) AND D.CMTYPE(+)='2250'                   \n");
						sql.append( "     AND A.COSTCD = G.CDCODE(+) AND G.CMTYPE(+)='0030'                   \n");
						sql.append( "     AND A.TEAM = E.DEPTCD(+)                                            \n");
					    */
						//System.out.println("# xat1004_s1 Query : \n" + sql);
						
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