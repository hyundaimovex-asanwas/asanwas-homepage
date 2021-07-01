package pms.menu.help;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceStatement;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;


import sales.common.HDUtil;
import sales.common.StringUtil;
import pms.common.SuperServlet;
import java.sql.Connection; 
import oracle.jdbc.OracleTypes;

public class Pu001H_01 extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
			
			arr_sql[1].append (" {call PMS.PR_PU001H_01 (?,?)}");
			
	}
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;

		try{
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			String 	v_item_nm		= HDUtil.nullCheckStr(greq.getParameter("v_item_nm"));		//자재명
			
			for(int i=0; i<dSets.length;i++){
					if(dSets[i].getName().equals("ds1")){
						GauceDataSet ds1 = gis.read("MASTER");
						
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setString(1, v_item_nm);	
						cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 			
						gos.write(getDataSet(rs, ds1));
					}
			}
		 gos.close();
	}catch (SQLException sqle){
		//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
		throw sqle;
	} catch (Exception e){
		//res.writeException("ERROR", "", e.toString());
		throw e;
	} finally {
		if(rs!=null) rs.close();
		if(cstmt!=null) cstmt.close();
	}
}

	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}
	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}
}