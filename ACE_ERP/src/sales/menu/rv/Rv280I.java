package sales.menu.rv;

import oracle.jdbc.OracleTypes;

import java.util.*;
import java.sql.*;
import java.io.*;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.SuperServlet;
import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;

import com.gauce.GauceContext;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.Logger;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
 
public class Rv280I extends SuperServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String SAVE_FILE = HDConstant.FILE_UPLOAD_PATH_COST;
	
    public void makeSql(){
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		arr_sql[1].append("CALL SALES.PR_RV280I_01(?,?,?,?,?,     ?,?,?,?)"); // 조회
		arr_sql[2].append("CALL SALES.PR_RV280I_02(?)");	// 수정 : 적합여부
	}
	
	// 초기
    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}	

	// 조회 method
    public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
    	CallableStatement cstmt = null;
		ResultSet rs = null;
		
		// 검색시 조건
		int  	sSaupSid	= HDUtil.nullCheckNum(greq.getParameter("sSaup_sid")); 	// 지역
		int  	sClientSid	= HDUtil.nullCheckNum(greq.getParameter("sClientSid")); 	// 매출처
		String  sDep_date	= HDUtil.nullCheckStr(greq.getParameter("sDep_date")); 	// 출발일자
		int  	sGoodsSid	= HDUtil.nullCheckNum(greq.getParameter("sGoods_sid")); 	// 상품id
		String	sOkYN		= HDUtil.nullCheckStr(greq.getParameter("sOkYN"));		// 적합여부
		String	sStatus		= HDUtil.nullCheckStr(greq.getParameter("sStatus"));		// status_cd값.
		int  	sSalDamSid	= HDUtil.nullCheckNum(greq.getParameter("sSalDamSid")); 	// 담당자sid
		String	sJobsel		= HDUtil.nullCheckStr(greq.getParameter("sJobsel"));		// 고객구분
		
		//StringUtil.printMsg("지역--- ", sSaupSid,this);
		//StringUtil.printMsg("대리점--- ", sClientSid,this);
		//StringUtil.printMsg("일자--- ", sDep_date,this);
		//StringUtil.printMsg("상품--- ", sGoodsSid,this);
		//StringUtil.printMsg("여부--- ", sOkYN,this);

		// dataset 구분 param
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
					if(dSets[i].getName().equals("ds1")){
						GauceDataSet ds1 = gis.read("DEFAULT");
							cstmt = conn.prepareCall(arr_sql[1].toString());
							cstmt.setInt(1,sSaupSid);
							cstmt.setInt(2,sClientSid);
							cstmt.setString(3, sDep_date);
							cstmt.setInt(4,sGoodsSid);
							cstmt.setString(5, sOkYN);
							cstmt.setString(6, sStatus);
							cstmt.setInt(7,sSalDamSid);
							cstmt.setString(8, sJobsel);
							cstmt.registerOutParameter(9, OracleTypes.CURSOR);	//결과를 받을 커서
							cstmt.executeQuery();
							rs = (ResultSet)cstmt.getObject(9);	//커서 OUT param. 			
							gos.write(getDataSet(rs, ds1));
					}
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
	/**
	 * 기능 : 
	 */
	// 입력, 수정, 삭제
    public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
    	CallableStatement cstmt = null;	
		ResultSet 		rs 			= null;
				
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
						
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		
		/* DataSet */
		GauceDataSet ds1 = null; // 대리점 정보 
		
		// 파라미터
		int sCustSid		= HDUtil.nullCheckNum(greq.getParameter("sCustSid"));	// CUST_SID		
		//StringUtil.printMsg("상품--- ", sGoods_sid,this);
		
		if (iParamIp.length() > 13) {
			 iParamIp = iParamIp.substring(0,13);	
		}
		
		try {
			cstmt = conn.prepareCall(arr_sql[2].toString());
			cstmt.setInt(1, sCustSid);
					
			// 쿼리실행
			cstmt.executeUpdate();
			if(cstmt!=null) cstmt.close();	
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
			if(cstmt!=null) cstmt.close();
		//if( fail == true ) throw new Exception("");			
		}
	}
}