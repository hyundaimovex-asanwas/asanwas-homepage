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
public class a090006_s1 extends HttpServlet {
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
				String  str2	= req.getParameter("v_str2");    //관리부서
				String  str3	= req.getParameter("v_str3");    //계정과목  
				String  str4	= req.getParameter("v_str4");    //자산중분류  
				String  str5	= req.getParameter("v_str5");    //자산소분류 
				String  str6	= req.getParameter("v_str6");    //취득일자  from
				String  str7	= req.getParameter("v_str7");    //취득일자  to    
				
				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				if (str7 == null) str7 = "";
			
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "CHK", "CDNAM", "ASTSEQ",  "SEQ1", "SEQ1", "ASTNO",  "ASTKND", "ASTNAME", "ASAQSDAT", 
															"ASTQTY",    "ASTUNIT",   "ASTAQAMT",   "MNGDPT",  "USEDPT" ,
															"MNGDPTNM", "USEDPTNM", "AST1ST"
													   }; 
 
				int[] intArrCN = new int[]{ 1,  30, 5, 20, 20, 11, 2, 30, 8,
			                   					10, 2, 13, 4, 4,
													50, 50, 10
					                          }; 
					
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1,-1, -1, -1,
												0, -1, 0, -1, -1,
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
					sql.append( " SELECT     \n ");
					sql.append( " 'F' AS CHK, E.CDNAM, A.ASTSEQ, \n ");
					sql.append( " (A.AST1ST  || A.AST2ND  || A.AST3RD  ||  A.ASTSEQ) AS SEQ1, \n");
					sql.append( " (A.AST1ST  || A.AST2ND  || A.AST3RD  ||  A.ASTSEQ) AS SEQ2,\n");
					sql.append( " RTRIM(A.AST1ST) || RTRIM(A.AST2ND) || RTRIM(A.AST3RD) || RTRIM(A.ASTSEQ) AS ASTNO, \n ");
					sql.append( " A.AST2ND AS ASTKND,  /*11:토지, 12:건물,13:구축물, 14:차량운반구 15:기계장치, 16:공기구비품, 17:기타유형자산*/  ");
					sql.append( " A.ASTNAME, \n ");
					sql.append( " A.ASAQSDAT, \n ");
					sql.append( " COALESCE(B.ASTQTY,0) AS ASTQTY, B.ASTUNIT, COALESCE(B.ASTAQAMT,0) AS ASTAQAMT, B.MNGDPT, B.USEDPT, \n ");
					sql.append( " RTRIM(C.DEPTNM) AS MNGDPTNM, /*관리부서명 CHAR(50)*/ \n ");
					sql.append( " CASE WHEN SUBSTR(B.ASTNOTE,1,2)='PC'THEN RTRIM(SUBSTR(B.ASTNOTE,3))ELSE RTRIM(D.DEPTNM) END  AS USEDPTNM, /*사용부서명  CHAR(50)*/ \n ");
					sql.append( " CASE A.AST1ST \n ");
					sql.append( " WHEN 01 THEN 'S' \n ");
					sql.append( " WHEN 02 THEN 'S' \n ");
					sql.append( " WHEN 03 THEN 'K' \n ");
					sql.append( " ELSE 'G' END AST1ST \n ");
					sql.append( " FROM ACCOUNT.ASTMST A, ACCOUNT.ASTBASIC B, PAYROLL.HCDEPT C, PAYROLL.HCDEPT D  \n ");
					sql.append( " LEFT JOIN ACCOUNT.COMMDTIL E ON A.ASTNAME=E.CDCODE AND CMTYPE='2161'  \n ");
					sql.append( " WHERE A.FDCODE = B.FDCODE   \n ");
					sql.append( "   AND A.ATCODE = B.ATCODE   \n ");
					sql.append( "   AND A.AST1ST = B.AST1ST   \n ");
					sql.append( "   AND A.AST2ND = B.AST2ND   \n ");
					sql.append( "   AND A.AST3RD = B.AST3RD   \n ");
					sql.append( "   AND A.ASTSEQ = B.ASTSEQ   \n ");
					sql.append( "   AND B.MNGDPT = C.DEPTCD   \n ");
					sql.append( "   AND B.USEDPT = D.DEPTCD   \n ");
			        if (!str1.equals(""))  sql.append( "  AND   A.FDCODE = '"+str1+"'  ");
					if (!str2.equals(""))  sql.append( "  AND   B.MNGDPT = '"+str2+"'   ");
					if (!str3.equals(""))  sql.append( "  AND   A.ATCODE = '"+str3+"'  ");
			        if (!str4.equals(""))  sql.append( "  AND   A.AST2ND = '"+str4+"'  ");	
					if (!str5.equals(""))   sql.append( "  AND  A.AST3RD = '"+str5+"' ");
					if (!str6.equals(""))  sql.append( "  AND   A.ASAQSDAT BETWEEN  '"+str6+"' AND '"+str7+"' "); 

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