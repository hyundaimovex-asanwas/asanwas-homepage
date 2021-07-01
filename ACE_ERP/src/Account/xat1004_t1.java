package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class xat1004_t1 extends HttpServlet{
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
       
				GauceStatement gsmt = null;
				GauceStatement gsmt2 = null;
				GauceStatement gsmt3 = null;
				
				//String strUserid = reqGauce.getParameter("v_str1");

				GauceDataSet userSet  = reqGauce.getGauceDataSet("USER");
				
				int idxDFSCD                = userSet.indexOfColumn("DFSCD");   //1
				int idxSALEDT               = userSet.indexOfColumn("SALEDT");  //2
				int idxPOSNO                = userSet.indexOfColumn("POSNO");
				int idxRECNO                = userSet.indexOfColumn("RECNO");
				int idxGUBUN                = userSet.indexOfColumn("GUBUN");
				int idxGUBUN2               = userSet.indexOfColumn("GUBUN2");
				int idxORDTM                = userSet.indexOfColumn("ORDTM");
				int idxAPPTM                = userSet.indexOfColumn("APPTM");
				int idxGOODCD               = userSet.indexOfColumn("GOODCD");
				int idxBARCD                = userSet.indexOfColumn("BARCD");
				int idxGOODNM               = userSet.indexOfColumn("GOODNM");
				int idxGOODCNT              = userSet.indexOfColumn("GOODCNT");
				int idxBUYAMT               = userSet.indexOfColumn("BUYAMT");
				int idxTSALAMT              = userSet.indexOfColumn("TSALAMT");
				int idxDISCAMT              = userSet.indexOfColumn("DISCAMT");
				int idxDISGB                = userSet.indexOfColumn("DISGB");
				int idxSALAMT               = userSet.indexOfColumn("SALAMT");
				int idxPRIAMT               = userSet.indexOfColumn("PRIAMT");
				int idxVATAMT               = userSet.indexOfColumn("VATAMT");
				int idxADJAMT               = userSet.indexOfColumn("ADJAMT");
				int idxAPPSUM               = userSet.indexOfColumn("APPSUM");
				int idxWONAMT               = userSet.indexOfColumn("WONAMT");
				int idxCARDAMT              = userSet.indexOfColumn("CARDAMT");
				int idxCASHAMT              = userSet.indexOfColumn("CASHAMT");
				int idxCNYAMT               = userSet.indexOfColumn("CNYAMT");
				int idxCWONAMT              = userSet.indexOfColumn("CWONAMT");
				int idxUSDAMT               = userSet.indexOfColumn("USDAMT");
				int idxUWONAMT              = userSet.indexOfColumn("UWONAMT");
				int idxPNTAMT               = userSet.indexOfColumn("PNTAMT");
				int idxCARDCD               = userSet.indexOfColumn("CARDCD");
				int idxCARDNM               = userSet.indexOfColumn("CARDNM");
				int idxCREATE_ID            = userSet.indexOfColumn("CREATE_ID");
				int idxCREATE_DATE          = userSet.indexOfColumn("CREATE_DATE");
				int idxUPDATE_ID            = userSet.indexOfColumn("UPDATE_ID");
				int idxUPDATE_DATE          = userSet.indexOfColumn("UPDATE_DATE");
				
				GauceDataRow[] rows  = userSet.getDataRows();
				
				StringBuffer mergesql  = null;
				StringBuffer DeleteSql  = null;
				

				mergesql = new StringBuffer();
				mergesql.append( " MERGE INTO ACCOUNT.TBIF_POSDATA MC \n ");
				mergesql.append( " USING DUAL \n ");
				mergesql.append( " ON (  MC.DFSCD = ? AND MC.SALEDT =? AND MC.POSNO =? AND MC.RECNO =? AND MC.GOODCD =? ) \n ");
				mergesql.append( " WHEN NOT MATCHED THEN \n ");
				mergesql.append( " INSERT ( DFSCD,	SALEDT,  POSNO,   RECNO,   GUBUN,   \n ");
				mergesql.append( "          GUBUN2, ORDTM,	 APPTM,   GOODCD,  BARCD,   \n ");
				mergesql.append( "          GOODNM, GOODCNT, BUYAMT,  TSALAMT, DISCAMT, \n ");
				mergesql.append( "          DISGB,	SALAMT,  PRIAMT,  VATAMT,  ADJAMT,  \n ");
				mergesql.append( "          APPSUM, WONAMT,  CARDAMT, CASHAMT, CNYAMT,  CWONAMT, \n ");
				mergesql.append( "          USDAMT, UWONAMT, PNTAMT,  CARDCD,  CARDNM,  \n ");
				mergesql.append( "          CREATE_ID,	     CREATE_DATE )  \n ");
				
				mergesql.append( " VALUES (                           \n ");
				mergesql.append( "          ?,  ?,  ?,  ?,  ?,        \n ");
				mergesql.append( "          ?,  ?,  ?,  ?,  ?,        \n ");
				mergesql.append( "          ?,  ?,  ?,  ?,  ?,        \n ");
				mergesql.append( "          ?,  ?,  ?,  ?,  ?,        \n ");
				mergesql.append( "          ?,  ?,  ?,  ?,  ?,  ?,    \n ");
				mergesql.append( "          ?,  ?,  ?,  ?,  ?,        \n ");
				mergesql.append( "          ?,  CURRENT_TIMESTAMP )   \n ");
				
				
				for (int j = 0; j < rows.length; j++){
					//////////////////////////////////////////////////////////////////////////
					//if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					
						//rows[j].setString(idxCREATE_ID, strUserid);
					    //System.out.println("rows ::\n" + rows);
					    
					    //System.out.println("mergesql.toString()::" + mergesql.toString());
						
						//신규 생성 - A
						gsmt = conn.getGauceStatement(mergesql.toString());
						
						 
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxDFSCD);
						gsmt.bindColumn(2,  idxSALEDT);
						gsmt.bindColumn(3,  idxPOSNO);
						gsmt.bindColumn(4,  idxRECNO);
						gsmt.bindColumn(5,  idxGOODCD);
						
						gsmt.bindColumn(6,  idxDFSCD);
						gsmt.bindColumn(7,  idxSALEDT);
						gsmt.bindColumn(8,  idxPOSNO);
						gsmt.bindColumn(9,  idxRECNO);
						gsmt.bindColumn(10,  idxGUBUN);
						gsmt.bindColumn(11,  idxGUBUN2);
						gsmt.bindColumn(12,  idxORDTM);
						gsmt.bindColumn(13,  idxAPPTM);
						gsmt.bindColumn(14,  idxGOODCD);
						gsmt.bindColumn(15,  idxBARCD);
						gsmt.bindColumn(16,  idxGOODNM);
						gsmt.bindColumn(17,  idxGOODCNT);
						gsmt.bindColumn(18,  idxBUYAMT);
						gsmt.bindColumn(19,  idxTSALAMT);
						gsmt.bindColumn(20,  idxDISCAMT);
						gsmt.bindColumn(21,  idxDISGB);
						gsmt.bindColumn(22,  idxSALAMT);
						gsmt.bindColumn(23,  idxPRIAMT);
						gsmt.bindColumn(24,  idxVATAMT);
						gsmt.bindColumn(25,  idxADJAMT);
						gsmt.bindColumn(26,  idxAPPSUM);
						gsmt.bindColumn(27,  idxWONAMT);
						gsmt.bindColumn(28,  idxCARDAMT);
						gsmt.bindColumn(29,  idxCASHAMT);
						gsmt.bindColumn(30,  idxCNYAMT);
						gsmt.bindColumn(31,  idxCWONAMT);
						gsmt.bindColumn(32,  idxUSDAMT);
						gsmt.bindColumn(33,  idxUWONAMT);
						gsmt.bindColumn(34,  idxPNTAMT);
						gsmt.bindColumn(35,  idxCARDCD);
						gsmt.bindColumn(36,  idxCARDNM);
						//gsmt.bindColumn(35,  idxFDCODE);
						//gsmt.bindColumn(36,  idxFSDAT);
						//gsmt.bindColumn(37,  idxFSNBR);
						
						gsmt.bindColumn(37,  idxCREATE_ID);
						
						
						gsmt.executeUpdate();
						gsmt.close();

						gsmt=null;
						
						
					//}
				} //for	
			
			}
			catch(Exception e){
				conn.rollback();
				
				System.out.println("err::"+e);
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}
			conn.commit(); 
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			System.out.println("err Exception::"+e);
			logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
		}
	}
}