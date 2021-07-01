package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a090001_t1_m1 extends HttpServlet{
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
				GauceStatement gsmt=null;
				GauceStatement gsmt2=null;

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				// 웹페이지에서 조건값을 넘겨받음
				String  strDate = reqGauce.getParameter("v_str1"); //작업일자
				String  strEmpno= reqGauce.getParameter("v_str2"); //작업ID		
				String  strCnt  = reqGauce.getParameter("v_str3"); //생성건수		
				String  strAstseq="";
				String  strAstnbr="";
				int     intAstseq=0;
				String  strAstseq_Ori="";
				String  strAstnbr_Ori="";

				String  strMovnote="";  //이동내역
				String  strMovno="";    //이동순번
				String  strAsaqsdat=""; //취득일자

				int     intCnt  = Integer.parseInt(strCnt); //생성건수		

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				//자산MST
				int idxFDCODE     = userSet.indexOfColumn("FDCODE");     
				int idxATCODE     = userSet.indexOfColumn("ATCODE");     
				int idxAST1ST     = userSet.indexOfColumn("AST1ST");     
				int idxAST2ND     = userSet.indexOfColumn("AST2ND");     
				int idxAST3RD     = userSet.indexOfColumn("AST3RD");  
				int idxASTSEQ     = userSet.indexOfColumn("ASTSEQ");    
				int idxASTNAME    = userSet.indexOfColumn("ASTNAME");   
				int idxASAQSDAT   = userSet.indexOfColumn("ASAQSDAT"); 
				int idxTAXNBR     = userSet.indexOfColumn("TAXNBR");   
				int idxFSDAT      = userSet.indexOfColumn("FSDAT");   
				int idxFSNBR      = userSet.indexOfColumn("FSNBR");    
				int idxFSSEQ      = userSet.indexOfColumn("FSSEQ");   
				int idxDEPTCD     = userSet.indexOfColumn("DEPTCD");     
				int idxEMPNO      = userSet.indexOfColumn("EMPNO");      
				int idxASTNAME2   = userSet.indexOfColumn("ASTNAME2");    
				int idxASTNAME3   = userSet.indexOfColumn("ASTNAME3");    
				int idxASTNBR     = userSet.indexOfColumn("ASTNBR");    
				int idxH_ASTNBR   = userSet.indexOfColumn("H_ASTNBR");  
				int idxWRDT       = userSet.indexOfColumn("WRDT");    
				int idxWRID       = userSet.indexOfColumn("WRID");  
				int idxUPDT       = userSet.indexOfColumn("UPDT");         
				int idxUPID       = userSet.indexOfColumn("UPID");  
				int idxS_ASTNBR   = userSet.indexOfColumn("S_ASTNBR"); 
				int idxMORDT   = userSet.indexOfColumn("MORDT");

                //자산BASIC
	 			GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2");
                int idx2FDCODE     = userSet2.indexOfColumn("FDCODE");     
			    int idx2ATCODE     = userSet2.indexOfColumn("ATCODE");     
				int idx2AST1ST     = userSet2.indexOfColumn("AST1ST");     
				int idx2AST2ND     = userSet2.indexOfColumn("AST2ND");     
				int idx2AST3RD     = userSet2.indexOfColumn("AST3RD");  
				int idx2ASTSEQ     = userSet2.indexOfColumn("ASTSEQ");    
				int idx2MNGTYPE    = userSet2.indexOfColumn("MNGTYPE");   
				int idx2ASTSTAT    = userSet2.indexOfColumn("ASTSTAT"); 
				int idx2ASCOSDIV   = userSet2.indexOfColumn("ASCOSDIV");   
				int idx2COSTCD     = userSet2.indexOfColumn("COSTCD");       
				int idx2ASAQSDIV   = userSet2.indexOfColumn("ASAQSDIV");       
				int idx2GODDIV     = userSet2.indexOfColumn("GODDIV");       
				int idx2ASTCLASS   = userSet2.indexOfColumn("ASTCLASS");     
				int idx2ASTRIS     = userSet2.indexOfColumn("ASTRIS");       
				int idx2ASTUNIT    = userSet2.indexOfColumn("ASTUNIT");      
				int idx2ASTQTY     = userSet2.indexOfColumn("ASTQTY");       
				int idx2ASTSTD     = userSet2.indexOfColumn("ASTSTD");       
				int idx2ASTAQAMT   = userSet2.indexOfColumn("ASTAQAMT");     
	            int idx2ASTYUSE    = userSet2.indexOfColumn("ASTYUSE");      
				int idx2ASTVALYMD  = userSet2.indexOfColumn("ASTVALYMD");    
				int idx2MNGDPT     = userSet2.indexOfColumn("MNGDPT");       
				int idx2USEDPT     = userSet2.indexOfColumn("USEDPT");       
				int idx2USELOC     = userSet2.indexOfColumn("USELOC");       
				int idx2BUYFROM    = userSet2.indexOfColumn("BUYFROM");      
				int idx2MAKER      = userSet2.indexOfColumn("MAKER");        
				int idx2ASTNOTE    = userSet2.indexOfColumn("ASTNOTE");      
	 	 	    int idx2ASTAQAMTY  = userSet2.indexOfColumn("ASTAQAMTY");    
				int idx2ASTUSER    = userSet2.indexOfColumn("ASTUSER");      
				int idx2WRDT       = userSet2.indexOfColumn("WRDT");         
				int idx2WRID       = userSet2.indexOfColumn("WRID");   
				int idx2UPDT       = userSet2.indexOfColumn("UPDT");         
				int idx2UPID       = userSet2.indexOfColumn("UPID");  
				int idx2REGIGB     = userSet2.indexOfColumn("REGIGB");         
				int idx2DEPRGB     = userSet2.indexOfColumn("DEPRGB"); 
				
				
		        //부가정보1
		        GauceDataSet userSet31 = reqGauce.getGauceDataSet("USER31");
		        int idx31FDCODE    = userSet31.indexOfColumn("FDCODE"); 
				int idx31ATCODE    = userSet31.indexOfColumn("ATCODE"); 
				int idx31AST1ST    = userSet31.indexOfColumn("AST1ST"); 
				int idx31AST2ND    = userSet31.indexOfColumn("AST2ND");
				int idx31AST3RD    = userSet31.indexOfColumn("AST3RD");
				int idx31ASTSEQ    = userSet31.indexOfColumn("ASTSEQ");
				int idx31ASTSOJE   = userSet31.indexOfColumn("ASTSOJE");
				int idx31ASTPOST   = userSet31.indexOfColumn("ASTPOST");
				int idx31ASTCON    = userSet31.indexOfColumn("ASTCON");
				int idx31ASTUSE    = userSet31.indexOfColumn("ASTUSE");
				int idx31ASTSIZE   = userSet31.indexOfColumn("ASTSIZE");
				int idx31ASTPYUNG  = userSet31.indexOfColumn("ASTPYUNG");
				int idx31ASTREGYMD = userSet31.indexOfColumn("ASTREGYMD");
				int idx31ASTREGNO  = userSet31.indexOfColumn("ASTREGNO");

				//부가정보2		
	  			GauceDataSet userSet32 = reqGauce.getGauceDataSet("USER32");
		        int idx32FDCODE    = userSet32.indexOfColumn("FDCODE"); 
				int idx32ATCODE    = userSet32.indexOfColumn("ATCODE"); 
				int idx32AST1ST    = userSet32.indexOfColumn("AST1ST"); 
				int idx32AST2ND    = userSet32.indexOfColumn("AST2ND");
				int idx32AST3RD    = userSet32.indexOfColumn("AST3RD");
				int idx32ASTSEQ    = userSet32.indexOfColumn("ASTSEQ");
				int idx32ACARTYPE  = userSet32.indexOfColumn("ACARTYPE");
				int idx32ACARNO    = userSet32.indexOfColumn("ACARNO");
				int idx32ACARBEGI  = userSet32.indexOfColumn("ACARBEGI");
				int idx32ACARFUEL  = userSet32.indexOfColumn("ACARFUEL");
				int idx32ACARUSE   = userSet32.indexOfColumn("ACARUSE");
				int idx32ACARINSDT = userSet32.indexOfColumn("ACARINSDT");
				int idx32ACARDRVID = userSet32.indexOfColumn("ACARDRVID");
				int idx32AINSDT1   = userSet32.indexOfColumn("AINSDT1");
				int idx32AINSDT2   = userSet32.indexOfColumn("AINSDT2");
												
				//부가정보3
				GauceDataSet userSet33 = reqGauce.getGauceDataSet("USER33");
                int idx33FDCODE    = userSet33.indexOfColumn("FDCODE"); 
				int idx33ATCODE    = userSet33.indexOfColumn("ATCODE"); 
				int idx33AST1ST    = userSet33.indexOfColumn("AST1ST"); 
				int idx33AST2ND    = userSet33.indexOfColumn("AST2ND");
				int idx33AST3RD    = userSet33.indexOfColumn("AST3RD");
				int idx33ASTSEQ    = userSet33.indexOfColumn("ASTSEQ");
				int idx33AMMODEL   = userSet33.indexOfColumn("AMMODEL");
				int idx33AMAKEDATE = userSet33.indexOfColumn("AMAKEDATE");
				int idx33ASUBSTD   = userSet33.indexOfColumn("ASUBSTD");
				int idx33AMAKENO   = userSet33.indexOfColumn("AMAKENO");
				int idx33AMWEIGHT  = userSet33.indexOfColumn("AMWEIGHT");
				int idx33AMFORM    = userSet33.indexOfColumn("AMFORM");
				int idx33AMOIL     = userSet33.indexOfColumn("AMOIL");
		 
				GauceDataRow[] rows = userSet.getDataRows();   //자산mst
				GauceDataRow[] rows2 = userSet2.getDataRows(); //자산basic
				GauceDataRow[] rows31 = userSet31.getDataRows(); //부가정보1
				GauceDataRow[] rows32 = userSet32.getDataRows(); //부가정보2
				GauceDataRow[] rows33 = userSet33.getDataRows(); //부가정보3
    
                StringBuffer Sql = null;        
				StringBuffer InsertSql = null;        
				StringBuffer UpdateSql = null;	      
 				StringBuffer DeleteSql = null;	  

				StringBuffer InsertSql2 = null;     
				StringBuffer UpdateSql2 = null;	      
 				StringBuffer DeleteSql2 = null;	
			
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {  
					
						//일련번호 채번      
						Sql = new StringBuffer();
						Statement stmt = conn.createStatement();

						Sql.append( " SELECT LPAD(TO_NUMBER(NVL(MAX(ASTSEQ),0))+1,5,0) " );
						Sql.append( "   FROM ACCOUNT.ASTMSTN " );
						Sql.append( "  WHERE FDCODE ='"+rows[j].getString(idxFDCODE)+"' " );
						Sql.append( "    AND ATCODE ='"+rows[j].getString(idxATCODE)+"' " );
                        Sql.append( "    AND AST1ST ='"+rows[j].getString(idxAST1ST)+"' " );
						Sql.append( "    AND AST2ND ='"+rows[j].getString(idxAST2ND)+"' " );
						Sql.append( "    AND AST3RD ='"+rows[j].getString(idxAST3RD)+"' " );

						ResultSet rs = stmt.executeQuery(Sql.toString()); 
						
						if(rs.next()){
							strAstseq= rs.getString(1);
						}    
  						rs.close();
						stmt.close();

          				//자산번호생성   
            			//대분류
						if(rows[j].getString(idxAST1ST).equals("01")||rows[j].getString(idxAST1ST).equals("02")){
							strAstnbr=strAstnbr+"S";
						}else if(rows[j].getString(idxAST1ST).equals("03")){
              				strAstnbr=strAstnbr+"K";
						}else if(rows[j].getString(idxAST1ST).equals("04")){
              				strAstnbr=strAstnbr+"G";
						}
 
			            //중분류
			            if(rows[j].getString(idxAST2ND).equals("11")){
							strAstnbr=strAstnbr+"L";
						}else if(rows[j].getString(idxAST2ND).equals("12")){
			                strAstnbr=strAstnbr+"B";
						}else if(rows[j].getString(idxAST2ND).equals("13")){
			                strAstnbr=strAstnbr+"S";
			            }else if(rows[j].getString(idxAST2ND).equals("14")){
							strAstnbr=strAstnbr+"V";
			            }else if(rows[j].getString(idxAST2ND).equals("15")){
			                strAstnbr=strAstnbr+"I"; 
			            }else if(rows[j].getString(idxAST2ND).equals("16")){
			                strAstnbr=strAstnbr+"F";
			            }else if(rows[j].getString(idxAST2ND).equals("17")){
			                strAstnbr=strAstnbr+"E";
						}

                        //소분류
						if(rows[j].getString(idxAST3RD).equals("01")){
							strAstnbr=strAstnbr+"H";
					    }else if(rows[j].getString(idxAST3RD).equals("02")){
							strAstnbr=strAstnbr+"B";
					    }else if(rows[j].getString(idxAST3RD).equals("03")){
							strAstnbr=strAstnbr+"C";
						}else if(rows[j].getString(idxAST3RD).equals("04")){
							strAstnbr=strAstnbr+"O";    //영문 O
						}else if(rows[j].getString(idxAST3RD).equals("05")){
							strAstnbr=strAstnbr+"T";
						}else if(rows[j].getString(idxAST3RD).equals("06")){
							strAstnbr=strAstnbr+"F";
						}else if(rows[j].getString(idxAST3RD).equals("07")){
							strAstnbr=strAstnbr+"E";
						}else{
							strAstnbr=strAstnbr+"0";    //숫자 0 
						}

						strAstnbr_Ori = strAstnbr;
           				strAstseq_Ori = strAstseq;

						strAstnbr = strAstnbr + strAstseq;				
						intAstseq = Integer.parseInt(strAstseq);

						//logger.dbg.println(this,"ASTNBR:::"+strAstnbr);						
            						
						rows[j].setString(idxH_ASTNBR,strAstnbr);					
						rows[j].setString(idxWRDT,strDate);
						rows[j].setString(idxWRID,strEmpno);

						for(int jj=0;jj<intCnt;jj++){
				            if(jj>0){
				                intAstseq +=1;
								strAstseq = String.valueOf(intAstseq);
								if(intAstseq<10) strAstseq = "0000"+strAstseq;
								else if(intAstseq>=10 && intAstseq<100)strAstseq = "000"+strAstseq;
								else if(intAstseq>=100 && intAstseq<1000) strAstseq ="00"+strAstseq;
								else if(intAstseq>=1000 && intAstseq<10000)strAstseq = "0"+strAstseq;

								strAstnbr = strAstnbr_Ori + strAstseq;
							}										

							//logger.dbg.println(this,"jj"+jj+"::strAstseq::"+strAstseq);

						    rows[j].setString(idxASTSEQ,strAstseq);		
							rows[j].setString(idxASTNBR,strAstnbr);

							 //취득일자 ( 자산이동의 최초이동일자로 넣기위함. )
						    strAsaqsdat = rows[j].getString(idxASAQSDAT);
						
							//등록구분이 최초등록일 경우 최초 자산번호는 자산번호임. 
							if(rows2[0].getString(idx2REGIGB).equals("1")){
								rows[j].setString(idxS_ASTNBR,strAstnbr);							
							}

							//자산원장
							InsertSql = new StringBuffer();
							InsertSql.append( " INSERT INTO ACCOUNT.ASTMSTN (  " );
							InsertSql.append( " FDCODE,ATCODE,AST1ST,AST2ND,AST3RD, " );
							InsertSql.append( " ASTSEQ,ASTNAME,ASAQSDAT,TAXNBR,FSDAT," );
							InsertSql.append( " FSNBR,FSSEQ,DEPTCD,EMPNO,ASTNAME2," );
							InsertSql.append( " ASTNAME3,ASTNBR,H_ASTNBR,WRDT,WRID,S_ASTNBR,MORDT ) " );
							InsertSql.append( " VALUES (  " );
							InsertSql.append( " ?,?,?,?,?,?,?,?,?,?, " );
							InsertSql.append( " ?,?,?,?,?,?,?,?,sysdate,?,?,? ) " );

							gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows[j]);
							gsmt.bindColumn(1,  idxFDCODE);
							gsmt.bindColumn(2,  idxATCODE);
							gsmt.bindColumn(3,  idxAST1ST);
							gsmt.bindColumn(4,  idxAST2ND);
							gsmt.bindColumn(5,  idxAST3RD);
							gsmt.bindColumn(6,  idxASTSEQ);
							gsmt.bindColumn(7,  idxASTNAME);
							gsmt.bindColumn(8,  idxASAQSDAT);
							gsmt.bindColumn(9,  idxTAXNBR);
							gsmt.bindColumn(10, idxFSDAT);
							gsmt.bindColumn(11, idxFSNBR);
							gsmt.bindColumn(12, idxFSSEQ);
							gsmt.bindColumn(13, idxDEPTCD);
							gsmt.bindColumn(14, idxEMPNO);
							gsmt.bindColumn(15, idxASTNAME2);
							gsmt.bindColumn(16, idxASTNAME3);
							gsmt.bindColumn(17, idxASTNBR);
							gsmt.bindColumn(18, idxH_ASTNBR);
							gsmt.bindColumn(19, idxWRID);
							gsmt.bindColumn(20, idxS_ASTNBR);
							gsmt.bindColumn(21, idxMORDT);
							gsmt.executeUpdate();
							gsmt.close();
						}//for jj
					}//if

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {  

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {  

					}
				}//for

                //자산기본 ASTBASIC
 				for (int i = 0; i < rows2.length; i++){
					if(rows2[i].getJobType() == GauceDataRow.TB_JOB_INSERT) {  

						rows2[i].setString(idx2WRDT,strDate);
						rows2[i].setString(idx2WRID,strEmpno);

						intAstseq = Integer.parseInt(strAstseq_Ori);
           				 strAstseq = strAstseq_Ori;

			            for(int ii=0;ii<intCnt;ii++){
			              if(ii>0){
			                intAstseq +=1;
								strAstseq = String.valueOf(intAstseq);
								if(intAstseq<10) strAstseq = "0000"+strAstseq;
								else if(intAstseq>=10 && intAstseq<100)strAstseq = "000"+strAstseq;
								else if(intAstseq>=100 && intAstseq<1000) strAstseq ="00"+strAstseq;
								else if(intAstseq>=1000 && intAstseq<10000)strAstseq = "0"+strAstseq;
							}				

   						   rows2[i].setString(idx2ASTSEQ,strAstseq);
  						
  						   //자산기본
							InsertSql = new StringBuffer();
							InsertSql.append( " INSERT INTO ACCOUNT.ASTBASICN (  " );
							InsertSql.append( " FDCODE,ATCODE,AST1ST,AST2ND,AST3RD, " );
							InsertSql.append( " ASTSEQ,MNGTYPE,ASTSTAT,ASCOSDIV,COSTCD," );
							InsertSql.append( " ASAQSDIV,GODDIV,ASTCLASS,ASTRIS,ASTUNIT, " );
							InsertSql.append( " ASTQTY,ASTSTD,ASTAQAMT,ASTYUSE,ASTVALYMD," );
							InsertSql.append( " MNGDPT,USEDPT,USELOC,BUYFROM,MAKER, " );
							InsertSql.append( " ASTNOTE,ASTAQAMTY,ASTUSER,WRDT,WRID,REGIGB,DEPRGB ) " );
							InsertSql.append( " VALUES (  " );
							InsertSql.append( " ?,?,?,?,?,?,?,?,?,?, " );
							InsertSql.append( " ?,?,?,?,?,?,?,?,?,?, " );
							InsertSql.append( " ?,?,?,?,?,?,?,?,sysdate,?,?,? )" );

							gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows2[i]);
							gsmt.bindColumn(1,  idx2FDCODE);   
							gsmt.bindColumn(2,  idx2ATCODE);   
							gsmt.bindColumn(3,  idx2AST1ST);   
							gsmt.bindColumn(4,  idx2AST2ND);   
							gsmt.bindColumn(5,  idx2AST3RD);   
							gsmt.bindColumn(6,  idx2ASTSEQ);   
							gsmt.bindColumn(7,  idx2MNGTYPE);  
							gsmt.bindColumn(8,  idx2ASTSTAT);  
							gsmt.bindColumn(9,  idx2ASCOSDIV); 
							gsmt.bindColumn(10, idx2COSTCD);   
							gsmt.bindColumn(11, idx2ASAQSDIV); 
							gsmt.bindColumn(12, idx2GODDIV);   
							gsmt.bindColumn(13, idx2ASTCLASS); 
							gsmt.bindColumn(14, idx2ASTRIS);   
							gsmt.bindColumn(15, idx2ASTUNIT);  
							gsmt.bindColumn(16, idx2ASTQTY);   
							gsmt.bindColumn(17, idx2ASTSTD);   
							gsmt.bindColumn(18, idx2ASTAQAMT); 
							gsmt.bindColumn(19, idx2ASTYUSE);  
							gsmt.bindColumn(20, idx2ASTVALYMD);
							gsmt.bindColumn(21, idx2MNGDPT);   
							gsmt.bindColumn(22, idx2USEDPT);   
							gsmt.bindColumn(23, idx2USELOC);   
							gsmt.bindColumn(24, idx2BUYFROM);  
							gsmt.bindColumn(25, idx2MAKER);    
							gsmt.bindColumn(26, idx2ASTNOTE);  
							gsmt.bindColumn(27, idx2ASTAQAMTY);
							gsmt.bindColumn(28, idx2ASTUSER);      
							gsmt.bindColumn(29, idx2WRID);     
							gsmt.bindColumn(30, idx2REGIGB);     
							gsmt.bindColumn(31, idx2DEPRGB);     
							gsmt.executeUpdate();
							gsmt.close();


                           //자산이동 INSERT 
							if(rows2[i].getString(idx2REGIGB).equals("2")){ //이체등록
								strMovnote ="이체등록";

							}else{ //최초등록
								strMovnote ="최초등록";

							}

                            //ASTMOVNO 채번==============================================================
							Sql = new StringBuffer();
							Statement stmt = conn.createStatement();

							Sql.append( " SELECT LPAD(TO_NUMBER(NVL(MAX(ASTMOVNO),0))+1,4,0) 	" );
							Sql.append( "   FROM ACCOUNT.ASTMOVINGN 											" );
							Sql.append( "  WHERE FDCODE ='"+rows2[i].getString(idxFDCODE)+"' " );
							Sql.append( "    AND ATCODE ='"+rows2[i].getString(idxATCODE)+"' " );
							Sql.append( "    AND AST1ST ='"+rows2[i].getString(idxAST1ST)+"' " );
							Sql.append( "    AND AST2ND ='"+rows2[i].getString(idxAST2ND)+"' " );
							Sql.append( "    AND AST3RD ='"+rows2[i].getString(idxAST3RD)+"' " );
							Sql.append( "    AND ASTSEQ ='"+rows2[i].getString(idxASTSEQ)+"' " );

							//logger.dbg.println(this,"Sql.toString()::"+Sql.toString());

							ResultSet rs = stmt.executeQuery(Sql.toString()); 
							if(rs.next()){
								strMovno= rs.getString(1);
							}    
							rs.close();
							stmt.close();
							
							//===========================================================================

							InsertSql2 = new StringBuffer();
							InsertSql2.append( " INSERT INTO ACCOUNT.ASTMOVINGN (  " );
							InsertSql2.append( " FDCODE,ATCODE,AST1ST,AST2ND,AST3RD, " );
							InsertSql2.append( " ASTSEQ,ASTMOVNO,MOVDATE,ASTGUBUN,AMNGDPT," );
							InsertSql2.append( " AUSEDPT,ACOSTCD,AUSER,MOVNOTE," );
							InsertSql2.append( " WRDT,WRID ) " );
							InsertSql2.append( " VALUES (   " );
							InsertSql2.append( " ?,?,?,?,?, " );
							InsertSql2.append( " ?,'"+strMovno+"','"+strAsaqsdat+"','0',?, " );
							InsertSql2.append( " ?,?,?,'"+strMovnote+"',   " );
							InsertSql2.append( " sysdate,? )   " );

							gsmt2 = conn.getGauceStatement(InsertSql2.toString());
							gsmt2.setGauceDataRow(rows2[i]);

							gsmt2.bindColumn(1,  idx2FDCODE);   
							gsmt2.bindColumn(2,  idx2ATCODE);   
							gsmt2.bindColumn(3,  idx2AST1ST);   
							gsmt2.bindColumn(4,  idx2AST2ND);   
							gsmt2.bindColumn(5,  idx2AST3RD);   
							gsmt2.bindColumn(6,  idx2ASTSEQ);  
							gsmt2.bindColumn(7,  idx2MNGDPT);   
							gsmt2.bindColumn(8,  idx2USEDPT); 
							gsmt2.bindColumn(9,  idx2COSTCD); 
							gsmt2.bindColumn(10, idx2ASTUSER);     
							gsmt2.bindColumn(11, idx2WRID); 

							gsmt2.executeUpdate();
							gsmt2.close();
	
						}//for ii
					}

					if(rows2[i].getJobType() == GauceDataRow.TB_JOB_UPDATE) {  
						
					}

					if(rows2[i].getJobType() == GauceDataRow.TB_JOB_DELETE) {  

					}
				}

        ////////////////////////////////////////////////////////////////
        //부가정보1
 				for (int a = 0; a < rows31.length; a++){
					if(rows31[a].getJobType() == GauceDataRow.TB_JOB_INSERT) { 
						
						intAstseq = Integer.parseInt(strAstseq_Ori);
            			strAstseq = strAstseq_Ori;
			
				         for(int aa=0;aa<intCnt;aa++){
				            if(aa>0){
			                    intAstseq +=1;
								strAstseq = String.valueOf(intAstseq);
								if(intAstseq<10) strAstseq = "0000"+strAstseq;
								else if(intAstseq>=10 && intAstseq<100)strAstseq = "000"+strAstseq;
								else if(intAstseq>=100 && intAstseq<1000) strAstseq ="00"+strAstseq;
								else if(intAstseq>=1000 && intAstseq<10000)strAstseq = "0"+strAstseq;
							}				

							rows31[a].setString(idx31ASTSEQ,strAstseq);

							InsertSql = new StringBuffer();
							InsertSql.append( " INSERT INTO ACCOUNT.ASTADINFO1N (  " );
							InsertSql.append( " FDCODE,ATCODE,AST1ST,AST2ND,AST3RD, " );
							InsertSql.append( " ASTSEQ,ASTSOJE,ASTPOST,ASTCON,ASTUSE," );
							InsertSql.append( " ASTSIZE,ASTPYUNG,ASTREGYMD,ASTREGNO ) " );
							InsertSql.append( " VALUES (  " );
							InsertSql.append( " ?,?,?,?,?,?,?,?,?,?, " );
							InsertSql.append( " ?,?,?,? ) " );

							gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows31[a]);
							gsmt.bindColumn(1,  idx31FDCODE);   
							gsmt.bindColumn(2,  idx31ATCODE);   
							gsmt.bindColumn(3,  idx31AST1ST);   
							gsmt.bindColumn(4,  idx31AST2ND);   
							gsmt.bindColumn(5,  idx31AST3RD);   
							gsmt.bindColumn(6,  idx31ASTSEQ);   
							gsmt.bindColumn(7,  idx31ASTSOJE);  
							gsmt.bindColumn(8,  idx31ASTPOST);  
							gsmt.bindColumn(9,  idx31ASTCON); 
							gsmt.bindColumn(10, idx31ASTUSE);   
							gsmt.bindColumn(11, idx31ASTSIZE); 
							gsmt.bindColumn(12, idx31ASTPYUNG);   
							gsmt.bindColumn(13, idx31ASTREGYMD); 
							gsmt.bindColumn(14, idx31ASTREGNO);   
								 
							gsmt.executeUpdate();
							gsmt.close();
						}//for aa
					}

					if(rows31[a].getJobType() == GauceDataRow.TB_JOB_UPDATE) {  
					}

					if(rows31[a].getJobType() == GauceDataRow.TB_JOB_DELETE) {  

					}
				}


	        ////////////////////////////////////////////////////////////////
	        //부가정보2
	 				for (int b = 0; b < rows32.length; b++){
						if(rows32[b].getJobType() == GauceDataRow.TB_JOB_INSERT) {  

						intAstseq = Integer.parseInt(strAstseq_Ori);
						strAstseq = strAstseq_Ori;

		            for(int bb=0;bb<intCnt;bb++){
		              if(bb>0){
		                intAstseq+=1;
								strAstseq = String.valueOf(intAstseq);
								if(intAstseq<10) strAstseq = "0000"+strAstseq;
								else if(intAstseq>=10 && intAstseq<100)strAstseq = "000"+strAstseq;
								else if(intAstseq>=100 && intAstseq<1000) strAstseq ="00"+strAstseq;
								else if(intAstseq>=1000 && intAstseq<10000)strAstseq = "0"+strAstseq;
							}				

							//logger.dbg.println(this,"bb"+bb+"::strAstseq::"+strAstseq);
							rows32[b].setString(idx32ASTSEQ,strAstseq);

							InsertSql = new StringBuffer();
							InsertSql.append( " INSERT INTO ACCOUNT.ASTADINFO2N (  " );
							InsertSql.append( " FDCODE,ATCODE,AST1ST,AST2ND,AST3RD, " );
							InsertSql.append( " ASTSEQ,ACARTYPE,ACARNO,ACARBEGI,ACARFUEL," );
							InsertSql.append( " ACARUSE,ACARINSDT,ACARDRVID,AINSDT1,AINSDT2 ) " );
							InsertSql.append( " VALUES (  " );
							InsertSql.append( " ?,?,?,?,?,?,?,?,?,?, " );
							InsertSql.append( " ?,?,?,?,? ) " );

							gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows32[b]);
							gsmt.bindColumn(1,  idx32FDCODE);   
							gsmt.bindColumn(2,  idx32ATCODE);   
							gsmt.bindColumn(3,  idx32AST1ST);   
							gsmt.bindColumn(4,  idx32AST2ND);   
							gsmt.bindColumn(5,  idx32AST3RD);   
							gsmt.bindColumn(6,  idx32ASTSEQ);  
							gsmt.bindColumn(7,  idx32ACARTYPE);  
							gsmt.bindColumn(8,  idx32ACARNO);  
							gsmt.bindColumn(9,  idx32ACARBEGI); 
							gsmt.bindColumn(10, idx32ACARFUEL); 
							gsmt.bindColumn(11, idx32ACARUSE); 
							gsmt.bindColumn(12, idx32ACARINSDT);   
							gsmt.bindColumn(13, idx32ACARDRVID); 
							gsmt.bindColumn(14, idx32AINSDT1);
							gsmt.bindColumn(15, idx32AINSDT2); 
								 
							gsmt.executeUpdate();
							gsmt.close();
						}//for bb
					}

					if(rows32[b].getJobType() == GauceDataRow.TB_JOB_UPDATE) {  
						
					}

					if(rows32[b].getJobType() == GauceDataRow.TB_JOB_DELETE) {  

					}
				}

	        ////////////////////////////////////////////////////////////////
	        //부가정보3
	 				for (int c = 0; c < rows33.length; c++){
						if(rows33[c].getJobType() == GauceDataRow.TB_JOB_INSERT) {  
            
						intAstseq = Integer.parseInt(strAstseq_Ori);
						strAstseq = strAstseq_Ori;

		            for(int cc=0;cc<intCnt;cc++){
		              if(cc>0){
		                intAstseq+=1;
								strAstseq = String.valueOf(intAstseq);
								if(intAstseq<10) strAstseq = "0000"+strAstseq;
								else if(intAstseq>=10 && intAstseq<100)strAstseq = "000"+strAstseq;
								else if(intAstseq>=100 && intAstseq<1000) strAstseq ="00"+strAstseq;
								else if(intAstseq>=1000 && intAstseq<10000)strAstseq = "0"+strAstseq;
							}				

							rows33[c].setString(idx33ASTSEQ,strAstseq);

							InsertSql = new StringBuffer();
							InsertSql.append( " INSERT INTO ACCOUNT.ASTADINFO3N (  " );
							InsertSql.append( " FDCODE,ATCODE,AST1ST,AST2ND,AST3RD, " );
							InsertSql.append( " ASTSEQ,AMMODEL,AMAKEDATE,ASUBSTD,AMAKENO," );
							InsertSql.append( " AMWEIGHT,AMFORM,AMOIL ) " );
							InsertSql.append( " VALUES (  " );
							InsertSql.append( " ?,?,?,?,?,?,?,?,?,?, " );
							InsertSql.append( " ?,?,? ) " );

							gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows33[c]);
							gsmt.bindColumn(1,  idx33FDCODE);   
							gsmt.bindColumn(2,  idx33ATCODE);   
							gsmt.bindColumn(3,  idx33AST1ST);   
							gsmt.bindColumn(4,  idx33AST2ND);   
							gsmt.bindColumn(5,  idx33AST3RD);   
							gsmt.bindColumn(6,  idx33ASTSEQ);  
							gsmt.bindColumn(7,  idx33AMMODEL);  
							gsmt.bindColumn(8,  idx33AMAKEDATE);  
							gsmt.bindColumn(9,  idx33ASUBSTD); 
							gsmt.bindColumn(10, idx33AMAKENO); 
							gsmt.bindColumn(11, idx33AMWEIGHT); 
							gsmt.bindColumn(12, idx33AMFORM);   
							gsmt.bindColumn(13, idx33AMOIL); 
								 
							gsmt.executeUpdate();
							gsmt.close();
						}//for cc
					}

					if(rows33[c].getJobType() == GauceDataRow.TB_JOB_UPDATE) {  
						
					}

					if(rows33[c].getJobType() == GauceDataRow.TB_JOB_DELETE) {  

					}
				}

				GauceDataSet userSet99 = reqGauce.getGauceDataSet("USER99");
				if (userSet99 != null) {
					resGauce.enableFirstRow(userSet99);
					userSet99.addDataColumn(new GauceDataColumn("ASTNBR", GauceDataColumn.TB_STRING,8));
					userSet99.addDataColumn(new GauceDataColumn("H_ASTNBR", GauceDataColumn.TB_STRING,8));
       
					GauceDataRow row = null;
					row = userSet99.newDataRow();
					row.addColumnValue(strAstnbr);
					row.addColumnValue(strAstnbr);
					userSet99.addDataRow(row);
					userSet99.flush();
				}
		
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