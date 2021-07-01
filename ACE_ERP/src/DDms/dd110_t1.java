package DDms;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceStatement;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import pms.common.SuperServlet;
import java.sql.Connection; 

public class dd110_t1 extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//Main 저장
		arr_sql[1].append ("{call ASNHR.PR_DD110I_S01(?,?,?,?,?,?,?,?,?,?) }");

   }

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;

		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			
		    //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
		    GauceDataSet[] dSets = gis.readAllOutput(); 

		    for(int i=0; i<dSets.length;i++){
		    	
			   	if(dSets[i].getName().equals("ds_default")){

					}  	
				  }

				} catch (Exception e){
					//res.writeException("ERROR", "", e.toString());
					throw e;
				} finally {
					if(rs!=null) rs.close();
					if(cstmt!=null) cstmt.close();
				}
			}  	
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;

		try {
			
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			for(int i=0; i<dSets.length;i++){

					if(dSets[i].getName().equals("ds_default")){


					}            	
				 }
				 gos.close();

		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
	
	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		
		//StringUtil.printMsg("# Command","저장",this);
		//StringUtil.printMsg("# Command","저장",this);
		
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 		rs 			= null;

		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
			
		/* DataSet */
		GauceDataSet ds1 = gis.read("USER");
		
		try{
			
			if (ds1 != null) {
				
				GauceDataRow[] 		rows = ds1.getDataRows();

				int PCAR_NO		   		= ds1.indexOfColumn("CAR_NO");	  	
				int PDRIVE_DT      		= ds1.indexOfColumn("DRIVE_DT");    	   	
				int PDPT_NM      			= ds1.indexOfColumn("DPT_NM");       
				int PJOB_NM      			= ds1.indexOfColumn("JOB_NM");       	
				int PENO_NM      			= ds1.indexOfColumn("ENO_NM");      
				int PDRIVE_BEFORE    	= ds1.indexOfColumn("DRIVE_BEFORE");       
				int PDRIVE_AFTER      	= ds1.indexOfColumn("DRIVE_AFTER");       	
				int PMILEAGE     	 		= ds1.indexOfColumn("MILEAGE");       		
				int PFOR_CMMT      		= ds1.indexOfColumn("FOR_CMMT");       				
				int PFOR_BIZ      			= ds1.indexOfColumn("FOR_BIZ");    

				for(int i=0; i<rows.length; i++){

							switch(rows[i].getJobType()){
							
									case GauceDataRow.TB_JOB_INSERT:
										
										cstmt = conn.prepareCall(arr_sql[1].toString());
									
										cstmt.setString(1, rows[i].getString(PCAR_NO));	
										cstmt.setString(2, rows[i].getString(PDRIVE_DT));	
										cstmt.setString(3, rows[i].getString(PDPT_NM));
										cstmt.setString(4, rows[i].getString(PJOB_NM));
										cstmt.setString(5, rows[i].getString(PENO_NM));
										cstmt.setString(6, rows[i].getString(PDRIVE_BEFORE));
										cstmt.setString(7, rows[i].getString(PDRIVE_AFTER));										
										cstmt.setString(8, rows[i].getString(PMILEAGE));
										cstmt.setString(9, rows[i].getString(PFOR_CMMT));
										cstmt.setString(10, rows[i].getString(PFOR_BIZ));						
							
										cstmt.executeUpdate();
										
										if(cstmt!=null) cstmt.close();		
										
										break;

							}
							
					}
				
			}
							gos.close();
			} catch (SQLException sqle){
				gres.addException(sqle);
				throw sqle;
			} catch (Exception e) {
				gres.addException(e);
				throw e;
			} finally {
				//msgDS.flush();
				//if(stmt!=null) stmt.close();
				if(rs!=null) rs.close();
				if(stmt!=null) stmt.close();			
				if(cstmt!=null) cstmt.close();
			//if( fail == true ) throw new Exception("");			
			}
		}
	}