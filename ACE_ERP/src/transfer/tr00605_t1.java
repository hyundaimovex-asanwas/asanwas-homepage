package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class tr00605_t1 extends HttpServlet{

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

				String str1 = reqGauce.getParameter("v_str1");
				String str2 = reqGauce.getParameter("v_str2");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxUSERID      = userSet.indexOfColumn("USERID");
				int idxUSERPW      = userSet.indexOfColumn("USERPW");
				int idxUSERNM      = userSet.indexOfColumn("USERNM");
				int idxREGNO       = userSet.indexOfColumn("REGNO");
				int idxZIPCD       = userSet.indexOfColumn("ZIPCD");
				int idxADDR1       = userSet.indexOfColumn("ADDR1");
				int idxADDR2       = userSet.indexOfColumn("ADDR2");
				int idxREGNM       = userSet.indexOfColumn("REGNM");
				int idxTEL1        = userSet.indexOfColumn("TEL1");
				int idxTEL2        = userSet.indexOfColumn("TEL2");
				int idxTEL3        = userSet.indexOfColumn("TEL3");
				int idxFAX1        = userSet.indexOfColumn("FAX1");
				int idxFAX2        = userSet.indexOfColumn("FAX2");
				int idxFAX3        = userSet.indexOfColumn("FAX3");
				int idxMOBILE1     = userSet.indexOfColumn("MOBILE1");
				int idxMOBILE2     = userSet.indexOfColumn("MOBILE2");
				int idxMOBILE3     = userSet.indexOfColumn("MOBILE3");
				int idxEMAIL       = userSet.indexOfColumn("EMAIL");
				int idxRELPART     = userSet.indexOfColumn("RELPART");
				int idxCREATE_DT   = userSet.indexOfColumn("CREATE_DT");
				int idxCREATE_USR  = userSet.indexOfColumn("CREATE_USR");
				int idxUPDATE_DT   = userSet.indexOfColumn("UPDATE_DT");
				int idxUPDATE_UST  = userSet.indexOfColumn("UPDATE_UST");
				int idxTEMPFLAG	    = userSet.indexOfColumn("TEMPFLAG");
				int idxUSER_DIV	    = userSet.indexOfColumn("USER_DIV");
	
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO TRANSFER.LTUSER                    (  \n" )
						 .append( " USERID,USERPW,USERNM,REGNO,ZIPCD,                 \n" )
						 .append( " ADDR1,ADDR2,REGNM,TEL1,TEL2,                      \n" )
						 .append( " TEL3,FAX1,FAX2,FAX3,MOBILE1,                      \n" )
						 .append( " MOBILE2,MOBILE3,EMAIL,RELPART,CREATE_DT,          \n" )
						 .append( " CREATE_USR,UPDATE_DT,UPDATE_UST,TEMPFLAG,         \n" )
						 .append( " USER_DIV)  \n" )
						 .append( " VALUES (  \n" )
						 .append( " ?, ?, ?, ?, ?,                        \n" )
						 .append( " ?, ?, ?, ?, ?,                        \n" )
						 .append( " ?, ?, ?, ?, ?,                        \n" )
						 .append( " ?, ?, ?, ?,                           \n" )
						 .append( " CURRENT_TIMESTAMP, '"	+ str1 + "',  \n" )
						 .append( " CURRENT_TIMESTAMP, '"	+ str2 + "',?,  " )
						 .append( " ? ) " );


				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE TRANSFER.LTUSER SET \n" )
						 .append( "        USERPW		= ?, \n" )
						 .append( "        USERNM		= ?, \n" )
						 .append( "        REGNO		= ?, \n" )
						 .append( "        ZIPCD		= ?, \n" )
						 .append( "        ADDR1		= ?, \n" )
						 .append( "        ADDR2		= ?, \n" )
						 .append( "        REGNM		= ?, \n" )
						 .append( "        TEL1			= ?, \n" )
						 .append( "        TEL2			= ?, \n" )
						 .append( "        TEL3			= ?, \n" )
						 .append( "        FAX1			= ?, \n" )
						 .append( "        FAX2			= ?, \n" )
						 .append( "        FAX3			= ?, \n" )
						 .append( "        MOBILE1	= ?, \n" )
						 .append( "        MOBILE2	= ?, \n" )
						 .append( "        MOBILE3	= ?, \n" )
						 .append( "        EMAIL		= ?, \n" )
						 .append( "        RELPART	= ?, \n" )
						 .append( "        UPDATE_DT = CURRENT_TIMESTAMP, \n" )
						 .append( "        UPDATE_UST  = '" + str1 + "', \n" )
						 .append( "        TEMPFLAG	= ?, \n" )
						 .append( "        USER_DIV	= ? \n" )
						 .append( " WHERE USERID = ? " );
				
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM TRANSFER.LTUSER \n" )
								 .append( " WHERE USERID = ? " );
		
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxUSERID);
						gsmt.bindColumn(2,  idxUSERPW);
						gsmt.bindColumn(3,  idxUSERNM);
						gsmt.bindColumn(4,  idxREGNO);
						gsmt.bindColumn(5,  idxZIPCD);
						gsmt.bindColumn(6,  idxADDR1);
						gsmt.bindColumn(7,  idxADDR2);
						gsmt.bindColumn(8,  idxREGNM);
						gsmt.bindColumn(9,  idxTEL1);
						gsmt.bindColumn(10, idxTEL2);
						gsmt.bindColumn(11,  idxTEL3);
						gsmt.bindColumn(12,  idxFAX1);
						gsmt.bindColumn(13,  idxFAX2);
						gsmt.bindColumn(14,  idxFAX3);
						gsmt.bindColumn(15,  idxMOBILE1);
						gsmt.bindColumn(16,  idxMOBILE2);
						gsmt.bindColumn(17,  idxMOBILE3);
						gsmt.bindColumn(18,  idxEMAIL);
						gsmt.bindColumn(19,  idxRELPART);
						gsmt.bindColumn(20,  idxTEMPFLAG);
						gsmt.bindColumn(21,  idxUSER_DIV);
						
						gsmt.executeUpdate();
						gsmt.close();

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,  idxUSERPW);
						gsmt.bindColumn(2,  idxUSERNM);
						gsmt.bindColumn(3,  idxREGNO);
						gsmt.bindColumn(4,  idxZIPCD);
						gsmt.bindColumn(5,  idxADDR1);
						gsmt.bindColumn(6,  idxADDR2);
						gsmt.bindColumn(7,  idxREGNM);
						gsmt.bindColumn(8,  idxTEL1);
						gsmt.bindColumn(9,  idxTEL2);
						gsmt.bindColumn(10,  idxTEL3);
						gsmt.bindColumn(11,  idxFAX1);
						gsmt.bindColumn(12,  idxFAX2);
						gsmt.bindColumn(13,  idxFAX3);
						gsmt.bindColumn(14,  idxMOBILE1);
						gsmt.bindColumn(15,  idxMOBILE2);
						gsmt.bindColumn(16,  idxMOBILE3);
						gsmt.bindColumn(17,  idxEMAIL);
						gsmt.bindColumn(18,  idxRELPART);
						gsmt.bindColumn(19,  idxTEMPFLAG);
						gsmt.bindColumn(20,  idxUSER_DIV);
						gsmt.bindColumn(21,  idxUSERID);
						
						gsmt.executeUpdate(); 
						gsmt.close();         

					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxUSERID);
					
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
			}
			catch(Exception e){
				logger.err.println(this,e.toString());	
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