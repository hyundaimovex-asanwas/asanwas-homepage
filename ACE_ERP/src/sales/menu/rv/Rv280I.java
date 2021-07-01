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
 
public class Rv280I extends SuperServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String SAVE_FILE = HDConstant.FILE_UPLOAD_PATH_COST;
	
    public void makeSql(){
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		arr_sql[1].append("CALL SALES.PR_RV280I_01(?,?,?,?,?,     ?,?,?,?)"); // ��ȸ
		arr_sql[2].append("CALL SALES.PR_RV280I_02(?)");	// ���� : ���տ���
	}
	
	// �ʱ�
    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}	

	// ��ȸ method
    public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
    	CallableStatement cstmt = null;
		ResultSet rs = null;
		
		// �˻��� ����
		int  	sSaupSid	= HDUtil.nullCheckNum(greq.getParameter("sSaup_sid")); 	// ����
		int  	sClientSid	= HDUtil.nullCheckNum(greq.getParameter("sClientSid")); 	// ����ó
		String  sDep_date	= HDUtil.nullCheckStr(greq.getParameter("sDep_date")); 	// �������
		int  	sGoodsSid	= HDUtil.nullCheckNum(greq.getParameter("sGoods_sid")); 	// ��ǰid
		String	sOkYN		= HDUtil.nullCheckStr(greq.getParameter("sOkYN"));		// ���տ���
		String	sStatus		= HDUtil.nullCheckStr(greq.getParameter("sStatus"));		// status_cd��.
		int  	sSalDamSid	= HDUtil.nullCheckNum(greq.getParameter("sSalDamSid")); 	// �����sid
		String	sJobsel		= HDUtil.nullCheckStr(greq.getParameter("sJobsel"));		// ������
		
		//StringUtil.printMsg("����--- ", sSaupSid,this);
		//StringUtil.printMsg("�븮��--- ", sClientSid,this);
		//StringUtil.printMsg("����--- ", sDep_date,this);
		//StringUtil.printMsg("��ǰ--- ", sGoodsSid,this);
		//StringUtil.printMsg("����--- ", sOkYN,this);

		// dataset ���� param
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
					if(dSets[i].getName().equals("ds1")){
						GauceDataSet ds1 = gis.read("DEFAULT");
							cstmt = conn.prepareCall(arr_sql[1].toString());
							cstmt.setInt(1,sSaupSid);
							cstmt.setInt(2,sClientSid);
							cstmt.setString(3, sDep_date);
							cstmt.setInt(4,sGoodsSid);
							cstmt.setString(5, sOkYN);
							cstmt.setString(6, sStatus);
							cstmt.setInt(7,sSalDamSid);
							cstmt.setString(8, sJobsel);
							cstmt.registerOutParameter(9, OracleTypes.CURSOR);	//����� ���� Ŀ��
							cstmt.executeQuery();
							rs = (ResultSet)cstmt.getObject(9);	//Ŀ�� OUT param. 			
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
	/**
	 * ��� : 
	 */
	// �Է�, ����, ����
    public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
    	CallableStatement cstmt = null;	
		ResultSet 		rs 			= null;
				
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
						
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		
		/* DataSet */
		GauceDataSet ds1 = null; // �븮�� ���� 
		
		// �Ķ����
		int sCustSid		= HDUtil.nullCheckNum(greq.getParameter("sCustSid"));	// CUST_SID		
		//StringUtil.printMsg("��ǰ--- ", sGoods_sid,this);
		
		if (iParamIp.length() > 13) {
			 iParamIp = iParamIp.substring(0,13);	
		}
		
		try {
			cstmt = conn.prepareCall(arr_sql[2].toString());
			cstmt.setInt(1, sCustSid);
					
			// ��������
			cstmt.executeUpdate();
			if(cstmt!=null) cstmt.close();	
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