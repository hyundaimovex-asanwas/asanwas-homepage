package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class trOrderCar extends HttpServlet{

	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceDataSet dSetMstID = null;

		try{
			loader = new ServiceLoader(req, res);
	 		service = loader.newService();
	 		context = service.getContext();
	 		logger = context.getLogger();
	 		GauceRequest reqGauce = null;
	 		GauceResponse resGauce = null;

			try {
				conn = service.getDBConnection();

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
//-----------------------------------------------------------------------------
//	Description : PARAMETER GET
//-----------------------------------------------------------------------------				
				String ord_no = reqGauce.getParameter("gstr1"); 
   				if ( ord_no==null || ord_no.trim().length()==0 ) { ord_no=""; }
				String car_seq_no = null ; 
                
//-----------------------------------------------------------------------------
//	Description : DataSet Index Setting
//-----------------------------------------------------------------------------	
				dSetMstID = new GauceDataSet(); 
				dSetMstID.addDataColumn(new GauceDataColumn("CAR_SEQ_NO", GauceDataColumn.TB_STRING,10));

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER"); 
				
				int idxORDER_NO =  userSet.indexOfColumn("ORDER_NO");
				int idxCAR_SEQ_NO =userSet.indexOfColumn("CAR_SEQ_NO");
				int idxCARTYPENO = userSet.indexOfColumn("CARTYPENO");
				int idxCAR_CNT =userSet.indexOfColumn("CAR_CNT");
				int idxLD_CARGO =  userSet.indexOfColumn("LD_CARGO");
				int idxLD_CARGONM =userSet.indexOfColumn("LD_CARGONM");
				int idxOFF_CARGO = userSet.indexOfColumn("OFF_CARGO");
				int idxOFF_CARGONM =  userSet.indexOfColumn("OFF_CARGONM");
				int idxCUST_CD =userSet.indexOfColumn("CUST_CD");
				int idxCUST_NAME = userSet.indexOfColumn("CUST_NAME");
				int idxCUST_PS =userSet.indexOfColumn("CUST_PS");
				int idxCUST_TEL =  userSet.indexOfColumn("CUST_TEL");
				int idxLD_DATE =userSet.indexOfColumn("LD_DATE");
				int idxPERSON_NO = userSet.indexOfColumn("PERSON_NO");
				int idxCAR_TYPE =  userSet.indexOfColumn("CAR_TYPE");
				int idxREMARK = userSet.indexOfColumn("REMARK");
				int idxCTN_STDRD = userSet.indexOfColumn("CTN_STDRD");
				int idxEDT_DATE =  userSet.indexOfColumn("EDT_DATE");
				int idxLCT_URL =userSet.indexOfColumn("LCT_URL");
				int idxCREATE_USR =userSet.indexOfColumn("CREATE_USR");
				int idxUPDATE_USR =userSet.indexOfColumn("UPDATE_USR");
				int idxLINE_PART = userSet.indexOfColumn("LINE_PART") ; 
				int idxIN_OUT = userSet.indexOfColumn("IN_OUT") ; 

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;  
				StringBuffer sql = null ; 

				for (int j = 0; j < rows.length; j++){
					InsertSql = null;
					UpdateSql = null;
					DeleteSql = null;  
					sql = null ; 

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						sql = new StringBuffer();
						sql.append( " SELECT ") ; 
						sql.append( " SUBSTR(CHAR(CURRENT DATE),3,2) CONCAT SUBSTR(CHAR(CURRENT DATE),6,2) CONCAT  ") ; 
						sql.append( " CASE WHEN MAX(CAR_SEQ_NO) IS NULL THEN '00001'  ") ; 
						sql.append( " WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(CAR_SEQ_NO,6,5)))+ 1)) = 1  ") ; 
						sql.append( " THEN '0000' CONCAT CHAR(DEC(MAX(SUBSTRING(CAR_SEQ_NO,6,5)))+ 1)  ") ; 
						sql.append( " WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(CAR_SEQ_NO,6,5)))+ 1)) = 2  ") ; 
						sql.append( " THEN '000' CONCAT CHAR(DEC(MAX(SUBSTRING(CAR_SEQ_NO,6,5)))+ 1)  ") ; 
						sql.append( " WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(CAR_SEQ_NO,6,5)))+ 1)) = 3  ") ; 
						sql.append( " THEN '00' CONCAT CHAR(DEC(MAX(SUBSTRING(CAR_SEQ_NO,6,5)))+ 1)  ") ; 
						sql.append( " WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(CAR_SEQ_NO,6,5)))+ 1)) = 4  ") ; 
						sql.append( " THEN '0' CONCAT CHAR(DEC(MAX(SUBSTRING(CAR_SEQ_NO,6,5)))+ 1)  ") ; 
						sql.append( " ELSE '00001' END AS CAR_SEQ_NO FROM TRANSFER.LTORDCAR  ") ; 
						sql.append( " WHERE SUBSTR(CAR_SEQ_NO,1,4) =SUBSTR(CHAR(CURRENT DATE),3,2) CONCAT SUBSTR(CHAR(CURRENT DATE),6,2)  ") ; 
						
						Statement stmt = null;
						ResultSet rs = null;

						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());

						while (rs.next()) {
							car_seq_no = rs.getString(1);
						}
						
						stmt.close();
						rs.close();

						InsertSql = new StringBuffer();
                        InsertSql.append(" INSERT INTO TRANSFER.LTORDCAR( ") ; 
                        InsertSql.append("ORDER_NO,CAR_SEQ_NO,CARTYPENO,CAR_CNT,") ; 
                        InsertSql.append("LD_CARGO,LD_CARGONM,OFF_CARGO,OFF_CARGONM,") ; 
                        InsertSql.append("CUST_CD,CUST_NAME,CUST_PS,CUST_TEL,LD_DATE,") ; 
                        InsertSql.append("PERSON_NO,CAR_TYPE,REMARK,CTN_STDRD,EDT_DATE,") ; 
                        InsertSql.append("LCT_URL ,CREATE_DT,CREATE_USR ,UPDATE_DT,UPDATE_USR") ; 
												InsertSql.append(",LINE_PART,IN_OUT )") ; 
                        InsertSql.append("VALUES( ") ; 
                        InsertSql.append("?, ? ,?,?,") ; 
                        InsertSql.append("?,?,?,?,") ; 
                        InsertSql.append("?,?,?,?,?,") ; 
                        InsertSql.append("?,?,?,?,?,") ; 
                        InsertSql.append("? ,TIMESTAMP,? ,TIMESTAMP, ?   ") ; 
						InsertSql.append(",?,? ) ") ; 

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString()); 
						gsmt.setGauceDataRow(rows[j]); 
						gsmt.setString(1, ord_no); 
						gsmt.setString(2, car_seq_no.trim() );
						gsmt.bindColumn(3, idxCARTYPENO  );
						gsmt.bindColumn(4, idxCAR_CNT    );
						gsmt.bindColumn(5, idxLD_CARGO   );
						gsmt.bindColumn(6, idxLD_CARGONM );
						gsmt.bindColumn(7, idxOFF_CARGO  );
						gsmt.bindColumn(8, idxOFF_CARGONM  );
						gsmt.bindColumn(9, idxCUST_CD    );
						gsmt.bindColumn(10,idxCUST_NAME  );
						gsmt.bindColumn(11,idxCUST_PS    );
						gsmt.bindColumn(12,idxCUST_TEL   );
						gsmt.bindColumn(13,idxLD_DATE    );
						gsmt.bindColumn(14,idxPERSON_NO  );
						gsmt.bindColumn(15,idxCAR_TYPE   );
						gsmt.bindColumn(16,idxREMARK     );
						gsmt.bindColumn(17,idxCTN_STDRD  );
						gsmt.bindColumn(18,idxEDT_DATE   );
						gsmt.bindColumn(19,idxLCT_URL    );
						gsmt.bindColumn(20,idxCREATE_USR );
						gsmt.bindColumn(21,idxUPDATE_USR );
						gsmt.bindColumn(22,idxLINE_PART );
						gsmt.bindColumn(23,idxIN_OUT );
	 					gsmt.executeUpdate(); 
						gsmt.close(); 
						 

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append(" UPDATE TRANSFER.LTORDCAR SET ");
						UpdateSql.append(" CARTYPENO = ? ,CAR_CNT = ?,");
						UpdateSql.append(" LD_CARGO= ?,LD_CARGONM= ?,OFF_CARGO= ?,OFF_CARGONM= ?,");
						UpdateSql.append(" CUST_CD= ?,CUST_NAME= ?,CUST_PS= ?,CUST_TEL= ?,LD_DATE= ?,");
						UpdateSql.append(" PERSON_NO= ?,CAR_TYPE= ?,REMARK= ?,CTN_STDRD= ?,EDT_DATE= ?,");
						UpdateSql.append(" LCT_URL = ?, ");
						UpdateSql.append(" UPDATE_DT= TIMESTAMP,UPDATE_USR= ? ") ;
						UpdateSql.append(" ,LINE_PART = ? , IN_OUT = ?, ORDER_NO = ? ") ; 
						UpdateSql.append(" WHERE ");
						UpdateSql.append(" CAR_SEQ_NO = ? ");  
//						UpdateSql.append(" ORDER_NO= ? AND CAR_SEQ_NO= ? ");  

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxCARTYPENO  );
						gsmt.bindColumn(2, idxCAR_CNT    );
						gsmt.bindColumn(3, idxLD_CARGO   );
						gsmt.bindColumn(4, idxLD_CARGONM );
						gsmt.bindColumn(5, idxOFF_CARGO  );
						gsmt.bindColumn(6, idxOFF_CARGONM  );
						gsmt.bindColumn(7, idxCUST_CD    );
						gsmt.bindColumn(8,idxCUST_NAME  );
						gsmt.bindColumn(9,idxCUST_PS    );
						gsmt.bindColumn(10,idxCUST_TEL   );
						gsmt.bindColumn(11,idxLD_DATE    );
						gsmt.bindColumn(12,idxPERSON_NO  );
						gsmt.bindColumn(13,idxCAR_TYPE   );
						gsmt.bindColumn(14,idxREMARK     );
						gsmt.bindColumn(15,idxCTN_STDRD  );
						gsmt.bindColumn(16,idxEDT_DATE   );
						gsmt.bindColumn(17,idxLCT_URL    );
						gsmt.bindColumn(18,idxUPDATE_USR );
						gsmt.bindColumn(19,idxLINE_PART );
						gsmt.bindColumn(20,idxIN_OUT );
						gsmt.setString(21, ord_no); 
						gsmt.bindColumn(22, idxCAR_SEQ_NO );
						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {

						DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE  ")
								 .append( "   FROM TRANSFER.LTORDCAR ")
								 .append( "  WHERE CAR_SEQ_NO = ? ");

						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxCAR_SEQ_NO ); 
						gsmt.executeUpdate();
						gsmt = null;
						DeleteSql = null;

						DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE  ")
								 .append( "   FROM TRANSFER.LTCARGOODS ")
								 .append( "  WHERE ORDER_NO = ? ");

						if (ord_no.equals("all"))	{
							gsmt = conn.getGauceStatement(DeleteSql.toString());
							gsmt.setGauceDataRow(rows[j]);

							gsmt.bindColumn(	1, idxORDER_NO); 
						} else {
							DeleteSql.append("		 AND CAR_SEQ_NO = ? ");

							gsmt = conn.getGauceStatement(DeleteSql.toString());
							gsmt.setGauceDataRow(rows[j]);

							gsmt.bindColumn(1, idxORDER_NO); 
							gsmt.bindColumn(2, idxCAR_SEQ_NO ); 
						}

						gsmt.executeUpdate();
						gsmt.close();

					}
				}
			}
			catch(SQLException se){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+se.toString()+")");
				logger.err.println(this,se);
				//logger.dbg.println(this,se.toString());
			}

			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}