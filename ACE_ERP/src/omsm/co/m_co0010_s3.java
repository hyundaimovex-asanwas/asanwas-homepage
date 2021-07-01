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

public class m_co0010_s3 extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		    arr_sql[0].append (" SELECT COUNT(*) CNT  \n");
		    arr_sql[0].append ("   FROM OMS.T_CO0010\n");
		    arr_sql[0].append ("  WHERE WORK_CD = ?\n");
		    arr_sql[0].append ("    AND CUR_DATE LIKE ? \n");
		    		
			arr_sql[1].append (" INSERT INTO OMS.T_CO0010                                                                              \n");
			arr_sql[1].append (" SELECT ? AS WORK_CD,                                                                                  \n");
			arr_sql[1].append ("        TO_CHAR((START_DATES + LEVEL - 1),'YYYYMMDD') AS CUR_DATE,                                     \n");
			arr_sql[1].append ("        TO_CHAR(START_DATES + LEVEL - 1,'D') AS CUR_DAY,                                               \n");
			arr_sql[1].append ("        CASE WHEN TO_CHAR(START_DATES + LEVEL - 1,'D')=1 THEN '1' ELSE '2' END HOL_YN,                 \n");
			arr_sql[1].append ("        CASE WHEN TO_CHAR(START_DATES + LEVEL - 1,'D')=1 THEN '' \n");
			arr_sql[1].append ("             ELSE  CASE WHEN TO_CHAR(START_DATES + LEVEL - 1,'D')=2  THEN TO_CHAR((START_DATES + LEVEL +4),'YYYYMMDD')\n");
			arr_sql[1].append ("                   ELSE  TO_CHAR((START_DATES + LEVEL +5),'YYYYMMDD') END \n");
			arr_sql[1].append ("         END AS INOUT_DATE, \n");
			arr_sql[1].append ("         CASE WHEN TO_CHAR(START_DATES + LEVEL - 1,'D')=1 THEN '1' ELSE  '3' END AS HOL_GB,            \n");
			arr_sql[1].append ("        '' AS REMARK ,                                                                                 \n");
			arr_sql[1].append ("        ?,                                                                                             \n");
			arr_sql[1].append ("        CURRENT_TIMESTAMP,                                                                             \n");
			arr_sql[1].append ("        ?,                                                                                             \n");
			arr_sql[1].append ("        CURRENT_TIMESTAMP, 'F' AS STAR_CHK                                                               \n");
			arr_sql[1].append ("  FROM(                                                                                                \n");
			arr_sql[1].append ("      SELECT (TO_DATE( ?,'YYYYMMDD')) START_DATES , (TO_DATE( ?,'YYYYMMDD')) END_DATES                 \n");
			arr_sql[1].append ("        FROM DUAL --기준달력 생성                                                                                                                                                   \n");
			arr_sql[1].append ("  )                                                                                                    \n");
			arr_sql[1].append ("  CONNECT BY (START_DATES+LEVEL-1) <= LAST_DAY(END_DATES)                                              \n");
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
		GauceDataSet ds1 = gis.read("DS_DATE");
		
		String strUserid = HDUtil.nullCheckStr(greq.getParameter("v_user_id"));
		
		int colNm_WORK_CD               = ds1.indexOfColumn("WORK_CD");
		int colNm_START_DATES           = ds1.indexOfColumn("START_DATES");
		int colNm_END_DATES             = ds1.indexOfColumn("END_DATES");
		int colNm_CREATE_ID             = ds1.indexOfColumn("CREATE_ID");
		int colNm_UPDATE_ID             = ds1.indexOfColumn("UPDATE_ID");
		
		Statement stmt1 = null;
		ResultSet rs1 = null;
		
		//TRY
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				for(int i=0; i<rows.length; i++){
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							cstmt = conn.prepareCall(arr_sql[1].toString());
							
							cstmt.setString(1,  rows[i].getString(colNm_WORK_CD));
							cstmt.setString(2,  strUserid);
							cstmt.setString(3,  strUserid);
							cstmt.setString(4,  rows[i].getString(colNm_START_DATES));
							cstmt.setString(5,  rows[i].getString(colNm_END_DATES));
														
							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();		
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							
							if(cstmt!=null) cstmt.close();	
							break;
							
						case GauceDataRow.TB_JOB_DELETE:
								
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
			String v_parm1  		= HDUtil.nullCheckStr(greq.getParameter("v_parm1"));
			
			switch(dsType) {
				case 1: //detail이 공백이 아닌 공통코드 검색
					
					//System.out.println("arr_sql[0].toString()::"+arr_sql[0].toString());
				
					// 쿼리 실행
					cstmt = conn.prepareCall(arr_sql[0].toString());	
					
					cstmt.setString(1,  v_keyword);	
					cstmt.setString(2,  v_parm1+"%");	
									
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
