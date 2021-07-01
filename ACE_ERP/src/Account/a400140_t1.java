package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a400140_t1 extends HttpServlet{
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
	 		
	 		String strApp_no ="";  //관리자ID
	 		
			try {
				
				conn = service.getDBConnection();	
				conn.setAutoCommit(false);  //Transaction 
				
				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				
				String str1 = reqGauce.getParameter("v_str1");				//사용자
				
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxAPP_NO                    = userSet.indexOfColumn("APP_NO");
				int idxSIGNET_ID                 = userSet.indexOfColumn("SIGNET_ID");
				int idxSIGNET_USE                = userSet.indexOfColumn("SIGNET_USE");
				int idxSIGNET_SUBMIT             = userSet.indexOfColumn("SIGNET_SUBMIT");
				int idxPAPER_CNT                 = userSet.indexOfColumn("PAPER_CNT");
				int idxSEAL_CNT                  = userSet.indexOfColumn("SEAL_CNT");
				int idxATT_FILE_NAME             = userSet.indexOfColumn("ATT_FILE_NAME");
				int idxATT_GB                    = userSet.indexOfColumn("ATT_GB");
				int idxSIGNET_CERTI_NO           = userSet.indexOfColumn("SIGNET_CERTI_NO");
				int idxSIGNET_CERTI_CNT          = userSet.indexOfColumn("SIGNET_CERTI_CNT");
				int idxREGI_CNT                  = userSet.indexOfColumn("REGI_CNT");
				int idxCUR_CAN_GB                = userSet.indexOfColumn("CUR_CAN_GB");
				int idxSEAL_DATE                 = userSet.indexOfColumn("SEAL_DATE");
				int idxSIGNET_MGR_NO             = userSet.indexOfColumn("SIGNET_MGR_NO");
				int idxAPP_TEAMCD                = userSet.indexOfColumn("APP_TEAMCD");
				int idxAPP_JOBCD                 = userSet.indexOfColumn("APP_JOBCD");
				int idxAPP_EMPNO                 = userSet.indexOfColumn("APP_EMPNO");
				int idxAPP_DATE                  = userSet.indexOfColumn("APP_DATE");
				int idxREMARK                    = userSet.indexOfColumn("REMARK");
				int idxWRID                      = userSet.indexOfColumn("WRID");
				int idxWRDT                      = userSet.indexOfColumn("WRDT");
				int idxUPID                      = userSet.indexOfColumn("UPID");
				int idxUPDT                      = userSet.indexOfColumn("UPDT");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql  = null;
				StringBuffer UpdateSql  = null;
				StringBuffer DeleteSql  = null;
				
				
				GauceStatement gsmt= null;
				
				//insert statement
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.SIGNET_COR  (                                       \n" );
				InsertSql.append( " APP_NO,    SIGNET_ID,     SIGNET_USE,SIGNET_SUBMIT,   PAPER_CNT,        \n" );
				InsertSql.append( " SEAL_CNT,  ATT_FILE_NAME, ATT_GB,    SIGNET_CERTI_NO, SIGNET_CERTI_CNT, \n" );
				InsertSql.append( " REGI_CNT,  CUR_CAN_GB,    SEAL_DATE, SIGNET_MGR_NO,   APP_TEAMCD,       \n" );
				InsertSql.append( " APP_JOBCD, APP_EMPNO,     APP_DATE,  REMARK,                            \n" );
				InsertSql.append( " WRID, WRDT                           \n" );
				InsertSql.append( " )VALUES (                            \n" );
				InsertSql.append( " ?,?,?,?,?,                           \n" );
				InsertSql.append( " ?,?,?,?,?,                           \n" );
				InsertSql.append( " ?,?,?,?,?,                           \n" );
				InsertSql.append( " ?,?,?,?,                             \n" );
				InsertSql.append( " ?,CURRENT_TIMESTAMP                  \n" );
				InsertSql.append( " )                                    \n" );
				
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.SIGNET_COR SET  \n" );
				UpdateSql.append( " SIGNET_ID= ?,       \n" );
				UpdateSql.append( " SIGNET_USE= ?,      \n" );
				UpdateSql.append( " SIGNET_SUBMIT= ?,   \n" );
				UpdateSql.append( " PAPER_CNT= ?,       \n" );
				UpdateSql.append( " SEAL_CNT= ?,        \n" );
				UpdateSql.append( " ATT_FILE_NAME= ?,   \n" );
				UpdateSql.append( " ATT_GB= ?,          \n" );
				UpdateSql.append( " SIGNET_CERTI_NO= ?, \n" );
				UpdateSql.append( " SIGNET_CERTI_CNT= ?,\n" );
				UpdateSql.append( " REGI_CNT= ?,        \n" );
				UpdateSql.append( " CUR_CAN_GB= ?,      \n" );
				UpdateSql.append( " SEAL_DATE= ?,       \n" );
				UpdateSql.append( " SIGNET_MGR_NO= ?,   \n" );
				UpdateSql.append( " APP_TEAMCD= ?,      \n" );
				UpdateSql.append( " APP_JOBCD= ?,       \n" );
				UpdateSql.append( " APP_EMPNO= ?,       \n" );
				UpdateSql.append( " APP_DATE= ?,        \n" );
				UpdateSql.append( " REMARK= ?,          \n" );
				UpdateSql.append( " UPID = ?,           \n" );
				UpdateSql.append( " UPDT = CURRENT_TIMESTAMP  \n" );
				UpdateSql.append( " WHERE APP_NO  = ?   \n" );
				
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.SIGNET_COR \n" );
				DeleteSql.append( " WHERE APP_NO  = ? \n" );
				
				//
				for (int j = 0; j < rows.length; j++){
					
					strApp_no =  rows[j].getString(idxAPP_NO);
					
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
				
						//채번시작
						Statement stmt0 = conn.createStatement();
						StringBuffer sql0 = new StringBuffer();
						sql0.append( "  SELECT LPAD(NVL(MAX(TO_NUMBER(SUBSTR(APP_NO,10,13))),0)+1,4,0) FROM ACCOUNT.SIGNET_COR  "); 
						sql0.append( "   WHERE APP_DATE = '"+rows[j].getString(idxAPP_DATE)+"'  "); 
						 
						
						ResultSet rs0 = stmt0.executeQuery(sql0.toString()); 
						if(rs0.next()){
							strApp_no= "C"+rows[j].getString(idxAPP_DATE)+rs0.getString(1);
						}
						rs0.close();
						stmt0.close();
						
						rows[j].setString(idxAPP_NO,strApp_no);
						rows[j].setString(idxWRID, str1);
						//채번완료
						
						//System.out.println(InsertSql.toString());
						
						gsmt = conn.getGauceStatement(InsertSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxAPP_NO);
						gsmt.bindColumn(2, idxSIGNET_ID);
						gsmt.bindColumn(3, idxSIGNET_USE);
						gsmt.bindColumn(4, idxSIGNET_SUBMIT);
						gsmt.bindColumn(5, idxPAPER_CNT);
						gsmt.bindColumn(6, idxSEAL_CNT);
						gsmt.bindColumn(7, idxATT_FILE_NAME);
						gsmt.bindColumn(8, idxATT_GB);
						gsmt.bindColumn(9, idxSIGNET_CERTI_NO);
						gsmt.bindColumn(10,idxSIGNET_CERTI_CNT);
						gsmt.bindColumn(11,idxREGI_CNT);
						gsmt.bindColumn(12,idxCUR_CAN_GB);
						gsmt.bindColumn(13,idxSEAL_DATE);
						gsmt.bindColumn(14,idxSIGNET_MGR_NO);
						gsmt.bindColumn(15,idxAPP_TEAMCD);
						gsmt.bindColumn(16,idxAPP_JOBCD);
						gsmt.bindColumn(17,idxAPP_EMPNO);
						gsmt.bindColumn(18,idxAPP_DATE);	
						gsmt.bindColumn(19,idxREMARK);
						gsmt.bindColumn(20,idxWRID);
												
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
						//System.out.println("insert1");
						
						
					}else if (rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE){
						
						//System.out.println(UpdateSql.toString());
						
						rows[j].setString(idxUPID,str1);
				
						gsmt = conn.getGauceStatement(UpdateSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
						
						
						gsmt.bindColumn(1, idxSIGNET_ID);
						gsmt.bindColumn(2, idxSIGNET_USE);
						gsmt.bindColumn(3, idxSIGNET_SUBMIT);
						gsmt.bindColumn(4, idxPAPER_CNT);
						gsmt.bindColumn(5, idxSEAL_CNT);
						gsmt.bindColumn(6, idxATT_FILE_NAME);
						gsmt.bindColumn(7, idxATT_GB);
						gsmt.bindColumn(8, idxSIGNET_CERTI_NO);
						gsmt.bindColumn(9, idxSIGNET_CERTI_CNT);
						gsmt.bindColumn(10,idxREGI_CNT);
						gsmt.bindColumn(11,idxCUR_CAN_GB);
						gsmt.bindColumn(12,idxSEAL_DATE);
						gsmt.bindColumn(13,idxSIGNET_MGR_NO);
						gsmt.bindColumn(14,idxAPP_TEAMCD);
						gsmt.bindColumn(15,idxAPP_JOBCD);
						gsmt.bindColumn(16,idxAPP_EMPNO);
						gsmt.bindColumn(17,idxAPP_DATE);	
						gsmt.bindColumn(18,idxREMARK);
						gsmt.bindColumn(19,idxUPID);
						gsmt.bindColumn(20,idxAPP_NO);
						
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
						//인감이력에 변경건으로 추가  INSERT 
					
			 	   }else if (rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE){
					
						//System.out.println(DeleteSql.toString());
						
						rows[j].setString(idxUPID,str1);
												
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxAPP_NO);
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
						//인감이력에 삭제 건으로 추가 INSERT 	
					}//if
					
				}//for	
				
				
				/************************************************************************************
				 @ return값
				*************************************************************************************/
				
				GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2");
				if (userSet2 != null) {
					resGauce.enableFirstRow(userSet2);
					userSet2.addDataColumn(new GauceDataColumn("APP_NO", GauceDataColumn.TB_STRING,13));
					GauceDataRow row = null;
					row = userSet2.newDataRow();
					row.addColumnValue(strApp_no);
					userSet2.addDataRow(row);
					userSet2.flush();
				}
			}//inner try
			catch(Exception e){
				System.out.println("ERROR000::"+e);
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}

			conn.commit(); 
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}//outer try
		catch (Exception e) {
			
			System.out.println("ERROR::"+e);
			//logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}//public void
	
}//classes