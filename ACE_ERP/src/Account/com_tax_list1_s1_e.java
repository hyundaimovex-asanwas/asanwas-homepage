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
public class com_tax_list1_s1_e extends HttpServlet {
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
				String [] str = new String [8];

				str[0]	= req.getParameter("v_str1"); //거래처       
				str[1]	= req.getParameter("v_str2");	//접수일자fr   
				str[2]	= req.getParameter("v_str3");	//접수일자to   
				str[3]	= req.getParameter("v_str4");	//적요         
				str[4]	= req.getParameter("v_str5");	//매입매출구분(접수번호 첫번째 A-매입, B-매출)
				str[5]	= req.getParameter("v_str6"); //증빙구분 ( 면세 - 계산서, 그외 세금계산서 , 현금영수증, 신용카드 별도)
				str[6]	= req.getParameter("v_str7"); //부서구분 ==>사용안함.
				str[7]	= req.getParameter("v_str8"); //사용자 구분
				                                      
				for (int s=0;s<=7;s++) {
					if (str[s]==null) str[s] = "";
				}
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "TAXNBR","TAXDAT","VENDNM","REMARK","FSNBR",
					                                "TAXKND","CDNAM","GUBUN","TAXSUM","TAXVATAMT","SUMS",
					                                "TAXNBRS", "DTI_STATUS"
				                                }; 

				int[] intArrCN = new int[] { 11, 8, 32, 132, 16,
					                            1, 30, 10, 15, 15, 15,
					                           11,1
				                           }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1 ,
					                           -1, -1, -1,  0,  0,  0 ,
					                           -1,-1
				                           }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT A.TAXNBR, A.TAXDAT, B.VEND_NM AS VENDNM, A.REMARK ,                                    \n " );
					sql.append( "        CASE WHEN TRIM(A.FSNBR) IS NULL THEN '' ELSE A.FSDAT||'-'||A.FSNBR END FSNBR, \n " );
					sql.append( "        A.TAXKND,                                                                              \n " );
					sql.append( "        CASE WHEN A.TAXIODIV='A' THEN  C.CDNAM                                                 \n " );
					sql.append( "             WHEN A.TAXIODIV='B' THEN  D.CDNAM END CDNAM,                                      \n " );
					sql.append( "        CASE WHEN A.TAXIODIV='A' THEN  '매입'                                                  \n " );
					sql.append( "             WHEN A.TAXIODIV='B' THEN  '매출' END GUBUN,                                       \n " );
					sql.append( "        A.TAXSUM, A.TAXVATAMT, A.TAXSUM+A.TAXVATAMT AS SUMS, SUBSTR(A.TAXNBR,2,10) TAXNBRS, E.DTI_STATUS     \n " );
					sql.append( " FROM ACCOUNT.ATTAXMST A, ACCOUNT.GCZM_VENDER B,                                                \n " );
					sql.append( "      ACCOUNT.COMMDTIL C, ACCOUNT.COMMDTIL D , HDASAN_EDI.XXSB_DTI_STATUS  E \n " );
					/*
					sql.append( " LEFT JOIN ACCOUNT.COMMDTIL C ON C.CDCODE = A.TAXKND AND C.CMTYPE='0013'                       \n " );
					sql.append( " LEFT JOIN ACCOUNT.COMMDTIL D ON D.CDCODE = A.TAXKND AND D.CMTYPE='0009'                       \n " );
					sql.append( " LEFT JOIN HDASAN_EDI.XXSB_DTI_STATUS  E ON A.CONVERSATION_ID =E.CONVERSATION_ID               \n " );
					sql.append( "                                        AND A.SUPBUY_TYPE = E.SUPBUY_TYPE                      \n " );
					sql.append( "                                        AND A.DIRECTION = E.DIRECTION                          \n " );
					*/
					sql.append( " WHERE A.VEND_CD = B.VEND_CD                     \n " );
					sql.append( " AND B.VEND_NM LIKE '%" + str[0] + "%'           \n " );
					sql.append( " AND TRIM(A.FSNBR) IS NULL                          \n " );
					sql.append( " AND A.TAXKND = C.CDCODE(+)  AND C.CMTYPE(+)='0013' \n " );
					sql.append( " AND A.TAXKND = D.CDCODE(+)  AND D.CMTYPE(+)='0009' \n " );
					sql.append( " AND A.CONVERSATION_ID =E.CONVERSATION_ID(+)     \n " );
					sql.append( " AND A.SUPBUY_TYPE = E.SUPBUY_TYPE(+)            \n " );
					sql.append( " AND A.DIRECTION = E.DIRECTION(+)                \n " );
					
					//2009.12.10 JYS  매출은 수신미승인(C), 수신승인(I) 만 조회,,,,매입은 모두 다 조회
					//2010.08.25 JYS  매출 중 외부시스템 발행건 조회 가능
					//2010.11.15 JYS  매출 중 수기발행 조회 가능 추가
					//sql.append( " AND (('B'=VALUE(A.TAXIODIV,'') AND ( E.DTI_STATUS IN('I','C') OR A.EXTCHK='1')) OR ('A'=VALUE(A.TAXIODIV,'')))   \n");
					//sql.append( " AND (('B'=VALUE(A.TAXIODIV,'') AND ((GUBUN='1' AND ( E.DTI_STATUS IN('I','C') OR A.EXTCHK='1')) OR GUBUN='2') OR ('A'=VALUE(A.TAXIODIV,''))))   \n");
					sql.append( " AND (('B'=NVL(A.TAXIODIV,'') AND ((GUBUN='1' AND ( E.DTI_STATUS IN('I','C') OR A.EXTCHK='1')) OR GUBUN='2') OR ('A'=NVL(A.TAXIODIV,''))))   \n");
					if (!str[1].equals("")&&!str[2].equals(""))	sql.append ( " AND A.TAXDAT BETWEEN '" + str[1] + "' AND  '" + str[2]+"' \n " );
					if (!str[3].equals(""))	sql.append( " AND A.REMARK LIKE '%" +str[3] + "%'  \n " );
					//if (!str[6].equals("A"))	sql.append( " AND A.DEPTCD = '" +str[6] + "'  \n " );
					if (!str[7].equals("A"))	sql.append( " AND A.EMPNO = '" +str[7] + "'  \n " );
					
					/**2007.12.27 정영식 수정 
          			if (str[4].equals("A")){ //매입
					  sql.append( " AND SUBSTR(A.TAXNBR,1,1) = 'A'  \n " );
						if (str[5].equals("101")){ sql.append( " AND A.TAXKND IN ('1','2','4') \n " );
						}else if(str[5].equals("102")){ sql.append( " AND A.TAXKND = '3'  \n " );
						}else if(str[5].equals("103")){ sql.append( " AND A.TAXKND IN ('7','8')  \n " );
						}else { sql.append( " AND A.TAXKND IN('1','2','3','4','7','8') \n " );}
					}else if(str[4].equals("B")){ //매출
						sql.append( " AND SUBSTR(A.TAXNBR,1,1) = 'B'  \n " );
						if (str[5].equals("101")){ sql.append( " AND A.TAXKND IN ('1','2')  \n " );
						}else if(str[5].equals("102")){ sql.append( " AND A.TAXKND ='3'  \n " );
						}else { sql.append( " AND A.TAXKND IN('1','2','3')");}
					}else{
						if (str[5].equals("101")){ sql.append( " AND A.TAXKND IN ('1','2','4')  \n " );
						}else if(str[5].equals("102")){ sql.append( " AND A.TAXKND ='3'  \n " );
						}else if(str[5].equals("103")){ sql.append( " AND A.TAXKND IN ('7','8')  \n " );
						}else { sql.append( " AND A.TAXKND IN('1','2','3','4','7','8')");}
					}
					**/
					if (str[4].equals("A")||str[4].equals("C")){ //매입
					  sql.append( " AND A.TAXIODIV = 'A'  \n " );
						if (str[5].equals("101")){ sql.append( " AND A.TAXKND IN ('1','2','4') \n " );
						}else if(str[5].equals("102")){ sql.append( " AND A.TAXKND = '3'  \n " );
						}else if(str[5].equals("103")){ sql.append( " AND A.TAXKND IN ('8')  \n " );
						}else if(str[5].equals("104")){ sql.append( " AND A.TAXKND IN ('7')  \n " );
						}else { sql.append( " AND A.TAXKND IN('1','2','3','4','7','8') \n " );}
					}else if(str[4].equals("B")||str[4].equals("D")){ //매출
						sql.append( " AND A.TAXIODIV = 'B'  \n " );
						if (str[5].equals("101")){ sql.append( " AND A.TAXKND IN ('1','2')  \n " );
						}else if(str[5].equals("102")){ sql.append( " AND A.TAXKND ='3'  \n " );
						}else { sql.append( " AND A.TAXKND IN('1','2','3')");}
					}else{ //전체
						if (str[5].equals("101")){ sql.append( " AND A.TAXKND IN ('1','2','4')  \n " );
						}else if(str[5].equals("102")){ sql.append( " AND A.TAXKND ='3'  \n " );
						}else if(str[5].equals("103")){ sql.append( " AND A.TAXKND IN ('8')  \n " );
						}else if(str[5].equals("104")){ sql.append( " AND A.TAXKND IN ('7')  \n " );
						}else { sql.append( " AND A.TAXKND IN('1','2','3','4','7','8')");}
					}
					
					sql.append( " ORDER BY A.TAXNBR \n " );
				
					//logger.dbg.println(this,sql.toString());

					//System.out.println("com_tax_list1_s1_e::"+sql.toString()); 
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