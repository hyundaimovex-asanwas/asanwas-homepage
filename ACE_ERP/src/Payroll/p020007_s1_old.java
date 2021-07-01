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
public class p020007_s1 extends HttpServlet {

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
	실제 업무에서 적용하실 부분 - 급여변동내역 조회
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				String [] str = new String [10];
				str[0]	= req.getParameter("v_str1");		//지급일자
				str[1]	= req.getParameter("v_str2");		//이전적용년월
				str[2]	= req.getParameter("v_str3");		//현재적용년월
				str[3]	= req.getParameter("v_str4");		//지급구분
				str[4]	= req.getParameter("v_str5");		//부서
				str[5]	= req.getParameter("v_str6");		//직군

				for (int s=0;s<6;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
        
        "PAYGRD",			/* 직위*/
				"GUBUN",			/* 구분*/
				"SEQ",				/* 순서*/
				"PAYGRDNM",		/* 직위명*/
				"PRVNUM",			/* 이전월 총인원 */
				"PRVAMT",			/* 이전월 전체 총 실급여*/
				"NEXNUM",			/* 현재월 총인원*/
				"NEXAMT",			/* 현재월 전체 총 실급여 */
			  "IBSANUM",		/* 현재적용년월 입사인원*/	
			  "IBSAAMT",		/* 현재적용년월 입사 총 실급여*/
				"TAENUM",			/* 현재적용년월 퇴사사인원 */
				"TAEAMT",			/* 현재적용년월 퇴사사 총 실급여*/
			  "SUNGNUM",		/* 현재적용년월 승진인원*/
			  "SUNGAMT",		/* 현재적용년월 승진자 총 실급여*/
				"ITSNUM",			/* 현재적용년월 입,퇴,승진자 총 실급여*/
				"ITSAMT",			/* 현재적용년월 입,퇴,승진자 총 실급여*/	
				"A1_AMT",			/* --기본급 증감 금액  */
				"A2_AMT",			/* --직책수당 증감 금액 */
				"A3_AMT",			/* --시간외 증감 금액  */
				"A4_AMT",			/* --근속수당 증감 금액 */
				"A5_AMT",			/* --자기계발비 증감 금액 */
				"A6_AMT",			/* --가족부양비 증감 금액 */	
				"A7_AMT",			/* --차량유지비 증감 금액 */
				"A8_AMT",			/* --자격수당 증감 금액  */
				"A9_AMT",			/* --개인연금 증감 금액 */
				"A10_AMT",		/* 남북경헙 증감 금액  */
				"A11_AMT",		/* 특수지 수당 증감 금액 */
				"A12_AMT",		/* 지역근무수당 증감 금액 */	
				"A13_AMT",		/* 휴일근무수당 증감 금액 -협의필요*/
				"A14_AMT",		/* 전월소급 증감 금액 */
				"A15_AMT",		/* 임원직책 증감 금액 */	
				"A16_AMT",		/* 학자금 증감 금액  */	
				"A17_AMT",		/* 출납수당*/	
				"A18_AMT",		/*운전수당*/	
				"A19_AMT",		/*연장수당*/	
				"A20_AMT",		/*사장단수당 */	
				"A21_AMT",		/*연차수당*/	
				"A22_AMT",		/*식대보조*/	
				"A23_AMT",		/*기타지급1 */	
				"A24_AMT",		/*기타지급2 */	
				"A25_AMT", 		/*기타지급3 */	
			  "AA_AMT"	    /* 지급 총합 증감 금액*/	
				};

				int[] intArrCN = new int[]{  
					4,
					5,
          3,
					30,	
					9,	/* 이전월 총인원 */
					9,   /* 이전월 전체 총 실급여*/
					9,	/* 현재월 총인원*/
					9,	/* 현재월 전체 총 실급여 */
					9,	/* 현재적용년월 입사인원*/	
					9,	/* 현재적용년월 입사 총 실급여*/
					9,	/* 현재적용년월 퇴사사인원 */
					9,   /* 현재적용년월 퇴사사 총 실급여*/
					9,	/* 현재적용년월 승진인원*/
					9,	/* 현재적용년월 승진자 총 실급여*/
					9,	/* 현재적용년월 입,퇴,승진자 총 실급여*/
					9,	/* 현재적용년월 입,퇴,승진자 총 실급여*/	
					9,	/* --기본급 증감 금액  */
					9,	/* --직책수당 증감 금액 */
					9,   /* --시간외 증감 금액  */
					9,	/* --근속수당 증감 금액 */
					9,	/* --자기계발비 증감 금액 */
					9,	/* --가족부양비 증감 금액 */	
					9,	/* --차량유지비 증감 금액 */
					9,	/* --자격수당 증감 금액*/
					9,   /* --개인연금 증감 금액*/
					9,	/* 남북경헙 증감 금액*/
					9,	/* 특수지 수당 증감 금액*/
					9,	/* 지역근무수당 증감 금액*/	
					9,	/* 휴일근무수당 증감 금액 -협의필요*/
					9,	/* 전월소급 증감 금액*/
					9,	/* 임원직책 증감 금액*/	
					9,	/* 학자금 증감 금액*/	
					9, /* 출납수당*/	   						  
					9, /*운전수당*/	   
					9, /*연장수당*/	   
					9, /*사장단수당 */	
					9, /*연차수당*/	   
					9, /*식대보조*/	   
					9, /*기타지급1 */	 
					9, /*기타지급2 */	 
					9, /*기타지급3 */	 
					9  /* 지급 총합 증감 금액*/	            
				}; 

				int[] intArrCN2 = new int[]{
					-1,
					-1,
					0,
					-1,
					0,	/* 이전월 총인원 */
					0,   /* 이전월 전체 총 실급여*/
					0,	/* 현재월 총인원*/
					0,	/* 현재월 전체 총 실급여 */
					0,	/* 현재적용년월 입사인원*/	
					0,	/* 현재적용년월 입사 총 실급여*/
					0,	/* 현재적용년월 퇴사사인원 */
					0,   /* 현재적용년월 퇴사사 총 실급여*/
					0,	/* 현재적용년월 승진인원*/
					0,	/* 현재적용년월 승진자 총 실급여*/
					0,	/* 현재적용년월 입,퇴,승진자 총 실급여*/
					0,	/* 현재적용년월 입,퇴,승진자 총 실급여*/	
					0,	/* --기본급 증감 금액  */
					0,	/* --직책수당 증감 금액 */
					0,   /* --시간외 증감 금액  */
					0,	/* --근속수당 증감 금액 */
					0,	/* --자기계발비 증감 금액 */
					0,	/* --가족부양비 증감 금액 */	
					0,	/* --차량유지비 증감 금액 */
					0,	/* --자격수당 증감 금액  */
					0,   /* --개인연금 증감 금액  */
					0,	/* 남북경헙 증감 금액*/
					0,	/* 특수지 수당 증감 금액*/
					0,	/* 지역근무수당 증감 금액*/	
					0,	/* 휴일근무수당 증감 금액 -협의필요*/
					0,	/* 전월소급 증감 금액*/
					0,	/* 임원직책 증감 금액*/	
					0,	/* 학자금 증감 금액*/	
	        0,	 /* 출납수당*/	   						   
					0,   /*운전수당*/	                   
					0,	 /*연장수당*/	                   
					0,	 /*사장단수당 */	               
					0,	 /*연차수당*/	                   
					0,	 /*식대보조*/	                   
					0,	 /*기타지급1 */	               
					0,	 /*기타지급2 */	               
					0,	 /*기타지급3 */	               
					0    /* 지급 총합 증감 금액*/	
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 
			
					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT X.PAYGRD,X.GUBUN,K.MINORNM AS PAYGRDNM,K.SEQ,																				\n");
						sql.append( "        SUM(X.CNT1)PRVNUM, SUM(X.SUM1)PRVAMT,  --이전월																			\n");
						sql.append( "        SUM(X.CNT2)NEXNUM, SUM(X.SUM2)NEXAMT,  --현재월																			\n");
						sql.append( "        SUM(CNT3)+SUM(CNT6) IBSANUM ,SUM(SUM3)+SUM(SUM6) IBSAAMT,   --입사																				\n");
						sql.append( "        SUM(CNT4) TAENUM , SUM(SUM4)TAEAMT,    --퇴사																				\n");
						sql.append( "        SUM(CNT5) SUNGNUM ,SUM(SUM5)SUNGAMT,   --승진																				\n");
						sql.append( "        SUM(CNT3)+ SUM(CNT4)+SUM(CNT5)+SUM(CNT6) ITSNUM, --입사+퇴사+승진 총 인원수										\n");
						sql.append( "        SUM(SUM3)+ SUM(SUM4)+SUM(SUM5)+SUM(SUM6) ITSAMT, --입사+퇴사+승진+소급 총 금액 			\n");
						sql.append( "        (SUM(A1)-SUM(B1))A1_AMT,                --기본급																			\n");
						sql.append( "        (SUM(A2)-SUM(B2))A2_AMT,                --직책																				\n");
						sql.append( "        (SUM(A3)-SUM(B3))A3_AMT,                --시간외																			\n");
						sql.append( "        (SUM(A4)-SUM(B4))A4_AMT,                --근속수당																		\n");
						sql.append( "        (SUM(A5)-SUM(B5))A5_AMT,                --자기 계발비																\n");
						sql.append( "        (SUM(A6)-SUM(B6))A6_AMT,                --가족 부양비																\n");
						sql.append( "        (SUM(A7)-SUM(B7))A7_AMT,                --차량 유지비																\n");
						sql.append( "        (SUM(A8)-SUM(B8))A8_AMT,                --자격수당																		\n");
						sql.append( "        (SUM(A9)-SUM(B9))A9_AMT,                --개인연금																		\n");
						sql.append( "        (SUM(A10)-SUM(B10))A10_AMT,             --남북경협																		\n");
						sql.append( "        (SUM(A11)-SUM(B11))A11_AMT,             --특수지수당																	\n");
						sql.append( "        (SUM(A12)-SUM(B12))A12_AMT,             --지역근무수당																\n");
						sql.append( "        (SUM(A13)-SUM(B13))A13_AMT,             --휴일수당																		\n");
						sql.append( "        (SUM(A14)-SUM(B14))A14_AMT,             --전월소급																		\n");
						sql.append( "        (SUM(A15)-SUM(B15))A15_AMT,             --임원직책수당																\n");
						sql.append( "        (SUM(A16)-SUM(B16))A16_AMT,             --학비보조금																	\n");
						sql.append( "        (SUM(A17)-SUM(B17))A17_AMT,             --출납수당																		\n");
						sql.append( "        (SUM(A18)-SUM(B18))A18_AMT,             --운전수당																		\n");
						sql.append( "        (SUM(A19)-SUM(B19))A19_AMT,             --연장수당																		\n");
						sql.append( "        (SUM(A20)-SUM(B20))A20_AMT,             --사장단수당																	\n");
						sql.append( "        (SUM(A21)-SUM(B21))A21_AMT,             --연차일수																		\n");
						sql.append( "        (SUM(A22)-SUM(B22))A22_AMT,             --식대보조금																	\n");
						sql.append( "        (SUM(A23)-SUM(B23))A23_AMT,             --기타지급1																	\n");
						sql.append( "        (SUM(A24)-SUM(B24))A24_AMT,             --기타지급2																	\n");
						sql.append( "        (SUM(A25)-SUM(B25))A25_AMT,             --기타지급3																	\n");
						sql.append( "        ((SUM(A1)-SUM(B1))+ (SUM(A2)-SUM(B2))+(SUM(A3)-SUM(B3))+															\n");
						sql.append( "        (SUM(A4)-SUM(B4))+ (SUM(A5)-SUM(B5))+(SUM(A6)-SUM(B6))+															\n");
						sql.append( "        (SUM(A7)-SUM(B7))+ (SUM(A8)-SUM(B8))+(SUM(A9)-SUM(B9))+															\n");
						sql.append( "        (SUM(A10)-SUM(B10))+(SUM(A11)-SUM(B11))+(SUM(A12)-SUM(B12))+													\n");
						sql.append( "        (SUM(A13)-SUM(B13))+(SUM(A14)-SUM(B14))+(SUM(A15)-SUM(B15))+													\n");
						sql.append( "        (SUM(A16)-SUM(B16))+(SUM(A17)-SUM(B17))+(SUM(A18)-SUM(B18))+													\n");
						sql.append( "        (SUM(A19)-SUM(B19))+(SUM(A20)-SUM(B20))+(SUM(A21)-SUM(B21))+													\n");
						sql.append( "        (SUM(A22)-SUM(B22))+(SUM(A23)-SUM(B23))+(SUM(A24)-SUM(B24))+													\n");
						sql.append( "        (SUM(A25)-SUM(B25))) AA_AMT             																							\n");
						sql.append( " FROM(																																												\n");
						sql.append( " --이전월																																										\n");
						sql.append( "        SELECT P.PAYGRD,P.GUBUN,COUNT(P.EMPNO) CNT1, SUM(P.PRES91)SUM1,											\n");
						sql.append( "             SUM(P.P10000)A1,    --기본급여																									\n");
						sql.append( "             SUM(P.P11000)A2,    --직책수당																									\n");
						sql.append( "             SUM(P.P12000)A3,    --시간외수당																								\n");
						sql.append( "             SUM(P.P21000)A4,    --근속수당																									\n");
						sql.append( "             SUM(P.P22000)A5,    --자기계발비																								\n");

						sql.append( "             SUM(P.P23000)A6,    --부양가족																									\n");
						sql.append( "             SUM(P.P24000)A7,    --차량유지비																								\n");
						sql.append( "             SUM(P.P28000)A8,    --자격수당																									\n");
						sql.append( "             SUM(P.P37000)A9,    --개인연금보조금																						\n");
						sql.append( "             SUM(P.P29000)A10,   --남북경협수당																							\n");

						sql.append( "             SUM(P.P31000)A11,   --특수지수당																								\n");
						sql.append( "             SUM(P.P32000)A12,   --지역근무수당																							\n");
						sql.append( "             SUM(P.PX0010)A13,   --휴일수당																									\n");
						sql.append( "             SUM(P.P39000)A14,   --전월소급																									\n");
						sql.append( "             SUM(P.P38000)A15,   --임원직책수당																							\n");

						sql.append( "             SUM(P.P36000)A16,   --학비보조금																								\n");
						sql.append( "             SUM(P.P25000)A17,   --출납수당																									\n");
						sql.append( "             SUM(P.P26000)A18,   --운전수당																									\n");
						sql.append( "             SUM(P.P27000)A19,   --연장수당																									\n");
						sql.append( "             SUM(P.P30000)A20,   --사장단수당																								\n");

						sql.append( "             SUM(P.P34000)A21,   --연차일수																									\n");
						sql.append( "             SUM(P.P35000)A22,   --식대보조금																								\n");
						sql.append( "             SUM(P.PX0020)A23,   --기타지급1																									\n");
						sql.append( "             SUM(P.PX0030)A24,   --기타지급2																									\n");
						sql.append( "             SUM(P.PX0040)A25,   --기타지급3																									\n");

						sql.append( "             0 AS CNT2,0 AS SUM2,																														\n");
						sql.append( "             0 B1,0 B2,0 B3,0 B4,0 B5,																												\n");
						sql.append( "             0 B6,0 B7,0 B8,0 B9,0 B10,																											\n");		
						sql.append( "             0 B11,0 B12,0 B13,0 B14,0 B15,																									\n");
						sql.append( "             0 B16,0 B17,0 B18,0 B19,0 B20,																									\n");
						sql.append( "             0 B21,0 B22,0 B23,0 B24,0 B25,																									\n");
						sql.append( "             0 CNT3,0 SUM3,0 CNT4,0 SUM4, 0 CNT5,0 SUM5,0 CNT6,0 SUM6																			\n");
						sql.append( "        FROM (																																								\n");
						sql.append( "             SELECT																																					\n");
						sql.append( "                   CASE WHEN (A.PAYGRD >='140' AND A.PAYGRD <='150') THEN '140'							\n");
						sql.append( "                        WHEN (A.PAYGRD >='180' AND A.PAYGRD <='190') THEN '180'							\n");
						sql.append( "                        WHEN (A.PAYGRD >='200' AND A.PAYGRD <='210'  OR A.PAYGRD ='400') THEN '200' \n");
						sql.append( "                        WHEN (A.PAYGRD >='220' AND A.PAYGRD <='230') THEN '220'							\n");
						sql.append( "                        WHEN (A.PAYGRD >='240' AND A.PAYGRD <='250') THEN '240'							\n");
						sql.append( "                        WHEN (A.PAYGRD >='260' AND A.PAYGRD <='270') THEN '260'							\n");
						sql.append( "                        WHEN (A.PAYGRD >='280' AND A.PAYGRD <='290') THEN '280'							\n");
						sql.append( "                        ELSE A.PAYGRD END PAYGRD,																						\n");

						sql.append( "                   CASE WHEN (A.PAYGRD >='220' AND A.PAYGRD <='230' AND C.SEX='1') THEN C.SEX			\n");
						sql.append( "                        WHEN (A.PAYGRD >='220' AND A.PAYGRD <='230' AND C.SEX='2') THEN C.SEX			\n");
						sql.append( "                        WHEN (A.PAYGRD >='240' AND A.PAYGRD <='250' AND C.SEX='1') THEN C.SEX			\n");
						sql.append( "                        WHEN (A.PAYGRD >='240' AND A.PAYGRD <='250' AND C.SEX='2') THEN C.SEX			\n");
						sql.append( "                        WHEN (A.PAYGRD >='260' AND A.PAYGRD <='270' AND C.SEX='1') THEN C.SEX			\n");
						sql.append( "                        WHEN (A.PAYGRD >='260' AND A.PAYGRD <='270' AND C.SEX='2') THEN C.SEX			\n");
						sql.append( "                        WHEN (A.PAYGRD >='280' AND A.PAYGRD <='290' AND C.SEX='1') THEN C.SEX			\n");
						sql.append( "                        WHEN (A.PAYGRD >='280' AND A.PAYGRD <='290' AND C.SEX='2') THEN C.SEX			\n");
						sql.append( "                        ELSE (CASE WHEN (A.PAYGRD >='140' AND A.PAYGRD <='150') THEN '140'					\n");
						sql.append( "                                   WHEN (A.PAYGRD >='180' AND A.PAYGRD <='190') THEN '180'					\n");
						sql.append( "                                   WHEN (A.PAYGRD >='200' AND A.PAYGRD <='210'  OR A.PAYGRD ='400') THEN '200'	\n");
						sql.append( "                                   WHEN (A.PAYGRD >='220' AND A.PAYGRD <='230') THEN '220'					\n");
						sql.append( "                                   WHEN (A.PAYGRD >='240' AND A.PAYGRD <='250') THEN '240'					\n");
						sql.append( "                                   WHEN (A.PAYGRD >='260' AND A.PAYGRD <='270') THEN '260'					\n");
						sql.append( "                                   WHEN (A.PAYGRD >='280' AND A.PAYGRD <='290') THEN '280'					\n");
						sql.append( "                                   ELSE A.PAYGRD END)																							\n");
						sql.append( "                        END AS GUBUN,																															\n");
						sql.append( "                                   A.EMPNO,  A.S91000 AS PRES91,																		\n");
						sql.append( "                                   A.P10000, A.P11000,  A.P12000, A.P21000, A.P22000,							\n");
						sql.append( "                                   A.P23000, A.P24000,  A.P28000, A.P37000, A.P29000,							\n");
						sql.append( "                                   A.P31000, A.P32000,  A.PX0010, A.P39000, A.P38000,							\n");
						sql.append( "                                   A.P36000, A.P25000,  A.P26000, A.P27000, A.P30000,							\n");
						sql.append( "                                   A.P34000, A.P35000,  A.PX0020, A.PX0030, A.PX0040								\n");
						sql.append( "           FROM  PAYROLL.PBPAY A																																		\n");
						sql.append( "           LEFT  OUTER  JOIN PAYROLL.HIPERSON C ON  A.EMPNO = C.EMPNO															\n");
						sql.append( "           WHERE A.EMPNO <> ' '																																		\n");
						sql.append( "           AND A.APPDT ='" +str[1]+ "'																									\n");
						if (str[3].equals("1")) 
						sql.append( "           AND A.PAYDIV IN ('1','3','4')	 											\n");
						if (str[3].equals("5")) 
						sql.append( "           AND A.PAYDIV IN ('5')	 											\n");
						sql.append( "         )P																																												\n");
						sql.append( "           GROUP BY P.PAYGRD,P.GUBUN																																\n");
						sql.append( "           UNION ALL																																								\n");
						sql.append( " 																																																	\n");
						sql.append( " --현재월																																													\n");
						sql.append( "         SELECT N.PAYGRD,N.GUBUN,0 CNT1, 0 AS SUM1,																								\n");
						sql.append( "                0 A1,0 A2,0 A3,0 A4,0 A5,																													\n");
						sql.append( "                0 A6,0 A7,0 A8,0 A9,0 A10,																													\n");
						sql.append( "                0 A11,0 A12,0 A13,0 A14,0 A15,																											\n");
						sql.append( "                0 A16,0 A17,0 A18,0 A19,0 A20,																											\n");
						sql.append( "                0 A21,0 A22,0 A23,0 A24,0 A25,																											\n");
						sql.append( "                COUNT(N.EMPNO)CNT2, SUM(N.CURS91)SUM2,																							\n");
						sql.append( "                SUM(N.P10000) B1,   SUM(N.P11000) B2, SUM(N.P12000) B3,SUM(N.P21000) B4, SUM(N.P22000) B5,		\n");
						sql.append( "                SUM(N.P23000) B6,   SUM(N.P24000) B7, SUM(N.P28000) B8,SUM(N.P37000) B9, SUM(N.P29000) B10,	\n");
						sql.append( "                SUM(N.P31000) B11,  SUM(N.P32000) B12,SUM(N.PX0010)B13,SUM(N.P39000) B14,SUM(N.P38000) B15,	\n");
						sql.append( "                SUM(N.P36000) B16,  SUM(N.P25000) B17,SUM(N.P26000)B18,SUM(N.P27000) B19,SUM(N.P30000) B20,	\n");
						sql.append( "                SUM(N.P34000) B21,  SUM(N.P35000) B22,SUM(N.PX0020)B23,SUM(N.PX0030) B24,SUM(N.PX0040) B25,	\n");
						sql.append( "                0 CNT3,0 SUM3,0 CNT4,0 SUM4, 0 CNT5,0 SUM5,	0 CNT6,0 SUM6																\n");
						sql.append( "         FROM (																																						\n");
						sql.append( "               SELECT																																			\n");
						sql.append( "                     CASE WHEN (B.PAYGRD >='140' AND B.PAYGRD <='150') THEN '140'					\n");
						sql.append( "                          WHEN (B.PAYGRD >='180' AND B.PAYGRD <='190') THEN '180'					\n");
						sql.append( "                          WHEN (B.PAYGRD >='200' AND B.PAYGRD <='210' OR B.PAYGRD ='400') THEN '200'		\n");
						sql.append( "                          WHEN (B.PAYGRD >='220' AND B.PAYGRD <='230') THEN '220'					\n");
						sql.append( "                          WHEN (B.PAYGRD >='240' AND B.PAYGRD <='250') THEN '240'					\n");
						sql.append( "                          WHEN (B.PAYGRD >='260' AND B.PAYGRD <='270') THEN '260'					\n");
						sql.append( "                          WHEN (B.PAYGRD >='280' AND B.PAYGRD <='290') THEN '280'					\n");
						sql.append( "                          ELSE B.PAYGRD END PAYGRD,																				\n");

						sql.append( "                     CASE WHEN (B.PAYGRD >='220' AND B.PAYGRD <='230' AND C.SEX='1') THEN  C.SEX			\n");
						sql.append( "                          WHEN (B.PAYGRD >='220' AND B.PAYGRD <='230' AND C.SEX='2') THEN  C.SEX			\n");
						sql.append( "                          WHEN (B.PAYGRD >='240' AND B.PAYGRD <='250' AND C.SEX='1') THEN  C.SEX			\n");
						sql.append( "                          WHEN (B.PAYGRD >='240' AND B.PAYGRD <='250' AND C.SEX='2') THEN  C.SEX			\n");
						sql.append( "                          WHEN (B.PAYGRD >='260' AND B.PAYGRD <='270' AND C.SEX='1') THEN  C.SEX			\n");
						sql.append( "                          WHEN (B.PAYGRD >='260' AND B.PAYGRD <='270' AND C.SEX='2') THEN  C.SEX			\n");
						sql.append( "                          WHEN (B.PAYGRD >='280' AND B.PAYGRD <='290' AND C.SEX='1') THEN  C.SEX			\n");
						sql.append( "                          WHEN (B.PAYGRD >='280' AND B.PAYGRD <='290' AND C.SEX='2') THEN  C.SEX			\n");
						sql.append( "                          ELSE (CASE WHEN (B.PAYGRD >='140' AND B.PAYGRD <='150') THEN '140'					\n");
						sql.append( "                                     WHEN (B.PAYGRD >='180' AND B.PAYGRD <='190') THEN '180'					\n");
						sql.append( "                                     WHEN (B.PAYGRD >='200' AND B.PAYGRD <='210' OR B.PAYGRD ='400') THEN '200'	\n");
						sql.append( "                                     WHEN (B.PAYGRD >='220' AND B.PAYGRD <='230') THEN '220'					\n");
						sql.append( "                                     WHEN (B.PAYGRD >='240' AND B.PAYGRD <='250') THEN '240'					\n");
						sql.append( "                                     WHEN (B.PAYGRD >='260' AND B.PAYGRD <='270') THEN '260'					\n");
						sql.append( "                                     WHEN (B.PAYGRD >='280' AND B.PAYGRD <='290') THEN '280'					\n");
						sql.append( "                                     ELSE B.PAYGRD END)																							\n");
						sql.append( "                          END AS GUBUN,																															\n");
						sql.append( "                                     B.EMPNO,  B.S91000 AS CURS91,																		\n");
						sql.append( "                                     B.P10000, B.P11000,  B.P12000, B.P21000, B.P22000,							\n");
						sql.append( "                                     B.P23000, B.P24000,  B.P28000, B.P37000, B.P29000,							\n");
						sql.append( "                                     B.P31000, B.P32000,  B.PX0010, B.P39000, B.P38000,							\n");
						sql.append( "                                     B.P36000, B.P25000,  B.P26000, B.P27000, B.P30000,							\n");
						sql.append( "                                     B.P34000, B.P35000,  B.PX0020, B.PX0030, B.PX0040								\n");
						sql.append( "         from  PAYROLL.PBPAY B																																				\n");
						sql.append( "         LEFT OUTER  JOIN PAYROLL.HIPERSON C ON  B.EMPNO = C.EMPNO																		\n");
						sql.append( "         WHERE B.EMPNO <> ' '																																				\n");
						sql.append( "         AND B.APPDT = '" +str[2]+ "'												\n");
						if (str[3].equals("1")) 
						sql.append( "           AND B.PAYDIV IN ('1','3','4')	 										\n");
						if (str[3].equals("5")) 
						sql.append( "           AND B.PAYDIV IN ('5')	 											\n");	
						sql.append( "      )N																																															\n");
						sql.append( "         GROUP BY N.PAYGRD,N.GUBUN																																		\n");
						sql.append( " 																																																		\n");
						sql.append( " --입사																																															\n");
						sql.append( "     UNION ALL																																												\n");
						sql.append( "         SELECT Y.PAYGRD, Y.GUBUN, 0 CNT1, 0 SUM1,																										\n");
						sql.append( "                0 A1,0 A2,0 A3,0 A4,0 A5,																														\n");
						sql.append( "                0 A6,0 A7,0 A8,0 A9,0 A10,																														\n");
						sql.append( "                0 A11,0 A12,0 A13,0 A14,0 A15,																												\n");
						sql.append( "                0 A16,0 A17,0 A18,0 A19,0 A20,																												\n");
						sql.append( "                0 A21,0 A22,0 A23,0 A24,0 A25,																												\n");
						sql.append( "                0 AS CNT2,0 AS SUM2,																																	\n");
						sql.append( "                0 B1,0 B2,0 B3,0 B4,0 B5,																														\n");
						sql.append( "                0 B6,0 B7,0 B8,0 B9,0 B10,																														\n");
						sql.append( "                0 B11,0 B12,0 B13,0 B14,0 B15,																												\n");
						sql.append( "                0 B16,0 B17,0 B18,0 B19,0 B20,																												\n");
						sql.append( "                0 B21,0 B22,0 B23,0 B24,0 B25,																												\n");
						sql.append( "                COALESCE(COUNT(Y.EMPNO),0)CNT3, COALESCE(SUM(Y.S91000),0)SUM3,												\n");
						sql.append( "                0 CNT4,0 SUM4, 0 CNT5,0 SUM5,	0 CNT6,0 SUM6																														\n");
						sql.append( "         FROM																																												\n");
						sql.append( "       (																																															\n");
						sql.append( "         SELECT																																											\n");
						sql.append( "               CASE WHEN (C.PAYGRD >='140' AND C.PAYGRD <='150') THEN '140'													\n");
						sql.append( "                    WHEN (C.PAYGRD >='180' AND C.PAYGRD <='190') THEN '180'													\n");
						sql.append( "                    WHEN (C.PAYGRD >='200' AND C.PAYGRD <='210'  OR C.PAYGRD ='400') THEN '200'			\n");
						sql.append( "                    WHEN (C.PAYGRD >='220' AND C.PAYGRD <='230') THEN '220'													\n");
						sql.append( "                    WHEN (C.PAYGRD >='240' AND C.PAYGRD <='250') THEN '240'													\n");
						sql.append( "                    WHEN (C.PAYGRD >='260' AND C.PAYGRD <='270') THEN '260'													\n");
						sql.append( "                    WHEN (C.PAYGRD >='280' AND C.PAYGRD <='290') THEN '280'													\n");
						sql.append( "                    ELSE C.PAYGRD END PAYGRD,																												\n");

						sql.append( "               CASE WHEN (C.PAYGRD >='220' AND C.PAYGRD <='230' AND D.SEX='1') THEN D.SEX						\n");
						sql.append( "                    WHEN (C.PAYGRD >='220' AND C.PAYGRD <='230' AND D.SEX='2') THEN D.SEX						\n");
						sql.append( "                    WHEN (C.PAYGRD >='240' AND C.PAYGRD <='250' AND D.SEX='1') THEN D.SEX						\n");
						sql.append( "                    WHEN (C.PAYGRD >='240' AND C.PAYGRD <='250' AND D.SEX='2') THEN D.SEX						\n");
						sql.append( "                    WHEN (C.PAYGRD >='260' AND C.PAYGRD <='270' AND D.SEX='1') THEN D.SEX						\n");
						sql.append( "                    WHEN (C.PAYGRD >='260' AND C.PAYGRD <='270' AND D.SEX='2') THEN D.SEX						\n");
						sql.append( "                    WHEN (C.PAYGRD >='280' AND C.PAYGRD <='290' AND D.SEX='1') THEN D.SEX						\n");
						sql.append( "                    WHEN (C.PAYGRD >='280' AND C.PAYGRD <='290' AND D.SEX='2') THEN D.SEX						\n");
						sql.append( "                    ELSE (CASE WHEN (C.PAYGRD >='140' AND C.PAYGRD <='150') THEN '140'								\n");
						sql.append( "                               WHEN (C.PAYGRD >='180' AND C.PAYGRD <='190') THEN '180'								\n");
						sql.append( "                               WHEN (C.PAYGRD >='200' AND C.PAYGRD <='210'  OR C.PAYGRD ='400') THEN '200'		\n");
						sql.append( "                               WHEN (C.PAYGRD >='220' AND C.PAYGRD <='230') THEN '220'								\n");
						sql.append( "                               WHEN (C.PAYGRD >='240' AND C.PAYGRD <='250') THEN '240'								\n");
						sql.append( "                               WHEN (C.PAYGRD >='260' AND C.PAYGRD <='270') THEN '260'								\n");
						sql.append( "                               WHEN (C.PAYGRD >='280' AND C.PAYGRD <='290') THEN '280'								\n");
						sql.append( "                               ELSE C.PAYGRD END)																										\n");
						sql.append( "                    END AS GUBUN,																																		\n");
						sql.append( "                    C.EMPNO, C.S91000,0 CNT4,0 SUM4, 0 CNT5,0 SUM5,	0 CNT6,0 SUM6																			\n");
						sql.append( "         FROM PAYROLL.PBPAY C, PAYROLL.HIPERSON D																										\n");
						sql.append( "         WHERE C.EMPNO = D.EMPNO																																			\n");
						sql.append( "         AND SUBSTR(C.PAYDT,1,6) ='" +str[2]+ "'																																			\n");
						if (str[3].equals("1")) 
						sql.append( "           AND C.PAYDIV IN ('1','3','4')	 											\n");
						if (str[3].equals("5")) 
						sql.append( "           AND C.PAYDIV IN ('5')	 											\n");	
						sql.append( "         AND C.APPDT = SUBSTR(D.STRTDT,1,6)  AND D.USESTS='1'																				\n");
						sql.append( "     ) Y																																															\n");
						sql.append( "         GROUP BY Y.PAYGRD, Y.GUBUN																																	\n");

						sql.append( " --퇴사																																															\n");
						sql.append( "     UNION ALL																																												\n");
						sql.append( "         SELECT Z.PAYGRD, Z.GUBUN, 0 CNT1,0 SUM1,																										\n");
						sql.append( "                0 A1,0 A2,0 A3,0 A4,0 A5,																														\n");
						sql.append( "                0 A6,0 A7,0 A8,0 A9,0 A10,																														\n");
						sql.append( "                0 A11,0 A12,0 A13,0 A14,0 A15,																												\n");
						sql.append( "                0 A16,0 A17,0 A18,0 A19,0 A20,																												\n");
						sql.append( "                0 A21,0 A22,0 A23,0 A24,0 A25,																												\n");
						sql.append( "                0 AS CNT2,0 AS SUM2,																																	\n");
						sql.append( "                0 B1,0 B2,0 B3,0 B4,0 B5,																														\n");
						sql.append( "                0 B6,0 B7,0 B8,0 B9,0 B10,																														\n");
						sql.append( "                0 B11,0 B12,0 B13,0 B14,0 B15,																												\n");
						sql.append( "                0 B16,0 B17,0 B18,0 B19,0 B20,																												\n");
						sql.append( "                0 B21,0 B22,0 B23,0 B24,0 B25,																												\n");
						sql.append( "                0 CNT3,0 SUM3, COALESCE(COUNT(Z.EMPNO),0)CNT4, COALESCE(SUM(Z.S91000),0)SUM4,	\n");
            sql.append( "                0 CNT5,0 SUM5	,	0 CNT6,0 SUM6	         \n");
						sql.append( "          FROM																																												\n");
						sql.append( "         (																																														\n");
						sql.append( "          SELECT																																											\n");
						sql.append( "                CASE WHEN (E.PAYGRD >='140' AND E.PAYGRD <='150') THEN '140'													\n");
						sql.append( "                     WHEN (E.PAYGRD >='180' AND E.PAYGRD <='190') THEN '180'													\n");
						sql.append( "                     WHEN (E.PAYGRD >='200' AND E.PAYGRD <='210' OR E.PAYGRD ='400') THEN '200'			\n");
						sql.append( "                     WHEN (E.PAYGRD >='220' AND E.PAYGRD <='230') THEN '220'													\n");
						sql.append( "                     WHEN (E.PAYGRD >='240' AND E.PAYGRD <='250') THEN '240'													\n");
						sql.append( "                     WHEN (E.PAYGRD >='260' AND E.PAYGRD <='270') THEN '260'													\n");
						sql.append( "                     WHEN (E.PAYGRD >='280' AND E.PAYGRD <='290') THEN '280'													\n");
						sql.append( "                     ELSE E.PAYGRD END PAYGRD,																												\n");
						sql.append( " 																																																		\n");
						sql.append( "                CASE WHEN (E.PAYGRD >='220' AND E.PAYGRD <='230' AND F.SEX='1') THEN  F.SEX					\n");
						sql.append( "                     WHEN (E.PAYGRD >='220' AND E.PAYGRD <='230' AND F.SEX='2') THEN  F.SEX					\n");
						sql.append( "                     WHEN (E.PAYGRD >='240' AND E.PAYGRD <='250' AND F.SEX='1') THEN  F.SEX					\n");
						sql.append( "                     WHEN (E.PAYGRD >='240' AND E.PAYGRD <='250' AND F.SEX='2') THEN  F.SEX					\n");
						sql.append( "                     WHEN (E.PAYGRD >='260' AND E.PAYGRD <='270' AND F.SEX='1') THEN  F.SEX					\n");
						sql.append( "                     WHEN (E.PAYGRD >='260' AND E.PAYGRD <='270' AND F.SEX='2') THEN  F.SEX					\n");
						sql.append( "                     WHEN (E.PAYGRD >='280' AND E.PAYGRD <='290' AND F.SEX='1') THEN  F.SEX					\n");
						sql.append( "                     WHEN (E.PAYGRD >='280' AND E.PAYGRD <='290' AND F.SEX='2') THEN  F.SEX					\n");
						sql.append( "                     ELSE (CASE WHEN (E.PAYGRD >='140' AND E.PAYGRD <='150') THEN '140'							\n");
						sql.append( "                                WHEN (E.PAYGRD >='180' AND E.PAYGRD <='190') THEN '180'							\n");
						sql.append( "                                WHEN (E.PAYGRD >='200' AND E.PAYGRD <='210'  OR E.PAYGRD ='400') THEN '200'	\n");
						sql.append( "                                WHEN (E.PAYGRD >='220' AND E.PAYGRD <='230') THEN '220'							\n");
						sql.append( "                                WHEN (E.PAYGRD >='240' AND E.PAYGRD <='250') THEN '240'							\n");
						sql.append( "                                WHEN (E.PAYGRD >='260' AND E.PAYGRD <='270') THEN '260'							\n");
						sql.append( "                                WHEN (E.PAYGRD >='280' AND E.PAYGRD <='290') THEN '280'							\n");
						sql.append( "                                ELSE E.PAYGRD END)																										\n");
						sql.append( "                     END AS GUBUN,																																		\n");
						sql.append( "                     E.EMPNO, E.S91000,0 CNT4,0 SUM4, 0 CNT5,0 SUM5,	0 CNT6,0 SUM6	 																	\n");
						sql.append( "          FROM PAYROLL.PBPAY E, PAYROLL.HIPERSON F																										\n");
						sql.append( "          WHERE E.EMPNO = F.EMPNO																																		\n");
						sql.append( "          AND E.APPDT ='" +str[2]+ "'																																				\n");
						if (str[3].equals("1")) 
						sql.append( "           AND E.PAYDIV IN ('1','3','4')	 											\n");
						if (str[3].equals("5")) 
						sql.append( "           AND E.PAYDIV  IN ('5')	 											\n");
						sql.append( "           AND E.APPDT = SUBSTR(F.ENDDT,1,6)  AND F.USESTS='3'																				\n");
						sql.append( "     ) Z																																															\n");
						sql.append( "         GROUP BY Z.PAYGRD, Z.GUBUN																																	\n");

						sql.append( " UNION ALL																																														\n");
						sql.append( " --승진																																															\n");
						sql.append( "         SELECT W.PAYGRD, W.GUBUN, 0 CNT1,0 SUM1,																										\n");
						sql.append( "                0 A1,0 A2,0 A3,0 A4,0 A5,																														\n");
						sql.append( "                0 A6,0 A7,0 A8,0 A9,0 A10,																														\n");
						sql.append( "                0 A11,0 A12,0 A13,0 A14,0 A15,																												\n");
						sql.append( "                0 A16,0 A17,0 A18,0 A19,0 A20,																												\n");
						sql.append( "                0 A21,0 A22,0 A23,0 A24,0 A25,																												\n");
						sql.append( "                0 AS CNT2,0 AS SUM2,																																	\n");
						sql.append( "                0 B1,0 B2,0 B3,0 B4,0 B5,																														\n");
						sql.append( "                0 B6,0 B7,0 B8,0 B9,0 B10,																														\n");
						sql.append( "                0 B11,0 B12,0 B13,0 B14,0 B15,																												\n");
						sql.append( "                0 B16,0 B17,0 B18,0 B19,0 B20,																												\n");
						sql.append( "                0 B21,0 B22,0 B23,0 B24,0 B25,																												\n");
						sql.append( "                0 CNT3,0 SUM3,0 CNT4,0 SUM4, COALESCE(COUNT(W.EMPNO),0)CNT5, COALESCE(SUM(W.S91000),0)SUM5,	0 CNT6,0 SUM6	 		\n");
						sql.append( "         FROM																																												\n");
						sql.append( "       (																																															\n");
						sql.append( "         SELECT																																											\n");
						sql.append( "               CASE WHEN (G.PAYGRD >='140' AND G.PAYGRD <='150') THEN '140'													\n");
						sql.append( "                    WHEN (G.PAYGRD >='180' AND G.PAYGRD <='190') THEN '180'													\n");
						sql.append( "                    WHEN (G.PAYGRD >='200' AND G.PAYGRD <='210'  OR G.PAYGRD ='400') THEN '200'			\n");
						sql.append( "                    WHEN (G.PAYGRD >='220' AND G.PAYGRD <='230') THEN '220'													\n");
						sql.append( "                    WHEN (G.PAYGRD >='240' AND G.PAYGRD <='250') THEN '240'													\n");
						sql.append( "                    WHEN (G.PAYGRD >='260' AND G.PAYGRD <='270') THEN '260'													\n");
						sql.append( "                    WHEN (G.PAYGRD >='280' AND G.PAYGRD <='290') THEN '280'													\n");
						sql.append( "                    ELSE G.PAYGRD END PAYGRD,																												\n");

						sql.append( "               CASE WHEN (G.PAYGRD >='220' AND G.PAYGRD <='230' AND H.SEX='1') THEN  H.SEX						\n");
						sql.append( "                    WHEN (G.PAYGRD >='220' AND G.PAYGRD <='230' AND H.SEX='2') THEN  H.SEX						\n");
						sql.append( "                    WHEN (G.PAYGRD >='240' AND G.PAYGRD <='250' AND H.SEX='1') THEN  H.SEX						\n");
						sql.append( "                    WHEN (G.PAYGRD >='240' AND G.PAYGRD <='250' AND H.SEX='2') THEN  H.SEX						\n");
						sql.append( "                    WHEN (G.PAYGRD >='260' AND G.PAYGRD <='270' AND H.SEX='1') THEN  H.SEX						\n");
						sql.append( "                    WHEN (G.PAYGRD >='260' AND G.PAYGRD <='270' AND H.SEX='2') THEN  H.SEX						\n");
						sql.append( "                    WHEN (G.PAYGRD >='280' AND G.PAYGRD <='290' AND H.SEX='1') THEN  H.SEX						\n");
						sql.append( "                    WHEN (G.PAYGRD >='280' AND G.PAYGRD <='290' AND H.SEX='2') THEN  H.SEX						\n");
						sql.append( "                    ELSE (CASE WHEN (G.PAYGRD >='140' AND G.PAYGRD <='150') THEN '140'								\n");
						sql.append( "                               WHEN (G.PAYGRD >='180' AND G.PAYGRD <='190') THEN '180'								\n");
						sql.append( "                               WHEN (G.PAYGRD >='200' AND G.PAYGRD <='210'  OR G.PAYGRD ='400') THEN '200'		\n");
						sql.append( "                               WHEN (G.PAYGRD >='220' AND G.PAYGRD <='230') THEN '220'								\n");
						sql.append( "                               WHEN (G.PAYGRD >='240' AND G.PAYGRD <='250') THEN '240'								\n");
						sql.append( "                               WHEN (G.PAYGRD >='260' AND G.PAYGRD <='270') THEN '260'								\n");
						sql.append( "                               WHEN (G.PAYGRD >='280' AND G.PAYGRD <='290') THEN '280'								\n");
						sql.append( "                               ELSE G.PAYGRD END)																										\n");
						sql.append( "                     END AS GUBUN,																																		\n");
						sql.append( "                     G.EMPNO, G.S91000,0 CNT4,0 SUM4, 0 CNT5,0 SUM5	,	0 CNT6,0 SUM6	 																\n");
						sql.append( "         FROM PAYROLL.PBPAY G, PAYROLL.HIPERSON H																										\n");
						sql.append( "         WHERE G.EMPNO = H.EMPNO																																			\n");
						sql.append( "         AND G.APPDT ='" +str[2]+ "'																																					\n");
						if (str[3].equals("1")) 
						sql.append( "           AND G.PAYDIV IN ('1','3','4')	 											\n");
						if (str[3].equals("5")) 
						sql.append( "           AND G.PAYDIV IN ('5')	 											\n");					
						sql.append( "         AND G.APPDT = SUBSTR(H.LAMDT,1,6)  AND H.USESTS='1'																					\n");
						sql.append( "       ) W																																														\n");
						sql.append( "         GROUP BY W.PAYGRD, W.GUBUN																																	\n");
						
						sql.append( "--소급                                                                                                     \n");
						sql.append( "UNION ALL                                                                                                  \n");
						sql.append( "        SELECT ZZ.PAYGRD, ZZ.GUBUN, 0 CNT1, 0 SUM1,                                                        \n");
						sql.append( "                0 A1,0 A2,0 A3,0 A4,0 A5,                                                                  \n");
						sql.append( "                0 A6,0 A7,0 A8,0 A9,0 A10,                                                                 \n");
						sql.append( "                0 A11,0 A12,0 A13,0 A14,0 A15,                                                             \n");
						sql.append( "                0 A16,0 A17,0 A18,0 A19,0 A20,                                                             \n");
						sql.append( "                0 A21,0 A22,0 A23,0 A24,0 A25,                                                             \n");
						sql.append( "                0 AS CNT2,0 AS SUM2,                                                                       \n");
						sql.append( "                0 B1,0 B2,0 B3,0 B4,0 B5,                                                                  \n");
						sql.append( "                0 B6,0 B7,0 B8,0 B9,0 B10,                                                                 \n");
						sql.append( "                0 B11,0 B12,0 B13,0 B14,0 B15,                                                              \n");
						sql.append( "                0 B16,0 B17,0 B18,0 B19,0 B20,                                                              \n");
						sql.append( "                0 B21,0 B22,0 B23,0 B24,0 B25,                                                              \n");
						sql.append( "                0 CNT3, 0 SUM3,                                                                             \n");
						sql.append( "                0 CNT4,0 SUM4, 0 CNT5,0 SUM5, COALESCE(COUNT(ZZ.EMPNO),0)CNT6,COALESCE(SUM(ZZ.S91000),0)SUM6");
						sql.append( "         FROM                                                                                              \n");
						sql.append( "       (                                                                                                   \n");
						sql.append( "         SELECT                                                                                            \n");
						sql.append( "               CASE WHEN (C.PAYGRD >='140' AND C.PAYGRD <='150') THEN '140'                                \n");
						sql.append( "                    WHEN (C.PAYGRD >='180' AND C.PAYGRD <='190') THEN '180'                                \n");
						sql.append( "                    WHEN (C.PAYGRD >='200' AND C.PAYGRD <='210'  OR C.PAYGRD ='400') THEN '200'            \n");
						sql.append( "                    WHEN (C.PAYGRD >='220' AND C.PAYGRD <='230') THEN '220'                                \n");
						sql.append( "                    WHEN (C.PAYGRD >='240' AND C.PAYGRD <='250') THEN '240'                                \n");
						sql.append( "                    WHEN (C.PAYGRD >='260' AND C.PAYGRD <='270') THEN '260'                                \n");
						sql.append( "                    WHEN (C.PAYGRD >='280' AND C.PAYGRD <='290') THEN '280'                                \n");
						sql.append( "                    ELSE C.PAYGRD END PAYGRD,                                                              \n");
						sql.append( "               CASE WHEN (C.PAYGRD >='220' AND C.PAYGRD <='230' AND D.SEX='1') THEN D.SEX                  \n");
						sql.append( "                    WHEN (C.PAYGRD >='220' AND C.PAYGRD <='230' AND D.SEX='2') THEN D.SEX                  \n");
						sql.append( "                    WHEN (C.PAYGRD >='240' AND C.PAYGRD <='250' AND D.SEX='1') THEN D.SEX                  \n");
						sql.append( "                    WHEN (C.PAYGRD >='240' AND C.PAYGRD <='250' AND D.SEX='2') THEN D.SEX                  \n");
						sql.append( "                    WHEN (C.PAYGRD >='260' AND C.PAYGRD <='270' AND D.SEX='1') THEN D.SEX                  \n");
            sql.append( "                    WHEN (C.PAYGRD >='260' AND C.PAYGRD <='270' AND D.SEX='2') THEN D.SEX                  \n");
						sql.append( "                    WHEN (C.PAYGRD >='280' AND C.PAYGRD <='290' AND D.SEX='1') THEN D.SEX                  \n");
						sql.append( "                    WHEN (C.PAYGRD >='280' AND C.PAYGRD <='290' AND D.SEX='2') THEN D.SEX                  \n");
						sql.append( "                    ELSE (CASE WHEN (C.PAYGRD >='140' AND C.PAYGRD <='150') THEN '140'                     \n");
						sql.append( "                               WHEN (C.PAYGRD >='180' AND C.PAYGRD <='190') THEN '180'                     \n");
						sql.append( "                               WHEN (C.PAYGRD >='200' AND C.PAYGRD <='210'  OR C.PAYGRD ='400') THEN '200' \n");
						sql.append( "                               WHEN (C.PAYGRD >='220' AND C.PAYGRD <='230') THEN '220'                     \n");
						sql.append( "                               WHEN (C.PAYGRD >='240' AND C.PAYGRD <='250') THEN '240'                     \n");
						sql.append( "                               WHEN (C.PAYGRD >='260' AND C.PAYGRD <='270') THEN '260'                     \n");
						sql.append( "                               WHEN (C.PAYGRD >='280' AND C.PAYGRD <='290') THEN '280'                     \n");
						sql.append( "                               ELSE C.PAYGRD END)                                                          \n");
						sql.append( "                    END AS GUBUN,                                                                          \n");
						sql.append( "                    C.EMPNO, C.S91000,0 CNT4,0 SUM4, 0 CNT5,0 SUM5, 0 CNT6,0 SUM6                          \n");
						sql.append( "         FROM PAYROLL.PBPAY C, PAYROLL.HIPERSON D                                                          \n");
						sql.append( "         WHERE C.EMPNO = D.EMPNO                                                                           \n");
						sql.append( "         AND C.PAYDIV IN ('2')                                                                             \n");
						sql.append( "         AND SUBSTR(C.PAYDT,1,6) ='" + str[2] +"'                                                          \n");
						sql.append( "         AND D.STRTDT>='" + str[1] + "16' AND D.STRTDT<='" + str[2] + "15'                                 \n");
						sql.append( "         AND D.USESTS='1'                                                                                  \n");
						sql.append( "       ) ZZ                                                                                                \n");
						sql.append( "         GROUP BY ZZ.PAYGRD, ZZ.GUBUN                                                                      \n");
						
						sql.append( "     )X																																															\n");
						sql.append( " LEFT JOIN PAYROLL.HCLCODE K ON X.PAYGRD = K.MINORCD AND K.MAJORCD='2002'														\n");
						sql.append( " GROUP BY X.PAYGRD,X.GUBUN,K.MINORNM,K.SEQ																														\n");
						sql.append( " ORDER BY K.SEQ,X.GUBUN																																							\n");
											
           // logger.dbg.println(this,sql.toString());
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