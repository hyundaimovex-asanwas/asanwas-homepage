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
public class h060012_s11 extends HttpServlet {

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
				String  str1= req.getParameter("v_str1"); //년월
				String  str2= req.getParameter("v_str2"); //부서
				String  str3= req.getParameter("v_str3"); //사번fr
				String  str4= req.getParameter("v_str4"); //사번to
				String  str5= req.getParameter("v_str5"); //입사일자
				String  str6= req.getParameter("v_str6"); //level
				String  str7= req.getParameter("v_str7"); //treecd

				if (str1==null ) {str1 ="";}
				if (str2==null ) {str2 ="";}
				if (str3==null ) {str3 ="";}
				if (str4==null ) {str4 ="";}
        if (str5==null ) {str5 ="";}
				if (str6==null ) {str6 ="";}
        if (str7==null ) {str7 ="";}

				GauceRes.enableFirstRow(dSet);
				
				String[] strArrCN = new String[]{ "EVAYM",	 "EMPNO",	 "EMPNMK",    "DEPTCD", "DEPTNM", 
					                                "PAYGRD",  "GRDNM",  "GRSTRTDT",  "STRTDT",	 "WRDT",	
					                                "TOTAVG",   "SCR1",	   "AVG1",   "SCR2",	"AVG2",
				                                            	"SCR3",	   "AVG3",	 "SCR4",	"AVG4",
                      "SCR5",	 "AVG5",      "SCR6",	 "AVG6",  "SCR7",	 "AVG7",      "SCR8",	 "AVG8", "SCR9",	 "AVG9",
                      "SCR10",	 "AVG10",      "SCR11",	 "AVG11",  "SCR12",	 "AVG12",      "SCR13",	 "AVG13", "SCR14",	 "AVG14",
                      "SCR15",	 "AVG15",      "SCR16",	 "AVG16",  "SCR17",	 "AVG17",      "SCR18",	 "AVG18", "SCR19",	 "AVG19",
                      "SCR20",	 "AVG20",      "SCR21",	 "AVG21",  "SCR22",	 "AVG22",      "SCR23",	 "AVG23", "SCR24",	 "AVG24",
                      "SCR25",	 "AVG25",      "SCR26",	 "AVG26",  "SCR27",	 "AVG27",      "SCR28",	 "AVG28", "SCR29",	 "AVG29",
                      "SCR30",	 "AVG30",      "SCR31",	 "AVG31",  "SCR32",	 "AVG32",      "SCR33",	 "AVG33", "SCR34",	 "AVG34",
                      "SCR35",	 "AVG35",      "SCR36",	 "AVG36",  "SCR37",	 "AVG37",      "SCR38",	 "AVG38", "SCR39",	 "AVG39",
                      "SCR40",	 "AVG40",      "SCR41",	 "AVG41",  "SCR42",	 "AVG42",      "SCR43",	 "AVG43", "SCR44",	 "AVG44",
                      "SCR45",	 "AVG45",      "SCR46",	 "AVG46",  "SCR47",	 "AVG47",      "SCR48",	 "AVG48", "SCR49",	 "AVG49",
                      "SCR50",	 "AVG50",      "SCR51",	 "AVG51",  "SCR52",	 "AVG52",      "SCR53",	 "AVG53", "SCR54",	 "AVG54",
                      "SCR55",	 "AVG55",      "SCR56",	 "AVG56",  "SCR57",	 "AVG57",      "SCR58",	 "AVG58", "SCR59",	 "AVG59",
                      "SCR60",	 "AVG60",       }; 
					                                             
				int[] intArrCN = new int[]{   6,  7, 20,  4,  50, 
					                            4, 30,  8,  8,   8,  
					                            5,   5,  5,  5,   5,  
					                            5,   5,  5,  5 ,
                      5,   5,  5,  5,   5,   5,   5,  5,  5,   5, 
                      5,   5,  5,  5,   5,   5,   5,  5,  5,   5, 
                      5,   5,  5,  5,   5,   5,   5,  5,  5,   5, 
                      5,   5,  5,  5,   5,   5,   5,  5,  5,   5, 
                      5,   5,  5,  5,   5,   5,   5,  5,  5,   5,
                      5,   5,  5,  5,   5,   5,   5,  5,  5,   5, 
                      5,   5,  5,  5,   5,   5,   5,  5,  5,   5, 
                      5,   5,  5,  5,   5,   5,   5,  5,  5,   5, 
                      5,   5,  5,  5,   5,   5,   5,  5,  5,   5, 
                      5,   5,  5,  5,   5,   5,   5,  5,  5,   5, 
                      5,   5,  5,  5,   5,   5,   5,  5,  5,   5, 
                      5,   5,	}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1,  -1,  -1,
					                           -1, -1, -1,  -1,  -1,
					                            2,  2,  2,    2,   2,  
					                            2,   2,   2,  2,
					 2,   2,  2,    2,   2,   2,  2,  2,    2,   2,
                     2,   2,  2,    2,   2,   2,  2,  2,    2,   2,
                     2,   2,  2,    2,   2,   2,  2,  2,    2,   2,
                     2,   2,  2,    2,   2,   2,  2,  2,    2,   2,
                     2,   2,  2,    2,   2,   2,  2,  2,    2,   2,
                     2,   2,  2,    2,   2,   2,  2,  2,    2,   2,
                     2,   2,  2,    2,   2,   2,  2,  2,    2,   2,
                     2,   2,  2,    2,   2,   2,  2,  2,    2,   2,
                     2,   2,  2,    2,   2,   2,  2,  2,    2,   2,
                     2,   2,  2,    2,   2,   2,  2,  2,    2,   2,
                     2,   2,  2,    2,   2,   2,  2,  2,    2,   2,
                     2,   2, 	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
			
          sql.append( " SELECT A.EVAYM,    A.EMPNO,    B.EMPNMK,      A.DEPTCD,      C.DEPTNM,\n" );
          sql.append( "        A.PAYGRD,   D.MINORNM AS GRDNM,        A.GRSTRTDT,    A.STRTDT,    SUBSTR(A.WRDT,1,6) WRDT,\n  ");
	    sql.append( "        A.TOTAVG,   A.SCR1,      A.AVG1,       A.SCR2,        A.AVG2,\n  ");
		sql.append( "        A.SCR3,     A.AVG3,      A.SCR4,       A.AVG4,\n ");
        sql.append( " A.SCR5  , A.AVG5  , A.SCR6,	A.AVG6,  A.SCR7,  A.AVG7,  A.SCR8 ,  A.AVG8 ,  A.SCR9 ,	A.AVG9,\n ");
        sql.append( " A.SCR10 , A.AVG10 , A.SCR11,	A.AVG11, A.SCR12, A.AVG12, A.SCR13 , A.AVG13 , A.SCR14 ,A.AVG14,\n ");
        sql.append( " A.SCR15 , A.AVG15 , A.SCR16,	A.AVG16,  A.SCR17,  A.AVG17,  A.SCR18 ,  A.AVG18 ,  A.SCR19 ,	A.AVG19,\n ");
        sql.append( " A.SCR20 , A.AVG20 , A.SCR21,	A.AVG21, A.SCR22, A.AVG22, A.SCR23 , A.AVG23 , A.SCR24 ,A.AVG24,\n ");                  
	    sql.append( " A.SCR25 , A.AVG25 , A.SCR26,	A.AVG26,  A.SCR27,  A.AVG27,  A.SCR28 ,  A.AVG28 ,  A.SCR29 ,	A.AVG29,\n ");
        sql.append( " A.SCR30 , A.AVG30 , A.SCR31,	A.AVG31, A.SCR32, A.AVG32, A.SCR33 , A.AVG33 , A.SCR34 ,A.AVG34,\n "); 				
		sql.append( " A.SCR35 , A.AVG35 , A.SCR36,	A.AVG36,  A.SCR37,  A.AVG37,  A.SCR38 ,  A.AVG38 ,  A.SCR39 ,	A.AVG39,\n ");
        sql.append( " A.SCR40 , A.AVG40 , A.SCR41,	A.AVG41, A.SCR42, A.AVG42, A.SCR43 , A.AVG43 , A.SCR44 ,A.AVG44,\n ");                  
	    sql.append( " A.SCR45 , A.AVG45 , A.SCR46,	A.AVG46,  A.SCR47,  A.AVG47,  A.SCR48 ,  A.AVG48 ,  A.SCR49 ,	A.AVG49,\n ");
        sql.append( " A.SCR50 , A.AVG50 , A.SCR51,	A.AVG51, A.SCR52, A.AVG52, A.SCR53 , A.AVG53 , A.SCR54 ,A.AVG54,\n "); 				
		sql.append( " A.SCR55 , A.AVG55  , A.SCR56,	A.AVG56,  A.SCR57,  A.AVG57,  A.SCR58 ,  A.AVG58 ,  A.SCR59 ,	A.AVG59,\n ");
        sql.append( " A.SCR60 , A.AVG60,\n "); 				
		sql.append( "   FROM PAYROLL.HVEMPS A \n");
        sql.append( "            LEFT JOIN PAYROLL.HIPERSON B ON A.EMPNO  = B.EMPNO \n");
		sql.append( "            LEFT JOIN PAYROLL.HCDEPT   C ON A.DEPTCD = C.DEPTCD   \n");
		sql.append( "            LEFT JOIN PAYROLL.HCLCODE  D ON A.PAYGRD = D.MINORCD  AND D.MAJORCD = '2002' \n");
        sql.append( " WHERE A.EVAYM   = '" + str1+"'" );
					//sql.append( "     AND A.DEPTCD  = '" + str2 +"'");
					if (!str3.equals("")&&!str4.equals(""))sql.append( " AND (A.EMPNO >= '" + str3 +"' AND A.EMPNO <= '" + str4 +"') \n");
					if (!str5.equals(""))sql.append( "     AND A.GRSTRTDT  < '" + str5 +"'\n" );

					if (str6.equals("1")) sql.append( " AND SUBSTR(C.TREECD,1,4) = '"+ str7 + "' \n");
					if (str6.equals("2")) sql.append( " AND SUBSTR(C.TREECD,1,4) = '"+ str7 + "' \n");
					if (str6.equals("3")) sql.append( " AND SUBSTR(C.TREECD,1,6) = '"+ str7 + "' \n");
					if (str6.equals("4")) sql.append( " AND RTRIM(C.TREECD) = '" + str7 + "'     \n");

				//	logger.dbg.println(this, sql.toString());
                    
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