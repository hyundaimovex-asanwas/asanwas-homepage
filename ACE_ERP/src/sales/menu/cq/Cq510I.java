package sales.menu.cq;

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

public class Cq510I extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		//조회
		arr_sql[0].append ("{call SALES.PR_CQ510I_01(?,?,?,?,?,     ?,?,?,?,?)}");
		
		//저장
		arr_sql[1].append ("{call SALES.PR_CQ510I_02(?,?,?,?,?,    ?,?,?,?,?,       ?,?,?,?,?,     ?,?,?,?,?,     ?)}");
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		try{
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			for(int i=0; i<dSets.length;i++){	
				//기본 검색 내역
				if(dSets[i].getName().equals("ds1")){
				GauceDataSet ds1 = gis.read("DEFAULT");
			
				int 	v_saup_sid 		= HDUtil.nullCheckNum(greq.getParameter("v_saup_sid"));
				String 	v_depart_date 	= HDUtil.nullCheckStr(greq.getParameter("v_depart_date"));
				String 	v_depart_time 	= HDUtil.nullCheckStr(greq.getParameter("v_depart_time"));
				int 	v_goods_sid 	= HDUtil.nullCheckNum(greq.getParameter("v_goods_sid"));
				String 	v_class 		= HDUtil.nullCheckStr(greq.getParameter("v_class"));
				String 	v_teams 		= HDUtil.nullCheckStr(greq.getParameter("v_teams"));
				String 	v_cust_nm 		= HDUtil.nullCheckStr(greq.getParameter("v_cust_nm"));
				String 	v_manage_no		= HDUtil.nullCheckStr(greq.getParameter("v_manage_no"));
				String 	v_out_gubn		= HDUtil.nullCheckStr(greq.getParameter("v_out_gubn"));
				
				/*
				StringUtil.printMsg("v_saup_sid", v_saup_sid, this);
				StringUtil.printMsg("v_depart_date", v_depart_date, this);
				StringUtil.printMsg("v_depart_time", v_depart_time, this);
				StringUtil.printMsg("v_goods_sid", v_goods_sid, this);
				StringUtil.printMsg("v_class", v_class, this);
				StringUtil.printMsg("v_teams", v_teams, this);
				StringUtil.printMsg("v_cust_nm", v_cust_nm, this);
				StringUtil.printMsg("v_manage_no", v_manage_no, this);
				StringUtil.printMsg("v_out_gubn", v_out_gubn, this);
				*/
		
				cstmt = conn.prepareCall(arr_sql[0].toString());
				cstmt.setInt	(1, v_saup_sid);
				cstmt.setString (2, v_depart_date);
				cstmt.setString (3, v_depart_time);
				cstmt.setInt	(4, v_goods_sid);
				cstmt.setString (5, v_class);
				cstmt.setString (6, v_teams);
				cstmt.setString (7, v_cust_nm);
				cstmt.setString (8, v_manage_no);
				cstmt.setString (9, v_out_gubn);
				cstmt.registerOutParameter(10, OracleTypes.CURSOR);	//결과를 받을 커서
				cstmt.executeQuery();
				rs = (ResultSet)cstmt.getObject(10);	//커서 OUT param. 			
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
		CallableStatement cstmt = null;	
		ResultSet 		rs 			= null;
				
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
						
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		/* DataSet */
		GauceDataSet ds1 = gis.read("DEFAULT");
		
//		int v_row = 1;
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				
				for(int i=0; i<rows.length; i++){
					int v_row = 1;
					cstmt = conn.prepareCall(arr_sql[1].toString());
					
					cstmt.setString (v_row++, rows[i].getString(ds1.indexOfColumn("JOB_SEL")));	//job_sel
					cstmt.setString (v_row++, rows[i].getString(ds1.indexOfColumn("BAR_SEL")));	//bar_sel
					cstmt.setInt	(v_row++, rows[i].getInt(ds1.indexOfColumn("INOUT_SID")));		//입출경SID
					cstmt.setInt	(v_row++, rows[i].getInt(ds1.indexOfColumn("SAUP_SID")));		//사업소SID
					cstmt.setInt	(v_row++, rows[i].getInt(ds1.indexOfColumn("RSV_SID")));		//예약SID
					cstmt.setInt	(v_row++, rows[i].getInt(ds1.indexOfColumn("GOODS_SID")));		//GOODS SID
					cstmt.setString (v_row++, rows[i].getString(ds1.indexOfColumn("ACCEPT_NO")));	//신청서번호
					cstmt.setString (v_row++, rows[i].getString(ds1.indexOfColumn("CLASS")));	//반
					cstmt.setString (v_row++, rows[i].getString(ds1.indexOfColumn("TEAMS")));	//조
					cstmt.setInt	(v_row++, rows[i].getInt(ds1.indexOfColumn("CUST_SID")));		//고객SID
					cstmt.setString (v_row++, rows[i].getString(ds1.indexOfColumn("CUST_GU")));	//고객구분
					cstmt.setString (v_row++, rows[i].getString(ds1.indexOfColumn("DEPART_DATE")));	//출발일자
					cstmt.setString (v_row++,rows[i].getString(ds1.indexOfColumn("DEPART_TIME")));	//출발시간
					cstmt.setString (v_row++, rows[i].getString(ds1.indexOfColumn("ARRIVE_DATE")));	//입경일자
					cstmt.setString (v_row++, rows[i].getString(ds1.indexOfColumn("ARRIVE_TIME")));	//입경시간
					cstmt.setString (v_row++, rows[i].getString(ds1.indexOfColumn("REMARKS")));	//참고사항
					cstmt.setString (v_row++, iParamEmpno);
					cstmt.setString (v_row++, iParamIp);
					cstmt.registerOutParameter(v_row++, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(v_row++, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(v_row++, java.sql.Types.VARCHAR);
					cstmt.executeUpdate();
//StringUtil.printMsg("cstmt.getString(18)", cstmt.getString(18), this);
//StringUtil.printMsg("cstmt.getString(19)", cstmt.getString(19), this);
//StringUtil.printMsg("cstmt.getString(20)", cstmt.getString(20), this);

					if(cstmt.getString(19).equals("N"))
						throw new Exception( cstmt.getString(21));
					
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
			if(cstmt!=null) cstmt.close();
		//if( fail == true ) throw new Exception("");			
		}
	}
}