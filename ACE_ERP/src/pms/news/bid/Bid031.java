package pms.news.bid;

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

public class Bid031 extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
				//	default 조회
				arr_sql[1].append ("{call PMS.PR_NEW_BID031_01(?,?)}");

				
				//	insert/update 쿼리
				arr_sql[2].append ("{call PMS.PR_NEW_BID031_02(?,?,?,?,?,?,?,?,?,?,?,?)}");
				
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

		String v_order 			= HDUtil.nullCheckStr(greq.getParameter("v_order"));		

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

        
		try {
            
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 

			
            for(int i=0; i<dSets.length;i++){
            
            	if(dSets[i].getName().equals("ds_default")){
            		
					GauceDataSet ds1 = gis.read("DS_DEFAULT");
					
						cstmt = conn.prepareCall(arr_sql[1].toString());
					 
					 	cstmt.setString(1, v_order);	

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
	
		CallableStatement 	cstmt 		= null;	
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		
		String iParamEmpno 	= fParamEmpno;
	
		GauceInputStream gis 	= greq.getGauceInputStream();
        GauceOutputStream gos 	= gres.getGauceOutputStream();

        GauceDataSet ds_default = gis.read("DS_DEFAULT");

        
		try{
			
			if (ds_default != null) {
				
				GauceDataRow[] 		rows = ds_default.getDataRows();

				int colNm_ORDER_CD				= ds_default.indexOfColumn("ORDER_CD");        		// ORDER_CD            
				int colNm_ORDER_NM     			= ds_default.indexOfColumn("ORDER_NM");   			// ORDER_NM       
				int colNm_COMPANY_NM			= ds_default.indexOfColumn("COMPANY_NM");			// COMPANY_NM
				int colNm_CONTENT    			= ds_default.indexOfColumn("CONTENT");     			// CONTENT
				int colNm_PERIOD				= ds_default.indexOfColumn("PERIOD");				// PERIOD
				int colNm_CONTRACT_AMT    		= ds_default.indexOfColumn("CONTRACT_AMT");     	// CONTRACT_AMT		
				int colNm_EXECUTE_AMT    		= ds_default.indexOfColumn("EXECUTE_AMT");     		// EXECUTE_AMT
				int colNm_SALES_PROFIT			= ds_default.indexOfColumn("SALES_PROFIT");			// SALES_PROFIT
				int colNm_PROFIT_RATE    		= ds_default.indexOfColumn("PROFIT_RATE");     		// PROFIT_RATE		
				int colNm_REMARK    			= ds_default.indexOfColumn("REMARK");     			// REMARK
				int colNm_ORDER_DT				= ds_default.indexOfColumn("ORDER_DT");				// ORDER_DT


				for(int i=0; i<rows.length; i++){
					
					// 가우스 행 JobType : 2=insert, 3=update, 4=delete
					//StringUtil.printMsg("ds1의 "+i+"행 작업===",rows[i].getJobType(),this);
					//쿼리 호출
					
					cstmt = conn.prepareCall(arr_sql[2].toString());
					
					cstmt.setString(1, rows[i].getString(colNm_ORDER_CD));
					cstmt.setString(2, rows[i].getString(colNm_ORDER_NM));
					cstmt.setString(3, rows[i].getString(colNm_COMPANY_NM));	
					cstmt.setString(4, rows[i].getString(colNm_CONTENT));	
					cstmt.setString(5, rows[i].getString(colNm_PERIOD));
					cstmt.setString(6, rows[i].getString(colNm_CONTRACT_AMT));
					cstmt.setString(7, rows[i].getString(colNm_EXECUTE_AMT));	
					cstmt.setString(8, rows[i].getString(colNm_SALES_PROFIT));	
					cstmt.setString(9, rows[i].getString(colNm_PROFIT_RATE));	
					cstmt.setString(10, rows[i].getString(colNm_REMARK));	
					cstmt.setString(11, rows[i].getString(colNm_ORDER_DT));
					cstmt.setString(12, iParamEmpno);						
					
					
					cstmt.executeUpdate();
					
					if(cstmt!=null) cstmt.close();		
				}
			}
			
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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




