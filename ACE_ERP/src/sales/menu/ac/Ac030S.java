package sales.menu.ac;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import javax.naming.*;

import oracle.jdbc.OracleTypes;

import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

import java.io.*;
import java.sql.*;

public class Ac030S extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_AC030S_01(?,?,?,?,?,		?,?,?)");
	}

	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","����ȸ",this);
	}

	
	 public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		int v_rowcnt = 0;


		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		
		/*
		 * �˻��� �ʿ��� ����
		 */
		
		int sSaup_sid 		= HDUtil.nullCheckNum(greq.getParameter("sSaup_sid"));	// �����
		int sGoods_sid 		= HDUtil.nullCheckNum(greq.getParameter("sGoods_sid"));			// ��ǰSID 
		int sClientSid 		= HDUtil.nullCheckNum(greq.getParameter("sClient_sid"));	// ����ó 
		String sSDate = HDUtil.nullCheckStr(greq.getParameter("sSDate")); 	// �������
		String sEDate = HDUtil.nullCheckStr(greq.getParameter("sEDate")); 	// ���ð� 
		String v_out_gubn	= HDUtil.nullCheckStr(greq.getParameter("v_out_gubn"));// ��汸��
		String sCustGu		= HDUtil.nullCheckStr(greq.getParameter("sCustGu")); // ������ 
		
		
		
		try { 
			GauceDataSet[] dSets = gis.readAllOutput(); 
			int sCnt1 = 1;
			
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//DEFAULT=ds_default,O: MASTER=ds_master	DATE=ds_date
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
				
					cstmt = conn.prepareCall(arr_sql[1].toString());
					/*
					StringUtil.printMsg("sSaup_sid",sSaup_sid+"",this);
					StringUtil.printMsg("sGoods_sid",sGoods_sid,this);
					StringUtil.printMsg("sClientSid",sClientSid,this);
					StringUtil.printMsg("sSDate",sSDate+"",this);
					StringUtil.printMsg("sEDate",sEDate+"",this);
					StringUtil.printMsg("v_out_gubn",v_out_gubn+"",this);
					StringUtil.printMsg("sCustGu",sCustGu+"",this);
					*/
					
					cstmt.setInt(1,sSaup_sid);
					cstmt.setInt(2, sGoods_sid);
					cstmt.setInt(3, sClientSid);
					cstmt.setString(4, sSDate);
					cstmt.setString(5, sEDate);
					cstmt.setString(6, v_out_gubn);
					cstmt.setString(7, sCustGu);
					cstmt.registerOutParameter(8, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(8);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));

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
	}
}