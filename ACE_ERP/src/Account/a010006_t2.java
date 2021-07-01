package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010006_t2 extends HttpServlet{
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
				String strGB1 = "";
				String strAcctno ="";  // 계좌번호 

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				int idxCANBR       = userSet.indexOfColumn("CANBR");
				int idxCADIV       = userSet.indexOfColumn("CADIV");
				int idxCACARDSPEC  = userSet.indexOfColumn("CACARDSPEC");
				int idxCADEPTCD    = userSet.indexOfColumn("CADEPTCD");			
				int idxCAEMPNO     = userSet.indexOfColumn("CAEMPNO");	
				int idxCAISSYYMM   = userSet.indexOfColumn("CAISSYYMM");
				int idxCAUSEYYMM   = userSet.indexOfColumn("CAUSEYYMM");
				int idxCASTTDAT    = userSet.indexOfColumn("CASTTDAT");
				int idxCAACCBANK   = userSet.indexOfColumn("CAACCBANK");
				int idxCABANKNO    = userSet.indexOfColumn("CABANKNO");
				int idxCACUST      = userSet.indexOfColumn("CACUST");
				int idxDSUDT       = userSet.indexOfColumn("DSUDT");
				int idxBANNAM      = userSet.indexOfColumn("BANNAM");
				int idxBANNA1      = userSet.indexOfColumn("BANNA1");
				int idxEMPNMK      = userSet.indexOfColumn("EMPNMK");
				int idxVEND_NM     = userSet.indexOfColumn("VEND_NM");
				int idxVEND_CD     = userSet.indexOfColumn("VEND_CD");
				int idxUSE_TAG     = userSet.indexOfColumn("USE_TAG");


				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.CARDCODE (  						   \n");
				InsertSql.append( " CANBR,  CADIV,  CACARDSPEC, CADEPTCD, CAEMPNO,  		   \n");
				InsertSql.append( " CAISSYYMM, CAUSEYYMM, CASTTDAT, CAACCBANK, CABANKNO,  	   \n");
				InsertSql.append( " CACUST, DSUDT,VEND_NM,VEND_CD,USE_TAG )					   \n");
				InsertSql.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,? ) 				   \n");

				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.CARDCODE SET 					            \n");
				UpdateSql.append( "        CADIV = ?,											\n");
				UpdateSql.append( "        CACARDSPEC = ?,									    \n");
				UpdateSql.append( "        CADEPTCD = ?,										\n");
				UpdateSql.append( "        CAEMPNO = ?,											\n");				
				UpdateSql.append( "        CAISSYYMM = ?,										\n");
				UpdateSql.append( "        CAUSEYYMM = ?,										\n");
				UpdateSql.append( "        CASTTDAT = ?,										\n");
				UpdateSql.append( "        CAACCBANK = ?,										\n");
				UpdateSql.append( "        CABANKNO = ?,										\n");
				UpdateSql.append( "        CACUST = ?,											\n");
				UpdateSql.append( "        DSUDT = ? ,											\n");
				UpdateSql.append( "        VEND_NM = ?, 										\n");
				UpdateSql.append( "        VEND_CD = ?, 										\n");
				UpdateSql.append( "        USE_TAG = ? 											\n");
				UpdateSql.append( " WHERE RTRIM(CANBR) = ? 								        \n");

				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.CARDCODE 					\n");
				DeleteSql.append( "  WHERE RTRIM(CANBR) = ? 						\n");
			
				for (int j = 0; j < rows.length; j++){
					
					
					//2017.02.21 JYS 이부분도 추가함. 공통코드 코드값에는 "-"를 넣지 않음..
					strAcctno =  rows[j].getString(idxCABANKNO).replace("-", ""); 

					//개인명계좌 조회
					Statement stmt0 = conn.createStatement();
					String sql0 = " SELECT RTRIM(CDCODE) CDCODE  FROM ACCOUNT.COMMDTIL "
							    + "	  WHERE CMTYPE='2166'"
                                + "	    AND REPLACE(CDCODE,'-','') ='"+strAcctno+"'";
											
					ResultSet rs0 = stmt0.executeQuery(sql0); 
					
					if(rs0.next()){
						strGB=rs0.getString(1);
					}else{
						strGB="0";
					}


					//개인카드 조회
					Statement stmt1 = conn.createStatement();
					String sql1 = " SELECT RTRIM(CDCODE) CDCODE  FROM ACCOUNT.COMMDTIL "
							    + "	 WHERE CMTYPE='2167'"
                                + "	   AND CDCODE ='"+rows[j].getString(idxCANBR)+"'";
											
					ResultSet rs1 = stmt1.executeQuery(sql1); 
					
					if(rs1.next()){
						 strGB1=rs1.getString(1);
					}else{
						strGB1="0";
					}


					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxCANBR);
						gsmt.bindColumn(2, idxCADIV);
						gsmt.bindColumn(3, idxCACARDSPEC);
						gsmt.bindColumn(4, idxCADEPTCD);
						gsmt.bindColumn(5, idxCAEMPNO);
						gsmt.bindColumn(6, idxCAISSYYMM);
						gsmt.bindColumn(7, idxCAUSEYYMM);
						gsmt.bindColumn(8, idxCASTTDAT);
						gsmt.bindColumn(9, idxCAACCBANK);
						gsmt.bindColumn(10, idxCABANKNO);
						gsmt.bindColumn(11, idxCACUST);
						gsmt.bindColumn(12, idxDSUDT);
						gsmt.bindColumn(13, idxVEND_NM);
						gsmt.bindColumn(14, idxVEND_CD);
						gsmt.bindColumn(15, idxUSE_TAG);
						gsmt.executeUpdate();
						gsmt.close();

						if(strGB.equals("0")){
							
							String  sql0_1 = " INSERT INTO ACCOUNT.COMMDTIL( "
										   + "   CMTYPE, CDCODE, CDNAM, WRDT,	WRID "
										   + "  ) VALUES ( "
									       + "  '2166','"+strAcctno+"',?,"
										   + "  '"+str1+"',"
										   + "  '"+str2+"')";

							GauceStatement gsmt0_1= conn.getGauceStatement(sql0_1);
							gsmt0_1.setGauceDataRow(rows[j]);
							//gsmt0_1.bindColumn(1, idxCABANKNO);
							gsmt0_1.bindColumn(1, idxCABANKNO);
							gsmt0_1.executeUpdate();
							gsmt0_1.close();
						}


						if(strGB1.equals("0")){
							
							String  sql1_1 = " INSERT INTO ACCOUNT.COMMDTIL( "
										   + "   CMTYPE, CDCODE, CDNAM, WRDT,	WRID "
										   + "  ) VALUES ( "
										   + "  '2167',?,?,"
										   + "  '"+str1+"',"
										   + "  '"+str2+"')";

							GauceStatement gsmt1_1= conn.getGauceStatement(sql1_1);
							gsmt1_1.setGauceDataRow(rows[j]);
							gsmt1_1.bindColumn(1, idxCANBR);
							gsmt1_1.bindColumn(2, idxCANBR);
							gsmt1_1.executeUpdate();
							gsmt1_1.close();
						}
						
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
					
						gsmt.bindColumn(1, idxCADIV);
						gsmt.bindColumn(2, idxCACARDSPEC);
						gsmt.bindColumn(3, idxCADEPTCD);
						gsmt.bindColumn(4, idxCAEMPNO);
						gsmt.bindColumn(5, idxCAISSYYMM);
						gsmt.bindColumn(6, idxCAUSEYYMM);
						gsmt.bindColumn(7, idxCASTTDAT);
						gsmt.bindColumn(8, idxCAACCBANK);
						gsmt.bindColumn(9, idxCABANKNO);
						gsmt.bindColumn(10, idxCACUST);
						gsmt.bindColumn(11, idxDSUDT);
						gsmt.bindColumn(12, idxVEND_NM);
						gsmt.bindColumn(13, idxVEND_CD);
						gsmt.bindColumn(14, idxUSE_TAG);
						gsmt.bindColumn(15, idxCANBR);
						gsmt.executeUpdate(); 
						gsmt.close();         
						
						// 계좌번호 조회하여 존재하지 않으면 INSERT
						// 이부분은 추가함. 2017.02.21 JYS
						if(strGB.equals("0")){
							
							String  sql0_1 = " INSERT INTO ACCOUNT.COMMDTIL( "
										   + "   CMTYPE, CDCODE, CDNAM, WRDT,	WRID "
										   + "  ) VALUES ( "
									       + "  '2166','"+strAcctno+"',?,"
										   + "  '"+str1+"',"
										   + "  '"+str2+"')";

							GauceStatement gsmt0_1= conn.getGauceStatement(sql0_1);
							gsmt0_1.setGauceDataRow(rows[j]);
							//gsmt0_1.bindColumn(1, idxCABANKNO);
							gsmt0_1.bindColumn(1, idxCABANKNO);
							gsmt0_1.executeUpdate();
							gsmt0_1.close();
						}
						            
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxCANBR);
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
			}
			catch(Exception e)
				{
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
				logger.err.println(this,e.toString()); //
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