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
public class p020008_s1 extends HttpServlet {

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
				String [] str = new String [5];
				str[0]	= req.getParameter("v_str1");		//사번
				str[1]	= req.getParameter("v_str2");		//년월

				for (int s=0;s<=1;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
					"EMPNO",		/*사번*/
					"EMPNMK",		/*한글명*/
					"APPDT",		/*년월*/
					"SANGRAT"		/*상여율*/  
				};

				int[] intArrCN = new int[]{  
					 7, 	/*사번*/                
					 20,	/*한글명*/               
					 6,		/*년월*/            
					 3    /*상여율*/  
         }; 		
						                              
				int[] intArrCN2 = new int[]{
					 -1,  /*사번*/                 
					 -1,	/*한글명*/              
					 -1,  /*년월*/             	
					  0   /*상여율*/  
        }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT	B.EMPNO,A.EMPNMK,B.APPDT,B.SANGRAT							");
					sql.append( " FROM  PAYROLL.PBPAY B																		"); 
					sql.append( " LEFT OUTER JOIN PAYROLL.HIPERSON A ON B.EMPNO = A.EMPNO ");
					sql.append( " WHERE RTRIM(B.EMPNO) <> ''															");
					sql.append( " AND B.PAYDIV = '5'																			");  
					
					if(!str[0].equals("")) sql.append( " AND B.EMPNO ='"+str[0]+"'				");
					if(!str[1].equals("")) sql.append( " AND B.APPDT ='"+str[1]+"'				");
					
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