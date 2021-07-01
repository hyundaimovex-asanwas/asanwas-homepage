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
import sales.common.HDUtil;
import sales.common.StringUtil;



public class dd010_t1 extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//Main 저장
		arr_sql[1].append ("{call ASNHR.PR_DD010I_S01(?,?,?,?,?,?,?) }");

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
		//System.out.println("PCAR_BELONG \n");		
		//System.out.println("이동훈 \n");			

		String V_ENO_NO				= greq.getParameter("V_ENO_NO"); 		//	
		
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

				//int PCAR_SID		   		= ds1.indexOfColumn("CAR_SID");	  	
				int PCAR_NO      			= ds1.indexOfColumn("CAR_NO");    	   	
				int PCAR_NM      			= ds1.indexOfColumn("CAR_NM");       
				int PCAR_TYPE      		= ds1.indexOfColumn("CAR_TYPE");       	
				int PLEASE_TYPE      	= ds1.indexOfColumn("LEASE_TYPE");      
				int PCAR_MILEAGE    	= ds1.indexOfColumn("CAR_MILEAGE");       
				int PCAR_BELONG      	= ds1.indexOfColumn("CAR_BELONG");       	

				
				//System.out.println(PCAR_SID);
				//System.out.println(PCAR_NO);			
				
				for(int i=0; i<rows.length; i++){

							switch(rows[i].getJobType()){
							
									case GauceDataRow.TB_JOB_INSERT:
										
										cstmt = conn.prepareCall(arr_sql[1].toString());
									
										//cstmt.setString(1, rows[i].getString(PCAR_SID));	
										cstmt.setString(1, rows[i].getString(PCAR_NO));	
										cstmt.setString(2, rows[i].getString(PCAR_NM));
										cstmt.setString(3, rows[i].getString(PCAR_TYPE));
										cstmt.setString(4, rows[i].getString(PLEASE_TYPE));
										cstmt.setString(5, rows[i].getString(PCAR_MILEAGE));
										cstmt.setString(6, rows[i].getString(PCAR_BELONG));														
										cstmt.setString(7, V_ENO_NO);
										
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