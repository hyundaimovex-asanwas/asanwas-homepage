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

public class Rv201S extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {   
		// TODO Auto-generated method stub
		//SELECT DATA
		arr_sql[0].append("{call SALES.PR_RV201S_01 (?,?,? ) }");

		//UPDATE DATA
		arr_sql[1].append("{call SALES.PR_RV201S_02 (?,? ) }");
		
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		// TODO Auto-generated method stub
		
		CallableStatement cstmt = null;
		ResultSet rs = null;

		/*
		 * �˻��� �ʿ��� ����
		 */
		 int 	v_saup_sid		= HDUtil.nullCheckNum(greq.getParameter("v_saup_sid"));
		String s_manage_no    	= HDUtil.nullCheckStr(greq.getParameter("v_manage_no"));	// �˻�����: �ֹ�/���ǹ�ȣ 
				
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
						//��ȸ����
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setString (1, s_manage_no);		//IN 
						cstmt.setInt	(2, v_saup_sid);
						cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 			
						gos.write(getDataSet(rs, ds1));
						
						//��������
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setString ( 1, s_manage_no);
						cstmt.setInt	(2, v_saup_sid);
						cstmt.executeUpdate();						
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

	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("=============================== ������Ʈ �Ķ���� =========================",this);
	}
}