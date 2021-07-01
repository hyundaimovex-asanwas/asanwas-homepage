package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class reguser_t01 extends HttpServlet{

	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection gconn = null;

		try{
			loader = new ServiceLoader(req, res);
	 		service = loader.newService();
	 		context = service.getContext();
	 		logger = context.getLogger();
	 		GauceRequest GauceReq = null;
	 		GauceResponse GauceRes = null;

			try {
				gconn = service.getDBConnection();

				GauceReq = service.getGauceRequest();
				GauceRes = service.getGauceResponse();

				GauceDataSet userSet = GauceReq.getGauceDataSet("USER");

				String gstr1 = GauceReq.getParameter("vstr1");
				if (gstr1==null || gstr1.equals("")) gstr1 = "";

				String[] strArrCN = new String[]{ "USERID","USERPW","USERNM","REGNO","ZIPCD",
																					"ADDR1","ADDR2","REGNM","TEL1","TEL2",
																					"TEL3","FAX1","FAX2","FAX3","MOBILE1",
																					"MOBILE2","MOBILE3","EMAIL","RELPART"
																				}; 
				int[] idx = new int[19];
        for (int i=0; i<strArrCN.length; i++) {
  				idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql	= null;
				StringBuffer UpdateSql	= null;
				StringBuffer DeleteSql	= null;

				for (int j = 0; j < rows.length; j++){
					String sa[] = new String[19];
					for (int k=0; k<19; k++) sa[k] = rows[j].getString(idx[k]);

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						InsertSql		= new StringBuffer();
						InsertSql.append( " INSERT INTO TRANSFER.LTUSER \n" )
										 .append( " ( " )
										 .append( "		USERID, USERPW, USERNM, REGNO, ZIPCD, \n")
										 .append( "		ADDR1, ADDR2, REGNM, TEL1, TEL2, \n")
										 .append( "		TEL3, FAX1, FAX2, FAX3, MOBILE1, \n")
										 .append( "		MOBILE2, MOBILE3, EMAIL, RELPART \n")
										 .append( " ) VALUES ( \n" )
										 .append( " UPPER('" + sa[0] + "'), '"+sa[1]+"', '"+sa[2]+"', '"+sa[3]+"', '"+sa[4]+"', \n")
										 .append( " '"+sa[5]+"', '"+sa[6]+"', '"+sa[7]+"', '"+sa[8]+"', '"+sa[9]+"', \n")
										 .append( " '"+sa[10]+"', '"+sa[11]+"', '"+sa[12]+"', '"+sa[13]+"', '"+sa[14]+"', \n")
										 .append( " '"+sa[15]+"', '"+sa[16]+"', '"+sa[17]+"', '"+sa[18]+"') \n");

						GauceStatement gstmt = gconn.getGauceStatement(InsertSql.toString());
						gstmt.executeUpdate(); 
						gstmt.close();
					}
	
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql		= new StringBuffer();
						UpdateSql.append( " UPDATE TRANSFER.LTUSER	\n" )
										 .append( "    SET USERNM			= '" + sa[2] + "', \n" )
										 .append( "				 ZIPCD			= '" + sa[4] + "', \n" )
										 .append( "				 ADDR1			= '" + sa[5] + "', \n" )
										 .append( "				 ADDR2			= '" + sa[6] + "', \n" )
										 .append( "				 REGNM			= '" + sa[7] + "', \n" )
										 .append( "				 TEL1				= '" + sa[8] + "', \n" )
										 .append( "				 TEL2				= '" + sa[9] + "', \n" )
										 .append( "				 TEL3				= '" + sa[10] + "', \n" )
										 .append( "				 FAX1				= '" + sa[11] + "', \n" )
										 .append( "				 FAX2				= '" + sa[12] + "', \n" )
										 .append( "				 FAX3				= '" + sa[13] + "', \n" )
										 .append( "				 MOBILE1		= '" + sa[14] + "', \n" )
										 .append( "				 MOBILE2		= '" + sa[15] + "', \n" )
										 .append( "				 MOBILE3		= '" + sa[16] + "', \n" )
										 .append( "				 EMAIL			= '" + sa[17] + "', \n" )
										 .append( "				 RELPART		= '" + sa[18] + "', \n" );

						if (!gstr1.equals("")) UpdateSql.append( " USERPW = '" + gstr1 + "', \n");

						UpdateSql.append( "				 UPDATE_DT	= CURRENT TIMESTAMP \n" )
										 .append( "  WHERE USERID			= UPPER('" + sa[0] + "')  " );

						GauceStatement gstmt = gconn.getGauceStatement(UpdateSql.toString());
						gstmt.executeUpdate();
						gstmt.close();
	
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql		= new StringBuffer();
						DeleteSql.append( " DELETE FROM TRANSFER.LTUSER WHERE USERID = UPPER('" + sa[0] + "') " );

						GauceStatement gstmt = gconn.getGauceStatement(DeleteSql.toString());
						gstmt.executeUpdate();
	
					}
				}
			}

			catch(Exception e){
				GauceRes.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}


			GauceRes.flush();
			GauceRes.commit();
			GauceRes.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		}
		finally {
			if (gconn != null) {	try {	gconn.close();	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}