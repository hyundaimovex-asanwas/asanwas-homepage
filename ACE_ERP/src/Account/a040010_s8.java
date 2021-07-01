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
public class a040010_s8 extends HttpServlet {
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
				String [] str = new String [3];
				str[0]	= req.getParameter("v_str1");		//현장코드
				str[1]	= req.getParameter("v_str2");		//가전표일자
				str[2]	= req.getParameter("v_str3");		//가전표번호

				for (int s=0;s<=2;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

			  String[] strArrCN = new String[]{ "FDCODE",	  "FSDAT",	  "FSDAT1", "FSDAT2",  "FSNBR",  
					                                "FSKND",    "FSWRTDAT",	"COCODE",	"DEPTCD",  "DEPTNM",  
					                                "EMPNO",	  "EMPNMK",   "DIVCD",  "FSAMT",   "FSVAT",	
					                                "DETOT",	  "CRTOT",	  "REMARK",	"SGNDAT",	 "FSSTAT",	"ACTDAT",  
					                                "WRDT",	    "WRID",	    "UPDT",	  "UPID"  ,  "DIVNM"
			  }; 

				int[] intArrCN = new int[]{  2, 9, 1,  8,  6,
					                           1, 8, 1,  4,  70,
					                           7,20, 4, 15,  15, 
					                          15,15,66,  8,   1,  8,
                                     8,  7, 8,  7, 70
																	}; 

				int[] intArrCN2 = new int[]{-1, -1, -1, -1,  -1, 
					                          -1, -1, -1, -1 , -1,
                          					-1, -1, -1,  0 ,  0,
					                           0,  0, -1, -1 , -1, -1,
					                          -1, -1, -1, -1 , -1
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				
				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT A.FDCODE,   A.FSDAT,    SUBSTR(A.FSDAT,1,1)FSDAT1, SUBSTR(A.FSDAT,2,9)FSDAT2,  A.FSNBR, ");
					sql.append( "        A.FSKND,    A.FSWRTDAT, A.COCODE,   A.DEPTCD,  B.DEPTNM,                                ");
					sql.append( "        A.EMPNO,    C.EMPNMK,   A.DIVCD,    A.FSAMT,   A.FSVAT,                                 ");
					sql.append( "        COALESCE(A.DETOT,0)DETOT,  COALESCE(A.CRTOT,0)CRTOT,   A.REMARK,  A.SGNDAT,   A.FSSTAT,   A.ACTDAT, ");
					sql.append( "        A.WRDT, A.WRID, A.UPDT, A.UPID, D.DEPTNM DIVNM                                                                  ");
					sql.append( "   FROM  ACCOUNT.MFSLIPMST A                                                                              ");
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD=B.DEPTCD                                                       ");
					sql.append( "   LEFT JOIN PAYROLL.HIPERSON C ON A.EMPNO=C.EMPNO                                                       ");
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT D ON A.DIVCD=D.DEPTCD                                                       ");
					sql.append( "  WHERE A.FDCODE IS NOT NULL   ");
					sql.append( "    AND A.FDCODE = '"+str[0]+"' "); 
					sql.append( "    AND A.FSDAT = '"+str[1]+"'  "); 
					sql.append( "    AND A.FSNBR = '"+str[2]+"'  ");
							
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