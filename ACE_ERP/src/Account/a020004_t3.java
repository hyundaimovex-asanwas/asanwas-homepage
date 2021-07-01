package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a020004_t3 extends HttpServlet{
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

				String str1 = reqGauce.getParameter("v_str1");  //WRDT
				String str2 = reqGauce.getParameter("v_str2");  //WRID

				String strFdcode="";   
				String strFsdat="";    
				String strFsnbr="";    
				String strFsseq="";    
				String strAtcode="";   
				double dblDeamt=0;    
				double dblCRamt=0;    
				String strActdat="";   
				String strCocode="";  
				String strSsdat="";   
				String strSsnbr="";   
				String strDivcd="";   
				String strDeptcd="";  
				String strActyymm=""; 
				double dblDecash=0;
				double dblCrcash=0;
				String [] sFsrefcd = new String [9];
				String [] sFsrefval = new String [9];

				double dblDeupamt=0;
				double dblCrupamt=0;

				String strGubun_1="";
				double dbldetot_1=0;
				double dblcrtot_1=0;
				double dbldecash_1=0;
				double dblcrcash_1=0;
				double dblDeupamt_1=0;
				double dblCrupamt_1=0;

				String strGubun_1_1="";
				double dbldetot_1_1=0;
				double dblcrtot_1_1=0;
				double dblDeupamt_1_1=0;
				double dblCrupamt_1_1=0;

				String strGubun_2="";
				double dbldetot_2=0;
				double dblcrtot_2=0;
				double dbldecash_2=0;
				double dblcrcash_2=0;
				double dblDeupamt_2=0;
				double dblCrupamt_2=0;

				String strGubun_2_1="";
				double dbldetot_2_1=0;
				double dblcrtot_2_1=0;
				double dblDeupamt_2_1=0;
				double dblCrupamt_2_1=0;

				double icnt=0;
				double ichk=0;

				String strseq="";
				String straccsgnid="";
				String strempno="";
				String straccsgndat="";
				String straccsgnend="";
				String strfromgb="";
				String strtogb="";
				String strbigo="";

        /***************************************************************************************
         @ 총계정원장 / 관리항목원장 / 일합계잔액 / 일관리항목집계 / 월합계잔액 /월관리항목집계
				*************************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");				
				//^^logger.dbg.println(this,"step_start");

				if (userSet!= null) { // 1
					int idxFDCODE       = userSet.indexOfColumn("FDCODE");
					int idxFSDAT        = userSet.indexOfColumn("FSDAT");
					int idxFSNBR        = userSet.indexOfColumn("FSNBR");
					int idxFSSEQ        = userSet.indexOfColumn("FSSEQ");
					int idxFSNUM        = userSet.indexOfColumn("FSNUM");
					int idxATCODE       = userSet.indexOfColumn("ATCODE");
					int idxATDECR       = userSet.indexOfColumn("ATDECR");
					int idxDEAMT        = userSet.indexOfColumn("DEAMT");
					int idxCRAMT        = userSet.indexOfColumn("CRAMT");
					int idxCOCODE       = userSet.indexOfColumn("COCODE");
					int idxDIVCD        = userSet.indexOfColumn("DIVCD");
					int idxDEPTCD       = userSet.indexOfColumn("DEPTCD");
					int idxDECASH       = userSet.indexOfColumn("DECASH");
					int idxCRCASH       = userSet.indexOfColumn("CRCASH");
					int idxACTDAT       = userSet.indexOfColumn("ACTDAT");
					int idxACTYYMM      = userSet.indexOfColumn("ACTYYMM");
					int idxSSDAT        = userSet.indexOfColumn("SSDAT");
					int idxSSNBR        = userSet.indexOfColumn("SSNBR");


				  String [] strFSREFCD = new String []{"FSREFCD01","FSREFCD02","FSREFCD03","FSREFCD04","FSREFCD05",  
				                                       "FSREFCD06","FSREFCD07","FSREFCD08","FSREFCD09"}; 

				  String [] strFSREFVAL = new String []{"FSREFVAL01","FSREFVAL02","FSREFVAL03","FSREFVAL04","FSREFVAL05",  
				                                        "FSREFVAL06","FSREFVAL07","FSREFVAL08","FSREFVAL09"}; 


					int [] idxFSREFCD = new int[9];
					for (int i=0;i<strFSREFCD.length;i++){
						idxFSREFCD[i] = userSet.indexOfColumn(strFSREFCD[i]);
					}

					int [] idxFSREFVAL = new int[9];
					for (int i=0;i<strFSREFVAL.length;i++){
						idxFSREFVAL[i] = userSet.indexOfColumn(strFSREFVAL[i]);
					}

					int idxDEUPAMT      = userSet.indexOfColumn("DEUPAMT");
					int idxCRUPAMT      = userSet.indexOfColumn("CRUPAMT");

					GauceDataRow[] rows = userSet.getDataRows();


					StringBuffer InsertSql_1 = null;
					StringBuffer InsertSql_2 = null;
					StringBuffer InsertSql_3 = null;
					StringBuffer UpdateSql_3 = null;
					StringBuffer InsertSql_4 = null;
					StringBuffer UpdateSql_4 = null;
					StringBuffer InsertSql_5 = null;
					StringBuffer UpdateSql_5 = null;
					StringBuffer InsertSql_6 = null;
					StringBuffer UpdateSql_6 = null;
					
					InsertSql_1 = new StringBuffer();
					InsertSql_2 = new StringBuffer();
					InsertSql_3 = new StringBuffer();
					UpdateSql_3 = new StringBuffer();
					InsertSql_4 = new StringBuffer();
					UpdateSql_4 = new StringBuffer();
					InsertSql_5 = new StringBuffer();
					UpdateSql_5 = new StringBuffer();
					InsertSql_6 = new StringBuffer();
					UpdateSql_6 = new StringBuffer();

					InsertSql_1.append( " INSERT INTO ACCOUNT.GENENLED (" );
					InsertSql_1.append( " FDCODE,   ACTDAT,   ATCODE,   COCODE,   FSDAT," );
					InsertSql_1.append( " FSNBR,    FSSEQ,    DEAMT,    CRAMT,    DECASH,  CRCASH " );
					InsertSql_1.append( "  ) " );
					InsertSql_1.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,? ) " ); 
					
					InsertSql_2.append( " INSERT INTO ACCOUNT.GENENREF (" );
					InsertSql_2.append( " FDCODE,  FSDAT,   FSNBR,   FSSEQ,   FSREFCD, FSREFVAL, SSDAT, SSNBR  " );
					InsertSql_2.append( "  ) " );
					InsertSql_2.append( " VALUES ( ?,?,?,?,?,?,?,?) " ); 

					InsertSql_3.append( " INSERT INTO ACCOUNT.TOTALBAL (" );
					InsertSql_3.append( " FDCODE,  ACTDAT,  ATCODE,  COCODE,  DIVCD, " );
					InsertSql_3.append( " DEPTCD,  DETOT,   CRTOT,   DECASH,  CRCASH,  " );
					InsertSql_3.append( " DEUPTOT, CRUPTOT " );
					InsertSql_3.append( "  ) " );
					InsertSql_3.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?) " ); 

					UpdateSql_3.append( " UPDATE ACCOUNT.TOTALBAL SET " );
					UpdateSql_3.append( "        DETOT = ?," );
					UpdateSql_3.append( "        CRTOT = ?," );
					UpdateSql_3.append( "        DECASH =?," );
					UpdateSql_3.append( "        CRCASH= ?, " );
					UpdateSql_3.append( "        DEUPTOT =?," );
					UpdateSql_3.append( "        CRUPTOT= ? " );
					UpdateSql_3.append( "  WHERE FDCODE=?" );
					UpdateSql_3.append( "    AND ACTDAT=?" );
					UpdateSql_3.append( "    AND ATCODE=?" );
					UpdateSql_3.append( "    AND COCODE=?" );
					UpdateSql_3.append( "    AND DIVCD=?" );
					UpdateSql_3.append( "    AND DEPTCD=?" );

					InsertSql_4.append( " INSERT INTO ACCOUNT.FSREFTOT (" );
					InsertSql_4.append( " FDCODE,   ACTDAT,  ATCODE,  COCODE,  DIVCD," );
					InsertSql_4.append( " DEPTCD,   FSREFCD, FSREFVAL , DETOT,  CRTOT," );
					InsertSql_4.append( " DEUPTOT,  CRUPTOT " );
					InsertSql_4.append( "  ) " );
					InsertSql_4.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?)" ); 

					UpdateSql_4.append( " UPDATE ACCOUNT.FSREFTOT SET " );
					UpdateSql_4.append( "        DETOT = ?," );
					UpdateSql_4.append( "        CRTOT = ?," );
					UpdateSql_4.append( "        DEUPTOT = ?," );
					UpdateSql_4.append( "        CRUPTOT = ?" );
					UpdateSql_4.append( "  WHERE FDCODE=?" );
					UpdateSql_4.append( "    AND ACTDAT=?" );
					UpdateSql_4.append( "    AND ATCODE=?" );
					UpdateSql_4.append( "    AND COCODE=?" );
					UpdateSql_4.append( "    AND DIVCD=?" );
					UpdateSql_4.append( "    AND DEPTCD=?" );
					UpdateSql_4.append( "    AND FSREFCD=?" );
					UpdateSql_4.append( "    AND FSREFVAL=?" );

					InsertSql_5.append( " INSERT INTO ACCOUNT.MTOTALBAL (" );
					InsertSql_5.append( " FDCODE,  ACTYYMM,  ATCODE,  COCODE,  DIVCD, " );
					InsertSql_5.append( " DEPTCD,  DETOT,    CRTOT,   DECASH,  CRCASH, " );
					InsertSql_5.append( " DEUPTOT, CRUPTOT " );
					InsertSql_5.append( "  ) " );
					InsertSql_5.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?) " ); 

					UpdateSql_5.append( " UPDATE ACCOUNT.MTOTALBAL SET " );
					UpdateSql_5.append( "        DETOT = ?," );
					UpdateSql_5.append( "        CRTOT = ?," );
					UpdateSql_5.append( "        DECASH =?," );
					UpdateSql_5.append( "        CRCASH= ?," );
					UpdateSql_5.append( "        DEUPTOT =?," );
					UpdateSql_5.append( "        CRUPTOT= ?" );
					UpdateSql_5.append( "  WHERE FDCODE=?" );
					UpdateSql_5.append( "    AND ACTYYMM=?" );
					UpdateSql_5.append( "    AND ATCODE=?" );
					UpdateSql_5.append( "    AND COCODE=?" );
					UpdateSql_5.append( "    AND DIVCD=?" );
					UpdateSql_5.append( "    AND DEPTCD=?" );

					InsertSql_6.append( " INSERT INTO ACCOUNT.MFSREFTOT (" );
					InsertSql_6.append( " FDCODE,  ACTYYMM,  ATCODE,   COCODE,  DIVCD," );
					InsertSql_6.append( " DEPTCD,  FSREFCD,  FSREFVAL, DETOT,   CRTOT," );
					InsertSql_6.append( " DEUPTOT, CRUPTOT " );
					InsertSql_6.append( "  ) " );
					InsertSql_6.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?) " ); 

					UpdateSql_6.append( " UPDATE ACCOUNT.MFSREFTOT SET " );
					UpdateSql_6.append( "        DETOT = ?," );
					UpdateSql_6.append( "        CRTOT = ?," );
					UpdateSql_6.append( "        DEUPTOT = ?," );
					UpdateSql_6.append( "        CRUPTOT = ?" );
					UpdateSql_6.append( "  WHERE FDCODE=?" );
					UpdateSql_6.append( "    AND ACTYYMM=?" );
					UpdateSql_6.append( "    AND ATCODE=?" );
					UpdateSql_6.append( "    AND COCODE=?" );
					UpdateSql_6.append( "    AND DIVCD=?" );
					UpdateSql_6.append( "    AND DEPTCD=?" );
					UpdateSql_6.append( "    AND FSREFCD=?" );
					UpdateSql_6.append( "    AND FSREFVAL=?" );
					
					////////////////////////////////////////////////////////////////////////////////////////////
					// 전표별 조회
					////////////////////////////////////////////////////////////////////////////////////////////
					for (int j=0;j<rows.length;j++){ //2
						Statement stmt_0 = conn.createStatement();
						StringBuffer sql_0 = new StringBuffer();
						sql_0.append( " SELECT X.FDCODE, X.FSDAT, X.FSNBR, X.FSSEQ, X.ATCODE,       ");
						sql_0.append( "         X.ATDECR, X.DEAMT, X.CRAMT, MAX(X.ACTDAT)ACTDAT,MAX(X.COCODE)COCODE, ");
						sql_0.append( "         MAX(X.SSDAT)SSDAT, MAX(X.SSNBR)SSNBR, MAX(X.DIVCD)DIVCD, MAX(X.DEPTCD)DEPTCD, MAX(X.ACTYYMM)ACTYYMM, ");
						sql_0.append( "         MAX(X.FSREFCD01)FSREFCD01,  " );
						sql_0.append( "         MAX(X.FSREFCD02)FSREFCD02,  " );
						sql_0.append( "         MAX(X.FSREFCD03)FSREFCD03,  " );
						sql_0.append( "        MAX(X.FSREFCD04)FSREFCD04,   " );
						sql_0.append( "        MAX(X.FSREFCD05)FSREFCD05,   " ); 
						sql_0.append( "        MAX(X.FSREFCD06)FSREFCD06,   " );
						sql_0.append( "        MAX(X.FSREFCD07)FSREFCD07,   " );
						sql_0.append( "        MAX(X.FSREFCD08)FSREFCD08,   " );
						sql_0.append( "        MAX(X.FSREFCD09)FSREFCD09,   " );
						sql_0.append( "        MAX(X.FSREFVAL01)FSREFVAL01, " );
						sql_0.append( "        MAX(X.FSREFVAL02)FSREFVAL02, " );
						sql_0.append( "        MAX(X.FSREFVAL03)FSREFVAL03, " );
						sql_0.append( "        MAX(X.FSREFVAL04)FSREFVAL04, " );
						sql_0.append( "        MAX(X.FSREFVAL05)FSREFVAL05, " );
						sql_0.append( "        MAX(X.FSREFVAL06)FSREFVAL06, " );
						sql_0.append( "        MAX(X.FSREFVAL07)FSREFVAL07, " );
						sql_0.append( "        MAX(X.FSREFVAL08)FSREFVAL08, " );
						sql_0.append( "        MAX(X.FSREFVAL09)FSREFVAL09  " );
						sql_0.append( " FROM( " );
						sql_0.append( " 	SELECT A.FDCODE,  A.FSDAT,   A.FSNBR,   A.FSSEQ,   A.ATCODE,  A.ATDECR,  " );
						sql_0.append( " 				 B.ACTDAT, B.COCODE,   B.SSDAT,   B.SSNBR,   A.DIVCD,   SUBSTR(B.ACTDAT,1,6) ACTYYMM,  ");
						sql_0.append( " 				 CASE WHEN C.FSREFCD = '0002' THEN C.FSREFVAL ELSE '' END DEPTCD,  " );
						sql_0.append( " 				 CASE WHEN A.ATDECR='1' THEN A.FSAMT ELSE 0 END DEAMT,      " );
						sql_0.append( " 				 CASE WHEN A.ATDECR='2' THEN A.FSAMT ELSE 0 END CRAMT,      " );
						sql_0.append( " 				 CASE WHEN C.FSREFSEQ ='01' THEN C.FSREFCD END FSREFCD01,   " );
						sql_0.append( " 				 CASE WHEN C.FSREFSEQ ='02' THEN C.FSREFCD END FSREFCD02,   " );
						sql_0.append( " 				 CASE WHEN C.FSREFSEQ ='03' THEN C.FSREFCD END FSREFCD03,   " );
						sql_0.append( " 				 CASE WHEN C.FSREFSEQ ='04' THEN C.FSREFCD END FSREFCD04,   " );
						sql_0.append( " 				 CASE WHEN C.FSREFSEQ ='05' THEN C.FSREFCD END FSREFCD05,   " ); 
						sql_0.append( " 				 CASE WHEN C.FSREFSEQ ='06' THEN C.FSREFCD END FSREFCD06,   " );
						sql_0.append( " 				 CASE WHEN C.FSREFSEQ ='07' THEN C.FSREFCD END FSREFCD07,   " );
						sql_0.append( " 				 CASE WHEN C.FSREFSEQ ='08' THEN C.FSREFCD END FSREFCD08,   " );
						sql_0.append( " 				 CASE WHEN C.FSREFSEQ ='09' THEN C.FSREFCD END FSREFCD09,   " );
						sql_0.append( " 				 CASE WHEN C.FSREFSEQ ='01' THEN C.FSREFVAL END FSREFVAL01, " );
						sql_0.append( " 				 CASE WHEN C.FSREFSEQ ='02' THEN C.FSREFVAL END FSREFVAL02, " );
						sql_0.append( " 				 CASE WHEN C.FSREFSEQ ='03' THEN C.FSREFVAL END FSREFVAL03, " );
						sql_0.append( " 				 CASE WHEN C.FSREFSEQ ='04' THEN C.FSREFVAL END FSREFVAL04, " );
						sql_0.append( " 				 CASE WHEN C.FSREFSEQ ='05' THEN C.FSREFVAL END FSREFVAL05, " );
						sql_0.append( " 				 CASE WHEN C.FSREFSEQ ='06' THEN C.FSREFVAL END FSREFVAL06, " );
						sql_0.append( " 				 CASE WHEN C.FSREFSEQ ='07' THEN C.FSREFVAL END FSREFVAL07, " );
						sql_0.append( " 				 CASE WHEN C.FSREFSEQ ='08' THEN C.FSREFVAL END FSREFVAL08, " );
						sql_0.append( "				 CASE WHEN C.FSREFSEQ ='09' THEN C.FSREFVAL END FSREFVAL09   " );
						sql_0.append( "		FROM ACCOUNT.FSLIPMST B    " );
						sql_0.append( "		LEFT JOIN ACCOUNT.FSLIPDTL A ON A.FDCODE = B.FDCODE  " );
						sql_0.append( "		                            AND A.FSDAT = B.FSDAT AND A.FSNBR = B.FSNBR       " );
						sql_0.append( "		LEFT JOIN ACCOUNT.FSLIPREF C ON A.FDCODE = C.FDCODE AND A.FSDAT = C.FSDAT     " );
						sql_0.append( " 		                            AND A.FSNBR = C.FSNBR   AND A.FSSEQ = C.FSSEQ     " );
						sql_0.append( " 	WHERE A.FDCODE='"+rows[j].getString(idxFDCODE)+"'   " );
						sql_0.append( " 		AND A.FSDAT='"+rows[j].getString(idxFSDAT)+"'     " );
						sql_0.append( " 		AND A.FSNBR='"+rows[j].getString(idxFSNBR)+"'     " );
						sql_0.append( " 	)X                                                  " );
						sql_0.append( " GROUP BY X.FDCODE, X.FSDAT, X.FSNBR, X.FSSEQ, X.ATCODE, X.ATDECR, X.DEAMT,X.CRAMT " );
						sql_0.append( " ORDER BY X.FSSEQ                                                                  ");
												
						ResultSet rs_0 = stmt_0.executeQuery(sql_0.toString()); 
						
						while(rs_0.next()){
						   
							strFdcode=rs_0.getString(1);
							strFsdat=rs_0.getString(2);
							strFsnbr=rs_0.getString(3);
							strFsseq=rs_0.getString(4);
							strAtcode=rs_0.getString(5);
							dblDeamt=rs_0.getDouble(7);
							dblCRamt=rs_0.getDouble(8);
							strActdat=rs_0.getString(9);
							strCocode=rs_0.getString(10);
							strSsdat=rs_0.getString(11);
							strSsnbr=rs_0.getString(12);
							strDivcd=rs_0.getString(13);
							strDeptcd=rs_0.getString(14);
							strActyymm=rs_0.getString(15);

							rows[j].setString(idxDIVCD,strDivcd);
							rows[j].setString(idxDEPTCD,strDeptcd);
							rows[j].setString(idxACTYYMM,strActyymm);

							for (int i=0;i<9;i++){
								sFsrefcd[i] = rs_0.getString(16+i);
								if(sFsrefcd[i]==null) sFsrefcd[i] = "";
							}

							for (int i=0;i<9;i++){
								sFsrefval[i] = rs_0.getString(25+i);
								if(sFsrefval[i]==null) sFsrefval[i] = "";
							}

							dblDecash=0;
							dblCrcash=0;

							dblDeupamt=rs_0.getDouble(7);
							dblCrupamt=rs_0.getDouble(8);


							//===================
							//총계정원장 Insert
							//===================
							GauceStatement gsmt = conn.getGauceStatement(InsertSql_1.toString());
							gsmt.setGauceDataRow(rows[j]);

							rows[j].setString(idxFDCODE,strFdcode);
							rows[j].setString(idxACTDAT,strActdat);
							rows[j].setString(idxATCODE,strAtcode);
							rows[j].setString(idxCOCODE,strCocode);
							rows[j].setString(idxFSDAT,strFsdat);
							rows[j].setString(idxFSNBR,strFsnbr);
							rows[j].setString(idxFSSEQ,strFsseq);
							rows[j].setDouble(idxDEAMT,dblDeamt);
							rows[j].setDouble(idxCRAMT,dblCRamt);
							rows[j].setDouble(idxDECASH,dblDecash);
							rows[j].setDouble(idxCRCASH,dblCrcash);

							gsmt.bindColumn(1, idxFDCODE);
							gsmt.bindColumn(2, idxACTDAT);
							gsmt.bindColumn(3, idxATCODE);
							gsmt.bindColumn(4, idxCOCODE);
							gsmt.bindColumn(5, idxFSDAT);
							gsmt.bindColumn(6, idxFSNBR);
							gsmt.bindColumn(7, idxFSSEQ);
							gsmt.bindColumn(8, idxDEAMT);
							gsmt.bindColumn(9, idxCRAMT);
							gsmt.bindColumn(10,idxDECASH);
							gsmt.bindColumn(11,idxCRCASH);

							gsmt.executeUpdate();
							gsmt.close();
							
							//===========================
							//총계정원장_관리항목_insert
							//===========================
							for (int i=0;i<=8;i++){
								if(!sFsrefval[i].equals("")){
										GauceStatement gsmt2 = conn.getGauceStatement(InsertSql_2.toString());
										gsmt2.setGauceDataRow(rows[j]);

										rows[j].setString(idxFSSEQ,strFsseq);
										rows[j].setString(idxFSREFCD[i],sFsrefcd[i]);
										rows[j].setString(idxFSREFVAL[i],sFsrefval[i]);
										rows[j].setString(idxSSDAT,strSsdat);
										rows[j].setString(idxSSNBR,strSsnbr);
										
										gsmt2.bindColumn(1,idxFDCODE);
										gsmt2.bindColumn(2,idxFSDAT);
										gsmt2.bindColumn(3,idxFSNBR);
										gsmt2.bindColumn(4,idxFSSEQ);
										gsmt2.bindColumn(5,idxFSREFCD[i]);
										gsmt2.bindColumn(6,idxFSREFVAL[i]);
										gsmt2.bindColumn(7,idxSSDAT);
										gsmt2.bindColumn(8,idxSSNBR);

										gsmt2.executeUpdate();
										gsmt2.close();
								}//if
							}//for
							
							//////////////////////////////////////////////////////////////////////////////////////////////	
							//==========================   
							//일자별 합계잔액 조회
							//==========================  	
							Statement stmt_1 = null;
							ResultSet rs_1 = null;
							StringBuffer sql_1 = new StringBuffer();

							strGubun_1="";

							dbldetot_1=0;
							dblcrtot_1=0;
							dbldecash_1=0;
							dblcrcash_1=0;
							dblDeupamt_1=0;
							dblCrupamt_1=0;

							sql_1.append( " SELECT DETOT,  CRTOT,  DECASH,  CRCASH, DEUPTOT, CRUPTOT " );
							sql_1.append( "  FROM ACCOUNT.TOTALBAL  " );
							sql_1.append( "  WHERE FDCODE ='"+rows[j].getString(idxFDCODE)+"'  " );
							sql_1.append( "    AND ACTDAT ='"+rows[j].getString(idxACTDAT)+"'  " );
							sql_1.append( "    AND ATCODE ='"+rows[j].getString(idxATCODE)+"'  " );
							sql_1.append( "    AND COCODE ='"+rows[j].getString(idxCOCODE)+"'  " );
							sql_1.append( "    AND DIVCD  ='"+rows[j].getString(idxDIVCD)+"'   " );
							sql_1.append( "    AND DEPTCD ='"+rows[j].getString(idxDEPTCD)+"'  " );

							stmt_1 = conn.createStatement();
							rs_1 = stmt_1.executeQuery(sql_1.toString());

							if(rs_1.next()){
								strGubun_1="1";
								dbldetot_1=rs_1.getDouble(1);
								dblcrtot_1=rs_1.getDouble(2);
								dbldecash_1=rs_1.getDouble(3);
								dblcrcash_1=rs_1.getDouble(4);
								dblDeupamt_1=rs_1.getDouble(5);
								dblCrupamt_1=rs_1.getDouble(6);
							}
							rs_1.close();
							stmt_1.close();

							if(strGubun_1.equals("1")){ //존재함. update 
							/***************************  
							//수정
							***************************/   
								GauceStatement gsmt3 = conn.getGauceStatement(UpdateSql_3.toString());
						
								//기존금액과 현재 금액을 합산함.
								dbldetot_1 = dbldetot_1 + dblDeamt;
								dblcrtot_1 = dblcrtot_1 + dblCRamt;
								dbldecash_1 = dbldecash_1 + dblDecash;
								dblcrcash_1 = dblcrcash_1 + dblCrcash;

								dblDeupamt_1 = dblDeupamt_1 + dblDeupamt;
								dblCrupamt_1 = dblCrupamt_1 + dblCrupamt;

								rows[j].setDouble(idxDEAMT,dbldetot_1);
								rows[j].setDouble(idxCRAMT,dblcrtot_1);
								rows[j].setDouble(idxDECASH,dbldecash_1);
								rows[j].setDouble(idxCRCASH,dblcrcash_1);
								rows[j].setDouble(idxDEUPAMT,dblDeupamt_1);
								rows[j].setDouble(idxCRUPAMT,dblCrupamt_1);

							  //일자별 합계잔액 Update///////////////////
								gsmt3.setGauceDataRow(rows[j]);

								gsmt3.bindColumn(1,idxDEAMT);
								gsmt3.bindColumn(2,idxCRAMT);
								gsmt3.bindColumn(3,idxDECASH);
								gsmt3.bindColumn(4,idxCRCASH);
								gsmt3.bindColumn(5,idxDEUPAMT);
								gsmt3.bindColumn(6,idxCRUPAMT);
								gsmt3.bindColumn(7,idxFDCODE);
								gsmt3.bindColumn(8,idxACTDAT);
								gsmt3.bindColumn(9,idxATCODE);
								gsmt3.bindColumn(10,idxCOCODE);
								gsmt3.bindColumn(11,idxDIVCD);
								gsmt3.bindColumn(12,idxDEPTCD);
		
								gsmt3.executeUpdate();
								gsmt3.close();

							//일자별 관리항목 조회////////////////////////
								for (int p=0;p<=8;p++){  
									if(!sFsrefval[p].equals("")){ 
										Statement stmt_1_1 = null;
										ResultSet rs_1_1 = null;
										StringBuffer sql_1_1 = new StringBuffer();

										strGubun_1_1="0";           //합계잔액 존재유무 1-존재 , 0-없음.
										dbldetot_1_1=0;
										dblcrtot_1_1=0;
										dblDeupamt_1_1=0;
										dblCrupamt_1_1=0;

										sql_1_1.append( " SELECT DETOT,   CRTOT, DEUPTOT, CRUPTOT ");
										sql_1_1.append( "   FROM ACCOUNT.FSREFTOT  ");
										sql_1_1.append( "  WHERE FDCODE ='"+rows[j].getString(idxFDCODE)+"'  ");
										sql_1_1.append( "    AND ACTDAT ='"+rows[j].getString(idxACTDAT)+"'  "); 
										sql_1_1.append( "    AND ATCODE ='"+rows[j].getString(idxATCODE)+"'  ");
										sql_1_1.append( "    AND COCODE ='"+rows[j].getString(idxCOCODE)+"'  ");
										sql_1_1.append( "    AND DIVCD  ='"+rows[j].getString(idxDIVCD)+"'   ");
										sql_1_1.append( "    AND DEPTCD ='"+rows[j].getString(idxDEPTCD)+"'  ");
										sql_1_1.append( "    AND FSREFCD  ='"+sFsrefcd[p]+"'   ");
										sql_1_1.append( "    AND FSREFVAL ='"+sFsrefval[p]+"'  ");

										stmt_1_1 = conn.createStatement();
										rs_1_1 = stmt_1_1.executeQuery(sql_1_1.toString());

										while(rs_1_1.next())	{
											strGubun_1_1="1";
											dbldetot_1_1=rs_1_1.getDouble(1);
											dblcrtot_1_1=rs_1_1.getDouble(2);
											dblDeupamt_1_1=rs_1_1.getDouble(3);
											dblCrupamt_1_1=rs_1_1.getDouble(4);
										}
										rs_1_1.close();
										stmt_1_1.close();

										if(strGubun_1_1.equals("1")){ //존재함. update
											GauceStatement gsmt4 = conn.getGauceStatement(UpdateSql_4.toString());
						
											//기존금액과 현재 금액을 합산함.
											dbldetot_1_1 = dbldetot_1_1 + dblDeamt;  
											dblcrtot_1_1 = dblcrtot_1_1 + dblCRamt;  
											dblDeupamt_1_1 = dblDeupamt_1_1 + dblDeupamt;  
											dblCrupamt_1_1 = dblCrupamt_1_1 + dblCrupamt;  
											
											//데이타셋 재설정
											rows[j].setDouble(idxDEAMT,dbldetot_1_1);
											rows[j].setDouble(idxCRAMT,dblcrtot_1_1);
											rows[j].setString(idxFSREFCD[p],sFsrefcd[p]);
											rows[j].setString(idxFSREFVAL[p],sFsrefval[p]);
											rows[j].setDouble(idxDEUPAMT,dblDeupamt_1_1);
											rows[j].setDouble(idxCRUPAMT,dblCrupamt_1_1);
											
											gsmt4.setGauceDataRow(rows[j]);
										
											gsmt4.bindColumn(1,idxDEAMT);
											gsmt4.bindColumn(2,idxCRAMT);
											gsmt4.bindColumn(3,idxDEUPAMT);
											gsmt4.bindColumn(4,idxCRUPAMT);
											gsmt4.bindColumn(5,idxFDCODE);
											gsmt4.bindColumn(6,idxACTDAT);
											gsmt4.bindColumn(7,idxATCODE);
											gsmt4.bindColumn(8,idxCOCODE);
											gsmt4.bindColumn(9,idxDIVCD);
											gsmt4.bindColumn(10,idxDEPTCD);
											gsmt4.bindColumn(11,idxFSREFCD[p]);
											gsmt4.bindColumn(12,idxFSREFVAL[p]);

											gsmt4.executeUpdate();
											gsmt4.close();
                  
										//관리항목집계(일자별)_신규/////
										}else{ //신규 .  Insert
											GauceStatement gsmt4 = conn.getGauceStatement(InsertSql_4.toString());
											gsmt4.setGauceDataRow(rows[j]);

											//데이타셋 재설정
											rows[j].setDouble(idxDEAMT,dblDeamt);
											rows[j].setDouble(idxCRAMT,dblCRamt);
											rows[j].setString(idxFSREFCD[p],sFsrefcd[p]);
											rows[j].setString(idxFSREFVAL[p],sFsrefval[p]);
											rows[j].setDouble(idxDEUPAMT,dblDeupamt);
											rows[j].setDouble(idxCRUPAMT,dblCrupamt);

											gsmt4.bindColumn(1, idxFDCODE);
											gsmt4.bindColumn(2, idxACTDAT);
											gsmt4.bindColumn(3, idxATCODE);
											gsmt4.bindColumn(4, idxCOCODE);
											gsmt4.bindColumn(5, idxDIVCD);
											gsmt4.bindColumn(6, idxDEPTCD);
											gsmt4.bindColumn(7, idxFSREFCD[p]);
											gsmt4.bindColumn(8, idxFSREFVAL[p]);
											gsmt4.bindColumn(9, idxDEAMT);
											gsmt4.bindColumn(10,idxCRAMT);
											gsmt4.bindColumn(11, idxDEUPAMT);
											gsmt4.bindColumn(12,idxCRUPAMT);

											gsmt4.executeUpdate();
											gsmt4.close();
										}//if
									}//if(!sFsrefval[p].equals("")){
								}//for P

							}else{ 
							/***************************  
							//신규:합계잔액_일자별_신규입력
							***************************/  
								GauceStatement gsmt3 = conn.getGauceStatement(InsertSql_3.toString());
								gsmt3.setGauceDataRow(rows[j]);

								//데이타셋 재설정
								rows[j].setDouble(idxDEAMT,dblDeamt);
								rows[j].setDouble(idxCRAMT,dblCRamt);
								rows[j].setDouble(idxDECASH,dblDecash);
								rows[j].setDouble(idxCRCASH,dblCrcash);
								rows[j].setDouble(idxDEUPAMT,dblDeupamt);
								rows[j].setDouble(idxCRUPAMT,dblCrupamt);

								gsmt3.bindColumn(1, idxFDCODE);
								gsmt3.bindColumn(2, idxACTDAT);
								gsmt3.bindColumn(3, idxATCODE);
								gsmt3.bindColumn(4, idxCOCODE);
								gsmt3.bindColumn(5, idxDIVCD);
								gsmt3.bindColumn(6, idxDEPTCD);
								gsmt3.bindColumn(7, idxDEAMT);
								gsmt3.bindColumn(8, idxCRAMT);
								gsmt3.bindColumn(9, idxDECASH);
								gsmt3.bindColumn(10,idxCRCASH);
								gsmt3.bindColumn(11,idxDEUPAMT);
								gsmt3.bindColumn(12,idxCRUPAMT);
								
								gsmt3.executeUpdate();
								gsmt3.close();

								//일자별 관리항목 insert
								for (int s=0;s<=8;s++){
									if(!sFsrefval[s].equals("")){
											GauceStatement gsmt4 = conn.getGauceStatement(InsertSql_4.toString());
											gsmt4.setGauceDataRow(rows[j]);

											rows[j].setString(idxFSREFCD[s],sFsrefcd[s]);
											rows[j].setString(idxFSREFVAL[s],sFsrefval[s]);

											gsmt4.bindColumn(1, idxFDCODE);
											gsmt4.bindColumn(2, idxACTDAT);
											gsmt4.bindColumn(3, idxATCODE);
											gsmt4.bindColumn(4, idxCOCODE);
											gsmt4.bindColumn(5, idxDIVCD);
											gsmt4.bindColumn(6, idxDEPTCD);
											gsmt4.bindColumn(7, idxFSREFCD[s]);
											gsmt4.bindColumn(8, idxFSREFVAL[s]);
											gsmt4.bindColumn(9, idxDEAMT);
											gsmt4.bindColumn(10,idxCRAMT);
											gsmt4.bindColumn(11,idxDEUPAMT);
											gsmt4.bindColumn(12,idxCRUPAMT);
											
											gsmt4.executeUpdate();
											gsmt4.close();
									}//if idxFSREFCD
								}//for s
							}

            //////////////////////////////////////////////////////////////////////////////////////////////
						//================================================   
						//월별 합계잔액 조회
						//================================================
						StringBuffer sql_2 = new StringBuffer();
						Statement stmt_2 = null;
						ResultSet rs_2 = null;

				    	dbldetot_2=0;
						dblcrtot_2=0;
						dbldecash_2=0;
						dblcrcash_2=0;
						dblDeupamt_2=0;
						dblCrupamt_2=0;

						sql_2.append( " SELECT DETOT,   CRTOT,  DECASH,  CRCASH ,DEUPTOT, CRUPTOT ");
						sql_2.append( "   FROM ACCOUNT.MTOTALBAL  ");
						sql_2.append( "  WHERE FDCODE ='"+rows[j].getString(idxFDCODE)+"'  " );
						sql_2.append( "    AND ACTYYMM='"+rows[j].getString(idxACTYYMM)+"' " );
						sql_2.append( "    AND ATCODE ='"+rows[j].getString(idxATCODE)+"'  " );
						sql_2.append( "    AND COCODE ='"+rows[j].getString(idxCOCODE)+"'  " );
						sql_2.append( "    AND DIVCD  ='"+rows[j].getString(idxDIVCD)+"'   " );
						sql_2.append( "    AND DEPTCD ='"+rows[j].getString(idxDEPTCD)+"'  " );

						stmt_2 = conn.createStatement();
						rs_2 = stmt_2.executeQuery(sql_2.toString());
					
						while(rs_2.next())	{
							strGubun_2="1";
							dbldetot_2=rs_2.getDouble(1);
							dblcrtot_2=rs_2.getDouble(2);
							dbldecash_2=rs_2.getDouble(3);
							dblcrcash_2=rs_2.getDouble(4);
							dblDeupamt_2=rs_2.getDouble(5);
							dblCrupamt_2=rs_2.getDouble(6);
						}
						rs_2.close();
						stmt_2.close();

						if(strGubun_2.equals("1")){ //존재함. update 
						  
							strGubun_2="";
							GauceStatement gsmt5 = conn.getGauceStatement(UpdateSql_5.toString());      
							//기존금액과 현재 금액을 합산함.
							dbldetot_2 = dbldetot_2 + dblDeamt;
							dblcrtot_2 = dblcrtot_2 + dblCRamt;
							dbldecash_2 = dbldecash_2 + dblDecash;
							dblcrcash_2 = dblcrcash_2 + dblCrcash;
							dblDeupamt_2 = dblDeupamt_2 + dblDeupamt;
							dblCrupamt_2 = dblCrupamt_2 + dblCrupamt;
             
							//데이타셋 재설정
							rows[j].setDouble(idxDEAMT,dbldetot_2);
							rows[j].setDouble(idxCRAMT,dblcrtot_2);
							rows[j].setDouble(idxDECASH,dbldecash_2);
							rows[j].setDouble(idxCRCASH,dblcrcash_2);
							rows[j].setDouble(idxDECASH,dblDeupamt_2);
							rows[j].setDouble(idxCRCASH,dblCrupamt_2);

							gsmt5.setGauceDataRow(rows[j]);
							gsmt5.bindColumn(1,idxDEAMT);
							gsmt5.bindColumn(2,idxCRAMT);
							gsmt5.bindColumn(3,idxDECASH);
							gsmt5.bindColumn(4,idxCRCASH);
							gsmt5.bindColumn(5,idxDECASH);
							gsmt5.bindColumn(6,idxCRCASH);
							gsmt5.bindColumn(7,idxFDCODE);
							gsmt5.bindColumn(8,idxACTYYMM);
							gsmt5.bindColumn(9,idxATCODE);
							gsmt5.bindColumn(10,idxCOCODE);
							gsmt5.bindColumn(11,idxDIVCD);
							gsmt5.bindColumn(12,idxDEPTCD);

							gsmt5.executeUpdate();
							gsmt5.close();

							//관리항목집계(월별)//////////////////////////////////////////////////////////////////////////////
							for (int p2=0;p2<=8;p2++){ 
								if(!sFsrefval[p2].equals("")){ 

									StringBuffer sql_2_1 = new StringBuffer();
									Statement stmt_2_1 = null;
									ResultSet rs_2_1 = null;
									strGubun_2_1="0"; //합계잔액 존재유무 1 - 존재 , 0-없음.
									dbldetot_2_1=0;
									dblcrtot_2_1=0;

									sql_2_1.append( " SELECT DETOT,   CRTOT, DEUPTOT, CRUPTOT " );
									sql_2_1.append( "   FROM ACCOUNT.MFSREFTOT  "  );
									sql_2_1.append( "  WHERE FDCODE ='"+rows[j].getString(idxFDCODE)+"'  "  );
									sql_2_1.append( "    AND ACTYYMM ='"+rows[j].getString(idxACTYYMM)+"'  "  );
									sql_2_1.append( "    AND ATCODE ='"+rows[j].getString(idxATCODE)+"'  "  );
									sql_2_1.append( "    AND COCODE ='"+rows[j].getString(idxCOCODE)+"'  "  );
									sql_2_1.append( "    AND DIVCD  ='"+rows[j].getString(idxDIVCD)+"'   "  );
									sql_2_1.append( "    AND DEPTCD ='"+rows[j].getString(idxDEPTCD)+"'  "  );
									sql_2_1.append( "    AND FSREFCD  ='"+sFsrefcd[p2]+"'  ");
									sql_2_1.append( "   AND FSREFVAL ='"+sFsrefval[p2]+"'  ");
                 
									stmt_2_1 = conn.createStatement();
									rs_2_1 = stmt_2_1.executeQuery(sql_2_1.toString());

									while(rs_2_1.next())	{
										strGubun_2_1="1";
										dbldetot_2_1=rs_2_1.getDouble(1);
										dblcrtot_2_1=rs_2_1.getDouble(2);
										dblDeupamt_2_1=rs_2_1.getDouble(3);
										dblCrupamt_2_1=rs_2_1.getDouble(4);
									}
									rs_2_1.close();
									stmt_2_1.close();

									//관리항목집계(월별)_수정건/////
									if(strGubun_2_1.equals("1")){ //존재함. update
										strGubun_2_1="";
										GauceStatement gsmt6 = conn.getGauceStatement(UpdateSql_6.toString());
       
										//기존금액과 현재 금액을 합산함.
									  dbldetot_2_1 = dbldetot_2_1 + dblDeamt;
										dblcrtot_2_1 = dblcrtot_2_1 + dblCRamt;
										dblDeupamt_2_1 = dblDeupamt_2_1 + dblDeupamt;
										dblCrupamt_2_1 = dblCrupamt_2_1 + dblCrupamt;
									
										//데이타셋 재설정
										rows[j].setDouble(idxDEAMT,dbldetot_2_1);
										rows[j].setDouble(idxCRAMT,dblcrtot_2_1);
										rows[j].setString(idxFSREFCD[p2],sFsrefcd[p2]);
										rows[j].setString(idxFSREFVAL[p2],sFsrefval[p2]);
										rows[j].setDouble(idxDEUPAMT,dblDeupamt_2_1);
										rows[j].setDouble(idxCRUPAMT,dblCrupamt_2_1);

										gsmt6.setGauceDataRow(rows[j]);
										gsmt6.bindColumn(1,idxDEAMT);
										gsmt6.bindColumn(2,idxCRAMT);
										gsmt6.bindColumn(3,idxDEUPAMT);
										gsmt6.bindColumn(4,idxCRUPAMT);
										gsmt6.bindColumn(5,idxFDCODE);
										gsmt6.bindColumn(6,idxACTYYMM);
										gsmt6.bindColumn(7,idxATCODE);
										gsmt6.bindColumn(8,idxCOCODE);
										gsmt6.bindColumn(9,idxDIVCD);
										gsmt6.bindColumn(10,idxDEPTCD);
										gsmt6.bindColumn(11,idxFSREFCD[p2]);
										gsmt6.bindColumn(12,idxFSREFVAL[p2]);
            
										gsmt6.executeUpdate();
										gsmt6.close();
                  
									//관리항목집계(월별)_신규/////
									}else{                      //신규 .  Insert

										GauceStatement gsmt6 = conn.getGauceStatement(InsertSql_6.toString());
										gsmt6.setGauceDataRow(rows[j]);

										rows[j].setDouble(idxDEAMT,dblDeamt);
										rows[j].setDouble(idxCRAMT,dblCRamt);
										rows[j].setString(idxFSREFCD[p2],sFsrefcd[p2]);
										rows[j].setString(idxFSREFVAL[p2],sFsrefval[p2]);
										rows[j].setDouble(idxDEUPAMT,dblDeupamt);
										rows[j].setDouble(idxCRUPAMT,dblCrupamt);
                   
										gsmt6.bindColumn(1, idxFDCODE);
										gsmt6.bindColumn(2, idxACTYYMM);
										gsmt6.bindColumn(3, idxATCODE);
										gsmt6.bindColumn(4, idxCOCODE);
										gsmt6.bindColumn(5, idxDIVCD);
										gsmt6.bindColumn(6, idxDEPTCD);
										gsmt6.bindColumn(7, idxFSREFCD[p2]);
										gsmt6.bindColumn(8, idxFSREFVAL[p2]);
										gsmt6.bindColumn(9, idxDEAMT);
										gsmt6.bindColumn(10,idxCRAMT);
										gsmt6.bindColumn(11,idxDEUPAMT);
										gsmt6.bindColumn(12,idxCRUPAMT);
										
										gsmt6.executeUpdate();
										gsmt6.close();
									}//if
								}//if idxFSREFCD
							}//for p2

							//합계잔액(월별)_신규건/////
						}else{   //신규    insert
						 
							GauceStatement gsmt5 = conn.getGauceStatement(InsertSql_5.toString());
							gsmt5.setGauceDataRow(rows[j]);

							//데이타셋 재설정
							rows[j].setDouble(idxDEAMT,dblDeamt);
							rows[j].setDouble(idxCRAMT,dblCRamt);
							rows[j].setDouble(idxDECASH,dblDecash);
							rows[j].setDouble(idxCRCASH,dblCrcash);
							rows[j].setDouble(idxDEUPAMT,dblDeupamt);
							rows[j].setDouble(idxCRUPAMT,dblCrupamt);
						  
							gsmt5.bindColumn(1, idxFDCODE);
							gsmt5.bindColumn(2, idxACTYYMM);
							gsmt5.bindColumn(3, idxATCODE);
							gsmt5.bindColumn(4, idxCOCODE);
							gsmt5.bindColumn(5, idxDIVCD);
							gsmt5.bindColumn(6, idxDEPTCD);
							gsmt5.bindColumn(7, idxDEAMT);
							gsmt5.bindColumn(8, idxCRAMT);
							gsmt5.bindColumn(9, idxDECASH);
							gsmt5.bindColumn(10,idxCRCASH);
							gsmt5.bindColumn(11,idxDEUPAMT);
							gsmt5.bindColumn(12,idxCRUPAMT);
							
							gsmt5.executeUpdate();
							gsmt5.close();
					
							////관리항목집계_신규/////////////
							for (int s2=0;s2<=8;s2++){
								if(!sFsrefval[s2].equals("")){
										GauceStatement gsmt6 = conn.getGauceStatement(InsertSql_6.toString());
										gsmt6.setGauceDataRow(rows[j]);

										rows[j].setString(idxFSREFCD[s2],sFsrefcd[s2]);
										rows[j].setString(idxFSREFVAL[s2],sFsrefval[s2]);

										gsmt6.bindColumn(1, idxFDCODE);
										gsmt6.bindColumn(2, idxACTYYMM);
										gsmt6.bindColumn(3, idxATCODE);
										gsmt6.bindColumn(4, idxCOCODE);
										gsmt6.bindColumn(5, idxDIVCD);
										gsmt6.bindColumn(6, idxDEPTCD);
										gsmt6.bindColumn(7, idxFSREFCD[s2]);
										gsmt6.bindColumn(8, idxFSREFVAL[s2]);
										gsmt6.bindColumn(9, idxDEAMT);
										gsmt6.bindColumn(10,idxCRAMT);
										gsmt6.bindColumn(11,idxDEUPAMT);
										gsmt6.bindColumn(12,idxCRUPAMT);
									
										gsmt6.executeUpdate();
										gsmt6.close();
								}//if sFsrefval[s2].equals
							}//for s2
					  
						}//if 월별 수정 & 신규 구분
          
					}//(rs_0.next()){
						rs_0.close();
						stmt_0.close();


					////////////////////////////////////////////////////
					//Flag Update
					////////////////////////////////////////////////////
					if(j==0){
						  StringBuffer sql9 = new StringBuffer();
							sql9.append( " UPDATE  ACCOUNT.FSLIPMST SET " );
							sql9.append( "         FSSTAT = 'Y'"  );
							sql9.append( "  WHERE  FDCODE = '"+rows[j].getString(idxFDCODE)+"'"  );
							sql9.append( "    AND  FSDAT  = '"+rows[j].getString(idxFSDAT)+"'"  );
							sql9.append( "    AND  FSNBR  = '"+rows[j].getString(idxFSNBR)+"'" );
							GauceStatement gsmt9 = conn.getGauceStatement(sql9.toString());
							gsmt9.executeUpdate();
							gsmt9.close();

							////////////////////////////////////////////////////
							//Detail건수와 상관없이 전표번호 당 1건 저장
							////////////////////////////////////////////////////
						
								Statement stmt_10 = conn.createStatement();
								StringBuffer sql_10 = new StringBuffer();
								sql_10.append( " SELECT SEQ,ACCSGNID,  " );
								sql_10.append( "        EMPNO,ACCSGNDAT,ACCSGNEND,FROMGB,TOGB,BIGO    " );
								sql_10.append( "   FROM ACCOUNT.ACTSGNSTS  " );
								sql_10.append( "  WHERE FDCODE='"+rows[j].getString(idxFDCODE)+"'" );   
								sql_10.append( "    AND FSDAT='"+rows[j].getString(idxFSDAT)+"'" );  
								sql_10.append( "    AND FSNBR='"+rows[j].getString(idxFSNBR)+"'" );  
								sql_10.append( "     AND SEQ  = (SELECT MAX(B.SEQ) FROM ACCOUNT.ACTSGNSTS B" );
								sql_10.append( "                   WHERE  FDCODE = B.FDCODE                " );
								sql_10.append( "                     AND  FSDAT = B.FSDAT                  " );
								sql_10.append( "                     AND  FSNBR = B.FSNBR                  " );
								sql_10.append( "                     AND  B.FDCODE = '"+rows[j].getString(idxFDCODE)+"'" );
								sql_10.append( "                     AND  B.FSDAT ='"+rows[j].getString(idxFSDAT)+"'" );   
								sql_10.append( "                     AND  B.FSNBR = '"+rows[j].getString(idxFSNBR)+"')"); 

								ResultSet rs_10 = stmt_10.executeQuery(sql_10.toString()); 
								  
								if(rs_10.next()){
									strseq= rs_10.getString(1);
									straccsgnid= rs_10.getString(2);
									strempno= rs_10.getString(3);
									straccsgndat= rs_10.getString(4);
									straccsgnend="Y";
									strfromgb= "03";
									strtogb= "05";
									strbigo= rs_10.getString(8);
								}
								rs_10.close();
								stmt_10.close();

								int ichk2 = Integer.parseInt(strseq)+1;
								    strseq = String.valueOf(ichk2);
								if(ichk2<10) strseq = "0"+strseq;

								StringBuffer sql10 = new StringBuffer();
								sql10.append( "  INSERT INTO ACCOUNT.ACTSGNSTS ( " );
								sql10.append( "  FDCODE, FSDAT, FSNBR, SEQ, ACCSGNID, EMPNO, "  );
								sql10.append( "  ACCSGNDAT, ACCSGNEND, FROMGB, TOGB, BIGO, "  );
								sql10.append( "  WRDT, WRID "  );
								sql10.append( "  ) VALUES ( "  );
								sql10.append( "   '"+rows[j].getString(idxFDCODE)+"',"  );
								sql10.append( "   '"+rows[j].getString(idxFSDAT)+"',"  );
								sql10.append( "   '"+rows[j].getString(idxFSNBR)+"',"  );
								sql10.append( "   '"+strseq+"',"  );
								sql10.append( "   '"+straccsgnid+"',"  );
								sql10.append( "   '"+strempno+"',"  );
								sql10.append( "   '"+straccsgndat+"',"  );
								sql10.append( "   '"+straccsgnend+"',"  );
								sql10.append( "   '"+strfromgb+"',"  );
								sql10.append( "   '"+strtogb+"',"  );
								sql10.append( "  '"+strbigo+"',"  );
								sql10.append( "  '"+str1+"',"  );
								sql10.append( "  '"+str2+"')");

								GauceStatement gsmt10= conn.getGauceStatement(sql10.toString());
								gsmt10.executeUpdate();
								gsmt10.close();

								strseq="";
								straccsgnid="";
								strempno="";
								straccsgndat="";
								straccsgnend="";
								strfromgb="";
								strtogb="";
								strbigo="";
					}// if j=0
				}//for j
			} //if (userSet!= null) { // 1
		} //try
			catch(Exception e){
				conn.rollback();
        /*
				GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2");
				
				if (userSet2 != null) {
					resGauce.enableFirstRow(userSet2);
					
					userSet2.addDataColumn(new GauceDataColumn("FDCODE", GauceDataColumn.TB_STRING));
					userSet2.addDataColumn(new GauceDataColumn("FSDAT", GauceDataColumn.TB_STRING));
					userSet2.addDataColumn(new GauceDataColumn("FSNBR", GauceDataColumn.TB_STRING));

					GauceDataRow row = null;
					row = userSet2.newDataRow();
					row.addColumnValue(strfdcode);
					row.addColumnValue(strfsdat);
					row.addColumnValue(strfsnbr);
					userSet2.addDataRow(row);
					userSet2.flush();
				}
				*/

				///^^logger.err.println(this,"errno::"+strErrorNo);
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}
			conn.commit();
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			///^^logger.err.println(this,e);
			///^^logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}