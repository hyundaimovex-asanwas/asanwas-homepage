package sales.menu.help;

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

public class Ac020H extends SuperServlet {

	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		arr_sql[1].append("CALL SALES.PR_AC020S_02(?,?,?,?,?,?,?,?)");	//가상계좌
		arr_sql[2].append("CALL SALES.PR_AC020S_03(?,?,?,?,?,?,?,?)");	//신용카드
		arr_sql[3].append("CALL SALES.PR_AC020S_04(?,?,?,?,?,?,?,?)");	//상품권
		arr_sql[4].append("CALL SALES.PR_AC020S_05(?,?,?,?,?,?,?,?)");	//무통
		arr_sql[5].append("CALL SALES.PR_AC020S_07(?,?,?,?,?,?,?,?)");  //환불, 환입 		
		arr_sql[6].append("CALL SALES.PR_AC020S_08(?,?,?,?,?,?,?,?)");  //보증금
		arr_sql[7].append("CALL SALES.PR_AC020S_06(?,?,?,?,?,?,?,?)");  //기타대체
		arr_sql[8].append("CALL SALES.PR_AC020S_09(?,?,?,?,?,?,?,?)");  //온라인카드
		
		
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res) throws ServletException, Exception {
		
	}
	
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res) throws ServletException, Exception {
		
	}
	
	// 조회 method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res) throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		ResultSetMetaData 	rsmd 		= null;
		String[] 			columnName 	= null;
		CallableStatement cstmt;
		
		int v_rowcnt = 0;

		/* DataSet */
		GauceDataSet ds1 = null; // 대리점 정보 
		
		/*
		 * 검색시 필요한 조건
		 */
		
		int sSaup_sid 		= HDUtil.nullCheckNum(req.getParameter("sSaup_sid"));	// 사업소
		int sGoods_sid 		= HDUtil.nullCheckNum(req.getParameter("sGoods_sid"));			// 상품SID 
		int sClientSid 		= HDUtil.nullCheckNum(req.getParameter("sClient_sid"));	// 매출처 
		String sSDate 		= HDUtil.nullCheckStr(req.getParameter("sSDate")); 	// 출경일자
		int sUpjangSid 		= HDUtil.nullCheckNum(req.getParameter("sUpjang_sid")); // 영업장
		String sCustGu		= HDUtil.nullCheckStr(req.getParameter("sCustGu")); // 고객구분 
		String v_status 	= HDUtil.nullCheckStr(req.getParameter("v_status")); //예약상태
		
		//StringUtil.printMsg("sSaup_sid 		= ", sSaup_sid 			,this);
		//StringUtil.printMsg("sGoods_sid 	= ", sGoods_sid 	    ,this); 
		//StringUtil.printMsg("sClientSid 	= ", sClientSid 	    ,this);
		//StringUtil.printMsg("sSDate 		= ", sSDate 		    ,this);
		//StringUtil.printMsg("sUpjangSid 	= ", sUpjangSid 	    ,this);
		//StringUtil.printMsg("sCustGu 		= ", sCustGu 	    	,this);
		//StringUtil.printMsg("v_status 	= ", v_status 	    ,this);
		try {
			int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
			
				StringUtil.printMsg("DS Name= "+ gauceName,this);
				
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if ("DS020".equals(gauceName)) {	//가상계좌
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setInt(2, sGoods_sid);
						cstmt.setInt(3, sClientSid);
						cstmt.setInt(4, sUpjangSid);
						cstmt.setString(5, sSDate);
						cstmt.setString(6, "020");
						cstmt.setString(7, sCustGu);
						cstmt.setString(8, v_status);
						rs = cstmt.executeQuery();	
					} else if ("DS030".equals(gauceName)) {
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setInt(2, sGoods_sid);
						cstmt.setInt(3, sClientSid);
						cstmt.setInt(4, sUpjangSid);
						cstmt.setString(5, sSDate);
						cstmt.setString(6, "030");
						cstmt.setString(7, sCustGu);
						cstmt.setString(8, v_status);
						rs = cstmt.executeQuery();		
					} else if ("DS040".equals(gauceName)) {//신용카드
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setInt(2, sGoods_sid);
						cstmt.setInt(3, sClientSid);
						cstmt.setInt(4, sUpjangSid);
						cstmt.setString(5, sSDate);
						cstmt.setString(6, "040");
						cstmt.setString(7, sCustGu);
						cstmt.setString(8, v_status);
						rs = cstmt.executeQuery();	
					} else if ("DS060".equals(gauceName)) {//상품권
						cstmt = conn.prepareCall(arr_sql[3].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setInt(2, sGoods_sid);
						cstmt.setInt(3, sClientSid);
						cstmt.setInt(4, sUpjangSid);
						cstmt.setString(5, sSDate);
						cstmt.setString(6, "060");
						cstmt.setString(7, sCustGu);
						cstmt.setString(8, v_status);
						rs = cstmt.executeQuery();	
					} else if ("DS080".equals(gauceName)) {//무통
						cstmt = conn.prepareCall(arr_sql[4].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setInt(2, sGoods_sid);
						cstmt.setInt(3, sClientSid);
						cstmt.setInt(4, sUpjangSid);
						cstmt.setString(5, sSDate);
						cstmt.setString(6, "080");
						cstmt.setString(7, sCustGu);
						cstmt.setString(8, v_status);
						rs = cstmt.executeQuery();
					} else if ("DS34".equals(gauceName)) { //환불 환입
				  		cstmt = conn.prepareCall(arr_sql[5].toString());
					  	cstmt.setInt(1,sSaup_sid);
					  	cstmt.setInt(2, sGoods_sid);
					  	cstmt.setInt(3, sClientSid);
					  	cstmt.setInt(4, sUpjangSid);
					  	cstmt.setString(5, sSDate);
					  	cstmt.setString(6, "000"); //사용하지 않음.
					  	cstmt.setString(7, sCustGu);
					  	cstmt.setString(8, v_status);
					  	rs = cstmt.executeQuery();	
					} else if ("DS100".equals(gauceName)) {//보증금
						cstmt = conn.prepareCall(arr_sql[6].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setInt(2, sGoods_sid);
						cstmt.setInt(3, sClientSid);
						cstmt.setInt(4, sUpjangSid);
						cstmt.setString(5, sSDate);
						cstmt.setString(6, "100");
						cstmt.setString(7, sCustGu);
						cstmt.setString(8, v_status);
						rs = cstmt.executeQuery();			
					} else if ("DS090".equals(gauceName)) {	//기타대체
						cstmt = conn.prepareCall(arr_sql[7].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setInt(2, sGoods_sid);
						cstmt.setInt(3, sClientSid);
						cstmt.setInt(4, sUpjangSid);
						cstmt.setString(5, sSDate);
						cstmt.setString(6, "090");
						cstmt.setString(7, sCustGu);
						cstmt.setString(8, v_status);
						rs = cstmt.executeQuery();	
					} else if ("DS050".equals(gauceName)) {	//온라인카드
						cstmt = conn.prepareCall(arr_sql[8].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setInt(2, sGoods_sid);
						cstmt.setInt(3, sClientSid);
						cstmt.setInt(4, sUpjangSid);
						cstmt.setString(5, sSDate);
						cstmt.setString(6, "050");
						cstmt.setString(7, sCustGu);
						cstmt.setString(8, v_status);
						rs = cstmt.executeQuery();
					}
					
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
			if(stmt!=null) stmt.close();
		}
	
	}
}
