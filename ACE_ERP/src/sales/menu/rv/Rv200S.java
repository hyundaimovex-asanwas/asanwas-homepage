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

public class Rv200S extends SuperServlet {
 
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		arr_sql[0].append("{call SALES.PR_RV200S_01DN(?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?)}");

	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;

		int v_saup_sid 			= HDUtil.nullCheckNum(greq.getParameter("v_saup_sid"));			// 사업소
		int v_goods_sid 		= HDUtil.nullCheckNum(greq.getParameter("v_goods_sid"));			// 상품
		int v_client_sid 		= HDUtil.nullCheckNum(greq.getParameter("v_client_sid"));		// 매출처
		String v_fr_depart_date = HDUtil.nullCheckStr(greq.getParameter("v_fr_depart_date")); 	// 출경일자 From
		String v_to_depart_date = HDUtil.nullCheckStr(greq.getParameter("v_to_depart_date")); 	// 출경일자 To
		String v_fr_accept_date = HDUtil.nullCheckStr(greq.getParameter("v_fr_accept_date"));
		String v_to_accept_date = HDUtil.nullCheckStr(greq.getParameter("v_to_accept_date"));

		String v_status			= HDUtil.nullCheckStr(greq.getParameter("v_status")); 			// 예약상태
		String v_accept_no		= HDUtil.nullCheckStr(greq.getParameter("v_accept_no")); 		// 신청서번호
		String v_cust_nm		= HDUtil.nullCheckStr(greq.getParameter("v_cust_nm")); 		// 신청서번호
		String v_manage_no		= HDUtil.nullCheckStr(greq.getParameter("v_manage_no")); 		// 신청서번호
		
		String s_cust_gu		= HDUtil.nullCheckStr(greq.getParameter("v_cust_gu")); 		// 고객
		String s_country_gu		= HDUtil.nullCheckStr(greq.getParameter("v_country_gu")); 		// 국적
		String s_saup_gu		= HDUtil.nullCheckStr(greq.getParameter("v_saup_gu")); 		// 사업
		String v_job_sel		= HDUtil.nullCheckStr(greq.getParameter("v_job_sel")); 		// 입금구분
		String v_empno			= HDUtil.nullCheckStr(greq.getParameter("v_empno")); 		// 유치자사번=아이디
		String v_i_empno		= HDUtil.nullCheckStr(greq.getParameter("v_i_empno")); 		// 입력자사번=아이디
		
		//StringUtil.printMsg("v_job_sel",v_job_sel,this);
		//StringUtil.printMsg("v_empno",v_empno,this);
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			GauceDataSet[] dSets = gis.readAllOutput(); 
			for(int i=0; i<dSets.length;i++){
				StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
				if(dSets[i].getName().equals("ds_cust")){
					GauceDataSet ds1 = gis.read("DS_CUST");
					cstmt = conn.prepareCall(arr_sql[0].toString());
					
					cstmt.setInt(1, v_saup_sid);
					cstmt.setInt(2, v_goods_sid);
					cstmt.setInt(3, v_client_sid);
					cstmt.setString(4, v_fr_depart_date);
					cstmt.setString(5, v_to_depart_date);
					cstmt.setString(6, v_fr_accept_date);
					cstmt.setString(7, v_to_accept_date);
					cstmt.setString(8, v_status);
					cstmt.setString(9, v_accept_no);
					cstmt.setString(10, v_manage_no);
					cstmt.setString(11, v_cust_nm);
					cstmt.setString(12, s_cust_gu);
					cstmt.setString(13, s_country_gu);
					cstmt.setString(14, s_saup_gu);
					cstmt.setString(15, v_job_sel);
					cstmt.setString(16, v_empno);
					cstmt.setString(17, v_i_empno);
					cstmt.registerOutParameter(18, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(18);	//커서 OUT param. 			
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

	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}
}