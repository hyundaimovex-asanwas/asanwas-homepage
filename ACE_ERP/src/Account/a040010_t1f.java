package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a040010_t1f extends HttpServlet{
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
			String strErrorNo ="";
			String strFsnbr="";
			String strFdcode="";
			String strFsdat = "";
			String strFsseq="";
			String strAcnnbr="";

			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
        
  /*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    @ 입력 / 수정
	>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/

        /************************************************************************************
         @ Master
				*************************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE       = userSet.indexOfColumn("FDCODE");  
				int idxFSDAT        = userSet.indexOfColumn("FSDAT");   
				int idxFSNBR        = userSet.indexOfColumn("FSNBR");   
				int idxFSKND        = userSet.indexOfColumn("FSKND");   
				int idxFSWRTDAT     = userSet.indexOfColumn("FSWRTDAT");

				int idxCOCODE       = userSet.indexOfColumn("COCODE");  
				int idxDEPTCD       = userSet.indexOfColumn("DEPTCD");  
				int idxEMPNO        = userSet.indexOfColumn("EMPNO");   
				int idxDIVCD        = userSet.indexOfColumn("DIVCD");  
				int idxFSAMT        = userSet.indexOfColumn("FSAMT"); 

				int idxFSVAT        = userSet.indexOfColumn("FSVAT");
				int idxDETOT        = userSet.indexOfColumn("DETOT");
				int idxCRTOT        = userSet.indexOfColumn("CRTOT");
				int idxREMARK       = userSet.indexOfColumn("REMARK"); 
				int idxSGNDAT       = userSet.indexOfColumn("SGNDAT"); 

				int idxFSSTAT       = userSet.indexOfColumn("FSSTAT");
				int idxACTDAT       = userSet.indexOfColumn("ACTDAT"); 
				int idxWRDT         = userSet.indexOfColumn("WRDT");    
				int idxWRID         = userSet.indexOfColumn("WRID");    
				int idxUPDT         = userSet.indexOfColumn("UPDT"); 
				int idxUPID         = userSet.indexOfColumn("UPID"); 

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.MFSLIPMST (  " );
				InsertSql.append( " FDCODE,	FSDAT,	FSNBR,	FSKND,	FSWRTDAT,  " );
				InsertSql.append( " COCODE,	DEPTCD,	EMPNO,	DIVCD,  FSAMT,  " );
				InsertSql.append( " FSVAT,  DETOT,  CRTOT,  REMARK, SGNDAT,	" );
				InsertSql.append( " FSSTAT,	ACTDAT, WRDT,	  WRID " );
				InsertSql.append( "  ) " );
				InsertSql.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,? ) " );
			 
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.MFSLIPMST SET " );
				UpdateSql.append( "        FSSTAT = ?," );
				UpdateSql.append( "        ACTDAT = ?," );
				UpdateSql.append( "        DEPTCD = ?," );
				UpdateSql.append( "        FSAMT = ?," );
				UpdateSql.append( "        FSVAT = ?," );
				UpdateSql.append( "        DETOT = ?," );
				UpdateSql.append( "        CRTOT = ?," );
				UpdateSql.append( "        REMARK = ?," );
				UpdateSql.append( "        UPDT = ?," );
				UpdateSql.append( "        UPID = ?" );
				UpdateSql.append( "  WHERE FDCODE=?" );
				UpdateSql.append( "    AND FSDAT=?" );
				UpdateSql.append( "    AND FSNBR=?" );
			
				/************************************************************************************
         		@ Master End
				*************************************************************************************/

    
				/************************************************************************************
         		@ Detail & Ref(관리항목 
				*************************************************************************************/
				GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2");

				//logger.dbg.println(this,"USER2");

				int idx2FDCODE       = userSet2.indexOfColumn("FDCODE");
				int idx2FSDAT        = userSet2.indexOfColumn("FSDAT");
				int idx2FSNBR        = userSet2.indexOfColumn("FSNBR");
				int idx2FSSEQ        = userSet2.indexOfColumn("FSSEQ");
				int idx2ATCODE       = userSet2.indexOfColumn("ATCODE");
				int idx2ATKORNAM     = userSet2.indexOfColumn("ATKORNAM");
				int idx2ATDECR       = userSet2.indexOfColumn("ATDECR");
				int idx2REMARK       = userSet2.indexOfColumn("REMARK");
				int idx2CHAAMT       = userSet2.indexOfColumn("CHAAMT");
				int idx2DAEAMT       = userSet2.indexOfColumn("DAEAMT");
				
				String [] strFSREFSEQ = new String []{"FSREFSEQ01","FSREFSEQ02","FSREFSEQ03","FSREFSEQ04","FSREFSEQ05",  
				                                      "FSREFSEQ06","FSREFSEQ07","FSREFSEQ08","FSREFSEQ09"}; 

				String [] strFSREFCD = new String []{"FSREFCD01","FSREFCD02","FSREFCD03","FSREFCD04","FSREFCD05",  
				                                     "FSREFCD06","FSREFCD07","FSREFCD08","FSREFCD09"}; 

				String [] strFSREFVAL = new String []{"FSREFVAL01","FSREFVAL02","FSREFVAL03","FSREFVAL04","FSREFVAL05",  
				                                      "FSREFVAL06","FSREFVAL07","FSREFVAL08","FSREFVAL09"}; 

				int [] idxFSREFSEQ = new int[9];
				for (int i=0;i<strFSREFSEQ.length;i++){
					idxFSREFSEQ[i] = userSet2.indexOfColumn(strFSREFSEQ[i]);
				}

				int [] idxFSREFCD = new int[9];
				for (int i=0;i<strFSREFCD.length;i++){
					idxFSREFCD[i] = userSet2.indexOfColumn(strFSREFCD[i]);
				}

				int [] idxFSREFVAL = new int[9];
				for (int i=0;i<strFSREFVAL.length;i++){
					idxFSREFVAL[i] = userSet2.indexOfColumn(strFSREFVAL[i]);
				}


 
				int idx2CNT           = userSet2.indexOfColumn("CNT");
				int idx2DOCUMCD       = userSet2.indexOfColumn("DOCUMCD");
				int idx2DOCUMNM       = userSet2.indexOfColumn("DOCUMNM");
				int idx2FSWRKDIV      = userSet2.indexOfColumn("FSWRKDIV");
				int idx2BANJAEYN      = userSet2.indexOfColumn("BANJAEYN");
				
				int idx2WRDT          = userSet2.indexOfColumn("WRDT");
				int idx2WRID          = userSet2.indexOfColumn("WRID");
				int idx2UPDT          = userSet2.indexOfColumn("UPDT");
				int idx2UPID          = userSet2.indexOfColumn("UPID");
				int idx2DOCUVAL       = userSet2.indexOfColumn("DOCUVAL");

				GauceDataRow[]rows2 = userSet2.getDataRows();
				
				StringBuffer InsertSql2 = null;
				InsertSql2 = new StringBuffer();

				InsertSql2.append( " INSERT INTO ACCOUNT.MFSLIPDTL (  " );
				InsertSql2.append( " FDCODE,	FSDAT,	FSNBR,	FSSEQ,	 ATCODE,   " );
				InsertSql2.append( " ATDECR,  FSAMT,  REMARK, DOCUMCD, FSWRKDIV, BANJAEYN,  WRDT,   WRID, DOCUVAL " );
				InsertSql2.append( "  ) " );
				InsertSql2.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,? ) " ); 

				/************************************************************************************
         		@ Detail End
				*************************************************************************************/

				//===================================================================================
				for (int j = 0; j < rows.length; j++){
					strFdcode = rows[j].getString(idxFDCODE);
					strFsdat = rows[j].getString(idxFSDAT);
					strFsnbr = rows[j].getString(idxFSNBR);
					String strWrdt = rows[j].getString(idxWRDT);
					String strWrid = rows[j].getString(idxWRID);
					double dblcnt=0;

					//전표Master 입력/수정 구분=====================================================>>>>

					//logger.dbg.println(this,"MST");
					Statement stmt0 = conn.createStatement();
					String sql0 = " SELECT COUNT(FDCODE) FROM ACCOUNT.MFSLIPMST "
				              				+ "	 WHERE FDCODE ='"+strFdcode+"'" 
				              				+ "	   AND FSDAT='"+strFsdat+"'"
				              				+ "	   AND FSNBR='"+strFsnbr+"'"; 
					ResultSet rs0 = stmt0.executeQuery(sql0); 

					if(rs0.next()){
						 dblcnt= rs0.getDouble(1);
					}
          
					if(dblcnt>0){   //수정

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxFSSTAT);
						gsmt.bindColumn(2, idxACTDAT);
						gsmt.bindColumn(3, idxDEPTCD);
						gsmt.bindColumn(4, idxFSAMT);
						gsmt.bindColumn(5, idxFSVAT);
						gsmt.bindColumn(6, idxDETOT);
						gsmt.bindColumn(7, idxCRTOT);
						gsmt.bindColumn(8, idxREMARK);
						gsmt.bindColumn(9, idxUPDT);
						gsmt.bindColumn(10, idxUPID);
						gsmt.bindColumn(11, idxFDCODE);
						gsmt.bindColumn(12, idxFSDAT);
						gsmt.bindColumn(13, idxFSNBR);
            
						gsmt.executeUpdate();
						gsmt.close();

					}else{ //신규입력
	
						rows[j].setString(idxFSNBR,strFsnbr);

						//================================================================================<<<<
						if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

							//error시 error 전표번호 
							strErrorNo = rows[j].getString(idxFDCODE)+"-"+rows[j].getString(idxFSDAT)+"-"+rows[j].getString(idxFSNBR);

							/************************************************************************************/
							//전표 Master
							/***********************************************************************************/

							GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows[j]);
							gsmt.bindColumn(1, idxFDCODE);
							gsmt.bindColumn(2, idxFSDAT);
							gsmt.bindColumn(3, idxFSNBR);
							gsmt.bindColumn(4, idxFSKND);
							gsmt.bindColumn(5, idxFSWRTDAT);
						 
							gsmt.bindColumn(6, idxCOCODE);
							gsmt.bindColumn(7, idxDEPTCD);
							gsmt.bindColumn(8, idxEMPNO);
							gsmt.bindColumn(9, idxDIVCD);
							gsmt.bindColumn(10,idxFSAMT);

							gsmt.bindColumn(11, idxFSVAT);
							gsmt.bindColumn(12, idxDETOT);
							gsmt.bindColumn(13, idxCRTOT);
							gsmt.bindColumn(14, idxREMARK);
							gsmt.bindColumn(15, idxSGNDAT);

							gsmt.bindColumn(16, idxFSSTAT);
							gsmt.bindColumn(17, idxACTDAT);
							gsmt.bindColumn(18, idxWRDT);
							gsmt.bindColumn(19, idxWRID);

							gsmt.executeUpdate();
							gsmt.close();
						} //if jobtype
					}

					/***************************************************************************************************/
					//전표 Detail
					/***************************************************************************************************/
					String strgubun =null;
					String strSeq = "";
					String strSeq2_2 = "";
					double dblchaamt=0; 
					double dbldaeamt=0;
					
					String strFDCODE2="";
					String strFSDAT2="";
					String strFSNBR2="";
					int ichk2=0;


					for (int k=0;k<rows2.length; k++){
						//전표 Detail 키값 생성
						rows2[k].setString(idx2FDCODE,strFdcode);
						rows2[k].setString(idx2FSDAT,strFsdat);
						rows2[k].setString(idx2FSNBR,strFsnbr);

						strFDCODE2 = rows2[k].getString(idx2FDCODE);
						strFSDAT2  = rows2[k].getString(idx2FSDAT);
						strFSNBR2  = rows2[k].getString(idx2FSNBR);

						//추가
						strSeq = rows2[k].getString(idx2FSSEQ);

						strFdcode = strFDCODE2;
						strFsdat = strFSDAT2;
						strFsnbr = strFSNBR2;

						rows2[k].setString(idx2FSSEQ,strSeq);
					
						dblchaamt = rows2[k].getDouble(idx2CHAAMT);
						dbldaeamt = rows2[k].getDouble(idx2DAEAMT);
						//차변 대변 구분 
						if(dblchaamt!=0 && dbldaeamt ==0){
							strgubun="1"; 
							rows2[k].setString(idx2ATDECR,strgubun);  //차변
						}else if (dblchaamt==0 && dbldaeamt != 0){
							strgubun="2";
							rows2[k].setString(idx2ATDECR,strgubun);  //대변
							rows2[k].setDouble(idx2CHAAMT,dbldaeamt);
						}else{
							rows2[k].setDouble(idx2CHAAMT,0);
							rows2[k].setDouble(idx2DAEAMT,0);
						}

						rows2[k].setString(idx2WRDT,strWrdt); 
						rows2[k].setString(idx2WRID,strWrid); 

						if(rows2[k].getJobType() == GauceDataRow.TB_JOB_INSERT) {

							GauceStatement gsmt2 = conn.getGauceStatement(InsertSql2.toString());
					
							gsmt2.setGauceDataRow(rows2[k]);
							gsmt2.bindColumn(1, idx2FDCODE);
							gsmt2.bindColumn(2, idx2FSDAT);
							gsmt2.bindColumn(3, idx2FSNBR);
							gsmt2.bindColumn(4, idx2FSSEQ);
							gsmt2.bindColumn(5, idx2ATCODE);
							gsmt2.bindColumn(6, idx2ATDECR);
							gsmt2.bindColumn(7, idx2CHAAMT);
							gsmt2.bindColumn(8, idx2REMARK);
							gsmt2.bindColumn(9, idx2DOCUMCD);
							gsmt2.bindColumn(10, idx2FSWRKDIV);
							gsmt2.bindColumn(11, idx2BANJAEYN);
							gsmt2.bindColumn(12, idx2WRDT);
							gsmt2.bindColumn(13, idx2WRID);
							gsmt2.bindColumn(14, idx2DOCUVAL);
							gsmt2.executeUpdate();
							gsmt2.close();


						/************************************************************************************/
						//전표 관리항목
						/************************************************************************************/
							for (int m=0;m<strFSREFSEQ.length;m++){

								if (!rows2[k].getString(idxFSREFCD[m]).equals("")&&!rows2[k].getString(idxFSREFCD[m]).equals(null)){

									int ichk2_2 = m+1;
									strSeq2_2 = String.valueOf(ichk2_2);
									if(ichk2_2<10) strSeq2_2 = "0"+ strSeq2_2;
									String  sql2_2 = " INSERT INTO  ACCOUNT.FSLIPREF ( "
																 + " FDCODE,	FSDAT,	  FSNBR,	FSSEQ,	 FSREFSEQ,"
																 + " FSREFCD, FSREFVAL, WRDT,   WRID "
																 + " ) "
																 + " VALUES ( "
																 + " '"+strFDCODE2+"',"
																 + " '"+strFSDAT2+"',"
																 + " '"+strFSNBR2+"',"
																 + " '"+strSeq+"',"
																 + " '"+strSeq2_2+"',"
																 + " '"+rows2[k].getString(idxFSREFCD[m])+"',"
																 + " '"+rows2[k].getString(idxFSREFVAL[m])+"',"
																 + " '"+rows2[k].getString(idx2WRDT)+"',"
																 + " '"+rows2[k].getString(idx2WRID)+"'"
																 + " ) ";
									GauceStatement gsmt2_2 = conn.getGauceStatement(sql2_2);
									gsmt2_2.executeUpdate();
									gsmt2_2.close();
								} //if 
							} //for m
					} //if_jobtype  rows2[k]
				}  //for k 
			}  //for j 

			/************************************************************************************
			 @ Detail & Ref(관리항목 수정건) Update Update Update Update Update
			*************************************************************************************/
			GauceDataSet userSet3 = reqGauce.getGauceDataSet("USER3");

				if (userSet3 != null) {

				int idx3FDCODE       = userSet3.indexOfColumn("FDCODE");
				int idx3FSDAT        = userSet3.indexOfColumn("FSDAT");
				int idx3FSNBR        = userSet3.indexOfColumn("FSNBR");
				int idx3FSSEQ        = userSet3.indexOfColumn("FSSEQ");
				int idx3ATCODE       = userSet3.indexOfColumn("ATCODE");
				int idx3ATDECR       = userSet3.indexOfColumn("ATDECR");
				int idx3REMARK       = userSet3.indexOfColumn("REMARK");
				int idx3CHAAMT       = userSet3.indexOfColumn("CHAAMT");
				int idx3DAEAMT       = userSet3.indexOfColumn("DAEAMT");


				String [] strFSREFSEQ3 = new String []{"FSREFSEQ01","FSREFSEQ02","FSREFSEQ03","FSREFSEQ04","FSREFSEQ05",  
																							 "FSREFSEQ06","FSREFSEQ07","FSREFSEQ08","FSREFSEQ09"}; 

				String [] strFSREFCD3 = new String []{"FSREFCD01","FSREFCD02","FSREFCD03","FSREFCD04","FSREFCD05",  
																							"FSREFCD06","FSREFCD07","FSREFCD08","FSREFCD09"}; 

				String [] strFSREFVAL3 = new String []{"FSREFVAL01","FSREFVAL02","FSREFVAL03","FSREFVAL04","FSREFVAL05",  
																							 "FSREFVAL06","FSREFVAL07","FSREFVAL08","FSREFVAL09"}; 


				int [] idxFSREFSEQ3 = new int[9];
				for (int i=0;i<strFSREFSEQ3.length;i++){
					idxFSREFSEQ3[i] = userSet2.indexOfColumn(strFSREFSEQ3[i]);
				}

				int [] idxFSREFCD3 = new int[9];
				for (int i=0;i<strFSREFCD3.length;i++){
					idxFSREFCD3[i] = userSet2.indexOfColumn(strFSREFCD3[i]);
				}

				int [] idxFSREFVAL3 = new int[9];
				for (int i=0;i<strFSREFVAL3.length;i++){
					idxFSREFVAL3[i] = userSet2.indexOfColumn(strFSREFVAL3[i]);
				}



				int idx3CNT           = userSet3.indexOfColumn("CNT");
				int idx3DOCUMCD       = userSet3.indexOfColumn("DOCUMCD");
				int idx3DOCUMNM       = userSet3.indexOfColumn("DOCUMNM");
				int idx3FSWRKDIV      = userSet3.indexOfColumn("FSWRKDIV");
				int idx3WRDT          = userSet3.indexOfColumn("WRDT");
				int idx3WRID          = userSet3.indexOfColumn("WRID");
				int idx3UPDT          = userSet3.indexOfColumn("UPDT");
				int idx3UPID          = userSet3.indexOfColumn("UPID");
				int idx3DOCUVAL       = userSet3.indexOfColumn("DOCUVAL");


				GauceDataRow[]rows3 = userSet3.getDataRows();
				
				String strFDCODE3="";
				String strFSDAT3="";
				String strFSNBR3="";
				String strFSSEQ3="";
				String strgubun3=null;
				String strSeq3_3= "";
				double dblchaamt3=0; 
				double dbldaeamt3=0;
				StringBuffer UpdateSql3 = null;
				StringBuffer DeleteSql3 = null;

				UpdateSql3 = new StringBuffer();
				UpdateSql3.append( " UPDATE ACCOUNT.MFSLIPDTL SET " );
				UpdateSql3.append( "        ATCODE = ?," );
				UpdateSql3.append( "        ATDECR = ?," );
				UpdateSql3.append( "        FSAMT = ?," );
				UpdateSql3.append( "        DOCUMCD = ?," );
				UpdateSql3.append( "        FSWRKDIV = ?," );
				UpdateSql3.append( "        REMARK = ?," );
				UpdateSql3.append( "        UPDT = ?," );
				UpdateSql3.append( "        UPID = ?," );
				UpdateSql3.append( "        DOCUVAL = ?" );
				UpdateSql3.append( "  WHERE FDCODE=?" );
				UpdateSql3.append( "    AND FSDAT=?" );
				UpdateSql3.append( "    AND FSNBR=?" );
				UpdateSql3.append( "    AND FSSEQ=?" );

				DeleteSql3 = new StringBuffer();
				DeleteSql3.append( " DELETE FROM ACCOUNT.FSLIPREF " );
				DeleteSql3.append( "  WHERE FDCODE=?" );
				DeleteSql3.append( "    AND FSDAT=?" );
				DeleteSql3.append( "    AND FSNBR=?" );
				DeleteSql3.append( "    AND FSSEQ=?" );


				for (int u=0;u<rows3.length;u++){
					if(rows3[u].getJobType() == GauceDataRow.TB_JOB_INSERT){

						strFDCODE3 = rows3[u].getString(idx3FDCODE);
						strFSDAT3  = rows3[u].getString(idx3FSDAT);
						strFSNBR3  = rows3[u].getString(idx3FSNBR);
						strFSSEQ3  = rows3[u].getString(idx3FSSEQ);
						dblchaamt3 = rows3[u].getDouble(idx3CHAAMT);
						dbldaeamt3 = rows3[u].getDouble(idx3DAEAMT);

						strFdcode = strFDCODE3;
						strFsdat = strFSDAT3;
						strFsnbr = strFSNBR3;

						//차변 대변 구분 
						if(dblchaamt3!=0 && dbldaeamt3 ==0){
							strgubun3="1"; 
							rows3[u].setString(idx3ATDECR,strgubun3);  //차변
						}else if (dblchaamt3==0 && dbldaeamt3 != 0){
							strgubun3="2";
							rows3[u].setString(idx3ATDECR,strgubun3);  //대변
							rows3[u].setDouble(idx3CHAAMT,dbldaeamt3);
						}else{
							rows3[u].setDouble(idx3CHAAMT,0);
							rows3[u].setDouble(idx3DAEAMT,0);
						}

						GauceStatement gsmt3 = conn.getGauceStatement(UpdateSql3.toString());

						gsmt3.setGauceDataRow(rows3[u]);
						gsmt3.bindColumn(1, idx3ATCODE);
						gsmt3.bindColumn(2, idx3ATDECR);
						gsmt3.bindColumn(3, idx3CHAAMT);
						gsmt3.bindColumn(4, idx3DOCUMCD);
						gsmt3.bindColumn(5, idx3FSWRKDIV);
						gsmt3.bindColumn(6, idx3REMARK);
						gsmt3.bindColumn(7, idx3WRDT);
						gsmt3.bindColumn(8, idx3WRID);
						gsmt3.bindColumn(9, idx3DOCUVAL);
						gsmt3.bindColumn(10, idx3FDCODE);
						gsmt3.bindColumn(11, idx3FSDAT);
						gsmt3.bindColumn(12, idx3FSNBR);
						gsmt3.bindColumn(13, idx3FSSEQ);
						gsmt3.executeUpdate();
						gsmt3.close();

						GauceStatement gsmt3_2 = conn.getGauceStatement(DeleteSql3.toString());
						gsmt3_2.setGauceDataRow(rows3[u]);
						gsmt3_2.bindColumn(1, idx3FDCODE);
						gsmt3_2.bindColumn(2, idx3FSDAT);
						gsmt3_2.bindColumn(3, idx3FSNBR);
						gsmt3_2.bindColumn(4, idx3FSSEQ);
						gsmt3_2.executeUpdate();
						gsmt3_2.close();


						//관리항목 수정건...계정과목이 변경될 수 있으므로 Delete 후에 Insert함.
						for (int v=0;v<strFSREFSEQ3.length;v++){

							if (!rows3[u].getString(idxFSREFCD3[v]).equals("")&&!rows3[u].getString(idxFSREFCD3[v]).equals(null)){

								int ichk3_3 = v+1;
								strSeq3_3 = String.valueOf(ichk3_3);
								if(ichk3_3<10) strSeq3_3 = "0"+ strSeq3_3;

								String  sql3 = " INSERT INTO ACCOUNT.FSLIPREF ( "
														 + " FDCODE,	FSDAT,	  FSNBR,	FSSEQ,	 FSREFSEQ,"
														 + " FSREFCD, FSREFVAL, WRDT,   WRID "
														 + " ) "
														 + " VALUES ( "
														 + " '"+strFDCODE3+"',"
														 + " '"+strFSDAT3+"',"
														 + " '"+strFSNBR3+"',"
														 + " '"+strFSSEQ3+"',"
														 + " '"+strSeq3_3+"',"
														 + " '"+rows3[u].getString(idxFSREFCD3[v])+"'," 
														 + " '"+rows3[u].getString(idxFSREFVAL3[v])+"'," 
														 + " '"+rows3[u].getString(idx3WRDT)+"'," 
														 + " '"+rows3[u].getString(idx3WRID)+"'" 
														 + " ) ";


								GauceStatement gsmt3_3 = conn.getGauceStatement(sql3);
								gsmt3_3.executeUpdate();
								gsmt3_3.close();
							} //if 
						} //for V

					}//if
				}//for u
      }//if
      //logger.dbg.println(this,"step15" );
			/************************************************************************************
			 @ Detail End(관리항목 수정건)  Update Update Update Update Update
			*************************************************************************************/


			/************************************************************************************
			 @ DELETE  삭제  Start 
			*************************************************************************************/
				GauceDataSet userSet4 = reqGauce.getGauceDataSet("USER4");
				if (userSet4 != null) {


				int idx4FDCODE  = userSet4.indexOfColumn("FDCODE");  
				int idx4FSDAT   = userSet4.indexOfColumn("FSDAT");   
				int idx4FSNBR   = userSet4.indexOfColumn("FSNBR");  
				int idx4FSSEQ   = userSet4.indexOfColumn("FSSEQ");
				
				GauceDataRow[] rows4 = userSet4.getDataRows();
				
				StringBuffer DeleteSql_DTL = null;
				StringBuffer DeleteSql_REF = null;
				StringBuffer DeleteTAX_MST = null;
				StringBuffer DeleteTAX_DTL = null;
			
				DeleteSql_DTL = new StringBuffer();
				DeleteSql_REF = new StringBuffer();
				DeleteTAX_MST = new StringBuffer();
				DeleteTAX_DTL = new StringBuffer();

				DeleteSql_DTL.append( " DELETE FROM  ACCOUNT.MFSLIPDTL  " );
				DeleteSql_DTL.append( "  WHERE FDCODE = ? " );
				DeleteSql_DTL.append( "    AND FSDAT = ? " );
				DeleteSql_DTL.append( "    AND FSNBR = ? " );
				DeleteSql_DTL.append( "    AND FSSEQ = ? " );
				
				DeleteSql_REF.append( " DELETE FROM  ACCOUNT.FSLIPREF  " );
				DeleteSql_REF.append( "  WHERE FDCODE = ? " );
				DeleteSql_REF.append( "    AND FSDAT = ? " );
				DeleteSql_REF.append( "    AND FSNBR = ? " );
				DeleteSql_REF.append( "    AND FSSEQ = ? " );


				for (int jj=0;jj<rows4.length; jj++){

						strFdcode = rows4[jj].getString(idx4FDCODE);
						strFsdat  = rows4[jj].getString(idx4FSDAT);
						strFsnbr  = rows4[jj].getString(idx4FSNBR);
						strFsseq  = rows4[jj].getString(idx4FSSEQ);

						//DETAIL의 건수 만큼 돌려서 계산서 번호를 찾아내어 존재하면 계산서 delete 시킴
						StringBuffer sql4 = new StringBuffer();
						Statement stmt4 = null;
						ResultSet rs4 = null;
						sql4.append( " SELECT COALESCE(ACNNBR,'') 					");
						sql4.append( "   FROM ACCOUNT.MFSLIPDTL     	 ");
						sql4.append( "  WHERE FDCODE ='"+strFdcode+"' ");
						sql4.append( "    AND FSDAT ='"+strFsdat+"' ");
						sql4.append( "    AND FSNBR ='"+strFsnbr+"' ");
						sql4.append( "    AND FSSEQ ='"+strFsseq+"' ");
						
						stmt4 = conn.createStatement();
						rs4 = stmt4.executeQuery(sql4.toString());

						while(rs4.next())	{
							strAcnnbr = rs4.getString(1);

							if (!strAcnnbr.equals("")){

								DeleteTAX_MST.append( " DELETE FROM  ACCOUNT.ATTAXMST   " );
								DeleteTAX_MST.append( "  WHERE TAXNBR = '"+strAcnnbr+"' " );

								GauceStatement gsmt11 = conn.getGauceStatement(DeleteTAX_MST.toString());
								gsmt11.executeUpdate(); 
								gsmt11.close();         

								DeleteTAX_DTL.append( " DELETE FROM  ACCOUNT.ATTAXDTL  " );
								DeleteTAX_DTL.append( "  WHERE TAXNBR ='"+strAcnnbr+"' " );
								
								GauceStatement gsmt12 = conn.getGauceStatement(DeleteTAX_DTL.toString());
								gsmt12.executeUpdate(); 
								gsmt12.close();         
							}//if
						}//while

            //전표Detail
            GauceStatement gsmt13 = conn.getGauceStatement(DeleteSql_DTL.toString());
						gsmt13.setGauceDataRow(rows4[jj]);
					
						gsmt13.bindColumn(1, idx4FDCODE);
						gsmt13.bindColumn(2, idx4FSDAT);
						gsmt13.bindColumn(3, idx4FSNBR);
						gsmt13.bindColumn(4, idx4FSSEQ);
            
						gsmt13.executeUpdate();
						gsmt13.close();

						//전표관리항목
						GauceStatement gsmt14 = conn.getGauceStatement(DeleteSql_REF.toString());
						gsmt14.setGauceDataRow(rows4[jj]);
					
						gsmt14.bindColumn(1, idx4FDCODE);
						gsmt14.bindColumn(2, idx4FSDAT);
						gsmt14.bindColumn(3, idx4FSNBR);
						gsmt14.bindColumn(4, idx4FSSEQ);
            
						gsmt14.executeUpdate();
						gsmt14.close();

				}//for
			}//if
			/************************************************************************************
			 @ DELETE  삭제  End 
			*************************************************************************************/

			/************************************************************************************
			 @ BANJAEREL 연결 Start  - 입력
			*************************************************************************************/
				GauceDataSet userSet6 = reqGauce.getGauceDataSet("USER6");

				if (userSet6 != null) {
        
				int idx6FTSTAT         = userSet6.indexOfColumn("FTSTAT");  
				int idx6FDCODE         = userSet6.indexOfColumn("FDCODE");  
				int idx6TSDAT          = userSet6.indexOfColumn("TSDAT");  
				int idx6TSNBR          = userSet6.indexOfColumn("TSNBR");  
				int idx6TSSEQ          = userSet6.indexOfColumn("TSSEQ");  
				int idx6BTSDAT         = userSet6.indexOfColumn("BTSDAT");  
				int idx6BTSNBR         = userSet6.indexOfColumn("BTSNBR");  
				int idx6BTSSEQ         = userSet6.indexOfColumn("BTSSEQ");  
				int idx6BANJAEYN       = userSet6.indexOfColumn("BANJAEYN");  
				int idx6WRDT           = userSet6.indexOfColumn("WRDT");  
				int idx6WRID           = userSet6.indexOfColumn("WRID");  
				int idx6UPDT           = userSet6.indexOfColumn("UPDT");  
				int idx6UPID           = userSet6.indexOfColumn("UPID");  

				GauceDataRow[] rows6 = userSet6.getDataRows();

				StringBuffer InsertSql6 = null;
				InsertSql6 = new StringBuffer();

				for (int b=0;b<rows6.length;b++){
        
					InsertSql6.append( " INSERT INTO ACCOUNT.BANJAEREL (  " );
					InsertSql6.append( " FTSTAT,	FDCODE,	TSDAT,	TSNBR,	  TSSEQ,  " );
					InsertSql6.append( " BTSDAT,	BTSNBR,	BTSSEQ,	BANJAEYN,	 " );
					InsertSql6.append( " WRDT,    WRID	" );
					InsertSql6.append( "  ) " );
					InsertSql6.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,? ) " );
			
					GauceStatement gsmt6 = conn.getGauceStatement(InsertSql6.toString());
					
					gsmt6.setGauceDataRow(rows6[b]);
					gsmt6.bindColumn(1,idx6FTSTAT);
					gsmt6.bindColumn(2,idx6FDCODE);
					gsmt6.bindColumn(3,idx6TSDAT);
					gsmt6.bindColumn(4,idx6TSNBR);
					gsmt6.bindColumn(5,idx6TSSEQ);
					gsmt6.bindColumn(6,idx6BTSDAT);
					gsmt6.bindColumn(7,idx6BTSNBR);
					gsmt6.bindColumn(8,idx6BTSSEQ);
					gsmt6.bindColumn(9,idx6BANJAEYN);
					gsmt6.bindColumn(10,idx6WRDT);
					gsmt6.bindColumn(11,idx6WRID);
							
					gsmt6.executeUpdate();
					gsmt6.close();
				}
				 
		 }
				
			 /************************************************************************************
			 @ BANJAEREL 연결 End 
			*************************************************************************************/

			/************************************************************************************
			 @ 계산서  Start  - 수정
			*************************************************************************************/
				GauceDataSet userSet7 = reqGauce.getGauceDataSet("USER7");

				if (userSet7 != null) {
        
			  	int idx7TAXNBR         = userSet7.indexOfColumn("TAXNBR");  
				int idx7FDCODE         = userSet7.indexOfColumn("FDCODE");  
				int idx7FSDAT          = userSet7.indexOfColumn("FSDAT");  
				int idx7FSNBR          = userSet7.indexOfColumn("FSNBR");  
				int idx7UPDT           = userSet7.indexOfColumn("UPDT");  
				int idx7UPID           = userSet7.indexOfColumn("UPID");  

				GauceDataRow[] rows7 = userSet7.getDataRows();
				 StringBuffer UpdateSql7 = null;
				 UpdateSql7 = new StringBuffer();

				for (int c=0;c<rows7.length;c++){

					UpdateSql7.append( " UPDATE ACCOUNT.ATTAXMST SET " );
					UpdateSql7.append( "        FDCODE = ?," );
					UpdateSql7.append( "        FSDAT = ?," );
					UpdateSql7.append( "        FSNBR = ?," );
					UpdateSql7.append( "        UPDT = ?," );
					UpdateSql7.append( "        UPID = ?" );
					UpdateSql7.append( "  WHERE TAXNBR=?" );

					GauceStatement gsmt7 = conn.getGauceStatement(UpdateSql7.toString());
					
					gsmt7.setGauceDataRow(rows7[c]);

					gsmt7.bindColumn(1,idx7FDCODE);
					gsmt7.bindColumn(2,idx7FSDAT);
					gsmt7.bindColumn(3,idx7FSNBR);
					gsmt7.bindColumn(4,idx7UPDT);
					gsmt7.bindColumn(5,idx7UPID);
					gsmt7.bindColumn(6,idx7TAXNBR);
					
					gsmt7.executeUpdate();
					gsmt7.close();
				
				}	//for
		 } //if
				
			/************************************************************************************
			 @ 계산서 수정 End 
			*************************************************************************************/

			/************************************************************************************
			 @ 일반증빙 - 입력
			*************************************************************************************/
		 GauceDataSet userSet8 = reqGauce.getGauceDataSet("USER8");
     
		 if (userSet8 != null) {

			  	int idx8FDCODE         = userSet8.indexOfColumn("FDCODE");  
				int idx8FSDAT          = userSet8.indexOfColumn("FSDAT");  
				int idx8FSNBR          = userSet8.indexOfColumn("FSNBR");  
				int idx8FSSEQ          = userSet8.indexOfColumn("FSSEQ");  
				int idx8RSVNO          = userSet8.indexOfColumn("RSVNO");  
				int idx8RSTDIV         = userSet8.indexOfColumn("RSTDIV");  
				int idx8RSTNO          = userSet8.indexOfColumn("RSTNO");  
				int idx8VEND_CD        = userSet8.indexOfColumn("VEND_CD");  
				int idx8REMARK          = userSet8.indexOfColumn("REMARK");  
				int idx8AMOUNT          = userSet8.indexOfColumn("AMOUNT");  
				int idx8RSVDATE         = userSet8.indexOfColumn("RSVDATE");  
				int idx8RSVMAN          = userSet8.indexOfColumn("RSVMAN");  
				int idx8CURDATE         = userSet8.indexOfColumn("CURDATE");  
      
				GauceDataRow[] rows8 = userSet8.getDataRows();

				StringBuffer InsertSql8 = null;
				InsertSql8 = new StringBuffer();
				String strRsvno ="";
				String strRsmm="";

	
				for (int b=0;b<rows8.length;b++){
					strRsmm = rows8[b].getString(idx8CURDATE);
					strRsmm = strRsmm.substring(0,6);
          
					InsertSql8.append( " INSERT INTO ACCOUNT.GENRST (  " );
					InsertSql8.append( " FDCODE,	FSDAT,	FSNBR,	  FSSEQ,  RSVNO, " );
					InsertSql8.append( " RSTDIV,	RSTNO,	VEND_CD,	REMARK,	AMOUNT, " );
					InsertSql8.append( " RSVDATE, RSVMAN	" );
					InsertSql8.append( "  ) " );
					InsertSql8.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,? ) " );
          
					Statement stmt8 = conn.createStatement();
					String sql8 = " SELECT COALESCE(MAX(SUBSTR(RSVNO,8,4)),0)+1 FROM ACCOUNT.GENRST "
										 + "	WHERE SUBSTR(RSVNO,2,6) ='"+strRsmm+"'";
					ResultSet rs8 = stmt8.executeQuery(sql8); 
					
					if(rs8.next()){
						 strRsvno= rs8.getString(1);
					}

					int ichk = Integer.parseInt(strRsvno);
					if(ichk<10) strRsvno = "000"+strRsvno;
					else if(ichk>=10 && ichk<100)strRsvno = "00"+strRsvno;
					else if(ichk>=100 && ichk<1000) strRsvno ="0"+strRsvno;

					strRsvno = "A"+ strRsmm +strRsvno;
					rows8[b].setString(idx8RSVNO,strRsvno);
				  
					GauceStatement gsmt8 = conn.getGauceStatement(InsertSql8.toString());
					gsmt8.setGauceDataRow(rows8[b]);
											 
					gsmt8.bindColumn(1,idx8FDCODE);
					gsmt8.bindColumn(2,idx8FSDAT);
					gsmt8.bindColumn(3,idx8FSNBR);
					gsmt8.bindColumn(4,idx8FSSEQ);
					gsmt8.bindColumn(5,idx8RSVNO);
					gsmt8.bindColumn(6,idx8RSTDIV);
					gsmt8.bindColumn(7,idx8RSTNO);
					gsmt8.bindColumn(8,idx8VEND_CD);
					gsmt8.bindColumn(9,idx8REMARK);
					gsmt8.bindColumn(10,idx8AMOUNT);
					gsmt8.bindColumn(11,idx8RSVDATE);
					gsmt8.bindColumn(12,idx8RSVMAN);
					gsmt8.executeUpdate();
					gsmt8.close();
				}
				 
		 }
				
			 /************************************************************************************
			 @ 일반증빙 - 입력 end
			*************************************************************************************/

			/************************************************************************************
			 @ return값
			*************************************************************************************/

			} //try
			catch(Exception e){
				conn.rollback();
				logger.err.println(this,"errno::"+strErrorNo);
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}
			conn.commit();
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}