package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.  //2010.01.18 정하나 수정 
public class h100003_s1 extends HttpServlet {

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

				if (str1==null) { str1 = ""; }

				GauceRes.enableFirstRow(dSet);


				String[] strArrCN = new String[]{ "STDYM"    ,"PAYGRD"   ,"PAYSEQ"   ,"PAYSEQNM", "BASAMT", 
																			"MONAMT"  ,"ECTAMT" , "TIMAMT",	  "YERAMT" ,"TRAAMT"		
																						   , "PLAAMT" , "NORAMT",
																					"PMOAMT", "NMOAMT",
																					"PYEAMT","NYEAMT"

																				}; 

				int[] intArrCN = new int[] {  6,   30,		4,		30,			9,
																			9,		9,		9,		9,		9,
																			9,		9,		9,		9,	
																			9,		9 
																		}; 
			
				int[] intArrCN2 = new int[]{	-1,		-1,   -1,	 -1,     0,
																			 0,		 0,		 0,		0,		 0,
																			 0,		 0,		 0,		0,
																			 0,		 0
																		}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						
						sql.append( " SELECT																																			");
						sql.append( " RTRIM(A.STDYM)   AS STDYM,																								\n");	//적용년월
						sql.append( " RTRIM(A.PAYGRD)  AS PAYGRD,																								\n");	//직위
						sql.append( " RTRIM(A.PAYSEQ)  AS PAYSEQ,																								\n");	//호봉
						sql.append( " RTRIM(D.MINORNM) AS PAYSEQNM,																							\n");	//호봉명
						sql.append( " COALESCE(A.BASAMT,0) AS BASAMT,																						\n"); //기본급
						sql.append( " COALESCE(A.ECTAMT,0) AS ECTAMT,																						\n");	//시간외
						sql.append( " COALESCE(A.MONAMT,0) AS MONAMT,																						\n");	//월급여
						sql.append( " COALESCE(A.TIMAMT,0) AS TIMAMT,																						\n"); //시급
						sql.append( " COALESCE(A.YERAMT,0) AS YERAMT,																						\n"); //연봉
						sql.append( " COALESCE(A.TRAAMT,0) AS TRAAMT																						\n"); //교통비
						sql.append( " ,COALESCE(A.PLAAMT,0) AS PLAAMT																						\n"); //현장수당
						sql.append( " ,COALESCE(A.NORAMT,0) AS NORAMT																						\n"); //북측근무수당
						sql.append( " ,COALESCE(A.PMOAMT,0) AS PMOAMT																						\n"); //현장급여
						sql.append( " ,COALESCE(A.NMOAMT,0) AS NMOAMT																						\n"); //북측급여
						sql.append( " ,COALESCE(A.PYEAMT,0) AS PYEAMT																						\n"); //현장연봉
						sql.append( " , COALESCE(A.NYEAMT,0) AS NYEAMT																						\n"); //북측연봉  */
						sql.append( " FROM PAYROLL.T_PCPAYTBL A								\n");
						sql.append( " LEFT JOIN PAYROLL.HCLCODE C ON C.MINORCD = A.PAYGRD AND C.MAJORCD ='2002' \n");	//직위
						sql.append( " LEFT JOIN PAYROLL.HCLCODE D ON D.MINORCD = A.PAYSEQ AND D.MAJORCD ='1184' \n");	//호봉

						if (!str1.equals("")) {	sql.append( " WHERE A.STDYM ='" +str1+ "' \n" ); }	//기준년월
					
						sql.append( " ORDER BY A.STDYM,A.PAYGRD, CAST(A.PAYSEQ AS INTEGER) DESC ");

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