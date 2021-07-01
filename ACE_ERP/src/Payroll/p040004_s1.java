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
public class p040004_s1 extends HttpServlet {

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

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
					 "APPDT",			//년월
					 "EMPNO",			//사번                                          
					 "EMPDIV",		//입사구분 1정규직",2별정직               
					 "EMPNMK",		//성명                                          
					 "DEPTNM",		//부서                                     
					 "PAYGRDNM",	//직위
					 "STRTDT",		//입사일                                   
					 "ENDDT",			//퇴사일                                   
					 "DUYEAR",		//근무년                                  
					 "DUYMM",			//근무월                                  
					 "DUDAY",			//근무일                                  
					 "CADDR01",   //주소 1                                 
					 "CADDR02",   //주소 2                                 
					 "BASDAY1",		//근무일 급여(기본급+직책수당+시간외수당)                                   
					 "BASDAY2",		//근무일 급여(기본급+직책수당+시간외수당)                                   
					 "BASDAY3",		//근무일 급여(기본급+직책수당+시간외수당)                                  
					 "BASDAY4",   //근무일 급여(기본급+직책수당+시간외수당)
					 "BASMAX1",   //정근무/기타근무 월끝일                                 
					 "BASMAX2",   //정근무/기타근무 월끝일                               
					 "BASMAX3",   //정근무/기타근무 월끝일
					 "BASMAX4",   //정근무/기타근무 월끝일
					 "BASAMT1",   //급여(기본급+직책수당+시간외수당)                                  
					 "BASAMT2",   //급여(기본급+직책수당+시간외수당)                                  
					 "BASAMT3",   //급여(기본급+직책수당+시간외수당)
					 "BASAMT4",   //급여(기본급+직책수당+시간외수당)
					 "BASBUS1",   //상여 3월                                  
					 "BASBUS2",   //상여 12,1월                                  
					 "BASBUS3",   //상여 9,11월
					 "BASBUS4",   //상여 5,7월
					 "BAEDAY1",		//기타근무일 (기타수당)                                 
					 "BAEDAY2",		//기타근무일 (기타수당)                                   
					 "BAEDAY3",		//기타근무일 (기타수당)                                  
					 "BAEDAY4",		//기타근무일 (기타수당)    
					 "BAEAMT1",		//기타수당액                                  
					 "BAEAMT2",		//기타수당액                                   
					 "BAEAMT3",		//기타수당액                                  
					 "BAEAMT4",		//기타수당액    
					 "YEAQTY",		//년차일수                                  
					 "YEAPAY",		//년차수당                                   
					 "AVGYER",		//평균년차수당  
					 "AVGAMT",		//평균급여    
					 "AVGBOS",		//평균상여    
					 "AVGETC",		//평균기타수당    
					 "P21000",		//근속수당    
					 "P22000",		//자기계발비    
					 "P24000",		//차량유지비    
					 "P29000",		//남북경협수당    
					 "P38000",		//임원직책수당
					 "P27000",    //연장수당  추가
					 "PX0000",		//기타수당    
					 "JUSPAY",		//급여    
					 "JUSRET",		//퇴직금    
					 "JUSYER",		//년차수당    
					 "JUSBOS",		//상여    
					 "S91000",		//지급합계    
					 "S94000",		//실지급액    
					 "T21000",		//갑근세-소득세                             
					 "T22000",		//주민세                              
					 "T23000",		//갑근세-소득세                             
					 "T24000",		//주민세                              
					 "P43000",		//국민연금                              
					 "P41000",		//건강보험                              
					 "P42000",		//고용보험                           
					 "RETJUH",		//퇴직전환금 
					 "BX0010",		//기타공제1
					 "BX0020",		//기타공제2                                
					 "BX0030",		//기타공제3                                
					 "BX0040",		//기타공제4
 					 "S93000",		//공제합계                               
 					 "RESINO",		//공제합계                               
					 
					 "REF1",			
					 "REF2",			
					 "REF3",			
					 "REF4",
					 "REF"
				};

				int[] intArrCN = new int[]{  

					 6,						//년월                                    
					 7,     			//사번                                    
					 4, 					//입사구분 1정규직",2별정직               
					 20,    			//성명                                    
					 40,					//부서                                    
					 30,					//직위                                    
					 8, 					//입사일                                  
					 8, 					//퇴사일                                  
					 2, 					//근무년                                  
					 2, 					//근무월                                  
					 2, 					//근무일                                  
					 70,					//주소 1                                  
					 70,					//주소 2                                  
					 2,           //근무일 급여(기본급+직책수당+시간외수당)                      
					 2,           //근무일 급여(기본급+직책수당+시간외수당)                       
					 2,           //근무일 급여(기본급+직책수당+시간외수당)                      
					 2, 					//근무일 급여(기본급+직책수당+시간외수당) 
					 2,           //정근무/기타근무 월끝일                    
					 2,           // 정근무/기타근무 월끝일                    
					 2, 					// 정근무/기타근무 월끝일                 
					 2, 					//  정근무/기타근무 월끝일                
					 9,           //급여(기본급+직책수당+시간외수당)                      
					 9,           //급여(기본급+직책수당+시간외수당)                      
					 9, 					//급여(기본급+직책수당+시간외수당)        
					 9, 					//급여(기본급+직책수당+시간외수당)        
					 9, 					//상여 3월                                
					 9,    				//상여 12,1월                             
					 9, 					//상여 9,11월                             
					 9, 					//상여 5,7월                              
					 2,           //기타근무일 (기타수당)                    
					 2,           //기타근무일 (기타수당)                      
					 2,           //기타근무일 (기타수당)                     
					 2, 					//기타근무일 (기타수당)                   
					 9,  					//기타수당액                              
					 9,   				//기타수당액                              
					 9,  					//기타수당액                              
					 9, 					//기타수당액                              
					 9, 					//년차일수                                
					 9,  					//년차수당                                
					 9, 					//평균년차수당                            
					 9, 					//평균급여                                
					 9, 					//평균상여                                
					 9, 					//평균기타수당                            
					 9, 					//근속수당                                
					 9, 					//자기계발비                              
					 9, 					//차량유지비                              
					 9, 					//남북경협수당                            
					 9, 					//임원직책수당
					 9,           //연장수당  추가
					 9, 					//기타수당                                
					 9, 					//급여                                    
					 9, 					//퇴직금                                  
					 9, 					//년차수당                                
					 9, 					//상여                                    
					 9, 					//지급합계                                
					 9, 					//실지급액                                
					 9, 					//갑근세-소득세                           
					 9, 					//주민세                                  
					 9, 					//갑근세-소득세                           
					 9, 					//주민세                                  
					 9, 					//국민연금                                
					 9, 					//건강보험                                
					 9, 					//고용보험                                
					 9, 					//퇴직전환금                              
					 9, 					//기타공제1                               
					 9, 					//기타공제2                               
					 9, 					//기타공제3                               
					 9, 					//기타공제4                               
 					 9, 					//공제합계                                
 					 13, 					//공제합계                                

					 20,
					 20,
					 20,
					 20,
					 20
           }; 

				int[] intArrCN2 = new int[]{

					 -1,					//년월                                    
					 -1,    			//사번                                    
					 -1, 					//입사구분 1정규직",2별정직               
					 -1,   				//성명                                    
					 -1, 					//부서                                    
					 -1, 					//직위                                    
					 -1, 					//입사일                                  
					 -1, 					//퇴사일                                  
					 0,  					//근무년                                  
					 0,  					//근무월                                  
					 0,  					//근무일                                  
					-1, 					//주소 1                                  
					-1, 					//주소 2                                  
					 0,           //근무일 급여(기본급+직책수당+시간외수당)                
					 0,           //근무일 급여(기본급+직책수당+시간외수당)                      
					 0,           //근무일 급여(기본급+직책수당+시간외수당)                     
					 0,  					//근무일 급여(기본급+직책수당+시간외수당) 
					 0,           //정근무/기타근무 월끝일                   
					 0,           //정근무/기타근무 월끝일                   
					 0,  					//정근무/기타근무 월끝일                 
					 0,  					//정근무/기타근무 월끝일                
					 0,           //급여(기본급+직책수당+시간외수당)                     
					 0,           //급여(기본급+직책수당+시간외수당)                     
					 0,  					//급여(기본급+직책수당+시간외수당)        
					 0,  					//급여(기본급+직책수당+시간외수당)        
					 0,  					//상여 3월                                
					 0,   				//상여 12,1월                             
					 0,  					//상여 9,11월                             
					 0,  					//상여 5,7월                              
					 0,           //기타근무일 (기타수당)                   
					 0,           //기타근무일 (기타수당)                     
					 0,           //기타근무일 (기타수당)                    
					 0,  					//기타근무일 (기타수당)                   
					 0,  					//기타수당액                              
					 0,  					//기타수당액                              
					 0,  					//기타수당액                              
					 0,  					//기타수당액                              
					 0,  					//년차일수                                
					 0,  					//년차수당                                
					 0,  					//평균년차수당                            
					 0,  					//평균급여                                
					 0,  					//평균상여                                
					 0,  					//평균기타수당                            
					 0,  					//근속수당                                
					 0,  					//자기계발비                              
					 0,  					//차량유지비                              
					 0,  					//남북경협수당                            
					 0,  					//임원직책수당
					 0,           //연장수당  추가
					 0,  					//기타수당                                
					 0,  					//급여                                    
					 0,  					//퇴직금                                  
					 0,  					//년차수당                                
					 0,  					//상여                                    
					 0,  					//지급합계                                
					 0,  					//실지급액                                
					 0, 					//갑근세-소득세                           
					 0, 					//주민세                                  
					 0, 					//갑근세-소득세                           
					 0, 					//주민세                                  
					 0, 					//국민연금                                
					 0, 					//건강보험                                
					 0,  					//고용보험                                
					 0,  					//퇴직전환금                              
					 0,  					//기타공제1                               
					 0,  					//기타공제2                               
					 0,  					//기타공제3                               
					 0,  					//기타공제4                               
 					 0,  					//공제합계                                
 					 -1,  					//공제합계
					 
					 -1,
					 -1,
					 -1,
					 -1,
					 -1
           }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append("   SELECT																																					\n");
					sql.append("     B.APPDT,    /*년월                                    */											\n");
					sql.append("     B.EMPNO,   /*사번                                     */											\n");
					sql.append("     A.EMPDIV,  /*입사구분 1정규직,2별정직                 */											\n");
					sql.append("     A.EMPNMK,  /*성명                                     */											\n");
					sql.append("     C.DEPTNM,  /*부서                                     */											\n");
					sql.append("     D.MINORNM AS PAYGRDNM, /*직위                         */											\n");
					sql.append("     B.STRTDT, /*입사일                                    */											\n");
					sql.append("     B.ENDDT,  /*퇴사일                                    */											\n");
					sql.append("     B.DUYEAR,  /*근무년                                   */											\n");
					sql.append("     B.DUYMM,   /*근무월                                   */											\n");
					sql.append("     B.DUDAY,   /*근무일                                   */											\n");
					sql.append("     RTRIM(A.CADDR01) AS CADDR01,   /*주소 1               */											\n");
					sql.append("     RTRIM(A.CADDR02) AS CADDR02,   /*주소 2               */											\n");
					sql.append("     B.BASDAY1, /*근무일 급여(기본급+직책수당+시간외수당)  */											\n");
					sql.append("     B.BASDAY2,  /*근무일 급여(기본급+직책수당+시간외수당) */											\n");
					sql.append("     B.BASDAY3,  /*근무일 급여(기본급+직책수당+시간외수당) */											\n");
					sql.append("     B.BASDAY4,   /*근무일 급여(기본급+직책수당+시간외수당)*/											\n");
					sql.append("     B.BASMAX1,   /*정근무/기타근무 월끝일                 */											\n");
					sql.append("     B.BASMAX2,   /* 정근무/기타근무 월끝일                */											\n");
					sql.append("     B.BASMAX3,   /* 정근무/기타근무 월끝일                */											\n");
					sql.append("     B.BASMAX4,   /*  정근무/기타근무 월끝일               */											\n");
					sql.append("     B.BASAMT1,   /*급여(기본급+직책수당+시간외수당)       */											\n");
					sql.append("     B.BASAMT2,   /*급여(기본급+직책수당+시간외수당)       */											\n");
					sql.append("     B.BASAMT3,   /*급여(기본급+직책수당+시간외수당)       */											\n");
					sql.append("     B.BASAMT4,   /*급여(기본급+직책수당+시간외수당)       */											\n");
					sql.append("     B.BASBUS1,   /*상여 3월                               */											\n");
					sql.append("     B.BASBUS2,   /*상여 12,1월                            */											\n");
					sql.append("     B.BASBUS3,   /*상여 9,11월                            */											\n");
					sql.append("     B.BASBUS4,   /*상여 5,7월                             */											\n");
					sql.append("     B.BAEDAY1,  /*기타근무일 (기타수당)                   */											\n");
					sql.append("     B.BAEDAY2,  /*기타근무일 (기타수당)                   */											\n");
					sql.append("     B.BAEDAY3,  /*기타근무일 (기타수당)                   */											\n");
					sql.append("     B.BAEDAY4,  /*기타근무일 (기타수당)                   */											\n");
					sql.append("     B.BAEAMT1,  /*기타수당액                              */											\n");
					sql.append("     B.BAEAMT2,  /*기타수당액                              */											\n");
					sql.append("     B.BAEAMT3,  /*기타수당액                              */											\n");
					sql.append("     B.BAEAMT4,  /*기타수당액                              */											\n");
					sql.append("     B.YEAQTY,   /*년차일수                                */											\n");
					sql.append("     B.YEAPAY,   /*년차수당                                */											\n");
					sql.append("     B.AVGYER,   /*평균년차수당                            */											\n");
					sql.append("     B.AVGAMT,   /*평균급여                                */											\n");
					sql.append("     B.AVGBOS,   /*평균상여                                */											\n");
					sql.append("     B.AVGETC,   /*평균기타수당                            */											\n");
					sql.append("     B.P21000,   /*근속수당                                */											\n");
					sql.append("     B.P22000,   /*자기계발비                              */											\n");
					sql.append("     B.P24000,   /*차량유지비                              */											\n");
					sql.append("     B.P29000,   /*남북경협수당                            */											\n");
					sql.append("     B.P38000,   /*임원직책수당                            */											\n");
					sql.append("     B.P27000,   /*연장수당			                           */											\n");
					sql.append("     B.PX0000,   /*기타수당                                */											\n");
					sql.append("     B.JUSPAY,   /*급여                                    */											\n");
					sql.append("     B.JUSRET,   /*퇴직금                                  */											\n");
					sql.append("     B.JUSYER,   /*년차수당                                */											\n");
					sql.append("     B.JUSBOS,   /*상여                                    */											\n");
					sql.append("     B.S91000,   /*지급합계                                */											\n");
					sql.append("     B.S94000,   /*실지급액                                */											\n");
					sql.append("     B.T21000, /*갑근세-소득세                             */											\n");
					sql.append("     B.T22000, /*주민세                                    */											\n");
					sql.append("     B.T23000, /*갑근세-소득세                             */											\n");
					sql.append("     B.T24000, /*주민세                                    */											\n");
					sql.append("     B.P43000, /*국민연금                                  */											\n");
					sql.append("     B.P41000, /*건강보험                                  */											\n");
					sql.append("     B.P42000,  /*고용보험                                 */											\n");
					sql.append("     B.RETJUH,  /*퇴직전환금                               */											\n");
					sql.append("     B.BX0010,  /*기타공제1                                */											\n");
					sql.append("     B.BX0020,  /*기타공제2                                */											\n");
					sql.append("     B.BX0030,  /*기타공제3                                */											\n");
					sql.append("     B.BX0040,  /*기타공제4                                */											\n");
					sql.append("     B.S93000,   /*공제합계                                */											\n");
					sql.append("     A.RESINO,  /*주민번호                                 */											\n");
					sql.append("		 RTRIM(B.REF1) REF1,																													\n");	
					sql.append("		 RTRIM(B.REF2) REF2,																													\n");
					sql.append("		 RTRIM(B.REF3) REF3,																													\n");
					sql.append("		 RTRIM(B.REF4) REF4,																													\n");
					sql.append("		 RTRIM(B.REF) REF				/*퇴직사유*/																					\n");
					sql.append(" FROM  PAYROLL.PRPAY B																														\n");
					sql.append(" LEFT JOIN PAYROLL.HIPERSON A ON A.EMPNO=B.EMPNO																	\n");
					sql.append(" LEFT JOIN PAYROLL.HCDEPT C  ON  A.DEPTCD = C.DEPTCD															\n");
					sql.append(" LEFT JOIN PAYROLL.HCLCODE D ON  A.PAYGRD = D.MINORCD  AND D.MAJORCD = '2002'			\n");
					sql.append(" WHERE RTRIM(B.EMPNO) <> ''																												\n");
					sql.append(" AND B.PAYDIV IN ('3')	--퇴직																										\n");
					
					if ( (!str[0].equals("")&&!str[0].equals("0")) && (!str[1].equals("")&&!str[1].equals("0")) )
						sql.append( " AND B.ENDDT BETWEEN  '"  + str[0] + "' AND  '"  + str[1] + "' ");											//퇴사일자-기준일자
					if (!str[2].equals("")&&!str[2].equals("0")) sql.append( " AND A.EMPNMK LIKE '" + str[2]+ "%'	\n");   //성명

					sql.append(" ORDER BY B.ENDDT DESC, B.APPDT DESC																							\n");

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