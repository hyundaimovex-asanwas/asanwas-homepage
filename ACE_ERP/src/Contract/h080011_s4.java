package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class h080011_s4 extends HttpServlet {

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
               // String str2	= req.getParameter("v_str2");		//구분
				//String str3	= req.getParameter("v_str3");		//level
              //  String str4	= req.getParameter("v_str4");		//treecd

				if (str1==null) str1 = "";
               // if (str2==null) str2 = "";
				//if (str3==null) str3 = "";
               // if (str4==null) str4 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{   "EMPNO", "EMPNMK", "PAYGNM", "DEPTNM", "PAYGRD", "DEPTCD", "GRSTRTDT"};

				int[] intArrCN = new int[]{  7, 20, 30, 30, 4, 4, 8 }; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1, -1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT  \n");
					sql.append( "	A.EMPNO,A.EMPNMK,B.MINORNM AS PAYGNM,C.DEPTNM,  \n");
					sql.append( " A.PAYGRD, A.DEPTCD, A.GRSTRTDT  \n");
					sql.append( "	FROM PAYROLL.HIPERSON A  ");
					sql.append( " LEFT JOIN PAYROLL.HCLCODE B ON A.PAYGRD = B.MINORCD AND B.MAJORCD = '2002'\n");
					sql.append( "	LEFT JOIN PAYROLL.HCDEPT  C ON A.DEPTCD = C.DEPTCD \n");
					sql.append( " WHERE A.EMPNO<>'' \n ");
				 	sql.append( "	AND A.USESTS IN ( '1', '2') \n");
					sql.append( "	AND A.EMPNMK LIKE '" + str1 + "%' \n");
				//	sql.append( " AND B.MEMO IN('0','20')	\n");
                    sql.append( " UNION ALL   \n");
					sql.append( " SELECT  \n");
					sql.append( "	A.EMPNO,A.EMPNMK,B.MINORNM AS PAYGNM,C.DEPTNM,  \n");
					sql.append( " A.PAYGRD, A.DEPTCD, A.GRSTRTDT  \n");
					sql.append( "	FROM PAYROLL.T_HIPERSON A  ");
					sql.append( " LEFT JOIN PAYROLL.HCLCODE B ON A.PAYGRD = B.MINORCD AND B.MAJORCD = '2002'\n");
					sql.append( "	LEFT JOIN PAYROLL.HCDEPT  C ON A.DEPTCD = C.DEPTCD \n");
					sql.append( " WHERE A.EMPNO<>'' \n ");
				 	sql.append( "	AND A.USESTS IN ( '1', '2') \n");
					sql.append( "	AND A.EMPNMK LIKE '" + str1 + "%' \n");
				//	sql.append( " AND B.MEMO IN('0','20')	\n");
					//if (str2.equals("S")&&str3.equals("1")) sql.append( " AND (B.MEMO ='0' OR (B.MEMO='20' AND SUBSTR(C.TREECD,1,4) = '"+ str4 + "'))\n");
					//if (str2.equals("S")&&str3.equals("2")) sql.append( " AND (B.MEMO ='0' OR (B.MEMO='20' AND SUBSTR(C.TREECD,1,4) = '"+ str4 + "'))\n");
					//if (str2.equals("S")&&str3.equals("3")) sql.append( " AND (B.MEMO ='0' OR (B.MEMO='20' AND SUBSTR(C.TREECD,1,6) = '"+ str4 + "'))\n");
					//if (str2.equals("S")&&str3.equals("4")) sql.append( " AND (B.MEMO ='0' OR (B.MEMO='20' AND RTRIM(C.TREECD) = '"+ str4 + "'))\n");
				  //if (str2.equals("S")&&str3.equals("")) sql.append( "  AND B.MEMO IN('0','20') \n");
				 // sql.append( "  ORDER BY B.SEQ, A.PAYSEQ DESC, A.GRSTRTDT ");
          
				  logger.dbg.println(this,sql.toString());
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