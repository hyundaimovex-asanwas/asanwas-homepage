package pms.news.pro;
//	si110i
//	si110i_h1 사용

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

public class Pr011 extends SuperServlet {


	private static final long serialVersionUID = 1L;

	public void makeSql(){
		
		for(int i=0; i<arr_sql.length; i++)
			
			arr_sql[i] = new StringBuffer();

		//project list : Master 조회
		arr_sql[1].append ("{call PMS.PR_NEW_PRO011_01(?) }" );
		

		//project list : Master 저장
		arr_sql[2].append ("{call PMS.PR_NEW_PRO011_02(?,?,?,?,?, ?,?,?,?) }" );


	}

	
	
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//init method
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		

		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		
		try {
			
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            

            GauceDataSet[] dSets = gis.readAllOutput(); 

			
            for(int i=0; i<dSets.length;i++){
            	
            	if(dSets[i].getName().equals("ds_default")){
            		
					GauceDataSet ds1 = gis.read("DS_DEFAULT");

					cstmt = conn.prepareCall(arr_sql[1].toString());
				
					cstmt.registerOutParameter(1, OracleTypes.CURSOR);	//결과를 받을 커서

					cstmt.executeQuery();

					rs = (ResultSet)cstmt.getObject(1);	//커서 OUT param. 

					gos.write(getDataSet(rs, ds1));
           
            	}
            	

            }
		}catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e){
			gres.addException(e);
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}

	}	
	
	
	
	
	
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//select method
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		CallableStatement cstmt = null;
		ResultSet rs = null;

		String v_project 			= HDUtil.nullCheckStr(greq.getParameter("v_project"));				// 프로젝트명
		String v_prop1 				= HDUtil.nullCheckStr(greq.getParameter("v_prop1"));				// 손익센터
		String v_prop2 				= HDUtil.nullCheckStr(greq.getParameter("v_prop2"));				// 사업구분


		try {
			
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            

            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
            	
	
            	if(dSets[i].getName().equals("ds_default")){
            		
					GauceDataSet ds1 = gis.read("DS_DEFAULT");
					
					cstmt = conn.prepareCall(arr_sql[1].toString());
	            
					cstmt.registerOutParameter(1, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(1);	//커서 OUT param. 					
							            
					gos.write(getDataSet(rs, ds1));
					
            	}

            }
		}catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e){
			gres.addException(e);
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

		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
        
		/* DataSet */
        GauceDataSet ds_default= gis.read("DS_DEFAULT");


		try{
			
			if (ds_default != null) {
				
				GauceDataRow[] 	rows    = ds_default.getDataRows();


				int colNm_REQUEST_CD    	= ds_default.indexOfColumn("REQUEST_CD");					
				int colNm_REQUEST_NM    	= ds_default.indexOfColumn("REQUEST_NM");				
				int colNm_PROP1				= ds_default.indexOfColumn("PROP1");			//                   
				int colNm_PROP2				= ds_default.indexOfColumn("PROP2");			//
				int colNm_COMPANY_NM   		= ds_default.indexOfColumn("COMPANY_NM");		//   
				int colNm_DEPT_CD			= ds_default.indexOfColumn("DEPT_CD");			//  				
				int colNm_PM   				= ds_default.indexOfColumn("PM");				//      



				for(int i=0; i<rows.length; i++){
					
					/*
					StringUtil.printMsg("colNm_PLJ_NM",rows[i].getString(colNm_PLJ_NM),this);
					StringUtil.printMsg("colNm_COST_CD",rows[i].getString(colNm_COST_CD),this);
					StringUtil.printMsg("colNm_PROP1",rows[i].getString(colNm_PROP1),this);
					StringUtil.printMsg("colNm_PROP2",rows[i].getString(colNm_PROP2),this);
					StringUtil.printMsg("colNm_ORDER_COMP_CD",rows[i].getString(colNm_ORDER_COMP_CD),this);
					StringUtil.printMsg("iParamEmpno",iParamEmpno,this);*/

					cstmt = conn.prepareCall(arr_sql[2].toString());
					

					cstmt.setString(1, rows[i].getString(colNm_REQUEST_CD));
					cstmt.setString(2, rows[i].getString(colNm_REQUEST_NM));					
					cstmt.setString(3, rows[i].getString(colNm_PROP1));
					cstmt.setString(4, rows[i].getString(colNm_PROP2));
					cstmt.setString(5, rows[i].getString(colNm_COMPANY_NM));
					cstmt.setString(6, rows[i].getString(colNm_DEPT_CD));
					cstmt.setString(7, rows[i].getString(colNm_PM));
					cstmt.setInt(8, rows[i].getJobType() );	//가우스행 작업 값
					cstmt.setString(9, iParamEmpno);
					
					cstmt.executeUpdate();
					
					if(cstmt!=null) cstmt.close();		
						
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



