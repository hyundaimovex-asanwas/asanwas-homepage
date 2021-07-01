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
public class com_tax_list1_s1 extends HttpServlet {
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
					                                "TAXNBRS"
				                                }; 

				int[] intArrCN = new int[] { 11, 8, 32, 132, 16,
					                            1, 30, 10, 15, 15, 15,
					                           11
				                           }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1 ,
					                           -1, -1, -1,  0,  0,  0 ,
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
					sql.append( " SELECT A.TAXNBR, A.TAXDAT, B.VEND_NM AS VENDNM, A.REMARK ,                                   " );
					sql.append( "        CASE WHEN (A.FSNBR=''OR A.FSNBR IS NULL) THEN '' ELSE A.FSDAT||'-'||A.FSNBR END FSNBR," );
					sql.append( "        A.TAXKND,                                                                             " );
					sql.append( "        CASE WHEN A.TAXIODIV='A' THEN  C.CDNAM                                      " );
					sql.append( "             WHEN A.TAXIODIV='B' THEN  D.CDNAM END CDNAM,                           " );
					sql.append( "        CASE WHEN A.TAXIODIV='A' THEN  '매입'                                       " );
					sql.append( "             WHEN A.TAXIODIV='B' THEN  '매출' END GUBUN,                            " );
					sql.append( "        A.TAXSUM, A.TAXVATAMT, A.TAXSUM+A.TAXVATAMT AS SUMS, SUBSTR(A.TAXNBR,2,10) TAXNBRS    " );
					sql.append( " FROM ACCOUNT.ATTAXMST A, ACCOUNT.GCZM_VENDER B                                               " );
					sql.append( " LEFT JOIN ACCOUNT.COMMDTIL C ON C.CDCODE = A.TAXKND AND C.CMTYPE='0013'                      " );
					sql.append( " LEFT JOIN ACCOUNT.COMMDTIL D ON D.CDCODE = A.TAXKND AND D.CMTYPE='0009'                      " );
				  sql.append( " WHERE A.VEND_CD = B.VEND_CD " );
					sql.append( " AND B.VEND_NM LIKE '%" + str[0] + "%' ");
					sql.append( " AND (A.FSNBR IS NULL OR A.FSNBR = '' )");
					
					if (!str[1].equals("")&&!str[2].equals(""))	sql.append ( " AND A.TAXDAT BETWEEN '" + str[1] + "' AND  '" + str[2]+"'" );
					if (!str[3].equals(""))	sql.append( " AND A.REMARK LIKE '%" +str[3] + "%' " );
					//if (!str[6].equals("A"))	sql.append( " AND A.DEPTCD = '" +str[6] + "' " );
					if (!str[7].equals("A"))	sql.append( " AND A.EMPNO = '" +str[7] + "' " );
					
					/**2007.12.27 정영식 수정 
          if (str[4].equals("A")){ //매입
					  sql.append( " AND SUBSTR(A.TAXNBR,1,1) = 'A' " );
						if (str[5].equals("101")){ sql.append( " AND A.TAXKND IN ('1','2','4')" );
						}else if(str[5].equals("102")){ sql.append( " AND A.TAXKND = '3' " );
						}else if(str[5].equals("103")){ sql.append( " AND A.TAXKND IN ('7','8') " );
						}else { sql.append( " AND A.TAXKND IN('1','2','3','4','7','8')" );}
					}else if(str[4].equals("B")){ //매출
						sql.append( " AND SUBSTR(A.TAXNBR,1,1) = 'B' " );
						if (str[5].equals("101")){ sql.append( " AND A.TAXKND IN ('1','2') " );
						}else if(str[5].equals("102")){ sql.append( " AND A.TAXKND ='3' " );
						}else { sql.append( " AND A.TAXKND IN('1','2','3')");}
					}else{
						if (str[5].equals("101")){ sql.append( " AND A.TAXKND IN ('1','2','4') " );
						}else if(str[5].equals("102")){ sql.append( " AND A.TAXKND ='3' " );
						}else if(str[5].equals("103")){ sql.append( " AND A.TAXKND IN ('7','8') " );
						}else { sql.append( " AND A.TAXKND IN('1','2','3','4','7','8')");}
					}
					**/
					if (str[4].equals("A")){ //매입
					  sql.append( " AND A.TAXIODIV = 'A' " );
						if (str[5].equals("101")){ sql.append( " AND A.TAXKND IN ('1','2','4')" );
						}else if(str[5].equals("102")){ sql.append( " AND A.TAXKND = '3' " );
						}else if(str[5].equals("103")){ sql.append( " AND A.TAXKND IN ('8') " );
						}else if(str[5].equals("104")){ sql.append( " AND A.TAXKND IN ('7') " );
						}else { sql.append( " AND A.TAXKND IN('1','2','3','4','7','8')" );}
					}else if(str[4].equals("B")){ //매출
						sql.append( " AND A.TAXIODIV = 'B' " );
						if (str[5].equals("101")){ sql.append( " AND A.TAXKND IN ('1','2') " );
						}else if(str[5].equals("102")){ sql.append( " AND A.TAXKND ='3' " );
						}else { sql.append( " AND A.TAXKND IN('1','2','3')");}
					}else{ //전체
						if (str[5].equals("101")){ sql.append( " AND A.TAXKND IN ('1','2','4') " );
						}else if(str[5].equals("102")){ sql.append( " AND A.TAXKND ='3' " );
						}else if(str[5].equals("103")){ sql.append( " AND A.TAXKND IN ('8') " );
						}else if(str[5].equals("104")){ sql.append( " AND A.TAXKND IN ('7') " );
						}else { sql.append( " AND A.TAXKND IN('1','2','3','4','7','8')");}
					}
				
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