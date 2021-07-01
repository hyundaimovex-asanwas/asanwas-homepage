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
public class commdtil_s6_bk extends HttpServlet {
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
				String  str2	= req.getParameter("v_str2");  //중분류  ( 계정에 따른 중분류 있으면 좋을 것 같음 ) 
				String  str3	= req.getParameter("v_str3");  //자산명
				String  str4	= req.getParameter("v_str4");  //1.신규등록,   2.신규등록 외 ( 매각, 폐기, 자본적지출, 이체 ) 
				  
				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				 
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "FDCODE",	  "H_ASTNBR",  "ASTNM",	    "ASAQSDAT",	
				                                  "COSTCD",   "COSTNM",  	 "ASAQSDIV",	"ASAQSDIVNM",	
					                                "ASTAQAMT", "ASTUSER",   "USERNM",	  	
					                                "BUYFROM",  "VEND_NM",   "ASTSTATNM"
				 
				 }; 

				int[] intArrCN = new int[]{ 2,  8, 60,  8, 
					                          6, 60,  1, 20, 
					                         13, 20, 40,  
					                         13, 60,10
					                         }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, 
					                           -1, -1, -1, -1, 
					                            0, -1, -1, 
					                           -1, -1,-1
					
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
                    sql.append( " 	SELECT X.FDCODE, X.H_ASTNBR, X.ASTNAME, X.ASTNM, X.ASAQSDAT,																								 \n " );
                    sql.append( " 	       X.COSTCD, X.COSTNM, X.ASAQSDIV, X.ASAQSDIVNM,																												 \n " );
					sql.append( " 	       SUM(ASTAQAMT) AS ASTAQAMT ,  X.ASTUSER, X.USERNM,																										 \n " );
					sql.append( " 	       X.BUYFROM,X.VEND_NM ,X.ASTSTATNM																																									 \n " );
					sql.append( " 	  FROM ( \n " );
					sql.append( "						 SELECT A.FDCODE, A.H_ASTNBR, A.ASTNAME,TRIM(X.ASTNM) AS ASTNM, A.ASAQSDAT,                         \n " );
					sql.append( "						        B.COSTCD, TRIM(Y.CDNAM) AS COSTNM, B.ASAQSDIV,TRIM(Z.CDNAM) AS ASAQSDIVNM,                   \n " );
					sql.append( "						        B.ASTAQAMT,  B.ASTUSER, TRIM(D.EMPNMK) AS USERNM,                                            \n " );
                    sql.append( "						        B.BUYFROM, TRIM(C.VEND_NM) AS VEND_NM,TRIM(Q.CDNAM) AS ASTSTATNM                                                      	 \n " );
					sql.append( "						   FROM ACCOUNT.ASTMSTN A,  ACCOUNT.ASTBASICN B                                                      \n " );
					sql.append( "						   LEFT JOIN ACCOUNT.ASTNAME X ON A.AST2ND=X.AST2ND AND A.AST3RD = X.AST3RD AND A.ASTNAME = X.ASTCD  \n " );
                    sql.append( "						   LEFT JOIN ACCOUNT.COMMDTIL Y ON B.COSTCD=Y.CDCODE AND Y.CMTYPE='0030'                             \n " );
					sql.append( "						   LEFT JOIN ACCOUNT.COMMDTIL Z ON B.ASAQSDIV=Z.CDCODE AND Z.CMTYPE='2103'                           \n " );
					sql.append( "						   LEFT JOIN ACCOUNT.COMMDTIL Q ON B.ASTSTAT=Q.CDCODE AND Q.CMTYPE='2106'                           \n " );
					sql.append( "						   LEFT JOIN PAYROLL.YIPERSON D ON B.ASTUSER = D.EMPNO AND D.USESTS IN ('1','2','3')                 \n " );
					sql.append( "						   LEFT JOIN ACCOUNT.GCZM_VENDER C ON C.VEND_CD=B.BUYFROM                                            \n " );
                    sql.append( "						 WHERE A.FDCODE = B.FDCODE                                                                           \n " );
					sql.append( "						   AND A.AST1ST = B.AST1ST                                                                           \n " );
					sql.append( "						   AND A.AST2ND = B.AST2ND                                                                           \n " );
                    sql.append( "						               AND A.AST3RD = B.AST3RD                                                                           \n " );
					sql.append( "						   AND A.ASTSEQ = B.ASTSEQ                                                                           \n " );
					if(str4.equals("1")){
					sql.append( "						   AND ( A.FSDAT='' AND A.FSNBR='' AND A.FSSEQ='')                                                   \n " );
					sql.append( "						   AND NOT EXISTS ( SELECT FSREFVAL																																	 \n " );
					sql.append( "						                      FROM ACCOUNT.FSLIPREF K1, ACCOUNT.FSLIPMST K2																	 \n " );
					sql.append( "						                     WHERE K1.FDCODE = K2.FDCODE																										 \n " );
					sql.append( "						                       AND K1.FSDAT = K2.FSDAT																											 \n " );
					sql.append( "						                       AND K1.FSNBR = K2.FSNBR																											 \n " );
					sql.append( "						                       AND K2.ACTDAT >='20110601'																										 \n " );
					sql.append( "						                       AND K1.FSREFCD ='1135'																												 \n " );
					sql.append( "						                       AND K1.FSREFVAL = A.H_ASTNBR																									 \n " );
					sql.append( "						                       AND A.FDCODE =K1.FDCODE )																										 \n " );					
					}else if (str4.equals("2")){	
					sql.append( "						   AND B.ASTSTAT <> '0'																										 \n " );		
					}
					
					if (!str1.equals(""))sql.append( "  AND A.FDCODE = '" + str1 + "'    \n " );
				    if (!str2.equals(""))sql.append( "  AND A.AST2ND = '" + str2 + "'    \n " );
					if (!str2.equals(""))sql.append( "  AND X.ASTNM LIKE '" + str3 + "%' \n " );
					sql.append( " 	      ) X \n " );
					sql.append( " 	GROUP BY X.FDCODE, X.H_ASTNBR,X.ASTNAME, X.ASTNM, X.ASAQSDAT,																									\n " );
					sql.append( " 	         X.COSTCD, X.COSTNM, X.ASAQSDIV, X.ASAQSDIVNM,X.ASTUSER, X.USERNM,																		\n " );
					sql.append( " 	         X.BUYFROM,X.VEND_NM	, X.ASTSTATNM																																								\n " );
                    sql.append( " 	ORDER BY X.H_ASTNBR																																														\n " );
          
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