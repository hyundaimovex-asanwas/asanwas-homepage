package pms.menu.pu;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.HDUtil;
import sales.common.SuperServlet;
import sales.common.StringUtil;

public class Pu010S extends SuperServlet {

    public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//Main 조회
		arr_sql[0].append ("{call PMS.PR_PU010S_01(?,?,?,?,?                    ,?,?) }" );
		}

	//init method
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
	}	
	
	//select method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

			int v_site_sid 				= HDUtil.nullCheckNum(req.getParameter("v_site_sid"));		// 현장 SID
			String v_vend_cd		 	= HDUtil.nullCheckStr(req.getParameter("v_vend_cd")); 		// 거래처코드
			int v_item_sid 				= HDUtil.nullCheckNum(req.getParameter("v_item_sid"));		// 품목
			String v_item_size	 	= HDUtil.nullCheckStr(req.getParameter("v_item_size")); 		// 규격		
			String v_fr_rqst_date 	= HDUtil.nullCheckStr(req.getParameter("v_fr_rqst_date")); 	// 요청일자 시작
			String v_to_rqst_date	= HDUtil.nullCheckStr(req.getParameter("v_to_rqst_date")); 	// 요청일자 종료
			String v_rqst_status		= HDUtil.nullCheckStr(req.getParameter("v_rqst_status")); 	// 요청상태
			
			StringUtil.printMsg("v_site_sid",v_site_sid,this);
			StringUtil.printMsg("v_vend_cd",v_vend_cd,this);
			StringUtil.printMsg("v_item_sid",v_item_sid,this);
			StringUtil.printMsg("v_item_size",v_item_size,this);
			StringUtil.printMsg("v_fr_rqst_date",v_fr_rqst_date,this);
			StringUtil.printMsg("v_to_rqst_date",v_to_rqst_date,this);
			StringUtil.printMsg("v_rqst_status",v_rqst_status,this);
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
						cstmt.setInt(1, v_site_sid);
						cstmt.setString(2, v_vend_cd);
						cstmt.setInt(3, v_item_sid);
						cstmt.setString(4, v_item_size);
						cstmt.setString(5, v_fr_rqst_date);
						cstmt.setString(6, v_to_rqst_date);
						cstmt.setString(7, v_rqst_status);
					
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
}