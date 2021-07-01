package sales.menu.help;
/**********************************************************************************
 * ���ڰ��� - ���� ��û 
 **********************************************************************************/

import java.io.File;
import java.sql.*;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.StringUtil;
import sales.common.SuperServlet;
import sales.common.HDConstant;
import sales.common.HDUtil;

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

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import java.sql.Connection; 
import oracle.jdbc.OracleTypes;

public class My400H extends SuperServlet {
	   
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		// ���� ������ ���� ��ȸ	
		arr_sql[0].append ("{call SALES.PR_MY400H_01(?,?) }");

		// ���� ������ ���� ��ȸ	
		arr_sql[1].append ("{call SALES.PR_MY400H_02(?,?) }");	//
		
		// ���缱 ���� ��ȸ	
		arr_sql[2].append ("{call COMMON.PR_AP001S_01(?,?,?) }");	//COMMON.PR_AP001S_01(1,'1');
		
		// ���� ����	
		arr_sql[3].append ("{call SALES.PR_MY400I_02(?,?,?,?,?,    ?,?,?) }");
				
    }
	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}
	// ��ȸ method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		/* DataSet */
		GauceDataSet ds_master = null;
		GauceDataSet ds_detail = null;
		GauceDataSet ds_line = null;
		
		// �˻��� ����
		int s_ap_m_sid			= HDUtil.nullCheckNum(greq.getParameter("s_ap_m_sid"));
		String s_ap_gu			= HDUtil.nullCheckStr(greq.getParameter("s_ap_gu"));
		
		try{
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
			GauceDataSet[] dSets = gis.readAllOutput();
			
			for(int i=0; i<dSets.length;i++){
				if(dSets[i].getName().equals("ds_default2")){
					GauceDataSet ds1 = gis.read("AP_LINE_DS");
					cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setInt(1, s_ap_m_sid);
						cstmt.setString(2, s_ap_gu);
						cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 			
					gos.write(getDataSet(rs, ds1));
				}
				if(dSets[i].getName().equals("ds_master")){
					GauceDataSet ds1 = gis.read("AP_MASTER_DS");
					cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setInt(1, s_ap_m_sid);
						cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 			
					gos.write(getDataSet(rs, ds1));
				}
				if(dSets[i].getName().equals("ds_detail")){
					GauceDataSet ds1 = gis.read("AP_DETAIL_DS");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt(1, s_ap_m_sid);
						cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 			
						gos.write(getDataSet(rs, ds1));
						rs = cstmt.executeQuery(); // DataSet set
					getDataSet(rs, ds_detail).flush();
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

	
	//	���� method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 		rs 			= null;
				
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
						
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		
		/* DataSet */
		GauceDataSet ds1 = gis.read("AP_LINE_DS");
		GauceDataSet msgDS = gis.read("msgDS");
		try{
			  if (ds1 != null) {
				  GauceDataRow[] 	    rows = ds1.getDataRows();
				  GauceDataColumn[] 	cols = ds1.getDataColumns();
				  
					int s_ap_m_sid	= HDUtil.nullCheckNum(greq.getParameter("s_ap_m_sid"));
					String s_empnmk	= "";
					/*
					StringUtil.printMsg("s_ap_m_sid",s_ap_m_sid,this);
					StringUtil.printMsg("s_empnmk",s_empnmk,this);
					StringUtil.printMsg("fParamEmpno",fParamEmpno,this);
					StringUtil.printMsg("iParamEmpno",iParamEmpno,this);
					StringUtil.printMsg("iParamIp",iParamIp,this);
					*/
					  cstmt = conn.prepareCall(arr_sql[3].toString());
					  cstmt.setInt(1, s_ap_m_sid);
  					  cstmt.setString(2, s_empnmk);
					  cstmt.setString(3, fParamEmpno);
					  cstmt.setString(4, iParamEmpno);
					  cstmt.setString(5, iParamIp);
					  cstmt.registerOutParameter(6,  java.sql.Types.VARCHAR);
					  cstmt.registerOutParameter(7,  java.sql.Types.VARCHAR);
					  cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);

					  cstmt.executeUpdate();
	
					  //�޽���ó��
					  if (cstmt.getString(6).equals("Y") ) {
						 if ( !cstmt.getString(7).equals("0000") ) {
							GauceDataRow row2 = msgDS.newDataRow();
							row2.addColumnValue(cstmt.getString(8));
							msgDS.addDataRow(row2);
						 }
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
			if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
		//if( fail == true ) throw new Exception("");			
		}
	}
}