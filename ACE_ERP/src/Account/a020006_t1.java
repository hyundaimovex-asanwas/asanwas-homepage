package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a020006_t1 extends HttpServlet{
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
	        
				String strchgyy="";
				String strchgmm="";

				//2010.03.09 추가 
				int intchgyymmfr=0;
				int intchgyymmto=0;

				String strchgyymmfr="";
				String strchgyymmto="";

				String strcocode="";
				String strdivcd="";
				String strdeptcd="";
				double dbldetot=0;
				double dblcrtot=0;
				String strmm="";
				String stryymm="";

				//역사적환율 변환관련
				String strfdcode2="";
				String stractyymm2="";
				String stratcode2="";
				String strcocode2="";
				String strdivcd2="";
				String strdeptcd2="";
				String strfsrefcd2="";
				String strfsrefval2="";
				double dbldetot2=0;
				double dblcrtot2=0;

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE   = userSet.indexOfColumn("FDCODE");
				int idxCHGYY    = userSet.indexOfColumn("CHGYY");
				int idxCHGMM    = userSet.indexOfColumn("CHGMM");
				int idxCHGGB    = userSet.indexOfColumn("CHGGB");
				int idxWRDT     = userSet.indexOfColumn("WRDT");
				int idxWRID     = userSet.indexOfColumn("WRID");
				int idxUPDT     = userSet.indexOfColumn("UPDT");
				int idxUPID     = userSet.indexOfColumn("UPID");
				int idxCHGYYMMFR = userSet.indexOfColumn("CHGYYMMFR");
				int idxCHGYYMMTO = userSet.indexOfColumn("CHGYYMMTO");
				
				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){

					dblermmlast=0; //월말환율
					dbleravg=0;    //평균환율 
	        
					strchgyy= rows[j].getString(idxCHGYY);
					strchgmm= rows[j].getString(idxCHGMM);

					strchgyy=strchgyy+strchgmm;

          
					//환율조회
					Statement stmt0 = conn.createStatement(); 
					StringBuffer sql0 = new StringBuffer();
					sql0.append( " SELECT ERMMLAST, ERAVG,ERSTDDAT  FROM ACCOUNT.EXCRATE ");
					sql0.append( "  WHERE ERCODE ='02'" );
					sql0.append( "    AND SUBSTR(ERSTDDAT,1,6)='"+strchgyy+"'" );
					sql0.append( "    AND SUBSTR(ERSTDDAT,7,2)='00'");
					
					//System.out.println("a020006_t1 : " + sql0.toString());		
					ResultSet rs0 = stmt0.executeQuery(sql0.toString()); 
					if(rs0.next()){
						 dblermmlast = rs0.getDouble(1);
						 dbleravg =  rs0.getDouble(2);
						 stryymmdd = rs0.getString(3);
					}
					rs0.close();
					stmt0.close();


					/**$$ 2010.03.03 JYS 막음 
					//총계정원장//////////////////////////////////////////////////////////////////////////////////

					  //월말환율
						StringBuffer sql1_1 = new StringBuffer();
					  sql1_1.append( " UPDATE ACCOUNT.GENENLED SET  " );
						sql1_1.append( "        EXRATE = "+dblermmlast+"," );
						sql1_1.append( "        EXRATEDT = '"+stryymmdd+"'" );
						sql1_1.append( "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'" );
						sql1_1.append( "    AND SUBSTR(ACTDAT,1,6) >= '"+rows[j].getString(idxCHGYYMMFR)+"'" );
						sql1_1.append( "    AND SUBSTR(ACTDAT,1,6) <= '"+rows[j].getString(idxCHGYYMMTO)+"'" );
						sql1_1.append( "    AND EXRATEGB = '1'" );                    
												 
						GauceStatement gsmt1_1 = conn.getGauceStatement(sql1_1.toString());
						gsmt1_1.executeUpdate();
						gsmt1_1.close();
      
						//평균환율
						StringBuffer sql1_2 = new StringBuffer();
					  sql1_2.append( " UPDATE ACCOUNT.GENENLED SET  " );
						sql1_2.append( "        EXRATE = "+dbleravg+"," );
						sql1_2.append( "        EXRATEDT = '"+stryymmdd+"'" );
						sql1_2.append( "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'" );
						sql1_2.append( "    AND SUBSTR(ACTDAT,1,6) >= '"+rows[j].getString(idxCHGYYMMFR)+"'"  );
						sql1_2.append( "    AND SUBSTR(ACTDAT,1,6) <= '"+rows[j].getString(idxCHGYYMMTO)+"'"  );
						sql1_2.append( "    AND EXRATEGB = '4'" );                     
												 
						GauceStatement gsmt1_2 = conn.getGauceStatement(sql1_2.toString());
						gsmt1_2.executeUpdate();
						gsmt1_2.close();

						//환율 * 달러 = 원화
						StringBuffer sql1_3 = new StringBuffer();
					  sql1_3.append( " UPDATE ACCOUNT.GENENLED SET  " );
						sql1_3.append( "        FODEAMT = ROUND(DEAMT*EXRATE,0), " );
						sql1_3.append( "        FOCRAMT = ROUND(CRAMT*EXRATE,0), " );
						sql1_3.append( "        FODECASH = ROUND(DECASH*EXRATE,0), " );   
						sql1_3.append( "        FOCRCASH = ROUND(CRCASH*EXRATE,0), " );   
						sql1_3.append( "        FOEDECASH = ROUND(EDECASH*EXRATE,0)," );
						sql1_3.append( "        FOECRCASH = ROUND(ECRCASH*EXRATE,0) " );
						sql1_3.append( "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'" );
						sql1_3.append( "    AND SUBSTR(ACTDAT,1,6) >= '"+rows[j].getString(idxCHGYYMMFR)+"'" );
						sql1_3.append( "    AND SUBSTR(ACTDAT,1,6) <= '"+rows[j].getString(idxCHGYYMMTO)+"'" );
						sql1_3.append( "    AND EXRATEGB IN ('1','4')" );                    
												 
						GauceStatement gsmt1_3 = conn.getGauceStatement(sql1_3.toString());
						gsmt1_3.executeUpdate();
						gsmt1_3.close();

					
					//일별합계잔액//////////////////////////////////////////////////////////////////////////////////
					//월말환율
					  StringBuffer sql2_1 = new StringBuffer();
					  sql2_1.append( "  UPDATE ACCOUNT.TOTALBAL SET  " );
						sql2_1.append( "         EXRATE = "+dblermmlast+","  );
						sql2_1.append( "         EXRATEDT = '"+stryymmdd+"'"  );
						sql2_1.append( "   WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'"  );
						sql2_1.append( "     AND SUBSTR(ACTDAT,1,6) >= '"+rows[j].getString(idxCHGYYMMFR)+"'"  );
						sql2_1.append( "     AND SUBSTR(ACTDAT,1,6) <= '"+rows[j].getString(idxCHGYYMMTO)+"'"  );
						sql2_1.append( "     AND EXRATEGB = '1'"   );                    
												 
						GauceStatement gsmt2_1 = conn.getGauceStatement(sql2_1.toString());
						gsmt2_1.executeUpdate();
						gsmt2_1.close();


						//평균환율
						StringBuffer sql2_2 = new StringBuffer();
					  sql2_2.append( " UPDATE ACCOUNT.TOTALBAL SET  " );
						sql2_2.append( "        EXRATE = "+dbleravg+"," );
						sql2_2.append( "        EXRATEDT = '"+stryymmdd+"'" );
						sql2_2.append( "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'" );
						sql2_2.append( "    AND SUBSTR(ACTDAT,1,6) >= '"+rows[j].getString(idxCHGYYMMFR)+"'"  );
						sql2_2.append( "    AND SUBSTR(ACTDAT,1,6) <= '"+rows[j].getString(idxCHGYYMMTO)+"'"  );
						sql2_2.append( "    AND EXRATEGB = '4'" );                     
												 
						GauceStatement gsmt2_2 = conn.getGauceStatement(sql2_2.toString());
						gsmt2_2.executeUpdate();
						gsmt2_2.close();

						//환율 * 달러 = 원화
						StringBuffer sql2_3 = new StringBuffer();
					  sql2_3.append( " UPDATE ACCOUNT.TOTALBAL SET  " );
						sql2_3.append( "        FODETOT = ROUND(DETOT*EXRATE,0), " );
						sql2_3.append( "        FOCRTOT = ROUND(CRTOT*EXRATE,0), " );
						sql2_3.append( "        FODECASH = ROUND(DECASH*EXRATE,0), " );
						sql2_3.append( "        FOCRCASH = ROUND(CRCASH*EXRATE,0), " );
						sql2_3.append( "        FOEDECASH = ROUND(EDECASH*EXRATE,0), " );
						sql2_3.append( "        FOECRCASH = ROUND(ECRCASH*EXRATE,0), " );
						sql2_3.append( "        FODEUPTOT = ROUND(DEUPTOT*EXRATE,0), " );
						sql2_3.append( "        FOCRUPTOT = ROUND(CRUPTOT*EXRATE,0), " );
						sql2_3.append( "        FODEUPCASH = ROUND(DEUPCASH*EXRATE,0), " );
						sql2_3.append( "        FOCRUPCASH = ROUND(CRUPCASH*EXRATE,0) " );
						sql2_3.append( "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'" );
						sql2_3.append( "    AND SUBSTR(ACTDAT,1,6) >= '"+rows[j].getString(idxCHGYYMMFR)+"'"  );
						sql2_3.append( "    AND SUBSTR(ACTDAT,1,6) <= '"+rows[j].getString(idxCHGYYMMTO)+"'"  );
						sql2_3.append( "    AND EXRATEGB IN ('1','4')"  );                     
												 
						GauceStatement gsmt2_3 = conn.getGauceStatement(sql2_3.toString());
						gsmt2_3.executeUpdate();
						gsmt2_3.close();


					//일별관리항목//////////////////////////////////////////////////////////////////////////////////
					//월말환율
					  StringBuffer sql3_1 = new StringBuffer();
					  sql3_1.append( " UPDATE ACCOUNT.FSREFTOT SET  " );
						sql3_1.append( "        EXRATE = "+dblermmlast+","  );
						sql3_1.append( "        EXRATEDT = '"+stryymmdd+"'"  );
						sql3_1.append( "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'"  );
						sql3_1.append( "    AND SUBSTR(ACTDAT,1,6) >= '"+rows[j].getString(idxCHGYYMMFR)+"'"  );
						sql3_1.append( "    AND SUBSTR(ACTDAT,1,6) <= '"+rows[j].getString(idxCHGYYMMTO)+"'"  );
						sql3_1.append( "    AND EXRATEGB = '1'"  );                     
												 
						GauceStatement gsmt3_1 = conn.getGauceStatement(sql3_1.toString());
						gsmt3_1.executeUpdate();
						gsmt3_1.close();


						//평균환율
						StringBuffer sql3_2 = new StringBuffer();
					  sql3_2.append( " UPDATE ACCOUNT.FSREFTOT SET  " );
						sql3_2.append( "        EXRATE = "+dbleravg+"," );
						sql3_2.append( "        EXRATEDT = '"+stryymmdd+"'" );
						sql3_2.append( "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'" );
						sql3_2.append( "    AND SUBSTR(ACTDAT,1,6) >= '"+rows[j].getString(idxCHGYYMMFR)+"'"  );
						sql3_2.append( "    AND SUBSTR(ACTDAT,1,6) <= '"+rows[j].getString(idxCHGYYMMTO)+"'"  );
						sql3_2.append( "    AND EXRATEGB = '4'"  );                     
												 
						GauceStatement gsmt3_2 = conn.getGauceStatement(sql3_2.toString());
						gsmt3_2.executeUpdate();
						gsmt3_2.close();

						//환율 * 달러 = 원화
						StringBuffer sql3_3 = new StringBuffer();
					  sql3_3.append( " UPDATE ACCOUNT.FSREFTOT SET  " );
						sql3_3.append( "        FODETOT = ROUND(DETOT*EXRATE,0), " );
						sql3_3.append( "        FOCRTOT = ROUND(CRTOT*EXRATE,0), " );
						sql3_3.append( "        FODEUPTOT = ROUND(DEUPTOT*EXRATE,0), " );
						sql3_3.append( "        FOCRUPTOT = ROUND(CRUPTOT*EXRATE,0) " );
						sql3_3.append( "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'" );
						sql3_3.append( "    AND SUBSTR(ACTDAT,1,6) >= '"+rows[j].getString(idxCHGYYMMFR)+"'"  );
						sql3_3.append( "    AND SUBSTR(ACTDAT,1,6) <= '"+rows[j].getString(idxCHGYYMMTO)+"'"  );
						sql3_3.append( "    AND EXRATEGB IN ('1','4')" );                    
												 
						GauceStatement gsmt3_3 = conn.getGauceStatement(sql3_3.toString());
						gsmt3_3.executeUpdate();
						gsmt3_3.close();
           		$$**/


					//월별합계잔액//////////////////////////////////////////////////////////////////////////////////
					//월말환율
						StringBuffer sql4_1 = new StringBuffer();
						sql4_1.append( " UPDATE ACCOUNT.MTOTALBAL SET  " );
						sql4_1.append( "        EXRATE = "+dblermmlast+"," );
						sql4_1.append( "        EXRATEDT = '"+stryymmdd+"'" );
						sql4_1.append( "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'" );
						sql4_1.append( "    AND ACTYYMM >= '"+rows[j].getString(idxCHGYYMMFR)+"'"  );
						sql4_1.append( "    AND ACTYYMM <= '"+rows[j].getString(idxCHGYYMMTO)+"'"  );
						sql4_1.append( "    AND EXRATEGB = '1'" );                   
					 	
						GauceStatement gsmt4_1 = conn.getGauceStatement(sql4_1.toString());
						gsmt4_1.executeUpdate();
						gsmt4_1.close();

						//평균환율
						StringBuffer sql4_2 = new StringBuffer();
						//System.out.println("sql4_1 : STEP4 ");
						sql4_2.append( " UPDATE ACCOUNT.MTOTALBAL SET  ");
						sql4_2.append( "        EXRATE = "+dbleravg+"," );
						sql4_2.append( "        EXRATEDT = '"+stryymmdd+"'" );
						sql4_2.append( "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'" );
						sql4_2.append( "    AND ACTYYMM >= '"+rows[j].getString(idxCHGYYMMFR)+"'"  );
						sql4_2.append( "    AND ACTYYMM <= '"+rows[j].getString(idxCHGYYMMTO)+"'"  );
						sql4_2.append( "    AND EXRATEGB = '4'" );                   
							
						GauceStatement gsmt4_2 = conn.getGauceStatement(sql4_2.toString());
						gsmt4_2.executeUpdate();
						gsmt4_2.close();

						//환율 * 달러 = 원화
						StringBuffer sql4_3 = new StringBuffer();
						sql4_3.append( " UPDATE ACCOUNT.MTOTALBAL SET  ");
						sql4_3.append( "        FODETOT = ROUND(DETOT*EXRATE,0), ");
						sql4_3.append( "        FOCRTOT = ROUND(CRTOT*EXRATE,0), ");
						sql4_3.append( "        FODECASH = ROUND(DECASH*EXRATE,0), ");
						sql4_3.append( "        FOCRCASH = ROUND(CRCASH*EXRATE,0), ");
						sql4_3.append( "        FOEDECASH = ROUND(EDECASH*EXRATE,0), ");
						sql4_3.append( "        FOECRCASH = ROUND(ECRCASH*EXRATE,0), ");
						sql4_3.append( "        FODEUPTOT = ROUND(DEUPTOT*EXRATE,0), ");
						sql4_3.append( "        FOCRUPTOT = ROUND(CRUPTOT*EXRATE,0), ");
						sql4_3.append( "        FODEUPCASH = ROUND(DEUPCASH*EXRATE,0), ");
						sql4_3.append( "        FOCRUPCASH = ROUND(CRUPCASH*EXRATE,0) ");
						sql4_3.append( "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'");
						sql4_3.append( "    AND ACTYYMM >= '"+rows[j].getString(idxCHGYYMMFR)+"'" );
						sql4_3.append( "    AND ACTYYMM <= '"+rows[j].getString(idxCHGYYMMTO)+"'" );
						sql4_3.append( "    AND EXRATEGB IN ('1','4')" );   
							
						GauceStatement gsmt4_3 = conn.getGauceStatement(sql4_3.toString());
						gsmt4_3.executeUpdate();
						gsmt4_3.close();

						//월별관리항목//////////////////////////////////////////////////////////////////////////////////
						//월말환율
						StringBuffer sql5_1 = new StringBuffer();
						sql5_1.append( " UPDATE ACCOUNT.MFSREFTOT SET  " );
						sql5_1.append( "        EXRATE = "+dblermmlast+"," );
						sql5_1.append( "        EXRATEDT = '"+stryymmdd+"'" );
						sql5_1.append( "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'" );
						sql5_1.append( "    AND ACTYYMM >= '"+rows[j].getString(idxCHGYYMMFR)+"'"  );
						sql5_1.append( "    AND ACTYYMM <= '"+rows[j].getString(idxCHGYYMMTO)+"'"  );
						sql5_1.append( "    AND EXRATEGB = '1'" );   
											
						GauceStatement gsmt5_1 = conn.getGauceStatement(sql5_1.toString());
						gsmt5_1.executeUpdate();
						gsmt5_1.close();


						//평균환율
						StringBuffer sql5_2 = new StringBuffer();
						sql5_2.append( " UPDATE ACCOUNT.MFSREFTOT SET  " );
						sql5_2.append( "        EXRATE = "+dbleravg+"," );
						sql5_2.append( "        EXRATEDT = '"+stryymmdd+"'" );
						sql5_2.append( "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'" );
						sql5_2.append( "    AND ACTYYMM >= '"+rows[j].getString(idxCHGYYMMFR)+"'"  );
						sql5_2.append( "    AND ACTYYMM <= '"+rows[j].getString(idxCHGYYMMTO)+"'"  );
						sql5_2.append( "    AND EXRATEGB = '4'" );                   
							
						GauceStatement gsmt5_2 = conn.getGauceStatement(sql5_2.toString());
						gsmt5_2.executeUpdate();
						gsmt5_2.close();

						//환율 * 달러 = 원화
						StringBuffer sql5_3 = new StringBuffer();
						sql5_3.append( " UPDATE ACCOUNT.MFSREFTOT SET  "  );
						sql5_3.append( "        FODETOT = ROUND(DETOT*EXRATE,0), "  ); 
						sql5_3.append( "        FOCRTOT = ROUND(CRTOT*EXRATE,0), "   );
						sql5_3.append( "        FODEUPTOT = ROUND(DEUPTOT*EXRATE,0), "  );
						sql5_3.append( "        FOCRUPTOT = ROUND(CRUPTOT*EXRATE,0) "  );
						sql5_3.append( "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'"  );
						sql5_3.append( "    AND ACTYYMM >= '"+rows[j].getString(idxCHGYYMMFR)+"'"   );
						sql5_3.append( "    AND ACTYYMM <= '"+rows[j].getString(idxCHGYYMMTO)+"'"    );
						sql5_3.append( "    AND EXRATEGB IN ('1','4')"  );  				
						
						GauceStatement gsmt5_3 = conn.getGauceStatement(sql5_3.toString());
						gsmt5_3.executeUpdate();
						gsmt5_3.close();

						/////////////////////////////////////////////////////////////////////////////////
						//2010.03.09. JYS 추가 
						//금강산의 서울지점 계정 가져오기 
						//서울의 금강산지점 금액을 가져와서 넣어야함.
						//부서정보는 모두 무시한다. 여기에 모두 입력한다.											
						//일단 첫번째행 조회 해서 거기에 UPDATE 한다.

						//금강산일경우 
						if(rows[j].getString(idxFDCODE).equals("03")){					

							//금강산의 서울지점 원화 금액을 모두 0으로 초기화
							StringBuffer sql8_1 = new StringBuffer();
							sql8_1.append( " UPDATE ACCOUNT.MTOTALBAL SET  ");
							sql8_1.append( "        FODETOT = 0,  ");
							sql8_1.append( "        FOCRTOT = 0,  ");
							sql8_1.append( "        FODEUPTOT = 0,");
							sql8_1.append( "        FOCRUPTOT = 0 ");
							sql8_1.append( "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'");
							sql8_1.append( "    AND ATCODE ='1240000' " ); 
							sql8_1.append( "    AND ACTYYMM >= '"+rows[j].getString(idxCHGYYMMFR)+"'" );
							sql8_1.append( "    AND ACTYYMM <= '"+rows[j].getString(idxCHGYYMMTO)+"'" );						
							
							GauceStatement gsmt8_1 = conn.getGauceStatement(sql8_1.toString());
							gsmt8_1.executeUpdate();
							gsmt8_1.close();

							//월
							strchgyymmfr=rows[j].getString(idxCHGYYMMFR).substring(4,6);
							strchgyymmto=rows[j].getString(idxCHGYYMMTO).substring(4,6);
							
							//logger.dbg.println(this,"strchgyymmfr::"+strchgyymmfr);
							//logger.dbg.println(this,"strchgyymmto::"+strchgyymmto);

							intchgyymmfr = Integer.parseInt(strchgyymmfr);
							intchgyymmto = Integer.parseInt(strchgyymmto);
								 
							//환율 변환 월의 수만큼 UPDATE 해야함.
							for(int k=intchgyymmfr;k<=intchgyymmto;k++){		
								if(k<10) strmm = "0"+String.valueOf(k);
								else strmm = String.valueOf(k);
								
								//변수초기화 
								strcocode="";
								strdivcd="";
								strdeptcd="";
								dbldetot=0;
								dblcrtot=0;
								stryymm="";

								//logger.dbg.println(this,"strchgyy::"+strchgyy);
								stryymm = strchgyy.substring(0,4)+strmm;
								//logger.dbg.println(this,"stryymm::"+stryymm);

								//COCODE, DIVCD, DEPTCD 가져오기 금강산의 서울지점
								Statement stmt8_2 = conn.createStatement(); 
								StringBuffer sql8_2 = new StringBuffer();

								sql8_2.append( " SELECT COCODE, DIVCD, DEPTCD ");
								sql8_2.append( "   FROM ACCOUNT.MTOTALBAL     ");
								sql8_2.append( "  WHERE FDCODE ='03'          ");
								sql8_2.append( "    AND ATCODE ='1240000'     ");
								sql8_2.append( "    AND ACTYYMM ='"+stryymm+"'");
								sql8_2.append( "    AND(DETOT<>0 OR CRTOT<>0 )");
								sql8_2.append( "    AND ROWNUM =1     ");	
								//sql8_2.append( "  FETCH FIRST 1 ROWS ONLY     ");	
							
								ResultSet rs8_2 = stmt8_2.executeQuery(sql8_2.toString()); 
								if(rs8_2.next()){
									 strcocode = rs8_2.getString(1);
									 strdivcd  = rs8_2.getString(2);
									 strdeptcd = rs8_2.getString(3);
								}
								rs8_2.close();
								stmt8_2.close();
                
								/////////////////////////////////////////////////////////////////////
								//서울의 금강산지점 금액 조회
								Statement stmt8_3 = conn.createStatement(); 
								StringBuffer sql8_3 = new StringBuffer();

								sql8_3.append( " SELECT SUM(DETOT)DETOT, SUM(CRTOT)CRTOT ");
								sql8_3.append( "   FROM ACCOUNT.MTOTALBAL                ");
								sql8_3.append( "  WHERE FDCODE ='02'                     ");
								sql8_3.append( "    AND ATCODE ='1250000'                ");
								sql8_3.append( "    AND ACTYYMM ='"+stryymm+"'           ");
							
								//System.out.println("sql8_3 : " + sql8_3.toString());
								ResultSet rs8_3 = stmt8_3.executeQuery(sql8_3.toString()); 
								if(rs8_3.next()){
									 //서울과 금강산은 차대가 바뀌어야함.
									 dbldetot = rs8_3.getDouble(2);
									 dblcrtot = rs8_3.getDouble(1);
								}
								rs8_3.close();
								stmt8_3.close();

								//금강산의 서울지점 처음에 UPDATE 함 (부서 무시함)
								StringBuffer sql8_4 = new StringBuffer();
								sql8_4.append( " UPDATE ACCOUNT.MTOTALBAL SET   ");
								sql8_4.append( "        FODETOT = "+dbldetot+", ");
								sql8_4.append( "        FOCRTOT = "+dblcrtot+"  ");
								sql8_4.append( "  WHERE FDCODE = '03' ");
								sql8_4.append( "    AND ATCODE ='1240000' " ); 
								sql8_4.append( "    AND ACTYYMM = '"+stryymm+"'"  );
								sql8_4.append( "    AND COCODE = '"+strcocode+"'" );			
								sql8_4.append( "    AND DIVCD  = '"+strdivcd+"'"  );		
								sql8_4.append( "    AND DEPTCD = '"+strdeptcd+"'" );		
														 
								//System.out.println("sql8_4 : " + sql8_4.toString());
								GauceStatement gsmt8_4 = conn.getGauceStatement(sql8_4.toString());
								gsmt8_4.executeUpdate();
								gsmt8_4.close();

								//2010.08.30 JYS
								//상위집계 후 데이터 변동시 변경
								//환율변환 적용시 상위집계상태에 UPDATE함
								//UPSTS = '4' 환율수정
								StringBuffer sql999 = new StringBuffer();
								sql999.append( " UPDATE ACCOUNT.UPSUMSTS SET   ");
								sql999.append( "        UPSTS = '4',");    
								sql999.append( "        UPID = "+rows[j].getString(idxWRDT)+",  ");
								sql999.append( "        UPDT = sysdate ");
								sql999.append( "  WHERE GUBUN='1'   ");
								sql999.append( "    AND FDCODE = '"+rows[j].getString(idxFDCODE)+"' "  ); 
								sql999.append( "    AND ACTYYMM ='"+stryymm+"'"  );
														 
								//System.out.println("sql999 : " + sql999.toString());
								GauceStatement gsmt999 = conn.getGauceStatement(sql999.toString());
								gsmt999.executeUpdate();
								gsmt999.close();

						  }//for(k=intchgyymmfr;k<=intchgyymmto;k++){

						}//if(rows[j].getString(idxFDCODE).equals("03")){	
						//============================================================================ 
						/////////////////////////////////////////////////////////////////////////////////////////////////////////

						///////////////////////////////////////////////////////////////////////////////////////////////////////// 
						//2010.04.13 JYS 추가 
						//역사적환율의 경우 결재 취소시 금액 차감로직이 없어서 여기서 대체함
						//GENENLED 중 EXRATEGB='9' 인 건을 모두 가져 와서 월집계의 원화금액에 넣는다.
						//이 때 중요한건 GENENLED의 금액은 정확해야함.

						GauceStatement gsmt8_6 = null;
						GauceStatement gsmt8_10 = null;

						//MTOTALBAL 원화변환 초기화     
						StringBuffer sql8_7 = new StringBuffer();
						sql8_7.append( " UPDATE ACCOUNT.MTOTALBAL SET  \n");
						sql8_7.append( "        FODETOT = 0,           \n");
						sql8_7.append( "        FOCRTOT = 0            \n");
						sql8_7.append( "  WHERE DETOT = 0 		         \n");
						sql8_7.append( "    AND CRTOT = 0 		         \n");
						sql8_7.append( "    AND (EXRATEGB = '9' OR (EXRATEGB = '1' AND ATCODE ='1240000')) \n");	
						sql8_7.append( "    AND ACTYYMM ='"+stryymm+"' \n ");
						sql8_7.append( "    AND FDCODE ='03' \n ");

						//logger.dbg.println(this,sql8_7.toString());
						//System.out.println("sql8_7 : " + sql8_7.toString());						 
						GauceStatement gsmt8_7 = conn.getGauceStatement(sql8_7.toString());
						gsmt8_7.executeUpdate();
						gsmt8_7.close();
           
						Statement stmt8_5 = conn.createStatement(); 
						StringBuffer sql8_5 = new StringBuffer();
						StringBuffer sql8_6 = null;
						StringBuffer sql8_10 = null;

						sql8_5.append( " SELECT A.FDCODE, SUBSTR(A.ACTDAT,1,6), A.ATCODE, A.COCODE,  ");
						sql8_5.append( "        B.DIVCD, C.FSREFVAL, SUM(FODEAMT), SUM(FOCRAMT)      ");
						sql8_5.append( "   FROM ACCOUNT.GENENLED A , ACCOUNT.FSLIPDTL B,ACCOUNT.GENENREF C ");
						/*
						sql8_5.append( "   LEFT JOIN ACCOUNT.GENENREF C ON A.FDCODE =C.FDCODE        ");
						sql8_5.append( "                              AND A.FSDAT = C.FSDAT          ");
						sql8_5.append( "                              AND A.FSNBR = C.FSNBR          ");
						sql8_5.append( "                              AND A.FSSEQ = C.FSSEQ          ");
						sql8_5.append( "                              AND C.FSREFCD ='0002'          ");
						*/
						sql8_5.append( "  WHERE A.FDCODE =B.FDCODE                                   ");
						sql8_5.append( "    AND A.FSDAT = B.FSDAT                                    ");
						sql8_5.append( "    AND A.FSNBR = B.FSNBR                                    ");
						sql8_5.append( "    AND A.FSSEQ = B.FSSEQ                                    ");
						sql8_5.append( "    AND A.FDCODE ='03'                                       ");
						sql8_5.append( "    AND A.ACTDAT LIKE '"+stryymm+"%'                         ");
						sql8_5.append( "    AND A.EXRATEGB='9'                                       ");
						sql8_5.append( "    AND A.FDCODE =C.FDCODE(+) ");
						sql8_5.append( "    AND A.FSDAT = C.FSDAT(+)  ");
						sql8_5.append( "    AND A.FSNBR = C.FSNBR(+)  ");
						sql8_5.append( "    AND A.FSSEQ = C.FSSEQ(+)  ");
						sql8_5.append( "    AND C.FSREFCD(+) ='0002'  ");
						sql8_5.append( "  GROUP BY A.FDCODE, SUBSTR(A.ACTDAT,1,6), A.ATCODE, A.COCODE, B.DIVCD, C.FSREFVAL ");

						//System.out.println("sql8_5 : " + sql8_5.toString());
						ResultSet rs8_5 = stmt8_5.executeQuery(sql8_5.toString()); 
						
						while(rs8_5.next()){
							strfdcode2=rs8_5.getString(1);
							stractyymm2=rs8_5.getString(2);
							stratcode2=rs8_5.getString(3);
							strcocode2=rs8_5.getString(4);
							strdivcd2=rs8_5.getString(5);
							strdeptcd2=rs8_5.getString(6);
							dbldetot2=rs8_5.getDouble(7);
							dblcrtot2=rs8_5.getDouble(8);

							sql8_6 = new StringBuffer();
							sql8_6.append( " UPDATE ACCOUNT.MTOTALBAL SET       \n");
							sql8_6.append( "        FODETOT = "+dbldetot2+",    \n");
							sql8_6.append( "        FOCRTOT = "+dblcrtot2+"     \n");
							sql8_6.append( "  WHERE FDCODE  = '"+strfdcode2+"'  \n");
							sql8_6.append( "    AND ACTYYMM = '"+stractyymm2+"' \n");
							sql8_6.append( "    AND ATCODE  = '"+stratcode2+"'  \n"); 
							sql8_6.append( "    AND COCODE  = '"+strcocode2+"'  \n");			
							sql8_6.append( "    AND DIVCD   = '"+strdivcd2+"'   \n");		
							sql8_6.append( "    AND DEPTCD  = '"+strdeptcd2+"'  \n");		
							sql8_6.append( "    AND EXRATEGB = '9'              \n");		

							//logger.dbg.println(this,sql8_6.toString());
							//System.out.println("sql8_6 : " + sql8_6.toString());						 
							gsmt8_6 = conn.getGauceStatement(sql8_6.toString());
							gsmt8_6.executeUpdate();
							gsmt8_6.close();
   					}
						rs8_5.close();
						stmt8_5.close();

						strfdcode2="";
						stractyymm2="";
						stratcode2="";
						strcocode2="";
						strdivcd2="";
						strdeptcd2="";
						strfsrefcd2="";
						strfsrefval2="";
						dbldetot2=0;
						dblcrtot2=0;

						//월관리항목 집계
						///////////////////////////////////////////////////////////////////////////////////////////////////////// 
						StringBuffer sql8_8 = new StringBuffer();
						sql8_8.append( " UPDATE ACCOUNT.MFSREFTOT SET  \n");
						sql8_8.append( "        FODETOT = 0,           \n");
						sql8_8.append( "        FOCRTOT = 0            \n");
						sql8_8.append( "  WHERE DETOT = 0 		         \n");
						sql8_8.append( "    AND CRTOT = 0 		         \n");
						sql8_8.append( "    AND (EXRATEGB = '9' OR (EXRATEGB = '1' AND ATCODE ='1240000')) \n");	
						sql8_8.append( "    AND ACTYYMM ='"+stryymm+"' \n ");
						sql8_8.append( "    AND FDCODE ='03' \n ");

						//System.out.println("sql8_8 : " + sql8_8.toString());
						//logger.dbg.println(this,sql8_8.toString());
						GauceStatement gsmt8_8 = conn.getGauceStatement(sql8_8.toString());
						gsmt8_8.executeUpdate();
						gsmt8_8.close();

						Statement stmt8_9 = conn.createStatement(); 
						StringBuffer sql8_9 = new StringBuffer();
						sql8_9.append( " SELECT A.FDCODE, SUBSTR(B.ACTDAT,1,6), B.ATCODE, B.COCODE,                 \n");
						sql8_9.append( "        D.DIVCD, C.FSREFVAL DEPTCD, A.FSREFCD, A.FSREFVAL,                  \n");
						sql8_9.append( "        SUM(B.FODEAMT), SUM(B.FOCRAMT)                                      \n");
						sql8_9.append( "   FROM ACCOUNT.GENENREF A, ACCOUNT.GENENLED B,                              \n");
						sql8_9.append( "        ACCOUNT.GENENREF C,ACCOUNT.FSLIPDTL D       \n");
						/*
						sql8_9.append( "   LEFT JOIN ACCOUNT.GENENREF C ON A.FDCODE = C.FDCODE                      \n");
						sql8_9.append( "                               AND A.FSDAT  = C.FSDAT                       \n");
						sql8_9.append( "                               AND A.FSNBR  = C.FSNBR                       \n");
						sql8_9.append( "                               AND A.FSSEQ  = C.FSSEQ                       \n");
						sql8_9.append( "                               AND C.FSREFCD = '0002'                       \n");
						sql8_9.append( "   LEFT JOIN ACCOUNT.FSLIPDTL D ON A.FDCODE = D.FDCODE                      \n");
						sql8_9.append( "                               AND A.FSDAT  = D.FSDAT                       \n");
						sql8_9.append( "                               AND A.FSNBR  = D.FSNBR                       \n");
						sql8_9.append( "                               AND A.FSSEQ  = D.FSSEQ                       \n");
						*/
						sql8_9.append( "  WHERE A.FDCODE =B.FDCODE                                                  \n");
						sql8_9.append( "    AND A.FSDAT = B.FSDAT                                                   \n");
						sql8_9.append( "    AND A.FSNBR = B.FSNBR                                                   \n");
						sql8_9.append( "    AND A.FSSEQ = B.FSSEQ                                                   \n");
						sql8_9.append( "    AND A.FDCODE ='03'                                                      \n");
						sql8_9.append( "    AND B.ACTDAT LIKE '"+stryymm+"%'                                        \n");
						sql8_5.append( "    AND B.EXRATEGB='9'                                                      \n");
						sql8_9.append( "    AND A.FDCODE = C.FDCODE(+) \n");
						sql8_9.append( "    AND A.FSDAT  = C.FSDAT(+)  \n");
						sql8_9.append( "    AND A.FSNBR  = C.FSNBR(+)  \n");
						sql8_9.append( "    AND A.FSSEQ  = C.FSSEQ(+)  \n");
						sql8_9.append( "    AND C.FSREFCD(+)  = '0002' \n");
						sql8_9.append( "    AND A.FDCODE = D.FDCODE(+) \n");
						sql8_9.append( "    AND A.FSDAT  = D.FSDAT(+)  \n");
						sql8_9.append( "    AND A.FSNBR  = D.FSNBR(+)  \n");
						sql8_9.append( "    AND A.FSSEQ  = D.FSSEQ(+)  \n");
						sql8_9.append( "    \n");
						sql8_9.append( "  GROUP BY A.FDCODE, SUBSTR(B.ACTDAT,1,6), B.ATCODE, B.COCODE,              \n");
						sql8_9.append( "        D.DIVCD, C.FSREFVAL , A.FSREFCD, A.FSREFVAL                         \n");
						sql8_9.append( "  ORDER BY B.ATCODE, B.COCODE, D.DIVCD, C.FSREFVAL , A.FSREFCD, A.FSREFVAL  \n");

						//System.out.println("sql8_9 : " + sql8_9.toString());
						//logger.dbg.println(this,sql8_9.toString());	
						ResultSet rs8_9 = stmt8_9.executeQuery(sql8_9.toString()); 
						while(rs8_9.next()){
							strfdcode2=rs8_9.getString(1);
							stractyymm2=rs8_9.getString(2);
							stratcode2=rs8_9.getString(3);
							strcocode2=rs8_9.getString(4);
							strdivcd2=rs8_9.getString(5);
							strdeptcd2=rs8_9.getString(6);
							strfsrefcd2=rs8_9.getString(7);
							strfsrefval2=rs8_9.getString(8);
							dbldetot2=rs8_9.getDouble(9);
							dblcrtot2=rs8_9.getDouble(10);

							sql8_10 = new StringBuffer();
							sql8_10.append( " UPDATE ACCOUNT.MFSREFTOT SET       \n");
							sql8_10.append( "        FODETOT = "+dbldetot2+",    \n");
							sql8_10.append( "        FOCRTOT = "+dblcrtot2+"     \n");
							sql8_10.append( "  WHERE FDCODE  = '"+strfdcode2+"'  \n");
							sql8_10.append( "    AND ACTYYMM = '"+stractyymm2+"' \n");
							sql8_10.append( "    AND ATCODE  = '"+stratcode2+"'  \n"); 
							sql8_10.append( "    AND COCODE  = '"+strcocode2+"'  \n");			
							sql8_10.append( "    AND DIVCD   = '"+strdivcd2+"'   \n");		
							sql8_10.append( "    AND DEPTCD  = '"+strdeptcd2+"'  \n");		
							sql8_10.append( "    AND FSREFCD = '"+strfsrefcd2+"' \n");		
							sql8_10.append( "    AND FSREFVAL= '"+strfsrefval2+"'\n");		
							sql8_10.append( "    AND EXRATEGB = '9'              \n");		

							//logger.dbg.println(this,sql8_10.toString());				 
							//System.out.println("sql8_10 : " + sql8_10.toString());
							gsmt8_10 = conn.getGauceStatement(sql8_10.toString());
							gsmt8_10.executeUpdate();
							gsmt8_10.close();

						}
						
						
						

						//환율관리적용 seq 체크////////////////////////////////////////////////////////////////////////////////// 
						Statement stmt6 = conn.createStatement();
						StringBuffer sql6 = new StringBuffer();
						sql6.append( " SELECT NVL(MAX(CHGSEQ),0)+1  FROM ACCOUNT.CHGRATE " );
						sql6.append( "	WHERE FDCODE ='"+rows[j].getString(idxFDCODE)+"'" );
						sql6.append( "	  AND CHGYY='"+rows[j].getString(idxCHGYY)+"'" );
						sql6.append( "	  AND CHGMM='"+rows[j].getString(idxCHGMM)+"'");
								
						//System.out.println("sql6 : " + sql6.toString());
						ResultSet rs6 = stmt6.executeQuery(sql6.toString()); 
						if(rs6.next()){
							 strchgseq = rs6.getString(1);
						}
						rs6.close();

					 int ichk = Integer.parseInt(strchgseq);		 
					 if(ichk<10) strchgseq = "0"+strchgseq;
				
					 //환율관리적용////////////////////////////////////////////////////////////////////////////////// 
					 StringBuffer sql7_1 = new StringBuffer();
					 sql7_1.append( " INSERT INTO ACCOUNT.CHGRATE( FDCODE,	CHGYY,	CHGMM, CHGSEQ, CHGGB,	WRDT,	WRID) " );
					 sql7_1.append( "   VALUES ( '"+rows[j].getString(idxFDCODE)+"','"+rows[j].getString(idxCHGYY)+"'," );
					 sql7_1.append( "   '"+rows[j].getString(idxCHGMM)+"','"+strchgseq+"','Y'," );
					 sql7_1.append( "   '"+rows[j].getString(idxWRDT)+"','"+rows[j].getString(idxWRID)+"')"); 

					 //System.out.println("sql7_1 : " + sql7_1.toString());
					 GauceStatement gsmt7_1 = conn.getGauceStatement(sql7_1.toString());
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