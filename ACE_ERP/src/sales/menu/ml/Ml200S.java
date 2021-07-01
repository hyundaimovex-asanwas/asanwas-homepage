package sales.menu.ml;

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

public class Ml200S extends SuperServlet {
 
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		arr_sql[0].append("{call SALES.PR_ML200S_01(?,?,?,?,?,   ?)}");

	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		String v_fr_date 	= HDUtil.nullCheckStr(greq.getParameter("sBgnDate")); 	// 주문일자 From
		String v_to_date 	= HDUtil.nullCheckStr(greq.getParameter("sEndDate")); 	// 주문일자 To
		String v_tr_gu		= HDUtil.nullCheckStr(greq.getParameter("sTrGu")); 		// 거래구분
		String v_tr_gu2		= HDUtil.nullCheckStr(greq.getParameter("sTrGu2")); 		// 거래구분2		
		String v_order_nm	= HDUtil.nullCheckStr(greq.getParameter("sTr_OrderNm")); 			// 주문자명
        
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//DS_MAIN=ds_main
            	if(dSets[i].getName().equals("ds_main")){
					GauceDataSet ds1 = gis.read("DS_MAIN");
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, v_fr_date);
					cstmt.setString(2, v_to_date);
					cstmt.setString(3, v_tr_gu);
					cstmt.setString(4, v_tr_gu2);					
					cstmt.setString(5, v_order_nm);
					cstmt.registerOutParameter(6, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(6);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}
			}
		}catch (SQLException sqle){
			throw sqle;
		} catch (Exception e){
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

}
