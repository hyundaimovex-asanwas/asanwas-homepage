package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class commrepay_t1 extends HttpServlet{
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

				double dblBjdeamt=0;
				double dblBjcramt=0;
				double dblDeamt=0;
				double dblCramt=0;
				double dblTotDeamt=0;
				double dblTotCramt=0;
				String strAtdecr="";
				
        /***************************************************************************************
         반제데이타 삭제
				*************************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");				
       
                if (userSet!= null) { // 1
					int idxFDCODE  = userSet.indexOfColumn("FDCODE");
					
					//반제정산
					int idxBTSDAT  = userSet.indexOfColumn("BTSDAT");
					int idxBTSNBR  = userSet.indexOfColumn("BTSNBR");
					int idxBTSSEQ  = userSet.indexOfColumn("BTSSEQ");
					
					//반제정산 금액
					int idxBJDEAMT = userSet.indexOfColumn("BJDEAMT");
					int idxBJCRAMT = userSet.indexOfColumn("BJCRAMT");

				  //반제원장
					int idxTSDAT   = userSet.indexOfColumn("TSDAT");
					int idxTSNBR   = userSet.indexOfColumn("TSNBR");
					int idxTSSEQ   = userSet.indexOfColumn("TSSEQ");

					int idxUPDT    = userSet.indexOfColumn("UPDT");
					int idxUPID    = userSet.indexOfColumn("UPID");

					GauceDataRow[] rows = userSet.getDataRows();	
					
					StringBuffer sql_1 = new StringBuffer();
					Statement stmt_1 = null;
					ResultSet rs_1 = null;
					StringBuffer UpdateSql_u1 = null;
					StringBuffer DeleteSql = null;
					

					////////////////////////////////////////////////////////////////////////////////////////////
					// 반제원장 조회 후 UPLOAD
					////////////////////////////////////////////////////////////////////////////////////////////
					
					for (int j=0;j<rows.length;j++){ //
						
						//System.out.println("rows.length+rows.length+j::" + j);
						//System.out.println("BTSDAT::" + rows[j].getString(idxBTSDAT)+"BTSNBR::" + rows[j].getString(idxBTSNBR)+"BTSSEQ::" + rows[j].getString(idxBTSSEQ));
						

					    dblBjdeamt=0;    
						dblBjcramt=0;   
						dblDeamt=0;     
						dblCramt=0;     
						dblTotDeamt=0;  
						dblTotCramt=0;  
						strAtdecr="";   

						//BANJAEREL 삭제
						DeleteSql = null;
						DeleteSql = new StringBuffer();
						DeleteSql.append( "  DELETE FROM ACCOUNT.BANJAEREL   ");
						DeleteSql.append( "   WHERE FDCODE='"+rows[j].getString(idxFDCODE)+"' ");
						DeleteSql.append( "     AND BTSDAT='"+rows[j].getString(idxBTSDAT)+"' ");
						DeleteSql.append( "     AND BTSNBR='"+rows[j].getString(idxBTSNBR)+"' ");
						DeleteSql.append( "     AND BTSSEQ='"+rows[j].getString(idxBTSSEQ)+"' ");
						
						//System.out.println("DeleteSql" + DeleteSql.toString());									
						GauceStatement gsmt_3 = conn.getGauceStatement(DeleteSql.toString());
						gsmt_3.executeUpdate();
						gsmt_3.close();


						//BANJSEMST를 한번 READ한 후 UPDATE 함.
						sql_1=null;
						sql_1 = new StringBuffer();
						stmt_1 = null;
						rs_1 = null;

						sql_1.append( "  SELECT A.DEAMT, A.CRAMT, B.ATDECR  ");  
						sql_1.append( "    FROM ACCOUNT.BANJAEMST A  "); 
						sql_1.append( "    LEFT JOIN ACCOUNT.ACTCODE B ON A.ATCODE = B.ATCODE  "); 
						sql_1.append( "   WHERE FDCODE='"+rows[j].getString(idxFDCODE)+"' "); 
						sql_1.append( "     AND TSDAT='"+rows[j].getString(idxTSDAT)+"' "); 
						sql_1.append( "     AND TSNBR='"+rows[j].getString(idxTSNBR)+"'"); 
						sql_1.append( "     AND TSSEQ='"+rows[j].getString(idxTSSEQ)+"'"); 
						stmt_1 = conn.createStatement();
						rs_1 = stmt_1.executeQuery(sql_1.toString());
						//System.out.println("sql_1" + sql_1.toString());	
						while(rs_1.next()){
							dblDeamt=rs_1.getDouble(1);
							dblCramt=rs_1.getDouble(2);
							strAtdecr = rs_1.getString(3);
						}

						rs_1.close();
						

						dblBjdeamt = rows[j].getDouble(idxBJDEAMT);
						dblBjcramt = rows[j].getDouble(idxBJCRAMT);

	
            
						dblTotDeamt=dblDeamt-dblBjdeamt;
						dblTotCramt=dblCramt-dblBjcramt;

						//BANJAEMST 금액 계산 후 UPDATE
						UpdateSql_u1 = null;
						UpdateSql_u1 = new StringBuffer();
						UpdateSql_u1.append( " UPDATE ACCOUNT.BANJAEMST SET " );
						UpdateSql_u1.append( "        DEAMT = "+dblTotDeamt+"," );
						UpdateSql_u1.append( "        CRAMT = "+dblTotCramt+"," );
						UpdateSql_u1.append( "        STATUS = '0'," );
						UpdateSql_u1.append( "        UPDT = '"+rows[j].getString(idxUPDT)+"'," );
						UpdateSql_u1.append( "        UPID = '"+rows[j].getString(idxUPID)+"'");
						UpdateSql_u1.append( "  WHERE FDCODE = '"+rows[j].getString(idxFDCODE)+"'");
						UpdateSql_u1.append( "    AND TSDAT = '"+rows[j].getString(idxTSDAT)+"'" );
						UpdateSql_u1.append( "    AND TSNBR = '"+rows[j].getString(idxTSNBR)+"'" );
						UpdateSql_u1.append( "    AND TSSEQ = '"+rows[j].getString(idxTSSEQ)+"'");
						
						//System.out.println("UpdateSql_u1" + UpdateSql_u1.toString());	
						GauceStatement gsmt_u1 = conn.getGauceStatement(UpdateSql_u1.toString());
						gsmt_u1.executeUpdate();
						gsmt_u1.close();
			
				 }//for j
			} //if (userSet!= null) { // 1
      
		} //try
			catch(Exception e){
				conn.rollback();
				///^^logger.err.println(this,"errno::"+strErrorNo);
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}
            conn.commit();
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			///^^logger.err.println(this,e);
			///^^logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}