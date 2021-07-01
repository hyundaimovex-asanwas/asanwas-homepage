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
public class h100009_s2 extends HttpServlet {

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
	실제 업무에서 적용하실 부분-급여지급현황 총인원보고서(Fheader 부분)
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				String [] str = new String [8];
				str[0]	= req.getParameter("v_str1");		//지급년월
				str[1]	= req.getParameter("v_str2");		//지급년월까지
				str[2]	= req.getParameter("v_str3");		//지급구분
				str[3]	= req.getParameter("v_str4");		//부서
				str[4]	= req.getParameter("v_str5");		//직군
				str[5]	= req.getParameter("v_str6");		//직위
				str[6]	= req.getParameter("v_str7");		//직급
				str[7]	= req.getParameter("v_str8");		//직급

				for (int s=0;s<8;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
					"COUNTP", // 이전월 인원수   
					"P10000", // 기본급여*/     
					"P11000", // 직책수당 */
					"P30000", /* 사장단수당-현장수당*/
					"P31000", /* 특수지수당 - 북측근무수당*/
					"P12000", // 시간외수당 */  
					"PXTOTAL",// 기타지급4*/   
					"S91000", // 지급합계*/     
					"T11000", // 소득세*/       
					"T12000", // 주민세*/       
					"B11000", // 건강보험료*/   
					"B12000", // 국민연금*/     
					"BXTOTAL",                 
					"S93000",// 공제합계*/      
					"S94000",// 실지급액*/
					"B13000",
					"B23000",
					"B17000",
					"B23170",
					"CYYYYO", //이전년          
					"CMMO",    //이전월         
					"COUNTR", //이전월 인원수   
					"P10000R", // 기본급여*/    
					"P11000R", // 직책수당 */  
					"P30000R", /* 사장단수당-현장수당*/         
					"P31000R", /* 특수지수당 - 북측근무수당*/   
					"P12000R", // 시간외수당 */ 
					"PXTOTALR", // 기타지급4*/  
					"S91000R", // 지급합계*/    
					"T11000R", // 소득세*/      
					"T12000R", // 주민세*/      
					"B11000R", // 건강보험료*/  
					"B12000R", // 국민연금*/    
					"BXTOTALR",                
					"S93000R", // 공제합계*/    
					"S94000R", // 실지급액*/  
					"B13000R",
					"B23000R",
					"B17000R",
					"B23170R",
					"CYYYY",   //현재년           
					"CMM",     //현재월           
					"TODATEE",  //오늘날짜    
					"CTITLE"   //제목 
				};

				int[] intArrCN = new int[]{  
					6, // 이전월 인원수   
					9, // 기본급여*/     
					9, // 직책수당 */
					9,/* 사장단수당-현장수당*/       
					9,/* 특수지수당 - 북측근무수당*/ 
					9, // 시간외수당 */  
					9, // 기타지급4*/   
					9, // 지급합계*/     
					9, // 소득세*/       
					9, // 주민세*/       
					9, // 건강보험료*/   
					9, // 국민연금*/     
					9,                 
					9,// 공제합계*/      
					9,// 실지급액*/ 
					9,9,9,9,
					4, //이전년          
					2,    //이전월         
					9, //이전월 인원수   
					9, // 기본급여*/    
					9, // 직책수당 */
					9,/* 사장단수당-현장수당*/         
					9,/* 특수지수당 - 북측근무수당*/   
					9, // 시간외수당 */ 
					9, // 기타지급4*/  
					9, // 지급합계*/    
					9, // 소득세*/      
					9, // 주민세*/      
					9, // 건강보험료*/  
					9, // 국민연금*/    
					9, //현재 기타공제합계               
					9, // 공제합계*/    
					9, // 실지급액*/  
					9,9,9,9,
					4, //현재년           
					2,    //현재월           
					8,    //오늘날짜   
					20  
            	}; 

				int[] intArrCN2 = new int[]{
					0, // 이전월 인원수   
					0, // 기본급여*/     
					0, // 직책수당 */ 
					0,/* 사장단수당-현장수당*/       
					0,/* 특수지수당 - 북측근무수당*/ 
					0, // 시간외수당 */  
					0, // 기타지급4*/   
					0, // 지급합계*/     
					0, // 소득세*/       
					0, // 주민세*/       
					0, // 건강보험료*/   
					0, // 국민연금*/     
					0,                 
					0,// 공제합계*/      
					0,// 실지급액*/    
					0,0,0,0,
					-1, //이전년          
					-1,    //이전월         
					0, //이전월 인원수   
					0, // 기본급여*/    
					0, // 직책수당 */
					0, /* 사장단수당-현장수당*/         
					0, /* 특수지수당 - 북측근무수당*/   
					0, // 시간외수당 */ 
					0, // 기타지급4*/  
					0, // 지급합계*/    
					0, // 소득세*/      
					0, // 주민세*/      
					0, // 건강보험료*/  
					0, // 국민연금*/    
					0, //현재 기타공제합계               
					0, // 공제합계*/    
					0, // 실지급액*/
					0,0,0,0,
					-1, //현재년           
					-1, //현재월           
					-1, //오늘날짜  
					-1  //제목
					}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();	/*REPORT 1.총인원*/
					sql.append(" SELECT  \n ");
					sql.append("  COALESCE(A.COUNTP,0) AS COUNTP, --이전월 인원수*/                            \n ");
					sql.append("  COALESCE(A.P10000,0) AS P10000, -- 기본급여*/                                \n ");
					sql.append("  COALESCE(A.P11000,0) AS P11000, -- 직책수당 */                               \n ");
					sql.append("  COALESCE(A.P30000,0) AS P30000, -- /* 사장단수당-현장수당*/                  \n ");
					sql.append("  COALESCE(A.P31000,0) AS P31000, -- /* 특수지수당 - 북측근무수당*/            \n ");
					sql.append("  COALESCE(A.P12000,0) AS P12000, -- 시간외수당 */                             \n ");
					sql.append("  COALESCE(A.PXTOTAL,0) AS PXTOTAL, -- 기타지급합계*/                          \n ");
					sql.append("  COALESCE(A.S91000,0) AS S91000, -- 지급합계*/                                \n ");
					sql.append("  COALESCE(A.T11000,0) AS T11000, -- 소득세*/                                  \n ");
					sql.append("  COALESCE(A.T12000,0) AS T12000, -- 주민세*/                                  \n ");
					sql.append("  COALESCE(A.B11000,0) AS B11000, -- 건강보험료*/                              \n ");
					sql.append("  COALESCE(A.B12000,0) AS B12000, -- 국민연금*/                                \n ");
					sql.append("  COALESCE(A.BXTOTAL,0) AS BXTOTAL,                                            \n ");
					sql.append("  COALESCE(A.S93000,0) AS S93000,-- 공제합계*/                                 \n ");
					sql.append("  COALESCE(A.S94000,0) AS S94000,-- 실지급액*/                                 \n ");
					sql.append("  COALESCE(A.B13000,0) AS B13000,-- 고용보험*/                                 \n ");
					sql.append("  COALESCE(A.B23000,0) AS B23000,-- 회사지원고용보험*/                         \n ");
					sql.append("  COALESCE(A.B17000,0) AS B17000,-- 산재보험*/                                 \n ");
					sql.append("  COALESCE(A.B23170,0) AS B23170,-- 회사지원 고용+산재*/                       \n ");
					sql.append("  '"+str[0].substring(0,4)+"' AS CYYYYO, --이전년 */													 \n ");
					sql.append("  '"+str[0].substring(4,6)+"' AS CMMO,    --이전월 */													 \n ");
					sql.append("  COALESCE(B.COUNTR,0) AS COUNTR, --이전월 인원수 */													 \n ");
					sql.append("  COALESCE(B.P10000R,0) AS P10000R, -- 기본급여*/                              \n ");
					sql.append("  COALESCE(B.P11000R,0) AS P11000R, -- 직책수당 */                             \n ");
					sql.append("  COALESCE(B.P30000R,0) AS P30000R, -- /* 사장단수당-현장수당*/                \n ");
					sql.append("  COALESCE(B.P31000R,0) AS P31000R , -- /* 특수지수당 - 북측근무수당*/         \n ");
					sql.append("  COALESCE(B.P12000R,0) AS P12000R, -- 시간외수당 */                           \n ");
					sql.append("  COALESCE(B.PXTOTALR,0) AS PXTOTALR, -- 기타지급4*/                           \n ");
					sql.append("  COALESCE(B.S91000R,0) AS S91000R, -- 지급합계*/                              \n ");
					sql.append("  COALESCE(B.T11000R,0) AS T11000R, -- 소득세*/                                \n ");
					sql.append("  COALESCE(B.T12000R,0) AS T12000R, -- 주민세*/                                \n ");
					sql.append("  COALESCE(B.B11000R,0) AS B11000R, -- 건강보험료*/                            \n ");
					sql.append("  COALESCE(B.B12000R,0) AS B12000R, -- 국민연금*/                              \n ");
					sql.append("  COALESCE(B.BXTOTALR,0) AS BXTOTALR,                                          \n ");
					sql.append("  COALESCE(B.S93000R,0) AS S93000R, -- 공제합계*/                              \n ");
					sql.append("  COALESCE(B.S94000R,0) AS S94000R, -- 실지급액*/                              \n ");
          sql.append("  COALESCE(B.B13000R,0) AS B13000R, -- 고용보험*/                              \n ");
					sql.append("  COALESCE(B.B23000R,0) AS B23000R, -- 회사지원 고용보험*/                     \n ");
					sql.append("  COALESCE(B.B17000R,0) AS B17000R, -- 산재보험*/                              \n ");
					sql.append("  COALESCE(B.B23170R,0) AS B23170R, -- 회사지원 고용+산재*/                    \n ");
					sql.append("  '"+str[1].substring(0,4)+"' AS CYYYY, --현재년 */                            \n ");
					sql.append("  '"+str[1].substring(4,6)+"' AS CMM,   --현재월 */                            \n ");
					sql.append("  RTRIM('" + str[7] + "') AS TODATEE,    --오늘날짜*/													 \n ");
          sql.append("  ''  CTITLE    --제목*/																											 \n ");
					sql.append("  FROM   																																			 \n ");
					sql.append(" (SELECT																																			 \n ");
					sql.append("  COUNT(B.EMPNO) AS COUNTR,																										 \n ");
					sql.append("  SUM(B.P10000) AS P10000R,-- 기본급여*/																			 \n ");
					sql.append("  SUM(B.P11000) AS P11000R,-- 직책수당 */																			 \n ");
					sql.append("  SUM(B.P30000) AS P30000R,-- /* 사장단수당-현장수당*/											   \n ");
					sql.append("  SUM(B.P31000) AS P31000R,-- /* 특수지수당 - 북측근무수당*/									 \n ");
					sql.append("  SUM(B.P12000) AS P12000R,-- 시간외수당 */																		 \n ");
					sql.append("  (SUM(B.P21000)+																															 \n ");
					sql.append("  SUM(B.P22000)+																															 \n ");
					sql.append("  SUM(B.P23000)+																															 \n ");
					sql.append("  SUM(B.P24000)+																															 \n ");
					sql.append("  SUM(B.P25000)+																															 \n ");
					sql.append("  SUM(B.P26000)+																															 \n ");
					sql.append("  SUM(B.P27000)+																															 \n ");
					sql.append("  SUM(B.P28000)+																															 \n ");
					sql.append("  SUM(B.P29000)+																															 \n ");
					sql.append("  SUM(B.P32000)+																															 \n ");
					sql.append("  SUM(B.P33000)+																															 \n ");
					sql.append("  SUM(B.P34000)+																															 \n ");
					sql.append("  SUM(B.P36000)+																															 \n ");
					sql.append("  SUM(B.P37000)+																															 \n ");
					sql.append("  SUM(B.P38000)+																															 \n ");
					sql.append("  SUM(B.P39000)+																															 \n ");
					sql.append("  SUM(B.P35000)+																											    		 \n ");
					sql.append("  SUM(B.PX0010)+																															 \n ");
					sql.append("  SUM(B.PX0020)+																															 \n ");
					sql.append("  SUM(B.PX0030)+																															 \n ");
					sql.append("  SUM(B.PX0040)) AS PXTOTALR, -- 기타지급4*/																	 \n ");			
					sql.append("  SUM(B.S91000) AS S91000R, -- 지급합계*/																			 \n ");			
					sql.append("  SUM(B.T11000) AS T11000R, -- 소득세*/																				 \n ");			
					sql.append("  SUM(B.T12000) AS T12000R, -- 주민세*/																				 \n ");			
					sql.append("  SUM(B.B11000) AS B11000R, -- 건강보험료*/																		 \n ");			
					sql.append("  SUM(B.B12000) AS B12000R, -- 국민연금*/																			 \n ");			
					sql.append("  (SUM(B.P41000)+																															 \n ");
					sql.append("  SUM(B.P42000)+																															 \n ");
					sql.append("  SUM(B.T21000)+																															 \n ");
					sql.append("  SUM(B.T22000)+																															 \n ");
					sql.append("  SUM(B.T23000)+																															 \n ");
					sql.append("  SUM(B.B14000)+																															 \n ");
					sql.append("  SUM(B.B15000)+																															 \n ");
					sql.append("  SUM(B.B16000)+																															 \n ");
					sql.append("  SUM(B.BX0010)+																															 \n ");
					sql.append("  SUM(B.BX0020)+																															 \n ");
					sql.append("  SUM(B.BX0030)+																															 \n ");
					sql.append("  SUM(B.BX0040)+																															 \n ");
					sql.append("  SUM(B.APLAMT)+																															 \n ");
					sql.append("  SUM(B.APLRAT)+SUM(B.COAAMT)+SUM(B.COLAMT))																	 \n ");
					sql.append("  AS BXTOTALR ,																																 \n ");
					sql.append("  SUM(B.S93000) AS S93000R, -- 공제합계*/																			 \n ");
					sql.append("  SUM(B.S94000) AS S94000R, -- 실지급액*/																			 \n ");
					sql.append("  SUM(B.B13000) AS B13000R, -- 고용보험*/																			 \n ");
					sql.append("  SUM(B.B23000) AS B23000R, -- 고용 회사지원*/ 																 \n ");
					sql.append("  SUM(B.B17000) AS B17000R, -- 산재 회사지원*/	  														 \n ");
					sql.append("  SUM(B.B23000)+ SUM(B.B17000) AS B23170R	-- 고용+산재 회사지원*/  						 \n ");
					sql.append("  FROM PAYROLL.PBPAY B																												 \n ");
					sql.append("  WHERE B.APPDT='"  + str[1] + "'																							 \n ");

					if (str[2].equals("1")) sql.append( " AND B.PAYDIV IN ('1','3','4') \n ");   //지급구분
          if (str[2].equals("5"))	sql.append( " AND B.PAYDIV IN ('5') \n ");   //지급구분
          if (str[2].equals("T")) sql.append( " AND B.PAYDIV IN ('T') \n ");   //지급구분	
					if (str[2].equals("K")) sql.append( " AND B.PAYDIV IN ('K') \n ");   //지급구분	

					if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND B.DEPTCD = '" + str[3] + "' \n ");   //부서코드
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append( " AND B.JOBGRPH= '" + str[4] + "' \n ");		//직군
												  													   
					if (!str[5].equals("")&&!str[5].equals("0")) sql.append( " AND B.PAYGRD= '"  + str[5] + "' \n ");		//직위
					if (!str[6].equals("")&&!str[6].equals("0")) sql.append( " AND B.GRDDIV = '" + str[6] + "' \n ");		// 직급
					sql.append("  GROUP BY B.APPDT																														 \n ");
					sql.append("  ) B																																					 \n ");
					sql.append(" LEFT JOIN (SELECT																														 \n ");
					sql.append("  B.APPDT,																																		 \n ");
					sql.append("  COUNT(B.EMPNO) AS COUNTP,																										 \n ");
					sql.append("  SUM(B.P10000) AS P10000,-- 기본급여*/																				 \n ");
					sql.append("  SUM(B.P11000) AS P11000,-- 직책수당 */																			 \n ");
					sql.append("  SUM(B.P30000) AS P30000,/* 사장단수당-현장수당*/														 \n ");
					sql.append("  SUM(B.P31000) AS P31000,/* 특수지수당 - 북측근무수당*/											 \n ");
					sql.append("  SUM(B.P12000) AS P12000,-- 시간외수당 */																		 \n ");
					sql.append("  (SUM(B.P21000)+					--근속수당*/																				 \n "); 
					sql.append("  SUM(B.P22000)+					--자기계발비 */																			 \n ");	 
					sql.append("  SUM(B.P23000)+					--부양가족수당*/																		 \n ");	 
					sql.append("  SUM(B.P24000)+					--차량유지비 */																			 \n ");	 
					sql.append("  SUM(B.P25000)+					--출납수당*/																				 \n ");	 
					sql.append("  SUM(B.P26000)+					--운전수당*/																				 \n ");	 
					sql.append("  SUM(B.P27000)+					--연장수당*/																				 \n ");	 
					sql.append("  SUM(B.P28000)+					--자격수당*/																				 \n ");	 
					sql.append("  SUM(B.P29000)+					--남북경협수당*/																		 \n ");
					sql.append("  SUM(B.P32000)+					--지역근무수당*/																		 \n ");	 
					sql.append("  SUM(B.P33000)+					--월차수당*/																				 \n ");	 
					sql.append("  SUM(B.P34000)+					--연차수당*/																				 \n ");	 
					sql.append("  SUM(B.P36000)+					--학비보조금*/																			 \n ");	 
					sql.append("  SUM(B.P37000)+					--개인연금보조금*/																	 \n ");	 
					sql.append("  SUM(B.P38000)+					--임원직책수당*/																		 \n ");	 
					sql.append("  SUM(B.P39000)+					--전월소급*/																				 \n ");	 
					sql.append("  SUM(B.P35000)+    			--식대*/																					   \n ");	 
					sql.append("  SUM(B.PX0010)+					--기타지급1*/																				 \n ");	 
					sql.append("  SUM(B.PX0020)+					--기타지급2*/																				 \n ");	 
					sql.append("  SUM(B.PX0030)+					--기타지급3*/																				 \n ");	 
					sql.append("  SUM(B.PX0040)) AS PXTOTAL, -- 기타지급합계*/																 \n ");
					sql.append("  SUM(B.S91000) AS S91000,   -- 지급합계*/																		 \n ");
					sql.append("  SUM(B.T11000) AS T11000,   -- 소득세*/																			 \n ");
					sql.append("  SUM(B.T12000) AS T12000,   -- 주민세*/																			 \n ");
					sql.append("  SUM(B.B11000) AS B11000,   -- 건강보험료*/																	 \n ");
					sql.append("  SUM(B.B12000) AS B12000,   -- 국민연금*/																		 \n ");
					sql.append("  (SUM(B.P41000)+         --정산건강보험*																			 \n ");  
					sql.append("  SUM(B.P42000)+          --정산고용보험*/																		 \n "); 
					sql.append("  SUM(B.T21000)+          --정산소득세*/																			 \n "); 
					sql.append("  SUM(B.T22000)+          --정산주민세*/																			 \n "); 
					sql.append("  SUM(B.T23000)+          --정산농특세*/																			 \n "); 
					sql.append("  SUM(B.B14000)+          --여직원회비*/																			 \n "); 
					sql.append("  SUM(B.B15000)+          --개인연금*/																			   \n "); 
					sql.append("  SUM(B.B16000)+          --공조회비*/																				 \n "); 
					sql.append("  SUM(B.BX0010)+          --기타공제1*/																				 \n "); 
					sql.append("  SUM(B.BX0020)+          --기타공제2*/																				 \n "); 
					sql.append("  SUM(B.BX0030)+          --기타공제3*/																				 \n "); 
					sql.append("  SUM(B.BX0040)+																															 \n ");
					sql.append("  SUM(B.APLAMT)+																															 \n ");
					sql.append("  SUM(B.APLRAT)+SUM(B.COAAMT)+SUM(B.COLAMT))																	 \n ");
					sql.append("  AS BXTOTAL,																																	 \n ");
					sql.append("  SUM(B.S93000) AS S93000,-- 공제합계*/																				 \n ");
					sql.append("  SUM(B.S94000) AS S94000,-- 실지급액*/																				 \n ");
          sql.append("  SUM(B.B13000) AS B13000,-- 고용보험*/																				 \n ");
					sql.append("  SUM(B.B23000) AS B23000,-- 고용 회사지원*/																	 \n ");
					sql.append("  SUM(B.B17000) AS B17000,-- 산재 회사지원*/																   \n ");
					sql.append("  SUM(B.B23000)+ SUM(B.B17000) AS B23170 	-- 고용+산재 회사지원*/							 \n ");
					sql.append("  FROM PAYROLL.PBPAY B																												 \n ");
					sql.append("  WHERE B.APPDT='"  + str[0] + "'																							 \n ");
					if (str[2].equals("1")) sql.append( " AND B.PAYDIV IN ('1','3','4') \n ");   //지급구분
					if (str[2].equals("5")) sql.append( " AND B.PAYDIV IN ('5') \n ");   //지급구분
          if (str[2].equals("T")) sql.append( " AND B.PAYDIV IN ('T') \n ");   //지급구분	
          if (str[2].equals("K")) sql.append( " AND B.PAYDIV IN ('K') \n ");   //지급구분	
					
					if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND B.DEPTCD = '" + str[3] + "' \n ");   //부서코드
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append( " AND B.JOBGRPH= '" + str[4] + "' \n ");   //직군코드
					if (!str[5].equals("")&&!str[5].equals("0")) sql.append( " AND B.PAYGRD= '"  + str[5] + "' \n ");		//직위코드
					if (!str[6].equals("")&&!str[6].equals("0")) sql.append( " AND B.GRDDIV = '" + str[6] + "' \n ");		//직급코드
					sql.append("  GROUP BY B.APPDT																														 \n ");
					sql.append("  ) A ON  A.APPDT='"  + str[0] + "'																						 \n ");

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