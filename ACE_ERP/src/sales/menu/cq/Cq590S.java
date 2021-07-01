package sales.menu.cq;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

public class Cq590S extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_CQ590S_01(?,?,?,?)"); // 생성
		
		
	}

	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		StringUtil.printMsg("DS TYPE","선조회",this);
	}

	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		
		ResultSet 			rs 			= null;
		CallableStatement 	cstmt 		= null;
		
		/* DataSet */
		GauceDataSet ds1 = null; // 대리점 정보 
		
		/*
		 * 검색시 필요한 조건
		 */
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		int sSaup_sid 		= HDUtil.nullCheckNum(req.getParameter("sSaup_sid"));	// 사업소
		int sGood_sid 		= HDUtil.nullCheckNum(req.getParameter("sGoodSid")); 	// 상품 
		String sDepatrDate 	= HDUtil.nullCheckStr(req.getParameter("sDepartDate")); 	// 출경일자
		String sDepartTime	= HDUtil.nullCheckStr(req.getParameter("sDepartTime")); // 출경시간
		StringUtil.printMsg("=============================== 조회 PARAM =========================",this);
		StringUtil.printMsg("사업소", sSaup_sid,this);
		StringUtil.printMsg("상품",sGood_sid ,this);
		StringUtil.printMsg("출경일자",sDepatrDate ,this);
		StringUtil.printMsg("출경시간", sDepartTime,this);
		
		
		try {
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
			
				if(ds1!=null){
					switch(dsType){
						case 1:
							res.enableFirstRow(ds1);
							cstmt = conn.prepareCall(arr_sql[1].toString());
							
							cstmt.setInt(1, sSaup_sid);
							cstmt.setInt(2, sGood_sid);
							cstmt.setString(3, sDepatrDate);
							cstmt.setString(4, sDepartTime);
							rs = cstmt.executeQuery();		
							getDataSet(rs, ds1).flush();
							break;
						case 2:
							break;
						case 3:
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
			if(cstmt!=null) cstmt.close();
		}
		
	}

	
	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
	}
}
