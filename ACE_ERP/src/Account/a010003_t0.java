package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010003_t0 extends HttpServlet{
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

				String str1 = reqGauce.getParameter("v_str1");
				String str2 = reqGauce.getParameter("v_str2");
				String strGB = "";
				String strCnt = "";

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxCORP_CD     = userSet.indexOfColumn("CORP_CD");
				int idxVEND_GB     = userSet.indexOfColumn("VEND_GB");
				int idxVEND_CD     = userSet.indexOfColumn("VEND_CD");
				int idxVEND_NM     = userSet.indexOfColumn("VEND_NM");
			
				int idxVD_DIRECT   = userSet.indexOfColumn("VD_DIRECT");
				int idxBSNS_CND    = userSet.indexOfColumn("BSNS_CND");
				int idxBSNS_KND    = userSet.indexOfColumn("BSNS_KND");
				int idxVD_TELNO    = userSet.indexOfColumn("VD_TELNO");

				int idxVD_FAXNO    = userSet.indexOfColumn("VD_FAXNO");
				int idxPOST_NO1    = userSet.indexOfColumn("POST_NO1");
				int idxPOST_NO2    = userSet.indexOfColumn("POST_NO2");
				int idxADDRESS1    = userSet.indexOfColumn("ADDRESS1");

				int idxADDRESS2    = userSet.indexOfColumn("ADDRESS2");
				int idxC_BANKCD    = userSet.indexOfColumn("C_BANKCD");
				int idxC_ACCTNO    = userSet.indexOfColumn("C_ACCTNO");
				int idxC_ACCTNO_NM = userSet.indexOfColumn("C_ACCTNO_NM");

				int idxC_ACCTNM    = userSet.indexOfColumn("C_ACCTNM");
				int idxB_BANKCD    = userSet.indexOfColumn("B_BANKCD");
				int idxB_ACCTNO    = userSet.indexOfColumn("B_ACCTNO");
				int idxB_ACCTNO_NM = userSet.indexOfColumn("B_ACCTNO_NM");

				int idxB_ACCTNM    = userSet.indexOfColumn("B_ACCTNM");
				int idxO_VENDGB    = userSet.indexOfColumn("O_VENDGB");
				int idxO_VENDCD    = userSet.indexOfColumn("O_VENDCD");
				int idxVEND_MAG    = userSet.indexOfColumn("VEND_MAG");

				int idxUSE_TAG     = userSet.indexOfColumn("USE_TAG");
				int idxREMARK      = userSet.indexOfColumn("REMARK");
				int idxCREAT_DT    = userSet.indexOfColumn("CREAT_DT");
				int idxCREAT_NM    = userSet.indexOfColumn("CREAT_NM");

				int idxMSN		   = userSet.indexOfColumn("MSN");
				int idxMPWD		   = userSet.indexOfColumn("MPWD");
				int idxCOCOMYN     = userSet.indexOfColumn("COCOMYN");
				int idxVEND_ID     = userSet.indexOfColumn("VEND_ID");

				int idxH_VEND_CD   = userSet.indexOfColumn("H_VEND_CD");
				int idxH_VEND_NM   = userSet.indexOfColumn("H_VEND_NM");
				int idxWRDT        = userSet.indexOfColumn("WRDT");
				int idxWRID        = userSet.indexOfColumn("WRID");
				int idxUPDT        = userSet.indexOfColumn("UPDT");
				int idxUPID        = userSet.indexOfColumn("UPID");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.GCZM_VENDER (  																\n");
				InsertSql.append( " VEND_CD,  VEND_NM,    																			\n");
				InsertSql.append( " VD_DIRECT, BSNS_CND, BSNS_KND, VD_TELNO,  														\n");
				InsertSql.append( " VD_FAXNO, POST_NO1, POST_NO2, ADDRESS1,   														\n");
				InsertSql.append( " ADDRESS2, C_BANKCD, C_ACCTNO, C_ACCTNO_NM,  													\n");
				InsertSql.append( " C_ACCTNM, B_BANKCD, B_ACCTNO, B_ACCTNO_NM,  													\n");
				InsertSql.append( " B_ACCTNM, O_VENDGB, O_VENDCD, VEND_MAG,    														\n");
				InsertSql.append( " USE_TAG, REMARK,  MSN, MPWD,COCOMYN,VEND_ID ,CREAT_DT, CREAT_NM,   				                \n");
				InsertSql.append( " H_VEND_CD, H_VEND_NM, IUGB,  																	\n");
				InsertSql.append( " WRDT,      WRID   ) 																			\n");
				InsertSql.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,'" + str1 + "','" +str2+"', 		\n");
				InsertSql.append( " ?,?,'I',sysdate,'" +str2+"') 																		\n");
 
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.GCZM_VENDER SET 																		\n");
		        UpdateSql.append( "        VEND_NM = ?,VD_DIRECT = ?,BSNS_CND = ?,BSNS_KND = ?,VD_TELNO = ?,				\n");
				UpdateSql.append( "        VD_FAXNO = ?,POST_NO1 = ?,POST_NO2 = ?,ADDRESS1 = ?,ADDRESS2 = ?,			\n");
				UpdateSql.append( "        C_BANKCD = ?,C_ACCTNO = ?,C_ACCTNO_NM = ?,C_ACCTNM = ?,B_BANKCD = ?,		\n");
				UpdateSql.append( "        B_ACCTNO = ?,B_ACCTNO_NM = ?,B_ACCTNM = ?,O_VENDGB = ?,O_VENDCD = ?,	\n");
				UpdateSql.append( "        VEND_MAG = ?,USE_TAG = ?,REMARK = ?,															\n");
				UpdateSql.append( "        CREAT_DT = '" + str1 + "',																					\n");
				UpdateSql.append( "        CREAT_NM = '" + str2 +"', 																					\n");
				UpdateSql.append( "        MSN = ?,MPWD = ?,COCOMYN=?,VEND_ID=?, 														\n");
				UpdateSql.append( "        H_VEND_CD=?, H_VEND_NM=?, IUGB='U', 															\n");
				UpdateSql.append( "        WRDT= sysdate, WRID = '" +str2+"' 													\n");
				UpdateSql.append( " WHERE VEND_CD= ?																								\n");

				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.GCZM_VENDER WHERE VEND_CD= ?										\n");

				for (int j = 0; j < rows.length; j++){
          
					//거래처 조회
                    Statement stmt0 = conn.createStatement();
					String sql0 = " SELECT COUNT(CDCODE) CNT  FROM ACCOUNT.COMMDTIL "
					 			+ "  WHERE CMTYPE='0020'"
                                + "	   AND CDCODE ='"+rows[j].getString(idxVEND_CD)+"'";
											
					ResultSet rs0 = stmt0.executeQuery(sql0); 
					if(rs0.next()){
						 strGB=rs0.getString(1);
					}else{
                         strGB="0";
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxVEND_CD);
						gsmt.bindColumn(2, idxVEND_NM);

						gsmt.bindColumn(3, idxVD_DIRECT);
						gsmt.bindColumn(4, idxBSNS_CND);
						gsmt.bindColumn(5, idxBSNS_KND);
						gsmt.bindColumn(6, idxVD_TELNO);

						gsmt.bindColumn(7, idxVD_FAXNO);
						gsmt.bindColumn(8, idxPOST_NO1);
						gsmt.bindColumn(9, idxPOST_NO2);
						gsmt.bindColumn(10, idxADDRESS1);

						gsmt.bindColumn(11, idxADDRESS2);
						gsmt.bindColumn(12, idxC_BANKCD);
						gsmt.bindColumn(13, idxC_ACCTNO);
						gsmt.bindColumn(14, idxC_ACCTNO_NM);

						gsmt.bindColumn(15, idxC_ACCTNM);
						gsmt.bindColumn(16, idxB_BANKCD);
						gsmt.bindColumn(17, idxB_ACCTNO);
						gsmt.bindColumn(18, idxB_ACCTNO_NM);

						gsmt.bindColumn(19, idxB_ACCTNM);
						gsmt.bindColumn(20, idxO_VENDGB);
						gsmt.bindColumn(21, idxO_VENDCD);
						gsmt.bindColumn(22, idxVEND_MAG);

						gsmt.bindColumn(23, idxUSE_TAG);
						gsmt.bindColumn(24, idxREMARK);

						gsmt.bindColumn(25, idxMSN);
						gsmt.bindColumn(26, idxMPWD);
						gsmt.bindColumn(27, idxCOCOMYN);
						gsmt.bindColumn(28, idxVEND_ID);

						//20080727 추가 
						gsmt.bindColumn(29, idxH_VEND_CD);
						gsmt.bindColumn(30, idxH_VEND_NM);

						gsmt.executeUpdate();
						gsmt.close();
						
						if(strGB.equals("0")){
							
							String  sql0_1 = " INSERT INTO ACCOUNT.COMMDTIL( "
										   + "   CMTYPE, CDCODE, CDNAM, WRDT,	WRID "
										   + "  ) VALUES ( "
										   + "  '0020',?,?,"
										   + "  '"+str1+"',"
										   + "  '"+str2+"')";

							GauceStatement gsmt0_1= conn.getGauceStatement(sql0_1);
							gsmt0_1.setGauceDataRow(rows[j]);
							gsmt0_1.bindColumn(1, idxVEND_CD);
							gsmt0_1.bindColumn(2, idxVEND_NM);
							gsmt0_1.executeUpdate();
							gsmt0_1.close();
							
						}else{
							
							String  sql0_2 = " UPDATE ACCOUNT.COMMDTIL SET  "
                                           + "        CDNAM = ?, "
										   + "        UPDT = '"+str1+"',"
										   + "        UPID = '"+str2+"'"
										   + "  WHERE CMTYPE = '0020'"
										   + "    AND CDCODE = '"+rows[j].getString(idxVEND_CD)+"'";
													
							GauceStatement gsmt0_2 = conn.getGauceStatement(sql0_2);
							gsmt0_2.setGauceDataRow(rows[j]);
							gsmt0_2.bindColumn(1, idxVEND_NM);
							gsmt0_2.executeUpdate();
							gsmt0_2.close();
							
						}
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxVEND_NM);

						gsmt.bindColumn(2, idxVD_DIRECT);
						gsmt.bindColumn(3, idxBSNS_CND);
						gsmt.bindColumn(4, idxBSNS_KND);
						gsmt.bindColumn(5, idxVD_TELNO);

						gsmt.bindColumn(6, idxVD_FAXNO);
						gsmt.bindColumn(7, idxPOST_NO1);
						gsmt.bindColumn(8, idxPOST_NO2);
						gsmt.bindColumn(9, idxADDRESS1);

						gsmt.bindColumn(10, idxADDRESS2);
						gsmt.bindColumn(11, idxC_BANKCD);
						gsmt.bindColumn(12, idxC_ACCTNO);
						gsmt.bindColumn(13, idxC_ACCTNO_NM);

						gsmt.bindColumn(14, idxC_ACCTNM);
						gsmt.bindColumn(15, idxB_BANKCD);
						gsmt.bindColumn(16, idxB_ACCTNO);
						gsmt.bindColumn(17, idxB_ACCTNO_NM);

						gsmt.bindColumn(18, idxB_ACCTNM);
						gsmt.bindColumn(19, idxO_VENDGB);
						gsmt.bindColumn(20, idxO_VENDCD);
						gsmt.bindColumn(21, idxVEND_MAG);

						gsmt.bindColumn(22, idxUSE_TAG);
						gsmt.bindColumn(23, idxREMARK);
						gsmt.bindColumn(24, idxMSN);
						gsmt.bindColumn(25, idxMPWD);
						gsmt.bindColumn(26, idxCOCOMYN);
						gsmt.bindColumn(27, idxVEND_ID);

						//20080727 추가 
						gsmt.bindColumn(28, idxH_VEND_CD);
						gsmt.bindColumn(29, idxH_VEND_NM);
						
						gsmt.bindColumn(30, idxVEND_CD);

						gsmt.executeUpdate(); 
						gsmt.close();   
						
						if(strGB.equals("0")){
						
							String  sql0_1 = " INSERT INTO ACCOUNT.COMMDTIL( "
										   + "   CMTYPE, CDCODE, CDNAM, WRDT,	WRID "
										   + "  ) VALUES ( "
										   + "  '0020',"
										   + "  '"+rows[j].getString(idxVEND_CD)+"',"
										   + "  '"+rows[j].getString(idxVEND_NM)+"',"
										   + "  '"+str1+"',"
										   + "  '"+str2+"')";

							GauceStatement gsmt0_1= conn.getGauceStatement(sql0_1);
							gsmt0_1.executeUpdate();
							gsmt0_1.close();
						}else{
						
							String  sql0_2 = " UPDATE ACCOUNT.COMMDTIL SET  "
                                           + "        CDNAM = '"+rows[j].getString(idxVEND_NM)+"',"
										   + "        UPDT = '"+str1+"',"
										   + "        UPID = '"+str2+"'"
										   + "  WHERE CMTYPE = '0020'"
										   + "    AND CDCODE = '"+rows[j].getString(idxVEND_CD)+"'";
														
							GauceStatement gsmt0_2 = conn.getGauceStatement(sql0_2);
							gsmt0_2.executeUpdate();
							gsmt0_2.close();
						}
                                    
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxVEND_CD);
						gsmt.executeUpdate();
						gsmt.close();
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