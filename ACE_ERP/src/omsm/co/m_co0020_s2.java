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

public class m_co0020_s2 extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		    arr_sql[0].append (" SELECT HEAD_CD,DETAIL_CD,DETAIL_NAME,PRT_SEQ,USE_GB,  \n");
		    arr_sql[0].append ("         ITEM1,ITEM2,ITEM3,ITEM4,ITEM5,REMARK, \n");
		    arr_sql[0].append ("         CREATE_ID,CREATE_DATE,UPDATE_ID,UPDATE_DATE \n");
		    arr_sql[0].append ("   FROM OMS.T_CO0030 \n");
		    arr_sql[0].append ("  WHERE HEAD_CD = ?  \n");
		    
		    arr_sql[1].append (" INSERT INTO OMS.T_CO0030 (  \n");
		    arr_sql[1].append ("        HEAD_CD,DETAIL_CD,DETAIL_NAME,PRT_SEQ,USE_GB,  \n");
		    arr_sql[1].append ("        ITEM1,ITEM2,ITEM3,ITEM4,ITEM5,REMARK,          \n");
		    arr_sql[1].append ("        CREATE_ID,CREATE_DATE,UPDATE_ID,UPDATE_DATE    \n");
		    arr_sql[1].append (" ) VALUES (                                            \n");
		    arr_sql[1].append (" ?,?,?,?,?,  \n");
		    arr_sql[1].append (" ?,?,?,?,?,?, \n");
		    arr_sql[1].append (" ?,CURRENT_TIMESTAMP,?,CURRENT_TIMESTAMP  \n");
		    arr_sql[1].append (" )\n");
		    
		    arr_sql[2].append (" UPDATE OMS.T_CO0030 SET  \n");
		    arr_sql[2].append ("  DETAIL_NAME = ?         \n");
		    arr_sql[2].append (" ,PRT_SEQ = ?             \n");
		    arr_sql[2].append (" ,USE_GB = ?              \n");
		    arr_sql[2].append (" ,ITEM1 = ?               \n");
		    arr_sql[2].append (" ,ITEM2 = ?               \n");
		    arr_sql[2].append (" ,ITEM3 = ?               \n");
		    arr_sql[2].append (" ,ITEM4 = ?               \n");
		    arr_sql[2].append (" ,ITEM5 = ?               \n");
		    arr_sql[2].append (" ,REMARK = ?              \n");
		    arr_sql[2].append (" ,UPDATE_ID = ?           \n");
		    arr_sql[2].append (" ,UPDATE_DATE=CURRENT_TIMESTAMP  \n");
		    arr_sql[2].append ("   WHERE HEAD_CD = ?      \n");
		    arr_sql[2].append ("     AND DETAIL_CD = ?    \n");
		    
		    arr_sql[3].append (" DELETE FROM OMS.T_CO0030 \n");
		    arr_sql[3].append ("  WHERE HEAD_CD = ?       \n");
		    arr_sql[3].append ("    AND DETAIL_CD = ?     \n");
		    
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
		
		int colNm_HEAD_CD               = ds1.indexOfColumn("HEAD_CD");
		int colNm_DETAIL_CD             = ds1.indexOfColumn("DETAIL_CD");
		int colNm_DETAIL_NAME           = ds1.indexOfColumn("DETAIL_NAME");
		int colNm_PRT_SEQ               = ds1.indexOfColumn("PRT_SEQ");
		int colNm_USE_GB                = ds1.indexOfColumn("USE_GB");
		int colNm_ITEM1                 = ds1.indexOfColumn("ITEM1");
		int colNm_ITEM2                 = ds1.indexOfColumn("ITEM2");
		int colNm_ITEM3                 = ds1.indexOfColumn("ITEM3");
		int colNm_ITEM4                 = ds1.indexOfColumn("ITEM4");
		int colNm_ITEM5                 = ds1.indexOfColumn("ITEM5");
		int colNm_REMARK                = ds1.indexOfColumn("REMARK");
		int colNm_CREATE_ID             = ds1.indexOfColumn("CREATE_ID");
		int colNm_UPDATE_ID             = ds1.indexOfColumn("UPDATE_ID");
		
		Statement stmt1 = null;
		ResultSet rs1 = null;
		
		//TRY
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				for(int i=0; i<rows.length; i++){
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							
							//System.out.println("arr_sql[1].toString()"+arr_sql[1].toString());
							cstmt = conn.prepareCall(arr_sql[1].toString());
							
							cstmt.setString(1,  rows[i].getString(colNm_HEAD_CD));
							cstmt.setString(2,  rows[i].getString(colNm_DETAIL_CD));
							cstmt.setString(3,  rows[i].getString(colNm_DETAIL_NAME));
							cstmt.setInt(4,     rows[i].getInt(colNm_PRT_SEQ));
							cstmt.setString(5,  rows[i].getString(colNm_USE_GB));
							cstmt.setString(6,  rows[i].getString(colNm_ITEM1));
							cstmt.setString(7,  rows[i].getString(colNm_ITEM2));
							cstmt.setString(8,  rows[i].getString(colNm_ITEM3));
							cstmt.setString(9,  rows[i].getString(colNm_ITEM4));
							cstmt.setString(10, rows[i].getString(colNm_ITEM5));
							cstmt.setString(11, rows[i].getString(colNm_REMARK));
							cstmt.setString(12, strUserid);
							cstmt.setString(13, strUserid);
														
							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();		
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							cstmt = conn.prepareCall(arr_sql[2].toString());
							cstmt.setString(1,  rows[i].getString(colNm_DETAIL_NAME));
							cstmt.setInt(2,     rows[i].getInt(colNm_PRT_SEQ));
							cstmt.setString(3,  rows[i].getString(colNm_USE_GB));
							cstmt.setString(4,  rows[i].getString(colNm_ITEM1));
							cstmt.setString(5,  rows[i].getString(colNm_ITEM2));
							cstmt.setString(6,  rows[i].getString(colNm_ITEM3));
							cstmt.setString(7,  rows[i].getString(colNm_ITEM4));
							cstmt.setString(8,  rows[i].getString(colNm_ITEM5));
							cstmt.setString(9,  rows[i].getString(colNm_REMARK));
							cstmt.setString(10, strUserid);
							cstmt.setString(11, rows[i].getString(colNm_HEAD_CD));
							cstmt.setString(12, rows[i].getString(colNm_DETAIL_CD));

							
							cstmt.executeUpdate();
														
							if(cstmt!=null) cstmt.close();	
							break;
							
						case GauceDataRow.TB_JOB_DELETE:
							cstmt = conn.prepareCall(arr_sql[3].toString());
							
							//System.out.println("arr_sql[3].toString()"+arr_sql[3].toString());
							
							cstmt.setString(1, rows[i].getString(colNm_HEAD_CD));
							cstmt.setString(2, rows[i].getString(colNm_DETAIL_CD));
							
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
			
			arr_sql[0].append ("   ORDER BY PRT_SEQ \n");
			switch(dsType) {
				case 1: //detail이 공백이 아닌 공통코드 검색
				
					//System.out.println("arr_sql[0]::"+arr_sql[0].toString());
					// 쿼리 실행
					cstmt = conn.prepareCall(arr_sql[0].toString());	
					
					cstmt.setString(1,  v_keyword);
										
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
