package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class  comm_up_sum_t1 extends HttpServlet{
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
			
			String strGubun_5 ="";

			
			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				for (int j=5;j<1;j--){
					logger.dbg.println(this,"j:"+j);
				}//for
					/************************************************************************************
					 @ 합계잔액 / 관리항목집계
					*************************************************************************************/
			/*		StringBuffer sql5 = new StringBuffer();
					Statement stmt5 = null;
					ResultSet rs5 = null;
					strGubun_5="0"; //합계잔액 존재유무 1 - 존재 , 0-없음.
					
					sql5.append( " SELECT FDCODE        AS FDCODE,                       ");
					sql5.append( "        ACTDAT        AS ACTDAT,                       ");
					sql5.append( "        B.ATUPCODE    AS ATUPCODE,                     ");
					sql5.append( "        COCODE        AS COCODE,                       ");
					sql5.append( "        DIVCD         AS DIVCD,                        ");
					sql5.append( "        DEPTCD        AS DEPTCD,                       ");
					sql5.append( "        SUM(DETOT)    AS DETOT,                        ");
					sql5.append( "        SUM(CRTOT)    AS CRTOT,                        ");
					sql5.append( "        SUM(DECASH)   AS DECASH,                       ");
					sql5.append( "        SUM(CRCASH)   AS CRCASH,                       ");
					sql5.append( "        SUM(DEUPTOT)  AS DEUPTOT,                      ");
					sql5.append( "        SUM(CRUPTOT)  AS CRUPTOT,                      ");
					sql5.append( "        SUM(DEUPCASH) AS DEUPCASH,                     ");
					sql5.append( "        SUM(CRUPCASH) AS CRUPCASH                      ");
					sql5.append( "   FROM ACCOUNT.TOTALBAL A,ACCOUNT.ACTCODE B           ");
					sql5.append( "  WHERE A.ATCODE = B.ATCODE                            ");
					sql5.append( "    AND (DEUPTOT <> 0 OR CRUPTOT <> 0                  ");
					sql5.append( "     OR DEUPCASH <> 0 OR CRUPCASH <> 0)                ");
					sql5.append( "    AND SUMLEVEL ='"+j+"'                              ");
					sql5.append( "    AND A.ATCODE NOT IN ('1110101','1110102')          ");
					sql5.append( "  GROUP BY FDCODE,ACTDAT,B.ATUPCODE,COCODE,DIVCD,DEPTCD");
					
					stmt5 = conn.createStatement();
					rs5 = stmt5.executeQuery(sql5.toString());

					while(rs5.next())	{
						strGubun_5="1";
						dbldetot4=rs4.getDouble(1);
						dblcrtot4=rs4.getDouble(2);
						dbldeuptot4=rs4.getDouble(3);
						dblcruptot4=rs4.getDouble(4);
					}
					*/
      //  } //j



				//GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
        /*
				int idxFDCODE       = userSet.indexOfColumn("FDCODE");
				int idxFSDAT        = userSet.indexOfColumn("FSDAT");
				int idxFSNBR        = userSet.indexOfColumn("FSNBR");
				int idxFSSEQ        = userSet.indexOfColumn("FSSEQ");
				int idxATCODE       = userSet.indexOfColumn("ATCODE");
				int idxATKORNAM     = userSet.indexOfColumn("ATKORNAM");
				int idxATDECR       = userSet.indexOfColumn("ATDECR");
				int idxREMARK       = userSet.indexOfColumn("REMARK");
				int idxCHAAMT       = userSet.indexOfColumn("CHAAMT");
				int idxDAEAMT       = userSet.indexOfColumn("DAEAMT");
				int idxCOCODE       = userSet.indexOfColumn("COCODE");
				int idxDIVCD        = userSet.indexOfColumn("DIVCD");
				int idxDEPTCD       = userSet.indexOfColumn("DEPTCD");
				int idxDECASH       = userSet.indexOfColumn("DECASH");
				int idxCRCASH       = userSet.indexOfColumn("CRCASH");
				int idxACTDAT       = userSet.indexOfColumn("ACTDAT");
				int idxACTYYMM      = userSet.indexOfColumn("ACTYYMM");
				int idxSGNDAT       = userSet.indexOfColumn("SGNDAT"); 
				int idxCHAUPAMT     = userSet.indexOfColumn("CHAUPAMT");
				int idxDAEUPAMT     = userSet.indexOfColumn("DAEUPAMT");
				int idxDEUPCASH     = userSet.indexOfColumn("DEUPCASH");
				int idxCRUPCASH     = userSet.indexOfColumn("CRUPCASH"); 
				
				String [] strFSREFSEQ = new String []{"FSREFSEQ01","FSREFSEQ02","FSREFSEQ03","FSREFSEQ04","FSREFSEQ05",  
				                                      "FSREFSEQ06","FSREFSEQ07","FSREFSEQ08","FSREFSEQ09"}; 

				String [] strFSREFCD = new String []{"FSREFCD01","FSREFCD02","FSREFCD03","FSREFCD04","FSREFCD05",  
				                                     "FSREFCD06","FSREFCD07","FSREFCD08","FSREFCD09"}; 

				String [] strFSREFVAL = new String []{"FSREFVAL01","FSREFVAL02","FSREFVAL03","FSREFVAL04","FSREFVAL05",  
				                                      "FSREFVAL06","FSREFVAL07","FSREFVAL08","FSREFVAL09"}; 

				int [] idxFSREFSEQ = new int[9];
				for (int i=0;i<strFSREFSEQ.length;i++){
					idxFSREFSEQ[i] = userSet.indexOfColumn(strFSREFSEQ[i]);
				}

        int [] idxFSREFCD = new int[9];
				for (int i=0;i<strFSREFCD.length;i++){
					idxFSREFCD[i] = userSet.indexOfColumn(strFSREFCD[i]);
				}

				int [] idxFSREFVAL = new int[9];
				for (int i=0;i<strFSREFVAL.length;i++){
					idxFSREFVAL[i] = userSet.indexOfColumn(strFSREFVAL[i]);
				}
				
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
				InsertSql_1.append( " FDCODE,  ACTDAT,  ATCODE,  COCODE,  FSDAT," );
				InsertSql_1.append( " FSNBR,   FSSEQ,   DEAMT,   CRAMT,   DECASH,  CRCASH " );
				InsertSql_1.append( "  ) " );
				InsertSql_1.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,? ) " ); 
				
        InsertSql_2.append( " INSERT INTO ACCOUNT.GENENREF (" );
				InsertSql_2.append( " FDCODE,  FSDAT,   FSNBR,   FSSEQ,   FSREFCD, FSREFVAL" );
				InsertSql_2.append( "  ) " );
				InsertSql_2.append( " VALUES ( ?,?,?,?,?,?) " ); 

				InsertSql_3.append( " INSERT INTO ACCOUNT.TOTALBAL (" );
				InsertSql_3.append( " FDCODE,  ACTDAT,  ATCODE,  COCODE,  DIVCD, " );
				InsertSql_3.append( " DEPTCD,  DETOT,   CRTOT,   DECASH,  CRCASH , " );
				InsertSql_3.append( " DEUPTOT,   CRUPTOT,   DEUPCASH,  CRUPCASH " );
				InsertSql_3.append( "  ) " );
				InsertSql_3.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?) " ); 

				UpdateSql_3.append( " UPDATE ACCOUNT.TOTALBAL SET " );
				UpdateSql_3.append( "        DETOT = ?," );
				UpdateSql_3.append( "        CRTOT = ?," );
				UpdateSql_3.append( "        DECASH =?," );
        UpdateSql_3.append( "        CRCASH= ?," );
        UpdateSql_3.append( "        DEUPTOT = ?," );
				UpdateSql_3.append( "        CRUPTOT = ?," );
				UpdateSql_3.append( "        DEUPCASH =?," );
        UpdateSql_3.append( "        CRUPCASH= ?" );
				UpdateSql_3.append( "  WHERE FDCODE=?" );
				UpdateSql_3.append( "    AND ACTDAT=?" );
				UpdateSql_3.append( "    AND ATCODE=?" );
				UpdateSql_3.append( "    AND COCODE=?" );
				UpdateSql_3.append( "    AND DIVCD=?" );
				UpdateSql_3.append( "    AND DEPTCD=?" );

				InsertSql_4.append( " INSERT INTO ACCOUNT.FSREFTOT (" );
				InsertSql_4.append( " FDCODE,  ACTDAT,  ATCODE,  COCODE,  DIVCD," );
				InsertSql_4.append( " DEPTCD,  FSREFCD, FSREFVAL , DETOT,  CRTOT," );
				InsertSql_4.append( " DEUPTOT,  CRUPTOT" );
				InsertSql_4.append( "  ) " );
				InsertSql_4.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?) " ); 

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
				InsertSql_5.append( " DEPTCD,  DETOT,   CRTOT,   DECASH,  CRCASH, " );
        InsertSql_5.append( " DEUPTOT,   CRUPTOT,   DEUPCASH,  CRUPCASH  " );
				InsertSql_5.append( "  ) " );
				InsertSql_5.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?) " ); 

				UpdateSql_5.append( " UPDATE ACCOUNT.MTOTALBAL SET " );
				UpdateSql_5.append( "        DETOT = ?," );
				UpdateSql_5.append( "        CRTOT = ?," );
				UpdateSql_5.append( "        DECASH =?," );
        UpdateSql_5.append( "        CRCASH= ?," );
				UpdateSql_5.append( "        DEUPTOT = ?," );
				UpdateSql_5.append( "        CRUPTOT = ?," );
				UpdateSql_5.append( "        DEUPCASH =?," );
        UpdateSql_5.append( "        CRUPCASH= ?" );
				UpdateSql_5.append( "  WHERE FDCODE=?" );
				UpdateSql_5.append( "    AND ACTYYMM=?" );
				UpdateSql_5.append( "    AND ATCODE=?" );
				UpdateSql_5.append( "    AND COCODE=?" );
				UpdateSql_5.append( "    AND DIVCD=?" );
				UpdateSql_5.append( "    AND DEPTCD=?" );

				InsertSql_6.append( " INSERT INTO ACCOUNT.MFSREFTOT (" );
				InsertSql_6.append( " FDCODE,  ACTYYMM,  ATCODE,  COCODE,  DIVCD," );
				InsertSql_6.append( " DEPTCD,  FSREFCD,  FSREFVAL ,   DETOT,  CRTOT," );
				InsertSql_6.append( " DEUPTOT, CRUPTOT" );
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
 
				for (int j=0;j<rows.length; j++){
					 	logger.dbg.println(this,"test");
						strfdcode = rows[j].getString(idxFDCODE);
						strfsdat  = rows[j].getString(idxFSDAT);
						strfsnbr  = rows[j].getString(idxFSNBR);
						strsgndat = rows[j].getString(idxSGNDAT);
						//logger.dbg.println(this,"strFdcode::"+strFdcode+"::strFsdat::"+strFsdat+"::strFsnbr::"+strFsnbr);
						strErrorNo = rows[j].getString(idxFDCODE)+"-"+rows[j].getString(idxFSDAT)+"-"+rows[j].getString(idxFSNBR);

            //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//총계정원장>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						logger.dbg.println(this,"step1");
            logger.dbg.println(this,"InsertSql_1.toString()"+InsertSql_1.toString());
						
						GauceStatement gsmt = conn.getGauceStatement(InsertSql_1.toString());
						gsmt.setGauceDataRow(rows[j]);
            logger.dbg.println(this,"step11111");
						logger.dbg.println(this,"idxDECASH:"+rows[j].getDouble(idxDECASH));
						logger.dbg.println(this,"idxCRCASH:"+rows[j].getDouble(idxCRCASH));
						logger.dbg.println(this,"idxACTDAT:"+rows[j].getString(idxACTDAT));
										
						gsmt.bindColumn(1, idxFDCODE);
						gsmt.bindColumn(2, idxACTDAT);
						gsmt.bindColumn(3, idxATCODE);
						gsmt.bindColumn(4, idxCOCODE);
						gsmt.bindColumn(5, idxFSDAT);
						gsmt.bindColumn(6, idxFSNBR);
						gsmt.bindColumn(7, idxFSSEQ);
						gsmt.bindColumn(8, idxCHAAMT);
						gsmt.bindColumn(9, idxDAEAMT);
						gsmt.bindColumn(10,idxDECASH);
						gsmt.bindColumn(11,idxCRCASH);

						gsmt.executeUpdate();
						gsmt.close();
             
            //총계정원장_관리항목원장//////////////////////////////////////////////////////////////////////////////
						logger.dbg.println(this,"step2");
						for (int i=0;i<=8;i++){
							logger.dbg.println(this,"step22");
							if(!rows[j].getString(idxFSREFVAL[i]).equals("")){
							
									GauceStatement gsmt2 = conn.getGauceStatement(InsertSql_2.toString());
									gsmt2.setGauceDataRow(rows[j]);
								  
									gsmt2.bindColumn(1, idxFDCODE);
									gsmt2.bindColumn(2, idxFSDAT);
									gsmt2.bindColumn(3, idxFSNBR);
									gsmt2.bindColumn(4, idxFSSEQ);
									gsmt2.bindColumn(5, idxFSREFCD[i]);
									gsmt2.bindColumn(6, idxFSREFVAL[i]);
									gsmt2.executeUpdate();
									gsmt2.close();

							}
						}

						//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
						//총계정원장 End<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
						//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

        
				    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//합계잔액(일자별)>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						logger.dbg.println(this,"step3");
            StringBuffer sql = new StringBuffer();
						Statement stmt = null;
				    ResultSet rs = null;
						strGubun_2="0"; //합계잔액 존재유무 1 - 존재 , 0-없음.
						dbldetot=0;
					  dblcrtot=0;
					  dbldecash=0;
					  dblcrcash=0;
            dbldeuptot= 0;   
						dblcruptot= 0;   
						dbldeupcash= 0;  
						dblcrupcash= 0;  
				
						sql.append( " SELECT DETOT, CRTOT, DECASH, CRCASH, DEUPTOT, CRUPTOT, DEUPCASH, CRUPCASH  ");
						sql.append( "   FROM ACCOUNT.TOTALBAL     	 ");
						sql.append( "  WHERE FDCODE ='"+rows[j].getString(idxFDCODE)+"'  ");
						sql.append( "    AND ACTDAT ='"+rows[j].getString(idxACTDAT)+"'  ");
						sql.append( "    AND ATCODE ='"+rows[j].getString(idxATCODE)+"'  ");
						sql.append( "    AND COCODE ='"+rows[j].getString(idxCOCODE)+"'  ");
						sql.append( "    AND DIVCD  ='"+rows[j].getString(idxDIVCD)+"'   ");
						sql.append( "    AND DEPTCD ='"+rows[j].getString(idxDEPTCD)+"'  ");

						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());

						while(rs.next())	{
							strGubun_2="1";
							dbldetot=rs.getDouble(1);
							dblcrtot=rs.getDouble(2);
							dbldecash=rs.getDouble(3);
							dblcrcash=rs.getDouble(4);
							dbldeuptot=rs.getDouble(5);  
						  dblcruptot=rs.getDouble(6);   
						  dbldeupcash=rs.getDouble(7);  
						  dblcrupcash=rs.getDouble(8); 
						}

						logger.dbg.println(this,"step4");

            //합계잔액(일자별)_수정건/////
						if(strGubun_2.equals("1")){ //존재함. update
							GauceStatement gsmt3 = conn.getGauceStatement(UpdateSql_3.toString());
          
					    //기존금액과 현재 금액을 합산함.
							dbldetot = dbldetot + rows[j].getDouble(idxCHAAMT);
							dblcrtot = dblcrtot + rows[j].getDouble(idxDAEAMT);
							dbldecash = dbldecash + rows[j].getDouble(idxDECASH);
							dblcrcash = dblcrcash + rows[j].getDouble(idxCRCASH);
							dbldeuptot = dbldeuptot + rows[j].getDouble(idxCHAUPAMT);
							dblcruptot = dblcruptot + rows[j].getDouble(idxDAEUPAMT);
							dbldeupcash = dbldeupcash + rows[j].getDouble(idxDEUPCASH);
							dblcrupcash = dblcrupcash + rows[j].getDouble(idxCRUPCASH);
             

              //관리항목집계가 신규일때 사용함.
							dbldetot_new= rows[j].getDouble(idxCHAAMT);
			        dblcrtot_new= rows[j].getDouble(idxDAEAMT);
							dbldecash_new= rows[j].getDouble(idxDECASH);
			        dblcrcash_new= rows[j].getDouble(idxCRCASH);
							dbldeuptot_new= rows[j].getDouble(idxCHAUPAMT);
			        dblcruptot_new= rows[j].getDouble(idxDAEUPAMT);
							dbldeupcash_new= rows[j].getDouble(idxDEUPCASH);
			        dblcrupcash_new= rows[j].getDouble(idxCRUPCASH);

              //데이타셋 재설정
							rows[j].setDouble(idxCHAAMT,dbldetot);
							rows[j].setDouble(idxDAEAMT,dblcrtot);
							rows[j].setDouble(idxDECASH,dbldecash);
							rows[j].setDouble(idxCRCASH,dblcrcash);
							rows[j].setDouble(idxCHAUPAMT,dbldeuptot);
							rows[j].setDouble(idxDAEUPAMT,dblcruptot);
							rows[j].setDouble(idxDEUPCASH,dbldeupcash);
							rows[j].setDouble(idxCRUPCASH,dblcrupcash);

							gsmt3.setGauceDataRow(rows[j]);
						
							gsmt3.bindColumn(1, idxCHAAMT);
							gsmt3.bindColumn(2, idxDAEAMT);
							gsmt3.bindColumn(3, idxDECASH);
							gsmt3.bindColumn(4, idxCRCASH);
							gsmt3.bindColumn(5, idxCHAUPAMT);
							gsmt3.bindColumn(6, idxDAEUPAMT);
							gsmt3.bindColumn(7, idxDEUPCASH);
							gsmt3.bindColumn(8, idxCRUPCASH);
							gsmt3.bindColumn(9, idxFDCODE);
							gsmt3.bindColumn(10,idxACTDAT);
							gsmt3.bindColumn(11,idxATCODE);
							gsmt3.bindColumn(12,idxCOCODE);
							gsmt3.bindColumn(13, idxDIVCD);
							gsmt3.bindColumn(14,idxDEPTCD);

							gsmt3.executeUpdate();
							gsmt3.close();

							logger.dbg.println(this,"step5");

              //관리항목집계(일자별)//////////////////////////////////////////////////////////////////////////////
							for (int p=0;p<=8;p++){
								if(!rows[j].getString(idxFSREFVAL[p]).equals("")){
                  logger.dbg.println(this,"j::"+j+":::"+rows[j].getString(idxFSREFVAL[p]));
									StringBuffer sql4 = new StringBuffer();
									Statement stmt4 = null;
									ResultSet rs4 = null;
									strGubun_4="0"; //합계잔액 존재유무 1 - 존재 , 0-없음.
									dbldetot4=0;
									dblcrtot4=0;
		
									sql4.append( " SELECT DETOT, CRTOT, DEUPTOT, CRUPTOT ");
									sql4.append( "   FROM ACCOUNT.FSREFTOT     	 ");
									sql4.append( "  WHERE FDCODE ='"+rows[j].getString(idxFDCODE)+"'  ");
									sql4.append( "    AND ACTDAT ='"+rows[j].getString(idxACTDAT)+"'  ");
									sql4.append( "    AND ATCODE ='"+rows[j].getString(idxATCODE)+"'  ");
									sql4.append( "    AND COCODE ='"+rows[j].getString(idxCOCODE)+"'  ");
									sql4.append( "    AND DIVCD  ='"+rows[j].getString(idxDIVCD)+"'   ");
									sql4.append( "    AND DEPTCD ='"+rows[j].getString(idxDEPTCD)+"'  ");
									sql4.append( "    AND FSREFCD  ='"+rows[j].getString(idxFSREFCD[p])+"'   ");
									sql4.append( "    AND FSREFVAL ='"+rows[j].getString(idxFSREFVAL[p])+"'  ");

									stmt4 = conn.createStatement();
									rs4 = stmt4.executeQuery(sql4.toString());

									while(rs4.next())	{
										strGubun_4="1";
										dbldetot4=rs4.getDouble(1);
										dblcrtot4=rs4.getDouble(2);
                    dbldeuptot4=rs4.getDouble(3);
										dblcruptot4=rs4.getDouble(4);
						
									}
                  
									logger.dbg.println(this,"dbldetot4::::"+dbldetot4);
									logger.dbg.println(this,"dblcrtot4::::"+dblcrtot4);

                  //관리항목집계(일자별)_수정건/////
									if(strGubun_4.equals("1")){ //존재함. update

                    logger.dbg.println(this,"step6+U");
										GauceStatement gsmt4 = conn.getGauceStatement(UpdateSql_4.toString());
          
										//기존금액과 현재 금액을 합산함.
										//dbldetot4 = dbldetot4 + rows[j].getDouble(idxCHAAMT);
										//dblcrtot4 = dblcrtot4 + rows[j].getDouble(idxDAEAMT);
										dbldetot4 = dbldetot4 + dbldetot_new;
										dblcrtot4 = dblcrtot4 + dblcrtot_new;
										dbldeuptot4 = dbldeuptot4 + dbldeuptot_new;
										dblcruptot4 = dblcruptot4 + dblcruptot_new;

									  logger.dbg.println(this,"dbldetot4+sum::::"+dbldetot4);
									  logger.dbg.println(this,"dblcrtot4+sum::::"+dblcrtot4);
									
										//데이타셋 재설정
										rows[j].setDouble(idxCHAAMT,dbldetot4);
										rows[j].setDouble(idxDAEAMT,dblcrtot4);
										rows[j].setDouble(idxCHAUPAMT,dbldeuptot4);
										rows[j].setDouble(idxDAEUPAMT,dblcruptot4);
										
										gsmt4.setGauceDataRow(rows[j]);
									
										gsmt4.bindColumn(1, idxCHAAMT);
										gsmt4.bindColumn(2, idxDAEAMT);
										gsmt4.bindColumn(3, idxCHAUPAMT);
										gsmt4.bindColumn(4, idxDAEUPAMT);
										gsmt4.bindColumn(5, idxFDCODE);
										gsmt4.bindColumn(6, idxACTDAT);
										gsmt4.bindColumn(7, idxATCODE);
										gsmt4.bindColumn(8, idxCOCODE);
										gsmt4.bindColumn(9, idxDIVCD);
										gsmt4.bindColumn(10, idxDEPTCD);
                    gsmt4.bindColumn(11, idxFSREFCD[p]);
										gsmt4.bindColumn(12, idxFSREFVAL[p]);
            
										gsmt4.executeUpdate();
										gsmt4.close();
                  
									//관리항목집계(일자별)_신규/////
									}else{                      //신규 .  Insert
									  logger.dbg.println(this,"step6+I");

										GauceStatement gsmt4 = conn.getGauceStatement(InsertSql_4.toString());
										gsmt4.setGauceDataRow(rows[j]);

										//데이타셋 재설정
										rows[j].setDouble(idxCHAAMT,dbldetot_new);
										rows[j].setDouble(idxDAEAMT,dblcrtot_new);
                    rows[j].setDouble(idxCHAUPAMT,dbldeuptot_new);
										rows[j].setDouble(idxDAEUPAMT,dblcruptot_new);

										gsmt4.bindColumn(1, idxFDCODE);
										gsmt4.bindColumn(2, idxACTDAT);
										gsmt4.bindColumn(3, idxATCODE);
										gsmt4.bindColumn(4, idxCOCODE);
										gsmt4.bindColumn(5, idxDIVCD);
										gsmt4.bindColumn(6, idxDEPTCD);
                    gsmt4.bindColumn(7, idxFSREFCD[p]);
										gsmt4.bindColumn(8, idxFSREFVAL[p]);
										gsmt4.bindColumn(9, idxCHAAMT);
										gsmt4.bindColumn(10,idxDAEAMT);
										gsmt4.bindColumn(11,idxCHAUPAMT);
										gsmt4.bindColumn(12,idxDAEUPAMT);
										
										gsmt4.executeUpdate();
										gsmt4.close();
									}//if
								}//if idxFSREFCD
							}//for

            //합계잔액(일자별)_신규건/////
						}else{                    //신규    insert
						  logger.dbg.println(this,"step7+I");
							GauceStatement gsmt3 = conn.getGauceStatement(InsertSql_3.toString());
							gsmt3.setGauceDataRow(rows[j]);
						
							gsmt3.bindColumn(1, idxFDCODE);
							gsmt3.bindColumn(2, idxACTDAT);
							gsmt3.bindColumn(3, idxATCODE);
							gsmt3.bindColumn(4, idxCOCODE);
							gsmt3.bindColumn(5, idxDIVCD);
							gsmt3.bindColumn(6, idxDEPTCD);
							gsmt3.bindColumn(7, idxCHAAMT);
							gsmt3.bindColumn(8, idxDAEAMT);
							gsmt3.bindColumn(9, idxDECASH);
							gsmt3.bindColumn(10,idxCRCASH);
							gsmt3.bindColumn(11,idxCHAUPAMT);
							gsmt3.bindColumn(12,idxDAEUPAMT);
							gsmt3.bindColumn(13,idxDEUPCASH);
							gsmt3.bindColumn(14,idxCRUPCASH);

							gsmt3.executeUpdate();
							gsmt3.close();

							////관리항목집계_신규/////////////
							logger.dbg.println(this,"step8+I");
							for (int s=0;s<=8;s++){
								logger.dbg.println(this,"idxFSREFCD::"+s+":::"+rows[j].getString(idxFSREFCD[s]));
								logger.dbg.println(this,"idxFSREFVAL::"+s+":::"+rows[j].getString(idxFSREFVAL[s]));
								
								if(!rows[j].getString(idxFSREFVAL[s]).equals("")){
										GauceStatement gsmt4 = conn.getGauceStatement(InsertSql_4.toString());
										gsmt4.setGauceDataRow(rows[j]);

                    logger.dbg.println(this,"chas::"+s+":::"+rows[j].getDouble(idxCHAAMT));
									  logger.dbg.println(this,"daes::"+s+":::"+rows[j].getDouble(idxDAEAMT));

										gsmt4.bindColumn(1, idxFDCODE);
										gsmt4.bindColumn(2, idxACTDAT);
										gsmt4.bindColumn(3, idxATCODE);
										gsmt4.bindColumn(4, idxCOCODE);
										gsmt4.bindColumn(5, idxDIVCD);
										gsmt4.bindColumn(6, idxDEPTCD);
										gsmt4.bindColumn(7, idxFSREFCD[s]);
										gsmt4.bindColumn(8, idxFSREFVAL[s]);
										gsmt4.bindColumn(9, idxCHAAMT);
										gsmt4.bindColumn(10,idxDAEAMT);
                    gsmt4.bindColumn(11,idxCHAUPAMT);
										gsmt4.bindColumn(12,idxDAEUPAMT);
										
										gsmt4.executeUpdate();
										gsmt4.close();
								}//if idxFSREFCD
							}//for
					  }//if
						//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
						//합계잔액(일자별) End<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
						//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

						//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//합계잔액(월별)>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
						//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

            logger.dbg.println(this,"step9");
            StringBuffer sql5 = new StringBuffer();
						Statement stmt5 = null;
				    ResultSet rs5 = null;
						strGubun_5="0"; //합계잔액 존재유무 1 - 존재 , 0-없음.
						dbldetot5=0;
					  dblcrtot5=0;
					  dbldecash5=0;
					  dblcrcash5=0;
            dbldeuptot5=0; 
						dblcruptot5=0; 
						dbldeupcash5=0;
						dblcrupcash5=0;
				
						sql5.append( " SELECT DETOT, CRTOT, DECASH, CRCASH, DEUPTOT, CRUPTOT, DEUPCASH, CRUPCASH ");
						sql5.append( "   FROM ACCOUNT.MTOTALBAL     	 ");
						sql5.append( "  WHERE FDCODE ='"+rows[j].getString(idxFDCODE)+"'  ");
						sql5.append( "    AND ACTYYMM='"+rows[j].getString(idxACTYYMM)+"' ");
						sql5.append( "    AND ATCODE ='"+rows[j].getString(idxATCODE)+"'  ");
						sql5.append( "    AND COCODE ='"+rows[j].getString(idxCOCODE)+"'  ");
						sql5.append( "    AND DIVCD  ='"+rows[j].getString(idxDIVCD)+"'   ");
						sql5.append( "    AND DEPTCD ='"+rows[j].getString(idxDEPTCD)+"'  ");

						stmt5 = conn.createStatement();
						rs5 = stmt5.executeQuery(sql5.toString());

						logger.dbg.println(this,"step10");

						while(rs5.next())	{
							strGubun_5="1";
							dbldetot5=rs5.getDouble(1);
							dblcrtot5=rs5.getDouble(2);
							dbldecash5=rs5.getDouble(3);
							dblcrcash5=rs5.getDouble(4);
              dbldeuptot5=rs5.getDouble(5); 
							dblcruptot5=rs5.getDouble(6); 
							dbldeupcash5=rs5.getDouble(7);
							dblcrupcash5=rs5.getDouble(8);
						}

						logger.dbg.println(this,"dblcrcash5 -U" + dblcrcash5);

            //합계잔액(월별)_수정건/////
						if(strGubun_5.equals("1")){ //존재함. update
						  logger.dbg.println(this,"step10 -U");
							GauceStatement gsmt5 = conn.getGauceStatement(UpdateSql_5.toString());
          
					    //기존금액과 현재 금액을 합산함.
							//dbldetot5 = dbldetot5 + rows[j].getDouble(idxCHAAMT);
							//dblcrtot5 = dblcrtot5 + rows[j].getDouble(idxDAEAMT);
							//dbldecash5 = dbldecash5 + rows[j].getDouble(idxDECASH);
							//dblcrcash5 = dblcrcash5 + rows[j].getDouble(idxCRCASH);

							dbldetot5 = dbldetot5 + dbldetot_new ;
							dblcrtot5 = dblcrtot5 + dblcrtot_new ;
							dbldecash5 = dbldecash5 + dbldecash_new ;
							dblcrcash5 = dblcrcash5 + dblcrcash_new ;
              dbldeuptot5 = dbldeuptot5 + dbldeuptot_new ;
							dblcruptot5 = dblcruptot5 + dblcruptot_new ;
							dbldeupcash5 = dbldeupcash5 + dbldeupcash_new ;
							dblcrupcash5 = dblcrupcash5 + dblcrupcash_new ;

						
							logger.dbg.println(this,"dblcrcash55 -U" + dblcrcash5);
              logger.dbg.println(this,"dblcrcash_new -U" + dblcrcash_new);

              //데이타셋 재설정
							rows[j].setDouble(idxCHAAMT,dbldetot5);
							rows[j].setDouble(idxDAEAMT,dblcrtot5);
							rows[j].setDouble(idxDECASH,dbldecash5);
							rows[j].setDouble(idxCRCASH,dblcrcash5);
              rows[j].setDouble(idxCHAUPAMT,dbldeuptot5);
							rows[j].setDouble(idxDAEUPAMT,dblcruptot5);
							rows[j].setDouble(idxDEUPCASH,dbldeupcash5);
							rows[j].setDouble(idxCRUPCASH,dblcrupcash5);

							gsmt5.setGauceDataRow(rows[j]);
						
							gsmt5.bindColumn(1, idxCHAAMT);
							gsmt5.bindColumn(2, idxDAEAMT);
							gsmt5.bindColumn(3, idxDECASH);
							gsmt5.bindColumn(4, idxCRCASH);
              gsmt5.bindColumn(5, idxCHAUPAMT);
							gsmt5.bindColumn(6, idxDAEUPAMT);
							gsmt5.bindColumn(7, idxDEUPCASH);
							gsmt5.bindColumn(8, idxCRUPCASH);
							gsmt5.bindColumn(9, idxFDCODE);
							gsmt5.bindColumn(10,idxACTYYMM);
							gsmt5.bindColumn(11,idxATCODE);
							gsmt5.bindColumn(12,idxCOCODE);
							gsmt5.bindColumn(13,idxDIVCD);
							gsmt5.bindColumn(14,idxDEPTCD);

							gsmt5.executeUpdate();
							gsmt5.close();

							logger.dbg.println(this,"step11");

              //관리항목집계(월별)//////////////////////////////////////////////////////////////////////////////
							for (int p2=0;p2<=8;p2++){
								if(!rows[j].getString(idxFSREFVAL[p2]).equals("")){

									logger.dbg.println(this,"step11 -I");
									StringBuffer sql6 = new StringBuffer();
									Statement stmt6 = null;
									ResultSet rs6 = null;
									strGubun_6="0"; //합계잔액 존재유무 1 - 존재 , 0-없음.
									dbldetot6=0;
									dblcrtot6=0;
									dbldeuptot6= 0;
			            dblcruptot6= 0;
		
									sql6.append( " SELECT DETOT, CRTOT, DEUPTOT, CRUPTOT ");
									sql6.append( "   FROM ACCOUNT.MFSREFTOT     	 ");
									sql6.append( "  WHERE FDCODE ='"+rows[j].getString(idxFDCODE)+"'  ");
									sql6.append( "    AND ACTYYMM ='"+rows[j].getString(idxACTYYMM)+"'  ");
									sql6.append( "    AND ATCODE ='"+rows[j].getString(idxATCODE)+"'  ");
									sql6.append( "    AND COCODE ='"+rows[j].getString(idxCOCODE)+"'  ");
									sql6.append( "    AND DIVCD  ='"+rows[j].getString(idxDIVCD)+"'   ");
									sql6.append( "    AND DEPTCD ='"+rows[j].getString(idxDEPTCD)+"'  ");
									sql6.append( "    AND FSREFCD  ='"+rows[j].getString(idxFSREFCD[p2])+"'   ");
									sql6.append( "    AND FSREFVAL ='"+rows[j].getString(idxFSREFVAL[p2])+"'  ");

									stmt6 = conn.createStatement();
									rs6 = stmt6.executeQuery(sql6.toString());

									while(rs6.next())	{
										strGubun_6="1";
										dbldetot6=rs6.getDouble(1);
										dblcrtot6=rs6.getDouble(2);
										dbldeuptot6= rs6.getDouble(3);
			              dblcruptot6= rs6.getDouble(4);
									}

									logger.dbg.println(this,"step12 -I");


                  //관리항목집계(월별)_수정건/////
									if(strGubun_6.equals("1")){ //존재함. update
                    logger.dbg.println(this,"step12 -U");

										GauceStatement gsmt6 = conn.getGauceStatement(UpdateSql_6.toString());
          
										//기존금액과 현재 금액을 합산함.
										//dbldetot6 = dbldetot6 + rows[j].getDouble(idxCHAAMT);
										//dblcrtot6 = dblcrtot6 + rows[j].getDouble(idxDAEAMT);
									  dbldetot6 = dbldetot6 + dbldetot_new;
										dblcrtot6 = dblcrtot6 + dblcrtot_new;
										dbldeuptot6 = dbldeuptot6 + dbldeuptot_new;
										dblcruptot6 = dblcruptot6 + dblcruptot_new;

										//데이타셋 재설정
										rows[j].setDouble(idxCHAAMT,dbldetot6);
										rows[j].setDouble(idxDAEAMT,dblcrtot6);
										rows[j].setDouble(idxCHAUPAMT,dbldeuptot6);
										rows[j].setDouble(idxDAEUPAMT,dblcruptot6);

										gsmt6.setGauceDataRow(rows[j]);
										gsmt6.bindColumn(1, idxCHAAMT);
										gsmt6.bindColumn(2, idxDAEAMT);
                    gsmt6.bindColumn(3, idxCHAUPAMT);
										gsmt6.bindColumn(4, idxDAEUPAMT);
										gsmt6.bindColumn(5, idxFDCODE);
										gsmt6.bindColumn(6, idxACTYYMM);
										gsmt6.bindColumn(7, idxATCODE);
										gsmt6.bindColumn(8, idxCOCODE);
										gsmt6.bindColumn(9, idxDIVCD);
										gsmt6.bindColumn(10, idxDEPTCD);
                    gsmt6.bindColumn(11, idxFSREFCD[p2]);
										gsmt6.bindColumn(12, idxFSREFVAL[p2]);
            
										gsmt6.executeUpdate();
										gsmt6.close();
                  
									//관리항목집계(월별)_신규/////
									}else{                      //신규 .  Insert
									  logger.dbg.println(this,"step13 -I");

										GauceStatement gsmt6 = conn.getGauceStatement(InsertSql_6.toString());
										gsmt6.setGauceDataRow(rows[j]);

							      rows[j].setDouble(idxCHAAMT,dbldetot_new);
										rows[j].setDouble(idxDAEAMT,dblcrtot_new);
                    rows[j].setDouble(idxCHAUPAMT,dbldeupcash_new);
										rows[j].setDouble(idxDAEUPAMT,dblcrupcash_new);

										gsmt6.bindColumn(1, idxFDCODE);
										gsmt6.bindColumn(2, idxACTYYMM);
										gsmt6.bindColumn(3, idxATCODE);
										gsmt6.bindColumn(4, idxCOCODE);
										gsmt6.bindColumn(5, idxDIVCD);
										gsmt6.bindColumn(6, idxDEPTCD);
                    gsmt6.bindColumn(7, idxFSREFCD[p2]);
										gsmt6.bindColumn(8, idxFSREFVAL[p2]);
										gsmt6.bindColumn(9, idxCHAAMT);
										gsmt6.bindColumn(10,idxDAEAMT);
										gsmt6.bindColumn(11,idxCHAUPAMT);
										gsmt6.bindColumn(12,idxDAEUPAMT);
										
										gsmt6.executeUpdate();
										gsmt6.close();
									}//if
								}//if idxFSREFCD
							}//for

            //합계잔액(월별)_신규건/////
						}else{                    //신규    insert
						  logger.dbg.println(this,"step14 -I");

							GauceStatement gsmt5 = conn.getGauceStatement(InsertSql_5.toString());
							gsmt5.setGauceDataRow(rows[j]);
						
							gsmt5.bindColumn(1, idxFDCODE);
							gsmt5.bindColumn(2, idxACTYYMM);
							gsmt5.bindColumn(3, idxATCODE);
							gsmt5.bindColumn(4, idxCOCODE);
							gsmt5.bindColumn(5, idxDIVCD);
							gsmt5.bindColumn(6, idxDEPTCD);
							gsmt5.bindColumn(7, idxCHAAMT);
							gsmt5.bindColumn(8, idxDAEAMT);
							gsmt5.bindColumn(9, idxDECASH);
							gsmt5.bindColumn(10,idxCRCASH);
							gsmt5.bindColumn(11,idxCHAUPAMT);
							gsmt5.bindColumn(12,idxDAEUPAMT);
							gsmt5.bindColumn(13,idxDEUPCASH);
							gsmt5.bindColumn(14,idxCRUPCASH);

							gsmt5.executeUpdate();
							gsmt5.close();

							////관리항목집계_신규/////////////
							for (int s2=0;s2<=8;s2++){
								logger.dbg.println(this,"step15 -I");

								if(!rows[j].getString(idxFSREFVAL[s2]).equals("")){
										GauceStatement gsmt6 = conn.getGauceStatement(InsertSql_6.toString());
										gsmt6.setGauceDataRow(rows[j]);
										gsmt6.bindColumn(1, idxFDCODE);
										gsmt6.bindColumn(2, idxACTYYMM);
										gsmt6.bindColumn(3, idxATCODE);
										gsmt6.bindColumn(4, idxCOCODE);
										gsmt6.bindColumn(5, idxDIVCD);
										gsmt6.bindColumn(6, idxDEPTCD);
										gsmt6.bindColumn(7, idxFSREFCD[s2]);
										gsmt6.bindColumn(8, idxFSREFVAL[s2]);
										gsmt6.bindColumn(9, idxCHAAMT);
										gsmt6.bindColumn(10,idxDAEAMT);
										gsmt6.bindColumn(11,idxCHAUPAMT);
										gsmt6.bindColumn(12,idxDAEUPAMT);
										gsmt6.executeUpdate();
										gsmt6.close();
								}//if idxFSREFCD
							}//for
					  }//if

					  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
						//합계잔액(월별) End<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
						//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


             //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
				//전표Mst 결재완료 Update>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
				//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      				
				if(!strfdcode.equals("")&&!strfsdat.equals("")&&!strfsnbr.equals("")){
					
						String  sql9 = " UPDATE  ACCOUNT.FSLIPMST SET "
												 + "         FSSTAT = 'Y',"
                         + "         SGNDAT = '"+strsgndat+"'"
												 + "  WHERE  FDCODE = '"+strfdcode+"'"
												 + "  AND  FSDAT  = '"+strfsdat+"'"
												 + "  AND  FSNBR  = '"+strfsnbr+"'";
												
						logger.dbg.println(this,"sql9" +sql9);

						GauceStatement gsmt9 = conn.getGauceStatement(sql9);
						gsmt9.executeUpdate();
						gsmt9.close();

						String  sql10 = " UPDATE  ACCOUNT.ACTSGNSTS SET "
												  + "         ACCSGNEND = 'Y'"
												  + "  WHERE  FDCODE = '"+strfdcode+"'"
												  + "  AND  FSDAT  = '"+strfsdat+"'"
												  + "  AND  FSNBR  = '"+strfsnbr+"'";
												
						logger.dbg.println(this,"sql10" +sql10);

						GauceStatement gsmt10= conn.getGauceStatement(sql10);
						gsmt10.executeUpdate();
						gsmt10.close();
        }
				
				//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
				//전표Mst 결재완료 Update End<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
				//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

				}//for j

				*/

			} //try
			catch(Exception e){
				conn.rollback();
				//logger.err.println(this,"errno::"+strErrorNo);
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