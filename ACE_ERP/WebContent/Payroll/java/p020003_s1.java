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
public class p020003_s1 extends HttpServlet {

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
				str[0]	= req.getParameter("v_str1");		//지급일자
				str[1]	= req.getParameter("v_str2");		//적용년월
				str[2]	= req.getParameter("v_str6");		//지급구분
				str[3]	= req.getParameter("v_str3");		//부서
				str[4]	= "";//req.getParameter("v_str5");		//직군
				str[5]	= req.getParameter("v_str4");		//사번부터
				//str[6]	= req.getParameter("v_str7");		//사번까지
				str[7]	= req.getParameter("v_str5");		//성명
				str[8]	= "";// req.getParameter("v_str9");		//직위
				str[9]	= "";//req.getParameter("v_str10");		//직급

				for (int s=0;s<10;s++) {
					if (str[s]==null) str[s] = "";
				}
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]	{

					"EMPNO",		/*	사번 */
					"EMPNMK",		/*	한글명*/
					"NOTWRK",		/*	휴직정직일수*/
					"APPDT",		/*	년월 */
					"PAYDIV",		/*	급여구분*/
					"DEPTCD",		/*  부서코드*/
					"DEPTNM",		/*  부서명*/
					"PAYGRDNM",	/*	직위코드*/
					"GRDDIVNM",	/*	직급*/
					"PAYSEQNM",	/*	호봉코드 */
					"PAYBNKNM",	/*  은행코드*/
					"PAYNUM",		/*  계좌번호*/
					"PAYDT",		/*  지급일*/
					"DUYNOT",		/*  무계결근일수*/
					"P10000",		/*  기본급여*/
					"P11000",		/*	직책수당 */
					"P12000",		/*	시간외수당 */
					"P21000",		/*  근속수당*/
					"P22000",		/*  자기계발비 */
					"P23000",		/*  부양가족수당*/
					"P24000",		/*  차량유지비 */
					"P25000",		/*  출납수당*/
					"P26000",		/*  운전수당*/
					"P27000",		/*  연장수당*/
					"P28000",		/*  자격수당*/
					"P29000",		/*  남북경협수당*/
					"P30000",		/*  사장단수당*/
					"P31000",		/*  특수지수당*/
					"P32000",		/*  지역근무수당*/
					"P36000",		/*  학비보조금*/
					"P37000",		/*  개인연금보조금*/
					"P38000",		/*  임원직책수당*/
					"PX0010",		/*  기타지급1*/
					"PX0020",		/*  기타지급2*/
					"PX0030",		/*  기타지급3*/
					"PX0040",		/*  기타지급4*/
					"S91000",		/*  지급합계*/
					"T11000",		/*  소득세 OR 갑근세*/
					"T12000",		/*  주민세*/
					"B11000",		/*  건강보험료*/
					"B12000",		/*  국민연금*/
					"B13000",		/*  고용보험*/
					"B15000",		/*  개인연금*/
					"B14000",		/*  여직원회비*/
					"B16000",		/*  공조회비*/
					"BX0010",		/*  기타공제1*/		
					"BX0020",		/*  기타공제2*/		
					"BX0030",		/*  기타공제3*/		
					"BX0040",		/*  기타공제4*/
					"S93000",		/*  공제합계*/	
					"S94000",		/*  차인지급액*/	
					"STRTDT",		/*  입사일*/	
					"JOBGRPHNM",/*  직군*/	
					"P34000",		/*  년차수당*/	
					"P39000",		/*  전월소급*/		
					"P41000",		/*  정산건강*/
					"P42000",		/*  정산고용*/	
					"T21000",		/*  장산소득*/	
					"T22000",		/*  정산주민*/	
					"STRTDT",		/*  입사일자*/	
					"ENDDT",		/*  퇴사일자*/
					"P35000"		/*  식대    */
			};

				int[] intArrCN = new int[]{  
					7, 	
					20,
					2, 
					6,	
					4,	
					4,	
					50,	
					30,	
					30,	
					30,	
					30,	
					25,	
					8,	
					2,
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
					9,
					9,
					9,
					9,
					9,
					9,
					9,
					8,
					30,
					9,
					9,
					9,
					9,
					9,
					9,
					8,
					8,
					9
        }; 

				int[] intArrCN2 = new int[]{
					-1,   
					-1,
					0,
					-1,   
					-1,
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
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					-1,
					-1,
					0,
					0,
					0,
					0,
					0,
					0,
					-1,
					-1
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
					sql.append( "  B.EMPNO, ");		/*	사번 */
					sql.append( "  A.EMPNMK, ");	/*	한글명*/
					sql.append( "  B.NOTWRK, ");	/*	휴직정직 OR 재직구분*/
					sql.append( "  B.APPDT, ");		/*	년월 */
					sql.append( "  B.PAYDIV, ");	/*	급여구분*/
					sql.append( "  B.DEPTCD, ");	/*  부서코드*/
					sql.append( "  C.DEPTNM AS DEPTNM, ");		/*  부서명*/
					sql.append( "  E.MINORNM AS PAYGRDNM, ");	/*	직위코드*/
					sql.append( "  F.MINORNM AS GRDDIVNM, ");	/*	직급*/
					sql.append( "  G.MINORNM AS PAYSEQNM, ");	/*	호봉코드 */
					sql.append( "  H.MINORNM AS PAYBNKNM, ");	/*  은행코드*/
					sql.append( "  B.PAYNUM, ");	/*  계좌번호*/
					sql.append( "  B.PAYDT, ");		/*  지급일*/
					sql.append( "  B.DUYNOT, ");	/*  무계결근일수*/
					sql.append( "  B.P10000, ");	/*  기본급여*/
					sql.append( "  B.P11000, ");	/* 직책수당 */
					sql.append( "  B.P12000, ");	/* 시간외수당 */
					sql.append( "  B.P21000, ");	/*  근속수당*/
					sql.append( "  B.P22000, ");	/*  자기계발비 */
					sql.append( "  B.P23000, ");	/*  부양가족수당*/
					sql.append( "  B.P24000, ");	/*  차량유지비 */
					sql.append( "  B.P25000, ");	/*  출납수당*/
					sql.append( "  B.P26000, ");	/*  운전수당*/
					sql.append( "  B.P27000, ");	/*  연장수당*/
					sql.append( "  B.P28000, ");	/*  자격수당*/
					sql.append( "  B.P29000, ");	/*  남북경협수당*/
					sql.append( "  B.P30000, ");	/*  사장단수당*/
					sql.append( "  B.P31000, ");	/*  특수지수당*/
					sql.append( "  B.P32000, ");	/*  지역근무수당*/
					sql.append( "  B.P36000, ");	/*  학비보조금*/
					sql.append( "	 COALESCE(B.P37000,0) AS P37000, ");	/*  개인연금보조금*/
					sql.append( "  B.P38000, ");	/*  임원직책수당*/
					sql.append( "  B.PX0010, ");	/*  기타지급1*/
					sql.append( "  B.PX0020, ");	/*  기타지급2*/
					sql.append( "  B.PX0030, ");	/*  기타지급3*/
					sql.append( "  B.PX0040, ");	/*  기타지급4*/
					sql.append( "  B.S91000, ");	/*  지급합계*/
					sql.append( "  B.T11000, ");	/*  소득세 OR 갑근세*/
					sql.append( "  B.T12000, ");	/*  주민세*/
					sql.append( "  B.B11000, ");	/*  건강보험료*/
					sql.append( "  B.B12000, ");	/*  국민연금*/
					sql.append( "  B.B13000, ");	/*  고용보험*/
					sql.append( "  B.B15000, ");	/*  개인연금*/
					sql.append( "  B.B14000, ");	/*  여직원회비*/
					sql.append( "  B.B16000, ");	/*  공조회비*/
					sql.append( "  B.BX0010, ");	/*  기타공제1*/		
					sql.append( "  B.BX0020, ");	/*  기타공제2*/		
					sql.append( "  B.BX0030, ");	/*  기타공제3*/		
					sql.append( "  B.BX0040, ");	/*  기타공제4*/
					sql.append( "  B.S93000,  ");	/*  공제합계*/	
					sql.append( "  B.S94000,  ");	/*  실지급액,차인*/	
					sql.append( "  RTRIM(A.STRTDT) AS STRTDT,  ");/*  입사일*/	
					sql.append( "  D.MINORNM AS JOBGRPHNM,  ");		/*  직군*/	
					sql.append( "  B.P34000, ");	/*  기타공제1*/		
					sql.append( "  B.P39000, ");	/*  기타공제2*/		
					sql.append( "  B.P41000, ");	/*  기타공제3*/		
					sql.append( "  B.P42000, ");	/*  기타공제4*/
					sql.append( "  B.T21000,  ");	/*  공제합계*/	
					sql.append( "  B.T22000,  ");	/*  실지급액,차인*/	
					sql.append( "  A.STRTDT,  ");	/*  입사일자*/	
					sql.append( "  A.ENDDT,  ");	/*  퇴직일자*/
					sql.append( "  A.P35000	 ");  /*  식대    */ 
					sql.append( " FROM PAYROLL.PBPAY B "); 
					sql.append( " LEFT OUTER JOIN PAYROLL.HIPERSON A ON  B.EMPNO  = A.EMPNO   ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT	 C ON  B.DEPTCD = C.DEPTCD   ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE D ON  B.JOBGRPH = D.MINORCD AND D.MAJORCD = '2000'  ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE E ON  B.PAYGRD = E.MINORCD  AND E.MAJORCD = '2002'  ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE F ON  B.GRDDIV = F.MINORCD  AND F.MAJORCD = '2001'  ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE G ON  B.PAYSEQ = G.MINORCD  AND G.MAJORCD = '1184'  ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE H ON  B.PAYBNK = H.MINORCD  AND H.MAJORCD = '1411'  ");
					sql.append( " WHERE B.EMPNO <> ' ' ");

					if (!str[0].equals("")&&!str[0].equals("0")) sql.append( " AND B.PAYDT= '"  + str[0] + "' ");    //지급일자
					if (!str[1].equals("")&&!str[1].equals("0")) sql.append( " AND B.APPDT = '" + str[1]+ "' ");     //적용년월
					if (!str[2].equals("")&&!str[2].equals("0")) sql.append( " AND B.PAYDIV= '"  + str[2] + "' ");   //급여구분
					if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND B.DEPTCD = '" + str[3]+ "' ");    //부서코드
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append( " AND B.JOBGRPH= '"  + str[4] + "' ");  //직군
												  													   
					if (!str[5].equals("")&&!str[5].equals("0") )
						                                        sql.append( " AND B.EMPNO =  '" + str[5]+ "' ");
					                                             //사번 부터 까지
					if (!str[7].equals("")&&!str[7].equals("0")) sql.append( " AND A.EMPNMK LIKE '" + str[7]+ "%' ");  //성명
					if (!str[8].equals("")&&!str[8].equals("0")) sql.append( " AND B.PAYGRD= '"  + str[8] + "' "); //직위
					if (!str[9].equals("")&&!str[9].equals("0")) sql.append( " AND B.GRDDIV = '" + str[9]+ "' "); // 직급
					
					logger.dbg.println(this,sql.toString());

/*********************************************************************************************/
          // System.out.println(sql);
					stmt = conn.getGauceStatement(sql.toString());
					// logger.err.println(this,"1");

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