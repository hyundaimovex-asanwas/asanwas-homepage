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
public class a020001_s4 extends HttpServlet {
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
				String [] str = new String [4];
				str[0]	= req.getParameter("v_str1");		//현장코드
				str[1]	= req.getParameter("v_str2");		//가전표일자
				str[2]	= req.getParameter("v_str3");		//가전표번호
				str[3]	= req.getParameter("v_str4");		//가전표행번호

				for (int s=0;s<=3;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "FDCODE", "FSDAT","FSNBR","FSSEQ", 
					                                 "ACNNBR",   "BANJAEYN",  "ERCODE",   "ERAMT",  "ERCRORAT",   
                                           "BUDYEAR",  "BUDDEPT",   "PRIMCOST",
					                                 "WRDT",	"WRID",	"UPDT",	"UPID"
																				};

				int[] intArrCN = new int[]{ 2, 9, 6, 5,
					                          9, 1, 3, 15, 6,
					                          4, 4, 5,
					                          8,  7, 8,  7
																	}; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, 0 ,
					                           -1 , -1, -1, 0, 0,
					                           -1 , -1, -1,
					                           -1 , -1, -1, -1
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT  FDCODE,   FSDAT,    FSNBR,   CAST(FSSEQ AS INTEGER)FSSEQ,    						");
					sql.append( "          COALESCE(ACNNBR,'')ACNNBR,   COALESCE(BANJAEYN,'')BANJAEYN,  						");
					sql.append( "          COALESCE(ERCODE,'')ERCODE,   COALESCE(ERAMT,0)ERAMT,     COALESCE(ERCRORAT,0)ERCRORAT, 		");
					sql.append( "          COALESCE(BUDYEAR,'')BUDYEAR, COALESCE(BUDDEPT,'')BUDDEPT,COALESCE(PRIMCOST,'')PRIMCOST, 	");
					sql.append( "          COALESCE(WRDT,'')WRDT,COALESCE(WRID,'')WRID,COALESCE(UPDT,'')UPDT,COALESCE(UPID,'')UPID		");
					sql.append( "    FROM ACCOUNT.FSLIPDTL                                         													");
					sql.append( "   WHERE  FDCODE IS NOT NULL                                         											");
				
					if(!str[0].equals("")) { sql.append( " AND FDCODE = '"+str[0]+"' "); }
					if(!str[1].equals("")) { sql.append( " AND FSDAT = '"+str[1]+"' "); }
					if(!str[2].equals("")) { sql.append( " AND FSNBR = '"+str[2]+"' "); }
					if(!str[3].equals("")) { sql.append( " AND CAST(FSSEQ AS INTEGER)= '"+str[3]+"' "); }
		
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