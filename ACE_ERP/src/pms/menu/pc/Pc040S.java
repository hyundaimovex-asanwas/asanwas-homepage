package pms.menu.pc;

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

public class Pc040S extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//Main 조회
		arr_sql[0].append ("{call PMS.PR_PC040S_01(?,?,?,?,?, ?,?,?,?,?,  ?) }" );
   }

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	}	
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		int v_site_sid 			= HDUtil.nullCheckNum(greq.getParameter("v_site_sid"));			// 사업소
		int v_coop_sid 			= HDUtil.nullCheckNum(greq.getParameter("v_coop_sid"));			// 상품
		int v_pct_fr 			= HDUtil.nullCheckNum(greq.getParameter("v_pct_fr"));		// 매출처
		int v_pct_to 			= HDUtil.nullCheckNum(greq.getParameter("v_pct_to"));			// 단체행사.
		String v_bid_kind_cd 	= HDUtil.nullCheckStr(greq.getParameter("v_bid_kind_cd")); 	// 출경일자 From
		String v_fr_bid_date 	= HDUtil.nullCheckStr(greq.getParameter("v_fr_bid_date")); 	// 출경일자 To
		String v_to_bid_date	= HDUtil.nullCheckStr(greq.getParameter("v_to_bid_date")); 			// 예약상태
		String v_reco_cd		= HDUtil.nullCheckStr(greq.getParameter("v_reco_cd")); 		// 신청서번호
		String v_bid_style		= HDUtil.nullCheckStr(greq.getParameter("v_bid_style")); 		// 신청서번호
		String v_bid_status		= HDUtil.nullCheckStr(greq.getParameter("v_bid_status")); 		// 신청서번호
		
        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {
	        //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 

            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
            	if(dSets[i].getName().equals("ds_default")){
					GauceDataSet ds1 = gis.read("DS_DEFAULT");

					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, v_fr_bid_date);
					cstmt.setString(2, v_to_bid_date);
					cstmt.setString(3, v_bid_style);
					cstmt.setInt(4, v_site_sid);
					cstmt.setString(5, v_bid_kind_cd);
					cstmt.setInt(6, v_coop_sid);
					cstmt.setInt(7, v_pct_fr);
					cstmt.setInt(8, v_pct_to);
					cstmt.setString(9, v_reco_cd);
					cstmt.setString(10, v_bid_status);
					
					cstmt.registerOutParameter(11, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(11);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));

					
				}
			}
		}catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e){
			gres.addException(e);
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