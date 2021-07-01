package sales.menu.ac;

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

import sales.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;

public class Ac080I_02 extends SuperServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		arr_sql[1].append("CALL SALES.PR_AC080I_01_01(?,?,?, ?)");	// 조회
	}

	
	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {


	} 
	

	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		
		try {
			String sBgnDate = HDUtil.nullCheckStr(greq.getParameter("c_pay_date1"));
			String sAcctGu  = HDUtil.nullCheckStr(greq.getParameter("v_bank_acc_no"));
			String sTr_Sum  = HDUtil.nullCheckStr(greq.getParameter("v_order_nm"));
			//StringUtil.printMsg("sBgnDate ",sBgnDate,this);
			//StringUtil.printMsg("sAcctGu ",sAcctGu,this);
			//StringUtil.printMsg("sTr_Sum ",sTr_Sum,this);
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
            
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				// MAIN_DS=ds_tongjang
            	if(dSets[i].getName().equals("ds_tongjang")){
					GauceDataSet ds1 = gis.read("MAIN_DS");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1,sBgnDate );
					cstmt.setString(2,sTr_Sum);
					cstmt.setString(3,sAcctGu );
					cstmt.registerOutParameter(4, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(4);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
					
				}
            }

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

	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {

		
	}
	
}
