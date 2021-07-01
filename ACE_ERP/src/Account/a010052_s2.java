package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class a010052_s2 extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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
				
				String  str1	= req.getParameter("v_str1"); //거래처코드 구분 
				String  str2	= req.getParameter("v_str2"); //거래처명 
				String  str3	= req.getParameter("v_str3"); //사번 
				String  str4	= ""; // 직원 거래처코드 
			

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
	
	    		GauceRes.enableFirstRow(dSet);
				String[] strArrCN = new String[]{ "CNT" }; 

				int[] intArrCN = new int[]{  3  }; 

				int[] intArrCN2 = new int[]{ 0  }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {		
					
					if(str1.equals("F")) {
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT COUNT(*) CNT	\n" );
						sql.append( "   FROM ACCOUNT.GCZM_VENDER_USER A	\n" );
						sql.append( "  WHERE VEND_CD LIKE 'F%'	\n" );
						sql.append( "    AND VEND_NM ='"+str2+"'	\n" );
					    
						//System.out.println("a010052_s1:11:"+sql.toString());
						stmt = conn.getGauceStatement(sql.toString());
		 		        stmt.executeQuery(dSet);
		 		        
					}else if(str1.equals("K")){
						
						str4 = str1+str3;
						
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT COUNT(*) CNT	\n" );
						sql.append( "   FROM ACCOUNT.GCZM_VENDER_USER A	\n" );
						sql.append( "  WHERE VEND_CD = '"+str4+"'	\n" );
						
						//System.out.println("a010052_s1:22:"+sql.toString());
						stmt = conn.getGauceStatement(sql.toString());
		 		        stmt.executeQuery(dSet);
					}
					
					
				   
/*********************************************************************************************/

					
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