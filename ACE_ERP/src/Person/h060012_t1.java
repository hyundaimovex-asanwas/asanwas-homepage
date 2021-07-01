package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h060012_t1 extends HttpServlet{

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

				int idxEVAYM			= userSet.indexOfColumn("EVAYM");
				int idxEMPNO			= userSet.indexOfColumn("EMPNO");
				int idxEMPNMK			= userSet.indexOfColumn("EMPNMK");
				int idxDEPTCD			= userSet.indexOfColumn("DEPTCD");
				int idxDEPTNM			= userSet.indexOfColumn("DEPTNM");
				int idxPAYGRD			= userSet.indexOfColumn("PAYGRD");
				int idxGRDNM			= userSet.indexOfColumn("GRDNM");
				int idxGRSTRTDT		    = userSet.indexOfColumn("GRSTRTDT");
				int idxSTRTDT			= userSet.indexOfColumn("STRTDT");
				int idxWRDT				= userSet.indexOfColumn("WRDT");
				int idxTOTAVG			= userSet.indexOfColumn("TOTAVG");
				int idxSCR1				= userSet.indexOfColumn("SCR1");
				int idxAVG1				= userSet.indexOfColumn("AVG1");
				int idxSCR2				= userSet.indexOfColumn("SCR2");
				int idxAVG2				= userSet.indexOfColumn("AVG2");
				int idxSCR3				= userSet.indexOfColumn("SCR3");
				int idxAVG3				= userSet.indexOfColumn("AVG3");
				int idxSCR4				= userSet.indexOfColumn("SCR4");
				int idxAVG4				= userSet.indexOfColumn("AVG4");
				int idxSCR5				= userSet.indexOfColumn("SCR5");
				int idxAVG5				= userSet.indexOfColumn("AVG5");
				int idxSCR6				= userSet.indexOfColumn("SCR6");
				int idxAVG6				= userSet.indexOfColumn("AVG6");
				int idxSCR7				= userSet.indexOfColumn("SCR7");
				int idxAVG7				= userSet.indexOfColumn("AVG7");
				int idxSCR8				= userSet.indexOfColumn("SCR8");
				int idxAVG8				= userSet.indexOfColumn("AVG8");
				int idxSCR9				= userSet.indexOfColumn("SCR9");
				int idxAVG9				= userSet.indexOfColumn("AVG9");
				int idxSCR10			= userSet.indexOfColumn("SCR10");
				int idxAVG10			= userSet.indexOfColumn("AVG10");
				int idxSCR11			= userSet.indexOfColumn("SCR11");
				int idxAVG11			= userSet.indexOfColumn("AVG11");
				int idxSCR12			= userSet.indexOfColumn("SCR12");
				int idxAVG12			= userSet.indexOfColumn("AVG12");
				int idxSCR13			= userSet.indexOfColumn("SCR13");
				int idxAVG13			= userSet.indexOfColumn("AVG13");
				int idxSCR14			= userSet.indexOfColumn("SCR14");
				int idxAVG14			= userSet.indexOfColumn("AVG14");
				int idxSCR15			= userSet.indexOfColumn("SCR15");
				int idxAVG15			= userSet.indexOfColumn("AVG15");
				int idxSCR16			= userSet.indexOfColumn("SCR16");
				int idxAVG16			= userSet.indexOfColumn("AVG16");
				int idxSCR17			= userSet.indexOfColumn("SCR17");
				int idxAVG17			= userSet.indexOfColumn("AVG17");
				int idxSCR18			= userSet.indexOfColumn("SCR18");
				int idxAVG18			= userSet.indexOfColumn("AVG18");
				int idxSCR19			= userSet.indexOfColumn("SCR19");
				int idxAVG19			= userSet.indexOfColumn("AVG19");
				int idxSCR20			= userSet.indexOfColumn("SCR20");
				int idxAVG20			= userSet.indexOfColumn("AVG20");
                int idxSCR21			= userSet.indexOfColumn("SCR21");
				int idxAVG21			= userSet.indexOfColumn("AVG21");
				int idxSCR22			= userSet.indexOfColumn("SCR22");
				int idxAVG22			= userSet.indexOfColumn("AVG22");
				int idxSCR23			= userSet.indexOfColumn("SCR23");
				int idxAVG23			= userSet.indexOfColumn("AVG23");
				int idxSCR24			= userSet.indexOfColumn("SCR24");
				int idxAVG24			= userSet.indexOfColumn("AVG24");
				int idxSCR25			= userSet.indexOfColumn("SCR25");
				int idxAVG25			= userSet.indexOfColumn("AVG25");
				int idxSCR26			= userSet.indexOfColumn("SCR26");
				int idxAVG26			= userSet.indexOfColumn("AVG26");
				int idxSCR27			= userSet.indexOfColumn("SCR27");
				int idxAVG27			= userSet.indexOfColumn("AVG27");
				int idxSCR28			= userSet.indexOfColumn("SCR28");
				int idxAVG28			= userSet.indexOfColumn("AVG28");
				int idxSCR29			= userSet.indexOfColumn("SCR29");
				int idxAVG29			= userSet.indexOfColumn("AVG29");
				int idxSCR30			= userSet.indexOfColumn("SCR30");
				int idxAVG30			= userSet.indexOfColumn("AVG30");
                int idxSCR31			= userSet.indexOfColumn("SCR31");
				int idxAVG31			= userSet.indexOfColumn("AVG31");
				int idxSCR32			= userSet.indexOfColumn("SCR32");
				int idxAVG32			= userSet.indexOfColumn("AVG32");
				int idxSCR33			= userSet.indexOfColumn("SCR33");
				int idxAVG33			= userSet.indexOfColumn("AVG33");
				int idxSCR34			= userSet.indexOfColumn("SCR34");
				int idxAVG34			= userSet.indexOfColumn("AVG34");
				int idxSCR35			= userSet.indexOfColumn("SCR35");
				int idxAVG35			= userSet.indexOfColumn("AVG35");
				int idxSCR36			= userSet.indexOfColumn("SCR36");
				int idxAVG36			= userSet.indexOfColumn("AVG36");
				int idxSCR37			= userSet.indexOfColumn("SCR37");
				int idxAVG37			= userSet.indexOfColumn("AVG37");
				int idxSCR38			= userSet.indexOfColumn("SCR38");
				int idxAVG38			= userSet.indexOfColumn("AVG38");
				int idxSCR39			= userSet.indexOfColumn("SCR39");
				int idxAVG39			= userSet.indexOfColumn("AVG39");
				int idxSCR40			= userSet.indexOfColumn("SCR40");
				int idxAVG40			= userSet.indexOfColumn("AVG40");
                int idxSCR41			= userSet.indexOfColumn("SCR41");
				int idxAVG41			= userSet.indexOfColumn("AVG41");
				int idxSCR42			= userSet.indexOfColumn("SCR42");
				int idxAVG42			= userSet.indexOfColumn("AVG42");
				int idxSCR43			= userSet.indexOfColumn("SCR43");
				int idxAVG43			= userSet.indexOfColumn("AVG43");
				int idxSCR44			= userSet.indexOfColumn("SCR44");
				int idxAVG44			= userSet.indexOfColumn("AVG44");
				int idxSCR45			= userSet.indexOfColumn("SCR45");
				int idxAVG45			= userSet.indexOfColumn("AVG45");
				int idxSCR46			= userSet.indexOfColumn("SCR46");
				int idxAVG46			= userSet.indexOfColumn("AVG46");
				int idxSCR47			= userSet.indexOfColumn("SCR47");
				int idxAVG47			= userSet.indexOfColumn("AVG47");
				int idxSCR48			= userSet.indexOfColumn("SCR48");
				int idxAVG48			= userSet.indexOfColumn("AVG48");
				int idxSCR49			= userSet.indexOfColumn("SCR49");
				int idxAVG49			= userSet.indexOfColumn("AVG49");
				int idxSCR50			= userSet.indexOfColumn("SCR50");
				int idxAVG50			= userSet.indexOfColumn("AVG50");
                int idxSCR51			= userSet.indexOfColumn("SCR51");
				int idxAVG51			= userSet.indexOfColumn("AVG51");
				int idxSCR52			= userSet.indexOfColumn("SCR52");
				int idxAVG52			= userSet.indexOfColumn("AVG52");
				int idxSCR53			= userSet.indexOfColumn("SCR53");
				int idxAVG53			= userSet.indexOfColumn("AVG53");
				int idxSCR54			= userSet.indexOfColumn("SCR54");
				int idxAVG54			= userSet.indexOfColumn("AVG54");
				int idxSCR55			= userSet.indexOfColumn("SCR55");
				int idxAVG55			= userSet.indexOfColumn("AVG55");
				int idxSCR56			= userSet.indexOfColumn("SCR56");
				int idxAVG56			= userSet.indexOfColumn("AVG56");
				int idxSCR57			= userSet.indexOfColumn("SCR57");
				int idxAVG57			= userSet.indexOfColumn("AVG57");
				int idxSCR58			= userSet.indexOfColumn("SCR58");
				int idxAVG58			= userSet.indexOfColumn("AVG58");
				int idxSCR59			= userSet.indexOfColumn("SCR59");
				int idxAVG59			= userSet.indexOfColumn("AVG59");
				int idxSCR60			= userSet.indexOfColumn("SCR50");
				int idxAVG60			= userSet.indexOfColumn("AVG60");


				int idxLAMDT			= userSet.indexOfColumn("LAMDT");
				int idxRECDIV			= userSet.indexOfColumn("RECDIV");
				int idxJOBKIND	    	= userSet.indexOfColumn("JOBKIND");
				int idxJOBREF           = userSet.indexOfColumn("JOBREF");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer DeleteSql2 = null;
				StringBuffer DeleteSql3 = null;

				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.HVEMPS SET " );
				UpdateSql.append( " JOBREF    = ? " );
				UpdateSql.append( " WHERE EVAYM = ? AND EMPNO = ? " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.HVEMPS WHERE EVAYM = ? AND EMPNO = ? " );

				DeleteSql2 = new StringBuffer();
				DeleteSql2.append( "DELETE FROM PAYROLL.HVHEMPS WHERE EVAYM = ? AND EMPNO = ? " );

				DeleteSql3 = new StringBuffer();
				DeleteSql3.append( "DELETE FROM PAYROLL.HVSCORES WHERE EVAYM = ? AND EMPNO = ? " );

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxJOBREF);
						gsmt.bindColumn(2, idxEVAYM);
						gsmt.bindColumn(3, idxEMPNO);
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

						GauceStatement gsmt2 = conn.getGauceStatement(DeleteSql2.toString());
						gsmt2.setGauceDataRow(rows[j]);
						gsmt2.bindColumn(1, idxEVAYM);
						gsmt2.bindColumn(2, idxEMPNO);
						gsmt2.executeUpdate();
						gsmt2.close();

						GauceStatement gsmt3 = conn.getGauceStatement(DeleteSql3.toString());
						gsmt3.setGauceDataRow(rows[j]);
						gsmt3.bindColumn(1, idxEVAYM);
						gsmt3.bindColumn(2, idxEMPNO);
						gsmt3.executeUpdate();
						gsmt3.close();
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