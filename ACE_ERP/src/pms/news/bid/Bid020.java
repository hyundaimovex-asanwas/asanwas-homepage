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

public class Bid020 extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		
		

				//	default 조회
				arr_sql[1].append ("{call PMS.PR_NEW_BID020_01(?,?,?,?,?)}");
				
				
				
				// bid011.jsp Detail 조회
				arr_sql[2].append ("{call PMS.PR_NEW_BID020_02(?,?,?)}");
				

				
				//	insert/update 쿼리
				arr_sql[4].append ("{call PMS.PR_NEW_BID020_03(?,?,?,?)}");
				


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

		
		String v_frdt 			= HDUtil.nullCheckStr(greq.getParameter("v_frdt"));	
		String v_todt 			= HDUtil.nullCheckStr(greq.getParameter("v_todt"));				
		String v_bid 			= HDUtil.nullCheckStr(greq.getParameter("v_bid"));		
		String v_status 		= HDUtil.nullCheckStr(greq.getParameter("v_status"));	

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

        
		try {
            
			
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 

			
            for(int i=0; i<dSets.length;i++){
            
            	if(dSets[i].getName().equals("ds_default")){
            		
					GauceDataSet ds1 = gis.read("DS_DEFAULT");
					

						cstmt = conn.prepareCall(arr_sql[1].toString());
					 
					 	cstmt.setString(1, v_frdt);
					 	cstmt.setString(2, v_todt);		
					 	cstmt.setString(3, v_bid);	
					 	cstmt.setString(4, v_status);	
					 	cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//결과를 받을 커서
					 
					 	cstmt.executeQuery();
						
						rs = (ResultSet)cstmt.getObject(5);	//커서 OUT param. 		

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
				
		    	//alert("입력값 확인:::1:"+V_COST_CD+"2:"+V_TY_BUDGET+"3:"+V_DS_BUDGET+"4:"+V_I_EMPNO);
				
				int cost_cd		= ds_default.indexOfColumn("COST_CD");                    
				int ty_budget   = ds_default.indexOfColumn("TY_BUDGET");          
				int ds_budget	= ds_default.indexOfColumn("DS_BUDGET");
				int I_EMPNO    	= ds_default.indexOfColumn("I_EMPNO");   
				int jobtype 	= 2;
				
				
				//System.out.println(rows.length+":cost_cd:"+cost_cd+":ty_budget:"+ty_budget+":ds_budget:"+ds_budget+":I_EMPNO:"+I_EMPNO);
				
				
				for(int i=0; i<rows.length; i++){
					
					// 가우스 행 JobType : 2=insert, 3=update, 4=delete
					//StringUtil.printMsg("ds1의 "+i+"행 작업===",rows[i].getJobType(),this);
					/*
					System.out.println(":cost_cd:"+rows[i].getString(cost_cd));
					System.out.println(":cost_cd:"+rows[i].getString(ty_budget));
					System.out.println(":cost_cd:"+rows[i].getString(ds_budget));
					System.out.println(":cost_cd:"+rows[i].getString(I_EMPNO));
					*/
					//쿼리 호출
					
					cstmt = conn.prepareCall(arr_sql[4].toString());
					
					cstmt.setString(1, rows[i].getString(cost_cd));
					cstmt.setString(2, rows[i].getString(ty_budget));
					cstmt.setString(3, rows[i].getString(ds_budget));	
					//cstmt.setString(4, rows[i].getString(I_EMPNO));	
					cstmt.setString(4, iParamEmpno);					
					
					
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




