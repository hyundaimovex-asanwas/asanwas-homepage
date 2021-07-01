package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a040080_t1 extends HttpServlet{
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
			
			String strAstnbr="";

			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				
				String strGB = reqGauce.getParameter("v_str1"); //���ݰ�꼭 ���а� 
				String strloginfdcode = reqGauce.getParameter("v_str2");   //�α��� ID�� ���� ���� 

				
				/*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
				���Ե�� mst 
				>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
				GauceDataSet userSet1 = reqGauce.getGauceDataSet("USER1");
				
				String[] StrArrCN1 = new String[] {
					   "TAXNBR",      "COCODE",   "DEPTCD",   "EMPNO",      "TAXIODIV",
					   "TAXDIV",        "TAXKND",    "VEND_CD", "TAXDAT",      "TAXSUM",
					   "TAXVATAMT","TAXTOT",    "REMARK",   "TAXCDNBR", "ATCODE",
					   "TAXPRTYN",  "TAXCNT",    "LASTPRT",  "TAXTYPE",    "FSDAT",	
					   "FSNBR",        "TAXKIDIV",   "FDCODE",   "WORKTYPE", "WRDT",  
					   "WRID",          "SEQ",          "GUBUN",     "AMEND_CODE", "AMEND_REMARK" , "EXTCHK", "REMARK2",
					   "REMARK3",   "S_BIZPLACE"
				};
	
			   	int[] idx1 = new int[34];
			    for(int i=0;i<StrArrCN1.length;i++) {
				   idx1[i] = userSet1.indexOfColumn(StrArrCN1[i]);
			    }
	
				GauceDataRow[] rows1 = userSet1.getDataRows();		
					
				String strTaxnbr = "";
				String taxch="";
			   
				/*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
				���Ե�� dtl 
				>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
				GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2");

				String[] StrArrCN2 = new String[] {
					"TAXNBR",  "TAXSEQ", "TAXPDTNAM","TAXSTD","TAXQTY",
					"TAXPRIC", "TAXSUM", "TAXVATAMT"  ,"BIGO","WRDT",
					"WRID",        "UPDT",      "UPID"
				};

				int[] idx2 = new int[13];
				for(int i=0;i<StrArrCN2.length;i++) {
					idx2[i] = userSet2.indexOfColumn(StrArrCN2[i]);
				}
				
				GauceDataRow[] rows2 = userSet2.getDataRows();		
				
				
				StringBuffer InsertSql1 = null;	//Master
				StringBuffer InsertSql2 = null;	//Detail
				
                //���� Master
				Statement stmt1 = null;
				ResultSet rs1 = null;

				//���� Detali
				Statement stmt2 = null;
				ResultSet rs2 = null;

				for (int j = 0; j < rows2.length; j++){
					if(rows2[j].getJobType() == GauceDataRow.TB_JOB_INSERT) { 
						
						strTaxnbr =strGB+ rows1[0].getString(idx1[8]);
						
						strTaxnbr=strTaxnbr.substring(0,7);
						taxch ="";
						
						StringBuffer sql = new StringBuffer();
						if (j==0) {
							sql.append( " SELECT RIGHT(CHAR(DIGITS(COALESCE(MAX(SUBSTR(TAXNBR,8,11)),0)+1)),4)	");
							sql.append( " FROM ACCOUNT.ATTAXMST												                                    ");
							sql.append( " WHERE SUBSTR(TAXNBR,1,7)='"+strTaxnbr+"'                                                       ");

							stmt1 = conn.createStatement();
							rs1 = stmt1.executeQuery(sql.toString());

							while(rs1.next())	{
								taxch = rs1.getString(1);
							}
							
							strTaxnbr = strTaxnbr+taxch ; //��꼭��ȣ ������ ����. 
							
							InsertSql1 = new StringBuffer();
							InsertSql1.append( " INSERT INTO ACCOUNT.ATTAXMST (						    \n");
							InsertSql1.append( " TAXNBR,COCODE,DEPTCD,EMPNO,TAXIODIV,			\n");
							InsertSql1.append( " TAXDIV,TAXKND,VEND_CD,TAXDAT,TAXSUM,			    \n");
							InsertSql1.append( " TAXVATAMT,TAXTOT,REMARK,TAXCDNBR,ATCODE,	\n");
							InsertSql1.append( " TAXPRTYN,TAXCNT,LASTPRT,TAXTYPE,FSDAT,	    	\n");
							InsertSql1.append( " FSNBR,TAXKIDIV,FDCODE,WORKTYPE,WRDT,WRID,	\n");
							InsertSql1.append( " SEQ, GUBUN, AMEND_CODE, AMEND_REMARK, EXTCHK, REMARK2,	\n");
							InsertSql1.append( " REMARK3, S_BIZPLACE  \n");
							InsertSql1.append( " ) VALUES(						\n");
							InsertSql1.append( " '"+strTaxnbr+"', ?,?,?,?,	");
							InsertSql1.append( " ?,?,?,?,?,");
							InsertSql1.append( " ?,?,?,?,?,");
							InsertSql1.append( " ?,?,?,?,?,");
							InsertSql1.append( " ?,?,?,?,?,");
							InsertSql1.append( " ?,?,?,?,?,");
							InsertSql1.append( " ?,?,?,? ");
							InsertSql1.append( " ) ");

							GauceStatement gsmt = conn.getGauceStatement(InsertSql1.toString());
							gsmt.setGauceDataRow(rows1[0]);
							
							
							for(int m=1;m<=33;m++) {
							   gsmt.bindColumn(m, idx1[m]);
							}

							gsmt.executeUpdate();
							gsmt.close();
							
				  	    }//if(j=0)
				 	 
						 String taxseq = rows2[j].getString(idx2[1]);
						 StringBuffer sql2 = new StringBuffer();
						 sql2.append(" SELECT RIGHT(CHAR(DIGITS(COALESCE(MAX(TAXSEQ),0)+1)),3)		");
						 sql2.append("   FROM ACCOUNT.ATTAXDTL								          				");
						 sql2.append(" WHERE TAXNBR = '"+strTaxnbr+"'		                          					");
	
						 stmt2 = conn.createStatement();
						 rs2 = stmt2.executeQuery(sql2.toString());
	
						 while(rs2.next()) {
							 taxseq = rs2.getString(1);
						 }

						 InsertSql2 = new StringBuffer();
						 InsertSql2.append( " INSERT INTO ACCOUNT.ATTAXDTL (				    		");
						 InsertSql2.append( " TAXNBR,TAXSEQ,TAXPDTNAM,TAXSTD,TAXQTY,			");
						 InsertSql2.append( " TAXPRIC,TAXSUM,TAXVATAMT,BIGO,							");
						 InsertSql2.append( " WRDT,WRID															");
						 InsertSql2.append( " ) VALUES(																");
						 InsertSql2.append( " '"+strTaxnbr+"','"+taxseq+"',?,?,?,	                			");
						 InsertSql2.append( " ?, ?, ?, ?,																");
						 InsertSql2.append( " ?, ? )			                                 						");
	
						 GauceStatement gsmt2 = conn.getGauceStatement(InsertSql2.toString());
						 gsmt2.setGauceDataRow(rows2[j]);
	
						 for(int k=1;k<=9;k++) {
							gsmt2.bindColumn(k, idx2[k+1]);
						 }
						 
						 gsmt2.executeUpdate();
						 gsmt2.close();
						 InsertSql2=null;
						 taxseq = "";

						
					}//if getJobType
				}//for
	            //���Ե�� End 
					
	        
                /*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                @ ��ǥ��� 
              	>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
            	
                /************************************************************************************
                 @ Master
				*************************************************************************************/
                 
				GauceDataSet userSet3 = reqGauce.getGauceDataSet("USER3");

				int idxFDCODE       = userSet3.indexOfColumn("FDCODE");

				int idxFSDAT          = userSet3.indexOfColumn("FSDAT");
				int idxFSNBR          = userSet3.indexOfColumn("FSNBR");   
				int idxFSKND          = userSet3.indexOfColumn("FSKND");   
				int idxFSWRTDAT   = userSet3.indexOfColumn("FSWRTDAT");
				int idxCOCODE       = userSet3.indexOfColumn("COCODE");  
				int idxDEPTCD        = userSet3.indexOfColumn("DEPTCD");  
				int idxEMPNO         = userSet3.indexOfColumn("EMPNO");   
				int idxDIVCD            = userSet3.indexOfColumn("DIVCD");  
				int idxFSAMT          = userSet3.indexOfColumn("FSAMT"); 
				int idxFSVAT           = userSet3.indexOfColumn("FSVAT");
				int idxDETOT          = userSet3.indexOfColumn("DETOT");
				int idxCRTOT          = userSet3.indexOfColumn("CRTOT");
				int idxREMARK       = userSet3.indexOfColumn("REMARK"); 
				int idxSGNDAT       = userSet3.indexOfColumn("SGNDAT"); 
				int idxFSSTAT       = userSet3.indexOfColumn("FSSTAT"); 
				int idxACTDAT       = userSet3.indexOfColumn("ACTDAT");  
				int idxWRDT          = userSet3.indexOfColumn("WRDT");     
				int idxWRID           = userSet3.indexOfColumn("WRID");     
				int idxUPDT           = userSet3.indexOfColumn("UPDT");
				int idxUPID            = userSet3.indexOfColumn("UPID");  
				

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
               @ Detail & Ref( ��ǥ ���� �� �����׸�) 
			*************************************************************************************/
		   		
		   		GauceDataSet userSet4 = reqGauce.getGauceDataSet("USER4");
		   		
						   		
				int idx2FDCODE       = userSet4.indexOfColumn("FDCODE");
				int idx2FSDAT         = userSet4.indexOfColumn("FSDAT");
				int idx2FSNBR         = userSet4.indexOfColumn("FSNBR");
				int idx2FSSEQ         = userSet4.indexOfColumn("FSSEQ");
				int idx2ATCODE       = userSet4.indexOfColumn("ATCODE");
				int idx2ATKORNAM  = userSet4.indexOfColumn("ATKORNAM");
				int idx2ATDECR       = userSet4.indexOfColumn("ATDECR");
				int idx2REMARK       = userSet4.indexOfColumn("REMARK");
				int idx2CHAAMT       = userSet4.indexOfColumn("CHAAMT");
				int idx2DAEAMT       = userSet4.indexOfColumn("DAEAMT");
				
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
 
        	    int idx2CNT                  = userSet4.indexOfColumn("CNT");
				int idx2DOCUMCD       = userSet4.indexOfColumn("DOCUMCD");
				int idx2DOCUMNM       = userSet4.indexOfColumn("DOCUMNM");
                int idx2FSWRKDIV        = userSet4.indexOfColumn("FSWRKDIV");
				int idx2BANJAEYN        = userSet4.indexOfColumn("BANJAEYN");
				
				int idx2WRDT          = userSet4.indexOfColumn("WRDT");
				int idx2WRID           = userSet4.indexOfColumn("WRID");
				int idx2UPDT           = userSet4.indexOfColumn("UPDT");
				int idx2UPID            = userSet4.indexOfColumn("UPID");
				int idx2DOCUVAL    = userSet4.indexOfColumn("DOCUVAL");
				int idx2FSNUM        = userSet4.indexOfColumn("FSNUM");
				int idx2DIVCD          = userSet4.indexOfColumn("DIVCD");
				int idx2BGTDIV        = userSet4.indexOfColumn("BGTDIV");

				GauceDataRow[]rows4 = userSet4.getDataRows();

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

				//===================================================================================
        		for (int j = 0; j < rows3.length; j++){
        			
					strFdcode = rows3[j].getString(idxFDCODE);
					strFsdat = rows3[j].getString(idxFSDAT);
					strFsnbr = rows3[j].getString(idxFSNBR);
					String strWrdt = rows3[j].getString(idxWRDT);
					String strWrid = rows3[j].getString(idxWRID);
					double dblcnt=0;

			        //��ǥMaster �Է�/���� ����=====================================================>>>>
			        Statement stmt0 = conn.createStatement();
			        StringBuffer sql0 = new StringBuffer();
					sql0.append( " SELECT COUNT(FDCODE) FROM ACCOUNT.FSLIPMST ");
				    sql0.append( "	 WHERE FDCODE ='"+strFdcode+"'");
					sql0.append( "	      AND FSDAT='"+strFsdat+"'");
					sql0.append( "	      AND FSNBR='"+strFsnbr+"'"); 

					ResultSet rs0 = stmt0.executeQuery(sql0.toString()); 

					if(rs0.next()){
						 dblcnt= rs0.getDouble(1);
					}
					rs0.close();
					stmt0.close();

					if(dblcnt>0){   //����

					}else{ //�ű��Է�
            
						 ///�ܺο��� ��ǥ��ȣ�� �����ϱ� ������ ����.20060125.
						//------------------------------------------------------------------
           				// @ ��ǥ��ȣ ä�� START
				       // -------------------------------------------------------------------
						if(strloginfdcode.equals(strFdcode)){
							Statement stmt = conn.createStatement();
							StringBuffer sql = new StringBuffer();
							sql.append( "  SELECT RIGHT(CHAR(DIGITS(COALESCE(MAX(FSNBR),0)+1)),6) ");
							sql.append( "	  FROM ACCOUNT.FSLIPMST "); 
							sql.append( "	WHERE FDCODE ='"+strFdcode+"'"); 
							sql.append( "	     AND FSDAT='"+strFsdat+"'");
							sql.append( "	     AND FSNBR<'500000'"); 
							ResultSet rs = stmt.executeQuery(sql.toString()); 
							
							if(rs.next()){
								 strFsnbr= rs.getString(1);
							}
							rs.close();
							stmt.close();
							}else{
              				Statement stmt = conn.createStatement();
							StringBuffer sql = new StringBuffer();
							sql.append( " SELECT RIGHT(CHAR(DIGITS(COALESCE(MAX(FSNBR),0)+1)),6) ");
							sql.append( "	  FROM ACCOUNT.FSLIPMST "); 
							sql.append( "	WHERE FDCODE ='"+strFdcode+"'");
							sql.append( "	     AND FSDAT='"+strFsdat+"'");
							sql.append( "	     AND FSNBR>='500000'"); 
							ResultSet rs = stmt.executeQuery(sql.toString()); 
							if(rs.next()){
								 strFsnbr= rs.getString(1);
							}
							rs.close();
							stmt.close();
						}					

						rows3[j].setString(idxFSNBR,strFsnbr);

						//���Ե�Ͽ� ������ȣ UPDATE ///////////////////////////////////
						UpdateSql0 = new StringBuffer();
						UpdateSql0.append( " UPDATE ACCOUNT.ATTAXMST SET " );
						UpdateSql0.append( "    FSDAT = '"+strFsdat+"', " );
						UpdateSql0.append( "    FSNBR = '"+strFsnbr+"'" );
						UpdateSql0.append( "  WHERE TAXNBR='"+strTaxnbr+"'" );
						GauceStatement gsmt0 = conn.getGauceStatement(UpdateSql0.toString());		
						gsmt0.executeUpdate();
						gsmt0.close();
						////////////////////////////////////////////////////////////////////
					
						//------------------------------------------------------------------
           			    //	@ ��ǥ��ȣ ä�� END
				   		//------------------------------------------------------------------
						//================================================================================<<<<
						if(rows3[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
							strErrorNo = rows3[j].getString(idxFDCODE)+"-"+rows3[j].getString(idxFSDAT)+"-"+rows3[j].getString(idxFSNBR);
							logger.dbg.println(this,"strErrorNo::"+strErrorNo);
							//------------------------------------------------------------------
							//��ǥ Master
							//------------------------------------------------------------------
							
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
					}
					
					//------------------------------------------------------------------
					//��ǥ Detail
					//------------------------------------------------------------------
					String strgubun =null;
					String strSeq = "";
					String strSeq2_2 = "";
					double dblchaamt=0; 
					double dbldaeamt=0;
					
					String strFDCODE2="";
					String strFSDAT2="";
					String strFSNBR2="";
					int ichk2=0;
          
					for (int k=0;k<rows4.length; k++){
						//��ǥ Detail Ű�� ����
						rows4[k].setString(idx2FDCODE,strFdcode);
						rows4[k].setString(idx2FSDAT,strFsdat);
						rows4[k].setString(idx2FSNBR,strFsnbr);

						strFDCODE2 = rows4[k].getString(idx2FDCODE);
						strFSDAT2  = rows4[k].getString(idx2FSDAT);
						strFSNBR2  = rows4[k].getString(idx2FSNBR);

						//�߰�
						strSeq = rows4[k].getString(idx2FSSEQ);
            
						if(!strFSNBR2.equals("000000")){
							strFdcode = strFDCODE2;
							strFsdat = strFSDAT2;
							strFsnbr = strFSNBR2;
          			    }
						
						rows4[k].setString(idx2FSSEQ,strSeq);
						rows4[k].setString(idx2DOCUVAL,strTaxnbr); //���ݰ�꼭 ��ȣ 
					
						dblchaamt = rows4[k].getDouble(idx2CHAAMT);
						dbldaeamt = rows4[k].getDouble(idx2DAEAMT);
						
						//���� �뺯 ���� (�������� ���밡 �ƴ϶� �ݾ� �ִ� �� ������)
						if(dblchaamt!=0 && dbldaeamt ==0){
							strgubun="1"; 
							rows4[k].setString(idx2ATDECR,strgubun);  //����
						}else if (dblchaamt==0 && dbldaeamt != 0){
							strgubun="2";
							rows4[k].setString(idx2ATDECR,strgubun);  //�뺯
							rows4[k].setDouble(idx2CHAAMT,dbldaeamt);
						}else{
							rows4[k].setDouble(idx2CHAAMT,0);
							rows4[k].setDouble(idx2DAEAMT,0);
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
							gsmt2.close();

							//---------------------------
							//��ǥ �����׸�
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

									GauceStatement gsmt2_2 = conn.getGauceStatement(sql2_2.toString());
									gsmt2_2.executeUpdate();
									gsmt2_2.close();
								} //if 
							} //for m
					} //if_jobtype  rows2[k]
				}  //for k 
			}  //for j 

            
		/****************************************** ******************************************
			 @ BANJAEREL ���� Start  - �Է�
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
		 @ BANJAEREL ���� End 
		*************************************************************************************/

		/************************************************************************************
		 @ BANJAE MST Start  - �Է�
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
        
			
				//���� �� �뺯�� 0 �� ��� ���� UPDATE
				UpdateSql14.append( " UPDATE ACCOUNT.BANJAEMST SET " );
				UpdateSql14.append( "        CRAMT = ?," );
				UpdateSql14.append( "        STATUS = ?," );
				UpdateSql14.append( "        UPDT = ?," );
				UpdateSql14.append( "        UPID = ?" );
				UpdateSql14.append( "  WHERE FDCODE=?" );
				UpdateSql14.append( "    AND TSDAT=?" );
				UpdateSql14.append( "    AND TSNBR=?" );
				UpdateSql14.append( "    AND TSSEQ=?" );

                //���� �� ������ 0 �� ��� �뺯 UPDATE
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

					dbldeamt14 = rows14[b].getDouble(idx14DEAMT); //�����ݾ�(������)
                    dblcramt14 = rows14[b].getDouble(idx14CRAMT); //�뺯�ݾ�(������)
					dblamt14 = rows14[b].getDouble(idx14AMT);         //�������ݾ�
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
						if(strAtdecr.equals("1")){      //��������==>�뺯 �ݾ��� UPDATE��
						    dblcramt += dblcramt14;

							 if(dblcramt==dblamt14){//�Ϸ�
								  strStatus = "1";
							 }else{                   //������   
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

						}else if(strAtdecr.equals("2")){     //�뺯���� - ���� �ݾ��� UPDATE��.
							 dbldeamt += dbldeamt14;
							 if(dbldeamt==dblamt14){ //�Ϸ�
								  strStatus = "1";
							 }else{                    //������   
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
		 @ PMS_MCH ��Ī ���̺� INSERT / TPU520 UPDATE 
		************************************************************************************/

		 GauceDataSet userSet7 = reqGauce.getGauceDataSet("USER7");
		
		 if (userSet7 != null) {

				int idx7CON_SID       = userSet7.indexOfColumn("CON_SID");  
				int idx7CGCD_SID     = userSet7.indexOfColumn("CGCD_SID"); 
				int idx7DATE_CGCD  = userSet7.indexOfColumn("DATE_CGCD");
				int idx7TAXNBR         = userSet7.indexOfColumn("TAXNBR");   
				int idx7FDCODE        = userSet7.indexOfColumn("FDCODE");   
				int idx7FSDAT           = userSet7.indexOfColumn("FSDAT");    
				int idx7FSNBR           = userSet7.indexOfColumn("FSNBR");     
				int idx7H_ASTNBR         = userSet7.indexOfColumn("H_ASTNBR");   
				
				GauceDataRow[] rows7 = userSet7.getDataRows();

				StringBuffer UpdateSql7 = null;
			    StringBuffer InsertSql7 = null;
				
			    UpdateSql7 = new StringBuffer();
			    InsertSql7 = new StringBuffer();

				UpdateSql7.append( " UPDATE PMS.TPU520 SET " );
				UpdateSql7.append( "        PUB_TAX_YN = 'Y'" );
				UpdateSql7.append( "  WHERE CGCD_SID=?" );
				
				InsertSql7.append( " INSERT INTO ACCOUNT.PMS_MCH (  " );
				InsertSql7.append( " CON_SID,	CGCD_SID,	DATE_CGCD,	TAXNBR,	  FDCODE,  " );
				InsertSql7.append( " FSDAT,	    FSNBR,	    H_ASTNBR   " );
				InsertSql7.append( "  ) " );
				InsertSql7.append( " VALUES ( ?,?,?,?,?,?,?,? ) ");

				for (int b=0;b<rows7.length;b++){
					logger.dbg.println(this,"UpdateSql7.toString()::"+UpdateSql7.toString());
					GauceStatement gsmt7 = conn.getGauceStatement(UpdateSql7.toString());
					gsmt7.setGauceDataRow(rows7[b]);
					gsmt7.bindColumn(1,idx7CGCD_SID);

					gsmt7.executeUpdate();
					gsmt7.close();
					gsmt7=null;
					
					rows7[b].setString(idx7TAXNBR,strTaxnbr);  //��꼭 ��ȣ 
					rows7[b].setString(idx7FDCODE,strFdcode);  //���� 
					rows7[b].setString(idx7FSDAT,strFsdat);        //�������� 
					rows7[b].setString(idx7FSNBR,strFsnbr);       //������ȣ 

					gsmt7 = conn.getGauceStatement(InsertSql7.toString());
					gsmt7.setGauceDataRow(rows7[b]);
					gsmt7.bindColumn(1,idx7CON_SID);
					gsmt7.bindColumn(2,idx7CGCD_SID);
					gsmt7.bindColumn(3,idx7DATE_CGCD);
					gsmt7.bindColumn(4,idx7TAXNBR);
					gsmt7.bindColumn(5,idx7FDCODE);
					gsmt7.bindColumn(6,idx7FSDAT);
					gsmt7.bindColumn(7,idx7FSNBR);
					gsmt7.bindColumn(8,idx7H_ASTNBR);

					gsmt7.executeUpdate();
					gsmt7.close();
					gsmt7=null;
                   				
				}// for
		 }	
	
			
			
			
			
			
			/************************************************************************************
					 @ return��
			************************************************************************************/
			
			GauceDataSet userSet5 = reqGauce.getGauceDataSet("USER5");
			if (userSet5 != null) {
				resGauce.enableFirstRow(userSet5);
				userSet5.addDataColumn(new GauceDataColumn("FDCODE", GauceDataColumn.TB_STRING,2));
				userSet5.addDataColumn(new GauceDataColumn("FSDAT", GauceDataColumn.TB_STRING,9));
				userSet5.addDataColumn(new GauceDataColumn("FSNBR", GauceDataColumn.TB_STRING,6));
 
				GauceDataRow row = null;
				row = userSet5.newDataRow();
				row.addColumnValue(strFdcode);
				row.addColumnValue(strFsdat);
				row.addColumnValue(strFsnbr);
				userSet5.addDataRow(row);
				userSet5.flush();
			}
				       	

			} //try
			catch(Exception e){
				conn.rollback();
				//logger.err.println(this,"errno::"+strErrorNo);
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
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