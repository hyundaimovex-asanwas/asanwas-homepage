package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a020001_t3f extends HttpServlet{
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
			String strErrorNo ="";
			String strFdcode="";
			String strFsdat="";
			String strFsnbr="";
			String strFsseq="";
			String strAcnnbr="";

			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

        /************************************************************************************
         @ 전표 DETAIL //전표관리항목 // TAXMST //TAXDTL
				*************************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				logger.dbg.println(this,"start");

				int idxFDCODE       = userSet.indexOfColumn("FDCODE");  
				int idxFSDAT        = userSet.indexOfColumn("FSDAT");   
				int idxFSNBR        = userSet.indexOfColumn("FSNBR");  
				int idxFSSEQ        = userSet.indexOfColumn("FSSEQ");
				
				GauceDataRow[] rows = userSet.getDataRows();
				
				StringBuffer DeleteSql_DTL = null;
				StringBuffer DeleteSql_REF = null;
				StringBuffer DeleteTAX_MST = null;
				StringBuffer DeleteTAX_DTL = null;
			
				DeleteSql_DTL = new StringBuffer();
				DeleteSql_REF = new StringBuffer();
				DeleteTAX_MST = new StringBuffer();
				DeleteTAX_DTL = new StringBuffer();

				DeleteSql_DTL.append( " DELETE FROM  ACCOUNT.FSLIPDTL  " );
				DeleteSql_DTL.append( "  WHERE FDCODE = ? " );
				DeleteSql_DTL.append( "    AND FSDAT = ? " );
				DeleteSql_DTL.append( "    AND FSNBR = ? " );
				DeleteSql_DTL.append( "    AND FSSEQ = ? " );
				
				DeleteSql_REF.append( " DELETE FROM  ACCOUNT.FSLIPREF  " );
				DeleteSql_REF.append( "  WHERE FDCODE = ? " );
				DeleteSql_REF.append( "    AND FSDAT = ? " );
				DeleteSql_REF.append( "    AND FSNBR = ? " );
				DeleteSql_REF.append( "    AND FSSEQ = ? " );

				//logger.dbg.println(this,"step1");
				for (int j=0;j<rows.length; j++){
					 	logger.dbg.println(this,"step2::j::" +  j );
						strFdcode = rows[j].getString(idxFDCODE);
						strFsdat  = rows[j].getString(idxFSDAT);
						strFsnbr  = rows[j].getString(idxFSNBR);
						strFsseq  = rows[j].getString(idxFSSEQ);

						//logger.dbg.println(this,"strFdcode::"+strFdcode+"::strFsdat::"+strFsdat+"::strFsnbr::"+strFsnbr+"::strFsseq::"+strFsseq);
						
						//DETAIL의 건수 만큼 돌려서 계산서 번호를 찾아내어 존재하면 계산서 delete 시킴
						StringBuffer sql = new StringBuffer();
						Statement stmt = null;
						ResultSet rs = null;
						sql.append( " SELECT COALESCE(ACNNBR,'') 					");
						sql.append( "   FROM ACCOUNT.FSLIPDTL     	 				");
						sql.append( "  WHERE FDCODE ='"+strFdcode+"' 				");
						sql.append( "    AND FSDAT ='"+strFsdat+"' 						");
						sql.append( "    AND FSNBR ='"+strFsnbr+"' 						");
						sql.append( "    AND FSSEQ ='"+strFsseq+"' 					");
						
						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());
						//logger.dbg.println(this,"step3");
						while(rs.next())	{
							strAcnnbr = rs.getString(1);
							//logger.dbg.println(this,"strAcnnbr"+strAcnnbr);
							if (!strAcnnbr.equals("")){
								//logger.dbg.println(this,"step4");
								DeleteTAX_MST.append( " DELETE FROM  ACCOUNT.ATTAXMST   " );
								DeleteTAX_MST.append( "  WHERE TAXNBR = '"+strAcnnbr+"' " );

								GauceStatement gsmt11 = conn.getGauceStatement(DeleteTAX_MST.toString());
								gsmt11.executeUpdate(); 
								gsmt11.close();         

								DeleteTAX_DTL.append( " DELETE FROM  ACCOUNT.ATTAXDTL  " );
								DeleteTAX_DTL.append( "  WHERE TAXNBR ='"+strAcnnbr+"' " );
								
								GauceStatement gsmt12 = conn.getGauceStatement(DeleteTAX_DTL.toString());
								gsmt12.executeUpdate(); 
								gsmt12.close();         
							}
						}
               
						//logger.dbg.println(this,"step7");
						//전표Detail
						GauceStatement gsmt13 = conn.getGauceStatement(DeleteSql_DTL.toString());
						gsmt13.setGauceDataRow(rows[j]);
					
						gsmt13.bindColumn(1, idxFDCODE);
						gsmt13.bindColumn(2, idxFSDAT);
						gsmt13.bindColumn(3, idxFSNBR);
						gsmt13.bindColumn(4, idxFSSEQ);
            
						gsmt13.executeUpdate();
						gsmt13.close();

						//전표관리항목
						GauceStatement gsmt14 = conn.getGauceStatement(DeleteSql_REF.toString());
						gsmt14.setGauceDataRow(rows[j]);
					
						gsmt14.bindColumn(1, idxFDCODE);
						gsmt14.bindColumn(2, idxFSDAT);
						gsmt14.bindColumn(3, idxFSNBR);
						gsmt14.bindColumn(4, idxFSSEQ);
            
						gsmt14.executeUpdate();
						gsmt14.close();

					  //logger.dbg.println(this,"step9");
				}
        
			} //try
			catch(Exception e){
				conn.rollback();
				logger.err.println(this,"errno::"+strErrorNo);
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