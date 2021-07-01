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
public class p030005_s4 extends HttpServlet {

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
																					"REF1","REF2","REF3","REF4","REF5",
																					"REF11","REF12","REF13","REF14","REF15", "REF16",
																					"REF21","REF22","REF23","REF24","REF25", "REF26",
																					"REF6","REF7","REF8","AD0106CNT"
				};  
					                              
				int[] intArrCN = new int[]{ 7,  6,  1, 20, 13,13,
																		1,  1,  1,  1,  1,
																		9,  9,  9,  9,  9, 9, 
																		9,  9,  9,  9,  9, 9,
																		1,  1, 1,2
					}; 
			
				int[] intArrCN2 = new int[]{-1,	-1,	-1,	-1,	-1,	-1, 
																		-1,	-1,	-1, -1,	-1,
																		 0,  0,	 0,	 0,	 0,	 0,	 
																		 0,	 0,	 0,	 0,	 0,  0,
																	  -1, -1, -1,0
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();


					sql.append(" SELECT A.EMPNO,A.APPDT,A.RELAT1,A.FAMNM1,A.RESINO1, B.RESINO AS JUMIN,\n ")
						 .append("				IFNULL(A.REF1,'')REF1,IFNULL(A.REF2,'')REF2,IFNULL(A.REF3,'')REF3,IFNULL(A.REF4,'')REF4,IFNULL(A.REF5,'')REF5, \n ")
						 .append("				CASE WHEN A.RELAT1=0 THEN COALESCE(A.REF11,0)+COALESCE(INSAMT01,0)+COALESCE(INSAMT02,0) ELSE COALESCE(A.REF11,0) END  REF11, COALESCE(A.REF12,0) REF12,COALESCE(A.REF13,0) REF13, COALESCE(A.REF14,0) REF14, COALESCE(A.REF15,0) REF15, COALESCE(A.REF16,0) REF16,  \n ")
						 .append("				COALESCE(A.REF21,0) REF21, COALESCE(A.REF22,0) REF22,COALESCE(A.REF23,0) REF23, COALESCE(A.REF24,0) REF24, COALESCE(A.REF25,0) REF25, COALESCE(A.REF26,0) REF26, \n ")
						 .append("				IFNULL(A.REF6,'')REF6 ,IFNULL(A.REF7,'')REF7,IFNULL(A.REF8,'')REF8,COALESCE(B.AD0106CNT,0)AD0106CNT \n ")
						 .append("   FROM PAYROLL.YCPRSN A, \n ")
						 //20080215. JYS 테이블 변경
					   .append("				PAYROLL.YCPAYCOL B, PAYROLL.YIPERSON C \n ")
						 //.append("				PAYROLL.YCPAYCOL B, PAYROLL.TPR_010 C \n ")
						 
						 .append("	WHERE A.EMPNO  =  B.EMPNO  \n ")
						 .append("		 AND A.APPDT  =  B.APPDT  \n ")
						 .append("		 AND A.EMPNO  =  C.EMPNO  \n ")
					 	 .append("		 AND B.RESINO  =  C.RESINO  \n ");
				//		 .append("		 AND A.RELAT1 <>'0'  \n ");

					if (!str[0].equals("")) sql.append( " AND A.APPDT = '" + str[0] + "' \n" );
					if (!str[1].equals("")) sql.append( " AND B.DEPTCD = '" + str[1] + "' \n" );
					if (!str[2].equals("")) sql.append( " AND C.EMPNMK LIKE '%" + str[2] + "%' \n" );
					if (!str[3].equals("")) sql.append( " AND A.EMPNO = '" + str[3] + "' \n" );
						
						
						sql.append("\n").append( " ORDER BY A.RELAT1 \n");
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