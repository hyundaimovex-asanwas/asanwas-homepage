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
public class a030022_s1 extends HttpServlet {
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
				String []  str	= new String [5];
				str[0] = req.getParameter("v_str1");	//지점코드
				str[1] = req.getParameter("v_str2");	//회계기간 from
				str[2] = req.getParameter("v_str3");	//회계기간 to
				str[3] = req.getParameter("v_str4");	//계정FR
				str[4] = req.getParameter("v_str5");	//계정TO

				for(int i=0;i<=4;i++) {
					if(str[i] == null) str[i] = ""; 
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "GUBUN","ATDECR","ATCODE","ATKORNAM","ACTDAT",
												  "DETOT","CRTOT","SLPVLA","REMARK","VEND_CD","VENDER",
												  "FDCODE","FSDAT","FSNBR", "FSSEQ", "SSDAT", "SSNBR", "FSNUM"
				}; 

				int[] intArrCN = new int[] {  1 ,  1,   7,  66,   10,  
											   9,   9,   9, 132,   13, 32,
											   2,   9,   6,   5,   9,  6,  3	}; 
			
				int[] intArrCN2 = new int[]{ -1,  -1,  -1,  -1,  -1, 
											   0,   0,   0,  -1,  -1, -1, 
									     	  -1,  -1,  -1,  -1,  -1, -1,  -1 }; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					String strdate="";   //
					String stryyyy="";
					String strfrdt="";  //from 일자의 날짜 format

					
					if (!str[1].substring(4,8).equals("0101")){  //1월1일 조회가 아닌경우
						strfrdt= str[1];
					    //strfrdt= str[1].substring(0,4)+"-"+ str[1].substring(4,6)+"-"+ str[1].substring(6,8);
						Statement stmt_10 = conn.createStatement();
					
						String sql_10 = "  SELECT TO_CHAR(TO_DATE( '"+strfrdt +"','YYYYMMDD')-1,'YYYY-MM-DD')  AS T_DATE "
																	+ "    FROM DUAL " ; 
	
						ResultSet rs_10 = stmt_10.executeQuery(sql_10); 
						
						if(rs_10.next()){
							strdate= rs_10.getString(1);
						}
						
						strdate = strdate.substring(0,4)+ strdate.substring(5,7)+ strdate.substring(8,10);
						stryyyy =strdate.substring(0,4);
					}else{   //1월1일 조회인경우
						strdate = str[1];
						stryyyy = strdate.substring(0,4);
					}
					
					sql.append( "  --전기이월                                                                                        												\n");	
					sql.append( "  SELECT 'A'GUBUN,RTRIM(B.ATDECR) ATDECR, RTRIM(B.ATCODE) ATCODE, RTRIM(B.ATKORNAM) ATKORNAM,       	\n");	
					sql.append( "         '' ACTDAT, SUM(A.DETOT) AS DETOT, SUM(A.CRTOT) AS CRTOT,                                   				\n");	
					sql.append( "         SUM(CASE WHEN B.ATDECR='1' THEN COALESCE(A.DETOT,0)-COALESCE(A.CRTOT,0)                    	\n");	
					sql.append( "                  ELSE COALESCE(A.CRTOT,0)-COALESCE(A.DETOT,0) END) AS SLPVLA,                      	\n");	
					sql.append( "         '전기이월' AS REMARK,'' AS VEND_CD, '' AS VENDER,                                                  			\n");	
					sql.append( "         '' AS FDCODE,'' AS FSDAT,'' AS FSNBR, '' FSSEQ ,'' SSDAT, '' SSNBR, '' FSNUM               	\n");	
					sql.append( "    FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                                      			\n");	
					sql.append( "   WHERE A.ATCODE=B.ATCODE                                                                          						\n");	
					if(!str[0].equals(""))sql.append( " AND A.FDCODE='"+str[0]+"'                                                               \n");	
					if(!str[1].equals("")&&!str[2].equals("")){					
						if (!str[1].substring(4,8).equals("0101")){
										sql.append( "     AND A.ACTDAT>='"+stryyyy+"0100' AND A.ACTDAT<='"+strdate+"'  \n " );
						}else{
										sql.append( "     AND A.ACTDAT>='"+stryyyy+"0100' AND A.ACTDAT< '"+strdate+"'  \n " );
						}
					}
					if(!str[3].equals("")&&!str[4].equals(""))sql.append( "  AND A.ATCODE>='"+str[3]+"'  AND A.ATCODE<='"+str[4]+"' \n " );
					sql.append( "     AND B.ATUSEYN='Y'                                                                              	\n");	
					sql.append( "   GROUP BY B.ATDECR, B.ATCODE, B.ATKORNAM                                                          	\n");	
					
					
					sql.append( "   UNION ALL                                                                                        							\n");	
					sql.append( "  --실데이타                                                                                        							\n");	
					sql.append( "  SELECT 'B'GUBUN,B.ATDECR AS ATDECR,B.ATCODE AS ATCODE,B.ATKORNAM AS ATKORNAM,                     	\n");	
					sql.append( "         A.ACTDAT AS ACTDAT, COALESCE(A.DEAMT,0) AS DETOT, COALESCE(A.CRAMT,0) AS CRTOT,            	\n");	
					sql.append( "         CASE WHEN B.ATDECR='1' THEN COALESCE(A.DEAMT,0)-COALESCE(A.CRAMT,0)                        	\n");	
					sql.append( "                                ELSE COALESCE(A.CRAMT,0)-COALESCE(A.DEAMT,0)END AS SLPVLA,          	\n");	
					sql.append( "         C.REMARK, F.FSREFVAL VEND_CD, H.VEND_NM VENDER,                                            			\n");	
					sql.append( "         A.FDCODE, A.FSDAT, A.FSNBR, A.FSSEQ,   C.SSDAT, C.SSNBR, C.FSNUM                           	\n");	
					sql.append( "    FROM ACCOUNT.GENENLED A                                                     											\n");	
					sql.append( "    LEFT JOIN ACCOUNT.FSLIPDTL C ON A.FDCODE = C.FDCODE                                              		\n");	
					sql.append( "     											AND A.FSDAT = C.FSDAT                                        						\n");	
					sql.append( "     											AND A.FSNBR = C.FSNBR                                       						\n");	
					sql.append( "     											AND A.FSSEQ = C.FSSEQ                                      						\n");						
					sql.append( "    LEFT JOIN ACCOUNT.ACTCODE B ON A.ATCODE = B.ATCODE                                              		\n");	
					sql.append( "    LEFT JOIN ACCOUNT.GENENREF F ON A.FDCODE=F.FDCODE    /*관리항목원장*/                           	\n");	
					sql.append( "                                AND A.FSDAT=F.FSDAT AND A.FSNBR=F.FSNBR                             					\n");	
					sql.append( "                                AND A.FSSEQ=F.FSSEQ AND F.FSREFCD='0020'                            					\n");	
					sql.append( "    LEFT JOIN ACCOUNT.GCZM_VENDER H ON F.FSREFVAL=H.VEND_CD    /*거래처코드*/                       	\n");	
					sql.append( "   WHERE A.FDCODE IS NOT NULL                                                                              						\n");	
					if(!str[0].equals(""))sql.append( " AND A.FDCODE = '"+str[0]+"'                                                             					\n");
					if(!str[1].equals("")&&!str[2].equals(""))sql.append( "  AND A.ACTDAT>='"+str[1]+"' AND A.ACTDAT<='"+str[2]+"'              \n");
					if(!str[3].equals("")&&!str[4].equals(""))sql.append( "  AND A.ATCODE>='"+str[3]+"' AND A.ATCODE<='"+str[4]+"'              \n");

					
					
					sql.append( "   UNION ALL                                                                                        	\n");	
					sql.append( "  --월계                                                                                            	\n");	
					sql.append( "  SELECT 'M'GUBUN,RTRIM(B.ATDECR) ATDECR, RTRIM(B.ATCODE) ATCODE, RTRIM(B.ATKORNAM) ATKORNAM,       	\n");	
					sql.append( "         SUBSTR(A.ACTDAT,1,6)||98 ACTDAT, 0 DETOT, 0 CRTOT, 0 SLPVLA,                               	\n");	
					sql.append( "         '월계' AS REMARK,'' AS VEND_CD, '' AS VENDER,                                                  	\n");	
					sql.append( "         '' AS FDCODE,'' AS FSDAT,'' AS FSNBR,''FSSEQ, '' SSDAT, '' SSNBR, ''FSNUM                  	\n");	
					sql.append( "    FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                                      	\n");	
					sql.append( "   WHERE A.ATCODE=B.ATCODE                                                                          	\n");	
					if(!str[0].equals(""))sql.append( " AND A.FDCODE = '"+str[0]+"'                                                             \n");
					if(!str[1].equals("")&&!str[2].equals(""))sql.append( "  AND A.ACTDAT>='"+str[1]+"' AND A.ACTDAT<='"+str[2]+"'              \n");
					if(!str[3].equals("")&&!str[4].equals(""))sql.append( "  AND A.ATCODE>='"+str[3]+"' AND A.ATCODE<='"+str[4]+"'              \n");
					sql.append( "     AND B.ATUSEYN='Y'                                                                              	\n");	
					sql.append( "   GROUP BY B.ATDECR, B.ATCODE, B.ATKORNAM ,SUBSTR(A.ACTDAT,1,6)||98                                	\n");	
					
					
					sql.append( "   UNION ALL                                                                                        	\n");	
					sql.append( "  --누계                                                                                            	\n");	
					sql.append( "  SELECT 'T'GUBUN,RTRIM(B.ATDECR) ATDECR, RTRIM(B.ATCODE) ATCODE, RTRIM(B.ATKORNAM) ATKORNAM,       	\n");	
					sql.append( "         SUBSTR(A.ACTDAT,1,6)||99 ACTDAT, 0 AS DETOT, 0 AS CRTOT, 0 AS SLPVLA,                      	\n");	
					sql.append( "         '누계' AS REMARK,'' AS VEND_CD, '' AS VENDER,                                                  	\n");	
					sql.append( "         '' AS FDCODE,'' AS FSDAT,'' AS FSNBR, ''FSSEQ, '' SSDAT, '' SSNBR, ''FSNUM                 	\n");	
					sql.append( "    FROM ACCOUNT.TOTALBAL A, ACCOUNT.ACTCODE B                                                      	\n");	
					sql.append( "   WHERE A.ATCODE=B.ATCODE                                                                          	\n");	
					if(!str[0].equals(""))sql.append( " AND A.FDCODE = '"+str[0]+"'                                                             \n");
					if(!str[1].equals("")&&!str[2].equals(""))sql.append( "  AND A.ACTDAT>='"+str[1]+"' AND A.ACTDAT<='"+str[2]+"'              \n");
					if(!str[3].equals("")&&!str[4].equals(""))sql.append( "  AND A.ATCODE>='"+str[3]+"' AND A.ATCODE<='"+str[4]+"'              \n");
					sql.append( "     AND B.ATUSEYN='Y'                                                                              	\n");	
					sql.append( "   GROUP BY B.ATDECR, B.ATCODE, B.ATKORNAM,SUBSTR(A.ACTDAT,1,6)||99                                 	\n");	
					sql.append( "   ORDER BY ATCODE, GUBUN, ACTDAT, SSDAT, SSNBR, FSNUM                                                      \n");	

					// logger.dbg.println(this, sql.toString());
		            //System.out.println(sql.toString());
					
					
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