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
public class comm_func_s1_n extends HttpServlet {
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
			  
			  String [] str = new String [6];
				str[0]	= req.getParameter("v_str1");		//지점
				str[1]	= req.getParameter("v_str2");		//회계년월to
        str[2]	= req.getParameter("v_str3");		//계정코드
				str[3]	= req.getParameter("v_str4");		//사업장코드
				str[4]	= req.getParameter("v_str5");		//본부코드
        str[5]	= req.getParameter("v_str6"); 	//회계년월fr
       
				for (int s=0;s<=5;s++) {
					if(str[s]==null) str[s] = "";
				}
      
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "FDCODE","ATCODE",
				                                   "TOTALVAL"}; 

				int[] intArrCN = new int[]{  2,  7, 
					                          15}; 
			
				int[] intArrCN2 = new int[]{ -1, -1,
					                            0}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT " );
					if(str[0].equals("")){ 
						sql.append( " '' FDCODE," );
					}else{
            sql.append( " A.FDCODE FDCODE," );
          }
					sql.append( " A.ATCODE, " );
					
					sql.append( "  SUM(CASE WHEN B.ATDECR ='1' THEN A.DETOT - A.CRTOT                " );
					sql.append( "           WHEN B.ATDECR ='2' THEN A.CRTOT - A.DETOT ELSE 0 END)  TOTALVAL " );
					sql.append( "   FROM ACCOUNT.MTOTALBAL A, ACCOUNT.ACTCODE B " );
					sql.append( "  WHERE A.ATCODE = B.ATCODE ");
					sql.append( "    AND A.ACTYYMM>='"+str[5]+"'" );
					sql.append( "    AND A.ACTYYMM<='"+str[1]+"'" );
					sql.append( "    AND A.ATCODE='"+str[2]+"'" );
				  if(!str[0].equals("")) sql.append(" AND A.FDCODE = '"+str[0]+"' ");
					if(!str[3].equals("")) sql.append(" AND A.COCODE = '"+str[3]+"' ");
					if(!str[4].equals("")) sql.append(" AND A.DIVCD = '"+str[4]+"' ");
				
          if(!str[0].equals("")) sql.append( "  GROUP BY FDCODE, A.ATCODE, B.ATDECR " );
					if(str[0].equals("")) sql.append( "  GROUP BY  A.ATCODE " );

					//logger.dbg.println(this , sql.toString());

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