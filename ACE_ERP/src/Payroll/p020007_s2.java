package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.//년간월별소득현황
public class p020007_s2 extends HttpServlet {

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
	실제 업무에서 적용하실 부분 - 급여지급현황 조회
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				String [] str = new String [9];
				str[0]	= req.getParameter("v_str1");		//지급년월
				str[1]	= req.getParameter("v_str2");		//지급년월까지
				str[2]	= req.getParameter("v_str3");		//지급구분
				str[3]	= req.getParameter("v_str4");		//부서
				str[4]	= req.getParameter("v_str5");		//직군
				str[5]	= req.getParameter("v_str6");		//직위
				str[6]	= req.getParameter("v_str7");		//직급
				str[7]	= req.getParameter("v_str8");		//level
				str[8]	= req.getParameter("v_str9");		//treecd

				for (int s=0;s<9;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"EMPNO",	   /* 사번 */
				"EMPNMK",       /*한글명*/
				"PAYDIVNM",	/* 지급구분*/
				"DEPTCD",	/*  부서코드*/
				"DEPTNM",	/*  부서명*/
				"PAYDT",  /*  지급일*/
                "MINORNM",	/*직위*/
				"TMINORNM",  /*근무지*/
				

				"P10000",	/*  기본급여*/
				"P11000",	/* 직책수당 */
				"P12000",	/* 시간외수당*/
				"B11000",	/*  건강보험료*/
				"B12000",	/*  국민연금*/

				"B13000",	/*  고용보험*/
				"T11000",	/*  소득세 OR 갑근세*/
				"T12000",	/*  주민세*/
				"S93000",	/*  공제합계*/	
				"S94000",	/*  실지금액*/	
				"MINORCD"       /*지급코드*/
				};

				int[] intArrCN = new int[]{  
					7, 	
					20,
					30,	
					4,	
					50,	
					8,/*지급일*/	

                    30,
                    30,
					9,
					9,
					9,
					9,
					9,

					9,
					9,
					9,
					9,
					9,
					4
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
					0,
					0,
					0,
					0,

					0,
					0,
					0,
					0,
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
					sql.append( "  A.EMPNO, ");								/* 사번 */
					sql.append( "  A.EMPNMK, ");							/*한글명*/
					sql.append( "  D.MINORNM AS PAYDIVNM, "); /*지급구분*/
					sql.append( "  B.DEPTCD, ");							/* 부서코드 */
					sql.append( "  C.DEPTNM AS DEPTNM, ");		/* 부서명*/
					sql.append( "  E.MINORNM AS MINORNM, ");		/* 직위명*/
					sql.append( "  F.MINORNM AS TMINORNM, ");		/* 근무지*/
					sql.append( "  B.PAYDT, ");		/*  지급일*/
					sql.append( "  B.P10000, ");	/*  기본급여*/
					sql.append( "  B.P11000, ");	/*  직책수당*/
					sql.append( "  B.P12000, ");	/*  시간외수당*/
					sql.append( "  B.B11000, ");	/*  건강보험료*/
					sql.append( "  B.B12000, ");	/*  국민연금*/
					sql.append( "  B.B13000, ");	/*  고용보험*/
					sql.append( "  B.T11000, ");	/*  소득세 OR 갑근세*/
					sql.append( "  B.T12000, ");	/*  주민세*/
					sql.append( "  B.S93000,  ");	/*  공제합계*/	
					sql.append( "  B.S94000,  ");	/*  실지급액*/	
					sql.append( "  D.MINORCD ");       /*지급코드*/
					sql.append( " from PAYROLL.HIPERSON A, PAYROLL.PBPAY B  ");
                    sql.append( " LEFT JOIN PAYROLL.HCDEPT C ON  B.DEPTCD=C.DEPTCD ");
				    sql.append( " LEFT JOIN PAYROLL.HCLCODE D ON  B.PAYDIV=D.MINORCD AND D.MAJORCD='1120' "); /*지급구분*/
					sql.append( " LEFT JOIN PAYROLL.HCLCODE E ON  B.PAYGRD=E.MINORCD AND E.MAJORCD='2002' "); /*직위*/
                    sql.append( " LEFT JOIN PAYROLL.HCLCODE F ON  C.DEPTGB=F.MINORCD AND F.MAJORCD='2050' "); /*근무지*/
					sql.append( " WHERE A.EMPNO=B.EMPNO ");
					//sql.append( " AND B.DEPTCD=C.DEPTCD ");
					//sql.append( " AND B.PAYDIV = D.MINORCD ");
					//sql.append( " AND D.MAJORCD = '1120' "); 
					
					if (!str[0].equals("")&&!str[0].equals("0") && (!str[1].equals("")&&!str[1].equals("0")) )
						sql.append( " AND SUBSTR(B.PAYDT,1,6) BETWEEN '"  + str[0] + "' AND '"  + str[1] + "' ");    //지급일자부터까지
					if (str[2].equals("1")) 
						sql.append( " AND B.PAYDIV IN('1','3','4') ");   //지급구분
					if (str[2].equals("5")) 
						sql.append( " AND B.PAYDIV IN('5') ");   //지급구분
                    if (str[2].equals("6")) 
						sql.append( " AND B.PAYDIV IN('6') ");   //지급구분

					//if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND B.DEPTCD = '" + str[3]+ "' ");    //부서코드
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append( " AND B.JOBGRPH= '"  + str[4] + "' ");  //직군
												  													   
					if (!str[5].equals("")&&!str[5].equals("0")) sql.append( " AND B.PAYGRD= '"  + str[5] + "' "); //직위
					if (!str[6].equals("")&&!str[6].equals("0")) sql.append( " AND B.GRDDIV = '" + str[6]+ "' "); // 직급
/*
          if (str[7].equals("1")) sql.append( " AND SUBSTR(C.TREECD,1,4)= '" + str[8] +"'");
					if (str[7].equals("2")) sql.append( " AND SUBSTR(C.TREECD,1,4)= '" + str[8] + "'");
					if (str[7].equals("3")) sql.append( " AND SUBSTR(C.TREECD,1,6)= '" + str[8] +"'");
					if (str[7].equals("4")) sql.append( " AND RTRIM(C.TREECD)= '" + str[8] + "'");
*/
					if (str[7].equals("1")) sql.append( " AND SUBSTR(C.TREECD,1,2)= '" + str[8] +"'  \n");
					if (str[7].equals("2")) sql.append( " AND SUBSTR(C.TREECD,1,2)= '" + str[8] +"'  \n");
					if (str[7].equals("3")) sql.append( " AND SUBSTR(C.TREECD,1,4)= '" + str[8] + "' \n");
					if (str[7].equals("4")) sql.append( " AND SUBSTR(C.TREECD,1,6)= '" + str[8] +"'  \n");
					if (str[7].equals("5")) sql.append( " AND RTRIM(C.TREECD)= '" + str[8] + "'      \n");


          sql.append( "  ORDER BY C.TREECD, E.SEQ "); /*지급구분*/
				//	sql.append( "  ORDER BY B.DEPTCD,SUBSTR(B.PAYDT,1,6),B.EMPNO, D.MINORCD "); /*지급구분*/
					
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