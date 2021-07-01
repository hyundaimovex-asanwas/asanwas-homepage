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
public class p040007_s1 extends HttpServlet {

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
				String [] str = new String [10];
				str[0]	= req.getParameter("v_str1");		//기준년월
				str[1]	= req.getParameter("v_str2");		//부서
				str[2]	= req.getParameter("v_str3");		//직급
				str[3]	= req.getParameter("v_str3");		//성명


				for (int s=0;s<4;s++) {
					if (str[s]==null) str[s] = "";
				}
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"EMPNO",	   /* 사번 */
				"EMPNMK",       /*한글명*/
				"DEPTNM",	       /* 부서 */
				"STRTDT",	/* 입사일*/
				"PAYGRD",	/*  직위*/

				"DUTPER",	/*  근무년수*/
				"MONPAY",	/* 평균급여*/
				"MONBUS",	/*평균상여*/
				"MONHOL",	/* 월차수당 */
				"YEAHOL",	/*  년차수당*/

				"RETPAY"	/*  퇴직급여*/

				};

				int[] intArrCN = new int[]{  
					7, 	
					20,
					30, 
					8,	
					30,
						
					4,	
					10,	
					10,
						
					10,	
					10,	

					10

            	}; 

				int[] intArrCN2 = new int[]{
					-1,   
					-1,
					-1,   
					-1,
					-1,
						
					-1,
					0,
					0,
					0,
					0,

					0





                                           }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT  ");
					sql.append( "  B.EMPNO, ");	   /* 사번 */
					sql.append( "  A.EMPNMK, ");       /*한글명*/

					sql.append( "  C.DEPTNM AS DEPTNM, ");	/*  부서명*/
					sql.append( "  A.STRTDT, ");       /*입사일*/
					sql.append( "  E.MINORNM AS PAYGRD, ");	/* 직위코드*/
					sql.append( "  B.DUTPER, ");  /*  근무년수*/
					sql.append( "  B.MONPAY, ");	/*  평균급여*/
					sql.append( "  B.MONBUS, ");	/* 평균상여 */
					sql.append( "  B.MONHOL, ");	/* 월차수당 */
					sql.append( "  B.YEAHOL, ");	/*  년차수당*/

					sql.append( "  B.RETPAY ");	/*  퇴직급여 */ 


					sql.append( " from  PAYROLL.HIPERSON A"); 
					sql.append( " LEFT OUTER JOIN PAYROLL.PRDEVPAY B  ON  B.EMPNO = A.EMPNO AND B.APPDT=SUBSTR(A.ENDDT,1,6)  ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT C ON  A.DEPTCD = C.DEPTCD   ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE E ON  A.PAYGRD = E.MINORCD  AND E.MAJORCD = '2002'   ");
					sql.append( " WHERE B.EMPNO <> ' ' and A.ENDDT <> ' ' \n ");

					if ( !str[0].equals("")&&!str[0].equals("0") )sql.append( " AND SUBSTRING(B.APPDT,1,6) = '"  + str[0] + "' ");    //기준년월
						
					if (!str[1].equals("")&&!str[1].equals("0")) sql.append( "  AND A.DEPTCD ='" + str[1]+ "' ");     //부서
					if (!str[2].equals("")&&!str[2].equals("0")) sql.append( "  AND A.GRDDIV ='" + str[2]+ "' ");     //직급
					if (!str[3].equals("")&&!str[3].equals("0")) sql.append( "  AND A.EMPNMK LIKE '" + str[3]+ "%' ");     //성명
					logger.dbg.println(this,sql.toString());
/*********************************************************************************************/
                     // System.out.println(sql);
						//logger.err.println(this,"1");
					stmt = conn.getGauceStatement(sql.toString());

	 		    stmt.executeQuery(dSet);
					//logger.err.println(this,"2");

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