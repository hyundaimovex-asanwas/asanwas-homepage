package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.//년간월별소득현황
public class p020007_s9 extends HttpServlet {

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
	실제 업무에서 적용하실 부분 - 급여지급현황 조회
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				String [] str = new String [7];
				str[0]	= req.getParameter("v_str1");		//지급년월
				str[1]	= req.getParameter("v_str2");		//지급년월

				for (int s=0;s<2;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{	"EMPNO","EMPNMK","PAYBNK","PAYNUM","S94000",	
																					"AMT2","DONG", "BUNJI","TELNO","MEMO"};

				int[] intArrCN = new int[]{	 7,		20,		4,	25,		9, 
																		 9,   60,  30,  15,  50 }; 

				int[] intArrCN2 = new int[]{ -1,	-1,		-1,		-1,		0,	
																		  0,  -1,   -1,   -1,  -1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT                                                                         	\n");
					sql.append( " B.EMPNO,         --사번                                                        	\n");
					sql.append( " A.EMPNMK,        --성명                                                        	\n");
					//sql.append( " RTRIM(C.MINORNM) PAYBKNM,  --은행명                                            	\n");
					sql.append( " B.PAYBNK,			   --은행코드					                                           	\n");
					sql.append( " B.PAYNUM,        --계좌번호                                                    	\n");
					sql.append( " B.S94000,         --실지급액                                                    \n");
					sql.append( " 0 AS AMT2,        --금액2																												\n");
					sql.append( " '' AS DONG,       --동																													\n");
					sql.append( " '' AS BUNJI,      --호수																												\n");
					sql.append( " '' AS TELNO,      --전화																												\n");
					sql.append( " '' AS MEMO       --메모																													\n");
					sql.append( " FROM PAYROLL.PBPAY B																														\n");
					sql.append( " LEFT JOIN PAYROLL.HIPERSON A ON A.EMPNO=B.EMPNO                           			\n");
					sql.append( " LEFT JOIN PAYROLL.HCLCODE C ON B.PAYBNK = C.MINORCD AND C.MAJORCD = '1411'			\n");
					//sql.append( " LEFT JOIN PAYROLL.HCPOSTNO K ON A.OZIPCD=K.ZIPCD																\n");	//우편번호
					//sql.append( " LEFT JOIN PAYROLL.HCLCODE E ON A.PAYGRD = E.MINORCD AND E.MAJORCD = '2002'      \n");
					//sql.append( " LEFT JOIN PAYROLL.HCDEPT D ON D.DEPTCD=B.DEPTCD																	\n");
					sql.append( " WHERE B.APPDT='"+str[0]+"'      \n");
					
					if (str[1].equals("1")) sql.append( " AND B.PAYDIV IN ('1','3','4')  ");
					if (str[1].equals("5")) sql.append( " AND B.PAYDIV IN ('5')  ");
					
					sql.append( " ORDER BY C.MINORNM, A.EMPNMK ");
					
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