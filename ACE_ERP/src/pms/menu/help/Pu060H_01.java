package pms.menu.help;
/**********************************************************************************
 * ȯ��ó���� �˾� 
 **********************************************************************************/
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceStatement;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

import sales.common.HDUtil;
import sales.common.StringUtil;
import pms.common.SuperServlet;
import java.sql.Connection; 
import oracle.jdbc.OracleTypes;
  
public class Pu060H_01 extends SuperServlet {
	                                       
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL PMS.PR_PU060H_01(?,?,?)"); // ��ȸ1
		
		arr_sql[2].append("{CALL PMS.PR_PU060H_03(?,?,?,?,?,             ?,?,?,?,?,         ?,?,?) }");	// ����
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}

	// ��ȸ method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		/* DataSet */
		GauceDataSet ds1 = null; //  
		
		/*
		 * �˻��� �ʿ��� ����
		 */
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		int v_est_sid 			= HDUtil.nullCheckNum(greq.getParameter("sest_sid"));			// ���� SID
		String v_vend_cd 	= HDUtil.nullCheckStr(greq.getParameter("svend_cd")); 			// �ŷ�ó�ڵ�
		
		try {
			
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ

			// DataSet ���� 			
			ds1 = new GauceDataSet();  
			
				switch(dsType){
					case 1:
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1,v_est_sid);
					  	cstmt.setString(2,v_vend_cd);
					  	cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 			
						gos.write(getDataSet(rs, ds1));
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
		
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 		rs 			= null;
				
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
						
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();	
		/* DataSet */
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			int v_est_sid 		= HDUtil.nullCheckNum(greq.getParameter("sest_sid"));			// ���� SID
			String v_vend_cd 	= HDUtil.nullCheckStr(greq.getParameter("svend_cd")); 			// �ŷ�ó�ڵ�
		
			/* DataSet */
			GauceDataSet ds1 = gis.read("DEFAULT");

			/** 
			 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
			 **/
			
		try {
			if(ds1!=null){
				int colNm_ITEM_SID            	= ds1.indexOfColumn("ITEM_SID");               	//ǰ��SID
				int colNm_ITEM_SEQ            	= ds1.indexOfColumn("ITEM_SEQ");               	//ǰ��SEQ
				int colNm_ITEM_NM             	= ds1.indexOfColumn("ITEM_NM");              		// ǰ���
				int colNm_ITEM_SIZE           	= ds1.indexOfColumn("ITEM_SIZE");             	// �԰�
				int colNm_ITEM_UNIT           	= ds1.indexOfColumn("ITEM_UNIT");             	// ���� 
				int colNm_EST_ITEM_CNT 			= ds1.indexOfColumn("EST_ITEM_CNT");		     	// ����
				int colNm_EST_AMT             	= ds1.indexOfColumn("EST_AMT");             		// �ܰ�
				int colNm_SUM_AMT            	= ds1.indexOfColumn("SUM_AMT");             	// �ܰ�*����
		
				GauceDataRow[] 	 	    rows = ds1.getDataRows();
				GauceDataColumn[]  		cols = ds1.getDataColumns();
				
				for(int i=0; i<rows.length; i++){
					//StringUtil.printMsg("rows[i].getJobType()====",rows[i].getJobType(),this);
					//�̰� ������ 3(������Ʈ) �� ��.
					
					cstmt = conn.prepareCall(arr_sql[2].toString());

					cstmt.setInt(1, v_est_sid);
					//StringUtil.printMsg("1", v_est_sid, this);
					cstmt.setInt(2, rows[i].getInt(colNm_ITEM_SID));
					//StringUtil.printMsg("2", rows[i].getInt(colNm_ITEM_SID), this);
					cstmt.setInt(3, rows[i].getInt(colNm_ITEM_SEQ));
					//StringUtil.printMsg("3", rows[i].getInt(colNm_ITEM_SEQ), this);
					cstmt.setString(4, v_vend_cd );	
					//StringUtil.printMsg("4",v_vend_cd , this);								
					cstmt.setString(5, rows[i].getString(colNm_ITEM_NM));
					//StringUtil.printMsg("5",rows[i].getString(colNm_ITEM_NM) , this);
					//StringUtil.printMsg("6",rows[i].getString(colNm_ITEM_SIZE) , this);			
					cstmt.setString(6, rows[i].getString(colNm_ITEM_SIZE));						
					//StringUtil.printMsg("7",rows[i].getString(colNm_ITEM_UNIT) , this);
					cstmt.setString(7, rows[i].getString(colNm_ITEM_UNIT));
					
					cstmt.setInt(8, rows[i].getInt(colNm_EST_ITEM_CNT));
					//StringUtil.printMsg("8", rows[i].getInt(colNm_EST_ITEM_CNT), this);
					cstmt.setLong(9, rows[i].getLong(colNm_EST_AMT));
					//StringUtil.printMsg("9", rows[i].getInt(colNm_EST_AMT), this);
					cstmt.setLong(10, rows[i].getLong(colNm_SUM_AMT));
					cstmt.setString(11, iParamEmpno);
					cstmt.setString(12, iParamIp);
					cstmt.setString(13, "3");

					cstmt.executeUpdate();
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