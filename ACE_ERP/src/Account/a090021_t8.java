package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a090021_t8 extends HttpServlet{
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
			String strFsnbr="";
			int intChk=0;
			try {
				conn = service.getDBConnection();

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();


				// 웹페이지에서 조건값을 넘겨받음
			 	String  str1   	= reqGauce.getParameter("v_str1");    //지점코드  필수 
				String  str2    = reqGauce.getParameter("v_str2");    //계정코드   필수
				String  str3	  = reqGauce.getParameter("v_str3");    //1구분  
				String  str4	  = reqGauce.getParameter("v_str4");    //자산중분류  필수      
				String  str5    = reqGauce.getParameter("v_str5");    //자산소분류  필수     
				String  str6	  = reqGauce.getParameter("v_str6");    //일련번호  			
				String  str7	  = reqGauce.getParameter("v_str7");     
				String  str8	  = reqGauce.getParameter("v_str8");    
				String  str9    = reqGauce.getParameter("v_str9");    
				String  str10	  = reqGauce.getParameter("v_str10");  
				String  str11  	= reqGauce.getParameter("v_str11");  
				String  str12   = reqGauce.getParameter("v_str12"); 
				String  str13  	= reqGauce.getParameter("v_str13");  
				String  str14	  = reqGauce.getParameter("v_str14");     
				String  str15	  = reqGauce.getParameter("v_str15");    
				String  str16   = reqGauce.getParameter("v_str16");    
				String  str17	  = reqGauce.getParameter("v_str17");  
				String  str18  	= reqGauce.getParameter("v_str18");  
				String  str19   = reqGauce.getParameter("v_str19"); 
				String  MORTNO	= reqGauce.getParameter("MORTNO"); 
				String  IsUpdated	= reqGauce.getParameter("IsUpdated"); 

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE        = userSet.indexOfColumn("FDCODE");          
				int idxATCODE        = userSet.indexOfColumn("ATCODE");             
				int idxAST1ST        = userSet.indexOfColumn("AST1ST");              
				int idxAST2ND        = userSet.indexOfColumn("AST2ND");             
				int idxAST3RD        = userSet.indexOfColumn("AST3RD");             
				int idxASTSEQ        = userSet.indexOfColumn("ASTSEQ");             
				int idxMORTNO        = userSet.indexOfColumn("MORTNO");            
				int idxMORTDATE      = userSet.indexOfColumn("MORTDATE");         
				int idxMORTBANK      = userSet.indexOfColumn("MORTBANK");        
				int idxCLOSEORNOT    = userSet.indexOfColumn("CLOSEORNOT");    
				int idxCLOSEDATE     = userSet.indexOfColumn("CLOSEDATE");       
				int idxBOOKAMT       = userSet.indexOfColumn("BOOKAMT");          
				int idxMORTSIZE      = userSet.indexOfColumn("MORTSIZE");         
				int idxMORTJDGDT     = userSet.indexOfColumn("MORTJDGDT");       
				int idxJUDGAMT       = userSet.indexOfColumn("JUDGAMT");           
				int idxMORTAMT       = userSet.indexOfColumn("MORTAMT");          
				int idxMORTDTL       = userSet.indexOfColumn("MORTDTL");           
				int idxMORTORDER  	 = userSet.indexOfColumn("MORTORDER");      
				int idxWRDT          = userSet.indexOfColumn("WRDT");                
				int idxWRID          = userSet.indexOfColumn("WRID");   

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql   = null;        
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql  = null;

				if(IsUpdated.equals("2")){

					UpdateSql = new StringBuffer();
					UpdateSql.append( " UPDATE ACCOUNT.ASTMORT  SET "); 
					UpdateSql.append( " MORTDATE     = '"+str7+"',	");
					UpdateSql.append( " MORTBANK     = '"+str8+"',	");
					UpdateSql.append( " CLOSEORNOT   = '"+str9+"',	");
					UpdateSql.append( " CLOSEDATE    = '"+str10+"',	");
					UpdateSql.append( " BOOKAMT      = '"+str11+"',	");
					UpdateSql.append( " MORTSIZE     = '"+str12+"',	");
					UpdateSql.append( " MORTJDGDT    = '"+str13+"',	");
					UpdateSql.append( " JUDGAMT      = '"+str14+"',	");
					UpdateSql.append( " MORTAMT      = '"+str15+"',	");
					UpdateSql.append( " MORTDTL      = '"+str16+"',	");
					UpdateSql.append( " MORTORDER    = '"+str17+"',	");
					UpdateSql.append( " WRDT         = '"+str18+"',	");
					UpdateSql.append( " ATCODE       =  '"+str2+"',	");
					UpdateSql.append( " WRID         = '"+str19+"'	");
					UpdateSql.append( " WHERE FDCODE = '"+str1+"'	  ");  
					UpdateSql.append( " AND AST1ST =  '"+str3+"'	  ");
					UpdateSql.append( " AND AST2ND =  '"+str4+"'	");
					UpdateSql.append( " AND AST3RD =  '"+str5+"'	");
					UpdateSql.append( " AND ASTSEQ =  '"+str6+"'	");
					UpdateSql.append( " AND MORTNO =  '"+MORTNO+"'	");

					GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());	
					gsmt.executeUpdate(); 
					gsmt.close(); 
 
				}  //update if
								
			if (IsUpdated.equals("1")){				

					Statement stmt = conn.createStatement();

					String sql = " SELECT COALESCE(MAX(MORTNO),0)+1 AS MORTNO FROM  ACCOUNT.ASTMORT "
										 + "	WHERE FDCODE  = '"+str1+"'"	
										 + "    AND	AST1ST  = '"+str3+"'"	
										 + "    AND AST2ND  = '"+str4+"'"  
										 + "    AND AST3RD  = '"+str5+"'" 				
										 + "    AND ASTSEQ  = '"+str6+"'";	

					ResultSet rs = stmt.executeQuery(sql); 

					if(rs.next()){
						 strFsnbr= rs.getString(1);
					}
					int ichk = Integer.parseInt(strFsnbr);
					if(ichk<10) strFsnbr = "000"+strFsnbr;
					else if(ichk>=10 && ichk<100)strFsnbr = "00"+strFsnbr;
					else if(ichk>=100 && ichk<1000) strFsnbr ="0"+strFsnbr;
						
					if(intChk==0){  
						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO ACCOUNT.ASTMORT (FDCODE,ATCODE,AST1ST,AST2ND,AST3RD,   ");
						InsertSql.append( "ASTSEQ,MORTDATE,MORTBANK,CLOSEORNOT,CLOSEDATE, ");
						InsertSql.append( "BOOKAMT,MORTSIZE,MORTJDGDT,JUDGAMT,MORTAMT, ");
						InsertSql.append( "MORTDTL,MORTORDER,WRDT,WRID,MORTNO  ) ");
						InsertSql.append( "  VALUES ( '" + str1 + "','" + str2 + "','"	+ str3 + "','" + str4 + "','" + str5 + "','" + str6+ "','" 
						+ str7 + "','" + str8 + "','" + str9 + "','" + str10+ "','" + str11 + "','" + str12 + "','" + str13 + "','" 
						+ str14 + "','" + str15 + "','" + str16 + "','" + str17+ "','" + str18 + "','" + str19 + "','" 
						+ strFsnbr+ "' ) " );

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());	 			
						gsmt.executeUpdate(); 
						gsmt.close();							
					} 
				} // 1
				
				if (IsUpdated.equals("3")){

					DeleteSql = new StringBuffer();
					DeleteSql.append( " DELETE FROM ACCOUNT.ASTMORT  ");
					DeleteSql.append( " WHERE FDCODE =  '"+str1+"'   ");  
					DeleteSql.append( " AND ATCODE   =  '"+str2+"'   ");
					DeleteSql.append( " AND AST1ST   =   '"+str3+"'	 ");
					DeleteSql.append( " AND AST2ND   =  '"+str4+"'	 ");
					DeleteSql.append( " AND AST3RD   =  '"+str5+"'	 ");
					DeleteSql.append( " AND ASTSEQ   =  '"+str6+"'	 ");
					DeleteSql.append( " AND MORTNO   =  '"+MORTNO+"' ");	

					GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());	 			
				  gsmt.executeUpdate(); 
				  gsmt.close();			
				}//3

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