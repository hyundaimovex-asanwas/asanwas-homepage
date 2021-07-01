package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h060030_t1 extends HttpServlet{

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
				int idxJOBCODE 	= userSet.indexOfColumn("JOBCODE");
				int idxJOBGRPH= userSet.indexOfColumn("JOBGRPH");
				int idxJOBRR 	= userSet.indexOfColumn("JOBRR");
				int idxJOBKIND 	= userSet.indexOfColumn("JOBKIND");
				int idxJOBNAME = userSet.indexOfColumn("JOBNAME");
				int idxJOBSM 	= userSet.indexOfColumn("JOBSM");
				int idxEDU= userSet.indexOfColumn("EDU");
				int idxMAJOR 	= userSet.indexOfColumn("MAJOR");
				int idxSEX 	= userSet.indexOfColumn("SEX");
				int idxETC = userSet.indexOfColumn("ETC");
				int idxEXP 	= userSet.indexOfColumn("EXP");
				int idxCERTIFICATE= userSet.indexOfColumn("CERTIFICATE");
				int idxENGLVL 	= userSet.indexOfColumn("ENGLVL");
				int idxJPLVL 	= userSet.indexOfColumn("JPLVL");
				int idxCHINALVL = userSet.indexOfColumn("CHINALVL");
				int idxETCLVL 	= userSet.indexOfColumn("ETCLVL");
				int idxHWGRDCD= userSet.indexOfColumn("HWGRDCD");
				int idxEXGRDCD 	= userSet.indexOfColumn("EXGRDCD");
				int idxPWGRDCD 	= userSet.indexOfColumn("PWGRDCD");
				int idxOAGRDCD = userSet.indexOfColumn("OAGRDCD");
				int idxABILITY 	= userSet.indexOfColumn("ABILITY");
				int idxTECHNIQUE= userSet.indexOfColumn("TECHNIQUE");
				int idxSTUDY 	= userSet.indexOfColumn("STUDY");
				int idxSTUDY2 	= userSet.indexOfColumn("STUDY2");
				int idxSTUDY3 = userSet.indexOfColumn("STUDY3");
				int idxI_EMPNO 		= userSet.indexOfColumn("I_EMPNO");		
				int idxU_EMPNO			= userSet.indexOfColumn("U_EMPNO");	

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
			  StringBuffer InsertSql = null;
        
				InsertSql = new StringBuffer();
				InsertSql.append( "INSERT INTO PAYROLL.JOBSPEC ( " );
				InsertSql.append( "EVAYM,	EMPNO,	HEADCD,	DIVCD,	DEPTCD, PAYGRD, " );
				InsertSql.append( "JOBCODE,	JOBGRPH,	JOBRR,	JOBKIND,	JOBNAME, " );
				InsertSql.append( "JOBSM,	EDU,	MAJOR,	SEX,	ETC, " );
				InsertSql.append( "EXP,	CERTIFICATE,	ENGLVL,	JPLVL,	CHINALVL, " );
				InsertSql.append( "ETCLVL,	HWGRDCD,	EXGRDCD,	PWGRDCD,	OAGRDCD, " );
				InsertSql.append( "ABILITY,	TECHNIQUE,	STUDY,	STUDY2,	STUDY3, " );
				InsertSql.append( "I_DATE,	I_EMPNO	  " );
				InsertSql.append( ") VALUES( " );
				InsertSql.append( "?, ?, ?, ?, ?, ?,");
				InsertSql.append( "?, ?, ?, ?, ?,");
				InsertSql.append( "?, ?, ?, ?, ?,");
				InsertSql.append( "?, ?, ?, ?, ?,");
				InsertSql.append( "?, ?, ?, ?, ?,");
				InsertSql.append( "?, ?, ?, ?, ?,");
				InsertSql.append( "CURRENT TIMESTAMP , ? ) " );
        
				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.JOBSPEC SET " );
        UpdateSql.append( " HEADCD = ?, " );
				UpdateSql.append( " DIVCD = ?, " );
				UpdateSql.append( " DEPTCD = ?, " );
				UpdateSql.append( " PAYGRD = ?, " );
				UpdateSql.append( " JOBCODE = ?, " );
				UpdateSql.append( " JOBGRPH = ?, " );
				UpdateSql.append( " JOBRR = ?, " );
				UpdateSql.append( " JOBKIND = ?, " );
				UpdateSql.append( " JOBNAME = ?, " );
				UpdateSql.append( " JOBSM = ?, " );
				UpdateSql.append( " EDU = ?, " );
				UpdateSql.append( " MAJOR = ?, " );
				UpdateSql.append( " SEX = ?, " );
				UpdateSql.append( " ETC = ?, " );
				UpdateSql.append( " EXP = ?, " );
				UpdateSql.append( " CERTIFICATE = ?, " );
				UpdateSql.append( " ENGLVL = ?, " );
				UpdateSql.append( " JPLVL = ?, " );
				UpdateSql.append( " CHINALVL = ?, " );
				UpdateSql.append( " ETCLVL = ?, " );
				UpdateSql.append( " HWGRDCD = ?, " );
				UpdateSql.append( " EXGRDCD = ?, " );
				UpdateSql.append( " PWGRDCD = ?, " );
				UpdateSql.append( " OAGRDCD = ?, " );
				UpdateSql.append( " ABILITY = ?, " );
				UpdateSql.append( " TECHNIQUE = ?, " );
				UpdateSql.append( " STUDY = ?, " );
				UpdateSql.append( " STUDY2 = ?, " );
				UpdateSql.append( " STUDY3 = ?, " );
				UpdateSql.append( " U_DATE = CURRENT TIMESTAMP, " );
				UpdateSql.append( " U_EMPNO = ? " );
				UpdateSql.append( " WHERE EVAYM = ? AND EMPNO = ? " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.JOBSPEC WHERE  EVAYM = ? AND EMPNO = ?  " );
				
				for (int j = 0; j < rows.length; j++){
/*
			 logger.dbg.println(this, "idxEVAYM	::"+rows[j].getString(idxEVAYM));
			 logger.dbg.println(this, "idxEMPNO	::"+rows[j].getString(idxEMPNO));
			 logger.dbg.println(this, "idxHEADCD::"+rows[j].getString(idxHEADCD));
			 logger.dbg.println(this, "idxDIVCD::"+rows[j].getString(idxDIVCD));
			 logger.dbg.println(this, "idxDEPTCD	::"+rows[j].getString(idxDEPTCD));
			 logger.dbg.println(this, "idxPAYGRD	::"+rows[j].getString(idxPAYGRD));
			 logger.dbg.println(this, "idxJOBCODE::"+rows[j].getString(idxJOBCODE));
			 logger.dbg.println(this, "idxJOBGRPH::"+rows[j].getString(idxJOBGRPH));

			 logger.dbg.println(this, "idxJOBRR	::"+rows[j].getString(idxJOBRR));
			 logger.dbg.println(this, "idxJOBKIND	::"+rows[j].getString(idxJOBKIND));
			 logger.dbg.println(this, "idxJOBNAME::"+rows[j].getString(idxJOBNAME));
			 logger.dbg.println(this, "idxJOBSM::"+rows[j].getString(idxJOBSM));

			 logger.dbg.println(this, "idxEDU	::"+rows[j].getString(idxEDU));
			 logger.dbg.println(this, "idxMAJOR	::"+rows[j].getString(idxMAJOR));
			 logger.dbg.println(this, "idxSEX::"+rows[j].getString(idxSEX));
			 logger.dbg.println(this, "idxETC::"+rows[j].getString(idxETC));

			 logger.dbg.println(this, "idxCERTIFICATE	::"+rows[j].getString(idxCERTIFICATE));
			 logger.dbg.println(this, "idxENGLVL	::"+rows[j].getString(idxENGLVL));
			 logger.dbg.println(this, "idxJPLVL::"+rows[j].getString(idxJPLVL));
			 logger.dbg.println(this, "idxCHINALVL::"+rows[j].getString(idxCHINALVL));

			 logger.dbg.println(this, "idxETCLVL	::"+rows[j].getString(idxETCLVL));
			 logger.dbg.println(this, "idxHWGRDCD	::"+rows[j].getString(idxHWGRDCD));
			 logger.dbg.println(this, "idxEXGRDCD::"+rows[j].getString(idxEXGRDCD));
			 logger.dbg.println(this, "idxPWGRDCD::"+rows[j].getString(idxPWGRDCD));

			 logger.dbg.println(this, "idxOAGRDCD	::"+rows[j].getString(idxOAGRDCD));
			 logger.dbg.println(this, "idxABILITY	::"+rows[j].getString(idxABILITY));
			 logger.dbg.println(this, "idxTECHNIQUE::"+rows[j].getString(idxTECHNIQUE));
			 logger.dbg.println(this, "idxSTUDY::"+rows[j].getString(idxSTUDY));
			 logger.dbg.println(this, "idxSTUDY2	::"+rows[j].getString(idxSTUDY2));
			 logger.dbg.println(this, "idxSTUDY3	::"+rows[j].getString(idxSTUDY3));
			 logger.dbg.println(this, "idxI_EMPNO::"+rows[j].getString(idxI_EMPNO));
			 logger.dbg.println(this, "idxU_EMPNO::"+rows[j].getString(idxU_EMPNO));

*/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						
						Statement stmt = conn.createStatement();
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT COUNT(*) AS CNT ");
						sql.append( "	  FROM PAYROLL.JOBSPEC "); 
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
							gsmt.bindColumn(7, idxJOBCODE);       
							gsmt.bindColumn(8, idxJOBGRPH);       
							gsmt.bindColumn(9, idxJOBRR);         
							gsmt.bindColumn(10,idxJOBKIND);       
							gsmt.bindColumn(11,idxJOBNAME);       
							gsmt.bindColumn(12, idxJOBSM);       
							gsmt.bindColumn(13, idxEDU);          
							gsmt.bindColumn(14, idxMAJOR);        
							gsmt.bindColumn(15, idxSEX);          
							gsmt.bindColumn(16, idxETC);          
							gsmt.bindColumn(17, idxEXP);          
							gsmt.bindColumn(18, idxCERTIFICATE);  
							gsmt.bindColumn(19, idxENGLVL);       
							gsmt.bindColumn(20, idxJPLVL);        
							gsmt.bindColumn(21, idxCHINALVL);     
							gsmt.bindColumn(22, idxETCLVL);       
							gsmt.bindColumn(23, idxHWGRDCD);      
							gsmt.bindColumn(24, idxEXGRDCD);      
							gsmt.bindColumn(25, idxPWGRDCD);      
							gsmt.bindColumn(26, idxOAGRDCD);      
							gsmt.bindColumn(27, idxABILITY);      
							gsmt.bindColumn(28, idxTECHNIQUE);    
							gsmt.bindColumn(29, idxSTUDY);        
							gsmt.bindColumn(30, idxSTUDY2);       
							gsmt.bindColumn(31, idxSTUDY3);       
							gsmt.bindColumn(32, idxI_EMPNO);

							gsmt.executeUpdate();
							gsmt.close();
						}else{
							GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						  gsmt.setGauceDataRow(rows[j]);      
							gsmt.bindColumn(1, idxHEADCD);      
							gsmt.bindColumn(2, idxDIVCD);       
							gsmt.bindColumn(3, idxDEPTCD);      
							gsmt.bindColumn(4, idxPAYGRD);      
							gsmt.bindColumn(5, idxJOBCODE);     
							gsmt.bindColumn(6, idxJOBGRPH);     
							gsmt.bindColumn(7, idxJOBRR);       
							gsmt.bindColumn(8, idxJOBKIND);     
							gsmt.bindColumn(9, idxJOBNAME);     
							gsmt.bindColumn(10, idxJOBSM);      
							gsmt.bindColumn(11, idxEDU);        
							gsmt.bindColumn(12, idxMAJOR);      
							gsmt.bindColumn(13, idxSEX);        
							gsmt.bindColumn(14, idxETC);        
							gsmt.bindColumn(15, idxEXP);        
							gsmt.bindColumn(16, idxCERTIFICATE);
							gsmt.bindColumn(17, idxENGLVL);     
							gsmt.bindColumn(18, idxJPLVL);      
							gsmt.bindColumn(19, idxCHINALVL);   
							gsmt.bindColumn(20, idxETCLVL);     
							gsmt.bindColumn(21, idxHWGRDCD);    
							gsmt.bindColumn(22, idxEXGRDCD);    
							gsmt.bindColumn(23, idxPWGRDCD);    
							gsmt.bindColumn(24, idxOAGRDCD);    
							gsmt.bindColumn(25, idxABILITY);    
							gsmt.bindColumn(26, idxTECHNIQUE);  
							gsmt.bindColumn(27, idxSTUDY);      
							gsmt.bindColumn(28, idxSTUDY2);     
							gsmt.bindColumn(29, idxSTUDY3);     
							gsmt.bindColumn(30, idxU_EMPNO);
							gsmt.bindColumn(31, idxEVAYM);
							gsmt.bindColumn(32, idxEMPNO);
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
							gsmt.bindColumn(5, idxJOBCODE);     
							gsmt.bindColumn(6, idxJOBGRPH);     
							gsmt.bindColumn(7, idxJOBRR);       
							gsmt.bindColumn(8, idxJOBKIND);     
							gsmt.bindColumn(9, idxJOBNAME);     
							gsmt.bindColumn(10, idxJOBSM);      
							gsmt.bindColumn(11, idxEDU);        
							gsmt.bindColumn(12, idxMAJOR);      
							gsmt.bindColumn(13, idxSEX);        
							gsmt.bindColumn(14, idxETC);        
							gsmt.bindColumn(15, idxEXP);        
							gsmt.bindColumn(16, idxCERTIFICATE);
							gsmt.bindColumn(17, idxENGLVL);     
							gsmt.bindColumn(18, idxJPLVL);      
							gsmt.bindColumn(19, idxCHINALVL);   
							gsmt.bindColumn(20, idxETCLVL);     
							gsmt.bindColumn(21, idxHWGRDCD);    
							gsmt.bindColumn(22, idxEXGRDCD);    
							gsmt.bindColumn(23, idxPWGRDCD);    
							gsmt.bindColumn(24, idxOAGRDCD);    
							gsmt.bindColumn(25, idxABILITY);    
							gsmt.bindColumn(26, idxTECHNIQUE);  
							gsmt.bindColumn(27, idxSTUDY);      
							gsmt.bindColumn(28, idxSTUDY2);     
							gsmt.bindColumn(29, idxSTUDY3);     
							gsmt.bindColumn(30, idxU_EMPNO);
							gsmt.bindColumn(31, idxEVAYM);
							gsmt.bindColumn(32, idxEMPNO);
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
        //직무명세
        //************************************************************************************************
				GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2");        
        int idx2EVAYM		= userSet2.indexOfColumn("EVAYM");
				int idx2EMPNO		= userSet2.indexOfColumn("EMPNO");
				int idx2SEQ 		= userSet2.indexOfColumn("SEQ");
				int idx2JOB		= userSet2.indexOfColumn("JOB");
				int idx2TASK 	= userSet2.indexOfColumn("TASK");
				int idx2TASKDESC 	= userSet2.indexOfColumn("TASKDESC");
				int idx2IMPORT 	= userSet2.indexOfColumn("IMPORT");
				int idx2DEGREE	  = userSet2.indexOfColumn("DEGREE");
				int idx2FREQUENCY		= userSet2.indexOfColumn("FREQUENCY");
				int idx2I_EMPNO 		= userSet2.indexOfColumn("I_EMPNO");		
				int idx2U_EMPNO			= userSet2.indexOfColumn("U_EMPNO");	
         
				GauceDataRow[] rows2 = userSet2.getDataRows();

				StringBuffer UpdateSql2 = null;
				StringBuffer DeleteSql2 = null;
			  StringBuffer InsertSql2 = null;
        
				InsertSql2 = new StringBuffer();
				InsertSql2.append( "INSERT INTO PAYROLL.TASK ( " );
				InsertSql2.append( "EVAYM,	  EMPNO,	SEQ,	JOB,	TASK, " );
				InsertSql2.append( "TASKDESC,	  IMPORT,	DEGREE,	FREQUENCY, " );
				InsertSql2.append( "I_DATE,	I_EMPNO " );
				InsertSql2.append( ") VALUES( " );
				InsertSql2.append( "?, ?, ?, ?, ?,");
				InsertSql2.append( "?, ?, ?, ?,   " );
				InsertSql2.append( "CURRENT TIMESTAMP, ?  ) " );
        
				UpdateSql2 = new StringBuffer();
				UpdateSql2.append( "UPDATE PAYROLL.TASK SET " );
        UpdateSql2.append( " JOB = ?, " );
				UpdateSql2.append( " TASK = ?, " );
				UpdateSql2.append( " TASKDESC = ?, " );
				UpdateSql2.append( " IMPORT = ?, " );
				UpdateSql2.append( " DEGREE = ?, " );
				UpdateSql2.append( " FREQUENCY = ?, " );
				UpdateSql2.append( " U_DATE = CURRENT TIMESTAMP, " );
				UpdateSql2.append( " U_EMPNO = ? " );
				UpdateSql2.append( " WHERE EVAYM = ? AND EMPNO = ? AND  SEQ = ? " );


				DeleteSql2 = new StringBuffer();
				DeleteSql2.append( "DELETE FROM PAYROLL.TASK WHERE  EVAYM = ? AND EMPNO = ? AND  SEQ = ? " );
				
				for (int j = 0; j < rows2.length; j++){
/*
			 logger.dbg.println(this, "idx2EVAYM::"+rows2[j].getString(idx2EVAYM));
			 logger.dbg.println(this, "idx2EMPNO	::"+rows2[j].getString(idx2EMPNO));
			 logger.dbg.println(this, "idx2SEQ	::"+rows2[j].getString(idx2SEQ));
			 logger.dbg.println(this, "idx2JOB::"+rows2[j].getString(idx2JOB));
			 logger.dbg.println(this, "idx2TASK::"+rows2[j].getString(idx2TASK));
			 logger.dbg.println(this, "idx2TASKDESC::"+rows2[j].getString(idx2TASKDESC));
			 logger.dbg.println(this, "idx2IMPORT::"+rows2[j].getString(idx2IMPORT));
			 logger.dbg.println(this, "idx2DEGREE::"+rows2[j].getString(idx2DEGREE));
			 logger.dbg.println(this, "idx2FREQUENCY	::"+rows2[j].getString(idx2FREQUENCY));
			 logger.dbg.println(this, "idx2I_EMPNO::"+rows2[j].getString(idx2I_EMPNO));
*/
					if(rows2[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {



					
						GauceStatement gsmt2 = conn.getGauceStatement(InsertSql2.toString());
						gsmt2.setGauceDataRow(rows2[j]);
						
						gsmt2.bindColumn(1, idx2EVAYM);
						gsmt2.bindColumn(2, idx2EMPNO);
						gsmt2.bindColumn(3, idx2SEQ);
						gsmt2.bindColumn(4, idx2JOB);
						gsmt2.bindColumn(5, idx2TASK);
						gsmt2.bindColumn(6, idx2TASKDESC);
						gsmt2.bindColumn(7, idx2IMPORT);
						gsmt2.bindColumn(8, idx2DEGREE);
						gsmt2.bindColumn(9, idx2FREQUENCY);
						gsmt2.bindColumn(10, idx2I_EMPNO);
					
						gsmt2.executeUpdate();
						gsmt2.close();
					}

					if(rows2[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

/*

			 logger.dbg.println(this, "idx2JOB::"+rows2[j].getString(idx2JOB));
			 logger.dbg.println(this, "idx2TASK::"+rows2[j].getString(idx2TASK));
			 logger.dbg.println(this, "idx2TASKDESC::"+rows2[j].getString(idx2TASKDESC));
			 logger.dbg.println(this, "idx2IMPORT::"+rows2[j].getString(idx2IMPORT));
			 logger.dbg.println(this, "idx2DEGREE::"+rows2[j].getString(idx2DEGREE));
			 logger.dbg.println(this, "idx2FREQUENCY	::"+rows2[j].getString(idx2FREQUENCY));

			 logger.dbg.println(this, "idx2U_EMPNO	::"+rows2[j].getString(idx2U_EMPNO));
			 
			 logger.dbg.println(this, "idx2EVAYM::"+rows2[j].getString(idx2EVAYM));
			 logger.dbg.println(this, "idx2EMPNO	::"+rows2[j].getString(idx2EMPNO));
			 logger.dbg.println(this, "idx2SEQ	::"+rows2[j].getString(idx2SEQ));
*/
						GauceStatement gsmt2 = conn.getGauceStatement(UpdateSql2.toString());
						gsmt2.setGauceDataRow(rows2[j]);
						
						gsmt2.bindColumn(1,  idx2JOB);       
						gsmt2.bindColumn(2,  idx2TASK);      
						gsmt2.bindColumn(3,  idx2TASKDESC);  
						gsmt2.bindColumn(4,  idx2IMPORT);    
						gsmt2.bindColumn(5,  idx2DEGREE); 
						gsmt2.bindColumn(6,  idx2FREQUENCY); 						
						gsmt2.bindColumn(7,  idx2U_EMPNO);
						gsmt2.bindColumn(8,  idx2EVAYM);
						gsmt2.bindColumn(9, idx2EMPNO);
						gsmt2.bindColumn(10, idx2SEQ);
						gsmt2.executeUpdate(); 
						gsmt2.close();       
					}    
						
					if(rows2[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt2 = conn.getGauceStatement(DeleteSql2.toString());
						gsmt2.setGauceDataRow(rows2[j]);

						gsmt2.bindColumn(1, idx2EVAYM);
						gsmt2.bindColumn(2, idx2EMPNO);
						gsmt2.bindColumn(3, idx2SEQ);
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