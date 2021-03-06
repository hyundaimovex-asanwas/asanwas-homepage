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
public class p020005_s1 extends HttpServlet {

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
				String [] str = new String [13];
				str[0]	= req.getParameter("v_str1");		//지급일자
				str[1]	= req.getParameter("v_str2");		//적용년월
				str[2]	= req.getParameter("v_str3");		//급여구분
				str[3]	= req.getParameter("v_str4");		//부서
				str[4]	= req.getParameter("v_str5");		//직군
				str[5]	= req.getParameter("v_str6");		//사번부터
				str[6]	= req.getParameter("v_str7");		//사번까지
				str[7]	= req.getParameter("v_str8");		//성명
				str[8]	= req.getParameter("v_str9");		//직위
				str[9]	= req.getParameter("v_str10");	//직급
				str[10]	= req.getParameter("v_str11");	//Level
				str[11]	= req.getParameter("v_str12");	//treecd
				str[12]	= req.getParameter("v_str13");	//TEMP

				for (int s=0;s<=12;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"EMPNO",	/* 사번 */
				"EMPNMK", /*한글명*/
				"NOTWRK", /*휴직정직일수*/
				"APPDT",	/* 년월 */
				"PAYDIV",	/* 급여구분*/
				"DEPTCD",	/*  부서코드*/
				"DEPTNM",	/*  부서명*/
				"PAYGRDNM",	/* 직위코드*/
				"GRDDIVNM",	/*직급*/
				"PAYSEQNM",	/* 호봉코드 */
				"PAYBNKNM",	/*  은행코드*/
				"PAYNUM",	/*  계좌번호*/
				"PAYDT",  /*  지급일*/
				"DUYNOT",	/*  무계결근일수*/
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
				"P36000",	/*  학비보조금*/
				"P37000",	/*  개인연금보조금*/
				"P38000",	/*  임원직책수당*/
				"PX0010",	/*  기타지급1*/
				"PX0020",	/*  기타지급2*/
				"PX0030",	/*  기타지급3*/
				"PX0040",	/*  기타지급4*/
				"S91000",	/*  지급합계*/
				"T11000",	/*  소득세 OR 갑근세*/
				"T12000",	/*  주민세*/
				"B11000",	/*  건강보험료*/
				"B12000",	/*  국민연금*/
				"B13000",	/*  고용보험*/
				"B15000",	/*  개인연금*/
				"B14000",	/*  여직원회비*/
				"B16000",	/*  공조회비*/
				"BX0010",	/*  기타공제1*/		
				"BX0020",	/*  기타공제2*/		
				"BX0030",	/*  기타공제3*/		
				"BX0040",	/*  기타공제4*/
				"S93000",	/*  공제합계*/	
				"S94000",	/*  실지급액*/

				"P34000",	/*  년차수당*/
				"P39000",	/*  전월소급*/
				"P41000",	/*  정산건강*/
				"P42000",	/*  정산고용*/
				"T21000",	/*  정산소득*/
				"T22000",	/*  정산주민*/
				"TS9100",	/*  누적소득누계*/
				"TT1100",	/*  누적소득액*/  
				"TT1200",	/*  누적주민세*/  

				"STRTDT",	 /*  입사일*/	
				"JOBGRPHNM",/*  직군*/	
				"ENDDT", 	 /*  퇴사일*/	
				"B17000",  /*  산재보험*/	  
				"P43000",  /* 정산연금 */	   
				"BSDAY",   /*  본사근무일수*/
				"HJDAY",   /*  현장근무일수*/
				"NSDAY",   /*  경헙근무일수*/

				"SANGRAT", /*상여율*/  
				"P23002",	 /* 배우자수 */  
				"P23003",	 /* 부모수 */  
				"P23004",	 /* 자녀수 */  
				"P23005",	 /* 장애인수 */  
				"P23006",	 /* 경로우대자수*/
				"P35000",	 /* 식대*/
        "DPOFFDT", /* 발령일*/

				"APLAMT",	//대출상환원금
				"APLRAT",	//대출상환이자
				"APPCNT",	//대출잔여회수
				"APJAMT",	//대출잔액

				"CHAGDT",   //변경일
				"GRSTRTDT", //그룹입사일
				"TRAINYN",	//수습여부
				"DEPTPRNM", //근무지
        
        "PR0020",  //기타지급제목1   
				"PR0030",	 //기타지급제목2   
				"PR0040",	 //기타지급제목3   
				"BR0020",	 //기타공제제목1   
				"BR0030",	 //기타공제제목2   
				"BR0040",  //기타공제제목3   
				"RESINO",  //주민번호   
				"AMT_1"		 //상환액
        
				};

				int[] intArrCN = new int[]{  
					7, 	 /* 사번 */                
					20,	 /* 한글명*/               
					2, 	 /* 휴직정직일수*/         
					6,	 /* 년월 */            
					30,	 /* 급여구분*/                
					4,	 /* 부서코드*/               
					50,	 /* 부서명*/                 
					30,	 /* 직위코드*/                
					30,	 /* 직급*/                     
					30,	 /* 호봉코드 */               
					30,	 /* 은행코드*/               
					25,	 /* 계좌번호*/               
					8,	 /* 지급일*/                
					2,	 /* 무계결근일수*/           
					9,	 /* 기본급여*/               
					9,	 /* 직책수당 */               
					9,	 /* 시간외수당 */             
					9,	 /* 근속수당*/               
					9,	 /* 자기계발비 */            
					9,	 /* 부양가족수당*/           
					9,	 /* 차량유지비 */            
					9,	 /* 출납수당*/               
					9,	 /* 운전수당*/               
					9,	 /* 연장수당*/               
					9,	 /* 자격수당*/               
					9,	 /* 남북경협수당*/           
					9,	 /* 사장단수당*/             
					9,	 /* 특수지수당*/             
					9,	 /* 지역근무수당*/           
					9,	 /* 학비보조금*/             
					9,	 /* 개인연금보조금*/         
					9,	 /* 임원직책수당*/           
					9,	 /* 기타지급1*/              
					9,	 /* 기타지급2*/              
					9,	 /* 기타지급3*/              
					9,	 /* 기타지급4*/              
					9,	 /* 지급합계*/               
					9,	 /* 소득세 OR 갑근세*/       
					9,	 /* 주민세*/                 
					9,	 /* 건강보험료*/             
					9,	 /* 국민연금*/               
					9,	 /* 고용보험*/               
					9,	 /* 개인연금*/               
					9,	 /* 여직원회비*/             
					9,	 /* 공조회비*/               
					9,	 /* 기타공제1*/		         
					9,	 /* 기타공제2*/		         
					9,	 /* 기타공제3*/		         
					9,	 /* 기타공제4*/              
					9,	 /* 공제합계*/	             
					9,	 /* 실지급액*/               
						                             
					9,	 /* 년차수당*/               
					9,	 /* 전월소급*/               
					9,	 /* 정산건강*/               
					9,	 /* 정산고용*/               
					9,	 /* 정산소득*/               
					9,	 /* 정산주민*/               
					9,   /* 누적소득누계*/
					9,   /* 누적소득액*/  
					9,   /* 누적주민세*/  

					8,	 /* 입사일*/                              
					30,	 /* 직군*/ 	             
					8,	 /* 퇴사일*/              
					9,   /* 산재보험*/	    
					9,   /* 정산연금 */	    
					2,   /* 본사근무일수*/
					2,   /* 현장근무일수*/
					2,   /* 경헙근무일수*/
					3,   /* 상여율*/  
					2,   /* 배우자수 */  
					2,   /* 부모수 */  
					2,   /* 자녀수 */  
					2,   /* 장애인수 */  
					2,   /* 경로우대자수*/
					9,   /* 식대보조*/
          8,    /* 발령일*/
					9,
					9,
					9,
					9,
					8,
					8,
					1,
					30,
          20,   //기타지급제목1    
					20,		//기타지급제목2    
					20,		//기타지급제목3    
					20,		//기타공제제목1    
					20,		//기타공제제목2    
					20,		//기타공제제목3    
					13,		//주민번호  
					9			//상환액
          }; 		
						                              
				int[] intArrCN2 = new int[]{
					-1,  /* 사번 */                 
					-1,	 /* 한글명*/              
					0,	 /* 휴직정직일수*/        
					-1,  /* 년월 */             
					-1,	 /* 급여구분*/               
					-1,  /* 부서코드*/                
					-1,	 /* 부서명*/                
					-1,  /* 직위코드*/                 
					-1,	 /* 직급*/                    
					-1,	 /* 호봉코드 */              
					-1,  /* 은행코드*/                
					-1,	 /* 계좌번호*/              
					-1,  /* 지급일*/                 
					0,	 /* 무계결근일수*/          
					0,	 /* 기본급여*/              
					0,	 /* 직책수당 */              
					0,	 /* 시간외수당 */            
					0,	 /* 근속수당*/              
					0,	 /* 자기계발비 */           
					0,	 /* 부양가족수당*/          
					0,	 /* 차량유지비 */           
					0,	 /* 출납수당*/              
					0,	 /* 운전수당*/              
					0,	 /* 연장수당*/              
					0,	 /* 자격수당*/              
					0,	 /* 남북경협수당*/          
					0,	 /* 사장단수당*/            
					0,	 /* 특수지수당*/            
					0,	 /* 지역근무수당*/          
					0,	 /* 학비보조금*/            
					0,	 /* 개인연금보조금*/        
					0,	 /* 임원직책수당*/          
					0,	 /* 기타지급1*/             
					0,	 /* 기타지급2*/             
					0,	 /* 기타지급3*/             
					0,	 /* 기타지급4*/             
					0,	 /* 지급합계*/              
					0,	 /* 소득세 OR 갑근세*/      
					0,	 /* 주민세*/                
					0,	 /* 건강보험료*/            
					0,	 /* 국민연금*/              
					0,	 /* 고용보험*/              
					0,	 /* 개인연금*/              
					0,	 /* 여직원회비*/            
					0,	 /* 공조회비*/              
					0,	 /* 기타공제1*/		     
					0,	 /* 기타공제2*/		     
					0,	 /* 기타공제3*/		     
					0,	 /* 기타공제4*/             
					0,	 /* 공제합계*/	             
					0,	 /* 실지급액*/              
					0,	 /* 년차수당*/                            
					0,	 /* 전월소급*/              
					0,	 /* 정산건강*/              
					0,	 /* 정산고용*/              
					0,	 /* 정산소득*/              
					0,	 /* 정산주민*/              
					0,	 /* 누적소득누계*/              
					0,	 /* 누적소득액*/              
					0,	 /* 누적주민세*/              
						               
					-1,	 /* 입사일*/           
					-1,	 /* 직군*/ 	             
					-1,	 /* 퇴사일*/               
					0,	 /* 산재보험*/	               
					0,	 /* 정산연금 */	               
					0,	 /* 본사근무일수*/             
					0,	 /* 현장근무일수*/             
					0,	 /* 경헙근무일수*/ 
						
					0,   /* 상여율*/  
					0,   /* 배우자수 */  
					0,   /* 부모수 */  
					0,   /* 자녀수 */  
					0,   /* 장애인수 */  
					0,   /* 경로우대자수*/
					0,   /* 식대보조*/
          -1,   /* 발령일*/
					0,
					0,
					0,
					0,
					-1,
					-1,
					-1,
					-1,
					-1,  //기타지급제목1    
					-1,	 //기타지급제목2    
          -1,	 //기타지급제목3    
					-1,	 //기타공제제목1    
					-1,	 //기타공제제목2    
					-1,	 //기타공제제목3    
					-1,	 //주민번호    
					0		 //상환액
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
					sql.append( "  A.EMPNMK, ");							/* 한글명*/
					sql.append( "  B.NOTWRK, ");							/* 휴직정직 OR 재직구분*/
					sql.append( "  B.APPDT, ");								/* 년월 */
					sql.append( "  I.MINORNM AS PAYDIV, ");		/* 급여구분*/
					sql.append( "  B.DEPTCD, ");							/* 부서코드*/
					sql.append( "  C.DEPTNM AS DEPTNM, ");	  /* 부서명*/
					sql.append( "  E.MINORNM AS PAYGRDNM, ");	/* 직위코드*/
					sql.append( "  F.MINORNM AS GRDDIVNM, ");	/* 직급*/
					sql.append( "  G.MINORNM AS PAYSEQNM, ");	/* 호봉코드 */
					sql.append( "  H.MINORNM AS PAYBNKNM, ");	/* 은행코드*/
					sql.append( "  B.PAYNUM, ");	/*  계좌번호*/
					sql.append( "  B.PAYDT, ");   /*  지급일*/
					sql.append( "  B.DUYNOT, ");	/*  무계결근일수*/
					sql.append( "  B.P10000, ");	/*  기본급여*/
					sql.append( "  B.P11000, ");	/*  직책수당 */
					sql.append( "  B.P12000, ");	/*  시간외수당 */
					sql.append( "  B.P21000, ");	/*  근속수당*/
					sql.append( "  B.P22000, ");	/*  자기계발비 */
					sql.append( "  B.P23000, ");	/*  부양가족*/
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
					sql.append( "  B.P37000, ");	/*  개인연금보조금*/
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
					sql.append( "  B.S94000,  ");	/*  실지급액*/	

					sql.append( "  B.P34000,  ");	/*  년차수당*/
					sql.append( "  B.P39000,  ");	/*  전월소급*/
					sql.append( "  B.P41000,  "); /*  정산건강*/
					sql.append( "  B.P42000,  "); /*  정산고용*/
					sql.append( "  B.T21000,  "); /*  정산소득*/
					sql.append( "  B.T22000,  "); /*  정산주민*/

					sql.append( "  B.TS9100,  "); /*  누적소득누계*/ 
					sql.append( "  B.TT1100,  "); /*  누적소득액*/   
					sql.append( "  B.TT1200,  "); /*  누적주민세*/   
					sql.append( "  RTRIM(A.STRTDT) AS STRTDT,  ");/*입사일*/	
					sql.append( "  D.MINORNM AS JOBGRPHNM,  ");	/*  직군*/	
					sql.append( "  RTRIM(A.ENDDT) AS ENDDT,  ");/*  퇴사일*/	
					sql.append( "  B.B17000,  ");	/*  산재보험*/	
					sql.append( "  B.P43000,  ");	/*  정산연금 */	
					sql.append( "  B.BSDAY,  ");	/*  본사근무일수*/	
					sql.append( "  B.HJDAY,  ");	/*  현장근무일수*/	
					sql.append( "  B.NSDAY,  ");	/*  경헙근무일수*/	
					sql.append( "  B.SANGRAT,  ");/*  상여율*/	
					sql.append( "  B.P23002,  ");	/*  배우자수 */	
					sql.append( "  B.P23003,  ");	/*  부모수*/	
					sql.append( "  B.P23004,  ");	/*  자녀수*/	
					sql.append( "  B.P23005,  ");	/*  장애인수*/	
					sql.append( "  B.P23006,  ");	/*  경로우대자수*/
					sql.append( "  B.P35000,	"); /*  식대    */
                  sql.append( "  RTRIM(A.DPOFFDT) DPOFFDT, ");	/* 발령일자 */
 
					sql.append( "  B.APLAMT,	");	//대출상환원금
					sql.append( "	 B.APLRAT,	"); //대출상환이자
					sql.append( "	 B.APPCNT,	"); //대출상환회수
					sql.append( "	 B.APJAMT,		"); //대출잔액
 
					sql.append( "  B.CHAGDT,  ");  //변경일
					sql.append( "  A.GRSTRTDT,  ");  //그룹입사일
					sql.append( "  A.TRAINYN,  ");  //수습여부
					sql.append( "  RTRIM(K.MINORNM) AS DEPTPRNM, ");  //근무지
					sql.append( "  B.PR0020,  ");  //기타지급제목1
					sql.append( "  B.PR0030,  ");  //기타지급제목2
					sql.append( "  B.PR0040,  ");  //기타지급제목3
					sql.append( "  B.BR0020,  ");  //기타공제제목1
					sql.append( "  B.BR0030,  ");  //기타공제제목2
					sql.append( "  B.BR0040,  ");   //기타공제제목3
          sql.append( "  A.RESINO,  ");   //주민번호
					
					//상환액 이자 테이블 변경 2005.12.24
					sql.append( "  COALESCE((B.APLAMT+B.APLRAT),0) AMT_1 ");	//상환액
					//sql.append( "  COALESCE((L.APLAMT+L.APLRAT),0) AMT_1 ");	//상환액

					sql.append( " FROM  PAYROLL.PBPAY B "); 
					sql.append( " LEFT OUTER JOIN PAYROLL.HIPERSON A ON  B.EMPNO = A.EMPNO   ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT C ON  B.DEPTCD = C.DEPTCD   ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE D ON  B.JOBGRPH = D.MINORCD  AND D.MAJORCD = '2000'  ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE E ON  B.PAYGRD = E.MINORCD   AND E.MAJORCD = '2002'   ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE F ON  B.GRDDIV = F.MINORCD   AND F.MAJORCD = '2001'  ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE G ON  B.PAYSEQ = G.MINORCD   AND G.MAJORCD='1184'  ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE H ON  B.PAYBNK = H.MINORCD   AND H.MAJORCD = '1411'  ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE I ON  B.PAYDIV = I.MINORCD   AND I.MAJORCD = '1120'  ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE K ON  C.DEPTPRT = K.MINORCD  AND K.MAJORCD = '1111'  ");

					if (str[12].equals("T")) sql.append( " LEFT OUTER  JOIN PAYROLL.PCWRKPAY L ON  B.APPDT = L.APPDT     AND B.PAYDIV = L.PAYDIV  AND L.PAYCD IN('P000001', 'P500000') ");
				
				//상환액 이자 테이블 변경 2005.12.24 막음	
				/*	sql.append( " LEFT OUTER JOIN PAYROLL.PWRONPAY L ON  B.EMPNO = L.EMPNO     AND SUBSTR(L.APLDAY,1,6) ='"+str[1]+"' ");
        */

				//	sql.append( " LEFT OUTER  JOIN PAYROLL.HOORDER J ON  B.EMPNO = J.EMPNO " );
				//	sql.append( " AND  J.ORDDT = (SELECT IFNULL(MAX(ORDDT),'') ORDDT FROM PAYROLL.HOORDER  WHERE EMPNO = B.EMPNO ) ");
				//	sql.append( " AND  J.SEQ = (SELECT IFNULL(MAX(SEQ),'') ORDDT FROM PAYROLL.HOORDER  WHERE EMPNO = B.EMPNO )  ");
					 sql.append( " WHERE RTRIM(B.EMPNO) <> '' ");
					 sql.append( " AND B.PAYDIV <> '3'  ");  //퇴직급여 제외  
					
					if (!str[0].equals("")&&!str[0].equals("0")) sql.append( " AND B.PAYDT= '"  + str[0] + "' ");    //지급일자
					if (!str[1].equals("")&&!str[1].equals("0")) sql.append( " AND B.APPDT = '" + str[1]+ "' ");     //적용년월
					if (!str[2].equals("")&&!str[2].equals("0")) sql.append( " AND B.PAYDIV= '"  + str[2] + "' ");   //급여구분
					//if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND B.DEPTCD = '" + str[3]+ "' ");  //부서코드
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append( " AND B.JOBGRPH= '"  + str[4] + "' ");  //직군
												  													   
					if (!str[5].equals("")&&!str[5].equals("0") && (!str[6].equals("")&&!str[6].equals("0")) )
						sql.append( " AND B.EMPNO BETWEEN   '" + str[5]+ "' AND '" + str[6]+ "' ");

					if (!str[7].equals("")&&!str[7].equals("0")) sql.append( " AND A.EMPNMK LIKE '" + str[7]+ "%' ");  //성명
					if (!str[8].equals("")&&!str[8].equals("0")) sql.append( " AND B.PAYGRD= '"  + str[8] + "' "); //직위
					if (!str[9].equals("")&&!str[9].equals("0")) sql.append( " AND B.GRDDIV = '" + str[9]+ "' "); // 직급

          if (str[10].equals("1")) sql.append( " AND SUBSTR(C.TREECD,1,4)= '" + str[11] +"'");
					if (str[10].equals("2")) sql.append( " AND SUBSTR(C.TREECD,1,4)= '" + str[11] + "'");
					if (str[10].equals("3")) sql.append( " AND SUBSTR(C.TREECD,1,6)= '" + str[11] +"'");
					if (str[10].equals("4")) sql.append( " AND RTRIM(B.TREECD)= '" + str[11] + "'");

					if (str[12].equals("T")) sql.append( " AND L.WRKSTS = 'C'  ");  // 

					//임시 - 김민정 대리 요청으로 2005.12 상여만 막음....//
          //if (str[1].equals("200601")&&str[2].equals("1")&&str[12].equals("T")) sql.append( " AND B.PAYDT= '9' ");  
          //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
					
					sql.append( " ORDER BY C.TREECD , A.EMPNMK,B.EMPNO  ");
					logger.dbg.println(this,sql.toString());
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