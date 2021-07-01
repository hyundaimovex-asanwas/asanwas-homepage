package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a020006_t2 extends HttpServlet{
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

				String strchgseq="";
				String stryymmdd="";
				double dblermmlast=0; //월말환율
				double dbleravg=0;    //평균환율 
				double dblerhis=0;    //역사적환율
	        
				String strchgyy="";
				String strchgmm="";
		
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE   = userSet.indexOfColumn("FDCODE");
				int idxCHGYY    = userSet.indexOfColumn("CHGYY");
				int idxCHGMM    = userSet.indexOfColumn("CHGMM");
				int idxCHGGB    = userSet.indexOfColumn("CHGGB");
				int idxWRDT     = userSet.indexOfColumn("WRDT");
				int idxWRID     = userSet.indexOfColumn("WRID");
				int idxUPDT     = userSet.indexOfColumn("UPDT");
				int idxUPID     = userSet.indexOfColumn("UPID");
				
				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){

					dblermmlast=0; //월말환율
					dbleravg=0;    //평균환율 
					dblerhis=0;    //역사적환율
	        
					strchgyy= rows[j].getString(idxCHGYY);
					strchgmm= rows[j].getString(idxCHGMM);

					strchgyy=strchgyy+strchgmm;

					//logger.dbg.println(this,"strchgyy::"+strchgyy);

					//환율조회
					Statement stmt0 = conn.createStatement(); 
					String sql0 = " SELECT ERMMLAST, ERAVG, ERHIS, ERSTDDAT  FROM ACCOUNT.EXCRATE "
									  	+ "	 WHERE ERCODE ='02'" 
										  + "	   AND SUBSTR(ERSTDDAT,1,6)='"+strchgyy+"'" 
											+ "	   AND SUBSTR(ERSTDDAT,7,2)='00'";
					ResultSet rs0 = stmt0.executeQuery(sql0); 
					if(rs0.next()){
						 dblermmlast = rs0.getDouble(1);
						 dbleravg =  rs0.getDouble(2);
						 dblerhis =  rs0.getDouble(3);
						 stryymmdd = rs0.getString(4);
					}

					//총계정원장//////////////////////////////////////////////////////////////////////////////////

					  //역사적환율
					  String  sql1_1 = " UPDATE ACCOUNT.GENENLED SET  "
												  	+ "        EXRATE = "+dblermmlast+","
													+ "        EXRATEDT = '"+stryymmdd+"'"
													+ "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'"
													+ "    AND SUBSTR(ACTDAT,1,4) = '"+rows[j].getString(idxCHGYY)+"'"
													+ "    AND SUBSTR(ACTDAT,5,2) <= '"+rows[j].getString(idxCHGMM)+"'"
													+ "    AND EXRATEGB = '3'"  ;                     

						GauceStatement gsmt1_1 = conn.getGauceStatement(sql1_1);
						gsmt1_1.executeUpdate();
						gsmt1_1.close();

    
						//환율 * 달러 = 원화
					  String  sql1_3 = " UPDATE ACCOUNT.GENENLED SET  "
												  	+ "        FODEAMT = DEAMT*EXRATE, "
													+ "        FOCRAMT = CRAMT*EXRATE, "
													+ "        FODECASH = DECASH*EXRATE, "   
													+ "        FOCRCASH = CRCASH*EXRATE, "     
													+ "        FOEDECASH = EDECASH*EXRATE, "
													+ "        FOECRCASH = ECRCASH*EXRATE "
													+ "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'"
													+ "    AND SUBSTR(ACTDAT,1,4) = '"+rows[j].getString(idxCHGYY)+"'"
													+ "    AND SUBSTR(ACTDAT,5,2) <= '"+rows[j].getString(idxCHGMM)+"'"
													+ "    AND EXRATEGB = '3'"   ;                     
												 
						GauceStatement gsmt1_3 = conn.getGauceStatement(sql1_3);
						gsmt1_3.executeUpdate();
						gsmt1_3.close();


					//일별합계잔액//////////////////////////////////////////////////////////////////////////////////
					//역사적환율
					 String  sql2_1 = " UPDATE ACCOUNT.TOTALBAL SET  "
												  	+ "        EXRATE = "+dblermmlast+","
													+ "        EXRATEDT = '"+stryymmdd+"'"
													+ "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'"
													+ "    AND SUBSTR(ACTDAT,1,4) = '"+rows[j].getString(idxCHGYY)+"'"
													+ "    AND SUBSTR(ACTDAT,5,2) <= '"+rows[j].getString(idxCHGMM)+"'"
													+ "    AND EXRATEGB = '3'"  ;                     
												 
						GauceStatement gsmt2_1 = conn.getGauceStatement(sql2_1);
						gsmt2_1.executeUpdate();
						gsmt2_1.close();


						//환율 * 달러 = 원화
					  String  sql2_3 = " UPDATE ACCOUNT.TOTALBAL SET  "
												  	+ "        FODETOT = DETOT*EXRATE, "
													+ "        FOCRTOT = CRTOT*EXRATE, "
													+ "        FODECASH = DECASH*EXRATE, "
													+ "        FOCRCASH = CRCASH*EXRATE, "
													+ "        FOEDECASH = EDECASH*EXRATE, "
													+ "        FOECRCASH = ECRCASH*EXRATE, "
													+ "        FODEUPTOT = DEUPTOT*EXRATE, "
													+ "        FOCRUPTOT = CRUPTOT*EXRATE, "
													+ "        FODEUPCASH = DEUPCASH*EXRATE, "
													+ "        FOCRUPCASH = CRUPCASH*EXRATE "
													+ "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'"
													+ "    AND SUBSTR(ACTDAT,1,4) = '"+rows[j].getString(idxCHGYY)+"'"
													+ "    AND SUBSTR(ACTDAT,5,2) <= '"+rows[j].getString(idxCHGMM)+"'"
													+ "    AND EXRATEGB = '3'"  ;                     
												 
						GauceStatement gsmt2_3 = conn.getGauceStatement(sql2_3);
						gsmt2_3.executeUpdate();
						gsmt2_3.close();


					//일별관리항목//////////////////////////////////////////////////////////////////////////////////
					//역사적환율
					  String  sql3_1 = " UPDATE ACCOUNT.FSREFTOT SET  "
												  	+ "        EXRATE = "+dblermmlast+","
													+ "        EXRATEDT = '"+stryymmdd+"'"
													+ "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'"
													+ "    AND SUBSTR(ACTDAT,1,4) = '"+rows[j].getString(idxCHGYY)+"'"
													+ "    AND SUBSTR(ACTDAT,5,2) <= '"+rows[j].getString(idxCHGMM)+"'"
													+ "    AND EXRATEGB = '3'"  ;                     
												 
						GauceStatement gsmt3_1 = conn.getGauceStatement(sql3_1);
						gsmt3_1.executeUpdate();
						gsmt3_1.close();


						//환율 * 달러 = 원화
					  String  sql3_3 = " UPDATE ACCOUNT.FSREFTOT SET  "
												  	+ "        FODETOT = DETOT*EXRATE, "
													+ "        FOCRTOT = CRTOT*EXRATE, "
													+ "        FODEUPTOT = DEUPTOT*EXRATE, "
													+ "        FOCRUPTOT = CRUPTOT*EXRATE "
													+ "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'"
													+ "    AND SUBSTR(ACTDAT,1,4) = '"+rows[j].getString(idxCHGYY)+"'"
													+ "    AND SUBSTR(ACTDAT,5,2) <= '"+rows[j].getString(idxCHGMM)+"'"
													+ "    AND EXRATEGB = '3'"  ;                     
												 
						GauceStatement gsmt3_3 = conn.getGauceStatement(sql3_3);
						gsmt3_3.executeUpdate();
						gsmt3_3.close();

						//월별합계잔액//////////////////////////////////////////////////////////////////////////////////
						//역사적환율
					  String  sql4_1 = " UPDATE ACCOUNT.MTOTALBAL SET  "
												  	+ "        EXRATE = "+dblermmlast+","
													+ "        EXRATEDT = '"+stryymmdd+"'"
													+ "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'"
													+ "    AND SUBSTR(ACTYYMM,1,4) = '"+rows[j].getString(idxCHGYY)+"'"
													+ "    AND SUBSTR(ACTYYMM,5,2) <= '"+rows[j].getString(idxCHGMM)+"'"
													+ "    AND EXRATEGB = '3'"  ;                     
												 
						GauceStatement gsmt4_1 = conn.getGauceStatement(sql4_1);
						gsmt4_1.executeUpdate();
						gsmt4_1.close();

						//환율 * 달러 = 원화
					  String  sql4_3 = " UPDATE ACCOUNT.MTOTALBAL SET  "
												  	+ "        FODETOT = DETOT*EXRATE, "
													+ "        FOCRTOT = CRTOT*EXRATE, "
													+ "        FODECASH = DECASH*EXRATE, "
													+ "        FOCRCASH = CRCASH*EXRATE, "
													+ "        FOEDECASH = EDECASH*EXRATE, "
													+ "        FOECRCASH = ECRCASH*EXRATE, "
													+ "        FODEUPTOT = DEUPTOT*EXRATE, "
													+ "        FOCRUPTOT = CRUPTOT*EXRATE, "
													+ "        FODEUPCASH = DEUPCASH*EXRATE, "
													+ "        FOCRUPCASH = CRUPCASH*EXRATE "
													+ "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'"
													+ "    AND SUBSTR(ACTYYMM,1,4) = '"+rows[j].getString(idxCHGYY)+"'"
													+ "    AND SUBSTR(ACTYYMM,5,2) <= '"+rows[j].getString(idxCHGMM)+"'"
													+ "    AND EXRATEGB = '3'"  ;                     
												 
						GauceStatement gsmt4_3 = conn.getGauceStatement(sql4_3);
						gsmt4_3.executeUpdate();
						gsmt4_3.close();

						//월별관리항목//////////////////////////////////////////////////////////////////////////////////
						//역사적환율
					  String  sql5_1 = " UPDATE ACCOUNT.MFSREFTOT SET  "
												  	+ "        EXRATE = "+dblermmlast+","
													+ "        EXRATEDT = '"+stryymmdd+"'"
													+ "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'"
													+ "    AND SUBSTR(ACTYYMM,1,4) = '"+rows[j].getString(idxCHGYY)+"'"
													+ "    AND SUBSTR(ACTYYMM,5,2) <= '"+rows[j].getString(idxCHGMM)+"'"
													+ "    AND EXRATEGB = '3'"  ;                     
												 
						GauceStatement gsmt5_1 = conn.getGauceStatement(sql5_1);
						gsmt5_1.executeUpdate();
						gsmt5_1.close();

						//환율 * 달러 = 원화
					  String  sql5_3 = " UPDATE ACCOUNT.MFSREFTOT SET  "
												  	+ "        FODETOT = DETOT*EXRATE, "
													+ "        FOCRTOT = CRTOT*EXRATE, "
													+ "        FODEUPTOT = DEUPTOT*EXRATE, "
													+ "        FOCRUPTOT = CRUPTOT*EXRATE "
													+ "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'"
													+ "    AND SUBSTR(ACTYYMM,1,4) = '"+rows[j].getString(idxCHGYY)+"'"
													+ "    AND SUBSTR(ACTYYMM,5,2) <= '"+rows[j].getString(idxCHGMM)+"'"
													+ "    AND EXRATEGB = '3'"  ;                     
												 
						GauceStatement gsmt5_3 = conn.getGauceStatement(sql5_3);
						gsmt5_3.executeUpdate();
						gsmt5_3.close();
            

						//환율관리적용 seq 체크////////////////////////////////////////////////////////////////////////////////// 
						Statement stmt6 = conn.createStatement();
						String sql6 = " SELECT COALESCE(MAX(CHGSEQ),0)+1  FROM ACCOUNT.CHGRATE "
												+ "	 WHERE FDCODE ='"+rows[j].getString(idxFDCODE)+"'" 
												+ "	   AND CHGYY='"+rows[j].getString(idxCHGYY)+"'"
												+ "	   AND CHGMM='"+rows[j].getString(idxCHGMM)+"'"; 
								
						ResultSet rs6 = stmt6.executeQuery(sql6); 
						if(rs6.next()){
							 strchgseq = rs6.getString(1);
						}

					 int ichk = Integer.parseInt(strchgseq);		 
					 if(ichk<10) strchgseq = "0"+strchgseq;
				
				  //환율관리적용////////////////////////////////////////////////////////////////////////////////// 
						 String  sql7_1 = " INSERT INTO ACCOUNT.CHGRATE( FDCODE,	CHGYY,	CHGMM, CHGSEQ, CHGGB,	WRDT,	WRID) "
												  	+ "   VALUES ( '"+rows[j].getString(idxFDCODE)+"','"+rows[j].getString(idxCHGYY)+"',"
													+ "   '"+rows[j].getString(idxCHGMM)+"','"+strchgseq+"','Y',"
													+ "   '"+rows[j].getString(idxWRDT)+"','"+rows[j].getString(idxWRID)+"')"; 

						GauceStatement gsmt7_1 = conn.getGauceStatement(sql7_1);
						gsmt7_1.executeUpdate();
						gsmt7_1.close();
				}//for
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