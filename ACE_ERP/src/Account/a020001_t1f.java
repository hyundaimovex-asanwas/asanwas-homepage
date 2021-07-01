package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a020001_t1f extends HttpServlet{
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
			double dblYYBresults=0;  //년별 금액
			double dblMMBresults=0;  //월별 금액
			double dblbchaamt_bgt=0;     //변경전 금액
			double dblchaamt_bgt=0;      //변경후 금액
			double dblamt=0;         //계산후update 금액

			String strSatcode="";    //예산관련 세목

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

				String strloginfdcode = reqGauce.getParameter("v_str1");   //로그인 ID에 따른 지점 

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
				InsertSql.append( " INSERT INTO ACCOUNT.FSLIPMST (  " );
				InsertSql.append( " FDCODE,	FSDAT,	FSNBR,	FSKND,	FSWRTDAT,  " );
				InsertSql.append( " COCODE,	DEPTCD,	EMPNO,	DIVCD,  FSAMT,  " );
				InsertSql.append( " FSVAT,  DETOT,  CRTOT,  REMARK, SGNDAT,	" );
				InsertSql.append( " FSSTAT,	ACTDAT, WRDT,	  WRID " );
				InsertSql.append( "  ) " );
				InsertSql.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,? ) " );
			 
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.FSLIPMST SET " );
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
         		@ Detail & Ref(관리항목) 
				*************************************************************************************/
				GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2");
				logger.dbg.println(this,"USER2");
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
				int idx2FSNUM       = userSet2.indexOfColumn("FSNUM");
				int idx2DIVCD       = userSet2.indexOfColumn("DIVCD");
				int idx2BGTDIV      = userSet2.indexOfColumn("BGTDIV");

				GauceDataRow[]rows2 = userSet2.getDataRows();
				
				StringBuffer InsertSql2 = null;
				InsertSql2 = new StringBuffer();

				InsertSql2.append( " INSERT INTO ACCOUNT.FSLIPDTL (  " );
				InsertSql2.append( " FDCODE,	FSDAT,	FSNBR,	FSSEQ,	 ATCODE,   " );
				InsertSql2.append( " ATDECR,  FSAMT,  REMARK, DOCUMCD, FSWRKDIV, BANJAEYN,  WRDT,   WRID," );
				InsertSql2.append( " DOCUVAL, FSNUM,  DIVCD,  BGTDIV  " );
				InsertSql2.append( "  ) " );
				InsertSql2.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,? ) " ); 

				//logger.dbg.println(this,"FSLIPDTL.INSERT : "+InsertSql2);
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
					String sql0 = " SELECT COUNT(FDCODE) FROM ACCOUNT.FSLIPMST "
				              + "	 WHERE FDCODE ='"+strFdcode+"'" 
					            + "	   AND FSDAT='"+strFsdat+"'"
										  + "	   AND FSNBR='"+strFsnbr+"'"; 
					ResultSet rs0 = stmt0.executeQuery(sql0); 

					if(rs0.next()){
						 dblcnt= rs0.getDouble(1);
						 ///^^logger.dbg.println(this,"dblcnt" + dblcnt );
					}
  
					rs0.close();

					if(dblcnt>0){   //수정
					  ///^^logger.dbg.println(this,"MST_U");
						//logger.dbg.println(this,"UpdateSql"+UpdateSql.toString() );
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
            
						///외부에서 전표번호를 생성하기 때문에 막음.20060125.
						 ///^^logger.dbg.println(this,"MST_I");
						/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
           				@ 전표번호 채번 START
				    	+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

						//logger.dbg.println(this, "strloginfdcode"+strloginfdcode);
						//logger.dbg.println(this, "strFdcode"+strFdcode);
						if(strloginfdcode.equals(strFdcode)){

							Statement stmt = conn.createStatement();
							String sql = " SELECT COALESCE(MAX(FSNBR),0)+1 FROM ACCOUNT.FSLIPMST "
												 + "	WHERE FDCODE ='"+strFdcode+"'" 
												 + "	  AND FSDAT='"+strFsdat+"'"
												 + "	  AND FSNBR<'500000'" ; 
							ResultSet rs = stmt.executeQuery(sql); 
							if(rs.next()){
								 strFsnbr= rs.getString(1);
							}

							rs.close();
							int ichk = Integer.parseInt(strFsnbr);

							if(ichk<10) strFsnbr = "00000"+strFsnbr;
							else if(ichk>=10 && ichk<100)strFsnbr = "0000"+strFsnbr;
							else if(ichk>=100 && ichk<1000) strFsnbr ="000"+strFsnbr;
							else if(ichk>=1000 && ichk<10000)strFsnbr = "00"+strFsnbr;
							else if(ichk>=10000 && ichk<100000) strFsnbr = "0"+strFsnbr;
						}else{
							Statement stmt = conn.createStatement();
							String sql = " SELECT COALESCE(MAX(FSNBR),0)+1 FROM ACCOUNT.FSLIPMST "
												 + "	WHERE FDCODE ='"+strFdcode+"'" 
												 + "	  AND FSDAT='"+strFsdat+"'"
												 + "	  AND FSNBR>='500000'" ; 
							ResultSet rs = stmt.executeQuery(sql); 
							if(rs.next()){
								 strFsnbr= rs.getString(1);
							}

							rs.close();
							int ichk = Integer.parseInt(strFsnbr);

							if(ichk<10) strFsnbr = "50000"+strFsnbr;
							else if(ichk>=10 && ichk<100)strFsnbr = "5000"+strFsnbr;
							else if(ichk>=100 && ichk<1000) strFsnbr ="500"+strFsnbr;
							else if(ichk>=1000 && ichk<10000)strFsnbr = "50"+strFsnbr;
							else if(ichk>=10000 && ichk<100000) strFsnbr = "5"+strFsnbr;		
						}
						
						rows[j].setString(idxFSNBR,strFsnbr);

					 /*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
           			@ 전표번호 채번 END
				    +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/


						//================================================================================<<<<
						if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
							 ///^^logger.dbg.println(this,"MST_I2");
							//error시 error 전표번호 
							strErrorNo = rows[j].getString(idxFDCODE)+"-"+rows[j].getString(idxFSDAT)+"-"+rows[j].getString(idxFSNBR);

							/************************************************************************************/
							//전표 Master
							/***********************************************************************************/
							/// logger.dbg.println(this,"InsertSql.toString()"+InsertSql.toString());
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

							// logger.dbg.println(this,"InsertSql END");

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
          
					 ///^^logger.dbg.println(this,"DTL");

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
            
						if(!strFSNBR2.equals("000000")){
							strFdcode = strFDCODE2;
							strFsdat = strFSDAT2;
							strFsnbr = strFSNBR2;
						}
						//logger.dbg.println(this,"k::"+k+":::"+rows2[k].getString(idx2FSNBR)+"strFSNBR2:::::"+strFSNBR2);
						/// logger.dbg.println(this,"DTL_I");
						/// logger.dbg.println(this,"strSeq" +strSeq);
						//전표행번호 Seq 생성(Max+1)=====================================================>>>>
						//if (k==0){
						/* 막음
							Statement stmt = conn.createStatement();
							String sql = " SELECT COALESCE(MAX(FSSEQ),0)+1 FROM ACCOUNT.FSLIPDTL "
												 + "	WHERE FDCODE ='"+strFDCODE2+"'" 
												 + "	  AND FSDAT='"+strFSDAT2+"'"
												 + "	  AND FSNBR='"+strFSNBR2+"'"; 
							ResultSet rs = stmt.executeQuery(sql); 
							if(rs.next()){
								 strSeq= rs.getString(1);
							}
							ichk2 = Integer.parseInt(strSeq);
         
						
						strSeq = String.valueOf(ichk2);
						if(ichk2<10) strSeq = "0000"+ strSeq;
						else if(ichk2>=10 && ichk2<100)strSeq = "000"+strSeq;
						else if(ichk2>=100 && ichk2<1000) strSeq ="00"+strSeq;
						else if(ichk2>=1000 && ichk2<10000)strSeq = "0"+strSeq;
						*/
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
						  ///^^logger.dbg.println(this,"DTL_I2");
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
							gsmt2.bindColumn(15, idx2FSNUM);
							gsmt2.bindColumn(16, idx2DIVCD);
							gsmt2.bindColumn(17, idx2BGTDIV);
							gsmt2.executeUpdate();
							///^^logger.dbg.println(this,"DTL_I222");
							gsmt2.close();

							///^^logger.dbg.println(this,"DTL_I333");

						/************************************************************************************/
						//전표 관리항목
						/************************************************************************************/
							for (int m=0;m<strFSREFSEQ.length;m++){

								if (!rows2[k].getString(idxFSREFCD[m]).equals("")&&!rows2[k].getString(idxFSREFCD[m]).equals(null)){
	
									///^^logger.dbg.println(this,"REF_I");
									//logger.dbg.println(this,"idxFSREFVAL"+rows2[k].getString(idxFSREFVAL[m]));
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

      
			///^^logger.dbg.println(this,"step11" );
			/************************************************************************************
			 @ Detail & Ref(관리항목 수정건) Update Update Update Update Update
			*************************************************************************************/
			GauceDataSet userSet3 = reqGauce.getGauceDataSet("USER3");
			//logger.dbg.println(this,"userSet3::" +userSet3);
			
      			if (userSet3 != null) {
				///^^logger.dbg.println(this,"DTL_U");
				int idx3FDCODE       = userSet3.indexOfColumn("FDCODE");
				int idx3FSDAT        = userSet3.indexOfColumn("FSDAT");
				int idx3FSNBR        = userSet3.indexOfColumn("FSNBR");
				int idx3FSSEQ        = userSet3.indexOfColumn("FSSEQ");
				int idx3ATCODE       = userSet3.indexOfColumn("ATCODE");
				int idx3ATDECR       = userSet3.indexOfColumn("ATDECR");
				int idx3REMARK       = userSet3.indexOfColumn("REMARK");
				int idx3CHAAMT       = userSet3.indexOfColumn("CHAAMT");
				int idx3DAEAMT       = userSet3.indexOfColumn("DAEAMT");

				///^^logger.dbg.println(this,"step1111" );

				String [] strFSREFSEQ3 = new String []{"FSREFSEQ01","FSREFSEQ02","FSREFSEQ03","FSREFSEQ04","FSREFSEQ05",  
																							 "FSREFSEQ06","FSREFSEQ07","FSREFSEQ08","FSREFSEQ09"}; 

				String [] strFSREFCD3 = new String []{"FSREFCD01","FSREFCD02","FSREFCD03","FSREFCD04","FSREFCD05",  
																							"FSREFCD06","FSREFCD07","FSREFCD08","FSREFCD09"}; 

				String [] strFSREFVAL3 = new String []{"FSREFVAL01","FSREFVAL02","FSREFVAL03","FSREFVAL04","FSREFVAL05",  
																							 "FSREFVAL06","FSREFVAL07","FSREFVAL08","FSREFVAL09"}; 

				///^^logger.dbg.println(this,"step2222" ); 
				int [] idxFSREFSEQ3 = new int[9];
				for (int i=0;i<strFSREFSEQ3.length;i++){
					idxFSREFSEQ3[i] = userSet3.indexOfColumn(strFSREFSEQ3[i]);
				}

				int [] idxFSREFCD3 = new int[9];
				for (int i=0;i<strFSREFCD3.length;i++){
					idxFSREFCD3[i] = userSet3.indexOfColumn(strFSREFCD3[i]);
				}

				int [] idxFSREFVAL3 = new int[9];
				for (int i=0;i<strFSREFVAL3.length;i++){
					idxFSREFVAL3[i] = userSet3.indexOfColumn(strFSREFVAL3[i]);
				}

				///^^logger.dbg.println(this,"step3333" ); 

				int idx3CNT           = userSet3.indexOfColumn("CNT");
				int idx3DOCUMCD       = userSet3.indexOfColumn("DOCUMCD");
				int idx3DOCUMNM       = userSet3.indexOfColumn("DOCUMNM");
				int idx3FSWRKDIV      = userSet3.indexOfColumn("FSWRKDIV");
				int idx3WRDT          = userSet3.indexOfColumn("WRDT");
				int idx3WRID          = userSet3.indexOfColumn("WRID");
				int idx3UPDT          = userSet3.indexOfColumn("UPDT");
				int idx3UPID          = userSet3.indexOfColumn("UPID");
				int idx3DOCUVAL       = userSet3.indexOfColumn("DOCUVAL");
				int idx3FSNUM         = userSet3.indexOfColumn("FSNUM");
				int idx3DIVCD         = userSet3.indexOfColumn("DIVCD");
				int idx3BGTDIV        = userSet3.indexOfColumn("BGTDIV");
				int idx3BANJAEYN      = userSet3.indexOfColumn("BANJAEYN");

				///^^logger.dbg.println(this,"step4444" ); 
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
				
				UpdateSql3.append( " UPDATE ACCOUNT.FSLIPDTL SET " );
				UpdateSql3.append( "        ATCODE = ?," );
				UpdateSql3.append( "        ATDECR = ?," );
				UpdateSql3.append( "        FSAMT = ?," );
				UpdateSql3.append( "        DOCUMCD = ?," );
				UpdateSql3.append( "        FSWRKDIV = ?," );
				UpdateSql3.append( "        REMARK = ?," );
				UpdateSql3.append( "        UPDT = ?," );
				UpdateSql3.append( "        UPID = ?," );
				UpdateSql3.append( "        DOCUVAL = ?," );
				UpdateSql3.append( "        FSNUM = ?," );
				UpdateSql3.append( "        DIVCD = ?," );
				UpdateSql3.append( "        BGTDIV = ?," );
				UpdateSql3.append( "        BANJAEYN = ?" );

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

			  ///^^logger.dbg.println(this,"step5555" );
				for (int u=0;u<rows3.length;u++){
					if(rows3[u].getJobType() == GauceDataRow.TB_JOB_INSERT){
						///^^logger.dbg.println(this,"DTL_U2");
						strFDCODE3 = rows3[u].getString(idx3FDCODE);
						strFSDAT3  = rows3[u].getString(idx3FSDAT);
						strFSNBR3  = rows3[u].getString(idx3FSNBR);
						strFSSEQ3  = rows3[u].getString(idx3FSSEQ);
						dblchaamt3 = rows3[u].getDouble(idx3CHAAMT);
						dbldaeamt3 = rows3[u].getDouble(idx3DAEAMT);

						if(!strFSNBR3.equals("000000")){
							strFdcode= strFDCODE3;
							strFsdat = strFSDAT3; 
							strFsnbr = strFSNBR3;
						}
				
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

					  ///^^logger.dbg.println(this,"DTL_U3");

						GauceStatement gsmt3 = conn.getGauceStatement(UpdateSql3.toString());
						///^^logger.dbg.println(this,"UpdateSql3.toString()::" +UpdateSql3.toString());
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
						gsmt3.bindColumn(10, idx3FSNUM);
						gsmt3.bindColumn(11, idx3DIVCD);
						gsmt3.bindColumn(12, idx3BGTDIV);
						gsmt3.bindColumn(13, idx3BGTDIV);
						gsmt3.bindColumn(14, idx3FDCODE);
						gsmt3.bindColumn(15, idx3FSDAT);
						gsmt3.bindColumn(16, idx3FSNBR);
						gsmt3.bindColumn(17, idx3FSSEQ);
						gsmt3.executeUpdate();
						gsmt3.close();
	 
						///^^logger.dbg.println(this,"REF_D");
						///^^logger.dbg.println(this,"DeleteSql3"+DeleteSql3);
						GauceStatement gsmt3_2 = conn.getGauceStatement(DeleteSql3.toString());
						///^^logger.dbg.println(this,"REF_D11");
						gsmt3_2.setGauceDataRow(rows3[u]);
						gsmt3_2.bindColumn(1, idx3FDCODE);
						gsmt3_2.bindColumn(2, idx3FSDAT);
						gsmt3_2.bindColumn(3, idx3FSNBR);
						gsmt3_2.bindColumn(4, idx3FSSEQ);
						gsmt3_2.executeUpdate();
						gsmt3_2.close();

						///^^logger.dbg.println(this,"REF_D2");
						///^^logger.dbg.println(this,"length"+strFSREFSEQ3.length);
						//관리항목 수정건...계정과목이 변경될 수 있으므로 Delete 후에 Insert함.
						for (int v=0;v<strFSREFSEQ3.length;v++){
   
							if (!rows3[u].getString(idxFSREFCD3[v]).equals("")&&!rows3[u].getString(idxFSREFCD3[v]).equals(null)){
						    ///^^logger.dbg.println(this,"REF_I");
								int ichk3_3 = v+1;
								strSeq3_3 = String.valueOf(ichk3_3);
								if(ichk3_3<10) strSeq3_3 = "0"+ strSeq3_3;
								
							//logger.dbg.println(this,"v:"+v+"idxFSREFCD3"+rows3[u].getString(idxFSREFCD3[v]));
							//logger.dbg.println(this,"idxFSREFVAL3"+rows3[u].getString(idxFSREFVAL3[v]));

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

						    ///^^logger.dbg.println(this,"sql3"+sql3);

								GauceStatement gsmt3_3 = conn.getGauceStatement(sql3);
								gsmt3_3.executeUpdate();
								gsmt3_3.close();
							} //if 
						} //for V

					}//if
				}//for u
      }//if
       ///^^logger.dbg.println(this,"step15" );
			/************************************************************************************
			 @ Detail End(관리항목 수정건)  Update Update Update Update Update
			*************************************************************************************/

      			/************************************************************************************
			 	@ DELETE  삭제  Start 
      			 *************************************************************************************/
      			GauceDataSet userSet4 = reqGauce.getGauceDataSet("USER4");
      			//logger.dbg.println(this,"USER4");
      			if (userSet4 != null) {
      				//logger.dbg.println(this,"USER4_del_start");

			 	int idx4FDCODE  = userSet4.indexOfColumn("FDCODE");  
				int idx4FSDAT   = userSet4.indexOfColumn("FSDAT");   
				int idx4FSNBR   = userSet4.indexOfColumn("FSNBR");  
				int idx4FSSEQ   = userSet4.indexOfColumn("FSSEQ");
				
				GauceDataRow[] rows4 = userSet4.getDataRows();
				
				StringBuffer DeleteSql_DTL = null;
				StringBuffer DeleteSql_REF = null;
				StringBuffer DeleteTAX_MST = null;
				StringBuffer DeleteTAX_DTL = null;
				String strFDCODE4="";
				String strFSDAT4="";
				String strFSNBR4="";
				String strFSSEQ4="";
			
				DeleteSql_DTL = new StringBuffer();
				DeleteSql_REF = new StringBuffer();
				DeleteTAX_MST = new StringBuffer();
				DeleteTAX_DTL = new StringBuffer();

				DeleteSql_DTL.append( " DELETE FROM  ACCOUNT.FSLIPDTL  " );
				DeleteSql_DTL.append( "  WHERE FDCODE = ? " );
				DeleteSql_DTL.append( "    AND FSDAT = ? " );
				DeleteSql_DTL.append( "    AND FSNBR = ? " );
				DeleteSql_DTL.append( "    AND FSSEQ = ? " );
				
				DeleteSql_REF.append( " DELETE FROM  ACCOUNT.FSLIPREF  " );
				DeleteSql_REF.append( "  WHERE FDCODE = ? " );
				DeleteSql_REF.append( "    AND FSDAT = ? " );
				DeleteSql_REF.append( "    AND FSNBR = ? " );
				DeleteSql_REF.append( "    AND FSSEQ = ? " );

				///^^logger.dbg.println(this,"step1");

				for (int jj=0;jj<rows4.length; jj++){
					 	///^^logger.dbg.println(this,"step2::jj::" +  jj );
						///^^logger.dbg.println(this,"rows4[jj].getString(idx4FDCODE)::"+rows4[jj].getString(idx4FDCODE));
						///^^logger.dbg.println(this,"rows4[jj].getString(idx4FSDAT)::"+rows4[jj].getString(idx4FSDAT));
						///^^logger.dbg.println(this,"rows4[jj].getString(idx4FSNBR)::"+rows4[jj].getString(idx4FSNBR));
						///^^logger.dbg.println(this,"rows4[jj].getString(idx4FSSEQ)::"+rows4[jj].getString(idx4FSSEQ));
            
						strFDCODE4 = rows4[jj].getString(idx4FDCODE);
						strFSDAT4  = rows4[jj].getString(idx4FSDAT);
						strFSNBR4  = rows4[jj].getString(idx4FSNBR);
						strFSSEQ4  = rows4[jj].getString(idx4FSSEQ);

						if(!strFSNBR4.equals("000000")){
							strFdcode= strFDCODE4;
							strFsdat = strFSDAT4; 
							strFsnbr = strFSNBR4;
							strFsseq = strFSSEQ4;
            }

						///^^logger.dbg.println(this,"strFdcode::"+strFdcode+"::strFsdat::"+strFsdat+"::strFsnbr::"+strFsnbr+"::strFsseq::"+strFsseq);
						
						//DETAIL의 건수 만큼 돌려서 계산서 번호를 찾아내어 존재하면 계산서 delete 시킴
						StringBuffer sql4 = new StringBuffer();
						Statement stmt4 = null;
						ResultSet rs4 = null;
						sql4.append( " SELECT COALESCE(ACNNBR,'') 					");
						sql4.append( "   FROM ACCOUNT.FSLIPDTL     	 ");
						sql4.append( "  WHERE FDCODE ='"+strFDCODE4+"' ");
						sql4.append( "    AND FSDAT ='"+strFSDAT4+"' ");
						sql4.append( "    AND FSNBR ='"+strFSNBR4+"' ");
						sql4.append( "    AND FSSEQ ='"+strFSSEQ4+"' ");
						
						stmt4 = conn.createStatement();
						rs4 = stmt4.executeQuery(sql4.toString());
						///^^logger.dbg.println(this,"step4");
						while(rs4.next())	{
							strAcnnbr = rs4.getString(1);
							///^^logger.dbg.println(this,"strAcnnbr"+strAcnnbr);
							if (!strAcnnbr.equals("")){
								///^^logger.dbg.println(this,"step42");
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

						rs4.close();
               
            ///^^logger.dbg.println(this,"step7");
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

					  ///^^logger.dbg.println(this,"step9");
         }//for
			}//if
      /************************************************************************************
			 @ DELETE  삭제  End 
			*************************************************************************************/

			/************************************************************************************
			 @ BANJAEREL 연결 Start  - 입력
			*************************************************************************************/
		 GauceDataSet userSet6 = reqGauce.getGauceDataSet("USER6");
		 //logger.dbg.println(this,"USER6");

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

				int idx6SSDAT         = userSet6.indexOfColumn("SSDAT");  
				int idx6SSNBR         = userSet6.indexOfColumn("SSNBR");  
				int idx6FSNUM         = userSet6.indexOfColumn("FSNUM");  
				int idx6BJDEAMT       = userSet6.indexOfColumn("BJDEAMT");  
				int idx6BJCRAMT       = userSet6.indexOfColumn("BJCRAMT");  
				int idx6BSDAT         = userSet6.indexOfColumn("BSDAT");  
				int idx6BSNBR         = userSet6.indexOfColumn("BSNBR");  
				int idx6BSNUM         = userSet6.indexOfColumn("BSNUM");  
				
				int idx6WRDT           = userSet6.indexOfColumn("WRDT");  
				int idx6WRID           = userSet6.indexOfColumn("WRID");  
				int idx6UPDT           = userSet6.indexOfColumn("UPDT");  
				int idx6UPID           = userSet6.indexOfColumn("UPID");  

				GauceDataRow[] rows6 = userSet6.getDataRows();

				StringBuffer InsertSql6 = null;
				InsertSql6 = new StringBuffer();
        
				InsertSql6.append( " INSERT INTO ACCOUNT.BANJAEREL (  " );
				InsertSql6.append( " FTSTAT,	FDCODE,	TSDAT,	TSNBR,	  TSSEQ,  " );
				InsertSql6.append( " BTSDAT,	BTSNBR,	BTSSEQ,	BANJAEYN, SSDAT,  " );
				InsertSql6.append( " SSNBR,	  FSNUM,	BJDEAMT,BJCRAMT,	 " );
				InsertSql6.append( " BSDAT,	  BSNBR,	BSNUM,	 " );
				InsertSql6.append( " WRDT,    WRID	" );
				InsertSql6.append( "  ) " );
				InsertSql6.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,? ) ");
        
				for (int b=0;b<rows6.length;b++){

					rows6[b].setString(idx6FDCODE,strFdcode);
					rows6[b].setString(idx6BTSDAT,strFsdat);
					rows6[b].setString(idx6BTSNBR,strFsnbr);
        /*
					InsertSql6.append( " INSERT INTO ACCOUNT.BANJAEREL (  " );
					InsertSql6.append( " FTSTAT,	FDCODE,	TSDAT,	TSNBR,	  TSSEQ,  " );
					InsertSql6.append( " BTSDAT,	BTSNBR,	BTSSEQ,	BANJAEYN, SSDAT,  " );
					InsertSql6.append( " SSNBR,	  FSNUM,	BJDEAMT,BJCRAMT,	 " );
					InsertSql6.append( " BSDAT,	  BSNBR,	BSNUM,	 " );
					InsertSql6.append( " WRDT,    WRID	" );
					InsertSql6.append( "  ) " );
					InsertSql6.append( " VALUES ( '"+rows6[b].getString(idx6FTSTAT)+"'," );
					InsertSql6.append( " '"+rows6[b].getString(idx6FDCODE)+"'," );
					InsertSql6.append( " '"+rows6[b].getString(idx6TSDAT)+"'," );
					InsertSql6.append( " '"+rows6[b].getString(idx6TSNBR)+"'," );
					InsertSql6.append( " '"+rows6[b].getString(idx6TSSEQ)+"'," );
					InsertSql6.append( " '"+rows6[b].getString(idx6BTSDAT)+"'," );
					InsertSql6.append( " '"+rows6[b].getString(idx6BTSNBR)+"'," );
					InsertSql6.append( " '"+rows6[b].getString(idx6BTSSEQ)+"'," );
					InsertSql6.append( " '"+rows6[b].getString(idx6BANJAEYN)+"'," );
					InsertSql6.append( " '"+rows6[b].getString(idx6SSDAT)+"'," );
					InsertSql6.append( " '"+rows6[b].getString(idx6SSNBR)+"'," );
					InsertSql6.append( " '"+rows6[b].getString(idx6FSNUM)+"'," );
					InsertSql6.append( " "+rows6[b].getDouble(idx6BJDEAMT)+"," );
          			InsertSql6.append( " "+rows6[b].getDouble(idx6BJCRAMT)+"," );
					InsertSql6.append( " '"+rows6[b].getString(idx6BSDAT)+"'," );
					InsertSql6.append( " '"+rows6[b].getString(idx6BSNBR)+"'," );
					InsertSql6.append( " '"+rows6[b].getString(idx6BSNUM)+"'," );
					InsertSql6.append( " '"+rows6[b].getString(idx6WRDT)+"'," );
					InsertSql6.append( " '"+rows6[b].getString(idx6WRID)+"')" );
          			logger.dbg.println(this,"InsertSql6:: "+InsertSql6.toString());
					*/
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
					gsmt6.bindColumn(10,idx6SSDAT);
					gsmt6.bindColumn(11,idx6SSNBR);
					gsmt6.bindColumn(12,idx6FSNUM);
					gsmt6.bindColumn(13,idx6BJDEAMT);
					gsmt6.bindColumn(14,idx6BJCRAMT);
					gsmt6.bindColumn(15,idx6BSDAT);
					gsmt6.bindColumn(16,idx6BSNBR);
					gsmt6.bindColumn(17,idx6BSNUM);
					gsmt6.bindColumn(18,idx6WRDT);
					gsmt6.bindColumn(19,idx6WRID);
         
					///^^logger.dbg.println(this,"step999");
					
					gsmt6.executeUpdate();
					gsmt6.close();
				}
		 }
				
			 /************************************************************************************
			 @ BANJAEREL 연결 End 
			*************************************************************************************/

			/************************************************************************************
			 @ BANJAE MST Start  - 입력
			*************************************************************************************/
		 GauceDataSet userSet14 = reqGauce.getGauceDataSet("USER14");
		 //logger.dbg.println(this,"USER14");
		 double dbldeamt=0;
		 double dblcramt=0;
		 double dbldeamt14=0;
		 double dblcramt14=0;
		 double dblamt14=0;
		 String strgubun14="";
		 String strStatus="";
		 String strAtdecr="";
		 ///^^logger.dbg.println(this,"banjaemst");

		 if (userSet14 != null) {

			  int idx14FDCODE         = userSet14.indexOfColumn("FDCODE");  
				int idx14TSDAT          = userSet14.indexOfColumn("TSDAT");  
				int idx14TSNBR          = userSet14.indexOfColumn("TSNBR");  
				int idx14TSSEQ          = userSet14.indexOfColumn("TSSEQ");  
				int idx14ATCODE         = userSet14.indexOfColumn("ATCODE");  
				
				int idx14DEPTCD         = userSet14.indexOfColumn("DEPTCD");  
				int idx14VENDCD         = userSet14.indexOfColumn("VENDCD");  
				int idx14FSREFCD        = userSet14.indexOfColumn("FSREFCD");  
				int idx14FSREFVAL       = userSet14.indexOfColumn("FSREFVAL"); 
				int idx14DEAMT          = userSet14.indexOfColumn("DEAMT");  

				int idx14CRAMT         = userSet14.indexOfColumn("CRAMT");  
				int idx14STATUS        = userSet14.indexOfColumn("STATUS");  
				int idx14SSDAT         = userSet14.indexOfColumn("SSDAT");  
				int idx14SSNBR         = userSet14.indexOfColumn("SSNBR");  
				int idx14FSNUM         = userSet14.indexOfColumn("FSNUM"); 
				
				int idx14REMARK        = userSet14.indexOfColumn("REMARK"); 
				
				int idx14WRDT          = userSet14.indexOfColumn("WRDT");  
				int idx14WRID          = userSet14.indexOfColumn("WRID");  
				int idx14UPDT          = userSet14.indexOfColumn("UPDT");  
				int idx14UPID          = userSet14.indexOfColumn("UPID");  
				int idx14AMT           = userSet14.indexOfColumn("AMT");  

				GauceDataRow[] rows14 = userSet14.getDataRows();

				StringBuffer InsertSql14 = null;
				StringBuffer UpdateSql14 = null;
				StringBuffer UpdateSql14_2 = null;
				InsertSql14 = new StringBuffer();
				UpdateSql14 = new StringBuffer();
				UpdateSql14_2 = new StringBuffer();
        
				InsertSql14.append( " INSERT INTO ACCOUNT.BANJAEMST (  " );
				InsertSql14.append( " FDCODE,	TSDAT,	TSNBR,	 TSSEQ,	   ATCODE,  " );
				InsertSql14.append( " DEPTCD,	VENDCD,	FSREFCD, FSREFVAL, DEAMT,   " );
				InsertSql14.append( " CRAMT,	STATUS,	SSDAT,	 SSNBR,	   FSNUM,   " );
				InsertSql14.append( " REMARK, WRDT,   WRID	" );
				InsertSql14.append( "  ) " );
				InsertSql14.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,? ) ");
        
				//받은 값 대변이 0 일 경우 차변 UPDATE
				UpdateSql14.append( " UPDATE ACCOUNT.BANJAEMST SET " );
				UpdateSql14.append( "        CRAMT = ?," );
				UpdateSql14.append( "        STATUS = ?," );
				UpdateSql14.append( "        UPDT = ?," );
				UpdateSql14.append( "        UPID = ?" );
				UpdateSql14.append( "  WHERE FDCODE=?" );
				UpdateSql14.append( "    AND TSDAT=?" );
				UpdateSql14.append( "    AND TSNBR=?" );
				UpdateSql14.append( "    AND TSSEQ=?" );

				//받은 값 차변이 0 일 경우 대변 UPDATE
				UpdateSql14_2.append( " UPDATE ACCOUNT.BANJAEMST SET " );
				UpdateSql14_2.append( "        DEAMT = ?," );				
				UpdateSql14_2.append( "        STATUS = ?," );
				UpdateSql14_2.append( "        UPDT = ?," );
				UpdateSql14_2.append( "        UPID = ?" );
				UpdateSql14_2.append( "  WHERE FDCODE=?" );
				UpdateSql14_2.append( "    AND TSDAT=?" );
				UpdateSql14_2.append( "    AND TSNBR=?" );
				UpdateSql14_2.append( "    AND TSSEQ=?" );
        
				for (int b=0;b<rows14.length;b++){

					dbldeamt14 = rows14[b].getDouble(idx14DEAMT); //차변금액(받은값)
					dblcramt14 = rows14[b].getDouble(idx14CRAMT); //대변금액(받은값)
					dblamt14 = rows14[b].getDouble(idx14AMT);     //반제원금액
					strgubun14="";
					strAtdecr="";

					Statement stmt14 = conn.createStatement();
					String sql14 = " SELECT A.DEAMT, A.CRAMT, B.ATDECR FROM ACCOUNT.BANJAEMST A "
					             + "   LEFT JOIN ACCOUNT.ACTCODE B ON A.ATCODE = B.ATCODE "
										   + "	WHERE A.FDCODE ='"+rows14[b].getString(idx14FDCODE)+"'"
											 + "	  AND A.TSDAT ='"+rows14[b].getString(idx14TSDAT)+"'"
											 + "	  AND A.TSNBR ='"+rows14[b].getString(idx14TSNBR)+"'"
											 + "	  AND A.TSSEQ ='"+rows14[b].getString(idx14TSSEQ)+"'";
					//logger.dbg.println(this,"sql14::"+sql14);
					ResultSet rs14 = stmt14.executeQuery(sql14); 
					
					if(rs14.next()){
						 strgubun14="1";
						 dbldeamt= rs14.getDouble(1);
						 dblcramt= rs14.getDouble(2);
						 strAtdecr= rs14.getString(3);
					}

					rs14.close();
										
					if(!strgubun14.equals("1")){    //insert 반제대상전표
						if(dbldeamt14==0){            //차변이 0일 경우 차변에 전체 금액 넣음.
						   if(dblcramt14==dblamt14){  //완료
								  strStatus = "1";
							 }else{                     //진행중   
								  strStatus = "0";
							 }
							 rows14[b].setString(idx14STATUS,strStatus);	
							 rows14[b].setDouble(idx14CRAMT,dblamt14); 
						}else if(dblcramt14==0){     //대변이 0 일 경우 대변에 전체 금액 넣음.
						   if(dbldeamt14==dblamt14){ //완료
								  strStatus = "1";
							 }else{                    //진행중   
								  strStatus = "0";    
							 }
							 rows14[b].setString(idx14STATUS,strStatus);
							 rows14[b].setDouble(idx14DEAMT,dblamt14);	
						}

						GauceStatement gsmt14 = conn.getGauceStatement(InsertSql14.toString());
						gsmt14.setGauceDataRow(rows14[b]);
						gsmt14.bindColumn(1,idx14FDCODE);
						gsmt14.bindColumn(2,idx14TSDAT);
						gsmt14.bindColumn(3,idx14TSNBR);
						gsmt14.bindColumn(4,idx14TSSEQ);
						gsmt14.bindColumn(5,idx14ATCODE);
						gsmt14.bindColumn(6,idx14DEPTCD);
						gsmt14.bindColumn(7,idx14VENDCD);
						gsmt14.bindColumn(8,idx14FSREFCD);
						gsmt14.bindColumn(9,idx14FSREFVAL);
						gsmt14.bindColumn(10,idx14DEAMT);
						gsmt14.bindColumn(11,idx14CRAMT);
						gsmt14.bindColumn(12,idx14STATUS);
						gsmt14.bindColumn(13,idx14SSDAT);
						gsmt14.bindColumn(14,idx14SSNBR);
						gsmt14.bindColumn(15,idx14FSNUM);
						gsmt14.bindColumn(16,idx14REMARK);
						gsmt14.bindColumn(17,idx14WRDT);
						gsmt14.bindColumn(18,idx14WRID);
						///^^logger.dbg.println(this,"gsmt14");
					
						gsmt14.executeUpdate();
						gsmt14.close();
					}else{                      //update
						///^^logger.dbg.println(this,"idx14DEAMT2222:::"+rows14[b].getDouble(idx14DEAMT));
						///^^logger.dbg.println(this,"idx14CRAMT2222:::"+rows14[b].getDouble(idx14CRAMT));
						String sdblcramt14 = "";
						String sdblcramt = "";
						String sdblamt14 = "";
						String sdbldeamt14 = "";
						String sdbldeamt = "";

						if(strAtdecr.equals("2")){        // 받은 값의 차변이 0일 경우 == 대변계정
						   dblcramt += dblcramt14;
							 sdblcramt14 = String.valueOf(dblcramt14);
						   sdblcramt = String.valueOf(dblcramt);
						   sdblamt14 = String.valueOf(dblamt14);
						   //logger.dbg.println(this,"sdblcramt14::"+sdblcramt14+"::sdblcramt::"+sdblcramt+"::sdblamt14::"+sdblamt14);

							 if(dblcramt==dblamt14){//완료
								  strStatus = "1";
							 }else{                   //진행중   
								  strStatus = "0";
							 }
								rows14[b].setString(idx14STATUS,strStatus);
								rows14[b].setDouble(idx14CRAMT,dblcramt); 
               
							  GauceStatement gsmt14 = conn.getGauceStatement(UpdateSql14.toString());
								gsmt14.setGauceDataRow(rows14[b]);
								gsmt14.bindColumn(1,idx14CRAMT);
								gsmt14.bindColumn(2,idx14STATUS);
								gsmt14.bindColumn(3,idx14UPDT);
								gsmt14.bindColumn(4,idx14UPID);
								gsmt14.bindColumn(5,idx14FDCODE);
								gsmt14.bindColumn(6,idx14TSDAT);
								gsmt14.bindColumn(7,idx14TSNBR);
								gsmt14.bindColumn(8,idx14TSSEQ);
								///^^logger.dbg.println(this,"gsmt14");
								gsmt14.executeUpdate();
								gsmt14.close();

						}else if(strAtdecr.equals("1")){     //받은 값의 대변이 0일 경우 == 차변계정
							 dbldeamt += dbldeamt14;
							 sdbldeamt14 = String.valueOf(dbldeamt14);
						   sdbldeamt = String.valueOf(dbldeamt);
						   sdblamt14 = String.valueOf(dblamt14);
						   //logger.dbg.println(this,"sdbldeamt14::"+sdbldeamt14+"::sdbldeamt::"+sdbldeamt+"::sdblamt14::"+sdblamt14);
							 if(dbldeamt==dblamt14){   //완료
								  strStatus = "1";
							 }else{                    //진행중   
								  strStatus = "0";    
							 }
								
								rows14[b].setString(idx14STATUS,strStatus);
								rows14[b].setDouble(idx14DEAMT,dbldeamt);

								GauceStatement gsmt14 = conn.getGauceStatement(UpdateSql14_2.toString());
								gsmt14.setGauceDataRow(rows14[b]);

								gsmt14.bindColumn(1,idx14DEAMT);
								gsmt14.bindColumn(2,idx14STATUS);
								gsmt14.bindColumn(3,idx14UPDT);
								gsmt14.bindColumn(4,idx14UPID);
								gsmt14.bindColumn(5,idx14FDCODE);
								gsmt14.bindColumn(6,idx14TSDAT);
								gsmt14.bindColumn(7,idx14TSNBR);
								gsmt14.bindColumn(8,idx14TSSEQ);
								///^^logger.dbg.println(this,"gsmt14");
								gsmt14.executeUpdate();
								gsmt14.close();
						}
					}//!strgubun14.

          /**************************************************************************
					반제원장에서 모두 처리해서 막음.
					//전표의 원전표에 BANJAEYN  최초 - Y 진행중 0  완료 1   반제아님 N 
					 String  sql14_3 = " UPDATE ACCOUNT.FSLIPDTL SET "
													 + "        BANJAEYN ='"+strStatus+"'"
													 + "  WHERE FDCODE ='"+rows14[b].getString(idx14FDCODE)+"'"
													 + "    AND FSDAT ='"+rows14[b].getString(idx14TSDAT)+"'"
													 + "    AND FSNBR ='"+rows14[b].getString(idx14TSNBR)+"'"
													 + "    AND FSSEQ ='"+rows14[b].getString(idx14TSSEQ)+"'";

					///^^logger.dbg.println(this,"sql14_3::"+sql14_3);
					GauceStatement gsmt14_3 = conn.getGauceStatement(sql14_3);
					gsmt14_3.executeUpdate();
					gsmt14_3.close();
					****************************************************************************/

				}// for
		 }
			/************************************************************************************
			 @ BANJAE MST End 
			*************************************************************************************/

			/************************************************************************************
			 @ 계산서  Start  - 수정
			*************************************************************************************/
		 	GauceDataSet userSet7 = reqGauce.getGauceDataSet("USER7");
		 	//logger.dbg.println(this,"USER7");
		 	if (userSet7 != null) {
			 //logger.dbg.println(this,"USER777");
		 		int idx7TAXNBR         = userSet7.indexOfColumn("TAXNBR");  
				int idx7FDCODE         = userSet7.indexOfColumn("FDCODE");  
				int idx7FSDAT          = userSet7.indexOfColumn("FSDAT");  
				int idx7FSNBR          = userSet7.indexOfColumn("FSNBR");  
				int idx7UPDT           = userSet7.indexOfColumn("UPDT");  
				int idx7UPID           = userSet7.indexOfColumn("UPID");  

				GauceDataRow[] rows7 = userSet7.getDataRows();
				
			
				StringBuffer UpdateSql7 = null;
				UpdateSql7 = new StringBuffer();

				UpdateSql7.append( " UPDATE ACCOUNT.ATTAXMST SET " );
				UpdateSql7.append( "        FDCODE = ?," );
				UpdateSql7.append( "        FSDAT = ?," );
				UpdateSql7.append( "        FSNBR = ?," );
				UpdateSql7.append( "        UPDT = ?," );
				UpdateSql7.append( "        UPID = ?" );
				UpdateSql7.append( "  WHERE TAXNBR=?" );

				//logger.dbg.println(this,"length::"+rows7.length);			
				for (int c=0;c<rows7.length;c++){
					// logger.dbg.println(this,"c::"+c);					
					
					String str7TAXNBR = rows7[c].getString(idx7TAXNBR);
					String str7FDCODE = rows7[c].getString(idx7FDCODE);
					String str7FSDAT = rows7[c].getString(idx7FSDAT);
					String str7FSNBR = rows7[c].getString(idx7FSNBR);
					String str7UPDT = rows7[c].getString(idx7UPDT);
					String str7UPID = rows7[c].getString(idx7UPID);
          
					//logger.dbg.println(this,"str7TAXNBR::"+ str7TAXNBR); 
					//logger.dbg.println(this,"str7FDCODE::"+ str7FDCODE); 
					//logger.dbg.println(this,"str7FSDAT ::"+ str7FSDAT); 
					//logger.dbg.println(this,"str7FSNBR ::"+ str7FSNBR); 
					//logger.dbg.println(this,"str7UPDT =::"+ str7UPDT); 
					//logger.dbg.println(this,"str7UPID =::"+ str7UPID); 
					
       /*
					UpdateSql7.append( " UPDATE ACCOUNT.ATTAXMST SET " );
					UpdateSql7.append( "        FDCODE = '"+str7FDCODE+"'," );
					UpdateSql7.append( "        FSDAT ='"+str7FSDAT+"'," );
					UpdateSql7.append( "        F/SNBR = '"+str7FSNBR+"'," );
					UpdateSql7.append( "        UPDT = '"+str7UPDT+"'," );
					UpdateSql7.append( "        UPID = '"+str7UPID+"'" );
					UpdateSql7.append( "  WHERE TAXNBR='"+str7TAXNBR+"'" );
       */
				
					rows7[c].setString(idx7FSNBR,strFsnbr);
		      		//logger.dbg.println(this,"UpdateSql7.toString()"+ UpdateSql7.toString());
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

				 //logger.dbg.println(this,"END::");		
		 } //if
				
			/************************************************************************************
			 @ 계산서 수정 End 
			*************************************************************************************/

			/************************************************************************************
			 @ 일반증빙 - 입력
			*************************************************************************************/
		 		GauceDataSet userSet8 = reqGauce.getGauceDataSet("USER8");
		 		//logger.dbg.println(this,"userSet8");
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

				InsertSql8.append( " INSERT INTO ACCOUNT.GENRST (  " );
				InsertSql8.append( " FDCODE,	FSDAT,	FSNBR,	  FSSEQ,  RSVNO, " );
				InsertSql8.append( " RSTDIV,	RSTNO,	VEND_CD,	REMARK,	AMOUNT, " );
				InsertSql8.append( " RSVDATE, RSVMAN	" );
				InsertSql8.append( "  ) " );
				InsertSql8.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,? ) " );

				for (int b=0;b<rows8.length;b++){
					strRsmm = rows8[b].getString(idx8CURDATE);
					strRsmm = strRsmm.substring(0,6);
          
					Statement stmt8 = conn.createStatement();
					String sql8 = " SELECT COALESCE(MAX(SUBSTR(RSVNO,8,4)),0)+1 FROM ACCOUNT.GENRST "
										 + "	WHERE SUBSTR(RSVNO,2,6) ='"+strRsmm+"'";
					ResultSet rs8 = stmt8.executeQuery(sql8); 
					
					if(rs8.next()){
						 strRsvno= rs8.getString(1);
					}

					rs8.close();

					int ichk = Integer.parseInt(strRsvno);
					if(ichk<10) strRsvno = "000"+strRsvno;
					else if(ichk>=10 && ichk<100)strRsvno = "00"+strRsvno;
					else if(ichk>=100 && ichk<1000) strRsvno ="0"+strRsvno;

					strRsvno = "A"+ strRsmm +strRsvno;
					rows8[b].setString(idx8RSVNO,strRsvno);
					rows8[b].setString(idx8FSNBR,strFsnbr);
				  
					GauceStatement gsmt8 = conn.getGauceStatement(InsertSql8.toString());
					gsmt8.setGauceDataRow(rows8[b]);
         /* 
					logger.dbg.println(this,"idx8FDCODE  "+rows8[b].getString(idx8FDCODE));
					logger.dbg.println(this,"idx8FSDAT   "+rows8[b].getString(idx8FSDAT));
					logger.dbg.println(this,"idx8FSNBR   "+rows8[b].getString(idx8FSNBR));
					logger.dbg.println(this,"idx8FSSEQ   "+rows8[b].getString(idx8FSSEQ));
					logger.dbg.println(this,"idx8RSVNO   "+rows8[b].getString(idx8RSVNO));
					logger.dbg.println(this,"idx8RSTDIV  "+rows8[b].getString(idx8RSTDIV));
					logger.dbg.println(this,"idx8RSTNO   "+rows8[b].getString(idx8RSTNO));
					logger.dbg.println(this,"idx8VEND_CD "+rows8[b].getString(idx8VEND_CD));
					logger.dbg.println(this,"idx8REMARK  "+rows8[b].getString(idx8REMARK));
					logger.dbg.println(this,"idx8AMOUNT  "+rows8[b].getDouble(idx8AMOUNT));
					logger.dbg.println(this,"idx8RSVDATE "+rows8[b].getString(idx8RSVDATE));
					logger.dbg.println(this,"idx8RSVMAN  "+rows8[b].getString(idx8RSVMAN));
					*/												 
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
		@ 예산 - 신규입력 (예산 미승인 실적도 포함)
		*************************************************************************************/
	 	///^^logger.dbg.println(this,"예산입력");
		 GauceDataSet userSet9 = reqGauce.getGauceDataSet("USER9");
		 //logger.dbg.println(this,"userSet9");
		 if (userSet9 != null) {
        ///^^logger.dbg.println(this,"1");
			  	String strBgtyy="";
				dblYYBresults=0;
				dblMMBresults=0;
				dblchaamt_bgt=0;
				dblamt=0;

				int idx9BGTYY           = userSet9.indexOfColumn("BGTYY");  
				int idx9BGTMM           = userSet9.indexOfColumn("BGTMM");  
				int idx9BGTDIV          = userSet9.indexOfColumn("BGTDIV");  
				int idx9BGTDPT          = userSet9.indexOfColumn("BGTDPT");  
				int idx9ATCODE          = userSet9.indexOfColumn("ATCODE");  
				int idx9FSREFCD         = userSet9.indexOfColumn("FSREFCD");  
				int idx9SATCODE         = userSet9.indexOfColumn("SATCODE");  
				int idx9BGTMACT         = userSet9.indexOfColumn("BGTMACT");  
				int idx9CHAAMT          = userSet9.indexOfColumn("CHAAMT");  

				int idx9FDCODE          = userSet9.indexOfColumn("FDCODE");  
				int idx9ACTDAT          = userSet9.indexOfColumn("ACTDAT");  
			//	int idx9ATCODE          = userSet9.indexOfColumn("ATCODE");  
				int idx9COCODE          = userSet9.indexOfColumn("COCODE");  
				int idx9FSDAT           = userSet9.indexOfColumn("FSDAT");  
				int idx9FSNBR           = userSet9.indexOfColumn("FSNBR");  
				int idx9FSSEQ           = userSet9.indexOfColumn("FSSEQ");  

				String [] str94FSREFCD = new String []{"FSREFCD01","FSREFCD02","FSREFCD03","FSREFCD04","FSREFCD05",  
				                                     "FSREFCD06","FSREFCD07","FSREFCD08","FSREFCD09"}; 

				String [] str94FSREFVAL = new String []{"FSREFVAL01","FSREFVAL02","FSREFVAL03","FSREFVAL04","FSREFVAL05",  
				                                      "FSREFVAL06","FSREFVAL07","FSREFVAL08","FSREFVAL09"}; 

				int [] idx94FSREFCD = new int[9];
				for (int i=0;i<str94FSREFCD.length;i++){
					idx94FSREFCD[i] = userSet9.indexOfColumn(str94FSREFCD[i]);
				}

				int [] idx94FSREFVAL = new int[9];
				for (int i=0;i<str94FSREFVAL.length;i++){
					idx94FSREFVAL[i] = userSet9.indexOfColumn(str94FSREFVAL[i]);
				}
				
				///^^logger.dbg.println(this,"2");
				GauceDataRow[] rows9 = userSet9.getDataRows();

				StringBuffer UpdateSql9 = null;
				StringBuffer UpdateSql9_2 = null;
				StringBuffer InsertSql9_4 = null;
				StringBuffer InsertSql9_3 = null;
				UpdateSql9 = new StringBuffer();
				UpdateSql9_2 = new StringBuffer();
				InsertSql9_3 = new StringBuffer();
				InsertSql9_4 = new StringBuffer();
				///^^logger.dbg.println(this,"3");

				UpdateSql9.append( " UPDATE ACCOUNT.BGTMST SET  " );
				UpdateSql9.append( "        BRESULTS =? " );
				UpdateSql9.append( " WHERE BGTYY = ? ");
				UpdateSql9.append( "	 AND BGTDIV =? ");
				UpdateSql9.append( "   AND BGTDPT =? ");
				UpdateSql9.append( "   AND ATCODE =? ");
				UpdateSql9.append( "   AND FSREFCD = ?");
				UpdateSql9.append( "	 AND SATCODE = ?");
				// UpdateSql9.append( "	 AND BGTMACT = ?");
				
				UpdateSql9_2.append( " UPDATE ACCOUNT.BGTDTL SET  " );
				UpdateSql9_2.append( "        BRESULTS =? " );
				UpdateSql9_2.append( "  WHERE BGTYY = ? ");
				UpdateSql9_2.append( "	  AND BGTMM =? ");
				UpdateSql9_2.append( "	  AND BGTDIV =? ");
				UpdateSql9_2.append( "    AND BGTDPT =? ");
				UpdateSql9_2.append( "    AND ATCODE =? ");
				UpdateSql9_2.append( "    AND FSREFCD = ?");
				UpdateSql9_2.append( "	  AND SATCODE = ?");
				//UpdateSql9_2.append( "	  AND BGTMACT = ?");
				
				InsertSql9_3.append( " INSERT INTO ACCOUNT.BGTGELED (  " );
				InsertSql9_3.append( " FDCODE,	ACTDAT,	ATCODE,	  COCODE,  FSDAT, " );
				InsertSql9_3.append( " FSNBR,	  FSSEQ,	DEAMT " );
				InsertSql9_3.append( "  ) " );
				InsertSql9_3.append( " VALUES ( ?,?,?,?,?,?,?,? ) " );

				InsertSql9_4.append( " INSERT INTO ACCOUNT.BGTGEREF (" );
				InsertSql9_4.append( " FDCODE,  FSDAT,   FSNBR,   FSSEQ,   FSREFCD, FSREFVAL" );
				InsertSql9_4.append( "  ) " );
				InsertSql9_4.append( " VALUES ( ?,?,?,?,?,?) " ); 
						

				for (int b=0;b<rows9.length;b++){
					///^^logger.dbg.println(this,"4");

					dblYYBresults=0;
					dblMMBresults=0;
					dblamt=0;
					dblchaamt_bgt=0;
					dblchaamt_bgt = rows9[b].getDouble(idx9CHAAMT);
          
					///^^logger.dbg.println(this,"5");
					Statement stmt9_1 = conn.createStatement();
					///^^logger.dbg.println(this,"6");
					///^^logger.dbg.println(this,"idx9BGTYY  "+rows9[b].getString(idx9BGTYY));
					///^^logger.dbg.println(this,"idx9BGTDIV  "+rows9[b].getString(idx9BGTDIV));
					///^^logger.dbg.println(this,"idx9BGTDPT  "+rows9[b].getString(idx9BGTDPT));
					///^^logger.dbg.println(this,"idx9ATCODE  "+rows9[b].getString(idx9ATCODE));
					///^^logger.dbg.println(this,"idx9FSREFCD  "+rows9[b].getString(idx9FSREFCD));
					///^^logger.dbg.println(this,"idx9SATCODE  "+rows9[b].getString(idx9SATCODE));
					///^^logger.dbg.println(this,"idx9BGTMACT  "+rows9[b].getString(idx9BGTMACT));

					//세목이 없을 경우 00으로 설정
					if(rows9[b].getString(idx9SATCODE).equals("")){
						strSatcode="00";
						rows9[b].setString(idx9SATCODE,strSatcode);
					}

					///년별예산
					String sql9_1 = " SELECT COALESCE(BRESULTS,0)BRESULTS FROM ACCOUNT.BGTMST "
										    + "	 WHERE BGTYY ='"+rows9[b].getString(idx9BGTYY)+"'"
												+ "	   AND BGTDIV ='"+rows9[b].getString(idx9BGTDIV)+"'"
												+ "	   AND BGTDPT ='"+rows9[b].getString(idx9BGTDPT)+"'"
												+ "	   AND ATCODE ='"+rows9[b].getString(idx9ATCODE)+"'"
												+ "	   AND FSREFCD ='"+rows9[b].getString(idx9FSREFCD)+"'"
												+ "	   AND SATCODE ='"+rows9[b].getString(idx9SATCODE)+"'";
											//	+ "	   AND BGTMACT ='"+rows9[b].getString(idx9BGTMACT)+"'";
					///^^logger.dbg.println(this,"7");
					logger.dbg.println(this,"sql9_1"+sql9_1);
					///^^logger.dbg.println(this,"8");
					ResultSet rs9_1 = stmt9_1.executeQuery(sql9_1); 


					if(rs9_1.next()){
						 dblYYBresults= rs9_1.getDouble(1);
					}else{
						 dblYYBresults=0;
					}

					rs9_1.close();

					///^^logger.dbg.println(this,"dblYYBresults"+dblYYBresults);
					///^^logger.dbg.println(this,"dblchaamt_bgt"+dblchaamt_bgt);

					dblamt = dblYYBresults + dblchaamt_bgt;

					rows9[b].setString(idx9FSNBR,strFsnbr);
					rows9[b].setDouble(idx9CHAAMT,dblamt);

					//logger.dbg.println(this,"dblamt"+dblamt);
					        
					GauceStatement gsmt9 = conn.getGauceStatement(UpdateSql9.toString());
					gsmt9.setGauceDataRow(rows9[b]);
        					 
					gsmt9.bindColumn(1,idx9CHAAMT);
					gsmt9.bindColumn(2,idx9BGTYY);
					gsmt9.bindColumn(3,idx9BGTDIV);
					gsmt9.bindColumn(4,idx9BGTDPT);
					gsmt9.bindColumn(5,idx9ATCODE);
					gsmt9.bindColumn(6,idx9FSREFCD);
					gsmt9.bindColumn(7,idx9SATCODE);
					//gsmt9.bindColumn(8,idx9BGTMACT);
				
					gsmt9.executeUpdate();
					gsmt9.close();
          
					///월별예산
					dblamt=0;
					Statement stmt9_2 = conn.createStatement();
					String sql9_2 = " SELECT BRESULTS FROM ACCOUNT.BGTDTL "
										    + "	 WHERE BGTYY ='"+rows9[b].getString(idx9BGTYY)+"'"
										    + "	   AND BGTMM ='"+rows9[b].getString(idx9BGTMM)+"'"
												+ "	   AND BGTDIV ='"+rows9[b].getString(idx9BGTDIV)+"'"
												+ "	   AND BGTDPT ='"+rows9[b].getString(idx9BGTDPT)+"'"
												+ "	   AND ATCODE ='"+rows9[b].getString(idx9ATCODE)+"'"
												+ "	   AND FSREFCD ='"+rows9[b].getString(idx9FSREFCD)+"'"
												+ "	   AND SATCODE ='"+rows9[b].getString(idx9SATCODE)+"'";
												//+ "	   AND BGTMACT ='"+rows9[b].getString(idx9BGTMACT)+"'";
					//logger.dbg.println(this,sql9_2);
					  
					ResultSet rs9_2 = stmt9_2.executeQuery(sql9_2); 
					
					if(rs9_2.next()){
						 dblMMBresults= rs9_2.getDouble(1);
					}else{
						 dblMMBresults=0;
					}

					rs9_2.close();

					///^^logger.dbg.println(this,"dblMMBresults"+dblMMBresults);
					///^^logger.dbg.println(this,"idx9CHAAMT"+rows9[b].getDouble(idx9CHAAMT));

					dblamt = dblMMBresults +dblchaamt_bgt;
					//logger.dbg.println(this,"dblamt"+dblamt);
					rows9[b].setDouble(idx9CHAAMT,dblamt);
					
       
					GauceStatement gsmt9_2 = conn.getGauceStatement(UpdateSql9_2.toString());
					gsmt9_2.setGauceDataRow(rows9[b]);
        
					gsmt9_2.bindColumn(1,idx9CHAAMT);				  
					gsmt9_2.bindColumn(2,idx9BGTYY);
					gsmt9_2.bindColumn(3,idx9BGTMM);
					gsmt9_2.bindColumn(4,idx9BGTDIV);
					gsmt9_2.bindColumn(5,idx9BGTDPT);
					gsmt9_2.bindColumn(6,idx9ATCODE);
					gsmt9_2.bindColumn(7,idx9FSREFCD);
					gsmt9_2.bindColumn(8,idx9SATCODE);
					// gsmt9_2.bindColumn(9,idx9BGTMACT);
					
					gsmt9_2.executeUpdate();
					gsmt9_2.close();


					//예산총계정원장 (미승인 실적)
					//logger.dbg.println(this,"dblchaamt_bgt"+dblchaamt_bgt);
					//logger.dbg.println(this,"step");
					rows9[b].setDouble(idx9CHAAMT,dblchaamt_bgt);
					//logger.dbg.println(this,"step1");

					GauceStatement gsmt9_3 = conn.getGauceStatement(InsertSql9_3.toString());
					//logger.dbg.println(this,"step2");
					gsmt9_3.setGauceDataRow(rows9[b]);
					//logger.dbg.println(this,"step3");
        
					gsmt9_3.bindColumn(1,idx9FDCODE);				  
					gsmt9_3.bindColumn(2,idx9ACTDAT);
					gsmt9_3.bindColumn(3,idx9ATCODE);
					gsmt9_3.bindColumn(4,idx9COCODE);
					gsmt9_3.bindColumn(5,idx9FSDAT);
					gsmt9_3.bindColumn(6,idx9FSNBR);
					gsmt9_3.bindColumn(7,idx9FSSEQ);
					gsmt9_3.bindColumn(8,idx9CHAAMT);
					///^^logger.dbg.println(this,"step4");
					gsmt9_3.executeUpdate();
					gsmt9_3.close();

					//예산 관리항목원장 (미승인 실적)
					for (int i=0;i<=8;i++){
						 //logger.dbg.println(this,"i::" +i);
						 logger.dbg.println(this,"idx94FSREFVAL::" +rows9[b].getString(idx94FSREFVAL[i]));
						if(!rows9[b].getString(idx94FSREFVAL[i]).equals("")){
								GauceStatement gsmt9_4 = conn.getGauceStatement(InsertSql9_4.toString());
								gsmt9_4.setGauceDataRow(rows9[b]);
								
								gsmt9_4.bindColumn(1, idx9FDCODE);
								gsmt9_4.bindColumn(2, idx9FSDAT);
								gsmt9_4.bindColumn(3, idx9FSNBR);
								gsmt9_4.bindColumn(4, idx9FSSEQ);
								gsmt9_4.bindColumn(5, idx94FSREFCD[i]);
								gsmt9_4.bindColumn(6, idx94FSREFVAL[i]);
								gsmt9_4.executeUpdate();
								gsmt9_4.close();
						}
					}
				}//for b
				 
		 }
				
			/************************************************************************************
			 @ 예산 - 입력 end
			*************************************************************************************/

		 	/************************************************************************************
			@ 예산 - 수정 start
			*************************************************************************************/
	 	 	///^^logger.dbg.println(this,"예산수정");
		 	GauceDataSet userSet10 = reqGauce.getGauceDataSet("USER10");
		 	//logger.dbg.println(this,"USER10");
		 	if (userSet10 != null) {
			  String strBgtyy="";
			  dblYYBresults=0;
			  dblMMBresults=0;
			  dblbchaamt_bgt=0;     //변경전 금액
			  dblchaamt_bgt=0;      //변경후 금액
			  dblamt=0;
        
				//변경전
				int idx10BBGTYY           = userSet10.indexOfColumn("BBGTYY");  
				int idx10BBGTMM           = userSet10.indexOfColumn("BBGTMM");  
				int idx10BBGTDIV          = userSet10.indexOfColumn("BBGTDIV");  
				int idx10BBGTDPT          = userSet10.indexOfColumn("BBGTDPT");  
				int idx10BATCODE          = userSet10.indexOfColumn("BATCODE");  
				int idx10BFSREFCD         = userSet10.indexOfColumn("BFSREFCD");  
				int idx10BSATCODE         = userSet10.indexOfColumn("BSATCODE");  
				int idx10BBGTMACT         = userSet10.indexOfColumn("BBGTMACT");  
				int idx10BCHAAMT          = userSet10.indexOfColumn("BCHAAMT");  
				int idx10BACTDAT          = userSet10.indexOfColumn("BACTDAT");  

				//변경후
				int idx10BGTYY           = userSet10.indexOfColumn("BGTYY");  
				int idx10BGTMM           = userSet10.indexOfColumn("BGTMM");  
				int idx10BGTDIV          = userSet10.indexOfColumn("BGTDIV");  
				int idx10BGTDPT          = userSet10.indexOfColumn("BGTDPT");  
				int idx10ATCODE          = userSet10.indexOfColumn("ATCODE");  
				int idx10FSREFCD         = userSet10.indexOfColumn("FSREFCD");  
				int idx10SATCODE         = userSet10.indexOfColumn("SATCODE");  
				int idx10BGTMACT         = userSet10.indexOfColumn("BGTMACT");  
				int idx10CHAAMT          = userSet10.indexOfColumn("CHAAMT");  

				//예산총계정원장
				int idx10FDCODE          = userSet10.indexOfColumn("FDCODE");  
				int idx10ACTDAT          = userSet10.indexOfColumn("ACTDAT");  
				//	int idx10ATCODE      = userSet10.indexOfColumn("ATCODE");  
				int idx10COCODE          = userSet10.indexOfColumn("COCODE");  
				int idx10FSDAT           = userSet10.indexOfColumn("FSDAT");  
				int idx10FSNBR           = userSet10.indexOfColumn("FSNBR");  
				int idx10FSSEQ           = userSet10.indexOfColumn("FSSEQ");  

				//변경전
				String [] str104BFSREFCD = new String []{"BFSREFCD01","BFSREFCD02","BFSREFCD03","BFSREFCD04","BFSREFCD05",  
				                                       "BFSREFCD06","BFSREFCD07","BFSREFCD08","BFSREFCD09"}; 

				String [] str104BFSREFVAL = new String []{"BFSREFVAL01","BFSREFVAL02","BFSREFVAL03","BFSREFVAL04","BFSREFVAL05",  
				                                        "BFSREFVAL06","BFSREFVAL07","BFSREFVAL08","BFSREFVAL09"}; 

				int [] idx104BFSREFCD = new int[9];
				for (int i=0;i<str104BFSREFCD.length;i++){
					idx104BFSREFCD[i] = userSet10.indexOfColumn(str104BFSREFCD[i]);
				}

				int [] idx104BFSREFVAL = new int[9];
				for (int i=0;i<str104BFSREFVAL.length;i++){
					idx104BFSREFVAL[i] = userSet10.indexOfColumn(str104BFSREFVAL[i]);
				}
         
				//변경후
				String [] str104FSREFCD = new String []{"FSREFCD01","FSREFCD02","FSREFCD03","FSREFCD04","FSREFCD05",  
				                                       "FSREFCD06","FSREFCD07","FSREFCD08","FSREFCD09"}; 

				String [] str104FSREFVAL = new String []{"FSREFVAL01","FSREFVAL02","FSREFVAL03","FSREFVAL04","FSREFVAL05",  
				                                        "FSREFVAL06","FSREFVAL07","FSREFVAL08","FSREFVAL09"}; 

				int [] idx104FSREFCD = new int[9];
				for (int i=0;i<str104FSREFCD.length;i++){
					idx104FSREFCD[i] = userSet10.indexOfColumn(str104FSREFCD[i]);
				}

				int [] idx104FSREFVAL = new int[9];
				for (int i=0;i<str104FSREFVAL.length;i++){
					idx104FSREFVAL[i] = userSet10.indexOfColumn(str104FSREFVAL[i]);
				}
				
				GauceDataRow[] rows10 = userSet10.getDataRows();

				StringBuffer UpdateSql10 = null;
				StringBuffer UpdateSql10_2 = null;
				StringBuffer UpdateSql10_3 = null;
				StringBuffer UpdateSql10_4 = null;
				StringBuffer UpdateSql10_5 = null;
				StringBuffer UpdateSql10_6 = null;
				StringBuffer DeleteSql10_7 = null;
				StringBuffer DeleteSql10_8 = null;
				StringBuffer InsertSql10_3 = null;
				StringBuffer InsertSql10_4 = null;
				
				UpdateSql10 = new StringBuffer();
				UpdateSql10_2 = new StringBuffer();
				UpdateSql10_3 = new StringBuffer();
				UpdateSql10_4 = new StringBuffer();
				UpdateSql10_5 = new StringBuffer();
				UpdateSql10_6 = new StringBuffer();
				DeleteSql10_7 = new StringBuffer();
				DeleteSql10_8 = new StringBuffer();
				InsertSql10_3 = new StringBuffer();
				InsertSql10_4 = new StringBuffer();
				
				//변경전 예산MST
				UpdateSql10_5.append( " UPDATE ACCOUNT.BGTMST SET  " );
				UpdateSql10_5.append( "        BRESULTS =? " );
				UpdateSql10_5.append( " WHERE BGTYY = ? ");
				UpdateSql10_5.append( "	  AND BGTDIV =? ");
				UpdateSql10_5.append( "   AND BGTDPT =? ");
				UpdateSql10_5.append( "   AND ATCODE =? ");
				UpdateSql10_5.append( "   AND FSREFCD = ?");
				UpdateSql10_5.append( "	  AND SATCODE = ?");
				//UpdateSql10_5.append( "	  AND BGTMACT = ?");

				UpdateSql10_6.append( " UPDATE ACCOUNT.BGTDTL SET  " );
				UpdateSql10_6.append( "        BRESULTS =? " );
				UpdateSql10_6.append( "  WHERE BGTYY = ? ");
				UpdateSql10_6.append( "	   AND BGTMM =? ");
				UpdateSql10_6.append( "	   AND BGTDIV =? ");
				UpdateSql10_6.append( "    AND BGTDPT =? ");
				UpdateSql10_6.append( "    AND ATCODE =? ");
				UpdateSql10_6.append( "    AND FSREFCD = ?");
				UpdateSql10_6.append( "	   AND SATCODE = ?");
				//UpdateSql10_6.append( "	   AND BGTMACT = ?");

				//변경후
				UpdateSql10.append( " UPDATE ACCOUNT.BGTMST SET  " );
				UpdateSql10.append( "        BRESULTS =? " );
				UpdateSql10.append( " WHERE BGTYY = ? ");
				UpdateSql10.append( "	  AND BGTDIV =? ");
				UpdateSql10.append( "   AND BGTDPT =? ");
				UpdateSql10.append( "   AND ATCODE =? ");
				UpdateSql10.append( "   AND FSREFCD = ?");
				UpdateSql10.append( "	  AND SATCODE = ?");
				//UpdateSql10.append( "	  AND BGTMACT = ?");

				UpdateSql10_2.append( " UPDATE ACCOUNT.BGTDTL SET  " );
				UpdateSql10_2.append( "        BRESULTS =? " );
				UpdateSql10_2.append( "  WHERE BGTYY = ? ");
				UpdateSql10_2.append( "	   AND BGTMM =? ");
				UpdateSql10_2.append( "	   AND BGTDIV =? ");
				UpdateSql10_2.append( "    AND BGTDPT =? ");
				UpdateSql10_2.append( "    AND ATCODE =? ");
				UpdateSql10_2.append( "    AND FSREFCD = ?");
				UpdateSql10_2.append( "	   AND SATCODE = ?");
				//UpdateSql10_2.append( "	   AND BGTMACT = ?");
 
				//예산총계정원장(미승인실적)
				//Delete 후 Insert 함.

				//변경전 DELETE
				DeleteSql10_7.append( " DELETE FROM  ACCOUNT.BGTGELED  " );
				DeleteSql10_7.append( "  WHERE FDCODE = ? " );
				DeleteSql10_7.append( "    AND ACTDAT = ? " );
				DeleteSql10_7.append( "    AND ATCODE = ? " );
				DeleteSql10_7.append( "    AND COCODE = ? " );
				DeleteSql10_7.append( "    AND FSDAT  = ? " );
				DeleteSql10_7.append( "    AND FSNBR  = ? " );
				DeleteSql10_7.append( "    AND FSSEQ  = ? " );
        
				//변경 후 INSERT
				InsertSql10_3.append( " INSERT INTO ACCOUNT.BGTGELED (  " );
				InsertSql10_3.append( " FDCODE,	ACTDAT,	ATCODE,	  COCODE,  FSDAT, " );
				InsertSql10_3.append( " FSNBR,	  FSSEQ,	DEAMT " );
				InsertSql10_3.append( "  ) " );
				InsertSql10_3.append( " VALUES ( ?,?,?,?,?,?,?,? ) " );

				//예산관리항목원장(미승인실적)
				//변경 전 DELETE
				DeleteSql10_8.append( " DELETE FROM  ACCOUNT.BGTGEREF  " );
				DeleteSql10_8.append( "  WHERE FDCODE = ? " );
				DeleteSql10_8.append( "    AND FSDAT = ? " );
				DeleteSql10_8.append( "    AND FSNBR = ? " );
				DeleteSql10_8.append( "    AND FSSEQ = ? " );
				DeleteSql10_8.append( "    AND FSREFCD = ? " );
				DeleteSql10_8.append( "    AND FSREFVAL = ? " );

				//변경 후 INSERT
				InsertSql10_4.append( " INSERT INTO ACCOUNT.BGTGEREF (" );
				InsertSql10_4.append( " FDCODE,  FSDAT,   FSNBR,   FSSEQ,   FSREFCD,  FSREFVAL" );
				InsertSql10_4.append( "  ) " );
				InsertSql10_4.append( " VALUES ( ?,?,?,?,?,?) " ); 

				for (int b=0;b<rows10.length;b++){

          /////////////////////////////////////////////////////////////////////////////
          // 변경전  금액을 조회
					/////////////////////////////////////////////////////////////////////////////
					dblYYBresults=0;
					dblMMBresults=0;
					dblchaamt_bgt =0;
					dblbchaamt_bgt =0;
					dblamt=0;
				
					dblbchaamt_bgt = rows10[b].getDouble(idx10BCHAAMT);  //변경전 금액
					Statement stmt10_5 = conn.createStatement();

					//세목이 없을 경우 00으로 설정
					if(rows10[b].getString(idx10BSATCODE).equals("")){
						strSatcode="00";
						rows10[b].setString(idx10BSATCODE,strSatcode);
					}

					///년별예산
					String sql10_5 = " SELECT BRESULTS FROM ACCOUNT.BGTMST "
										    + "	 WHERE BGTYY ='"+rows10[b].getString(idx10BBGTYY)+"'"
												+ "	   AND BGTDIV ='"+rows10[b].getString(idx10BBGTDIV)+"'"
												+ "	   AND BGTDPT ='"+rows10[b].getString(idx10BBGTDPT)+"'"
												+ "	   AND ATCODE ='"+rows10[b].getString(idx10BATCODE)+"'"
												+ "	   AND FSREFCD ='"+rows10[b].getString(idx10BFSREFCD)+"'"
												+ "	   AND SATCODE ='"+rows10[b].getString(idx10BSATCODE)+"'";
												//+ "	   AND BGTMACT ='"+rows10[b].getString(idx10BBGTMACT)+"'";

					ResultSet rs10_5 = stmt10_5.executeQuery(sql10_5); 

					///^^logger.dbg.println(this,"sql10_5::"+sql10_5);

					if(rs10_5.next()){
						dblYYBresults= rs10_5.getDouble(1);  //변경전 기존 금액
					}else{
					  dblYYBresults=0;
					}

					rs10_5.close();
          
					//미승인 금액 = 기존 미승인 금액 + 0 - 수정 전 금액 
					dblamt = dblYYBresults + dblchaamt_bgt - dblbchaamt_bgt;
					rows10[b].setDouble(idx10BCHAAMT,dblamt);
								
					///^^logger.dbg.println(this,"UpdateSql10_5::"+UpdateSql10_5.toString());
					GauceStatement gsmt10_5 = conn.getGauceStatement(UpdateSql10_5.toString());
					gsmt10_5.setGauceDataRow(rows10[b]);

					gsmt10_5.bindColumn(1,idx10BCHAAMT);
					gsmt10_5.bindColumn(2,idx10BBGTYY);
					gsmt10_5.bindColumn(3,idx10BBGTDIV);
					gsmt10_5.bindColumn(4,idx10BBGTDPT);
					gsmt10_5.bindColumn(5,idx10BATCODE);
					gsmt10_5.bindColumn(6,idx10BFSREFCD);
					gsmt10_5.bindColumn(7,idx10BSATCODE);
					//gsmt10_5.bindColumn(8,idx10BBGTMACT);

					gsmt10_5.executeUpdate();
					gsmt10_5.close();

					///변경전 월별예산
					dblamt=0;
					Statement stmt10_6 = conn.createStatement();
					String sql10_6 = " SELECT BRESULTS FROM ACCOUNT.BGTDTL "
										    + "	 WHERE BGTYY ='"+rows10[b].getString(idx10BBGTYY)+"'"
                        + "	   AND BGTMM ='"+rows10[b].getString(idx10BBGTMM)+"'"
												+ "	   AND BGTDIV ='"+rows10[b].getString(idx10BBGTDIV)+"'"
												+ "	   AND BGTDPT ='"+rows10[b].getString(idx10BBGTDPT)+"'"
												+ "	   AND ATCODE ='"+rows10[b].getString(idx10BATCODE)+"'"
												+ "	   AND FSREFCD ='"+rows10[b].getString(idx10BFSREFCD)+"'"
												+ "	   AND SATCODE ='"+rows10[b].getString(idx10BSATCODE)+"'";
												//+ "	   AND BGTMACT ='"+rows10[b].getString(idx10BBGTMACT)+"'";
		
					ResultSet rs10_6 = stmt10_6.executeQuery(sql10_6); 
					///^^logger.dbg.println(this,"sql10_6::"+sql10_6);
					
					if(rs10_6.next()){
						 dblMMBresults= rs10_6.getDouble(1);
					}else{
						 dblMMBresults=0;
					}

					rs10_6.close();

					//미승인 금액 = 기존 미승인  금액 + 0 - 수정 전 금액 
					dblamt = dblMMBresults + dblchaamt_bgt - dblbchaamt_bgt;
					rows10[b].setDouble(idx10BCHAAMT,dblamt);

					///^^logger.dbg.println(this,"UpdateSql10_6::"+UpdateSql10_6.toString());
					GauceStatement gsmt10_6 = conn.getGauceStatement(UpdateSql10_6.toString());
					gsmt10_6.setGauceDataRow(rows10[b]);
        	
					gsmt10_6.bindColumn(1,idx10BCHAAMT);
					gsmt10_6.bindColumn(2,idx10BBGTYY);
					gsmt10_6.bindColumn(3,idx10BBGTMM);
					gsmt10_6.bindColumn(4,idx10BBGTDIV);
					gsmt10_6.bindColumn(5,idx10BBGTDPT);
					gsmt10_6.bindColumn(6,idx10BATCODE);
					gsmt10_6.bindColumn(7,idx10BFSREFCD);
					gsmt10_6.bindColumn(8,idx10BSATCODE);
					//gsmt10_6.bindColumn(9,idx10BBGTMACT);
				
					gsmt10_6.executeUpdate();
					gsmt10_6.close();

					/////////////////////////////////////////////////////////////////////////////
					// 변경후
					/////////////////////////////////////////////////////////////////////////////
					dblYYBresults=0;
					dblMMBresults=0;
					dblchaamt_bgt =0;
					dblbchaamt_bgt =0;
					dblamt=0;
          
					dblchaamt_bgt = rows10[b].getDouble(idx10CHAAMT);
					Statement stmt10_1 = conn.createStatement();

					///변경 후 년별예산
					String sql10_1 = " SELECT BRESULTS FROM ACCOUNT.BGTMST "
										    + "	 WHERE BGTYY ='"+rows10[b].getString(idx10BGTYY)+"'"
												+ "	   AND BGTDIV ='"+rows10[b].getString(idx10BGTDIV)+"'"
												+ "	   AND BGTDPT ='"+rows10[b].getString(idx10BGTDPT)+"'"
												+ "	   AND ATCODE ='"+rows10[b].getString(idx10ATCODE)+"'"
												+ "	   AND FSREFCD ='"+rows10[b].getString(idx10FSREFCD)+"'"
												+ "	   AND SATCODE ='"+rows10[b].getString(idx10SATCODE)+"'";
												//+ "	   AND BGTMACT ='"+rows10[b].getString(idx10BGTMACT)+"'";
       
					ResultSet rs10_1 = stmt10_1.executeQuery(sql10_1); 

					///^^logger.dbg.println(this,"sql10_1::"+sql10_1);

					if(rs10_1.next()){
						 dblYYBresults= rs10_1.getDouble(1);
					}else{
						 dblYYBresults=0;
					}

					rs10_1.close();

					//미승인 금액 = 기존 미승인 금액 + 변경후 - 0 
					dblamt = dblYYBresults + dblchaamt_bgt -dblbchaamt_bgt;
					rows10[b].setDouble(idx10CHAAMT,dblamt);
					        
					///^^logger.dbg.println(this,"UpdateSql10::"+UpdateSql10.toString());
					GauceStatement gsmt10 = conn.getGauceStatement(UpdateSql10.toString());
					gsmt10.setGauceDataRow(rows10[b]);
        					 
					gsmt10.bindColumn(1,idx10CHAAMT);
					gsmt10.bindColumn(2,idx10BGTYY);
					gsmt10.bindColumn(3,idx10BGTDIV);
					gsmt10.bindColumn(4,idx10BGTDPT);
					gsmt10.bindColumn(5,idx10ATCODE);
					gsmt10.bindColumn(6,idx10FSREFCD);
					gsmt10.bindColumn(7,idx10SATCODE);
					//gsmt10.bindColumn(8,idx10BGTMACT);
				
					gsmt10.executeUpdate();
					gsmt10.close();
          
					///변경후 월별예산
					dblamt=0;
					Statement stmt10_2 = conn.createStatement();
					String sql10_2 = " SELECT BRESULTS FROM ACCOUNT.BGTDTL "
										    + "	 WHERE BGTYY ='"+rows10[b].getString(idx10BGTYY)+"'"
										    + "	   AND BGTMM ='"+rows10[b].getString(idx10BGTMM)+"'"
												+ "	   AND BGTDIV ='"+rows10[b].getString(idx10BGTDIV)+"'"
												+ "	   AND BGTDPT ='"+rows10[b].getString(idx10BGTDPT)+"'"
												+ "	   AND ATCODE ='"+rows10[b].getString(idx10ATCODE)+"'"
												+ "	   AND FSREFCD ='"+rows10[b].getString(idx10FSREFCD)+"'"
												+ "	   AND SATCODE ='"+rows10[b].getString(idx10SATCODE)+"'";
												//+ "	   AND BGTMACT ='"+rows10[b].getString(idx10BGTMACT)+"'";
		
					ResultSet rs10_2 = stmt10_2.executeQuery(sql10_2); 
					
					if(rs10_2.next()){
						 dblMMBresults= rs10_2.getDouble(1);
					}else{
						 dblMMBresults=0;
					}

					rs10_2.close();

					//미승인 금액 = 기존 미승인  금액 + 변경 후 금액 - 0 
					dblamt = dblMMBresults + dblchaamt_bgt -dblbchaamt_bgt;
					rows10[b].setDouble(idx10CHAAMT,dblamt);

					///^^logger.dbg.println(this,"UpdateSql10_2::"+UpdateSql10_2.toString());
					GauceStatement gsmt10_2 = conn.getGauceStatement(UpdateSql10_2.toString());
					gsmt10_2.setGauceDataRow(rows10[b]);
        	
					gsmt10_2.bindColumn(1,idx10CHAAMT);
					gsmt10_2.bindColumn(2,idx10BGTYY);
					gsmt10_2.bindColumn(3,idx10BGTMM);
					gsmt10_2.bindColumn(4,idx10BGTDIV);
					gsmt10_2.bindColumn(5,idx10BGTDPT);
					gsmt10_2.bindColumn(6,idx10ATCODE);
					gsmt10_2.bindColumn(7,idx10FSREFCD);
					gsmt10_2.bindColumn(8,idx10SATCODE);
					//gsmt10_2.bindColumn(9,idx10BGTMACT);

					gsmt10_2.executeUpdate();
					gsmt10_2.close();

					///////////////////////////////////////////////////////////////////////////
					///예산 총계정원장 Delete ( 변경 전)
					///////////////////////////////////////////////////////////////////////////
					///^^logger.dbg.println(this,"DeleteSql10_7::"+DeleteSql10_7.toString());
					GauceStatement gsmt10_7 = conn.getGauceStatement(DeleteSql10_7.toString());
					gsmt10_7.setGauceDataRow(rows10[b]);
           
					///^^logger.dbg.println(this,"idx10FDCODE::"+rows10[b].getString(idx10FDCODE));
					///^^logger.dbg.println(this,"idx10BACTDAT::"+rows10[b].getString(idx10BACTDAT));
					///^^logger.dbg.println(this,"idx10BATCODE::"+rows10[b].getString(idx10BATCODE));
					///^^logger.dbg.println(this,"idx10COCODE::"+rows10[b].getString(idx10COCODE));
					///^^logger.dbg.println(this,"idx10FSDAT::"+rows10[b].getString(idx10FSDAT));
					///^^logger.dbg.println(this,"idx10FSNBR::"+rows10[b].getString(idx10FSNBR));
					///^^logger.dbg.println(this,"idx10FSSEQ::"+rows10[b].getString(idx10FSSEQ));
					
					gsmt10_7.bindColumn(1,idx10FDCODE);
					gsmt10_7.bindColumn(2,idx10BACTDAT);
					gsmt10_7.bindColumn(3,idx10BATCODE);
					gsmt10_7.bindColumn(4,idx10COCODE);
					gsmt10_7.bindColumn(5,idx10FSDAT);
					gsmt10_7.bindColumn(6,idx10FSNBR);
					gsmt10_7.bindColumn(7,idx10FSSEQ);

					gsmt10_7.executeUpdate();
					gsmt10_7.close();

					///////////////////////////////////////////////////////////////////////////
					///예산 총계정원장 Insert ( 변경 후)
					///////////////////////////////////////////////////////////////////////////
					///^^logger.dbg.println(this,"InsertSql10_3::"+InsertSql10_3.toString());

					rows10[b].setDouble(idx10CHAAMT,dblchaamt_bgt);
					if(!rows10[b].getString(idx10ATCODE).equals("")){
						GauceStatement gsmt10_3 = conn.getGauceStatement(InsertSql10_3.toString());
						gsmt10_3.setGauceDataRow(rows10[b]);
						gsmt10_3.bindColumn(1,idx10FDCODE);
						gsmt10_3.bindColumn(2,idx10ACTDAT);
						gsmt10_3.bindColumn(3,idx10ATCODE);
						gsmt10_3.bindColumn(4,idx10COCODE);
						gsmt10_3.bindColumn(5,idx10FSDAT);
						gsmt10_3.bindColumn(6,idx10FSNBR);
						gsmt10_3.bindColumn(7,idx10FSSEQ);
						gsmt10_3.bindColumn(8,idx10CHAAMT);

						gsmt10_3.executeUpdate();
						gsmt10_3.close();
					}


					///////////////////////////////////////////////////////
					//변경 전 예산 관리항목원장 Delete 
					///////////////////////////////////////////////////////
					
					for (int i=0;i<=8;i++){
						if(!rows10[b].getString(idx104BFSREFVAL[i]).equals("")){
							///^^logger.dbg.println(this,"DeleteSq10_8::"+DeleteSql10_8.toString());
							GauceStatement gsmt10_8 = conn.getGauceStatement(DeleteSql10_8.toString());
							gsmt10_8.setGauceDataRow(rows10[b]);
							gsmt10_8.bindColumn(1,idx10FDCODE);
							gsmt10_8.bindColumn(2,idx10FSDAT);
							gsmt10_8.bindColumn(3,idx10FSNBR);
							gsmt10_8.bindColumn(4,idx10FSSEQ);
							gsmt10_8.bindColumn(5,idx104BFSREFCD[i]);
							gsmt10_8.bindColumn(6,idx104BFSREFVAL[i]);
							gsmt10_8.executeUpdate();
							gsmt10_8.close();
						}//if
					}//for i


					///////////////////////////////////////////////////////
					//변경 후 예산 관리항목원장 Insert 
					///////////////////////////////////////////////////////
					for (int i=0;i<=8;i++){
						///^^logger.dbg.println(this,"i::"+i);
						if(!rows10[b].getString(idx104FSREFVAL[i]).equals("")){
						/*logger.dbg.println(this,"InsertSql10_4::"+InsertSql10_4.toString());
							logger.dbg.println(this,"idx10FDCODE::"+rows10[b].getString(idx10FDCODE));
							logger.dbg.println(this,"idx10FSDAT::"+rows10[b].getString(idx10FSDAT));
							logger.dbg.println(this,"idx10FSNBR::"+rows10[b].getString(idx10FSNBR));
							logger.dbg.println(this,"idx10FSSEQ::"+rows10[b].getString(idx10FSSEQ));
							logger.dbg.println(this,"idx104FSREFCD::"+rows10[b].getString(idx104FSREFCD[i]));
							logger.dbg.println(this,"idx104FSREFVAL::"+rows10[b].getString(idx104FSREFVAL[i]));
             */
							GauceStatement gsmt10_4 = conn.getGauceStatement(InsertSql10_4.toString());
							gsmt10_4.setGauceDataRow(rows10[b]);
							gsmt10_4.bindColumn(1,idx10FDCODE);
							gsmt10_4.bindColumn(2,idx10FSDAT);
							gsmt10_4.bindColumn(3,idx10FSNBR);
							gsmt10_4.bindColumn(4,idx10FSSEQ);
							gsmt10_4.bindColumn(5,idx104FSREFCD[i]);
							gsmt10_4.bindColumn(6,idx104FSREFVAL[i]);
							gsmt10_4.executeUpdate();
							gsmt10_4.close();
						}//if
					}//for i
				}//for b
		 }//if userSet10
			/************************************************************************************
			 @ 예산 - 입력 end
			*************************************************************************************/

		  /************************************************************************************
			@ 예산 - 계정과목 삭제 start
			*************************************************************************************/
	 	 ///^^logger.dbg.println(this,"예산계정과목삭제");
		 GauceDataSet userSet11 = reqGauce.getGauceDataSet("USER11");
		 //logger.dbg.println(this,"USER11");
		 if (userSet11 != null) {
			  String strBgtyy="";
				dblYYBresults=0;
				dblMMBresults=0;
				dblchaamt_bgt=0;
				dblamt=0;

				int idx11BGTYY           = userSet11.indexOfColumn("BGTYY");  
				int idx11BGTMM           = userSet11.indexOfColumn("BGTMM");  
				int idx11BGTDIV          = userSet11.indexOfColumn("BGTDIV");  
				int idx11BGTDPT          = userSet11.indexOfColumn("BGTDPT");  
				int idx11ATCODE          = userSet11.indexOfColumn("ATCODE");  
				int idx11FSREFCD         = userSet11.indexOfColumn("FSREFCD");  
				int idx11SATCODE         = userSet11.indexOfColumn("SATCODE");  
				int idx11BGTMACT         = userSet11.indexOfColumn("BGTMACT");  
				int idx11CHAAMT          = userSet11.indexOfColumn("CHAAMT");  
			
				//예산총계정원장
				int idx11FDCODE          = userSet11.indexOfColumn("FDCODE");  
				int idx11ACTDAT          = userSet11.indexOfColumn("ACTDAT");  
			  //int idx11ATCODE          = userSet10.indexOfColumn("ATCODE");  
				int idx11COCODE          = userSet11.indexOfColumn("COCODE");  
				int idx11FSDAT           = userSet11.indexOfColumn("FSDAT");  
				int idx11FSNBR           = userSet11.indexOfColumn("FSNBR");  
				int idx11FSSEQ           = userSet11.indexOfColumn("FSSEQ");  

			  ///^^logger.dbg.println(this,"삭제-STEP1"); 

				//변경전 예산관리항목원장
				String [] str114FSREFCD = new String []{"FSREFCD01","FSREFCD02","FSREFCD03","FSREFCD04","FSREFCD05",  
				                                       "FSREFCD06","FSREFCD07","FSREFCD08","FSREFCD09"}; 

				String [] str114FSREFVAL = new String []{"FSREFVAL01","FSREFVAL02","FSREFVAL03","FSREFVAL04","FSREFVAL05",  
				                                        "FSREFVAL06","FSREFVAL07","FSREFVAL08","FSREFVAL09"}; 

				int [] idx114FSREFCD = new int[9];
				for (int i=0;i<str114FSREFCD.length;i++){
					idx114FSREFCD[i] = userSet11.indexOfColumn(str114FSREFCD[i]);
				}

				int [] idx114FSREFVAL = new int[9];
				for (int i=0;i<str114FSREFVAL.length;i++){
					idx114FSREFVAL[i] = userSet11.indexOfColumn(str114FSREFVAL[i]);
				}
				
				GauceDataRow[] rows11 = userSet11.getDataRows();

				StringBuffer UpdateSql11 = null;
				StringBuffer UpdateSql11_2 = null;
				StringBuffer DeleteSql11_3 = null;
				StringBuffer DeleteSql11_4 = null;

				UpdateSql11 = new StringBuffer();
				UpdateSql11_2 = new StringBuffer();
				DeleteSql11_3 = new StringBuffer();
				DeleteSql11_4 = new StringBuffer();

				//예산mst
				UpdateSql11.append( " UPDATE ACCOUNT.BGTMST SET  " );
				UpdateSql11.append( "        BRESULTS =? " );
				UpdateSql11.append( " WHERE BGTYY = ? ");
				UpdateSql11.append( "	  AND BGTDIV =? ");
				UpdateSql11.append( "   AND BGTDPT =? ");
				UpdateSql11.append( "   AND ATCODE =? ");
				UpdateSql11.append( "   AND FSREFCD = ?");
				UpdateSql11.append( "	  AND SATCODE = ?");
				//UpdateSql11.append( "	  AND BGTMACT = ?");
        
				//예산dtl
				UpdateSql11_2.append( " UPDATE ACCOUNT.BGTDTL SET  " );
				UpdateSql11_2.append( "        BRESULTS =? " );
				UpdateSql11_2.append( "  WHERE BGTYY = ? ");
				UpdateSql11_2.append( "	   AND BGTMM =? ");
				UpdateSql11_2.append( "	   AND BGTDIV =? ");
				UpdateSql11_2.append( "    AND BGTDPT =? ");
				UpdateSql11_2.append( "    AND ATCODE =? ");
				UpdateSql11_2.append( "    AND FSREFCD = ?");
				UpdateSql11_2.append( "	   AND SATCODE = ?");
				//UpdateSql11_2.append( "	   AND BGTMACT = ?");

				//예산총계정원장(미승인실적)
				//변경전 DELETE
				DeleteSql11_3.append( " DELETE FROM  ACCOUNT.BGTGELED  " );
				DeleteSql11_3.append( "  WHERE FDCODE = ? " );
				DeleteSql11_3.append( "    AND ACTDAT = ? " );
				DeleteSql11_3.append( "    AND ATCODE = ? " );
				DeleteSql11_3.append( "    AND COCODE = ? " );
				DeleteSql11_3.append( "    AND FSDAT  = ? " );
				DeleteSql11_3.append( "    AND FSNBR  = ? " );
				DeleteSql11_3.append( "    AND FSSEQ  = ? " );
        
				//예산관리항목원장(미승인실적)
				//변경 전 DELETE
				DeleteSql11_4.append( " DELETE FROM  ACCOUNT.BGTGEREF  " );
				DeleteSql11_4.append( "  WHERE FDCODE = ? " );
				DeleteSql11_4.append( "    AND FSDAT = ? " );
				DeleteSql11_4.append( "    AND FSNBR = ? " );
				DeleteSql11_4.append( "    AND FSSEQ = ? " );
				DeleteSql11_4.append( "    AND FSREFCD = ? " );
				DeleteSql11_4.append( "    AND FSREFVAL = ? " );

				///^^logger.dbg.println(this,"삭제-STEP2"); 

				for (int b=0;b<rows11.length;b++){

					dblYYBresults=0;
					dblMMBresults=0;
					dblchaamt_bgt=0;
					dblamt=0;
					dblchaamt_bgt=rows11[b].getDouble(idx11CHAAMT);


					//세목이 없을 경우 00으로 설정
					if(rows11[b].getString(idx11SATCODE).equals("")){
						strSatcode="00";
						rows11[b].setString(idx11SATCODE,strSatcode);
					}


					Statement stmt11_1 = conn.createStatement();
					///년별예산
					String sql11_1 = " SELECT BRESULTS FROM ACCOUNT.BGTMST "
										    + "	  WHERE BGTYY ='"+rows11[b].getString(idx11BGTYY)+"'"
												+ "	    AND BGTDIV ='"+rows11[b].getString(idx11BGTDIV)+"'"
												+ "	    AND BGTDPT ='"+rows11[b].getString(idx11BGTDPT)+"'"
												+ "	    AND ATCODE ='"+rows11[b].getString(idx11ATCODE)+"'"
												+ "	    AND FSREFCD ='"+rows11[b].getString(idx11FSREFCD)+"'"
												+ "	    AND SATCODE ='"+rows11[b].getString(idx11SATCODE)+"'";
												//+ "	    AND BGTMACT ='"+rows11[b].getString(idx11BGTMACT)+"'";
       
					///^^logger.dbg.println(this,"sql11_1::"+sql11_1);
					ResultSet rs11_1 = stmt11_1.executeQuery(sql11_1); 

					if(rs11_1.next()){
						 dblYYBresults= rs11_1.getDouble(1);
					}else{
						 dblYYBresults=0;
					}
					rs11_1.close();


					//미승인 금액 = 기존 미승인 금액 - 삭제 금액 
					dblamt = dblYYBresults - dblchaamt_bgt;
					rows11[b].setDouble(idx11CHAAMT,dblamt);
					        
					GauceStatement gsmt11 = conn.getGauceStatement(UpdateSql11.toString());
					gsmt11.setGauceDataRow(rows11[b]);
        	
					gsmt11.bindColumn(1,idx11CHAAMT);
					gsmt11.bindColumn(2,idx11BGTYY);
					gsmt11.bindColumn(3,idx11BGTDIV);
					gsmt11.bindColumn(4,idx11BGTDPT);
					gsmt11.bindColumn(5,idx11ATCODE);
					gsmt11.bindColumn(6,idx11FSREFCD);
					gsmt11.bindColumn(7,idx11SATCODE);
					//gsmt11.bindColumn(8,idx11BGTMACT);
				
					gsmt11.executeUpdate();
					gsmt11.close();

					///^^logger.dbg.println(this,"삭제-STEP22"); 
          
					///월별예산
					dblamt=0;
					Statement stmt11_2 = conn.createStatement();
					String sql11_2 = " SELECT BRESULTS FROM ACCOUNT.BGTDTL "
										    + "	  WHERE BGTYY ='"+rows11[b].getString(idx11BGTYY)+"'"
                        + "	    AND BGTMM ='"+rows11[b].getString(idx11BGTMM)+"'"
												+ "	    AND BGTDIV ='"+rows11[b].getString(idx11BGTDIV)+"'"
												+ "	    AND BGTDPT ='"+rows11[b].getString(idx11BGTDPT)+"'"
												+ "	    AND ATCODE ='"+rows11[b].getString(idx11ATCODE)+"'"
												+ "	    AND FSREFCD ='"+rows11[b].getString(idx11FSREFCD)+"'"
												+ "	    AND SATCODE ='"+rows11[b].getString(idx11SATCODE)+"'";
												//+ "	    AND BGTMACT ='"+rows11[b].getString(idx11BGTMACT)+"'";
		
					ResultSet rs11_2 = stmt11_2.executeQuery(sql11_2); 
					
					if(rs11_2.next()){
						 dblMMBresults= rs11_2.getDouble(1);
					}else{
						 dblMMBresults=0;
					}

					rs11_2.close();

					//미승인 금액 = 기존 미승인 금액 + 삭제 금액
					dblamt = dblMMBresults - dblchaamt_bgt;
					rows11[b].setDouble(idx11CHAAMT,dblamt);
					  ///^^logger.dbg.println(this,"삭제-STEP222"); 
					GauceStatement gsmt11_2 = conn.getGauceStatement(UpdateSql11_2.toString());
					gsmt11_2.setGauceDataRow(rows11[b]);
        	
					gsmt11_2.bindColumn(1,idx11CHAAMT);
					gsmt11_2.bindColumn(2,idx11BGTYY);
					gsmt11_2.bindColumn(3,idx11BGTMM);
					gsmt11_2.bindColumn(4,idx11BGTDIV);
					gsmt11_2.bindColumn(5,idx11BGTDPT);
					gsmt11_2.bindColumn(6,idx11ATCODE);
					gsmt11_2.bindColumn(7,idx11FSREFCD);
					gsmt11_2.bindColumn(8,idx11SATCODE);
					//gsmt11_2.bindColumn(9,idx11BGTMACT);
				
					gsmt11_2.executeUpdate();
					gsmt11_2.close();
           
					///^^logger.dbg.println(this,"DeleteSql11_3::"+DeleteSql11_3.toString());
					GauceStatement gsmt11_3 = conn.getGauceStatement(DeleteSql11_3.toString());
					gsmt11_3.setGauceDataRow(rows11[b]);
					gsmt11_3.bindColumn(1,idx11FDCODE);
					gsmt11_3.bindColumn(2,idx11ACTDAT);
					gsmt11_3.bindColumn(3,idx11ATCODE);
					gsmt11_3.bindColumn(4,idx11COCODE);
					gsmt11_3.bindColumn(5,idx11FSDAT);
					gsmt11_3.bindColumn(6,idx11FSNBR);
					gsmt11_3.bindColumn(7,idx11FSSEQ);

					gsmt11_3.executeUpdate();
					gsmt11_3.close();

					for (int i=0;i<=8;i++){
						if(!rows11[b].getString(idx114FSREFVAL[i]).equals("")){
							///^^logger.dbg.println(this,"DeleteSql11_4::"+DeleteSql11_4.toString());
							GauceStatement gsmt11_4 = conn.getGauceStatement(DeleteSql11_4.toString());
							gsmt11_4.setGauceDataRow(rows11[b]);
							gsmt11_4.bindColumn(1,idx11FDCODE);
							gsmt11_4.bindColumn(2,idx11FSDAT);
							gsmt11_4.bindColumn(3,idx11FSNBR);
							gsmt11_4.bindColumn(4,idx11FSSEQ);
							gsmt11_4.bindColumn(5,idx114FSREFCD[i]);
							gsmt11_4.bindColumn(6,idx114FSREFVAL[i]);
							gsmt11_4.executeUpdate();
							gsmt11_4.close();
						}//if
					}//for i

				}//for b
		 }
				
			/************************************************************************************
			 @ 예산 - 계정과목 삭제 end
			*************************************************************************************/
      
		  /************************************************************************************
			 @ 순번 수정
			*************************************************************************************/
		 GauceDataSet userSet13 = reqGauce.getGauceDataSet("USER13");
		 //logger.dbg.println(this,"USER13");
		 ///^^logger.dbg.println(this,"순번");
		 if (userSet13 != null) {
				int idx13FDCODE         = userSet13.indexOfColumn("FDCODE");  
				int idx13FSDAT          = userSet13.indexOfColumn("FSDAT");  
				int idx13FSNBR          = userSet13.indexOfColumn("FSNBR");  
				int idx13FSSEQ          = userSet13.indexOfColumn("FSSEQ");  
				int idx13FSNUM          = userSet13.indexOfColumn("FSNUM");  

					GauceDataRow[] rows13 = userSet13.getDataRows();
					StringBuffer UpdateSql13 = null;
					UpdateSql13 = new StringBuffer();

					UpdateSql13.append( " UPDATE ACCOUNT.FSLIPDTL SET " );
					UpdateSql13.append( "        FSNUM =?" );
					UpdateSql13.append( "  WHERE FDCODE=?" );
					UpdateSql13.append( "    AND FSDAT=?" );
					UpdateSql13.append( "    AND FSNBR=?" );
					UpdateSql13.append( "    AND FSSEQ=?" );

					for (int c=0;c<rows13.length;c++){
      
					///^^logger.dbg.println(this,"UpdateSql13.toString()"+ UpdateSql13.toString());
					GauceStatement gsmt13 = conn.getGauceStatement(UpdateSql13.toString());
					
					gsmt13.setGauceDataRow(rows13[c]);
          
					gsmt13.bindColumn(1,idx13FSNUM); 
					gsmt13.bindColumn(2,idx13FDCODE);
					gsmt13.bindColumn(3,idx13FSDAT);
					gsmt13.bindColumn(4,idx13FSNBR);
					gsmt13.bindColumn(5,idx13FSSEQ); 
					
					gsmt13.executeUpdate();
					gsmt13.close();

				}	//for
		 } //if
				
			/************************************************************************************
			 @ 순번 수정 End 
			*******************************************************************************
			

			/************************************************************************************
			 @ return값
			*************************************************************************************/
			
			GauceDataSet userSet5 = reqGauce.getGauceDataSet("USER5");
			
				if (userSet5 != null) {
		
					resGauce.enableFirstRow(userSet5);
					userSet5.addDataColumn(new GauceDataColumn("FDCODE", GauceDataColumn.TB_STRING,2));
					userSet5.addDataColumn(new GauceDataColumn("FSDAT", GauceDataColumn.TB_STRING,9));
					userSet5.addDataColumn(new GauceDataColumn("FSNBR", GauceDataColumn.TB_STRING,6));
         
					///^^logger.dbg.println(this,"step555222"+strFdcode+strFsdat+strFsnbr+"BBBB"); 
					GauceDataRow row = null;
					row = userSet5.newDataRow();
					row.addColumnValue(strFdcode);
					row.addColumnValue(strFsdat);
					row.addColumnValue(strFsnbr);
					userSet5.addDataRow(row);
					userSet5.flush();
				}
       
				///^^logger.dbg.println(this,"step555222");

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
			logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}