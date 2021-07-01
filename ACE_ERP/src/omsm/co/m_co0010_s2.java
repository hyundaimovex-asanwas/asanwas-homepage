package omsm.co;
/***********************************************************************
 * 	OMS 공지사항
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

public class m_co0010_s2 extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		    arr_sql[0].append (" SELECT WORK_CD, CUR_DATE, CUR_DAY, HOL_YN, INOUT_DATE, HOL_GB, REMARK, STAR_CHK  \n");
		    arr_sql[0].append ("   FROM OMS.T_CO0010    \n");
		    arr_sql[0].append ("  WHERE WORK_CD = ?     \n");	
		    arr_sql[0].append ("    AND CUR_DATE LIKE ? \n");	
		    arr_sql[0].append ("  ORDER BY CUR_DATE     \n");	
		    
		    arr_sql[1].append (" INSERT INTO OMS.T_CO0010 (    \n");
		    arr_sql[1].append ("  WORK_CD,CUR_DATE,CUR_DAY,HOL_YN,INOUT_DATE,   \n");
		    arr_sql[1].append ("  HOL_GB,REMARK, STAR_CHK,  \n");
		    arr_sql[1].append ("  CREATE_ID,CREATE_DATE,UPDATE_ID,UPDATE_DATE   \n");
		    arr_sql[1].append ("  ) VALUES (    \n");	
		    arr_sql[1].append ("  ?,?,?,?,?, \n");	
		    arr_sql[1].append ("  ?,?,       \n");	
		    arr_sql[1].append ("  ?,CURRENT_TIMESTAMP,?,CURRENT_TIMESTAMP       \n");
		    
		    //UPDATE
			arr_sql[2].append ("  UPDATE OMS.T_CO0010 SET  \n");
			arr_sql[2].append ("  HOL_YN=?     \n");
			arr_sql[2].append (" ,INOUT_DATE=? \n");
			arr_sql[2].append (" ,HOL_GB=?     \n");
			arr_sql[2].append (" ,REMARK=?     \n");
			arr_sql[2].append (" ,STAR_CHK=?     \n");
			arr_sql[2].append (" ,UPDATE_ID=?  \n");
			arr_sql[2].append (" ,UPDATE_DATE=CURRENT_TIMESTAMP \n");
			arr_sql[2].append ("  WHERE WORK_CD =?  \n");
			arr_sql[2].append ("    AND CUR_DATE=? \n");
						
			//DELETE
			arr_sql[3].append (" DELETE FROM OMS.T_CO0010  \n");
			arr_sql[3].append ("  WHERE WORK_CD =? \n");
			arr_sql[3].append ("    AND CUR_DATE=? \n");
		    
 	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		
	}
	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		CallableStatement cstmt = null;	
		ResultSet 		  rs	= null;
		
		conn.setAutoCommit(false);
			
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		
		String iParamEmpno 	= fParamEmpno;
		String iParamIp 	= fParamIp;
					
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
		GauceDataSet ds1 = gis.read("DS_DEFAULT");
		
		String strUserid = HDUtil.nullCheckStr(greq.getParameter("v_user_id"));
		
		int colNm_WORK_CD                = ds1.indexOfColumn("WORK_CD");
		int colNm_CUR_DATE               = ds1.indexOfColumn("CUR_DATE");
		int colNm_CUR_DAY                = ds1.indexOfColumn("CUR_DAY");
		int colNm_HOL_YN                 = ds1.indexOfColumn("HOL_YN");
		int colNm_INOUT_DATE             = ds1.indexOfColumn("INOUT_DATE");
		int colNm_HOL_GB                 = ds1.indexOfColumn("HOL_GB");
		int colNm_REMARK                 = ds1.indexOfColumn("REMARK");
		int colNm_STAR_CHK                 = ds1.indexOfColumn("STAR_CHK");
		int colNm_CREATE_ID              = ds1.indexOfColumn("CREATE_ID");
		int colNm_CREATE_DATE            = ds1.indexOfColumn("CREATE_DATE");
		int colNm_UPDATE_ID              = ds1.indexOfColumn("UPDATE_ID");
		int colNm_UPDATE_DATE            = ds1.indexOfColumn("UPDATE_DATE");
		
		Statement stmt1 = null;
		ResultSet rs1 = null;
		
		//TRY
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				for(int i=0; i<rows.length; i++){
					//int j=1;
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							cstmt = conn.prepareCall(arr_sql[1].toString());
							
							cstmt.setString(1,  rows[i].getString(colNm_WORK_CD));
							cstmt.setString(2,  rows[i].getString(colNm_CUR_DATE));
							cstmt.setString(3,  rows[i].getString(colNm_CUR_DAY));
							cstmt.setString(4,  rows[i].getString(colNm_HOL_YN));
							cstmt.setString(5,  rows[i].getString(colNm_INOUT_DATE));
							cstmt.setString(6,  rows[i].getString(colNm_HOL_GB));
							cstmt.setString(7,  rows[i].getString(colNm_REMARK));
							cstmt.setString(8,  rows[i].getString(colNm_STAR_CHK));
							cstmt.setString(9,  strUserid);
							cstmt.setString(10, strUserid);
							
							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();		
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							
							
							cstmt = conn.prepareCall(arr_sql[2].toString());
							
							cstmt.setString(1, rows[i].getString(colNm_HOL_YN));
							cstmt.setString(2, rows[i].getString(colNm_INOUT_DATE));
							cstmt.setString(3, rows[i].getString(colNm_HOL_GB));
							cstmt.setString(4, rows[i].getString(colNm_REMARK));
							cstmt.setString(5, rows[i].getString(colNm_STAR_CHK));
							cstmt.setString(6, strUserid);
							cstmt.setString(7, rows[i].getString(colNm_WORK_CD));
							cstmt.setString(8, rows[i].getString(colNm_CUR_DATE));
							
							cstmt.executeUpdate();
							if(cstmt!=null) cstmt.close();	
							break;
							
						case GauceDataRow.TB_JOB_DELETE:
							
							
							cstmt = conn.prepareCall(arr_sql[3].toString());
		
							cstmt.setString(1,rows[i].getString(colNm_WORK_CD));
							cstmt.setString(2,rows[i].getString(colNm_CUR_DATE));
							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();	
							break;
							
					}//switch(rows[i].getJobType()){
				}
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
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		/* DataSet */
		GauceDataSet ds1 = null;
		
		try {
			GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
			
			// DataSet 생성 			
			ds1 = new GauceDataSet(); 
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * Parameter 설정
			 * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다  
			 **********************************************************************************/
			int dsType 				= HDUtil.nullCheckNum(greq.getParameter("dsType"));
			String v_keyword		= HDUtil.nullCheckStr(greq.getParameter("v_keyword"));
			String v_parm1	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm1"));
					
			//System.out.println("v_keyword::"+v_keyword);
			//System.out.println("v_parm1::"+v_parm1);
			//System.out.println("arr_sql[0].toString()::"+arr_sql[0].toString());
			switch(dsType) {
				case 1: //detail이 공백이 아닌 공통코드 검색
				    // 쿼리 실행
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, v_keyword);			
					cstmt.setString(2,"%"+v_parm1+"%");
					rs = cstmt.executeQuery();     //DataSet set
					gos.write(getDataSet(rs, ds1));
					break;
			}
		} catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e){
			gres.addException(e);
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
}
