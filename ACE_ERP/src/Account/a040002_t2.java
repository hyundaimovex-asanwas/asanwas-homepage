package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a040002_t2 extends HttpServlet{
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
				
				String str1 = reqGauce.getParameter("v_str1");	//계산서번호
				String str2 = reqGauce.getParameter("v_str2");	//FDCODE
				String str3 = reqGauce.getParameter("v_str3");	//FSDAT
				String str4 = reqGauce.getParameter("v_str4");	//FSNBR
				String strGB = str1.substring(0,1);

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				String[] StrArrCN = new String[] {
					"TAXNBR"
				};

				int[] idx = new int[1];
				for(int i=0;i<StrArrCN.length;i++) {
					idx[i] = userSet.indexOfColumn(StrArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql   = null;
				StringBuffer UpdateSql   = null;
				StringBuffer DeleteSql   = null;
				StringBuffer DeleteSql2  = null;

				StringBuffer UpdateSql3   = null;
				StringBuffer UpdateSql2   = null;
				
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						InsertSql = new StringBuffer();
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate(); 
						gsmt.close();						
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {

						//접수번호 및 세금계산서 번호로 READ함.
                        UpdateSql3 = new StringBuffer();		/*세금계산서 MST*/
						UpdateSql3.append( " UPDATE ACCOUNT.FSLIPDTL SET DOCUMCD='000',DOCUVAL=''  ");
						UpdateSql3.append( "  WHERE FDCODE = '"+str2+"'                            ");
						UpdateSql3.append( " 	 AND FSDAT = '"+str3+"'                              ");
						UpdateSql3.append( " 	 AND FSNBR = '"+str4+"'                              ");
						UpdateSql3.append( " 	 AND DOCUVAL = '"+str1+"'                            ");		   
						GauceStatement gsmt3 = conn.getGauceStatement(UpdateSql3.toString());
						gsmt3.setGauceDataRow(rows[j]);
						gsmt3.executeUpdate();
						gsmt3.close();

						DeleteSql = new StringBuffer();		/*세금계산서 MST*/
						DeleteSql.append( " DELETE FROM ACCOUNT.ATTAXMST WHERE TAXNBR = '"+str1+"' ");
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate();
						gsmt.close();

						DeleteSql2 = new StringBuffer();	/*세금계산서 DTL*/
						DeleteSql2.append( " DELETE FROM ACCOUNT.ATTAXDTL WHERE TAXNBR = '"+str1+"' ");
						GauceStatement gsmt2 = conn.getGauceStatement(DeleteSql2.toString());
						gsmt2.setGauceDataRow(rows[j]);
						gsmt2.executeUpdate();
						gsmt2.close();

                      //관리자일 경우 해당 세금계산서가 입력된 전표를 찾아서 세금계산서번호를 삭제한다.
            
						if(strGB.equals("A")){ // 매입의 경우 2012.10.17 JYS
							//출납관리의 세금계산서 번호도 삭제 함.	
							UpdateSql2 = new StringBuffer();
							UpdateSql2.append( " UPDATE PMS.TSI010  SET TAXNBR ='' ");
							UpdateSql2.append( "  WHERE TAXNBR = '"+str1+"' ");
							GauceStatement gsmt4 = conn.getGauceStatement(UpdateSql2.toString());
							gsmt4.setGauceDataRow(rows[j]);
							gsmt4.executeUpdate(); 
							gsmt4.close();			
						}
            
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