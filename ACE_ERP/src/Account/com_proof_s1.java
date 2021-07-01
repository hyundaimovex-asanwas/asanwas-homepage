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
public class com_proof_s1 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1");  //지점
				String  str2  = req.getParameter("v_str2");  //전표일자
				String  str3  = req.getParameter("v_str3");  //전표번호
				String  str4  = req.getParameter("v_str4");  //전표행번호

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "FDCODE","FSDAT","FSNBR","FSSEQ","RSVNO",
																					"RSTDIV","RSTNO","VENDCD","VENDNM","REMARK","AMOUNT",
																					"RSVDATE","RSVMAN","EMPNMK"
				}; 

				int[] intArrCN = new int[] { 2, 9, 6, 5, 11,
																			3, 16, 13,62, 40, 15,
																			8, 7, 20
				}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
																			-1, -1, -1, -1,-1, 0,
																			-1, -1, -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT A.FDCODE, A.FSDAT, A.FSNBR, A.FSSEQ, A.RSVNO, " );
					sql.append( "        A.RSTDIV, A.RSTNO, A.VEND_CD AS VENDCD, B.VEND_NM AS VENDNM , " );
					sql.append( "        A.REMARK, IFNULL(A.AMOUNT,0) AMOUNT, " );
					sql.append( "        A.RSVDATE, A.RSVMAN, C.EMPNMK " );
					sql.append( " FROM ACCOUNT.GENRST A " );
					sql.append( " LEFT JOIN ACCOUNT.GCZM_VENDER B ON A.VEND_CD = B.VEND_CD " );
					sql.append( " LEFT JOIN PAYROLL.HIPERSON C ON A.RSVMAN = C.EMPNO " );

					sql.append( " WHERE FDCODE = '"+str1+"'" );
					sql.append( "   AND FSDAT = '"+str2+"'" );
					sql.append( "   AND FSNBR = '"+str3+"'" );
					sql.append( "   AND FSSEQ = '"+str4+"'" );

					//logger.dbg.println(this,"");

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