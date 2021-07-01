package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h060020_t1 extends HttpServlet{

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
				String strCnt ="0";

        //************************************************************************************************
        //업적신고서 MST
        //************************************************************************************************
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");        
        int idxEVAYM		= userSet.indexOfColumn("EVAYM");
				int idxEMPNO		= userSet.indexOfColumn("EMPNO");
				int idxHEADCD	  = userSet.indexOfColumn("HEADCD");
				int idxDIVCD	  = userSet.indexOfColumn("DIVCD");
				int idxDEPTCD		= userSet.indexOfColumn("DEPTCD");
				int idxPAYGRD 	= userSet.indexOfColumn("PAYGRD");
				int idxWORK_1 	= userSet.indexOfColumn("WORK_1");
				int idxSTARTDT_1= userSet.indexOfColumn("STARTDT_1");
				int idxENDDT_1 	= userSet.indexOfColumn("ENDDT_1");
				int idxPLACE_1 	= userSet.indexOfColumn("PLACE_1");
				int idxREMARK_1 = userSet.indexOfColumn("REMARK_1");
				int idxWORK_2 	= userSet.indexOfColumn("WORK_2");
				int idxSTARTDT_2= userSet.indexOfColumn("STARTDT_2");
				int idxENDDT_2 	= userSet.indexOfColumn("ENDDT_2");
				int idxPLACE_2 	= userSet.indexOfColumn("PLACE_2");
				int idxREMARK_2 = userSet.indexOfColumn("REMARK_2");
				int idxWORK_3 	= userSet.indexOfColumn("WORK_3");
				int idxSTARTDT_3= userSet.indexOfColumn("STARTDT_3");
				int idxENDDT_3 	= userSet.indexOfColumn("ENDDT_3");
				int idxPLACE_3 	= userSet.indexOfColumn("PLACE_3");
				int idxREMARK_3 = userSet.indexOfColumn("REMARK_3");
				int idxWRDT   	= userSet.indexOfColumn("WRDT");
				int idxWRID 		= userSet.indexOfColumn("WRID");		
				int idxUPDT			= userSet.indexOfColumn("UPDT");	
				int idxUPID			= userSet.indexOfColumn("UPID");	

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
			  StringBuffer InsertSql = null;
        
				InsertSql = new StringBuffer();
				InsertSql.append( "INSERT INTO PAYROLL.HWORKMST ( " );
				InsertSql.append( "EVAYM,	EMPNO,	HEADCD,	DIVCD,	DEPTCD, PAYGRD, " );
				InsertSql.append( "WORK_1,	STARTDT_1,	ENDDT_1,	PLACE_1,	REMARK_1, " );
				InsertSql.append( "WORK_2,	STARTDT_2,	ENDDT_2,	PLACE_2,	REMARK_2, " );
				InsertSql.append( "WORK_3,	STARTDT_3,	ENDDT_3,	PLACE_3,	REMARK_3, " );
				InsertSql.append( "WRDT,	WRID,	  UPDT,	  UPID " );
				InsertSql.append( ") VALUES( " );
				InsertSql.append( "?, ?, ?, ?, ?, ?,");
				InsertSql.append( "?, ?, ?, ?, ?,");
				InsertSql.append( "?, ?, ?, ?, ?,");
				InsertSql.append( "?, ?, ?, ?, ?,");
				InsertSql.append( "?, ?, ?, ? ) " );
        
				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.HWORKMST SET " );
        UpdateSql.append( " HEADCD = ?, " );
				UpdateSql.append( " DIVCD = ?, " );
				UpdateSql.append( " DEPTCD = ?, " );
				UpdateSql.append( " PAYGRD = ?, " );
				UpdateSql.append( " WORK_1 = ?, " );
				UpdateSql.append( " STARTDT_1 = ?, " );
				UpdateSql.append( " ENDDT_1 = ?, " );
				UpdateSql.append( " PLACE_1 = ?, " );
				UpdateSql.append( " REMARK_1 = ?, " );
				UpdateSql.append( " WORK_2 = ?, " );
				UpdateSql.append( " STARTDT_2 = ?, " );
				UpdateSql.append( " ENDDT_2 = ?, " );
				UpdateSql.append( " PLACE_2 = ?, " );
				UpdateSql.append( " REMARK_2 = ?, " );
				UpdateSql.append( " WORK_3 = ?, " );
				UpdateSql.append( " STARTDT_3 = ?, " );
				UpdateSql.append( " ENDDT_3 = ?, " );
				UpdateSql.append( " PLACE_3 = ?, " );
				UpdateSql.append( " REMARK_3 = ?, " );
				UpdateSql.append( " UPDT = ?, " );
				UpdateSql.append( " UPID = ? " );
				UpdateSql.append( " WHERE EVAYM = ? AND EMPNO = ? " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.HWORKMST WHERE  EVAYM = ? AND EMPNO = ?  " );
				
				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						
						Statement stmt = conn.createStatement();
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT COUNT(*) AS CNT ");
						sql.append( "	  FROM PAYROLL.HWORKMST "); 
						sql.append( "	 WHERE EVAYM='"+rows[j].getString(idxEVAYM)+"'");
						sql.append( "	   AND EMPNO='"+rows[j].getString(idxEMPNO)+"'"); 
						
						ResultSet rs = stmt.executeQuery(sql.toString()); 
						if(rs.next()){
							 strCnt= rs.getString(1);
						}
						rs.close();
						stmt.close();		

            if(strCnt.equals("0")){
							GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows[j]);
							
							gsmt.bindColumn(1, idxEVAYM);
							gsmt.bindColumn(2, idxEMPNO);
							gsmt.bindColumn(3, idxHEADCD);
							gsmt.bindColumn(4, idxDIVCD);
							gsmt.bindColumn(5, idxDEPTCD);
							gsmt.bindColumn(6, idxPAYGRD);
							gsmt.bindColumn(7, idxWORK_1);
							gsmt.bindColumn(8, idxSTARTDT_1);
							gsmt.bindColumn(9, idxENDDT_1);
							gsmt.bindColumn(10, idxPLACE_1);
							gsmt.bindColumn(11, idxREMARK_1);
							gsmt.bindColumn(12, idxWORK_2);
							gsmt.bindColumn(13, idxSTARTDT_2);
							gsmt.bindColumn(14, idxENDDT_2);
							gsmt.bindColumn(15, idxPLACE_2);
							gsmt.bindColumn(16, idxREMARK_2);
							gsmt.bindColumn(17, idxWORK_3);
							gsmt.bindColumn(18, idxSTARTDT_3);
							gsmt.bindColumn(19, idxENDDT_3);
							gsmt.bindColumn(20, idxPLACE_3);
							gsmt.bindColumn(21, idxREMARK_3);
							gsmt.bindColumn(22, idxWRDT);
							gsmt.bindColumn(23, idxWRID);
							gsmt.bindColumn(24,idxUPDT);
							gsmt.bindColumn(25,idxUPID);

							gsmt.executeUpdate();
							gsmt.close();
						}else{
							GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						  gsmt.setGauceDataRow(rows[j]);
							gsmt.bindColumn(1, idxHEADCD);
							gsmt.bindColumn(2, idxDIVCD);
							gsmt.bindColumn(3, idxDEPTCD);
							gsmt.bindColumn(4, idxPAYGRD);
							gsmt.bindColumn(5, idxWORK_1);
							gsmt.bindColumn(6, idxSTARTDT_1);
							gsmt.bindColumn(7, idxENDDT_1);
							gsmt.bindColumn(8, idxPLACE_1);
							gsmt.bindColumn(9, idxREMARK_1);
							gsmt.bindColumn(10, idxWORK_2);
							gsmt.bindColumn(11, idxSTARTDT_2);
							gsmt.bindColumn(12, idxENDDT_2);
							gsmt.bindColumn(13, idxPLACE_2);
							gsmt.bindColumn(14, idxREMARK_2);
							gsmt.bindColumn(15, idxWORK_3);
							gsmt.bindColumn(16, idxSTARTDT_3);
							gsmt.bindColumn(17, idxENDDT_3);
							gsmt.bindColumn(18, idxPLACE_3);
							gsmt.bindColumn(19, idxREMARK_3);
							gsmt.bindColumn(20, idxUPDT);
							gsmt.bindColumn(21, idxUPID);
							gsmt.bindColumn(22, idxEVAYM);
							gsmt.bindColumn(23, idxEMPNO);
							gsmt.executeUpdate(); 
							gsmt.close();         
								
						}
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxHEADCD);
						gsmt.bindColumn(2, idxDIVCD);
						gsmt.bindColumn(3, idxDEPTCD);
						gsmt.bindColumn(4, idxPAYGRD);
						gsmt.bindColumn(5, idxWORK_1);
						gsmt.bindColumn(6, idxSTARTDT_1);
						gsmt.bindColumn(7, idxENDDT_1);
						gsmt.bindColumn(8, idxPLACE_1);
						gsmt.bindColumn(9, idxREMARK_1);
						gsmt.bindColumn(10, idxWORK_2);
						gsmt.bindColumn(11, idxSTARTDT_2);
						gsmt.bindColumn(12, idxENDDT_2);
						gsmt.bindColumn(13, idxPLACE_2);
						gsmt.bindColumn(14, idxREMARK_2);
						gsmt.bindColumn(15, idxWORK_3);
						gsmt.bindColumn(16, idxSTARTDT_3);
						gsmt.bindColumn(17, idxENDDT_3);
						gsmt.bindColumn(18, idxPLACE_3);
						gsmt.bindColumn(19, idxREMARK_3);
						gsmt.bindColumn(20, idxUPDT);
						gsmt.bindColumn(21, idxUPID);
						gsmt.bindColumn(22, idxEVAYM);
						gsmt.bindColumn(23, idxEMPNO);
						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxEVAYM);
						gsmt.bindColumn(2, idxEMPNO);
						gsmt.executeUpdate();
						gsmt.close();
					}
					
				}

        //************************************************************************************************
        //업적신고서 상세
        //************************************************************************************************
				GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2");        
        int idx2EVAYM		= userSet2.indexOfColumn("EVAYM");
				int idx2EMPNO		= userSet2.indexOfColumn("EMPNO");
				int idx2SEQ2 		= userSet2.indexOfColumn("SEQ2");
				int idx2WORKGB	  = userSet2.indexOfColumn("WORKGB");
				int idx2WKCONT		= userSet2.indexOfColumn("WKCONT");
				int idx2IMPORT 	= userSet2.indexOfColumn("IMPORT");
				int idx2REMARK 	= userSet2.indexOfColumn("REMARK");
				int idx2WRDT   	= userSet2.indexOfColumn("WRDT");
				int idx2WRID 		= userSet2.indexOfColumn("WRID");		
				int idx2UPDT			= userSet2.indexOfColumn("UPDT");	
				int idx2UPID			= userSet2.indexOfColumn("UPID");	
         
				GauceDataRow[] rows2 = userSet2.getDataRows();

				StringBuffer UpdateSql2 = null;
				StringBuffer DeleteSql2 = null;
			  StringBuffer InsertSql2 = null;
        
				InsertSql2 = new StringBuffer();
				InsertSql2.append( "INSERT INTO PAYROLL.HWORKDTL ( " );
				InsertSql2.append( "EVAYM,	  EMPNO,	SEQ2,	WORKGB,	WKCONT, " );
				InsertSql2.append( "IMPORT,	REMARK,	WRDT,	WRID,	  UPDT,	  UPID " );
				InsertSql2.append( ") VALUES( " );
				InsertSql2.append( "?, ?, ?, ?, ?,");
				InsertSql2.append( "?, ?, ?, ?, ?, ? ) " );
        
				UpdateSql2 = new StringBuffer();
				UpdateSql2.append( "UPDATE PAYROLL.HWORKDTL SET " );
        UpdateSql2.append( " WORKGB = ?, " );
				UpdateSql2.append( " WKCONT = ?, " );
				UpdateSql2.append( " IMPORT = ?, " );
				UpdateSql2.append( " REMARK = ?, " );
				UpdateSql2.append( " UPDT = ?, " );
				UpdateSql2.append( " UPID = ? " );
				UpdateSql2.append( " WHERE EVAYM = ? AND EMPNO = ? AND  SEQ2 = ? " );

				DeleteSql2 = new StringBuffer();
				DeleteSql2.append( "DELETE FROM PAYROLL.HWORKDTL WHERE  EVAYM = ? AND EMPNO = ? AND  SEQ2 = ? " );
				
				for (int j = 0; j < rows2.length; j++){

					if(rows2[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					
						GauceStatement gsmt2 = conn.getGauceStatement(InsertSql2.toString());
						gsmt2.setGauceDataRow(rows2[j]);
						
						gsmt2.bindColumn(1, idx2EVAYM);
						gsmt2.bindColumn(2, idx2EMPNO);
						gsmt2.bindColumn(3, idx2SEQ2);
						gsmt2.bindColumn(4, idx2WORKGB);
						gsmt2.bindColumn(5, idx2WKCONT);
						gsmt2.bindColumn(6, idx2IMPORT);
						gsmt2.bindColumn(7, idx2REMARK);
						gsmt2.bindColumn(8, idx2WRDT);
						gsmt2.bindColumn(9, idx2WRID);
						gsmt2.bindColumn(10,idx2UPDT);
						gsmt2.bindColumn(11,idx2UPID);
					
						gsmt2.executeUpdate();
						gsmt2.close();
					}

					if(rows2[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt2 = conn.getGauceStatement(UpdateSql2.toString());
						gsmt2.setGauceDataRow(rows2[j]);
						
						gsmt2.bindColumn(1, idx2WORKGB);
						gsmt2.bindColumn(2, idx2WKCONT);
						gsmt2.bindColumn(3, idx2IMPORT);
						gsmt2.bindColumn(4, idx2REMARK);
						gsmt2.bindColumn(5, idx2UPDT);
						gsmt2.bindColumn(6, idx2UPID);
						gsmt2.bindColumn(7, idx2EVAYM);
						gsmt2.bindColumn(8, idx2EMPNO);
						gsmt2.bindColumn(9, idx2SEQ2);
						gsmt2.executeUpdate(); 
						gsmt2.close();         
					}    
						
					if(rows2[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt2 = conn.getGauceStatement(DeleteSql2.toString());
						gsmt2.setGauceDataRow(rows2[j]);

						gsmt2.bindColumn(1, idx2EVAYM);
						gsmt2.bindColumn(2, idx2EMPNO);
						gsmt2.bindColumn(3, idx2SEQ2);
						gsmt2.executeUpdate();
						gsmt2.close();
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