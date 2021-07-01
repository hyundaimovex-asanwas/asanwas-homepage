package pms.menu.help;
/**********************************************************************************
 * 환불처리상세 팝업 
 **********************************************************************************/
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceStatement;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

import sales.common.HDUtil;
import sales.common.StringUtil;
import pms.common.SuperServlet;
import java.sql.Connection; 
import oracle.jdbc.OracleTypes;
  
public class Pu060H_01 extends SuperServlet {
	                                       
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL PMS.PR_PU060H_01(?,?,?)"); // 조회1
		
		arr_sql[2].append("{CALL PMS.PR_PU060H_03(?,?,?,?,?,             ?,?,?,?,?,         ?,?,?) }");	// 저장
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}

	// 조회 method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		/* DataSet */
		GauceDataSet ds1 = null; //  
		
		/*
		 * 검색시 필요한 조건
		 */
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		int v_est_sid 			= HDUtil.nullCheckNum(greq.getParameter("sest_sid"));			// 견적 SID
		String v_vend_cd 	= HDUtil.nullCheckStr(greq.getParameter("svend_cd")); 			// 거래처코드
		
		try {
			
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환

			// DataSet 생성 			
			ds1 = new GauceDataSet();  
			
				switch(dsType){
					case 1:
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1,v_est_sid);
					  	cstmt.setString(2,v_vend_cd);
					  	cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 			
						gos.write(getDataSet(rs, ds1));
				}
		gos.close();
	}catch (SQLException sqle){
		//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
		throw sqle;
	} catch (Exception e){
		//res.writeException("ERROR", "", e.toString());
		throw e;
	} finally {
		if(rs!=null) rs.close();
		if(cstmt!=null) cstmt.close();
	}
}
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 		rs 			= null;
				
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
						
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();	
		/* DataSet */
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			int v_est_sid 		= HDUtil.nullCheckNum(greq.getParameter("sest_sid"));			// 견적 SID
			String v_vend_cd 	= HDUtil.nullCheckStr(greq.getParameter("svend_cd")); 			// 거래처코드
		
			/* DataSet */
			GauceDataSet ds1 = gis.read("DEFAULT");

			/** 
			 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
			 **/
			
		try {
			if(ds1!=null){
				int colNm_ITEM_SID            	= ds1.indexOfColumn("ITEM_SID");               	//품목SID
				int colNm_ITEM_SEQ            	= ds1.indexOfColumn("ITEM_SEQ");               	//품목SEQ
				int colNm_ITEM_NM             	= ds1.indexOfColumn("ITEM_NM");              		// 품목명
				int colNm_ITEM_SIZE           	= ds1.indexOfColumn("ITEM_SIZE");             	// 규격
				int colNm_ITEM_UNIT           	= ds1.indexOfColumn("ITEM_UNIT");             	// 단위 
				int colNm_EST_ITEM_CNT 			= ds1.indexOfColumn("EST_ITEM_CNT");		     	// 수량
				int colNm_EST_AMT             	= ds1.indexOfColumn("EST_AMT");             		// 단가
				int colNm_SUM_AMT            	= ds1.indexOfColumn("SUM_AMT");             	// 단가*수량
		
				GauceDataRow[] 	 	    rows = ds1.getDataRows();
				GauceDataColumn[]  		cols = ds1.getDataColumns();
				
				for(int i=0; i<rows.length; i++){
					//StringUtil.printMsg("rows[i].getJobType()====",rows[i].getJobType(),this);
					//이건 무조건 3(업데이트) 일 듯.
					
					cstmt = conn.prepareCall(arr_sql[2].toString());

					cstmt.setInt(1, v_est_sid);
					//StringUtil.printMsg("1", v_est_sid, this);
					cstmt.setInt(2, rows[i].getInt(colNm_ITEM_SID));
					//StringUtil.printMsg("2", rows[i].getInt(colNm_ITEM_SID), this);
					cstmt.setInt(3, rows[i].getInt(colNm_ITEM_SEQ));
					//StringUtil.printMsg("3", rows[i].getInt(colNm_ITEM_SEQ), this);
					cstmt.setString(4, v_vend_cd );	
					//StringUtil.printMsg("4",v_vend_cd , this);								
					cstmt.setString(5, rows[i].getString(colNm_ITEM_NM));
					//StringUtil.printMsg("5",rows[i].getString(colNm_ITEM_NM) , this);
					//StringUtil.printMsg("6",rows[i].getString(colNm_ITEM_SIZE) , this);			
					cstmt.setString(6, rows[i].getString(colNm_ITEM_SIZE));						
					//StringUtil.printMsg("7",rows[i].getString(colNm_ITEM_UNIT) , this);
					cstmt.setString(7, rows[i].getString(colNm_ITEM_UNIT));
					
					cstmt.setInt(8, rows[i].getInt(colNm_EST_ITEM_CNT));
					//StringUtil.printMsg("8", rows[i].getInt(colNm_EST_ITEM_CNT), this);
					cstmt.setLong(9, rows[i].getLong(colNm_EST_AMT));
					//StringUtil.printMsg("9", rows[i].getInt(colNm_EST_AMT), this);
					cstmt.setLong(10, rows[i].getLong(colNm_SUM_AMT));
					cstmt.setString(11, iParamEmpno);
					cstmt.setString(12, iParamIp);
					cstmt.setString(13, "3");

					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();
				}
			}
			gos.close();
		} catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e) {
			gres.addException(e);
			throw e;
		} finally {
			//msgDS.flush();
			//if(stmt!=null) stmt.close();
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
		//if( fail == true ) throw new Exception("");			
		}
	}
}