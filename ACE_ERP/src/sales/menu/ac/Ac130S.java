package sales.menu.ac;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

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

public class Ac130S extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		//조회
		arr_sql[1].append("CALL SALES.PR_AC130S_01(?,?,?,?,?, ?,?,?,?,?)");

	
	}
 
	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		StringUtil.printMsg("DS TYPE","선조회",this);
	}

	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		
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
		
		int sSaup_sid 		= HDUtil.nullCheckNum(req.getParameter("sSaup_sid"));	// 1 사업소
		int sGoods_sid 		= HDUtil.nullCheckNum(req.getParameter("sGoods_sid"));	// 2 상품SID 
		int sClientSid 		= HDUtil.nullCheckNum(req.getParameter("sClient_sid"));	// 3 매출처 
		String sSDate 		= HDUtil.nullCheckStr(req.getParameter("sSDate")); 		// 4 출발일자 시작
		String sEDate 		= HDUtil.nullCheckStr(req.getParameter("sEDate")); 		// 5 출발일자 끝 
		String v_status		= HDUtil.nullCheckStr(req.getParameter("v_status"));	// 6 예약상태
		String sCustGu		= HDUtil.nullCheckStr(req.getParameter("sCustGu")); 	// 7 고객구분 
		String sPayDate 	= HDUtil.nullCheckStr(req.getParameter("sPayDate")); 	// 8 정산 기준일자
		String v_wrk_gubn	= HDUtil.nullCheckStr(req.getParameter("v_wrk_gubn"));	// 9 작업구분 (1:정산, 2:외상매출) 
		int sSalDamSid 		= HDUtil.nullCheckNum(req.getParameter("sSalDamSid"));	//10 영업담당자 
		
		
		//StringUtil.printMsg("사업소",sSaup_sid+"",this);
		//StringUtil.printMsg("상품SID",sGoods_sid+"",this);
		//StringUtil.printMsg("매출처",sClientSid+"",this);
		//StringUtil.printMsg("출발일 S",sSDate,this);
		//StringUtil.printMsg("출발일 E",sEDate,this);
		//StringUtil.printMsg("예약상태",v_status,this);
		//StringUtil.printMsg("고객구분",sCustGu,this);
		//StringUtil.printMsg("정산일자",sPayDate+"",this);
		//StringUtil.printMsg("작업구분",v_wrk_gubn+"",this);
		//StringUtil.printMsg("영업담당자",sSalDamSid+"",this);
		
		try {
			int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if ("DS1".equals(gauceName)) {
						
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setInt(2, sGoods_sid);
						cstmt.setInt(3, sClientSid);
						cstmt.setString(4, sSDate);
						cstmt.setString(5, sEDate);
						cstmt.setString(6, v_status);
						cstmt.setString(7, sCustGu);
						cstmt.setString(8, sPayDate);
						cstmt.setString(9, v_wrk_gubn);
						cstmt.setInt(10, sSalDamSid);
						
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

	
	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub







	}

}
