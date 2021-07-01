package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class h050003_s1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");		//검색일 FROM
				String  str2	= req.getParameter("v_str2");		//검색일 TO
				String  str3	= req.getParameter("v_str3");		//구분[A:결재 B:미결재 C:결재취소 D:전체]
				String  str4	= req.getParameter("v_str4");		//근무구분
				String  str5	= req.getParameter("v_str5");		//부서명
				String  str6	= req.getParameter("v_str6");		//Level
				String  str7	= req.getParameter("v_str7");		//Treecd

        if (str4==null) str4="";
				if (str6==null) str6="";
				if (str7==null) str7="";
    
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CHK",		"APPDT",  "LAZCD", "LAZNM" , "EMPNO",  "EMPNMK", 
																					"FRDT",		"FRTIME", "TODT",  "TOTIME", "SGDT",
																					"SGNM",		"SGNID",  "AGRDT", "AGNM",   "AGRID",  
																					"DTYREM", "DEPTNM" , "AMT"
																				}; 

				int[] intArrCN = new int[]{   1,  8,  4,  30, 7, 20, 
																			8,  6,  8,  6,  8, 
																		 20,  7,  8, 20,  7, 40, 50, 7
																	}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1, 
																		 -1, -1, -1, -1, -1, 
																		 -1, -1, -1, -1, -1, -1, -1, 0
																	}; 
			
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					

					StringBuffer sql = new StringBuffer();
					
					sql.append( " SELECT ");
					sql.append( " 'F' as CHK, RTRIM(D.APPDT) APPDT, RTRIM(D.LAZCD) LAZCD, RTRIM(F.MINORNM) LAZNM, RTRIM(D.EMPNO) EMPNO, ");
					sql.append( " RTRIM(A.EMPNMK) EMPNMK,  RTRIM(D.FRDT) FRDT, RTRIM(D.FRTIME) FRTIME, RTRIM(D.TODT) TODT, ");
					sql.append( " RTRIM(D.TOTIME) TOTIME, RTRIM(D.SGDT) SGDT,  B.EMPNMK AS SGNM, ");
					sql.append( " RTRIM(D.SGNID) SGNID, RTRIM(D.AGRDT) AGRDT,  C.EMPNMK AS AGNM, ");
					sql.append( " RTRIM(D.AGRID) AGRID, RTRIM(D.DTYREM) DTYREM, RTRIM(E.DEPTNM) DEPTNM, ");
					sql.append( " COALESCE(D.AMT,0) AMT  ");
					sql.append( " FROM PAYROLL.HLDUTY D ");
					sql.append( "	LEFT JOIN PAYROLL.HIPERSON A ON A.EMPNO  =  D.EMPNO ");
					sql.append( "	LEFT JOIN PAYROLL.HIPERSON B ON B.EMPNO  =  D.SGNID ");
					sql.append( "	LEFT JOIN PAYROLL.HIPERSON C ON C.EMPNO  =  D.AGRID ");
					sql.append( "	LEFT JOIN PAYROLL.HCDEPT	 E ON E.DEPTCD =  A.DEPTCD AND E.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) ");
					sql.append( " LEFT JOIN PAYROLL.HCLCODE  F ON F.MINORCD = D.LAZCD AND F.MAJORCD = '1124' ");
					sql.append( " WHERE APPDT BETWEEN '"+str1+"' AND '"+str2+"'" );

          
					if (str4.equals("A"))  {			//승인
							sql.append( "     AND (D.LAZCD LIKE '%')" );
          }else if (str4.equals("GCH"))  {			//승인
							sql.append( "     AND (D.LAZCD LIKE 'G%' OR D.LAZCD LIKE 'H%' OR D.LAZCD LIKE 'C%')" );
					}else{
							sql.append( "     AND D.LAZCD LIKE '"+str4+"%'" );
          }

					if (str3.equals("A"))  {			//승인
						sql.append( " AND AGRDT is not null and SGDT != '99999999' " ); 
					}
					else if (str3.equals("B"))  {	//미승인
						sql.append( " AND AGRDT is null  " ); 
					}
					else if (str3.equals("C"))  {	//승인취소
						sql.append( " AND AGRDT = '99999999' "); 
					}
					
					if (str6.equals("1")) sql.append( " AND SUBSTR(E.TREECD,1,4)= '" + str7 +"'");
					if (str6.equals("2")) sql.append( " AND SUBSTR(E.TREECD,1,4)= '" + str7 + "'");
					if (str6.equals("3")) sql.append( " AND SUBSTR(E.TREECD,1,6)= '" + str7 +"'");
					if (str6.equals("4")) sql.append( " AND RTRIM(E.TREECD)= '" + str7 + "'");

					sql.append( " ORDER BY D.APPDT, D.EMPNO ");

					//	logger.dbg.println(this,sql.toString());

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