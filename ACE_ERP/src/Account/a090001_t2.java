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


				// ������������ ���ǰ��� �Ѱܹ���
				String  str1	= reqGauce.getParameter("v_str1");    //�����ڵ�  �ʼ�   
				String  str2    = reqGauce.getParameter("v_str2");   //�ڻ��       
				String  str3	= reqGauce.getParameter("v_str3");   //�ڻ��ߺз�  �ʼ�    
				String  str4	= reqGauce.getParameter("v_str4");   //�ڻ�Һз�  �ʼ�    
				String  str5    = reqGauce.getParameter("v_str5");    //�����ڵ�   �ʼ�  
				String  str6	= reqGauce.getParameter("v_str6");   //������� 	       
				String  str7	= reqGauce.getParameter("v_str7");   //��꼭��ȣ    
				String  str8	= reqGauce.getParameter("v_str8");   //ȸ��������ȣ  
				String  str9    = reqGauce.getParameter("v_str9");   //���μ�          
				String  str10	= reqGauce.getParameter("v_str10");  //�����*/            
				String  str11	= reqGauce.getParameter("v_str11"); //MNGTYPE, *��������*/ 
				String  str12   = reqGauce.getParameter("v_str12"); //ASTSTAT, *�����ڵ�*/
				String  str13	= reqGauce.getParameter("v_str13"); //ASCOSDIV,*�����������
				String  str14	= reqGauce.getParameter("v_str14"); //COSTCD,  *�����ڵ�*/
				String  str15	= reqGauce.getParameter("v_str15"); //ASAQSDIV,*��汸��*/
				String  str16   = reqGauce.getParameter("v_str16"); //GODDIV,  *�ڻ걸��*/
				String  str17	= reqGauce.getParameter("v_str17"); //ASTCLASS,*�ڻ���*/
				String  str18	= reqGauce.getParameter("v_str18"); //ASTRIS,  *��������*/
				String  str19   = reqGauce.getParameter("v_str19"); //ASTUNIT, *����*/    
				String  str20	= reqGauce.getParameter("v_str20"); //ASTQTY,  *����*/    
				String  str21	= reqGauce.getParameter("v_str21"); //ASTSTD,  *�԰�*/    
				String  str22	= reqGauce.getParameter("v_str22"); //ASTAQAMT,*���ݾ�*/
				String  str23   = reqGauce.getParameter("v_str23"); //ASTYUSE, *������*/
				String  str24	= reqGauce.getParameter("v_str24"); //ASTVALYMD*������*/
				String  str25	= reqGauce.getParameter("v_str25"); //MNGDPT,  *�����μ�*/
				String  str26   = reqGauce.getParameter("v_str26"); //USEDPT,  *���μ�*/
				String  str27	= reqGauce.getParameter("v_str27"); //USELOC,  *��ġ���*/
				String  str28	= reqGauce.getParameter("v_str28"); //BUYFROM, *����ó*/  
				String  str29	= reqGauce.getParameter("v_str29"); //MAKER,   *����ó*/  
				String  str30	= reqGauce.getParameter("v_str30"); //ASTNOTE  *���*/    
				String  str31	= reqGauce.getParameter("v_str31"); //�Ϸù�ȣ 
				String  str33	= reqGauce.getParameter("v_str33"); //�Ϸù�ȣ 


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