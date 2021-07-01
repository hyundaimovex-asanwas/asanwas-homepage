package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class h060003_s2 extends HttpServlet {

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
				String  str1= req.getParameter("v_str1");
				String  str2= req.getParameter("v_str2");
				String  str3= req.getParameter("v_str3");
				String  str4= req.getParameter("v_str4");

				if (str1==null ) {str1 ="";}
				if (str2==null ) {str2 ="";}
				if (str3==null ) {str3 ="";}
				if (str4==null ) {str4 ="";}
				
				if (str2.equals("A000")){str2 ="";}  //현대아산 선택시 전체부서조회됨.
				if (str3.equals("0")){str3 ="";}       //직위가 전체일경우
                 
				 
				GauceRes.enableFirstRow(dSet);
				
				String[] strArrCN = new String[]{ "CHK",      "EVAYM",	     "EMPNO",	    "EMPNMK",   "DEPTNM", 
					                                             "SEQ1",     "EMPNMK1",   "SEQ2",       "EMPNMK2",	
					                                             "SEQ3",      "EMPNMK3",  "SEQ4",       "EMPNMK4"}; 
					                                             
				int[] intArrCN = new int[]{   1,  6,  7, 20,  50, 
					                                     7, 20,  7,  20,  
					                                     7, 20,  7,  20 }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1,  -1, 
					                                     -1, -1, -1,  -1, 
					                                     -1, -1, -1,  -1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


CHKOUT,EVAYM, EMPNOH,EMPNMKH,EMPNO,EMPNMK,EVASEQ:DECIMAL,DEPTCD,DEPTNM,GRSTRTDT, PAYGRD,PAYGRDNM


CHKOUT,EVAYM, EMPNOH,EMPNMKH,EMPNO,EMPNMK,EVASEQ,DEPTCD,DEPTNM,    GRSTRTDT, PAYGRD,PAYGRDNM

            EVAYM	EMPNOH	              EMPNO	        EVASEQ  	DEPTCD	DEPTNM
					


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT X.CHK, X.EVAYM, X.EMPNO, X.EMPNMK, RTRIM(X.DEPTNM) DEPTNM ," );
					sql.append( "              MAX(X.SEQ1)SEQ1, MAX(H.EMPNMK)EMPNMK1, MAX(X.SEQ2)SEQ2, MAX(I.EMPNMK)EMPNMK2,  ");
					sql.append( "              MAX(X.SEQ3)SEQ3, MAX(J.EMPNMK)EMPNMK3, MAX(X.SEQ4)SEQ4, MAX(K.EMPNMK)EMPNMK4  ");
					sql.append( "    FROM  ");
					sql.append( "           ( SELECT 'F' CHK, A.EVAYM, A.EMPNO, C.EMPNMK, D.DEPTNM, ");
					sql.append( "                         CASE B.EVASEQ WHEN 1 THEN B.EMPNOH END AS SEQ1, ");
					sql.append( "                         CASE B.EVASEQ WHEN 2 THEN B.EMPNOH END AS SEQ2, ");
					sql.append( "                         CASE B.EVASEQ WHEN 3 THEN B.EMPNOH END AS SEQ3, ");
					sql.append( "                         CASE B.EVASEQ WHEN 4 THEN B.EMPNOH END AS SEQ4  ");
					sql.append( "               FROM PAYROLL.HVEMP A, PAYROLL.HVHEMP B " );
					sql.append( "                        LEFT JOIN PAYROLL.HIPERSON C ON A.EMPNO  = C.EMPNO   " );
					sql.append( "                        LEFT JOIN PAYROLL.HCDEPT   D ON A.DEPTCD = D.DEPTCD  ");
					sql.append( "              WHERE A.EVAYM = B.EVAYM       " );
					sql.append( "                  AND A.EMPNO = B.EMPNO       " );
                    sql.append( "              UNION ALL   " ); 
                    sql.append( "               SELECT 'F' CHK, A.EVAYM, A.EMPNO, C.EMPNMK, D.DEPTNM ,''SEQ1,''SEQ2,''SEQ3,''SEQ4  " ); 
					sql.append( "                  FROM PAYROLL.HVEMP A         " ); 
					sql.append( "                           LEFT JOIN PAYROLL.HIPERSON C ON A.EMPNO  = C.EMPNO         " ); 
					sql.append( "                           LEFT JOIN PAYROLL.HCDEPT   D ON A.DEPTCD = D.DEPTCD         " ); 
					sql.append( "                    ) X    " );
					sql.append( "           LEFT JOIN PAYROLL.HIPERSON H ON X.SEQ1  = H.EMPNO    " );
					sql.append( "           LEFT JOIN PAYROLL.HIPERSON I ON X.SEQ2  = I.EMPNO     " );
					sql.append( "           LEFT JOIN PAYROLL.HIPERSON J ON X.SEQ3  = J.EMPNO     " );
					sql.append( "           LEFT JOIN PAYROLL.HIPERSON K ON X.SEQ4  = K.EMPNO   " );
					sql.append( "  GROUP BY X.CHK, X.EVAYM, X.EMPNO, X.EMPNMK, X.DEPTNM   " );

                    logger.dbg.println(this,sql.toString());
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