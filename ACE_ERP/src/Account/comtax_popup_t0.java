package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class comtax_popup_t0 extends HttpServlet{
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

			String strTaxnbr=""; 
      double g_dbltottaxvat=0; 


			try {
				conn = service.getDBConnection();
        conn.setAutoCommit(false); 
   
				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				String str[] = new String[7];

				str[0] = reqGauce.getParameter("v_str1");			//현재일자
				str[1] = reqGauce.getParameter("v_str2");			//계산서번호
				str[2] = reqGauce.getParameter("v_str3");			//처리자
				str[3] = reqGauce.getParameter("v_str4");			//지점코드
				str[4] = reqGauce.getParameter("v_str5");			//전표일자
				str[5] = reqGauce.getParameter("v_str6");			//전표번호
				str[6] = reqGauce.getParameter("v_str7");			//전표행번호

			/*	logger.dbg.println(this,"str[0]::" +str[0] );
				logger.dbg.println(this,"str[1]::" +str[1] );
				logger.dbg.println(this,"str[2]::" +str[2] );
				logger.dbg.println(this,"str[3]::" +str[3] );
				logger.dbg.println(this,"str[4]::" +str[4] );
				logger.dbg.println(this,"str[5]::" +str[5] );
				logger.dbg.println(this,"str[6]::" +str[6] );
			*/
        strTaxnbr = str[1];
        /*계산서 Master Start==================================================================*/
			
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				String[] StrArrCN = new String[] {
					"TAXNBR","COCODE","TAXIODIV","TAXDIV","TAXKND",
					"CCCODE","TAXDAT","TAXSUM","TAXVATAMT","TAXTOT",
					"REMARK","TAXCDNBR","FSDAT","FSNBR","TAXKIDIV",
					"FDCODE",	"WRDT","WRID","UPDT","UPID"
				};

				int[] idx = new int[20];
				for(int i=0;i<StrArrCN.length;i++) {
					idx[i] = userSet.indexOfColumn(StrArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();
				StringBuffer InsertSql  = null;
				StringBuffer UpdateSql  = null;
				StringBuffer DeleteSql  = null;
				StringBuffer UpdateSql_DTL = null;
				StringBuffer DeleteSql_DTL = null;
				StringBuffer UpdateSql_DTL2 = null;

				Statement stmt = null;
				ResultSet rs = null;
				
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

              //계산서 번호 생성
							String taxch = rows[j].getString(idx[0]);
							StringBuffer sql = new StringBuffer();
							sql.append( " SELECT CAST(MAX(TAXNBR) AS INTEGER)+1 CNT					");
							sql.append( " FROM ACCOUNT.ATTAXMST															");
							sql.append( " WHERE SUBSTR(TAXNBR,1,4) = SUBSTR('"+str[0]+"',1,4) ");
							stmt = conn.createStatement();
							rs = stmt.executeQuery(sql.toString());

							while(rs.next())	{
								taxch = rs.getInt(1) + "";
							}
            //logger.dbg.println(this,sql.toString());
						if (taxch==null||taxch.length()<10) taxch = str[0].substring(0,6) + "0001";
						else taxch = taxch + "";
             
						strTaxnbr = taxch;
						
						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO ACCOUNT.ATTAXMST ( ");
						InsertSql.append( " TAXNBR,COCODE,TAXIODIV,TAXDIV,TAXKND, ");
						InsertSql.append( " CCCODE,TAXDAT,TAXSUM,TAXVATAMT,TAXTOT, ");
						InsertSql.append( " REMARK,TAXCDNBR,FSDAT,FSNBR,TAXKIDIV, ");
						InsertSql.append( " FDCODE,WRDT,WRID");
						InsertSql.append( " ) VALUES( " );
						InsertSql.append( " '"+taxch+"',?, ?, ?, ?, " );
						InsertSql.append( " ?, ?, ?, ?, ?, " );
						InsertSql.append( " ?, ?, ?, ?, ?, " );
						InsertSql.append( " ?, '"+str[0]+"', '"+str[2]+"' ) " );

           /// logger.dbg.println(this,"insert::::"+InsertSql.toString()); 
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
           /// logger.dbg.println(this,"step3");
						for(int k=1;k<=15;k++) {
							gsmt.bindColumn(k, idx[k]);
						}
					///	logger.dbg.println(this,"step4");
						gsmt.executeUpdate();
						gsmt.close();
						InsertSql=null;
						taxch = "";

            //전표 Detail에 세금계산서 번호 update
            UpdateSql_DTL = new StringBuffer();
						UpdateSql_DTL.append( " UPDATE ACCOUNT.FSLIPDTL SET																					");
						UpdateSql_DTL.append( " ACNNBR = '"+strTaxnbr+"',	                                          ");
						UpdateSql_DTL.append( " UPDT =  '"+str[0]+"',	  UPID =  '"+str[2]+"'		  						      ");
						UpdateSql_DTL.append( " WHERE FDCODE = '"+str[3]+"'																										");
						UpdateSql_DTL.append( "   AND FSDAT = '"+str[4]+"'																									  	");
						UpdateSql_DTL.append( "   AND FSNBR = '"+str[5]+"'																									  	");
						UpdateSql_DTL.append( "   AND FSSEQ = '"+str[6]+"'																									  	");
			      
						//logger.dbg.println(this,UpdateSql_DTL.toString());
						GauceStatement gsmt11 = conn.getGauceStatement(UpdateSql_DTL.toString());
						//gsmt11.setGauceDataRow(rows[j]);
          
						gsmt11.executeUpdate(); 
						gsmt11.close();      
						
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					//	logger.dbg.println(this,"step5");
						UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE ACCOUNT.ATTAXMST SET																					");
						UpdateSql.append( " COCODE = ?,		TAXIODIV = ?, TAXDIV = ?,			TAXKND = ?,   CCCODE = ?, ");
						UpdateSql.append( " TAXDAT = ?,		TAXSUM = ?,		TAXVATAMT = ?,	TAXTOT = ?,   REMARK = ?, ");
						UpdateSql.append( " TAXCDNBR = ?, FSDAT = ?,		FSNBR = ?,			TAXKIDIV = ?, FDCODE = ?,	");
						UpdateSql.append( " UPDT =  '"+str[0]+"',	  UPID =  '"+str[2]+"'		  						");
						UpdateSql.append( " WHERE TAXNBR = ?																										");
			
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
            ///logger.dbg.println(this,"step6");
						for(int s=1;s<=15;s++) {
							gsmt.bindColumn(s, idx[s]);
						}

						gsmt.bindColumn(16, idx[0]);
            ///logger.dbg.println(this,"step7");
						gsmt.executeUpdate(); 
						gsmt.close();         

					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();		/*세금계산서 MST*/
						DeleteSql.append( " DELETE FROM ACCOUNT.ATTAXMST WHERE TAXNBR = ? ");
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idx[0]);
						gsmt.executeUpdate();
						gsmt.close();

						DeleteSql_DTL = new StringBuffer();	/*세금계산서 DTL*/
						DeleteSql_DTL.append( " DELETE FROM ACCOUNT.ATTAXDTL WHERE TAXNBR = ? ");
						GauceStatement gsmt2 = conn.getGauceStatement(DeleteSql_DTL.toString());
						gsmt2.setGauceDataRow(rows[j]);
						gsmt2.bindColumn(1, idx[0]);
						gsmt2.executeUpdate();
						gsmt2.close();


            //전표 Detail에 세금계산서 번호 update
            UpdateSql_DTL2 = new StringBuffer();
						UpdateSql_DTL2.append( " UPDATE ACCOUNT.FSLIPDTL SET														");
						UpdateSql_DTL2.append( " ACNNBR = '',	                                          ");
						UpdateSql_DTL2.append( " UPDT =  '"+str[0]+"',	  UPID =  '"+str[2]+"'		  		");
						UpdateSql_DTL2.append( " WHERE FDCODE = '"+str[3]+"'																										");
						UpdateSql_DTL2.append( "   AND FSDAT = '"+str[4]+"'																									  	");
						UpdateSql_DTL2.append( "   AND FSNBR = '"+str[5]+"'																									  	");
						UpdateSql_DTL2.append( "   AND FSSEQ = '"+str[6]+"'																									  	");
			      
						//logger.dbg.println(this,UpdateSql_DTL2.toString());
						GauceStatement gsmt22 = conn.getGauceStatement(UpdateSql_DTL2.toString());
						//gsmt11.setGauceDataRow(rows[j]);
						gsmt22.executeUpdate(); 
						gsmt22.close();         
					}
				}//for 
				/*계산서 Master End==================================================================*/


        /*계산서 Detail Start==================================================================*/
				GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2");
        
				String[] StrArrCN2 = new String[] {
					"TAXNBR", "TAXSEQ","TAXPDTNAM","TAXSTD","TAXQTY",
					"TAXPRIC","TAXSUM","TAXVATAMT","BIGO",
					"WRDT","WRID","UPDT","UPID"
				};
        /// logger.dbg.println(this,"step1111");
				int[] idx2 = new int[13];
				for(int i=0;i<StrArrCN2.length;i++) {
					idx2[i] = userSet2.indexOfColumn(StrArrCN2[i]);
				}
        
				GauceDataRow[] rows2 = userSet2.getDataRows();
				StringBuffer InsertSql2  = null;
				StringBuffer UpdateSql2  = null;
				StringBuffer DeleteSql2  = null;

				Statement stmt2 = null;
				ResultSet rs2 = null;
				///logger.dbg.println(this,"rows2.length" +rows2.length);
				for (int k=0;k<rows2.length;k++){
					//logger.dbg.println(this,"k::"+k);
					if(rows2[k].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						 
              //Seq 번호 생성
							String seq ="";
							StringBuffer sql2 = new StringBuffer();
							sql2.append( " SELECT COALESCE(MAX(TAXSEQ),0)+1 SEQ					");
							sql2.append( " FROM ACCOUNT.ATTAXDTL 												");
							sql2.append( " WHERE TAXNBR = '"+strTaxnbr+"' ");

							stmt2 = conn.createStatement();
							rs2 = stmt2.executeQuery(sql2.toString());

							while(rs2.next())	{
								seq = rs2.getInt(1) + "";
							}

						if (seq.length()==1) seq = "00"+seq;
						else if (seq.length()==2) seq = "0"+seq;

						//logger.dbg.println(this,"seq.length()"+seq.length());
						InsertSql2 = new StringBuffer();
						InsertSql2.append( " INSERT INTO ACCOUNT.ATTAXDTL ( ");
						InsertSql2.append( " TAXNBR,TAXSEQ,TAXPDTNAM,TAXSTD,TAXQTY, ");
						InsertSql2.append( " TAXPRIC,TAXSUM,TAXVATAMT,BIGO, ");
						InsertSql2.append( " WRDT,WRID ");
						InsertSql2.append( " ) VALUES( " );
						InsertSql2.append( " '"+strTaxnbr+"','"+seq+"', ?, ?, ?, " );
						InsertSql2.append( " ?, ?, ?, ?, " );
						InsertSql2.append( "  '"+str[0]+"',  '"+str[2]+"') " );

           // logger.dbg.println(this,InsertSql2.toString());
						GauceStatement gsmt2 = conn.getGauceStatement(InsertSql2.toString());
						gsmt2.setGauceDataRow(rows2[k]);
    
						for(int s=1;s<=7;s++) {
							gsmt2.bindColumn(s,idx2[s+1]);
						}

						gsmt2.executeUpdate();
						gsmt2.close();
						InsertSql2=null;
						seq = "";
					} //insert

					if(rows2[k].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						
						UpdateSql2 = new StringBuffer();
						UpdateSql2.append( " UPDATE ACCOUNT.ATTAXDTL SET																					");
						UpdateSql2.append( " TAXPDTNAM = ?,		TAXSTD = ?, TAXQTY = ?,	TAXPRIC = ?, TAXSUM = ?,    ");
						UpdateSql2.append( " TAXVATAMT = ?,		BIGO = ?,		       ");
						UpdateSql2.append( " UPDT =  '"+str[0]+"',     UPID = '"+str[2]+"' ");
						UpdateSql2.append( " WHERE TAXNBR = ?							       ");
						UpdateSql2.append( "   AND TAXSEQ = ?							       ");
            
						GauceStatement gsmt2 = conn.getGauceStatement(UpdateSql2.toString());
						gsmt2.setGauceDataRow(rows2[k]);
           
						for(int s=1;s<=7;s++) {
							gsmt2.bindColumn(s,idx2[s+1]);
						}
						gsmt2.bindColumn(8, idx2[0]);
						gsmt2.bindColumn(9, idx2[1]);

						gsmt2.executeUpdate(); 
						gsmt2.close();         
					} //update
						
					if(rows2[k].getJobType() == GauceDataRow.TB_JOB_DELETE ){
						DeleteSql2 = new StringBuffer();	/*세금계산서 DTL*/
						DeleteSql2.append( " DELETE FROM ACCOUNT.ATTAXDTL  ");
						DeleteSql2.append( " WHERE TAXNBR = ? ");
						DeleteSql2.append( "   AND TAXSEQ = ? ");
						GauceStatement gsmt2 = conn.getGauceStatement(DeleteSql2.toString());
						gsmt2.setGauceDataRow(rows2[k]);
						gsmt2.bindColumn(1, idx2[0]);
						gsmt2.bindColumn(2, idx2[1]);
						gsmt2.executeUpdate();
						gsmt2.close();
					} //delete

				} //for k 

				/*세금계산서 Master 공급가액/부가세액/합계 update   Start   =========================*/

				 //금액///////////////////////////////////////////////////////////////////////////////
				  Statement stmt22 = null;
				  ResultSet rs22 = null;
					double dbltaxsum =0;
					double dbltaxvatamt =0;
					double dbltaxtot =0;
					StringBuffer sql22 = new StringBuffer();
					sql22.append( " SELECT SUM(TAXSUM)TAXSUM,SUM(TAXVATAMT)TAXVATAMT,SUM(TAXSUM)+SUM(TAXVATAMT) TAXTOT ");
					sql22.append( " FROM  ACCOUNT.ATTAXDTL 												");
					sql22.append( " WHERE TAXNBR = '"+strTaxnbr+"' ");

					stmt22 = conn.createStatement();
					rs22 = stmt22.executeQuery(sql22.toString());

					while(rs22.next())	{
						dbltaxsum = rs22.getDouble(1);
						dbltaxvatamt = rs22.getDouble(2);
						dbltaxtot = rs22.getDouble(3);
					}

					StringBuffer UpdateSql_MST22 = new StringBuffer();
					UpdateSql_MST22.append( " UPDATE ACCOUNT.ATTAXMST SET														");
					UpdateSql_MST22.append( " TAXSUM = "+dbltaxsum+",	                              ");
					UpdateSql_MST22.append( " TAXVATAMT = "+dbltaxvatamt+",	                        ");
					UpdateSql_MST22.append( " TAXTOT = "+dbltaxtot+",	                              ");
					UpdateSql_MST22.append( " UPDT =  '"+str[0]+"',	  UPID =  '"+str[2]+"'		  		");
					UpdateSql_MST22.append( " WHERE TAXNBR = '"+strTaxnbr+"'												");
					
					//logger.dbg.println(this,UpdateSql_DTL2.toString());
					GauceStatement gsmt22 = conn.getGauceStatement(UpdateSql_MST22.toString());
					//gsmt11.setGauceDataRow(rows[j]);
					gsmt22.executeUpdate(); 
					gsmt22.close();         
				/*세금계산서 Master 공급가액/부가세액/합계 update   End     =========================*/
				
			
				/*전표 Master 부가세액 update   Start================================================*/
				//부가세
					Statement stmt222 = null;
					ResultSet rs222 = null;
					double dbltottaxvat =0;
					
					StringBuffer sql222 = new StringBuffer();
					sql222.append( "  SELECT SUM(A.TAXVATAMT) TAXVATAMT ");
					sql222.append( "    FROM ACCOUNT.ATTAXDTL A, ACCOUNT.ATTAXMST B											");
					sql222.append( " WHERE A.TAXNBR=B.TAXNBR ");
					sql222.append( "   AND B.FDCODE = '"+str[3]+"' ");
					sql222.append( "   AND B.FSDAT = '"+str[4]+"'  ");
					sql222.append( "   AND B.FSNBR = '"+str[5]+"'  ");


         //logger.dbg.println(this,"sql222"+sql222.toString());
					stmt222 = conn.createStatement();
					rs222 = stmt222.executeQuery(sql222.toString());

					while(rs222.next())	{
						dbltottaxvat = rs222.getDouble(1);
					}
				
				  g_dbltottaxvat= dbltottaxvat;
				 //logger.dbg.println(this,"dbltottaxvat::"+dbltottaxvat);
					StringBuffer UpdateSql_MST222 = new StringBuffer();
					UpdateSql_MST222.append( " UPDATE ACCOUNT.FSLIPMST SET														");
					UpdateSql_MST222.append( " FSVAT = "+dbltottaxvat+",	                            ");
					UpdateSql_MST222.append( " UPDT =  '"+str[0]+"',	  UPID =  '"+str[2]+"'		  		");
					UpdateSql_MST222.append( " WHERE FDCODE = '"+str[3]+"'	  												");
					UpdateSql_MST222.append( "   AND FSDAT = '"+str[4]+"'		    									  	");
					UpdateSql_MST222.append( "   AND FSNBR = '"+str[5]+"'				                      ");

					///logger.dbg.println(this,"UpdateSql_MST222"+UpdateSql_MST222.toString());
					GauceStatement gsmt222 = conn.getGauceStatement(UpdateSql_MST222.toString());
					//gsmt11.setGauceDataRow(rows[j]);
					gsmt222.executeUpdate(); 
					gsmt222.close();         
				/*전표 Master 부가세액 update   End  ================================================*/
	
				
				//}//for k
				/*계산서 Detail End==================================================================*/

      
       /************************************************************************************
			 @ return값 : 신규 생성 및 수정된 계산서 번호
			  *************************************************************************************/
				GauceDataSet userSet3 = reqGauce.getGauceDataSet("USER3");
				if (userSet3 != null) {
					resGauce.enableFirstRow(userSet3);
					userSet3.addDataColumn(new GauceDataColumn("TAXNBR", GauceDataColumn.TB_STRING,10));
	
					StringBuffer sql3 = new StringBuffer();
					sql3.append( " SELECT DISTINCT TAXNBR ");
					sql3.append( "   FROM ACCOUNT.ATTAXMST     	 ");
					sql3.append( "  WHERE TAXNBR ='"+strTaxnbr+"' ");

					//logger.dbg.println(this,"sql3.toString()"+sql3.toString());
					GauceStatement gsmt3 = conn.getGauceStatement(sql3.toString());
					gsmt3.executeQuery(userSet3);
					userSet3.flush();
					gsmt3.close();
				}


			  /************************************************************************************
			 @ return값 : 부가세금액
			  *************************************************************************************/
				GauceDataSet userSet4 = reqGauce.getGauceDataSet("USER4");
				if (userSet4 != null) {
					resGauce.enableFirstRow(userSet4);
					userSet4.addDataColumn(new GauceDataColumn("FSVATAMT", GauceDataColumn.TB_DECIMAL));
	
	        GauceDataRow row4 = null;
	        row4 = userSet4.newDataRow();
					row4.addColumnValue(g_dbltottaxvat);
					userSet4.addDataRow(row4);
					
					userSet4.flush();
					
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