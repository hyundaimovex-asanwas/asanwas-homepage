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

public class Bud025 extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		

		
		
				//	PROJECT 정보 조회
				arr_sql[1].append ("{call PMS.PR_NEW_BUD025_01(?,?,?)}");
				


				//	insert or update쿼리
				arr_sql[2].append ("{call PMS.PR_NEW_BUD025_02(?,?,?,?,?,?,?,?,?,?)}");
				
				
			
				
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
		ResultSet rs			= null;
	

		//bd025.jsp 값 받기 
		String v_project 		= HDUtil.nullCheckStr(greq.getParameter("v_project"));		
		String v_no_budget 		= HDUtil.nullCheckStr(greq.getParameter("v_no_budget"));	

		
        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {
            
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 

			
            for(int i=0; i<dSets.length;i++){
            	
				StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS_DEFAULT=ds_default

            	if(dSets[i].getName().equals("ds_default")){
            		
					GauceDataSet ds1 = gis.read("DS_DEFAULT");

					cstmt = conn.prepareCall(arr_sql[1].toString());
					StringUtil.printMsg(" 컴포넌트의 데이터셋 네임1 ",v_project,this);	
				 	cstmt.setString(1, v_project);
				 	cstmt.setString(2, v_no_budget);		
				 	StringUtil.printMsg(" 컴포넌트의 데이터셋 네임2 ",v_project,this);	
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

		CallableStatement 	cstmt 		= null;	
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		
		String iParamEmpno 	= fParamEmpno;

				
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
        //저장 
        GauceDataSet ds_default = gis.read("DS_DEFAULT");
        

		try{

			if (ds_default != null) {
				
				
				GauceDataRow[] 		rows = ds_default.getDataRows();
				
				
				int colNm_COST_CD				= ds_default.indexOfColumn("COST_CD");        		// 프로젝트코드            
				int colNm_NO_BUDGET        		= ds_default.indexOfColumn("NO_BUDGET");   			// 차수       
				int colNm_CD_COST				= ds_default.indexOfColumn("CD_COST");				// 상세분류코드
				int colNm_DS_KSITEM    			= ds_default.indexOfColumn("DS_KSITEM");     		// 품목명
				int colNm_COST_YN    			= ds_default.indexOfColumn("COST_YN");     			// node,leaf 여부
				int colNm_ORDER_AMT_NOW    		= ds_default.indexOfColumn("ORDER_AMT_NOW");   		// 도급금액(현재)         
				int colNm_EXE_ACT_AMT_NOW      	= ds_default.indexOfColumn("EXE_ACT_AMT_NOW");      // 실행예산(현재) 
				int colNm_ITEM_CD      			= ds_default.indexOfColumn("ITEM_CD");       		// 품목코드 

				
				for(int i=0; i<rows.length; i++){

					if(rows[i].getJobType()==2){
						
						cstmt = conn.prepareCall(arr_sql[4].toString());
						
						cstmt.setString(1, rows[i].getString(colNm_COST_CD));
						cstmt.setString(2, rows[i].getString(colNm_NO_BUDGET));	
						cstmt.setString(3, rows[i].getString(colNm_CD_COST));	
						cstmt.setString(4, rows[i].getString(colNm_DS_KSITEM));
						cstmt.setString(5, rows[i].getString(colNm_COST_YN));	
						cstmt.setString(6, rows[i].getString(colNm_ORDER_AMT_NOW));
						cstmt.setString(7, rows[i].getString(colNm_EXE_ACT_AMT_NOW));	
						cstmt.setString(8, rows[i].getString(colNm_ITEM_CD));	
						
						cstmt.setInt(9, rows[i].getJobType() );	//가우스행 작업 값
						
						cstmt.setString(10, iParamEmpno);
						
						cstmt.executeUpdate();
						
						
					}else if(rows[i].getJobType()==3){
						
						cstmt = conn.prepareCall(arr_sql[4].toString());
						
						cstmt.setString(1, rows[i].getString(colNm_COST_CD));
						cstmt.setString(2, rows[i].getString(colNm_NO_BUDGET));	
						cstmt.setString(3, rows[i].getString(colNm_CD_COST));	
						cstmt.setString(4, rows[i].getString(colNm_DS_KSITEM));
						cstmt.setString(5, rows[i].getString(colNm_COST_YN));
						cstmt.setString(6, rows[i].getString(colNm_ORDER_AMT_NOW));
						cstmt.setString(7, rows[i].getString(colNm_EXE_ACT_AMT_NOW));	
						cstmt.setString(8, rows[i].getString(colNm_ITEM_CD));	
						
						cstmt.setInt(9, rows[i].getJobType() );	//가우스행 작업 값
						
						cstmt.setString(10, iParamEmpno);
						
						cstmt.executeUpdate();
						
					
					}
					
					

					
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