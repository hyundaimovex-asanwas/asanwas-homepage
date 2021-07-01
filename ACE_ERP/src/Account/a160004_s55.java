package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.//년간월별소득현황
public class a160004_s55 extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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
	실제 업무에서 적용하실 부분-급여지급현황 본사근무자보고서(Fheader 부분)
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				String [] str = new String [2];
				str[0]	= req.getParameter("v_str1");		//지급년월
				str[1]	= req.getParameter("v_str2");		//지급구분

				for (int s=0;s<2;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
					"COUNTR", //이전월 인원수   
					"PAYSUMR", // 총급여*/    
					"BP35000R", // 식대 */   
					"BP24000R", // 차량 */ 
					"S91000R", // 차량+식대*/  
					"T11000R", // 소득세*/    
					"T12000R", // 주민세*/      
					"BXTOTALR", // 기타공제계*/      
					"S93000R", // 공제합계*/  
					"S94000R",  //실지급액              
					"CYYYY",   //현재년           
					"CMM"     //현재월             
				};

				int[] intArrCN = new int[]{  
					9,  //이전월 인원수 
					9,  // 총급여*/    
					9,  // 식대 */    
					9, // 차량 */    
					9, // 차량+식대*/  
					9,  // 소득세*/    
					9,  // 주민세*/    
					9,  // 기타공제계*
  					9,  //공제합계     
					9,   //실지급액              					         
					4,   //현재년   
					2  ///현재월/         
            	}; 

				int[] intArrCN2 = new int[]{
					0,  //이전월 인원수 
					0,  // 총급여*/     
					0,  // 식대 */      
					0, // 차량 */       
					0, // 차량+식대*/   
					0,  // 소득세*/     
					0,  // 주민세*/     
					0,  // 기타공제계*  
					0,  //공제합계      
					0,   //실지급액     
					-1,   //현재년                    
					-1  ///현재월/           
					}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();		/*REPORT 1.본사(임원)*/
					sql.append(" SELECT  \n ");
					sql.append("  COALESCE(B.COUNTR,0) AS COUNTR, --현재월 인원수 */						\n ");
					sql.append("  COALESCE(B.PAYSUMR,0) AS PAYSUMR, -- 총급여*/                              \n ");
					sql.append("  COALESCE(B.BP35000R,0) AS BP35000R, -- 식대 */                             \n ");
					sql.append("  COALESCE(B.BP24000R,0) AS BP24000R, --  차량*/                          \n ");
					sql.append("  COALESCE(B.S91000R,0) AS S91000R, -- 차량+식대 */                          \n ");
					sql.append("  COALESCE(B.T11000R,0) AS T11000R, -- 소득세*/                                \n ");
					sql.append("  COALESCE(B.T12000R,0) AS T12000R, -- 주민세*/                                \n ");
					sql.append("  COALESCE(B.BXTOTALR,0) AS BXTOTALR,   --기타공제계*/                         \n ");
					sql.append("  COALESCE(B.S93000R,0) AS S93000R, -- 공제합계*/                              \n ");
					sql.append("  COALESCE(B.S94000R,0) AS S94000R, -- 실지급액*/                              \n ");
					sql.append("  '"+str[0].substring(0,4)+"' AS CYYYY, --현재년 */                            \n ");
					sql.append("  '"+str[0].substring(4,6)+"' AS CMM   --현재월 */                            \n ");
					sql.append("    FROM                                               \n ");
					sql.append(" (SELECT                                               \n ");
					sql.append("  COUNT(B.EMPNO) AS COUNTR,														\n ");
					sql.append("  SUM(B.P35000) AS P35000R,-- 비과세 식대*/				 						\n ");
					sql.append("  SUM(B.P24000) AS P24000R,-- 과세 차량 */										\n ");
					sql.append("  SUM(H.BP35000) AS BP35000R,-- 비과세 식대*/									\n ");
					sql.append("  SUM(H.GP35000) AS GP35000R,-- 과세 식*/											\n ");
					sql.append("  SUM(H.BP24000) AS BP24000R,-- 비과세 차량 */									\n ");
					sql.append("  SUM(H.GP24000) AS GP24000R,-- 과세 차량 */									\n ");
					sql.append("  (SUM(B.P10000)+																\n ");
					sql.append("  SUM(B.P11000)+							-- 직책수당 */						\n ");
					sql.append("  SUM(B.P11000)+							-- 시간외수당 */					\n ");
 					sql.append("  SUM(B.P21000)+							--근속수당*/						\n ");
					sql.append("  SUM(B.P22000)+							--자기계발비 */						\n ");
					sql.append("  SUM(B.P23000)+							--부양가족수당*/					\n ");
					sql.append("  SUM(H.GP24000)+							--차량유지비 */						\n ");
					sql.append("  SUM(B.P25000)+							--출납수당*/						\n ");
					sql.append("  SUM(B.P26000)+							--운전수당*/						\n ");
					sql.append("  SUM(B.P27000)+							--연장수당*/						\n ");
					sql.append("  SUM(B.P28000)+							--자격수당*/						\n ");
					sql.append("  SUM(B.P29000)+							--남북경협수당*/					\n ");
					sql.append("  SUM(B.P30000)+							--사장단수당*/						\n ");
					sql.append("  SUM(B.P31000)+							--특수지수당*/						\n ");
					sql.append("  SUM(B.P32000)+							--지역근무수당*/					\n ");
					sql.append("  SUM(B.P33000)+							--월차수당*/						\n ");
					sql.append("  SUM(B.P34000)+							--연차수당*/						\n ");
					sql.append("  SUM(H.GP35000)+								--식대*/						\n ");
					sql.append("  SUM(B.P36000)+							--학비보조금*/						\n ");
					sql.append("  SUM(B.P37000)+							--개인연금보조금*/					\n ");
					sql.append("  SUM(B.P38000)+							--임원직책수당*/					\n ");
					sql.append("  SUM(B.P39000))						--전월소급*/							\n ");
					sql.append("  AS PAYSUMR,							--급여*/								\n ");
					sql.append( " SUM(B.S91000)AS S91000R,    --차량+식대*/							\n"); 
					sql.append("  SUM(B.T11000) AS T11000R, -- 소득세*/											\n ");			
					sql.append("  SUM(B.T12000) AS T12000R, -- 주민세*/											\n ");	
					sql.append("  (SUM(B.B11000)+						 -- 건강보험료*/						\n ");			
					sql.append("  SUM(B.B12000)+							 -- 국민연금*/	 					\n ");
					sql.append("  SUM(B.B13000)+																\n ");
					sql.append("  SUM(B.B14000)+							--여직원회비*/						\n ");
					sql.append("  SUM(B.B15000)+							--개인연금*/						\n ");
					sql.append("  SUM(B.B16000)+							--공조회비*/						\n ");
					sql.append("  SUM(B.BX0010)+							--기타공제1*/						\n ");
					sql.append("  SUM(B.BX0020)+							--기타공제2*/						\n ");
					sql.append("  SUM(B.BX0030)+							--기타공제3*/						\n ");
					sql.append("  SUM(B.BX0040)+																\n ");	
					sql.append("  SUM(B.APLAMT)+																\n ");
					sql.append("  SUM(B.APLRAT))																\n ");
					sql.append("  AS BXTOTALR ,	             --기타공제계*/										\n ");
					sql.append("  SUM(B.S93000) AS S93000R, -- 공제합계*/										\n ");
					sql.append("  SUM(B.S94000) AS S94000R  -- 실지급액*/										\n ");	
					sql.append("  FROM PAYROLL.PBPAY B                                 \n ");
					sql.append( " LEFT JOIN (  SELECT   G.EMPNO, G.APPDT, G.PAYDIV, \n");
					sql.append( "					    CASE WHEN G.P35000 > 100000 THEN  (G.P35000 - 100000) ELSE 0 END GP35000 , \n"); //과세식대 , 10만원보다 크면 -10만원한 것이 과세 , 작으면 0이 과세
					sql.append( "					    CASE WHEN G.P35000 >= 100000 THEN  100000 ELSE G.P35000 END BP35000 , \n"); //비과세식대 10만원>= 10= 비과세, 더 작으면 식대가 비과세
					sql.append( "						CASE WHEN G.P24000 > 200000 THEN  (G.P24000 - 200000) ELSE 0 END GP24000 , \n"); //과세차량 , 20> -20만원=  과세 , 작으면 0이 과세
					sql.append( "						CASE WHEN G.P24000 >= 200000 THEN  200000 ELSE G.P24000 END BP24000 \n"); //비과세차량, 20>= 20만원 비과세, < 차량이가 비과세
					sql.append( "        FROM PAYROLL.PBPAY G)H ON B.EMPNO = H.EMPNO AND H.APPDT ='"  + str[0] + "' AND H.PAYDIV ='"+str[1]+"' \n");					
					sql.append("  WHERE B.APPDT='"  + str[0] + "'                      \n ");
					sql.append( " AND B.DEPTCD IN(SELECT DEPTCD FROM PAYROLL.HCDEPT WHERE GROUPID='01'  AND USEYN='T' AND CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) ) "); //본사
					if (str[1].equals("1")) sql.append( " AND B.PAYDIV IN( '1') "); //지급구분
					if (str[1].equals("5")) sql.append( " AND B.PAYDIV IN( '5')					"); //지급구분
					sql.append("  GROUP BY B.APPDT ");
					sql.append("  ) B ");
         
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