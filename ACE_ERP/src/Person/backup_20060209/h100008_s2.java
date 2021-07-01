//CREATE TABLE PBPAY (			
//EMPNO	CHAR(7) 	NOT NULL,	/* 사번 */
//APPDT	CHAR(6)	NOT NULL,	/* 년월 */
//PAYDIV	CHAR(1)	NOT NULL,	/* 급여구분*/
//PAYDT	CHAR(8)	NOT NULL,	/* 지급일*/
//PAYGBN	VARCHAR(4)	,	/* 연호봉구분 */
//PAYGRD	VARCHAR(4)	,	/* 직위코드*/
//PAYSEQ	VARCHAR(4)	,	/* 호봉코드 */
//JOBGRPH	VARCHAR(4) 	,	/* 직군코드 */
//GRDDIV	VARCHAR(4)	,	/* 직급코드 */
//DEPTCD	CHAR(4)	,	/* 부서코드*/
//PAYBNK	CHAR(4)	,	/* 은행코드*/
//PAYNUM	VARCHAR(25)	,	/* 계좌번호*/
//DUYNOT	NUMERIC(2,0)	DEFAULT 0,	/* 무계결근일수*/
//NOTWRK	NUMERIC(2,0)	DEFAULT 0,	/* 휴직일수 */
//P10000	NUMERIC(9,0)	DEFAULT 0,	/* 기본급여*/
//P11000	NUMERIC(9,0)	DEFAULT 0,	/* 직책수당 */
//P12000	NUMERIC(9,0)	DEFAULT 0,	/* 시간외수당 */
//P21000	NUMERIC(9,0)	DEFAULT 0,	/* 근속수당*/
//P22000	NUMERIC(9,0)	DEFAULT 0,	/* 자기계발비 */
//P23001	NUMERIC(9,0)	DEFAULT 0,	/* 부양가족*/
//P23000	NUMERIC(9,0)	DEFAULT 0,	/* 부양가족수당*/
//P24000	NUMERIC(9,0)	DEFAULT 0,	/* 차량유지비 */
//P25000	NUMERIC(9,0)	DEFAULT 0,	/* 출납수당*/
//P26000	NUMERIC(9,0)	DEFAULT 0,	/* 운전수당*/
//P27000	NUMERIC(9,0)	DEFAULT 0,	/* 연장수당*/
//P28000	NUMERIC(9,0)	DEFAULT 0,	/* 자격수당*/
//P29000	NUMERIC(9,0)	DEFAULT 0,	/* 남북경협수당*/
//P30000	NUMERIC(9,0)	DEFAULT 0,	/* 사장단수당*/
//P31000	NUMERIC(9,0)	DEFAULT 0,	/* 특수지수당*/
//P32000	NUMERIC(9,0)	DEFAULT 0,	/* 지역근무수당*/
//P33001	NUMERIC(9,0)	DEFAULT 0,	/* 월차일수  */
//P33000	NUMERIC(9,0)	DEFAULT 0,	/* 월차수당*/
//P34001	NUMERIC(9,0)	DEFAULT 0,	/* 연차일수*/
//P34000	NUMERIC(9,0)	DEFAULT 0,	/* 연차수당*/
//P35000	NUMERIC(9,0)	DEFAULT 0,	/* 상여금*/
//P36000	NUMERIC(9,0)	DEFAULT 0,	/* 학비보조금*/
//P37000	NUMERIC(9,0)	DEFAULT 0,	/* 개인연금보조금*/
//P38000	NUMERIC(9,0)	DEFAULT 0,	/* 임원직책수당*/
//P39000	NUMERIC(9,0)	DEFAULT 0,	/* 전월소급*/
//PX0010	NUMERIC(9,0)	DEFAULT 0,	/* 기타지급1*/
//PX0020	NUMERIC(9,0)	DEFAULT 0,	/* 기타지급2*/
//PX0030	NUMERIC(9,0)	DEFAULT 0,	/* 기타지급3*/
//PX0040	NUMERIC(9,0)	DEFAULT 0,	/* 기타지급4*/
//P41000	NUMERIC(9,0)	DEFAULT 0,	/* 정산건강보험*/
//P42000	NUMERIC(9,0)	DEFAULT 0,	/* 정산고용보험*/
//T21000	NUMERIC(9,0)	DEFAULT 0,	/* 정산소득세*/
//T22000	NUMERIC(9,0)	DEFAULT 0,	/* 정산주민세*/
//T23000	NUMERIC(9,0)	DEFAULT 0,	/* 정산농특세*/
//S91000	NUMERIC(9,0)	DEFAULT 0,	/* 지급합계*/
//S92000	NUMERIC(9,0)	DEFAULT 0,	/* 소득합계*/
//T11000	NUMERIC(9,0)	DEFAULT 0,	/* 소득세*/
//T12000	NUMERIC(9,0)	DEFAULT 0,	/* 주민세*/
//B11000	NUMERIC(9,0)	DEFAULT 0,	/* 건강보험료*/
//B12000	NUMERIC(9,0)	DEFAULT 0,	/* 국민연금*/
//B13000	NUMERIC(9,0)	DEFAULT 0,	/* 고용보험*/
//B14000	NUMERIC(9,0)	DEFAULT 0,	/* 여직원회비*/
//B15000	NUMERIC(9,0)	DEFAULT 0,	/* 개인연금*/
//B16000	NUMERIC(9,0)	DEFAULT 0,	/* 공조회비*/
//BX0010	NUMERIC(9,0)	DEFAULT 0,	/* 기타공제1*/
//BX0020	NUMERIC(9,0)	DEFAULT 0,	/* 기타공제2*/
//BX0030	NUMERIC(9,0)	DEFAULT 0,	/* 기타공제3*/
//BX0040	NUMERIC(9,0)	DEFAULT 0,	/* 기타공제4*/
//T31000	NUMERIC(9,0)	DEFAULT 0,	/* 추징소득세*/
//T33000	NUMERIC(9,0)	DEFAULT 0,	/* 추징주민세*/
//T92000	NUMERIC(9,0)	DEFAULT 0,	/* 퇴직전환금*/
//S93000	NUMERIC(9,0)	DEFAULT 0,	/* 공제합계*/
//S94000	NUMERIC(9,0)	DEFAULT 0,	/* 실지급액*/
//STRTDT	CHAR(8)	,	/* 입사일 */
//CHAGDT	CHAR(8)	,	/* 최종변동일 */
//DUYEAR	NUMERIC(2,0)	DEFAULT 0,	/* 근무년수*/
//DUYMM	NUMERIC(2,0)	DEFAULT 0,	/* 근무월수*/
//DUDAY	NUMERIC(2,0)	DEFAULT 0,	/* 근무일수*/
//BSDAY	NUMERIC(2,0)	DEFAULT 0,	/* 본사근무일수*/
//HJDAY	NUMERIC(2,0)	DEFAULT 0,	/* 현장근무일수*/
//NSDAY	NUMERIC(2,0)	DEFAULT 0,	/* 해외근무일수*/
///* Primary key Define */			
////       CONSTRAINT PBPAYPK PRIMARY KEY (EMPNO, APPDT, PAYDIV, PAYDT)); 			



package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.//년간월별소득현황
public class h100008_s2 extends HttpServlet {

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
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{

				"DEPTNM",	/*  부서명*/
				"TREECD",	/*  부서명*/
				"EMPNO",	   /* 사번 */
				"EMPNMK",       /*한글명*/
				
				"PAYGRDNM", /*  직위명*/
				"JOBGRPHNM",	/*  직군명*/	
				"PAYSEQNM", /*  호봉명*/
				"GRDDIVNM", /*  직급명*/

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
				//"P35000",	/* 상여금*/
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
				"P23006"	 /* 경로*/    

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
					//9,	/* 상여금*/
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
					2	  /* 경로*/  
             

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
					//0,	/* 상여금*/
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
					0 		/* 경로*/    
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
					sql.append("\n").append( "  RTRIM(C.DEPTNM) AS DEPTNM, ");	/* 부서명*/
					sql.append("\n").append( "  C.TREECD, ");	   /* 트리시디 */
					sql.append("\n").append( "  A.EMPNO, ");	   /* 사번 */
					sql.append("\n").append( "  A.EMPNMK, ");       /*한글명*/

					sql.append("\n").append( "  RTRIM(D.MINORNM) AS PAYGRDNM, ");	/*  직위명*/
					sql.append("\n").append( "  RTRIM(F.MINORNM) AS JOBGRPHNM,  ");	/*  직군명*/	
					sql.append("\n").append( "  RTRIM(G.MINORNM) AS PAYSEQNM,  ");	/*  호봉명*/
					sql.append("\n").append( "  RTRIM(H.MINORNM) AS GRDDIVNM,  ");	/*  직급명*/
					
					sql.append("\n").append( "  B.P10000,  ");	/* 기본급여*/
					sql.append("\n").append( "  B.P11000,  ");	/* 직책수당 */
					sql.append("\n").append( "  B.P12000,  ");	/* 시간외수당 */
					sql.append("\n").append( "  B.P21000,  ");	/* 근속수당*/
					sql.append("\n").append( "  B.P22000,  ");	/* 자기계발비 */
					sql.append("\n").append( "  B.P23001,  ");	/* 부양가족*/
					sql.append("\n").append( "  B.P23000,  ");	/* 부양가족수당*/
					sql.append("\n").append( "  B.P24000,  ");	/* 차량유지비 */
					sql.append("\n").append( "  B.P25000,  ");	/* 출납수당*/
					sql.append("\n").append( "  B.P26000,  ");	/* 운전수당*/
					sql.append("\n").append( "  B.P27000,  ");	/* 연장수당*/
					sql.append("\n").append( "  B.P28000,  ");	/* 자격수당*/
					sql.append("\n").append( "  B.P29000,  ");	/* 남북경협수당*/
					sql.append("\n").append( "  B.P30000,  ");	/* 사장단수당*/
					sql.append("\n").append( "  B.P31000,  ");	/* 특수지수당*/
					sql.append("\n").append( "  B.P32000,  ");	/* 지역근무수당*/
					sql.append("\n").append( "  B.P33001, ");	/* 월차일수  */
					sql.append("\n").append( "  B.P33000,  ");	/* 월차수당*/
					sql.append("\n").append( "  B.P34001,  ");	/* 연차일수*/
					sql.append("\n").append( "  B.P34000,  ");	/* 연차수당*/
					sql.append("\n").append( "  --B.P35000, \n ");	/* 상여금*/
					sql.append("\n").append( "  B.P36000,  ");	/* 학비보조금*/
					sql.append("\n").append( "  B.P37000,  ");	/* 개인연금보조금*/
					sql.append("\n").append( "  B.P38000,  ");	/* 임원직책수당*/
					sql.append("\n").append( "  B.P39000,  ");	/* 전월소급*/
					sql.append("\n").append( "  B.PX0010,  ");	/* 기타지급1*/
					sql.append("\n").append( "  B.PX0020,  ");	/* 기타지급2*/
					sql.append("\n").append( "  B.PX0030,  ");	/* 기타지급3*/
					sql.append("\n").append( "  B.PX0040,  ");	/* 기타지급4*/
					sql.append("\n").append( "  B.P41000,  ");	/* 정산건강보험*/
					sql.append("\n").append( "  B.P42000,  ");	/* 정산고용보험*/
					sql.append("\n").append( "  B.T21000,  ");	/* 정산소득세*/
					sql.append("\n").append( "  B.T22000,  ");	/* 정산주민세*/
					sql.append("\n").append( "  B.T23000,  ");	/* 정산농특세*/
					sql.append("\n").append( "  B.S91000,  ");	/* 지급합계*/
					sql.append("\n").append( "  B.S92000,  ");	/* 소득합계*/
					sql.append("\n").append( "  B.T11000,  ");	/* 소득세*/
					sql.append("\n").append( "  B.T12000,  ");	/* 주민세*/
					sql.append("\n").append( "  B.B11000,  ");	/* 건강보험료*/
					sql.append("\n").append( "  B.B12000,  ");	/* 국민연금*/
					sql.append("\n").append( "  B.B13000,  ");	/* 고용보험*/
					sql.append("\n").append( "  B.B14000,  ");	/* 여직원회비*/
					sql.append("\n").append( "  B.B15000,  ");	/* 개인연금*/
					sql.append("\n").append( "  B.B16000,  ");	/* 공조회비*/
					sql.append("\n").append( "  B.BX0010,  ");	/* 기타공제1*/
					sql.append("\n").append( "  B.BX0020,  ");	/* 기타공제2*/
					sql.append("\n").append( "  B.BX0030,  ");	/* 기타공제3*/
					sql.append("\n").append( "  B.BX0040,  ");	/* 기타공제4*/
					sql.append("\n").append( "  --B.T31000,  ");	/* 추징소득세*/
					sql.append("\n").append( "  --B.T33000,  ");	/* 추징주민세*/
					sql.append("\n").append( "  --B.T92000, \n  ");	/* 퇴직전환금*/
					sql.append("\n").append( "  B.S93000,  ");	/* 공제합계*/
					sql.append("\n").append( "  B.S94000,  ");	/* 실지급액*/
					sql.append("\n").append( "  RTRIM(B.STRTDT) AS STRTDT,  "); /* 입사일 */
					sql.append("\n").append( "  RTRIM(A.GRSTRTDT) AS GRSTRTDT,   ");	/* 그룹입사일*/
					sql.append("\n").append( "  A.TRAINYN,  "); /* 수습적용여부 */
					sql.append("\n").append( "  B.CHAGDT AS CHAGDT,   ");	/* 최종변동일*/
					sql.append("\n").append( "  '0'  AS SENUM,  ");	/* 배부자장경*/
					sql.append("\n").append( "  B.P23002, ");	/* 배우자*/
					sql.append("\n").append( "  B.P23003,  ");	/* 부모*/
					sql.append("\n").append( "  B.P23004, ");	/* 자녀*/
					sql.append("\n").append( "  B.P23005,  ");	/* 장애*/
					sql.append("\n").append( "  B.P23006 ");	/* 경로*/		
					sql.append("\n").append( " from PAYROLL.T_PBPAY B ");
					sql.append("\n").append( " LEFT JOIN PAYROLL.T_HIPERSON A ON A.EMPNO=B.EMPNO ");
					sql.append("\n").append( " LEFT JOIN PAYROLL.HCDEPT C ON B.DEPTCD=C.DEPTCD ");
					sql.append("\n").append( " LEFT JOIN PAYROLL.HCLCODE D ON B.PAYGRD = D.MINORCD AND D.MAJORCD = '2002' "); /*직위*/
					sql.append("\n").append( " LEFT JOIN PAYROLL.HCLCODE F ON B.JOBGRPH = F.MINORCD AND F.MAJORCD = '2000' "); /*직군*/
					sql.append("\n").append( " LEFT JOIN PAYROLL.HCLCODE G ON B.PAYSEQ = G.MINORCD AND G.MAJORCD = '1184' "); /*호봉*/
					sql.append("\n").append( " LEFT JOIN PAYROLL.HCLCODE H ON B.GRDDIV = H.MINORCD AND H.MAJORCD = '2001' "); /*직급*/
					sql.append("\n").append( " WHERE B.EMPNO <> ' ' ");

					if (!str[0].equals("")&&!str[0].equals("0") )
						sql.append("\n").append( " AND B.PAYDT = '"  + str[0] + "' ");    //지급일자부터까지
					if (!str[1].equals("")&&!str[1].equals("0")) sql.append("\n").append( " AND B.APPDT= '"  + str[1] + "' ");   //적용년월
					if (!str[2].equals("")&&!str[2].equals("0")) sql.append("\n").append( " AND B.PAYDIV = '" + str[2]+ "' ");   //지급구분
					if (!str[3].equals("")&&!str[3].equals("0")) sql.append("\n").append( " AND B.DEPTCD = '" + str[3]+ "' ");   //부서
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append("\n").append( " AND B.JOBGRPH= '"  + str[3] + "' "); //직군
					if (!str[5].equals("")&&!str[5].equals("0") && (!str[6].equals("")&&!str[6].equals("0")) )
						sql.append("\n").append( " AND B.EMPNO BETWEEN '"  + str[5] + "' AND '"  + str[6] + "' ");              //사원번호부터 까지
												  													   
					if (!str[7].equals("")&&!str[7].equals("0")) sql.append("\n").append( " AND A.EMPNMK= '"  + str[7] + "' "); //성명
					if (!str[8].equals("")&&!str[8].equals("0")) sql.append("\n").append( " AND B.PAYGRD = '" + str[8]+ "' ");  // 직위
					if (!str[9].equals("")&&!str[9].equals("0")) sql.append("\n").append( " AND B.GRDDIV = '" + str[9]+ "' ");  // 직급
					sql.append("\n").append( "  ORDER BY C.TREECD,SUBSTR(B.PAYDT,1,6),B.EMPNO "); /*지급구분*/
					
/*********************************************************************************************/
          logger.dbg.println(this,sql.toString());
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