package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p040001_t1 extends HttpServlet{

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

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				String[] strArrCN = new String[]{
                               
					 "BASAMT1", //급여(기본급+직책수당+시간외수당)                                  
					 "BASAMT2", //급여(기본급+직책수당+시간외수당)                                  
					 "BASAMT3", //급여(기본급+직책수당+시간외수당)
					 "BASAMT4", //급여(기본급+직책수당+시간외수당)
					 "BASBUS1", //상여 3월                                  
					 "BASBUS2", //상여 12,1월                                  
					 "BASBUS3", //상여 9,11월
					 "BASBUS4", //상여 5,7월
					 "BAEAMT1", //기타수당액                                  
					 "BAEAMT2", //기타수당액                                   
					 "BAEAMT3", //기타수당액                                  
					 "BAEAMT4", //기타수당액    
					 "YEAQTY",  //년차일수                                  
					 "YEAPAY",  //년차수당                                   
					 "AVGYER",  //평균년차수당  
					 "AVGAMT",  //평균급여    
					 "AVGBOS",  //평균상여    
					 "AVGETC",  //평균기타수당    
					 "P21000",  //근속수당    
					 "P22000",  //자기계발비    
					 "P24000",  //차량유지비    
					 "P29000",  //남북경협수당    
					 "P38000",  //임원직책수당    
					 "PX0000",  //기타수당    
					 "JUSPAY",  //급여    
					 "JUSRET",  //퇴직금    
					 "JUSYER",  //년차수당    
					 "JUSBOS",  //상여    
					 "S91000",  //지급합계    
					 "S94000",  //실지급액    
					 "T21000",  //정산갑근세-소득세                             
					 "T22000",  //정산주민세                              
					 "T23000",  //퇴직갑근세-소득세                             
					 "T24000",  //퇴직주민세                              
					 "P43000",  //국민연금                              
					 "P41000",  //건강보험                              
					 "P42000",  //고용보험                           
					 "RETJUH",  //퇴직전환금 
					 "BX0010",  //기타공제1
					 "BX0020",  //기타공제2                                
					 "BX0030",  //기타공제3                                
					 "BX0040",  //기타공제4
 					 "S93000",   //공제합계
					 "PAYDIV",	
           "REF1"	,		//상여1
					 "REF2"	,		//상여2
					 "REF3"	,		//상여3
					 "REF4"	,		//상여4
					 "REF"			//퇴직사유
				};
                
				int idxEMPNO = userSet.indexOfColumn("EMPNO");	/*  사번*/
				int idxAPPDT = userSet.indexOfColumn("APPDT");	/*  년월 */
               
				int[] idx = new int[strArrCN.length];
				for (int i=0; i<strArrCN.length; i++) {
					idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.executeUpdate();
						gsmt.close();
						InsertSql=null;
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append( "UPDATE PAYROLL.PRPAY SET " );
						for(int i=0; i <strArrCN.length; i++)	{
							if(i==(strArrCN.length-1))
								UpdateSql.append( " "+strArrCN[i]+"=?  " );
							else
								UpdateSql.append( " "+strArrCN[i]+"=?,  " );
						}
						UpdateSql.append( " WHERE EMPNO = ? " );
						UpdateSql.append( " AND APPDT = ? " );

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						//logger.dbg.println(this, UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						for (int i=1; i<=strArrCN.length; i++) {
							gsmt.bindColumn(i, idx[(i-1)]);
						}

						gsmt.bindColumn((strArrCN.length+1), idxEMPNO);
						gsmt.bindColumn((strArrCN.length+2), idxAPPDT);
	
						gsmt.executeUpdate(); 
						gsmt.close(); 
						UpdateSql=null;
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						DeleteSql.append( "DELETE FROM PAYROLL.PRPAY WHERE EMPNO = ? AND APPDT	= ? " );

						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						//logger.dbg.println(this, DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxEMPNO);
						gsmt.bindColumn(2, idxAPPDT);
						gsmt.executeUpdate();
						gsmt.close();
						DeleteSql=null;
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