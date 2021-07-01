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

public class MSSQL020 extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		
		for(int i=0; i<arr_sql.length; i++)
			
			arr_sql[i] = new StringBuffer();


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
		
		  
		  //신규 MS SQL 177 쪽으로 발송
		  arr_sql[2].append ("	INSERT INTO TCO.dbo.tblOverwork( 				\n")
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
		  
		  //System.out.println("INSERT INTO TCO.dbo.tblOverwork \n" + arr_sql[1].toString());		

		
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
		
		CallableStatement cstmt_ms   = null;	
		/*2021.06.08 신규 DB에 연결하는 부분 추가 */
		CallableStatement cstmt_ms_177   = null;		
		
		GauceInputStream gis  = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
		GauceDataSet ds00 = gis.read("dsT_DI_OVERTIMEWORK");
		  
		try{

			if (ds00 != null) {
			
				GauceDataRow[] 		rows = ds00.getDataRows();
				

				int colNm_REG_YMD       = ds00.indexOfColumn("REG_YMD");		//REG_YMD 				
				int colNm_STR_TIME     	= ds00.indexOfColumn("STR_OVR_TIME");	//ENO_NO vo.get("STR_TIME") + "" + vo.get("STR_MINUTE");
				int colNm_END_TIME      = ds00.indexOfColumn("END_OVR_TIME");		

				
				Connection conn_ms = DriverManager.getConnection("jdbc:sqlserver://203.242.32.128:1433;databaseName=TCO;username=sa;password=pc2?79!42;");
				Connection conn_ms_177 = DriverManager.getConnection("jdbc:sqlserver://10.106.246.177:1433;databaseName=TCO;username=sa;password=pc2?79!42;");
				
				
				for(int i=0; i<rows.length; i++){				
				
					/* 보내는 부분 Start */

					String ENO_NO    = "hda" + HDUtil.nullCheckStr(greq.getParameter("ENO_NO")); 			// 사번	
					//String STR_TIME  = rows[i].getString(colNm_STR_TIME);
					//String END_TIME  = rows[i].getString(colNm_END_TIME);

					String STR_TIME  = rows[i].getString(colNm_STR_TIME).substring(0,2) + ":" + rows[i].getString(colNm_STR_TIME).substring(2,4);
					String END_TIME  = rows[i].getString(colNm_END_TIME).substring(0,2) + ":" + rows[i].getString(colNm_END_TIME).substring(2,4);

					//StringUtil.printMsg("# Command11111111",ENO_NO,this);

					if(!rows[i].getString(colNm_STR_TIME).equals("")&&!rows[i].getString(colNm_STR_TIME).equals(null)){

						cstmt_ms = conn_ms.prepareCall(arr_sql[1].toString());
						
						cstmt_ms.setString(1, ENO_NO);					
						cstmt_ms.setString(2, rows[i].getString(colNm_REG_YMD));
						cstmt_ms.setString(3, STR_TIME);					
						cstmt_ms.setString(4, END_TIME);
						
						cstmt_ms.executeUpdate();
					


						cstmt_ms_177 = conn_ms_177.prepareCall(arr_sql[2].toString());
						
						cstmt_ms_177.setString(1, ENO_NO);					
						cstmt_ms_177.setString(2, rows[i].getString(colNm_REG_YMD));
						cstmt_ms_177.setString(3, STR_TIME);					
						cstmt_ms_177.setString(4, END_TIME);
						
						cstmt_ms_177.executeUpdate();
					
					}					
					
					
					
					/* 보내는 부분 Finish*/		
					
				}

				
				
				/* 2021.06.08 이동훈 신규 DB에 Data 쏘는 부분 추가     Start */				
				
				//Connection conn_ms_177 = DriverManager.getConnection("jdbc:sqlserver://10.106.246.177:1433;databaseName=TCO;username=sa;password=pc2?79!42;");			
				
					cstmt_ms_177.close();
					conn_ms_177.close();

				/* 2021.06.08 이동훈 신규 DB에 Data 쏘는 부분 추가     End  */				
				
					//if(cstmt_ms!=null && !cstmt_ms.isClosed())cstmt_ms.close();
					//if(conn_ms!=null && !conn_ms.isClosed())conn_ms.close();
				
					cstmt_ms.close();
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