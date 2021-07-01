package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a090021_t12 extends HttpServlet{
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
			 	String  str1   	= reqGauce.getParameter("v_str1");   //지점코드   필수 
				String  str2    = reqGauce.getParameter("v_str2");   //계정코드   필수
				String  str3	  = reqGauce.getParameter("v_str3");   //1구분  
				String  str4    = reqGauce.getParameter("v_str4");   //자산중분류  필수      
				String  str5    = reqGauce.getParameter("v_str5");   //자산소분류  필수     
				String  str6	  = reqGauce.getParameter("v_str6");   //일련번호  
				String  str7	  = reqGauce.getParameter("v_str7");     
				String  str8	  = reqGauce.getParameter("v_str8");    
				String  str9    = reqGauce.getParameter("v_str9");    
				String  str10	  = reqGauce.getParameter("v_str10");  
				String  str11  	= reqGauce.getParameter("v_str11");  
				String  str12   = reqGauce.getParameter("v_str12"); 
				String  str13  	= reqGauce.getParameter("v_str13");  

				String  ASTMOVNO	= reqGauce.getParameter("ASTMOVNO"); 
				String  IsUpdated	= reqGauce.getParameter("IsUpdated"); 

				String strAMNGDPT="";
				String strAUSEDPT="";
				String strACOSTCD="";
				String strAUSER="";

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE    = userSet.indexOfColumn("FDCODE");        
				int idxATCODE    = userSet.indexOfColumn("ATCODE");           
				int idxAST1ST    = userSet.indexOfColumn("AST1ST");            
				int idxAST2ND    = userSet.indexOfColumn("AST2ND");           
				int idxAST3RD    = userSet.indexOfColumn("AST3RD");           
				int idxASTSEQ    = userSet.indexOfColumn("ASTSEQ");           
				int idxASTMOVNO  = userSet.indexOfColumn("ASTMOVNO");        
				int idxMOVDATE   = userSet.indexOfColumn("MOVDATE");        
				int idxAMNGDPT  = userSet.indexOfColumn("AMNGDPT");      
				int idxAUSEDPT  = userSet.indexOfColumn("AUSEDPT");    
				int idxACOSTCD   = userSet.indexOfColumn("ACOSTCD");       
				int idxMOVNOTE   = userSet.indexOfColumn("MOVNOTE");              
				int idxWRID      = userSet.indexOfColumn("WRID");  

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql   = null;        
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql  = null;

				if(IsUpdated.equals("2")){ //update 

					UpdateSql = new StringBuffer();
					UpdateSql.append( " UPDATE ACCOUNT.ASTMOVINGN  SET "); 
					UpdateSql.append( "				 MOVDATE  = '"+str7+"',	");
					UpdateSql.append( "				 AMNGDPT = '"+str8+"',	");
					UpdateSql.append( "				 AUSEDPT = '"+str9+"',	");
					UpdateSql.append( "				 ACOSTCD  = '"+str10+"',");
					UpdateSql.append( "				 MOVNOTE  = '"+str11+"',");
					UpdateSql.append( "				 ATCODE   =  '"+str2+"',");
					UpdateSql.append( "				 WRDT     = sysdate,");
					UpdateSql.append( "				 WRID     = '"+str13+"' ");
					UpdateSql.append( "  WHERE FDCODE =  '"+str1+"'	  ");  
					UpdateSql.append( "    AND ATCODE =  '"+str2+"'	  ");
					UpdateSql.append( "    AND AST1ST =  '"+str3+"'	  ");
					UpdateSql.append( "    AND AST2ND =  '"+str4+"'	");
					UpdateSql.append( "    AND AST3RD =  '"+str5+"'	");
					UpdateSql.append( "    AND ASTSEQ =  '"+str6+"'	");
					UpdateSql.append( "    AND ASTMOVNO = '"+ASTMOVNO+"'");  

					GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());	

					gsmt.executeUpdate(); 
					gsmt.close(); 
					gsmt = null;

					//자산BASIC UPDATE  - 원가, 관리부서, 사용부서, WRDT, WRID 
					UpdateSql = new StringBuffer();
					UpdateSql.append( " UPDATE ACCOUNT.ASTBASICN SET "); 
					UpdateSql.append( "				 COSTCD = '"+str10+"',");
					UpdateSql.append( "				 USEDPT = '"+str9+"',	");
					UpdateSql.append( "				 MNGDPT = '"+str8+"',	");
					UpdateSql.append( "				 WRDT   = sysdate,");
					UpdateSql.append( "				 WRID   = '"+str13+"' ");
					UpdateSql.append( "  WHERE FDCODE =  '"+str1+"'	"); 
					UpdateSql.append( "    AND ATCODE =  '"+str2+"'	");
					UpdateSql.append( "    AND AST1ST =  '"+str3+"'	");
					UpdateSql.append( "    AND AST2ND =  '"+str4+"'	");
					UpdateSql.append( "    AND AST3RD =  '"+str5+"'	");
					UpdateSql.append( "    AND ASTSEQ =  '"+str6+"'	");
					
					gsmt = conn.getGauceStatement(UpdateSql.toString());	

					gsmt.executeUpdate(); 
					gsmt.close(); 
					gsmt = null;

 				}  //update if

  
	     //4 는 사용안함.////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	   	 if(IsUpdated.equals("4")){

					InsertSql = new StringBuffer();
					InsertSql.append( " INSERT INTO ACCOUNT.ASTMOVINGN (FDCODE,ATCODE,AST1ST,AST2ND,AST3RD," );
					InsertSql.append( " ASTSEQ,MOVDATE,AMNGDPT,AUSEDPT,ACOSTCD," );
					InsertSql.append( " MOVNOTE,WRDT,WRID,ASTMOVNO  ) ");
					InsertSql.append( "  VALUES ( '" + str1 + "','" + str2 + "','"	+ str3 + "','" + str4 + "','" + str5 + "','" + str6+ "','" 
													 + str7 + "','" + str8 + "','" + str9 + "','" + str10+ "','" + str11 + "',sysdate,'" + str13 + "','" 						
													 + ASTMOVNO+ "' ) " );		 
					GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());	 			
					gsmt.executeUpdate(); 
					gsmt.close();	
       }  //update if //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
								
      //insert
			if (IsUpdated.equals("1")){				

					Statement stmt = conn.createStatement();
					String sql = " SELECT COALESCE(MAX(ASTMOVNO),0)+1 AS ASTMOVNO FROM  ACCOUNT.ASTMOVINGN "
										 + "	WHERE FDCODE  = '"+str1+"'"	
										 + "    AND	AST1ST  = '"+str3+"'"	
										 + "    AND AST2ND  = '"+str4+"'"  
										 + "    AND AST3RD  = '"+str5+"'" 				
										 + "    AND ASTSEQ  = '"+str6+"'";			

					ResultSet rs = stmt.executeQuery(sql); 
					
					if(rs.next()){
						 strFsnbr= rs.getString(1);
					}
					rs.close();
					stmt.close();


					int ichk = Integer.parseInt(strFsnbr);
					if(ichk<10) strFsnbr = "000"+strFsnbr;
					else if(ichk>=10 && ichk<100)strFsnbr = "00"+strFsnbr;
					else if(ichk>=100 && ichk<1000) strFsnbr ="0"+strFsnbr;

					InsertSql = new StringBuffer();
					InsertSql.append( " INSERT INTO ACCOUNT.ASTMOVINGN (FDCODE,ATCODE,AST1ST,AST2ND,AST3RD," );
					InsertSql.append( " ASTSEQ,MOVDATE,AMNGDPT,AUSEDPT,ACOSTCD," );
					InsertSql.append( " MOVNOTE,WRDT,WRID,ASTMOVNO  ) ");
					InsertSql.append( " VALUES ( '" + str1 + "','" + str2 + "','"	+ str3 + "','" + str4 + "','" + str5 + "','" + str6+ "','" 
															 + str7 + "','" + str8 + "','" + str9 + "','" + str10+ "','" + str11 + "',sysdate,'" + str13 + "','" 						
															 + strFsnbr+ "' ) " );
					GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());	 			
					gsmt.executeUpdate(); 
					gsmt.close();							

					//자산BASIC UPDATE  - 원가, 관리부서, 사용부서, WRDT, WRID 
					UpdateSql = new StringBuffer();
					UpdateSql.append( " UPDATE ACCOUNT.ASTBASICN SET "); 
					UpdateSql.append( "				 COSTCD = '"+str10+"',");
					UpdateSql.append( "				 USEDPT = '"+str9+"',	");
					UpdateSql.append( "				 MNGDPT = '"+str8+"',	");
					UpdateSql.append( "				 WRDT   = sysdate,");
					UpdateSql.append( "				 WRID   = '"+str13+"' ");
					UpdateSql.append( "  WHERE FDCODE =  '"+str1+"'	"); 
					UpdateSql.append( "    AND ATCODE =  '"+str2+"'	");
					UpdateSql.append( "    AND AST1ST =  '"+str3+"'	");
					UpdateSql.append( "    AND AST2ND =  '"+str4+"'	");
					UpdateSql.append( "    AND AST3RD =  '"+str5+"'	");
					UpdateSql.append( "    AND ASTSEQ =  '"+str6+"'	");
					
					gsmt = conn.getGauceStatement(UpdateSql.toString());	

					gsmt.executeUpdate(); 
					gsmt.close(); 
					gsmt = null;


			} // 1
				
			if (IsUpdated.equals("3")){

				 strAMNGDPT="";
				 strAUSEDPT="";
				 strACOSTCD="";
				 strAUSER ="";

				//삭제시 삭제이전 원가/관리부서/사용부서/사용자 등을 자산BASIC에 반영함.
				Statement stmt = conn.createStatement();
				String sql = "  SELECT AMNGDPT, AUSEDPT, ACOSTCD, AUSER "
				           			+ "	FROM ACCOUNT.ASTMOVINGN "	
									 + "	WHERE FDCODE  = '"+str1+"'"	
									 + "    AND	ATCODE  = '"+str2+"'"	
									 + "    AND	AST1ST  = '"+str3+"'"	
									 + "    AND AST2ND  = '"+str4+"'"  
									 + "    AND AST3RD  = '"+str5+"'" 				
									 + "    AND ASTSEQ  = '"+str6+"'"		
									 + "    AND ASTMOVNO = (SELECT MAX(ASTMOVNO) FROM ACCOUNT.ASTMOVINGN "
									 + "	                   WHERE FDCODE = '"+str1+"'"	
									 + "                       AND ATCODE = '"+str2+"'"	
									 + "                       AND AST1ST = '"+str3+"'"	
									 + "                       AND AST2ND = '"+str4+"'"  
									 + "                       AND AST3RD = '"+str5+"'" 				
									 + "                       AND ASTSEQ = '"+str6+"'"		
									 + "                       AND ASTMOVNO<'"+ASTMOVNO+"')";		 
				ResultSet rs = stmt.executeQuery(sql); 


				if(rs.next()){				
					strAMNGDPT=rs.getString(1);
					strAUSEDPT=rs.getString(2);
					strACOSTCD=rs.getString(3);
					strAUSER  =rs.getString(4);
				}

				rs.close();
				stmt.close();

				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.ASTBASICN SET "); 
				UpdateSql.append( "				 COSTCD = '"+strACOSTCD+"',");
				UpdateSql.append( "				 USEDPT = '"+strAUSEDPT+"',");
				UpdateSql.append( "				 MNGDPT = '"+strAMNGDPT+"',");
				UpdateSql.append( "				 ASTUSER = '"+strAUSER+"',");
				UpdateSql.append( "				 WRDT   = sysdate,");
				UpdateSql.append( "				 WRID   = '"+str13+"' ");
				UpdateSql.append( "  WHERE FDCODE = '"+str1+"'"); 
				UpdateSql.append( "    AND ATCODE = '"+str2+"'");
				UpdateSql.append( "    AND AST1ST = '"+str3+"'");
				UpdateSql.append( "    AND AST2ND = '"+str4+"'");
				UpdateSql.append( "    AND AST3RD = '"+str5+"'");
				UpdateSql.append( "    AND ASTSEQ = '"+str6+"'");
				
				GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());	

				gsmt.executeUpdate(); 
				gsmt.close(); 
				gsmt = null;


				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.ASTMOVINGN    ");
				DeleteSql.append( "  WHERE FDCODE   =  '"+str1+"'  	 ");  
				DeleteSql.append( "    AND ATCODE   =  '"+str2+"'  	 ");
				DeleteSql.append( "    AND AST1ST   =  '"+str3+"'	   ");
				DeleteSql.append( "    AND AST2ND   =  '"+str4+"'	   ");
				DeleteSql.append( "    AND AST3RD   =  '"+str5+"'	   ");
				DeleteSql.append( "    AND ASTSEQ   =  '"+str6+"'	   ");
				DeleteSql.append( "    AND ASTMOVNO =  '"+ASTMOVNO+"'");	

				gsmt = conn.getGauceStatement(DeleteSql.toString());	 			
				gsmt.executeUpdate(); 
				gsmt.close();			

				//이전의 건을 가지고 UPDATE 해야함.


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