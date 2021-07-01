package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010010_t1 extends HttpServlet{
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
				conn.setAutoCommit(false);


				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				String str1 = reqGauce.getParameter("v_str1"); //userid

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxPGMID  	= userSet.indexOfColumn("PGMID");                    
				int idxRPGMID 	= userSet.indexOfColumn("RPGMID");									
				int idxEMPNO  	= userSet.indexOfColumn("EMPNO");										
				int idxAUTHGR 	= userSet.indexOfColumn("AUTHGR");									
				int idxDEPTCD1	= userSet.indexOfColumn("DEPTCD1");									
				int idxDEPTCD2	= userSet.indexOfColumn("DEPTCD2");									
				int idxDEPTCD3	= userSet.indexOfColumn("DEPTCD3");									
				int idxDEPTCD4	= userSet.indexOfColumn("DEPTCD4");									
				int idxDEPTCD5	= userSet.indexOfColumn("DEPTCD5");									
				int idxDEPTCD6	= userSet.indexOfColumn("DEPTCD6");									
				int idxDEPTCD7	= userSet.indexOfColumn("DEPTCD7");									
				int idxDEPTCD8	= userSet.indexOfColumn("DEPTCD8");									
				int idxDEPTCD9	= userSet.indexOfColumn("DEPTCD9");		
				int idxDEPTCD10	= userSet.indexOfColumn("DEPTCD10");		
				int idxDEPTCD11	= userSet.indexOfColumn("DEPTCD11");
				int idxDEPTCD12	= userSet.indexOfColumn("DEPTCD12");
				int idxDEPTCD13	= userSet.indexOfColumn("DEPTCD13");
				int idxDEPTCD14	= userSet.indexOfColumn("DEPTCD14");
				int idxDEPTCD15	= userSet.indexOfColumn("DEPTCD15");
				int idxDEPTCD16	= userSet.indexOfColumn("DEPTCD16");
				int idxDEPTCD17	= userSet.indexOfColumn("DEPTCD17");
				int idxDEPTCD18	= userSet.indexOfColumn("DEPTCD18");
				int idxDEPTCD19	= userSet.indexOfColumn("DEPTCD19");
				int idxDEPTCD20	= userSet.indexOfColumn("DEPTCD20");				
				int idxPEMPNO1	= userSet.indexOfColumn("PEMPNO1");									
				int idxPEMPNO2	= userSet.indexOfColumn("PEMPNO2");									
				int idxPEMPNO3	= userSet.indexOfColumn("PEMPNO3");									
				int idxPEMPNO4	= userSet.indexOfColumn("PEMPNO4");									
				int idxPEMPNO5	= userSet.indexOfColumn("PEMPNO5");									
				int idxETC1   	= userSet.indexOfColumn("ETC1");										
				int idxETC2   	= userSet.indexOfColumn("ETC2");										
				int idxETC3   	= userSet.indexOfColumn("ETC3");										
				int idxETC4   	= userSet.indexOfColumn("ETC4");										
				int idxETC5   	= userSet.indexOfColumn("ETC5");										
				int idxUSEYN  	= userSet.indexOfColumn("USEYN");										
													   																								
																																						
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.ACCAUTH ( 														\n");
				InsertSql.append( " PGMID,	  RPGMID,	  EMPNO,	  AUTHGR,	           								\n");
				InsertSql.append( " DEPTCD1,	DEPTCD2,	DEPTCD3,	DEPTCD4,	DEPTCD5, 						\n");
				InsertSql.append( " DEPTCD6,	DEPTCD7,	DEPTCD8,	DEPTCD9,	         							\n");
				InsertSql.append( " DEPTCD10,	DEPTCD11,	DEPTCD12,	DEPTCD13, DEPTCD14,					\n");
				InsertSql.append( " DEPTCD15,	DEPTCD16,	DEPTCD17,	DEPTCD18, DEPTCD19,					\n");
				InsertSql.append( " DEPTCD20,                                        												\n");
				InsertSql.append( " PEMPNO1,	PEMPNO2,	PEMPNO3,	PEMPNO4,	PEMPNO5, 					\n");
				InsertSql.append( " ETC1,	    ETC2,	    ETC3,	    ETC4,	    ETC5,	   							\n");
				InsertSql.append( " USEYN,    I_EMPNO,  I_DATE                       										\n");
				InsertSql.append( "	) VALUES( 																						\n");
				InsertSql.append( " ?, ?, ?, ?, 																						\n");
				InsertSql.append( " ?, ?, ?, ?, ?, 																					\n");
				InsertSql.append( " ?, ?, ?, ?, 																						\n");
				InsertSql.append( " ?, ?, ?, ?, ?,																						\n");
				InsertSql.append( " ?, ?, ?, ?, ?, 																					\n");
				InsertSql.append( " ?, 																									\n");
				InsertSql.append( " ?, ?, ?, ?, ?, 																					\n");
				InsertSql.append( " ?, ?, ?, ?, ?, 																					\n");
				InsertSql.append( " ?, '"+str1+"', sysdate ) 																		\n");

				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE ACCOUNT.ACCAUTH SET 		\n");
				UpdateSql.append( " AUTHGR=?,  									\n");
				UpdateSql.append( " DEPTCD1=?, 									\n");
				UpdateSql.append( " DEPTCD2=?, 									\n");
				UpdateSql.append( " DEPTCD3=?, 									\n");
				UpdateSql.append( " DEPTCD4=?, 									\n");
				UpdateSql.append( " DEPTCD5=?, 									\n");
				UpdateSql.append( " DEPTCD6=?, 									\n");
				UpdateSql.append( " DEPTCD7=?, 									\n");
				UpdateSql.append( " DEPTCD8=?, 									\n");
				UpdateSql.append( " DEPTCD9=?, 									\n");
				UpdateSql.append( " DEPTCD10=?,									\n");
				UpdateSql.append( " DEPTCD11=?,									\n");
				UpdateSql.append( " DEPTCD12=?,									\n");
				UpdateSql.append( " DEPTCD13=?,									\n");
				UpdateSql.append( " DEPTCD14=?,									\n");
				UpdateSql.append( " DEPTCD15=?,									\n");
				UpdateSql.append( " DEPTCD16=?,									\n");
				UpdateSql.append( " DEPTCD17=?,									\n");
				UpdateSql.append( " DEPTCD18=?,									\n");
				UpdateSql.append( " DEPTCD19=?,									\n");
				UpdateSql.append( " DEPTCD20=?,									\n");
				UpdateSql.append( " PEMPNO1=?, 									\n");
				UpdateSql.append( " PEMPNO2=?, 									\n");
				UpdateSql.append( " PEMPNO3=?, 									\n");
				UpdateSql.append( " PEMPNO4=?, 									\n");
				UpdateSql.append( " PEMPNO5=?, 									\n");
				UpdateSql.append( " ETC1=?,    										\n");
				UpdateSql.append( " ETC2=?,    										\n");
				UpdateSql.append( " ETC3=?,    										\n");
				UpdateSql.append( " ETC4=?,    										\n");
				UpdateSql.append( " ETC5=?,    										\n");
				UpdateSql.append( " USEYN=?,  										\n");		
				UpdateSql.append( " U_EMPNO = '"+str1+"', 						\n");
				UpdateSql.append( " U_DATE	= sysdate 							\n");
				UpdateSql.append( " WHERE PGMID=?  							\n");
				UpdateSql.append( "   AND RPGMID=? 							\n");
				UpdateSql.append( "   AND EMPNO=?  							\n");
				

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM ACCOUNT.ACCAUTH  	\n");
				DeleteSql.append( " WHERE PGMID=?  							\n");
				DeleteSql.append( "   AND RPGMID=? 								\n");
				DeleteSql.append( "   AND EMPNO=?  								\n");

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
				

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
					
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,idxPGMID);			
						gsmt.bindColumn(2,idxRPGMID);	
						gsmt.bindColumn(3,idxEMPNO);	
						gsmt.bindColumn(4,idxAUTHGR);
						gsmt.bindColumn(5,idxDEPTCD1);		
						gsmt.bindColumn(6,idxDEPTCD2);		
						gsmt.bindColumn(7,idxDEPTCD3);	
						gsmt.bindColumn(8,idxDEPTCD4);
						gsmt.bindColumn(9,idxDEPTCD5);		
						gsmt.bindColumn(10,idxDEPTCD6);
						gsmt.bindColumn(11,idxDEPTCD7);			
						gsmt.bindColumn(12,idxDEPTCD8);	
						gsmt.bindColumn(13,idxDEPTCD9);	
						gsmt.bindColumn(14,idxDEPTCD10);	
						gsmt.bindColumn(15,idxDEPTCD11);	
						gsmt.bindColumn(16,idxDEPTCD12);	
						gsmt.bindColumn(17,idxDEPTCD13);	
						gsmt.bindColumn(18,idxDEPTCD14);	
						gsmt.bindColumn(19,idxDEPTCD15);	
						gsmt.bindColumn(20,idxDEPTCD16);	
						gsmt.bindColumn(21,idxDEPTCD17);	
						gsmt.bindColumn(22,idxDEPTCD18);	
						gsmt.bindColumn(23,idxDEPTCD19);
						gsmt.bindColumn(24,idxDEPTCD20); 
						gsmt.bindColumn(25,idxPEMPNO1);
						gsmt.bindColumn(26,idxPEMPNO2);		
						gsmt.bindColumn(27,idxPEMPNO3);		
						gsmt.bindColumn(28,idxPEMPNO4);	
						gsmt.bindColumn(29,idxPEMPNO5);
						gsmt.bindColumn(30,idxETC1);		
						gsmt.bindColumn(31,idxETC2);
						gsmt.bindColumn(32,idxETC3);			
						gsmt.bindColumn(33,idxETC4);	
						gsmt.bindColumn(34,idxETC5);	
						gsmt.bindColumn(35,idxUSEYN);
						
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,idxAUTHGR);			
						gsmt.bindColumn(2,idxDEPTCD1);	
						gsmt.bindColumn(3,idxDEPTCD2);	
						gsmt.bindColumn(4,idxDEPTCD3);
						gsmt.bindColumn(5,idxDEPTCD4);		
						gsmt.bindColumn(6,idxDEPTCD5);		
						gsmt.bindColumn(7,idxDEPTCD6);	
						gsmt.bindColumn(8,idxDEPTCD7);
						gsmt.bindColumn(9,idxDEPTCD8);		
						gsmt.bindColumn(10,idxDEPTCD9);	
						gsmt.bindColumn(11,idxDEPTCD10);	
						gsmt.bindColumn(12,idxDEPTCD11);	
						gsmt.bindColumn(13,idxDEPTCD12);	
						gsmt.bindColumn(14,idxDEPTCD13);	
						gsmt.bindColumn(15,idxDEPTCD14);	
						gsmt.bindColumn(16,idxDEPTCD15);	
						gsmt.bindColumn(17,idxDEPTCD16);	
						gsmt.bindColumn(18,idxDEPTCD17);	
						gsmt.bindColumn(19,idxDEPTCD18);	
						gsmt.bindColumn(20,idxDEPTCD19);	
						gsmt.bindColumn(21,idxDEPTCD20);					
						gsmt.bindColumn(22,idxPEMPNO1);	
						gsmt.bindColumn(23,idxPEMPNO2);		
						gsmt.bindColumn(24,idxPEMPNO3);		
						gsmt.bindColumn(25,idxPEMPNO4);				
						gsmt.bindColumn(26,idxPEMPNO5);	
						gsmt.bindColumn(27,idxETC1);		
						gsmt.bindColumn(28,idxETC2);		
						gsmt.bindColumn(29,idxETC3);				
						gsmt.bindColumn(30,idxETC4);	
						gsmt.bindColumn(31,idxETC5);	
						gsmt.bindColumn(32,idxUSEYN);
						gsmt.bindColumn(33,idxPGMID);			
						gsmt.bindColumn(34,idxRPGMID);	
						gsmt.bindColumn(35,idxEMPNO);	
	
		
						gsmt.executeUpdate(); 
						gsmt.close();        
					}
						if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,idxPGMID);			
						gsmt.bindColumn(2,idxRPGMID);	
						gsmt.bindColumn(3,idxEMPNO);	
						gsmt.executeUpdate(); 
						gsmt.close();        
					}    					
						
				}
			}
			catch(Exception e){
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}
      
			conn.commit();
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