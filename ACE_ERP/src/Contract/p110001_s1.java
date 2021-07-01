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
public class p110001_s1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");		//적용년월
				String  str2	= req.getParameter("v_str2");		//부서
				String  str3	= req.getParameter("v_str3");		//성명
				String  str4  = req.getParameter("v_str4");		//LEVEL
				String  str5  = req.getParameter("v_str5");		//TREECD

				if (str1==null) { str1 = ""; }
				if (str2==null) { str2 = ""; }
				if (str3==null) { str3 = ""; }
				if (str4==null)	{ str4 = ""; }
				if (str5==null)	{ str5 = ""; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"STRDT","EMPNO","EMPNMK","DEPTNM","PAYGNM","GRDDIV",
					"STRTDT","TODT","PAYSEQ","CURYEAR","USEYEAR",
					"P10000","P27000","PAYSUM",
					"PAYGMT","MINYEAR","PAYAMT","PAYGRD","BEFYEAR","PAYYEAR"
				}; 

				int[] intArrCN = new int[]{  6,	 7, 30,	 30,	30,	 
																		30,  8,  8,   3,   3,3,	 
																		 9,  9, 9,
																		 9,  9,  9,		4,   3,  3
																	}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, 
																		 -1, -1, -1,  -1,  0,0,  
																			0,  0, 0,
																		  0,  0,  0, -1,  0,  0
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT																							\n ");
						sql.append( " RTRIM(A.STRDT) STRDT,               --년월					\n ");
						sql.append( " RTRIM(B.EMPNO) EMPNO,               --사번					\n ");
						sql.append( " RTRIM(B.EMPNMK) EMPNMK,             --성명					\n ");
						sql.append( " RTRIM(C.DEPTNM) DEPTNM,             --부서명				\n ");
						sql.append( " RTRIM(D.MINORNM) PAYGNM,            --직위					\n ");
						sql.append( " RTRIM(B.STRTDT) STRTDT,         --그룹입사일		\n ");
						sql.append( " RTRIM(B.TODT) TODT,             --계약만료일				\n ");
						//sql.append( " IFNULL(B.GRDDIV,'') GRDDIV ,                           --호봉					\n "); 
						sql.append( " RTRIM(E.MINORNM) GRDDIV,                          --호봉					\n ");
						sql.append( " IFNULL(A.PAYSEQ,'') PAYSEQ,                           --호봉					\n "); 
						sql.append( " COALESCE(A.CURYEAR,0) AS CURYEAR,   --발생연차			\n "); 
						sql.append( " COALESCE(A.USEYEAR,0) AS USEYEAR,   --사용연차			\n "); 
						sql.append( " COALESCE(A.P10000,0) AS P10000,     --기본급여			\n "); 
						sql.append( " COALESCE(A.P27000,0) AS P27000,     --조장수당			\n "); 
						sql.append( " COALESCE((A.P10000+A.P27000),0) AS PAYSUM,  --계					\n "); 
						sql.append( " ROUND((COALESCE((A.P10000+A.P27000)/30,0)/1000),1)*1000 AS PAYGMT,  --통상임금	\n "); 
						sql.append( " COALESCE((A.CURYEAR-A.USEYEAR),0) AS MINYEAR,   --잔여연차	\n "); 
						sql.append( " COALESCE(A.PAYAMT,0) AS PAYAMT,     --년차금액			\n "); 
						sql.append( " IFNULL(A.PAYGRD,'') PAYGRD,																						\n ");
						sql.append( " COALESCE(A.BEFYEAR,0) AS BEFYEAR,   --정산					\n "); 
						sql.append( " COALESCE(A.PAYYEAR,0) AS PAYYEAR    --잔여					\n "); 
						sql.append( " FROM PAYROLL.PCMONPAY A																			\n "); 
						sql.append( " LEFT JOIN PAYROLL.T_HIPERSON B ON B.EMPNO = A.EMPNO						\n "); 
						sql.append( " LEFT JOIN PAYROLL.HCDEPT   F ON F.DEPTCD = A.DEPCOD					\n "); 
						sql.append( " LEFT JOIN PAYROLL.HCDEPT   C ON C.DEPTCD = B.DEPTCD					\n "); 
						sql.append( " LEFT JOIN PAYROLL.HCLCODE  D ON D.MINORCD = A.PAYGRD AND D.MAJORCD='2002'		\n "); 
						sql.append( " LEFT JOIN PAYROLL.HCLCODE  E ON E.MINORCD = B.GRDDIV AND E.MAJORCD='2001'		\n "); 
						
						if (!str1.equals("")) sql.append( " WHERE A.STRDT = '" + str1 + "' " );
						//if (!str2.equals("")) sql.append( "AND C.DEPTCD = '" + str2 + "' " );
						if (!str3.equals("")) sql.append( "AND B.EMPNMK LIKE '" + str3 + "%' " );

						if (str4.equals("1")) sql.append( " AND SUBSTR(C.TREECD,1,4) ='" + str5 + "'");
						if (str4.equals("2")) sql.append( " AND SUBSTR(C.TREECD,1,4) ='" + str5 + "'");
						if (str4.equals("3")) sql.append( " AND SUBSTR(C.TREECD,1,6) ='" + str5 + "'");
						if (str4.equals("4")) sql.append( " AND RTRIM(C.TREECD) ='" + str5 + "'");
           // sql.append( " AND RTRIM(D.MEMO) IN ('20','22') AND B.PAYGRD='890' ");
            sql.append( "  AND ( B.PAYGRD='890' OR  B.PAYGRD='700' ) ");
            sql.append( "  AND (B.ENDDT='' OR B.ENDDT IS NULL OR SUBSTR(B.ENDDT,1,6) < '" + str1 + "') "); //퇴사자제외
            sql.append( " ORDER BY C.TREECD, D.SEQ ");

						// logger.dbg.println(this, sql.toString());

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