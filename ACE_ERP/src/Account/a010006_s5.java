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
public class a010006_s5 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1"); //은행명

				if(str1 == null) str1 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "BANCOD", "BNKNUM", "BNKNAM", "ACCTNONM", "ACCTNM",
					                              "ATCODE", "COSTCD", "EMPNO", "TELNO", "FAXNO", 
				                                  "HPNO", "OPENDT", "DIRECT", "CZIPCD", "CADDR01",
                                                  "CADDR02", "DELDATE", "DELNAME", "CRTDATE", "CRTNAME",
													"BANNAM", "BANNA1", "EMPNMK"
				}; 

				int[] intArrCN = new int[]{ 6, 15, 50, 32, 32,
					                       7,  5,  7,  14, 14, 
				                           14, 8, 12,  6, 70,
					                        70, 12, 10, 12, 10,
											30, 16, 20
				}; 
			
				int[] intArrCN2 = new int[]{ -1, -1,-1,-1,-1, 
					                         -1, -1,-1,-1,-1,
					                         -1, -1,-1,-1, -1,
					                         -1, -1, -1, -1, -1,
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
					sql.append( " SELECT RTRIM(A.BANCOD) BANCOD, RTRIM(A.BNKNUM) BNKNUM,         											\n");
					sql.append( " RTRIM(A.BNKNAM) BNKNAM, RTRIM(A.ACCTNONM) ACCTNONM, RTRIM(A.ACCTNM) ACCTNM,        		\n");
					sql.append( "        RTRIM(A.ATCODE) ATCODE, RTRIM(A.COSTCD) COSTCD,         												\n");
					sql.append( "        RTRIM(A.EMPNO) EMPNO, RTRIM(A.TELNO) TELNO, RTRIM(A.FAXNO) FAXNO,        					\n");
					sql.append( "        RTRIM(A.HPNO) HPNO, RTRIM(A.OPENDT) OPENDT,  																\n");
					sql.append( "        RTRIM(A.DIRECT) DIRECT, RTRIM(A.CZIPCD) CZIPCD, RTRIM(A.CADDR01) CADDR01, 					\n");
					sql.append( "        RTRIM(A.CADDR02) CADDR02, RTRIM(A.DELDATE) DELDATE,   												\n");					
					sql.append( "        RTRIM(A.DELNAME) DELNAME, RTRIM(A.CRTDATE) CRTDATE, RTRIM(A.CRTNAME) CRTNAME,  		\n");
					sql.append( "        RTRIM(B.BANNAM) BANNAM, RTRIM(B.BANNA1) BANNA1, RTRIM(C.EMPNMK) EMPNMK    				\n");
					sql.append( "   FROM ACCOUNT.BANKACC A                       																				\n");
					sql.append( "   LEFT JOIN ACCOUNT.BANKCODE B ON RTRIM(B.BANCOD) = RTRIM(A.BANCOD) 								\n");
					sql.append( "   LEFT JOIN PAYROLL.HIPERSON C ON RTRIM(C.EMPNO) = RTRIM(A.EMPNO) 									\n");
					sql.append( "   WHERE RTRIM(B.BANNAM) LIKE '%"+str1+"%'                        														\n");
                    
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