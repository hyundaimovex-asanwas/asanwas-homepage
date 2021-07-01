package sales.menu.cq;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.gauce.GauceContext;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.log.Logger;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;
import sales.common.HDConstant;

public class Cq230S extends SuperServlet {
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		arr_sql[1].append("CALL SALES.PR_CQ230S_01(?,?,?,?,?,       ?,?)"); // 메인 조회
		}
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		StringUtil.printMsg("DS TYPE","선조회",this);
	}
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		/* DataSet */
		GauceDataSet ds1 = null; // 대리점 정보
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		ResultSetMetaData 	rsmd 		= null;
		String[] 			columnName 	= null;
		CallableStatement cstmt;
		
		try {
			/*
			* 검색시 필요한 조건
			*/
			int sSaup_sid 		= HDUtil.nullCheckNum(req.getParameter("sSaup_sid"));			// 사업소
			String sDepart_date = HDUtil.nullCheckStr(req.getParameter("sDepart_date")); 	// 출경일자
			String sDepart_time = HDUtil.nullCheckStr(req.getParameter("sDepart_time")); 	// 출경시간 
			int sGoods_sid 		= HDUtil.nullCheckNum(req.getParameter("sGoods_sid"));	// 상품SID 
			int sClientSid 		= HDUtil.nullCheckNum(req.getParameter("sClient_sid"));		// 매출처
			String v_accept_no 	= HDUtil.nullCheckStr(req.getParameter("v_accept_no"));	// 신청서번호		
			String sJobsel 	= HDUtil.nullCheckStr(req.getParameter("sJobsel"));				// 신분구분
		
			//StringUtil.printMsg("사업소",sSaup_sid+"",this);
			//StringUtil.printMsg("출경일자",sDepart_date,this);
			//StringUtil.printMsg("출경시간",sDepart_time,this);
			//StringUtil.printMsg("상품SID",sGoods_sid+"",this);
			//StringUtil.printMsg("매출처",sClientSid+"",this);
			//StringUtil.printMsg("신청서번호",v_accept_no,this);
			//StringUtil.printMsg("신분구분",sJobsel,this);
		
			int v_rowcnt = 0;
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			StringUtil.printMsg("dsType",dsType,this);
			Iterator it = req.getGauceDataSetKeys();
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
			
				if(ds1!=null){
					switch(dsType){
						case 1:
							int sCnt1 = 1;
							res.enableFirstRow(ds1);
					
							cstmt = conn.prepareCall(arr_sql[1].toString());
							cstmt.setInt(1,sSaup_sid);
							cstmt.setInt(2, sGoods_sid);
							cstmt.setInt(3, sClientSid);
							cstmt.setString(4, sDepart_date);
							cstmt.setString(5, sDepart_time);
							cstmt.setString(6, v_accept_no);
							cstmt.setString(7, sJobsel);
							rs = cstmt.executeQuery();							
							getDataSet(rs, ds1).flush();
						break;
						case 2:
						break;
					}
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
			if(stmt!=null) stmt.close();
		}
	}

	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

}
