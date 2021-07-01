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
public class h030003_s6 extends HttpServlet {

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
				String str1	= req.getParameter("v_str1");		//사원명
				String str2 = req.getParameter("v_str2");		//재직구분
				String str3 = req.getParameter("v_str3");		//사번
        String str4 ="";
   
				if (str1==null) str1 = "";
				if (str2==null) str2 = "";
				if (str3==null) str3 = "";

        if(!str3.equals("")) str4 =str3.substring(0,1);
				

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO", "EMPNMK", "PAYGNM", "DEPTNM", "PAYGRD", "DEPTCD", "MEMO" };

				int[] intArrCN = new int[]{  7, 20, 30, 30, 4, 4 , 30}; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1, -1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn(new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT	RTRIM(A.EMPNO) AS EMPNO,RTRIM(A.EMPNMK) AS EMPNMK,	\n ");
					sql.append( "					RTRIM(B.MINORNM) AS PAYGNM,RTRIM(C.DEPTNM) AS DEPTNM, \n ");
					sql.append( "       	A.PAYGRD, A.DEPTCD, RTRIM(B.MEMO) MEMO\n ");
					sql.append( "	 FROM PAYROLL.HIPERSON A,																		\n ");
					sql.append( "       PAYROLL.HCLCODE B,																		\n ");
					sql.append( "				PAYROLL.HCDEPT C																			\n ");
					sql.append( "	 LEFT JOIN PAYROLL.HCDEPT L ON SUBSTR(C.TREECD,1,6)||'00' = L.TREECD    		\n ");
					sql.append( "	                           AND L.CHGYM= (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) 		\n ");    
					sql.append( " WHERE A.PAYGRD = B.MINORCD																	\n ");
					sql.append( "		AND A.DEPTCD = C.DEPTCD																		\n ");
					sql.append( "		AND B.MAJORCD = '2002'																		\n ");
          sql.append( "   AND C.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)     \n ");
					sql.append( "   AND RTRIM(B.MEMO) <> '0' \n ");
          
					if(str2.equals("T"))sql.append( "	AND A.USESTS IN ( '1', '2', '3')	\n ");
					else	sql.append( "	AND A.USESTS IN ( '1', '2')				\n ");
					sql.append( "   AND A.EMPNMK LIKE '" + str1 + "%' \n ");
          sql.append( "		AND L.TREECD IN ( SELECT CASE WHEN LEVEL =5 THEN SUBSTR(TREECD,1,6)||'00'     	\n ");
					sql.append( "		                              WHEN LEVEL =4 THEN SUBSTR(TREECD,1,4)||'0000' END TREECD \n ");
					if(str4.equals("1")||str4.equals("2"))sql.append( "   FROM PAYROLL.HIPERSON A, 	\n ");
					if(!str4.equals("1")&&!str4.equals("2"))sql.append( " FROM PAYROLL.T_HIPERSON A, 	\n ");
					sql.append( "		                 PAYROLL.HCDEPT B                              		\n ");
					sql.append( "		                   WHERE A.DEPTCD = B.DEPTCD                     	\n ");
					sql.append( "		                     AND B.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) \n ");
					sql.append( "		                     AND A.EMPNO ='" + str3 + "'  )               \n ");
          sql.append( " UNION ALL	\n ");
          sql.append( " SELECT	RTRIM(A.EMPNO) AS EMPNO,RTRIM(A.EMPNMK) AS EMPNMK,	\n ");
					sql.append( "					RTRIM(B.MINORNM) AS PAYGNM,RTRIM(C.DEPTNM) AS DEPTNM, \n ");
					sql.append( "       	A.PAYGRD, A.DEPTCD, RTRIM(B.MEMO) MEMO \n ");
					sql.append( "	FROM PAYROLL.T_HIPERSON A,																		\n ");
					sql.append( "       PAYROLL.HCLCODE B,																		\n ");
					sql.append( "				PAYROLL.HCDEPT C																			\n ");
					sql.append( "	LEFT JOIN PAYROLL.HCDEPT L ON SUBSTR(C.TREECD,1,6)||'00' = L.TREECD    		\n ");
					sql.append( "	                           AND L.CHGYM= (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) 		\n ");  
					sql.append( " WHERE A.PAYGRD = B.MINORCD																	\n ");
					sql.append( "		AND A.DEPTCD = C.DEPTCD																		\n ");
					sql.append( "		AND B.MAJORCD = '2002'																		\n ");
          sql.append( "   AND C.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)     \n ");
					sql.append( "   AND RTRIM(B.MEMO) <> '0' \n ");
          if(str2.equals("T")) sql.append( "	AND A.USESTS IN ( '1', '2', '3')	\n ");
					else sql.append( "	AND A.USESTS IN ( '1', '2')				\n ");
					sql.append( "   AND A.EMPNMK LIKE '" + str1 + "%' \n ");
          sql.append( "		AND L.TREECD IN ( SELECT CASE WHEN LEVEL =5 THEN SUBSTR(TREECD,1,6)||'00'     	\n ");
					sql.append( "		                              WHEN LEVEL =4 THEN SUBSTR(TREECD,1,4)||'0000' END TREECD \n ");
          if(str4.equals("1")||str4.equals("2"))sql.append( "   FROM PAYROLL.HIPERSON A, 	\n ");
					if(!str4.equals("1")&&!str4.equals("2"))sql.append( " FROM PAYROLL.T_HIPERSON A, 	\n ");
					sql.append( "		                   PAYROLL.HCDEPT B                              		\n ");
					sql.append( "		                   WHERE A.DEPTCD = B.DEPTCD                     	\n ");
					sql.append( "		                     AND B.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) \n ");
					sql.append( "		                     AND A.EMPNO ='" + str3 + "'  )               \n ");

					sql.append( " ORDER BY DEPTCD, PAYGRD \n ");
          
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