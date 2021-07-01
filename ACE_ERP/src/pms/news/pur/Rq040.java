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

public class Rq040 extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			
			arr_sql[i] = new StringBuffer();
		
		
		
				//	default 조회  , 구매의뢰서 발주 ,조건  - project 
				arr_sql[1].append ("{call PMS.PR_NEW_RQ040_01(?,?) }" );
				
				
				
				// default 조회 , 프로젝트 팝업, param - Project
				//arr_sql[1].append ("{call PMS.PR_NEW_RQ010S_02(?,?) }" );

				
				
				//	default 저장  , 구매의뢰서 작성 ,저장  - project 
				//arr_sql[2].append ("{call PMS.PR_NEW_RQ040S_03(?,?,?,?,?,?,?) }" );

				
				
				//	default 조회  , 구매의뢰서 발주 디테일(발주 기본 정보) ,조회  - project_code , v_project_no
				//arr_sql[3].append ("{call PMS.PR_NEW_RQ041S_01(?,?,?) }" );
				
				
				
				//	default 조회  , 구매의뢰서 발주 디테일(발주 품목 list) ,조회  - project_code , v_project_no
				//arr_sql[4].append ("{call PMS.PR_NEW_RQ041S_02(?,?,?) }" );
				
				
				
				//	default 저장  , 구매의뢰서 디테일(발주 품목 list) ,승인/저장   
				//arr_sql[5].append ("{call PMS.PR_NEW_RQ041S_03(?,?,?) }" );
				


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
		ResultSet 			rs  = null;


		String v_project 			= HDUtil.nullCheckStr(greq.getParameter("v_project"));			// 상등록공종
		//String v_po 				= HDUtil.nullCheckStr(greq.getParameter("v_po"));				// 발주 번호
		//String v_project_name 		= HDUtil.nullCheckStr(greq.getParameter("v_project_name"));		// 상등록공종
		//String v_project_code 		= HDUtil.nullCheckStr(greq.getParameter("v_project_code"));		// 상등록공종
		//String v_project_no 		= HDUtil.nullCheckStr(greq.getParameter("v_project_no"));		// 상등록공종
		

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {

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
            	
            	
            	/*
            	if(dSets[i].getName().equals("ds_culd")){

					GauceDataSet ds2 = gis.read("DS_CULD");
					
					cstmt = conn.prepareCall(arr_sql[1].toString());

					cstmt.setString(1, v_project_name);
					
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 		
					
					gos.write(getDataSet(rs, ds2));
            	}
            	 */            	
            	
            	
            	// arr_sql[3]
            	// 구매의뢰서 발주 - 상세화면 (발주 기본 정보  select)
            	/*
            	if(dSets[i].getName().equals("ds_culs")){

					GauceDataSet ds1 = gis.read("DS_CULS");
					
					cstmt = conn.prepareCall(arr_sql[3].toString());

					
					cstmt.setString(1, v_project); //프로젝트 명(code)로 값 던짐
					cstmt.setString(2, v_po); 		//발주 번호 
					
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();	//실행
					
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 	
					
					gos.write(getDataSet(rs, ds1));
					
            	}
            	*/
            	
            	
            	//arr_sql[4]
            	//구매의뢰서 발주 - 상세화면 (발주 품목 list)
            	/*
            	if(dSets[i].getName().equals("ds_culds")){

            		
					GauceDataSet ds1 = gis.read("DS_CULDS");
					
					cstmt = conn.prepareCall(arr_sql[4].toString());
					
					cstmt.setString(1, v_project); //프로젝트 명(code)로 값 던짐
					cstmt.setString(2, v_po); 	   //발주 번호 
					
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();	//실행
					
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 	
					
					gos.write(getDataSet(rs, ds1));
					
            	}
            	*/
            	
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
		

		CallableStatement 		cstmt 		= null;	
		GauceStatement 			stmt 		= null;
		ResultSet 				rs 			= null;
		
		String iParamEmpno 	= fParamEmpno;

				
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        

        GauceDataSet ds_culs = gis.read("DS_CULS");

		
		try{
			if (ds_culs != null) {
				
				GauceDataRow[] 		rows = ds_culs.getDataRows();


				int colNm_COST_CD        	= ds_culs.indexOfColumn("COST_CD");			//프로젝트 코드
				int colNm_NO_PO     		= ds_culs.indexOfColumn("NO_PO");          	//발주서 번호
  

				for(int i=0; i<rows.length; i++){
					

					cstmt = conn.prepareCall(arr_sql[5].toString());

					
					cstmt.setString(1, rows[i].getString(colNm_COST_CD));			//프로젝트 코드
					cstmt.setString(2, rows[i].getString(colNm_NO_PO));				//발주서 번호	
					cstmt.setString(3, iParamEmpno);
					
					
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



