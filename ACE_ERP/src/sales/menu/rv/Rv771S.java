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

public class Rv771S extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
        for(int i=0; i<arr_sql.length; i++)
            arr_sql[i] = new StringBuffer();
        
        //���� ����� ��ȸ
        arr_sql[0].append ("{call SALES.PR_RV771S_01(?,?,?,?)}");
	}

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub

		//GauceDataSet ds1 = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		String  v_depart_date 	= HDUtil.nullCheckStr(greq.getParameter("v_depart_date"));	//�������
		int		v_nights	 	= HDUtil.nullCheckNum(greq.getParameter("v_nights"));		//���ڼ�
		int     v_saup_sid		= HDUtil.nullCheckNum(greq.getParameter("v_saup_sid"));		//�������� �߰�
		
		try{
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
			GauceDataSet[] dSets = gis.readAllOutput();
			
			for(int j=0; j<dSets.length;j++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
				if(dSets[j].getName().equals("ds1")){
		    		GauceDataSet ds1 = gis.read("DEFAULT");
		    		
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, v_depart_date);
					cstmt.setInt   (2, v_nights);
					cstmt.setInt   (3, v_saup_sid);
					cstmt.registerOutParameter(4, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(4);	//Ŀ�� OUT param. 			
					gos.write(getDataSet(rs, ds1));

					if(rs!=null) rs.close();
					if(cstmt!=null) cstmt.close();
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

	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}
}