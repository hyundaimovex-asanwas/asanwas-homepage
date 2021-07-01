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
public class p050005_s1 extends HttpServlet {

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
				str[0]	= req.getParameter("v_str1");		//부서
				str[1]	= req.getParameter("v_str2");		//성명


//DROP TABLE PWINDPEN;			
//CREATE TABLE PWINDPEN (			
//EMPNO	CHAR(7) 	NOT NULL,	/*  사번*/
//FRDT	CHAR(8)	NOT NULL,	/*  가입일*/
//DIV	VARCHAR(4)	NOT NULL,	/*  연금종류*/
//PERAMT	NUMERIC(7, 0)	DEFAULT 0,	/*  본인부담*/
//SUPAMT	NUMERIC(7, 0)	DEFAULT 0,	/*  회사지원*/
/* Primary key Define */			
//       CONSTRAINT PWINDPENPK PRIMARY KEY ( EMPNO)); 








				for (int s=0;s<2;s++) {
					if (str[s]==null) str[s] = "";
				}
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"DEPTNM",	   /* 부서 */
				"EMPNO",       /*사번*/
				"EMPNMK",      /*성명*/
				"FRDT",        /*가입일*/
				"TODT",        /*종료일*/
				"DIV",       /*연금코드*/
				"DIVNM",       /*연금종류*/
				"PERAMT",      /*본인부담*/
				"SUPAMT"       /*회사지원*/


				};

				int[] intArrCN = new int[]{  
					50, 	
					7,
					20,
					8, 	
					8, 	
					4,
					30,
					7, 	
					7

            	}; 

				int[] intArrCN2 = new int[]{
					-1,   
					-1,
					-1,   
					-1,   
					-1,
					-1,
					-1,
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
					sql.append( "  RTRIM(C.DEPTNM) AS DEPTNM, ");	  
					sql.append( "  A.EMPNO, ");   
					sql.append( "  B.EMPNMK, ");  
					sql.append( "  A.FRDT, ");   
					sql.append( "  A.TODT, ");   
					sql.append( "  A.DIV, ");   
					sql.append( "  D.MINORNM AS DIVNM, ");  
					sql.append( "  A.PERAMT, ");   
					sql.append( "  A.SUPAMT ");  


					sql.append( " from  PAYROLL.PWINDPEN A "); 
					sql.append( " LEFT OUTER JOIN PAYROLL.HIPERSON B ON  A.EMPNO = B.EMPNO   ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT C ON  B.DEPTCD = C.DEPTCD   ");
                    sql.append( " LEFT JOIN PAYROLL.HCLCODE D ON  A.DIV = D.MINORCD  AND D.MAJORCD = '1170' \n");
					sql.append( " WHERE RTRIM(A.EMPNO) <> ' '  \n ");



					
					
					if ( !str[0].equals("")&&!str[0].equals("0"))
						sql.append( " AND B.DEPTCD  = '"  + str[0] + "' ");    //부서
					if (!str[1].equals("")&&!str[1].equals("0")) sql.append( " AND B.EMPNMK LIKE '" + str[1]+ "%' ");     //성명
					sql.append( " ORDER BY B.DEPTCD  ASC , A.EMPNO ASC ");
					logger.err.println(this,sql.toString());
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