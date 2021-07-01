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

public class Cq511I extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		//조회
		arr_sql[0].append ("{call SALES.PR_CQ511I_01(?,?,?,?,?,  ?,?)}");
		
		//저장
		arr_sql[1].append ("{call SALES.PR_CQ511I_02(?,?,?,?,?,  ?,?,?,?,?,    ?,?,?,?,?,  ?,?,?)}");
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
				String 	v_car_no		= HDUtil.nullCheckStr(greq.getParameter("v_car_no"));
				String 	v_out_gubn		= HDUtil.nullCheckStr(greq.getParameter("v_out_gubn"));
				
				/*
				StringUtil.printMsg("v_saup_sid", v_saup_sid, this);
				StringUtil.printMsg("v_depart_date", v_depart_date, this);
				StringUtil.printMsg("v_depart_time", v_depart_time, this);
				StringUtil.printMsg("v_goods_sid", v_goods_sid, this);
				StringUtil.printMsg("v_car_no", v_car_no, this);
				StringUtil.printMsg("v_out_gubn", v_out_gubn, this);
				*/
				cstmt = conn.prepareCall(arr_sql[0].toString());
				cstmt.setInt	(1, v_saup_sid);
				cstmt.setString (2, v_depart_date);
				cstmt.setString (3, v_depart_time);
				cstmt.setInt	(4, v_goods_sid);
				cstmt.setString (5, v_out_gubn);
				cstmt.setString (6, v_car_no);
				cstmt.registerOutParameter(7, OracleTypes.CURSOR);	//결과를 받을 커서
				cstmt.executeQuery();
				rs = (ResultSet)cstmt.getObject(7);	//커서 OUT param. 			
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
					cstmt = conn.prepareCall(arr_sql[1].toString());
					
					/*
					StringUtil.printMsg("1", rows[i].getString(ds1.indexOfColumn("JOB_SEL")), this);	//job_sel
					StringUtil.printMsg("2", rows[i].getString(ds1.indexOfColumn("BAR_SEL")), this);	//bar_sel
					StringUtil.printMsg("3", rows[i].getInt(ds1.indexOfColumn("INOUT_SID")), this);		//입출경SID
					StringUtil.printMsg("4", rows[i].getInt(ds1.indexOfColumn("SAUP_SID")), this);		//사업소SID
					StringUtil.printMsg("5", rows[i].getInt(ds1.indexOfColumn("CAR_RSV_SID")), this);		//차량 예약SID
					StringUtil.printMsg("6", rows[i].getInt(ds1.indexOfColumn("GOODS_SID")), this);		//GOODS SID
					StringUtil.printMsg("7", rows[i].getString(ds1.indexOfColumn("ACCEPT_NO")), this);	//신청서번호
					StringUtil.printMsg("8", rows[i].getInt(ds1.indexOfColumn("CAR_SID")), this);		//CAR SID
					StringUtil.printMsg("9", rows[i].getString(ds1.indexOfColumn("DEPART_DATE")), this);	//출발일자
					StringUtil.printMsg("10",rows[i].getString(ds1.indexOfColumn("DEPART_TIME")), this);	//출발시간
					StringUtil.printMsg("11", rows[i].getString(ds1.indexOfColumn("ARRIVE_DATE")), this);	//입경일자
					StringUtil.printMsg("12", rows[i].getString(ds1.indexOfColumn("ARRIVE_TIME")), this);	//입경시간
					StringUtil.printMsg("13", rows[i].getString(ds1.indexOfColumn("REMARKS")), this);	//참고사항					
					*/
					cstmt.setString (1, rows[i].getString(ds1.indexOfColumn("JOB_SEL")));	//job_sel
					cstmt.setString (2, rows[i].getString(ds1.indexOfColumn("BAR_SEL")));	//bar_sel
					cstmt.setInt	(3, rows[i].getInt(ds1.indexOfColumn("INOUT_SID")));		//입출경SID
					cstmt.setInt	(4, rows[i].getInt(ds1.indexOfColumn("SAUP_SID")));		//사업소SID
					cstmt.setInt	(5, rows[i].getInt(ds1.indexOfColumn("CAR_RSV_SID")));		//차량 예약SID
					cstmt.setInt	(6, rows[i].getInt(ds1.indexOfColumn("GOODS_SID")));		//GOODS SID
					cstmt.setString (7, rows[i].getString(ds1.indexOfColumn("ACCEPT_NO")));	//신청서번호
					cstmt.setInt	(8, rows[i].getInt(ds1.indexOfColumn("CAR_SID")));		//CAR SID
					cstmt.setString (9, rows[i].getString(ds1.indexOfColumn("DEPART_DATE")));	//출발일자
					cstmt.setString (10,rows[i].getString(ds1.indexOfColumn("DEPART_TIME")));	//출발시간
					cstmt.setString (11, rows[i].getString(ds1.indexOfColumn("ARRIVE_DATE")));	//입경일자
					cstmt.setString (12, rows[i].getString(ds1.indexOfColumn("ARRIVE_TIME")));	//입경시간
					cstmt.setString (13, rows[i].getString(ds1.indexOfColumn("REMARKS")));	//참고사항
					cstmt.setString (14, iParamEmpno);
					cstmt.setString (15, iParamIp);
					cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
					cstmt.executeUpdate();

					if(cstmt.getString(16).equals("N"))
						throw new Exception( cstmt.getString(18));
					
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