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
public class p020007_s63 extends HttpServlet {

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
	실제 업무에서 적용하실 부분-급여지급현황 상세보고서
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

				for (int s=0;s<7;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
					"SEQ", // 근무지순서   
          "MINORCD", // 근무지코드   
          "DEPTNM", // 근무지명   
					"DCOUNTP", // 이전월 인원수   
					"DP10000", // 기본급여*/     
					"DP11000", // 직책수당 */    
					"DP12000", // 시간외수당 */  
					"DPXTOTAL", // 기타지급4*/   
					"DS91000", // 지급합계*/     
					"DT11000", // 소득세*/       
					"DT12000", // 주민세*/       
					"DB11000", // 건강보험료*/   
					"DB12000", // 국민연금*/     
					"DBXTOTAL",                 
					"DS93000",// 공제합계*/      
					"DS94000",// 실지급액*/
					"DB13000","DB23000","DB17000","DB23170",
					"DCYYYYO", //이전년          
					"DCMMO",    //이전월         
					"DCOUNTR", //이전월 인원수   
					"DP10000R", // 기본급여*/    
					"DP11000R", // 직책수당 */   
					"DP12000R", // 시간외수당 */ 
					"DPXTOTALR", // 기타지급4*/  
					"DS91000R", // 지급합계*/    
					"DT11000R", // 소득세*/      
					"DT12000R", // 주민세*/      
					"DB11000R", // 건강보험료*/  
					"DB12000R", // 국민연금*/    
					"DBXTOTALR",                
					"DS93000R", // 공제합계*/    
					"DS94000R", // 실지급액*/  
					"DB13000R","DB23000R","DB17000R","DB23170R",
					"DCYYYY", //현재년           
					"DCMM"    //현재월           
				};

				int[] intArrCN = new int[]{  
					3, // 근무지순서   
          4, // 근무지코드   
					30, // 근무지명   
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
					9,9,9,9,
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
					9,9,9,9,
					4, //현재년           
					2    //현재월           
          }; 

				int[] intArrCN2 = new int[]{
					0, // 근무지순서   
					-1, // 근무지코드 
					-1, // 근무지명 
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
					0,0,0,0,
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
					0,0,0,0,
					-1, //현재년           
					-1 //현재월           
					}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();		/*3.그외 본부*/
					sql.append(" SELECT																																				 \n ");
					sql.append("  B.SEQ, B.MINORCD, B.DEPTNM,																									 \n ");
					sql.append("  COALESCE(A.COUNTP,0) AS DCOUNTP, -- 이전월 인원수                            \n ");
					sql.append("  COALESCE(A.P10000,0) AS DP10000, -- 기본급여*/                               \n ");
					sql.append("  COALESCE(A.P11000,0) AS DP11000, -- 직책수당 */                              \n ");
					sql.append("  COALESCE(A.P12000,0) AS DP12000, -- 시간외수당 */                            \n ");
					sql.append("  COALESCE(A.PXTOTAL,0) AS DPXTOTAL, -- 기타지급합계*/                         \n ");
					sql.append("  COALESCE(A.S91000,0) AS DS91000, -- 지급합계*/                               \n ");
					sql.append("  COALESCE(A.T11000,0) AS DT11000, -- 소득세*/                                 \n ");
					sql.append("  COALESCE(A.T12000,0) AS DT12000, -- 주민세*/                                 \n ");
					sql.append("  COALESCE(A.B11000,0) AS DB11000, -- 건강보험료*/                             \n ");
					sql.append("  COALESCE(A.B12000,0) AS DB12000, -- 국민연금*/                               \n ");
					sql.append("  COALESCE(A.BXTOTAL,0) AS DBXTOTAL,                                           \n ");
					sql.append("  COALESCE(A.S93000,0) AS DS93000,-- 공제합계*/                                \n ");
					sql.append("  COALESCE(A.S94000,0) AS DS94000,-- 실지급액*/                                \n ");
					sql.append("  COALESCE(A.B13000,0) AS DB13000,-- 고용보험*/                                \n ");
					sql.append("  COALESCE(A.B23000,0) AS DB23000,-- 회사지원고용보험*/                        \n ");
					sql.append("  COALESCE(A.B17000,0) AS DB17000,-- 산재보험*/                                \n ");
					sql.append("  COALESCE(A.B23170,0) AS DB23170,-- 회사지원고용+산재*/                       \n ");
					sql.append("  '"+str[0].substring(0,4)+"' AS DCYYYYO, --이전년                             \n ");
					sql.append("  '"+str[0].substring(4,6)+"' AS DCMMO,    --이전월                            \n ");
					sql.append("  COALESCE(B.COUNTR,0) AS DCOUNTR, --이전월 인원수                             \n ");
					sql.append("  COALESCE(B.P10000R,0) AS DP10000R, -- 기본급여*/                             \n ");
					sql.append("  COALESCE(B.P11000R,0) AS DP11000R, -- 직책수당 */                            \n ");
					sql.append("  COALESCE(B.P12000R,0) AS DP12000R, -- 시간외수당 */                          \n ");
					sql.append("  COALESCE(B.PXTOTALR,0) AS DPXTOTALR, -- 기타지급4*/                          \n ");
					sql.append("  COALESCE(B.S91000R,0) AS DS91000R, -- 지급합계*/                             \n ");
					sql.append("  COALESCE(B.T11000R,0) AS DT11000R, -- 소득세*/                               \n ");
					sql.append("  COALESCE(B.T12000R,0) AS DT12000R, -- 주민세*/                               \n ");
					sql.append("  COALESCE(B.B11000R,0) AS DB11000R, -- 건강보험료*/                           \n ");
					sql.append("  COALESCE(B.B12000R,0) AS DB12000R, -- 국민연금*/                             \n ");
					sql.append("  COALESCE(B.BXTOTALR,0) AS DBXTOTALR,                                         \n ");
					sql.append("  COALESCE(B.S93000R,0) AS DS93000R, -- 공제합계*/                             \n ");
					sql.append("  COALESCE(B.S94000R,0) AS DS94000R, -- 실지급액*/                             \n ");
					sql.append("  COALESCE(B.B13000R,0) AS DB13000R,                                           \n ");
					sql.append("  COALESCE(B.B23000R,0) AS DB23000R,                                           \n ");
					sql.append("  COALESCE(B.B17000R,0) AS DB17000R,                                           \n ");
					sql.append("  COALESCE(B.B23170R,0) AS DB23170R,                                           \n ");
					sql.append("  '"+str[1].substring(0,4)+"' AS DCYYYY, --현재년                              \n ");
					sql.append("  '"+str[1].substring(4,6)+"' AS DCMM    --현재월                              \n ");
					sql.append("    FROM																																			 \n ");
					sql.append("  ( \n ");
					sql.append("  -- 현재                                                                                      \n ");
					sql.append("  SELECT                                                                                       \n ");
					sql.append("     B.PRTSEQ AS SEQ,                                                                          \n ");
 					sql.append("	  (CASE WHEN B.PRTCOD='' THEN 'XXX' ELSE B.PRTCOD END) AS MINORCD,                         	 \n ");
					sql.append("	  (CASE WHEN B.PRTDEPTNM=''THEN 'XXXX' ELSE B.PRTDEPTNM END) AS DEPTNM,                   	 \n ");
					sql.append("     COUNT(B.EMPNO) AS COUNTR,                                                                 \n ");
					sql.append("     SUM(B.P10000) AS P10000R, SUM(B.P11000) AS P11000R, SUM(B.P12000) AS P12000R,             \n ");
					sql.append("    (SUM(B.P21000)+ SUM(B.P22000)+ SUM(B.P23000)+ SUM(B.P24000)+  SUM(B.P25000)+               \n ");
					sql.append("     SUM(B.P26000)+ SUM(B.P27000)+ SUM(B.P28000)+ SUM(B.P29000)+  SUM(B.P30000)+               \n ");
					sql.append("     SUM(B.P31000)+ SUM(B.P32000)+ SUM(B.P33000)+ SUM(B.P34000)+  SUM(B.P36000)+               \n ");
					sql.append("     SUM(B.P37000)+ SUM(B.P38000)+ SUM(B.P39000)+ SUM(B.P35000)+  SUM(B.PX0010)+               \n ");
					sql.append("     SUM(B.PX0020)+ SUM(B.PX0030)+ SUM(B.PX0040)) AS PXTOTALR, -- 기타지급4*/                  \n ");
					sql.append("     SUM(B.S91000) AS S91000R,  SUM(B.T11000) AS T11000R, SUM(B.T12000) AS T12000R,            \n ");
					sql.append("     SUM(B.B11000) AS B11000R,  SUM(B.B12000) AS B12000R,                                      \n ");
					sql.append("    (SUM(B.P41000)+ SUM(B.P42000)+ SUM(B.T21000)+ SUM(B.T22000)+ SUM(B.T23000)+                \n ");
					sql.append("     SUM(B.B14000)+ SUM(B.B15000)+ SUM(B.B16000)+ SUM(B.BX0010)+                               \n ");
					sql.append("     SUM(B.BX0020)+ SUM(B.BX0030)+ SUM(B.BX0040)+ SUM(B.APLAMT)+ SUM(B.APLRAT)+                \n ");
					sql.append("     SUM(B.COAAMT)+ SUM(B.COLAMT)) AS BXTOTALR ,                                               \n ");
					sql.append("     SUM(B.S93000) AS S93000R, -- 공제합계*/                                                   \n ");
					sql.append("     SUM(B.S94000) AS S94000R, -- 실지급액*/                                                   \n ");
					sql.append("     SUM(B.B13000) AS B13000R,		                                                             \n ");
					sql.append("     SUM(B.B23000) AS B23000R,                                                                 \n ");
					sql.append("     SUM(B.B17000) AS B17000R,                                                                 \n ");
					sql.append("     SUM(B.B23000)+ SUM(B.B17000) AS B23170R                                                   \n ");
					sql.append("    FROM PAYROLL.PBPAY B                                                                       \n ");
					sql.append("   WHERE B.APPDT='"  + str[1] + "'                                                             \n ");
					sql.append("     AND (B.PRTCOD<>'01' )                                                                     \n ");
					if (str[2].equals("1")) sql.append( " AND B.PAYDIV IN( '1','3','4') "); //지급구분
					if (str[2].equals("5")) sql.append( " AND B.PAYDIV IN( '5') ");					//지급구분
	        if (str[2].equals("6")) sql.append( " AND B.PAYDIV IN( '6') ");					//지급구분
					if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND B.DEPTCD  = '" + str[3] + "' \n ");	//부서코드
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append( " AND B.JOBGRPH = '" + str[4] + "' \n ");  //직군
					if (!str[5].equals("")&&!str[5].equals("0")) sql.append( " AND B.PAYGRD  = '" + str[5] + "' \n ");	//직위
					if (!str[6].equals("")&&!str[6].equals("0")) sql.append( " AND B.GRDDIV  = '" + str[6] + "' \n ");	//직급			 
					sql.append("   GROUP BY B.PRTSEQ, B.PRTCOD, B.PRTDEPTNM                                                    \n ");
					sql.append("   ORDER BY B.PRTSEQ, B.PRTCOD, B.PRTDEPTNM                                                    \n ");
					sql.append("   )B                                                                                          \n ");
					sql.append("    LEFT JOIN                                                                                  \n ");
					sql.append("  (                                                                                            \n ");
					sql.append("   --이전                                                                                      \n ");
					sql.append("   SELECT                                                                                      \n ");
					sql.append("     B.PRTSEQ AS SEQ,                                                                          \n ");
					sql.append("	  (CASE WHEN B.PRTCOD='' THEN 'XXX' ELSE B.PRTCOD END) AS MINORCD,                         	 \n ");
					sql.append("	  (CASE WHEN B.PRTDEPTNM=''THEN 'XXXX' ELSE B.PRTDEPTNM END) AS DEPTNM,                   	 \n ");
  				sql.append("     COUNT(B.EMPNO) AS COUNTP,                                                                 \n ");
					sql.append("     SUM(B.P10000) AS P10000,SUM(B.P11000) AS P11000,SUM(B.P12000) AS P12000,                  \n ");
					sql.append("    (SUM(B.P21000)+ SUM(B.P22000)+ SUM(B.P23000)+ SUM(B.P24000)+ SUM(B.P25000)+                \n ");
					sql.append("     SUM(B.P26000)+ SUM(B.P27000)+ SUM(B.P28000)+ SUM(B.P29000)+ SUM(B.P30000)+                \n ");
					sql.append("     SUM(B.P31000)+ SUM(B.P32000)+ SUM(B.P33000)+ SUM(B.P34000)+ SUM(B.P36000)+                \n ");
					sql.append("     SUM(B.P37000)+ SUM(B.P38000)+ SUM(B.P39000)+ SUM(B.P35000)+ SUM(B.PX0010)+                \n ");
					sql.append("     SUM(B.PX0020)+ SUM(B.PX0030)+ SUM(B.PX0040)) AS PXTOTAL,                                  \n ");
					sql.append("     SUM(B.S91000) AS S91000, SUM(B.T11000) AS T11000, SUM(B.T12000) AS T12000,                \n ");
					sql.append("     SUM(B.B11000) AS B11000, SUM(B.B12000) AS B12000,                                         \n ");
					sql.append("    (SUM(B.P41000)+ SUM(B.P42000)+ SUM(B.T21000)+ SUM(B.T22000)+ SUM(B.T23000)+                \n ");
					sql.append("     SUM(B.B14000)+ SUM(B.B15000)+ SUM(B.B16000)+ SUM(B.BX0010)+                               \n ");
					sql.append("     SUM(B.BX0020)+ SUM(B.BX0030)+ SUM(B.BX0040)+ SUM(B.APLAMT)+ SUM(B.APLRAT)+                \n ");
					sql.append("     SUM(B.COAAMT)+ SUM(B.COLAMT)) AS BXTOTAL ,                                                \n ");
					sql.append("     SUM(B.S93000) AS S93000, SUM(B.S94000) AS S94000,                                         \n ");
          sql.append("     SUM(B.B13000) AS B13000,		                                                     \n ");
          sql.append("     SUM(B.B23000) AS B23000,                                                        \n ");
          sql.append("     SUM(B.B17000) AS B17000,                                                        \n ");
          sql.append("     SUM(B.B23000)+ SUM(B.B17000) AS B23170                                          \n ");
					sql.append("    FROM PAYROLL.PBPAY B                                                                       \n ");
					sql.append("   WHERE B.APPDT='"  + str[0] + "'                                                             \n ");
					sql.append("     AND (B.PRTCOD<>'01' )                                                    \n ");
					if (str[2].equals("1")) sql.append( " AND B.PAYDIV IN( '1','3','4') "); //지급구분
					if (str[2].equals("5")) sql.append( " AND B.PAYDIV IN( '5') ");					//지급구분
	        if (str[2].equals("6")) sql.append( " AND B.PAYDIV IN( '6') ");					//지급구분
					if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND B.DEPTCD  = '" + str[3] + "' \n ");	//부서코드
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append( " AND B.JOBGRPH = '" + str[4] + "' \n ");  //직군
					if (!str[5].equals("")&&!str[5].equals("0")) sql.append( " AND B.PAYGRD  = '" + str[5] + "' \n ");	//직위
					if (!str[6].equals("")&&!str[6].equals("0")) sql.append( " AND B.GRDDIV  = '" + str[6] + "' \n ");	//직급			
					sql.append("   GROUP BY B.PRTSEQ, B.PRTCOD, B.PRTDEPTNM                                                    \n ");
					sql.append("   --ORDER BY B.PRTSEQ, B.PRTCOD, B.PRTDEPTNM                                                    \n ");
					sql.append("   ) A ON A.MINORCD = B.MINORCD                                                                \n ");
					sql.append("   ORDER BY SEQ, MINORCD, DEPTNM                                                               \n ");

				
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