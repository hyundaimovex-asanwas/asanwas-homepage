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
public class p050003_s2 extends HttpServlet {

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

//Table Name	보험등급변경및납부실적		Update:
//COLUMN	ATTRIBUTE	NULL	LABEL
//DROP TABLE PWMEDPAY;			
//CREATE TABLE PWMEDPAY (			
//STRDT	CHAR(4)	NOT NULL,	/*  기준년도*/
//INSCD	CHAR(1)	NOT NULL,	/*  구분코드*/
//RESINO	CHAR(13)	NOT NULL,	/*  주민번호*/
//EMPNO	CHAR(7)	,	/*  사번*/
//MEDSO1	CHAR(4)	,	/*  조합기호*/
//MEDSO2	CHAR(6)	,	/*  연번*/
//MEDSO3	CHAR(6)	,	/*  사업장번호*/
//MEDSO4	CHAR(4)	,	/*  단위사업장*/
//MEDSNO	CHAR(8)	,	/*  건강보험증번호*/
//NAME	CHAR(14)	,	/*  성명*/		
//GETDT	CHAR(8)	,	/*  자격취득일*/		
//MEDAMT1	NUMERIC(15 , 0)	DEFAULT 0,	/*  전년도보험료납부*/		
//MEDAMT2	NUMERIC(15 , 0)	DEFAULT 0,	/*  실납부보험료*/		
//M12100	NUMERIC(15 , 0)	DEFAULT 0,	/*  전년도보수총액*/		
//DUTMON	NUMERIC(2 , 0)	DEFAULT 0,	/*  근무월수*/		
//OGRCD	NUMERIC(3 , 0)	DEFAULT 0,	/*  종전등급*/		
//NGRCD	NUMERIC(3 , 0)	DEFAULT 0,	/*  결정등급*/		
//CHK1	CHAR(1)	,	/*  확인여부*/		
//CHK2	CHAR(1)	,	/*  결정여부*/		
///* Primary key Define */					
//       CONSTRAINT PWMEDPAYPK PRIMARY KEY ( STRDT, INSCD, RESINO)); 					


				for (int s=0;s<4;s++) {
					if (str[s]==null) str[s] = "";
				}
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"DEPTNM",	   /* 부서 */
				"EMPNO",       /*사번*/
				"EMPNMK",       /*성명*/

				"RESINO",	       /* 주민번호 */
				"MEDSNO",	/* 보험증번호*/

				"GETDT",	/*  자격취득일*/
				"MEDAMT1",	/*  전년도보험료납부*/
				"MEDAMT2",	/* 실납부보험료*/
				"M12100",	/*  전년도보수총액*/
				"DUTMON",	/*  개월*/

				"NGRDCD",	/*  결정등급*/
				"STRDT",	/*  기준년도*/
				"INSCD"	/*  구분코드*/

				};

				int[] intArrCN = new int[]{  
					50, 	
					7,
					20, 
					13, 
					8,	
					8,
						
					15,	//전년도보험료납부
					15,	
					15,
					2,
						
					3,
					4,	
					1

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
					sql.append( "  A.RESINO, ");	
					sql.append( "  RTRIM(A.MEDSNO) MEDSNO, ");
					
					sql.append( "  A.GETDT, ");	
					sql.append( "  A.MEDAMT1, ");	
					sql.append( "  A.MEDAMT2, ");	
					sql.append( "  A.M12100, ");	
					sql.append( "  A.DUTMON, ");	
					sql.append( "  A.NGRDCD, ");
					
					sql.append( "  A.STRDT,  ");	
					sql.append( "  A.INSCD ");
					

					sql.append( " from  PAYROLL.PWMEDPAY  A "); 
					sql.append( " LEFT OUTER JOIN PAYROLL.HIPERSON B ON  A.EMPNO = B.EMPNO ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT C ON  B.DEPTCD = C.DEPTCD   ");
					sql.append( " WHERE RTRIM(A.EMPNO) <> ' '  \n ");



					
					
					if (!str[0].equals("")&&!str[0].equals("0")) sql.append( " AND A.INSCD = '" + str[0]+ "' ");     //보험구분
					if ( !str[1].equals("")&&!str[1].equals("0"))
						sql.append( " AND A.STRDT  = '"  + str[1] + "' ");    //기준년
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