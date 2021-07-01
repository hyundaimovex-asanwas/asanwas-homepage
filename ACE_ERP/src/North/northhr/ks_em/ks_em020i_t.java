package North.northhr.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class ks_em020i_t extends HttpServlet{

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
				conn.setAutoCommit(false);

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				String strEMPNO = reqGauce.getParameter("v_str2");				

				String[] strArrCN = new String[]{ 	                                                 
									"WORK_GB", "WKTM_GB1","USE_YN1","STDT_GB1" ,"START_DT1","EDDT_GB1","END_DT1","T_UNIT1","STPE_TM1","EDPE_TM1",
													  "WKTM_GB2","USE_YN2","STDT_GB2" ,"START_DT2","EDDT_GB2","END_DT2","T_UNIT2","STPE_TM2","EDPE_TM2",
													  "WKTM_GB3","USE_YN3","STDT_GB3" ,"START_DT3","EDDT_GB3","END_DT3","T_UNIT3","STPE_TM3","EDPE_TM3",
													  "WKTM_GB4","USE_YN4","STDT_GB4" ,"START_DT4","EDDT_GB4","END_DT4","T_UNIT4","STPE_TM4","EDPE_TM4",
													  "DEDU_YN", "RETM1_FR", "RETM1_TO",  "RETM2_FR", "RETM2_TO",  "EMPNO"
																			  };

				int[] idx = new int[43]; //컬럼갯수를 넣어준다.

				for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}
				

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;

				/******************************** **********************************************
				* INSERT 처리
				*********************************************************************************/
		int temp =0;
		int i=0;
		for (int j = 0; j < rows.length; j++){
			
			rows[j].setString(idx[42], strEMPNO);
						
			if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					
					
				for (i=1;i<=4;i++ ){
					if (i==1) temp=0;
					else if(i>=2)temp+=9;
			

						InsertSql = new StringBuffer();
						InsertSql.append( "INSERT INTO SALES.KST110 ( ");														
						InsertSql.append( "USE_YN, ");
						InsertSql.append( "STDT_GB,");
						InsertSql.append( "START_DT,");
						InsertSql.append( "EDDT_GB,");
						InsertSql.append( "END_DT,");
						InsertSql.append( "T_UNIT,");
						InsertSql.append( "STPE_TM,");
						InsertSql.append( "EDPE_TM,");
						InsertSql.append( "WKTM_GB,");
						InsertSql.append( "WORK_GB,  ");
						InsertSql.append( "I_EMPNO  ,");
						
						InsertSql.append( "I_DATE  ");
						InsertSql.append( ") VALUES( ");
						InsertSql.append( "?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT TIMESTAMP)" );



						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						logger.dbg.println(this,InsertSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
			
						gsmt.bindColumn(1, idx[temp+2]);  
						gsmt.bindColumn(2, idx[temp+3]); 	
						gsmt.bindColumn(3, idx[temp+4]);  
						gsmt.bindColumn(4, idx[temp+5]);
						gsmt.bindColumn(5, idx[temp+6]);
						gsmt.bindColumn(6, idx[temp+7]);
						gsmt.bindColumn(7, idx[temp+8]);
						gsmt.bindColumn(8, idx[temp+9]);
						gsmt.bindColumn(9, idx[temp+1]);
						gsmt.bindColumn(10,idx[0]);
		 		   		gsmt.bindColumn(11,idx[42]);

						gsmt.executeUpdate(); 
						gsmt.close();
				

		  	}	
			
	 		InsertSql = new StringBuffer();
			InsertSql.append(" INSERT INTO SALES.KST120 ( ");
			InsertSql.append( "WORK_GB,DEDU_YN ,RETM1_FR, RETM1_TO, RETM2_FR ,RETM2_TO,I_EMPNO,I_DATE ");
			InsertSql.append( ") VALUES( " );
			InsertSql.append( "?, ?, ?, ?, ?, ?, ?, CURRENT TIMESTAMP) " );
            

       
			GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
			logger.dbg.println(this,InsertSql.toString());
			gsmt.setGauceDataRow(rows[j]);
			
			gsmt.bindColumn(1,  idx[0]);	
			gsmt.bindColumn(2,  idx[37]);	
			gsmt.bindColumn(3,  idx[38]);	
			gsmt.bindColumn(4,  idx[39]);	
			gsmt.bindColumn(5,  idx[40]);	
			gsmt.bindColumn(6,  idx[41]);	
			gsmt.bindColumn(7,  idx[42]); 
				
			gsmt.executeUpdate();
			gsmt.close();
			
			
			
			}    
		}

				/*******************************************************************************
				* UPDATE 처리
				*********************************************************************************/
		
		for (int j = 0; j < rows.length; j++){
			if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
				 for (i=1;i<=4;i++ ){
					if (i==1) temp=0;
					else if(i>=2)temp+=9;
	
						
					UpdateSql = new StringBuffer();
					UpdateSql.append( "UPDATE SALES.KST110 SET " );
					UpdateSql.append( "USE_YN=?, ");
					UpdateSql.append( "STDT_GB=?, ");
					UpdateSql.append( "START_DT=?, ");
					UpdateSql.append( "EDDT_GB=?, ");
					UpdateSql.append( "END_DT =?, ");
					UpdateSql.append( "T_UNIT=?, ");
					UpdateSql.append( "STPE_TM =?, ");
					UpdateSql.append( "EDPE_TM=?, ");
					UpdateSql.append( "U_EMPNO=?, ");
					UpdateSql.append( "U_DATE= CURRENT TIMESTAMP");
	
					UpdateSql.append( " WHERE WKTM_GB=? ");
				    UpdateSql.append( " AND WORK_GB = ? " );	
					
					GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
		//			logger.dbg.println(this,UpdateSql.toString());
						
			
			
					gsmt.setGauceDataRow(rows[j]);
	           
					gsmt.bindColumn(1, idx[temp+2]);   
					gsmt.bindColumn(2, idx[temp+3]);   	
					gsmt.bindColumn(3, idx[temp+4]);   
					gsmt.bindColumn(4, idx[temp+5]); 
					gsmt.bindColumn(5, idx[temp+6]);   
					gsmt.bindColumn(6, idx[temp+7]); 
					gsmt.bindColumn(7, idx[temp+8]);   
					gsmt.bindColumn(8, idx[temp+9]); 
					gsmt.bindColumn(9, idx[42]); 
					gsmt.bindColumn(10, idx[temp+1]);
					gsmt.bindColumn(11,idx[0]); 				
					gsmt.executeUpdate(); 
					gsmt.close();			
			
		 		 }

			UpdateSql = new StringBuffer();
			UpdateSql.append( "UPDATE SALES.KST120 SET ");
			UpdateSql.append( "DEDU_YN  =?, ");
			UpdateSql.append( "RETM1_FR =?, ");
			UpdateSql.append( "RETM1_TO =?, ");
			UpdateSql.append( "RETM2_FR =?, ");
			UpdateSql.append( "RETM2_TO =?, ");
			UpdateSql.append( "U_EMPNO=?, ");
			UpdateSql.append( "U_DATE= CURRENT TIMESTAMP ");
			UpdateSql.append( "WHERE WORK_GB = ? " );
			
			

			GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
			gsmt.setGauceDataRow(rows[j]);
	
			gsmt.bindColumn(1,  idx[37]);	
			gsmt.bindColumn(2,  idx[38]);	
			gsmt.bindColumn(3,  idx[39]);	
			gsmt.bindColumn(4,  idx[40]);	
			gsmt.bindColumn(5,  idx[41]);	
			gsmt.bindColumn(6,  idx[42]); 
			gsmt.bindColumn(7,  idx[0]);			
										   											   
			gsmt.executeUpdate(); 
			gsmt.close();
       
			}    
		}
	}
			catch(Exception e){
				conn.rollback();				
				logger.err.println(this,e.getMessage());					
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