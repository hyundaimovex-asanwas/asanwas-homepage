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
public class p050002_s2 extends HttpServlet {

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
				str[2]	= req.getParameter("v_str3");		//성명
				str[3]	= req.getParameter("v_str4");		//보험구분


//DROP TABLE PWINDIPN_H;		//건강보험	
//CREATE TABLE PWINDIPN_H (			
//APPYM	CHAR(6)	NOT NULL,	/*  적용년월*/
//RESINO	CHAR(13)	NOT NULL,	/* 주민번호*/
//EMPNO	CHAR(7) 	NOT NULL,	/*  사번*/
//STDAMT	NUMERIC(9, 0)	DEFAULT 0,	/*  소득월액*/
//GRDCD	NUMERIC(3, 0)	DEFAULT 0,	/*  보험등급*/
//INSGETCOD	CHAR(1)	,	/*  취득부호*/
//INSREDCOD	CHAR(2)	,	/*  감면부호*/
//JANGREF	CHAR(1)	,	/*  장애유공자*/
//BUYANG	NUMERIC(2, 0)	DEFAULT 0,	/*  피부양자수*/
//INSAMT	NUMERIC(9, 0)	DEFAULT 0,	/*  월보험료*/
//MEDSNO	VARCHAR(20)	,	/*  보험번호*/
//GETDT	CHAR(8)	,	/*  취득일자*/
//LOSDT	CHAR(8)	,	/*  상실일자*/
//REPDT	CHAR(8)	,	/*  신고일자*/
///* Primary key Define */			
//       CONSTRAINT PWINDIPN_HPK PRIMARY KEY (APPYM,RESINO)); 			


//DROP TABLE PWINDIPN_Y;			//국민연금
//CREATE TABLE PWINDIPN_Y (			
//APPYM	CHAR(6)	NOT NULL,	/*  적용년월*/
//RESINO	CHAR(13)	NOT NULL,	/* 주민번호*/
//EMPNO	CHAR(7) 	NOT NULL,	/*  사번*/
//STDAMT	NUMERIC(9, 0)	DEFAULT 0,	/*  소득월액*/
//GRDCD	NUMERIC(3, 0)	DEFAULT 0,	/*  보험등급*/
//INSGETCOD	CHAR(1)	,	/*  취득부호*/
//JANGREF	CHAR(1)	,	/*  장애유공자*/
//INSAMT	NUMERIC(9, 0)	DEFAULT 0,	/*  월보험료*/
//MEDSNO	VARCHAR(20)	,	/*  보험번호*/
//GETDT	CHAR(8)	,	/*  취득일자*/
//LOSDT	CHAR(8)	,	/*  상실일자*/
//REPDT	CHAR(8)	,	/*  신고일자*/
///* Primary key Define */			
//       CONSTRAINT PWINDIPN_YPK PRIMARY KEY (APPYM,RESINO)); 			
///* Table Refference */			
//






				for (int s=0;s<4;s++) {
					if (str[s]==null) str[s] = "";
				}
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"DEPTNM",	   /* 부서 */
				"EMPNO",       /*사번*/
				"EMPNMK",       /*성명*/
				"APPYM",	       /* 적용년월 */
				"RESINO",	/* 주민번호*/
				"GRDCD",	/*  등급*/
				"STDAMT",	/*  표준보수월액*/
				"INSAMT",	/* 월보험료*/
				"MEDSNO",	/*  증번호*/
				"GETDT",	/*  취득일자*/
				"LOSDT",	/*  상실일자*/
				"REPDT"	    /* 신고일자*/


				};

				int[] intArrCN = new int[]{  
					50, 	
					7,
					20, 
					6,	
					13,
						
					3,	
					9,	
					9,	
					20,	
					8,
						
					8,	
					8

            	}; 

				int[] intArrCN2 = new int[]{
					-1,   
					-1,
					-1,
					-1,
					-1,

					0,
					0,
					0,
					-1,
					-1,

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
					sql.append( "  C.DEPTNM AS DEPTNM, ");	  
					sql.append( "  A.EMPNO, ");   
					sql.append( "  B.EMPNMK, ");  
					sql.append( "  A.APPYM, ");	
					sql.append( "  A.RESINO, ");	
					sql.append( "  A.GRDCD, ");	
					sql.append( "  A.STDAMT, ");	
					sql.append( "  A.INSAMT, ");	
					sql.append( "  A.MEDSNO, ");	
					sql.append( "  A.GETDT, ");	
					sql.append( "  A.LOSDT, ");	
					sql.append( "  A.REPDT  ");	


					sql.append( " from  PAYROLL.PWINDIPN_Y A "); 
					sql.append( " LEFT OUTER JOIN PAYROLL.HIPERSON B ON  A.EMPNO = B.EMPNO ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT C ON  B.DEPTCD = C.DEPTCD   ");
					sql.append( " WHERE RTRIM(A.EMPNO) <> ' '  \n ");



					
					
					if ( !str[0].equals("")&&!str[0].equals("0"))
						sql.append( " AND A.APPYM  = '"  + str[0] + "' ");    //기준년월
					if ( !str[1].equals("")&&!str[1].equals("0"))
						sql.append( " AND B.DEPTCD  = '"  + str[1] + "' ");    //부서
					if (!str[2].equals("")&&!str[2].equals("0")) sql.append( " AND B.EMPNMK LIKE '" + str[2]+ "%' ");     //성명
					//if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND A.INSGB = '" + str[3]+ "' ");     //보험구분
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