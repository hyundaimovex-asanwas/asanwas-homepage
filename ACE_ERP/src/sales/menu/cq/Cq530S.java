package sales.menu.cq;

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

import oracle.jdbc.OracleTypes;

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

import sales.common.SuperServlet;
import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;

public class Cq530S extends SuperServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_CQ530S_01(?,?,?,?,?)");
		arr_sql[2].append("CALL SALES.PR_CQ530S_02(?,?,?,?,?)");
		arr_sql[3].append("CALL SALES.PR_CQ530S_03(?,?,?,?,?)");
		
	}
 
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","����ȸ",this);
	}
	
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		ResultSetMetaData 	rsmd 		= null;
		String[] 			columnName 	= null;
		CallableStatement 	cstmt		=null;
		
		int v_rowcnt = 0;

		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		
		/*
		 * �˻��� �ʿ��� ����
		 */
		
         int 	sSaup_sid 		= HDUtil.nullCheckNum(greq.getParameter("sSaup_sid"));	// �����
		 int	sGoodSid		= HDUtil.nullCheckNum(greq.getParameter("sGoodSid"));	// ��ǰ 	
		 String sDepartDate 	= HDUtil.nullCheckStr(greq.getParameter("sDepartDate")); 	// �԰�����
		 String sDepartTime		= HDUtil.nullCheckStr(greq.getParameter("sDepartTime")); 	// ���ð�
		/*
		StringUtil.printMsg("�����",sSaup_sid+"",this);
		StringUtil.printMsg("��ǰ",sGoodSid,this);
		StringUtil.printMsg("�԰�����",sDepartDate,this);
		StringUtil.printMsg("�԰�ð�",sDepartTime,this);
		*/
		int c = 1;
		try {
			GauceDataSet[] dSets = gis.readAllOutput(); 
			int sCnt1 = 1;
			for(int i=0; i<dSets.length;i++){	
				//�⺻ �˻� ����
				if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
						
					cstmt = conn.prepareCall(arr_sql[1].toString()); // �Ѱ�
					cstmt.setInt(1,sSaup_sid);
					cstmt.setInt(2,sGoodSid);
					cstmt.setString(3, sDepartDate);
					cstmt.setString(4, sDepartTime);
					cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(5);	//Ŀ�� OUT param. 			
					gos.write(getDataSet(rs, ds1));
				}
				if(dSets[i].getName().equals("ds2")){
					GauceDataSet ds1 = gis.read("DS2");
				
					cstmt = conn.prepareCall(arr_sql[2].toString());	// ������ �Ѱ�
					cstmt.setInt(1,sSaup_sid);
					cstmt.setInt(2,sGoodSid);
					cstmt.setString(3, sDepartDate);
					cstmt.setString(4, sDepartTime);
					cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(5);	//Ŀ�� OUT param. 			
					gos.write(getDataSet(rs, ds1));
				} 
				if(dSets[i].getName().equals("ds3")){
					GauceDataSet ds1 = gis.read("DS3");
					cstmt = conn.prepareCall(arr_sql[3].toString()); // ��ž�� �ο�
					cstmt.setInt(1,sSaup_sid);
					cstmt.setInt(2,sGoodSid);
					cstmt.setString(3, sDepartDate);
					cstmt.setString(4, sDepartTime);
					cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(5);	//Ŀ�� OUT param. 			
					gos.write(getDataSet(rs, ds1));	
				}
					//StringUtil.printMsg("ī��Ʈ C" , c++, this);
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