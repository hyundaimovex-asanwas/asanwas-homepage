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
public class a090022_s1 extends HttpServlet {
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
				// 감가상각 조회 쿼리

				String  str1 = req.getParameter("v_str1");    //소속
				String  str2 = req.getParameter("v_str2");    //자산분류
				String  str3 = req.getParameter("v_str3");    //자산코드
				String  str4 = req.getParameter("v_str4");    //자산명
				String  str5 = req.getParameter("v_str5");    //상태
				String  str6 = req.getParameter("v_str6");    //원화,외화 구분 1-원화, 2-외화
				String  str7 = req.getParameter("v_str7");    //원가코드


				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				if (str7 == null) str7 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"ASNBR",    "ASNAM",     "ASAQSDAT",  "ASTYUSE",  "ASTAQAMT", 
					                               "ABDEPRAMT","ACDEPRAMT", "ACDEPRSUM", "ASTRMAMT" ,"LASTYM",
					                               "ASTNUM",   "CDNAM",     "COSTCD",    "COSTNM",   "ASTDEPRST" ,"REGIGB"}; 

				int[] intArrCN = new int[]{11, 30,  8,  5, 13, 
					                         13, 13, 13, 13,  6, 
					                         11, 30, 20, 40,  2, 1}; 
					
				int[] intArrCN2 = new int[]{-1, -1, -1,  2,  0,
					                           0,  0,  0,  0, -1, 
					                          -1, -1, -1, -1, -1, -1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();
				/*	
					sql.append( " SELECT B.ASTNBR AS ASNBR,   																							\n");
					sql.append( "        B.ASTNAME AS ASNAM, B.ASAQSDAT,                                               								\n");
					sql.append( "        COALESCE(C.ASTYUSE,0) AS ASTYUSE,                                             								\n");
					sql.append( "        CASE WHEN  '"+str6+"'=1  THEN COALESCE(C.ASTAQAMT,0)  ELSE COALESCE(C.ASTAQAMTY,0) END AS ASTAQAMT,                                             \n");
					sql.append( "        CASE WHEN  '"+str6+"'=1  THEN COALESCE(A.ABDEPRAMT,0) ELSE COALESCE(A.FOBDAMT,0)   END AS ABDEPRAMT,                                            \n");
					sql.append( "        CASE WHEN  '"+str6+"'=1  THEN COALESCE(A.ACDEPRAMT,0) ELSE COALESCE(A.FOCDAMT,0)   END AS ACDEPRAMT,                                            \n");
					sql.append( "        CASE WHEN  '"+str6+"'=1  THEN COALESCE(A.ABDEPRAMT,0)+COALESCE(A.ACDEPRAMT,0) ELSE COALESCE(A.FOBDAMT,0)+COALESCE(A.FOCDAMT,0) END AS ACDEPRSUM,\n");
					sql.append( "        CASE WHEN  '"+str6+"'=1  THEN COALESCE(A.ASTRMAMT,0) ELSE COALESCE(A.FORMAMT,0)   END AS ASTRMAMT,                                              \n");
					sql.append( "        COALESCE(SUBSTR(A.DEPRENDDT,1,6),'') AS LASTYM,                               						\n");
					sql.append( "       (A.AST1ST||A.AST2ND||A.AST3RD||A.ASTSEQ) AS ASTNUM, TRIM(X.ASTNM) AS CDNAM,    	\n");
					sql.append( "        C.COSTCD, TRIM(Y.CDNAM) AS COSTNM, A.ASTDEPRST , C.REGIGB                     				\n");
					sql.append( "  FROM ACCOUNT.ASTDEPR A                                                              									\n");
					sql.append( "  LEFT JOIN ACCOUNT.ASTMSTN B ON A.FDCODE=B.FDCODE AND A.ATCODE=B.ATCODE              	\n");
					sql.append( "                             AND A.AST1ST=B.AST1ST AND A.AST2ND=B.AST2ND              						\n");
					sql.append( "                             AND A.AST3RD=B.AST3RD AND A.ASTSEQ=B.ASTSEQ              						\n");
					sql.append( "  LEFT JOIN ACCOUNT.ASTBASICN C ON A.FDCODE=C.FDCODE AND A.ATCODE=C.ATCODE            	\n");
					sql.append( "                               AND A.AST1ST=C.AST1ST AND A.AST2ND=C.AST2ND            						\n");
					sql.append( "                               AND A.AST3RD=C.AST3RD AND A.ASTSEQ=C.ASTSEQ            						\n");
					sql.append( "  LEFT JOIN ACCOUNT.ASTNAME X ON B.AST2ND=X.AST2ND AND B.AST3RD = X.AST3RD AND B.ASTNAME = X.ASTCD \n"); 
					sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL Y ON C.COSTCD=Y.CDCODE AND Y.CMTYPE='0030'               		\n");
					sql.append( " WHERE A.AST2ND>'11' 													\n"); //토지 :: 토지의 경우 감가상각하지 않음.
					if (!str1.equals("")) sql.append( " AND A.FDCODE = '" + str1 + "' 				\n");
					if (!str2.equals("")) sql.append( " AND A.AST2ND = '" + str2 + "' 				\n");
					if (!str3.equals("")||!str4.equals("")) sql.append( " AND ( B.ASTNAME ='" + str3 + "' AND TRIM(X.ASTNM) LIKE '"+str4+ "%' ) \n");
					if (!str5.equals("")) sql.append( " AND A.ASTDEPRST = '" + str5 + "' 			\n");
					if (!str7.equals("")) sql.append( " AND C.COSTCD = '" + str7 + "' 				\n");
					sql.append( " ORDER BY  B.ASAQSDAT,B.ASTNBR 								\n");
				*/
					
					sql.append( " SELECT B.ASTNBR AS ASNBR,   																							\n");
					sql.append( "        B.ASTNAME AS ASNAM, B.ASAQSDAT,                                               								\n");
					sql.append( "        COALESCE(C.ASTYUSE,0) AS ASTYUSE,                                             								\n");
					sql.append( "        CASE WHEN  '"+str6+"'=1  THEN COALESCE(C.ASTAQAMT,0)  ELSE COALESCE(C.ASTAQAMTY,0) END AS ASTAQAMT,                                             \n");
					sql.append( "        CASE WHEN  '"+str6+"'=1  THEN COALESCE(A.ABDEPRAMT,0) ELSE COALESCE(A.FOBDAMT,0)   END AS ABDEPRAMT,                                            \n");
					sql.append( "        CASE WHEN  '"+str6+"'=1  THEN COALESCE(A.ACDEPRAMT,0) ELSE COALESCE(A.FOCDAMT,0)   END AS ACDEPRAMT,                                            \n");
					sql.append( "        CASE WHEN  '"+str6+"'=1  THEN COALESCE(A.ABDEPRAMT,0)+COALESCE(A.ACDEPRAMT,0) ELSE COALESCE(A.FOBDAMT,0)+COALESCE(A.FOCDAMT,0) END AS ACDEPRSUM,\n");
					sql.append( "        CASE WHEN  '"+str6+"'=1  THEN COALESCE(A.ASTRMAMT,0) ELSE COALESCE(A.FORMAMT,0)   END AS ASTRMAMT,                                              \n");
					sql.append( "        COALESCE(SUBSTR(A.DEPRENDDT,1,6),'') AS LASTYM,                               						\n");
					sql.append( "       (A.AST1ST||A.AST2ND||A.AST3RD||A.ASTSEQ) AS ASTNUM, TRIM(X.ASTNM) AS CDNAM,    	\n");
					sql.append( "        C.COSTCD, TRIM(Y.CDNAM) AS COSTNM, A.ASTDEPRST , C.REGIGB                     				\n");
					sql.append( "  FROM ACCOUNT.ASTDEPR A                                                              									\n");
					sql.append( "  LEFT JOIN ACCOUNT.ASTMSTN B ON A.FDCODE=B.FDCODE AND A.ATCODE=B.ATCODE              	\n");
					sql.append( "                             AND A.AST1ST=B.AST1ST AND A.AST2ND=B.AST2ND              						\n");
					sql.append( "                             AND A.AST3RD=B.AST3RD AND A.ASTSEQ=B.ASTSEQ              						\n");
					sql.append( "  LEFT JOIN ACCOUNT.ASTBASICN C ON A.FDCODE=C.FDCODE AND A.ATCODE=C.ATCODE            	\n");
					sql.append( "                               AND A.AST1ST=C.AST1ST AND A.AST2ND=C.AST2ND            						\n");
					sql.append( "                               AND A.AST3RD=C.AST3RD AND A.ASTSEQ=C.ASTSEQ            						\n");
					sql.append( "  LEFT JOIN ACCOUNT.ASTNAME X ON B.AST2ND=X.AST2ND AND B.AST3RD = X.AST3RD AND B.ASTNAME = X.ASTCD \n"); 
					sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL Y ON C.COSTCD=Y.CDCODE AND Y.CMTYPE='0030'               		\n");
					sql.append( " WHERE A.AST2ND>'11' 													\n"); //토지 :: 토지의 경우 감가상각하지 않음.
					if (!str1.equals("")) sql.append( " AND A.FDCODE = '" + str1 + "' 				\n");
					if (!str2.equals("")) sql.append( " AND A.AST2ND = '" + str2 + "' 				\n");
					if (!str3.equals("")||!str4.equals("")) sql.append( " AND ( B.ASTNAME ='" + str3 + "' AND TRIM(X.ASTNM) LIKE '"+str4+ "%' ) \n");
					if (!str5.equals("")) sql.append( " AND A.ASTDEPRST = '" + str5 + "' 			\n");
					if (!str7.equals("")) sql.append( " AND C.COSTCD = '" + str7 + "' 				\n");
					sql.append( " ORDER BY  B.ASAQSDAT,B.ASTNBR 								\n");

					//System.out.println("# Query : \n" + sql);
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