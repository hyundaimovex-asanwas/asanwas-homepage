package pms.news.dsh;

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

public class Dsh013 extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		
		for(int i=0; i<arr_sql.length; i++)
			
			arr_sql[i] = new StringBuffer();
		

				//ds_default 조회
				arr_sql[1].append ("{call PMS.PR_NEW_DSH013_01(?,?)}");

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
		
		String v_project			= HDUtil.nullCheckStr(greq.getParameter("v_project"));				//프로젝트
		
		
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
			
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
			
			cstmt.executeQuery();
			
			rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
			
			gos.write(getDataSet(rs, ds1));
		
			}          	
		
		}
		
			
			
		gos.close();
		
		
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
			
			for(int i=0; i<rows.length; i++){
			
			cstmt = conn.prepareCall(arr_sql[2].toString());					
			
			cstmt.executeUpdate();
			
			if(cstmt!=null) cstmt.close();		
			
			}
		}
		
			
			
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

