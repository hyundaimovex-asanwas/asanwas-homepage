package omsm.al;
/***********************************************************************
 * 	OMS FAQ 팝업상세
************************************************************************/

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

import omsm.common.HDUtil;
import omsm.common.StringUtil;
import omsm.common.SuperServlet;

public class m_al0020_s3 extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		    arr_sql[1].append ("  INSERT INTO OMS.T_AL0020 (  \n");
			arr_sql[1].append ("   AL_SID,AL_SEQ,INOUT_DATE,LOGIS_GB,INOUT_GB,        \n");
			arr_sql[1].append ("   ITEM_NAME,CAR_KIND,CAR_NO,DRV_ID,WEIGHT,           \n");
			arr_sql[1].append ("   START_ADDR,END_ADDR,OUT_TIME,IN_TIME,REMARK,       \n");
			arr_sql[1].append ("   STATUS,ORDER_SID,ORDER_SEQ,SHIP_COMPANY,SHIP_CRNO, \n");
			arr_sql[1].append ("   WORK_CD,AL_YN,           \n");
			arr_sql[1].append ("   CREATE_ID, CREATE_DATE   \n");
			arr_sql[1].append ("  ) VALUES (  \n");
			arr_sql[1].append ("   ?,?,?,?,?, \n");
			arr_sql[1].append ("   ?,?,?,?,?, \n");
			arr_sql[1].append ("   ?,?,?,?,?, \n");
			arr_sql[1].append ("   ?,?,?,?,?, \n");
			arr_sql[1].append ("   ?,?,  \n");
			arr_sql[1].append ("   ?,  CURRENT_TIMESTAMP    \n");
			arr_sql[1].append ("  )     \n");
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		
	}
	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	
		
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		conn.setAutoCommit(false);
			
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		
		String iParamEmpno 	= fParamEmpno;
		String iParamIp 	= fParamIp;
					
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
		GauceDataSet ds1 = gis.read("DS_DEFAULT");  //배차관리
		
		Statement stmt1 = null;
		ResultSet rs1 = null;
		
		String strUser_id	= HDUtil.nullCheckStr(greq.getParameter("v_user_id"));
			
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
					
				int colNm_AL_SID                     = ds1.indexOfColumn("AL_SID"); 	
				int colNm_AL_SEQ                     = ds1.indexOfColumn("AL_SEQ"); 	
				int colNm_INOUT_DATE                 = ds1.indexOfColumn("INOUT_DATE"); 	
				int colNm_LOGIS_GB                   = ds1.indexOfColumn("LOGIS_GB"); 	
				int colNm_INOUT_GB                   = ds1.indexOfColumn("INOUT_GB"); 	
				int colNm_ITEM_NAME                  = ds1.indexOfColumn("ITEM_NAME"); 	
				int colNm_CAR_KIND                   = ds1.indexOfColumn("CAR_KIND"); 	
				int colNm_CAR_NO                     = ds1.indexOfColumn("CAR_NO"); 	
				int colNm_DRV_ID                     = ds1.indexOfColumn("DRV_ID"); 	
				int colNm_WEIGHT                     = ds1.indexOfColumn("WEIGHT"); 	
				int colNm_START_ADDR                 = ds1.indexOfColumn("START_ADDR"); 	
				int colNm_END_ADDR                   = ds1.indexOfColumn("END_ADDR"); 	
				int colNm_OUT_TIME                   = ds1.indexOfColumn("OUT_TIME"); 	
				int colNm_IN_TIME                    = ds1.indexOfColumn("IN_TIME"); 	
				int colNm_REMARK                     = ds1.indexOfColumn("REMARK"); 	
				int colNm_STATUS                     = ds1.indexOfColumn("STATUS"); 	
				int colNm_ORDER_SID                  = ds1.indexOfColumn("ORDER_SID"); 	
				int colNm_ORDER_SEQ                  = ds1.indexOfColumn("ORDER_SEQ"); 	
				int colNm_SHIP_COMPANY               = ds1.indexOfColumn("SHIP_COMPANY"); 	
				int colNm_SHIP_CRNO                  = ds1.indexOfColumn("SHIP_CRNO"); 	
				int colNm_WORK_CD                    = ds1.indexOfColumn("WORK_CD"); 	
				int colNm_AL_YN                      = ds1.indexOfColumn("AL_YN");
				int colNm_CREATE_ID                  = ds1.indexOfColumn("CREATE_ID"); 	
				int colNm_CREATE_DATE                = ds1.indexOfColumn("CREATE_DATE"); 	
				int colNm_UPDATE_ID                  = ds1.indexOfColumn("UPDATE_ID"); 	
				int colNm_UPDATE_DATE                = ds1.indexOfColumn("UPDATE_DATE"); 	
				
				
				
				for(int i=0; i<rows.length; i++){
					//int j=1;
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							
							cstmt = conn.prepareCall(arr_sql[1].toString());
							
							cstmt.setString(1, rows[i].getString(colNm_AL_SID));
							cstmt.setInt(2, rows[i].getInt(colNm_AL_SEQ));
							cstmt.setString(3, rows[i].getString(colNm_INOUT_DATE));
							cstmt.setString(4, rows[i].getString(colNm_LOGIS_GB));
							cstmt.setString(5, rows[i].getString(colNm_INOUT_GB));
							cstmt.setString(6, rows[i].getString(colNm_ITEM_NAME));
							cstmt.setString(7, rows[i].getString(colNm_CAR_KIND));
							cstmt.setString(8, rows[i].getString(colNm_CAR_NO));
							cstmt.setString(9, rows[i].getString(colNm_DRV_ID));
							cstmt.setString(10, rows[i].getString(colNm_WEIGHT));
							cstmt.setString(11, rows[i].getString(colNm_START_ADDR));
							cstmt.setString(12, rows[i].getString(colNm_END_ADDR));
							cstmt.setString(13, rows[i].getString(colNm_OUT_TIME));
							cstmt.setString(14, rows[i].getString(colNm_IN_TIME));
							cstmt.setString(15, rows[i].getString(colNm_REMARK));
							cstmt.setString(16, rows[i].getString(colNm_STATUS));
							cstmt.setString(17, rows[i].getString(colNm_ORDER_SID));
							cstmt.setInt(18, rows[i].getInt(colNm_ORDER_SEQ));
							cstmt.setString(19, rows[i].getString(colNm_SHIP_COMPANY));
							cstmt.setString(20, rows[i].getString(colNm_SHIP_CRNO));
							cstmt.setString(21, rows[i].getString(colNm_WORK_CD));
							cstmt.setString(22, rows[i].getString(colNm_AL_YN));
							cstmt.setString(23, strUser_id);
							
							cstmt.executeUpdate();
														
							if(cstmt!=null) cstmt.close();		
						
							break;
							
						case GauceDataRow.TB_JOB_UPDATE:
																
														
						
							break;
						case GauceDataRow.TB_JOB_DELETE:
							/*
							cstmt = conn.prepareCall(arr_sql[3].toString());
		
							cstmt.setString(1,rows[i].getString(colNm_DRV_ID));	
							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();
							*/
							break;
					}//switch(rows[i].getJobType()){
				}//for
			}//if (ds1 != null) {
			
				
			gos.close();	
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			conn.rollback();
			throw e;
		} finally {			
			//msgDS.flush();
			if(rs!=null) rs.close();
//				if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
			//if( fail == true ) throw new Exception("");			
		}
		
	}
			
	// 조회 method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		
	}
}
