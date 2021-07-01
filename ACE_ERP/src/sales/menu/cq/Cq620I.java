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

public class Cq620I extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		//MASTER 조회
		arr_sql[0].append ("{call SALES.PR_CQ620I_01(?,?,?,?,?, 	?,?,?)}");
		
		//DETAIL 조회
		arr_sql[1].append ("{call SALES.PR_CQ620I_02(?,?,?)}");
		
		//MASTER 저장
		arr_sql[2].append ("{call SALES.PR_CQ620I_03(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)}");
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		try{
			int 	v_saup_sid 			= HDUtil.nullCheckNum(greq.getParameter("v_saup_sid"));
			String 	v_fr_trn_date 		= HDUtil.nullCheckStr(greq.getParameter("v_fr_trn_date"));
			String 	v_to_trn_date 		= HDUtil.nullCheckStr(greq.getParameter("v_to_trn_date"));
			String 	v_fr_arrive_date 	= HDUtil.nullCheckStr(greq.getParameter("v_fr_arrive_date"));
			String 	v_to_arrive_time 	= HDUtil.nullCheckStr(greq.getParameter("v_to_arrive_time"));
			String 	v_cust_nm		 	= HDUtil.nullCheckStr(greq.getParameter("v_cust_nm"));
			int 	v_cust_sid 			= HDUtil.nullCheckNum(greq.getParameter("v_cust_sid"));
						
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
		    //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
		    GauceDataSet[] dSets = gis.readAllOutput(); 

		    for(int i=0; i<dSets.length;i++){
			   	if(dSets[i].getName().equals("ds_master")){
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);
		   			GauceDataSet ds1 = gis.read("MASTER");
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setInt	(1, v_saup_sid);
						cstmt.setString (2, v_fr_trn_date);
						cstmt.setString (3, v_to_trn_date);
						cstmt.setString (4, v_fr_arrive_date);
						cstmt.setString (5, v_to_arrive_time);
						cstmt.setString (6, v_cust_nm);
						cstmt.setString (7, "7512011234567");
						cstmt.registerOutParameter(8, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(8);	//커서 OUT param. 			
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

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		try{
			int 	v_saup_sid 			= HDUtil.nullCheckNum(greq.getParameter("v_saup_sid"));
			String 	v_fr_trn_date 		= HDUtil.nullCheckStr(greq.getParameter("v_fr_trn_date"));
			String 	v_to_trn_date 		= HDUtil.nullCheckStr(greq.getParameter("v_to_trn_date"));
			String 	v_fr_arrive_date 	= HDUtil.nullCheckStr(greq.getParameter("v_fr_arrive_date"));
			String 	v_to_arrive_time 	= HDUtil.nullCheckStr(greq.getParameter("v_to_arrive_time"));
			String 	v_cust_nm		 	= HDUtil.nullCheckStr(greq.getParameter("v_cust_nm"));
			String 	v_manage_no		 	= HDUtil.nullCheckStr(greq.getParameter("v_manage_no"));
			String	v_trn_date			= HDUtil.nullCheckStr(greq.getParameter("v_trn_date"));
			int 	v_rsv_sid 			= HDUtil.nullCheckNum(greq.getParameter("v_rsv_sid"));
			
			
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
					if(dSets[i].getName().equals("ds_master")){
						GauceDataSet ds1 = gis.read("MASTER");
						StringUtil.printMsg("v_saup_sid", v_saup_sid, this);						
						StringUtil.printMsg("v_fr_trn_date", v_fr_trn_date, this);
						StringUtil.printMsg("v_to_trn_date", v_to_trn_date, this);
						StringUtil.printMsg("v_fr_arrive_date", v_fr_arrive_date, this);
						
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setInt	(1, v_saup_sid);
						cstmt.setString (2, v_fr_trn_date);
						cstmt.setString (3, v_to_trn_date);
						cstmt.setString (4, v_fr_arrive_date);
						cstmt.setString (5, v_to_arrive_time);
						cstmt.setString (6, v_cust_nm);
						cstmt.setString (7, v_manage_no);
						cstmt.registerOutParameter(8, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(8);	//커서 OUT param. 			
						gos.write(getDataSet(rs, ds1));
					} else if(dSets[i].getName().equals("ds_detail")){
						GauceDataSet ds1 = gis.read("DETAIL");
						//StringUtil.printMsg("v_saup_sid", v_saup_sid, this);
						//StringUtil.printMsg("v_rsv_sid", v_rsv_sid, this);
						
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1, v_saup_sid);
						cstmt.setInt(2, v_rsv_sid);
						cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 			
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

		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 		rs 			= null;
				
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
						
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		/* DataSet */
		GauceDataSet ds1 = gis.read("MASTER");
		GauceDataSet ds_result = gis.read("RESULT");		
		GauceDataSet ds3 = gis.read("DS_DETAIL");
		
		String v_edit_status = "";
		
		String r_s_yn = "";
		String r_msg_cd = "";
		String r_msg = "";
		
		try{
			if(ds1!=null){
				GauceDataRow[] row = ds1.getDataRows();
				for(int i=0; i<row.length; i++){
					if(row[i].getJobType()==GauceDataRow.TB_JOB_INSERT)
						v_edit_status = 1+"";
					if(row[i].getJobType()==GauceDataRow.TB_JOB_DELETE)
						v_edit_status = 2+"";
					if(row[i].getJobType()==GauceDataRow.TB_JOB_UPDATE)
						v_edit_status = 3+"";
					
					cstmt = conn.prepareCall(arr_sql[2].toString());

//StringUtil.printMsg("row[i].getString(0) 신청일자",row[i].getString(0), this);
//StringUtil.printMsg("row[i].getInt(20) 입출경 SID", row[i].getInt(20), this);
//StringUtil.printMsg("변경시각", row[i].getString(4), this);
//StringUtil.printMsg("예약 SID", row[i].getInt(21), this);
//StringUtil.printMsg("상태", v_edit_status, this);

					cstmt.setInt(1, row[i].getInt(20));			//입출경 SID
					cstmt.setInt(2, row[i].getInt(21));			//예약 SID
					cstmt.setString(3, row[i].getString(0));	//신청일자
					cstmt.setString(4, row[i].getString(5));	//변경시점
					cstmt.setString(5, row[i].getString(1));	//입경예정일자
					cstmt.setString(6, row[i].getString(2));	//입경예정시간
					cstmt.setString(7, row[i].getString(3));	//예정변경일자
					cstmt.setString(8, row[i].getString(4));	//예정변경시간
					cstmt.setString(9, row[i].getString(7));	//변경사유코드
					cstmt.setString(10, row[i].getString(9));	//변경사유
					cstmt.setString(11, row[i].getString(16));	//출발일자 : 숙박기간 계산용 2008-05-18심동현
					cstmt.setString(12, fParamEmpno);
					cstmt.setString(13, fParamIp);
					cstmt.setString(14, v_edit_status);
					cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);	//성공여부
					cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);	//메세지 코드
					cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);	//메세지
					
					cstmt.executeUpdate();
					
					r_s_yn 		= cstmt.getString(15);
					r_msg_cd 	= cstmt.getString(16);
					r_msg 		= cstmt.getString(17);
					
					//if(r_s_yn.equals("N")){
						//res.writeException("ERROR", r_msg_cd, r_msg);
					//}
					
					if(ds_result!=null){
						GauceDataRow row1 = ds_result.newDataRow();
						row1.addColumnValue(r_s_yn);
						row1.addColumnValue(r_msg_cd);
						row1.addColumnValue(r_msg);
						
						ds_result.addDataRow(row1);
					}
					if(cstmt!=null) cstmt.close();
				}
				if(ds_result!=null)
					ds_result.flush();
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