package pms.news.bud;

import java.sql.CallableStatement;
import java.sql.Connection;
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

import pms.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;

public class Bud050 extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		
		for(int i=0; i<arr_sql.length; i++)
			
			arr_sql[i] = new StringBuffer();
		
				//ds_default 조회
				arr_sql[1].append ("{call PMS.PR_NEW_BUD050_01(?,?,?)}");
				
				//ds_default 저장
				arr_sql[2].append ("{call PMS.PR_NEW_BUD050_02(?,?,?,?,?,?,?)}");

   }


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//init method
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		try {
		} catch (Exception e){
		} finally {
		}
	}
	
	
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//select method
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		CallableStatement cstmt = null;
		
		ResultSet rs = null;

		String v_project 		= HDUtil.nullCheckStr(greq.getParameter("v_project"));			//프로젝트
		String v_ds_budget		= HDUtil.nullCheckStr(greq.getParameter("v_ds_budget"));		//실행차수
	
        GauceInputStream gis  = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {
         
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
            	
            	if(dSets[i].getName().equals("ds_default")){
            	
					GauceDataSet ds1 = gis.read("DS_DEFAULT");

					cstmt = conn.prepareCall(arr_sql[1].toString());
					
					cstmt.setString(1, v_project);
					cstmt.setString(2, v_ds_budget);
					
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(3);						
					
					gos.write(getDataSet(rs, ds1));

            	}          	
            	
			}

            gos.close();
            
		}catch (SQLException sqle){
			throw sqle;
		} catch (Exception e){
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
	

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//apply method
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	
		CallableStatement 	cstmt 		= null;	
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		
		String iParamEmpno 	= fParamEmpno;

			
		GauceInputStream gis 	= greq.getGauceInputStream();
        GauceOutputStream gos 	= gres.getGauceOutputStream();
        
        GauceDataSet ds_default 		= gis.read("DS_DEFAULT");

		try{
			
			if (ds_default != null) {

				GauceDataRow[] 		rows = ds_default.getDataRows();

				int cost_cd		= ds_default.indexOfColumn("COST_CD");  
				int no_budget	= ds_default.indexOfColumn("NO_BUDGET");				
				int cd_cost     = ds_default.indexOfColumn("CD_COST");          
				int ds_ksitem   = ds_default.indexOfColumn("DS_KSITEM");   
				int exe_act_amt = ds_default.indexOfColumn("EXE_ACT_AMT");          
 

				for(int i=0; i<rows.length; i++){

					if(rows[i].getJobType()==2){

						cstmt = conn.prepareCall(arr_sql[2].toString());
						
						cstmt.setString(1, rows[i].getString(cost_cd));
						cstmt.setString(2, rows[i].getString(no_budget));					
						cstmt.setString(3, rows[i].getString(cd_cost));
						cstmt.setString(4, rows[i].getString(ds_ksitem));	
						cstmt.setString(5, rows[i].getString(exe_act_amt));
						cstmt.setInt(6, rows[i].getJobType() );	//가우스행 작업 값
						cstmt.setString(7, iParamEmpno);					

						cstmt.executeUpdate();
						
						if(cstmt!=null) cstmt.close();	
						
						
					}else if(rows[i].getJobType()==3){
		
						cstmt = conn.prepareCall(arr_sql[2].toString());
						
						cstmt.setString(1, rows[i].getString(cost_cd));
						cstmt.setString(2, rows[i].getString(no_budget));					
						cstmt.setString(3, rows[i].getString(cd_cost));
						cstmt.setString(4, rows[i].getString(ds_ksitem));	
						cstmt.setString(5, rows[i].getString(exe_act_amt));
						cstmt.setInt(6, rows[i].getJobType() );	//가우스행 작업 값
						cstmt.setString(7, iParamEmpno);					

						cstmt.executeUpdate();
						
						if(cstmt!=null) cstmt.close();	
							
					}else if(rows[i].getJobType()==4){
						
						cstmt = conn.prepareCall(arr_sql[2].toString());

						cstmt.setString(1, rows[i].getString(cost_cd));
						cstmt.setString(2, rows[i].getString(no_budget));					
						cstmt.setString(3, rows[i].getString(cd_cost));
						cstmt.setString(4, rows[i].getString(ds_ksitem));	
						cstmt.setString(5, rows[i].getString(exe_act_amt));
						cstmt.setInt(6, rows[i].getJobType() );	//가우스행 작업 값
						cstmt.setString(7, iParamEmpno);					

						cstmt.executeUpdate();
						
						if(cstmt!=null) cstmt.close();							
						
						
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

			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();

		}
		
	}
	
}