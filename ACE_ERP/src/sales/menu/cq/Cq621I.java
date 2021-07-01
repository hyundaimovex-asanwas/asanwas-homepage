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

public class Cq621I extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		//MASTER ��ȸ
		arr_sql[0].append ("{call SALES.PR_CQ621I_01(?,?,?,?,?, 	?,?)}");
		
		//DETAIL ��ȸ
		arr_sql[1].append ("{call SALES.PR_CQ621I_02(?,?,?)}");
		
		//MASTER ����
		arr_sql[2].append ("{call SALES.PR_CQ621I_03(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)}");
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
		    //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
		    GauceDataSet[] dSets = gis.readAllOutput(); 

		    for(int i=0; i<dSets.length;i++){
			   	if(dSets[i].getName().equals("ds_master")){
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
		   			GauceDataSet ds1 = gis.read("MASTER");
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setInt	(1, v_saup_sid);
						cstmt.setString (2, v_fr_trn_date);
						cstmt.setString (3, v_to_trn_date);
						cstmt.setString (4, v_fr_arrive_date);
						cstmt.setString (5, v_to_arrive_time);
						cstmt.setString (6, "1234567");
						cstmt.registerOutParameter(7, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(7);	//Ŀ�� OUT param. 			
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
			String 	v_car_no		 	= HDUtil.nullCheckStr(greq.getParameter("v_car_no"));
			
			String	v_trn_date			= HDUtil.nullCheckStr(greq.getParameter("v_trn_date"));
			int 	v_car_rsv_sid 		= HDUtil.nullCheckNum(greq.getParameter("v_car_rsv_sid"));
			
			/*
			StringUtil.printMsg("v_saup_sid", v_saup_sid, this);
			StringUtil.printMsg("v_fr_trn_date", v_fr_trn_date, this);
			StringUtil.printMsg("v_to_trn_time", v_to_trn_date, this);
			StringUtil.printMsg("v_fr_arrive_date",v_fr_arrive_date, this);
			StringUtil.printMsg("v_to_arrive_time", v_to_arrive_time, this);
			StringUtil.printMsg("v_car_no", v_car_no, this);
			StringUtil.printMsg("v_car_rsv_sid", v_car_rsv_sid, this);
			*/
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
					if(dSets[i].getName().equals("ds_master")){
						GauceDataSet ds1 = gis.read("MASTER");
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setInt	(1, v_saup_sid);
						cstmt.setString (2, v_fr_trn_date);
						cstmt.setString (3, v_to_trn_date);
						cstmt.setString (4, v_fr_arrive_date);
						cstmt.setString (5, v_to_arrive_time);
						cstmt.setString (6, v_car_no);
						cstmt.registerOutParameter(7, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(7);	//Ŀ�� OUT param. 			
						gos.write(getDataSet(rs, ds1));
					} else if(dSets[i].getName().equals("ds_detail")){
						GauceDataSet ds1 = gis.read("DETAIL");
						//StringUtil.printMsg("v_saup_sid", v_saup_sid, this);
						//StringUtil.printMsg("v_rsv_sid", v_rsv_sid, this);
						
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1, v_saup_sid);
						cstmt.setInt(2, v_car_rsv_sid);
						cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 			
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

//StringUtil.printMsg("row[i].getString(0) ��û����",row[i].getString(0), this);
					/*
StringUtil.printMsg("��������",row[i].getString(ds1.indexOfColumn("L_ARRIVE_DATE")), this);
StringUtil.printMsg("����ð�",row[i].getString(ds1.indexOfColumn("L_ARRIVE_TIME")), this);
StringUtil.printMsg("INOUT_SID", row[i].getInt(ds1.indexOfColumn("INOUT_SID")), this);			//����� SID
StringUtil.printMsg("CAR_RSV_SID", row[i].getInt(ds1.indexOfColumn("CAR_RSV_SID")), this);			//�������� SID
StringUtil.printMsg("TRN_DATE", row[i].getString(ds1.indexOfColumn("TRN_DATE")), this);	//��û����
StringUtil.printMsg("TRN_GU", row[i].getString(ds1.indexOfColumn("TRN_GU")), this);	//�������
StringUtil.printMsg("F_ARRIVE_DATE", row[i].getString(ds1.indexOfColumn("F_ARRIVE_DATE")), this);	//�԰濹������
StringUtil.printMsg("F_ARRIVE_TIME", row[i].getString(ds1.indexOfColumn("F_ARRIVE_TIME")), this);	//�԰濹���ð�
StringUtil.printMsg("L_ARRIVE_DATE", row[i].getString(ds1.indexOfColumn("L_ARRIVE_DATE")), this);	//������������
StringUtil.printMsg("L_ARRIVE_DATE", row[i].getString(ds1.indexOfColumn("L_ARRIVE_TIME")), this);	//��������ð�
StringUtil.printMsg("TRN_CODE", row[i].getString(ds1.indexOfColumn("TRN_CODE")), this);	//��������ڵ�
StringUtil.printMsg("TRN_DESC", row[i].getString(ds1.indexOfColumn("TRN_DESC")), this);	//�������
StringUtil.printMsg("DEPART_DATE", row[i].getString(ds1.indexOfColumn("DEPART_DATE")), this);	//������� : ���ڱⰣ ���� 2008-05-18�ɵ���
*/

					cstmt.setInt(1, row[i].getInt(ds1.indexOfColumn("INOUT_SID")));			//����� SID
					cstmt.setInt(2, row[i].getInt(ds1.indexOfColumn("CAR_RSV_SID")));			//�������� SID
					cstmt.setString(3, row[i].getString(ds1.indexOfColumn("TRN_DATE")));	//��û����
					cstmt.setString(4, row[i].getString(ds1.indexOfColumn("TRN_GU")));	//�������
					cstmt.setString(5, row[i].getString(ds1.indexOfColumn("F_ARRIVE_DATE")));	//�԰濹������
					cstmt.setString(6, row[i].getString(ds1.indexOfColumn("F_ARRIVE_TIME")));	//�԰濹���ð�
					cstmt.setString(7, row[i].getString(ds1.indexOfColumn("L_ARRIVE_DATE")));	//������������
					cstmt.setString(8, row[i].getString(ds1.indexOfColumn("L_ARRIVE_TIME")));	//��������ð�
					cstmt.setString(9, row[i].getString(ds1.indexOfColumn("TRN_CODE")));	//��������ڵ�
					cstmt.setString(10, row[i].getString(ds1.indexOfColumn("TRN_DESC")));	//�������
					cstmt.setString(11, row[i].getString(ds1.indexOfColumn("DEPART_DATE")));	//������� : ���ڱⰣ ���� 2008-05-18�ɵ���
					cstmt.setString(12, fParamEmpno);
					cstmt.setString(13, fParamIp);
					cstmt.setString(14, v_edit_status);
					cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);	//��������
					cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);	//�޼��� �ڵ�
					cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);	//�޼���
					
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