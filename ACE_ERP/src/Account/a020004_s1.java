package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class a020004_s1 extends HttpServlet {
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
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				
						  
			    String [] str = new String [9];
				str[0]	= req.getParameter("v_str1");		//회계일자 FR
				str[1]	= req.getParameter("v_str2");		//회계일자 TO
				str[2]	= req.getParameter("v_str3");		//결재권자 사번
				str[3]	= req.getParameter("v_str4");		//전표상태
				str[4]	= req.getParameter("v_str5");		//전결전표일자
				str[5]	= req.getParameter("v_str6");		//지점
				str[6]	= req.getParameter("v_str7");		//적요
				str[7]	= req.getParameter("v_str8");		//결재구분 01-회계, 02-예산, 06-자금
				str[8]	= req.getParameter("v_str9");		//잠금 구분 A - 전체, T-잠금, F-풀림
				
				
				for (int s=0;s<=8;s++) {
					if(str[s]==null) str[s] = "";
				}
				
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CHK",	   "FDCODE",   "FSDAT",	   "FSNBR",	 "SEQ",
					                              "ACCSGNID",  "EMPNO",    "EMPNMK",   "REMARK", "FSAMT",
				                                  "ACCSGNEND", "ACTDAT",   "ACCSGNDAT","FROMGB", "TOGB",
					                              "BIGO",      "FSDATNBR", "FDNAME",   "BGTGB",  "SSDATNBR", "FSSTAT", "FSLOCK"}; 

				int[] intArrCN = new int[]{  1, 2, 9, 6, 2,
					                           7, 7, 20, 66,15,
					                           1, 8, 8,  2, 2 ,
					                           50, 16, 20, 4, 16, 1, 1}; 
			
				int[] intArrCN2 = new int[]{ -1, -1,-1, -1, -1,
					                           -1, -1, -1, -1, 0,
					                           -1, -1, -1, -1, -1,
				                             -1, -1, -1, -1, -1, -1, -1}; 
				
				
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 
				
				//System.out.println("a020004_s1 : 4 ");

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					if(str[3].equals("A")){ //전체

						sql.append( " SELECT '' CHK,   A.FDCODE FDCODE,  A.FSDAT FSDAT,  A.FSNBR FSNBR,  A.SEQ,  \n ");
						sql.append( "        ACCSGNID, A.EMPNO,             									 \n ");
						sql.append( "        ASNHR.SF_GET_ENONAME('01',A.EMPNO ) AS EMPNMK,            		     \n ");
						sql.append( "        B.REMARK, B.FSAMT,            										 \n ");
						sql.append( "        A.ACCSGNEND,  B.ACTDAT,  A.ACCSGNDAT, A.FROMGB, A.TOGB,      	     \n ");
						sql.append( "        A.BIGO, A.FSDAT||'-'||A.FSNBR FSDATNBR , RTRIM(FDNAME)FDNAME,       \n ");
						sql.append( "        RTRIM(A.BGTGB)BGTGB,  												 \n ");
						sql.append( "        B.SSDAT||'-'||B.SSNBR SSDATNBR, B.FSSTAT, B.FSLOCK 	 			 \n ");
						sql.append( " FROM ACCOUNT.ACTSGNSTS A                     								 \n ");
						sql.append( " LEFT JOIN ACCOUNT.FSLIPMST B ON A.FDCODE =B.FDCODE                   	     \n ");
						sql.append( " 			 	   	  	      AND A.FSDAT = B.FSDAT                          \n ");
						sql.append( " 						      AND A.FSNBR= B.FSNBR                           \n " );						
						sql.append( " LEFT JOIN (SELECT C.FDCODE,  C.FSDAT,  C.FSNBR,  MAX(C.SEQ) AS SEQ         \n ");
						sql.append( "              FROM ACCOUNT.ACTSGNSTS C, ACCOUNT.FSLIPMST D  	             \n " );
						sql.append( "             WHERE C.FDCODE =D.FDCODE                       				 \n " );
						sql.append( "               AND C.FSDAT = D.FSDAT                        				 \n " );
						sql.append( "               AND C.FSNBR = D.FSNBR                        				 \n " );
						if(!str[0].equals("")&&!str[1].equals("")) sql.append(" AND (D.ACTDAT>='"+ str[0]+"' AND  D.ACTDAT <='"+ str[1]+"') \n ");
						sql.append( "             GROUP BY C.FDCODE,C.FSDAT,C.FSNBR )X 	\n " );					 
						sql.append( "  		 ON A.FDCODE =X.FDCODE    					\n " );
						sql.append( " 		AND A.FSDAT = X.FSDAT     					\n " );
						sql.append( " 		AND A.FSNBR= X.FSNBR      					\n " );
						sql.append( " 		AND A.SEQ = X.SEQ         					\n " );
						sql.append( " LEFT JOIN ACCOUNT.FIELDCODE F ON A.FDCODE = F.FDCODE                              \n " );
						sql.append( " LEFT JOIN ( SELECT H.FDCODE, H.FSDAT, H.FSNBR, COUNT(*) CNT                       \n " );
						sql.append( "               FROM ACCOUNT.FSLIPDTL H, ACCOUNT.FSLIPMST K                         \n " );
						sql.append( "              WHERE H.FDCODE = K.FDCODE                                            \n " );
						sql.append( "                AND H.FSDAT = K.FSDAT                                              \n " );
						sql.append( "                AND H.FSNBR = K.FSNBR                                              \n " );
						sql.append( "                AND H.FSWRKDIV='02'                                                \n " );
						sql.append( "                AND H.FDCODE ='"+ str[5]+"'                                        \n " );
						sql.append( "                AND (K.ACTDAT>='"+ str[0]+"' AND  K.ACTDAT <='"+ str[1]+"')        \n " );
						sql.append( "              GROUP BY H.FDCODE, H.FSDAT, H.FSNBR                                  \n " );
						sql.append( "            ) Y ON Y.FDCODE = B.FDCODE AND Y.FSDAT = B.FSDAT AND Y.FSNBR = B.FSNBR \n " );
						sql.append( " WHERE 1 = 1               \n " );
						sql.append( " AND A.FDCODE = B.FDCODE 	\n " );
						sql.append( " AND A.FSDAT  = B.FSDAT   	\n " );
						sql.append( " AND A.FSNBR  = B.FSNBR   	\n " );
						sql.append( " AND A.FDCODE = X.FDCODE   \n " );
						sql.append( " AND A.FSDAT  = X.FSDAT    \n " );
						sql.append( " AND A.FSNBR  = X.FSNBR    \n " );
						sql.append( " AND A.SEQ    = X.SEQ      \n " );
						
						if(!str[0].equals("")&&!str[1].equals("")) sql.append(" AND (B.ACTDAT>='"+ str[0]+"' AND  B.ACTDAT <='"+ str[1]+"') \n ");
						if(!str[5].equals(""))sql.append( "    AND A.FDCODE ='"+ str[5]+"' \n " );				
						if(!str[3].equals("")&&!str[3].equals("A"))sql.append( "    AND A.ACCSGNEND='"+ str[3]+"' \n ");
						if(str[7].equals("06"))sql.append( "   AND (A.TOGB ='06') \n ");
						if(str[7].equals("01"))sql.append( "   AND (A.TOGB<>'02' AND A.TOGB<>'06') \n ");

						//2010.02.04 JYS 수정 
						if(str[7].equals("02")){  //예산 
							if(!str[2].equals("")){ //결재담당자 존재하면
								sql.append( "  AND (( A.ACCSGNID='"+ str[2]+"'  AND A.TOGB ='02') OR  COALESCE(Y.CNT,0)>0 ) \n ");
							}else{
								sql.append( "  AND (A.TOGB ='02' OR  COALESCE(Y.CNT,0)>0 ) \n ");
							}
						}else{ 
							
							//if(!str[2].equals(""))sql.append( "    AND A.ACCSGNID='"+ str[2]+"' \n " );	
							//2018.12.04.JYS  관리센터-회계 일 경우 이정식 이전 데이터 조회도 가능
							if(str[2].equals("6180021")){
								sql.append( "    AND A.ACCSGNID IN ('6180021','2040080') \n " );
							}else if (!str[2].equals("")){					
					            sql.append( "    AND A.ACCSGNID='"+ str[2]+"' \n " );  
							}
						}
						///////////////////////////////////////////////////////////////////////////////////////////////////////
						if(!str[6].equals(""))sql.append( "    AND B.REMARK LIKE '%"+ str[6]+"%' \n " );
						//2013.12.24 jys						
						if(!str[8].equals("A"))sql.append( "    AND B.FSLOCK ='"+ str[8]+"' 	\n  ");
						
						sql.append( " UNION ALL       																\n " );
						sql.append( "  SELECT '' CHK,   B.FDCODE FDCODE,  B.FSDAT FSDAT,  B.FSNBR FSNBR,  ''SEQ,    \n " );
						sql.append( "           '' ACCSGNID, B.EMPNO,                                               \n " );
						sql.append( "           ASNHR.SF_GET_ENONAME('01',B.EMPNO ) AS  EMPNMK, 					\n " );
						sql.append( "           B.REMARK, B.FSAMT,                                                  \n " );
						sql.append( "           B.FSSTAT ACCSGNEND,  B.ACTDAT,  '' ACCSGNDAT, '' FROMGB,  '' TOGB,  \n " );
						sql.append( "           '' BIGO, B.FSDAT||'-'||B.FSNBR FSDATNBR , RTRIM(FDNAME)FDNAME,      \n " );
						sql.append( "           '' BGTGB,                                                           \n " );
						sql.append( "           B.SSDAT||'-'||B.SSNBR SSDATNBR, B.FSSTAT, B.FSLOCK               	\n " );
						sql.append( "    FROM  ACCOUNT.FSLIPMST B                                                	\n " );
						sql.append( "    LEFT JOIN ACCOUNT.FIELDCODE F ON B.FDCODE = F.FDCODE                       \n " );
						sql.append( "    LEFT JOIN ( SELECT H.FDCODE, H.FSDAT, H.FSNBR, COUNT(*) CNT               	\n " );
						sql.append( "                  FROM ACCOUNT.FSLIPDTL H, ACCOUNT.FSLIPMST K               	\n " );
						sql.append( "                 WHERE H.FDCODE = K.FDCODE                                  	\n " );
						sql.append( "                   AND H.FSDAT = K.FSDAT                                    	\n " );
						sql.append( "                   AND H.FSNBR = K.FSNBR                                    	\n " );
						sql.append( "                   AND H.FSWRKDIV='02'                                         \n " );
						sql.append( "                   AND H.FDCODE ='"+ str[5]+"'                                 \n " );
						sql.append( "                   AND (K.ACTDAT>='"+ str[0]+"' AND  K.ACTDAT <='"+ str[1]+"') \n " );
						sql.append( "                 GROUP BY H.FDCODE, H.FSDAT, H.FSNBR                           \n " );
						sql.append( "               ) Y ON Y.FDCODE = B.FDCODE AND Y.FSDAT = B.FSDAT AND Y.FSNBR = B.FSNBR \n " );
						sql.append( "    WHERE B.FDCODE IS NOT NULL                                                                         \n " );
						if(!str[0].equals("")&&!str[1].equals("")) sql.append(" AND (B.ACTDAT>='"+ str[0]+"' AND  B.ACTDAT <='"+ str[1]+"') \n ");
						if(!str[5].equals(""))sql.append( "    AND B.FDCODE ='"+ str[5]+"' 													\n " );
						//sql.append( "    AND B.FSSTAT IN ('N','B')                                                                 			\n " );
						sql.append( "    AND B.FSSTAT IN ('N')                                                                 			    \n " );
						if(str[7].equals("02"))sql.append( "   AND COALESCE(Y.CNT,0)>0 													    \n  "); 
						//2013.10.21 이동훈 추가						
						if(!str[8].equals("A"))sql.append( "    AND B.FSLOCK ='"+ str[8]+"'  \n  ");
						
						sql.append( "    ORDER BY FDCODE, FSDAT DESC, FSNBR                   \n " );
					}else if(str[3].equals("B")||str[3].equals("N")){  //반송, 대기
						sql.append( "  SELECT '' CHK,   B.FDCODE FDCODE,  B.FSDAT FSDAT,  B.FSNBR FSNBR,  ''SEQ,      \n " );
						sql.append( "           '' ACCSGNID, B.EMPNO,                                                 \n " );
						sql.append( "           ASNHR.SF_GET_ENONAME('01',B.EMPNO ) AS EMPNMK, 						  \n " );
						sql.append( "           B.REMARK, B.FSAMT,                                                    \n " );
						sql.append( "           B.FSSTAT ACCSGNEND,  B.ACTDAT,  '' ACCSGNDAT, '' FROMGB,  '' TOGB,    \n " );
						sql.append( "           '' BIGO, B.FSDAT||'-'||B.FSNBR FSDATNBR , RTRIM(FDNAME)FDNAME,        \n " );
						sql.append( "           '' BGTGB,                                                             \n " );
						sql.append( "           B.SSDAT||'-'||B.SSNBR SSDATNBR, B.FSSTAT, B.FSLOCK                    \n " );
						sql.append( "    FROM  ACCOUNT.FSLIPMST B                                                     \n " );
						sql.append( "    LEFT JOIN ACCOUNT.FIELDCODE F ON B.FDCODE = F.FDCODE                         \n " );
						sql.append( "    LEFT JOIN ( SELECT H.FDCODE, H.FSDAT, H.FSNBR, COUNT(*) CNT                  \n " );
						sql.append( "                  FROM ACCOUNT.FSLIPDTL H, ACCOUNT.FSLIPMST K                    \n " );
						sql.append( "                 WHERE H.FDCODE = K.FDCODE                                            \n " );
						sql.append( "                   AND H.FSDAT = K.FSDAT                                              \n " );
						sql.append( "                   AND H.FSNBR = K.FSNBR                                              \n " );
						sql.append( "                   AND H.FSWRKDIV='02'                                                \n " );
						sql.append( "                   AND H.FDCODE ='"+ str[5]+"'                                        \n " );
						sql.append( "                   AND (K.ACTDAT>='"+ str[0]+"' AND  K.ACTDAT <='"+ str[1]+"')        \n " );
						sql.append( "                 GROUP BY H.FDCODE, H.FSDAT, H.FSNBR                                  \n " );
						sql.append( "               ) Y ON Y.FDCODE = B.FDCODE AND Y.FSDAT = B.FSDAT AND Y.FSNBR = B.FSNBR \n " );
						sql.append( "    WHERE B.FDCODE IS NOT NULL                                                        \n " );
						if(!str[0].equals("")&&!str[1].equals("")) sql.append(" AND (B.ACTDAT>='"+ str[0]+"' AND  B.ACTDAT <='"+ str[1]+"') ");
						if(!str[5].equals(""))sql.append( "    AND B.FDCODE ='"+ str[5]+"'" );
						sql.append( "    AND B.FSSTAT ='"+ str[3]+"'                            \n " );
						if(str[7].equals("02"))sql.append( "   AND COALESCE(Y.CNT,0)>0 			\n  "); 
						//2013.10.21 이동훈 추가						
						if(!str[8].equals("A"))sql.append( "    AND B.FSLOCK ='"+ str[8]+"' 	\n  ");
						sql.append( "    ORDER BY FDCODE, FSDAT DESC, FSNBR                     \n " );
					
					}else{   //결재완료, 결재요청, 결재취소
						
						sql.append( " SELECT '' CHK,   A.FDCODE,  A.FSDAT,  A.FSNBR,  A.SEQ,              		\n ");
						sql.append( "        ACCSGNID, A.EMPNO,             									\n ");
						sql.append( "        ASNHR.SF_GET_ENONAME('01',B.EMPNO ) AS EMPNMK,            			\n ");
						sql.append( "        B.REMARK, B.FSAMT,            										\n ");
						sql.append( "        A.ACCSGNEND,  B.ACTDAT,  A.ACCSGNDAT, A.FROMGB, A.TOGB,      		\n ");
						sql.append( "        A.BIGO, A.FSDAT||'-'||A.FSNBR FSDATNBR , RTRIM(FDNAME)FDNAME,	    \n ");
						sql.append( "        RTRIM(A.BGTGB)BGTGB,  												\n ");
						sql.append( "        B.SSDAT||'-'||B.SSNBR SSDATNBR, B.FSSTAT, B.FSLOCK					\n ");
						sql.append( " FROM ACCOUNT.ACTSGNSTS A, ACCOUNT.FSLIPMST B,                       		\n ");
						sql.append( "      (SELECT C.FDCODE,  C.FSDAT,  C.FSNBR,  MAX(C.SEQ) AS SEQ       		\n ");
						sql.append( "         FROM ACCOUNT.ACTSGNSTS C, ACCOUNT.FSLIPMST D  					\n " );
						sql.append( "        WHERE C.FDCODE =D.FDCODE                       					\n " );
						sql.append( "          AND C.FSDAT = D.FSDAT                        					\n " );
						sql.append( "          AND C.FSNBR = D.FSNBR                        					\n " );
						if(!str[0].equals("")&&!str[1].equals("")) sql.append(" AND (D.ACTDAT>='"+ str[0]+"' AND  D.ACTDAT <='"+ str[1]+"') ");
						sql.append( "        GROUP BY C.FDCODE,C.FSDAT,C.FSNBR )X,  							\n " );
						sql.append( "        ACCOUNT.FIELDCODE F,               	                        	\n " );
						sql.append( "            ( SELECT H.FDCODE, H.FSDAT, H.FSNBR, COUNT(*) CNT              \n " );
						sql.append( "               FROM ACCOUNT.FSLIPDTL H, ACCOUNT.FSLIPMST K                 \n " );
						sql.append( "              WHERE H.FDCODE = K.FDCODE                                	\n " );
						sql.append( "                AND H.FSDAT = K.FSDAT                                      \n " );
						sql.append( "                AND H.FSNBR = K.FSNBR                                      \n " );
						sql.append( "                AND H.FSWRKDIV='02'                                        \n " );
						sql.append( "                AND H.FDCODE ='"+ str[5]+"'                                \n " );
						sql.append( "                AND (K.ACTDAT>='"+ str[0]+"' AND  K.ACTDAT <='"+ str[1]+"')	\n " );
						sql.append( "              GROUP BY H.FDCODE, H.FSDAT, H.FSNBR                           	\n " );
						sql.append( "            ) Y  \n " );
						sql.append( " WHERE A.FDCODE =B.FDCODE  \n " );
						sql.append( " AND A.FSDAT = B.FSDAT    	\n " );
						sql.append( " AND A.FSNBR= B.FSNBR     	\n " );
						sql.append( " AND A.FDCODE =X.FDCODE    \n " );
						sql.append( " AND A.FSDAT = X.FSDAT     \n " );
						sql.append( " AND A.FSNBR= X.FSNBR      \n " );
						sql.append( " AND A.SEQ = X.SEQ         \n " );
						
						if(!str[0].equals("")&&!str[1].equals("")) sql.append(" AND (B.ACTDAT>='"+ str[0]+"' AND  B.ACTDAT <='"+ str[1]+"') ");
						if(!str[5].equals(""))sql.append( "    AND A.FDCODE ='"+ str[5]+"'" );
						if(!str[3].equals("")&&!str[3].equals("A"))sql.append( "    AND A.ACCSGNEND='"+ str[3]+"'");
						if(str[7].equals("06"))sql.append( "   AND (A.TOGB ='06')");
						if(str[7].equals("01"))sql.append( "   AND (A.TOGB!='02' AND A.TOGB!='06')");
						
						//2010.02.04 JYS 수정 
						if(str[7].equals("02")){  //예산 
							if(!str[2].equals("")){ //결재담당자 존재하면
								sql.append( "  AND (( A.ACCSGNID='"+ str[2]+"'  AND A.TOGB ='02') OR  COALESCE(Y.CNT,0)>0 ) \n ");
							}else{
								sql.append( "  AND (A.TOGB ='02' OR  COALESCE(Y.CNT,0)>0 ) \n ");
							}
						}else{ 
							//if(!str[2].equals(""))sql.append( "    AND A.ACCSGNID='"+ str[2]+"' \n " );
							
							//2018.12.04.JYS  관리센터-회계 일 경우 이정식 이전 데이터 조회도 가능
							if(str[2].equals("6180021")){
								sql.append( "    AND A.ACCSGNID IN ('6180021','2040080') \n " );
								
							//2019.03.21.JYS  곽진희 - 손명희 데이터 조회 가능	
							}else if (str[2].equals("3190004")){
								sql.append( "    AND A.ACCSGNID IN ('3190004','3170009') \n " );
																
							}else if (!str[2].equals("")){					
					            sql.append( "    AND A.ACCSGNID='"+ str[2]+"' \n " );  
							}
						}
						/////////////////////////////////////////////////////////////////////////////////////////////////////// 
						if(!str[6].equals(""))sql.append( "    AND B.REMARK LIKE '%"+ str[6]+"%'" );
						//2013.10.21 이동훈 추가						
						if(!str[8].equals("A"))sql.append( "    AND B.FSLOCK ='"+ str[8]+"' 		\n ");
						
						sql.append( "  AND A.FDCODE = F.FDCODE(+)  \n " );
						sql.append( "  AND B.FDCODE = Y.FDCODE(+)  \n " );
						sql.append( "  AND B.FSDAT = Y.FSDAT(+)    \n " );
						sql.append( "  AND B.FSNBR = Y.FSNBR(+)    \n " );
				  }
					
					
					
					//System.out.println("a020004_s1 : " + sql.toString());	
					//logger.dbg.println(this,sql.toString());
/*********************************************************************************************/

					stmt = conn.getGauceStatement(sql.toString());
					stmt.executeQuery(dSet);
				}
			} catch(Exception e) {
		  	logger.err.println(this,e);
		  	
		  	System.out.println("Exception : " + e.getMessage());	
		
		  
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