package security.menu.li;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import oracle.jdbc.OracleTypes;

import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import com.gauce.db.GauceStatement;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.shift.gef.support.vo.GauceValueObject;

import pms.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;

public class MSSQL010 extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		
		for(int i=0; i<arr_sql.length; i++)
			
			arr_sql[i] = new StringBuffer();


		  //MS SQL 쪽으로 발송
		  arr_sql[0].append ("	DELETE FROM TCO.dbo.tblOverwork 				\n")
					.append ("	WHERE 											\n")
					.append ("		fldEmployeeNum = ?							\n")
					.append ("	AND	fldDate = ?                                	\n");			
		
		
		  //MS SQL 쪽으로 발송
		  arr_sql[1].append ("	INSERT INTO TCO.dbo.tblOverwork( 				\n")
					.append ("		fldEmployeeNum,                             \n")
					.append ("		fldDate,                            		\n")
					.append ("		fldStartTime,                             	\n")
					.append ("		fldEndTime, 								\n")	
					.append ("		fldUptdt )									\n")		
					.append ("	VALUES (										\n")
					.append ("		?,  										\n")
					.append ("		?,                                 			\n")		
					.append ("		?, 											\n")
					.append ("		?,  										\n")
					.append ("		GETDATE() ); 								\n");				
		
		  
		  //MS SQL 쪽으로 발송
		  arr_sql[2].append ("	UPDATE TCO.dbo.tblOverwork( 					\n")
					.append ("	SET fldStartTime = ?,	                        \n")
					.append ("		fldEndTime = ?,                            	\n")
					.append ("		fldUptdt = GETDATE()                        \n")	
					.append ("	WHERE 											\n")
					.append ("		fldEmployeeNum = ?							\n")
					.append ("		fldDate = ?                                	\n");				  
		  

   }

	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//init method
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
	}	
	
	
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//select method
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {


		try {
			
		} catch (Exception e){
			
			gres.addException(e);
			throw e;
			
		} finally {

			
		}
	}
	

	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//apply method
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		
		CallableStatement cstmt_ms0   = null;
		CallableStatement cstmt_ms   = null;	

		GauceInputStream gis  = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
        
		/* DataSet */
		GauceDataSet ds00 = gis.read("dsT_DI_WORKSCHEDULE");
		  
		try{

			if (ds00 != null) {
			
				GauceDataRow[] 		rows = ds00.getDataRows();
				
				int colNm_ENO_NO     	= ds00.indexOfColumn("ENO_NO");			//ENO_NO
				int colNm_REG_YMD       = ds00.indexOfColumn("REG_YMD");		//REG_YMD 				
				int colNm_STR_TIME     	= ds00.indexOfColumn("STR_TIME");		//ENO_NO vo.get("STR_TIME") + "" + vo.get("STR_MINUTE");
				int colNm_STR_MINUTE    = ds00.indexOfColumn("STR_MINUTE");
				int colNm_END_TIME      = ds00.indexOfColumn("END_TIME");		
				int colNm_END_MINUTE    = ds00.indexOfColumn("END_MINUTE");
				
				Connection conn_ms = DriverManager.getConnection("jdbc:sqlserver://203.242.32.128:1433;databaseName=TCO;username=sa;password=pc2?79!42;");
				
				for(int i=0; i<rows.length; i++){				

					
					switch(rows[i].getJobType()){
					

							case GauceDataRow.TB_JOB_INSERT:					
		
								
								String ENO_NO  = "hda" + rows[i].getString(colNm_ENO_NO);
								String STR_TIME  = rows[i].getString(colNm_STR_TIME) + ":" + rows[i].getString(colNm_STR_MINUTE);
								String END_TIME = rows[i].getString(colNm_END_TIME) + ":" + rows[i].getString(colNm_END_MINUTE);									
								
								
								if(!rows[i].getString(colNm_STR_TIME).equals("")&&!rows[i].getString(colNm_STR_TIME).equals(null)){
			
									/* 일단 먼저 지운 뒤에 다시 저장하자 */
									cstmt_ms0 = conn_ms.prepareCall(arr_sql[0].toString());
									
									cstmt_ms0.setString(1, ENO_NO);					
									cstmt_ms0.setString(2, rows[i].getString(colNm_REG_YMD));
									
									cstmt_ms0.executeUpdate();
									
									cstmt_ms0.close();									
									
									
									cstmt_ms = conn_ms.prepareCall(arr_sql[1].toString());
									
									cstmt_ms.setString(1, ENO_NO);					
									cstmt_ms.setString(2, rows[i].getString(colNm_REG_YMD));
									cstmt_ms.setString(3, STR_TIME);					
									cstmt_ms.setString(4, END_TIME);
									
									cstmt_ms.executeUpdate();
									
									cstmt_ms.close();
								}

							break;
							
							

							case GauceDataRow.TB_JOB_UPDATE:	

								String ENO_NO2  = "hda" + rows[i].getString(colNm_ENO_NO);
								String STR_TIME2  = rows[i].getString(colNm_STR_TIME) + ":" + rows[i].getString(colNm_STR_MINUTE);
								String END_TIME2 = rows[i].getString(colNm_END_TIME) + ":" + rows[i].getString(colNm_END_MINUTE);									
								
								
								if(!rows[i].getString(colNm_STR_TIME).equals("")&&!rows[i].getString(colNm_STR_TIME).equals(null)){
			
									/* 일단 먼저 지운 뒤에 다시 저장하자 */
									cstmt_ms0 = conn_ms.prepareCall(arr_sql[0].toString());
									
									cstmt_ms0.setString(1, ENO_NO2);					
									cstmt_ms0.setString(2, rows[i].getString(colNm_REG_YMD));
									
									cstmt_ms0.executeUpdate();
									
									cstmt_ms0.close();									
									
									
									cstmt_ms = conn_ms.prepareCall(arr_sql[1].toString());
									
									cstmt_ms.setString(1, ENO_NO2);					
									cstmt_ms.setString(2, rows[i].getString(colNm_REG_YMD));
									cstmt_ms.setString(3, STR_TIME2);					
									cstmt_ms.setString(4, END_TIME2);
									
									cstmt_ms.executeUpdate();
									
									cstmt_ms.close();
								}								
								
								
							break;
								
							
							case GauceDataRow.TB_JOB_DELETE:	
		
							break;
							
						
						}
					
				}
					

					conn_ms.close();

			}
			

			gos.close();
			
			
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {

		}		
		
		
	}
	
	
}


