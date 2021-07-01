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
public class p050003_s1 extends HttpServlet {

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
				str[0]	= req.getParameter("v_str1");		//보험구분
				str[1]	= req.getParameter("v_str2");		//기준년월
				str[2]	= req.getParameter("v_str3");		//부서
				str[3]	= req.getParameter("v_str4");		//성명

//EMPNO	CHAR(7) 	NOT NULL,	        /*  사번*/
//STDYM	CHAR(6)	NOT NULL,           	/*  년월*/
//INSCD	CHAR(1)	NOT NULL,            	/*  보험구분*/
//STRYMD	CHAR(8)	,	                /*  기산일수*/
//DUTMON	NUMERIC(2,0)	DEFAULT 0,	/*  근무월수*/
//Y12000	NUMERIC(9,0)	DEFAULT 0,	/*  년보수총액*/
//M12100	NUMERIC(9,0)	DEFAULT 0,	/*  산출표준보수액*/
//M12000	NUMERIC(9,0)	DEFAULT 0,	/*  월보수월액*/
//M12200	NUMERIC(9,0)	DEFAULT 0,	/*  비대상소득액*/
//OGRDCD	NUMERIC(3,0)	DEFAULT 0,	/*  현등급*/
//M12300	NUMERIC(9,0)	DEFAULT 0,	/*  납부보험료*/
//NGRDCD	NUMERIC(3,0)	DEFAULT 0,	/*  신등급*/
//S12000	NUMERIC(9,0)	DEFAULT 0,	/*  표준보수월액*/
//N12301	NUMERIC(9,0)	DEFAULT 0,	/*  월보험료*/
//N12300	NUMERIC(9,0)	DEFAULT 0,	/*  결정보험료*/
//DIVAMT	NUMERIC(9,0)	DEFAULT 0,	/*  정산금액*/
//DIVDT	CHAR(8)	,	                    /*  정산일자*/




				for (int s=0;s<4;s++) {
					if (str[s]==null) str[s] = "";
				}
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"DEPTNM",	   /* 부서 */
				"EMPNO",       /*사번*/
				"EMPNMK",       /*성명*/

				"MEDSNO",	       /* 증번호 */
				"M12300",	/* 납부보험료*/

				"Y12000",	/*  년간보수*/
				"DUTMON",	/*  개월(근무월수)*/
				"M12000",	/* 월보수*/
				"S12000",	/*  월표준*/
				"OGRDCD",	/*  현등급*/

				"NGRDCD",	/*  신등급*/
				"STDYM",	/*  년월*/
				"INSCD"	/*  보험구분*/


				};

				int[] intArrCN = new int[]{  
					50, 	
					7,
					20, 
					20, 

					9,	

					9,
						
					2,	//근무월수
					9,	
					9,
						
					3,	
					3,
					6,	
					1

            	}; 

				int[] intArrCN2 = new int[]{
					-1,   
					-1,
					-1,
					-1,
					0,

					0,
					0,
					0,
					0,
					0,
					0,
					-1,
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
					sql.append( "  D.MEDSNO, ");	
					sql.append( "  A.M12300, ");
					
					sql.append( "  A.Y12000, ");	
					sql.append( "  A.DUTMON, ");	
					sql.append( "  A.M12000, ");	
					sql.append( "  A.S12000, ");	
					sql.append( "  A.OGRDCD, ");
					
					sql.append( "  A.NGRDCD,  ");	
					sql.append( "  A.STDYM, ");
					
					sql.append( "  A.INSCD  ");	

					sql.append( " from  PAYROLL.PWINSPAY  A "); 
					sql.append( " LEFT OUTER JOIN PAYROLL.HIPERSON B ON  A.EMPNO = B.EMPNO ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT C ON  B.DEPTCD = C.DEPTCD   ");
					sql.append( " LEFT OUTER JOIN PAYROLL.PWINDIPN_H D ON  A.EMPNO = D.EMPNO     ");
					sql.append( " WHERE RTRIM(A.EMPNO) <> ' '  \n ");



					
					
					if (!str[0].equals("")&&!str[0].equals("0")) sql.append( " AND A.INSGB = '" + str[0]+ "' ");     //보험구분
					if ( !str[1].equals("")&&!str[1].equals("0"))
						sql.append( " AND A.STDYM  = '"  + str[1] + "' ");    //기준년월
					if ( !str[2].equals("")&&!str[2].equals("0"))
						sql.append( " AND B.DEPTCD  = '"  + str[2] + "' ");    //부서
					if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND B.EMPNMK LIKE '" + str[3]+ "%' ");     //성명
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