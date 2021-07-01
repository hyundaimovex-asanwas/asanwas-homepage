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
public class asetdep_popup_s12 extends HttpServlet {
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

				String  str1 = req.getParameter("v_str1");    //소속
				String  str2 = req.getParameter("v_str2");    //자산분류
				String  str3 = req.getParameter("v_str3");    //상각년월
				String  str4 = req.getParameter("v_str4");    //원화구분 1-원화 2 외화

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"ASTNBR",     "ASTNAME",   "ASTYUSE",   "ASAQSDAT", "ASTAQAMT", 
					                               "ABDEPRAMT", "ACDEPRAMT", "ASTRMAMT",  "LASTYM",   "ASTAMT", 
					                               "ASNAM",     "COSTNM"
				                                };  

				int[] intArrCN = new int[]{ 11, 30, 5,  8, 13, 
					                          13, 13, 13, 6, 13,
					                          30, 40 
					                        }; 
					
				int[] intArrCN2 = new int[]{-1, -1,  2, -1, 0,
					                           0,  0,  0, -1, 0,
					                          -1, -1
				                            }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();

					/*
          			sql.append( " SELECT  (CASE A.AST1ST WHEN '01' THEN 'S' WHEN '02' THEN 'S'                           \n");
					sql.append( "                        WHEN '03' THEN 'K' WHEN '04' THEN 'G' END||                     \n");
					sql.append( "          CASE A.AST2ND WHEN '11' THEN 'L' WHEN '12' THEN 'B'                           \n");
					sql.append( "                        WHEN '13' THEN 'S' WHEN '14' THEN 'V'                           \n");
					sql.append( "                        WHEN '15' THEN 'I' WHEN '16' THEN 'F'                           \n");
					sql.append( "                        WHEN '17' THEN 'E' END||                                        \n");
					sql.append( "          CASE A.AST3RD WHEN '01' THEN 'H' WHEN '02' THEN 'B'                           \n");
					sql.append( "                        WHEN '03' THEN 'C' WHEN '04' THEN 'O'                           \n");
					sql.append( "                        WHEN '05' THEN 'T' WHEN '06' THEN 'F'                           \n");
					sql.append( "                        WHEN '07' THEN 'E' WHEN '00' THEN '0' END||A.ASTSEQ) AS ASNBR,  \n");
					*/
				/*	
					sql.append( " SELECT  A.ASTNBR,                                                                      \n");
					sql.append( "         A.ASTNAME,  COALESCE(B.ASTYUSE,0) AS ASTYUSE,                                  \n");
					sql.append( "         A.ASAQSDAT,                                                                    \n");
				*/
					/*
					sql.append( "         COALESCE(B.ASTAQAMT,0)  AS ASTAQAMT,                                           \n");
					sql.append( "         COALESCE(C.ABDEPRAMT,0) AS ABDEPRAMT,                                          \n");
  					sql.append( "         COALESCE(C.ACDEPRAMT,0) AS ACDEPRAMT,                                          \n");
					sql.append( "         COALESCE(C.ASTRMAMT,0)  AS ASTRMAMT,                                           \n");
					*/
				/*	
					sql.append( "         CASE WHEN  '"+str4+"'=1  THEN COALESCE(B.ASTAQAMT,0)   ELSE COALESCE(B.ASTAQAMTY,0) END AS ASTAQAMT,\n");
					sql.append( "         CASE WHEN  '"+str4+"'=1  THEN COALESCE(C.ABDEPRAMT,0)  ELSE COALESCE(C.FOBDAMT,0) END AS ABDEPRAMT, \n");
					sql.append( "         CASE WHEN  '"+str4+"'=1  THEN COALESCE(C.ACDEPRAMT,0)  ELSE COALESCE(C.FOCDAMT,0) END AS ACDEPRAMT, \n");
					sql.append( "         CASE WHEN  '"+str4+"'=1  THEN COALESCE(C.ASTRMAMT,0)   ELSE COALESCE(C.FORMAMT,0) END AS ASTRMAMT,  \n");
					sql.append( "         CASE WHEN  '"+str4+"'=1  THEN COALESCE(D.ASTAMT,0)     ELSE COALESCE(D.FOATAMT,0) END AS ASTAMT,    \n");
					sql.append( "         COALESCE(SUBSTR(C.DEPRENDDT,1,6),'') AS LASTYM,                                \n");
					//sql.append( "         COALESCE(D.ASTAMT,0) AS ASTAMT,                                                \n");
					sql.append( "         \n"); 
					sql.append( "         TRIM(X.ASTNM) AS ASNAM ,TRIM(Y.CDNAM) AS COSTNM                                \n");
					sql.append( "  FROM ACCOUNT.ASTMSTN A                                                                \n");
					sql.append( "  LEFT JOIN ACCOUNT.ASTBASICN B ON A.FDCODE=B.FDCODE AND A.ATCODE=B.ATCODE              \n");
					sql.append( "                               AND A.AST1ST=B.AST1ST AND A.AST2ND=B.AST2ND              \n");
					sql.append( "                               AND A.AST3RD=B.AST3RD AND A.ASTSEQ=B.ASTSEQ              \n");
					sql.append( "  LEFT JOIN ACCOUNT.ASTDEPR C ON A.FDCODE=C.FDCODE AND A.ATCODE=C.ATCODE                \n");
 					sql.append( "                             AND A.AST1ST=C.AST1ST AND A.AST2ND=C.AST2ND                \n");
					sql.append( "                             AND A.AST3RD=C.AST3RD AND A.ASTSEQ=C.ASTSEQ                \n");
					sql.append( "  LEFT JOIN ACCOUNT.ASTYEPR D ON A.FDCODE=D.FDCODE AND A.ATCODE=D.ATCODE                \n");
					sql.append( "                             AND A.AST1ST=D.AST1ST AND A.AST2ND=D.AST2ND                \n");
					sql.append( "                             AND A.AST3RD=D.AST3RD AND A.ASTSEQ=D.ASTSEQ                \n");
					if (!str3.equals("")) sql.append( " AND D.ASTYM = '" + str3 + "' " );
					sql.append( "  LEFT JOIN ACCOUNT.ASTNAME X ON A.AST2ND=X.AST2ND AND A.AST3RD = X.AST3RD AND A.ASTNAME = X.ASTCD \n"); 
					sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL Y ON B.COSTCD=Y.CDCODE AND Y.CMTYPE='0030'                 \n");			
					sql.append( " WHERE A.AST2ND>'11'  ");
					sql.append( "   AND B.DEPRGB = '1' "); //상각처리 건만...

					if (!str3.equals("")) sql.append( " AND A.ASAQSDAT <= '"+str3+"31' "); //상각처리 건만...
					if (!str1.equals("")) sql.append( " AND A.FDCODE = '" + str1 + "' " );
					if (!str2.equals("")) sql.append( " AND A.AST2ND = '" + str2 + "' " );			
					
					sql.append( "  ORDER BY  A.ASTNBR "); 
			*/
					
					sql.append( " SELECT  A.ASTNBR,                                                                      																			\n");
					sql.append( "         A.ASTNAME,  COALESCE(B.ASTYUSE,0) AS ASTYUSE,                                  															\n");
					sql.append( "         A.ASAQSDAT,                                                                    																				\n");
					sql.append( "         CASE WHEN  '"+str4+"'=1  THEN COALESCE(B.ASTAQAMT,0)   ELSE COALESCE(B.ASTAQAMTY,0) END AS ASTAQAMT,	\n");
					sql.append( "         CASE WHEN  '"+str4+"'=1  THEN COALESCE(C.ABDEPRAMT,0)  ELSE COALESCE(C.FOBDAMT,0) END AS ABDEPRAMT, 	\n");
					sql.append( "         CASE WHEN  '"+str4+"'=1  THEN COALESCE(C.ACDEPRAMT,0)  ELSE COALESCE(C.FOCDAMT,0) END AS ACDEPRAMT, 	\n");
					sql.append( "         CASE WHEN  '"+str4+"'=1  THEN COALESCE(C.ASTRMAMT,0)   ELSE COALESCE(C.FORMAMT,0) END AS ASTRMAMT,  	\n");
					sql.append( "         CASE WHEN  '"+str4+"'=1  THEN COALESCE(D.ASTAMT,0)     ELSE COALESCE(D.FOATAMT,0) END AS ASTAMT,    		\n");
					sql.append( "         COALESCE(SUBSTR(C.DEPRENDDT,1,6),'') AS LASTYM,                                					\n");
					sql.append( "         TRIM(X.ASTNM) AS ASNAM ,TRIM(Y.CDNAM) AS COSTNM                                					\n");
					sql.append( "  FROM ACCOUNT.ASTMSTN A                                                                									\n");
					sql.append( "  LEFT JOIN ACCOUNT.ASTBASICN B ON A.FDCODE=B.FDCODE AND A.ATCODE=B.ATCODE              \n");
					sql.append( "                               AND A.AST1ST=B.AST1ST AND A.AST2ND=B.AST2ND              						\n");
					sql.append( "                               AND A.AST3RD=B.AST3RD AND A.ASTSEQ=B.ASTSEQ              					\n");
					sql.append( "  LEFT JOIN ACCOUNT.ASTDEPR C ON A.FDCODE=C.FDCODE AND A.ATCODE=C.ATCODE                \n");
 					sql.append( "                             AND A.AST1ST=C.AST1ST AND A.AST2ND=C.AST2ND                						\n");
					sql.append( "                             AND A.AST3RD=C.AST3RD AND A.ASTSEQ=C.ASTSEQ                					\n");
					sql.append( "  LEFT JOIN ACCOUNT.ASTYEPR D ON A.FDCODE=D.FDCODE AND A.ATCODE=D.ATCODE                \n");
					sql.append( "                             AND A.AST1ST=D.AST1ST AND A.AST2ND=D.AST2ND                						\n");
					sql.append( "                             AND A.AST3RD=D.AST3RD AND A.ASTSEQ=D.ASTSEQ                					\n");
					if (!str3.equals("")) sql.append( " AND D.ASTYM = '" + str3 + "' " );
					sql.append( "  LEFT JOIN ACCOUNT.ASTNAME X ON A.AST2ND=X.AST2ND AND A.AST3RD = X.AST3RD AND A.ASTNAME = X.ASTCD 	\n"); 
					sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL Y ON B.COSTCD=Y.CDCODE AND Y.CMTYPE='0030'                 							\n");			
					sql.append( " WHERE A.AST2ND>'11'  ");
					sql.append( "   AND B.DEPRGB = '1' "); //상각처리 건만...
					if (!str3.equals("")) sql.append( " AND A.ASAQSDAT <= '"+str3+"31' "); //상각처리 건만...
					if (!str1.equals("")) sql.append( " AND A.FDCODE = '" + str1 + "' " );
					if (!str2.equals("")) sql.append( " AND A.AST2ND = '" + str2 + "' " );			
					sql.append( "  ORDER BY  A.ASTNBR "); 					
					
					//System.out.println("asetdep_popup_s12 \n"+sql.toString() );
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