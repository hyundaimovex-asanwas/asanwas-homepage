package pms.news.pur;

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

public class Rq010 extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		
		for(int i=0; i<arr_sql.length; i++)
			
			
			arr_sql[i] = new StringBuffer();
		
		
				//	default 조회  , 구매의뢰서 작성 ,조건  - project 
				arr_sql[1].append ("{call PMS.PR_NEW_RQ010_01(?,?) }" );

				
				
				//	구매의뢰서 작성 + 저장   
				arr_sql[2].append ("{call PMS.PR_NEW_RQ010_02(?,?,?,?,?,?,?,?,?) }" );

				
				
				//	구매의뢰서 승인요청
				arr_sql[3].append ("{call PMS.PR_NEW_RQ010_03(?,?) }" );

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
		ResultSet 			rs 	= null;


		String v_project 			= HDUtil.nullCheckStr(greq.getParameter("v_project"));			// v_project
		

        GauceInputStream gis  = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

        
		try {
            
            
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 

			
            for(int i=0; i<dSets.length;i++){

            	
            	if(dSets[i].getName().equals("ds_default")){

					GauceDataSet ds1 = gis.read("DS_DEFAULT");
					
					cstmt = conn.prepareCall(arr_sql[1].toString());

					
					cstmt.setString(1, v_project);

					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					

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

	

		CallableStatement cstmt 		= null;	
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		
		String iParamEmpno 	= fParamEmpno;
		String v_stat 		= HDUtil.nullCheckStr(greq.getParameter("v_stat"));		// status   
		
				
		GauceInputStream gis 	= greq.getGauceInputStream();
        GauceOutputStream gos 	= gres.getGauceOutputStream();
        

        GauceDataSet ds_default 	= gis.read("DS_DEFAULT");
        

		try{
			
			
				if (ds_default != null) {
				

						if (!v_stat.equals("R")) {				

							GauceDataRow[] 		rows = ds_default.getDataRows();
			
							int colNm_COST_CD        	= ds_default.indexOfColumn("COST_CD");          
							int colNm_NO_MA_REQUEST     = ds_default.indexOfColumn("NO_MA_REQUEST");          
							int colNm_DS_MA_REQUEST     = ds_default.indexOfColumn("DS_MA_REQUEST");          
							int colNm_TY_BUYTYPE		= ds_default.indexOfColumn("TY_BUYTYPE");
							int colNm_REMARK			= ds_default.indexOfColumn("REMARK");
							int colNm_VEND_CD			= ds_default.indexOfColumn("VEND_CD");
							int colNm_VEND_NM			= ds_default.indexOfColumn("VEND_NM");
							
							for(int i=0; i<rows.length; i++){
			
								cstmt = conn.prepareCall(arr_sql[2].toString());
			
								cstmt.setString(1, rows[i].getString(colNm_COST_CD));			//프로젝트 코드
								cstmt.setString(2, rows[i].getString(colNm_NO_MA_REQUEST));		//구매의뢰서 번호	
								cstmt.setString(3, rows[i].getString(colNm_DS_MA_REQUEST));		//contents	
								cstmt.setString(4, rows[i].getString(colNm_TY_BUYTYPE));		//구매근거
								cstmt.setString(5, rows[i].getString(colNm_REMARK));			//비고	
								cstmt.setString(6, rows[i].getString(colNm_VEND_CD));			//거래처코드
								cstmt.setString(7, rows[i].getString(colNm_VEND_NM));			//거래처명
								
								cstmt.setInt(8, rows[i].getJobType() );	//가우스행 작업 값
								cstmt.setString(9, iParamEmpno);
			
								cstmt.executeUpdate();
								
								if(cstmt!=null) cstmt.close();		
								
							}
						
						}
						
					
					
					
						if (v_stat.equals("R")) {
					
							GauceDataRow[] 		rows = ds_default.getDataRows();
							
							int colNm_NO_MA_REQUEST     = ds_default.indexOfColumn("NO_MA_REQUEST");          

							for(int i=0; i<rows.length; i++){
			
								cstmt = conn.prepareCall(arr_sql[3].toString());
			
								cstmt.setString(1, rows[i].getString(colNm_NO_MA_REQUEST));		//구매의뢰서 번호	
								cstmt.setString(2, iParamEmpno);
			
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




