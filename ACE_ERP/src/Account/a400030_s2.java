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
public class a400030_s2 extends HttpServlet {
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
	 					-1,  -1,  -1,   2, -1, -1,  -1
 					
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT   X.DEDATE,''BRCHCD,''ACCTGB,  X.BRCHNM, X.ACCTGBNM,                                          \n");
						sql.append( " 	 X.CURUNIT,   ROUND((X.A01+X.A02-X.A03)/1000000) AS BALAMTS2,        \n");
						sql.append( " 	 X.A01+X.A02-X.A03 AS BALAMTS, X.B01+X.B02-X.B03 FBALAMTS,       \n");
						sql.append( " 	 ''REMARK,  X.ACCTCD, X.ACCTNO, '' INRATE, '' ACCTUSE, ''CHKBOX , NVL(Y.CLOSEYN,'N')CLOSEYN                   \n");
						sql.append( " FROM (                                                                                                          \n");
						sql.append( " --원화                                                                                                                                                       \n");
						sql.append( "   SELECT  '"+str[2]+"'AS DEDATE, '현금(원화)' AS BRCHNM, '' AS ACCTGBNM , 'WON' AS GB, ''CURUNIT, '1'ACCTNO,  '1' ACCTCD,   \n");
						sql.append( " 	  SUM(CASE WHEN C.ACTDAT>='20160100' AND C.ACTDAT <'"+str[2]+"'    THEN C.DETOT-C.CRTOT ELSE 0  END ) A01,    --전기이월                                  \n");
						sql.append( " 	  SUM(CASE WHEN C.ACTDAT='"+str[2]+"'THEN C.DETOT ELSE 0  END ) A02,           --차변(증가)                      \n");
						sql.append( " 	  SUM(CASE WHEN C.ACTDAT='"+str[2]+"'THEN C.CRTOT ELSE 0  END ) A03,           --대변(감소)                      \n");
						sql.append( " 	   0 B01, 0 B02, 0 B03                            \n");
						sql.append( "    FROM ACCOUNT.TOTALBAL C                                        				                               \n");
						sql.append( "     WHERE C.ATCODE IN ('1110110')                                   				                               \n");
						sql.append( "       AND C.FDCODE = '02'  											                                           \n");
						sql.append( "       AND C.ACTDAT <='"+str[2]+"'                                                                                \n");
						sql.append( "  UNION ALL                                                                                                       \n");
						sql.append( "  SELECT                                                                                                          \n");
						sql.append( "    '"+str[2]+"'AS DEDATE, '현금(외화)' AS BRCHNM, '' AS ACCTGBNM ,'FOR' AS GB, MAX(CASHNM) AS CURUNIT,  \n");
						sql.append( "    ( CASE WHEN CASHCD='02' THEN '2' WHEN CASHCD='04' THEN '3' WHEN CASHCD='31' THEN '4' ELSE '' END) ACCTNO,   \n");
						sql.append( "    ( CASE WHEN CASHCD='02' THEN '2' WHEN CASHCD='04' THEN '3' WHEN CASHCD='31' THEN '4' ELSE '' END) ACCTCD,   \n");
						sql.append( " 	SUM(CASE WHEN CASHCD IN ('02','04','31') AND ACTDAT>='20160100' AND ACTDAT<'"+str[2]+"' THEN FDEAMT - FCRAMT ELSE 0 END) A01,   \n");
						sql.append( " 	--증감                                                                                                                                               \n");
						sql.append( " 	SUM(CASE WHEN CASHCD IN ('02','04','31') AND ACTDAT='"+str[2]+"' AND  FDEAMT - FCRAMT >0 THEN FDEAMT - FCRAMT ELSE 0 END) A02,  \n");
						sql.append( " 	SUM(CASE WHEN CASHCD IN ('02','04','31') AND ACTDAT='"+str[2]+"' AND  FDEAMT - FCRAMT <0 THEN FCRAMT - FDEAMT ELSE 0 END) A03,  \n");
						
						sql.append( " 	SUM(CASE WHEN CASHCD IN ('02','04','31') AND ACTDAT>='20160100' AND ACTDAT<'"+str[2]+"' THEN DEAMT - CRAMT ELSE 0 END) B01,   \n");
						sql.append( " 	--증감                                                                                                                                               \n");
						sql.append( " 	SUM(CASE WHEN CASHCD IN ('02','04','31') AND ACTDAT='"+str[2]+"' AND  DEAMT - CRAMT >0 THEN DEAMT - CRAMT ELSE 0 END) B02,  \n");
						sql.append( " 	SUM(CASE WHEN CASHCD IN ('02','04','31') AND ACTDAT='"+str[2]+"' AND  DEAMT - CRAMT <0 THEN CRAMT - DEAMT ELSE 0 END) B03  \n");
						
						sql.append( " FROM ACCOUNT.CASHHAND                                                                                                                                        \n");
						sql.append( " WHERE FDCODE = '02'                                                         \n");
						sql.append( " AND ACTDAT < ='"+str[2]+"'                                                  \n");
						sql.append( " GROUP BY CASHCD                     \n");                
						sql.append( " ) X , ACCOUNT.ACDPSUM Y                                                     \n");
						sql.append( " WHERE X.ACCTNO =Y.ACCTNO(+) AND X.DEDATE=Y.DEDATE(+)                        \n");
						sql.append( " ORDER BY ACCTNO                        \n");

						
						System.out.println("# a400030_s2 Query : \n" + sql);
						
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