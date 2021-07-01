package sales.menu.ac;

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

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Ac740I extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		//Master 조회
		arr_sql[0].append ("{CALL SALES.PR_AC740I_01(?,?,?)}");
		
		//Detail 조회
		arr_sql[1].append ("{CALL SALES.PR_AC740I_02(?,?)}");
		
		//Master 저장
		arr_sql[2].append ("{CALL SALES.PR_AC740I_03(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");
		
		//Detail 저장
		arr_sql[3].append ("{CALL SALES.PR_AC740I_04(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		
		String v_fr_date 	= HDUtil.nullCheckStr(greq.getParameter("v_fr_date"));
		String v_to_date 	= HDUtil.nullCheckStr(greq.getParameter("v_to_date"));
		String v_gift_cd 	= HDUtil.nullCheckStr(greq.getParameter("v_gift_cd"));
		
		try {
			GauceDataSet[] dSets = gis.readAllOutput(); 
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//DEFAULT=ds_default,O: MASTER=ds_master	DATE=ds_date
            	if(dSets[i].getName().equals("ds_master")){
					GauceDataSet ds1 = gis.read("MASTER");
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, v_fr_date);
					cstmt.setString(2, v_to_date);
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
				} else if(dSets[i].getName().equals("ds_detail")){
					GauceDataSet ds1 = gis.read("DETAIL");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, v_gift_cd);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
				} else{
					throw new Exception ("알수 없는 DataSet Name입니다.");
				}
			}
		} catch (SQLException sqle){
		    throw sqle;
		} catch (Exception e) {
		    throw e;
		} finally {
		    if(rs!=null) rs.close();
	
		    if(cstmt!=null) cstmt.close();
		}
	}

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		String v_fr_date 	= HDUtil.nullCheckStr(greq.getParameter("v_fr_date"));
		String v_to_date 	= HDUtil.nullCheckStr(greq.getParameter("v_to_date"));
		String v_gift_cd 	= HDUtil.nullCheckStr(greq.getParameter("v_gift_cd"));
		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		try {
			GauceDataSet[] dSets = gis.readAllOutput(); 
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//DEFAULT=ds_default,O: MASTER=ds_master	DATE=ds_date
            	if(dSets[i].getName().equals("ds_master")){
					GauceDataSet ds1 = gis.read("MASTER");
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, v_fr_date);
					cstmt.setString(2, v_to_date);
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
				} else if(dSets[i].getName().equals("ds_detail")){
					GauceDataSet ds1 = gis.read("DETAIL");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, v_gift_cd);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
				} else{
					throw new Exception ("알수 없는 DataSet Name입니다.");
				}
			}
		} catch (SQLException sqle){
		    throw sqle;
		} catch (Exception e) {
		    throw e;
		} finally {
		    if(rs!=null) rs.close();
	
		    if(cstmt!=null) cstmt.close();
		}
	}

	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;	
		ResultSet 		rs 			= null;
		try {
			int v_gift_cnt 	= HDUtil.nullCheckNum(greq.getParameter("v_gift_cnt"));
			int v_gift_amt 	= HDUtil.nullCheckNum(greq.getParameter("v_gift_amt"));
			String v_edit_status = "";
			String r_gift_cd	= "";
			String r_s_yn		= "";
			String r_msg_cd		= "";
			String r_msg		= "";
			
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			/* DataSet */
			GauceDataSet ds_master 	= gis.read("MASTER");		
			GauceDataSet ds_detail 	= gis.read("DETAIL");			
			GauceDataSet ds_master_result 	= gis.read("RESULT");
			GauceDataSet ds_detail_result 	= gis.read("RESULT2");		
			
			if(ds_master!=null){
				if(ds_master_result!=null){
					ds_master_result.addDataColumn(new GauceDataColumn("GIFT_CD", GauceDataColumn.TB_STRING));
					ds_master_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
					ds_master_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
					ds_master_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
				}
				GauceDataRow[] 		rows = ds_master.getDataRows();
					
				for(int i = 0; i < rows.length; i++) {
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_INSERT)
						v_edit_status = "1";
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_DELETE)
						v_edit_status = "2";
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE)
						v_edit_status = "3";
					
					cstmt = conn.prepareCall(arr_sql[2].toString());
					/*
					StringUtil.printMsg("rows[i].getString(ds_master.indexOfColumn(GIFT_CD))",rows[i].getString(ds_master.indexOfColumn("GIFT_CD")),this);
					StringUtil.printMsg("rows[i].getString(ds_master.indexOfColumn(PAY_DATE))",rows[i].getString(ds_master.indexOfColumn("PAY_DATE")),this);
					StringUtil.printMsg("v_gift_amt",v_gift_amt,this);
					StringUtil.printMsg("v_gift_cnt",v_gift_cnt,this);
					StringUtil.printMsg("rows[i].getString(ds_master.indexOfColumn(PAY_GU))",rows[i].getString(ds_master.indexOfColumn("PAY_GU")),this);
					StringUtil.printMsg("rows[i].getString(ds_master.indexOfColumn(PAY_EMPNO))",rows[i].getString(ds_master.indexOfColumn("PAY_EMPNO")),this);
					StringUtil.printMsg("fParamEmpno",fParamEmpno,this);
					StringUtil.printMsg("fParamIp",fParamIp,this);
					StringUtil.printMsg("v_edit_status",v_edit_status,this);
					*/
					cstmt.setString (1, rows[i].getString(ds_master.indexOfColumn("GIFT_CD")));
					cstmt.registerOutParameter(1, OracleTypes.VARCHAR);	//상품권코드
					cstmt.setString (2, rows[i].getString(ds_master.indexOfColumn("PAY_DATE")));
					cstmt.setInt	(3, v_gift_amt);
					cstmt.setInt	(4, v_gift_cnt);
					cstmt.setString (5, rows[i].getString(ds_master.indexOfColumn("PAY_GU")));
					cstmt.setString (6, rows[i].getString(ds_master.indexOfColumn("PAY_EMPNO")));
					cstmt.setString (7, fParamEmpno);
					cstmt.setString (8, fParamIp);
					cstmt.setString (9, v_edit_status);
					cstmt.registerOutParameter(10, OracleTypes.VARCHAR);	//성공여부
					cstmt.registerOutParameter(11, OracleTypes.VARCHAR);	//메세지 코드
					cstmt.registerOutParameter(12, OracleTypes.VARCHAR);	//메세지
					
					cstmt.executeUpdate();
					
					r_gift_cd	 = cstmt.getString(1);
					r_s_yn		 = cstmt.getString(10);
					r_msg_cd	 = cstmt.getString(11);
					r_msg		 = cstmt.getString(12);	
					/*	
					StringUtil.printMsg("r_s_yn",r_s_yn,this);
					StringUtil.printMsg("r_msg_cd",r_msg_cd,this);
					StringUtil.printMsg("r_msg",r_msg,this);
					*/
					
					if(ds_master_result!=null){
						ds_master_result.put("GIFT_CD", r_gift_cd, 20);//커서 OUT param.
						ds_master_result.put("S_YN", 	r_s_yn, 1);//커서 OUT param.
						ds_master_result.put("MSG_CD", r_msg_cd, 4);//커서 OUT param.
						ds_master_result.put("MSG", 	r_msg, 200);//커서 OUT param.
						ds_master_result.heap();
					}
					if(cstmt!=null) cstmt.close();
				}
				if(ds_master_result!=null) gos.write(ds_master_result);
			}
			if(ds_detail!=null){
				//StringUtil.printMsg("22222222222222222","222222222222222222",this);
				if(ds_detail_result!=null){
					ds_detail_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
					ds_detail_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
					ds_detail_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
				}
				GauceDataRow[] 		rows = ds_detail.getDataRows();
					
				for(int i = 0; i < rows.length; i++) {
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_INSERT)
						v_edit_status = "1";
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_DELETE)
						v_edit_status = "2";
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE)
						v_edit_status = "3";
					
					cstmt = conn.prepareCall(arr_sql[3].toString());
					cstmt.setString (1, rows[i].getString(ds_detail.indexOfColumn("GIFT_CD")));
					cstmt.setString (2, rows[i].getString(ds_detail.indexOfColumn("GIFT_TYPE")));
					cstmt.setString (3, rows[i].getString(ds_detail.indexOfColumn("FR_GIFT_SEQ")));
					cstmt.setString (4, rows[i].getString(ds_detail.indexOfColumn("TO_GIFT_SEQ")));
					cstmt.setInt	(5, rows[i].getInt(ds_detail.indexOfColumn("PAY_QTY")));
					cstmt.setInt	(6, rows[i].getInt(ds_detail.indexOfColumn("PAY_AMT")));
					cstmt.setString (7, fParamEmpno);
					cstmt.setString (8, fParamIp);
					cstmt.setString (9, v_edit_status);
					cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);	//성공여부
					cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);	//메세지 코드
					cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);	//메세지
					
					cstmt.executeUpdate();
					
					r_s_yn		 = cstmt.getString(10);
					r_msg_cd	 = cstmt.getString(11);
					r_msg		 = cstmt.getString(12);	
					
					if(ds_detail!=null){
						ds_detail_result.put("S_YN", 	r_s_yn, 1);//커서 OUT param.
						ds_detail_result.put("MSG_CD", r_msg_cd, 4);//커서 OUT param.
						ds_detail_result.put("MSG", 	r_msg, 200);//커서 OUT param.
						ds_detail_result.heap();
					}
					if(cstmt!=null) cstmt.close();
				}
				if(ds_detail_result!=null) gos.write(ds_detail_result);
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
		if(cstmt!=null) cstmt.close();
	//if( fail == true ) throw new Exception("");			
	}
}
}