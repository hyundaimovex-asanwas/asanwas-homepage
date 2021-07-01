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
public class a090004_s12 extends HttpServlet {
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

				String  str1	= req.getParameter("v_str1");    //사업장
				String  str2	= req.getParameter("v_str2");    //기준년월

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
		          "COSTCD","COSTNM","JSGUBUN","GETAMTY","GETAMT",
		          "SANGNUAMT","DANGGIAMT","JANJONAMT"
		        };  

				int[] intArrCN = new int[]{ 
		          6, 40, 40, 10, 13,
		          13, 13, 13
		        }; 
					
				int[] intArrCN2 = new int[]{ 
		          -1,-1, -1,4, 0,
		            0, 0, 0
		        }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();
					sql.append("\n SELECT C.COSTCD AS COSTCD,                                                                                                 ");
					sql.append("\n        Y.CDNAM AS COSTNM,                                                                                                  ");
					sql.append("\n        Z.CDNAM AS JSGUBUN,                                                                                                 ");
					sql.append("\n        SUM(C.ASTAQAMTY) AS GETAMTY,                                                                                        ");
					sql.append("\n        SUM(C.ASTAQAMT) AS GETAMT,                                                                                          ");
					sql.append("\n        SUM(A.ABDEPRAMT) AS SANGNUAMT,                                                                                      ");
					sql.append("\n        SUM(A.ACDEPRAMT) AS DANGGIAMT,                                                                                      ");
					sql.append("\n        SUM(C.ASTAQAMT) - SUM(A.ABDEPRAMT) - SUM(A.ACDEPRAMT) AS JANJONAMT                                                  ");
					sql.append("\n   FROM ACCOUNT.ASTDEPR A,ACCOUNT.ASTMST B,                                                                                 ");
					sql.append("\n        ACCOUNT.ASTBASIC C LEFT OUTER JOIN (SELECT * FROM ACCOUNT.COMMDTIL WHERE CMTYPE = '0030') Y ON C.COSTCD = Y.CDCODE, ");
					sql.append("\n        ACCOUNT.COMMDTIL Z                                                                                                  ");
					sql.append("\n  WHERE A.FDCODE = B.FDCODE AND A.ATCODE = B.ATCODE AND A.AST1ST = B.AST1ST                                                 ");
					sql.append("\n    AND A.AST2ND = B.AST2ND AND A.AST3RD = B.AST3RD AND A.ASTSEQ = B.ASTSEQ                                                 ");
					sql.append("\n    AND A.FDCODE = C.FDCODE AND A.ATCODE = C.ATCODE AND A.AST1ST = C.AST1ST                                                 ");
					sql.append("\n    AND A.AST2ND = C.AST2ND AND A.AST3RD = C.AST3RD AND A.ASTSEQ = C.ASTSEQ                                                 ");
					sql.append("\n    AND A.AST2ND = Z.CDCODE                                                                                                 ");
					sql.append("\n    AND Z.CMTYPE = '2101'                                                                                                   ");
					sql.append("\n    AND A.AST2ND >= '11'                                                                                                    ");
					sql.append("\n    AND TRIM(C.COSTCD) IS NOT NULL                                                                                                ");
					if(str2!=null && !str2.equals("")){
					sql.append("\n 	 AND SUBSTR(A.DEPRENDDT,1,6) = '"+str2+"'	                                                                              ");
					}
					if(str1!=null && !str1.equals("")){
					sql.append("\n    AND A.FDCODE LIKE '"+str1+"%'	                                                                                              ");
					}
					if(str2!=null && !str2.equals("")){
					sql.append("\n    AND SUBSTR(B.ASAQSDAT,1,6) <= '"+str2+"'	                                                                             ");
					}
					sql.append("\n GROUP BY C.COSTCD,Y.CDNAM,Z.CDNAM                                                                                          ");
					sql.append("\n ORDER BY C.COSTCD,Y.CDNAM,Z.CDNAM                                                                                          ");				

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