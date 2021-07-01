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
public class a030023_s11 extends HttpServlet {
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
				String []  str	= new String [10];
				str[0] = req.getParameter("v_str1");	//지점코드
				str[1] = req.getParameter("v_str2");	//기간 from
				str[2] = req.getParameter("v_str3");	//기간 to
				str[3] = req.getParameter("v_str4");	//거래처
				str[4] = req.getParameter("v_str5");	//계정과목from 
				str[5] = req.getParameter("v_str6");	//계정과목to  
				str[6] = str[1].substring(4,6);  //01
				str[7] = str[1].substring(0,4);  //2008      
				
				for(int i=0;i<=7;i++) {
					if(str[i] == null) str[i] = ""; 
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "ATCODE", "ATKORNAM", "BEVAL", "DETOT", "CRTOT", "SLPVAL", "ATDECR" }; 
				int[] intArrCN = new int[] {  7,   66,   15,   15,  15,  15,  1 }; 
				int[] intArrCN2 = new int[]{  -1,   -1,   0,   0,   0,   0,  -1 }; 

				for (int i=0; i<strArrCN.length; i++) { 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

          
					sql.append( " SELECT  X.ATCODE, X.ATKORNAM,                                                                                            \n" );
					sql.append( "         SUM(X.BEVAL)BEVAL,SUM(X.DEAMT)DETOT,SUM(X.CRAMT)CRTOT,                                                           \n" );
					sql.append( "         CASE WHEN X.ATDECR='1' THEN COALESCE(SUM(X.BEVAL),0)+ COALESCE(SUM(X.DEAMT),0) - COALESCE(SUM(X.CRAMT),0)        \n" );
					sql.append( "              WHEN X.ATDECR='2' THEN COALESCE(SUM(X.BEVAL),0)+ COALESCE(SUM(X.CRAMT),0) - COALESCE(SUM(X.DEAMT),0)        \n" );
					sql.append( "              ELSE 0 END SLPVAL, X.ATDECR                                                                                 \n" );
					sql.append( "  FROM(                                                                                                                   \n" );
					sql.append( "         --전기이월                                                                                                       \n" );
					sql.append( "         SELECT A.ATCODE,  R1.FSREFVAL, C.ATDECR, C.ATKORNAM,                                                             \n" );
					sql.append( "                CASE WHEN C.ATDECR='1' THEN COALESCE(SUM(A.DEAMT),0) - COALESCE(SUM(A.CRAMT),0)                           \n" );
					sql.append( "                     WHEN C.ATDECR='2' THEN COALESCE(SUM(A.CRAMT),0) - COALESCE(SUM(A.DEAMT),0)                           \n" );
					sql.append( "                     ELSE 0 END BEVAL, 0 DEAMT, 0 CRAMT, 0 JANAMT                                                         \n" );
					sql.append( "           FROM ACCOUNT.GENENLED A, ACCOUNT.ACTCODE C,                                                                    \n" );
					sql.append( "                 (SELECT B.FDCODE, B.FSDAT, B.FSNBR, B.FSSEQ, B.FSREFCD,                                                  \n" );
					sql.append( "                         B.FSREFVAL, B.SSDAT, B.SSNBR                                                                     \n" );
					sql.append( "                    FROM ACCOUNT.GENENREF B                                                                               \n" );
					sql.append( "                   WHERE B.FDCODE = '"+str[0]+"'                                                                          \n" );
					sql.append( "                     AND B.FSREFCD = '0020'                                                                               \n" );
					sql.append( "                     AND B.FSREFVAL ='" +str[3]+ "'                                                                       \n" );
					sql.append( "                 )R1                                                                                                      \n" );
					sql.append( "          WHERE A.FDCODE =  '"+str[0]+"'                                                                                  \n" );
					if(!str[4].equals(""))sql.append( "  AND A.ATCODE BETWEEN '" +str[4]+ "'  AND '" +str[5]+ "'                                           \n" );
					sql.append( "            AND (A.ATCODE<'4000000' AND A.ATCODE NOT IN ('3302210','3302200','3302220','1110690'))                        \n" );
					sql.append( "            AND A.ACTDAT>='20060000'                                                                                      \n" );
					sql.append( "            AND A.ACTDAT<'"+str[1]+"01'                                                                                   \n" );
					sql.append( "            AND A.FDCODE= R1.FDCODE                                                                                       \n" );
					sql.append( "            AND A.FSDAT = R1.FSDAT                                                                                        \n" );
					sql.append( "            AND A.FSNBR = R1.FSNBR                                                                                        \n" );
					sql.append( "            AND A.FSSEQ = R1.FSSEQ                                                                                        \n" );
					sql.append( "            AND A.ATCODE = C.ATCODE                                                                                       \n" );
					sql.append( "          GROUP BY  A.ATCODE, R1.FSREFVAL,  C.ATDECR, C.ATKORNAM                                                          \n" );
					sql.append( "                                                                                                                          \n" );
					sql.append( "          UNION ALL                                                                                                       \n" );
					sql.append( "         --실데이타                                                                                                       \n" );
					sql.append( "         SELECT A.ATCODE, R1.FSREFVAL, C.ATDECR, C.ATKORNAM,                                                              \n" );
					sql.append( "                0 BEVAL, SUM(A.DEAMT)DEAMT, SUM(A.CRAMT)CRAMT,                                                            \n" );
					sql.append( "                CASE WHEN C.ATDECR='1' THEN COALESCE(SUM(A.DEAMT),0) - COALESCE(SUM(A.CRAMT),0)                           \n" );
					sql.append( "                     WHEN C.ATDECR='2' THEN COALESCE(SUM(A.CRAMT),0) - COALESCE(SUM(A.DEAMT),0)                           \n" );
					sql.append( "                     ELSE 0 END JANAMT                                                                                    \n" );
					sql.append( "                                                                                                                          \n" );
					sql.append( "           FROM ACCOUNT.GENENLED A, ACCOUNT.ACTCODE C,                                                                    \n" );
					sql.append( "                 (SELECT B.FDCODE, B.FSDAT, B.FSNBR, B.FSSEQ, B.FSREFCD,                                                  \n" );
					sql.append( "                         B.FSREFVAL, B.SSDAT, B.SSNBR                                                                     \n" );
					sql.append( "                    FROM ACCOUNT.GENENREF B                                                                               \n" );
					sql.append( "                   WHERE B.FDCODE = '"+str[0]+"'                                                                          \n" );
					sql.append( "                     AND B.FSREFCD = '0020'                                                                               \n" );
					sql.append( "                     AND B.FSREFVAL = '" +str[3]+ "'                                                                      \n" );
					sql.append( "                 )R1                                                                                                      \n" );
					sql.append( "          WHERE A.FDCODE = '"+str[0]+"'                                                                                   \n" );
					if(!str[4].equals(""))sql.append( "  AND A.ATCODE BETWEEN '" +str[4]+ "'  AND '" +str[5]+ "'                                           \n" );
					sql.append( "            AND A.ACTDAT>='"+str[1]+"01'                                                                                  \n" );
					sql.append( "            AND A.ACTDAT<='"+str[2]+"31'                                                                                  \n" );
					sql.append( "            AND A.FDCODE = R1.FDCODE                                                                                      \n" );
					sql.append( "            AND A.FSDAT = R1.FSDAT                                                                                        \n" );
					sql.append( "            AND A.FSNBR = R1.FSNBR                                                                                        \n" );
					sql.append( "            AND A.FSSEQ = R1.FSSEQ                                                                                        \n" );
					sql.append( "            AND A.ATCODE = C.ATCODE                                                                                       \n" );
					sql.append( "          GROUP BY A.ATCODE, R1.FSREFVAL,  C.ATDECR, C.ATKORNAM                                                           \n" );
					sql.append( "  )X                                                                                                                      \n" );
					sql.append( "  GROUP BY X.ATCODE, X.FSREFVAL, X.ATDECR, X.ATKORNAM                                                                     \n" );
					sql.append( "  HAVING  CASE WHEN X.ATDECR='1' THEN COALESCE(SUM(X.BEVAL),0)+ COALESCE(SUM(X.DEAMT),0) - COALESCE(SUM(X.CRAMT),0)       \n" );
					sql.append( "               WHEN X.ATDECR='2' THEN COALESCE(SUM(X.BEVAL),0)+ COALESCE(SUM(X.CRAMT),0) - COALESCE(SUM(X.DEAMT),0)       \n" );
					sql.append( "               ELSE 0 END <>0                                                                                             \n" );
					sql.append( "  ORDER BY X.ATCODE, X.FSREFVAL                                                                                           \n" );

					//logger.dbg.println(this, sql.toString());
						
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