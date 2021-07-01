package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010002_t1 extends HttpServlet{
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

				String str1 = reqGauce.getParameter("v_str1");
				String str2 = reqGauce.getParameter("v_str2");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
        

				int idxATCODE				 = userSet.indexOfColumn("ATCODE");
				int idxATKORNAM      = userSet.indexOfColumn("ATKORNAM");
				int idxATPRTNAM      = userSet.indexOfColumn("ATPRTNAM");
				int idxATDIV         = userSet.indexOfColumn("ATDIV");
				int idxATGRP         = userSet.indexOfColumn("ATGRP");
				int idxATDECR        = userSet.indexOfColumn("ATDECR");
				int idxATUSEYN       = userSet.indexOfColumn("ATUSEYN");
				int idxATUPCODE      = userSet.indexOfColumn("ATUPCODE");
				int idxATPRTSEQ      = userSet.indexOfColumn("ATPRTSEQ");
				int idxATFORCURYN    = userSet.indexOfColumn("ATFORCURYN");
				int idxATCURTYPE     = userSet.indexOfColumn("ATCURTYPE");
				int idxATAPRYN       = userSet.indexOfColumn("ATAPRYN");
				int idxATAPRCODE     = userSet.indexOfColumn("ATAPRCODE");
				int idxATDAYBALYN    = userSet.indexOfColumn("ATDAYBALYN");
				int idxATSUPPLYN     = userSet.indexOfColumn("ATSUPPLYN");
				int idxATTOTACCYN    = userSet.indexOfColumn("ATTOTACCYN");
				int idxATSUMBALYN    = userSet.indexOfColumn("ATSUMBALYN");
				int idxATBALSHTYN    = userSet.indexOfColumn("ATBALSHTYN");
				int idxATPROLSTYN    = userSet.indexOfColumn("ATPROLSTYN");
				int idxATATTSHTYN    = userSet.indexOfColumn("ATATTSHTYN");
				int idxATMAKYN       = userSet.indexOfColumn("ATMAKYN");
				int idxATWRKYN       = userSet.indexOfColumn("ATWRKYN");
				int idxATTRAYN       = userSet.indexOfColumn("ATTRAYN");
				int idxATETCYN       = userSet.indexOfColumn("ATETCYN");
				int idxATOPPUSEYN    = userSet.indexOfColumn("ATOPPUSEYN");
				int idxATBDGRELYN    = userSet.indexOfColumn("ATBDGRELYN");
				int idxATDEBTYN      = userSet.indexOfColumn("ATDEBTYN");
				int idxATTXT         = userSet.indexOfColumn("ATTXT");
				int idxBASDAT        = userSet.indexOfColumn("BASDAT");
				int idxWRDT          = userSet.indexOfColumn("WRDT");
				int idxWRID          = userSet.indexOfColumn("WRID");
				int idxUPDT          = userSet.indexOfColumn("UPDT");
				int idxUPID          = userSet.indexOfColumn("UPID");
				int idxDSUDT         = userSet.indexOfColumn("DSUDT"); 
				int idxCOMMUSE       = userSet.indexOfColumn("COMMUSE"); 
				int idxSUMLEVEL      = userSet.indexOfColumn("SUMLEVEL"); 
				int idxFSREFCD       = userSet.indexOfColumn("FSREFCD"); 
				int idxFUNDIV        = userSet.indexOfColumn("FUNDIV"); 

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.ACTCODE (  														\n");
				InsertSql.append( " ATCODE,	    ATKORNAM ,	ATPRTNAM,	  ATDIV,	    ATGRP,	   					\n");
				InsertSql.append( " ATDECR,	    ATUSEYN,	  ATUPCODE,  	ATPRTSEQ,	  ATFORCURYN,		\n");
				InsertSql.append( " ATCURTYPE,	ATAPRYN,	  ATAPRCODE,	ATDAYBALYN,	ATSUPPLYN, 			\n");
				InsertSql.append( " ATTOTACCYN,	ATSUMBALYN,	ATBALSHTYN,	ATPROLSTYN,	ATATTSHTYN,		\n");
				InsertSql.append( " ATMAKYN,	  ATWRKYN,	  ATTRAYN,	  ATETCYN,	  ATOPPUSEYN,					\n");
				InsertSql.append( " ATBDGRELYN,	ATDEBTYN,	  ATTXT,	    BASDAT,	               						\n");
				InsertSql.append( " WRDT,	WRID,	DSUDT,COMMUSE,SUMLEVEL, FSREFCD,FUNDIV         		\n");
				InsertSql.append( "  ) 																										\n");
				InsertSql.append( "  VALUES 																								\n");
				InsertSql.append( " ( 																										\n");
				InsertSql.append( " ?,? ,?,?,?, 																							\n");
				InsertSql.append( " ?,?,?,?,?, 																							\n");
				InsertSql.append( " ?,?,?,?,?, 																							\n");
				InsertSql.append( " ?,?,?,?,?, 																							\n");
				InsertSql.append( " ?,?,?,?,?, 																							\n");
				InsertSql.append( " ?,?,?,?,  																								\n");
				InsertSql.append( " '" + str1 + "','" +str2+"',?,?,?,?,? ) 															\n");				

  
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.ACTCODE SET \n");
				UpdateSql.append( "        ATKORNAM   = ?,					\n");
				UpdateSql.append( "        ATPRTNAM   = ?,					\n");
				UpdateSql.append( "        ATDIV      = ?,						\n");
				UpdateSql.append( "        ATGRP      = ?,					\n");
				UpdateSql.append( "        ATDECR     = ?,					\n");
				UpdateSql.append( "        ATUSEYN    = ?,					\n");
				UpdateSql.append( "        ATUPCODE   = ?,					\n");
				UpdateSql.append( "        ATPRTSEQ   = ?,					\n");
				UpdateSql.append( "        ATFORCURYN = ?,				\n");
				UpdateSql.append( "        ATCURTYPE  = ?,					\n");
				UpdateSql.append( "        ATAPRYN    = ?,					\n");
				UpdateSql.append( "        ATAPRCODE  = ?,					\n");
				UpdateSql.append( "        ATDAYBALYN = ?,					\n");
				UpdateSql.append( "        ATSUPPLYN  = ?,					\n");
				UpdateSql.append( "        ATTOTACCYN = ?,					\n");
				UpdateSql.append( "        ATSUMBALYN = ?,				\n");
				UpdateSql.append( "        ATBALSHTYN = ?,					\n");
				UpdateSql.append( "        ATPROLSTYN = ?,					\n");
				UpdateSql.append( "        ATATTSHTYN = ?,					\n");
				UpdateSql.append( "        ATMAKYN    = ?,					\n");
				UpdateSql.append( "        ATWRKYN    = ?,					\n");
				UpdateSql.append( "        ATTRAYN    = ?,					\n");
				UpdateSql.append( "        ATETCYN    = ?,					\n");
				UpdateSql.append( "        ATOPPUSEYN = ?,				\n");
				UpdateSql.append( "        ATBDGRELYN = ?,					\n");
				UpdateSql.append( "        ATDEBTYN   = ?,					\n");
				UpdateSql.append( "        ATTXT      = ?,						\n");
				UpdateSql.append( "        BASDAT     = ?,					\n");
				UpdateSql.append( "        UPDT = '" + str1 + "',				\n");
				UpdateSql.append( "        UPID = '" + str2 +"',				\n");
				UpdateSql.append( "        DSUDT= ?,							\n");
				UpdateSql.append( "        COMMUSE= ?,						\n");
				UpdateSql.append( "        SUMLEVEL= ?,						\n");
				UpdateSql.append( "        FSREFCD= ?,						\n");
				UpdateSql.append( "        FUNDIV= ?							\n");
				UpdateSql.append( " WHERE ATCODE= ?						\n");

				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.ACTCODE 			\n");
				DeleteSql.append( "  WHERE ATCODE= ?									\n");

				//logger.dbg.println(this,InsertSql.toString());

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxATCODE);
						gsmt.bindColumn(2, idxATKORNAM);
						gsmt.bindColumn(3, idxATPRTNAM);
						gsmt.bindColumn(4, idxATDIV);
						gsmt.bindColumn(5, idxATGRP);
						gsmt.bindColumn(6, idxATDECR);
						gsmt.bindColumn(7, idxATUSEYN);
						gsmt.bindColumn(8, idxATUPCODE);
						gsmt.bindColumn(9, idxATPRTSEQ);
						gsmt.bindColumn(10, idxATFORCURYN);
						gsmt.bindColumn(11, idxATCURTYPE);
						gsmt.bindColumn(12, idxATAPRYN);
						gsmt.bindColumn(13, idxATAPRCODE);
						gsmt.bindColumn(14, idxATDAYBALYN);
						gsmt.bindColumn(15, idxATSUPPLYN);
						gsmt.bindColumn(16, idxATTOTACCYN);
						gsmt.bindColumn(17, idxATSUMBALYN);
						gsmt.bindColumn(18, idxATBALSHTYN);
						gsmt.bindColumn(19, idxATPROLSTYN);
						gsmt.bindColumn(20, idxATATTSHTYN);
						gsmt.bindColumn(21, idxATMAKYN);
						gsmt.bindColumn(22, idxATWRKYN);
						gsmt.bindColumn(23, idxATTRAYN);
						gsmt.bindColumn(24, idxATETCYN);
						gsmt.bindColumn(25, idxATOPPUSEYN);
						gsmt.bindColumn(26, idxATBDGRELYN);
						gsmt.bindColumn(27, idxATDEBTYN);
						gsmt.bindColumn(28, idxATTXT);
						gsmt.bindColumn(29, idxBASDAT);
						gsmt.bindColumn(30, idxDSUDT); 
						gsmt.bindColumn(31, idxCOMMUSE); 
						gsmt.bindColumn(32, idxSUMLEVEL); 
						gsmt.bindColumn(33, idxFSREFCD); 
						gsmt.bindColumn(34, idxFUNDIV); 
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxATKORNAM);
						gsmt.bindColumn(2, idxATPRTNAM);
						gsmt.bindColumn(3, idxATDIV);
						gsmt.bindColumn(4, idxATGRP);
						gsmt.bindColumn(5, idxATDECR);
						gsmt.bindColumn(6, idxATUSEYN);
						gsmt.bindColumn(7, idxATUPCODE);
						gsmt.bindColumn(8, idxATPRTSEQ);
						gsmt.bindColumn(9, idxATFORCURYN);
						gsmt.bindColumn(10, idxATCURTYPE);
						gsmt.bindColumn(11, idxATAPRYN);
						gsmt.bindColumn(12, idxATAPRCODE);
						gsmt.bindColumn(13, idxATDAYBALYN);
						gsmt.bindColumn(14, idxATSUPPLYN);
						gsmt.bindColumn(15, idxATTOTACCYN);
						gsmt.bindColumn(16, idxATSUMBALYN);
						gsmt.bindColumn(17, idxATBALSHTYN);
						gsmt.bindColumn(18, idxATPROLSTYN);
						gsmt.bindColumn(19, idxATATTSHTYN);
						gsmt.bindColumn(20, idxATMAKYN);
						gsmt.bindColumn(21, idxATWRKYN);
						gsmt.bindColumn(22, idxATTRAYN);
						gsmt.bindColumn(23, idxATETCYN);
						gsmt.bindColumn(24, idxATOPPUSEYN);
						gsmt.bindColumn(25, idxATBDGRELYN);
						gsmt.bindColumn(26, idxATDEBTYN);
						gsmt.bindColumn(27, idxATTXT);
						gsmt.bindColumn(28, idxBASDAT);
						gsmt.bindColumn(29, idxDSUDT);
						gsmt.bindColumn(30, idxCOMMUSE);
						gsmt.bindColumn(31, idxSUMLEVEL);
						gsmt.bindColumn(32, idxFSREFCD);
						gsmt.bindColumn(33, idxFUNDIV);
						gsmt.bindColumn(34, idxATCODE);
						gsmt.executeUpdate(); 
						gsmt.close();                                             
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxATCODE);
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
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