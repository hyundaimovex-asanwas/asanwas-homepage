package northhr.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class KS_Em033_S1 extends HttpServlet {

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
			
				String  str1	= req.getParameter("v_str1"); if (str1==null) {str1="";}
				String  str2	= req.getParameter("v_str2"); if (str2==null) {str2="";}
				String  str3	= req.getParameter("v_str3"); if (str3==null) {str3="";}	
				String  str4	= req.getParameter("v_str4"); if (str4==null) {str4="";}
				String  str5	= req.getParameter("v_str5"); if (str5==null) {str5="";}					
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
																			"EMPNO", "EMPNMK", "CHK",
																			"START_DT",
																			"END_DT",
																			"WORK_GB",																			
																			"DEPT_CD",																				
																			"REMARK",
																			"I_EMPNO",
																			"I_DATE",
																			"U_EMPNO",
																			"U_DATE"
                                          
																			}; 


				int[] intArrCN = new int[] { 
					
                                          10, 10, 1,  8,  8, 
                                          
                                          5,  5,  50, 
                                          
                                          10,10,10,10
                                         
																			}; 
			
				int[] intArrCN2 = new int[]{
					
                                          -1, -1, -1, -1, -1,
                                          
                                          -1, -1, -1, 
                                          
                                          -1,-1,-1,-1

																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append("	SELECT A.EMPNO,	B.EMPNMK,	'' CHK,	\n");
						sql.append("	A.START_DT,		 	\n");
						sql.append("	A.END_DT,		 	\n");
						sql.append("	A.WORK_GB,		 	\n");
						sql.append("	A.DEPT_CD,		 	\n");
						sql.append("	A.REMARK,		 	\n");
						sql.append("	A.I_EMPNO,		 \n");
						sql.append("	A.I_DATE,			 \n");
						sql.append("	A.U_EMPNO,		 \n");
						sql.append("	A.U_DATE		 	\n");
						sql.append( "	FROM NORTHHR.KST150 A       \n");
						sql.append( "	LEFT JOIN NORTHHR.KST010 B ON RTRIM(B.EMPNO) = RTRIM(A.EMPNO)				  \n");	
												
						sql.append( "	WHERE 1=1                 \n");				
						
//						if(!str1.equals("")&&!str2.equals(""))sql.append( "	  AND START_DT BETWEEN '"+str1+"' AND '"+str2+"'\n");
						if(!str3.equals(""))sql.append( "	  AND B.DEPT_CD = '"+str3+"'    \n");		
						if(!str4.equals(""))sql.append( "	  AND B.EMPNO = = '"+str4+"'    \n");							
						if(!str5.equals(""))sql.append( "	  AND B.EMPNMK LIKE '"+str5+"%' \n");						
						
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