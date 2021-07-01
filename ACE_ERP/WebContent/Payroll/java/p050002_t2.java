package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p050002_t2 extends HttpServlet{

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
						logger.dbg.println(this,"11");

				int idxEMPNO	= userSet.indexOfColumn("EMPNO");
				int idxAPPYM	= userSet.indexOfColumn("APPYM");
				int idxRESINO	= userSet.indexOfColumn("RESINO");
				int idxGRDCD	= userSet.indexOfColumn("GRDCD");

				int idxSTDAMT	= userSet.indexOfColumn("STDAMT");

				int idxINSAMT	= userSet.indexOfColumn("INSAMT");
				int idxMEDSNO	= userSet.indexOfColumn("MEDSNO");
				int idxGETDT	= userSet.indexOfColumn("GETDT");
				int idxLOSDT	= userSet.indexOfColumn("LOSDT");
				int idxREPDT	= userSet.indexOfColumn("REPDT");
						logger.dbg.println(this,"11");

				GauceDataRow[] rows = userSet.getDataRows();
//CREATE TABLE PWINDIPN_H (			
//APPYM	CHAR(6)	NOT NULL,	/*  ������*/
//RESINO	CHAR(13)	NOT NULL,	/* �ֹι�ȣ*/
//EMPNO	CHAR(7) 	NOT NULL,	/*  ���*/
//STDAMT	NUMERIC(9, 0)	DEFAULT 0,	/*  �ҵ����*/
//GRDCD	NUMERIC(3, 0)	DEFAULT 0,	/*  ������*/
//INSGETCOD	CHAR(1)	,	/*  ����ȣ*/
//INSREDCOD	CHAR(2)	,	/*  �����ȣ*/
//JANGREF	CHAR(1)	,	/*  ���������*/
//BUYANG	NUMERIC(2, 0)	DEFAULT 0,	/*  �Ǻξ��ڼ�*/
//INSAMT	NUMERIC(9, 0)	DEFAULT 0,	/*  �������*/
//MEDSNO	VARCHAR(20)	,	/*  �����ȣ*/
//GETDT	CHAR(8)	,	/*  �������*/
//LOSDT	CHAR(8)	,	/*  �������*/
//REPDT	CHAR(8)	,	/*  �Ű�����*/

				/*Statement stmt2 = conn.createStatement();
				String sql2 = " SELECT MAX(ZIPSEQ) + 1 ZIPSEQ FROM PAYROLL.HCPOSTNO ";
				ResultSet rs2 = stmt2.executeQuery(sql2);

				int dbl_zipseq = 0;
				if(rs2.next()){ 
					dbl_zipseq = rs2.getInt(1);
				}*/

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

						logger.dbg.println(this,"11");



				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						logger.dbg.println(this,"12");
						InsertSql = new StringBuffer();
						InsertSql.append( "INSERT INTO PAYROLL.PWINDIPN_Y ( " );
						InsertSql.append( "EMPNO,APPYM,GRDCD,RESINO,STDAMT, INSAMT,MEDSNO,GETDT,LOSDT,REPDT " );
						InsertSql.append( ") VALUES( " );
						InsertSql.append( " ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) " );

						logger.dbg.println(this,InsertSql.toString());
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());

						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxEMPNO);	   	
						gsmt.bindColumn(2, idxAPPYM);	   		
						gsmt.bindColumn(3, idxGRDCD);	   		
						gsmt.bindColumn(4, idxRESINO);	   		
						gsmt.bindColumn(5, idxSTDAMT);
						gsmt.bindColumn(6, idxINSAMT);		   	
						gsmt.bindColumn(7, idxMEDSNO);	   		
						gsmt.bindColumn(8, idxGETDT);
						gsmt.bindColumn(9, idxLOSDT);	   		
						gsmt.bindColumn(10, idxREPDT);
						gsmt.executeUpdate();
						gsmt.close();
						InsertSql=null;
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						logger.dbg.println(this,"13");
						UpdateSql = new StringBuffer();
						UpdateSql.append( "UPDATE PAYROLL.PWINDIPN_Y SET  " );  
						UpdateSql.append( " GRDCD	= ?, " );
						UpdateSql.append( " STDAMT	= ?, " );
						UpdateSql.append( " INSAMT	= ?, " );
						UpdateSql.append( " MEDSNO	= ?, " );
						UpdateSql.append( " GETDT	= ?, " );
						UpdateSql.append( " LOSDT	= ?, " );
						UpdateSql.append( " REPDT	= ?  " );
						UpdateSql.append( "  WHERE EMPNO = ? " );
						UpdateSql.append( " AND APPYM = ? " );
						UpdateSql.append( " AND RESINO = ? " );
						logger.dbg.println(this,UpdateSql.toString());
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxGRDCD);
						gsmt.bindColumn(2, idxSTDAMT);
						gsmt.bindColumn(3, idxINSAMT);
						gsmt.bindColumn(4, idxMEDSNO);
						gsmt.bindColumn(5, idxGETDT);
						gsmt.bindColumn(6, idxLOSDT);
						gsmt.bindColumn(7, idxREPDT);
						gsmt.bindColumn(8, idxEMPNO);
						gsmt.bindColumn(9, idxAPPYM);
						gsmt.bindColumn(10, idxRESINO);
						logger.dbg.println(this,"13");

						gsmt.executeUpdate(); 
						gsmt.close(); 
						UpdateSql=null;
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						DeleteSql.append( "DELETE FROM PAYROLL.PWINDIPN_Y WHERE EMPNO = ? AND APPYM	= ? AND RESINO	= ? " );

						logger.dbg.println(this,"DeleteSql :"+ DeleteSql.toString());
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						logger.dbg.println(this,DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxEMPNO);
						gsmt.bindColumn(2, idxAPPYM);
						gsmt.bindColumn(3, idxRESINO);
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