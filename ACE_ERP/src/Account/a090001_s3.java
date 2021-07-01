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
public class a090001_s3 extends HttpServlet {
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
				String  str2	= req.getParameter("v_str2");    //자산중분류
				String  str3	= req.getParameter("v_str3");    //자산소분류
				String  str4	= req.getParameter("v_str4");    //계정코드 
				String  str5	= req.getParameter("v_str5");    //일련번호

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
		        if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"ASTSTAT",
					                             "MNGTYPE", "ASCOSDIV","COSTCD",
					                              "GODDIV", "ASTCLASS", "ASTRIS",
					                              "ASTUNIT","ASTSTD","MNGDPT","USEDPT",					
				                                   "USELOC","BUYFROM","MAKER",
					                              "ASAQSDIV",
					                             "ASTNOTE",
					                             "ASTVALYMD","ASTYUSE","ASTAQAMT","ASTQTY",
					                              "ASTSEQ","FDCODE","ATCODE","AST1ST","AST2ND","AST3RD", "VEND_NM",
					"MNGDPTNM", "USEDPTNM", "MAKERNM", "COSTNM","ASTUSER","ASTUSERNM" };
		 

				int[] intArrCN = new int[]{  1,
					                         1,   1,   6,
					                         1,   1,   1,
                                             10,   30,  4,  4,
					                         30,   30, 30,
					                          1,
					                         50,
					                        8,3,13,10,
					                         5,2,7,2,2,2, 30,
					30, 30, 30, 30,7,50 };
									
					
				int[] intArrCN2 = new int[]{ -1,
					                         -1,   -1,   -1,
					                          -1,  -1,    -1,
					                          -1,  -1,    -1, -1,
					                          -1,   -1, -1,
					                          -1,
					                            -1,
					                          -1, 0,0,0,
					                          -1,-1,-1,-1,-1,-1, -1,
					-1, -1, -1, -1 ,-1,-1};
														

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();

					sql.append( " 	SELECT           "); 
					sql.append( "	A.FDCODE, A.ATCODE, A.AST1ST, A.AST2ND,         \n ");		
					sql.append( "	A.AST3RD,      \n ");
					sql.append( "   A.ASTSEQ,       \n ");
					sql.append( "	A.ASTSTAT,        \n ");
					sql.append( "	A.MNGTYPE,       \n ");
					sql.append( "	A.ASCOSDIV,      \n ");
					sql.append( "	A.COSTCD,        \n ");
					sql.append( "	A.GODDIV,       \n ");
					sql.append( "	A.ASTCLASS,     \n ");
					sql.append( "	A.ASTRIS,       ");
					sql.append( "	A.ASTUNIT,      ");
					sql.append( "	A.ASTSTD,       ");
					sql.append( "	nvl(A.ASTAQAMT,0)  ASTAQAMT,    ");
					sql.append( "	nvl(A.ASTYUSE,0)   ASTYUSE,   ");
					sql.append( "	A.ASTVALYMD,     ");
					sql.append( "	A.MNGDPT,       ");
					sql.append( "	A.USEDPT,      ");
					sql.append( "	A.USELOC,       ");
					sql.append( "	A.BUYFROM,      ");
					sql.append( "	A.MAKER,      ");
					sql.append( "	A.ASAQSDIV,     ");
					sql.append( "	A.ASTNOTE,     ");
					sql.append( "	nvl(A.ASTQTY,0)  ASTQTY, B.VEND_NM , (C.DEPTNM) MNGDPTNM, (D.DEPTNM) USEDPTNM, (E.CDNAM) AS MAKERNM,(F.CDNAM) AS COSTNM,A.ASTUSER, G.EMPNMK AS ASTUSERNM   \n ");
					sql.append( "	FROM ACCOUNT.ASTBASIC A     \n ");
					sql.append( "	LEFT JOIN ACCOUNT.GCZM_VENDER B ON B.VEND_CD = A.BUYFROM     \n ");
					if (!str1.equals("")){
					  sql.append( "	LEFT JOIN PAYROLL.HCDEPT C ON A.MNGDPT = C.DEPTCD AND C.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) \n ");
					  sql.append( "	LEFT JOIN PAYROLL.HCDEPT D ON A.USEDPT = D.DEPTCD AND D.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)  \n ");
					}else{
					  sql.append( "	LEFT JOIN PAYROLL.HCDEPT C ON A.MNGDPT = C.DEPTCD AND C.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) \n ");
					  sql.append( "	LEFT JOIN PAYROLL.HCDEPT D ON A.USEDPT = D.DEPTCD AND D.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) \n ");
					}
					sql.append( "	LEFT JOIN ACCOUNT.COMMDTIL E ON A.MAKER=E.CDCODE AND E.CMTYPE='2163'    \n ");
					sql.append( "	LEFT JOIN ACCOUNT.COMMDTIL F ON A.COSTCD=F.CDCODE AND F.CMTYPE='0030'    \n ");
					sql.append( "	LEFT JOIN PAYROLL.CIPERSON G ON A.ASTUSER=G.EMPNO    \n ");
					sql.append( "	WHERE A.FDCODE IS NOT NULL      \n  " );
 					if (!str1.equals(""))  sql.append( " AND   A.FDCODE = '"+str1+"'    AND   AST1ST = '"+str1+"' "); 							
 					if (!str2.equals(""))  sql.append( " AND   A.AST2ND = '"+str2+"'  ");
 					if (!str3.equals(""))  sql.append( " AND   A.AST3RD = '"+str3+"'  ");
 					if (!str4.equals(""))  sql.append( " AND   A.ATCODE = '"+str4+"'  ");
 					if (!str5.equals(""))  sql.append( " AND   A.ASTSEQ = '"+str5+"'  ");

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