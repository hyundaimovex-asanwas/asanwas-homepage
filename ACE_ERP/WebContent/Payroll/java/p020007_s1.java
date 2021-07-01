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
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
        
        "PAYGRD",	/* 직위*/
				"SEQ",	/* 순서*/
				"PAYGRDNM",	/* 직위명*/
				"PRVNUM",	/* 이전월 총인원 */
				"PRVAMT",   /* 이전월 전체 총 실급여*/
				"NEXNUM",	/* 현재월 총인원*/
				"NEXAMT",	/* 현재월 전체 총 실급여 */
			   "IBSANUM",	/* 현재적용년월 입사인원*/	
			   "IBSAAMT",	/* 현재적용년월 입사 총 실급여*/
				"TAENUM",	/* 현재적용년월 퇴사사인원 */
				"TAEAMT",   /* 현재적용년월 퇴사사 총 실급여*/
			   "SUNGNUM",	/* 현재적용년월 승진인원*/
			   "SUNGAMT",	/* 현재적용년월 승진자 총 실급여*/
				"ITSNUM",	/* 현재적용년월 입,퇴,승진자 총 실급여*/
				"ITSAMT",	/* 현재적용년월 입,퇴,승진자 총 실급여*/	
				"A1_AMT",	/* --기본급 증감 금액  */
				"A2_AMT",	/* --직책수당 증감 금액 */
				"A3_AMT",   /* --시간외 증감 금액  */
				"A4_AMT",	/* --근속수당 증감 금액 */
				"A5_AMT",	/* --자기계발비 증감 금액 */
				"A6_AMT",	/* --가족부양비 증감 금액 */	
				"A7_AMT",	/* --차량유지비 증감 금액 */
				"A8_AMT",	/* --자격수당 증감 금액  */
				"A9_AMT",   /* --개인연금 증감 금액 */
				"A10_AMT",	/* 남북경헙 증감 금액  */
				"A11_AMT",	/* 특수지 수당 증감 금액 */
				"A12_AMT",	/* 지역근무수당 증감 금액 */	
				"A13_AMT",	/* 휴일근무수당 증감 금액 -협의필요*/
				"A14_AMT",	/* 전월소급 증감 금액 */
				"A15_AMT",	/* 임원직책 증감 금액 */	
				"A16_AMT",	/* 학자금 증감 금액  */	
				"A17_AMT",	/* 출납수당*/	
				"A18_AMT",	/*운전수당*/	
				"A19_AMT",	/*연장수당*/	
				"A20_AMT",	/*사장단수당 */	
				"A21_AMT",	/*연차수당*/	
				"A22_AMT",	/*식대보조*/	
				"A23_AMT",	/*기타지급1 */	
				"A24_AMT",	/*기타지급2 */	
				"A25_AMT", 	/*기타지급3 */	
			   "AA_AMT"	    /* 지급 총합 증감 금액*/	
				};

				int[] intArrCN = new int[]{  
					4,
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
					9,	/* --자격수당 증감 금액  */
					9,   /* --개인연금 증감 금액  */
					9,	/* 남북경헙 증감 금액       */
					9,	/* 특수지 수당 증감 금액         */
					9,	/* 지역근무수당 증감 금액       */	
					9,	/* 휴일근무수당 증감 금액 -협의필요*/
					9,	/* 전월소급 증감 금액            */
					9,	/* 임원직책 증감 금액         */	
					9,	/* 학자금 증감 금액          */	
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
					0,	/* 남북경헙 증감 금액       */
					0,	/* 특수지 수당 증감 금액         */
					0,	/* 지역근무수당 증감 금액       */	
					0,	/* 휴일근무수당 증감 금액 -협의필요*/
					0,	/* 전월소급 증감 금액            */
					0,	/* 임원직책 증감 금액         */	
					0,	/* 학자금 증감 금액          */	
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
				//	logger.err.println(this,"1234");

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 
			
					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append(" SELECT X.PAYGRD, K.SEQ, K.MINORNM AS PAYGRDNM,        ");  
						sql.append("       SUM(X.CNT1)PRVNUM, SUM(X.SUM1)PRVAMT,                  ");
						sql.append("       SUM(X.CNT2)NEXNUM, SUM(X.SUM2)NEXAMT,                  ");  
						sql.append("       SUM(CNT3) IBSANUM ,SUM(SUM3)IBSAAMT,                    ");  
						sql.append("       SUM(CNT4) TAENUM , SUM(SUM4)TAEAMT,                    ");
						sql.append("       SUM(CNT5) SUNGNUM ,SUM(SUM5)SUNGAMT,                  ");  
						sql.append("       SUM(CNT3)+ SUM(CNT4)+SUM(CNT5) ITSNUM,             ");  
						sql.append("       SUM(SUM3)+ SUM(SUM4)+SUM(SUM5) ITSAMT,             ");
						sql.append("       (SUM(B1)-SUM(A1))A1_AMT,     (SUM(B2)-SUM(A2))A2_AMT,   (SUM(B3)-SUM(A3))A3_AMT,                  ");
						sql.append("       (SUM(B4)-SUM(A4))A4_AMT,     (SUM(B5)-SUM(A5))A5_AMT,   (SUM(B6)-SUM(A6))A6_AMT,                  ");  
						sql.append("       (SUM(B7)-SUM(A7))A7_AMT,     (SUM(B8)-SUM(A8))A8_AMT,   (SUM(B9)-SUM(A9))A9_AMT,                  ");
						sql.append("       (SUM(B10)-SUM(A10))A10_AMT,  (SUM(B11)-SUM(A11))A11_AMT,(SUM(B12)-SUM(A12))A12_AMT,        ");  
						sql.append("       (SUM(B13)-SUM(A13))A13_AMT,  (SUM(B14)-SUM(A14))A14_AMT,(SUM(B15)-SUM(A15))A15_AMT,        ");
						sql.append("       (SUM(B16)-SUM(A16))A16_AMT,  (SUM(B17)-SUM(A17))A17_AMT,(SUM(B18)-SUM(A18))A18_AMT,        ");  
						sql.append("       (SUM(B19)-SUM(A19))A19_AMT,  (SUM(B20)-SUM(A20))A20_AMT,(SUM(B21)-SUM(A21))A21_AMT,        ");
						sql.append("       (SUM(B22)-SUM(A22))A22_AMT,  (SUM(B23)-SUM(A23))A23_AMT,(SUM(B24)-SUM(A24))A24_AMT,        ");  
						sql.append("       (SUM(B25)-SUM(A25))A25_AMT,                                                                                                       ");
						sql.append("       ((SUM(B1)-SUM(A1))+ (SUM(B2)-SUM(A2))+(SUM(B3)-SUM(A3))+                                                      ");  
						sql.append("        (SUM(B4)-SUM(A4))+ (SUM(B5)-SUM(A5))+(SUM(B6)-SUM(A6))+                                                        ");
						sql.append("        (SUM(B7)-SUM(A7))+ (SUM(B8)-SUM(A8))+(SUM(B9)-SUM(A9))+                                                        ");  
						sql.append("        (SUM(B10)-SUM(A10))+(SUM(B11)-SUM(A11))+(SUM(B12)-SUM(A12))+                                                                 ");
						sql.append("        (SUM(B13)-SUM(A13))+(SUM(B14)-SUM(A14))+(SUM(B15)-SUM(A15))+                                                                 ");  
						sql.append("        (SUM(B16)-SUM(A16))+(SUM(B17)-SUM(A17))+(SUM(B18)-SUM(A18))+                                                                 ");
						sql.append("        (SUM(B19)-SUM(A19))+(SUM(B20)-SUM(A20))+(SUM(B21)-SUM(A21))+                                                                 ");  
						sql.append("        (SUM(B22)-SUM(A22))+(SUM(B23)-SUM(A23))+(SUM(B24)-SUM(A24))+                                                                 ");
						sql.append("        (SUM(B25)-SUM(A25))) AA_AMT                                                                                                                          ");  
						sql.append("  FROM                                                                                                                                                                       ");
						sql.append("/*전년월*/                                                                                                                                                                   ");  
						sql.append(" (SELECT  A.PAYGRD , COUNT(A.EMPNO)CNT1, SUM(A.S91000)SUM1,                                                                             ");
						sql.append("        SUM(A.P10000)A1,SUM(A.P11000)A2,SUM(A.P12000)A3,SUM(A.P21000)A4,SUM(A.P22000)A5,                                  ");  
						sql.append("        SUM(A.P23000)A6,SUM(A.P24000)A7,SUM(A.P28000)A8,SUM(A.P37000)A9,SUM(A.P29000)A10,                                ");
						sql.append("        SUM(A.P31000)A11,SUM(A.P32000)A12,SUM(A.PX0010)A13,SUM(A.P39000)A14,SUM(A.P38000)A15,                         ");  
						sql.append("        SUM(A.P36000)A16,SUM(A.P25000)A17,SUM(A.P26000)A18,SUM(A.P27000)A19,SUM(A.P30000)A20,                         ");
						sql.append("        SUM(A.P34000)A21,SUM(A.P35000)A22,SUM(A.PX0020)A23,SUM(A.PX0030)A24,SUM(A.PX0040)A25,                        ");  
						sql.append("        0 AS CNT2,0 AS SUM2,                                                                                                                                       ");
						sql.append("        0 B1,0 B2,0 B3,0 B4,0 B5,                                                                                                                                   ");  
						sql.append("        0 B6,0 B7,0 B8,0 B9,0 B10,                                                                                                                                 ");
						sql.append("        0 B11,0 B12,0 B13,0 B14,0 B15,                                                                                                                          ");  
						sql.append("        0 B16,0 B17,0 B18,0 B19,0 B20,                                                                                                                          ");
						sql.append("        0 B21,0 B22,0 B23,0 B24,0 B25,                                                                                                                          ");  
						sql.append("        0 CNT3,0 SUM3,0 CNT4,0 SUM4, 0 CNT5,0 SUM5                                                                                                   ");
						sql.append("    FROM PAYROLL.PBPAY A                                                                                                                                          ");  
						sql.append("   WHERE A.APPDT ='" + str[1]+"'");
						sql.append("     AND A.PAYDIV = '1'                                                                                                                                               ");  
						sql.append(" GROUP BY A.PAYGRD                                                                                                                                                 ");
						sql.append(" UNION ALL                                                                                                                                                                 ");
						sql.append("/*현년월*/                                                                                                                                                                   ");  
						sql.append(" SELECT  B.PAYGRD, 0 AS CNT1,0 AS SUM1,                                                                                                                 ");
						sql.append("        0 A1,0 A2,0 A3,0 A4,0 A5,                                                                                                                                   ");  
						sql.append("        0 A6,0 A7,0 A8,0 A9,0 A10,                                                                                                                                 ");
						sql.append("        0 A11,0 A12,0 A13,0 A14,0 A15,                                                                                                                          ");  
						sql.append("        0 A16,0 A17,0 A18,0 A19,0 A20,                                                                                                                          ");
						sql.append("        0 A21,0 A22,0 A23,0 A24,0 A25,                                                                                                                          ");  
						sql.append("        COUNT(B.EMPNO)CNT2, SUM(B.S91000)SUM2,                                                                                                      ");
						sql.append("        SUM(B.P10000) B1,SUM(B.P11000) B2,SUM(B.P12000) B3,SUM(B.P21000) B4,SUM(B.P22000) B5,                             ");  
						sql.append("        SUM(B.P23000) B6,SUM(B.P24000) B7,SUM(B.P28000) B8,SUM(B.P37000) B9,SUM(B.P29000) B10,                           ");
						sql.append("        SUM(B.P31000) B11,SUM(B.P32000)B12,SUM(B.PX0010)B13,SUM(B.P39000) B14,SUM(B.P38000) B15,                      ");  
						sql.append("        SUM(B.P36000) B16,SUM(B.P25000)B17,SUM(B.P26000)B18,SUM(B.P27000)B19,SUM(B.P30000)B20,                        ");
						sql.append("        SUM(B.P34000)B21,SUM(B.P35000)B22,SUM(B.PX0020)B23,SUM(B.PX0030)B24,SUM(B.PX0040)B25,                        ");  
						sql.append("        0 CNT3,0 SUM3,0 CNT4,0 SUM4, 0 CNT5,0 SUM5                                                                                                   ");
						sql.append("  FROM PAYROLL.PBPAY B                                                                                                                                            ");  
						sql.append(" WHERE B.APPDT ='" + str[2]+"'");                                                                                                                               
						sql.append("   AND B.PAYDIV = '1'                                                                                                                                                 ");  
						sql.append(" GROUP BY B.PAYGRD                                                                                                                                                 ");
						sql.append(" UNION ALL                                                                                                                                                                 ");
						sql.append(" /*입사*/                                                                                                                                                                 ");  
						sql.append(" SELECT C.PAYGRD, 0,0,                                                                                                                                             ");
						sql.append("        0 A1,0 A2,0 A3,0 A4,0 A5,                                                                                                                                   ");  
						sql.append("        0 A6,0 A7,0 A8,0 A9,0 A10,                                                                                                                                 ");
						sql.append("        0 A11,0 A12,0 A13,0 A14,0 A15,                                                                                                                          ");  
						sql.append("        0 A16,0 A17,0 A18,0 A19,0 A20,                                                                                                                          ");
						sql.append("        0 A21,0 A22,0 A23,0 A24,0 A25,                                                                                                                          ");  
						sql.append("        0 AS CNT2,0 AS SUM2,                                                                                                                                       ");
						sql.append("        0 B1,0 B2,0 B3,0 B4,0 B5,                                                                                                                                   ");  
						sql.append("        0 B6,0 B7,0 B8,0 B9,0 B10,                                                                                                                                 ");
						sql.append("        0 B11,0 B12,0 B13,0 B14,0 B15,                                                                                                                          ");  
						sql.append("        0 B16,0 B17,0 B18,0 B19,0 B20,                                                                                                                          ");
						sql.append("        0 B21,0 B22,0 B23,0 B24,0 B25,                                                                                                                          ");  
						sql.append("        COALESCE(COUNT(C.EMPNO),0)CNT3, COALESCE(SUM(C.S91000),0)SUM3,0 CNT4,0 SUM4, 0 CNT5,0 SUM5             ");
				  	sql.append("        FROM PAYROLL.PBPAY C, PAYROLL.HIPERSON D                                                                                                   ");  
						sql.append(" WHERE C.EMPNO = D.EMPNO                                                                                                                                      ");
						sql.append("   AND C.APPDT ='" + str[2]+"'");                                                                                                                           
						sql.append("   AND C.PAYDIV='1'                                                                                                                                                   ");
						sql.append("   AND C.APPDT = SUBSTR(D.STRTDT,1,6)  AND D.USESTS='1'                                                                                     ");  
						sql.append("  GROUP BY C.PAYGRD                                                                                                                                               ");
						sql.append(" UNION ALL                                                                                                                                                                 ");
	   			  sql.append(" /*퇴사*/                                                                                                                                                                      ");
						sql.append(" SELECT E.PAYGRD, 0, 0,                                                                                                                                             ");  
						sql.append("        0 A1,0 A2,0 A3,0 A4,0 A5,                                                                                                                                   ");
						sql.append("        0 A6,0 A7,0 A8,0 A9,0 A10,                                                                                                                                 ");  
						sql.append("        0 A11,0 A12,0 A13,0 A14,0 A15,                                                                                                                          ");
						sql.append("        0 A16,0 A17,0 A18,0 A19,0 A20,                                                                                                                          ");  
						sql.append("        0 A21,0 A22,0 A23,0 A24,0 A25,                                                                                                                          ");
						sql.append("        0 AS CNT2,0 AS SUM2,                                                                                                                                       ");  
						sql.append("        0 B1,0 B2,0 B3,0 B4,0 B5,                                                                                                                                   ");
						sql.append("        0 B6,0 B7,0 B8,0 B9,0 B10,                                                                                                                                 ");  
						sql.append("        0 B11,0 B12,0 B13,0 B14,0 B15,                                                                                                                          ");
						sql.append("        0 B16,0 B17,0 B18,0 B19,0 B20,                                                                                                                          ");  
						sql.append("        0 B21,0 B22,0 B23,0 B24,0 B25,                                                                                                                          ");
						sql.append("        0 CNT3,0 SUM3, COALESCE(COUNT(E.EMPNO),0)CNT4, COALESCE(SUM(E.S91000),0)SUM4,0 CNT5,0 SUM5              ");  
						sql.append("  FROM PAYROLL.PBPAY E, PAYROLL.HIPERSON F                                                                                                           ");
						sql.append(" WHERE E.EMPNO = F.EMPNO                                                                                                                                       ");  
						sql.append("   AND E.APPDT ='" + str[2]+"'");                                                                                                                      
						sql.append("   AND E.PAYDIV='1'                                                                                                                                                   ");  
						sql.append("   AND E.APPDT = SUBSTR(F.ENDDT,1,6)  AND F.USESTS='3'                                                                                         ");
						sql.append("  GROUP BY E.PAYGRD                                                                                                                                                ");  
						sql.append(" UNION ALL                                                                                                                                                                 ");  
						sql.append(" /*승진*/                                                                                                                                                                     ");
						sql.append(" SELECT G.PAYGRD, 0, 0,                                                                                                                                             ");  
						sql.append("        0 A1,0 A2,0 A3,0 A4,0 A5,                                                                                                                                   ");
						sql.append("        0 A6,0 A7,0 A8,0 A9,0 A10,                                                                                                                                 ");  
						sql.append("        0 A11,0 A12,0 A13,0 A14,0 A15,                                                                                                                          ");
						sql.append("        0 A16,0 A17,0 A18,0 A19,0 A20,                                                                                                                          ");  
						sql.append("        0 A21,0 A22,0 A23,0 A24,0 A25,                                                                                                                          ");
						sql.append("        0 AS CNT2,0 AS SUM2,                                                                                                                                       ");  
						sql.append("        0 B1,0 B2,0 B3,0 B4,0 B5,                                                                                                                                   ");
						sql.append("        0 B6,0 B7,0 B8,0 B9,0 B10,                                                                                                                                 ");  
						sql.append("        0 B11,0 B12,0 B13,0 B14,0 B15,                                                                                                                          ");
						sql.append("        0 B16,0 B17,0 B18,0 B19,0 B20,                                                                                                                          ");  
						sql.append("        0 B21,0 B22,0 B23,0 B24,0 B25,                                                                                                                          ");
						sql.append("        0 CNT3,0 SUM3,0 CNT4,0 SUM4, COALESCE(COUNT(G.EMPNO),0)CNT5, COALESCE(SUM(G.S91000),0)SUM5             ");  
						sql.append("  FROM PAYROLL.PBPAY G, PAYROLL.HIPERSON H                                                                                                          ");
						sql.append(" WHERE G.EMPNO = H.EMPNO                                                                                                                                      ");  
						sql.append("   AND G.APPDT ='" + str[2]+"'");                                                                                                                              
						sql.append("   AND G.PAYDIV='1'                                                                                                                                                   ");  
						sql.append("   AND G.APPDT = SUBSTR(H.LAMDT,1,6)  AND H.USESTS='1'                                                                                        ");
						sql.append("  GROUP BY G.PAYGRD                                                                                                                                               ");  
						sql.append(" )X                                                                                                                                                                            ");
						sql.append("LEFT JOIN PAYROLL.HCLCODE K ON X.PAYGRD = K.MINORCD AND K.MAJORCD='2002'                                                   ");
						sql.append("GROUP BY X.PAYGRD,K.MINORNM,K.SEQ                                                                                                                      ");  
						sql.append("ORDER BY K.SEQ                                                                                                                                                        ");
											

			logger.dbg.println(this,sql.toString());
/*********************************************************************************************/

					stmt = conn.getGauceStatement(sql.toString());
								//		logger.err.println(this,"1");

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