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
public class a070001_repay_s1 extends HttpServlet {
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
			  
			    String [] str = new String [15];
				str[0]	= req.getParameter("v_str1");	//지점
				str[1]	= req.getParameter("v_str2");	//처리기간FR
				str[2]	= req.getParameter("v_str3");	//처리기간TO
				str[3]	= req.getParameter("v_str4");	//구분
				str[4]	= req.getParameter("v_str5");	//거래처FR
				str[5]	= req.getParameter("v_str6");	//계정과목FR
				str[6]	= req.getParameter("v_str7");	//관리항목
				str[7]  = req.getParameter("v_str8");   //관리항목FR
				str[8]  = req.getParameter("v_str9");   //관리항목to
				str[11] = req.getParameter("v_str10");  //가수금의 경우 입금일자
				str[12] = req.getParameter("v_str11");  //가수금의 경우 입금일자
				str[13] = req.getParameter("v_str12");  //입금일자의 관리항목 코드
				str[14] = req.getParameter("v_str13");  //입금일자의 관리항목 코드
				
       
				for (int s=0;s<=10;s++) {
					if(str[s]==null) str[s] = "";
				}
				if(str[11]==null) str[11] = "";
				if(str[12]==null) str[12] = "";
				if(str[13]==null) str[13] = "";
				if(str[14]==null) str[14] = "";

				if(str[3].equals("N")){       //미결
					str[9] ="Y";
					str[10] ="0";
				}else if(str[3].equals("Y")){ //완료
					str[9] ="9";
					str[10] ="1";
				}else if(str[3]=="A"){ //전체
					

				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{   "CHK",	      "FDCODE",    "FSDAT",   "FSNBR",	 "FSSEQ", 
				                                    "ATCODE",     "ATKORNAM",  "SSDAT",   "SSNBR",   "FSNUM", 
					                                "GUBUN",      "REMARK",    "CHAAMT",	"DAEAMT" , "JANAMT", 
					                                "BANJAEAMT",  "VENDCD",    "VENDNM",  "DEPTCD",  "DEPTNM",
					                                "FSREFCD",    "FSREFVAL",  "FSREFNM",  "COCODE",  "DIVCD",  
												    "SSNBR1",     "ACTDAT",    "FSSTAT",   "FSREFCD2", "FSREFVAL2",  "FSREFNM2", "ATDECR",
					                                "REFCD2",     "REFVAL2",   "REFVALNM2" ,"GCUSTPAY_CHK"						
												}; 

				int[] intArrCN = new int[]{  1,  2,  9, 6, 5, 
					                           7,  66, 9, 6, 3, 
					                           10, 132,15,15,15,
					                           15, 20, 32,4, 30,
					                            4, 20, 40,2, 4, 
											   16, 8,  1 , 4,  20, 40, 1,
					                            4, 30, 40, 1
					                        }; 
				
				int[] intArrCN2 = new int[]{ -1, -1,-1, -1, -1,
					                           -1, -1,-1, -1, -1,
					                           -1, -1, 0,  0,  0,
					                            0, -1,-1, -1, -1,
					                           -1, -1,-1, -1, -1, 
                                               -1 ,-1,-1, -1,-1, -1, -1,
					                           -1, -1, -1, -1
					                           }; 
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( "  SELECT ''CHK,     N.FDCODE,  N.TSDAT FSDAT, N.TSNBR FSNBR,  N.TSSEQ FSSEQ,                    \n" );
					sql.append( "          N.ATCODE, C.ATKORNAM,N.SSDAT,       N.SSNBR,  N.FSNUM,                                \n" );
					sql.append( "          CASE WHEN N.STATUS='0' THEN 'N'                                                       \n" );
					sql.append( "               WHEN N.STATUS='1' THEN 'Y'  END  GUBUN, N.REMARK,                                \n" );
					sql.append( "          N.DEAMT CHAAMT, N.CRAMT DAEAMT,                                                       \n" );
					sql.append( "          CASE WHEN C.ATDECR = '1' THEN  COALESCE(N.DEAMT,0)- COALESCE(N.CRAMT,0)               \n" );
					sql.append( "               WHEN C.ATDECR = '2' THEN  COALESCE(N.CRAMT,0)- COALESCE(N.DEAMT,0) END  JANAMT,  \n" );
					sql.append( "          0 BANJAEAMT,                                                                          \n" );
					//sql.append( "          N.DEPTCD, E2.CDNAM DEPTNM, N.VENDCD, E.CDNAM VENDNM,                                  \n" );
					sql.append( "          N.DEPTCD, E2.DEPTNM DEPTNM, N.VENDCD, E.CDNAM VENDNM,                                 \n" );
					sql.append( "          N.FSREFCD, N.FSREFVAL,  E3.CDNAM FSREFNM, ''COCODE, ''DIVCD,                          \n" );
					sql.append( "          N.SSDAT||'-'||N.SSNBR AS SSNBR1 , SUBSTR(N.SSDAT,2,9) ACTDAT, 'Y' FSSTAT,             \n" );
					sql.append( "          E4.CMTYPE FSREFCD2, E4.CDCODE FSREFVAL2, E4.CDNAM FSREFNM2 , C.ATDECR,                \n" );
					sql.append( "          N.FSREFCD2 AS REFCD2, N.FSREFVAL2 AS REFVAL2,                                         \n" ); //추가된필드임
					//2008.02.01 정영식 수정 (미지급금(법인카드)를 코드없이 text로만 입력함.
					//sql.append( "          CASE WHEN N.FSREFCD2='0029' THEN E6.VEND_NM ELSE E5.CDNAM END REFVALNM2               \n" );
					sql.append( "					CASE WHEN N.FSREFCD2='0029' AND SUBSTR(N.FSREFVAL2,1,1)='I'  THEN E6.VEND_NM  \n");
					sql.append( "					     WHEN N.FSREFCD2='0029' AND SUBSTR(N.FSREFVAL2,1,1)<>'I' THEN N.FSREFVAL2 \n");
					sql.append( "					     ELSE E5.CDNAM END REFVALNM2                                              \n");
					//2015.07.01 정영식 수정 - 대금지급 테이블에 데이터 저장 시점에 체크하여 MSG 뿌려줌. 
					sql.append( "			,CASE WHEN G.TSDAT IS NOT NULL THEN 'Y' ELSE 'N' END GCUSTPAY_CHK		     \n");
					sql.append( "       FROM ACCOUNT.BANJAEMST N ,ACCOUNT.ACTCODE C,                                              \n" );
					sql.append( "       ACCOUNT.COMMDTIL E,  PAYROLL.HCDEPT E2,      \n" );
					sql.append( "       ACCOUNT.COMMDTIL E3, ACCOUNT.COMMDTIL E4,    \n" );
					sql.append( "       ACCOUNT.COMMDTIL E5, ACCOUNT.GCZM_VENDER E6, \n" );
					sql.append( "       ACCOUNT.FSLIPMST F,  ACCOUNT.ACUSTPAY G      \n" );
										
					sql.append( "      WHERE N.ATCODE = C.ATCODE                                                                 \n" );
					sql.append( "        AND N.STATUS='"+str[10]+"'                                                              \n" );
					sql.append( "        AND SUBSTR(N.SSDAT,2,9) >='"+str[1]+"' AND  SUBSTR(N.SSDAT,2,9)<='"+str[2]+"'           \n" );
					sql.append( "        AND N.FDCODE='"+str[0]+"'                                                               \n" );
					sql.append( "        AND N.ATCODE='"+str[5]+"'                                                               \n" );
					
					if(!str[4].equals("All"))sql.append( "  AND N.VENDCD='"+str[4]+"'                                                            \n" );	
					if(!str[6].equals(""))sql.append( "  AND N.FSREFCD='"+str[6]+"'                                                              \n" );	

					/* 2014.02.04 이동훈 수정 ㅜ.ㅜ 힘들다 */ 					
					if((!str[7].equals("")&&!str[8].equals("")) && (!str[7].equals(" ")&&!str[8].equals(" ")))sql.append( " AND N.FSREFVAL>='"+str[7]+"' AND  N.FSREFVAL<='"+str[8]+"'           \n" );
					
					if(!str[11].equals("")&&!str[12].equals(""))sql.append( " AND N.FSREFVAL2>='"+str[11]+"' AND  N.FSREFVAL2<='"+str[12]+"'     \n" );				
					if(!str[13].equals(""))sql.append( " AND N.FSREFCD2>='"+str[13]+"' \n" );							
					
					sql.append( "      AND N.VENDCD = E.CDCODE(+) AND E.CMTYPE(+)='0020'   \n" );
					sql.append( "      AND N.DEPTCD = E2.DEPTCD(+) AND E2.CHGYM =( SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT )  \n" );
					sql.append( "      AND N.FSREFVAL = E3.CDCODE(+) AND N.FSREFCD =E3.CMTYPE(+)  \n" );
					sql.append( "      AND E3.GBCD=E4.CDCODE(+)  AND E3.CDREMARK = E4.CMTYPE(+) \n" );
					sql.append( "      AND N.FSREFVAL2 = E5.CDCODE(+) AND N.FSREFCD2=E5.CMTYPE(+) \n" );
					sql.append( "      AND N.FSREFVAL2 = E6.VEND_CD(+)   \n" );
					//2017.03.07 JYS F.EMPNO 작성자 추가 
					sql.append( "      AND N.FDCODE = F.FDCODE(+) AND N.TSDAT = F.FSDAT(+) AND N.TSNBR = F.FSNBR(+) AND F.EMPNO='"+str[14]+"'  \n" );
					
					sql.append( "      AND (( F.FSLOCK = 'F' OR F.FSLOCK IS NULL ) \n" ); //전표없는 반제건이 존재함. 2006 최초 시점 
					sql.append( "      OR ( F.FSLOCK = 'T' AND C.ATCODE IN ('1120700','1110215') ) )\n" ); //저장품,상품은 잠겨있어도 검색되도록 2014.3.11 이동훈
					sql.append( "      AND N.FDCODE = G.FDCODE(+) AND N.TSDAT = G.TSDAT(+) AND N.TSNBR = G.TSNBR(+) AND N.TSSEQ = G.TSSEQ(+)  \n" );  //2015.07.01 대금지급 조인 
					if(str[5].equals("2101300")||str[5].equals("2100920")) sql.append( "  ORDER BY  REFVAL2, N.SSDAT,N.SSNBR, N.TSSEQ  \n" );
					else sql.append( " ORDER BY  N.SSDAT,N.SSNBR, N.TSSEQ  \n" );

					//logger.dbg.println(this,sql.toString());
					//System.out.println("a020003_s1:"+sql.toString());
				  
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