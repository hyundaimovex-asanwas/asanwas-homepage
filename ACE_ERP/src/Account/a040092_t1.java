package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a040092_t1 extends HttpServlet{
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

			String strSeq = "";
			String strVend_CD="";

			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);


				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				String str1 = reqGauce.getParameter("v_str1");  //사번 
				String str2 = reqGauce.getParameter("v_str2");  //일자 
				String strTaxnbr ="";
				String strTaxnbrgb ="";
				

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				int idxBS_ID  	        = userSet.indexOfColumn("BS_ID");
				int idxTAXNBR        	= userSet.indexOfColumn("TAXNBR");
				int idxCOCODE           = userSet.indexOfColumn("COCODE");
				int idxDEPTCD        	= userSet.indexOfColumn("DEPTCD");
				int idxEMPNO         	= userSet.indexOfColumn("EMPNO");
				int idxTAXIODIV      	= userSet.indexOfColumn("TAXIODIV");
				int idxTAXDIV        	= userSet.indexOfColumn("TAXDIV");
				int idxTAXKND        	= userSet.indexOfColumn("TAXKND");
				int idxVEND_CD          = userSet.indexOfColumn("VEND_CD");
				int idxTAXDAT        	= userSet.indexOfColumn("TAXDAT");
				int idxTAXSUM        	= userSet.indexOfColumn("TAXSUM");
				int idxTAXVATAMT        = userSet.indexOfColumn("TAXVATAMT");
				int idxTAXTOT        	= userSet.indexOfColumn("TAXTOT");
				int idxREMARK        	= userSet.indexOfColumn("REMARK");
				int idxTAXCDNBR    	    = userSet.indexOfColumn("TAXCDNBR");
				int idxATCODE        	= userSet.indexOfColumn("ATCODE");
				int idxTAXPRTYN    	    = userSet.indexOfColumn("TAXPRTYN");
				int idxTAXCNT        	= userSet.indexOfColumn("TAXCNT");
				int idxLASTPRT          = userSet.indexOfColumn("LASTPRT");
				int idxTAXTYPE       	= userSet.indexOfColumn("TAXTYPE");
				int idxFSDAT         	= userSet.indexOfColumn("FSDAT");
				int idxFSNBR         	= userSet.indexOfColumn("FSNBR");
				int idxTAXKIDIV      	= userSet.indexOfColumn("TAXKIDIV");
				int idxFDCODE        	= userSet.indexOfColumn("FDCODE");
				int idxWORKTYPE         = userSet.indexOfColumn("WORKTYPE");
				int idxREPORT        	= userSet.indexOfColumn("REPORT");
				int idxWRDT          	= userSet.indexOfColumn("WRDT");
				int idxWRID          	= userSet.indexOfColumn("WRID");
				int idxUPDT          	= userSet.indexOfColumn("UPDT");
				int idxUPID          	= userSet.indexOfColumn("UPID");
				int idxSSDAT         	= userSet.indexOfColumn("SSDAT");
				int idxSSNBR         	= userSet.indexOfColumn("SSNBR");
				int idxSEQ           	= userSet.indexOfColumn("SEQ");
				int idxGUBUN         	= userSet.indexOfColumn("GUBUN");
				int idxAMEND_CODE    	= userSet.indexOfColumn("AMEND_CODE");
				int idxAMEND_REMARK  	= userSet.indexOfColumn("AMEND_REMARK");
				int idxEXTCHK        	= userSet.indexOfColumn("EXTCHK");
				int idxREMARK2          = userSet.indexOfColumn("REMARK2");
				int idxREMARK3          = userSet.indexOfColumn("REMARK3");
				int idxS_BIZPLACE       = userSet.indexOfColumn("S_BIZPLACE");
				int idxB_BIZPLACE       = userSet.indexOfColumn("B_BIZPLACE");
				int idxTAXSEQ        	= userSet.indexOfColumn("TAXSEQ");
				int idxTAXPDTNAM        = userSet.indexOfColumn("TAXPDTNAM");
				int idxTAXSTD        	= userSet.indexOfColumn("TAXSTD");
				int idxTAXQTY        	= userSet.indexOfColumn("TAXQTY");
				int idxTAXPRIC   	  	= userSet.indexOfColumn("TAXPRIC");
				int idxBIGO          	= userSet.indexOfColumn("BIGO");
				int idxCOSTCD          	= userSet.indexOfColumn("COSTCD");
				
				
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer UpdateSql2 = null;
				StringBuffer InsertSql2 = null;
				
				GauceStatement gsmt =null;
				GauceStatement gsmt2 =null;

				InsertSql = new StringBuffer();
				
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.ATTAXMST (						");
				InsertSql.append( " TAXNBR,COCODE,DEPTCD,EMPNO,TAXIODIV,			");
				InsertSql.append( " TAXDIV,TAXKND,VEND_CD,TAXDAT,TAXSUM,			");
				InsertSql.append( " TAXVATAMT,TAXTOT,REMARK,TAXCDNBR,ATCODE,	");
				InsertSql.append( " TAXPRTYN,TAXCNT,LASTPRT,TAXTYPE,FSDAT,		");
				InsertSql.append( " FSNBR,TAXKIDIV,FDCODE,WORKTYPE,WRDT,WRID,	");
				InsertSql.append( " SEQ, GUBUN, AMEND_CODE, AMEND_REMARK, EXTCHK, 	");
				InsertSql.append( " REMARK2, REMARK3, S_BIZPLACE, COSTCD	");
				InsertSql.append( "	) VALUES( " );
				InsertSql.append( " ?, ?, ?, ?, ?, " );
				InsertSql.append( " ?, ?, ?, ?, ?, " );
				InsertSql.append( " ?, ?, ?, ?, ?, " );
				InsertSql.append( " ?, ?, ?, ?, ?, " );
				InsertSql.append( " ?, ?, ?, ?,  '"+str2+"','"+str1+"', " );
				InsertSql.append( " ?, ?, ?, ?, ?, " );
				InsertSql.append( " ?, ?, ?, ?) " );
				
								
				InsertSql2 = new StringBuffer();
				InsertSql2.append( " INSERT INTO ACCOUNT.ATTAXDTL (					    ");
				InsertSql2.append( " TAXNBR,TAXSEQ,TAXPDTNAM,TAXSTD,TAXQTY,	");
				InsertSql2.append( " TAXPRIC,TAXSUM,TAXVATAMT,BIGO,					    ");
				InsertSql2.append( " WRDT,WRID															");
				InsertSql2.append( ") VALUES( " );
				InsertSql2.append( " ?, ?, ?, ?, ?, " );
				InsertSql2.append( " ?, ?, ?, ?,  " );
				InsertSql2.append( " '"+str2+"','"+str1+"') " );
			
				
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE VNDUS.TBS010 SET  " );				
				UpdateSql.append( "  BS_TAXNO = ? " );
				UpdateSql.append( " ,BS_STS = 'Y' " );
				UpdateSql.append( " ,U_EMPNO = '"+str1+"'" );
				UpdateSql.append( " ,U_DATE = sysdate " );
				UpdateSql.append( "  WHERE  BS_ID = ? " );	
				
			
				
				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
			            						
						strTaxnbr ="";
						strTaxnbrgb =rows[j].getString(idxTAXIODIV)+rows[j].getString(idxTAXDAT).substring(0,6);
						
						
						//채번 
						Statement stmt0 = conn.createStatement();
						StringBuffer sql0 = new StringBuffer();
						
						//sql0.append( " SELECT RIGHT(CHAR(DIGITS(COALESCE(MAX(SUBSTR(TAXNBR,8,11)),0)+1)),4) "); 
						sql0.append( " SELECT LPAD(TO_NUMBER(NVL(MAX(SUBSTR(TAXNBR,8,11)),0))+1,4,0)	\n"); 						
						sql0.append( "	 FROM ACCOUNT.ATTAXMST  										\n");
						sql0.append( "  WHERE TAXNBR LIKE '"+strTaxnbrgb+"%' 							\n");
							  			
						ResultSet rs0 = stmt0.executeQuery(sql0.toString()); 
						if(rs0.next()){
							strTaxnbr= strTaxnbrgb+rs0.getString(1);
						}
						rs0.close();
						stmt0.close();

					    rows[j].setString(idxTAXNBR,strTaxnbr);

						gsmt = conn.getGauceStatement(InsertSql.toString());

						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,  idxTAXNBR       );
						gsmt.bindColumn(2,  idxCOCODE       );
						gsmt.bindColumn(3,  idxDEPTCD       );
						gsmt.bindColumn(4,  idxEMPNO        );
						gsmt.bindColumn(5,  idxTAXIODIV     );
						gsmt.bindColumn(6,  idxTAXDIV       );
						gsmt.bindColumn(7,  idxTAXKND       );
						gsmt.bindColumn(8,  idxVEND_CD      );
						gsmt.bindColumn(9,  idxTAXDAT       );
						gsmt.bindColumn(10,  idxTAXSUM       );
						gsmt.bindColumn(11,  idxTAXVATAMT    );
						gsmt.bindColumn(12,  idxTAXTOT       );
						gsmt.bindColumn(13,  idxREMARK       );
						gsmt.bindColumn(14,  idxTAXCDNBR     );
						gsmt.bindColumn(15,  idxATCODE       );
						gsmt.bindColumn(16,  idxTAXPRTYN     );
						gsmt.bindColumn(17,  idxTAXCNT       );
						gsmt.bindColumn(18,  idxLASTPRT      );
						gsmt.bindColumn(19,  idxTAXTYPE      );
						gsmt.bindColumn(20,  idxFSDAT        );
						gsmt.bindColumn(21,  idxFSNBR        );
						gsmt.bindColumn(22,  idxTAXKIDIV     );
						gsmt.bindColumn(23,  idxFDCODE       );
						gsmt.bindColumn(24,  idxWORKTYPE     );
						gsmt.bindColumn(25,  idxSEQ          );
						gsmt.bindColumn(26,  idxGUBUN        );
						gsmt.bindColumn(27,  idxAMEND_CODE   );
						gsmt.bindColumn(28,  idxAMEND_REMARK );
						gsmt.bindColumn(29,  idxEXTCHK       );
						gsmt.bindColumn(30,  idxREMARK2      );
						gsmt.bindColumn(31,  idxREMARK3      );
						gsmt.bindColumn(32,  idxS_BIZPLACE   );
						gsmt.bindColumn(33,  idxCOSTCD   );
						gsmt.executeUpdate();
						gsmt.close();
						
						gsmt= null;
						
						gsmt = conn.getGauceStatement(InsertSql2.toString());

						gsmt.setGauceDataRow(rows[j]);
						
						InsertSql2 = new StringBuffer();
						InsertSql2.append( " INSERT INTO ACCOUNT.ATTAXDTL (					    \n");
						InsertSql2.append( " TAXNBR,TAXSEQ,TAXPDTNAM,TAXSTD,TAXQTY,		\n");
						InsertSql2.append( " TAXPRIC,TAXSUM,TAXVATAMT,BIGO,					    \n");
						InsertSql2.append( " WRDT,WRID														\n");
						InsertSql2.append( ") VALUES( 															\n");
						InsertSql2.append( " ?, ?, ?, ?, ?, 														\n");
						InsertSql2.append( " ?, ?, ?, ?,  															\n");
						InsertSql2.append( " '"+str2+"','"+str1+"') 												\n");
						
						gsmt.bindColumn(1,  idxTAXNBR);
						gsmt.bindColumn(2,  idxTAXSEQ);
						gsmt.bindColumn(3,  idxTAXPDTNAM);
						gsmt.bindColumn(4,  idxTAXSTD);
						gsmt.bindColumn(5,  idxTAXQTY);
						gsmt.bindColumn(6,  idxTAXPRIC);
						gsmt.bindColumn(7,  idxTAXSUM);
						gsmt.bindColumn(8,  idxTAXVATAMT);
						gsmt.bindColumn(9,  idxBIGO);
						
						gsmt.executeUpdate();
						gsmt.close();
						gsmt= null;
							
										
						gsmt2 = conn.getGauceStatement(UpdateSql.toString());
						gsmt2.setGauceDataRow(rows[j]);
						gsmt2.bindColumn(1,  idxTAXNBR);	
						gsmt2.bindColumn(2,  idxBS_ID);	
						gsmt2.executeUpdate();
						gsmt2.close();
						gsmt= null;
						
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					
						
					
					}
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
		
					}    					
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