package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class P050011_s1 extends HttpServlet {

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
				// 웹페이지에서 조건값을 넘겨받기



				String  str1	= req.getParameter("v_str1");
				String  str2	= req.getParameter("v_str2"); 
				String  str3	= req.getParameter("v_str3"); 
				String  str4	= req.getParameter("v_str4"); 
				String  str5	= req.getParameter("v_str5"); 


				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";


				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "HEADCD","DIVCD","DEPTCD","HEADNM", "DIVNM", 
																				"DEPTNM", "EMPNMK", "EMPNO", "APPDT","REQAMT", "MEMBER", 
																				"TAXGB", "SALEDT", "SETTDT", "SEQID"
				}; 

				int[] intArrCN = new int[]{4, 4, 4, 70,  70,  
																	70,  20,  7, 8, 7,  100,  
																	1,  8, 8, 5
				}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, 
																		-1, -1, -1, -1, 0, -1, 
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
					sql.append( "   SELECT A.HEADCD, A.DIVCD, A.DEPTCD,																																				\n");
					sql.append( "   RTRIM(E.DEPTNM) AS HEADNM, RTRIM(D.DEPTNM) AS DIVNM, RTRIM(C.DEPTNMK) AS DEPTNM,													\n");
					sql.append( "	  B.EMPNMK, A.EMPNO, RTRIM(APPDT) APPDT, RTRIM(REQAMT) REQAMT, RTRIM(MEMBER) MEMBER,												\n");
					sql.append( "   RTRIM(TAXGB) TAXGB,RTRIM(SALEDT) SALEDT,RTRIM(SETTDT) SETTDT,RTRIM(SEQID) SEQID														\n");
					sql.append( "   FROM PAYROLL.PWFCARD A																																										\n");
					sql.append( "   LEFT JOIN PAYROLL.YIPERSON B ON A.EMPNO=B.EMPNO  AND B.USESTS IN ('1', '2', '3')                                                          \n");
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT C ON A.DEPTCD = C.DEPTCD AND C.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)   \n");
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT D ON A.DIVCD = D.DEPTCD AND D.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)    \n");
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT E ON A.HEADCD = E.DEPTCD AND E.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)   \n");
					sql.append( "   LEFT JOIN PAYROLL.HCLCODE F ON B.PAYGRD = F.MINORCD AND F.MAJORCD ='2002'																	\n");
					sql.append( "   WHERE 1= 1                         \n");
					sql.append( "  AND SETTDT LIKE '"+str1+"%'        \n" );
					sql.append( "  AND A.EMPNO LIKE '"+str2+"%'    \n" );	
					sql.append( "  AND A.HEADCD LIKE '"+str3+"%'    \n" ); 
					sql.append( "  AND A.DIVCD LIKE '"+str4+"%'    \n" );	
					if(!str5.equals("")) { sql.append( "  AND A.DEPTCD = '"+str5+"'        \n" );	}
					if(str1.equals("201012")) {sql.append(" AND A.EMPNO NOT IN ('3080166') \n");}
					sql.append( "  ORDER BY A.HEADCD , A.DIVCD , A.DEPTCD, INTEGER(F.SEQ), A.EMPNO, A.SETTDT            \n" );

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