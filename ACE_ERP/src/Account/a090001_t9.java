package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a090001_t9 extends HttpServlet{
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
				String  str3	    = reqGauce.getParameter("v_str3");   //1����  
				String  str4	    = reqGauce.getParameter("v_str4");   //�ڻ��ߺз�  �ʼ�      
				String  str5    = reqGauce.getParameter("v_str5");   //�ڻ�Һз�  �ʼ�     
				String  str6	   = reqGauce.getParameter("v_str6");    //�Ϸù�ȣ  
				String  str7	   = reqGauce.getParameter("v_str7");     
				String  str8	    = reqGauce.getParameter("v_str8");    
				String  str9    = reqGauce.getParameter("v_str9");    
				String  str10	  = reqGauce.getParameter("v_str10");  
				String  str11  	= reqGauce.getParameter("v_str11");  
				String  str12   = reqGauce.getParameter("v_str12"); 
				String  str13  	= reqGauce.getParameter("v_str13");  
				String  str14	   = reqGauce.getParameter("v_str14");     
				String  str15	    = reqGauce.getParameter("v_str15");    
				String  str16    = reqGauce.getParameter("v_str16");    
				String  str17	  = reqGauce.getParameter("v_str17");  

				String   CHGNO	= reqGauce.getParameter("CHGNO"); 
				String    IsUpdated	= reqGauce.getParameter("IsUpdated"); 

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE        = userSet.indexOfColumn("FDCODE");      
				int idxATCODE        = userSet.indexOfColumn("ATCODE");         
				int idxAST1ST          = userSet.indexOfColumn("AST1ST");          
				int idxAST2ND         = userSet.indexOfColumn("AST2ND");         
				int idxAST3RD          = userSet.indexOfColumn("AST3RD");        
				int idxASTSEQ         = userSet.indexOfColumn("ASTSEQ");         
				int idxCHGNO          = userSet.indexOfColumn("CHGNO");          
				int idxCHGDATE       = userSet.indexOfColumn("CHGDATE");       
				int idxCHGTYPE       = userSet.indexOfColumn("CHGTYPE");       
				int idxDECTYPE       = userSet.indexOfColumn("DECTYPE");       
				int idxCHGWHAT     = userSet.indexOfColumn("CHGWHAT");     
				int idxCHGQTY        = userSet.indexOfColumn("CHGQTY");        
				int idxCHGAMT        = userSet.indexOfColumn("CHGAMT");        
				int idxRELFIRM        = userSet.indexOfColumn("RELFIRM");        
				int idxRPSTARTDT    = userSet.indexOfColumn("RPSTARTDT");    
				int idxRPENDDT       = userSet.indexOfColumn("RPENDDT");       
				int idxWRDT            = userSet.indexOfColumn("WRDT");            
				int idxWRID             = userSet.indexOfColumn("WRID");    

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql   = null;        
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql  = null;

				if(IsUpdated.equals("2")){

				UpdateSql = new StringBuffer();
                UpdateSql.append( " UPDATE ACCOUNT.ASTCHG  SET   "); 
                UpdateSql.append( " CHGDATE    = '"+str7+"',	      ");
                UpdateSql.append( " CHGTYPE   	= '"+str8+"',	    ");
                UpdateSql.append( " DECTYPE   = '"+str9+"',	      ");
                UpdateSql.append( " CHGWHAT 	= '"+str10+"',	    ");
                UpdateSql.append( " CHGQTY     			= '"+str11+"',	    ");
                UpdateSql.append( " CHGAMT    		= '"+str12+"',	      ");
                UpdateSql.append( " RELFIRM    		= '"+str13+"',	      ");
                UpdateSql.append( " RPSTARTDT= '"+str14+"',	      ");
                UpdateSql.append( " RPENDDT   = '"+str15+"',	      ");
                UpdateSql.append( "  ATCODE =  '"+str2+"',	");
                UpdateSql.append( " WRDT        = '"+str16+"',	      ");
                UpdateSql.append( " WRID         = '"+str17+"'       ");
             	UpdateSql.append( " WHERE FDCODE = '"+str1+"'	  ");  
				UpdateSql.append( " AND AST1ST =  '"+str3+"'	  ");
				UpdateSql.append( " AND AST2ND =  '"+str4+"'	");
                UpdateSql.append( " AND AST3RD =  '"+str5+"'	");
                UpdateSql.append( " AND ASTSEQ =  '"+str6+"'	");
                UpdateSql.append( " AND CHGNO =  '"+CHGNO+"'	");

			     GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());	
			     gsmt.executeUpdate(); 
			     gsmt.close(); 
 
		       }  //update if
										
					if (IsUpdated.equals("1")){				
		
		              Statement stmt = conn.createStatement();

							String sql = "SELECT COALESCE(MAX(CHGNO),0)+1 AS CHGNO FROM  ACCOUNT.ASTCHG "
										 + "	WHERE FDCODE  = '"+str1+"'"	
								         + "    AND	  AST1ST  = '"+str3+"'"	
								         + "    AND   AST2ND  = '"+str4+"'"  
									     + "    AND   AST3RD  = '"+str5+"'" 				
 									     + "    AND   ASTSEQ  = '"+str6+"'";		

							ResultSet rs = stmt.executeQuery(sql); 

							if(rs.next()){
								 logger.dbg.println(this,"rs.getString(1):"+rs.getString(1));
								 strFsnbr= rs.getString(1);
							}


							int ichk = Integer.parseInt(strFsnbr);
							if(ichk<10) strFsnbr = "000"+strFsnbr;
							else if(ichk>=10 && ichk<100)strFsnbr = "00"+strFsnbr;
							else if(ichk>=100 && ichk<1000) strFsnbr ="0"+strFsnbr;

						    if(intChk==0){  
						    InsertSql = new StringBuffer();
							InsertSql.append( " INSERT INTO ACCOUNT.ASTCHG ( FDCODE,ATCODE,AST1ST,AST2ND,AST3RD,");
							InsertSql.append( " ASTSEQ,CHGDATE,CHGTYPE,DECTYPE,CHGWHAT,");
							InsertSql.append( " CHGQTY,CHGAMT,RELFIRM,RPSTARTDT,RPENDDT,");
							InsertSql.append( "  WRDT,WRID,CHGNO ) ");
							InsertSql.append( "  VALUES ( '" + str1 + "','" + str2 + "','"	+ str3 + "','" + str4 + "','" + str5 + "','" + str6+ "','" 
								 + str7 + "','" + str8 + "','" + str9 + "','" + str10+ "','" + str11 + "','" + str12 + "','" + str13 + "','" 
								 + str14 + "','" + str15 + "','" + str16 + "','" + str17+ "','"
                              	  + strFsnbr+ "' ) " );

								 GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());	 			
								 gsmt.executeUpdate(); 
								 gsmt.close();							

					} 
				} // 1
					
				if (IsUpdated.equals("3")){

				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.ASTCHG   " );
				DeleteSql.append( " WHERE FDCODE =  '"+str1+"'       	");  
				DeleteSql.append( " AND ATCODE      =  '"+str2+"'      	");
				DeleteSql.append( " AND AST1ST       =   '"+str3+"'	      ");
				DeleteSql.append( " AND AST2ND      =  '"+str4+"'	      ");
				DeleteSql.append( " AND AST3RD      =  '"+str5+"'	        ");
				DeleteSql.append( " AND ASTSEQ      =  '"+str6+"'	      ");
				DeleteSql.append( " AND CHGNO  =  '"+CHGNO+"'   	");	

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