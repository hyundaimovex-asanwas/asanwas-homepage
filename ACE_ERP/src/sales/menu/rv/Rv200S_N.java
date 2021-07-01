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

public class Rv200S_N extends SuperServlet {
 
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		arr_sql[0].append ("{call SALES.PR_RV200S_01_PLZ(?,?,?,?,?, 	?,?,?,?,?,	 ?,?,?,?,?		,?)}");
		arr_sql[1].append ("SELECT                       		        \n")
				  .append ("	r15.bound_seq, TO_CHAR(r15.bound_seq) AS bound_nm     	\n")
				  .append ("FROM                                    	\n")
				  .append ("	sales.trv010 r1 join sales.trv015 r15 on (r1.accept_sid=r15.accept_sid)                  \n")
				  .append ("WHERE 1=1                           		\n")
				  .append (" AND  r1.ACCEPT_NO = ?              		\n")
				  .append (" ORDER BY r15.bound_seq               		\n");
						  
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
		int v_event_sid 		= HDUtil.nullCheckNum(greq.getParameter("v_event_sid"));			// ��ü���.
		int v_bound_seq 		= HDUtil.nullCheckNum(greq.getParameter("v_bound_seq"));			// ��ǰ����.
		String v_fr_depart_date = HDUtil.nullCheckStr(greq.getParameter("v_fr_depart_date")); 	// ������� From
		String v_to_depart_date = HDUtil.nullCheckStr(greq.getParameter("v_to_depart_date")); 	// ������� To
		String v_status			= HDUtil.nullCheckStr(greq.getParameter("v_status")); 			// �������
		String v_accept_no		= HDUtil.nullCheckStr(greq.getParameter("v_accept_no")); 		// ��û����ȣ
		String v_cust_nm		= HDUtil.nullCheckStr(greq.getParameter("v_cust_nm")); 		// ��û����ȣ
		String v_manage_no		= HDUtil.nullCheckStr(greq.getParameter("v_manage_no")); 		// ��û����ȣ
		String s_cust_gu		= HDUtil.nullCheckStr(greq.getParameter("v_cust_gu")); 		// ��
		String s_country_gu		= HDUtil.nullCheckStr(greq.getParameter("v_country_gu")); 		// ����
		String s_saup_gu		= HDUtil.nullCheckStr(greq.getParameter("v_saup_gu")); 		// ���
		String s_job_sel		= HDUtil.nullCheckStr(greq.getParameter("v_job_sel")); 		// ���
		//StringUtil.printMsg("v_bound_seq",v_bound_seq,this);
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
					
					cstmt.setInt(1, v_saup_sid);
					cstmt.setInt(2, v_goods_sid);
					cstmt.setInt(3, v_client_sid);
					cstmt.setInt(4, v_event_sid);
					cstmt.setString(5, v_fr_depart_date);
					cstmt.setString(6, v_to_depart_date);
					cstmt.setString(7, v_status);
					cstmt.setString(8, v_accept_no);
					cstmt.setString(9, v_manage_no);
					cstmt.setString(10, v_cust_nm);
					cstmt.setString(11, s_cust_gu);
					cstmt.setString(12, s_country_gu);
					cstmt.setString(13, s_saup_gu);
					cstmt.setString(14, s_job_sel);
					cstmt.setInt(15, v_bound_seq);
					cstmt.registerOutParameter(16, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(16);	//Ŀ�� OUT param. 			
					gos.write(getDataSet(rs, ds1));
					
				}
			}
			 //gos.close();
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
		ResultSet rs = null;

		String v_accept_no		= HDUtil.nullCheckStr(greq.getParameter("v_accept_no")); 		// ��û����ȣ
		//StringUtil.printMsg("v_accept_no",v_accept_no,this);
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
					if(dSets[i].getName().equals("ds_bound")){
						GauceDataSet ds1 = gis.read("DS_BOUND");
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setString(1, v_accept_no);
						rs = cstmt.executeQuery();
						gos.write(getDataSet(rs, ds1));
				}
			}
			gos.close();
		} catch (SQLException sqle){
			//gres..writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			//gres..writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
}

