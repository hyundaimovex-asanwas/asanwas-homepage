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
public class p030002_s6 extends HttpServlet {

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
				String [] str = new String [10];
				str[0]	= req.getParameter("v_str1");		//사번
				str[1]  = req.getParameter("v_str2");		//귀속년도
				str[2]  = req.getParameter("v_str3");		//부서
				str[3]  = req.getParameter("v_str4");		//작성일자

				for (int s=0;s<=3;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);
				String[] strArrCN = new String[]{
						"YYYY",			/*귀속연도*/
						"EMPNO",    /*사번*/
						"EMPNMK",		/*성명*/
						"RESINO",		/*주민등록번호*/
						"EMPCNT",		/*총건수*/
						"CURDT"			/*작성일자*/
				};

				int[] intArrCN = new int[]{
						4,					/*귀속연도*/
						7,					/*사번*/             
						20,					/*성명*/             
						13,					/*주민등록번호*/
						3,					/*총건수*/
						8						/*작성일자*/  
				};
				
				int[] intArrCN2 = new int[]{
						-1,					/*귀속연도*/
						-1,         /*사번*/                         
						-1,         /*성명*/                         
						-1,         /*주민등록번호*/
						0,					/*총건수*/
						-1					/*작성일자*/
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
						sql.append(" SELECT	DISTINCT																													\n");
						sql.append(" A.YYYY,																							/*귀속연도*/				\n");
						sql.append(" A.EMPNO,																							/*사번*/						\n");
						sql.append(" RTRIM(B.EMPNMK) EMPNMK,															/*성명*/						\n");
						sql.append(" B.RESINO,																					  /*주민등록번호*/		\n");
						sql.append(" (SELECT COUNT(EMPNO) FROM PAYROLL.YCGIBU WHERE A.EMPNO=EMPNO) EMPCNT,    \n");
						sql.append(" '"+str[3]+"' AS CURDT																/*작성일자*/				\n");
						sql.append(" FROM PAYROLL.YCGIBU A																/*기부금명세서*/		\n");	
						sql.append(" LEFT JOIN PAYROLL.HIPERSON B ON A.EMPNO = B.EMPNO		/*인사기본정보*/		\n");
						sql.append(" LEFT JOIN PAYROLL.HCDEPT   C ON B.DEPTCD = C.DEPTCD  /*부서정보*/        \n");
						sql.append(" WHERE RTRIM(A.EMPNO) <> ''																								\n");
						//if (!str[0].equals(""))	sql.append(" AND RTRIM(A.EMPNO)	= '"+str[0]+"'							\n"); 
						if (!str[0].equals(""))	sql.append(" AND RTRIM(B.EMPNMK) LIKE '"+str[0]+"%'						\n"); 
						if (!str[1].equals(""))	sql.append(" AND RTRIM(A.YYYY)		= '"+str[1]+"'							\n");	
						if (!str[2].equals(""))	sql.append(" AND RTRIM(C.DEPTCD)	= '"+str[2]+"'							\n");
						sql.append(" GROUP BY A.YYYY,A.EMPNO,B.EMPNMK,B.RESINO																\n");	
						sql.append(" ORDER BY EMPNMK	  																											\n");

						//logger.dbg.println(this, sql.toString());

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