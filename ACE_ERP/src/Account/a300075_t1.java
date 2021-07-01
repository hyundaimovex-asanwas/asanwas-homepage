package Account;

import com.gauce.*;
//import com.gauce.http.HttpGauceResponse;

import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;


import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;


import com.gauce.io.GauceOutputStream;
import com.ixync.DefineContext;
import java.io.IOException;
import javax.servlet.http.HttpServletResponse;




//	

public class a300075_t1 extends HttpServlet{
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
		
		
		//HttpGauceResponse response = null;
				
		
		try{
			loader = new ServiceLoader(req, res);
	 		service = loader.newService();
	 		context = service.getContext();
	 		logger = context.getLogger();
	 		GauceRequest reqGauce = null;
	 		GauceResponse resGauce = null;
	 		
	 		
	 		//GauceOutputStream gos = ((HttpGauceResponse) response).getGauceOutputStream();
	 		
			String strErrorNo ="";
			String strFsnbr="";
			String strFdcode="";
			String strFsdat = "";
			String strFsseq="";
			String strAstnbr="";

			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				
				String struserid = reqGauce.getParameter("v_str1");        //userid
				String strloginfdcode = reqGauce.getParameter("v_str2");   //로그인 ID에 따른 지점 

                /*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                @ 전표등록 
              	>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
            	
                /************************************************************************************
                 @ Master
				*************************************************************************************/
                 
				GauceDataSet userSet3 = reqGauce.getGauceDataSet("USER3");

				int idxFDCODE       = userSet3.indexOfColumn("FDCODE");
				int idxFSDAT        = userSet3.indexOfColumn("FSDAT");
				int idxFSNBR        = userSet3.indexOfColumn("FSNBR");   
				int idxFSKND        = userSet3.indexOfColumn("FSKND");   
				int idxFSWRTDAT     = userSet3.indexOfColumn("FSWRTDAT");
				int idxCOCODE       = userSet3.indexOfColumn("COCODE");  
				int idxDEPTCD       = userSet3.indexOfColumn("DEPTCD");  
				int idxEMPNO        = userSet3.indexOfColumn("EMPNO");   
				int idxDIVCD        = userSet3.indexOfColumn("DIVCD");  
				int idxFSAMT        = userSet3.indexOfColumn("FSAMT"); 
				int idxFSVAT        = userSet3.indexOfColumn("FSVAT");
				int idxDETOT        = userSet3.indexOfColumn("DETOT");
				int idxCRTOT        = userSet3.indexOfColumn("CRTOT");
				int idxREMARK       = userSet3.indexOfColumn("REMARK"); 
				int idxSGNDAT       = userSet3.indexOfColumn("SGNDAT"); 
				int idxFSSTAT       = userSet3.indexOfColumn("FSSTAT"); 
				int idxACTDAT       = userSet3.indexOfColumn("ACTDAT");  
				int idxWRDT         = userSet3.indexOfColumn("WRDT");     
				int idxWRID         = userSet3.indexOfColumn("WRID");     
				int idxUPDT         = userSet3.indexOfColumn("UPDT");
				int idxUPID         = userSet3.indexOfColumn("UPID");  
				
				GauceDataRow[] rows3 = userSet3.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				
				StringBuffer UpdateSql0 = null;
				
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.FSLIPMST (  " );
       			InsertSql.append( " FDCODE,	FSDAT,	FSNBR,	FSKND,	FSWRTDAT,  " );
				InsertSql.append( " COCODE,	DEPTCD,	EMPNO,	DIVCD,  FSAMT,  " );
        		InsertSql.append( " FSVAT,  DETOT,  CRTOT,  REMARK, SGNDAT,	" );
				InsertSql.append( " FSSTAT,	ACTDAT, WRDT,	  WRID " );
				InsertSql.append( "  ) " );
				InsertSql.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,? ) " );
				
		    /************************************************************************************
               @ Master End
			*************************************************************************************/

		    /************************************************************************************
               @ Detail & Ref( 전표 계정 및 관리항목) 
			*************************************************************************************/
			   
		   		GauceDataSet userSet4 = reqGauce.getGauceDataSet("USER4");
		   				   		
				int idx2FDCODE       = userSet4.indexOfColumn("FDCODE");
				int idx2FSDAT        = userSet4.indexOfColumn("FSDAT");
				int idx2FSNBR        = userSet4.indexOfColumn("FSNBR");
				int idx2FSSEQ        = userSet4.indexOfColumn("FSSEQ");
				int idx2ATCODE       = userSet4.indexOfColumn("ATCODE");
				int idx2ATKORNAM     = userSet4.indexOfColumn("ATKORNAM");
				int idx2ATDECR       = userSet4.indexOfColumn("ATDECR");
				int idx2REMARK       = userSet4.indexOfColumn("REMARK");
				int idx2DEAMT        = userSet4.indexOfColumn("DEAMT");
				int idx2CRAMT        = userSet4.indexOfColumn("CRAMT");
				
				String [] strFSREFSEQ = new String []{"FSREFSEQ01","FSREFSEQ02","FSREFSEQ03","FSREFSEQ04","FSREFSEQ05",  
				                                      "FSREFSEQ06","FSREFSEQ07","FSREFSEQ08","FSREFSEQ09"}; 

				String [] strFSREFCD = new String []{"FSREFCD01","FSREFCD02","FSREFCD03","FSREFCD04","FSREFCD05",  
				                                     "FSREFCD06","FSREFCD07","FSREFCD08","FSREFCD09"}; 

				String [] strFSREFVAL = new String []{"FSREFVAL01","FSREFVAL02","FSREFVAL03","FSREFVAL04","FSREFVAL05",  
				                                      "FSREFVAL06","FSREFVAL07","FSREFVAL08","FSREFVAL09"}; 

				int [] idxFSREFSEQ = new int[9];
				for (int i=0;i<strFSREFSEQ.length;i++){
					idxFSREFSEQ[i] = userSet4.indexOfColumn(strFSREFSEQ[i]);
				}

       		    int [] idxFSREFCD = new int[9];
				for (int i=0;i<strFSREFCD.length;i++){
					idxFSREFCD[i] = userSet4.indexOfColumn(strFSREFCD[i]);
				}

				int [] idxFSREFVAL = new int[9];
				for (int i=0;i<strFSREFVAL.length;i++){
					idxFSREFVAL[i] = userSet4.indexOfColumn(strFSREFVAL[i]);
				}
 
        	    int idx2CNT            = userSet4.indexOfColumn("CNT");
				int idx2DOCUMCD        = userSet4.indexOfColumn("DOCUMCD");
				int idx2DOCUMNM        = userSet4.indexOfColumn("DOCUMNM");
                int idx2FSWRKDIV       = userSet4.indexOfColumn("FSWRKDIV");
				int idx2BANJAEYN       = userSet4.indexOfColumn("BANJAEYN");
				
				int idx2WRDT           = userSet4.indexOfColumn("WRDT");
				int idx2WRID           = userSet4.indexOfColumn("WRID");
				int idx2UPDT           = userSet4.indexOfColumn("UPDT");
				int idx2UPID           = userSet4.indexOfColumn("UPID");
				int idx2DOCUVAL        = userSet4.indexOfColumn("DOCUVAL");
				int idx2FSNUM          = userSet4.indexOfColumn("FSNUM");
				int idx2DIVCD          = userSet4.indexOfColumn("DIVCD");
				int idx2BGTDIV         = userSet4.indexOfColumn("BGTDIV");
				
				//System.out.println("a300065_t1 1");

				GauceDataRow[]rows4 = userSet4.getDataRows();
				
				//System.out.println("a300065_t1 2");
				
				StringBuffer InsertSql4 = null;
                InsertSql4 = new StringBuffer();

				InsertSql4.append( " INSERT INTO ACCOUNT.FSLIPDTL (  " );
                InsertSql4.append( " FDCODE,	 FSDAT,	FSNBR,	FSSEQ,	  ATCODE,   " );
				InsertSql4.append( " ATDECR,   FSAMT,   REMARK, DOCUMCD, FSWRKDIV, BANJAEYN,  WRDT,   WRID," );
				InsertSql4.append( " DOCUVAL, FSNUM,  DIVCD,     BGTDIV  " );
				InsertSql4.append( "  ) " );
				InsertSql4.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,? ) " );
			
         /************************************************************************************
         @ Detail End
		  *************************************************************************************/
         
		 //logger.dbg.println(this,"rows3.length::"+rows3.length);
        //===================================================================================
        		for (int j = 0; j < rows3.length; j++){

					strFdcode = rows3[j].getString(idxFDCODE);
					strFsdat = rows3[j].getString(idxFSDAT);
					strFsnbr = rows3[j].getString(idxFSNBR);
					String strWrdt = rows3[j].getString(idxWRDT);
					String strWrid = rows3[j].getString(idxWRID);
					double dblcnt=0;
					
			        //전표Master 입력/수정 구분=====================================================>>>>
			        Statement stmt0 = conn.createStatement();
			        StringBuffer sql0 = new StringBuffer();
					sql0.append( " SELECT COUNT(FDCODE) FROM ACCOUNT.FSLIPMST ");
				    sql0.append( "	WHERE FDCODE ='"+strFdcode+"'");
					sql0.append( "	  AND FSDAT='"+strFsdat+"'");
					sql0.append( "	  AND FSNBR='"+strFsnbr+"'"); 

					ResultSet rs0 = stmt0.executeQuery(sql0.toString()); 

					if(rs0.next()){
						 dblcnt= rs0.getDouble(1);
					}
					rs0.close();
					stmt0.close();
			
					if(dblcnt>0){   //수정

					}else{ //신규입력
            
						 ///외부에서 전표번호를 생성하기 때문에 막음.20060125.
						//------------------------------------------------------------------
           				// @ 전표번호 채번 START
				       // -------------------------------------------------------------------
						if(strloginfdcode.equals(strFdcode)){
							Statement stmt = conn.createStatement();
							StringBuffer sql = new StringBuffer();
							//sql.append( "  SELECT RIGHT(CHAR(DIGITS(COALESCE(MAX(FSNBR),0)+1)),6) ");
							sql.append( " SELECT LPAD(TO_NUMBER(NVL(MAX(FSNBR),0))+1,6,0)  \n");
							sql.append( "	FROM ACCOUNT.FSLIPMST \n"); 
							sql.append( "  WHERE FDCODE ='"+strFdcode+"'\n"); 
							sql.append( "	 AND FSDAT='"+strFsdat+"'\n");
							//sql.append( "	 AND ((FSNBR<'500000' AND FSNBR>'200000') OR(FSNBR<'100000'))       \n"); 
							sql.append( "	 AND FSNBR<'100000'"); 
							
							ResultSet rs = stmt.executeQuery(sql.toString()); 
							
							if(rs.next()){
								 strFsnbr= rs.getString(1);
							}
							rs.close();
							stmt.close();
						}else{
              				Statement stmt = conn.createStatement();
							StringBuffer sql = new StringBuffer();
							//sql.append( " SELECT RIGHT(CHAR(DIGITS(COALESCE(MAX(FSNBR),0)+1)),6) ");
							sql.append( " SELECT LPAD(TO_NUMBER(NVL(MAX(FSNBR),0))+1,6,0)  \n");
							sql.append( "   FROM ACCOUNT.FSLIPMST "); 
							sql.append( "  WHERE FDCODE ='"+strFdcode+"'");
							sql.append( "	 AND FSDAT='"+strFsdat+"'");
							sql.append( "	 AND FSNBR>='500000'"); 
							ResultSet rs = stmt.executeQuery(sql.toString()); 
							if(rs.next()){
								 strFsnbr= rs.getString(1);
							}
							rs.close();
							stmt.close();
						}					
						
						//logger.dbg.println(this,"strFsnbr::"+strFsnbr);
						//System.out.println("strFsnbr "+strFsnbr);
						rows3[j].setString(idxFSNBR,strFsnbr);
						
						
						/**
						//매입등록에 접수번호 UPDATE ///////////////////////////////////
						UpdateSql0 = new StringBuffer();
						UpdateSql0.append( " UPDATE ACCOUNT.ATTAXMST SET " );
						UpdateSql0.append( "    FSDAT = '"+strFsdat+"', " );
						UpdateSql0.append( "    FSNBR = '"+strFsnbr+"'" );
					//	UpdateSql0.append( "  WHERE TAXNBR='"+strTaxnbr+"'" );
						GauceStatement gsmt0 = conn.getGauceStatement(UpdateSql0.toString());		
						gsmt0.executeUpdate();
						gsmt0.close();
						////////////////////////////////////////////////////////////////////
												
					**/							
				
												
						//------------------------------------------------------------------
           			    //	@ 전표번호 채번 END
				   		//------------------------------------------------------------------
						//logger.dbg.println(this,"채번 끝::");
						//================================================================================<<<<
						if(rows3[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
							strErrorNo = rows3[j].getString(idxFDCODE)+"-"+rows3[j].getString(idxFSDAT)+"-"+rows3[j].getString(idxFSNBR);
							//logger.dbg.println(this,"strErrorNo::"+strErrorNo);
							//------------------------------------------------------------------
							//전표 Master
							//------------------------------------------------------------------
							//logger.dbg.println(this,"InsertSql.toString()::"+InsertSql.toString());
							//System.out.println("a300065_t1 8"+InsertSql.toString());
							
							GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows3[j]);
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
						
						//logger.dbg.println(this,"전표MST 끝 ::");
					}
					
					//------------------------------------------------------------------
					//전표 Detail
					//------------------------------------------------------------------
					String strgubun =null;
					String strSeq = "";
					String strSeq2_2 = "";
					double dblDEAMT=0; 
					double dblCRAMT=0;
					
					String strFDCODE2="";
					String strFSDAT2="";
					String strFSNBR2="";
					int ichk2=0;
          
					//logger.dbg.println(this,"rows4.length::"+rows4.length);
					//System.out.println("rows4.length::"+rows4.length);
          
					for (int k=0;k<rows4.length; k++){
						//전표 Detail 키값 생성
						rows4[k].setString(idx2FDCODE,strFdcode);
						rows4[k].setString(idx2FSDAT,strFsdat);
						rows4[k].setString(idx2FSNBR,strFsnbr);

						strFDCODE2 = rows4[k].getString(idx2FDCODE);
						strFSDAT2  = rows4[k].getString(idx2FSDAT);
						strFSNBR2  = rows4[k].getString(idx2FSNBR);

						//추가
						strSeq = rows4[k].getString(idx2FSSEQ);
						            
						if(!strFSNBR2.equals("000000")){
							strFdcode = strFDCODE2;
							strFsdat = strFSDAT2;
							strFsnbr = strFSNBR2;
          			    }
						
						rows4[k].setString(idx2FSSEQ,strSeq);
					//	rows4[k].setString(idx2DOCUVAL,strTaxnbr); //세금계산서 번호 
					
						dblDEAMT = rows4[k].getDouble(idx2DEAMT);
						dblCRAMT = rows4[k].getDouble(idx2CRAMT);
						
						//차변 대변 구분 (실제적인 차대가 아니라 금액 있는 쪽 구분함)
						if(dblDEAMT!=0 && dblCRAMT ==0){
							strgubun="1"; 
							rows4[k].setString(idx2ATDECR,strgubun);  //차변
						}else if (dblDEAMT==0 && dblCRAMT != 0){
							strgubun="2";
							rows4[k].setString(idx2ATDECR,strgubun);  //대변
							rows4[k].setDouble(idx2DEAMT,dblCRAMT);
						}else{
							rows4[k].setDouble(idx2DEAMT,0);
							rows4[k].setDouble(idx2CRAMT,0);
						}

						rows4[k].setString(idx2WRDT,strWrdt); 
						rows4[k].setString(idx2WRID,strWrid); 
						

						if(rows4[k].getJobType() == GauceDataRow.TB_JOB_INSERT) {
							GauceStatement gsmt2 = conn.getGauceStatement(InsertSql4.toString());
							
							gsmt2.setGauceDataRow(rows4[k]);
							gsmt2.bindColumn(1, idx2FDCODE);
							gsmt2.bindColumn(2, idx2FSDAT);
							gsmt2.bindColumn(3, idx2FSNBR);
							gsmt2.bindColumn(4, idx2FSSEQ);
							gsmt2.bindColumn(5, idx2ATCODE);
							gsmt2.bindColumn(6, idx2ATDECR);
							gsmt2.bindColumn(7, idx2DEAMT);
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
							gsmt2.close();
							
						//---------------------------
						//전표 관리항목
						//---------------------------
							for (int m=0;m<strFSREFSEQ.length;m++){
								if (!rows4[k].getString(idxFSREFCD[m]).equals("")&&!rows4[k].getString(idxFSREFCD[m]).equals(null)){
									int ichk2_2 = m+1;
									strSeq2_2 = String.valueOf(ichk2_2);
									if(ichk2_2<10) strSeq2_2 = "0"+ strSeq2_2;
									StringBuffer sql2_2 = new StringBuffer();
									sql2_2.append( " INSERT INTO  ACCOUNT.FSLIPREF ( ");
									sql2_2.append( " FDCODE,	FSDAT,	  FSNBR,	FSSEQ,	 FSREFSEQ,");
									sql2_2.append( " FSREFCD, FSREFVAL, WRDT,   WRID ");
									sql2_2.append( " ) ");
									sql2_2.append( " VALUES ( ");
									sql2_2.append( " '"+strFDCODE2+"',");
									sql2_2.append( " '"+strFSDAT2+"',");
									sql2_2.append( " '"+strFSNBR2+"',");
									sql2_2.append( " '"+strSeq+"',");
									sql2_2.append( " '"+strSeq2_2+"',");
									sql2_2.append( " '"+rows4[k].getString(idxFSREFCD[m])+"',");
									sql2_2.append( " '"+rows4[k].getString(idxFSREFVAL[m])+"',");
									sql2_2.append( " '"+rows4[k].getString(idx2WRDT)+"',");
									sql2_2.append( " '"+rows4[k].getString(idx2WRID)+"'");
									sql2_2.append( " ) ");
									
									//logger.dbg.println(this,"sql2_2.toString()::"+sql2_2.toString());
									//System.out.println("sql2_2.toString()::"+sql2_2.toString());
									GauceStatement gsmt2_2 = conn.getGauceStatement(sql2_2.toString());
									gsmt2_2.executeUpdate();
									gsmt2_2.close();
								} //if 
							} //for m
							
													
							//증빙 존재할 경우 매입에 전표 접수번호 UPDATE 
							
							if(!rows4[k].getString(idx2DOCUVAL).equals("")){
								
								//매입등록에 접수번호 UPDATE ///////////////////////////////////
								UpdateSql0 = new StringBuffer();
								UpdateSql0.append( " UPDATE ACCOUNT.ATTAXMST SET " );
								UpdateSql0.append( "    FSDAT = '"+strFsdat+"', " );
								UpdateSql0.append( "    FSNBR = '"+strFsnbr+"'" );
								UpdateSql0.append( "  WHERE TAXNBR='"+rows4[k].getString(idx2DOCUVAL)+"'" );
								GauceStatement gsmt0 = conn.getGauceStatement(UpdateSql0.toString());		
								gsmt0.executeUpdate();
								gsmt0.close();
								////////////////////////////////////////////////////////////////////								
								
							}
							
					} //if_jobtype  rows2[k]
				}  //for k 
			}  //for j 

            
		/****************************************** ******************************************
			 @ BANJAEREL 연결 Start  - 입력
			*************************************************************************************/
 	
		 GauceDataSet userSet6 = reqGauce.getGauceDataSet("USER6");

		 if (userSet6 != null) {
		 
			    int idx6FTSTAT         = userSet6.indexOfColumn("FTSTAT");  
				int idx6FDCODE        = userSet6.indexOfColumn("FDCODE");  
				int idx6TSDAT           = userSet6.indexOfColumn("TSDAT");  
				int idx6TSNBR          = userSet6.indexOfColumn("TSNBR");  
				int idx6TSSEQ          = userSet6.indexOfColumn("TSSEQ");  
				
				int idx6BTSDAT         = userSet6.indexOfColumn("BTSDAT");  
				int idx6BTSNBR        = userSet6.indexOfColumn("BTSNBR");  
				int idx6BTSSEQ        = userSet6.indexOfColumn("BTSSEQ");  
				int idx6BANJAEYN     = userSet6.indexOfColumn("BANJAEYN");  

				int idx6SSDAT          = userSet6.indexOfColumn("SSDAT");  
				int idx6SSNBR          = userSet6.indexOfColumn("SSNBR");  
				int idx6FSNUM          = userSet6.indexOfColumn("FSNUM");  
				int idx6BJDEAMT       = userSet6.indexOfColumn("BJDEAMT");  
				int idx6BJCRAMT       = userSet6.indexOfColumn("BJCRAMT");  
				int idx6BSDAT           = userSet6.indexOfColumn("BSDAT");  
				int idx6BSNBR          = userSet6.indexOfColumn("BSNBR");  
				int idx6BSNUM         = userSet6.indexOfColumn("BSNUM");  
				
				int idx6WRDT          = userSet6.indexOfColumn("WRDT");  
				int idx6WRID           = userSet6.indexOfColumn("WRID");  
				int idx6UPDT           = userSet6.indexOfColumn("UPDT");  
				int idx6UPID            = userSet6.indexOfColumn("UPID");  

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
		 double dbldeamt=0;
		 double dblcramt=0;
		 double dbldeamt14=0;
		 double dblcramt14=0;
		 double dblamt14=0;
		 String strgubun14="";
		 String strStatus="";
		 String strAtdecr="";

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

				StringBuffer UpdateSql14 = null;
				StringBuffer UpdateSql14_2 = null;
				UpdateSql14 = new StringBuffer();
				UpdateSql14_2 = new StringBuffer();
        
			
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
					dblamt14 = rows14[b].getDouble(idx14AMT);         //반제원금액
					strgubun14="";
					strAtdecr="";

					Statement stmt14 = conn.createStatement();
					StringBuffer sql14 = new StringBuffer();
					sql14.append( " SELECT A.DEAMT, A.CRAMT, B.ATDECR FROM ACCOUNT.BANJAEMST A ");
					sql14.append( "   LEFT JOIN ACCOUNT.ACTCODE B ON A.ATCODE = B.ATCODE ");
					sql14.append( "	 WHERE A.FDCODE ='"+rows14[b].getString(idx14FDCODE)+"'");
					sql14.append( "	   AND A.TSDAT ='"+rows14[b].getString(idx14TSDAT)+"'");
					sql14.append( "	   AND A.TSNBR ='"+rows14[b].getString(idx14TSNBR)+"'");
					sql14.append( "	   AND A.TSSEQ ='"+rows14[b].getString(idx14TSSEQ)+"'");
					ResultSet rs14 = stmt14.executeQuery(sql14.toString()); 

					if(rs14.next()){
						 strgubun14="1";
						 dbldeamt= rs14.getDouble(1);
						 dblcramt= rs14.getDouble(2);
						 strAtdecr= rs14.getString(3);
					}
					rs14.close();
                    stmt14.close();
					
					if(strgubun14.equals("1")){       //update
						if(strAtdecr.equals("1")){      //차변계정==>대변 금액을 UPDATE함
						    dblcramt += dblcramt14;

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
								gsmt14.executeUpdate();
								gsmt14.close();

						}else if(strAtdecr.equals("2")){     //대변계정 - 차변 금액을 UPDATE함.
							 dbldeamt += dbldeamt14;
							 if(dbldeamt==dblamt14){ //완료
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
								gsmt14.executeUpdate();
								gsmt14.close();
						}
					}//!strgubun14.
				}// for
		 }
		/************************************************************************************
		 @ BANJAE MST End 
		*************************************************************************************/
		
		/************************************************************************************
		 @ ACAPPFUND에 UPDATE 처리   ( APPFSDAT, APPFSNBR ) 신청접수번호
		************************************************************************************/

		 GauceDataSet userSet7 = reqGauce.getGauceDataSet("USER7");
		
		 if (userSet7 != null) {

				int idx7APPNO           = userSet7.indexOfColumn("APPNO");
			    int idx7FDCODE          = userSet7.indexOfColumn("FDCODE");  
				int idx7FSDAT           = userSet7.indexOfColumn("FSDAT");    
				int idx7FSNBR           = userSet7.indexOfColumn("FSNBR");        
				
				GauceDataRow[] rows7 = userSet7.getDataRows();

				StringBuffer UpdateSql7 = null;
			    StringBuffer InsertSql7 = null;
				
			    UpdateSql7 = new StringBuffer();
			    InsertSql7 = new StringBuffer();

			    // 자금신청으로 변경해야 함.  
				UpdateSql7.append( " UPDATE ACCOUNT.ACAPPFUND " );
				UpdateSql7.append( "    SET FDCODE =?" );
			    UpdateSql7.append( "       ,PAYFSDAT = ?" );
			    UpdateSql7.append( "       ,PAYFSNBR = ?" );
				UpdateSql7.append( "  WHERE APPNO=?" );
				
				for (int b=0;b<rows7.length;b++){
					
					//System.out.println("UpdateSql7.toString()::"+UpdateSql7.toString());
					GauceStatement gsmt7 = conn.getGauceStatement(UpdateSql7.toString());
					
					rows7[b].setString(idx7FDCODE,strFdcode);  //지점 
					rows7[b].setString(idx7FSDAT,strFsdat);    //접수일자 
					rows7[b].setString(idx7FSNBR,strFsnbr);    //접수번호 
					
					gsmt7.setGauceDataRow(rows7[b]);
					
					gsmt7.bindColumn(1,idx7FDCODE);
					gsmt7.bindColumn(2,idx7FSDAT);
					gsmt7.bindColumn(3,idx7FSNBR);
					gsmt7.bindColumn(4,idx7APPNO);

					gsmt7.executeUpdate();
					gsmt7.close();
					gsmt7=null;
					
				}// for
		 }	
		 
		 
		 /************************************************************************************
		 @ ACAPPFUND에 UPDATE 처리   ( PAYFSDAT, PAYFSNBR ) 
		************************************************************************************/

		 GauceDataSet userSet8 = reqGauce.getGauceDataSet("USER8");
		
		 if (userSet8 != null) {

				int idx8APPNO           = userSet8.indexOfColumn("APPNO");
			    int idx8FDCODE          = userSet8.indexOfColumn("FDCODE");  
				int idx8FSDAT           = userSet8.indexOfColumn("FSDAT");    
				int idx8FSNBR           = userSet8.indexOfColumn("FSNBR");        
				
				GauceDataRow[] rows8 = userSet8.getDataRows();

				StringBuffer UpdateSql8 = null;
			    StringBuffer InsertSql8 = null;
				
			    UpdateSql8 = new StringBuffer();
			    InsertSql8 = new StringBuffer();

			    // 자금신청으로 변경해야 함.  
				UpdateSql8.append( " UPDATE ACCOUNT.ACAPPFUND " );
				UpdateSql8.append( "    SET PAYFSDAT =?" );
			    UpdateSql8.append( "       ,PAYFSNBR =?" );
				UpdateSql8.append( "  WHERE APPNO=?" );
				
				for (int b=0;b<rows8.length;b++){
					
					//System.out.println("UpdateSql7.toString()::"+UpdateSql7.toString());
					GauceStatement gsmt8 = conn.getGauceStatement(UpdateSql8.toString());
					 
					rows8[b].setString(idx8FSDAT,strFsdat);    //접수일자 
					rows8[b].setString(idx8FSNBR,strFsnbr);    //접수번호 
					
					gsmt8.setGauceDataRow(rows8[b]);
					
					gsmt8.bindColumn(1,idx8FSDAT);
					gsmt8.bindColumn(2,idx8FSNBR);
					gsmt8.bindColumn(3,idx8APPNO);

					gsmt8.executeUpdate();
					gsmt8.close();
					gsmt8=null;
					
				}// for
		 }	
			
			/************************************************************************************
					 @ return값
			************************************************************************************/
			
			GauceDataSet userSet5 = reqGauce.getGauceDataSet("USER5");
			
			if (userSet5 != null) {
				
				resGauce.enableFirstRow(userSet5);
				userSet5.addDataColumn(new GauceDataColumn("FDCODE", GauceDataColumn.TB_STRING,2));
				userSet5.addDataColumn(new GauceDataColumn("FSDAT", GauceDataColumn.TB_STRING,9));
				userSet5.addDataColumn(new GauceDataColumn("FSNBR", GauceDataColumn.TB_STRING,6));
				
				
				System.out.println("strFdcode::"+strFdcode);
				System.out.println("strFsdat::"+strFsdat);
				System.out.println("strFsnbr::"+strFsnbr);
 
				GauceDataRow row = null;
				row = userSet5.newDataRow();
				row.addColumnValue(strFdcode);
				row.addColumnValue(strFsdat);
				row.addColumnValue(strFsnbr);
				
				System.out.println("userSet5::1");
				
				userSet5.addDataRow(row);
				
				
				int idxFDCODE5       = userSet5.indexOfColumn("FDCODE");       //차변현금등가물
				int idxFSDAT5        = userSet5.indexOfColumn("FSDAT");       //차변현금등가물
				int idxFSNBR5        = userSet5.indexOfColumn("FSNBR");       //차변현금등가물
				
				System.out.println("userSet5::2");
				System.out.println("userSet5::2" + row.getString(idxFDCODE5));
				System.out.println("userSet5::2" + row.getString(idxFSDAT5));
				System.out.println("userSet5::2" + row.getString(idxFSNBR5));
				
				userSet5.flush();
				
				System.out.println("userSet5::3");
			}
				       	

			} //try
			catch(Exception e){

				conn.rollback();
				logger.err.println(this,"9999errno::"+strErrorNo); 
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