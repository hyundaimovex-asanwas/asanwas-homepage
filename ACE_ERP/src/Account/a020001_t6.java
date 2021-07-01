package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a020001_t6 extends HttpServlet{
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

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				//String str1 = reqGauce.getParameter("v_str1");
				//String str2 = reqGauce.getParameter("v_str2");
				//String str3 = reqGauce.getParameter("v_str3");
    
				//logger.dbg.println(this,"step1");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE     = userSet.indexOfColumn("FDCODE");
				int idxFSDAT      = userSet.indexOfColumn("FSDAT");
				int idxFSNBR      = userSet.indexOfColumn("FSNBR");
				int idxSEQ        = userSet.indexOfColumn("SEQ");
				int idxACCSGNID   = userSet.indexOfColumn("ACCSGNID");
				int idxEMPNO      = userSet.indexOfColumn("EMPNO");
				int idxACCSGNDAT  = userSet.indexOfColumn("ACCSGNDAT");
				int idxACCSGNEND  = userSet.indexOfColumn("ACCSGNEND");
				int idxFROMGB     = userSet.indexOfColumn("FROMGB");
				int idxTOGB       = userSet.indexOfColumn("TOGB");
				int idxBIGO       = userSet.indexOfColumn("BIGO");
				int idxBGTGB      = userSet.indexOfColumn("BGTGB");
				int idxWRDT       = userSet.indexOfColumn("WRDT");
				int idxWRID       = userSet.indexOfColumn("WRID");
				int idxUPDT       = userSet.indexOfColumn("UPDT");
				int idxUPID       = userSet.indexOfColumn("UPID");				

				//logger.dbg.println(this,"step2");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				//StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.ACTSGNSTS (  " );
				InsertSql.append( " FDCODE,    FSDAT,     FSNBR,   SEQ,  ACCSGNID, EMPNO,  " );
				InsertSql.append( " ACCSGNDAT, ACCSGNEND, FROMGB,  TOGB, BIGO, BGTGB, WRDT,   WRID )" );
				InsertSql.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?) " );

				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE  ACCOUNT.FSLIPMST SET  " );
				UpdateSql.append( "         FSSTAT =? ,           " );
				UpdateSql.append( "         UPDT =? ,           " );
				UpdateSql.append( "         UPID =?             " );
				UpdateSql.append( "  WHERE  FDCODE =?             " );
				UpdateSql.append( "    AND  FSDAT =?              " );
				UpdateSql.append( "    AND  FSNBR =?              " );
			
				String strcnt="0";
				for (int j = 0; j < rows.length; j++){

					//logger.dbg.println(this,"step44");
					//logger.dbg.println(this,"rows " + rows.length);
     
					Statement stmt0 = conn.createStatement();
					String sql0 = " SELECT NVL(MAX(SEQ),0)+1 FROM ACCOUNT.ACTSGNSTS "
								  + "	 WHERE FDCODE ='"+rows[j].getString(idxFDCODE)+"'"
								  + "	   AND FSDAT='"+rows[j].getString(idxFSDAT)+"'"
								  + "	   AND FSNBR='"+rows[j].getString(idxFSNBR)+"'"; 
					ResultSet rs0 = stmt0.executeQuery(sql0); 

					if(rs0.next()){
					  strcnt= rs0.getString(1);
					}

					int ichk = Integer.parseInt(strcnt);
					if(ichk<10) strcnt = "0"+strcnt;
					rows[j].setString(idxSEQ,strcnt);
					GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
					gsmt.setGauceDataRow(rows[j]);
					gsmt.bindColumn(1,idxFDCODE);
					gsmt.bindColumn(2,idxFSDAT);
					gsmt.bindColumn(3,idxFSNBR);
					gsmt.bindColumn(4,idxSEQ);
					gsmt.bindColumn(5,idxACCSGNID);
					gsmt.bindColumn(6,idxEMPNO);
					gsmt.bindColumn(7,idxACCSGNDAT);
					gsmt.bindColumn(8,idxACCSGNEND);
					gsmt.bindColumn(9,idxFROMGB);
					gsmt.bindColumn(10,idxTOGB);
					gsmt.bindColumn(11,idxBIGO);
					gsmt.bindColumn(12,idxBGTGB);
					gsmt.bindColumn(13,idxWRDT);
					gsmt.bindColumn(14,idxWRID);

					//logger.dbg.println(this,"step555555");

					gsmt.executeUpdate();
					gsmt.close();

					GauceStatement gsmt2 = conn.getGauceStatement(UpdateSql.toString());

					gsmt2.setGauceDataRow(rows[j]);
					gsmt2.bindColumn(1,idxACCSGNEND);
					gsmt2.bindColumn(2,idxUPDT);
					gsmt2.bindColumn(3,idxUPID);
					gsmt2.bindColumn(4,idxFDCODE);
					gsmt2.bindColumn(5,idxFSDAT);
					gsmt2.bindColumn(6,idxFSNBR);
				
					gsmt2.executeUpdate();
					gsmt2.close();

				}//for
			}
			catch(Exception e){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}

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