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
public class KS_Em030_S1 extends HttpServlet {

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
				
				String [] str = new String[7];
				
        		str[0] =  req.getParameter("v_str1"); // 부서 
				str[1] =  req.getParameter("v_str2"); // 사번   
				str[2] =  req.getParameter("v_str3"); // 성명
				str[3] =  req.getParameter("v_str4");	// 휴가일자FR 
				str[4] =  req.getParameter("v_str5");	// 휴가일자TO  

 
				
        for(int i=0;i<7;i++){
					if(str[i]==null) str[i]="";
				} 
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "HOL_DT", "EMPNO",   "EMPNMK",  
					
                                           			 "DAY_CD", "DAY_NM",  "DEPT_CD", "DEPT_NM",  "HOL_GB",                                       			

					                                 "I_EMPNO", "I_DATE",  "U_EMPNO","U_DATE"                           
																		  	}; 

				int[] intArrCN = new int[] { 8, 10, 30,  
					
					                           1,5, 5, 50, 1,

					                           10, 10, 10, 10
																			}; 
			
				int[] intArrCN2 = new int[]{ -1,-1, -1,
					
					                           -1,-1,-1,-1,-1,
					                           
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


						sql.append( "	 SELECT A.HOL_DT, A.EMPNO,   B.EMPNMK,                                \n");
						sql.append( "	   A.DAY_CD,  D.DETAIL_NM AS DAY_NM,      			\n");						
						sql.append( "	   B.DEPT_CD,  C.DETAIL_NM AS DEPT_NM,      		\n");
						sql.append( "	   A.HOL_GB,		  												   		\n");						
						sql.append( "	   A.I_EMPNO, A.I_DATE,  A.U_EMPNO, A.U_DATE 	\n");						
						sql.append( "	   FROM NORTHHR.KST160 A                                                                        \n");						
						sql.append( "	   LEFT JOIN NORTHHR.KST010 B ON B.EMPNO = A.EMPNO                                              \n");						
						sql.append( "	   LEFT JOIN NORTHHR.TSY010 C ON C.DETAIL =A.DEPT_CD AND C.HEAD = 'KS006' AND TRIM(C.DETAIL)<>''\n");
						sql.append( "	   LEFT JOIN NORTHHR.TSY010 D ON D.DETAIL =A.DAY_CD AND D.HEAD = 'KS020' AND TRIM(D.DETAIL)<>''\n");
						sql.append( "	  WHERE 1=1  \n");
						if(!str[0].equals(""))sql.append( "	  AND A.DEPT_CD = '"+str[0]+"'    \n");
						if(!str[1].equals(""))sql.append( "	  AND A.EMPNO = '"+str[1]+"' \n");
						if(!str[2].equals(""))sql.append( "	  AND B.EMPNMK LIKE '"+str[2]+"%' \n");
						if(!str[3].equals("")&&!str[4].equals(""))sql.append( "	  AND ((A.HOL_DT >='"+str[3]+"' AND A.HOL_DT<='"+str[4]+"'))  \n");
						
						logger.dbg.println(this,sql.toString());
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