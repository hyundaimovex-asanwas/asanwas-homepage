package sales.menu.cu;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.*;
import java.sql.*;
import java.io.*;
import java.sql.CallableStatement;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;
 
import oracle.jdbc.OracleTypes;

public class Cu090I extends SuperServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String SAVE_FILE  = HDConstant.FILE_UPLOAD_PATH_CAR;
	String SAVE_FILE2 = HDConstant.FILE_UPLOAD_PATH_CAR_INS;
	public void makeSql() {
		// ��ȸ
		arr_sql[0].append ("CALL SALES.PR_CU090I_01(?,?,  ?)");	// ��ȸ

		// ����
		arr_sql[1].append ("{call SALES.PR_CU090I_02(?,?,?,?,?,   ?,?,?,?,?,   ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?)} ");
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataSet */
		ResultSet rs = null;
		CallableStatement cstmt = null;
		
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
		    //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
		    GauceDataSet[] dSets = gis.readAllOutput(); 
		    //StringUtil.printMsg("DS TYPE","����ȸ",this);
		    for(int i=0; i<dSets.length;i++){
		   		if(dSets[i].getName().equals("ds1")){//
		    		GauceDataSet ds1 = gis.read("DEFAULT");
		    		cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, "");
					cstmt.setString(2,"11111212" );

					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 					
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

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		
		int v_rowcnt = 0;
		
		// �˻��� ����
		String  sClientCd	= HDUtil.nullCheckStr(greq.getParameter("sClientCd")); 	// ����ó
		String  sCarNo		= HDUtil.nullCheckStr(greq.getParameter("sCarNo")); 		// ������Ϲ�ȣ

		//StringUtil.printMsg("sClientCd", sClientCd, this);
		//StringUtil.printMsg("sCarNo", sCarNo, this);

		// dataset ���� param
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		
		try{
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				if(dSets[i].getName().equals("ds1")){// || dSets[i].getName().equals("imgDs")){
		    		GauceDataSet ds1 = gis.read("DEFAULT");
		    		cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, sClientCd);
					cstmt.setString(2, sCarNo );

					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 					
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

	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		//StringUtil.printMsg("# Command","����",this);
		CallableStatement cstmt = null;	
		ResultSet 		rs 			= null;
				
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
						
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		
		/* DataSet */
		GauceDataSet inputDs = gis.read("REGIST");
		
		try{
			if(inputDs!=null){
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();

				int colNm_CAR_SID	  = inputDs.indexOfColumn("CAR_SID");	// ������Ϲ�ȣ
				int colNm_CAR_NO	  = inputDs.indexOfColumn("CAR_NO");	// ������Ϲ�ȣ
				int colNm_CAR_TYPE 	  = inputDs.indexOfColumn("CAR_TYPE"); 	// ����
				int colNm_CAR_NM 	  = inputDs.indexOfColumn("CAR_NM"); 	// ����
				int colNm_CAR_FORM 	  = inputDs.indexOfColumn("CAR_FORM"); 	// ����
				int colNm_CAR_YEAR 	  = inputDs.indexOfColumn("CAR_YEAR"); 	// ����
				int colNm_CAR_CC 	  = inputDs.indexOfColumn("CAR_CC"); 	// ��ⷮ
				int colNm_CAR_PERSONS = inputDs.indexOfColumn("CAR_PERSONS");	// �����ο�
				int colNm_MAX_KG 	  = inputDs.indexOfColumn("MAX_KG"); 	// �ִ����緮
				int colNm_CAR_TYPE_CD = inputDs.indexOfColumn("CAR_TYPE_CD"); 	// �����ڵ�
				int colNm_CAR_DNO	  = inputDs.indexOfColumn("CAR_DNO");	// �����ȣ
				int colNm_NORTH_YN 	  = inputDs.indexOfColumn("NORTH_YN"); 	// ���ʹ�Ͽ���
				int colNm_NORTH_DATE  = inputDs.indexOfColumn("NORTH_DATE"); 	// ���ʹ湮������
				
				int colNm_TT_CAR_TYPE = inputDs.indexOfColumn("TT_CAR_TYPE"); 	// 
				int colNm_RATE_TT_CAR_KG 	  = inputDs.indexOfColumn("RATE_TT_CAR_KG"); 	//
				int colNm_TT_BGNDATE 	  = inputDs.indexOfColumn("TT_BGNDATE"); 	//
				int colNm_TT_ENDDATE 	  = inputDs.indexOfColumn("TT_ENDDATE"); 	//
				int colNm_TT_CLIENT_SID 	  = inputDs.indexOfColumn("TT_CLIENT_SID"); 	//
				int colNm_TT_GUBN 	  = inputDs.indexOfColumn("TT_GUBN"); 	//
				int colNm_TT_COUNT 	  = inputDs.indexOfColumn("TT_COUNT"); 	//
				int colNm_TT_USE 	  = inputDs.indexOfColumn("TT_USE"); 	//
				int colNm_TT_START 	  = inputDs.indexOfColumn("TT_START"); 	//
				int colNm_TT_SITE 	  = inputDs.indexOfColumn("TT_SITE"); 	//
				int colNm_TT_ISSUE 	  = inputDs.indexOfColumn("TT_ISSUE"); 	//
				int colNm_CLIENT_SID  = inputDs.indexOfColumn("CLIENT_SID"); 	// ���»�sid
				int colNm_TT_CF_BGNDATE 	  = inputDs.indexOfColumn("TT_CF_BGNDATE"); 	//
				int colNm_TT_CF_ENDDATE 	  = inputDs.indexOfColumn("TT_CF_ENDDATE"); 	//

				for(int i=0; i<rows.length; i++){

					//StringUtil.printMsg("INSERT",this);
					//�����߷� �� : �Ҽ��� ó��
						//StringUtil.printMsg("colNm_RATE_TT_CAR_KG", rows[i].getDouble(colNm_RATE_TT_CAR_KG)+"", this);
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt(1, rows[i].getInt(colNm_CAR_SID));
					cstmt.setString(2, rows[i].getString(colNm_CAR_NO));
					cstmt.setString(3, rows[i].getString(colNm_CAR_TYPE));
					cstmt.setString(4, rows[i].getString(colNm_CAR_NM));
					cstmt.setString(5, rows[i].getString(colNm_CAR_FORM));
					cstmt.setString(6, rows[i].getString(colNm_CAR_YEAR));
					cstmt.setInt(7, rows[i].getInt(colNm_CAR_CC));
					cstmt.setInt(8, rows[i].getInt(colNm_CAR_PERSONS));
					cstmt.setInt(9, 0);
					cstmt.setString(10, "4");
					cstmt.setString(11, rows[i].getString(colNm_CAR_DNO));
					cstmt.setString(12, rows[i].getString(colNm_NORTH_YN));
					cstmt.setString(13, rows[i].getString(colNm_NORTH_DATE));
					
					cstmt.setString(14, rows[i].getString(colNm_TT_CAR_TYPE));
					cstmt.setDouble(15, rows[i].getDouble(colNm_RATE_TT_CAR_KG));
					cstmt.setString(16, rows[i].getString(colNm_TT_BGNDATE));
					cstmt.setString(17, rows[i].getString(colNm_TT_ENDDATE));
					cstmt.setInt(18, rows[i].getInt(colNm_TT_CLIENT_SID));
					cstmt.setString(19, rows[i].getString(colNm_TT_GUBN));
					cstmt.setString(20, rows[i].getString(colNm_TT_COUNT));
					cstmt.setString(21, rows[i].getString(colNm_TT_USE));
					cstmt.setString(22, rows[i].getString(colNm_TT_START));
					cstmt.setString(23, rows[i].getString(colNm_TT_SITE));
					cstmt.setString(24, rows[i].getString(colNm_TT_ISSUE));
					cstmt.setString(25, rows[i].getString(colNm_TT_CF_BGNDATE));
					cstmt.setString(26, rows[i].getString(colNm_TT_CF_ENDDATE));
					
					cstmt.setInt(27, rows[i].getInt(colNm_CLIENT_SID));
					cstmt.setString(28, fParamEmpno);
					cstmt.setInt(29, rows[i].getJobType() );	//���콺�� �۾� ��
					// ��������
					cstmt.executeUpdate();
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
			if(cstmt!=null) cstmt.close();
		//if( fail == true ) throw new Exception("");			
		}
	}
}
