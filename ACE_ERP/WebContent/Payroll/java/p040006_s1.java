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
public class p040006_s1 extends HttpServlet {

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
				str[0]	= req.getParameter("v_str1");		//퇴사일,1- 입사일,2
				str[1]	= req.getParameter("v_str2");		//기준일자부터
				str[2]	= req.getParameter("v_str3");		//기준일자까지
				str[3]	= req.getParameter("v_str4");		//부서코드
				str[4]	= req.getParameter("v_str5");		//사번





				for (int s=0;s<5;s++) {
					if (str[s]==null) str[s] = "";
				}
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"EMPNO",	   /* 사번 */
				"EMPNMK",       /*한글명*/
				//"NOTWRK",       /*휴직정직일수*/
				"APPDT",	       /* 년월 */
				"PAYDIV",	/* 급여구분*/
				"DEPTCD",	/*  부서코드*/
				"DEPTNM",	/*  부서명*/
				"PAYGRDNM",	/* 직위코드*/
				"GRDDIVNM",	/*직급*/
				"PAYSEQNM",	/* 호봉코드 */
				"PAYBNKNM",	/*  은행코드*/
				"PAYNUM",	/*  계좌번호*/
				"PAYDT",  /*  지급일*/
				//"DUYNOT",	/*  무계결근일수*/
				"P10000",	/*  기본급여*/
				"P11000",	/* 직책수당 */
				"P12000",	/* 시간외수당 */
				"P21000",	/*  근속수당*/
				"P22000",	/*  자기계발비 */
				"P23000",	/*  부양가족수당*/
				"P24000",	/*  차량유지비 */
				"P25000",	/*  출납수당*/
				"P26000",	/*  운전수당*/
				"P27000",	/*  연장수당*/
				"P28000",	/*  자격수당*/
				"P29000",	/*  남북경협수당*/
				"P30000",	/*  사장단수당*/
				"P31000",	/*  특수지수당*/
				"P32000",	/*  지역근무수당*/
				"P33000",	/*  월차수당*/
				"P36000",	/*  학비보조금*/
				"P37000",	/*  개인연금보조금*/
				"P38000",	/*  임원직책수당*/
				"PX0010",	/*  기타지급1*/
				"PX0020",	/*  기타지급2*/
				"PX0030",	/*  기타지급3*/
				"PX0040",	/*  기타지급4*/
				//"S91000",	/*  지급합계*/
				//"T11000",	/*  소득세 OR 갑근세*/
				//"T12000",	/*  주민세*/
				//"B11000",	/*  건강보험료*/
				//"B12000",	/*  국민연금*/
				//"B13000",	/*  고용보험*/
				//"B15000",	/*  개인연금*/
				//"B14000",	/*  여직원회비*/
				//"B16000",	/*  공조회비*/
				//"BX0010",	/*  기타공제1*/		
				//"BX0020",	/*  기타공제2*/		
				//"BX0030",	/*  기타공제3*/		
				//"BX0040",	/*  기타공제4*/
				//"S93000",	/*  공제합계*/	
				//"S94000",	/*  차인지급액*/	
				"STRTDT",	/*  입사일*/	
				"JOBGRPHNM",	/*  직군*/	
				"ENDDT",	/*  퇴사일*/	
				"RESINO",	/*  주민번호*/	
				"DUYEAR",	/*  근무기간*/	
				"DUYMM",	/*  근무기간*/	
				"DUDAY",	/*  근무기간*/	
				"T21000",	/*  총소득*/	
				"CZIPCD",	/*  우편번호*/	
				"CADDR",	 /*  주소*/	
				"MONAVG", /*  평균급여 OR 평균임금*/	
				"MONBUS",/*  평균상여금*/	
				"YEAPAY",/*  년차수당계*/	
				"MONCOM",/*  평균수당*/	
				"RETPAY",/*  퇴직금*/	
				"RETDT", /*  퇴직금지급일*/	
				"T92000", /*  퇴직전환금 협의필요*/	
				"RETTAX", /*  퇴직소득세*/	
				"PERTAX", /*  퇴직주민세*/	
				"S94000" /*  실지급액*/	
				};

				int[] intArrCN = new int[]{  
					7, 	
					20,
					//2, 
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
					//2,
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
                    /*
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
                    */
					8,
					30,
					8,
					13,
					2,
					2,
					2,
					9,
					6,
					140,

					10,
					10,
					10,
					10,
					10,
					8,
					10,  //퇴직전환금
					10,  //퇴직소득세
					10,  //퇴직주민세
					10  //실지급액
            	}; 

				int[] intArrCN2 = new int[]{
					-1,   
					-1,
					//0,
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
					//0
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
					/*
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
					*/
					-1,
					-1,
					-1,
					-1,
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
					-1,
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
					//sql.append( "  B.NOTWRK, ");       /*휴직정직 OR 재직구분*/

					sql.append( "  B.APPYM AS APPDT, ");	       /* 년월 */
					sql.append( "  A.PAYDIV, ");	/* 급여구분*/
					sql.append( "  A.DEPTCD, ");	/*  부서코드*/
					sql.append( "  C.DEPTNM AS DEPTNM, ");	/*  부서명*/
					sql.append( "  E.MINORNM AS PAYGRDNM, ");	/* 직위코드*/

					sql.append( "  F.MINORNM AS GRDDIVNM, ");	/*직급*/
					sql.append( "  G.MINORNM AS PAYSEQNM, ");	/* 호봉코드 */
					sql.append( "  H.MINORNM AS PAYBNKNM, ");	/*  은행코드*/
					sql.append( "  I.BNKNO AS PAYNUM, ");	/*  계좌번호*/
					sql.append( "  B.PAYDT, ");  /*  지급일*/
					//sql.append( "  B.DUYNOT, ");	/*  무계결근일수*/
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
					sql.append( "  B.P33000, ");	/*  월차수당*/
					sql.append( "  B.P36000, ");	/*  학비보조금*/
					sql.append( "  COALESCE(B.P37000,0) AS P37000, ");	/*  개인연금보조금*/
					sql.append( "  B.P38000, ");	/*  임원직책수당*/

					sql.append( "  B.PX0010, ");	/*  기타지급1*/
					sql.append( "  B.PX0020, ");	/*  기타지급2*/
					sql.append( "  B.PX0030, ");	/*  기타지급3*/
					sql.append( "  B.PX0040, ");	/*  기타지급4*/
					//sql.append( "  B.S91000, ");	/*  지급합계*/
					//sql.append( "  B.T11000, ");	/*  소득세 OR 갑근세*/
					//sql.append( "  B.T12000, ");	/*  주민세*/
					//sql.append( "  B.B11000, ");	/*  건강보험료*/

					//sql.append( "  B.B12000, ");	/*  국민연금*/

					//sql.append( "  B.B13000, ");	/*  고용보험*/
					//sql.append( "  B.B15000, ");	/*  개인연금*/
					//sql.append( "  B.B14000, ");	/*  여직원회비*/
					//sql.append( "  B.B16000, ");	/*  공조회비*/
					//sql.append( "  B.BX0010, ");	/*  기타공제1*/	
					
					//sql.append( "  B.BX0020, ");	/*  기타공제2*/		
					//sql.append( "  B.BX0030, ");	/*  기타공제3*/		
					//sql.append( "  B.BX0040, ");	/*  기타공제4*/
					//sql.append( "  B.S93000,  ");	/*  공제합계*/	
					//sql.append( "  B.S94000,  ");	/*  실지급액,차인*/	
					sql.append( "  RTRIM(A.STRTDT) AS STRTDT,  ");	/*  입사일*/	
					sql.append( "  D.MINORNM AS JOBGRPHNM,  ");	/*  직군*/	
					sql.append( "  RTRIM(A.ENDDT) AS ENDDT,  ");	/*  퇴사일*/	
					sql.append( "  RTRIM(A.RESINO) AS RESINO,  ");	/*  주민번호*/	
					sql.append( "  A.DUYEAR,  ");	/*  근무년월일*/	
					sql.append( "  A.DUYMM,  ");	/*  근무년월일*/	
					sql.append( "  A.DUDAY,  ");	/*  근무년월일*/	
					sql.append( "  I.RETTAX AS T21000,  ");	/*  총소득*/	
					sql.append( "  A.CZIPCD,  ");	/*  우편번호*/	
					sql.append( "  (A.CADDR01 || A.CADDR02) AS CADDR, ");	/*  주소*/	
					sql.append( "  I.MONAVG, ");	/*  평균급여 OR 평균임금*/	
					sql.append( "  I.MONBUS, ");	/*  평균상여금*/	
					sql.append( "  I.YEAPAY, ");	/*  년차수당계*/	
					sql.append( "  I.MONCOM, ");	    /*  평균수당*/	
					sql.append( "  I.RETPAY, ");	    /*  퇴직금*/	
					sql.append( "  I.RETDT, ");	    /*  퇴직금지급일*/	
					sql.append( "  COALESCE(J.T92000,0) AS T92000, ");	    /*  퇴직전환금 협의피요*/	
					sql.append( "  I.RETTAX, ");	/*  퇴직소득세*/	
					sql.append( "  I.PERTAX, ");	    /*  퇴직주민세*/	
					sql.append( "  COALESCE(J.S94000,0) AS S94000 ");	    /*  실지급액*/	

					sql.append( " from  PAYROLL.HIPERSON A"); 
					sql.append( " LEFT OUTER JOIN PAYROLL.PRAVGPAY B  ON  B.EMPNO = A.EMPNO AND B.APPYM=SUBSTR(A.ENDDT,1,6)  ");
					sql.append( " LEFT OUTER JOIN PAYROLL.PRPAY I ON  B.EMPNO = I.EMPNO   ");
					sql.append( " LEFT OUTER JOIN PAYROLL.PBPAY J ON  B.EMPNO = J.EMPNO AND B.APPYM=J.APPDT ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT C ON  A.DEPTCD = C.DEPTCD   ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE D ON  A.JOBGRPH = D.MINORCD  AND D.MAJORCD = '2000'  ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE E ON  A.PAYGRD = E.MINORCD  AND E.MAJORCD = '2002'   ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE F ON  A.GRDDIV = F.MINORCD  AND F.MAJORCD = '2001'  ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE G ON  A.PAYSEQ =  G.MINORCD  AND G.MAJORCD='1184'  ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE H ON  I.BNKCD = H.MINORCD  AND H.MAJORCD = '1411'  ");
					sql.append( " WHERE B.EMPNO <> ' ' and A.ENDDT <> ' ' \n ");

					if ( (!str[1].equals("")&&!str[1].equals("0")) && (!str[2].equals("")&&!str[2].equals("0")) )
					{
						if ( str[0].equals("1") )
						{
						sql.append( " AND A.ENDDT BETWEEN  '"  + str[1] + "' AND  '"  + str[2] + "' ");    //퇴사일자
						}else
						{
						sql.append( " AND A.STRTDT BETWEEN  '"  + str[1] + "' AND  '"  + str[2] + "' ");    //입사일자
						}
					}

					if (!str[3].equals("")&&!str[3].equals("0")) sql.append( "  AND A.DEPTCD ='" + str[3]+ "' ");     //부서
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append( "  AND B.EMPNO = '" + str[4]+ "' ");     //사번
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