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
public class a030010_s22_n_b extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1"); //지점코드         
				String  str2  = req.getParameter("v_str2");	//from 기간
				String  str3	= req.getParameter("v_str3");	//to 기간
				String  str4  = req.getParameter("v_str4");	//사업소           
				String  str5  = req.getParameter("v_str5");	//본부             

				if(str1 == null) str1 = ""; 
				if(str2 == null) str2 = ""; 
				if(str3 == null) str3 = ""; 
				if(str3 == null) str3 = ""; 
				if(str4 == null) str4 = ""; 

				String strbyyyy = str2.substring(0,4); 
				       strbyyyy = String.valueOf(Integer.parseInt(strbyyyy) - 1); //전기년
				String strbfrmm = str2.substring(4,6); //전기from 월
				String strbtomm = str3.substring(4,6); //전기to 월

				String strbfryymm = strbyyyy+strbfrmm;
				String strbtoyymm = strbyyyy+strbtomm;
				String strprtcode="07";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{   "PRTNAM", "PRTSEQ", "XLTTOT", "XRTTOT", "XCOM",
																						"XREAD", "YLTTOT", "YRTTOT", "YCOM", "YREAD"
				}; 

				int[] intArrCN = new int[]{ 66, 5, 15, 15, 100,
																		1, 15, 15, 100, 1
				}; 
			
				int[] intArrCN2 = new int[]{-1, -1, 0, 0, -1,
																		-1,  0, 0, -1, -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				}
				
				if (!GauceReq.isBuilderRequest()) {
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT X.PRTNAM PRTNAM, X.PRTSEQ PRTSEQ, nvl(X.LTTOT,0) XLTTOT, nvl(X.RTTOT,0) XRTTOT, X.COM XCOM, \n" );
					sql.append( "        X.READ XREAD, nvl(Y.LTTOT,0) YLTTOT, nvl(Y.RTTOT,0) YRTTOT, Y.COM YCOM, Y.READ YREAD \n" );
					sql.append( " FROM  \n" );
					sql.append( " ( \n" );
					sql.append( "		SELECT D.ATCODE AS ATCODE, \n" );
					sql.append( "          D.PRTNAM AS PRTNAM, \n" );
					sql.append( "          D.PRTSEQ AS PRTSEQ, \n" );
					sql.append( "          D.PRTNBR AS PRTNBR, \n" );
					sql.append( "          CASE WHEN D.LRDIV = 'L' OR D.LRDIV = 'B' THEN CASE WHEN C.ATDECR = '1' THEN DETOT - CRTOT ELSE CRTOT - DETOT END END AS LTTOT, \n" );
					sql.append( "          CASE WHEN D.LRDIV = 'R' THEN CASE WHEN C.ATDECR = '1' THEN DETOT - CRTOT ELSE CRTOT - DETOT END END AS RTTOT, \n" );
					sql.append( "          CASE WHEN RTRIM(D.PRTRT) IS NOT NULL AND RTRIM(D.PRTRT) IS NOT NULL THEN D.PRTRT END COM, \n" );
					sql.append( "          CASE WHEN D.LRDIV = 'B' THEN 'B' END READ \n" );
					sql.append( "		FROM ACCOUNT.RPTPRTACT D \n" );
					sql.append( "   LEFT JOIN ( \n" );
					sql.append( "						SELECT G.ATDECR, G.ATCODE, SUM(G.DETOT) AS DETOT, SUM(G.CRTOT) AS CRTOT  \n" );
					sql.append( "						FROM (                                                                   \n" );
					sql.append( "									  SELECT B.ATDECR  AS ATDECR, B.ATCODE  AS ATCODE, A.DETOT, A.CRTOT \n" );
					sql.append( "										  FROM ACCOUNT.MTOTALBAL A,ACCOUNT.ACTCODE B                      \n" );
					sql.append( "										 WHERE A.ATCODE = B.ATCODE                                        \n" );
					if(!str1.equals("")) sql.append( " AND A.FDCODE = '"+str1+"'                                      \n" );
					sql.append( "											 AND A.ACTYYMM BETWEEN '"+str2+"' AND '"+str3+"'                \n" );
					if(!str4.equals("")) sql.append( " AND A.COCODE = '"+str4+"'                                       \n" );
					if(!str5.equals("")) sql.append( " AND A.DIVCD = '"+str5+"'                                       \n" );
					sql.append( "											 AND A.ATCODE LIKE '4%' \n");
					sql.append( "								 )G                                                                  \n" );
					sql.append( "						GROUP BY G.ATDECR,G.ATCODE                                               \n" );
					sql.append( "		) C " );
					sql.append( "   ON C.ATCODE = D.ATCODE " );
					sql.append( "   WHERE D.PRTCODE = '"+strprtcode+"' " );
					sql.append( " ) X, \n" );					
					sql.append( " ( \n" );
					sql.append( "		SELECT D.ATCODE AS ATCODE, \n" );
					sql.append( "					 D.PRTNAM AS PRTNAM, \n" );
					sql.append( "          D.PRTSEQ AS PRTSEQ, \n" );
					sql.append( "          D.PRTNBR AS PRTNBR, \n" );
					sql.append( "		   CASE WHEN D.LRDIV = 'L' OR D.LRDIV = 'B' THEN CASE WHEN C.ATDECR = '1' THEN DETOT - CRTOT ELSE CRTOT - DETOT END END AS LTTOT, \n" );
					sql.append( "          CASE WHEN D.LRDIV = 'R' THEN CASE WHEN C.ATDECR = '1' THEN DETOT - CRTOT ELSE CRTOT - DETOT END END AS RTTOT, \n" );
					sql.append( "          CASE WHEN RTRIM(D.PRTRT) IS NOT NULL AND RTRIM(D.PRTRT) IS NOT NULL THEN D.PRTRT END COM, \n" );
					sql.append( "		   CASE WHEN D.LRDIV = 'B' THEN 'B' END READ \n" );
					sql.append( "		FROM ACCOUNT.RPTPRTACT D \n" );
					sql.append( "   LEFT JOIN  ( \n" );
					sql.append( "								SELECT G.ATDECR, G.ATCODE, SUM(G.DETOT) AS DETOT, SUM(G.CRTOT) AS CRTOT    \n" );
					sql.append( "								FROM (                                                                     \n" );
					sql.append( "											 SELECT B.ATDECR  AS ATDECR, B.ATCODE  AS ATCODE, A.DETOT, A.CRTOT   \n" );
					sql.append( "												 FROM ACCOUNT.MTOTALBAL A,ACCOUNT.ACTCODE B                        \n" );
					sql.append( "												WHERE A.ATCODE = B.ATCODE                                          \n" );
					if(!str1.equals("")) sql.append( "		AND A.FDCODE = '"+str1+"'                                              \n" );
					sql.append( "													AND A.ACTYYMM BETWEEN '"+strbfryymm+"' AND '"+strbtoyymm+"'                      \n" );
					if(!str4.equals("")) sql.append( "		AND A.COCODE = '"+str4+"'                                              \n" );
					if(!str5.equals("")) sql.append( "    AND A.DIVCD = '"+str5+"' \n" );
					sql.append( "											    AND A.ATCODE LIKE '4%' \n");
					sql.append( "										 )G                                                                     \n" );
					sql.append( "								GROUP BY G.ATDECR,G.ATCODE                                                 \n" );
					sql.append( "		) C \n" );
					sql.append( "		ON C.ATCODE = D.ATCODE \n" );
					sql.append( "   WHERE D.PRTCODE = '"+strprtcode+"' \n" );
					sql.append( " ) Y \n" );
					sql.append( " WHERE X.ATCODE = Y.ATCODE \n" );
					sql.append( " ORDER BY 2 \n" );

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