package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;

import javax.servlet.*;
import javax.servlet.http.*;

import sales.common.HDUtil;

public class a010051_t1 extends HttpServlet{
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
				String str1 = reqGauce.getParameter("v_str1");
				String str2 = reqGauce.getParameter("v_str2");
				String strGB = "";
				String strCnt = "";

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxVEND_ID  	= userSet.indexOfColumn("VEND_ID");
				int idxVEND_CD  	= userSet.indexOfColumn("VEND_CD");
				int idxVEND_NM  	= userSet.indexOfColumn("VEND_NM");
				int idxVD_DIRECT	= userSet.indexOfColumn("VD_DIRECT");
				int idxBSNS_CND 	= userSet.indexOfColumn("BSNS_CND");
				int idxBSNS_KND 	= userSet.indexOfColumn("BSNS_KND");
				int idxVD_TELNO 	= userSet.indexOfColumn("VD_TELNO");
				int idxVD_FAXNO 	= userSet.indexOfColumn("VD_FAXNO");
				int idxPOST_NO1 	= userSet.indexOfColumn("POST_NO1");
				int idxPOST_NO2 	= userSet.indexOfColumn("POST_NO2");
				int idxADDRESS1 	= userSet.indexOfColumn("ADDRESS1");
				int idxADDRESS2 	= userSet.indexOfColumn("ADDRESS2");
				int idxCOCOMYN  	= userSet.indexOfColumn("COCOMYN");
				int idxUSE_TAG  	= userSet.indexOfColumn("USE_TAG");
				int idxREMARK   	= userSet.indexOfColumn("REMARK");
				int idxWRID     	    = userSet.indexOfColumn("WRID");
				int idxWRDT     	= userSet.indexOfColumn("WRDT");
				int idxSTATUS    	= userSet.indexOfColumn("STATUS");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
							
	
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.GCZM_VENDER_USER SET 		    \n");				
				UpdateSql.append( "  STATUS = ? 									\n");
				UpdateSql.append( " ,CFID = '"+str1+"'								\n");
				UpdateSql.append( " ,CFDT =sysdate									\n");
				UpdateSql.append( "  WHERE  VEND_CD = ? 							\n");	
				
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.GCZM_VENDER ( 				\n");
				InsertSql.append( "VEND_ID,VEND_CD,VEND_NM,VD_DIRECT,BSNS_CND,  	\n");
				InsertSql.append( "BSNS_KND,VD_TELNO,VD_FAXNO,POST_NO1,POST_NO2,	\n");
				InsertSql.append( "ADDRESS1,ADDRESS2,COCOMYN,USE_TAG,REMARK,    	\n");
				InsertSql.append( "WRID,WRDT,  IUGB                                 \n");
				InsertSql.append( "	) VALUES( 										\n");
				InsertSql.append( " ?, ?, ?, ?, ?, 									\n");
				InsertSql.append( " ?, ?, ?, ?, ?, 									\n");
				InsertSql.append( " ?, ?, ?, ?, ?, 									\n");
				InsertSql.append( " '"+str1+"', sysdate,  'I' ) 					\n");
				
				
				/* MS-SQL로 거래처 등록하는 부분 start*/
				StringBuffer InsertSql_MSSQL = null;					
				InsertSql_MSSQL = new StringBuffer();
				
				InsertSql_MSSQL.append( " IF NOT EXISTS (SELECT KUNNR  FROM SIFT_VENDOR WHERE KUNNR = ?) 			    \n");	
				InsertSql_MSSQL.append( " 		BEGIN																	\n");				
				
				InsertSql_MSSQL.append( " INSERT INTO SIFT_VENDOR ( 													\n");
				InsertSql_MSSQL.append( " BUKRS,  KOART,  KUNNR,  KTOKD,   NAME1,      SORTL,       TY_TAX, 			\n");
				InsertSql_MSSQL.append( " LAND1,  STCD2,   J_1KFREPRE,    CD_CORP,	TY_STATUS							\n");
				InsertSql_MSSQL.append( "	) VALUES( 																	\n");
				InsertSql_MSSQL.append( " ?, ?, ?, '1000', ?, ?, ?, 													\n");
				InsertSql_MSSQL.append( " ?, ?, ?, ?, ?																	\n");
				InsertSql_MSSQL.append( " ) 																			\n");
				
				InsertSql_MSSQL.append( "		END 																	\n");				
				/* MS-SQL로 거래처 등록하는 부분 end*/
				
				
				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
				
						gsmt.setGauceDataRow(rows[j]);
							
						gsmt.bindColumn(1, idxSTATUS);	
						gsmt.bindColumn(2, idxVEND_CD);	

						gsmt.executeUpdate();
						gsmt.close();
						
						gsmt=null;
						
						
						gsmt = conn.getGauceStatement(InsertSql.toString());
					
						//	logger.dbg.println(this,InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idxVEND_ID);	
						gsmt.bindColumn(2,  idxVEND_CD);	
						gsmt.bindColumn(3,  idxVEND_NM);	
						gsmt.bindColumn(4,  idxVD_DIRECT);	
						gsmt.bindColumn(5,  idxBSNS_CND);	
						gsmt.bindColumn(6,  idxBSNS_KND);	
						gsmt.bindColumn(7,  idxVD_TELNO);	
						gsmt.bindColumn(8,  idxVD_FAXNO);	
						gsmt.bindColumn(9,  idxPOST_NO1);	
						gsmt.bindColumn(10, idxPOST_NO2);	
						gsmt.bindColumn(11, idxADDRESS1);	
						gsmt.bindColumn(12, idxADDRESS2);	
						gsmt.bindColumn(13, idxCOCOMYN);	
						gsmt.bindColumn(14, idxUSE_TAG);	
						gsmt.bindColumn(15, idxREMARK);	
						
						gsmt.executeUpdate();
						gsmt.close();
						
						
						/* MS-SQL 로 거래처 등록하는 부분 start*/
						String  VEND_ID		= rows[j].getString(idxVEND_ID); 			
						String  VEND_CD	= rows[j].getString(idxVEND_CD); 				
						String  VEND_NM	= rows[j].getString(idxVEND_NM); 		
						String  VD_DIRECT	= rows[j].getString(idxVD_DIRECT); 		
						String  COCOMYN	= rows[j].getString(idxCOCOMYN); 							
						String  check        = VEND_CD.substring(0,1); 	
						
						  if(COCOMYN.equals("N")){
							  COCOMYN="일반";
						  }else if(COCOMYN.equals("T")){
							  COCOMYN="간이";
						  }else if(COCOMYN.equals("M")){
							  COCOMYN="면세";							  
						  }else{
							  COCOMYN="일반";							  
						  }
						

						  
					   if(check.equals("J")){
					  
						   
						   
						}else{						  
						  
						/* DataSet */
						CallableStatement cstmt = null;

						Connection conn_ms = DriverManager.getConnection("jdbc:sqlserver://203.242.32.128:1433;databaseName=econnetUX;user=econnet;password=econnet!;");
						
						cstmt = conn_ms.prepareCall(InsertSql_MSSQL.toString());					
					
						
						cstmt.setString(1, VEND_ID);							
						cstmt.setString(2, "02");									
						cstmt.setString(3, "K");							
						cstmt.setString(4, VEND_ID);		
						cstmt.setString(5, VEND_NM);		
						cstmt.setString(6, VEND_NM);							
						cstmt.setString(7, COCOMYN);							
						cstmt.setString(8, "KR");	
						cstmt.setString(9, VEND_CD);						
						cstmt.setString(10, VD_DIRECT);	
						cstmt.setString(11, "01");						
						cstmt.setString(12, "02");						

						cstmt.executeUpdate();
						
						conn_ms.close();						
						cstmt.close();
						
						}
						/* MS-SQL로 거래처 등록하는 부분 end*/

						
						
						//	거래처 조회
						  Statement stmt0 = conn.createStatement();
						  String sql0 = " SELECT COUNT(CDCODE) CNT  FROM ACCOUNT.COMMDTIL "
											+ " WHERE CMTYPE='0020'"
											+ "	  AND CDCODE ='"+rows[j].getString(idxVEND_CD)+"'";
							
						  ResultSet rs0 = stmt0.executeQuery(sql0); 
	
						  if(rs0.next()){
							   strGB=rs0.getString(1);
						  }else{
							   strGB="0";
						  }
						  
						  if(strGB.equals("0")){
							
							String  sql0_1 = " INSERT INTO ACCOUNT.COMMDTIL( "
														+ "   CMTYPE, CDCODE, CDNAM, WRID, WRDT	 "
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
												  + "         UPID= '"+str1+"',"
												  + "         UPDT= '"+str2+"'"  
												  + "  WHERE CMTYPE = '0020'"
												  + "    AND CDCODE = '"+rows[j].getString(idxVEND_CD)+"'";
									
							GauceStatement gsmt0_2 = conn.getGauceStatement(sql0_2);
							gsmt0_2.setGauceDataRow(rows[j]);
						    gsmt0_2.bindColumn(1, idxVEND_NM);
							gsmt0_2.executeUpdate();
							gsmt0_2.close();
						}
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