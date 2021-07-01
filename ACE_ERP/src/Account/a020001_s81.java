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
public class a020001_s81 extends HttpServlet {
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
				String [] str = new String [5];
				str[0]	= req.getParameter("v_str1");		//지점
				str[1]	= req.getParameter("v_str2");		//접수일자
				str[2]	= req.getParameter("v_str3");		//접수번호
				str[3]	= req.getParameter("v_str4");		//전표일자
				str[4]	= req.getParameter("v_str5");		//전표번호

				for (int s=0;s<=4;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "FDCODE",	  "FSDAT",	  "FSDAT1", "FSDAT2",  "FSNBR",  
					                                "FSKND",    "FSWRTDAT",	"COCODE",	"DEPTCD",  "DEPTNM",  
					                                "EMPNO",	  "EMPNMK",   "DIVCD",  "FSAMT",   "FSVAT",	
					                                "DETOT",	  "CRTOT",	  "REMARK",	"SGNDAT",	 "FSSTAT",	"ACTDAT",  
					                                "WRDT",	    "WRID",	    "UPDT",	  "UPID"  ,  "DIVNM",
					                                "SSDAT",	  "SSDAT1",	  "SSDAT2",	"SSNBR" 
				}; 

				int[] intArrCN = new int[]{  2, 9, 1,  8,  6,
					                           1, 8, 2,  4,  70,
					                           7,20, 4, 15,  15, 
					                          15,15,66,  8,   1,  8,
                                     8,  7, 8,  7, 70,
					                           9,  1, 8,  6
																	}; 

				int[] intArrCN2 = new int[]{-1, -1, -1, -1,  -1, 
					                          -1, -1, -1, -1 , -1,
                          					-1, -1, -1,  0 ,  0,
					                           0,  0, -1, -1 , -1, -1,
					                          -1, -1, -1, -1 , -1,
					                          -1, -1, -1, -1 
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				
				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT A.FDCODE,   A.FSDAT,    SUBSTR(A.FSDAT,1,1)FSDAT1, SUBSTR(A.FSDAT,2,9)FSDAT2,  A.FSNBR, \n");
					sql.append( "        A.FSKND,    A.FSWRTDAT, A.COCODE,   A.DEPTCD,  RTRIM(B.DEPTNM) DEPTNM,                                \n");
					sql.append( "        A.EMPNO,                                     \n");
					sql.append( "        CASE WHEN (RTRIM(C.EMPNMK)='' OR C.EMPNMK IS NULL) THEN E.EMPNMK ELSE C.EMPNMK END EMPNMK,   \n");
					sql.append( "        A.DIVCD,    A.FSAMT,   A.FSVAT,   \n");
					sql.append( "        COALESCE(A.DETOT,0)DETOT,  COALESCE(A.CRTOT,0)CRTOT,   A.REMARK,  A.SGNDAT,   A.FSSTAT,   A.ACTDAT, \n");
					sql.append( "        A.WRDT, A.WRID, A.UPDT, A.UPID, D.DEPTNM DIVNM,                                                                  \n");
					sql.append( "        A.SSDAT,    SUBSTR(A.SSDAT,1,1)SSDAT1, SUBSTR(A.SSDAT,2,9)SSDAT2,  A.SSNBR                         \n");
					sql.append( "   FROM  ACCOUNT.FSLIPMST A                                                                              \n");
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD=B.DEPTCD                                                       \n");
					sql.append( "   LEFT JOIN PAYROLL.HIPERSON C ON A.EMPNO=C.EMPNO                                                       \n");
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT D ON A.DIVCD=D.DEPTCD                                                       \n");
					sql.append( "   LEFT JOIN PAYROLL.T_HIPERSON E ON A.EMPNO=E.EMPNO                                                       \n");
					sql.append( "  WHERE A.FDCODE IS NOT NULL   \n");

					if(!str[0].equals(""))sql.append( "    AND A.FDCODE = '"+str[0]+"' \n"); 
				
					if(!str[1].equals(""))sql.append( "    AND A.SSDAT = '"+str[1]+"'  \n"); 
					if(!str[2].equals(""))sql.append( "    AND A.SSNBR = '"+str[2]+"'  \n");
					if(!str[3].equals(""))sql.append( "    AND A.FSDAT = '"+str[3]+"'  \n"); 
					if(!str[4].equals(""))sql.append( "    AND A.FSNBR = '"+str[4]+"'  \n");
							
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