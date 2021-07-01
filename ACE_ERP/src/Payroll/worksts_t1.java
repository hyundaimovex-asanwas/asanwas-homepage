package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class worksts_t1 extends HttpServlet{

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

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxAPPDT    = userSet.indexOfColumn("APPDT");   //년월       
				int idxPAYDT    = userSet.indexOfColumn("PAYDT");   //일자
				int idxPAYCD    = userSet.indexOfColumn("PAYCD");   //항목코드
				int idxWRKSTS   = userSet.indexOfColumn("WRKSTS");  //상태       
				int idxMEMO     = userSet.indexOfColumn("MEMO");    //비고       

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer SelectSql = null;

				GauceStatement gsmt = null;
				Statement stmt = null;
				ResultSet rs = null;

				int intCnt=0;
				String strDate="";
				String strTime="";

        
        //===================================================================================
				for (int j = 0; j < rows.length; j++){
				if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

					SelectSql = new StringBuffer();
					SelectSql.append( " SELECT COUNT(*) CNT,                                             \n" ); 
					SelectSql.append( "        TRIM(REPLACE(CAST(CURRENT DATE AS VARCHAR(10)),'-','')),  \n" ); 
					SelectSql.append( "        TRIM(REPLACE(CAST(CURRENT TIME AS VARCHAR(10)),'.',''))   \n" ); 
					SelectSql.append( "   FROM PAYROLL.PCWRKPAY                                          \n" ); 
					SelectSql.append( "  WHERE APPDT  ='"+rows[j].getString(idxAPPDT)+"'                 \n" );
					SelectSql.append( "    AND PAYDIV = 'Y'                                              \n" ); 
					SelectSql.append( "    AND PAYDT  = '"+rows[j].getString(idxPAYDT)+"'                \n" ); 
					SelectSql.append( "    AND PBDIV  = '1'                                              \n" ); 
					SelectSql.append( "    AND PAYCD  = '"+rows[j].getString(idxPAYCD)+"'                \n" ); 

          logger.dbg.println(this,"SelectSql.toString()::"+SelectSql.toString());
					stmt = conn.createStatement();
					rs = stmt.executeQuery(SelectSql.toString());

					while(rs.next()){
						intCnt =rs.getInt("CNT");  //Cnt
						strDate=rs.getString(2);
						strTime=rs.getString(3);
          }
					rs.close();
					stmt.close();

					if(intCnt==0){ //신규

						//연말정산 대상자 생성 
						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO PAYROLL.PCWRKPAY (                         \n " );
						InsertSql.append( " APPDT, PAYDIV, PAYDT,  PBDIV, PAYCD,                   \n " );
						InsertSql.append( " FRDT,  FRTM,   TODT,   TOTM,  WRKSTS,                  \n " );
						InsertSql.append( " MEMO )                                                 \n " );
						InsertSql.append( " VALUES(                                                \n " );
            InsertSql.append( " '"+rows[j].getString(idxAPPDT)+"','Y',                 \n " );
						InsertSql.append( " '"+rows[j].getString(idxPAYDT)+"','1',                 \n " );
            InsertSql.append( " '"+rows[j].getString(idxPAYCD)+"',                     \n " );
						InsertSql.append( " '"+strDate+"','"+strTime+"','"+strDate+"','"+strTime+"',   \n " );
						InsertSql.append( " '"+rows[j].getString(idxWRKSTS)+"',                    \n " );
						InsertSql.append( " '"+rows[j].getString(idxMEMO)+"'                       \n " );
						InsertSql.append( " )                                                      \n " );

						//logger.dbg.println(this,"InsertSql.toString()::"+InsertSql.toString()); 
						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;      
						InsertSql=null;

					}else{ //기존존재

					  UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE PAYROLL.PCWRKPAY SET  \n " );
						UpdateSql.append( "   FRDT = '"+strDate+"',\n " );
            UpdateSql.append( "   FRTM = '"+strTime+"',\n " );
						UpdateSql.append( "   TODT = '"+strDate+"',\n " );
						UpdateSql.append( "   TOTM = '"+strTime+"',\n " );
            UpdateSql.append( " WRKSTS = '"+rows[j].getString(idxWRKSTS)+"',      \n " );
						UpdateSql.append( "   MEMO = '"+rows[j].getString(idxMEMO)+"'         \n " );
						UpdateSql.append( " WHERE APPDT  ='"+rows[j].getString(idxAPPDT)+"'		\n" );
					  UpdateSql.append( "   AND PAYDIV = 'Y'															  \n" ); 
					  UpdateSql.append( "   AND PAYDT  = '"+rows[j].getString(idxPAYDT)+"'  \n" ); 
					  UpdateSql.append( "   AND PBDIV  = '1'															  \n" ); 
					  UpdateSql.append( "   AND PAYCD  = '"+rows[j].getString(idxPAYCD)+"'  \n" ); 
						
						//logger.dbg.println(this,"UpdateSql.toString()::"+UpdateSql.toString()); 
						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;      
						UpdateSql=null;
					
					}  

				 } //getJobType
			}  //for j 
     			
			} //try
			catch(Exception e){
				conn.rollback();
				logger.err.println(this,"errno::");
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