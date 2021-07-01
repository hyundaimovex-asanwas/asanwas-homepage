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
public class p020007_s4 extends HttpServlet {

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
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
					"COUNTP", // 이전월 인원수   
					"P10000", // 기본급여*/     
					"P11000", // 직책수당 */    
					"P12000", // 시간외수당 */  
					"PXTOTAL", // 기타지급4*/   
					"S91000", // 지급합계*/     
					"T11000", // 소득세*/       
					"T12000", // 주민세*/       
					"B11000", // 건강보험료*/   
					"B12000", // 국민연금*/     
					"BXTOTAL",                 
					"S93000",// 공제합계*/      
					"S94000",// 실지급액*/      
					"CYYYYO", //이전년          
					"CMMO",    //이전월         
					"COUNTR", //이전월 인원수   
					"P10000R", // 기본급여*/    
					"P11000R", // 직책수당 */   
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
					"CYYYY", //현재년           
					"CMM",    //현재월           
					"TODATEE"    //오늘날짜           
				};

				int[] intArrCN = new int[]{  
					6, // 이전월 인원수   
					9, // 기본급여*/     
					9, // 직책수당 */    
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
					4, //이전년          
					2,    //이전월         
					9, //이전월 인원수   
					9, // 기본급여*/    
					9, // 직책수당 */   
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
					4, //현재년           
					2,    //현재월           
					8    //오늘날짜           
            	}; 

				int[] intArrCN2 = new int[]{
					0, // 이전월 인원수   
					0, // 기본급여*/     
					0, // 직책수당 */    
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
					-1, //이전년          
					-1,    //이전월         
					0, //이전월 인원수   
					0, // 기본급여*/    
					0, // 직책수당 */   
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
					-1, //현재년           
					-1, //현재월           
					-1    //오늘날짜           
					}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append(" SELECT                                                 \n ");
					sql.append("  COALESCE(A.COUNTP,0) AS COUNTP, --이전월 인원수                             \n ");
					sql.append("  COALESCE(A.P10000,0) AS P10000, -- 기본급여*/                                \n ");
					sql.append("  COALESCE(A.P11000,0) AS P11000, -- 직책수당 */                               \n ");
					sql.append("  COALESCE(A.P12000,0) AS P12000, -- 시간외수당 */                             \n ");
					sql.append("  COALESCE(A.PXTOTAL,0) AS PXTOTAL, -- 기타지급합계*/                             \n ");
					sql.append("  COALESCE(A.S91000,0) AS S91000, -- 지급합계*/                                \n ");
					sql.append("  COALESCE(A.T11000,0) AS T11000, -- 소득세*/                                 \n ");
					sql.append("  COALESCE(A.T12000,0) AS T12000, -- 주민세*/                                 \n ");
					sql.append("  COALESCE(A.B11000,0) AS B11000, -- 건강보험료*/                             \n ");
					sql.append("  COALESCE(A.B12000,0) AS B12000, -- 국민연금*/                               \n ");
					sql.append("  COALESCE(A.BXTOTAL,0) AS BXTOTAL,                                           \n ");
					sql.append("  COALESCE(A.S93000,0) AS S93000,-- 공제합계*/                                \n ");
					sql.append("  COALESCE(A.S94000,0) AS S94000,-- 실지급액*/                                \n ");
					sql.append("  '"+str[0].substring(0,4)+"' AS CYYYYO, --이전년                                    \n ");
					sql.append("  '"+str[0].substring(4,6)+"' AS CMMO,    --이전월                                   \n ");
					sql.append("  COALESCE(B.COUNTR,0) AS COUNTR, --이전월 인원수                             \n ");
					sql.append("  COALESCE(B.P10000R,0) AS P10000R, -- 기본급여*/                               \n ");
					sql.append("  COALESCE(B.P11000R,0) AS P11000R, -- 직책수당 */                              \n ");
					sql.append("  COALESCE(B.P12000R,0) AS P12000R, -- 시간외수당 */                            \n ");
					sql.append("  COALESCE(B.PXTOTALR,0) AS PXTOTALR, -- 기타지급4*/                            \n ");
					sql.append("  COALESCE(B.S91000R,0) AS S91000R, -- 지급합계*/                               \n ");
					sql.append("  COALESCE(B.T11000R,0) AS T11000R, -- 소득세*/                                \n ");
					sql.append("  COALESCE(B.T12000R,0) AS T12000R, -- 주민세*/                                \n ");
					sql.append("  COALESCE(B.B11000R,0) AS B11000R, -- 건강보험료*/                            \n ");
					sql.append("  COALESCE(B.B12000R,0) AS B12000R, -- 국민연금*/                              \n ");
					sql.append("  COALESCE(B.BXTOTALR,0) AS BXTOTALR,                                          \n ");
					sql.append("  COALESCE(B.S93000R,0) AS S93000R, -- 공제합계*/                               \n ");
					sql.append("  COALESCE(B.S94000R,0) AS S94000R, -- 실지급액*/                               \n ");
					sql.append("  '"+str[1].substring(0,4)+"' AS CYYYY, --현재년                                     \n ");
					sql.append("  '"+str[1].substring(4,6)+"' AS CMM,    --현재월                                     \n ");
					sql.append("  RTRIM('" + str[7] + "') AS TODATEE    --오늘날짜              \n ");
					sql.append("    FROM                                                \n ");


					sql.append(" (SELECT                                                \n ");
					sql.append("  COUNT(B.EMPNO) AS COUNTR,                             \n ");
					sql.append("  SUM(B.P10000) AS P10000R,-- 기본급여*/                \n ");
					sql.append("  SUM(B.P11000) AS P11000R,-- 직책수당 */               \n ");
					sql.append("  SUM(B.P12000) AS P12000R,-- 시간외수당 */             \n ");
					sql.append("  (SUM(B.P21000)+               ");
					sql.append("  SUM(B.P22000)+                ");
					sql.append("  SUM(B.P23000)+                ");
					sql.append("  SUM(B.P24000)+                ");
					sql.append("  SUM(B.P25000)+                ");
					sql.append("  SUM(B.P26000)+                ");
					sql.append("  SUM(B.P27000)+                ");
					sql.append("  SUM(B.P28000)+                ");
					sql.append("  SUM(B.P29000)+                ");
					sql.append("  SUM(B.P30000)+                ");
					sql.append("  SUM(B.P31000)+                ");
					sql.append("  SUM(B.P32000)+                ");
					sql.append("  SUM(B.P33000)+                ");
					sql.append("  SUM(B.P34000)+                ");
					sql.append("  SUM(B.P36000)+                ");
					sql.append("  SUM(B.P37000)+                ");
					sql.append("  SUM(B.P38000)+                ");
					sql.append("  SUM(B.P39000)+                ");
					sql.append("  SUM(B.P35000)+                ");
					sql.append("  SUM(B.PX0010)+                ");
					sql.append("  SUM(B.PX0020)+                ");
					sql.append("  SUM(B.PX0030)+                ");
					sql.append("  SUM(B.PX0040)) AS PXTOTALR, -- 기타지급4*/            \n ");
					sql.append("  SUM(B.S91000) AS S91000R, -- 지급합계*/               \n ");
					sql.append("  SUM(B.T11000) AS T11000R, -- 소득세*/                 \n ");
					sql.append("  SUM(B.T12000) AS T12000R, -- 주민세*/                 \n ");
					sql.append("  SUM(B.B11000) AS B11000R, -- 건강보험료*/             \n ");
					sql.append("  SUM(B.B12000) AS B12000R, -- 국민연금*/               \n ");
					sql.append("  (SUM(B.P41000)+ ");
					sql.append("  SUM(B.P42000)+ ");
					sql.append("  SUM(B.T21000)+ ");
					sql.append("  SUM(B.T22000)+ ");
					sql.append("  SUM(B.T23000)+ ");
					sql.append("  SUM(B.B13000)+ ");
					sql.append("  SUM(B.B14000)+ ");
					sql.append("  SUM(B.B15000)+ ");
					sql.append("  SUM(B.B16000)+ ");
					sql.append("  SUM(B.BX0010)+ ");
					sql.append("  SUM(B.BX0020)+ ");
					sql.append("  SUM(B.BX0030)+ ");
					sql.append("  SUM(B.BX0040)+ ");
					sql.append("  SUM(B.T31000)+ ");
					sql.append("  SUM(B.T33000)+ ");
					sql.append("  SUM(B.T92000)) ");
					sql.append("  AS BXTOTALR ,                                         \n ");
					sql.append("  SUM(B.S93000) AS S93000R, -- 공제합계*/                \n ");
					sql.append("  SUM(B.S94000) AS S94000R  -- 실지급액*/                \n ");
					sql.append("  FROM PAYROLL.PBPAY B                                  \n ");
					sql.append("  WHERE B.APPDT='"  + str[1] + "'                       \n ");
					if (!str[2].equals("")&&!str[2].equals("0")) sql.append( " AND B.PAYDIV= '"  + str[2] + "' ");   //지급구분
					if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND B.DEPTCD = '" + str[3]+ "' ");    //부서코드
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append( " AND B.JOBGRPH= '"  + str[4] + "' ");  //직군
												  													   
					if (!str[5].equals("")&&!str[5].equals("0")) sql.append( " AND B.PAYGRD= '"  + str[5] + "' "); //직위
					if (!str[6].equals("")&&!str[6].equals("0")) sql.append( " AND B.GRDDIV = '" + str[6]+ "' "); // 직급
					sql.append("  GROUP BY B.APPDT ");
					sql.append("  ) B                                                   ");

					sql.append(" LEFT JOIN (SELECT                                                \n ");
					sql.append("  B.APPDT,                             \n ");
					sql.append("  COUNT(B.EMPNO) AS COUNTP,                             \n ");
					sql.append("  SUM(B.P10000) AS P10000,-- 기본급여*/                 \n ");
					sql.append("  SUM(B.P11000) AS P11000,-- 직책수당 */                \n ");
					sql.append("  SUM(B.P12000) AS P12000,-- 시간외수당 */              \n ");
					sql.append("  (SUM(B.P21000)+                  ");   // 근속수당*/      
					sql.append("  SUM(B.P22000)+                   ");	// 자기계발비 */    
					sql.append("  SUM(B.P23000)+                   ");	// 부양가족수당*/   
					sql.append("  SUM(B.P24000)+                   ");	// 차량유지비 */    
					sql.append("  SUM(B.P25000)+                   ");	// 출납수당*/       
					sql.append("  SUM(B.P26000)+                   ");	// 운전수당*/       
					sql.append("  SUM(B.P27000)+                   ");	// 연장수당*/       
					sql.append("  SUM(B.P28000)+                   ");	// 자격수당*/       
					sql.append("  SUM(B.P29000)+                   ");	// 남북경협수당*/   
					sql.append("  SUM(B.P30000)+                   ");	// 사장단수당*/     
					sql.append("  SUM(B.P31000)+                   ");	// 특수지수당*/     
					sql.append("  SUM(B.P32000)+                   ");	// 지역근무수당*/   
					sql.append("  SUM(B.P33000)+                   ");	// 월차수당*/       
					sql.append("  SUM(B.P34000)+                   ");	// 연차수당*/       
					sql.append("  SUM(B.P36000)+                   ");	// 학비보조금*/     
					sql.append("  SUM(B.P37000)+                   ");	// 개인연금보조금*/ 
					sql.append("  SUM(B.P38000)+                   ");	// 임원직책수당*/   
					sql.append("  SUM(B.P39000)+                   ");	// 전월소급*/       
					sql.append("  SUM(B.P35000)+                   ");	// 상여금*/         
					sql.append("  SUM(B.PX0010)+                   ");	// 기타지급1*/      
					sql.append("  SUM(B.PX0020)+                   ");	// 기타지급2*/      
					sql.append("  SUM(B.PX0030)+                   ");	// 기타지급3*/      
					sql.append("  SUM(B.PX0040)) AS PXTOTAL, -- 기타지급합계*/             \n ");
					sql.append("  SUM(B.S91000) AS S91000,   -- 지급합계*/                 \n ");
					sql.append("  SUM(B.T11000) AS T11000,   -- 소득세*/                  \n ");
					sql.append("  SUM(B.T12000) AS T12000,  -- 주민세*/                  \n ");
					sql.append("  SUM(B.B11000) AS B11000,  -- 건강보험료*/              \n ");
					sql.append("  SUM(B.B12000) AS B12000,  -- 국민연금*/                \n ");
					sql.append("  (SUM(B.P41000)+                     ");  // 정산건강보험*
					sql.append("  SUM(B.P42000)+                       "); // 정산고용보험*/
					sql.append("  SUM(B.T21000)+                       "); // 정산소득세*/  
					sql.append("  SUM(B.T22000)+                       "); // 정산주민세*/  
					sql.append("  SUM(B.T23000)+                       "); // 정산농특세*/  
					sql.append("                                       ");                  
					sql.append("  SUM(B.B13000)+                       "); // 고용보험*/    
					sql.append("  SUM(B.B14000)+                       "); // 여직원회비*/  
					sql.append("  SUM(B.B15000)+                       "); // 개인연금*/    
					sql.append("  SUM(B.B16000)+                       "); // 공조회비*/    
					sql.append("  SUM(B.BX0010)+                       "); // 기타공제1*/   
					sql.append("  SUM(B.BX0020)+                       "); // 기타공제2*/   
					sql.append("  SUM(B.BX0030)+                       "); // 기타공제3*/   
					sql.append("  SUM(B.BX0040)+                       "); // 기타공제4*/   
					sql.append("  SUM(B.T31000)+                       "); // 추징소득세*/  
					sql.append("  SUM(B.T33000)+                       "); // 추징주민세*/  
					sql.append("  SUM(B.T92000))                       "); // 퇴직전환금*/  
					sql.append("  AS BXTOTAL ,                                          \n ");
					sql.append("  SUM(B.S93000) AS S93000,-- 공제합계*/                 \n ");
					sql.append("  SUM(B.S94000) AS S94000 -- 실지급액*/                 \n ");
					sql.append("  FROM PAYROLL.PBPAY B                                  \n ");
					sql.append("  WHERE B.APPDT='"  + str[0] + "'                       \n ");
					if (!str[2].equals("")&&!str[2].equals("0")) sql.append( " AND B.PAYDIV= '"  + str[2] + "' \n ");   //지급구분
					if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND B.DEPTCD = '" + str[3]+ "' \n ");    //부서코드
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append( " AND B.JOBGRPH= '"  + str[4] + "' \n ");  //직군
												  													   
					if (!str[5].equals("")&&!str[5].equals("0")) sql.append( " AND B.PAYGRD= '"  + str[5] + "' \n "); //직위
					if (!str[6].equals("")&&!str[6].equals("0")) sql.append( " AND B.GRDDIV = '" + str[6]+ "' \n "); // 직급
					sql.append("  GROUP BY B.APPDT                                      \n ");
					sql.append("  ) A ON  A.APPDT='"  + str[0] + "'                                                 \n ");



					
					//logger.err.println(this,sql.toString());
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