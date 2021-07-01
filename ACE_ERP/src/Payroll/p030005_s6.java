package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class p030005_s6 extends HttpServlet {

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

				String [] str= new String[4] ;
				str[0] = req.getParameter("v_str1");  //귀속년도
				str[1] = req.getParameter("v_str2");	//부서
				str[2] = req.getParameter("v_str3");	//성명
				str[3] = req.getParameter("v_str4");	//사번

		  	for (int s=0;s<str.length;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO","APPDT","RELAT1","FAMNM1","RESINO1","JUMIN",

																					"REF1","REF2","REF3","REF4","REF5","REF6","REF7","REF8","CHILDCNT",

																					"REF11","REF12","REF13","REF14","REF15", "REF16",  "REF17",

																					"REF21","REF22","REF23","REF24","REF25", "REF26",	"REF27",

																					"TREF11","TREF12","TREF13","TREF14","TREF15","TREF16","TREF17",

																					"TREF21","TREF22","TREF23","TREF24","TREF25","TREF26","TREF27"
																					
				};  
					                              
				int[] intArrCN = new int[]{ 7,  6,  1, 20, 13,13,

																		1,  1,  1,  1,  1, 1,  1, 1, 2,

																		9,  9,  9,  9,  9, 9, 9,

																		9,  9,  9,  9,  9, 9, 9,

																		9,  9,  9,  9,  9, 9, 9,

																		9,  9,  9,  9,  9, 9, 9
																		
					}; 
			
				int[] intArrCN2 = new int[]{-1,	-1,	-1,	-1,	-1,	-1, 

																		-1,	-1,	-1, -1,	-1,  -1,  -1,  -1,  0,

																		 0,  0,	 0,	 0,	 0,	 0,	0,

																		 0,	 0,	 0,	 0,	 0,  0,	0,

																		 0,  0,	 0,	 0,	 0,	 0,	0,

																		 0,	 0,	 0,	 0,	 0,  0,	0
																	  
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();


					 sql.append(" 			SELECT																														\n")
						 .append("				A.EMPNO,																													\n")
						 .append("				A.APPDT,																													\n")
						 .append("				A.RELAT1,																													\n")
						 .append("				A.FAMNM1,																												\n")
						 .append("				A.RESINO1,																												\n")
						 .append("				B.RESINO AS JUMIN,																									\n")
						 .append("				IFNULL(A.REF1,'')REF1,																								\n")
						 .append("				IFNULL(A.REF2,'')REF2,																								\n") 
						 .append("				IFNULL(A.REF3,'')REF3,																								\n") 
						 .append("				IFNULL(A.REF4,'')REF4,																								\n") 
						 .append("				IFNULL(A.REF5,'')REF5,																								\n") 
						 .append("				IFNULL(A.REF6,'')REF6 ,																							\n") 
						 .append("				IFNULL(A.REF7,'')REF7,																								\n") 
						 .append("				IFNULL(A.REF8,'')REF8,																								\n")
						 .append("				'0' CHILDCNT,																											\n") 	
						 
						 .append("				CASE WHEN A.RELAT1=0 THEN COALESCE(A.REF11,0)+COALESCE(B.CINSAMT01,0)+COALESCE(B.CINSAMT02,0) +COALESCE(B.BINSAMT01,0)+COALESCE(B.BINSAMT02,0)+COALESCE(B.INSSUM,0) ELSE COALESCE(A.REF11,0) END  REF11,  \n ")


//						 .append("				COALESCE(A.REF11,0) REF11,																					\n") 						 
						 .append("				COALESCE(A.REF12,0) REF12,																					\n") 
						 .append("				COALESCE(A.REF13,0) REF13,																					\n") 
						 .append("				COALESCE(A.REF14,0) REF14,																					\n") 
						 .append("				COALESCE(A.REF15,0) REF15,																					\n") 
						 .append("				COALESCE(A.REF16,0) REF16,																					\n") 
						 .append("				COALESCE(A.REF17,0) REF17,																					\n") 
						 .append("				COALESCE(A.REF21,0) REF21,																					\n") 
						 .append("				COALESCE(A.REF22,0) REF22,																					\n") 
						 .append("				COALESCE(A.REF23,0) REF23,																					\n") 
						 .append("				COALESCE(A.REF24,0) REF24,																					\n") 
						 .append("				COALESCE(A.REF25,0) REF25,																					\n") 
						 .append("				COALESCE(A.REF26,0) REF26,																					\n") 
						 .append("				COALESCE(A.REF27,0) REF27,																					\n") 

						 .append("				'0' TREF11,'0' TREF12,'0' TREF13,'0' TREF14,'0' TREF15,'0' TREF16,'0' TREF17,			\n") 
						 .append("				'0' TREF21,'0' TREF22,'0' TREF23,'0' TREF24,'0' TREF25,'0' TREF26,'0' TREF27			\n") 

						 .append("				FROM PAYROLL.YCPRSN A																							\n") 
						 .append("				JOIN PAYROLL.YCENTRY10 B ON A.EMPNO  =  B.EMPNO  AND SUBSTR(A.APPDT,0,5)  =  B.APPYY		\n") 
						 .append("				JOIN PAYROLL.YIPERSON C ON B.RESINO  =  C.RESINO AND A.EMPNO  =  C.EMPNO							\n") 
						 .append("				WHERE																														\n") ;



					if (!str[0].equals("")) sql.append( " A.APPDT = '" + str[0] + "'																	\n" );
					if (!str[2].equals("")) sql.append( " AND C.EMPNMK = '" + str[2] + "'												\n" );
					if (!str[3].equals("")) sql.append( " AND A.EMPNO = '" + str[3] + "'															\n" );

						 sql.append("				ORDER BY A.RELAT1																									\n");
						
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