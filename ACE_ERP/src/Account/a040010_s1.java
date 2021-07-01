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
public class a040010_s1 extends HttpServlet {
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
				String  str1	  = req.getParameter("v_str1"); //처리기간 from
				String  str2    = req.getParameter("v_str2"); //처리기간 to
				String  str3    = req.getParameter("v_str3"); //결재유무
				String  str4    = req.getParameter("v_str4"); //지점코드
				String  str5    = req.getParameter("v_str5"); //업무구분

				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";
				if(str3 == null) str3 = "";
				if(str4 == null) str4 = "";
				if(str5 == null) str5 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "SELECT2", "FDCODE", "FS1", "FSDAT", "FSDAT1", "FSNBR",
																					"FSDAT2", "FSKND", "FSWRTDAT", "COCODE", "DEPTCD",
																					"EMPNO", "DIVCD", "FSVAT", "FSAMT", "DETOT",
																					"CRTOT", "REMARK", "SGNDAT", "FSSTAT", "ACTDAT"
				}; 

				int[] intArrCN = new int[]{  1, 2, 1, 9, 8, 6,
																		16, 1, 8, 2, 4,
																		 7, 4, 15, 15, 15,
																		15, 132, 8, 1, 8
				}; 
			
				int[] intArrCN2 = new int[]{  -1, -1, -1, -1, -1, -1,
																			-1, -1, -1, -1, -1,
																			-1, -1,  0,  0,  0,
					                            0, -1, -1, -1, -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				}
				
				if (!GauceReq.isBuilderRequest()) {
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT 'F' SELECT2, FDCODE, SUBSTR(FSDAT,1,1) FS1, FSDAT, SUBSTR(FSDAT,2,8) FSDAT1 , FSNBR, \n");
					sql.append( "        FSDAT||'-'||FSNBR FSDAT2, FSKND, FSWRTDAT, COCODE, DEPTCD, \n");
					sql.append( "        EMPNO, DIVCD, nvl(FSVAT,0) FSVAT, nvl(FSAMT,0) FSAMT, nvl(DETOT,0) DETOT, \n");
					sql.append( "        nvl(CRTOT,0) CRTOT, REMARK, SGNDAT, FSSTAT, ACTDAT \n");
					sql.append( " FROM ACCOUNT.MFSLIPMST 												\n");
					sql.append( " WHERE 																			\n");
					sql.append( " (ACTDAT >='"+str1+"' AND  ACTDAT <= '"+str2+"' ) 					\n");
					if(!str3.equals(""))sql.append( " AND FSSTAT = '"+str3+"' 							\n");
					if(!str4.equals(""))sql.append( " AND FDCODE = '"+str4+"' 							\n");
					if(!str5.equals(""))sql.append( " AND SUBSTR(FSDAT,1,1) = '"+str5+"' 			\n");

					
					//System.out.println("# Query : " + sql);		
					
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