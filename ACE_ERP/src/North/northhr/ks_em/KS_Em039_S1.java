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
public class KS_Em039_S1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");  //출근날짜
				String  str2	= req.getParameter("v_str2");  //직장구분
				String  str3	= req.getParameter("v_str3");  //소속				

				if (str1==null) str1=""; 
				if (str2==null) str2=""; 
				if (str3==null) str3=""; 

				GauceRes.enableFirstRow(dSet);
				
				String[] strArrCN = new String[]{  
                                                                      
																"ATT_DT",
																"EMPNO", 	
																"EMPNMK",		//3
																"SAYU_GB",
																"A_TM",
																"L_TM",											
																"M_H",
																"A_H",
																"O_H",
																"N1_H",
																"N2_H"			//11

																			}; 

				int[] intArrCN = new int[] { 10, 10, 10,

													5, 5, 5, 5, 5, 5, 5, 5				//11
				                            
														}; 
			
				int[] intArrCN2 = new int[]{ -1,-1, -1,		//3

													-1,-1,-1,-1,-1,-1, 		//9
					                           																								
													-1,-1							//11

														}; 


				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
	
						sql.append( "	SELECT DISTINCT H.ATT_DT, A.EMPNO,   A.EMPNMK,                               	\n");
						sql.append( "	       H.SAYU_GB,  																					\n");
						sql.append( "	       H.A_TM, H.L_TM,                 																\n");								
						sql.append( "	       nvl(H.M_H,0) AS M_H,  nvl(H.A_H,0) AS A_H,										\n");							
						sql.append( "	       nvl(H.O_H,0) AS O_H,  nvl(H.N1_H,0) AS N1_H,									\n");	
						sql.append( "	       nvl(H.N2_H,0) AS N2_H																		\n");	
						sql.append( "	  FROM ATP.KST010 A                                                           					\n");
						sql.append( "	  LEFT  JOIN ATP.KST100 H ON RTRIM(H.EMPNO) = RTRIM(A.EMPNO) AND H.ATT_DT = '"+str1+"'		\n");		
						sql.append( "   WHERE 1=1																												\n");
						sql.append( "	  AND (A.USESTS = '1' OR (A.USESTS = '3' AND H.ATT_DT < A.END_DT))							\n");		

						if(!str2.equals(""))sql.append( "	  AND A.DEPT_CD = '"+str2+"'																\n");
						if(!str3.equals(""))sql.append( "	  AND A.VEND_CD = '"+str3+"'																	\n");		
								
						//System.out.println("sql \n" + sql.toString());	
						
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

