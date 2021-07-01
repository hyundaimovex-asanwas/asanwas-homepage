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
public class p020006_s9 extends HttpServlet {

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
				str[2]	= req.getParameter("v_str3");		//지급구분
				str[3]	= req.getParameter("v_str4");		//부서
				str[4]	= req.getParameter("v_str5");		//직군
				str[5]	= req.getParameter("v_str6");		//사원번호
				str[6]	= req.getParameter("v_str7");		//사원번호
				str[7]	= req.getParameter("v_str8");		//성명
				str[8]	= req.getParameter("v_str9");		//직위
				str[9]	= req.getParameter("v_str10");		//직급

				for (int s=0;s<10;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{

				"DEPTNM",	 /*  부서명*/
				"TREECD",	 /*  부서명*/
				"EMPNO",	 /* 사번 */
				"EMPNMK",  /*한글명*/
				
				"PAYGRDNM",/*  직위명*/
				"JOBGRPHNM",/*  직군명*/	
				"PAYSEQNM",/*  호봉명*/
				"GRDDIVNM",/*  직급명*/

				"P10000",	/* 기본급여*/
				"P11000",	/* 직책수당 */
				"P12000",	/* 시간외수당 */
				"P21000",	/* 근속수당*/
				"P22000",	/* 자기계발비 */
				"P23001",	/* 부양가족*/
				"P23000",	/* 부양가족수당*/
				"P24000",	/* 차량유지비 */
				"P25000",	/* 출납수당*/
				"P26000",	/* 운전수당*/
				"P27000",	/* 연장수당*/
				"P28000",	/* 자격수당*/
				"P29000",	/* 남북경협수당*/
				"P30000",	/* 사장단수당*/
				"P31000",	/* 특수지수당*/
				"P32000",	/* 지역근무수당*/
				"P33001",	/* 월차일수  */
				"P33000",	/* 월차수당*/
				"P34001",	/* 연차일수*/
				"P34000",	/* 연차수당*/
				"P35000",	/* 식대*/
				"P36000",	/* 학비보조금*/
				"P37000",	/* 개인연금보조금*/
				"P38000",	/* 임원직책수당*/
				"P39000",	/* 전월소급*/
				"PX0010",	/* 기타지급1*/
				"PX0020",	/* 기타지급2*/
				"PX0030",	/* 기타지급3*/
				"PX0040",	/* 기타지급4*/
				"P41000",	/* 정산건강보험*/
				"P42000",	/* 정산고용보험*/
				"T21000",	/* 정산소득세*/
				"T22000",	/* 정산주민세*/
				"T23000",	/* 정산농특세*/
				"S91000",	/* 지급합계*/
				"S92000",	/* 소득합계*/
				"T11000",	/* 소득세*/
				"T12000",	/* 주민세*/
				"B11000",	/* 건강보험료*/
				"B12000",	/* 국민연금*/
				"B13000",	/* 고용보험*/
				"B14000",	/* 여직원회비*/
				"B15000",	/* 개인연금*/
				"B16000",	/* 공조회비*/
				"BX0010",	/* 기타공제1*/
				"BX0020",	/* 기타공제2*/
				"BX0030",	/* 기타공제3*/
				"BX0040",	/* 기타공제4*/
				//"T31000",	/* 추징소득세*/
				//"T33000",	/* 추징주민세*/
				//"T92000",	/* 퇴직전환금*/
				"S93000",	/* 공제합계*/
				"S94000",	/* 실지급액*/
				"STRTDT",   /* 입사일 */
				"GRSTRTDT",   /* 그룹입사일 */
				"TRAINYN",  /* 수습적용여부*/
				"CHAGDT",  /* 최종변동일 */
				"SENUM",    /* 배부자장경수 -부양가족수로 -> 6월16일 다시변경 배우자-부모-자녀-장애인-경로우대 */
				"P23002",   /* 배우자*/ 
				"P23003",	 /* 부모*/    
				"P23004",	 /* 자녀*/    
				"P23005",	 /* 장애*/    
				"P23006",	 /* 경로*/    
        "SEQ",	 /* 근무지출력순서*/   
				"APLAMT",
				"APLRAT",			
				"SANGRAT",  /*상여율*/
				"AMT_1"
				};

				int[] intArrCN = new int[]{  
					30,	
					8, 	
					7, 	
					20,

					30,	/*  직위명*/
					30,	/*  직군명*/
					30,	/*  호봉명*/
					30,	/*  직급명*/

					9,	/* 기본급여*/
					9,	/* 직책수당 */
					9,	/* 시간외수당 */
					9,	/* 근속수당*/
					9,	/* 자기계발비 */
					9,	/* 부양가족*/
					9,	/* 부양가족수당*/
					9,	/* 차량유지비 */
					9,	/* 출납수당*/
					9,	/* 운전수당*/
					9,	/* 연장수당*/
					9,	/* 자격수당*/
					9,	/* 남북경협수당*/
					9,	/* 사장단수당*/
					9,	/* 특수지수당*/
					9,	/* 지역근무수당*/
					9,	/* 월차일수  */
					9,	/* 월차수당*/
					9,	/* 연차일수*/
					9,	/* 연차수당*/
					9,	/* 식대*/
					9,	/* 학비보조금*/
					9,	/* 개인연금보조금*/
					9,	/* 임원직책수당*/
					9,	/* 전월소급*/
					9,	/* 기타지급1*/
					9,	/* 기타지급2*/
					9,	/* 기타지급3*/
					9,	/* 기타지급4*/
					9,	/* 정산건강보험*/
					9,	/* 정산고용보험*/
					9,	/* 정산소득세*/
					9,	/* 정산주민세*/
					9,	/* 정산농특세*/
					9,	/* 지급합계*/
					9,	/* 소득합계*/
					9,	/* 소득세*/
					9,	/* 주민세*/
					9,	/* 건강보험료*/
					9,	/* 국민연금*/
					9,	/* 고용보험*/
					9,	/* 여직원회비*/
					9,	/* 개인연금*/
					9,	/* 공조회비*/
					9,	/* 기타공제1*/
					9,	/* 기타공제2*/
					9,	/* 기타공제3*/
					9,	/* 기타공제4*/
					//9,	/* 추징소득세*/
					//9,	/* 추징주민세*/
					//9,	/* 퇴직전환금*/
					9,	/* 공제합계*/
					9,	/* 실지급액*/
					8,   /* 입사일 */
					8,   /* 그룹입사일 */
					1,   /* 수습적용여부 */
					8,  /* 최종변동일 -협의중*/
					9,    /* 배부자장경수 -부양가족수로 -> 6월16일 다시변경 배우자-부모-자녀-장애인-경로우대*/
					2,	/* 배우자*/
					2,	/* 부모*/  
					2,	/* 자녀*/  
					2,	/* 장애*/  
					2,	/* 경로*/  
          3,	  /* 근무지출력순*/  
					9,
					9,
					3,
					9
          }; 

				int[] intArrCN2 = new int[]{
					-1,
					-1,   
					-1,   
					-1,

					-1,	/*  직위명*/
					-1,	/*  직군명*/
					-1,	/*  호봉명*/
					-1,	/*  직급명*/

					0,	/* 기본급여*/
					0,	/* 직책수당 */
					0,	/* 시간외수당 */
					0,	/* 근속수당*/
					0,	/* 자기계발비 */
					0,	/* 부양가족*/
					0,	/* 부양가족수당*/
					0,	/* 차량유지비 */
					0,	/* 출납수당*/
					0,	/* 운전수당*/
					0,	/* 연장수당*/
					0,	/* 자격수당*/
					0,	/* 남북경협수당*/
					0,	/* 사장단수당*/
					0,	/* 특수지수당*/
					0,	/* 지역근무수당*/
					0,	/* 월차일수  */
					0,	/* 월차수당*/
					0,	/* 연차일수*/
					0,	/* 연차수당*/
					0,	/* 식대*/
					0,	/* 학비보조금*/
					0,	/* 개인연금보조금*/
					0,	/* 임원직책수당*/
					0,	/* 전월소급*/
					0,	/* 기타지급1*/
					0,	/* 기타지급2*/
					0,	/* 기타지급3*/
					0,	/* 기타지급4*/
					0,	/* 정산건강보험*/
					0,	/* 정산고용보험*/
					0,	/* 정산소득세*/
					0,	/* 정산주민세*/
					0,	/* 정산농특세*/
					0,	/* 지급합계*/
					0,	/* 소득합계*/
					0,	/* 소득세*/
					0,	/* 주민세*/
					0,	/* 건강보험료*/
					0,	/* 국민연금*/
					0,	/* 고용보험*/
					0,	/* 여직원회비*/
					0,	/* 개인연금*/
					0,	/* 공조회비*/
					0,	/* 기타공제1*/
					0,	/* 기타공제2*/
					0,	/* 기타공제3*/
					0,	/* 기타공제4*/
					//0,	/* 추징소득세*/
					//0,	/* 추징주민세*/
					//0,	/* 퇴직전환금*/
					0,	/* 공제합계*/
					0,	/* 실지급액*/
					-1,   /* 입사일 */
					-1,   /* 그룹입사일 */
					-1,   /* 수습적용여부 */
					-1,  /* 최종변동일 */
					-1,    /* 배부자장경수 -부양가족수로 -> 6월16일 다시변경 배우자-부모-자녀-장애인-경로우대*/
					0,		/* 배우자*/ 
					0,		/* 부모*/    
					0,		/* 자녀*/    
					0,		/* 장애*/    
					0, 		/* 경로*/    
          -1,
					0,
					0,
					-1,
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
					
					sql.append( " SELECT                            \n ");
          sql.append( " RTRIM(C.DEPTNM) AS DEPTNM,        \n "); /* 부서명*/
					sql.append( " C.TREECD,                         \n "); /* 트리시디 */  
					sql.append( " A.EMPNO,                          \n ");	/* 사번 */      
          sql.append( " A.EMPNMK,                         \n ");	/*한글명*/      
					sql.append( " RTRIM(D.MINORNM) AS PAYGRDNM,     \n "); /*  직위명*/  
					sql.append( " RTRIM(F.MINORNM) AS JOBGRPHNM,    \n ");	/*  직군명*/	
					sql.append( " RTRIM(G.MINORNM) AS PAYSEQNM,     \n ");	/*  호봉명*/  
					sql.append( " RTRIM(H.MINORNM) AS GRDDIVNM,     \n ");	/*  직급명*/  
					sql.append( " X.P10000,                         \n "); /* 기본급여*/       
					sql.append( " X.P11000,                         \n ");	/* 직책수당 */      
					sql.append( " X.P12000,                         \n ");	/* 시간외수당 */    
					sql.append( " X.P21000,                         \n ");	/* 근속수당*/       
					sql.append( " X.P22000,                         \n ");	/* 자기계발비 */    
          sql.append( " X.P23001,                         \n ");	/* 부양가족*/       
          sql.append( " X.P23000,                         \n ");	/* 부양가족수당*/   
					sql.append( " X.P24000,                         \n ");	/* 차량유지비 */    
					sql.append( " X.P25000,                         \n ");	/* 출납수당*/       
          sql.append( " X.P26000,                         \n ");	/* 운전수당*/       
					sql.append( " X.P27000,                         \n ");	/* 연장수당*/       
					sql.append( " X.P28000,                         \n ");	/* 자격수당*/       
					sql.append( " X.P29000,                         \n ");	/* 남북경협수당*/   
					sql.append( " X.P30000,                         \n ");	/* 사장단수당*/     
					sql.append( " X.P31000,                         \n ");	/* 특수지수당*/     
					sql.append( " X.P32000,                         \n ");	/* 지역근무수당*/   
					sql.append( " X.P33001,                         \n ");	/* 월차일수  */     
					sql.append( " X.P33000,                         \n ");	/* 월차수당*/       
					sql.append( " X.P34001,                         \n ");	/* 연차일수*/       
					sql.append( " X.P34000,                         \n ");	/* 연차수당*/       
          sql.append( " X.P35000,                         \n ");	/* 식대*/           
					sql.append( " X.P36000,                         \n ");	/* 학비보조금*/     
					sql.append( " X.P37000,                         \n ");	/* 개인연금보조금*/ 
          sql.append( " X.P38000,                         \n ");	/* 임원직책수당*/   
					sql.append( " X.P39000,                         \n ");	/* 전월소급*/       
					sql.append( " X.PX0010,                         \n ");	/* 기타지급1*/      
					sql.append( " X.PX0020,                         \n ");	/* 기타지급2*/      
					sql.append( " X.PX0030,                         \n ");	/* 기타지급3*/      
					sql.append( " X.PX0040,                         \n ");	/* 기타지급4*/      
					sql.append( " X.P41000,                         \n ");	/* 정산건강보험*/   
					sql.append( " X.P42000,                         \n ");	/* 정산고용보험*/   
					sql.append( " X.T21000,                         \n ");	/* 정산소득세*/     
					sql.append( " X.T22000,                         \n ");	/* 정산주민세*/     
					sql.append( " X.T23000,                         \n ");	/* 정산농특세*/     
          sql.append( " X.S91000,                         \n ");	/* 지급합계*/       
					sql.append( " X.S92000,                         \n ");	/* 소득합계*/       
					sql.append( " X.T11000,                         \n ");	/* 소득세*/         
          sql.append( " X.T12000,                         \n ");	/* 주민세*/         
					sql.append( " X.B11000,                         \n ");	/* 건강보험료*/     
					sql.append( " X.B12000,                         \n ");	/* 국민연금*/       
					sql.append( " X.B13000,                         \n ");	/* 고용보험*/       
					sql.append( " X.B14000,                         \n ");	/* 여직원회비*/     
					sql.append( " X.B15000,                         \n ");	/* 개인연금*/       
					sql.append( " X.B16000,                         \n ");	/* 공조회비*/       
					sql.append( " X.BX0010,                         \n ");	/* 기타공제1*/      
					sql.append( " X.BX0020,                         \n ");	/* 기타공제2*/      
					sql.append( " X.BX0030,                         \n ");	/* 기타공제3*/      
					sql.append( " X.BX0040,                         \n ");	/* 기타공제4*/      
          sql.append( " X.S93000,                         \n "); /* 공제합계*/  
					sql.append( " X.S94000,                         \n ");	/* 실지급액*/  
					sql.append( " X.STRTDT,                         \n "); /* 입사일 */     
          sql.append( " RTRIM(A.GRSTRTDT) AS GRSTRTDT,    \n ");	/* 그룹입사일*/  
					sql.append( " X.TRAINYN,                        \n ");  /* 수습적용여부 */ 
					sql.append( " X.CHAGDT AS CHAGDT,               \n ");	/* 최종변동일*/    
					sql.append( " X.SENUM,                          \n ");	 /* 배부자장경*/    
					sql.append( " X.P23002,                         \n ");	 /* 배우자*/        
					sql.append( " X.P23003,                         \n ");	/* 부모*/          
					sql.append( " X.P23004,                         \n ");	 /* 자녀*/          
					sql.append( " X.P23005,                         \n ");	 /* 장애*/          
					sql.append( " X.P23006,                         \n ");	 /* 경로*/		       
					//sql.append( " I.SEQ,                            \n ");	 /* 경로*/
          // 2008.08.18 재택근무자 별도로 정렬...
          //sql.append( " CASE WHEN A.HSKSCR=2 THEN 99 ELSE I.SEQ END SEQ,   \n ");	 /* 경로*/
					// 2009.01.18 재택근무자 별도로 정렬...
					//sql.append( " CASE WHEN A.JTGB IN (2,3,4,5,6) THEN 99 ELSE I.SEQ END SEQ,   \n ");	 /* 경로*/
					// 2010.01.25. JYS 정영식 예외처리
          sql.append( " CASE WHEN X.JTGB = 2 THEN 995    \n ");	 
					sql.append( " 		 WHEN X.JTGB = 3 THEN 996    \n ");	 
					sql.append( " 		 WHEN X.JTGB = 4 THEN 997    \n ");	 
					sql.append( " 		 WHEN X.JTGB = 5 THEN 998    \n ");	 
					sql.append( " 		 WHEN X.JTGB = 6 THEN 999    \n ");	 				
					sql.append( " 		 ELSE CASE WHEN X.EMPNO ='1990016' THEN '7'        \n ");	 //1990005-->1990016
					sql.append( " 		           WHEN X.EMPNO ='2000001' THEN '8'        \n ");	
					sql.append( " 		      ELSE I.SEQ END        \n ");	 
					sql.append( "  END SEQ,        \n ");	 
					sql.append( " X.APLAMT,X.APLRAT,              \n ");
          sql.append( " X.SANGRAT,                      \n ");	 /* 상여율*/
					sql.append( " COALESCE((L.APLAMT+L.APLRAT),0) AMT_1,  \n ");	/* 상환액 */
					//2007.10.24추가 2009.10.16 추가 2010.01.18 추가
					//sql.append( " CASE WHEN A.EMPNO='1990005' THEN '998'             \n " );	/* 예외처리 */
          //sql.append( " CASE WHEN A.EMPNO='2030001' THEN '998'             \n " );	/* 예외처리 */
					//sql.append( "      WHEN A.EMPNO='2010008' THEN '999'   \n " );	/*  */
					//sql.append( "      WHEN A.EMPNO='2060002' THEN '40'  \n " );	/*  */
          //sql.append( "      WHEN A.EMPNO='1990013' THEN '41'  \n " );	/*  */
					//sql.append( "      WHEN A.EMPNO='2070012' THEN '42'  \n " );	/*  */
					//sql.append( "      WHEN A.EMPNO='2040056' THEN '43'  \n " );	/*  */
					//sql.append( "      WHEN A.EMPNO='2040060' THEN '50'  \n " );	/*  */
					//sql.append( "      WHEN A.EMPNO='2040056' THEN '60'  \n " );	/*  */
					//sql.append( "      WHEN A.EMPNO='2090007' THEN '70'  \n " );	/*  */
					//sql.append( "      ELSE D.SEQ END SEQ2  \n " );	/*  */					
					sql.append( " CASE WHEN A.EMPNO='1990005' THEN '548'  \n " );	/* 예외처리 */
					sql.append( "      WHEN A.EMPNO='2070031' THEN '549'  \n " );	/* 예외처리 */
					sql.append( "      ELSE D.SEQ END SEQ2  \n " );	/*  */
					sql.append( " FROM                              \n " );
          sql.append( " (                                                                                                                     \n " );
					sql.append( "    SELECT B.EMPNO, MAX(B.DEPTCD)DEPTCD, MAX(B.PAYGRD)PAYGRD, MAX(B.JOBGRPH)JOBGRPH,                                      \n " );
					sql.append( "		 MAX(B.PAYSEQ)PAYSEQ,    MAX(B.GRDDIV)GRDDIV,                                                                          \n " );
          sql.append( "		 SUM(B.P10000)P10000,    SUM(B.P11000)P11000,    SUM(B.P12000)P12000,    SUM(B.P21000)P21000,    SUM(B.P22000)P22000,  \n " );
					sql.append( "		 SUM(B.P23001)P23001,    SUM(B.P23000)P23000,    SUM(B.P24000)P24000,    SUM(B.P25000)P25000,    SUM(B.P26000)P26000,  \n " );
					sql.append( "		 SUM(B.P27000)P27000,    SUM(B.P28000)P28000,    SUM(B.P29000)P29000,    SUM(B.P30000)P30000,    SUM(B.P31000)P31000,  \n " );
					sql.append( "		 SUM(B.P32000)P32000,    SUM(B.P33001)P33001,    SUM(B.P33000)P33000,    SUM(B.P34001)P34001,    SUM(B.P34000)P34000,  \n " );
					sql.append( "		 SUM(B.P35000)P35000,    SUM(B.P36000)P36000,    SUM(B.P37000)P37000,    SUM(B.P38000)P38000,    SUM(B.P39000)P39000,  \n " );
					sql.append( "		 SUM(B.PX0010)PX0010,    SUM(B.PX0020)PX0020,    SUM(B.PX0030)PX0030,    SUM(B.PX0040)PX0040,    SUM(B.P41000)P41000,  \n " );
					sql.append( "		 SUM(B.P42000)P42000,    SUM(B.T21000)T21000,    SUM(B.T22000)T22000,    SUM(B.T23000)T23000,    SUM(B.S91000)S91000,  \n " );
					sql.append( "		 SUM(B.S92000)S92000,    SUM(B.T11000)T11000,    SUM(B.T12000)T12000,    SUM(B.B11000)B11000,    SUM(B.B12000)B12000,  \n " );
					sql.append( "		 SUM(B.B13000)B13000,    SUM(B.B14000)B14000,    SUM(B.B15000)B15000,    SUM(B.B16000)B16000,    SUM(B.BX0010)BX0010,  \n " );
					sql.append( "		 SUM(B.BX0020)BX0020,    SUM(B.BX0030)BX0030,    SUM(B.BX0040)BX0040,    SUM(B.S93000)S93000,    SUM(B.S94000)S94000,  \n " );
					sql.append( "		 MAX(B.STRTDT)STRTDT,    MAX(B.CHAGDT)CHAGDT,    '0'  AS SENUM,            \n " );
          sql.append( "		 SUM(B.P23002)P23002,    SUM(B.P23003)P23003,    SUM(B.P23004)P23004,    SUM(B.P23005)P23005,    SUM(B.P23006)P23006,  \n " );
					sql.append( "		 SUM(B.APLAMT)APLAMT,    SUM(B.APLRAT)APLRAT,    IFNULL(MAX(B.SANGRAT),0)SANGRAT, IFNULL(MAX(B.TRAINYN),'')TRAINYN,MAX(B.JTGB) JTGB	 \n " );
					sql.append( "		 FROM PAYROLL.PBPAY B                                                                                                  \n " );
					
					sql.append( "   WHERE B.EMPNO <> ' ' \n " );
					if (!str[0].equals("")&&!str[0].equals("0")) 
					sql.append( "     AND B.PAYDT = '"  + str[0] + "' \n " );    //지급일자부터까지
					if (!str[1].equals("")&&!str[1].equals("0")) 
					sql.append( "     AND B.APPDT= '"  + str[1] + "' \n " );     //적용년월
					//if (!str[2].equals("")&&!str[2].equals("0")) sql.append( " AND B.PAYDIV = '" + str[2]+ "' \n " );   //지급구분
					if (!str[3].equals("")&&!str[3].equals("0")) 
					sql.append( "     AND B.DEPTCD = '" + str[3]+ "' \n " );   //부서
					if (!str[4].equals("")&&!str[4].equals("0")) 
					sql.append( "     AND B.JOBGRPH= '"  + str[4] + "' \n " ); //직군
					if (!str[5].equals("")&&!str[5].equals("0") && (!str[6].equals("")&&!str[6].equals("0")) )
					sql.append( "     AND B.EMPNO BETWEEN '"  + str[5] + "' AND '"  + str[6] + "' \n " );                //사원번호부터 까지                                                                                               \n " );
          if (!str[8].equals("")&&!str[8].equals("0")) 
					sql.append( "     AND B.PAYGRD = '" + str[8]+ "' \n " );  // 직위
					if (!str[9].equals("")&&!str[9].equals("0")) 
					sql.append( "     AND B.GRDDIV = '" + str[9]+ "' \n " );  // 직급
					if (str[2].equals("1")) 
					sql.append( "   	AND B.PAYDIV IN ('1','3','4')                \n " );     //정기+퇴직+휴급
					if (str[2].equals("5"))
					sql.append( "	    AND B.PAYDIV IN ('5')                \n " );	
					if (str[2].equals("6"))
					sql.append( "	    AND B.PAYDIV IN ('6')                \n " );	
					if (str[2].equals("7"))
					sql.append( "	    AND B.PAYDIV IN ('7')                \n " );	
					sql.append( "	GROUP BY SUBSTR(B.PAYDT,1,6), B.EMPNO) X                                                                              \n " );
					sql.append( " LEFT JOIN PAYROLL.HIPERSON A ON A.EMPNO=X.EMPNO                                                                       \n " );
					sql.append( " LEFT JOIN PAYROLL.HCDEPT C ON X.DEPTCD=C.DEPTCD AND C.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)                 \n " );
					sql.append( " LEFT JOIN PAYROLL.HCLCODE D ON X.PAYGRD = D.MINORCD AND D.MAJORCD = '2002'                                            \n " ); /*직위*/       
					sql.append( " LEFT JOIN PAYROLL.HCLCODE F ON X.JOBGRPH = F.MINORCD AND F.MAJORCD = '2000'                                           \n " );	 /*직군*/      
					sql.append( " LEFT JOIN PAYROLL.HCLCODE G ON X.PAYSEQ = G.MINORCD AND G.MAJORCD = '1184'                                            \n " );	/*호봉*/       
					sql.append( " LEFT JOIN PAYROLL.HCLCODE H ON X.GRDDIV = H.MINORCD AND H.MAJORCD = '2001'                                            \n " );	/*직급*/       
					sql.append( " LEFT JOIN PAYROLL.HCLCODE I ON C.GROUPID = I.MINORCD AND I.MAJORCD = '2051'                                           \n " );	 /*근무지*/    
					sql.append( " LEFT OUTER JOIN PAYROLL.PWRONPAY L ON  X.EMPNO = L.EMPNO     AND L.APLDAY ='"+str[1]+"25' \n " );
														  													   
					if (!str[7].equals("")&&!str[7].equals("0")) sql.append( " WHERE A.EMPNMK= '"  + str[7] + "' \n " ); //성명
				
					//sql.append( " ORDER BY I.SEQ, D.SEQ, PAYSEQNM DESC, A.EMPNO \n " ); /*지급구분*/
					//sql.append( " ORDER BY I.SEQ, SEQ2, INTEGER(X.PAYSEQ) DESC, PAYSEQNM DESC, A.EMPNO \n " ); /*지급구분*/

          sql.append( " ORDER BY SEQ, SEQ2, INTEGER(X.PAYSEQ) DESC, PAYSEQNM DESC, A.EMPNO \n " ); /*지급구분*/

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