package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p030008_t2 extends HttpServlet{

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

				String strYyyy="";;       
     
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxAPPYY    = userSet.indexOfColumn("APPYY");   //귀속년도       

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer SelectSql = null;

				GauceStatement gsmt = null;
				Statement stmt = null;
				ResultSet rs = null;

        
        //===================================================================================
				for (int j = 0; j < rows.length; j++){
				if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

          strYyyy=rows[j].getString(idxAPPYY);  

          //WORKSTS 초기화 
					DeleteSql = new StringBuffer();
					DeleteSql.append( "  DELETE FROM PAYROLL.PCWRKPAY    \n  " );
					DeleteSql.append( "   WHERE APPDT  = '"+strYyyy+"12' \n  " );
					DeleteSql.append( "     AND PAYDIV = 'Y' \n  " );
					DeleteSql.append( "     AND PAYCD <> 'Y101001S' \n  " );
					gsmt = conn.getGauceStatement(DeleteSql.toString());
					gsmt.executeUpdate();
					gsmt.close();

					
					//기존데이터 초기화 
					DeleteSql = new StringBuffer();
					DeleteSql.append( "  DELETE FROM PAYROLL.YCENTRY10  \n  " );
					DeleteSql.append( "   WHERE APPYY = ? \n  " );
					gsmt = conn.getGauceStatement(DeleteSql.toString());
					gsmt.setGauceDataRow(rows[j]);
					gsmt.bindColumn(1, idxAPPYY);
					gsmt.executeUpdate();
					gsmt.close();
          gsmt=null;
					DeleteSql =null;

          //연말정산 대상자 생성 
          InsertSql = new StringBuffer();

          InsertSql.append( " INSERT INTO PAYROLL.YCENTRY10 (                                                                                     \n " );
					InsertSql.append( "  APPYY, EMPNO, MGENO,  DEPTCD, PAYGRD, PAYSEQ,                                                                      \n " );
					InsertSql.append( "  ADDR1, ADDR2, RESINO, SEX,                                                                                         \n " );
					InsertSql.append( "  WORKFR,WORKTO,REDUFR, REDUTO,                                                                                      \n " );
					InsertSql.append( "  RESIGB,RESINA, RESINACD, COTRYGB, FSINGLE,                                                                         \n " );
					InsertSql.append( "  NATION,NATIONCD,                                                                                                   \n " );
					InsertSql.append( "  CP11000,CP12000,CP13000,CP10000,CNTAXSUM,                                                                          \n " );
					InsertSql.append( "  CP41000,CP42000,CPENAMT01,CINSAMT01,CINSAMT02,                                                                     \n " );
					InsertSql.append( "  SFRE002,SFRE005,SFRE006                                                                                            \n " );
					InsertSql.append( " )                                                                                                                   \n " );
					InsertSql.append( " SELECT '"+strYyyy+"' AS APPYY, A.EMPNO,                                                                             \n " );
					InsertSql.append( "        RIGHT(CHAR(DIGITS(RANK() OVER( PARTITION BY YYYY ORDER BY A.EMPNO))),4) AS MGENO,                            \n " );
  				InsertSql.append( "        A.DEPTCD, B.PAYGRD, B.PAYSEQ,                                                                                \n " );
					InsertSql.append( "        TRIM(B.CADDR01) AS ADDR1, TRIM(B.CADDR02) AS ADDR2, B.RESINO, B.SEX,                                         \n " );
					InsertSql.append( "        CASE WHEN B.STRTDT<='"+strYyyy+"0101' THEN '"+strYyyy+"0101' ELSE B.STRTDT END WORKFR,                       \n " );
					InsertSql.append( "        CASE WHEN (B.ENDDT>='"+strYyyy+"1231' OR B.ENDDT='' OR B.ENDDT IS NULL) THEN '"+strYyyy+"1231' ELSE B.ENDDT END WORKTO,   \n " );
					InsertSql.append( "        '' AS REDUFR, '' AS REDUTO,                                                                                  \n " );
					InsertSql.append( "        '1' AS RESIGB, '한국' AS RESINA,   'KR' AS RESINACD, '1' AS COTRYGB, '2' AS FSINGLE,                         \n " );
          InsertSql.append( "        '한국' AS NATION, 'KR' AS NATIONCD,                                                                          \n " );
					InsertSql.append( "        A.SINC001 AS CP11000, A.SINC002 AS CP12000, A.SINC003 AS CP13000, A.SINC004 AS CP10000,                      \n " );
					InsertSql.append( "        A.SFRE002 + A.SFRE003 + A.SFRE005 + A.SFRE006 AS CNTAXSUM,                                                   \n " );
					InsertSql.append( "        A.SCOL002 AS CP41000,   A.SCOL003 AS CP42000,                                                                \n " );
					InsertSql.append( "        A.SCOL005 AS CPENAMT01, A.SCOL006 AS CINSAMT01,  A.SCOL007 AS CINSAMT02,                                     \n " );
          InsertSql.append( "        A.SFRE002, A.SFRE005,  A.SFRE006                                                                             \n " );
					InsertSql.append( "   FROM PAYROLL.YCPERCOL A                                                                                           \n " );
					InsertSql.append( "   LEFT JOIN PAYROLL.YIPERSON B ON A.EMPNO = B.EMPNO                                                                 \n " );
					InsertSql.append( "  WHERE YYYY=?                                                                                                       \n " );
          
					gsmt = conn.getGauceStatement(InsertSql.toString());
					gsmt.setGauceDataRow(rows[j]);  
					gsmt.bindColumn(1, idxAPPYY);
					gsmt.executeUpdate();
					gsmt.close();
          gsmt=null;      
					InsertSql=null;

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