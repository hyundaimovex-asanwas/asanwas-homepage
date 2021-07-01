package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class tr00515_t1 extends HttpServlet{

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

				int idxLINE_PART   = userSet.indexOfColumn("LINE_PART");
				int idxPROJECT     = userSet.indexOfColumn("PROJECT");
				int idxTR_PROJECT  = userSet.indexOfColumn("TR_PROJECT");
				int idxPROJECT_NM  = userSet.indexOfColumn("PROJECT_NM");
				int idxDETAIL_NM   = userSet.indexOfColumn("DETAIL_NM");

				int idxCONT_NM     = userSet.indexOfColumn("CONT_NM");
				int idxCONT_DT     = userSet.indexOfColumn("CONT_DT");
				int idxCONT_OWN    = userSet.indexOfColumn("CONT_OWN");
				int idxCONT_AMT    = userSet.indexOfColumn("CONT_AMT");
				int idxCONT_PED    = userSet.indexOfColumn("CONT_PED");

				int idxCONT_DESC   = userSet.indexOfColumn("CONT_DESC");
				int idxSTAY_DIV    = userSet.indexOfColumn("STAY_DIV");
				int idxFOOD_DIV    = userSet.indexOfColumn("FOOD_DIV");
				int idxTRANS_DIV   = userSet.indexOfColumn("TRANS_DIV");
				int idxUSE_STS     = userSet.indexOfColumn("USE_STS");

				int idxREMARK      = userSet.indexOfColumn("REMARK");
				int idxCREATE_DT   = userSet.indexOfColumn("CREATE_DT");
				int idxCREATE_USR  = userSet.indexOfColumn("CREATE_USR");
				int idxUPDATE_DT   = userSet.indexOfColumn("UPDATE_DT");
				int idxUPDATE_USR  = userSet.indexOfColumn("UPDATE_USR");
				int idxDSP_SORT		 = userSet.indexOfColumn("DSP_SORT");
			
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				
				InsertSql = new StringBuffer();

				InsertSql.append( " INSERT INTO TRANSFER.LTUNTCOD ( \n" )
								 .append( " LINE_PART, PROJECT, TR_PROJECT, PROJECT_NM, DETAIL_NM, \n" )
								 .append( " CONT_NM, CONT_DT, CONT_OWN, CONT_AMT, CONT_PED, \n" )
								 .append( " CONT_DESC, STAY_DIV, FOOD_DIV,TRANS_DIV,USE_STS, \n" )
								 .append( " REMARK, CREATE_DT, CREATE_USR, UPDATE_DT, UPDATE_USR, \n" )
								 .append( " DSP_SORT \n" )
								 .append( " ) VALUES ( \n" )
								 .append( " ?, ?, ?, ?, ?, \n" )
								 .append( " ?, ?, ?, ?, ?, \n" )
								 .append( " ?, ?, ?, ?, ?, \n" )
								 .append( " ?, \n" )
								 .append( " CURRENT TIMESTAMP, '"	+ str1 + "', \n" )
								 .append( " CURRENT TIMESTAMP, '"	+ str2 + "', \n" )
								 .append( " ? ) \n" );
	
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE TRANSFER.LTUNTCOD SET \n" )
								 .append( "        PROJECT_NM = ?, \n" )
								 .append( "        DETAIL_NM	= ?, \n" )
								 .append( "        CONT_NM		= ?, \n" )
								 .append( "        CONT_DT		= ?, \n" )
								 .append( "        CONT_OWN		= ?, \n" )
								 .append( "        CONT_AMT		= ?, \n" )
								 .append( "        CONT_PED		= ?, \n" )
								 .append( "        CONT_DESC	= ?, \n" )
								 .append( "        STAY_DIV		= ?, \n" )
								 .append( "        FOOD_DIV		= ?, \n" )
								 .append( "        TRANS_DIV	= ?, \n" )
								 .append( "        USE_STS		= ?, \n" )
								 .append( "        REMARK			= ?, \n" )
								 .append( "        UPDATE_DT	= CURRENT TIMESTAMP, \n" )
								 .append( "        UPDATE_USR = '" + str1 + "', \n" )
								 .append( "        DSP_SORT		= ? \n" )
								 .append( "  WHERE LINE_PART	= ? \n" )
								 .append( "    AND PROJECT		= ? \n" )
								 .append( "    AND TR_PROJECT = ? \n" );
				
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM TRANSFER.LTUNTCOD \n" )
								 .append( " WHERE LINE_PART  = ? \n" )
								 .append( "   AND PROJECT		 = ? \n" )
								 .append( "   AND TR_PROJECT = ? \n" );
			
				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());

						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idxLINE_PART);
						gsmt.bindColumn(2,  idxPROJECT);
						gsmt.bindColumn(3,  idxTR_PROJECT);
						gsmt.bindColumn(4,  idxPROJECT_NM);
						gsmt.bindColumn(5,  idxDETAIL_NM);
						gsmt.bindColumn(6,  idxCONT_NM);
						gsmt.bindColumn(7,  idxCONT_DT);
						gsmt.bindColumn(8,  idxCONT_OWN);
						gsmt.bindColumn(9,  idxCONT_AMT);
						gsmt.bindColumn(10, idxCONT_PED);
						gsmt.bindColumn(11, idxCONT_DESC);
						gsmt.bindColumn(12, idxSTAY_DIV);
						gsmt.bindColumn(13, idxFOOD_DIV);
						gsmt.bindColumn(14, idxTRANS_DIV);
						gsmt.bindColumn(15, idxUSE_STS);
						gsmt.bindColumn(16, idxREMARK);
						gsmt.bindColumn(17, idxDSP_SORT);

						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,  idxPROJECT_NM);
						gsmt.bindColumn(2,  idxDETAIL_NM);
						gsmt.bindColumn(3,  idxCONT_NM);
						gsmt.bindColumn(4,  idxCONT_DT);
						gsmt.bindColumn(5,  idxCONT_OWN);
						gsmt.bindColumn(6,  idxCONT_AMT);
						gsmt.bindColumn(7,  idxCONT_PED);
						gsmt.bindColumn(8,  idxCONT_DESC);
						gsmt.bindColumn(9,  idxSTAY_DIV);
						gsmt.bindColumn(10, idxFOOD_DIV);
						gsmt.bindColumn(11, idxTRANS_DIV);
						gsmt.bindColumn(12, idxUSE_STS);
						gsmt.bindColumn(13, idxREMARK);
						gsmt.bindColumn(14, idxDSP_SORT);
						gsmt.bindColumn(15,  idxLINE_PART);
						gsmt.bindColumn(16,  idxPROJECT);
						gsmt.bindColumn(17,  idxTR_PROJECT);
		
						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxLINE_PART);
						gsmt.bindColumn(2,  idxPROJECT);
						gsmt.bindColumn(3,  idxTR_PROJECT);
						
						gsmt.executeUpdate();
						gsmt.close();
						logger.err.println(this,DeleteSql.toString());
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