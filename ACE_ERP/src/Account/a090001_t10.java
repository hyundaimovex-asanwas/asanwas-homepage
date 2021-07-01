package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a090001_t10 extends HttpServlet{
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
			 	String  str1   	= reqGauce.getParameter("v_str1");    //지점코드  필수 
				String  str2    = reqGauce.getParameter("v_str2");   //계정코드   필수
				String  str3	    = reqGauce.getParameter("v_str3");   //1구분  
				String  str4	    = reqGauce.getParameter("v_str4");   //자산중분류  필수      
				String  str5    = reqGauce.getParameter("v_str5");  //자산소분류  필수     
				String  str6	   = reqGauce.getParameter("v_str6");    //일련번호              
				String  str7	   = reqGauce.getParameter("v_str7");    
				String  str8	    = reqGauce.getParameter("v_str8");    
				String  str9    = reqGauce.getParameter("v_str9");  
				String  str10	  = reqGauce.getParameter("v_str10");  
				String  str11  	= reqGauce.getParameter("v_str11");    
				String  str12   = reqGauce.getParameter("v_str12");  
				String  str13  	= reqGauce.getParameter("v_str13");  
				String  str14	  = reqGauce.getParameter("v_str14");
				String  str15	  = reqGauce.getParameter("v_str15");

				String  IsUpdated	= reqGauce.getParameter("IsUpdated"); 

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE       = userSet.indexOfColumn("FDCODE");        
				int idxATCODE       = userSet.indexOfColumn("ATCODE");         
				int idxAST1ST        = userSet.indexOfColumn("AST1ST");           
				int idxAST2ND       = userSet.indexOfColumn("AST2ND");          
				int idxAST3RD       = userSet.indexOfColumn("AST3RD");          
				int idxASTSEQ       = userSet.indexOfColumn("ASTSEQ");          
				int idxACARTYPE   = userSet.indexOfColumn("ACARTYPE");      
				int idxACARNO      = userSet.indexOfColumn("ACARNO");         
				int idxACARBEGI   = userSet.indexOfColumn("ACARBEGI");      
				int idxACARFUEL   = userSet.indexOfColumn("ACARFUEL");      
				int idxACARUSE     = userSet.indexOfColumn("ACARUSE");        
				int idxACARINSDT   = userSet.indexOfColumn("ACARINSDT");    
				int idxACARDRVID   = userSet.indexOfColumn("ACARDRVID");    
				int idxAINSDT1       = userSet.indexOfColumn("AINSDT1");         
				int idxAINSDT2       = userSet.indexOfColumn("AINSDT2");   


				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;        
				StringBuffer UpdateSql = null;	  
				StringBuffer DeleteSql = null;	

				if(IsUpdated.equals("2")){
					
				UpdateSql = new StringBuffer();
				
		        UpdateSql.append( " UPDATE ACCOUNT.ASTADINFO2  SET   ");
                UpdateSql.append( " ACARTYPE   =    '"+str7+"',	      ");
                UpdateSql.append( " ACARNO     =    '"+str8+"',	      ");	
                UpdateSql.append( " ACARBEGI   =	  '"+str9+"',	      ");
                UpdateSql.append( " ACARFUEL   =   '"+str10+"',	    ");
                UpdateSql.append( " ACARUSE    =   '"+str11+"',      ");             
                UpdateSql.append( " ACARINSDT  =    '"+str12+"',	    ");
                UpdateSql.append( " ACARDRVID  =   '"+str13+"',	    ");
                UpdateSql.append( " AINSDT1     =   '"+str14+"',	    ");
                UpdateSql.append( "  ATCODE      =  '"+str2+"',	     ");
                UpdateSql.append( " AINSDT2      =    '"+str15+"'	    ");
                UpdateSql.append( " WHERE FDCODE = '"+str1+"'	  ");   
                UpdateSql.append( " AND AST1ST =  '"+str3+"'	        ");
				UpdateSql.append( " AND AST2ND =  '"+str4+"'	     ");
                UpdateSql.append( " AND AST3RD =  '"+str5+"'	     ");
                UpdateSql.append( " AND ASTSEQ =  '"+str6+"'	     ");

			     GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());	
			     
			     gsmt.executeUpdate(); 
			     gsmt.close(); 
 
                }else if (IsUpdated.equals("1")){
				
				InsertSql = new StringBuffer();

				InsertSql.append( " INSERT INTO ACCOUNT.ASTADINFO2   ");
				InsertSql.append( "  VALUES ( '" + str1 + "','" + str2 + "','" + str3+ "','" + str4+ "','" + str5+ "','"  + str6+ "','"
								 		+ str7 + "','" + str8 + "','" + str9+ "','" + str10+ "','" + str11+ "','" 
								 		+ str12 + "','" + str13 + "','" + str14+ "','" 
								 		+ str15 + "' ) " );

			    GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());	 			
   			     gsmt.executeUpdate(); 
			     gsmt.close(); 

                }else if (IsUpdated.equals("3")){

				DeleteSql = new StringBuffer();

				DeleteSql.append( " DELETE FROM  ACCOUNT.ASTADINFO2   " );
                DeleteSql.append( "  WHERE FDCODE  = '"+str1+"'   " );
				DeleteSql.append( "    AND AST1ST  = '"+str1+"'   " );			
				DeleteSql.append( "    AND AST2ND =  '"+str3+"'   " );
				DeleteSql.append( "    AND AST3RD  = '"+str4+"'   " );
				DeleteSql.append( "    AND ASTSEQ  = '"+str6+"'    " );

				GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());	 			
				gsmt.executeUpdate(); 
				gsmt.close();

				}
/////////////////////////////////////////////////////////////////////
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