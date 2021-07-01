package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class trLoadLst extends HttpServlet{

	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceDataSet dSetMstID = null;
		GauceStatement gsmt = null ; 

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
//-----------------------------------------------------------------------------
//	Description : PARAMETER GET
//-----------------------------------------------------------------------------				
				String str1 = reqGauce.getParameter("gstr1"); 
   				if ( str1==null || str1.trim().length()==0 ) { str1=""; }
				String str2 = null ; 
                
//-----------------------------------------------------------------------------
//	Description : DataSet Index Setting
//-----------------------------------------------------------------------------	
		 
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER"); 
				
				int idxCAR_SEQ_NO     =userSet.indexOfColumn("CAR_SEQ_NO");
				int idxORDER_NO       =userSet.indexOfColumn("ORDER_NO");
				int idxORDER_SEQ      =userSet.indexOfColumn("ORDER_SEQ");
				int idxARTC_CNT       =userSet.indexOfColumn("ARTC_CNT");
				int idxPUNIT_CNT      =userSet.indexOfColumn("PUNIT_CNT");
				int idxPUNIT_WEIGHT   =userSet.indexOfColumn("PUNIT_WEIGHT");
				int idxPKG_LNGTH      =userSet.indexOfColumn("PKG_LNGTH");
				int idxPKG_HEIGHT     =userSet.indexOfColumn("PKG_HEIGHT");
				int idxPKG_WIDTH      =userSet.indexOfColumn("PKG_WIDTH");
				int idxTOTAL_CBM      =userSet.indexOfColumn("TOTAL_CBM");
				int idxTOTAL_WEIGHT   =userSet.indexOfColumn("TOTAL_WEIGHT");
				int idxSTS_CODE       =userSet.indexOfColumn("STS_CODE");
				int idxUPEND_DT       =userSet.indexOfColumn("UPEND_DT");
				int idxUPEND_TIME     =userSet.indexOfColumn("UPEND_TIME");
				int idxREMARK         =userSet.indexOfColumn("REMARK");
				int idxBAECHA_NO      =userSet.indexOfColumn("BAECHA_NO");
				int idxENTER_NO       =userSet.indexOfColumn("ENTER_NO");
				int idxCAR_NO         =userSet.indexOfColumn("CAR_NO"); 
				int idxCREATE_USR     =userSet.indexOfColumn("CREATE_USR"); 
				int idxUPDATE_UST     =userSet.indexOfColumn("UPDATE_UST");
				int idxARTC_NM        =userSet.indexOfColumn("ARTC_NM");
				int idxSTN_SZNM       =userSet.indexOfColumn("STN_SZNM");
				int idxVEND_NM        =userSet.indexOfColumn("VEND_NM");
				int idxCAR_NO1        =userSet.indexOfColumn("CAR_NO1");
				int idxPKG_CNT        =userSet.indexOfColumn("PKG_CNT");  

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;  
				StringBuffer sql = null ; 

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
 
						InsertSql = new StringBuffer();
						InsertSql.append(" INSERT INTO TRANSFER.LTLOADLST( \n ")
										 .append("		CAR_SEQ_NO,ORDER_NO,ORDER_SEQ,ARTC_CNT, \n ")
										 .append("		PUNIT_CNT,PUNIT_WEIGHT,PKG_LNGTH, \n ")
										 .append("		PKG_HEIGHT,PKG_WIDTH,TOTAL_CBM,TOTAL_WEIGHT, \n ")
										 .append("		STS_CODE,UPEND_DT,UPEND_TIME,REMARK,BAECHA_NO, \n ")
										 .append("		ENTER_NO,CAR_NO,CREATE_DT,CREATE_USR, \n ")
										 .append("		UPDATE_DT,UPDATE_UST,PKG_CNT ) \n ")
										 .append(" VALUES( \n ")
										 .append("		?,?,?,?, \n ")
										 .append("		?,?,?, \n ")
										 .append("		?,?,?,?, \n ")
										 .append("		?,?,?,?,?, \n ")
										 .append("		?,?,CURRENT TIMESTAMP,?, \n ")
										 .append("		CURRENT TIMESTAMP,?,? )");

						gsmt = conn.getGauceStatement(InsertSql.toString()); 
						gsmt.setGauceDataRow(rows[j]); 

						gsmt.bindColumn(1, idxCAR_SEQ_NO  );
						gsmt.bindColumn(2, idxORDER_NO  );
						gsmt.bindColumn(3, idxORDER_SEQ  );
						gsmt.bindColumn(4, idxARTC_CNT  );
						gsmt.bindColumn(5, idxPUNIT_CNT  );
						gsmt.bindColumn(6, idxPUNIT_WEIGHT  );
						gsmt.bindColumn(7, idxPKG_LNGTH  );
						gsmt.bindColumn(8, idxPKG_HEIGHT );
						gsmt.bindColumn(9, idxPKG_WIDTH );						 
						gsmt.bindColumn(10, idxTOTAL_CBM );
						gsmt.bindColumn(11, idxTOTAL_WEIGHT );
						gsmt.bindColumn(12, idxSTS_CODE );
						gsmt.bindColumn(13, idxUPEND_DT );
						gsmt.bindColumn(14, idxUPEND_TIME );
						gsmt.bindColumn(15, idxREMARK );
						gsmt.bindColumn(16, idxBAECHA_NO );
						gsmt.bindColumn(17, idxENTER_NO );
						gsmt.bindColumn(18, idxCAR_NO );
						gsmt.bindColumn(19, idxCREATE_USR );
						gsmt.bindColumn(20, idxUPDATE_UST );
						gsmt.bindColumn(21, idxPKG_CNT ); 

						gsmt.executeUpdate(); 
						gsmt.close();  

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append(" UPDATE TRANSFER.LTLOADLST SET ")
										 .append("		ARTC_CNT = ?,PUNIT_CNT  = ?, \n")
										 .append("		PUNIT_WEIGHT = ?,PKG_LNGTH = ?,PKG_HEIGHT = ?, \n")
										 .append(" 		PKG_WIDTH = ?,TOTAL_CBM = ?,TOTAL_WEIGHT = ?, \n")
										 .append("		STS_CODE = ?,UPEND_DT = ?,UPEND_TIME = ?, \n")
										 .append("		REMARK = ?,BAECHA_NO = ?,ENTER_NO = ?,CAR_NO = ?, \n")
										 .append("		UPDATE_DT = CURRENT TIMESTAMP,UPDATE_UST = ?,PKG_CNT = ? \n")
										 .append("	WHERE  CAR_SEQ_NO = ? \n")
										 .append("		AND ORDER_NO = ? AND \n")
										 .append("		AND  ORDER_SEQ = ? ") ; 
						
						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]); 
						
						gsmt.bindColumn(1, idxARTC_CNT  );
						gsmt.bindColumn(2, idxPUNIT_CNT  );
						gsmt.bindColumn(3, idxPUNIT_WEIGHT  );
						gsmt.bindColumn(4, idxPKG_LNGTH  );
						gsmt.bindColumn(5, idxPKG_HEIGHT );
						gsmt.bindColumn(6, idxPKG_WIDTH );						 
						gsmt.bindColumn(7, idxTOTAL_CBM );
						gsmt.bindColumn(8, idxTOTAL_WEIGHT );
						gsmt.bindColumn(9, idxSTS_CODE );
						gsmt.bindColumn(10, idxUPEND_DT );
						gsmt.bindColumn(11, idxUPEND_TIME );
						gsmt.bindColumn(12, idxREMARK );
						gsmt.bindColumn(13, idxBAECHA_NO );
						gsmt.bindColumn(14, idxENTER_NO );
						gsmt.bindColumn(15, idxCAR_NO ); 
						gsmt.bindColumn(16, idxUPDATE_UST );
						gsmt.bindColumn(17, idxPKG_CNT ); 
						gsmt.bindColumn(18, idxCAR_SEQ_NO  );
						gsmt.bindColumn(19, idxORDER_NO  );
						gsmt.bindColumn(20, idxORDER_SEQ  );
						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {

						DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM TRANSFER.LTLOADLST \n")
										 .append("	 WHERE CAR_SEQ_NO = ? AND \n")
										 .append("		 AND ORDER_NO = ? AND \n")
										 .append("		 AND  ORDER_SEQ = ? "); 

						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxCAR_SEQ_NO  );
						gsmt.bindColumn(2, idxORDER_NO  );
						gsmt.bindColumn(3, idxORDER_SEQ  );
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
			}
			catch(SQLException se){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+se.toString()+")");
				logger.err.println(this,se);
				//logger.dbg.println(this,se.toString());
			}

			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}