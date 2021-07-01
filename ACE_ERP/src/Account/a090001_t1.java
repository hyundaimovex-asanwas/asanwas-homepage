package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a090001_t1 extends HttpServlet{
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
				String  str1	= reqGauce.getParameter("v_str1"); //지점
				String  str2    = reqGauce.getParameter("v_str2"); //자산명
				String  str3	= reqGauce.getParameter("v_str3"); //자산중분류  필수
				String  str4	= reqGauce.getParameter("v_str4"); //자산소분류  필수
				String  str5    = reqGauce.getParameter("v_str5"); ///계정코드   
				String  str6	= reqGauce.getParameter("v_str6"); //취득일자 
				String  str7	= reqGauce.getParameter("v_str7"); //계산서번호
				String  str8    = reqGauce.getParameter("v_str8"); //회계접수번호
				String  str9	= reqGauce.getParameter("v_str9"); ///담당부서
				String  str10	= reqGauce.getParameter("v_str10"); //담당자	
				String  str11	= reqGauce.getParameter("v_str11"); //AST1ST
				String  str12	= reqGauce.getParameter("v_str12"); //ASTSEQ
				String  str13	= reqGauce.getParameter("v_str13"); //규격
				String  str14	= reqGauce.getParameter("v_str14"); //모델명
				String  str15	= reqGauce.getParameter("v_str15"); //작업자
				String  str16	= reqGauce.getParameter("v_str16"); //작업ID

				String  IsUpdated	= reqGauce.getParameter("IsUpdated"); 

				if(str4==""){
				  str4 ="00";
				}else{
                  str4 =str4;
				}

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE     = userSet.indexOfColumn("FDCODE");     
				int idxATCODE     = userSet.indexOfColumn("ATCODE");     
				int idxAST1ST     = userSet.indexOfColumn("AST1ST");     
				int idxAST2ND     = userSet.indexOfColumn("AST2ND");     
				int idxAST3RD     = userSet.indexOfColumn("AST3RD");     
				int idxASTNAME    = userSet.indexOfColumn("ASTNAME");    
				int idxDEPTCD     = userSet.indexOfColumn("DEPTCD");     
				int idxEMPNO      = userSet.indexOfColumn("EMPNO");      
				int idxASTSEQ     = userSet.indexOfColumn("ASTSEQ");     
				int idxSEQ        = userSet.indexOfColumn("SEQ");        
				int idxASAQSDAT   = userSet.indexOfColumn("ASAQSDAT"); 
				int idxTAXNBR     = userSet.indexOfColumn("TAXNBR");   
				int idxFSNBR      = userSet.indexOfColumn("FSNBR");    
				int idxASTNAME2      = userSet.indexOfColumn("ASTNAME2");    
				int idxASTNAME3      = userSet.indexOfColumn("ASTNAME3");    
					            						            
							
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;        
				StringBuffer UpdateSql = null;	      
 				StringBuffer DeleteSql = null;	      

 				if(IsUpdated.equals("2")){

				UpdateSql = new StringBuffer();

                UpdateSql.append( " UPDATE ACCOUNT.ASTMST SET   ");               
                UpdateSql.append( " ASTNAME =	'"+str2+"',	    ");	
                UpdateSql.append( " ASAQSDAT =	'"+str6+"',	    ");
                UpdateSql.append( " TAXNBR =	'"+str7+"',	    ");
                UpdateSql.append( " FSNBR =		'"+str8+"',     ");             
                UpdateSql.append( " DEPTCD =	'"+str9+"',	    ");
                UpdateSql.append( " AST1ST =	'"+str1+"',	    ");
                UpdateSql.append( " EMPNO =     '"+str10+"',	");
                UpdateSql.append( " ATCODE =    '"+str5+"',	    ");	
                UpdateSql.append( " ASTNAME3 =    '"+str14+"',	    ");	
				UpdateSql.append( " UPDT =    '"+str15+"',	    ");	
				UpdateSql.append( " UPID =    '"+str16+"'	    ");	
                UpdateSql.append( " WHERE FDCODE = '"+str1+"'	");
				UpdateSql.append( " AND AST2ND =  '"+str3+"'	");
                UpdateSql.append( " AND AST3RD =  '"+str4+"'	");
                UpdateSql.append( " AND	ASTSEQ =  '"+str12+"'    ");

			     // logger.dbg.println(this,UpdateSql.toString());
			     GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());	
			     gsmt.executeUpdate(); 
			     gsmt.close(); 
 
              }else if (IsUpdated.equals("1")){
//////////////////////////////////////////////////////////		
                          Statement stmt = conn.createStatement();

							String sql = "SELECT COALESCE(MAX(ASTSEQ),0)+1 AS ASTSEQ FROM  ACCOUNT.ASTMST "
					                   + "	WHERE FDCODE = '"+str1+"'"	
									   + "  AND   AST1ST = '"+str11+"'"  
									   + "  AND   AST2ND = '"+str3+"'"  
									   + "  AND   AST3RD = '"+str4+"'" ;					
                          
							ResultSet rs = stmt.executeQuery(sql); 

							if(rs.next()){

								 strFsnbr= rs.getString(1);
							}

							int ichk = Integer.parseInt(strFsnbr);
							
							if(ichk<10) strFsnbr = "0000"+strFsnbr;
							else if(ichk>=10 && ichk<100)strFsnbr = "000"+strFsnbr;
							else if(ichk>=100 && ichk<1000) strFsnbr ="00"+strFsnbr;
							else if(ichk>=1000 && ichk<10000)strFsnbr = "0"+strFsnbr;


						    if(intChk==0){  
                           InsertSql = new StringBuffer();
						   InsertSql.append( " INSERT INTO ACCOUNT.ASTMST ( FDCODE, AST1ST, ASTNAME,AST2ND,AST3RD, " );
						   InsertSql.append( " ATCODE,ASAQSDAT,TAXNBR,FSNBR,DEPTCD, " );
						   InsertSql.append( " EMPNO,ASTSEQ,ASTNAME2,ASTNAME3,WRDT,WRID ) " );
						   InsertSql.append( "  VALUES ( '" + str1 + "','" + str11 + "','"		
								 + str2 + "','" + str3 + "','" + str4 + "','" + str5+ "','" 
								 + str6 + "','" + str7 + "','" + str8 + "','" + str9+ "','" 
                              	 + str10 + "','" + strFsnbr+ "','" + str13 + "','" +str14 + "','" + str15 + "','" + str16+ "' ) " );

								GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());	 			
								 gsmt.executeUpdate(); 
								 gsmt.close();							

						}
					 }else if (IsUpdated.equals("3")){
		
						        DeleteSql = new StringBuffer();
		
								DeleteSql.append( "  DELETE FROM  ACCOUNT.ASTMST   " );
				                DeleteSql.append( "  WHERE FDCODE  = '"+str1+"'   " );
								DeleteSql.append( "    AND AST1ST  = '"+str1+"'   " );			
								DeleteSql.append( "    AND AST2ND =  '"+str3+"'   " );
								DeleteSql.append( "    AND AST3RD  = '"+str4+"'   " );
								DeleteSql.append( "    AND ASTSEQ  = '"+str12+"'    " );

								GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());	 			
								 gsmt.executeUpdate(); 
								 gsmt.close();	

						 }
///////////////////////////	
			
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