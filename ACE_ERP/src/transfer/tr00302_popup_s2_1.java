package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class tr00302_popup_s2_1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");    //
				String  str2	= req.getParameter("v_str2");    //
				String  str3	= req.getParameter("v_str3");    //
				
				
				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				

				GauceRes.enableFirstRow(dSet);




				String[] strArrCN = new String[]{ "PERSON_NO",	"PRSN_NAME", "COMPANY","JOB_DUTY", "GENDER",
													  "PRSN_REGNO", "ADDRESS1", "PRSN_CMPY"																
																	};

				int[] intArrCN = new int[]{ 50, 50, 50, 50, 50,
										    	50, 50, 50
														
					}; 
						
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, 
					                           -1, -1, -1	
					}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT A.PERSON_NO, IFNULL(A.PSN_KNAME,'') AS PRSN_NAME, IFNULL(A.COMPANY,'') AS COMPANY,  \n" );
					sql.append( " IFNULL(A.POSITION,'') AS JOB_DUTY, A.GENDER,  \n" );
					sql.append( " IFNULL(A.REG_NO,'') AS PRSN_REGNO, A.ADDRESS1, \n" );
					sql.append( " IFNULL(B.MINORNM,'') AS PRSN_CMPY \n" );
					sql.append( " FROM TRANSFER.LTPERSON A \n" );
					sql.append( " LEFT JOIN TRANSFER.LTLCODE B ON B.MINORCD = A.COMPANY AND B.MAJORCD = '0015' \n" );
					//sql.append( " LEFT JOIN TRANSFER.LTCARTYPE C ON C.CAR_TYPE = A.CARTYPENO \n" );
					sql.append( " WHERE A.PERSON_NO <> '' \n" );
					sql.append( " AND PERSON_NO   \n" );
					sql.append( " NOT IN  \n" );
					sql.append( " ( SELECT X.PERSON_NO    \n" );
					sql.append( " FROM (SELECT PERSON_NO FROM TRANSFER.LTPSRNACC WHERE ACCSECTION = 'I' AND RTRN_DATE >= '" + str1 + "'  \n");
					sql.append( " UNION ALL \n");
					
					sql.append( " SELECT PERSON_NO FROM TRANSFER.LTCARACC WHERE ACCSECTION = 'I' AND START_DATE > '" + str2 + "') X ) \n");
					
					if (str3 != null && !str3.equals("")) sql.append( " AND A.PSN_KNAME LIKE '%"+str3+"%' \n");//null값 체크
										
				// logger.err.println(this,sql.toString());

GauceRes.writeException("Sql",":",sql.toString());				
						
					//logger.dbg.println( this, sql.toString() );
/*********************************************************************************************/
		//			GauceRes.writeException("Sql",":",sql.toString());
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