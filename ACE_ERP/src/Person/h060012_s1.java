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
public class h060012_s1 extends HttpServlet {

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
				String  str1= req.getParameter("v_str1");  //고과년월
				String  str2= req.getParameter("v_str2");  //부서
				String  str3= req.getParameter("v_str3");  //직위
				String  str4= req.getParameter("v_str4");  //성명
				String  str5= req.getParameter("v_str5");  //level
				String  str6= req.getParameter("v_str6");  //treecd

				if (str1==null ) {str1 ="";}
				if (str2==null ) {str2 ="";}
				if (str3==null ) {str3 ="";}
				if (str4==null ) {str4 ="";}
				if (str5==null ) {str5 ="";}
				if (str6==null ) {str6 ="";}
             
				GauceRes.enableFirstRow(dSet);
				
				String[] strArrCN = new String[]{ "EVAYM",	 "EMPNO",	 "EMPNMK",    "DEPTCD", "DEPTNM", 
					                                "PAYGRD",  "GRDNM",  "GRSTRTDT",  "STRTDT",	"WRDT",	
					                                "TOTAVG",  "SCR1",	 "AVG1",      "SCR2",	  "AVG2",	    
		     			                            "SCR3",	   "AVG3",	 "SCR4",	    "AVG4" ,
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
                      "SCR60",	 "AVG60",
                                                 "LAMDT",   "RECDIV", "RECNM",     "JOBKIND","JOBNM", "JOBREF",
		                                         "SEQ",     "PAYSEQ" 	}; 

					                                             
				int[] intArrCN = new int[]{   6,  7, 20,  4,  50, 
					                            4, 30,  8,  8,   8,  
					                            5,  5,  5,  5,   5,  
					                            5,  5,  5,  5, 
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
                      5,   5,
			                            8,  4,  30, 4,  30, 2, 
					                         3,  4   }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1,  -1,  -1,
					                           -1, -1, -1,  -1,  -1,
					                            2,  2,  2,   2,   2,  
					                            2,  2,  2,   2,
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
                     2,   2, 
					                           -1, -1, -1,  -1,  -1, -1,
					                            0, -1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
                    sql.append( " SELECT X.EVAYM,   X.EMPNO, X.EMPNMK  ,X.DEPTCD,       X.DEPTNM,			\n");
					sql.append( "  			 X.PAYGRD,  X.GRDNM, X.GRSTRTDT,   X.STRTDT,    X.WRDT,				\n");
					sql.append( "  			 X.TOTAVG,  X.SCR1,      X.AVG1,      X.SCR2,   X.AVG2,					\n");
                    sql.append( "  			 X.SCR3,     X.AVG3,     X.SCR4,      X.AVG4,							\n");
                sql.append( " X.SCR5  , X.AVG5  , X.SCR6,	X.AVG6,  X.SCR7,  X.AVG7,  X.SCR8 ,  X.AVG8 ,  X.SCR9 ,	 X.AVG9,  \n ");
                sql.append( " X.SCR10 , X.AVG10 , X.SCR11,	X.AVG11, X.SCR12, X.AVG12, X.SCR13 , X.AVG13 , X.SCR14 , X.AVG14,  \n ");
                sql.append( " X.SCR15 , X.AVG15 , X.SCR16,	X.AVG16, X.SCR17, X.AVG17, X.SCR18 , X.AVG18 , X.SCR19 , X.AVG19,  \n ");
                sql.append( " X.SCR20 , X.AVG20 , X.SCR21,	X.AVG21, X.SCR22, X.AVG22, X.SCR23 , X.AVG23 , X.SCR24 , X.AVG24,  \n ");                  
	            sql.append( " X.SCR25 , X.AVG25 , X.SCR26,	X.AVG26, X.SCR27, X.AVG27, X.SCR28 , X.AVG28 , X.SCR29 , X.AVG29,  \n ");
                sql.append( " X.SCR30 , X.AVG30 , X.SCR31,	X.AVG31, X.SCR32, X.AVG32, X.SCR33 , X.AVG33 , X.SCR34 , X.AVG34,  \n "); 				
         		sql.append( " X.SCR35 , X.AVG35 , X.SCR36,	X.AVG36, X.SCR37, X.AVG37, X.SCR38 , X.AVG38 , X.SCR39 , X.AVG39,  \n ");
                sql.append( " X.SCR40 , X.AVG40 , X.SCR41,	X.AVG41, X.SCR42, X.AVG42, X.SCR43 , X.AVG43 , X.SCR44 , X.AVG44 ,  \n");                  
          	    sql.append( " X.SCR45 , X.AVG45 , X.SCR46,	X.AVG46, X.SCR47, X.AVG47, X.SCR48 , X.AVG48 , X.SCR49 , X.AVG49 ,  \n");
                sql.append( " X.SCR50 , X.AVG50 , X.SCR51,	X.AVG51, X.SCR52, X.AVG52, X.SCR53 , X.AVG53 , X.SCR54 , X.AVG54,  \n "); 				
        		sql.append( " X.SCR55 , X.AVG55  , X.SCR56,	X.AVG56, X.SCR57, X.AVG57, X.SCR58 , X.AVG58 , X.SCR59 , X.AVG59,  \n ");
                sql.append( " X.SCR60 , X.AVG60,  \n "); 	
					sql.append( "  			 X.LAMDT,   X.RECDIV,  X.RECNM,X.JOBKIND,X.JOBNM,	X.JOBREF,X.SEQ, X.PAYSEQ \n");
                    sql.append( "   FROM(										\n");
					sql.append( "        SELECT A.EVAYM,    A.EMPNO,  										\n");
                    sql.append( "              CASE WHEN SUBSTR(A.EMPNO,1,1) IN ('1','2') THEN B.EMPNMK ELSE T.EMPNMK END EMPNMK ,\n");
					sql.append( "               A.DEPTCD,      C.DEPTNM,	 \n");
					sql.append( "               A.PAYGRD,   D.MINORNM AS GRDNM,        RTRIM(A.GRSTRTDT)GRSTRTDT,    RTRIM(A.STRTDT)STRTDT,    A.WRDT,  \n");
					sql.append( "               A.TOTAVG,   A.SCR1,      A.AVG1,       A.SCR2,        A.AVG2,													\n");
					sql.append( "               A.SCR3,     A.AVG3,      A.SCR4,       A.AVG4,																					\n");
		        sql.append( " A.SCR5  , A.AVG5  , A.SCR6,	A.AVG6,  A.SCR7,  A.AVG7,  A.SCR8 ,  A.AVG8 ,  A.SCR9 ,	A.AVG9,  \n ");
                sql.append( " A.SCR10 , A.AVG10 , A.SCR11,	A.AVG11, A.SCR12, A.AVG12, A.SCR13 , A.AVG13 , A.SCR14 ,A.AVG14,  \n ");
                sql.append( " A.SCR15 , A.AVG15 , A.SCR16,	A.AVG16,  A.SCR17,  A.AVG17,  A.SCR18 ,  A.AVG18 ,  A.SCR19 ,	A.AVG19,  \n ");
                sql.append( " A.SCR20 , A.AVG20 , A.SCR21,	A.AVG21, A.SCR22, A.AVG22, A.SCR23 , A.AVG23 , A.SCR24 ,A.AVG24,  \n ");                  
	            sql.append( " A.SCR25 , A.AVG25 , A.SCR26,	A.AVG26,  A.SCR27,  A.AVG27,  A.SCR28 ,  A.AVG28 ,  A.SCR29 ,	A.AVG29,  \n ");
                sql.append( " A.SCR30 , A.AVG30 , A.SCR31,	A.AVG31, A.SCR32, A.AVG32, A.SCR33 , A.AVG33 , A.SCR34 ,A.AVG34,  \n "); 				
         		sql.append( " A.SCR35 , A.AVG35 , A.SCR36,	A.AVG36,  A.SCR37,  A.AVG37,  A.SCR38 ,  A.AVG38 ,  A.SCR39 ,	A.AVG39,  \n ");
                sql.append( " A.SCR40 , A.AVG40 , A.SCR41,	A.AVG41, A.SCR42, A.AVG42, A.SCR43 , A.AVG43 , A.SCR44 ,A.AVG44 ,  \n");                  
          	    sql.append( " A.SCR45 , A.AVG45 , A.SCR46,	A.AVG46,  A.SCR47,  A.AVG47,  A.SCR48 ,  A.AVG48 ,  A.SCR49 ,	A.AVG49 ,  \n");
                sql.append( " A.SCR50 , A.AVG50 , A.SCR51,	A.AVG51, A.SCR52, A.AVG52, A.SCR53 , A.AVG53 , A.SCR54 ,A.AVG54,  \n "); 				
        		sql.append( " A.SCR55 , A.AVG55  , A.SCR56,	A.AVG56,  A.SCR57,  A.AVG57,  A.SCR58 ,  A.AVG58 ,  A.SCR59 ,	A.AVG59,  \n ");
                sql.append( " A.SCR60 , A.AVG60,  \n "); 			
					sql.append( "               RTRIM(A.LAMDT)LAMDT,    A.RECDIV,  RTRIM(E.MINORNM) RECNM, A.JOBKIND, RTRIM(F.MINORNM) JOBNM,			\n");
					sql.append( "               A.JOBREF, D.SEQ, B.PAYSEQ																																					\n");
					sql.append( "        FROM PAYROLL.HVEMPS A																																					\n");
                    sql.append( "        LEFT JOIN PAYROLL.HIPERSON B ON A.EMPNO   = B.EMPNO																			\n");
					sql.append( "        LEFT JOIN PAYROLL.HCDEPT   C ON A.DEPTCD = C.DEPTCD																			\n");
					sql.append( "        LEFT JOIN PAYROLL.HCLCODE  D ON A.PAYGRD = D.MINORCD  AND D.MAJORCD = '2002'							\n");
					sql.append( "        LEFT JOIN PAYROLL.HCLCODE  E ON A.RECDIV = E.MINORCD  AND E.MAJORCD = '2035'							\n");
					sql.append( "        LEFT JOIN PAYROLL.HCLCODE  F ON A.JOBREF = F.MINORCD  AND F.MAJORCD = '2034'						 \n");
          sql.append( "        LEFT JOIN PAYROLL.T_HIPERSON T ON A.EMPNO   = T.EMPNO						 \n");
          sql.append( "       WHERE A.EVAYM <> ''																																						\n");
					if (!str1.equals("")) sql.append( " AND A.EVAYM   = '" + str1+"'						 \n");
					if (!str3.equals("")) sql.append( " AND A.PAYGRD  = '" + str3 +"'						 \n");
				    if (str5.equals("1")) sql.append( " AND SUBSTR(C.TREECD,1,4) = '"+ str6 + "' \n");
					if (str5.equals("2")) sql.append( " AND SUBSTR(C.TREECD,1,4) = '"+ str6 + "' \n");
					if (str5.equals("3")) sql.append( " AND SUBSTR(C.TREECD,1,6) = '"+ str6 + "' \n");
					if (str5.equals("4")) sql.append( " AND RTRIM(C.TREECD) = '" + str6 + "'     \n");
					sql.append( "    ) X										\n");
					sql.append( "    WHERE X.EVAYM <> ''									\n");
					if (!str4.equals("")) sql.append( " AND X.EMPNMK  LIKE '" + str4 +"%' 	 \n");
					sql.append( " ORDER BY X.SEQ, X.PAYSEQ DESC, X.GRSTRTDT ");
    logger.dbg.println(this, sql.toString());
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