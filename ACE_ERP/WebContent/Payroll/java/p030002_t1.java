package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p030002_t1 extends HttpServlet{

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

				int  idxYYYY = userSet.indexOfColumn("APPDT");
				int  idxEMPNO = userSet.indexOfColumn("EMPNO");
				int  idxBA0101YN = userSet.indexOfColumn("BA0101YN");
				int  idxBA0102CNT = userSet.indexOfColumn("BA0102CNT");
				int  idxBA0103CNT = userSet.indexOfColumn("BA0103CNT");
				int  idxBA0104CNT = userSet.indexOfColumn("BA0104CNT");
				int  idxBA0105CNT = userSet.indexOfColumn("BA0105CNT");
				int  idxAD0101CNT = userSet.indexOfColumn("AD0101CNT");
				int  idxAD0102CNT = userSet.indexOfColumn("AD0102CNT");
				int  idxAD0103CNT = userSet.indexOfColumn("AD0103CNT");
				int  idxAD0104YN = userSet.indexOfColumn("AD0104YN");
				int  idxAD0105CNT = userSet.indexOfColumn("AD0105CNT");
				int  idxPENSUM = userSet.indexOfColumn("PENSUM");
				int  idxINSAMT01 = userSet.indexOfColumn("INSAMT01");
				int  idxINSAMT02 = userSet.indexOfColumn("INSAMT02");
				int  idxINSAMT03 = userSet.indexOfColumn("INSAMT03");
				int  idxINSAMT04 = userSet.indexOfColumn("INSAMT04");
				int  idxMEDAMT01 = userSet.indexOfColumn("MEDAMT01");
				int  idxMEDAMT02 = userSet.indexOfColumn("MEDAMT02");
				int  idxEDUAMT01 = userSet.indexOfColumn("EDUAMT01");
				int  idxEDUAMT02 = userSet.indexOfColumn("EDUAMT02");
				int  idxEDUAMT021 = userSet.indexOfColumn("EDUAMT021");
				int  idxEDUAMT022 = userSet.indexOfColumn("EDUAMT022");
				int  idxEDUAMT023 = userSet.indexOfColumn("EDUAMT023");
				int  idxEDUAMT024 = userSet.indexOfColumn("EDUAMT024");
				int  idxEDUAMT025 = userSet.indexOfColumn("EDUAMT025");
				int  idxEDUAMT03 = userSet.indexOfColumn("EDUAMT03");
				int  idxEDUAMT031 = userSet.indexOfColumn("EDUAMT031");
				int  idxEDUAMT032 = userSet.indexOfColumn("EDUAMT032");
				int  idxEDUAMT033 = userSet.indexOfColumn("EDUAMT033");
				int  idxEDUAMT034 = userSet.indexOfColumn("EDUAMT034");
				int  idxEDUAMT035 = userSet.indexOfColumn("EDUAMT035");
				int  idxEDUAMT04 = userSet.indexOfColumn("EDUAMT04");
				int  idxEDUAMT041 = userSet.indexOfColumn("EDUAMT041");
				int  idxEDUAMT042 = userSet.indexOfColumn("EDUAMT042");
				int  idxEDUAMT043 = userSet.indexOfColumn("EDUAMT043");
				int  idxEDUAMT044 = userSet.indexOfColumn("EDUAMT044");
				int  idxEDUAMT045 = userSet.indexOfColumn("EDUAMT045");
				int  idxEDUAMT05 = userSet.indexOfColumn("EDUAMT05");
				int  idxEDUAMT051 = userSet.indexOfColumn("EDUAMT051");
				int  idxEDUAMT052 = userSet.indexOfColumn("EDUAMT052");
				int  idxEDUAMT053 = userSet.indexOfColumn("EDUAMT053");
				int  idxEDUAMT054 = userSet.indexOfColumn("EDUAMT054");
				int  idxEDUAMT055 = userSet.indexOfColumn("EDUAMT055");
				int  idxHOUAMT01 = userSet.indexOfColumn("HOUAMT01");
				int  idxHOUAMT02 = userSet.indexOfColumn("HOUAMT02");
				int  idxHOUAMT03 = userSet.indexOfColumn("HOUAMT03");
				int  idxHOUAMT04 = userSet.indexOfColumn("HOUAMT04");
				int  idxCONAMT01 = userSet.indexOfColumn("CONAMT01");
				int  idxCONAMT02 = userSet.indexOfColumn("CONAMT02");
				int  idxCONAMT03 = userSet.indexOfColumn("CONAMT03");
				int  idxCONAMT04 = userSet.indexOfColumn("CONAMT04");
				int  idxCONAMT05 = userSet.indexOfColumn("CONAMT05");
				int  idxCONAMT06 = userSet.indexOfColumn("CONAMT06");
				int  idxMARCNT01 = userSet.indexOfColumn("MARCNT01");
				int  idxMARCNT02 = userSet.indexOfColumn("MARCNT02");
				int  idxMARCNT03 = userSet.indexOfColumn("MARCNT03");
				int  idxETCAMT011 = userSet.indexOfColumn("ETCAMT011");
				int  idxETCAMT01 = userSet.indexOfColumn("ETCAMT01");
				int  idxETCAMT02 = userSet.indexOfColumn("ETCAMT02");
				int  idxETCAMT031 = userSet.indexOfColumn("ETCAMT031");
				int  idxETCAMT032 = userSet.indexOfColumn("ETCAMT032");
				int  idxETCAMT033 = userSet.indexOfColumn("ETCAMT033");
				int  idxETCAMT034 = userSet.indexOfColumn("ETCAMT034");
				int  idxETCAMT04 = userSet.indexOfColumn("ETCAMT04");
				int  idxREDAMT01 = userSet.indexOfColumn("REDAMT01");
				int  idxREDAMT02 = userSet.indexOfColumn("REDAMT02");
				int  idxDEDAMT01 = userSet.indexOfColumn("DEDAMT01");
				int  idxDEDAMT02 = userSet.indexOfColumn("DEDAMT02");
				int  idxDEDAMT03 = userSet.indexOfColumn("DEDAMT03");
				int  idxDEDAMT04 = userSet.indexOfColumn("DEDAMT04");
				int  idxDEDAMT05 = userSet.indexOfColumn("DEDAMT05");
				int  idxPB61000 = userSet.indexOfColumn("PB61000");


				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();																						
				InsertSql.append( "  " );		
			
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE PAYROLL.YCPAYCOL SET  " );
				UpdateSql.append( " BA0101YN=?,	BA0102CNT=?,	BA0103CNT=?,	BA0104CNT=?,	BA0105CNT=?,");
        UpdateSql.append( " AD0101CNT=?,	AD0102CNT=?,	AD0103CNT=?,	AD0104YN=?,	AD0105CNT=?, " );
				UpdateSql.append( " PENSUM=?,	INSAMT01=?,	INSAMT02=?,	INSAMT03=?,	INSAMT04=?,	 " );
				UpdateSql.append( " MEDAMT01=?,	MEDAMT02=?,	EDUAMT01=?,	EDUAMT02=?,	EDUAMT021=?, ");
				UpdateSql.append( " EDUAMT022=?,	EDUAMT023=?,	EDUAMT024=?,	EDUAMT025=?,	EDUAMT03=?, ");
				UpdateSql.append( " EDUAMT031=?,	EDUAMT032=?,	EDUAMT033=?,	EDUAMT034=?,	EDUAMT035=?,	 ");
				UpdateSql.append( " EDUAMT04=?,	EDUAMT041=?,	EDUAMT042=?,	EDUAMT043=?,	EDUAMT044=?, ");
				UpdateSql.append( " EDUAMT045=?,	EDUAMT05=?,	EDUAMT051=?,	EDUAMT052=?,	EDUAMT053=?, ");
				UpdateSql.append( " EDUAMT054=?,	EDUAMT055=?,	HOUAMT01=?,	HOUAMT02=?,	HOUAMT03=?,	 ");
				UpdateSql.append( " HOUAMT04=?,	CONAMT01=?,	CONAMT02=?,	CONAMT03=?,	CONAMT04=?, ");
				UpdateSql.append( " CONAMT05=?,	CONAMT06=?,	MARCNT01=?,	MARCNT02=?,	MARCNT03=?,	");
				UpdateSql.append( " ETCAMT011=?,	ETCAMT01=?,	ETCAMT02=?,	ETCAMT031=?,	ETCAMT032=?,	");
				UpdateSql.append( " ETCAMT033=?,	ETCAMT034=?,	ETCAMT04=?,	REDAMT01=?,	REDAMT02=?,");
				UpdateSql.append( " DEDAMT01=?,	DEDAMT02=?,	DEDAMT03=?,	DEDAMT04=?,	DEDAMT05=?, ");
				UpdateSql.append( " PB61000=? ");
			  UpdateSql.append( "  WHERE   APPDT = ?  " );
				UpdateSql.append( "       AND  EMPNO = ?  " );
				UpdateSql.append( "       AND  PAYDIV = 'Y'  " );
			
				DeleteSql = new StringBuffer();
				DeleteSql.append( "  DELETE from  PAYROLL.YCPAYCOL " );
			  DeleteSql.append( "  WHERE   APPDT = ?  " );
				DeleteSql.append( "       AND  EMPNO = ?  " );
				DeleteSql.append( "       AND  PAYDIV = 'Y'  " );

			for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

					  GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
            gsmt.setGauceDataRow(rows[j]);

						gsmt.executeUpdate();
						gsmt.close();
					}

				
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,idxBA0101YN);
						gsmt.bindColumn(2,idxBA0102CNT);
						gsmt.bindColumn(3,idxBA0103CNT);
						gsmt.bindColumn(4,idxBA0104CNT);
						gsmt.bindColumn(5,idxBA0105CNT);
						gsmt.bindColumn(6,idxAD0101CNT);
						gsmt.bindColumn(7,idxAD0102CNT);
						gsmt.bindColumn(8,idxAD0103CNT);
						gsmt.bindColumn(9,idxAD0104YN);
						gsmt.bindColumn(10,idxAD0105CNT);
						gsmt.bindColumn(11,idxPENSUM);
						gsmt.bindColumn(12,idxINSAMT01);
						gsmt.bindColumn(13,idxINSAMT02);
						gsmt.bindColumn(14,idxINSAMT03);
						gsmt.bindColumn(15,idxINSAMT04);
						gsmt.bindColumn(16,idxMEDAMT01);
						gsmt.bindColumn(17,idxMEDAMT02);
						gsmt.bindColumn(18,idxEDUAMT01);
						gsmt.bindColumn(19,idxEDUAMT02);
						gsmt.bindColumn(20,idxEDUAMT021);
						gsmt.bindColumn(21,idxEDUAMT022);
						gsmt.bindColumn(22,idxEDUAMT023);
						gsmt.bindColumn(23,idxEDUAMT024);
						gsmt.bindColumn(24,idxEDUAMT025);
						gsmt.bindColumn(25,idxEDUAMT03);
						gsmt.bindColumn(26,idxEDUAMT031);
						gsmt.bindColumn(27,idxEDUAMT032);
						gsmt.bindColumn(28,idxEDUAMT033);
						gsmt.bindColumn(29,idxEDUAMT034);
						gsmt.bindColumn(30,idxEDUAMT035);
						gsmt.bindColumn(31,idxEDUAMT04);
						gsmt.bindColumn(32,idxEDUAMT041);
						gsmt.bindColumn(33,idxEDUAMT042);
						gsmt.bindColumn(34,idxEDUAMT043);
						gsmt.bindColumn(35,idxEDUAMT044);
						gsmt.bindColumn(36,idxEDUAMT045);
						gsmt.bindColumn(37,idxEDUAMT05);
						gsmt.bindColumn(38,idxEDUAMT051);
						gsmt.bindColumn(39,idxEDUAMT052);
						gsmt.bindColumn(40,idxEDUAMT053);
						gsmt.bindColumn(41,idxEDUAMT054);
						gsmt.bindColumn(42,idxEDUAMT055);
						gsmt.bindColumn(43,idxHOUAMT01);
						gsmt.bindColumn(44,idxHOUAMT02);
						gsmt.bindColumn(45,idxHOUAMT03);
						gsmt.bindColumn(46,idxHOUAMT04);
						gsmt.bindColumn(47,idxCONAMT01);
						gsmt.bindColumn(48,idxCONAMT02);
						gsmt.bindColumn(49,idxCONAMT03);
						gsmt.bindColumn(50,idxCONAMT04);
						gsmt.bindColumn(51,idxCONAMT05);
						gsmt.bindColumn(52,idxCONAMT06);
						gsmt.bindColumn(53,idxMARCNT01);
						gsmt.bindColumn(54,idxMARCNT02);
						gsmt.bindColumn(55,idxMARCNT03);
						gsmt.bindColumn(56,idxETCAMT011);
						gsmt.bindColumn(57,idxETCAMT01);
						gsmt.bindColumn(58,idxETCAMT02);
						gsmt.bindColumn(59,idxETCAMT031);
						gsmt.bindColumn(60,idxETCAMT032);
						gsmt.bindColumn(61,idxETCAMT033);
						gsmt.bindColumn(62,idxETCAMT034);
						gsmt.bindColumn(63,idxETCAMT04);
						gsmt.bindColumn(64,idxREDAMT01);
						gsmt.bindColumn(65,idxREDAMT02);
						gsmt.bindColumn(66,idxDEDAMT01);
						gsmt.bindColumn(67,idxDEDAMT02);
						gsmt.bindColumn(68,idxDEDAMT03);
						gsmt.bindColumn(69,idxDEDAMT04);
						gsmt.bindColumn(70,idxDEDAMT05);
						gsmt.bindColumn(71,idxPB61000);
						gsmt.bindColumn(72,idxYYYY);
						gsmt.bindColumn(73,idxEMPNO);

						gsmt.executeUpdate(); 
						gsmt.close();       
                                    
					}      
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxYYYY);
						gsmt.bindColumn(2,  idxEMPNO);
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