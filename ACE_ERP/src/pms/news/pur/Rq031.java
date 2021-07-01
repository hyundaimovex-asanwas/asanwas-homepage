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

public class Rq031 extends SuperServlet {

	/**
	 * 
	 */
	
	private static final long serialVersionUID = 1L;

	
	public void makeSql(){
		
		
		for(int i=0; i<arr_sql.length; i++)
			
			
			arr_sql[i] = new StringBuffer();
		
		
				//	조회  
				arr_sql[1].append ("{call PMS.PR_NEW_RQ031_01(?,?,?) }" );


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
		
		CallableStatement 	cstmt 	= null;
		ResultSet 				rs 	= null;


		String v_project 				= HDUtil.nullCheckStr(greq.getParameter("v_project"));			// 
		String v_contents 				= HDUtil.nullCheckStr(greq.getParameter("v_contents"));				// 
		
		//System.out.println("select 입니다.");
		
        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

        
		try {
            
            
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 

			
            for(int i=0; i<dSets.length;i++){

            	if(dSets[i].getName().equals("ds_default")){

					GauceDataSet ds1 = gis.read("DS_DEFAULT");
					
					cstmt = conn.prepareCall(arr_sql[1].toString());

					cstmt.setString(1, v_project);
					cstmt.setString(2, v_contents);
					
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

        GauceOutputStream gos = gres.getGauceOutputStream();

		try{

			gos.close();

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




