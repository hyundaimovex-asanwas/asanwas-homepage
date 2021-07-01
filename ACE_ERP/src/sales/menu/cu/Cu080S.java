package sales.menu.cu;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;


public class Cu080S extends SuperServlet {

    public void makeSql(){
//		for(int i=0; i<arr_sql.length; i++)
//			arr_sql[i] = new StringBuffer();
   	
		//SELECT DATA
		arr_sql[0].append("{call SALES.PR_CU080S_01(?, ?, ?, ?, ? ) }");	//매출처 SID,한글성명,주민/여권번호,방북증 승인번호 

		//UPDATE DATA
//		arr_sql[1].append("{call SALES.PR_RV201S_02 (? ) }");
    	
    }
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {

	}	
	
	// 조회 method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		//System.out.println("# Command : 조회");

		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;

		/* DataSet */
		GauceDataSet ds1 = null; // 대리점 정보 
		
		CallableStatement cstmt = null;		
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		/*
		 * 검색시 필요한 조건
		 */
		int	   sClientSid  	= HDUtil.nullCheckNum(req.getParameter("sClientSid"));	// 검색조건: 거래처 아이디 
		String sEducNo    	= HDUtil.nullCheckStr(req.getParameter("sEducNo"));		// 검색조건: 방북증 승인번호
		String sNcardNo    	= HDUtil.nullCheckStr(req.getParameter("sNcardNo"));	// 검색조건: 방북증번호
		String sCustNm    	= HDUtil.nullCheckStr(req.getParameter("sCustNm"));		// 검색조건: 고객명
		String sManageNo 	= HDUtil.nullCheckStr(req.getParameter("sManageNo"));	// 검색조건: 주민/여권번호

		try {
			//int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				//StringUtil.printMsg("가우스명 - ", gauceName, this);
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if ("DEFAULT".equals(gauceName)) {
						//조회쿼리
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setInt(1, sClientSid);		//IN 
						cstmt.setString(2, sCustNm);		//IN
						cstmt.setString(3, sManageNo);		//IN
						cstmt.setString(4, sEducNo);		//IN
						cstmt.setString(5, sNcardNo);		//IN
						
						
						rs = cstmt.executeQuery();
						
						//업뎃쿼리
						//cstmt = conn.prepareCall(arr_sql[1].toString());
						//cstmt.setString(1, s_manage_no);

						//cstmt.executeUpdate();						
					}
					getDataSet(rs, ds1).flush();

				}
			}

		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
	}

	/**
	 * 기능 :
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 *
	 */
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {

	}

}
