package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a070004_t1 extends HttpServlet{
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

				String str1 = reqGauce.getParameter("v_str1");
				String str2 = reqGauce.getParameter("v_str2");
				String str3 = reqGauce.getParameter("v_str3");
				String str4 = reqGauce.getParameter("v_str4");
				String str5 = reqGauce.getParameter("v_str5");
				String str6 = reqGauce.getParameter("v_str6");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE  = userSet.indexOfColumn("FDCODE");		 
				int idxACYYMM  = userSet.indexOfColumn("ACYYMM");		 
				int idxDEPTCD  = userSet.indexOfColumn("DEPTCD");		 
				int idxREMCODE = userSet.indexOfColumn("REMCODE");	 
				int idxAMTDIV  = userSet.indexOfColumn("AMTDIV");		 
				int idxPLAMT   = userSet.indexOfColumn("PLAMT");		 
				int idxEXAMT   = userSet.indexOfColumn("EXAMT");		 
				int idxREMARK  = userSet.indexOfColumn("REMARK");		 
				int idxEXDATE  = userSet.indexOfColumn("EXDATE");		 
				int idxSTATDIV = userSet.indexOfColumn("STATDIV");	 
				int idxVENDCD  = userSet.indexOfColumn("VENDCD");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO ACCOUNT.AFUNDMON  (					\n");
						InsertSql.append( "  FDCODE,ACYYMM,DEPTCD,REMCODE,AMTDIV,		\n");
						InsertSql.append( "  PLAMT,EXAMT,REMARK,EXDATE,STATDIV,VENDCD,UPDT,UPID	\n");
						InsertSql.append( " ) VALUES (														\n");
						InsertSql.append( " '"+str1+"','"+str2+"','"+str3+"',				\n");
						InsertSql.append( " '"+rows[j].getString(idxREMCODE)+"',	\n");
						InsertSql.append( " '"+rows[j].getString(idxAMTDIV)+"',		\n");
						InsertSql.append( "  "+rows[j].getString(idxPLAMT)+",			\n");
						InsertSql.append( "  "+rows[j].getString(idxEXAMT)+",			\n");
						InsertSql.append( " '"+rows[j].getString(idxREMARK)+"',		\n");
						InsertSql.append( " '"+rows[j].getString(idxEXDATE)+"',		\n");
						InsertSql.append( " '"+rows[j].getString(idxSTATDIV)+"',		\n");
						InsertSql.append( " '"+rows[j].getString(idxVENDCD)+"',		\n");
						InsertSql.append( " '"+str4+"','"+str5+"' 		\n");
						InsertSql.append( " )									    \n");

						
						//System.out.println("a070004_t1"+InsertSql.toString());
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE ACCOUNT.AFUNDMON SET " );
						UpdateSql.append( "        PLAMT   = "+rows[j].getString(idxPLAMT)+",			" );
						UpdateSql.append( "        EXAMT   = "+rows[j].getString(idxEXAMT)+",			" );
						UpdateSql.append( "        REMARK  = '"+rows[j].getString(idxREMARK)+"',		" );
						UpdateSql.append( "        EXDATE  = '"+rows[j].getString(idxEXDATE)+"',		" );
						UpdateSql.append( "        STATDIV = '"+rows[j].getString(idxSTATDIV)+"',		" );
						UpdateSql.append( "        UPDT ='"+str4+"',	UPID ='"+str5+"'				" );
						UpdateSql.append( " WHERE  FDCODE='"+str1+"'	AND ACYYMM='"+str2+"'			" );
						UpdateSql.append( "   AND  DEPTCD='"+str3+"'								    " );
						UpdateSql.append( "   AND  REMCODE='"+rows[j].getString(idxREMCODE)+"'		    " );
						UpdateSql.append( "   AND  AMTDIV ='"+rows[j].getString(idxAMTDIV)+"'			" );
						UpdateSql.append( "   AND  VENDCD ='"+rows[j].getString(idxVENDCD)+"'			" );

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM ACCOUNT.AFUNDMON										" );	
						DeleteSql.append( " WHERE  FDCODE='"+str1+"'	AND ACYYMM='"+str2+"'		 		" );
						DeleteSql.append( "   AND  DEPTCD='"+str3+"'													 	" );
						DeleteSql.append( "   AND  REMCODE='"+rows[j].getString(idxREMCODE)+"' 				" );
						DeleteSql.append( "   AND  AMTDIV ='"+rows[j].getString(idxAMTDIV)+"'	 					" );
						DeleteSql.append( "   AND  VENDCD ='"+rows[j].getString(idxVENDCD)+"'	 					" );

						
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
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