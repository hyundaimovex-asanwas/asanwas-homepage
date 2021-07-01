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
public class a030012_s2 extends HttpServlet {
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
				String []  str	= new String [9];

				str[0] = req.getParameter("v_str1");	//지점코드
				str[1] = req.getParameter("v_str2");	//기간 from
				str[2] = req.getParameter("v_str3");	//기간 to
				str[3] = req.getParameter("v_str4");	//계정과목

				str[4] = req.getParameter("v_str5");	//관리항목1
				str[5] = req.getParameter("v_str6");	//관리항목2
				str[6] = req.getParameter("v_str7");	//관리항목3
				
				str[7] = req.getParameter("v_str8");	//구간 from
				str[8] = req.getParameter("v_str9");	//구간 to	
		
				for(int i=0;i<=8;i++) {
					if(str[i] == null) str[i] = ""; 
				}

				GauceRes.enableFirstRow(dSet);
				String[] strArrCN = new String[]{   "FDCODE",     "ATCODE",   "COCODE",   "FSREFVAL01", "FSREFVAL02",
					                                  "FSREFVAL03", "BEVAL",    "DEAMT",    "CRAMT", "SLPVAL"
			                                 	};
				int[] intArrCN = new int[] {    2,    8,    2,    20,   20, 
																				20,   15,   15,   15,   15 }; 

				int[] intArrCN2 = new int[]{    -1,   -1,    -1,    -1,   -1,
																			  -1,    0,     0,     0,    0
					                        }; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {		
					String strfsref =""; //마지막 순서의 관리항목
					String strdate="";   //
					String stryyyy="";
					String strfrdt="";  //from 일자의 날짜 format

					if(!str[4].equals("")&&str[5].equals("")&&str[6].equals("")){
						strfsref = str[4];
					}else if(!str[4].equals("")&&!str[5].equals("")&&str[6].equals("")){
						strfsref = str[5];
					}else if(!str[4].equals("")&&!str[5].equals("")&&!str[6].equals("")){
						strfsref = str[6];
					}else{
						strfsref = "";
					} 

					if (!str[1].substring(4,8).equals("0101")){  //1월1일 조회가 아닌경우
						
						strfrdt = str[1];
						//strfrdt= str[1].substring(0,4)+"-"+ str[1].substring(4,6)+"-"+ str[1].substring(6,8);
						
						Statement stmt_10 = conn.createStatement();
						
						String sql_10 = "  SELECT TO_CHAR(TO_DATE( '"+strfrdt +"','YYYYMMDD')-1,'YYYY-MM-DD')  AS T_DATE "
													+ "   FROM DUAL " ; 
						
						ResultSet rs_10 = stmt_10.executeQuery(sql_10); 
					
						if(rs_10.next()){
							strdate= rs_10.getString(1);
						}
						strdate = strdate.substring(0,4)+ strdate.substring(5,7)+ strdate.substring(8,10);
						stryyyy =strdate.substring(0,4);
					}else{                                    //1월1일 조회인경우
						strdate = str[1];
						stryyyy = strdate.substring(0,4);
					}

					StringBuffer sql = new StringBuffer();

 					sql.append( " SELECT Z.FDCODE, Z.ATCODE, Z.COCODE, Z.FSREFVAL01, Z.FSREFVAL02,                                                              	\n");	
					sql.append( "        Z.FSREFVAL03, COALESCE(SUM(Z.BEVAL),0)BEVAL,                                                                           	\n");	
					sql.append( "        COALESCE(SUM(Z.DEAMT),0)DEAMT,COALESCE(SUM(Z.CRAMT),0)CRAMT ,                                                          	\n");	
					sql.append( "        COALESCE(SUM(CASE WHEN Z.ATDECR ='1' THEN Z.BEVAL + Z.DEAMT -Z.CRAMT ELSE Z.BEVAL+Z.CRAMT - Z.DEAMT END),0) AS SLPVAL  	\n");	
					sql.append( "    FROM(                                                                                                                      	\n");	
					sql.append( "         --전기이월                                                                                                            	\n");	
					sql.append( "         SELECT X.FDCODE, X.ACTDAT, X.ATCODE, X.COCODE, X.FSDAT,                                                               	\n");	
					sql.append( "                 X.FSNBR,  X.FSSEQ,  V.ATDECR,  MAX(X.FSREFVAL01)FSREFVAL01, MAX(X.FSREFVAL02)FSREFVAL02,                      	\n");	
					sql.append( "                 MAX(X.FSREFVAL03)FSREFVAL03,                                                                                  	\n");	
					if(!str[1].substring(4,8).equals("0101")){
						sql.append( "               SUM(CASE WHEN X.ACTDAT >='"+stryyyy+"0100'  AND X.ACTDAT  <= '"+strdate+"'                                             	\n");	
					}else{
						sql.append( "               SUM(CASE WHEN X.ACTDAT >='"+stryyyy+"0100'  AND X.ACTDAT  < '"+strdate+"'                                              	\n");	                             
					}
					sql.append( "                          THEN  CASE WHEN V.ATDECR ='1'  THEN X.DEAMT - X.CRAMT                                                	\n");	
					sql.append( "                                     ELSE X.CRAMT - X.DEAMT END  ELSE 0 END) AS BEVAL,                                         	\n");	
					sql.append( "                 0 DEAMT,0 CRAMT, 0 SLPVAL                                                                                     	\n");	
					sql.append( "          FROM (                                                                                                               	\n");	
					sql.append( "                  SELECT A.FDCODE, A.ACTDAT, A.ATCODE, A.COCODE,                                                               	\n");	
					sql.append( "                         A.FSDAT,  A.FSNBR,  A.FSSEQ,                                                                          	\n");	
					sql.append( "                         CASE WHEN B.FSREFCD ='"+str[4]+"' THEN B.FSREFVAL END FSREFVAL01,                                           	\n");	
					sql.append( "                         CASE WHEN B.FSREFCD ='"+str[5]+"' THEN B.FSREFVAL END FSREFVAL02,                                           	\n");	
					sql.append( "                         CASE WHEN B.FSREFCD ='"+str[6]+"' THEN B.FSREFVAL END FSREFVAL03,                                               	\n");	
					sql.append( "                         Y.DEAMT, Y.CRAMT                                                                                      	\n");	
					sql.append( "                    FROM ACCOUNT.GENENLED A, ACCOUNT.GENENREF B,                                                               	\n");	
					sql.append( "                        ( SELECT S.FDCODE, S.ACTDAT, S.ATCODE,S.COCODE,                                                        	\n");	
					sql.append( "                                 S.FSDAT,  S.FSNBR,  S.FSSEQ--, B.FSREFCD, B.FSREFVAL                                          	\n");	
					sql.append( "                            FROM ACCOUNT.GENENLED S, ACCOUNT.GENENREF T                                                        	\n");	
					sql.append( "                           WHERE S.FDCODE = T.FDCODE                                                                           	\n");	
					sql.append( "                             AND S.FSDAT =  T.FSDAT                                                                            	\n");	
					sql.append( "                             AND S.FSNBR =  T.FSNBR                                                                            	\n");	
					sql.append( "                             AND S.FSSEQ =  T.FSSEQ                                                                            	\n");	
					if(!str[0].equals(""))sql.append( "       AND S.FDCODE =  '"+str[0]+"'                                                                        \n");	
					sql.append( "                             AND S.ATCODE ='"+str[3]+"'                                                                          \n");	
					if (!str[1].substring(4,8).equals("0101")){
						sql.append( "                         AND S.ACTDAT >='"+stryyyy+"0100' AND S.ACTDAT <='"+strdate+"'                                                 	\n");	
					}else{
						sql.append( "                         AND S.ACTDAT >='"+stryyyy+"0100' AND S.ACTDAT <'"+strdate+"'                                                 	\n");	
					}
					sql.append( "                             AND T.FSREFCD ='"+str[4]+"'                                                                             	\n");	
					sql.append( "                             AND (T.FSREFVAL>='"+str[7]+"' AND T.FSREFVAL<='"+str[8]+"' )                                      	\n");	
					sql.append( "                        ) C                                                                                                    	\n");	
					sql.append( "                   --데이타중 마지막 관리항목의 금액을 선택함.                                                                 	\n");	
					sql.append( "                   LEFT JOIN ( SELECT D.FDCODE, D.ACTDAT, D.ATCODE, D.COCODE,                                                  	\n");	
					sql.append( "                                      D.FSDAT,  D.FSNBR,  D.FSSEQ,                                                             	\n");	
					sql.append( "                                      CASE WHEN E.FSREFCD ='"+str[4]+"' THEN E.FSREFVAL END FSREFVAL01,                              	\n");	
					sql.append( "                                      CASE WHEN E.FSREFCD ='"+str[5]+"' THEN E.FSREFVAL END FSREFVAL02,                              	\n");	
					sql.append( "                                      CASE WHEN E.FSREFCD ='"+str[6]+"' THEN E.FSREFVAL END FSREFVAL03,                                  	\n");	
					sql.append( "                                      D.DEAMT,D.CRAMT                                                                          	\n");	
					sql.append( "                                 FROM ACCOUNT.GENENLED D, ACCOUNT.GENENREF E                                                   	\n");	
					sql.append( "                                WHERE D.FDCODE = E.FDCODE                                                                      	\n");	
					sql.append( "                                  AND D.FSDAT =  E.FSDAT                                                                       	\n");	
					sql.append( "                                  AND D.FSNBR =  E.FSNBR                                                                       	\n");	
					sql.append( "                                  AND D.FSSEQ =  E.FSSEQ                                                                       	\n");	
					if(!str[0].equals(""))sql.append( "            AND D.FDCODE = '"+str[0]+"'                                                                          	\n");	
					sql.append( "                                  AND D.ATCODE ='"+str[3]+"'                                                                      	\n");	
					if (!str[1].substring(4,8).equals("0101")){
						sql.append( "                                AND D.ACTDAT >='"+stryyyy+"0100'  AND D.ACTDAT <='"+strdate+"'                                         	\n");	
					}else{
						sql.append( "                                AND D.ACTDAT >='"+stryyyy+"0100'  AND D.ACTDAT <'"+strdate+"'                                         	\n");	
					}
					sql.append( "                                  AND E.FSREFCD='"+strfsref+"'                                                                         	\n");	
					sql.append( "                                  ) Y ON Y.FDCODE = B.FDCODE                                                                   	\n");	
					sql.append( "                                         AND Y.FSDAT = B.FSDAT                                                                 	\n");	
					sql.append( "                                         AND Y.FSNBR = B.FSNBR                                                                 	\n");	
					sql.append( "                                         AND Y.FSSEQ = B.FSSEQ                                                                 	\n");	
					sql.append( "                                         AND B.FSREFCD = '"+strfsref+"'                                                                	\n");	
					sql.append( "                 WHERE A.FDCODE = C.FDCODE                                                                                     	\n");	
					sql.append( "                   AND A.ACTDAT = C.ACTDAT                                                                                     	\n");	
					sql.append( "                   AND A.COCODE = C.COCODE                                                                                     	\n");	
					sql.append( "                   AND A.FSDAT =  C.FSDAT                                                                                      	\n");	
					sql.append( "                   AND A.FSNBR =  C.FSNBR                                                                                      	\n");	
					sql.append( "                   AND A.FSSEQ =  C.FSSEQ                                                                                      	\n");	
					sql.append( "                   AND A.FDCODE = B.FDCODE                                                                                     	\n");	
					sql.append( "                   AND A.FSDAT = B.FSDAT                                                                                       	\n");	
					sql.append( "                   AND A.FSNBR = B.FSNBR                                                                                       	\n");	
					sql.append( "                   AND A.FSSEQ = B.FSSEQ                                                                                       	\n");	
					if(!str[0].equals(""))sql.append( " AND A.FDCODE = '"+str[0]+"'                                                                                         	\n");	
					sql.append( "                   AND A.ATCODE ='"+str[3]+"'                                                                                    	\n");	
					if (!str[1].substring(4,8).equals("0101")){
						sql.append( "                   AND A.ACTDAT >='"+stryyyy+"0100'  AND A.ACTDAT <='"+strdate+"'                                                          	\n");	
					}else{
						sql.append( "                   AND A.ACTDAT >='"+stryyyy+"0100'  AND A.ACTDAT <'"+strdate+"'  '                                                         	\n");	
					}
					sql.append( "                  ) X, ACCOUNT.ACTCODE V                                                                                       	\n");	
					sql.append( "          WHERE X.ATCODE = V.ATCODE   AND V.ATUSEYN='Y'                                                                        	\n");	
					sql.append( "          GROUP BY X.FDCODE, X.ACTDAT, X.ATCODE, X.COCODE, X.FSDAT,  X.FSNBR,  X.FSSEQ,V.ATDECR                                	\n");	
					sql.append( "                                                                                                                               	\n");	
					sql.append( "          UNION ALL                                                                                                            	\n");	
					sql.append( "         --일반                                                                                                                	\n");	
					sql.append( "          SELECT X.FDCODE, X.ACTDAT, X.ATCODE, X.COCODE, X.FSDAT,                                                              	\n");	
					sql.append( "                 X.FSNBR,  X.FSSEQ,  V.ATDECR,  MAX(X.FSREFVAL01)FSREFVAL01, MAX(X.FSREFVAL02)FSREFVAL02,                      	\n");	
					sql.append( "                 MAX(X.FSREFVAL03)FSREFVAL03,                                                                                  	\n");	
					sql.append( "                 0 BEVAL, SUM(X.DEAMT)DEAMT,SUM(X.CRAMT)CRAMT,                                                                 	\n");	
					sql.append( "                 SUM(CASE WHEN V.ATDECR ='1'  THEN X.DEAMT - X.CRAMT ELSE X.CRAMT - X.DEAMT END) AS SLPVAL                     	\n");	
					sql.append( "          FROM (                                                                                                               	\n");	
					sql.append( " 								SELECT A.FDCODE, A.ACTDAT, A.ATCODE, A.COCODE,                                                                	\n");	
					sql.append( " 											 A.FSDAT,  A.FSNBR,  A.FSSEQ,                                                                           	\n");	
					sql.append( " 											 CASE WHEN B.FSREFCD ='"+str[4]+"'  THEN B.FSREFVAL END FSREFVAL01,                                            	\n");	
					sql.append( " 											 CASE WHEN B.FSREFCD ='"+str[5]+"'  THEN B.FSREFVAL END FSREFVAL02,                                            	\n");	
					sql.append( " 											 CASE WHEN B.FSREFCD ='"+str[6]+"'  THEN B.FSREFVAL END FSREFVAL03,                                                	\n");	
					sql.append( "                        Y.DEAMT, Y.CRAMT                                                                                       	\n");	
					sql.append( "                  FROM ACCOUNT.GENENLED A, ACCOUNT.GENENREF B,                                                                 	\n");	
					sql.append( "                     ( SELECT S.FDCODE, S.ACTDAT, S.ATCODE,S.COCODE,                                                           	\n");	
					sql.append( " 													   S.FSDAT,  S.FSNBR,  S.FSSEQ--, B.FSREFCD, B.FSREFVAL                                             	\n");	
					sql.append( " 											  FROM ACCOUNT.GENENLED S, ACCOUNT.GENENREF T                                                           	\n");	
					sql.append( " 											 WHERE S.FDCODE = T.FDCODE                                                                              	\n");	
					sql.append( " 												 AND S.FSDAT =  T.FSDAT                                                                               	\n");	
					sql.append( " 												 AND S.FSNBR =  T.FSNBR                                                                               	\n");	
					sql.append( " 												 AND S.FSSEQ =  T.FSSEQ                                                                               	\n");	
					if(!str[0].equals(""))sql.append( "    AND S.FDCODE = '"+str[0]+"'                                                                                   	\n");	
					sql.append( " 												 AND S.ATCODE ='"+str[3]+"'                                                                               	\n");	
					sql.append( " 												 AND S.ACTDAT >='"+str[1]+"' AND S.ACTDAT <='"+str[2]+"'                                                 	\n");	
					sql.append( " 												 AND T.FSREFCD ='"+str[4]+"'                                                                                 	\n");	
					sql.append( " 												 AND (T.FSREFVAL>='"+str[7]+"' AND  T.FSREFVAL<='"+str[8]+"' )                                                                               	\n");	
					sql.append( " 										 ) C                                                                                                      	\n");	
					sql.append( "                     LEFT JOIN ( SELECT D.FDCODE, D.ACTDAT, D.ATCODE, D.COCODE,                                                	\n");	
					sql.append( "                                        D.FSDAT,  D.FSNBR,  D.FSSEQ,                                                           	\n");	
					sql.append( "                                        CASE WHEN E.FSREFCD ='"+str[4]+"' THEN E.FSREFVAL END FSREFVAL01,                            	\n");	
					sql.append( "                                        CASE WHEN E.FSREFCD ='"+str[5]+"' THEN E.FSREFVAL END FSREFVAL02,                            	\n");	
					sql.append( "                                        CASE WHEN E.FSREFCD ='"+str[6]+"' THEN E.FSREFVAL END FSREFVAL03,                                	\n");	
					sql.append( "                                        D.DEAMT,D.CRAMT                                                                        	\n");	
					sql.append( "                                 FROM ACCOUNT.GENENLED D, ACCOUNT.GENENREF E                                                   	\n");	
					sql.append( "                                WHERE D.FDCODE = E.FDCODE                                                                      	\n");	
					sql.append( "                                  AND D.FSDAT =  E.FSDAT                                                                       	\n");	
					sql.append( "                                  AND D.FSNBR =  E.FSNBR                                                                       	\n");	
					sql.append( "                                  AND D.FSSEQ =  E.FSSEQ                                                                       	\n");	
					if(!str[0].equals(""))sql.append( "            AND D.FDCODE = '"+str[0]+"'                                                                           	\n");	
					sql.append( "                                  AND D.ATCODE ='"+str[3]+"'                                                                      	\n");	
					sql.append( "                                  AND D.ACTDAT >='"+str[1]+"'  AND D.ACTDAT <='"+str[2]+"'                                       	\n");	
					sql.append( "                                  AND E.FSREFCD='"+strfsref+"'                                                                         	\n");	
					sql.append( "                                  ) Y ON Y.FDCODE = B.FDCODE                                                                   	\n");	
					sql.append( "                                     AND Y.FSDAT = B.FSDAT                                                                     	\n");	
					sql.append( "                                     AND Y.FSNBR = B.FSNBR                                                                     	\n");	
					sql.append( "                                     AND Y.FSSEQ = B.FSSEQ                                                                     	\n");	
					sql.append( "                                     AND B.FSREFCD = '"+strfsref+"'                                                                     	\n");	
					sql.append( "                    WHERE A.FDCODE = C.FDCODE                                                                                  	\n");	
					sql.append( "                      AND A.ACTDAT = C.ACTDAT                                                                                  	\n");	
					sql.append( "                      AND A.COCODE = C.COCODE                                                                                  	\n");	
					sql.append( "                      AND A.FSDAT =  C.FSDAT                                                                                   	\n");	
					sql.append( "                      AND A.FSNBR =  C.FSNBR                                                                                   	\n");	
					sql.append( "                      AND A.FSSEQ =  C.FSSEQ                                                                                   	\n");	
					sql.append( "                      AND A.FDCODE = B.FDCODE                                                                                  	\n");	
					sql.append( "                      AND A.FSDAT = B.FSDAT                                                                                    	\n");	
					sql.append( "                      AND A.FSNBR = B.FSNBR                                                                                    	\n");	
					sql.append( "                      AND A.FSSEQ = B.FSSEQ                                                                                    	\n");	
					if(!str[0].equals(""))sql.append( " AND A.FDCODE =  '"+str[0]+"'                                                                                       	\n");	
					sql.append( "                      AND A.ATCODE ='"+str[3]+"'                                                                                   	\n");	
					sql.append( "                      AND A.ACTDAT >='"+str[1]+"' AND A.ACTDAT <='"+str[2]+"'                                                      	\n");	
					sql.append( "               ) X, ACCOUNT.ACTCODE V                                                                                          	\n");	
					sql.append( "          WHERE X.ATCODE = V.ATCODE   AND V.ATUSEYN='Y'                                                                        	\n");	
					sql.append( "          GROUP BY X.FDCODE, X.ACTDAT, X.ATCODE, X.COCODE, X.FSDAT,  X.FSNBR,  X.FSSEQ, V.ATDECR                               	\n");	
					sql.append( "    )Z                                                                                                                         	\n");	
					sql.append( "    GROUP BY Z.FDCODE, Z.ATCODE, Z.COCODE, Z.FSREFVAL01, Z.FSREFVAL02, Z.FSREFVAL03                                            	\n");	
					sql.append( "    ORDER BY FSREFVAL01, FSREFVAL02, FSREFVAL03                                                                                	\n");	
				
					System.out.println("# Query : " + sql);
					//logger.dbg.println(this, sql.toString());
					
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