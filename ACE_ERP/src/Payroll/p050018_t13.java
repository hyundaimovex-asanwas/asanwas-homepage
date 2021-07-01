package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p050018_t13 extends HttpServlet{

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

				String str1 = req.getParameter("v_str1");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxEMPNO	= userSet.indexOfColumn("EMPNO");		//사번 1
				int idxREPDT	= userSet.indexOfColumn("REPDT");			//중도상환일자 2
				int idxREPYN	= userSet.indexOfColumn("REPYN");			//중도상환여부 3
				int idxREPMM	= userSet.indexOfColumn("REPMM");		//중도상환월 4
				int idxAPBAMT	= userSet.indexOfColumn("APBAMT");		//상환전잔액 5
				int idxAPLAMT	= userSet.indexOfColumn("APLAMT");		//상환원금 6
				int idxCALAMT	= userSet.indexOfColumn("CALAMT");		//정산이자 7
				int idxAPLDT	= userSet.indexOfColumn("APLDT");			//상환일 8

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){
						
						if(rows[j].getJobType() != GauceDataRow.TB_JOB_UPDATE) {

/******************************** **********************************************
	* 업데이트 START
*********************************************************************************/
			/*+++++++++++++++++++++++++++++++++++++++++++++++ 
				 상환 마지막 달은 상태를 상환으로 만들어 준다
			+++++++++++++++++++++++++++++++++++++++++++++++*/

				StringBuffer UpdateSql = null;

				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.PWCOLOAN SET										\n");
				UpdateSql.append( " APBAMT= ?,																	\n");
				UpdateSql.append( " APLAMT= ?,																	\n");
				UpdateSql.append( " APJAMT= '0',																	\n");
				UpdateSql.append( " CALAMT= ?,																	\n");
				UpdateSql.append( " REPDT= ?,																		\n");
				UpdateSql.append( " REPYN= 'Y'																		\n");
				UpdateSql.append( " WHERE EMPNO = ? 															\n");
				UpdateSql.append( " AND APLDT = ? 																\n");

				GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
				gsmt.setGauceDataRow(rows[j]);

				gsmt.bindColumn(1, idxAPBAMT);
				gsmt.bindColumn(2, idxAPLAMT);
				gsmt.bindColumn(3, idxCALAMT);
				gsmt.bindColumn(4, idxREPDT);
				gsmt.bindColumn(5, idxEMPNO);
				gsmt.bindColumn(6, idxAPLDT);

				gsmt.executeUpdate(); 
				gsmt.close();         

				logger.dbg.println(this,UpdateSql.toString());


			/*+++++++++++++++++++++++++++++++++++++++++++++++ 
				 상환 마지막 달 이후에는 데이타를 다 Delete 시킨다.
			+++++++++++++++++++++++++++++++++++++++++++++++*/

				StringBuffer DeleteSql = null;

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.PWCOLOAN 															\n");
				DeleteSql.append( " WHERE EMPNO = ? 	AND SUBSTR(APLDT,1,6) > ?										\n");

				GauceStatement gsmt2 = conn.getGauceStatement(DeleteSql.toString());
				gsmt2.setGauceDataRow(rows[j]);

				gsmt2.bindColumn(1, idxEMPNO);
				gsmt2.bindColumn(2, idxREPMM);

				gsmt2.executeUpdate(); 
				gsmt2.close();         

				logger.dbg.println(this,DeleteSql.toString());


/******************************** **********************************************
	* END
*********************************************************************************/
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