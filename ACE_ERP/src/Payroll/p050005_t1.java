package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p050005_t1 extends HttpServlet{

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

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxEMPNO	= userSet.indexOfColumn("EMPNO");			//���
				int idxFRDT	= userSet.indexOfColumn("FRDT");				//������
				int idxTODT	= userSet.indexOfColumn("TODT");				//������
				int idxDIV	= userSet.indexOfColumn("DIV");					//���������ڵ�
				int idxINSUR	= userSet.indexOfColumn("INSUR");			//���κδ�
				int idxTOTDAY	= userSet.indexOfColumn("TOTDAY");		//ȸ������
				int idxTOTCNT	= userSet.indexOfColumn("TOTCNT");		//������
				int idxPERAMT	= userSet.indexOfColumn("PERAMT");		//������
				int idxSUPAMT	= userSet.indexOfColumn("SUPAMT");		//���������ڵ�
				int idxTOTAMT	= userSet.indexOfColumn("TOTAMT");		//���κδ�
				int idxLASTMON	= userSet.indexOfColumn("LASTMON"); //ȸ������

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						InsertSql = new StringBuffer();
						InsertSql.append( "INSERT INTO PAYROLL.PWINDPEN ( " );
						InsertSql.append( "EMPNO,FRDT,TODT,DIV,INSUR,TOTDAY,TOTCNT,PERAMT,SUPAMT,TOTAMT,LASTMON " );
						InsertSql.append( ") VALUES( " );
						InsertSql.append( " ?,?,?,?,?, ?,?,?,?,?,?) " );

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxEMPNO);	   	
						gsmt.bindColumn(2, idxFRDT);	   		
						gsmt.bindColumn(3, idxTODT);	   		
						gsmt.bindColumn(4, idxDIV);	   		
						gsmt.bindColumn(5, idxINSUR);	   		
						gsmt.bindColumn(6, idxTOTDAY);
						gsmt.bindColumn(7, idxTOTCNT);	   		
						gsmt.bindColumn(8, idxPERAMT);	   		
						gsmt.bindColumn(9, idxSUPAMT);	   		
						gsmt.bindColumn(10, idxTOTAMT);	   		
						gsmt.bindColumn(11, idxLASTMON);
						gsmt.executeUpdate();
						gsmt.close();
						InsertSql=null;
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE PAYROLL.PWINDPEN SET  " );  
						UpdateSql.append( "		TODT	  = ?,							 " );
						UpdateSql.append( "		DIV	    = ?,							 " );
						UpdateSql.append( "		INSUR	  = ?,							 " );
						UpdateSql.append( "		TOTDAY	= ?,							 " );
						UpdateSql.append( "		TOTCNT	= ?,							 " );
						UpdateSql.append( "		PERAMT	= ?,							 " );
						UpdateSql.append( "		SUPAMT	= ?,							 " );
						UpdateSql.append( "		TOTAMT	= ? 							 " );
						UpdateSql.append( " WHERE EMPNO = ? AND FRDT = ? AND LASTMON	= ? " );

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxTODT);	   	
						gsmt.bindColumn(2, idxDIV);	   		
						gsmt.bindColumn(3, idxINSUR);	   		
						gsmt.bindColumn(4, idxTOTDAY);	   		
						gsmt.bindColumn(5, idxTOTCNT);	   		
						gsmt.bindColumn(6, idxPERAMT);
						gsmt.bindColumn(7, idxSUPAMT);	   		
						gsmt.bindColumn(8, idxTOTAMT);	   								
						gsmt.bindColumn(9, idxEMPNO);	   		
						gsmt.bindColumn(10, idxFRDT);
						gsmt.bindColumn(11, idxLASTMON);	   		

						gsmt.executeUpdate(); 
						gsmt.close(); 
						UpdateSql=null;
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						DeleteSql.append( "DELETE FROM PAYROLL.PWINDPEN WHERE EMPNO = ? AND FRDT = ? " );

						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxEMPNO);
						gsmt.bindColumn(2, idxFRDT);
						gsmt.executeUpdate();
						gsmt.close();
						DeleteSql=null;
					}
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