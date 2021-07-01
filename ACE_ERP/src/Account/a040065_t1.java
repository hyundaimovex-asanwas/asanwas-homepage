package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a040065_t1 extends HttpServlet{
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

				GauceStatement gsmt=null;

                GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2"); //RETURN용

				String strEmpno = reqGauce.getParameter("v_str1");     //사번
				String strRegno = reqGauce.getParameter("v_str2");     //공급자 사업자 등록번호
				
				int idxCONVERSATION_ID = userSet.indexOfColumn("CONVERSATION_ID");
				int idxSUPBUY_TYPE     = userSet.indexOfColumn("SUPBUY_TYPE");
				int idxDIRECTION       = userSet.indexOfColumn("DIRECTION");
		
				GauceDataRow[] rows = userSet.getDataRows();

                String strID="";
				String strPW="";  
				long lng_Interface_Batch_id = 0;

				StringBuffer sql0 = null;
				Statement stmt0 = null;
				ResultSet rs0 = null;

				StringBuffer sql9 = null;
				Statement stmt9 = null;
				ResultSet rs9 = null;

				StringBuffer UpdateSql = null;


				//스마트빌 ID, PW 조회 >>>>>>>>>>>
				sql9 = new StringBuffer();
				sql9.append( " SELECT SMART_ID, SMART_PASSWORD     		\n" ); 
				sql9.append( " 	 FROM HDASAN_EDI.XXSB_DTI_SM_USER  		\n" ); 
				sql9.append( "  WHERE FND_USER ='"+strEmpno+"'     				\n" ); 
				sql9.append( "    AND FND_REGNO ='"+strRegno+"'    				\n" ); 
				
				stmt9 = conn.createStatement();
				rs9 = stmt9.executeQuery(sql9.toString());
				while(rs9.next()){         
					strID = rs9.getString(1);  
					strPW = rs9.getString(2);  
				}
				rs9.close();
				stmt9.close();


				//BATCH_ID 조회 >>>>>>>>>>>>>>>>
				sql0 = new StringBuffer();
				/*
				sql0.append( " SELECT CAST(SUBSTR(REPLACE(CHAR(CURRENT DATE,ISO),'-',''),3,6)||REPLACE(CHAR(CURRENT TIME,ISO),'.','')|| SUBSTR(MICROSECOND(sysdate),1,3) AS NUMERIC(15))  \n" ); 
				sql0.append( " 	 FROM SYSIBM.SYSDUMMY1                                                      \n" ); 
				*/
				sql0.append( " SELECT CAST(SUBSTR(TO_CHAR(CURRENT_TIMESTAMP,'YYMMDDHH24MISSxFF3'),1,12)||SUBSTR(TO_CHAR(CURRENT_TIMESTAMP,'YYMMDDHH24MISSxFF3'),14,3) AS NUMBER(15)) \n" ); 
				sql0.append( " 	 FROM SYS.DUAL                                                    \n" ); 
				
				
				stmt0 = conn.createStatement();
				rs0 = stmt0.executeQuery(sql0.toString());
				
				while(rs0.next()){         
					lng_Interface_Batch_id = rs0.getLong(1);  //키값으로 사용함.
				}
				rs0.close();
				stmt0.close();
				
				
				
				System.out.println("lng_Interface_Batch_id::"+lng_Interface_Batch_id+"::");

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append( "  UPDATE HDASAN_EDI.XXSB_DTI_MAIN \n" );
						UpdateSql.append( "     SET INTERFACE_BATCH_ID="+lng_Interface_Batch_id+",\n" );
						UpdateSql.append( "         LAST_UPDATED_BY='"+strEmpno+"',               \n" );
						UpdateSql.append( "         LAST_UPDATE_DATE=sysdate            \n" );
						UpdateSql.append( "   WHERE CONVERSATION_ID=?        \n" );
						UpdateSql.append( "     AND SUPBUY_TYPE=?            \n" );
						UpdateSql.append( "     AND DIRECTION=?              \n" );
						
						System.out.println("idxTAXNBR::"+ rows[j].getString(idxCONVERSATION_ID));
						System.out.println("idxSUPBUY_TYPE::"+ rows[j].getString(idxSUPBUY_TYPE));
						System.out.println("idxDIRECTION::"+ rows[j].getString(idxDIRECTION));

						//MAIN
						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);  
						gsmt.bindColumn(1, idxCONVERSATION_ID);
						gsmt.bindColumn(2, idxSUPBUY_TYPE);
						gsmt.bindColumn(3, idxDIRECTION);

						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;      
						UpdateSql=null;

					}//if
				}//for

				if (userSet2 != null) {
						resGauce.enableFirstRow(userSet2);
						userSet2.addDataColumn(new GauceDataColumn("BATCH_ID", GauceDataColumn.TB_DECIMAL,15));
						userSet2.addDataColumn(new GauceDataColumn("ID",   GauceDataColumn.TB_STRING,12));
						userSet2.addDataColumn(new GauceDataColumn("PASS", GauceDataColumn.TB_STRING,35));
					 
						GauceDataRow row = null;
						row = userSet2.newDataRow();
						row.addColumnValue(lng_Interface_Batch_id);
						row.addColumnValue(strID);
						row.addColumnValue(strPW);
						userSet2.addDataRow(row);
						userSet2.flush();
				 }
			}
			catch(Exception e)
				{
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
				logger.err.println(this,e.toString()); //
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