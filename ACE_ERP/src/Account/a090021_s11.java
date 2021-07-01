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
public class a090021_s11 extends HttpServlet {
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

				String  str1	= req.getParameter("v_str1");    //지점코드
				String  str2  = req.getParameter("v_str2");    //계정코드 
				String  str3	= req.getParameter("v_str3");    //1구분
				String  str4	= req.getParameter("v_str4");    //자산중분류
				String  str5	= req.getParameter("v_str5");    //자산소분류
				String  str6	= req.getParameter("v_str6");    //일련번호 
	
				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "FDCODE","ATCODE","AST1ST","AST2ND","AST3RD",
																					"ASTSEQ","ACARTYPE","ACARNO","ACARBEGI","ACARFUEL",
																					"ACARUSE","ACARINSDT","ACARDRVID","AINSDT1","AINSDT2"}; 

				int[] intArrCN = new int[]{2, 7, 2, 2, 2,
																	 5,30,20,10,10,
																	20,20,25,20,20	}; 
					
				int[] intArrCN2 = new int[]{-1,-1,-1,-1,-1,
																		-1,-1,-1,-1,-1,
																		-1,-1,-1,-1,-1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT FDCODE, ATCODE,   AST1ST,   AST2ND,  AST3RD,   ");
					sql.append( "        ASTSEQ, ACARTYPE, ACARNO,   ACARBEGI,ACARFUEL, ");    
 					sql.append( "        ACARUSE,ACARINSDT,ACARDRVID,AINSDT1, AINSDT2   ");
					sql.append( "   FROM ACCOUNT.ASTADINFO2N  ");
					sql.append( "  WHERE FDCODE IS NOT NULL       ");
 					if (!str1.equals(""))sql.append( " AND  FDCODE = '"+str1+"' ");
 					if (!str2.equals(""))sql.append( " AND  ATCODE = '"+str2+"' "); 		
 					if (!str3.equals(""))sql.append( " AND  AST1ST = '"+str3+"' ");
 					if (!str4.equals(""))sql.append( " AND  AST2ND = '"+str4+"' ");
 					if (!str5.equals(""))sql.append( " AND  AST3RD = '"+str5+"' ");
 					if (!str6.equals(""))sql.append( " AND	ASTSEQ = '"+str6+"' ");

					//logger.dbg.println( this, sql.toString() );
 					
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