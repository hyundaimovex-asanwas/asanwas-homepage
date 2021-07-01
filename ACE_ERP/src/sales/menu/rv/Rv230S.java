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

public class Rv230S extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		arr_sql[0].append ("{call SALES.PR_RV230S_01(?,?,?,?,?, 		?,?,?)}");//�ο� ��Ȳ
		arr_sql[1].append ("{call SALES.PR_RV230S_02(?,?,?,?,?, 		?,?,?)}");//�ο� �ϰ�
		arr_sql[2].append ("{call SALES.PR_RV230S_03(?,?,?,?,?, 		?,?,?)}");//���� ��Ȳ
		arr_sql[3].append ("{call SALES.PR_RV230S_04(?,?,?,?,?, 		?,?,?)}");//���� �ϰ�
		
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;

		int v_saup_sid 			= HDUtil.nullCheckNum(greq.getParameter("v_saup_sid"));			// �����
		int v_goods_sid 		= HDUtil.nullCheckNum(greq.getParameter("v_goods_sid"));			// ��ǰ
		int v_client_sid 		= HDUtil.nullCheckNum(greq.getParameter("v_client_sid"));		// ����ó
		String v_fr_depart_date = HDUtil.nullCheckStr(greq.getParameter("v_fr_depart_date")); 	// ������� From
		String v_to_depart_date = HDUtil.nullCheckStr(greq.getParameter("v_to_depart_date")); 	// ������� To
		String v_status			= HDUtil.nullCheckStr(greq.getParameter("v_status")); 			// �������
		String v_accept_no		= HDUtil.nullCheckStr(greq.getParameter("v_accept_no")); 		// ��û����ȣ

		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
				if(dSets[i].getName().equals("ds_cust")){
					GauceDataSet ds1 = gis.read("DS_CUST");
					cstmt = conn.prepareCall(arr_sql[0].toString());
					/*
					StringUtil.printMsg(" arr_sql[0].toString() ",arr_sql[0].toString(),this);
					StringUtil.printMsg(" v_saup_sid",v_saup_sid,this);
					StringUtil.printMsg(" v_goods_sid",v_goods_sid,this);
					StringUtil.printMsg(" v_client_sid",v_client_sid,this);
					StringUtil.printMsg(" v_fr_depart_date",v_fr_depart_date,this);
					StringUtil.printMsg(" v_to_depart_date",v_to_depart_date,this);
					StringUtil.printMsg(" v_status",v_status,this);
					StringUtil.printMsg(" v_accept_no",v_accept_no,this);
					*/
					cstmt.setInt(1, v_saup_sid);
					cstmt.setInt(2, v_goods_sid);
					cstmt.setInt(3, v_client_sid);
					cstmt.setString(4, v_fr_depart_date);
					cstmt.setString(5, v_to_depart_date);
					cstmt.setString(6, v_status);
					cstmt.setString(7, v_accept_no);
					cstmt.registerOutParameter(8, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(8);	//Ŀ�� OUT param. 			
					gos.write(getDataSet(rs, ds1));
				}
				if(dSets[i].getName().equals("ds2")){
					GauceDataSet ds1 = gis.read("DS2");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					/*
					StringUtil.printMsg(" arr_sql[0].toString() ",arr_sql[0].toString(),this);
					StringUtil.printMsg(" v_saup_sid",v_saup_sid,this);
					StringUtil.printMsg(" v_goods_sid",v_goods_sid,this);
					StringUtil.printMsg(" v_client_sid",v_client_sid,this);
					StringUtil.printMsg(" v_fr_depart_date",v_fr_depart_date,this);
					StringUtil.printMsg(" v_to_depart_date",v_to_depart_date,this);
					StringUtil.printMsg(" v_status",v_status,this);
					StringUtil.printMsg(" v_accept_no",v_accept_no,this);
					*/
					cstmt.setInt(1, v_saup_sid);
					cstmt.setInt(2, v_goods_sid);
					cstmt.setInt(3, v_client_sid);
					cstmt.setString(4, v_fr_depart_date);
					cstmt.setString(5, v_to_depart_date);
					cstmt.setString(6, v_status);
					cstmt.setString(7, v_accept_no);
					cstmt.registerOutParameter(8, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(8);	//Ŀ�� OUT param. 			
					gos.write(getDataSet(rs, ds1));
				}
				if(dSets[i].getName().equals("ds_car")){
					GauceDataSet ds1 = gis.read("DS_CAR");
					cstmt = conn.prepareCall(arr_sql[2].toString());
					/*
					StringUtil.printMsg(" arr_sql[2].toString() ",arr_sql[2].toString(),this);
					StringUtil.printMsg(" v_saup_sid",v_saup_sid,this);
					StringUtil.printMsg(" v_goods_sid",v_goods_sid,this);
					StringUtil.printMsg(" v_client_sid",v_client_sid,this);
					StringUtil.printMsg(" v_fr_depart_date",v_fr_depart_date,this);
					StringUtil.printMsg(" v_to_depart_date",v_to_depart_date,this);
					StringUtil.printMsg(" v_status",v_status,this);
					StringUtil.printMsg(" v_accept_no",v_accept_no,this);
					*/
					cstmt.setInt(1, v_saup_sid);
					cstmt.setInt(2, v_goods_sid);
					cstmt.setInt(3, v_client_sid);
					cstmt.setString(4, v_fr_depart_date);
					cstmt.setString(5, v_to_depart_date);
					cstmt.setString(6, v_status);
					cstmt.setString(7, v_accept_no);
					cstmt.registerOutParameter(8, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(8);	//Ŀ�� OUT param. 			
					gos.write(getDataSet(rs, ds1));
				}
				if(dSets[i].getName().equals("ds_car2")){
					GauceDataSet ds1 = gis.read("DS_CAR2");
					cstmt = conn.prepareCall(arr_sql[3].toString());
					cstmt.setInt(1, v_saup_sid);
					cstmt.setInt(2, v_goods_sid);
					cstmt.setInt(3, v_client_sid);
					cstmt.setString(4, v_fr_depart_date);
					cstmt.setString(5, v_to_depart_date);
					cstmt.setString(6, v_status);
					cstmt.setString(7, v_accept_no);
					cstmt.registerOutParameter(8, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(8);	//Ŀ�� OUT param. 			
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