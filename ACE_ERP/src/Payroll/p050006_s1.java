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
public class p050006_s1 extends HttpServlet {

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
				str[1]	= req.getParameter("v_str2");		//성명


				//DROP TABLE PWALLOW;			
				//CREATE TABLE PWALLOW (			
				//EMPNO	CHAR(7) 	NOT NULL,	/*  사번*/
				//ALLOWGB	VARCHAR(4)	NOT NULL,	/*  수당구분*/
				//FRDT	CHAR(6)	NOT NULL,	/*  시작년월*/
				//TODT	CHAR(6)	,	/*  종료년월*/
				//DEPTCD	CHAR(4)	,	/*  부서*/
				//ALLOWAMT	NUMERIC(9,0)	DEFAULT 0,	/*  수당액*/
				//ETC	VARCHAR(30)	,	/*  비고*/
				///* Primary key Define */			
			   //CONSTRAINT PWALLOWPK PRIMARY KEY ( EMPNO, ALLOWGB, FRDT)); 			




				for (int s=0;s<2;s++) {
					if (str[s]==null) str[s] = "";
				}
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"DEPTNM",	   /* 부서 */
				"EMPNO",       /*사번*/
				"EMPNMK",      /*성명*/
				"ALLOWGB",        /*수당구분코드*/
				"ALLOWGBNM",        /*수당구분명*/
				"FRDT",       /*시작년월*/
				"TODT",       /*종료년월*/
				"DEPTCD",      /*부서*/
				"ALLOWAMT",      /*수당액*/
				"ETC"       /*비고*/


				};

				int[] intArrCN = new int[]{  
					50, 	
					7,
					20,
					4, 	
					30, 	
					6,
					6,
					4, 	
					9, 	
					30

            	}; 

				int[] intArrCN2 = new int[]{
					-1,   
					-1,
					-1,   
					-1,
					-1,

					-1,
					-1,
					-1,
					0,
					-1
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
					sql.append( "  A.ALLOWGB, ");   
					sql.append( "  D.MINORNM AS ALLOWGBNM, ");   
					sql.append( "  A.FRDT, ");   
					sql.append( "  A.TODT, ");   
					sql.append( "  A.DEPTCD, ");   
					sql.append( "  A.ALLOWAMT, ");   
					sql.append( "  A.ETC ");  


					sql.append( " from  PAYROLL.PWALLOW A "); 
					sql.append( " LEFT OUTER JOIN PAYROLL.HIPERSON B ON  A.EMPNO = B.EMPNO   ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT C ON  B.DEPTCD = C.DEPTCD   ");
                    sql.append( " LEFT JOIN PAYROLL.HCLCODE D ON  A.ALLOWGB = D.MINORCD  AND D.MAJORCD = '1777' \n");
					sql.append( " WHERE RTRIM(A.EMPNO) <> ' '  \n ");



					
					
					if ( !str[0].equals("")&&!str[0].equals("0"))
						sql.append( " AND '"  + str[0] + "'  BETWEEN A.FRDT AND A.TODT ");    //기준년월
					if (!str[1].equals("")&&!str[1].equals("0")) sql.append( " AND B.EMPNMK LIKE '" + str[1]+ "%' ");     //성명
					sql.append( " ORDER BY B.DEPTCD  ASC , A.EMPNO ASC ");
					//logger.err.println(this,sql.toString());
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