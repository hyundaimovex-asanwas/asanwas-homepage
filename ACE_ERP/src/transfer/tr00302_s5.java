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
public class tr00302_s5 extends HttpServlet {

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
				String  str10	= req.getParameter("v_str10");    //입력자


				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				if (str7 == null) str7 = "";
				if (str8 == null) str8 = "";
				if (str9 == null) str9 = "";
				if (str10 == null) str10 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "FLAG", "ACCESSNO", "PROJECT_CD", "ACC_NAME", "ACC_DATE", "ACC_COURSE",	
													  "RTRN_DATE", "RTRN_COURSE", "START_TIME", "SMDL_TIME", "SREACH_CIQ", 
														   "RTRN_TIME" ,  "RMDL_TIME", "RREACH_CIQ", "SPERSON_CNT","SCAR_CNT", 
																"RPERSON_CNT","RCAR_CNT", "PURPOSE", "LEADER","UNDTSK_PSN", 
															"GOODS","GOODS_PSN", "PLAN_NO", "REMARK","CREATE_DT", 
														"CREATE_USR","UPDATE_DT", "UPDATE_UST",
															"P_CD", "A_COURSE", "S_CIQ","R_DATE","R_COURSE",
																"R_CIQ","G_CIQ", "C_USR", "C_DT", "U_UST",
																	"U_DT", "PP_POSE", "S_DATE"//, "R_DATE"
				
																	};

				int[] intArrCN = new int[]{ 1, 10, 4, 70, 8, 4,
										    	8, 4, 4, 4, 5, 
								                  4, 4, 5, 4, 4, 
													4, 4, 100, 30, 30, 
												  100, 100, 100, 100, 10,
												10, 10, 10,
													20, 50, 50, 50, 50, 
														50, 40, 40, 30, 20,
															 30, 30, 30//, 30
					}; 
						
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1,
					                           -1, -1, 1, -1, -1, 
												  -1, -1, -1, 0, 0,  
											         0, 0, -1, -1, -1, 
												  -1, -1, -1, -1, -1,
													 -1, -1, -1, 
														-1, -1, -1, -1, -1,
															-1, -1, -1, -1, -1,
														 -1, -1, -1//, -1
					}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT DISTINCT CASE WHEN A.ACCESSNO=K.ACCESS_NO THEN 'Y' ELSE 'N' END FLAG, A.ACCESSNO, A.PROJECT_CD, A.ACC_NAME, A.ACC_DATE, A.ACC_COURSE,  \n" );
					sql.append( " A.RTRN_DATE, A.RTRN_COURSE, A.START_TIME, A.SMDL_TIME, A.SREACH_CIQ, \n" );
					sql.append( " A.RTRN_TIME, A.RMDL_TIME, A.RREACH_CIQ, A.SPERSON_CNT, A.SCAR_CNT, \n" );
					sql.append( " A.RPERSON_CNT, A.RCAR_CNT, A.PURPOSE, A.LEADER, A.UNDTSK_PSN, \n" );
					sql.append( " A.GOODS, A.GOODS_PSN, A.PLAN_NO, A.REMARK, A.CREATE_DT, \n" );
					sql.append( " A.CREATE_USR, A.UPDATE_DT, A.UPDATE_UST,  \n" );
					sql.append( " B.MINORNM P_CD, C.MINORNM A_COURSE, D.MINORNM S_CIQ, \n" );
					
					sql.append( " SUBSTR(A.RTRN_DATE,1,4)||'-'|| SUBSTR(A.RTRN_DATE,5,2)||'-'|| \n" );
					sql.append( " SUBSTR(A.RTRN_DATE,7,2)||' '|| SUBSTR(A.RTRN_TIME,1,2)||':'|| \n" );
					sql.append( " SUBSTR(A.RTRN_TIME,3,2) R_DATE, \n" );
					
					sql.append( " E.MINORNM R_COURSE, F.MINORNM R_CIQ, G.MINORNM G_CIQ, H.EMPNMK C_USR, \n" );

					sql.append( " SUBSTR(CAST (A.CREATE_DT AS VARCHAR(30)),1,10)||'   '||   \n" );
					sql.append( " SUBSTR(CAST (A.CREATE_DT AS VARCHAR(30)),12,2)||':'||    \n" );
					sql.append( " SUBSTR(CAST (A.CREATE_DT AS VARCHAR(30)),15,2)||':'||   \n" );
					sql.append( " SUBSTR(CAST (A.CREATE_DT AS VARCHAR(30)),18,2)  \n" );
					sql.append( " C_DT, I.EMPNMK U_UST, \n" );
					sql.append( " SUBSTR(CAST (A.UPDATE_DT AS VARCHAR(30)),1,10)||'   '||  \n" );
					sql.append( " SUBSTR(CAST (A.UPDATE_DT AS VARCHAR(50)),12,2)||':'||  \n" );
					sql.append( " SUBSTR(CAST (A.UPDATE_DT AS VARCHAR(50)),15,2)||':'||  \n" );
					sql.append( " SUBSTR(CAST (A.UPDATE_DT AS VARCHAR(50)),18,2)  \n" );
					sql.append( " U_DT, J.CDNAM PP_POSE,  \n" );
					sql.append( " SUBSTR(A.ACC_DATE,1,4)||'-'|| SUBSTR(A.ACC_DATE,5,2)||'-'|| \n" );
					sql.append( " SUBSTR(A.ACC_DATE,7,2)||' '|| SUBSTR(A.START_TIME,1,2)||':'|| \n" );
					sql.append( " SUBSTR(A.START_TIME,3,2) S_DATE \n" );
					

					sql.append( " FROM TRANSFER.LTACCPLAN A \n" );
					sql.append( " LEFT JOIN TRANSFER.LTLCODE B ON B.MINORCD = A.PROJECT_CD AND B.MAJORCD = '0002'  \n" );
					sql.append( " LEFT JOIN TRANSFER.LTLCODE C ON C.MINORCD = A.ACC_COURSE AND C.MAJORCD = '0004'  \n" );
					sql.append( " LEFT JOIN TRANSFER.LTLCODE D ON D.MINORCD = A.SREACH_CIQ AND D.MAJORCD = '0007'  \n" );
					//sql.append( " LEFT JOIN PAYROLL.HIPERSON B ON B.EMPNO = A.CREATE_DT \n" );
					
					sql.append( " LEFT JOIN TRANSFER.LTLCODE E ON E.MINORCD = A.RTRN_COURSE AND E.MAJORCD = '0004'  \n" );
					sql.append( " LEFT JOIN TRANSFER.LTLCODE F ON F.MINORCD = A.RREACH_CIQ AND F.MAJORCD = '0007'  \n" );

					sql.append( " LEFT JOIN TRANSFER.LTLCODE G ON G.MINORCD = A.RREACH_CIQ AND G.MAJORCD = '0007'  \n" );
					sql.append( " LEFT JOIN PAYROLL.HIPERSON H ON H.EMPNO = A.CREATE_USR \n" );
					sql.append( " LEFT JOIN PAYROLL.HIPERSON I ON I.EMPNO = A.UPDATE_UST \n" );
					sql.append( " LEFT JOIN ACCOUNT.COMMDTIL J ON J.CDCODE = A.PURPOSE AND J.CMTYPE = '0030'  \n" );
					sql.append( " LEFT JOIN TRANSFER.LTACCPLCAR K ON K.ACCESS_NO = A.ACCESSNO   \n" );
					//sql.append( " LEFT JOIN TRANSFER.LTLCODE F ON F.MINORCD = A.RREACH_CIQ  AND D.MAJORCD = '0007'  \n" );
					//sql.append( " LEFT JOIN TRANSFER.LTLCODE G ON G.MINORCD = A.PROJECT_CD AND G.MAJORCD = '0002'  \n" );
				///	sql.append( " LEFT JOIN ACCOUNT.COMMDTIL H ON H.CDCODE = A.DEPART_PP AND H.CMTYPE = '0030'  \n" );
					//sql.append( " LEFT JOIN ACCOUNT.COMMDTIL I ON I.CDCODE = A.ENTER_PP AND I.CMTYPE = '0030'  \n" );
					//sql.append( " LEFT JOIN PAYROLL.HIPERSON J ON J.EMPNO = A.UPDATE_UST \n" );
					//sql.append( " LEFT JOIN PAYROLL.HIPERSON H ON H.EMPNO = A.UPDATE_UST \n" );
					sql.append( " WHERE A.PROJECT_CD <> ''  \n");
					
					
						
					if (!str1.equals("")) sql.append( " AND A.PROJECT_CD = '"+str1+"' \n" );
					if (!str2.equals("")) sql.append( " AND A.PURPOSE = '"+str2+"' \n" );
					if (!str3.equals("")) sql.append( "  AND  A.ACC_DATE BETWEEN '"+str3+"' AND '"+str4+"' \n");
         
					if (!str5.equals("")) sql.append( "  AND A.RTRN_DATE BETWEEN '"+str5+"' AND '"+str6+"' \n");
					if (!str7.equals("")) sql.append( "  AND A.SREACH_CIQ = '"+str7+"'  \n");
					if (!str8.equals("")) sql.append( "  AND A.RREACH_CIQ = '"+str8+"'  \n");
					if (!str9.equals("")) sql.append( "  AND A.ACCESSNO = '"+str9+"'  \n");
					if (!str10.equals("")) sql.append( " AND A.CREATE_USR = '" + str10 + "'" );
						
					logger.dbg.println( this, sql.toString() );
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