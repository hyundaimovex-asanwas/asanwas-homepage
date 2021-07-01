package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a020001_t2f extends HttpServlet{
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
			String strFdcode="";
			String strFsdat="";
			String strFsnbr="";
			String strAcnnbr="";

			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

		        /************************************************************************************
		         @ 전표 Master // 전표 DETAIL // 전표관리항목 // TAXMST //TAXDTL //일반증빙
				*************************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				if (userSet != null) {
					int idxFDCODE       = userSet.indexOfColumn("FDCODE");  
					int idxFSDAT        = userSet.indexOfColumn("FSDAT");   
					int idxFSNBR        = userSet.indexOfColumn("FSNBR");   
					int idxFSKND        = userSet.indexOfColumn("FSKND");   // 전표종류

					//logger.dbg.println(this,"DELETE_STEP1");
					
					GauceDataRow[] rows = userSet.getDataRows();
					
					StringBuffer DeleteSql_MST = null;
					StringBuffer DeleteSql_DTL = null;
					StringBuffer DeleteSql_REF = null;
					StringBuffer DeleteTAX_MST = null;
					StringBuffer DeleteTAX_DTL = null;
					StringBuffer UpdateTAX_MST = null;
					StringBuffer DeleteSql_GENRST = null;
					
					StringBuffer UpdateAPPFUND_A = null;
					StringBuffer UpdateAPPFUND_P = null;
					
					DeleteSql_MST = new StringBuffer();
					DeleteSql_DTL = new StringBuffer();
					DeleteSql_REF = new StringBuffer();
					DeleteTAX_MST = new StringBuffer();
					DeleteTAX_DTL = new StringBuffer();
					UpdateTAX_MST = new StringBuffer();
					DeleteSql_GENRST = new StringBuffer();
					UpdateAPPFUND_A = new StringBuffer();
					UpdateAPPFUND_P = new StringBuffer();
					
					
					DeleteSql_MST.append( " DELETE FROM  ACCOUNT.FSLIPMST   " );
					DeleteSql_MST.append( "  WHERE FDCODE = ? " );
					DeleteSql_MST.append( "    AND FSDAT = ? " );
					DeleteSql_MST.append( "    AND FSNBR = ? " );

					DeleteSql_DTL.append( " DELETE FROM  ACCOUNT.FSLIPDTL  " );
					DeleteSql_DTL.append( "  WHERE FDCODE = ? " );
					DeleteSql_DTL.append( "    AND FSDAT = ? " );
					DeleteSql_DTL.append( "    AND FSNBR = ? " );

					
					DeleteSql_REF.append( " DELETE FROM  ACCOUNT.FSLIPREF  " );
					DeleteSql_REF.append( "  WHERE FDCODE = ? " );
					DeleteSql_REF.append( "    AND FSDAT = ? " );
					DeleteSql_REF.append( "    AND FSNBR = ? " );

		
					UpdateTAX_MST.append( " UPDATE ACCOUNT.ATTAXMST SET " );
					////UpdateTAX_MST.append( "        FDCODE = '', " );
					UpdateTAX_MST.append( "        FSDAT = '', " );
					UpdateTAX_MST.append( "        FSNBR = '' " );
					UpdateTAX_MST.append( "  WHERE FDCODE = ? " );
					UpdateTAX_MST.append( "    AND FSDAT = ? " );
					UpdateTAX_MST.append( "    AND FSNBR = ? " );

		
					DeleteSql_GENRST.append( " DELETE FROM  ACCOUNT.GENRST  " );
					DeleteSql_GENRST.append( "  WHERE FDCODE = ? " );
					DeleteSql_GENRST.append( "    AND FSDAT = ? " );
					DeleteSql_GENRST.append( "    AND FSNBR = ? " );
					
					//자금신청 전표 
					UpdateAPPFUND_A.append( " UPDATE ACCOUNT.ACAPPFUND SET \n" );
					UpdateAPPFUND_A.append( "        APPFSDAT = '', \n" );
					UpdateAPPFUND_A.append( "        APPFSNBR = ''  \n" );
					UpdateAPPFUND_A.append( "  WHERE FDCODE = ?     \n" );
					UpdateAPPFUND_A.append( "    AND APPFSDAT = ?   \n" );
					UpdateAPPFUND_A.append( "    AND APPFSNBR = ?   \n" );
					
					//자금지급전표
					UpdateAPPFUND_P.append( " UPDATE ACCOUNT.ACAPPFUND SET \n" );
					UpdateAPPFUND_P.append( "        APPFSDAT = '', \n" );
					UpdateAPPFUND_P.append( "        APPFSNBR = ''  \n" );
					UpdateAPPFUND_P.append( "  WHERE FDCODE = ?     \n" );
					UpdateAPPFUND_P.append( "    AND APPFSDAT = ?   \n" );
					UpdateAPPFUND_P.append( "    AND APPFSNBR = ?   \n" );
                    
	 
					//logger.dbg.println(this,"DeleteSql"+DeleteSql_GENRST.toString());
					//logger.dbg.println(this,"rows"+rows.length);
					for (int j=0;j<rows.length; j++){
						// 	logger.dbg.println(this,"test");
							strFdcode = rows[j].getString(idxFDCODE);
							strFsdat  = rows[j].getString(idxFSDAT);
							strFsnbr  = rows[j].getString(idxFSNBR);
						//	logger.dbg.println(this,"strFdcode::"+strFdcode+"::strFsdat::"+strFsdat+"::strFsnbr::"+strFsnbr);
							GauceStatement gsmt = conn.getGauceStatement(DeleteSql_MST.toString());
							gsmt.setGauceDataRow(rows[j]);
						
							gsmt.bindColumn(1, idxFDCODE);
							gsmt.bindColumn(2, idxFSDAT);
							gsmt.bindColumn(3, idxFSNBR);
							
							gsmt.executeUpdate();
							gsmt.close();
							 
							/***계산서 테이블 및 로직 변경으로 막음
							//DETAIL의 건수 만큼 돌려서 계산서 번호를 찾아내어 존재하면 계산서 delete 시킴
							StringBuffer sql = new StringBuffer();
							Statement stmt = null;
							ResultSet rs = null;
							sql.append( " SELECT COALESCE(ACNNBR,'')					");
							sql.append( "   FROM ACCOUNT.FSLIPDTL     	 ");
							sql.append( "  WHERE FDCODE ='"+strFdcode+"' ");
							sql.append( "    AND FSDAT ='"+strFsdat+"' ");
							sql.append( "    AND FSNBR ='"+strFsnbr+"' ");
							
							stmt = conn.createStatement();
							rs = stmt.executeQuery(sql.toString());

							while(rs.next())	{
								strAcnnbr = rs.getString(1);
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
								}
							}
							*******************/
							//계산서에서 전표번호만 없앰
							GauceStatement gsmt12 = conn.getGauceStatement(UpdateTAX_MST.toString());
							gsmt12.setGauceDataRow(rows[j]);
						
							gsmt12.bindColumn(1, idxFDCODE);
							gsmt12.bindColumn(2, idxFSDAT);
							gsmt12.bindColumn(3, idxFSNBR);
							
							gsmt12.executeUpdate();
							gsmt12.close();

							 
							//전표Detail
							GauceStatement gsmt13 = conn.getGauceStatement(DeleteSql_DTL.toString());
							gsmt13.setGauceDataRow(rows[j]);
						
							gsmt13.bindColumn(1, idxFDCODE);
							gsmt13.bindColumn(2, idxFSDAT);
							gsmt13.bindColumn(3, idxFSNBR);
							
							gsmt13.executeUpdate();
							gsmt13.close();

							//전표관리항목
							GauceStatement gsmt14 = conn.getGauceStatement(DeleteSql_REF.toString());
							gsmt14.setGauceDataRow(rows[j]);
						
							gsmt14.bindColumn(1, idxFDCODE);
							gsmt14.bindColumn(2, idxFSDAT);
							gsmt14.bindColumn(3, idxFSNBR);
							
							gsmt14.executeUpdate();
							gsmt14.close();
							 
							//logger.dbg.println(this,"DELETE_STEP2");
					

						    //일반증빙
							GauceStatement gsmt15 = conn.getGauceStatement(DeleteSql_GENRST.toString());
							gsmt15.setGauceDataRow(rows[j]);
						
							gsmt15.bindColumn(1, idxFDCODE);
							gsmt15.bindColumn(2, idxFSDAT);
							gsmt15.bindColumn(3, idxFSNBR);
							
							gsmt15.executeUpdate();
							gsmt15.close();
							
							
							if(rows[j].getString(idxFSKND).equals("A")){ // 자금신청전표
								GauceStatement gsmt16 = conn.getGauceStatement(UpdateAPPFUND_A.toString());
								gsmt16.setGauceDataRow(rows[j]);
							
								gsmt16.bindColumn(1, idxFDCODE);
								gsmt16.bindColumn(2, idxFSDAT);
								gsmt16.bindColumn(3, idxFSNBR);
								
								gsmt16.executeUpdate();
								gsmt16.close();
								
							}else if(rows[j].getString(idxFSKND).equals("P")){ // 자금지급전표
								GauceStatement gsmt17 = conn.getGauceStatement(UpdateAPPFUND_P.toString());
								gsmt17.setGauceDataRow(rows[j]);
							
								gsmt17.bindColumn(1, idxFDCODE);
								gsmt17.bindColumn(2, idxFSDAT);
								gsmt17.bindColumn(3, idxFSNBR);
								
								gsmt17.executeUpdate();
								gsmt17.close();
							}

							//logger.dbg.println(this,"DELETE_STEP3");
					} //for
				}

			/************************************************************************************
			@ 예산 - 계정과목 전체 삭제 start
			*************************************************************************************/
	 	// logger.dbg.println(this,"예산계정과목삭제");
		 
		 GauceDataSet userSet22 = reqGauce.getGauceDataSet("USER22");
		 if (userSet22 != null) {
			  String strBgtyy="";
				double dblYYBresults=0;
				double dblMMBresults=0;
				double dblchaamt=0;
				double dblamt=0;

				int idx22BGTYY           = userSet22.indexOfColumn("BGTYY");  
				int idx22BGTMM           = userSet22.indexOfColumn("BGTMM");  
				int idx22BGTDIV          = userSet22.indexOfColumn("BGTDIV");  
				int idx22BGTDPT          = userSet22.indexOfColumn("BGTDPT");  
				int idx22ATCODE          = userSet22.indexOfColumn("ATCODE");  
				int idx22FSREFCD         = userSet22.indexOfColumn("FSREFCD");  
				int idx22SATCODE         = userSet22.indexOfColumn("SATCODE");  
				int idx22BGTMACT         = userSet22.indexOfColumn("BGTMACT");  
				int idx22CHAAMT          = userSet22.indexOfColumn("CHAAMT");  
			
				//예산총계정원장
				int idx22FDCODE          = userSet22.indexOfColumn("FDCODE");  
				int idx22ACTDAT          = userSet22.indexOfColumn("ACTDAT");  
				//int idx22ATCODE          = userSet10.indexOfColumn("ATCODE");  
				int idx22COCODE          = userSet22.indexOfColumn("COCODE");  
				int idx22FSDAT           = userSet22.indexOfColumn("FSDAT");  
				int idx22FSNBR           = userSet22.indexOfColumn("FSNBR");  
				int idx22FSSEQ           = userSet22.indexOfColumn("FSSEQ");  

				/// logger.dbg.println(this,"삭제-STEP1"); 

				//변경전 예산관리항목원장
				String [] str224FSREFCD = new String []{"FSREFCD01","FSREFCD02","FSREFCD03","FSREFCD04","FSREFCD05",  
				                                       "FSREFCD06","FSREFCD07","FSREFCD08","FSREFCD09"}; 

				String [] str224FSREFVAL = new String []{"FSREFVAL01","FSREFVAL02","FSREFVAL03","FSREFVAL04","FSREFVAL05",  
				                                        "FSREFVAL06","FSREFVAL07","FSREFVAL08","FSREFVAL09"}; 

				int [] idx224FSREFCD = new int[9];
				for (int i=0;i<str224FSREFCD.length;i++){
					idx224FSREFCD[i] = userSet22.indexOfColumn(str224FSREFCD[i]);
				}

				int [] idx224FSREFVAL = new int[9];
				for (int i=0;i<str224FSREFVAL.length;i++){
					idx224FSREFVAL[i] = userSet22.indexOfColumn(str224FSREFVAL[i]);
				}

				GauceDataRow[] rows22 = userSet22.getDataRows();

				StringBuffer UpdateSql22 = null;
				StringBuffer UpdateSql22_2 = null;
				StringBuffer DeleteSql22_3 = null;
				StringBuffer DeleteSql22_4 = null;
				UpdateSql22 = new StringBuffer();
				UpdateSql22_2 = new StringBuffer();
				DeleteSql22_3 = new StringBuffer();
				DeleteSql22_4 = new StringBuffer();

				UpdateSql22.append( " UPDATE ACCOUNT.BGTMST SET  " );
				UpdateSql22.append( "        BRESULTS = ? " );
				UpdateSql22.append( " WHERE BGTYY = ? ");
				UpdateSql22.append( "	  AND BGTDIV =? ");
				UpdateSql22.append( "   AND BGTDPT =? ");
				UpdateSql22.append( "   AND ATCODE =? ");
				UpdateSql22.append( "   AND FSREFCD = ?");
				UpdateSql22.append( "	  AND SATCODE = ?");
				//UpdateSql22.append( "	  AND BGTMACT = ?");

				UpdateSql22_2.append( " UPDATE ACCOUNT.BGTDTL SET  " );
				UpdateSql22_2.append( "        BRESULTS = ? " );
				UpdateSql22_2.append( "  WHERE BGTYY = ? ");
				UpdateSql22_2.append( "	   AND BGTMM =? ");
				UpdateSql22_2.append( "	   AND BGTDIV =? ");
				UpdateSql22_2.append( "    AND BGTDPT =? ");
				UpdateSql22_2.append( "    AND ATCODE =? ");
				UpdateSql22_2.append( "    AND FSREFCD = ?");
				UpdateSql22_2.append( "	   AND SATCODE = ?");
				//UpdateSql22_2.append( "	   AND BGTMACT = ?");

				//예산총계정원장(미승인실적)
				//변경전 DELETE
				DeleteSql22_3.append( " DELETE FROM  ACCOUNT.BGTGELED  " );
				DeleteSql22_3.append( "  WHERE FDCODE = ? " );
				DeleteSql22_3.append( "    AND ACTDAT = ? " );
				DeleteSql22_3.append( "    AND ATCODE = ? " );
				DeleteSql22_3.append( "    AND COCODE = ? " );
				DeleteSql22_3.append( "    AND FSDAT  = ? " );
				DeleteSql22_3.append( "    AND FSNBR  = ? " );
				DeleteSql22_3.append( "    AND FSSEQ  = ? " );
        
				//예산관리항목원장(미승인실적)
				//변경 전 DELETE
				DeleteSql22_4.append( " DELETE FROM  ACCOUNT.BGTGEREF  " );
				DeleteSql22_4.append( "  WHERE FDCODE = ? " );
				DeleteSql22_4.append( "    AND FSDAT = ? " );
				DeleteSql22_4.append( "    AND FSNBR = ? " );
				DeleteSql22_4.append( "    AND FSSEQ = ? " );
				DeleteSql22_4.append( "    AND FSREFCD = ? " );
				DeleteSql22_4.append( "    AND FSREFVAL = ? " );

				for (int b=0;b<rows22.length;b++){

					dblYYBresults=0;
					dblMMBresults=0;
					dblchaamt=0;
					dblamt=0;
					dblchaamt=rows22[b].getDouble(idx22CHAAMT);
					Statement stmt22_1 = conn.createStatement();
					///년별예산
					String sql22_1 = " SELECT BRESULTS FROM ACCOUNT.BGTMST "
										    	+ "	  WHERE BGTYY ='"+rows22[b].getString(idx22BGTYY)+"'"
												+ "	    AND BGTDIV ='"+rows22[b].getString(idx22BGTDIV)+"'"
												+ "	    AND BGTDPT ='"+rows22[b].getString(idx22BGTDPT)+"'"
												+ "	    AND ATCODE ='"+rows22[b].getString(idx22ATCODE)+"'"
												+ "	    AND FSREFCD ='"+rows22[b].getString(idx22FSREFCD)+"'"
												+ "	    AND SATCODE ='"+rows22[b].getString(idx22SATCODE)+"'";
											 // + "	    AND BGTMACT ='"+rows22[b].getString(idx22BGTMACT)+"'";

					/// logger.dbg.println(this,"sql22_1::"+sql22_1);
       
					ResultSet rs22_1 = stmt22_1.executeQuery(sql22_1); 

					if(rs22_1.next()){
						 dblYYBresults= rs22_1.getDouble(1);
					}else{
						 dblYYBresults=0;
					}

					//미승인 금액 = 기존 미승인 금액 - 삭제 금액 
					dblamt = dblYYBresults - dblchaamt;
					rows22[b].setDouble(idx22CHAAMT,dblamt);
					///logger.dbg.println(this,"dblamt"+dblamt);

					GauceStatement gsmt22 = conn.getGauceStatement(UpdateSql22.toString());
					gsmt22.setGauceDataRow(rows22[b]);
        	
					gsmt22.bindColumn(1,idx22CHAAMT);
					gsmt22.bindColumn(2,idx22BGTYY);
					gsmt22.bindColumn(3,idx22BGTDIV);
					gsmt22.bindColumn(4,idx22BGTDPT);
					gsmt22.bindColumn(5,idx22ATCODE);
					gsmt22.bindColumn(6,idx22FSREFCD);
					gsmt22.bindColumn(7,idx22SATCODE);
					//gsmt22.bindColumn(8,idx22BGTMACT);
				
					gsmt22.executeUpdate();
					gsmt22.close();

					///월별예산
					dblamt=0;
					Statement stmt22_2 = conn.createStatement();
					String sql22_2 = " SELECT BRESULTS FROM ACCOUNT.BGTDTL "
										    + "	 WHERE BGTYY ='"+rows22[b].getString(idx22BGTYY)+"'"
										    + "	   AND BGTMM ='"+rows22[b].getString(idx22BGTMM)+"'"
												+ "	   AND BGTDIV ='"+rows22[b].getString(idx22BGTDIV)+"'"
												+ "	   AND BGTDPT ='"+rows22[b].getString(idx22BGTDPT)+"'"
												+ "	   AND ATCODE ='"+rows22[b].getString(idx22ATCODE)+"'"
												+ "	   AND FSREFCD ='"+rows22[b].getString(idx22FSREFCD)+"'"
												+ "	   AND SATCODE ='"+rows22[b].getString(idx22SATCODE)+"'";
												//+ "	   AND BGTMACT ='"+rows22[b].getString(idx22BGTMACT)+"'";
		
					///logger.dbg.println(this,"sql22_2::"+sql22_2);
					ResultSet rs22_2 = stmt22_2.executeQuery(sql22_2); 
					
					if(rs22_2.next()){
						 dblMMBresults= rs22_2.getDouble(1);
					}else{
						 dblMMBresults=0;
					}

					//미승인 금액 = 기존 미승인 금액 + 삭제 금액
					dblamt = dblMMBresults - dblchaamt;
					rows22[b].setDouble(idx22CHAAMT,dblamt);
					///	logger.dbg.println(this,"33dblamt"+dblamt);
					
					GauceStatement gsmt22_2 = conn.getGauceStatement(UpdateSql22_2.toString());
					gsmt22_2.setGauceDataRow(rows22[b]);
        					 
					gsmt22_2.bindColumn(1,idx22CHAAMT);
					gsmt22_2.bindColumn(2,idx22BGTYY);
					gsmt22_2.bindColumn(3,idx22BGTMM);
					gsmt22_2.bindColumn(4,idx22BGTDIV);
					gsmt22_2.bindColumn(5,idx22BGTDPT);
					gsmt22_2.bindColumn(6,idx22ATCODE);
					gsmt22_2.bindColumn(7,idx22FSREFCD);
					gsmt22_2.bindColumn(8,idx22SATCODE);
					//gsmt22_2.bindColumn(9,idx22BGTMACT);
				
					gsmt22_2.executeUpdate();
					gsmt22_2.close();

					///	logger.dbg.println(this,"DeleteSql22_3::"+DeleteSql22_3.toString());
					GauceStatement gsmt22_3 = conn.getGauceStatement(DeleteSql22_3.toString());
					gsmt22_3.setGauceDataRow(rows22[b]);
					gsmt22_3.bindColumn(1,idx22FDCODE);
					gsmt22_3.bindColumn(2,idx22ACTDAT);
					gsmt22_3.bindColumn(3,idx22ATCODE);
					gsmt22_3.bindColumn(4,idx22COCODE);
					gsmt22_3.bindColumn(5,idx22FSDAT);
					gsmt22_3.bindColumn(6,idx22FSNBR);
					gsmt22_3.bindColumn(7,idx22FSSEQ);

					gsmt22_3.executeUpdate();
					gsmt22_3.close();

					for (int i=0;i<=8;i++){
						if(!rows22[b].getString(idx224FSREFVAL[i]).equals("")){
							///logger.dbg.println(this,"DeleteSql22_4::"+DeleteSql22_4.toString());
							GauceStatement gsmt22_4 = conn.getGauceStatement(DeleteSql22_4.toString());
							gsmt22_4.setGauceDataRow(rows22[b]);
							gsmt22_4.bindColumn(1,idx22FDCODE);
							gsmt22_4.bindColumn(2,idx22FSDAT);
							gsmt22_4.bindColumn(3,idx22FSNBR);
							gsmt22_4.bindColumn(4,idx22FSSEQ);
							gsmt22_4.bindColumn(5,idx224FSREFCD[i]);
							gsmt22_4.bindColumn(6,idx224FSREFVAL[i]);
							gsmt22_4.executeUpdate();
							gsmt22_4.close();
						}//if
					}//for i
				}//for b
		 }
				
			/************************************************************************************
			 @ 예산 - 계정과목 삭제 end
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
			logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}