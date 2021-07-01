package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a090001_t12 extends HttpServlet{
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


				// ������������ ���ǰ��� �Ѱܹ���
			 	String  str1   	= reqGauce.getParameter("v_str1");    //�����ڵ�  �ʼ� 
				String  str2    = reqGauce.getParameter("v_str2");   //�����ڵ�   �ʼ�
				String  str3	= reqGauce.getParameter("v_str3");   //1����  
				String  str4    = reqGauce.getParameter("v_str4");   //�ڻ��ߺз�  �ʼ�      
				String  str5    = reqGauce.getParameter("v_str5");   //�ڻ�Һз�  �ʼ�     
				String  str6	   = reqGauce.getParameter("v_str6");    //�Ϸù�ȣ  
				String  str7	 = reqGauce.getParameter("v_str7");     
				String  str8	 = reqGauce.getParameter("v_str8");    
				String  str9    = reqGauce.getParameter("v_str9");    
				String  str10	 = reqGauce.getParameter("v_str10");  
				String  str11  	= reqGauce.getParameter("v_str11");  
				String  str12   = reqGauce.getParameter("v_str12"); 
				String  str13  	= reqGauce.getParameter("v_str13");  

                String    ASTMOVNO	= reqGauce.getParameter("ASTMOVNO"); 
				String    IsUpdated	= reqGauce.getParameter("IsUpdated"); 

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE      = userSet.indexOfColumn("FDCODE");        
				int idxATCODE      = userSet.indexOfColumn("ATCODE");           
				int idxAST1ST      = userSet.indexOfColumn("AST1ST");            
				int idxAST2ND      = userSet.indexOfColumn("AST2ND");           
				int idxAST3RD      = userSet.indexOfColumn("AST3RD");           
				int idxASTSEQ      = userSet.indexOfColumn("ASTSEQ");           
				int idxASTMOVNO    = userSet.indexOfColumn("ASTMOVNO");        
				int idxMOVDATE     = userSet.indexOfColumn("MOVDATE");        
				int idxAMNGDEPT    = userSet.indexOfColumn("AMNGDEPT");      
				int idxAUSEDEPT    = userSet.indexOfColumn("AUSEDEPT");    
				int idxACOSTCD     = userSet.indexOfColumn("ACOSTCD");       
				int idxMOVNOTE     = userSet.indexOfColumn("MOVNOTE");        
				int idxWRDT        = userSet.indexOfColumn("WRDT");           
				int idxWRID        = userSet.indexOfColumn("WRID");  

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql   = null;        
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql  = null;

				if(IsUpdated.equals("2")){

				UpdateSql = new StringBuffer();
                UpdateSql.append( " UPDATE ACCOUNT.ASTMOVING  SET   "); 
                UpdateSql.append( " MOVDATE      = '"+str7+"',	      ");
                UpdateSql.append( " AMNGDEPT     = '"+str8+"',	    ");
                UpdateSql.append( " AUSEDEPT     = '"+str9+"',	      ");
                UpdateSql.append( " ACOSTCD    	 = '"+str10+"',	    ");
                UpdateSql.append( " MOVNOTE      = '"+str11+"',	    ");
                UpdateSql.append( "  ATCODE      =  '"+str2+"',   	");
                UpdateSql.append( " WRDT       	= '"+str12+"',	      ");
                UpdateSql.append( " WRID       	= '"+str13+"'      ");
              	UpdateSql.append( " WHERE FDCODE = '"+str1+"'	  ");  
		        UpdateSql.append( " AND AST1ST =  '"+str3+"'	  ");
		        UpdateSql.append( " AND AST2ND =  '"+str4+"'	");
                UpdateSql.append( " AND AST3RD =  '"+str5+"'	");
                UpdateSql.append( " AND ASTSEQ =  '"+str6+"'	");
   
                UpdateSql.append( " AND ASTMOVNO =  '"+ASTMOVNO+"'	");  

			     GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());	
			     gsmt.executeUpdate(); 
			     gsmt.close(); 
 
				}  //update if


	   				if(IsUpdated.equals("4")){

                           	InsertSql = new StringBuffer();
							InsertSql.append( " INSERT INTO ACCOUNT.ASTMOVING (FDCODE,ATCODE,AST1ST,AST2ND,AST3RD," );
							InsertSql.append( " ASTSEQ,MOVDATE,AMNGDEPT,AUSEDEPT,ACOSTCD," );
							InsertSql.append( " MOVNOTE,WRDT,WRID,ASTMOVNO  ) ");
							InsertSql.append( "  VALUES ( '" + str1 + "','" + str2 + "','"	+ str3 + "','" + str4 + "','" + str5 + "','" + str6+ "','" 
								 + str7 + "','" + str8 + "','" + str9 + "','" + str10+ "','" + str11 + "','" + str12 + "','" + str13 + "','" 						
                              	  + ASTMOVNO+ "' ) " );

								 GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());	 			
								 gsmt.executeUpdate(); 
								 gsmt.close();	
 
			       }  //update if
											
						if (IsUpdated.equals("1")){				
			
			              Statement stmt = conn.createStatement();

							String sql = "SELECT COALESCE(MAX(ASTMOVNO),0)+1 AS ASTMOVNO FROM  ACCOUNT.ASTMOVING "
					                     + "	WHERE FDCODE  = '"+str1+"'"	
								         + "    AND	  AST1ST  = '"+str3+"'"	
								         + "    AND   AST2ND  = '"+str4+"'"  
									     + "    AND   AST3RD  = '"+str5+"'" 				
 									     + "    AND   ASTSEQ  = '"+str6+"'";			

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
							InsertSql.append( " INSERT INTO ACCOUNT.ASTMOVING (FDCODE,ATCODE,AST1ST,AST2ND,AST3RD," );
							InsertSql.append( " ASTSEQ,MOVDATE,AMNGDEPT,AUSEDEPT,ACOSTCD," );
							InsertSql.append( " MOVNOTE,WRDT,WRID,ASTMOVNO  ) ");
							InsertSql.append( "  VALUES ( '" + str1 + "','" + str2 + "','"	+ str3 + "','" + str4 + "','" + str5 + "','" + str6+ "','" 
													+ str7 + "','" + str8 + "','" + str9 + "','" + str10+ "','" + str11 + "','" + str12 + "','" + str13 + "','" 						
													+ strFsnbr+ "' ) " );

								 GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());	 			
								 gsmt.executeUpdate(); 
								 gsmt.close();							

					} 
				} // 1
				
				if (IsUpdated.equals("3")){

				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.ASTMOVING   " );
				DeleteSql.append( " WHERE FDCODE   =  '"+str1+"'       	");  
				DeleteSql.append( " AND ATCODE      =  '"+str2+"'      	");
				DeleteSql.append( " AND AST1ST       =   '"+str3+"'	      ");
				DeleteSql.append( " AND AST2ND      =  '"+str4+"'	      ");
				DeleteSql.append( " AND AST3RD      =  '"+str5+"'	        ");
				DeleteSql.append( " AND ASTSEQ      =  '"+str6+"'	      ");
				DeleteSql.append( " AND ASTMOVNO  =  '"+ASTMOVNO+"'   	");	


				GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());	 			
				 gsmt.executeUpdate(); 
				 gsmt.close();			
				}//3

			}
			catch(Exception e){
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
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