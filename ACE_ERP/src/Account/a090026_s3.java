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
public class a090026_s3 extends HttpServlet {
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
				// 자산 이체 및 이동

				String  str1 = req.getParameter("v_str1");    //자산번호    
				String  str2 = req.getParameter("v_str2");    //이체 -8 , 이동 -9 구분    


				if (str1 == null) str1 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "ASTNBR",	 "S_ASTNBR",	"AST1ST",	    "AST2ND",	    "AST2NDNM",	
					                                 "AST3RD",	 "AST3RDNM",	"ASTSEQ",	    "ASTNAME",	  "ASTNM",	
					                                 "ASAQSDAT", "ASTQTY",	  "ASTYUSE",	  "ASTAQAMT", 	"GODDIV",	
					                                 "GODDIVNM", "ASAQSDIV",	"ASAQSDIVNM",	"BCOSTCD",	  "BCOSTNM",	
					                                 "BMNGDPT",	 "BMNGDPTNM",	"BUSEDPT",	  "BUSEDPTNM",  "BUSER",	
					                                 "BUSERNM",	 "ASTSTAT",	  "ABDEPRAMT",	"ACDEPRAMT",  "ASTRMAMT",	
					                                 "MOVDATE",  "LASTYM"
                                          
				                                }; 

				int[] intArrCN = new int[]{ 8, 8, 2, 2, 30,
					                          2,30, 5,30, 60,
				                            8,10, 3,13,  1,
					                         30, 1,30, 6, 100,
					                          4,60, 4,60, 20,
					                         40, 1,13,13, 13,
					                          8, 6
				                           }; 
					
				int[] intArrCN2 = new int[]{-1, -1, -1, -1, -1,
					                          -1, -1, -1, -1, -1,
					                          -1,  0,  0,  0, -1,
					                          -1, -1, -1, -1, -1, 
					                          -1, -1, -1, -1, -1, 
					                          -1, -1,  0,  0,  0,
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
					sql.append( " SELECT B.ASTNBR,   B.S_ASTNBR, A.AST1ST, A.AST2ND, TRIM(E.CDNAM) AS AST2NDNM,                                            \n");
					sql.append( "        A.AST3RD,   TRIM(F.CDNAM) AS AST3RDNM,  A.ASTSEQ,  B.ASTNAME,  TRIM(X.ASTNM) AS ASTNM,                            \n");
					sql.append( "        B.ASAQSDAT, COALESCE(A.ASTQTY,0) AS ASTQTY,  COALESCE(A.ASTYUSE,0) AS ASTYUSE, COALESCE(A.ASTAQAMT,0) AS ASTAQAMT,\n");
					sql.append( "        A.GODDIV,   TRIM(G.CDNAM) AS GODDIVNM,   A.ASAQSDIV, TRIM(H.CDNAM) AS ASAQSDIVNM,                                 \n");
					sql.append( "        A.COSTCD AS BCOSTCD, TRIM(L.CDNAM)||'=>'||TRIM(I.CDNAM) AS BCOSTNM,                                               \n");
					sql.append( "        A.MNGDPT AS BMNGDPT, TRIM(C.DEPTNM) AS BMNGDPTNM,                                                                 \n");
					sql.append( "        A.USEDPT AS BUSEDPT, TRIM(D.DEPTNM) AS BUSEDPTNM,                                                                 \n");
					sql.append( "        A.ASTUSER AS BUSER,  TRIM(Z.EMPNMK) AS BUSERNM,                                                                   \n");
					sql.append( "        A.DEPRGB AS BDEPTGB,                                                                                              \n");
					sql.append( "        A.ASTSTAT,                                                                                                        \n");
					sql.append( "        COALESCE(Y.ABDEPRAMT,0) AS ABDEPRAMT, COALESCE(Y.ACDEPRAMT,0) AS ACDEPRAMT, COALESCE(Y.ASTRMAMT,0) AS ASTRMAMT,   \n");
					sql.append( "        M.MOVDATE,  SUBSTR(Y.DEPRENDDT,1,6) AS LASTYM                                                                     \n");
					sql.append( "   FROM ACCOUNT.ASTBASICN A, ACCOUNT.ASTMSTN B                                                                            \n");
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT C ON A.MNGDPT=C.DEPTCD AND C.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)                  \n");
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT D ON A.USEDPT=D.DEPTCD AND D.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)                  \n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL E ON E.CDCODE = A.AST2ND AND E.CMTYPE ='2101'                                               \n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL F ON F.CDCODE = A.AST3RD AND F.CMTYPE ='2141'                                               \n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL G ON G.CDCODE = A.GODDIV AND G.CMTYPE ='2111'                                               \n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL H ON H.CDCODE = A.ASAQSDIV AND H.CMTYPE ='2103'                                             \n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL I ON A.COSTCD = I.CDCODE AND I.CMTYPE='0030'                                                \n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTNAME X ON B.AST2ND=X.AST2ND AND B.AST3RD = X.AST3RD AND B.ASTNAME = X.ASTCD                       \n");
					sql.append( "   LEFT JOIN PAYROLL.YIPERSON Z ON A.ASTUSER = Z.EMPNO AND Z.USESTS IN ('1','2','3')                                      \n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTDEPR Y ON Y.FDCODE = A.FDCODE AND Y.ATCODE = A.ATCODE                                             \n");
					sql.append( "                              AND Y.AST1ST = A.AST1ST AND Y.AST2ND = A.AST2ND                                             \n");
					sql.append( "                              AND Y.AST3RD = A.AST3RD AND Y.ASTSEQ = A.ASTSEQ                                             \n");
					sql.append( "   LEFT JOIN (  SELECT Y.FDCODE, Y.ATCODE,  Y.AST1ST,  Y.AST2ND,  Y.AST3RD,  Y.ASTSEQ, Y.ASTGUBUN,                        \n");
					sql.append( "                       Y.MOVDATE, Y.BCOSTCD AS BBCOSTCD                                                                   \n");
					sql.append( "                   FROM ACCOUNT.ASTMOVINGN Y                                                                              \n");
					sql.append( "                  WHERE ASTGUBUN ='"+str2+"'                                                                              \n");
					sql.append( "                    AND ASTMOVNO  =( SELECT MAX(X.ASTMOVNO)                                                               \n");
					sql.append( "                                       FROM ACCOUNT.ASTMOVINGN X                                                          \n");
					sql.append( "                                      WHERE Y.FDCODE = X.FDCODE                                                           \n");
					sql.append( "                                        AND Y.ATCODE = X.ATCODE                                                           \n");
					sql.append( "                                        AND Y.AST1ST = X.AST1ST                                                           \n");
					sql.append( "                                        AND Y.AST2ND = X.AST2ND                                                           \n");
					sql.append( "                                        AND Y.AST3RD = X.AST3RD                                                           \n");
					sql.append( "                                        AND Y.ASTSEQ = X.ASTSEQ                                                           \n");
					sql.append( "                                        AND Y.ASTGUBUN = '"+str2+"'                                                       \n");
					sql.append( "                                    )                                                                                     \n");
					sql.append( "             ) M ON M.FDCODE = A.FDCODE                                                                                   \n");
					sql.append( "                AND M.ATCODE = A.ATCODE                                                                                   \n");
					sql.append( "                AND M.AST1ST = A.AST1ST                                                                                   \n");
					sql.append( "                AND M.AST2ND = A.AST2ND                                                                                   \n");
					sql.append( "                AND M.AST3RD = A.AST3RD                                                                                   \n");
					sql.append( "                AND M.ASTSEQ = A.ASTSEQ                                                                                   \n");	
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL L ON M.BBCOSTCD = L.CDCODE AND L.CMTYPE='0030'                                              \n");
					sql.append( "  WHERE A.FDCODE = B.FDCODE                                                                                               \n");
					sql.append( "    AND A.AST1ST = B.AST1ST                                                                                               \n");
					sql.append( "    AND A.AST2ND = B.AST2ND                                                                                               \n");
					sql.append( "    AND A.AST3RD = B.AST3RD                                                                                               \n");
					sql.append( "    AND A.ASTSEQ = B.ASTSEQ                                                                                               \n");
					if (str2.equals("8"))sql.append( "  AND A.ASTSTAT ='"+str2+"'                                                                          \n");
					if (str2.equals("9"))sql.append( "  AND M.ASTGUBUN ='"+str2+"'                                                                          \n");
					if (!str1.equals(""))sql.append( "  AND  B.ASTNBR IN  ("+str1+")   \n");		 //자산번호  
				*/	
	
					sql.append( " SELECT B.ASTNBR,   B.S_ASTNBR, A.AST1ST, A.AST2ND, TRIM(E.CDNAM) AS AST2NDNM,                                            \n");
					sql.append( "        A.AST3RD,   TRIM(F.CDNAM) AS AST3RDNM,  A.ASTSEQ,  B.ASTNAME,  TRIM(X.ASTNM) AS ASTNM,                            \n");
					sql.append( "        B.ASAQSDAT, COALESCE(A.ASTQTY,0) AS ASTQTY,  COALESCE(A.ASTYUSE,0) AS ASTYUSE, COALESCE(A.ASTAQAMT,0) AS ASTAQAMT,\n");
					sql.append( "        A.GODDIV,   TRIM(G.CDNAM) AS GODDIVNM,   A.ASAQSDIV, TRIM(H.CDNAM) AS ASAQSDIVNM,                                 \n");
					sql.append( "        A.COSTCD AS BCOSTCD, TRIM(L.CDNAM)||'=>'||TRIM(I.CDNAM) AS BCOSTNM,                                               \n");
					sql.append( "        A.MNGDPT AS BMNGDPT,                                                                				\n");
					sql.append( "        ASNHR.SF_GET_DPTNAME0('01','A6',A.MNGDPT ) AS BMNGDPTNM,                     \n");
					sql.append( "        A.USEDPT AS BUSEDPT,                                                                 				\n");
					sql.append( "        ASNHR.SF_GET_DPTNAME0('01','A6',A.USEDPT ) AS BUSEDPTNM,                      \n");
					sql.append( "        A.ASTUSER AS BUSER,                                      											\n");
					sql.append( "        ASNHR.SF_GET_ENONAME('01',A.ASTUSER ) AS BUSERNM,                               \n");					
					sql.append( "        A.DEPRGB AS BDEPTGB,                                                                               \n");
					sql.append( "        A.ASTSTAT,                                                                                                   \n");
					sql.append( "        COALESCE(Y.ABDEPRAMT,0) AS ABDEPRAMT, COALESCE(Y.ACDEPRAMT,0) AS ACDEPRAMT, COALESCE(Y.ASTRMAMT,0) AS ASTRMAMT,   \n");
					sql.append( "        M.MOVDATE,  SUBSTR(Y.DEPRENDDT,1,6) AS LASTYM                                                                     \n");
					sql.append( "   FROM ACCOUNT.ASTBASICN A                                                                            									\n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTMSTN B ON A.FDCODE = B.FDCODE                 	 													\n");
					sql.append( "    						AND A.AST1ST = B.AST1ST                                                                                               \n");
					sql.append( "    						AND A.AST2ND = B.AST2ND                                                                                               \n");
					sql.append( "    						AND A.AST3RD = B.AST3RD                                                                                               \n");
					sql.append( "    						AND A.ASTSEQ = B.ASTSEQ                                                                                               \n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL E ON E.CDCODE = A.AST2ND AND E.CMTYPE ='2101'                                               \n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL F ON F.CDCODE = A.AST3RD AND F.CMTYPE ='2141'                                               \n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL G ON G.CDCODE = A.GODDIV AND G.CMTYPE ='2111'                                               \n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL H ON H.CDCODE = A.ASAQSDIV AND H.CMTYPE ='2103'                                             \n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL I ON A.COSTCD = I.CDCODE AND I.CMTYPE='0030'                                                \n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTNAME X ON B.AST2ND=X.AST2ND AND B.AST3RD = X.AST3RD AND B.ASTNAME = X.ASTCD                       \n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTDEPR Y ON Y.FDCODE = A.FDCODE AND Y.ATCODE = A.ATCODE                                             \n");
					sql.append( "                              AND Y.AST1ST = A.AST1ST AND Y.AST2ND = A.AST2ND                                             \n");
					sql.append( "                              AND Y.AST3RD = A.AST3RD AND Y.ASTSEQ = A.ASTSEQ                                             \n");
					sql.append( "   LEFT JOIN (  SELECT Y.FDCODE, Y.ATCODE,  Y.AST1ST,  Y.AST2ND,  Y.AST3RD,  Y.ASTSEQ, Y.ASTGUBUN,                        \n");
					sql.append( "                       Y.MOVDATE, Y.BCOSTCD AS BBCOSTCD                                                                   \n");
					sql.append( "                   FROM ACCOUNT.ASTMOVINGN Y                                                                              \n");
					sql.append( "                  WHERE ASTGUBUN ='"+str2+"'                                                                              \n");
					sql.append( "                    AND ASTMOVNO  =( SELECT MAX(X.ASTMOVNO)                                                               \n");
					sql.append( "                                       FROM ACCOUNT.ASTMOVINGN X                                                          \n");
					sql.append( "                                      WHERE Y.FDCODE = X.FDCODE                                                           \n");
					sql.append( "                                        AND Y.ATCODE = X.ATCODE                                                           \n");
					sql.append( "                                        AND Y.AST1ST = X.AST1ST                                                           \n");
					sql.append( "                                        AND Y.AST2ND = X.AST2ND                                                           \n");
					sql.append( "                                        AND Y.AST3RD = X.AST3RD                                                           \n");
					sql.append( "                                        AND Y.ASTSEQ = X.ASTSEQ                                                           \n");
					sql.append( "                                        AND Y.ASTGUBUN = '"+str2+"'                                                       \n");
					sql.append( "                                    )                                                                                     					\n");
					sql.append( "             ) M ON M.FDCODE = A.FDCODE                                                                                   \n");
					sql.append( "                AND M.ATCODE = A.ATCODE                                                                                   \n");
					sql.append( "                AND M.AST1ST = A.AST1ST                                                                                   \n");
					sql.append( "                AND M.AST2ND = A.AST2ND                                                                                   \n");
					sql.append( "                AND M.AST3RD = A.AST3RD                                                                                   \n");
					sql.append( "                AND M.ASTSEQ = A.ASTSEQ                                                                                   \n");	
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL L ON M.BBCOSTCD = L.CDCODE AND L.CMTYPE='0030'             \n");
					sql.append( "  WHERE 1 = 1                                                                                               						\n");
					if (str2.equals("8"))sql.append( "  AND A.ASTSTAT ='"+str2+"'                                                                          \n");
					if (str2.equals("9"))sql.append( "  AND M.ASTGUBUN ='"+str2+"'                                                                          \n");
					if (!str1.equals(""))sql.append( "  AND  B.ASTNBR IN  ("+str1+")   \n");		 //자산번호  
					
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