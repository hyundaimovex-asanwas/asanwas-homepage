package Account;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.HDUtil;
import sales.common.SuperServlet;
import sales.common.StringUtil;

public class a030013_s1_proc extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//Main 조회
		arr_sql[0].append ("{call ACCOUNT.PR_A030013_S1('02','20110801','20110805','0020','K99086','K99086','1110110') }" );
   }

	//init method
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
	}	
	
	//select method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		int v_site_sid 			= HDUtil.nullCheckNum(req.getParameter("v_site_sid"));			// 사업소
		int v_coop_sid 			= HDUtil.nullCheckNum(req.getParameter("v_coop_sid"));			// 상품
		int v_pct_fr 			= HDUtil.nullCheckNum(req.getParameter("v_pct_fr"));		// 매출처
		int v_pct_to 			= HDUtil.nullCheckNum(req.getParameter("v_pct_to"));			// 단체행사.
		String v_bid_kind_cd 	= HDUtil.nullCheckStr(req.getParameter("v_bid_kind_cd")); 	// 출경일자 From
		String v_fr_bid_date 	= HDUtil.nullCheckStr(req.getParameter("v_fr_bid_date")); 	// 출경일자 To
		String v_to_bid_date	= HDUtil.nullCheckStr(req.getParameter("v_to_bid_date")); 			// 예약상태
		String v_reco_cd		= HDUtil.nullCheckStr(req.getParameter("v_reco_cd")); 		// 신청서번호
		String v_bid_style		= HDUtil.nullCheckStr(req.getParameter("v_bid_style")); 		// 신청서번호
		String v_bid_status		= HDUtil.nullCheckStr(req.getParameter("v_bid_status")); 		// 신청서번호
		
		//StringUtil.printMsg("야야야야양","1",this);
		try {
			Iterator it = req.getGauceDataSetKeys();
			while (it.hasNext()) {
				String gauceName = (String)it.next();

				GauceDataSet ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);

					if(gauceName.equals("DS_DEFAULT")){
						cstmt = conn.prepareCall(arr_sql[0].toString());
					}
					
					rs = cstmt.executeQuery();
					getDataSet(rs, ds1).flush();
					
				}
			}
		}catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
	
	//apply method
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
	}

	@Override
	public void init(Connection conn, HttpGauceRequest greq,
			HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void select(Connection conn, HttpGauceRequest greq,
			HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void apply(Connection conn, HttpGauceRequest greq,
			HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		
	}
}