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

public class m_co0070_s1 extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		    //주문조회
			arr_sql[0].append (" SELECT  A.CAR_NO,A.CAR_KIND,A.CAR_LENGTH,A.CAR_WIDTH,A.CAR_HEIGHT            \n");
			arr_sql[0].append ("        ,A.CAR_USE,A.CAR_CLOSE_DATE,A.REMARK,A.DRV_ID,A.WORK_CD               \n");
			arr_sql[0].append ("        ,A.CREATE_ID,A.CREATE_DATE,A.UPDATE_ID,A.UPDATE_DATE, B.DRV_NAME      \n");
			arr_sql[0].append ("   FROM OMS.T_AL0040 A, OMS.T_AL0030 B                                        \n");
			arr_sql[0].append ("  WHERE A.DRV_ID = B.DRV_ID(+)                                                \n");		
			
			//INSERT
			arr_sql[1].append (" INSERT INTO OMS.T_AL0040(                                             \n");
			arr_sql[1].append ("   CAR_NO,CAR_KIND,CAR_LENGTH,CAR_WIDTH,CAR_HEIGHT                     \n");
			arr_sql[1].append ("  ,CAR_USE,CAR_CLOSE_DATE,REMARK,DRV_ID,WORK_CD                        \n");
			arr_sql[1].append ("  ,CREATE_ID,CREATE_DATE,UPDATE_ID,UPDATE_DATE                         \n");
			arr_sql[1].append (" )VALUES(                                                              \n");
			arr_sql[1].append (" ?,?,?,?,?,  	                                                       \n");
			arr_sql[1].append (" ?,?,?,?,?,	                                                           \n");
			arr_sql[1].append (" ?,CURRENT_TIMESTAMP,?,CURRENT_TIMESTAMP                               \n");
			arr_sql[1].append (" )                                                                     \n");
			                                                                                     
			
			//UPDATE
			arr_sql[2].append ("  UPDATE OMS.T_AL0040 SET  \n");
			arr_sql[2].append ("  CAR_KIND=?    \n");
			arr_sql[2].append (" ,CAR_LENGTH=?  \n");
			arr_sql[2].append (" ,CAR_WIDTH=?   \n");
			arr_sql[2].append (" ,CAR_HEIGHT=?  \n");
			arr_sql[2].append (" ,CAR_USE=?     \n");
			arr_sql[2].append (" ,CAR_CLOSE_DATE=?   \n");
			arr_sql[2].append (" ,REMARK=?      \n");
			arr_sql[2].append (" ,DRV_ID=?      \n");
			arr_sql[2].append (" ,WORK_CD=?     \n");
			arr_sql[2].append (" ,UPDATE_ID=?   \n");
			arr_sql[2].append (" ,UPDATE_DATE=CURRENT_TIMESTAMP \n");
			arr_sql[2].append ("  WHERE CAR_NO =? \n");
			
			
			//DELETE
			arr_sql[3].append (" DELETE FROM OMS.T_AL0040  \n");
			arr_sql[3].append (" WHERE CAR_NO =?        \n");
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
		
		//String strOrder_Sid		= HDUtil.nullCheckStr(greq.getParameter("v_order_sid"));
		//String strIO        	= HDUtil.nullCheckStr(greq.getParameter("v_io"));
		
		Statement stmt1 = null;
		ResultSet rs1 = null;
		
		//TRY
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
					
				int colNm_CAR_NO            = ds1.indexOfColumn("CAR_NO"); 
				int colNm_CAR_KIND          = ds1.indexOfColumn("CAR_KIND"); 
				int colNm_CAR_LENGTH        = ds1.indexOfColumn("CAR_LENGTH"); 
				int colNm_CAR_WIDTH         = ds1.indexOfColumn("CAR_WIDTH"); 
				int colNm_CAR_HEIGHT        = ds1.indexOfColumn("CAR_HEIGHT"); 
				int colNm_CAR_USE           = ds1.indexOfColumn("CAR_USE"); 
				int colNm_CAR_CLOSE_DATE    = ds1.indexOfColumn("CAR_CLOSE_DATE"); 
				int colNm_REMARK            = ds1.indexOfColumn("REMARK"); 
				int colNm_DRV_ID            = ds1.indexOfColumn("DRV_ID"); 
				int colNm_WORK_CD           = ds1.indexOfColumn("WORK_CD"); 
				int colNm_CREATE_ID         = ds1.indexOfColumn("CREATE_ID"); 
				int colNm_CREATE_DATE       = ds1.indexOfColumn("CREATE_DATE"); 
				int colNm_UPDATE_ID         = ds1.indexOfColumn("UPDATE_ID"); 
				int colNm_UPDATE_DATE       = ds1.indexOfColumn("UPDATE_DATE"); 
				
				
				for(int i=0; i<rows.length; i++){
					//int j=1;
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							cstmt = conn.prepareCall(arr_sql[1].toString());
							
							cstmt.setString(1, rows[i].getString(colNm_CAR_NO));
							cstmt.setString(2, rows[i].getString(colNm_CAR_KIND));
							cstmt.setString(3, rows[i].getString(colNm_CAR_LENGTH));
							cstmt.setString(4, rows[i].getString(colNm_CAR_WIDTH));
							cstmt.setString(5, rows[i].getString(colNm_CAR_HEIGHT));
							cstmt.setString(6, rows[i].getString(colNm_CAR_USE));
							cstmt.setString(7, rows[i].getString(colNm_CAR_CLOSE_DATE));
							cstmt.setString(8, rows[i].getString(colNm_REMARK));
							cstmt.setString(9, rows[i].getString(colNm_DRV_ID));
							cstmt.setString(10, rows[i].getString(colNm_WORK_CD));
							cstmt.setString(11, rows[i].getString(colNm_CREATE_ID));
							cstmt.setString(12, rows[i].getString(colNm_UPDATE_ID));
							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();		
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							
							cstmt = conn.prepareCall(arr_sql[2].toString());
							
							
							cstmt.setString(1, rows[i].getString(colNm_CAR_KIND));
							cstmt.setString(2, rows[i].getString(colNm_CAR_LENGTH));
							cstmt.setString(3, rows[i].getString(colNm_CAR_WIDTH));
							cstmt.setString(4, rows[i].getString(colNm_CAR_HEIGHT));
							cstmt.setString(5, rows[i].getString(colNm_CAR_USE));
							cstmt.setString(6, rows[i].getString(colNm_CAR_CLOSE_DATE));
							cstmt.setString(7, rows[i].getString(colNm_REMARK));
							cstmt.setString(8, rows[i].getString(colNm_DRV_ID));
							cstmt.setString(9, rows[i].getString(colNm_WORK_CD));
							cstmt.setString(10, rows[i].getString(colNm_UPDATE_ID));
							cstmt.setString(11, rows[i].getString(colNm_CAR_NO));
								
							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();	
							break;
							
						case GauceDataRow.TB_JOB_DELETE:
							cstmt = conn.prepareCall(arr_sql[3].toString());
		
							cstmt.setString(1,rows[i].getString(colNm_CAR_NO));	
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
			String v_keyword		= HDUtil.nullCheckStr(greq.getParameter("v_keyword")); //반출 O, 반입 I
		
			String v_parm1	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm1")); //차량번호
			String v_parm2	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm2")); //사용유무
		
			//System.out.println("v_keyword::::::::::::::"+v_keyword+":::::");
			//System.out.println("v_parm1::::::::::::::"+v_parm1+":::::");
			//System.out.println("v_parm2::::::::::::::"+v_parm2+":::::");
		
			
			if(!v_parm1.equals(""))  arr_sql[0].append (" AND  A.CAR_NO LIKE ?  \n");
			if(!v_parm2.equals(""))  arr_sql[0].append (" AND  A.CAR_USE=? \n");
					
			switch(dsType) {
				case 1: //주문 MST
					
					//System.out.println("arr_sql[0].toString()"+arr_sql[0].toString());
					//쿼리 실행
					cstmt = conn.prepareCall(arr_sql[0].toString());
					
					int i_cnt=0;
					
					if(!v_parm1.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, "%"+v_parm1+"%");}
					if(!v_parm2.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, v_parm2);}	
		
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
