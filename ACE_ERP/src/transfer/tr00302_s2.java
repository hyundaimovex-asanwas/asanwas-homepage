package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class tr00302_s2 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");    //프로젝트
				String  str2	= req.getParameter("v_str2");    //투입목적
				String  str3	= req.getParameter("v_str3");    //출경일자 FROM
				String  str4	= req.getParameter("v_str4");    //출경일자 TO
 				String  str5	= req.getParameter("v_str5");    //입경일자 FROM
				String  str6	= req.getParameter("v_str6");    //입경일자 TO
				String  str7	= req.getParameter("v_str7");    //출경목적지
				String  str8	= req.getParameter("v_str8");    //입경목적지 
				String  str9	= req.getParameter("v_str9");    //출입번호
				
				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				if (str7 == null) str7 = "";
				if (str8 == null) str8 = "";
				if (str9 == null) str9 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ACCESSNO",	"ACCSECTION", "SEQ_NO", "PERSON_NO", "CAR_NO", 	
													  "PRSN_NAME", "PRSN_CMPY", "JOB_DUTY",	"GENDER" , "PRSN_REGNO", 
														   "ADDRESS1", "PURPOSE","ACC_AREA", "DRIVE_DIV" , "START_DATE",  
																"START_TIME", "RTRN_DATE", "RTRN_TIME", "REMARK", "CREATE_DT", 
															 "CREATE_USR", "UPDATE_DT","UPDATE_UST",
																"P_REGNO", "PR_REGNO", "S_DATE", "P_POSE02", 
																	 "A_AREA", "IMAGE", "C_USR", "RT_DATE", "P_CMPY",
																		"SEX"
																	};

				int[] intArrCN = new int[]{ 10, 1, 4, 10, 16, 
												20, 30, 20, 1, 13,  
								                    100, 100, 20, 1, 8, 
														4, 8, 4, 512, 10, 
													10, 10, 10, 
														30, 30, 30, 50, 
															30, 50, 30, 30, 30,
																10
					}; 
						
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1, 
												  -1, -1, -1, -1, -1,
														-1, -1, -1, -1, -1,
													-1, -1, -1,
														-1, -1, -1, -1,
															-1, -1, -1, -1, -1,
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
					sql.append( " SELECT A.ACCESSNO, A.ACCSECTION, A.SEQ_NO, A.PERSON_NO, A.CAR_NO,   \n" );
					sql.append( " A.PRSN_NAME, A.PRSN_CMPY, A.JOB_DUTY, A.GENDER, A.PRSN_REGNO,  \n" );
					sql.append( " A.ADDRESS1, A.PURPOSE, A.ACC_AREA, A.DRIVE_DIV, A.START_DATE,  \n" );
					sql.append( " A.START_TIME, A.RTRN_DATE, A.RTRN_TIME, A.REMARK, A.CREATE_DT, \n" );
					sql.append( " A.CREATE_USR, A.UPDATE_DT, A.UPDATE_UST, \n" );
					sql.append( " SUBSTR(A.PRSN_REGNO,1,6)||'-'||SUBSTR(A.PRSN_REGNO,7,7) AS P_REGNO, \n" );
					sql.append( " SUBSTR(A.PRSN_REGNO,1,2)||'.'||SUBSTR(A.PRSN_REGNO,3,2)||'.'||SUBSTR(A.PRSN_REGNO,5,2) AS PR_REGNO, \n" );
				    sql.append( " SUBSTR(A.START_DATE,3,2)||'.'||SUBSTR(A.START_DATE,5,2)||'.'||SUBSTR(A.START_DATE,7,2) AS S_DATE, \n" );
					sql.append( " B.CDNAM P_POSE02, C.MINORNM A_AREA, \n" );
					sql.append( "  '../picture/' CONCAT A.PERSON_NO CONCAT '.jpg' AS  IMAGE,  D.EMPNMK C_USR,  \n" );
					sql.append( " SUBSTR(A.RTRN_DATE,3,2)||'.'||SUBSTR(A.RTRN_DATE,5,2)||'.'||SUBSTR(A.RTRN_DATE,7,2) AS RT_DATE, \n" );
					//sql.append( "  '../picture/' ||  A.PERSON_NO || '.jpg' AS  IMAGE \n" );
					sql.append( " E.MINORNM P_CMPY, \n" );

					sql.append( " CASE WHEN A.GENDER = 'M' then '남' \n" );
					sql.append( " ELSE '여' \n" );
					sql.append( " END  SEX \n" );
					
					sql.append( " FROM TRANSFER.LTPSRNACC A  \n" );
					sql.append( " LEFT JOIN ACCOUNT.COMMDTIL B ON B.CDCODE = A.PURPOSE AND B.CMTYPE = '0030'       \n" );
					sql.append( " LEFT JOIN TRANSFER.LTLCODE C ON C.MINORCD = A.ACC_AREA   AND C.MAJORCD = '0007'  \n" );
					sql.append( " LEFT JOIN PAYROLL.HIPERSON D ON D.EMPNO = A.CREATE_USR \n" );
					sql.append( " LEFT JOIN TRANSFER.LTLCODE E ON E.MINORCD = A.PRSN_CMPY   AND E.MAJORCD = '0015'  \n" );
					
					
					sql.append( " WHERE A.ACCSECTION = 'O'  \n");
					
					//if (!str1.equals("")) sql.append( " AND PROJECT_CD = '"+str1+"' \n" );
					//if (!str2.equals("")) sql.append( " AND A.PURPOSE = '"+str2+"' \n" );
					if (!str3.equals("")) sql.append( " AND  A.START_DATE BETWEEN '"+str3+"' AND '"+str4+"' \n");
         
					if (!str5.equals("")) sql.append( "  AND A.RTRN_DATE BETWEEN '"+str5+"' AND '"+str6+"' \n");
					//if (!str7.equals("")) sql.append( "  AND A.ACC_AREA = '"+str7+"'  \n");
					//if (!str8.equals("")) sql.append( "  AND A.RREACH_CIQ = '"+str8+"'  \n");
					if (!str9.equals("")) sql.append( "  AND A.ACCESSNO = '"+str9+"'  \n");
					//if (!str10.equals("")) sql.append( " AND A.CREATE_USR = '" + str10 + "'" );
						
					//logger.dbg.println( this, sql.toString() );
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