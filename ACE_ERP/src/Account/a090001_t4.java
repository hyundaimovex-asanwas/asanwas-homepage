package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a090001_t4 extends HttpServlet{
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
				String  str5    = reqGauce.getParameter("v_str5");   //자산소분류  필수     
				String  str6	   = reqGauce.getParameter("v_str6");    //일련번호  
				String  str7	   = reqGauce.getParameter("v_str7");     //감가상각완료구분
				String  str8	    = reqGauce.getParameter("v_str8");    //취득금액             
				String  str9    = reqGauce.getParameter("v_str9");    //전기증가누계액   
				String  str10	  = reqGauce.getParameter("v_str10");  ///감가상각완료일    
				String  str11  	= reqGauce.getParameter("v_str11");  //전기상각누계액     
				String  str12   = reqGauce.getParameter("v_str12"); ////전기감소누계액    
				String  str13  	= reqGauce.getParameter("v_str13");  //전기장부가액        
				String  str14	  = reqGauce.getParameter("v_str14");  ///당기증가누계액     
				String  str15	  = reqGauce.getParameter("v_str15");  	 //내용년수              
				String  str16	  = reqGauce.getParameter("v_str16");  	//당기감가상각비총액
				String  str17	  = reqGauce.getParameter("v_str17");  	//당기감소누계액      
				String  str18	  = reqGauce.getParameter("v_str18");  	 //잔존가액             

				String  IsUpdated	= reqGauce.getParameter("IsUpdated"); 

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE        = userSet.indexOfColumn("FDCODE");        
				int idxATCODE        = userSet.indexOfColumn("ATCODE");          
				int idxAST1ST         = userSet.indexOfColumn("AST1ST");            
				int idxAST2ND        = userSet.indexOfColumn("AST2ND");           
				int idxAST3RD        = userSet.indexOfColumn("AST3RD");           
				int idxASTSEQ        = userSet.indexOfColumn("ASTSEQ");           
				int idxASTAQAMT    = userSet.indexOfColumn("ASTAQAMT");       
				int idxASTYUSE       =userSet.indexOfColumn("ASTYUSE");          
				int idxASTRMAMT    = userSet.indexOfColumn("ASTRMAMT");      
				int idxASTDEPRST   = userSet.indexOfColumn("ASTDEPRST");     
				int idxDEPRENDDT  = userSet.indexOfColumn("DEPRENDDT");    
				int idxABINSAMT     = userSet.indexOfColumn("ABINSAMT");       
				int idxACINSAMT     = userSet.indexOfColumn("ACINSAMT");      
				int idxABDECAMT    = userSet.indexOfColumn("ABDECAMT");      
				int idxACDECAMT    = userSet.indexOfColumn("ACDECAMT");      
				int idxABDEPRAMT   = userSet.indexOfColumn("ABDEPRAMT");    
				int idxABBOOKAMT  = userSet.indexOfColumn("ABBOOKAMT");    
				int idxACDEPRAMT  = userSet.indexOfColumn("ACDEPRAMT");   


				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;        
				StringBuffer UpdateSql = null;	       

				if(IsUpdated.equals("2")){
				UpdateSql = new StringBuffer();
                UpdateSql.append( " UPDATE ACCOUNT.ASTDEPR  SET   ");
                UpdateSql.append( " ASTAQAMT     =    '"+str7+"',	    ");
                UpdateSql.append( " ASTYUSE       =    '"+str8+"',	    ");	
                UpdateSql.append( " ASTRMAMT    =	   '"+str9+"',	    ");	
                UpdateSql.append( " ASTDEPRST   =    '"+str10+"',	    ");	
                UpdateSql.append( " DEPRENDDT  =   '"+str11+"',	    ");	         
                UpdateSql.append( " ACINSAMT    =    '"+str13+"',	    ");	
                UpdateSql.append( " ABDECAMT     =   '"+str14+"',	    ");	
				UpdateSql.append( " ABDEPRAMT  =    '"+str16+"',	    ");	
				UpdateSql.append( " ABBOOKAMT =    '"+str17+"'	    ");	
             	UpdateSql.append( " WHERE FDCODE = '"+str1+"'	");  
				UpdateSql.append( " AND AST1ST =  '"+str3+"'	  ");
				UpdateSql.append( " AND AST2ND =  '"+str4+"'	");
                UpdateSql.append( " AND AST3RD =  '"+str5+"'	");
                UpdateSql.append( " AND ASTSEQ =  '"+str6+"'	");
                UpdateSql.append( " AND ATCODE =  '"+str2+"'	");

			     GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());	
			     gsmt.executeUpdate(); 
			     gsmt.close(); 
 
                }else if (IsUpdated.equals("1")){
				
				InsertSql = new StringBuffer();

				InsertSql.append( " INSERT INTO ACCOUNT.ASTDEPR  (FDCODE, ATCODE, AST1ST, AST2ND, AST3RD,ASTSEQ, ASTAQAMT, ASTYUSE, ASTRMAMT,   " );
				InsertSql.append( " ASTDEPRST, DEPRENDDT,   ACINSAMT,   ABDECAMT,  ABDEPRAMT, ABBOOKAMT   ) ");
				InsertSql.append( "  VALUES ( '" + str1 + "','" + str2 + "','" + str3+ "','" + str4+ "','" + str5+ "','"  + str6+ "','"
								 + str7 + "','" + str8 + "','" + str9+ "','" + str10+ "','" + str11+ "','" 
								 + str13 + "','" + str14+ "','" + str16+ "','" + str17+ "' ) " );

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