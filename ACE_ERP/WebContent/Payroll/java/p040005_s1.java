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
public class p040005_s1 extends HttpServlet {

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
				str[0]	= req.getParameter("v_str1");		//퇴사일자부터
				str[1]	= req.getParameter("v_str2");		//퇴사일자까지
				str[2]	= req.getParameter("v_str3");		//성명





				for (int s=0;s<3;s++) {
					if (str[s]==null) str[s] = "";
				}
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
					 "EMPNO",                                             
					 "EMPDIV",  //입사구분 1정규직",2별정직               
					 "EMPNMK",                                            
					 "ENDDT",                                             
					 "DEPTNM", //부서                                     
					 "PAYGRDNM", //직위                                   
					 "STRTDT", //입사일                                   
					 "ENDDT",  //퇴사일                                   
					 "DUYEAR",  //근무년                                  
					 "DUYMM",   //근무월                                  
					 "DUDAY",   //근무일                                  
					 "CADDR01",   //주소                                  
					 "APPYM",                                             
					 "SUM_P1", //기본급여+직책수당+시간외수당 직원   			
					 "SUM_P2", //기본급여+직책수당+시간외수당 직원				
					 "SUM_P3", //기본급여+직책수당+시간외수당 직원				
					 "SUM_P4", //기본급여+직책수당+시간외수당 직원				
					 "BUSPAY1", //상여 1월달                              
					 "BUSPAY2", //상여 3월달                              
					 "BUSPAY3", //상여 5월달                              
					 "BUSPAY4", //상여 7월달                              
					 "BUSPAY5", //상여 9월달                              
					 "BUSPAY6", //상여 11월달                             
					 "BUSPAY7", //상여 12월달(200%)                       
					 "RETRAT",  //최근3개월급여                           
					 "YEAPAY",  //년차수당                                
					 "MONAVG",  //평균급여(기본급여+직책수당+시간외수당 ) 
					 "MONBUS",  //평균상여                                
					 "MONCOM",  //평균수당                                
					 "P21000",  //근속수당                                
					 "P22000",  //자기계발비                              
					 "P24000",  //차량유지비                              
					 "P29000",  //남북경협수당                            
					 "P38000",  //임원직책수당                            
					 "P21000_2",  //근속수당                                
					 "P22000_2",  //자기계발비                              
					 "P24000_2",  //차량유지비                              
					 "P29000_2",  //남북경협수당                            
					 "P38000_2",  //임원직책수당                            
					 "P21000_3",  //근속수당                                
					 "P22000_3",  //자기계발비                              
					 "P24000_3",  //차량유지비                              
					 "P29000_3",  //남북경협수당                            
					 "P38000_3",  //임원직책수당                            
					 "P21000_4",  //근속수당                                
					 "P22000_4",  //자기계발비                              
					 "P24000_4",  //차량유지비                              
					 "P29000_4",  //남북경협수당                            
					 "P38000_4",  //임원직책수당                            
					 "PX0010",  //기타비                    				      
					 "PX0020",  //기타비                				          
					 "PX0030",  //기타비                				          
					 "PX0040",  //기타비                				          
					 "S91000",  //퇴직급여                                
					 "RETPAY",  //퇴직금                                  
					 "T11000",  //갑근세                                  
					 "T12000",  //주민세                                  
					 "B11000",  //건강보험료                              
					 "B12000",  //국민연금                                
					 "B13000",  //고용보험                                
					 "T92000",  //퇴직전환금                    
					 "BX0010",  //기타공제1                               
					 "BX0020",  //기타공제2                               
					 "BX0030",  //기타공제3                               
					 "BX0040"   //기타공제4                               
                                                      				



				};

				int[] intArrCN = new int[]{  
					 7,   //사번                                          
					 4,  //입사구분 1정규직",2별정직               
					 20,   //성명                                         
					 8,    //퇴사일                                         
					 30, //부서                                     
					 30, //직위                                   
					 8, //입사일                                   
					 8,  //퇴사일                                   
					 2,  //근무년                                  
					 2,   //근무월                                  
					 2,   //근무일                                  
					 70,   //주소                                  
					 6,   //적용년도                                          
					 9, //기본급여+직책수당+시간외수당 직원   			
					 9, //기본급여+직책수당+시간외수당 직원				
					 9, //기본급여+직책수당+시간외수당 직원				
					 9, //기본급여+직책수당+시간외수당 직원				
					 9, //상여 1월달                              
					 9, //상여 3월달                              
					 9, //상여 5월달                              
					 9, //상여 7월달                              
					 9, //상여 9월달                              
					 9, //상여 11월달                             
					 9, //상여 12월달(200%)                       
					 10,  //최근3개월급여                           
					 10,  //년차수당                                
					 10,  //평균급여(기본급여+직책수당+시간외수당 ) 
					 10,  //평균상여                                
					 10,  //평균수당                                
					 9,  //근속수당                                
					 9,  //자기계발비                              
					 9,  //차량유지비                              
					 9,  //남북경협수당                            
					 9,  //임원직책수당                            
					 9,  //근속수당                                
					 9,  //자기계발비                              
					 9,  //차량유지비                              
					 9,  //남북경협수당                            
					 9,  //임원직책수당                            
					 9,  //근속수당                                
					 9,  //자기계발비                              
					 9,  //차량유지비                              
					 9,  //남북경협수당                            
					 9,  //임원직책수당                            
					 9,  //근속수당                                
					 9,  //자기계발비                              
					 9,  //차량유지비                              
					 9,  //남북경협수당                            
					 9,  //임원직책수당                            
					 9,  //기타비                    				      
					 9,  //기타비                				          
					 9,  //기타비                				          
					 9,  //기타비                				          
					 9,  //퇴직급여                                
					 10,  //퇴직금                                  
					 9,  //갑근세                                  
					 9,  //주민세                                  
					 9,  //건강보험료                              
					 9,  //국민연금                                
					 9,  //고용보험                                
					 9,  //퇴직전환금                     
					 9,  //기타공제1                               
					 9,  //기타공제2                               
					 9,  //기타공제3                               
					 9   //기타공제4                               

            	}; 

				int[] intArrCN2 = new int[]{
					 -1,   //사번                                          
					 -1,  //입사구분 1정규직",2별정직               
					 -1,   //성명                                         
					 -1,    //퇴사일                                         
					 -1, //부서                                     
					 -1, //직위                                   
					 -1, //입사일                                   
					 -1,  //퇴사일                                   
					 0,  //근무년                                  
					 0,   //근무월                                  
					 0,   //근무일                                  
					 -1,   //주소                                  
					 -1,   //적용년도                                          
					 0, //기본급여+직책수당+시간외수당 직원최근이전0     			
					 0, //기본급여+직책수당+시간외수당 직원	최근이전1  			
					 0, //기본급여+직책수당+시간외수당 직원	최근이전2  			
					 0, //기본급여+직책수당+시간외수당 직원	최근이전3  			
					 0, //상여 1월달                              
					 0, //상여 3월달                              
					 0, //상여 5월달                              
					 0, //상여 7월달                              
					 0, //상여 9월달                              
					 0, //상여 11월달                             
					 0, //상여 12월달(200%)                       
					 0,  //최근3개월급여                           
					 0,  //년차수당                                
					 0,  //평균급여(기본급여+직책수당+시간외수당 ) 
					 0,  //평균상여                                
					 0,  //평균수당                                
					 0,  //근속수당                                
					 0,  //자기계발비                              
					 0,  //차량유지비                              
					 0,  //남북경협수당                            
					 0,  //임원직책수당                            
					 0,  //근속수당                                
					 0,  //자기계발비                              
					 0,  //차량유지비                              
					 0,  //남북경협수당                            
					 0,  //임원직책수당                            
					 0,  //근속수당                                
					 0,  //자기계발비                              
					 0,  //차량유지비                              
					 0,  //남북경협수당                            
					 0,  //임원직책수당                            
					 0,  //근속수당                                
					 0,  //자기계발비                              
					 0,  //차량유지비                              
					 0,  //남북경협수당                            
					 0,  //임원직책수당                            
					 0,  //기타비 최근이전0                   				      
					 0,  //기타비  최근이전1                   				          
					 0,  //기타비  최근이전2                   				          
					 0,  //기타비  최근이전3                  				          
					 0,  //퇴직급여                                
					 0,  //퇴직금                                  
					 0,  //갑근세                                  
					 0,  //주민세                                  
					 0,  //건강보험료                              
					 0,  //국민연금                                
					 0,  //고용보험                                
					 0,  //퇴직전환금                   
					 0,  //기타공제1                               
					 0,  //기타공제2                               
					 0,  //기타공제3                               
					 0   //기타공제4                               


                     }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
sql.append("   SELECT                                                                                  \n");
sql.append("            A.EMPNO,                                                                       \n");
sql.append("            A.EMPDIV,  --입사구분 1정규직,2별정직                                          \n");
sql.append("            A.EMPNMK,                                                                      \n");
sql.append("            A.ENDDT,                                                                       \n");
sql.append("            E.DEPTNM, --부서                                                               \n");
sql.append("            F.MINORNM AS PAYGRDNM, --직위                                                  \n");
sql.append("            A.STRTDT, --입사일                                                             \n");
sql.append("            A.ENDDT,  --퇴사일                                                             \n");
sql.append("            A.DUYEAR,  --근무년                                                            \n");
sql.append("            A.DUYMM,   --근무월                                                            \n");
sql.append("            A.DUDAY,   --근무일                                                            \n");
sql.append("            A.CADDR01,   --주소                                                            \n");
sql.append("            C.APPYM,                                                                       \n");
sql.append("           (C.P10000+C.P11000+C.P12000) AS SUM_P1, --기본급여+직책수당+시간외수당 직원     \n");
sql.append("           (C2.P10000+C2.P11000+C2.P12000) AS SUM_P2, --기본급여+직책수당+시간외수당 직원  \n");
sql.append("           (C3.P10000+C3.P11000+C3.P12000) AS SUM_P3, --기본급여+직책수당+시간외수당 직원  \n");
sql.append("           (C4.P10000+C4.P11000+C4.P12000) AS SUM_P4, --기본급여+직책수당+시간외수당 직원  \n");
sql.append("            B.BUSPAY1, --상여 1월달                                                        \n");
sql.append("            B.BUSPAY2, --상여 3월달                                                        \n");
sql.append("            B.BUSPAY3, --상여 5월달                                                        \n");
sql.append("            B.BUSPAY4, --상여 7월달                                                        \n");
sql.append("            B.BUSPAY5, --상여 9월달                                                        \n");
sql.append("            B.BUSPAY6, --상여 11월달                                                       \n");
sql.append("            B.BUSPAY7, --상여 12월달(200%)                                                 \n");
sql.append("            B.RETRAT,  --최근3개월급여                                                     \n");
sql.append("            B.YEAPAY,  --년차수당                                                          \n");
sql.append("            B.MONAVG,  --평균급여(기본급여+직책수당+시간외수당 )                           \n");
sql.append("            B.MONBUS,  --평균상여                                                          \n");
sql.append("            B.MONCOM,  --평균수당                                                          \n");
sql.append("            C.P21000,  --근속수당                                                          \n");
sql.append("            C.P22000,  --자기계발비                                                        \n");
sql.append("            C.P24000,  --차량유지비                                                        \n");
sql.append("            C.P29000,  --남북경협수당                                                      \n");
sql.append("            C.P38000,  --임원직책수당                                                      \n");
sql.append("            C2.P21000 AS P21000_2,  --근속수당                                             \n");
sql.append("            C2.P22000 AS P22000_2,  --자기계발비                                           \n");
sql.append("            C2.P24000 AS P24000_2,  --차량유지비                                           \n");
sql.append("            C2.P29000 AS P29000_2,  --남북경협수당                                         \n");
sql.append("            C2.P38000 AS P38000_2,  --임원직책수당                                         \n");
sql.append("            C3.P21000 AS P21000_3,  --근속수당                                             \n");
sql.append("            C3.P22000 AS P22000_3,  --자기계발비                                           \n");
sql.append("            C3.P24000 AS P24000_3,  --차량유지비                                           \n");
sql.append("            C3.P29000 AS P29000_3,  --남북경협수당                                         \n");
sql.append("            C3.P38000 AS P38000_3,  --임원직책수당                                         \n");
sql.append("            C4.P21000 AS P21000_4,  --근속수당                                             \n");
sql.append("            C4.P22000 AS P22000_4,  --자기계발비                                           \n");
sql.append("            C4.P24000 AS P24000_4,  --차량유지비                                           \n");
sql.append("            C4.P29000 AS P29000_4,  --남북경협수당                                         \n");
sql.append("            C4.P38000 AS P38000_4,  --임원직책수당                                         \n");
sql.append("            (C.PX0010+C.PX0020+C.PX0030+C.PX0040) AS PX0010, --기타비                      \n");
sql.append("            (C2.PX0010+C2.PX0020+C2.PX0030+C2.PX0040) AS PX0020, --기타비                  \n");
sql.append("            (C3.PX0010+C3.PX0020+C3.PX0030+C3.PX0040) AS PX0030, --기타비                  \n");
sql.append("            (C4.PX0010+C4.PX0020+C4.PX0030+C4.PX0040) AS PX0040, --기타비                  \n");
sql.append("            D.S91000, --퇴직급여                                                           \n");
sql.append("            B.RETPAY, --퇴직금                                                             \n");
sql.append("            D.T11000, --갑근세                                                             \n");
sql.append("            D.T12000, --주민세                                                             \n");
sql.append("            D.B11000, --건강보험료                                                         \n");
sql.append("            D.B12000, --국민연금                                                           \n");
sql.append("            D.B13000, --고용보험                                                           \n");
sql.append("            COALESCE(D.T92000,0) AS T92000, --퇴직전환금                                   \n");
sql.append("            D.BX0010, --기타공제1                                                          \n");
sql.append("            D.BX0020, --기타공제2                                                          \n");
sql.append("            D.BX0030, --기타공제3                                                          \n");
sql.append("            D.BX0040  --기타공제4                                                          \n");
sql.append("   FROM  PAYROLL.PRPAY B                                                                 \n");
sql.append("        LEFT JOIN PAYROLL.HIPERSON A ON A.EMPNO=B.EMPNO                                       \n");
sql.append("        LEFT JOIN PAYROLL.PRAVGPAY C ON A.EMPNO=C.EMPNO  AND C.APPYM=SUBSTR(A.ENDDT,1,6)   \n");
sql.append("        LEFT JOIN PAYROLL.PRAVGPAY C2 ON A.EMPNO=C2.EMPNO                                       \n");
sql.append("        AND C2.APPYM=SUBSTR(CHAR(DATE(SUBSTR(A.ENDDT,1,4) || '-' ||SUBSTR(A.ENDDT,5,2) || '-01')+ -1 MONTH),1,4) || \n");
sql.append("            SUBSTR(CHAR(DATE(SUBSTR(A.ENDDT,1,4) || '-' ||SUBSTR(A.ENDDT,5,2) || '-01')+ -1 MONTH),6,2)      \n");
sql.append("        LEFT JOIN PAYROLL.PRAVGPAY C3 ON A.EMPNO=C3.EMPNO                                       \n");
sql.append("        AND C3.APPYM=SUBSTR(CHAR(DATE(SUBSTR(A.ENDDT,1,4) || '-' ||SUBSTR(A.ENDDT,5,2) || '-01')+ -2 MONTH),1,4) || \n");
sql.append("            SUBSTR(CHAR(DATE(SUBSTR(A.ENDDT,1,4) || '-' ||SUBSTR(A.ENDDT,5,2) || '-01')+ -2 MONTH),6,2)      \n");
sql.append("        LEFT JOIN PAYROLL.PRAVGPAY C4 ON A.EMPNO=C4.EMPNO                                       \n");
sql.append("        AND C4.APPYM=SUBSTR(CHAR(DATE(SUBSTR(A.ENDDT,1,4) || '-' ||SUBSTR(A.ENDDT,5,2) || '-01')+ -3 MONTH),1,4) || \n");
sql.append("            SUBSTR(CHAR(DATE(SUBSTR(A.ENDDT,1,4) || '-' ||SUBSTR(A.ENDDT,5,2) || '-01')+ -3 MONTH),6,2)      \n");
sql.append("        LEFT JOIN PAYROLL.PBPAY D ON A.EMPNO=D.EMPNO AND SUBSTR(A.ENDDT,1,6)=D.APPDT       \n");
sql.append("        LEFT JOIN PAYROLL.HCDEPT E  ON  A.DEPTCD = E.DEPTCD                                \n");
sql.append("        LEFT JOIN PAYROLL.HCLCODE F ON  A.PAYGRD = F.MINORCD  AND F.MAJORCD = '2002'       \n");
sql.append("  WHERE A.EMPNO <> ' '                                                                     \n");
if ( (!str[0].equals("")&&!str[0].equals("0")) && (!str[1].equals("")&&!str[1].equals("0")) )
	sql.append( " AND A.ENDDT BETWEEN  '"  + str[0] + "' AND  '"  + str[1] + "' ");    //퇴사일자
if (!str[2].equals("")&&!str[2].equals("0")) sql.append( " AND A.EMPNMK LIKE '" + str[2]+ "%' ");     //성명

sql.append("          order by a.enddt desc, c.appym desc                                              \n");

					logger.err.println(this,sql.toString());
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