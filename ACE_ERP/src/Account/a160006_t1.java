package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a160006_t1 extends HttpServlet{
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
				
				String str1 = reqGauce.getParameter("v_str1"); //년도 
				String str2 = reqGauce.getParameter("v_str2"); //월 
				
				//System.out.println("str1::"+str1);
				//System.out.println("str2::"+str2);
			

				GauceDataSet userSet  = reqGauce.getGauceDataSet("USER");

				int idxYYYY            = userSet.indexOfColumn("YYYY");
				int idxINC_MM          = userSet.indexOfColumn("INC_MM");
				int idxINC_SEQ         = userSet.indexOfColumn("INC_SEQ");
				int idxPAY_DT          = userSet.indexOfColumn("PAY_DT");
				int idxCO_CRNO         = userSet.indexOfColumn("CO_CRNO");
				int idxCO_NO           = userSet.indexOfColumn("CO_NO");
				int idxCO_NM           = userSet.indexOfColumn("CO_NM");
				int idxCO_RENM         = userSet.indexOfColumn("CO_RENM");
				int idxCO_AD           = userSet.indexOfColumn("CO_AD");
				int idxEA_NM           = userSet.indexOfColumn("EA_NM");
				int idxEA_NO           = userSet.indexOfColumn("EA_NO");
				int idxEA_AD           = userSet.indexOfColumn("EA_AD");
				int idxTOT_AMT         = userSet.indexOfColumn("TOT_AMT");
				int idxEXP_AMT         = userSet.indexOfColumn("EXP_AMT");
				int idxINC_AMT         = userSet.indexOfColumn("INC_AMT");
				int idxTAX_RATE        = userSet.indexOfColumn("TAX_RATE");
				int idxINC_TAX         = userSet.indexOfColumn("INC_TAX");
				int idxLINC_TAX        = userSet.indexOfColumn("LINC_TAX");
				int idxFVS_TAX         = userSet.indexOfColumn("FVS_TAX");
				int idxSUM_AMT         = userSet.indexOfColumn("SUM_AMT");
				int idxINOUT_GB        = userSet.indexOfColumn("INOUT_GB");
				int idxINCOME_GB       = userSet.indexOfColumn("INCOME_GB");
				int idxCREATE_ID       = userSet.indexOfColumn("CREATE_ID");
				int idxCREATE_DATE     = userSet.indexOfColumn("CREATE_DATE");
				int idxUPDATE_ID       = userSet.indexOfColumn("UPDATE_ID");
				int idxUPDATE_DATE     = userSet.indexOfColumn("UPDATE_DATE");
				
			

				GauceDataRow[] rows  = userSet.getDataRows();
				StringBuffer InsertSql  = null;
				StringBuffer DeleteSql  = null;
			
				InsertSql = new StringBuffer();

				InsertSql.append( " INSERT INTO ACCOUNT.PINCOME  (                                           \n " );
				InsertSql.append( "	       YYYY,	    INC_MM,	        INC_SEQ,	PAY_DT,	        CO_CRNO, \n " );
				InsertSql.append( "	       CO_NO,	    CO_NM,	        CO_RENM,	CO_AD,	        EA_NM,	 \n " );
				InsertSql.append( "        EA_NO,	    EA_AD,	       	TOT_AMT,    EXP_AMT,	    INC_AMT, \n " );
				InsertSql.append( "        TAX_RATE,	INC_TAX,	    LINC_TAX,   FVS_TAX,        SUM_AMT, \n " );
				InsertSql.append( "        INOUT_GB,	INCOME_GB,                                           \n " );
				InsertSql.append( "        CREATE_ID,	CREATE_DATE,	UPDATE_ID,	UPDATE_DATE              \n " );
				InsertSql.append( " ) VALUES ( \n " );
				InsertSql.append( "        ?,?,?,?,?, \n " );
				InsertSql.append( "        ?,?,?,?,?, \n " );
				InsertSql.append( "        ?,?,?,?,?, \n " );
				InsertSql.append( "        ?,?,?,?,?, \n " );
				InsertSql.append( "        ?,?,       \n " );
				InsertSql.append( "        ?,CURRENT_TIMESTAMP,?,CURRENT_TIMESTAMP    \n " );
				InsertSql.append( "        ) \n " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.PINCOME WHERE YYYY = ? AND INC_MM=?  \n " );

			
				for (int j = 0; j < rows.length; j++){
					//////////////////////////////////////////////////////////////////////////
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						//삭제
						/**
						rows[j].setString(idxYYYY,str1);
						rows[j].setString(idxINC_MM,str2);
						
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxYYYY);   
						gsmt.bindColumn(2,  idxINC_MM);  
						
						gsmt.executeUpdate();
						gsmt.close();

						gsmt=null;
						**/
					
						//신규 생성 - A
						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxYYYY);   
						gsmt.bindColumn(2,  idxINC_MM); 
						gsmt.bindColumn(3,  idxINC_SEQ); 
						gsmt.bindColumn(4,  idxPAY_DT); 
						gsmt.bindColumn(5,  idxCO_CRNO); 
						gsmt.bindColumn(6,  idxCO_NO);   
						gsmt.bindColumn(7,  idxCO_NM); 
						gsmt.bindColumn(8,  idxCO_RENM); 
						gsmt.bindColumn(9,  idxCO_AD); 
						gsmt.bindColumn(10,  idxEA_NM); 
						gsmt.bindColumn(11,  idxEA_NO);   
						gsmt.bindColumn(12,  idxEA_AD); 
						gsmt.bindColumn(13,  idxTOT_AMT);
						gsmt.bindColumn(14,  idxEXP_AMT);
						gsmt.bindColumn(15,  idxINC_AMT);
						gsmt.bindColumn(16,  idxTAX_RATE); 
						gsmt.bindColumn(17,  idxINC_TAX); 
						gsmt.bindColumn(18,  idxLINC_TAX);
						gsmt.bindColumn(19,  idxFVS_TAX);
						gsmt.bindColumn(20,  idxSUM_AMT);   
						gsmt.bindColumn(21,  idxINOUT_GB); 
						gsmt.bindColumn(22,  idxINCOME_GB); 
						gsmt.bindColumn(23,  idxCREATE_ID);    
						gsmt.bindColumn(24,  idxUPDATE_ID);  
						
						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;
					}
				} //for
			}
			catch(Exception e){
				conn.rollback();
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