package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a080002_t2 extends HttpServlet{
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

				String []  str	= new String [10];
				str[0] = reqGauce.getParameter("v_str1");		//지점코드    
				str[1] = reqGauce.getParameter("v_str2");		//예산년도              
				str[2] = reqGauce.getParameter("v_str3");		//예산본부              
				str[3] = reqGauce.getParameter("v_str4");		//예산부서              

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				for(int i=0;i<=3;i++) {
					if (str[i]==null) str[i] = "";
				}

				String[] StrArrCN = new String[] {
					"BGTMM", "ATCODE","SATCODE","FDCODE","BGTYY",
					"BGTDIV","BGTDPT","CHGBGT"
				};

				int[] idx = new int[8];
				for(int i=0;i<StrArrCN.length;i++) {
					idx[i] = userSet.indexOfColumn(StrArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql  = null;	
				StringBuffer UpdateSql  = null;
				StringBuffer DeleteSql  = null;

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						InsertSql = new StringBuffer();
						InsertSql.append( " UPDATE ACCOUNT.BGTDTL SET														\n");
						InsertSql.append( " CHGBGT="+rows[j].getString(idx[7])+"		/*조정액*/	\n");
						InsertSql.append( " WHERE BGTMM='"+rows[j].getString(idx[0])+"'					\n");
						InsertSql.append( "   AND ATCODE='"+rows[j].getString(idx[1])+"'				\n");
						InsertSql.append( "   AND SATCODE='"+rows[j].getString(idx[2])+"'				\n");
						if(!str[0].equals("")) InsertSql.append( " AND FDCODE='"+str[0]+"' \n");	//지점코드
						if(!str[1].equals("")) InsertSql.append( " AND BGTYY ='"+str[1]+"' \n");	//예산년도
						if(!str[2].equals("")) InsertSql.append( " AND BGTDIV='"+str[2]+"' \n");	//예산본부 
						if(!str[3].equals("")) InsertSql.append( " AND BGTDPT='"+str[3]+"' \n");	//예산부서

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate(); 
						gsmt.close();					
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
							
					}   
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {

					}
				}
			}catch(Exception e){
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