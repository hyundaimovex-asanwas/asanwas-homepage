package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a040030_t1 extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;

		try{
			loader = new ServiceLoader(req, res);
	 		service = loader.newService();
	 		context = service.getContext();
	 		logger = context.getLogger();
	 		GauceRequest reqGauce = null;
	 		GauceResponse resGauce = null;

			try {
				conn = service.getDBConnection();

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();


				// 웹페이지에서 조건값을 넘겨받음
				String  str1	= reqGauce.getParameter("v_str1"); //지점
				String  str2    = reqGauce.getParameter("v_str2"); //기준년도
				String  str3	= reqGauce.getParameter("v_str3"); //월
				String  str4	= reqGauce.getParameter("v_str4"); //일
				String  str5    = reqGauce.getParameter("v_str5"); //WORKCLOSE
				String  str6	= reqGauce.getParameter("v_str6"); //SLPCLOSE
				String  str7	= reqGauce.getParameter("v_str7"); //ACTCLOSE
				String  str10	= reqGauce.getParameter("v_str9"); //BGTCLOSE
				String  IsUpdated	= reqGauce.getParameter("v_str8"); //ACTCLOSE

				int str8 = Integer.parseInt(str3);
				if(str8 < 10) str3 = "0"+str3 ;
				else str3=str3;

				int str9 = Integer.parseInt(str4);
				if(str9 < 10) str4 = "0"+str4 ;
				else str4=str4;			

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE        = userSet.indexOfColumn("FDCODE");
				int idxYEAR          = userSet.indexOfColumn("YEAR");
				int idxMOON          = userSet.indexOfColumn("MOON");
				int idxDAY           = userSet.indexOfColumn("DAY");
				int idxWORKCLOSE     = userSet.indexOfColumn("WORKCLOSE");
				int idxSLIPCLOSE     = userSet.indexOfColumn("SLIPCLOSE");
				int idxACTCLOSE      = userSet.indexOfColumn("ACTCLOSE"); 
				int idxBGTCLOSE      = userSet.indexOfColumn("BGTCLOSE"); 

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;        
				StringBuffer UpdateSql = null;	      
                

				if(IsUpdated.equals("2")){
				UpdateSql = new StringBuffer();
                UpdateSql.append( " UPDATE ACCOUNT.SLIPCLOSE  SET " );
		        UpdateSql.append( "        WORKCLOSE = '" + str5 + "', ");
				UpdateSql.append( "        SLPCLOSE  = '" + str6 + "', ");
				UpdateSql.append( "        ACTCLOSE  = '" + str7 + "',  ");
				UpdateSql.append( "        BGTCLOSE  = '" + str10 + "'  ");
				UpdateSql.append( " WHERE FDCODE     = '" + str1 + "'  ");
				UpdateSql.append( "       AND YEAR   = '" + str2 + "'  ");
				UpdateSql.append( "       AND MOON   = '" + str3 + "'  ");
				UpdateSql.append( "       AND DAY    = '" + str4 + "'  ");

			     GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());	
			     gsmt.executeUpdate(); 
			     gsmt.close(); 
 
                }else if (IsUpdated.equals("1")){
				
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.SLIPCLOSE    " );
				InsertSql.append( "  VALUES ( '" + str1 + "', '" + str2 + "','" + str3 + "','" + str4 + "','" + str5 + "','" + str6 + "','" + str7 + "','" + str10 + "' ) " );

			    GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());	 			
   			     gsmt.executeUpdate(); 
			     gsmt.close(); 
				
				}

			}
			catch(Exception e){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}

			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}