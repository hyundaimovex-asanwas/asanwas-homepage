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
public class a030005_s2 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1");
				String  str2    = req.getParameter("v_str2");
				String  str3    = req.getParameter("v_str3");

				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";
				if(str3 == null) str3 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{   "FSDAT", "FSNBR", "FSSEQ", "ATKORNAM", "DEBAMT",
													"CREAMT", "REMARK", "VENDNM"
				}; 

				int[] intArrCN = new int[]{  9, 6, 5, 66, 15,
											15, 132, 32
				}; 
			
				int[] intArrCN2 = new int[]{  -1, -1, -1, -1, 0,
											0, -1, -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				}
				
				if (!GauceReq.isBuilderRequest()) {
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT G.ATKORNAM ATKORNAM, F.FSDAT FSDAT, F.FSNBR FSNBR, F.FSSEQ FSSEQ, nvl(F.DEBAMT,0) DEBAMT, 		" );
					sql.append( "					nvl(F.CREAMT,0) CREAMT, F.REMARK REMARK, H.VEND_NM VENDNM    													" );
					sql.append( "	FROM (SELECT D.FSDAT, D.FSNBR, D.FSSEQ, D.ATCODE, D.DEBAMT, D.CREAMT, D.REMARK, D.FSREFVAL   			" );
					sql.append( "		FROM ACCOUNT.FSLIPMST E LEFT JOIN             									" );
					sql.append( "			(SELECT C.FSDAT, C.FSNBR, C.FSSEQ, C.ATCODE, C.REMARK, 			" );
					sql.append( "				CASE C.ATDECR WHEN '1' THEN C.FSAMT ELSE 0 END AS DEBAMT,  " );
					sql.append( "				CASE C.ATDECR WHEN '2' THEN C.FSAMT ELSE 0 END AS CREAMT,  " );
					sql.append( "				B.FSREFVAL 																			" );
					sql.append( "				FROM ACCOUNT.FSLIPDTL C LEFT JOIN         								" );
					sql.append( "					(SELECT A.FSDAT, A.FSNBR, A.FSSEQ, A.FSREFVAL             	" );
					sql.append( "						FROM ACCOUNT.FSLIPREF A      										" );
					sql.append( "						WHERE A.FSREFCD = '0020'  											" );
					if(!str1.equals("")) sql.append( "						AND A.FDCODE LIKE '"+str1+"'      				" );
					if (!str2.equals("") && !str3.equals("")) sql.append( "				AND SUBSTR(A.FSDAT,2,9) >= '"+str2+"' AND SUBSTR(A.FSDAT,2,9) <= '"+str3+"' " );
					sql.append( "					) B ON C.FSDAT = B.FSDAT AND C.FSNBR = B.FSNBR AND C.FSSEQ = B.FSSEQ  " );
					if(!str1.equals("")) sql.append( "				WHERE C.FDCODE LIKE '"+str1+"'     					" );
					if (!str2.equals("") && !str3.equals("")) sql.append( "		AND SUBSTR(C.FSDAT,2,9) >= '"+str2+"' AND SUBSTR(C.FSDAT,2,9) <= '"+str3+"' " );
					sql.append( "			) D ON D.FSDAT = E.FSDAT AND D.FSNBR = E.FSNBR                    	" );
					sql.append( "		WHERE E.FSSTAT = 'Y'    																" );
					if(!str1.equals("")) sql.append( "		AND E.FDCODE LIKE '"+str1+"'    								" );
					if (!str2.equals("") && !str3.equals("")) sql.append( " AND SUBSTR(E.FSDAT,2,9) >= '"+str2+"' AND SUBSTR(E.FSDAT,2,9) <= '"+str3+"' " );
					sql.append( "	) F LEFT JOIN ACCOUNT.ACTCODE G ON G.ATCODE = F.ATCODE 				" );
					sql.append( "	LEFT JOIN ACCOUNT.GCZM_VENDER H ON H.VEND_CD = F.FSREFVAL   		" );
					sql.append( "   ORDER BY G.ATKORNAM, F.FSDAT, F.FSSEQ 										" );

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