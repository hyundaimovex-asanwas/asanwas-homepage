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
public class p020007_s3 extends HttpServlet {

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
	실제 업무에서 적용하실 부분-부서별급여지급현황조회
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				String [] str = new String [7];
				str[0]	= req.getParameter("v_str1");		//지급년월
				str[1]	= req.getParameter("v_str2");		//지급년월까지
				str[2]	= req.getParameter("v_str3");		//지급구분
				str[3]	= req.getParameter("v_str4");		//부서
				str[4]	= req.getParameter("v_str5");		//직군
				str[5]	= req.getParameter("v_str6");		//직위
				str[6]	= req.getParameter("v_str7");		//직급

				for (int s=0;s<7;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"PAYDIVNM",	/* 지급구분*/
				"DEPTCD",	/*  부서코드*/
				"DEPTNM",	/*  부서명*/
				"PAYDT",  /*  지급일*/

				"P10000",	/*  기본급여*/
				"P11000",	/* 직책수당 */
				"P12000",	/* 시간외수당*/
				"B11000",	/*  건강보험료*/
				"B12000",	/*  국민연금*/

				"B13000",	/*  고용보험*/
				"T11000",	/*  소득세 OR 갑근세*/
				"T12000",	/*  주민세*/
				"S93000",	/*  공제합계*/	
				"S94000"	/*  실지금액*/	
				};

				int[] intArrCN = new int[]{  
					30,	
					4,	
					50,	
					8,

					9,
					9,
					9,
					9,
					9,

					9,
					9,
					9,
					9,
					9
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
					sql.append( "  D.MINORNM AS PAYDIVNM, ");   /*지급구분*/
					sql.append( "  B.DEPTCD, ");								/* 부서코드 */
					sql.append( "  C.DEPTNM AS DEPTNM, ");		  /* 부서명*/
					sql.append( "  SUBSTR(B.PAYDT,1,6) AS PAYDT, ");/*  지급일*/
					sql.append( "  SUM(B.P10000) AS P10000, ");	/*  기본급여*/
					sql.append( "  SUM(B.P11000) AS P11000, ");	/*  직책수당*/
					sql.append( "  SUM(B.P12000) AS P12000, ");	/*  시간외수당*/
					//sql.append( "  ( SUM(COALESCE(B.P24000,0))+ SUM(COALESCE(B.P26000,0))) AS PBISUM , ");	/*  차량유지비 + 운전수당 비과세*/
					sql.append( "  SUM(B.B11000) AS B11000, ");	/*  건강보험료*/
					sql.append( "  SUM(B.B12000) AS B12000, ");	/*  국민연금*/
					sql.append( "  SUM(B.B13000) AS B13000, ");	/*  고용보험*/
					sql.append( "  SUM(B.T11000) AS T11000, ");	/*  소득세 OR 갑근세*/
					sql.append( "  SUM(B.T12000) AS T12000, ");	/*  주민세*/
					sql.append( "  SUM(B.S93000) AS S93000,  ");	/*  공제합*/	
					sql.append( "  SUM(B.S94000) AS S94000  ");	/*  실지급*/	
					sql.append( " FROM PAYROLL.HIPERSON A, PAYROLL.PBPAY B,PAYROLL.HCDEPT C,PAYROLL.HCLCODE D  ");
					sql.append( " WHERE A.EMPNO=B.EMPNO ");
					sql.append( " AND B.DEPTCD=C.DEPTCD ");
					sql.append( " AND B.PAYDIV = D.MINORCD ");
					sql.append( " AND D.MAJORCD = '1120' "); /*지급구분*/
					
					if (!str[0].equals("")&&!str[0].equals("0") && (!str[1].equals("")&&!str[1].equals("0")) )
						sql.append( " AND SUBSTR(B.PAYDT,1,6) BETWEEN '"  + str[0] + "' AND '"  + str[1] + "' ");    //지급일자부터까지
				
          if (str[2].equals("1")) 
					sql.append( " AND B.PAYDIV IN ( '1','3','4') ");   //지급구분
					if (str[2].equals("5")) 
					sql.append( " AND B.PAYDIV IN ( '5') ");   //지급구분

					if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND B.DEPTCD = '" + str[3]+ "' ");    //부서코드
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append( " AND B.JOBGRPH= '"  + str[4] + "' ");  //직군
												  													   
					if (!str[5].equals("")&&!str[5].equals("0")) sql.append( " AND B.PAYGRD= '"  + str[5] + "' "); //직위
					if (!str[6].equals("")&&!str[6].equals("0")) sql.append( " AND B.GRDDIV = '" + str[6]+ "' "); // 직급
					sql.append( "  GROUP BY SUBSTR(B.PAYDT,1,6),B.DEPTCD, D.MINORNM,C.DEPTNM "); /*그룹바이*/
					sql.append( "  ORDER BY B.DEPTCD,SUBSTR(B.PAYDT,1,6) "); /*순서*/
					
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