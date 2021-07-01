package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a020003_t3 extends HttpServlet{
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

				String strFdcode="";
				String strTsdat="";
				String strTsnbr="";
				String strTsseq="";
				double dblBjdeamt=0;
				double dblBjcramt=0;
				double dblDeamt=0;
				double dblCramt=0;
				double dblTotDeamt=0;
				double dblTotCramt=0;

				
        /***************************************************************************************
         반제데이타 삭제
				*************************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");				
       
					if (userSet!= null) { // 1
					int idxFDCODE       = userSet.indexOfColumn("FDCODE");
					int idxBTSDAT       = userSet.indexOfColumn("BTSDAT");
					int idxBTSNBR       = userSet.indexOfColumn("BTSNBR");
					int idxTSDAT        = userSet.indexOfColumn("TSDAT");
					int idxTSNBR        = userSet.indexOfColumn("TSNBR");
					int idxTSSEQ        = userSet.indexOfColumn("TSSEQ");

					GauceDataRow[] rows = userSet.getDataRows();
					
					////////////////////////////////////////////////////////////////////////////////////////////
					// 반제연결전표 조회
					////////////////////////////////////////////////////////////////////////////////////////////
					for (int j=0;j<rows.length;j++){ //2

					  StringBuffer sql_0 = new StringBuffer();
						Statement stmt_0 = null;
						ResultSet rs_0 = null;
						
						sql_0.append( "  SELECT  FDCODE, TSDAT, TSNBR, TSSEQ, BJDEAMT, BJCRAMT ");  
						sql_0.append( "    FROM  ACCOUNT.BANJAEREL A "); 
						sql_0.append( "   WHERE  FDCODE='"+rows[j].getString(idxFDCODE)+"' "); 
						sql_0.append( "     AND  BTSDAT='"+rows[j].getString(idxBTSDAT)+"' "); 
						sql_0.append( "     AND  BTSNBR='"+rows[j].getString(idxBTSNBR)+"' "); 
						//logger.dbg.println(this,"sql_0" + sql_0.toString());
						stmt_0 = conn.createStatement();
						rs_0 = stmt_0.executeQuery(sql_0.toString());
						
					  while(rs_0.next()){
							strFdcode=""; 
							strTsdat ="";
							strTsnbr="";
							strTsseq="";
							dblBjdeamt=0;
							dblBjcramt=0;
							dblBjdeamt=0;
							dblBjcramt=0;
							dblTotDeamt=0;
							dblTotCramt=0;

							strFdcode=rs_0.getString(1);
							strTsdat=rs_0.getString(2);
							strTsnbr=rs_0.getString(3);
							strTsseq=rs_0.getString(4);
							dblBjdeamt=rs_0.getDouble(5);
							dblBjcramt=rs_0.getDouble(6);

							//BANJSEMST를 한번 READ한 후 UPDATE 함.
							StringBuffer sql_1 = new StringBuffer();
							Statement stmt_1 = null;
							ResultSet rs_1 = null;
	
							sql_1.append( "  SELECT  DEAMT, CRAMT  ");  
							sql_1.append( "    FROM  ACCOUNT.BANJAEMST A  "); 
							sql_1.append( "   WHERE  FDCODE='"+strFdcode+"' "); 
							sql_1.append( "     AND  TSDAT='"+strTsdat+"' "); 
							sql_1.append( "     AND  TSNBR='"+strTsnbr+"'"); 
							sql_1.append( "     AND  TSSEQ='"+strTsseq+"'"); 
							//logger.dbg.println(this,"sql_1" + sql_1.toString());
							stmt_1 = conn.createStatement();
							rs_1 = stmt_1.executeQuery(sql_1.toString());

							while(rs_1.next()){
								dblDeamt=rs_1.getDouble(1);
								dblCramt=rs_1.getDouble(2);
							}
								rs_1.close();

							dblTotDeamt=dblDeamt-dblBjdeamt;
							dblTotCramt=dblCramt-dblBjcramt;

							//BANJAEMST 금액 계산 후 UPDATE
							StringBuffer UpdateSql_u1 = null;
							UpdateSql_u1 = new StringBuffer();
							UpdateSql_u1.append( " UPDATE ACCOUNT.BANJAEMST SET " );
							UpdateSql_u1.append( "        DEAMT = "+dblTotDeamt+"," );
							UpdateSql_u1.append( "        CRAMT = "+dblTotCramt+"," );
							UpdateSql_u1.append( "        STATUS = '0'" );
							UpdateSql_u1.append( "  WHERE FDCODE = '"+strFdcode+"'");
							UpdateSql_u1.append( "    AND TSDAT = '"+strTsdat+"'" );
							UpdateSql_u1.append( "    AND TSNBR = '"+strTsnbr+"'" );
							UpdateSql_u1.append( "    AND TSSEQ = '"+strTsseq+"'");
							
							//logger.dbg.println(this,"UpdateSql_u1"+UpdateSql_u1.toString());
							GauceStatement gsmt_u1 = conn.getGauceStatement(UpdateSql_u1.toString());
							gsmt_u1.executeUpdate();
							gsmt_u1.close();
					}
					rs_0.close();
					
					//BANJAEREL 삭제
					StringBuffer DeleteSql = null;
					DeleteSql = new StringBuffer();
					DeleteSql.append( "  DELETE FROM ACCOUNT.BANJAEREL   ");
					DeleteSql.append( "   WHERE  FDCODE='"+rows[j].getString(idxFDCODE)+"' ");
					DeleteSql.append( "     AND  BTSDAT='"+rows[j].getString(idxBTSDAT)+"' ");
					DeleteSql.append( "     AND  BTSNBR='"+rows[j].getString(idxBTSNBR)+"' ");
				  //logger.dbg.println(this,"DeleteSql" + DeleteSql.toString());									
					GauceStatement gsmt_3 = conn.getGauceStatement(DeleteSql.toString());
					gsmt_3.executeUpdate();
					gsmt_3.close();
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