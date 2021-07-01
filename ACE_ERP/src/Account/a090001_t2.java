package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a090001_t2 extends HttpServlet{
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
				String  str1	= reqGauce.getParameter("v_str1");    //지점코드  필수   
				String  str2    = reqGauce.getParameter("v_str2");   //자산명       
				String  str3	= reqGauce.getParameter("v_str3");   //자산중분류  필수    
				String  str4	= reqGauce.getParameter("v_str4");   //자산소분류  필수    
				String  str5    = reqGauce.getParameter("v_str5");    //계정코드   필수  
				String  str6	= reqGauce.getParameter("v_str6");   //취득일자 	       
				String  str7	= reqGauce.getParameter("v_str7");   //계산서번호    
				String  str8	= reqGauce.getParameter("v_str8");   //회계접수번호  
				String  str9    = reqGauce.getParameter("v_str9");   //담당부서          
				String  str10	= reqGauce.getParameter("v_str10");  //담당자*/            
				String  str11	= reqGauce.getParameter("v_str11"); //MNGTYPE, *관리구분*/ 
				String  str12   = reqGauce.getParameter("v_str12"); //ASTSTAT, *상태코드*/
				String  str13	= reqGauce.getParameter("v_str13"); //ASCOSDIV,*매출원가구분
				String  str14	= reqGauce.getParameter("v_str14"); //COSTCD,  *원가코드*/
				String  str15	= reqGauce.getParameter("v_str15"); //ASAQSDIV,*취득구분*/
				String  str16   = reqGauce.getParameter("v_str16"); //GODDIV,  *자산구분*/
				String  str17	= reqGauce.getParameter("v_str17"); //ASTCLASS,*자산등급*/
				String  str18	= reqGauce.getParameter("v_str18"); //ASTRIS,  *리스유무*/
				String  str19   = reqGauce.getParameter("v_str19"); //ASTUNIT, *단위*/    
				String  str20	= reqGauce.getParameter("v_str20"); //ASTQTY,  *수량*/    
				String  str21	= reqGauce.getParameter("v_str21"); //ASTSTD,  *규격*/    
				String  str22	= reqGauce.getParameter("v_str22"); //ASTAQAMT,*취득금액*/
				String  str23   = reqGauce.getParameter("v_str23"); //ASTYUSE, *내용년수*/
				String  str24	= reqGauce.getParameter("v_str24"); //ASTVALYMD*평가일자*/
				String  str25	= reqGauce.getParameter("v_str25"); //MNGDPT,  *관리부서*/
				String  str26   = reqGauce.getParameter("v_str26"); //USEDPT,  *사용부서*/
				String  str27	= reqGauce.getParameter("v_str27"); //USELOC,  *설치장소*/
				String  str28	= reqGauce.getParameter("v_str28"); //BUYFROM, *구입처*/  
				String  str29	= reqGauce.getParameter("v_str29"); //MAKER,   *제작처*/  
				String  str30	= reqGauce.getParameter("v_str30"); //ASTNOTE  *비고*/    
				String  str31	= reqGauce.getParameter("v_str31"); //일련번호 
				String  str33	= reqGauce.getParameter("v_str33"); //일련번호 


				String  IsUpdated	= reqGauce.getParameter("IsUpdated"); 

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE       = userSet.indexOfColumn("FDCODE");   
				int idxATCODE       = userSet.indexOfColumn("ATCODE");   
				int idxAST1ST       = userSet.indexOfColumn("AST1ST");   
				int idxAST2ND       = userSet.indexOfColumn("AST2ND");   
				int idxAST3RD       = userSet.indexOfColumn("AST3RD");   
				int idxASTSEQ       = userSet.indexOfColumn("ASTSEQ");   
				int idxMNGTYPE      = userSet.indexOfColumn("MNGTYPE");  
				int idxASTSTAT  	= userSet.indexOfColumn("ASTSTAT");  
				int idxASCOSDIV 	= userSet.indexOfColumn("ASCOSDIV"); 
				int idxCOSTCD   	= userSet.indexOfColumn("COSTCD");   
				int idxASAQSDIV 	= userSet.indexOfColumn("ASAQSDIV"); 
				int idxGODDIV   	= userSet.indexOfColumn("GODDIV");   
				int idxASTCLASS 	= userSet.indexOfColumn("ASTCLASS"); 
				int idxASTRIS   	= userSet.indexOfColumn("ASTRIS");   
				int idxASTUNIT  	= userSet.indexOfColumn("ASTUNIT");  
				int idxASTQTY   	= userSet.indexOfColumn("ASTQTY");   
				int idxASTSTD   	= userSet.indexOfColumn("ASTSTD");   
				int idxASTAQAMT 	= userSet.indexOfColumn("ASTAQAMT"); 
				int idxASTYUSE  	= userSet.indexOfColumn("ASTYUSE");  
				int idxASTVALYMD	= userSet.indexOfColumn("ASTVALYMD");
				int idxMNGDPT   	= userSet.indexOfColumn("MNGDPT");   
				int idxUSEDPT   	= userSet.indexOfColumn("USEDPT");   
				int idxUSELOC   	= userSet.indexOfColumn("USELOC");   
				int idxBUYFROM  	= userSet.indexOfColumn("BUYFROM");  
				int idxMAKER    	= userSet.indexOfColumn("MAKER");    
				int idxASTNOTE  	= userSet.indexOfColumn("ASTNOTE");	


				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;        
				StringBuffer UpdateSql = null;	                 

				StringBuffer DeleteSql = null;	     

				if(IsUpdated.equals("2")){
				UpdateSql = new StringBuffer();
                UpdateSql.append( " UPDATE ACCOUNT.ASTBASIC  SET   ");
                UpdateSql.append( " ASTSTAT =   '"+str12+"',	    ");	
                UpdateSql.append( " MNGTYPE =  	'"+str11+"',	    ");
                UpdateSql.append( " ASCOSDIV =  '"+str13+"',	    ");
                UpdateSql.append( " COSTCD =    '"+str14+"',       ");             
                UpdateSql.append( " GODDIV =    '"+str16+"',	    ");
                UpdateSql.append( " ASTCLASS =  '"+str17+"',	    ");
                UpdateSql.append( " ASTRIS =    '"+str18+"',	    ");
                UpdateSql.append( " ASTUNIT =   '"+str19+"',	    ");	
                UpdateSql.append( " ASTSTD =   	'"+str21+"',	    ");
                UpdateSql.append( " MNGDPT =    '"+str25+"',	    ");
                UpdateSql.append( " USEDPT =    '"+str26+"',       ");             
                UpdateSql.append( " USELOC =    '"+str27+"',	    ");
                UpdateSql.append( " BUYFROM =   '"+str28+"',	    ");
                UpdateSql.append( " MAKER =     '"+str29+"',	    ");
                UpdateSql.append( " ASAQSDIV =  '"+str15+"',	    ");	
                UpdateSql.append( " ASTNOTE =  	'"+str30+"',	    ");
                UpdateSql.append( " ASTVALYMD = '"+str24+"',	    ");
                UpdateSql.append( " ASTYUSE =   '"+str23+"',      ");             
                UpdateSql.append( " ASTAQAMT =  '"+str22+"',	    ");
                UpdateSql.append( " ASTQTY =    '"+str20+"',	   ");
                UpdateSql.append( " ATCODE =    '"+str5+"',	    ");
                UpdateSql.append( " ASTUSER =    '"+str33+"'	    ");
                UpdateSql.append( " WHERE FDCODE = '"+str1+"'	");   
                UpdateSql.append( " AND AST1ST =  '"+str1+"'	");				
                UpdateSql.append( " AND AST2ND =  '"+str3+"'	");
                UpdateSql.append( " AND AST3RD =  '"+str4+"'	");
                UpdateSql.append( " AND ASTSEQ =  '"+str31+"'	");

			     GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());	
			     gsmt.executeUpdate(); 
			     gsmt.close(); 

                }else if (IsUpdated.equals("3")){

				UpdateSql = new StringBuffer();
                UpdateSql.append( " UPDATE ACCOUNT.ASTBASIC  SET   ");
                UpdateSql.append( " ASTYUSE =   '"+str23+"',      ");             
                UpdateSql.append( " ASTAQAMT =  '"+str22+"'	    ");          
          
                UpdateSql.append( " WHERE FDCODE = '"+str1+"'	");   
                UpdateSql.append( " AND AST1ST =  '"+str1+"'	");				
                UpdateSql.append( " AND AST2ND =  '"+str3+"'	");
                UpdateSql.append( " AND AST3RD =  '"+str4+"'	");
                UpdateSql.append( " AND ASTSEQ =  '"+str31+"'	");

			     GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());	
			     gsmt.executeUpdate(); 
			     gsmt.close(); 


                }else if (IsUpdated.equals("4")){

				UpdateSql = new StringBuffer();
                UpdateSql.append( " UPDATE ACCOUNT.ASTBASIC  SET   ");
                UpdateSql.append( " MNGDPT =   '"+str25+"',      ");             
                UpdateSql.append( " USEDPT =  '"+str26+"'	    ");          
          
                UpdateSql.append( " WHERE FDCODE = '"+str1+"'	");   
                UpdateSql.append( " AND AST1ST =  '"+str1+"'	");				
                UpdateSql.append( " AND AST2ND =  '"+str3+"'	");
                UpdateSql.append( " AND AST3RD =  '"+str4+"'	");
                UpdateSql.append( " AND ASTSEQ =  '"+str31+"'	");

			     GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());	
			     gsmt.executeUpdate(); 
			     gsmt.close(); 
 
                }else if (IsUpdated.equals("1")){
				
				InsertSql = new StringBuffer();

				InsertSql.append( " INSERT INTO ACCOUNT.ASTBASIC (   ");
				InsertSql.append( " MNGTYPE,ASTSTAT,ASCOSDIV,COSTCD,ASAQSDIV,GODDIV,ASTCLASS,ASTRIS,ASTUNIT, ASTQTY,  ");
				InsertSql.append( " ASTSTD,ASTAQAMT,ASTYUSE,MNGDPT,USEDPT,USELOC,BUYFROM,MAKER,ASTNOTE,");
				InsertSql.append( " ATCODE, FDCODE,AST1ST, 	AST2ND,  AST3RD, ASTSEQ,ASTUSER ) ");
				InsertSql.append( "  VALUES ( '" + str11 + "','" + str12 + "','" + str13+ "','" + str14+ "','" + str15+ "','"  + str16+ "','"
								 + str17 + "','" + str18 + "','" + str19+ "','" + str20+ "','" + str21+ "','" 
								 + str22 + "','" + str23 + "','" + str25+ "','" + str26+ "','" 
								 + str27 + "','" + str28 + "','" + str29+ "','" + str30+ "','" 
								 + str5 + "','" + str1+ "','"  
								 + str1 + "','" + str3 + "','" + str4+ "','" 
								 + str31 + "','" + str33+ "' ) ") ;

			    GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());	 			
   			     gsmt.executeUpdate(); 
			     gsmt.close(); 			
				

                }else if (IsUpdated.equals("4")){

				DeleteSql = new StringBuffer();

				DeleteSql.append( " DELETE FROM  ACCOUNT.ASTBASIC   " );
                DeleteSql.append( "  WHERE FDCODE  = '"+str1+"'   " );
				DeleteSql.append( "    AND AST1ST  = '"+str1+"'   " );			
				DeleteSql.append( "    AND AST2ND =  '"+str3+"'   " );
				DeleteSql.append( "    AND AST3RD  = '"+str4+"'   " );
				DeleteSql.append( "    AND ASTSEQ  = '"+str31+"'    " );

								GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());	 			
								 gsmt.executeUpdate(); 
								 gsmt.close();	


             }

///////////////////////////////////////////////////////////////////////
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