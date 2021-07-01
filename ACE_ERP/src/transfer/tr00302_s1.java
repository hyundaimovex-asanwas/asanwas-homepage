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
public class tr00302_s1 extends HttpServlet {

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
				String  str10	= req.getParameter("v_str10");   //입력자
				
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

				String[] strArrCN = new String[]{ "ACCESS_NO", "ACCSECTION", "SEQ_NO", "CAR_NO", "CAR_SEQ_NO",		
													  "CAR_TYPE", "PERSON_NO", "LD_CARGO", "LD_CARGONM", "OFF_CARGO", 
														   "OFF_CARGONM", "PURPOSE", "LEAD_FEE","PERSON_CNT", "START_DATE" ,  
																"START_TIME", "RTRN_DATE", "RTRN_TIME","BAECHA_NO", "RDS_GOODS", 
															"REMARK", "CREATE_DT","CREATE_USR", "UPDATE_DT","UPDATE_UST",
																"R_GOODS", "P_POSE", "C_USR", "R_DATE", "START_D", 
																	"START_DA", "SPERSON_CNT", "SCAR_CNT", "RPERSON_CNT","RCAR_CNT",
																			"L_CARGO", "O_CARGO", "GOODS", "GOODS_PSN", "PSN_KNAME",
																				"CARTYPENO", "CAR_NAME", "START_T", "RTRN_T","ST_DATE",
																			"PROJECT_CD", "ST_DATE_TIME","S_DATE_TIME", "RT_DATE_TIME","R_DATE_TIME"//,"TOT_PER_CNT"
																				
																
																	};

				int[] intArrCN = new int[]{ 10, 1, 4, 16, 12, 
										    	20, 20, 4, 50, 4,  
								                    50, 100, 1, 5, 8,  
														4, 8, 4, 20, 50, 
													512, 10, 10, 10, 10,
														30, 50, 30, 30, 30,
															 20, 4, 4, 4, 4,
																20, 20, 100, 100, 30,
																	50, 50, 20, 20,30,
																4, 30, 30, 30, 30//, 5
																	
					}; 
						
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1, 
												  -1, -1, -1, 0, -1, 
														-1, -1, -1, -1, -1, 
													-1, -1, -1, -1, -1,
														-1, -1, -1, -1, -1, 
															-1, 0, 0, 0, 0,
																-1, -1, -1, -1, -1,
																	-1, -1, -1, -1, -1,
																-1, -1, -1, -1, -1//, 0
																	
					}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT A.ACCESS_NO, A.ACCSECTION, A.SEQ_NO, A.CAR_NO, A.CAR_SEQ_NO,   \n" );
					sql.append( " A.CAR_TYPE, A.PERSON_NO, A.LD_CARGO, A.LD_CARGONM, A.OFF_CARGO,  \n" );
					sql.append( " A.OFF_CARGONM, A.PURPOSE, A.LEAD_FEE, A.PERSON_CNT, A.START_DATE,  \n" );
					sql.append( " A.START_TIME, A.RTRN_DATE, A.RTRN_TIME, A.BAECHA_NO, A.RDS_GOODS, \n" );
					sql.append( " A.REMARK, A.CREATE_DT, A.CREATE_USR, A.UPDATE_DT, A.UPDATE_UST,  \n" );
					sql.append( " B.MINORNM R_GOODS, C.CDNAM P_POSE, D.EMPNMK C_USR,   \n" );
					sql.append( " SUBSTR(A.RTRN_DATE,3,2)||'.'||SUBSTR(A.RTRN_DATE,5,2)||'.'||SUBSTR(A.RTRN_DATE,7,2) AS R_DATE, \n" );
					sql.append( " SUBSTR(A.START_DATE,5,2)||'.'||SUBSTR(A.START_DATE,7,2) AS START_D, \n" );
					sql.append( " CASE DAYOFWEEK(SUBSTR(A.START_DATE,1,4)||'-'||SUBSTR(A.START_DATE,5,2)||'-'||SUBSTR(A.START_DATE,7,2))  \n" );
					sql.append( " WHEN 1 THEN '일'  \n" );
					sql.append( " WHEN 2 THEN '월'  \n" );
					sql.append( " WHEN 3 THEN '화'  \n" );
					sql.append( " WHEN 4 THEN '수'  \n" );
					sql.append( " WHEN 5 THEN '목'  \n" );
					sql.append( " WHEN 6 THEN '금'  \n" );
					sql.append( " ELSE '토' END START_DA,  \n" );

					sql.append( " F.SPERSON_CNT, F.SCAR_CNT, F.RPERSON_CNT, F.RCAR_CNT,  \n" );
					sql.append( " G.MINORNM L_CARGO, H.MINORNM O_CARGO, F.GOODS, F.GOODS_PSN, K.PSN_KNAME,L.CARTYPENO, M.CAR_NAME,  \n" );
					sql.append( " SUBSTR(A.START_TIME,1,2)||':'||SUBSTR(A.START_TIME,3,2) AS START_T, \n" );
					sql.append( " SUBSTR(A.RTRN_TIME,1,2)||':'||SUBSTR(A.RTRN_TIME,3,4) AS RTRN_T, \n" );
					sql.append( " SUBSTR(A.START_DATE,5,2)||'월'||SUBSTR(A.START_DATE,7,2)||'일'  AS ST_DATE, PROJECT_CD, \n" );
					//sql.append( " COUNT(A.SEQ_NO) AS TOT_PER_CNT \n" );
					sql.append( " SUBSTR(A.START_DATE,1,4)||'.'||SUBSTR(A.START_DATE,5,2)||'.'||SUBSTR(A.START_DATE,7,2)||' '|| \n" );
					sql.append( " SUBSTR(A.START_TIME,1,2)||':'||SUBSTR(A.START_TIME,3,2)  AS ST_DATE_TIME, \n" );
					sql.append( " CAST(SUBSTR(A.START_TIME,1,2)||':'||SUBSTR(A.START_TIME,3,4) AS TIME)- 20 MINUTE AS S_DATE_TIME, \n" );

					sql.append( " SUBSTR(A.RTRN_DATE,1,4)||'.'||SUBSTR(A.RTRN_DATE,5,2)||'.'||SUBSTR(A.RTRN_DATE,7,2)||'.'|| \n" );
					sql.append( " SUBSTR(A.RTRN_TIME,1,2)||':'||SUBSTR(A.RTRN_TIME,3,2)  AS RT_DATE_TIME, \n" );
					sql.append( " CAST(SUBSTR(A.RTRN_TIME,1,2)||':'||SUBSTR(A.RTRN_TIME,3,4) AS TIME)- 20 MINUTE AS R_DATE_TIME \n" );


			 
					sql.append( " FROM TRANSFER.LTACCPLCAR  A \n" );
					sql.append( " LEFT JOIN TRANSFER.LTLCODE B ON B.MINORCD = A.RDS_GOODS AND B.MAJORCD = '0006'  \n" );
					sql.append( " LEFT JOIN ACCOUNT.COMMDTIL C ON C.CDCODE = A.PURPOSE AND C.CMTYPE = '0030'       \n" );
					sql.append( " LEFT JOIN PAYROLL.HIPERSON D ON D.EMPNO = A.CREATE_USR \n" );
					sql.append( " LEFT JOIN TRANSFER.LTACCPLAN F ON F.ACCESSNO = A.ACCESS_NO \n" );
					sql.append( " LEFT JOIN TRANSFER.LTLCODE G ON G.MINORCD = A.LD_CARGO AND G.MAJORCD = '0004' \n" );
					sql.append( " LEFT JOIN TRANSFER.LTLCODE H ON H.MINORCD = A.OFF_CARGO AND H.MAJORCD = '0004'  \n" );
					sql.append( " LEFT JOIN TRANSFER.LTLCODE I ON I.MINORCD = F.SREACH_CIQ AND I.MAJORCD = '0007' \n" );
					sql.append( " LEFT JOIN TRANSFER.LTLCODE J ON J.MINORCD = F.RREACH_CIQ AND J.MAJORCD = '0007' \n" );
					sql.append( " LEFT JOIN TRANSFER.LTPERSON K ON K.PERSON_NO = A.PERSON_NO  \n" );
					sql.append( " LEFT JOIN TRANSFER.LTCARINFO L ON L.CAR_NO = A.CAR_NO \n" );
					sql.append( " LEFT JOIN TRANSFER.LTCARTYPE M ON M.CAR_TYPE = A.CAR_TYPE \n" );
					sql.append( " WHERE A.ACCSECTION = 'O'  \n");
					
										
					//if (!str1.equals("")) sql.append( " AND PROJECT_CD = '"+str1+"' \n" );
					//if (!str2.equals("")) sql.append( " AND A.PURPOSE = '"+str2+"' \n" );
					if (!str3.equals("")) sql.append( "  AND  A.START_DATE BETWEEN '"+str3+"' AND '"+str4+"' \n");
         
					if (!str5.equals("")) sql.append( "  AND A.RTRN_DATE BETWEEN '"+str5+"' AND '"+str6+"' \n");
					//if (!str7.equals("")) sql.append( "  AND A.SREACH_CIQ = '"+str7+"'  \n");
					//if (!str8.equals("")) sql.append( "  AND A.RREACH_CIQ = '"+str8+"'  \n");
					if (!str9.equals("")) sql.append( "  AND A.ACCESS_NO = '"+str9+"'  \n");
				//	if (!str10.equals("")) sql.append( " AND A.CREATE_USR = '" + str10 + "'" );
						
					logger.dbg.println( this, sql.toString() );
/*********************************************************************************************/
		//			GauceRes.writeException("Sql",":",sql.toString());
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