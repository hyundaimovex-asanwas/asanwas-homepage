package sales.menu.cq;

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

import common.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;

public class Cq100I extends SuperServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_CQ100I_01(?,?,?,?,?,  ?,?,?)"); // 생성
		
		arr_sql[2].append("CALL SALES.PR_CQ100I_02(?,?,?,?,?)");	// 조회
		
		arr_sql[3].append("CALL SALES.PR_CQ100I_03(?,?,?,?,?,  ?)");	// 삭제
		
	}
	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","선조회",this);
	}
	
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		
		/*
		 * 검색시 필요한 조건
		 */
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		int sSaup_sid 		= HDUtil.nullCheckNum(greq.getParameter("sSaup_sid"));	// 사업소
		int sGoods_sid		= HDUtil.nullCheckNum(greq.getParameter("sGoods_sid"));	// 상품sid
		String sJob_date 	= HDUtil.nullCheckStr(greq.getParameter("sJob_date")); 	// 작업년월
		String sJob_seq		= HDUtil.nullCheckStr(greq.getParameter("sJob_seq"));	// 작업구분

		
		//StringUtil.printMsg("상품--- ", sGoods_sid,this);
		//StringUtil.printMsg("상품--- ", sGoods_sid,this);
		
		try {
			GauceDataSet[] dSets = gis.readAllOutput(); 
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DEFAULT=ds_main, O:DETAIL=ds_detail
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
					switch(dsType){
						case 1:
							//res.enableFirstRow(ds1);
							
							cstmt = conn.prepareCall(arr_sql[2].toString());
							cstmt.setInt(1,sSaup_sid);
							cstmt.setInt(2,sGoods_sid);
							cstmt.setString(3, sJob_date);
							cstmt.setString(4, sJob_seq);
							cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//결과를 받을 커서
							cstmt.executeQuery();
							rs = (ResultSet)cstmt.getObject(5);	//커서 OUT param. 					
							gos.write(getDataSet(rs, ds1));
							break;
						case 2:
							break;
						case 3:
							break;
					}
				}
			}
		} catch (SQLException sqle){
//			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
//			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		CallableStatement cstmt = null;	
		ResultSet 		rs 			= null;
		
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
						
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		/* DataSet */
		GauceDataSet ds1 = gis.read("DS1");
		
		/*
		 * 검색시 필요한 조건
		 */
		int dsType 			= HDUtil.nullCheckNum(greq.getParameter("dsType"));
		int sSaup_sid 		= HDUtil.nullCheckNum(greq.getParameter("sSaup_sid"));	// 사업소
		int sGoods_sid		= HDUtil.nullCheckNum(greq.getParameter("sGoods_sid"));	// 상품sid
		String sJob_date 	= HDUtil.nullCheckStr(greq.getParameter("sJob_date")); 	// 작업년월
		String sJob_seq		= HDUtil.nullCheckStr(greq.getParameter("sJob_seq"));	// 작업구분
		
		//StringUtil.printMsg("상품--- ", sGoods_sid,this);
		
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		if (iParamIp.length() > 13) {
			 iParamIp = iParamIp.substring(0,13);	
		}
		
		try {
			if(ds1!=null){
			
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				
				for(int i = 0; i < rows.length; i++) {
					switch(dsType){
						case 1:
							//StringUtil.printMsg("DS1 Insert",arr_sql[1].toString(), this);
							cstmt = conn.prepareCall(arr_sql[1].toString());
							//StringUtil.printMsg("=============================== 마스터 신규 =========================",this);
							cstmt.setInt(1, sSaup_sid);
							cstmt.setString(2,sJob_date);
							cstmt.setInt(3, sGoods_sid);
							cstmt.setString(4, iParamEmpno);
							cstmt.setString(5, iParamIp);
							cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
							cstmt.setString(8, sJob_seq);
							
							// 쿼리실행
							cstmt.executeUpdate();
							
							break;
						case 2:
							//StringUtil.printMsg("삭제",this);
							cstmt = conn.prepareCall(arr_sql[3].toString());
							
							cstmt.setInt(1,sSaup_sid);
							cstmt.setString(2, sJob_date);
							cstmt.setInt(3, sGoods_sid);
							cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
							cstmt.setString(6, sJob_seq);
							cstmt.executeUpdate();
							break;
						case 3:
							
							break;
					}
				}
			}
			gos.close();
		} catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
}