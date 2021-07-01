package security.menu.li;

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

public class Li0101S extends SuperServlet {

    public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//Main 조회
		arr_sql[0].append ("{call SECURITY.PR_LI0101S_01(?,?,?,?,?,?,?) }" );
		//Main 저장
		//arr_sql[1].append ("{call SALES.PR_SY900I_02(?,?,?,?,?,   ?,?,?,?) }");
   }

	//init method
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
	}	
	
	//select method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		String v_doc_grd		= HDUtil.nullCheckStr(req.getParameter("v_doc_grd")); 		// 문서등급
		String v_doc_frm		= HDUtil.nullCheckStr(req.getParameter("v_doc_frm")); 		// 문서형태
		String v_gdeptcd		= HDUtil.nullCheckStr(req.getParameter("v_gdeptcd")); 		// 소유부서
		String v_sgn_sts		= HDUtil.nullCheckStr(req.getParameter("v_sgn_sts")); 		// 결재상태
		String v_doc_tle		= HDUtil.nullCheckStr(req.getParameter("v_doc_tle")); 		    // 제목
		String v_doc_cts		= HDUtil.nullCheckStr(req.getParameter("v_doc_cts")); 		// 내용
		String v_doc_kwd		= HDUtil.nullCheckStr(req.getParameter("v_doc_kwd")); 		// 키워드
				
		//StringUtil.printMsg("v_fr_bid_date",v_fr_bid_date,this);
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
					cstmt.setString(1, v_doc_grd);
					cstmt.setString(2, v_doc_frm);
					cstmt.setString(3, v_gdeptcd);
					cstmt.setString(4, v_sgn_sts);
					cstmt.setString(5, v_doc_tle);
					cstmt.setString(6, v_doc_cts);
					cstmt.setString(7, v_doc_kwd);
					
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