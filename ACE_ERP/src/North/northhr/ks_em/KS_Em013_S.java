package North.northhr.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class KS_Em013_S extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1"); if (str1 == null) { str1 = ""; } //직장
				String  str2	= req.getParameter("v_str2"); if (str2 == null) { str2 = ""; } //소속
				String  str3	= req.getParameter("v_str3"); if (str3 == null) { str3 = ""; } //직종
				String  str4	= req.getParameter("v_str4"); if (str4 == null) { str4 = ""; } //입직일 프롬
				String  str5	= req.getParameter("v_str5"); if (str5 == null) { str5 = ""; } //입직일 투			 
				String  str6	= req.getParameter("v_str6"); if (str6 == null) { str6 = ""; } //재직구분	

				GauceRes.enableFirstRow(dSet);
				
				String[] strArrCN = new String[]{ 
																				
																				"USESTS",		"EMPNO",		"EMPNMK",																					
																				"SEX", "BIRTHDAY",	
																				"START_DT",	"END_DT",   

																				"DEPT_CD", 		"DEPT_NM",	
																				"VEND_CD",		"VEND_NM",																								
																				"JOB_CD",		"JOB_NM",		
																				"C_VEND_CD", 	"C_VEND_NM", 

																				"CON_YEAR",	"ATT_CD"

																	
																			}; 	
																					
				int[] intArrCN = new int[] { 
																				1, 10, 30, 1, 8,			//5
																				
																				 8, 8, 						//7
																				
																				10, 20, 10, 20, 		//11
																				
																				10, 20, 10, 20, 		//15
																				
																				 2, 1							//17
																	 	

																			};  
			
				int[] intArrCN2 = new int[]{
																				-1,-1, -1, -1, -1,
																				
																				-1, -1,						//9
																				
																				-1,-1, -1, -1, 
																				
																				-1,-1, -1, -1,			   //15
																				
																				 0, -1 


																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( "	SELECT  A.USESTS,           																							\n");
						sql.append( "			A.EMPNO,			RTRIM(A.EMPNMK) AS EMPNMK,  													\n");
						sql.append( "	        A.SEX ,				TRIM(A.BIRTHDAY) AS BIRTHDAY,          										\n");
						sql.append( "			A.START_DT,		nvl(A.END_DT,'')END_DT,   														\n");
						sql.append( "	        A.DEPT_CD, 		B.DETAIL_NM AS DEPT_NM,  							             					\n");
						sql.append( "	        A.VEND_CD,	 	C.DETAIL_NM AS VEND_NM,                               							\n");
						sql.append( "			A.JOB_CD, 		D.DETAIL_NM AS	JOB_NM,															\n");				
						sql.append( "	        A.C_VEND_CD,  E.DETAIL_NM AS C_VEND_NM,														 \n");										
						sql.append( "	        A.CON_YEAR, A.ATT_CD              																			 \n");
						sql.append( "		FROM ATP. KST010 A                                                                                        \n");
						sql.append( "		LEFT JOIN ATP.TSY010 B ON RTRIM(B.DETAIL) = RTRIM(A.DEPT_CD)   	AND B.HEAD='KS006'  AND RTRIM(B.DETAIL) IS NOT NULL    \n");
						sql.append( "		LEFT JOIN ATP.TSY010 C ON RTRIM(C.DETAIL) = RTRIM(A.VEND_CD)    	AND C.HEAD='KS007'  AND RTRIM(C.DETAIL) IS NOT NULL    \n");
						sql.append( "		LEFT JOIN ATP.TSY010 D ON RTRIM(D.DETAIL) = RTRIM(A.JOB_CD)    	AND D.HEAD='KS002'   AND RTRIM(D.DETAIL) IS NOT NULL    \n");
						sql.append( "		LEFT JOIN ATP.TSY010 E ON RTRIM(E.DETAIL) = RTRIM(A.C_VEND_CD)  AND E.HEAD='KS008'  AND RTRIM(E.DETAIL) IS NOT NULL    \n");

						sql.append( " WHERE 1=1																																	\n");
						if (!str1.equals(""))sql.append( "AND A.DEPT_CD = '"+str1+"'																			\n");
						if (!str2.equals(""))sql.append( "AND A.VEND_CD = '"+str2+"'																			\n");
						if (!str3.equals(""))sql.append( "AND A.JOB_CD = '"+str3+"'																				\n");	
						if (!str4.equals("")&&!str5.equals(""))sql.append( "AND A.START_DT BETWEEN '"+str4+"' AND '"+str5+"'           \n");
						if (!str6.equals(""))sql.append( "AND A.USESTS = '"+str6+"'																				\n");
								
						sql.append( "ORDER BY A.START_DT, A.EMPNMK 	\n");
			
						System.out.println("KS_Em010_S1 \n" + sql.toString());
						//logger.dbg.println(this,sql.toString());

						stmt = conn.getGauceStatement(sql.toString());
		 				stmt.executeQuery(dSet);

					}
				
/*********************************************************************************************/

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