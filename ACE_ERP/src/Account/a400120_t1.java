package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a400120_t1 extends HttpServlet{
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
	 		
	 		String strSignet_id="";  //관리자ID
	 		
			try {
				
				conn = service.getDBConnection();	
				conn.setAutoCommit(false);  //Transaction 
				
				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				
				String str1 = reqGauce.getParameter("v_str1");				//사용자
				Integer intSignet_Seq=0;
				
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxSIGNET_ID          = userSet.indexOfColumn("SIGNET_ID");
				int idxSIGNET_GB          = userSet.indexOfColumn("SIGNET_GB");
				int idxMGR_TEAMCD         = userSet.indexOfColumn("MGR_TEAMCD");
				int idxMGR_TEAMNM         = userSet.indexOfColumn("MGR_TEAMNM");
				int idxREG_DATE           = userSet.indexOfColumn("REG_DATE");
				int idxMAIN_EMPID         = userSet.indexOfColumn("MAIN_EMPID");
				int idxSUB_EMPID          = userSet.indexOfColumn("SUB_EMPID");
				int idxCARVE              = userSet.indexOfColumn("CARVE");
				int idxMATERIAL           = userSet.indexOfColumn("MATERIAL");
				int idxDISUSE_DATE        = userSet.indexOfColumn("DISUSE_DATE");
				int idxDISUSE_REASON      = userSet.indexOfColumn("DISUSE_REASON");
				int idxRECE_DATE          = userSet.indexOfColumn("RECE_DATE");
				int idxRECE_REASON        = userSet.indexOfColumn("RECE_REASON");
				int idxUSEGB              = userSet.indexOfColumn("USEGB");
				int idxUSE_REMARK         = userSet.indexOfColumn("USE_REMARK");
				int idxETC                = userSet.indexOfColumn("ETC");
				int idxPLACEGB            = userSet.indexOfColumn("PLACEGB");
				int idxSIGNET_HEAD_NO     = userSet.indexOfColumn("SIGNET_HEAD_NO");
				int idxWRID               = userSet.indexOfColumn("WRID");
				int idxUPID               = userSet.indexOfColumn("UPID");
				int idxWORK_GB            = userSet.indexOfColumn("WORK_GB");
				int idxSIGNET_SEQ         = userSet.indexOfColumn("SIGNET_SEQ");
				int idxSEND_DATE          = userSet.indexOfColumn("SEND_DATE");
				
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql  = null;
				StringBuffer UpdateSql  = null;
				StringBuffer DeleteSql  = null;
				
				StringBuffer InsertSql_His  = null;
				
				GauceStatement gsmt= null;
				
				//insert statement
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.SIGNET_INFO (                            \n" );
				InsertSql.append( " SIGNET_ID,    SIGNET_GB,MGR_TEAMCD, MGR_TEAMNM, REG_DATE,    \n" );
				InsertSql.append( " MAIN_EMPID,   SUB_EMPID,CARVE,      MATERIAL,   DISUSE_DATE, \n" );
				InsertSql.append( " DISUSE_REASON,RECE_DATE,RECE_REASON,USEGB,      USE_REMARK,  \n" );
				InsertSql.append( " ETC,          PLACEGB,  SIGNET_HEAD_NO,                      \n" );
				InsertSql.append( " WRID, WRDT                           \n" );
				InsertSql.append( " )VALUES (                            \n" );
				InsertSql.append( " ?,?,?,?,?,                           \n" );
				InsertSql.append( " ?,?,?,?,?,                           \n" );
				InsertSql.append( " ?,?,?,?,?,                           \n" );
				InsertSql.append( " ?,?,?,                               \n" );
				InsertSql.append( " ?,CURRENT_TIMESTAMP                  \n" );
				InsertSql.append( " )                                    \n" );
				
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.SIGNET_INFO SET  \n" );
				UpdateSql.append( " SIGNET_GB= ?,       \n" );
				UpdateSql.append( " MGR_TEAMCD= ?,      \n" );
				UpdateSql.append( " MGR_TEAMNM= ?,      \n" );
				UpdateSql.append( " REG_DATE= ?,        \n" );
				UpdateSql.append( " MAIN_EMPID= ?,      \n" );
				UpdateSql.append( " SUB_EMPID= ?,       \n" );
				UpdateSql.append( " CARVE= ?,           \n" );
				UpdateSql.append( " MATERIAL= ?,        \n" );
				UpdateSql.append( " DISUSE_DATE= ?,     \n" );
				UpdateSql.append( " DISUSE_REASON= ?,   \n" );
				UpdateSql.append( " RECE_DATE= ?,       \n" );
				UpdateSql.append( " RECE_REASON= ?,     \n" );
				UpdateSql.append( " USEGB= ?,           \n" );
				UpdateSql.append( " USE_REMARK= ?,      \n" );
				UpdateSql.append( " ETC= ?,             \n" );
				UpdateSql.append( " PLACEGB= ?,         \n" );
				UpdateSql.append( " SIGNET_HEAD_NO= ?,  \n" );
				UpdateSql.append( " UPID = ?,       \n" );
				UpdateSql.append( " UPDT = CURRENT_TIMESTAMP  \n" );
				UpdateSql.append( " WHERE SIGNET_ID  = ? \n" );
				
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.SIGNET_INFO \n" );
				DeleteSql.append( " WHERE SIGNET_ID  = ? \n" );
				
				//insert statement
				InsertSql_His = new StringBuffer();
				InsertSql_His.append( " INSERT INTO ACCOUNT.SIGNET_HIS (                                 \n" );
				InsertSql_His.append( " SIGNET_ID,    SIGNET_SEQ,  WORK_GB,   MGR_TEAMCD,  MGR_TEAMNM,   \n" );
				InsertSql_His.append( " MAIN_EMPID,   SUB_EMPID,   SEND_DATE, DISUSE_DATE, DISUSE_REASON,\n" );
				InsertSql_His.append( " RECE_DATE,    RECE_REASON, USEGB,     USE_REMARK,  ETC,          \n" );
				InsertSql_His.append( " WRID, WRDT                                    \n" );
				InsertSql_His.append( " )VALUES (                                     \n" );
				InsertSql_His.append( " ?,?,?,?,?,     \n" );
				InsertSql_His.append( " ?,?,?,?,?,                                    \n" );
				InsertSql_His.append( " ?,?,?,?,?,                                    \n" );
				InsertSql_His.append( " ?,CURRENT_TIMESTAMP                           \n" );
				InsertSql_His.append( " )                                             \n" );
				
				//인감정보 데이터
				for (int j = 0; j < rows.length; j++){
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
				
						//채번시작
						Statement stmt0 = conn.createStatement();
						StringBuffer sql0 = new StringBuffer();
						sql0.append( "  SELECT LPAD(NVL(MAX(TO_NUMBER(SIGNET_ID)),0)+1,4,0) FROM ACCOUNT.SIGNET_INFO  "); 
						 
						ResultSet rs0 = stmt0.executeQuery(sql0.toString()); 
						if(rs0.next()){
							strSignet_id= rs0.getString(1);
						}
						rs0.close();
						stmt0.close();
						
						
						rows[j].setString(idxSIGNET_ID,strSignet_id);
						rows[j].setString(idxWRID, str1);
						rows[j].setString(idxWORK_GB,"1");
						//채번완료
						
						//System.out.println(InsertSql.toString());
						
						gsmt = conn.getGauceStatement(InsertSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxSIGNET_ID);
						gsmt.bindColumn(2, idxSIGNET_GB);
						gsmt.bindColumn(3, idxMGR_TEAMCD);
						gsmt.bindColumn(4, idxMGR_TEAMNM);
						gsmt.bindColumn(5, idxREG_DATE);
						gsmt.bindColumn(6, idxMAIN_EMPID);
						gsmt.bindColumn(7, idxSUB_EMPID);
						gsmt.bindColumn(8, idxCARVE);
						gsmt.bindColumn(9, idxMATERIAL);
						gsmt.bindColumn(10,idxDISUSE_DATE);
						gsmt.bindColumn(11,idxDISUSE_REASON);
						gsmt.bindColumn(12,idxRECE_DATE);
						gsmt.bindColumn(13,idxRECE_REASON);
						gsmt.bindColumn(14,idxUSEGB);
						gsmt.bindColumn(15,idxUSE_REMARK);
						gsmt.bindColumn(16,idxETC);
						gsmt.bindColumn(17,idxPLACEGB);
						gsmt.bindColumn(18,idxSIGNET_HEAD_NO);						
						gsmt.bindColumn(19,idxWRID);
												
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
						//System.out.println("insert1");
						
						
						
					}else if (rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE){
						
						//System.out.println(UpdateSql.toString());
						
						rows[j].setString(idxUPID,str1);
						rows[j].setString(idxWORK_GB,"2");
												
						gsmt = conn.getGauceStatement(UpdateSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxSIGNET_GB);
						gsmt.bindColumn(2, idxMGR_TEAMCD);
						gsmt.bindColumn(3, idxMGR_TEAMNM);
						gsmt.bindColumn(4, idxREG_DATE);
						gsmt.bindColumn(5, idxMAIN_EMPID);
						gsmt.bindColumn(6, idxSUB_EMPID);
						gsmt.bindColumn(7, idxCARVE);
						gsmt.bindColumn(8, idxMATERIAL);
						gsmt.bindColumn(9, idxDISUSE_DATE);
						gsmt.bindColumn(10,idxDISUSE_REASON);
						gsmt.bindColumn(11,idxRECE_DATE);
						gsmt.bindColumn(12,idxRECE_REASON);
						gsmt.bindColumn(13,idxUSEGB);
						gsmt.bindColumn(14,idxUSE_REMARK);
						gsmt.bindColumn(15,idxETC);
						gsmt.bindColumn(16,idxPLACEGB);
						gsmt.bindColumn(17,idxSIGNET_HEAD_NO);
						gsmt.bindColumn(18,idxUPID);
						gsmt.bindColumn(19,idxSIGNET_ID);
						
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
						//인감이력에 변경건으로 추가  INSERT 
					
			 	   }else if (rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE){
					
						//System.out.println(DeleteSql.toString());
						
						rows[j].setString(idxUPID,str1);
						rows[j].setString(idxWORK_GB,"3");
												
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxSIGNET_ID);
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
						//인감이력에 삭제 건으로 추가 INSERT 	
					}//if
					
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT||rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE||rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE){
						
						//채번시작///////////////////////////////////////////////////////////////////////////////
						Statement stmt2= conn.createStatement();
						StringBuffer sql2 = new StringBuffer();
						sql2.append( "  SELECT NVL(MAX(TO_NUMBER(SIGNET_SEQ)),0)+1 FROM ACCOUNT.SIGNET_HIS "); 
						sql2.append( "   WHERE SIGNET_ID ='"+rows[j].getString(idxSIGNET_ID)+"'"); 
						 
						ResultSet rs2 = stmt2.executeQuery(sql2.toString()); 
						if(rs2.next()){
							intSignet_Seq= rs2.getInt(1);
						}
						rs2.close();
						stmt2.close();
						
						rows[j].setInt(idxSIGNET_SEQ,intSignet_Seq);
						//채번완료///////////////////////////////////////////////////////////////////////////////
						
						//System.out.println("InsertSql_His::"+InsertSql_His.toString());
						gsmt = conn.getGauceStatement(InsertSql_His.toString());
						
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxSIGNET_ID);
						gsmt.bindColumn(2, idxSIGNET_SEQ);
						gsmt.bindColumn(3, idxWORK_GB);
						gsmt.bindColumn(4, idxMGR_TEAMCD);
						gsmt.bindColumn(5, idxMGR_TEAMNM);
						gsmt.bindColumn(6, idxMAIN_EMPID);
						gsmt.bindColumn(7, idxSUB_EMPID);
						gsmt.bindColumn(8, idxSEND_DATE);
						gsmt.bindColumn(9, idxDISUSE_DATE);
						gsmt.bindColumn(10,idxDISUSE_REASON);
						gsmt.bindColumn(11,idxRECE_DATE);
						gsmt.bindColumn(12,idxRECE_REASON);
						gsmt.bindColumn(13,idxUSEGB);
						gsmt.bindColumn(14,idxUSE_REMARK);
						gsmt.bindColumn(15,idxETC);
						gsmt.bindColumn(16,idxWRID);						
						
												
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
						//System.out.println("InsertSql_His::success");
					
					}
					
					
					
				}//for	
				
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