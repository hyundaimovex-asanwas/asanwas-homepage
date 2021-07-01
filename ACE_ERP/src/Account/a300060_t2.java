package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a300060_t2 extends HttpServlet{
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
				String strTaxnbr=reqGauce.getParameter("v_str1"); //구분값+년월
				
				//System.out.println("strTaxnbr : " + strTaxnbr);
				
				String taxno="";                                 
				String taxseq="";
				
				GauceDataSet userSet1 = reqGauce.getGauceDataSet("USER1");
				String[] StrArrCN1 = new String[] {
				
					"TAXNBR",   "COCODE",   "DEPTCD",  "EMPNO",      "TAXIODIV",
					"TAXDIV",   "TAXKND",   "VEND_CD", "TAXDAT",     "TAXSUM",
					"TAXVATAMT","TAXTOT",   "REMARK",  "TAXCDNBR",   "ATCODE",
					"TAXPRTYN", "TAXCNT",   "LASTPRT", "TAXTYPE",    "FSDAT",	
					"FSNBR",    "TAXKIDIV", "FDCODE",  "WORKTYPE",   "WRDT",  
					"WRID",     "SEQ",      "GUBUN",   "AMEND_CODE", "AMEND_REMARK" , 
					"EXTCHK",   "REMARK2",  "COSTCD",  "B_BIZPLACE", "S_BIZPLACE",  "REMARK3",  "UPDT",  "UPID", 
				};

				int[] idx1 = new int[38];
				for(int i=0;i<StrArrCN1.length;i++) {
					idx1[i] = userSet1.indexOfColumn(StrArrCN1[i]);
				}
				
				GauceDataRow[] rows1 = userSet1.getDataRows();
							
				//str27=rows1[0].getString(idx1[4]);			//  서울 A-매입, B-매출  , 개성 C-매입, D-매출 , 금강산 E-매입, F-매출 

				GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2");

				String[] StrArrCN = new String[] {
					"TAXNBR",  "TAXSEQ", "TAXPDTNAM","TAXSTD","TAXQTY",
					"TAXPRIC", "TAXSUM", "TAXVATAMT","BIGO","WRDT",
					"WRID",    "UPDT",   "UPID"
				};

				int[] idx2 = new int[13];
				for(int i=0;i<StrArrCN.length;i++) {
					idx2[i] = userSet2.indexOfColumn(StrArrCN[i]);
				}

				GauceDataRow[] rows2 = userSet2.getDataRows();
				
				
				
				GauceDataSet userSet3 = reqGauce.getGauceDataSet("USER3");
				String[] StrArrCN3 = new String[] {
					"APPNO","TAXNBR","UPDT","UPID"
				};

				int[] idx3 = new int[4];
				for(int i=0;i<StrArrCN3.length;i++) {
					idx3[i] = userSet3.indexOfColumn(StrArrCN3[i]);
				}

				GauceDataRow[] rows3 = userSet3.getDataRows();
				

				StringBuffer InsertSql1  = null;	//Master
				StringBuffer InsertSql2  = null;	//Detail
				StringBuffer UpdateSql1  = null;
				StringBuffer UpdateSql2  = null;
				StringBuffer DeleteSql1  = null;
				StringBuffer DeleteSql2  = null;
				
				StringBuffer UpdateSql3  = null;

				//매입 Master
				Statement stmt1 = null;
				ResultSet rs1 = null;

				//매입 Detali
				Statement stmt2 = null;
				ResultSet rs2 = null;
				
				for (int j = 0; j < rows1.length; j++){
					if(rows1[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						/*******************************************************************
								매입 Master
						********************************************************************/
											
						StringBuffer sql1 = new StringBuffer();
						
						sql1.append( " SELECT LPAD(TO_NUMBER(NVL(MAX(SUBSTR(TAXNBR,8,11)),0))+1,4,'0')    \n");
						sql1.append( "   FROM ACCOUNT.ATTAXMST								         	  \n");
						sql1.append( "  WHERE TAXNBR LIKE '"+strTaxnbr+"%'		                          \n");
													
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(sql1.toString());

						//System.out.println("sql1 : " + sql1.toString());
						while(rs1.next())	{
							taxno = rs1.getString(1);
						}
						rs1.close();
						stmt1.close();
																	
						strTaxnbr = strTaxnbr+taxno; //계산서번호 구분자 포함. 
						
						//System.out.println("strTaxnbr : " + strTaxnbr);
						
						rows1[j].setString(idx1[0],strTaxnbr);

						InsertSql1 = new StringBuffer();
						InsertSql1.append( " INSERT INTO ACCOUNT.ATTAXMST (					\n");
						InsertSql1.append( " TAXNBR,COCODE,DEPTCD,EMPNO,TAXIODIV,			\n");
						InsertSql1.append( " TAXDIV,TAXKND,VEND_CD,TAXDAT,TAXSUM,			\n");
						InsertSql1.append( " TAXVATAMT,TAXTOT,REMARK,TAXCDNBR,ATCODE,    	\n");
						InsertSql1.append( " TAXPRTYN,TAXCNT,LASTPRT,TAXTYPE,FSDAT,			\n");
						InsertSql1.append( " FSNBR,TAXKIDIV,FDCODE,WORKTYPE,WRDT,WRID,	    \n");
						InsertSql1.append( " SEQ,  GUBUN, AMEND_CODE, AMEND_REMARK,       	\n");
						InsertSql1.append( " EXTCHK, REMARK2,COSTCD, B_BIZPLACE,S_BIZPLACE,REMARK3 	\n");
						InsertSql1.append( " ) VALUES(										\n");
						InsertSql1.append( "   ?,?,?,?,?,?,?,?,?,?,                       	\n");
						InsertSql1.append( "   ?,?,?,?,?,?,?,?,?,?,                       	\n");
						InsertSql1.append( "   ?,?,?,?,?,?,?,?,?,?,                       	\n");
						InsertSql1.append( "   ?,?,?,?,?,?                                   \n");
						InsertSql1.append( " )												\n");

						GauceStatement gsmt1 = conn.getGauceStatement(InsertSql1.toString());
						//System.out.println("strTaxnbr : " + strTaxnbr);
						gsmt1.setGauceDataRow(rows1[j]);

						for(int k=1;k<=36;k++) {
							gsmt1.bindColumn(k, idx1[k-1]);
						}
						
						gsmt1.executeUpdate();
						gsmt1.close();
						InsertSql1=null;
						taxseq = "";
					}//if
					
					if(rows1[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						
						strTaxnbr = rows1[j].getString(idx1[0]);
						
						UpdateSql1 = new StringBuffer();
						
						//지점, 사업장, 계산서일자, 발행구분, 과세, 귀속구분, 거래처, 사업자번호, 거래처 담당자, 거래처 Email, 대표자, 
						//적요, 전표접수번호, 상대계정, 전자발행구분, 원가, 신용카드
						UpdateSql1.append( " UPDATE ACCOUNT.ATTAXMST SET \n");
						UpdateSql1.append( " COCODE=?       \n");
						UpdateSql1.append( " ,DEPTCD=?      \n");
						UpdateSql1.append( " ,EMPNO=?       \n");
						UpdateSql1.append( " ,TAXIODIV=?    \n");
						UpdateSql1.append( " ,TAXDIV=?      \n");
						UpdateSql1.append( " ,TAXKND=?      \n");
						UpdateSql1.append( " ,VEND_CD=?     \n");
						UpdateSql1.append( " ,TAXDAT=?      \n");
						UpdateSql1.append( " ,TAXSUM=?      \n");
						UpdateSql1.append( " ,TAXVATAMT=?   \n");
						UpdateSql1.append( " ,TAXTOT=?      \n");
						UpdateSql1.append( " ,REMARK=?      \n");
						UpdateSql1.append( " ,TAXCDNBR=?    \n");
						UpdateSql1.append( " ,ATCODE=?      \n");
						
						UpdateSql1.append( " ,FSDAT=?       \n");
						UpdateSql1.append( " ,FSNBR=?       \n");
						UpdateSql1.append( " ,TAXKIDIV=?    \n");
						UpdateSql1.append( " ,FDCODE=?      \n");
						
						UpdateSql1.append( " ,SEQ=?         \n");
						UpdateSql1.append( " ,GUBUN=?       \n");
						UpdateSql1.append( " ,EXTCHK=?      \n");
						UpdateSql1.append( " ,COSTCD=?      \n");
						UpdateSql1.append( " ,B_BIZPLACE=?  \n");
						UpdateSql1.append( " ,S_BIZPLACE=?  \n");
						UpdateSql1.append( " ,REMARK3=?  \n");
						UpdateSql1.append( " ,UPDT=?        \n");
						UpdateSql1.append( " ,UPID=?        \n");
						UpdateSql1.append( " WHERE TAXNBR=? \n");
																		
						GauceStatement gsmt1 = conn.getGauceStatement(UpdateSql1.toString());
						gsmt1.setGauceDataRow(rows1[j]);
					
						for(int k=1;k<=14;k++) {
							gsmt1.bindColumn(k, idx1[k]);
						}
												
						for(int k=15;k<=18;k++) {
							gsmt1.bindColumn(k, idx1[k+4]);
						}
						
						gsmt1.bindColumn(19, idx1[26]);
						gsmt1.bindColumn(20, idx1[27]);
						gsmt1.bindColumn(21, idx1[30]);
						gsmt1.bindColumn(22, idx1[32]);
						gsmt1.bindColumn(23, idx1[33]);
						gsmt1.bindColumn(24, idx1[34]);
						gsmt1.bindColumn(25, idx1[35]);
						
						gsmt1.bindColumn(26, idx1[36]);
						gsmt1.bindColumn(27, idx1[37]);
						gsmt1.bindColumn(28, idx1[0]);
						
						gsmt1.executeUpdate(); 
						gsmt1.close();         
					}
										
					if(rows1[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql1 = new StringBuffer();
						
						DeleteSql1.append( " DELETE FROM ACCOUNT.ATTAXMST \n");
						DeleteSql1.append( "  WHERE TAXNBR = ?            \n");
						
						GauceStatement gsmt1 = conn.getGauceStatement(DeleteSql1.toString());
						gsmt1.setGauceDataRow(rows1[j]);
						
						gsmt1.bindColumn(1, idx1[0]);
						
						gsmt1.executeUpdate();
						gsmt1.close();
					}
				}//for
					
				//매입상세 
				for (int j = 0; j < rows2.length; j++){
					if(rows2[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {	
					
						/*******************************************************************
								매입 Detail
						********************************************************************/
						
						StringBuffer sql2 = new StringBuffer();
						
						sql2.append(" SELECT LPAD(TO_NUMBER(NVL(MAX(TAXSEQ),0)+1),3,'0')  \n");
						sql2.append(" 	FROM ACCOUNT.ATTAXDTL	   			              \n");
						sql2.append("  WHERE TAXNBR = '"+strTaxnbr+"'			          \n");
						
						System.out.println("sql2 : " + sql2.toString());		
						
						stmt2 = conn.createStatement();
						rs2 = stmt2.executeQuery(sql2.toString());

						while(rs2.next()) {
							taxseq = rs2.getString(1);
						}
						rs2.close();
						stmt2.close();
						
						//System.out.println("taxseq : " + taxseq);
												
						rows2[j].setString(idx2[0],strTaxnbr);  //TAXNBR
						rows2[j].setString(idx2[1],taxseq);     //TAXSEQ
												
						InsertSql2 = new StringBuffer();
						InsertSql2.append( " INSERT INTO ACCOUNT.ATTAXDTL (				\n");
						InsertSql2.append( " TAXNBR,TAXSEQ,TAXPDTNAM,TAXSTD,TAXQTY,	    \n");
						InsertSql2.append( " TAXPRIC,TAXSUM,TAXVATAMT,BIGO,				\n");
						InsertSql2.append( " WRDT,WRID									\n");
						InsertSql2.append( " ) VALUES(									\n");
						InsertSql2.append( " ?,?,?,?,?,	                            	\n");
						InsertSql2.append( " ?,?,?,?,					  			    \n");
						InsertSql2.append( " ?,? )	  				                    \n");

						//System.out.println("a040001_t4_ee# Query : \n" + InsertSql);								
						
						GauceStatement gsmt2 = conn.getGauceStatement(InsertSql2.toString());
						gsmt2.setGauceDataRow(rows2[j]);

						for(int k=1;k<=11;k++) {
							gsmt2.bindColumn(k, idx2[k-1]);
						}
						
						gsmt2.executeUpdate();
						gsmt2.close();
						InsertSql2=null;
						
					} //if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) 

					if(rows2[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
							
						UpdateSql2 = new StringBuffer();
						UpdateSql2.append( " UPDATE ACCOUNT.ATTAXDTL SET \n");
						UpdateSql2.append( "        TAXPDTNAM=? \n");
						UpdateSql2.append( "       ,TAXSTD=?    \n");
						UpdateSql2.append( "       ,TAXQTY=?    \n");
						UpdateSql2.append( "       ,TAXPRIC=?   \n");
						UpdateSql2.append( "       ,TAXSUM=?    \n");
						UpdateSql2.append( "       ,TAXVATAMT=? \n");
						UpdateSql2.append( "       ,UPDT=?      \n");
						UpdateSql2.append( "       ,UPID=?      \n");
						UpdateSql2.append( "  WHERE TAXNBR = ?  \n");
						UpdateSql2.append( "    AND TAXSEQ = ?  \n");
												
						GauceStatement gsmt2 = conn.getGauceStatement(UpdateSql2.toString());
						gsmt2.setGauceDataRow(rows2[j]);
						
						
						for(int k=1;k<=6;k++) {
							gsmt2.bindColumn(k, idx2[k+1]);
						}
						
						gsmt2.bindColumn(7, idx2[11]);
						gsmt2.bindColumn(8, idx2[12]);
						gsmt2.bindColumn(9, idx2[0]);
						gsmt2.bindColumn(10,idx2[1]);
						
						gsmt2.executeUpdate(); 
						gsmt2.close();         
					 }
											
					 if(rows2[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql2 = new StringBuffer();
						DeleteSql2.append( " DELETE FROM ACCOUNT.ATTAXDTL  \n");
						DeleteSql2.append( "  WHERE TAXNBR = ?  \n");
						DeleteSql2.append( "    AND TAXSEQ = ?  \n");
						
						GauceStatement gsmt2 = conn.getGauceStatement(DeleteSql2.toString());
						gsmt2.setGauceDataRow(rows2[j]);
						
						gsmt2.bindColumn(1, idx2[0]);
						gsmt2.bindColumn(2, idx2[1]);
						
						gsmt2.executeUpdate();
						gsmt2.close();
					 }
				}//for (int j = 0; j < rows.length; j++){
		 	
				/************************************************************************************
			 	@ 계산서 번호 UPDATE 
				*************************************************************************************/
				for (int k = 0; k < rows3.length; k++){
					if(rows3[k].getJobType() == GauceDataRow.TB_JOB_INSERT) {
								
						rows3[k].setString(idx3[1],strTaxnbr);
						
						UpdateSql3 = new StringBuffer();
						
						//지점, 사업장, 계산서일자, 발행구분, 과세, 귀속구분, 거래처, 사업자번호, 거래처 담당자, 거래처 Email, 대표자, 
						//적요, 전표접수번호, 상대계정, 전자발행구분, 원가, 신용카드
						UpdateSql3.append( " UPDATE ACCOUNT.ACAPPFUND SET \n");
						UpdateSql3.append( " TAXNBR=?       \n");
						UpdateSql3.append( " ,UPDT=?        \n");
						UpdateSql3.append( " ,UPID=?        \n");
						UpdateSql3.append( " WHERE APPNO=?  \n");
																		
						GauceStatement gsmt3 = conn.getGauceStatement(UpdateSql3.toString());
						gsmt3.setGauceDataRow(rows3[k]);
						
						gsmt3.bindColumn(1, idx3[1]);	
						gsmt3.bindColumn(2, idx3[2]);
						gsmt3.bindColumn(3, idx3[3]);
						gsmt3.bindColumn(4, idx3[0]);
						
						gsmt3.executeUpdate(); 
						gsmt3.close();         

					}//if
					
				
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
