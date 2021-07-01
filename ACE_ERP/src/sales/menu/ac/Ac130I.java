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

public class Ac130I extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		//조회
		arr_sql[1].append("CALL SALES.PR_AC130I_01(?,?,?,?,?, ?,?,?,?)");
		//저장(정산액 인서트합니다. 무조건)
		arr_sql[2].append("CALL SALES.PR_AC130I_02(?,?,?,?,?, ? )");
	
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
		String v_out_gubn	= HDUtil.nullCheckStr(req.getParameter("v_out_gubn"));	// 6 출경구분
		String sCustGu		= HDUtil.nullCheckStr(req.getParameter("sCustGu")); 	// 7 고객구분 
		String sPayDate 	= HDUtil.nullCheckStr(req.getParameter("sPayDate")); 	// 8 정산 기준일자
		String v_wrk_gubn	= HDUtil.nullCheckStr(req.getParameter("v_wrk_gubn"));	// 9 작업구분 (1:정산, 2:외상매출) 
		
		
		
		//StringUtil.printMsg("사업소",sSaup_sid+"",this);
		//StringUtil.printMsg("출발일 S",sSDate,this);
		//StringUtil.printMsg("출발일 E",sEDate,this);
		//StringUtil.printMsg("상품SID",sGoods_sid+"",this);
		//StringUtil.printMsg("매출처",sClientSid+"",this);
		//StringUtil.printMsg("출경구분",v_out_gubn+"",this);
		//StringUtil.printMsg("고객구분",sCustGu+"",this);
		//StringUtil.printMsg("정산 기준일자",sPayDate+"",this);
		//StringUtil.printMsg("작업구분",v_wrk_gubn+"",this);
		
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
						cstmt.setString(6, v_out_gubn);
						cstmt.setString(7, sCustGu);
						cstmt.setString(8, sPayDate);
						cstmt.setString(9, v_wrk_gubn);
						
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

		CallableStatement 	cstmt 		= null;
		ResultSet 			rs 			= null;
		//StringUtil.printMsg("입력",this);
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		
		/* DataSet */
		GauceDataSet ds1		= req.getGauceDataSet("DS1");	

		try{
			//내부 변수
			
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				
				int colNm_Rsv_sid               = ds1.indexOfColumn("RSV_SID");
				int colNm_PayManageNo           = ds1.indexOfColumn("PAY_MANAGE_NO");
				int colNm_SaleAmt               = ds1.indexOfColumn("SALE_AMT_TEMP");				
				int colNm_AgencyAmt				= ds1.indexOfColumn("AGENCY_AMT");
				for(int i = 0; i < rows.length; i++) {
					//업데이트행만 처리한다.
					//StringUtil.printMsg("job=", rows[i].getJobType(), this);
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setInt        (1, rows[i].getInt(colNm_Rsv_sid));		//예약SID 
						//StringUtil.printMsg("1", rows[i].getInt(colNm_Rsv_sid), this);
						cstmt.setString     (2, rows[i].getString(colNm_PayManageNo));//결제관리번호
						//StringUtil.printMsg("2",rows[i].getString(colNm_PayManageNo) , this);
						cstmt.setInt     	(3, rows[i].getInt(colNm_SaleAmt));			//정산예정액
						//StringUtil.printMsg("3",rows[i].getInt(colNm_SaleAmt) , this);
						cstmt.setInt     	(4, rows[i].getInt(colNm_AgencyAmt));			//정산예정액
						cstmt.setString     (5, fParamEmpno);							//수정사번
						cstmt.setString     (6, fParamIp);								//수정ip
					
						cstmt.executeUpdate();
					} //if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
				};//for(int i=0; i<row.length; i++){
	
			}; //if
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			if(cstmt!=null) cstmt.close();
		};//try{	






	}

}
