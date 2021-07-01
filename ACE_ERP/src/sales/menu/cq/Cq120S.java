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

public class Cq120S extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		//ž���� ���� ��Ȳ
		arr_sql[0].append ("{call SALES.PR_CQ120S_01(?,?,?,?,?) }");

		//������ ������ ���
		arr_sql[1].append ("{call SALES.PR_CQ120S_02(?,?,?,?,?) }");
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
	}

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();

		int sSaup_sid 		= HDUtil.nullCheckNum(greq.getParameter("sSaup_sid"));		// �����
		String sDepart_date = HDUtil.nullCheckStr(greq.getParameter("sDepart_date")); 	// �������
		String sDepart_time = HDUtil.nullCheckStr(greq.getParameter("sDepart_time")); 	// ���ð� 
		int sGoods_sid 		= HDUtil.nullCheckNum(greq.getParameter("sGoods_sid"));		// ��ǰSID 
		/*
		StringUtil.printMsg("�����",sSaup_sid,this);
		StringUtil.printMsg("�������",sDepart_date,this);
		StringUtil.printMsg("���ð�",sDepart_time,this);
		StringUtil.printMsg("��ǰSID",sGoods_sid+"",this);
		 */
		try {
			GauceDataSet[] dSets = gis.readAllOutput(); 
			for(int j=0; j<dSets.length;j++){	
				//�⺻ �˻� ����
				if(dSets[j].getName().equals("ds_cust")){
					GauceDataSet ds1 = gis.read("DS_CUST");
						//StringUtil.printMsg("arr_sql[0].toString()", arr_sql[0].toString(), this);
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setInt(1, sSaup_sid);
						cstmt.setString(2, sDepart_date);
						cstmt.setString(3, sDepart_time);
						cstmt.setInt(4, sGoods_sid);
						cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(5);	//Ŀ�� OUT param. 			
						gos.write(getDataSet(rs, ds1));	
				} else if (dSets[j].getName().equals("ds_tour")){
					GauceDataSet ds1 = gis.read("DS_TOUR");
						//StringUtil.printMsg("arr_sql[1].toString()", arr_sql[1].toString(), this);
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1, sSaup_sid);
						cstmt.setString(2, sDepart_date);
						cstmt.setString(3, sDepart_time);
						cstmt.setInt(4, sGoods_sid);
						cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(5);	//Ŀ�� OUT param. 			
						gos.write(getDataSet(rs, ds1));	
				}
			}
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


	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
	}
}