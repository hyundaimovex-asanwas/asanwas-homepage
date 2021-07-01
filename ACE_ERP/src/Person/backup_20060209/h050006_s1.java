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
public class h050006_s1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");		//부서
				String  str2  = req.getParameter("v_str2");		//년월
				String  str3  = req.getParameter("v_str3");		//성명
				String  str4  = req.getParameter("v_str4");		//LEVEL
				String  str5  = req.getParameter("v_str5");		//TREECD

				if (str1 == null)	{ str1 = ""; }
				if (str2 == null) { str2 = ""; }
				if (str3 == null) { str3 = ""; }
				if (str4 == null) { str4 = ""; }
				if (str5 == null) { str5 = ""; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO","EMPNMK", "ATTDAY","ATTTIME","CLODAY",
																					"CLOTIME","DEPTCD","ETC","DEPTNM" 
																				 ,"TREECD","SEQ","PAYGNM"}; //OVERWK->ETC

				int[] intArrCN = new int[] { 7,  20,	8,  6,  8,  6,  4,	30, 70
																		,8,  3, 30}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1,  -1, -1, -1 
																		,-1, 0, 30}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT " );	//U
						sql.append( " RTRIM(A.EMPNO) EMPNO, RTRIM(A.EMPNMK) EMPNMK, RTRIM(E.ATTDAY) ATTDAY, ");
						sql.append( " RTRIM(E.ATTTIME) ATTTIME, RTRIM(E.CLODAY) CLODAY, RTRIM(E.CLOTIME) CLOTIME," );
						sql.append( " RTRIM(E.DEPTCD) DEPTCD, RTRIM(E.ETC) ETC, RTRIM(C.DEPTNM) DEPTNM " );
						sql.append( " ,C.TREECD, D.SEQ, RTRIM(D.MINORNM) PAYGNM ");
						sql.append( " FROM PAYROLL.HIPERSON A, ");
						sql.append( " PAYROLL.HLATTEND E, ");
						sql.append( " PAYROLL.HCDEPT C ");
						sql.append( " LEFT JOIN PAYROLL.HCLCODE D ON A.PAYGRD = D.MINORCD AND D.MAJORCD ='2002' ");
						sql.append( " WHERE E.EMPNO = A.EMPNO AND E.DEPTCD = C.DEPTCD " );

						if (!str1.equals("")) sql.append( " AND E.DEPTCD = '" + str1 + "' " );
						if (!str2.equals("")) sql.append( " AND E.ATTDAY LIKE '" + str2 + "%' ");
						if (!str3.equals("")) sql.append( " AND A.EMPNMK = '" + str3 + "' " );

						if (str4.equals("1")) sql.append( " AND SUBSTR(C.TREECD,1,4) = '" + str5 + "'");
						if (str4.equals("2")) sql.append( " AND SUBSTR(C.TREECD,1,4) = '" + str5 + "'");
						if (str4.equals("3")) sql.append( " AND SUBSTR(C.TREECD,1,6) = '" + str5 + "'");
						if (str4.equals("4")) sql.append( " AND RTRIM(C.TREECD) = '" +str5 + "'");

						sql.append( " ORDER BY C.TREECD ASC, D.SEQ ASC ");

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