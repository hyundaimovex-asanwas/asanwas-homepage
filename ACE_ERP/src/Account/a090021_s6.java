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
public class a090021_s6 extends HttpServlet {
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
	                      									"ASTSEQ","REPAIRNO","REPAIRDATE","REPAIRPART","DEFECTNOTE",
									                      	"REPAIRAMT",/*"REPAIRJUDG","INCORNOT",*/ "WRDT","WRID", "VEND_NM"}; 

				int[] intArrCN = new int[]{2,7,2,2,2,
																	 5,4,8,13,30,
																	13,/*2,1,*/8,7,70}; 
					
				int[] intArrCN2 = new int[]{-1,-1,-1,-1,-1,
																		-1,-1,-1,-1,-1,
																	 	0,/*-1,-1,*/-1,-1,-1	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT  A.FDCODE, A.ATCODE,A.AST1ST,A.AST2ND,A.AST3RD,    				\n ");
					sql.append( "         A.ASTSEQ, A.REPAIRNO,A.REPAIRDATE,  A.REPAIRPART, 					\n ");            
					sql.append( "         A.DEFECTNOTE, nvl(A.REPAIRAMT,0) REPAIRAMT,    							\n ");    
 					sql.append( "         A.WRDT,   A.WRID,  B.VEND_NM                      								\n ");       
					sql.append( "   FROM  ACCOUNT.ASTREPAIR A                               								\n ");
					sql.append( "   LEFT  JOIN ACCOUNT.GCZM_VENDER B ON A.REPAIRPART = B.VEND_CD  	\n" );
					sql.append( "  WHERE  A.FDCODE IS NOT NULL    													\n ");
 					if (!str1.equals(""))  sql.append( "  AND  A.FDCODE  = '"+str1+"' 									\n ");
 					if (!str2.equals(""))  sql.append( "  AND  A.ATCODE  = '"+str2+"' 									\n "); 		
 					if (!str3.equals(""))  sql.append( "  AND  A.AST1ST  = '"+str3+"' 									\n ");
 					if (!str4.equals(""))  sql.append( "  AND  A.AST2ND  = '"+str4+"' 									\n ");
 					if (!str5.equals(""))  sql.append( "  AND  A.AST3RD  = '"+str5+"' 									\n ");
 					if (!str6.equals(""))  sql.append( "  AND  A.ASTSEQ  = '"+str6+"' 									\n ");

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