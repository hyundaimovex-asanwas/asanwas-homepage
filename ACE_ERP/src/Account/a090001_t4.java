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


				// ������������ ���ǰ��� �Ѱܹ���
			 	String  str1   	= reqGauce.getParameter("v_str1");    //�����ڵ�  �ʼ� 
				String  str2    = reqGauce.getParameter("v_str2");   //�����ڵ�   �ʼ�
				String  str3	    = reqGauce.getParameter("v_str3");   //1����  
				String  str4	    = reqGauce.getParameter("v_str4");   //�ڻ��ߺз�  �ʼ�      
				String  str5    = reqGauce.getParameter("v_str5");   //�ڻ�Һз�  �ʼ�     
				String  str6	   = reqGauce.getParameter("v_str6");    //�Ϸù�ȣ  
				String  str7	   = reqGauce.getParameter("v_str7");     //�����󰢿Ϸᱸ��
				String  str8	    = reqGauce.getParameter("v_str8");    //���ݾ�             
				String  str9    = reqGauce.getParameter("v_str9");    //�������������   
				String  str10	  = reqGauce.getParameter("v_str10");  ///�����󰢿Ϸ���    
				String  str11  	= reqGauce.getParameter("v_str11");  //����󰢴����     
				String  str12   = reqGauce.getParameter("v_str12"); ////���Ⱘ�Ҵ����    
				String  str13  	= reqGauce.getParameter("v_str13");  //������ΰ���        
				String  str14	  = reqGauce.getParameter("v_str14");  ///������������     
				String  str15	  = reqGauce.getParameter("v_str15");  	 //������              
				String  str16	  = reqGauce.getParameter("v_str16");  	//��Ⱘ���󰢺��Ѿ�
				String  str17	  = reqGauce.getParameter("v_str17");  	//��Ⱘ�Ҵ����      
				String  str18	  = reqGauce.getParameter("v_str18");  	 //��������             

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