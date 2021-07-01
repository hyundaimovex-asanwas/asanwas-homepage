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
public class comm_card_s1 extends HttpServlet {
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
                String  str2	= req.getParameter("v_str2");


				if (str1 == null) str1 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CANBR",	    "CARDNO", "CAACCBANK", "BANKNM", 
					                                "CACARDSPEC",	"CARDKD", "CABANKNO",  "ACCNO" 
				                                 
																				 }; 

				int[] intArrCN = new int[] {  16, 40,  4, 40,
					                             3, 40, 20, 40 
				                           }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, 
					                           -1, -1, -1, -1
				                           }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT A.CANBR,      C.CDNAM AS CARDNO,                                                       ");
					sql.append( "         A.CAACCBANK,  B.CDNAM AS BANKNM,                                                       ");
					sql.append( "         A.CACARDSPEC, E.CDNAM AS CARDKD,                                                       ");
					sql.append( "         A.CABANKNO,   D.CDNAM AS ACCNO                                                         ");
					sql.append( "    FROM ACCOUNT.CARDCODE A                                                                     ");
					sql.append( "    LEFT JOIN ACCOUNT.COMMDTIL B ON A.CAACCBANK = B.CDCODE AND B.CMTYPE ='2168'           "); //은행
                    sql.append( "    LEFT JOIN ACCOUNT.COMMDTIL C ON A.CANBR = C.CDCODE AND C.CMTYPE ='2167'           ");//카드번호
					sql.append( "    LEFT JOIN ACCOUNT.COMMDTIL D ON A.CABANKNO = D.CDCODE AND D.CMTYPE ='2166'        ");//계좌번호
					sql.append( "    LEFT JOIN ACCOUNT.COMMDTIL E ON A.CACARDSPEC = E.CDCODE AND E.CMTYPE ='1134'      ");//카드종류
					sql.append( "   WHERE A.VEND_CD ='"+str1+"'                                                                  ");
					sql.append( "     AND (A.USE_TAG ='Y' OR (A.USE_TAG<>'Y' AND A.DSUDT>='"+str2+"' ))                          ");

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