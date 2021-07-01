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

public class Rv811S extends SuperServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		arr_sql[1].append("CALL SALES.PR_RV811S_01(?,?,?,?,?,  ?,?,?)"); // ��ȸ: �ο� ���
		arr_sql[2].append("CALL SALES.PR_RV811S_02(?,?,?,?,?,  ?,?,?)"); //����Ʈ �����ȸ
		arr_sql[3].append("CALL SALES.PR_RV811S_03(?,?,?,?,?,  ?,?,?)"); // ��ȸ: ���� ���
		arr_sql[4].append("CALL SALES.PR_RV811S_04(?,?,?,?,?,  ?,?,?)"); // ��ȸ: �ο�+����
		}
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","����ȸ",this);
	}
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		try {
			//�˻��� �ʿ��� ����
			int sSaup_sid 		= HDUtil.nullCheckNum(greq.getParameter("sSaup_sid"));	// �����
			String sDepart_date = HDUtil.nullCheckStr(greq.getParameter("sDepart_date")); 	// �������
			String sDepart_time = HDUtil.nullCheckStr(greq.getParameter("sDepart_time")); 	// ���ð� 
			int sGoods_sid 		= HDUtil.nullCheckNum(greq.getParameter("sGoods_sid"));			// ��ǰSID 
			int sClientSid 		= HDUtil.nullCheckNum(greq.getParameter("sClient_sid"));	// ����ó
			String v_accept_no 	= HDUtil.nullCheckStr(greq.getParameter("v_accept_no"));	// ��û����ȣ		
			String sJobsel 	= HDUtil.nullCheckStr(greq.getParameter("sJobsel"));	// �źб���
			/*
			StringUtil.printMsg("�����",sSaup_sid+"",this);
			StringUtil.printMsg("�������",sDepart_date,this);
			StringUtil.printMsg("���ð�",sDepart_time,this);
			StringUtil.printMsg("��ǰSID",sGoods_sid+"",this);
			StringUtil.printMsg("����ó",sClientSid+"",this);
			StringUtil.printMsg("��û����ȣ",v_accept_no,this);
			StringUtil.printMsg("�źб���",sJobsel,this);
			 */
			int v_rowcnt = 0;
			// dataset ���� param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			//StringUtil.printMsg("dsType",dsType,this);
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			for(int i=0; i<dSets.length;i++){
				StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
					if(dSets[i].getName().equals("ds1")){
						GauceDataSet ds1 = gis.read("DS1");
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setInt(2, sGoods_sid);
						cstmt.setInt(3, sClientSid);
						cstmt.setString(4, sDepart_date);
						cstmt.setString(5, sDepart_time);
						cstmt.setString(6, v_accept_no);
						cstmt.setString(7, sJobsel);
						cstmt.registerOutParameter(8, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(8);	//Ŀ�� OUT param. 			
						gos.write(getDataSet(rs, ds1));	
					}
					if(dSets[i].getName().equals("ds_gr2")){
						GauceDataSet ds1 = gis.read("DS_GR2");
						cstmt = conn.prepareCall(arr_sql[3].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setInt(2, sGoods_sid);
						cstmt.setInt(3, sClientSid);
						cstmt.setString(4, sDepart_date);
						cstmt.setString(5, sDepart_time);
						cstmt.setString(6, v_accept_no);
						cstmt.setString(7, sJobsel);
						cstmt.registerOutParameter(8, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(8);	//Ŀ�� OUT param. 			
						gos.write(getDataSet(rs, ds1));		
					}		
					if(dSets[i].getName().equals("ds_gr3")){
						GauceDataSet ds1 = gis.read("DS_GR3");
						cstmt = conn.prepareCall(arr_sql[4].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setInt(2, sGoods_sid);
						cstmt.setInt(3, sClientSid);
						cstmt.setString(4, sDepart_date);
						cstmt.setString(5, sDepart_time);
						cstmt.setString(6, v_accept_no);
						cstmt.setString(7, sJobsel);
						cstmt.registerOutParameter(8, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(8);	//Ŀ�� OUT param. 			
						gos.write(getDataSet(rs, ds1));		
					}	
					if(dSets[i].getName().equals("ds9")){
						GauceDataSet ds1 = gis.read("REPORT");
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setInt(2, sGoods_sid);
						cstmt.setInt(3, sClientSid);
						cstmt.setString(4, sDepart_date);
						cstmt.setString(5, sDepart_time);
						cstmt.setString(6, v_accept_no);
						cstmt.setString(7, sJobsel);
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