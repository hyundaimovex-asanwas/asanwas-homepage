package omsm.ca;
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

public class m_ca0030_s1 extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
			arr_sql[0].append (" SELECT 'F'CHK, ACC_ORD_SID,WORK_CD,INOUT_GB,INOUT_DATE,CAR_KIND  \n");
			arr_sql[0].append ("       ,ITEM_NAME,START_ADDR,START_NAME,START_INFO,END_ADDR       \n");
			arr_sql[0].append ("       ,END_NAME,END_INFO,SHIP_CRNO,SHIP_COMPANY,PALLET_CNT       \n");
			arr_sql[0].append ("       ,ORDER_SID,ORDER_SEQ,ORDER_STS,LOGIS_STS,ORDER_GB          \n");
			arr_sql[0].append ("       ,CREATE_ID,CREATE_DATE,UPDATE_ID,UPDATE_DATE               \n");
			arr_sql[0].append ("  FROM OMS.T_OR0040                                               \n");
			arr_sql[0].append (" WHERE ORDER_STS = ?                                              \n");  //주문접수 마감건
		    
		    
		    //UPDATE
			arr_sql[2].append ("  UPDATE OMS.T_OR0040 SET  \n");
			arr_sql[2].append ("   LOGIS_STS=?   \n");
			arr_sql[2].append ("  ,UPDATE_ID=?   \n");
			arr_sql[2].append ("  ,UPDATE_DATE=CURRENT_TIMESTAMP \n");
			arr_sql[2].append ("  WHERE ACC_ORD_SID =? \n");
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
		GauceDataSet ds1 = gis.read("DS_DEFAULT");
		
		String strLogis_sts		= HDUtil.nullCheckStr(greq.getParameter("v_logis_sts"));
		String strUser_id		= HDUtil.nullCheckStr(greq.getParameter("v_user_id"));
				 
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
					
				int colNm_LOGIS_STS         = ds1.indexOfColumn("LOGIS_STS"); 	
				int colNm_ACC_ORD_SID       = ds1.indexOfColumn("ACC_ORD_SID");
				int colNm_UPDATE_ID         = ds1.indexOfColumn("UPDATE_ID"); 
				int colNm_UPDATE_DATE       = ds1.indexOfColumn("UPDATE_DATE"); 
				
				
				for(int i=0; i<rows.length; i++){
					//int j=1;
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							
							cstmt = conn.prepareCall(arr_sql[1].toString());
							/*
							
							
							cstmt.setString(1, strDrv_id);
							cstmt.setString(2, rows[i].getString(colNm_DRV_NAME));
							cstmt.setString(3, rows[i].getString(colNm_BIRTH_DATE));
							cstmt.setString(4, rows[i].getString(colNm_DRV_PHONE));
							cstmt.setString(5, rows[i].getString(colNm_DRV_USE));
							cstmt.setString(6, rows[i].getString(colNm_DRV_CLOSE_DATE));
							cstmt.setString(7, rows[i].getString(colNm_REMARK));
							cstmt.setString(8, rows[i].getString(colNm_WORK_CD));
							cstmt.setString(9, rows[i].getString(colNm_CREATE_ID));
							cstmt.setString(10, rows[i].getString(colNm_UPDATE_ID));
							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();		
							*/
							break;
							
						case GauceDataRow.TB_JOB_UPDATE:
																
														
							//System.out.println("arr_sql[2].toString()"+arr_sql[2].toString());
							
							//System.out.println("strLogis_sts"+strLogis_sts);  
							//System.out.println("strUser_id"+strUser_id);  
							//System.out.println("rows[i].getString(colNm_ACC_ORD_SID)"+rows[i].getString(colNm_ACC_ORD_SID));  
							
							cstmt = conn.prepareCall(arr_sql[2].toString());
						
							cstmt.setString(1, strLogis_sts); 
							cstmt.setString(2, strUser_id);
							cstmt.setString(3, rows[i].getString(colNm_ACC_ORD_SID));
							
							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();
						
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
			String v_keyword		= HDUtil.nullCheckStr(greq.getParameter("v_keyword")); //order_sts
						
			String v_parm1	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm1")); //반출입일자 fr
			String v_parm2	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm2")); //반출입일자 to
			String v_parm3	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm3")); //실화주사업자번호
			String v_parm4	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm4")); //실화주명
			String v_parm5	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm5")); //택배상태
			String v_parm6	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm6")); //사업명
			String v_parm7	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm7")); //반출입구분
						
			if(!v_parm1.equals("")&&!v_parm2.equals(""))  arr_sql[0].append (" AND  INOUT_DATE BETWEEN ? AND ?  \n");			
			if(!v_parm3.equals(""))    arr_sql[0].append (" AND  SHIP_CRNO = ?  \n");
			if(!v_parm4.equals(""))    arr_sql[0].append (" AND  SHIP_COMPANY LIKE ? \n");
			if(!v_parm5.equals(""))    arr_sql[0].append (" AND  LOGIS_STS=? \n");
			if(!v_parm6.equals(""))    arr_sql[0].append (" AND  WORK_CD=? \n");
			if(!v_parm7.equals(""))    arr_sql[0].append (" AND  INOUT_GB=? \n");
						
			//arr_sql[0].append (" ORDER BY A.SHIP_COMPANY, A.INOUT_GB, A.INOUT_DATE  \n");
			/*
			System.out.println("v_keyword"+v_keyword); 
			System.out.println("v_parm1"+v_parm1); 
			System.out.println("v_parm2"+v_parm2); 
			System.out.println("v_parm3"+v_parm3); 
			System.out.println("v_parm4"+v_parm4); 
			System.out.println("v_parm5"+v_parm5); 
			System.out.println("v_parm6"+v_parm6); 
			System.out.println("v_parm7"+v_parm7); 
			*/
			
			
			switch(dsType) {
				case 1: //detail이 공백이 아닌 공통코드 검색
				
					// 쿼리 실행
					//System.out.println("arr_sql[0].toString()"+arr_sql[0].toString());
					cstmt = conn.prepareCall(arr_sql[0].toString());
										
					cstmt.setString(1, v_keyword);
					int i_cnt=1;
					if(!v_parm1.equals("")&&!v_parm2.equals(""))  {
						i_cnt+=1;	cstmt.setString(i_cnt, v_parm1);
						i_cnt+=1;	cstmt.setString(i_cnt, v_parm2);
					}	
					
					if(!v_parm3.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, v_parm3);}
					if(!v_parm4.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, "%"+v_parm4+"%");}	
					if(!v_parm5.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, v_parm5);}
					if(!v_parm6.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, v_parm6);}
					if(!v_parm7.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, v_parm7);}
										
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
