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

public class Rq011 extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		
		for(int i=0; i<arr_sql.length; i++)
			
			arr_sql[i] = new StringBuffer();
		
		
		
				//	실행 조회
				arr_sql[1].append ("{call PMS.PR_NEW_RQ011_01(?,?,?) }" );
				

				
				// 구매의뢰서 detail 조회
				arr_sql[2].append ("{call PMS.PR_NEW_RQ011_02(?,?,?) }" );
				

				
				// 구매의뢰서 디테일(청구 품목 list) 저장 
				arr_sql[3].append ("{call PMS.PR_NEW_RQ011_03(?,?,?,?,?,  ?,?,?,?) }" );
				

				

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


		String v_project_code 		= HDUtil.nullCheckStr(greq.getParameter("v_project_code"));		// 
		String v_request_no 		= HDUtil.nullCheckStr(greq.getParameter("v_request_no"));		// 

        GauceInputStream gis  = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {
            
            
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 

			
            for(int i=0; i<dSets.length;i++){

            	
            	if(dSets[i].getName().equals("ds_master")){

					GauceDataSet ds1 = gis.read("DS_MASTER");
					
					cstmt = conn.prepareCall(arr_sql[1].toString());

					cstmt.setString(1, v_project_code);
					cstmt.setString(2, v_request_no);
					
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 					

					gos.write(getDataSet(rs, ds1));
					
            	}
            	

            	
            	if(dSets[i].getName().equals("ds_detail")){
            		

					GauceDataSet ds1 = gis.read("DS_DETAIL");
					
					cstmt = conn.prepareCall(arr_sql[2].toString());
					
					cstmt.setString(1, v_project_code);
					cstmt.setString(2, v_request_no);
					
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 	
					
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

		GauceInputStream gis 	= greq.getGauceInputStream();
        GauceOutputStream gos 	= gres.getGauceOutputStream();


        GauceDataSet ds_detail2 	= gis.read("DS_DETAIL2");
		
		try{

			
			//저장
			if (ds_detail2 != null) {
				
				GauceDataRow[] 		rows = ds_detail2.getDataRows();

				
				int colNm_NO_MA_REQUEST			= ds_detail2.indexOfColumn("NO_MA_REQUEST");		//구매의뢰서 번호
				int colNm_SN_NO					= ds_detail2.indexOfColumn("SN_NO");				//품목순번
				int colNm_CD_COST				= ds_detail2.indexOfColumn("CD_COST");				//상세분류코드(공통코드)
				int colNm_DS_ITEM				= ds_detail2.indexOfColumn("DS_ITEM");				//상세분류명
				int colNm_QN_ITEM				= ds_detail2.indexOfColumn("QN_ITEM");				//청구수량(청구)
				int colNm_UP_ITEM				= ds_detail2.indexOfColumn("UP_ITEM");				//청구단가 = 실행금액
				int colNm_AM_ITEM				= ds_detail2.indexOfColumn("AM_ITEM");				//청구금액 = 청구수량 * 실행금액	

				
				for(int i=0; i<rows.length; i++){

					
					cstmt = conn.prepareCall(arr_sql[3].toString());

					cstmt.setString(1, rows[i].getString(colNm_NO_MA_REQUEST));			//프로젝트 코드 : 구매의뢰서 번호
					cstmt.setString(2, rows[i].getString(colNm_SN_NO));					//프로젝트 코드 : 번호
					cstmt.setString(3, rows[i].getString(colNm_CD_COST));				//프로젝트 코드 : 상세분류코드
					cstmt.setString(4, rows[i].getString(colNm_DS_ITEM));				//프로젝트 코드 : 상세분류명
					cstmt.setString(5, rows[i].getString(colNm_QN_ITEM));				//프로젝트 코드 : 청구수량
					cstmt.setString(6, rows[i].getString(colNm_UP_ITEM));				//프로젝트 코드 : 청구단가 
					cstmt.setString(7, rows[i].getString(colNm_AM_ITEM));				//프로젝트 코드 : 청구금액 
					
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



