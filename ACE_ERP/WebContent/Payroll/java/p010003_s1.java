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
public class p010003_s1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");		//기준년월
				String  str2	= req.getParameter("v_str2");		//구분[1:기본급,2:시간외수당,3:직책수당]

				if (str1==null) { str1 = ""; }
				if (str1==null) { str1 = ""; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "STDYM"    ,"CDDIV"    ,"PAYGRD"   , 
																					"PAYSEQ_1" ,"PAYSEQ_2" ,"PAYSEQ_3" ,"PAYSEQ_4" ,"PAYSEQ_5",
																					"PAYSEQ_6" ,"PAYSEQ_7" ,"PAYSEQ_8" ,"PAYSEQ_9" ,"PAYSEQ_10",
																					"PAYSEQ_11","PAYSEQ_12","PAYSEQ_13","PAYSEQ_14","PAYSEQ_15",
																					"PAYSEQ_16","PAYSEQ_17","PAYSEQ_18","PAYSEQ_19","PAYSEQ_20",
																					"PAYSEQ_21","PAYSEQ_22","PAYSEQ_23","PAYSEQ_24","PAYSEQ_25",
																					"PAYSEQ_26","PAYSEQ_27","PAYSEQ_28","PAYSEQ_29","PAYSEQ_30",
																					"PAYSEQ_31","PAYSEQ_32","PAYSEQ_33","PAYSEQ_34","PAYSEQ_35",
																					"PAYSEQ_36","PAYSEQ_37","PAYSEQ_38","PAYSEQ_39","PAYSEQ_40"
																				}; 

				int[] intArrCN = new int[] {  6,   30,   30,   
																			9,		9,		9,		9,   9,	
																			9,		9,		9,		9,   9,	
																			9,		9,		9,		9,   9,	
																			9,		9,		9,		9,   9,	
																			9,		9,		9,		9,   9,	
																			9,		9,		9,		9,   9,	
																			9,		9,		9,		9,   9,	
																			9,		9,		9,		9,   9	
																		}; 
			
				int[] intArrCN2 = new int[]{	-1,		-1,		-1,		
																			 0,		 0,		 0,		 0,		 0,	
																			 0,		 0,		 0,		 0,		 0,
																			 0,		 0,		 0,		 0,		 0,
																			 0,		 0,		 0,		 0,		 0,
																			 0,		 0,		 0,		 0,		 0,
																			 0,		 0,		 0,		 0,		 0,
																			 0,		 0,		 0,		 0,		 0,
																			 0,		 0,		 0,		 0,		 0
																		}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						
						sql.append( " SELECT  ");
						sql.append( " RTRIM(A.STDYM) AS STDYM,RTRIM(A.CDDIV) AS CDDIV,RTRIM(A.PAYGRD) AS PAYGRD, ");
						
						for (int i=1;i<=39;i++) {
							sql.append( " COALESCE(MAX(CASE INTEGER(PAYSEQ) WHEN INTEGER('"+i+"') THEN AMT END),0) as PAYSEQ_"+i+",");
						}
							sql.append( " COALESCE(MAX(CASE INTEGER(PAYSEQ) WHEN INTEGER('40') THEN AMT END),0) as PAYSEQ_40 ");

						sql.append( " FROM PAYROLL.PCPAYTBL A");
						//sql.append( " LEFT JOIN PAYROLL.HCLCODE B ON B.MINORCD = A.CDDIV	AND B.MAJORCD ='2018' ");		//구분
						sql.append( " LEFT JOIN PAYROLL.HCLCODE C ON C.MINORCD = A.PAYGRD AND C.MAJORCD ='2002' ");			//직위
						sql.append( " LEFT JOIN PAYROLL.HCLCODE D ON D.MINORCD = A.PAYSEQ AND D.MAJORCD ='1184' ");			//호봉
						sql.append( " GROUP BY A.STDYM,A.CDDIV,A.PAYGRD ");
						sql.append( " HAVING A.CDDIV ='"+str2+"' " );		//구분
	
						if (!str1.equals("")) {
							sql.append( " AND A.STDYM ='" +str1+ "' " );	//기준년월
						}
 
						sql.append( " ORDER BY A.CDDIV ");

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