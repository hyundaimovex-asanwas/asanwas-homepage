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
public class a030012_s5 extends HttpServlet {
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
				String []  str	= new String [10];

				str[0] = req.getParameter("v_str1");	//지점코드
				str[1] = req.getParameter("v_str2");	//기간 from
				str[2] = req.getParameter("v_str3");	//기간 to
				str[3] = req.getParameter("v_str4");	//계정과목
				str[4] = req.getParameter("v_str5");	//관리항목1
				str[5] = req.getParameter("v_str6");	//관리항목2
				str[6] = req.getParameter("v_str7");	//관리항목3
				str[7] = req.getParameter("v_str8");	//구간 from
				str[8] = req.getParameter("v_str9");	//구간 to	
				str[9] = req.getParameter("v_str10");	//관리항목1 전체 체크
		
				for(int i=0;i<=9;i++) {
					if(str[i] == null) str[i] = ""; 
				}

				GauceRes.enableFirstRow(dSet);
				String[] strArrCN = new String[]{   "GUBUN",  "FDCODE",   "ATCODE", "ATKORNAM",  "ATDECR", "FSREFVAL01",  
					                                  "CDNAM1", "FSREFVAL02","CDNAM2", "FSREFVAL03", "CDNAM3",
				                                    "ACTDAT", "COCODE",   "FSDAT",  "FSNBR",     "FSSEQ",
					                                  "BEVAL",  "DEAMT",    "CRAMT",  "JANAMT",    "SSDAT",     
																						"SSNBR",  "SSDANBR",  "REMARK" };

				int[] intArrCN = new int[] {    1,    2,    7,    66,    1,   20, 
																			 40,   20,   40,    20,   40,
					                              8,    2,    9,     6,    5,
					                             15,   15,   15,   15,     9,    
					                             6,    30,  132}; 

				int[] intArrCN2 = new int[]{    -1,   -1,    -1,    -1,   -1,  -1,
					                              -1,   -1,    -1,    -1,   -1,
					                              -1,   -1,    -1,    -1,   -1,
											      0,    0,     0,     0,   -1,   
					                              -1,   -1,    -1 }; 

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
					String strStartdt ="";  //추가 - 관리항목이 년이월이 안되어서 추가됨.

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
						
						strfrdt= str[1];
						//strfrdt= str[1].substring(0,4)+"-"+ str[1].substring(4,6)+"-"+ str[1].substring(6,8);
						Statement stmt_10 = conn.createStatement();
						String sql_10 = "  SELECT TO_CHAR(TO_DATE( '"+strfrdt +"','YYYYMMDD')-1,'YYYY-MM-DD')  AS T_DATE "
											+ "   FROM DUAL " ; 
						ResultSet rs_10 = stmt_10.executeQuery(sql_10); 
					
						if(rs_10.next()){
							strdate= rs_10.getString(1);
						}
						rs_10.close();
						stmt_10.close();
						
						strdate = strdate.substring(0,4)+ strdate.substring(5,7)+ strdate.substring(8,10);
						stryyyy =strdate.substring(0,4);
					}else{                                    //1월1일 조회인경우
						strdate = str[1];
						stryyyy = strdate.substring(0,4);
					}

					//추가부분 ///////////////////////////////////////////////////////////////////////////////////////////////
					//계정코드가 '3302210','3302200','3302220','1110690'  또는 비용/수익(4)
					//인경우 해당년월 0101부터 
					//그 외는 20060000 부터
					if(str[3].substring(0,1).equals("4")){
						strStartdt = stryyyy+"0000"; 
					}else{
						if(str[3].equals("3302210")||str[3].equals("3302200")||str[3].equals("3302220")||str[3].equals("1110690")){
						  strStartdt = stryyyy+"0000";
					  }else{
						  strStartdt = "20060000"; 
						}
				  }
					/////////////////////////////////////////////////////////////////////////////////////////////////////////////

					StringBuffer sql = new StringBuffer();

 					sql.append( " SELECT X.GUBUN,  X.FDCODE, X.ATCODE, Y.ATKORNAM, Y.ATDECR,                                          \n");
					sql.append( "        X.FSREFVAL01,                                                                                \n");
					sql.append( "        CASE WHEN X.ATCODE='2100520' AND '"+str[4]+"'='0029' THEN K.VEND_NM ELSE P.CDNAM  END CDNAM1,\n");
					sql.append( "        X.FSREFVAL02, '' CDNAM2, \n");
					//2014.01.23 관리항목 수정 
					//sql.append( "        CASE WHEN (X.GUBUN='C'AND(X.FSREFVAL02 IS NOT NULL OR X.FSREFVAL02 IS NOT NULL ) AND (Q.CDNAM=''OR Q.CDNAM IS NULL)) THEN X.FSREFVAL02 ELSE Q.CDNAM END CDNAM2, \n");
					sql.append( "        X.FSREFVAL03, '' CDNAM3, \n");
					//2014.01.23 관리항목 수정 
					//sql.append( "        CASE WHEN (X.GUBUN='C'AND(X.FSREFVAL03 IS NOT NULL OR X.FSREFVAL03 IS NOT NULL ) AND (R.CDNAM=''OR R.CDNAM IS NULL)) THEN X.FSREFVAL03 ELSE R.CDNAM END CDNAM3, \n");
					sql.append( "        X.ACTDAT, X.COCODE, X.FSDAT,  X.FSNBR,  X.FSSEQ,                                          \n");	
					sql.append( "        X.BEVAL,  X.DEAMT,  X.CRAMT,  X.JANAMT, X.SSDAT, X.SSNBR, X.SSDAT||'-'||X.SSNBR SSDANBR,  \n");	
					sql.append( "        X.REMARK  \n");	
					sql.append( " FROM(            \n");	
					sql.append( " 		--전기이월      \n");	
					sql.append( " 		SELECT A.FDCODE,  MIN(A.ACTDAT) ACTDAT,  A.ATCODE,  ''COCODE,  '' FSDAT,                          \n");	
					sql.append( " 					 '' FSNBR,   '' FSSEQ,                                                                \n");	
					sql.append( " 					 CASE WHEN C.ATDECR='1' THEN COALESCE(SUM(A.DEAMT),0) - COALESCE(SUM(A.CRAMT),0)      \n");
					sql.append( " 								WHEN C.ATDECR='2' THEN COALESCE(SUM(A.CRAMT),0) - COALESCE(SUM(A.DEAMT),0)\n");
					sql.append( " 								ELSE 0 END BEVAL,                                                         \n");	
					sql.append( " 				   0  DEAMT,   0  CRAMT,   0 JANAMT,                                                      \n");	
					sql.append( " 					 '' SSDAT,'' SSNBR,                                                                   \n");	
					sql.append( " 					 nvl(R1.FSREFVAL,'AA') FSREFVAL01, '' FSREFVAL02, '' FSREFVAL03 , 'B' GUBUN,          \n");	
					sql.append( " 					 '' REMARK                                                                            \n");	
					sql.append( " 			FROM ACCOUNT.GENENLED A, ACCOUNT.ACTCODE C,                                                   \n");	
					sql.append( " 					 (SELECT /*+ no_merge */  --@@ 힌트 추가                                                                                   \n");	
					sql.append( " 					         B.FDCODE, B.FSDAT, B.FSNBR, B.FSSEQ, B.FSREFCD,                              \n");	
					sql.append( " 							 B.FSREFVAL, B.SSDAT, B.SSNBR                                                 \n");	
					sql.append( " 						FROM ACCOUNT.GENENREF B                                                           \n");
					sql.append( " 				       WHERE 1=1      		                                                              \n");
					if(!str[0].equals(""))sql.append( "  AND B.FDCODE = '"+str[0]+"'                                                      \n");
					if(!str[4].equals(""))sql.append( "	 AND B.FSREFCD = '"+str[4]+"'                                                     \n");
					if(str[9].equals("")) sql.append( "  AND B.FSREFVAL >= '"+str[7]+"' AND B.FSREFVAL <='"+str[8]+"'                     \n");	
							sql.append( " 			  )R1                                                                                 \n");
					sql.append( " 		   WHERE 1=1      		                                                                          \n");		
					if(!str[0].equals(""))sql.append( "  AND A.FDCODE = '"+str[0]+"'                                                      \n");
					sql.append( " 			 AND A.ATCODE = C.ATCODE                                                                      \n");

					if(!str[3].equals(""))sql.append( "  AND A.ATCODE='"+str[3]+"'                                                        \n");	
							sql.append( " 	 AND A.ACTDAT>='"+strStartdt+"'                                                          \n");	
					if(!str[1].substring(4,8).equals("0101")){					
							sql.append( " 	 AND A.ACTDAT<='"+strdate+"'                                                              \n");
					}else{
					        sql.append( " 	 AND A.ACTDAT<'"+strdate+"'                                                              \n");
					}
					sql.append( " 			 AND A.FDCODE = R1.FDCODE                                                                 \n");
					sql.append( " 			 AND A.FSDAT = R1.FSDAT                                                                   \n");	
					sql.append( " 			 AND A.FSNBR = R1.FSNBR                                                                   \n");	
					sql.append( " 			 AND A.FSSEQ = R1.FSSEQ                                                                   \n");	
					if(str[9].equals(""))sql.append( "	AND R1.FSREFVAL >='"+str[7]+"' AND R1.FSREFVAL <='"+str[8]+"'                 \n");	
					sql.append( " 		 GROUP BY A.FDCODE,  A.ATCODE, R1.FSREFVAL,  C.ATDECR              \n");	
					sql.append( " 		UNION ALL                                                                                   \n");
					sql.append( " 		--실제데이타                                                                                \n");	
					sql.append( " 		 SELECT  /*+ leading(a g) index(a GENENLED_PK) */  --@@ 힌트 추가                                 \n");	
					sql.append( " 		         A.FDCODE,  A.ACTDAT,  A.ATCODE,  A.COCODE,  A.FSDAT,                                 \n");	
					sql.append( " 				 A.FSNBR,   A.FSSEQ,   0 BEVAL ,  A.DEAMT,   A.CRAMT,   0 JANAMT,                     \n");	
					sql.append( " 				 R1.SSDAT,  R1.SSNBR,                                                                 \n");	
					sql.append( " 				 nvl(R1.FSREFVAL,'AA') FSREFVAL01,'' FSREFVAL02, '' FSREFVAL03 , 'C'GUBUN,       \n");	
					sql.append( " 				 G.REMARK       \n");	
					sql.append( " 			FROM ACCOUNT.GENENLED A,  ACCOUNT.FSLIPDTL G,                                               \n");	
					sql.append( " 					 (SELECT B.FDCODE, B.FSDAT, B.FSNBR, B.FSSEQ, B.FSREFCD,                              \n");	
					sql.append( " 							 B.FSREFVAL, B.SSDAT, B.SSNBR                                                 \n");
					sql.append( " 						FROM ACCOUNT.GENENREF B                                                           \n");
					sql.append( " 				       WHERE 1=1      		                                                             \n");
					if(!str[0].equals(""))sql.append( "  AND B.FDCODE = '"+str[0]+"'                                                      \n");
					if(!str[4].equals(""))sql.append( "  AND B.FSREFCD = '"+str[4]+"'                                                     \n");
					if(str[9].equals("")) sql.append( "  AND B.FSREFVAL >= '"+str[7]+"' AND B.FSREFVAL <='"+str[8]+"'                     \n");
					sql.append( " 						)R1                                                                                 \n");	
					sql.append( " 		   WHERE 1=1      		                                                             \n");		
					if(!str[0].equals(""))sql.append( "  AND A.FDCODE = '"+str[0]+"'                                                      \n");
					if(!str[3].equals(""))sql.append( "	 AND A.ATCODE='"+str[3]+"'                                                        \n");	
					sql.append( " 		     AND A.FDCODE = G.FDCODE                              		\n");	
					sql.append( " 			 AND A.FSDAT =G.FSDAT                                         \n");	
					sql.append( " 			 AND A.FSNBR = G.FSNBR                                        \n");	
					sql.append( " 			 AND A.FSSEQ = G.FSSEQ                                        \n");	
					sql.append( " 			 AND A.ACTDAT>='"+str[1]+"'                                                               \n");
					sql.append( " 			 AND A.ACTDAT<='"+str[2]+"'                                                               \n");
					sql.append( " 			 AND A.FDCODE = R1.FDCODE                                                                 \n");	
					sql.append( " 			 AND A.FSDAT = R1.FSDAT                                                                   \n");	
					sql.append( " 			 AND A.FSNBR = R1.FSNBR                                                                   \n");	
					sql.append( " 			 AND A.FSSEQ = R1.FSSEQ                                                                   \n");	
					if(str[9].equals("")) sql.append( "  AND R1.FSREFVAL >='"+str[7]+"' AND R1.FSREFVAL <='"+str[8]+"'                            \n");	
					sql.append( " 		--소계1                                                                                     \n");	
					sql.append( " 		UNION ALL                                                                                   \n");
					sql.append( " 		SELECT /*+ leading(a) index(a GENENLED_PK) */  --@@ 힌트 추가                      \n");
					sql.append( " 		            A.FDCODE,  MIN(A.ACTDAT)ACTDAT,  A.ATCODE,  ''COCODE, ''FSDAT,                       \n");
					sql.append( " 					''FSNBR,  ''FSSEQ,  0 BEVAL , 0 DEAMT,   0 CRAMT,   0 JANAMT,                         \n");	
					sql.append( " 					''SSDAT,  ''SSNBR,                                                                    \n");	
					sql.append( " 					nvl(R1.FSREFVAL,'AA') FSREFVAL01, '' FSREFVAL02, '' FSREFVAL03 , 'D'GUBUN ,       \n");	
					sql.append( " 					 '' REMARK      \n");	
					sql.append( " 			FROM ACCOUNT.GENENLED A,                                                                  \n");	
					sql.append( " 					 (SELECT B.FDCODE, B.FSDAT, B.FSNBR, B.FSSEQ, B.FSREFCD,                              \n");	
					sql.append( " 									 B.FSREFVAL, B.SSDAT, B.SSNBR                                                 \n");	
					sql.append( " 							FROM ACCOUNT.GENENREF B                                                           \n");	
					sql.append( " 				       WHERE 1=1      		                                                             \n");
					if(!str[0].equals(""))sql.append( "  AND B.FDCODE = '"+str[0]+"'                                                      \n");
					if(!str[4].equals(""))sql.append( "	 AND B.FSREFCD = '"+str[4]+"'                                                     \n");
					if(str[9].equals("")) sql.append( "	 AND B.FSREFVAL >= '"+str[7]+"' AND B.FSREFVAL <='"+str[8]+"'                     \n");	
					sql.append( " 					)R1                                                                                 \n");	
					sql.append( " 		   WHERE 1=1      		                                                             \n");
					if(!str[0].equals(""))sql.append( "  AND A.FDCODE = '"+str[0]+"'                                                      \n");
					if(!str[3].equals(""))sql.append( "	 AND A.ATCODE='"+str[3]+"'                                                        \n");	
					sql.append( " 			 AND A.ACTDAT>='"+strStartdt+"'                                                          \n");	
					sql.append( " 			 AND A.ACTDAT<='"+str[2]+"'                                                              \n");	
					sql.append( " 			 AND A.FDCODE = R1.FDCODE                                                                 \n");
					sql.append( " 			 AND A.FSDAT = R1.FSDAT                                                                   \n");
					sql.append( " 			 AND A.FSNBR = R1.FSNBR                                                                   \n");	
					sql.append( " 			 AND A.FSSEQ = R1.FSSEQ                                                                   \n");	
					if(str[9].equals(""))sql.append( "  AND R1.FSREFVAL >='"+str[7]+"' AND R1.FSREFVAL <='"+str[8]+"'                            \n");	
					sql.append( " 		GROUP BY A.FDCODE,  A.ATCODE ,R1.FSREFVAL                      \n");	
					sql.append( " 		--전체계                                                                                    \n");	
					sql.append( " 		UNION ALL                                                                                   \n");	
					sql.append( " 		SELECT /*+ index(a GENENLED_PK) */  --@@ 힌트 추가                      \n");	
					sql.append( " 		        A.FDCODE,  MIN(A.ACTDAT)ACTDAT,  A.ATCODE,  ''COCODE, ''FSDAT,                       \n");	
					sql.append( " 					''FSNBR,  ''FSSEQ,  0 BEVAL , 0 DEAMT,   0 CRAMT,   0 JANAMT,                         \n");	
					sql.append( " 					''SSDAT,	''SSNBR,  'Z9999' FSREFVAL01, '9999' FSREFVAL02, '' FSREFVAL03 , 'T' GUBUN,      \n");	
					sql.append( " 					'' REMARK      \n");	
					sql.append( " 		  FROM ACCOUNT.GENENLED A                                                                   \n");
					sql.append( " 		 WHERE 1=1      		                                                             \n");
					if(!str[0].equals(""))sql.append( " AND A.FDCODE = '"+str[0]+"'                                                      \n");
					if(!str[3].equals(""))sql.append( " AND A.ATCODE='"+str[3]+"'                                                        \n");	
					sql.append( " 		   AND A.ACTDAT>='"+strStartdt+"'                                                   \n");	
					sql.append( " 		   AND A.ACTDAT<='"+str[2]+"'                                                       \n");
					sql.append( " 	 	 GROUP BY A.FDCODE,  A.ATCODE                                                                \n");	
					sql.append( " )X                                                                                              \n");	
					sql.append( " LEFT JOIN ACCOUNT.ACTCODE Y ON X.ATCODE = Y.ATCODE                                              \n");	
					sql.append( " LEFT JOIN ACCOUNT.COMMDTIL P ON X.FSREFVAL01 = P.CDCODE AND P.CMTYPE='"+str[4]+"'               \n");	
					
					//2014.01.23 관리항목 1개라서 의미없는 join은 막음.
					//sql.append( " LEFT JOIN ACCOUNT.COMMDTIL Q ON X.FSREFVAL02 = Q.CDCODE AND Q.CMTYPE='"+str[5]+"'               \n");	
					//sql.append( " LEFT JOIN ACCOUNT.COMMDTIL R ON X.FSREFVAL03 = R.CDCODE AND R.CMTYPE='"+str[6]+"'               \n");	
                    sql.append( " LEFT JOIN ACCOUNT.GCZM_VENDER K ON X.FSREFVAL01 = K.VEND_CD                 \n");	
					sql.append( " ORDER BY X.FSREFVAL01 , X.FSREFVAL02, X.FSREFVAL03, X.GUBUN, X.SSDAT , X.SSNBR                  \n");

					//System.out.println("a030012_s5 : \n" + sql);
					//logger.dbg.println(this,sql.toString());
					
/*********************************************************************************************/
					//stmt = conn.getGauceStatement(sql.toString());
		 			//stmt.executeQuery(dSet);
		 		
					Statement stmt_11 = conn.createStatement();
					ResultSet rs_11 = stmt_11.executeQuery(sql.toString()); 
   
					 while (rs_11.next()){
  	
					   GauceDataRow row = dSet.newDataRow();  // 레코드 생성
					   row = dSet.newDataRow();
   
					   row.addColumnValue(rs_11.getString(1)); //
					   row.addColumnValue(rs_11.getString(2)); //
					   row.addColumnValue(rs_11.getString(3)); //
					   row.addColumnValue(rs_11.getString(4)); //
					   row.addColumnValue(rs_11.getString(5)); //
					   row.addColumnValue(rs_11.getString(6)); //
					   row.addColumnValue(rs_11.getString(7)); //
					   row.addColumnValue(rs_11.getString(8)); //
					   row.addColumnValue(rs_11.getString(9)); //
					   row.addColumnValue(rs_11.getString(10)); //
					   row.addColumnValue(rs_11.getString(11)); //
					   row.addColumnValue(rs_11.getString(12)); //
					   row.addColumnValue(rs_11.getString(13)); //
					   row.addColumnValue(rs_11.getString(14)); //
					   row.addColumnValue(rs_11.getString(15)); //
					   row.addColumnValue(rs_11.getString(16)); //
					   row.addColumnValue(rs_11.getDouble(17)); //
					   row.addColumnValue(rs_11.getDouble(18)); //
					   row.addColumnValue(rs_11.getDouble(19)); //
					   row.addColumnValue(rs_11.getDouble(20)); //
					   row.addColumnValue(rs_11.getString(21)); //
					   row.addColumnValue(rs_11.getString(22)); //
					   row.addColumnValue(rs_11.getString(23)); //
					   row.addColumnValue(rs_11.getString(24)); //
					   dSet.addDataRow(row);
				 
					}
 					 rs_11.close();
		 			
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