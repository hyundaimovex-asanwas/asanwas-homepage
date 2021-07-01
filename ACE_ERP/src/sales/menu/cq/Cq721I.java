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

public class Cq721I extends SuperServlet {
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		//��ȸ
		arr_sql[0].append ("{call SALES.PR_CQ721I_01(?,?,?,?,?, 	?,?)}");
		
		//����
		arr_sql[1].append ("{call SALES.PR_CQ721I_02(?,?,?,?,?,		 ?,?,?,?,?)}");
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		try{
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
			GauceDataSet[] dSets = gis.readAllOutput(); 
			for(int i=0; i<dSets.length;i++){	
				//�⺻ �˻� ����
				if(dSets[i].getName().equals("ds1")){
				GauceDataSet ds1 = gis.read("DEFAULT");
				
				int 	v_saup_sid 		= HDUtil.nullCheckNum(greq.getParameter("v_saup_sid"));
				String 	v_arrive_date 	= HDUtil.nullCheckStr(greq.getParameter("v_arrive_date"));
				String 	v_arrive_time 	= HDUtil.nullCheckStr(greq.getParameter("v_arrive_time"));
				int 	v_goods_sid 	= HDUtil.nullCheckNum(greq.getParameter("v_goods_sid"));
				String 	v_car_no		= HDUtil.nullCheckStr(greq.getParameter("v_car_no"));
				String 	v_out_gubn		= HDUtil.nullCheckStr(greq.getParameter("v_out_gubn"));

				//StringUtil.printMsg("v_saup_sid", v_saup_sid, this);
				//StringUtil.printMsg("v_arrive_date", v_arrive_date, this);
				//StringUtil.printMsg("v_arrive_time", v_arrive_time, this);
				//StringUtil.printMsg("v_goods_sid", v_goods_sid, this);
				//StringUtil.printMsg("v_cust_nm", v_cust_nm, this);
				//StringUtil.printMsg("v_manage_no", v_manage_no, this);
				//StringUtil.printMsg("v_out_gubn", v_out_gubn, this);

				cstmt = conn.prepareCall(arr_sql[0].toString());
				cstmt.setInt	(1, v_saup_sid);
				cstmt.setString (2, v_arrive_date);
				cstmt.setString (3, v_arrive_time);
				cstmt.setInt	(4, v_goods_sid);
				cstmt.setString (5, v_car_no);
				cstmt.setString (6, v_out_gubn);
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

	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		CallableStatement cstmt = null;	
		ResultSet 		rs 			= null;
				
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
						
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		/* DataSet */
		GauceDataSet ds1 = gis.read("DEFAULT");
		
		try{
			if(ds1!=null){
				GauceDataRow[] row = ds1.getDataRows();
				for(int i=0; i<row.length; i++){
					cstmt = conn.prepareCall(arr_sql[1].toString());
					
					
					cstmt.setString (1, row[i].getString(ds1.indexOfColumn("JOB_SEL")));	//job_sel
					cstmt.setInt	(2, row[i].getInt(ds1.indexOfColumn("CAR_RSV_SID")));		//���� ����SID
					cstmt.setInt	(3, row[i].getInt(ds1.indexOfColumn("INOUT_SID")));		//�����SID
					cstmt.setString (4, row[i].getString(ds1.indexOfColumn("ARRIVE_DATE")));	//�԰�����
					cstmt.setString (5, row[i].getString(ds1.indexOfColumn("ARRIVE_TIME")));	//�԰�ð�
					cstmt.setString (6, row[i].getString(ds1.indexOfColumn("REMARKS")));	//�������
					cstmt.setString (7, iParamEmpno);
					cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
					
					cstmt.executeUpdate();
					
					if(cstmt.getString(9)==null || cstmt.getString(9).equals("N"))
						throw new Exception(cstmt.getString(11));
					
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
