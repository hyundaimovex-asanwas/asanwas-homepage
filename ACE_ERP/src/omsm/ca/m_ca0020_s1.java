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

public class m_ca0020_s1 extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
			arr_sql[2].append (" UPDATE OMS.T_CA0010 SET              \n");
			arr_sql[2].append ("       SHIP_SUP_AMT = ?               \n");
			arr_sql[2].append ("      ,SHIP_SUP_VAT = ?               \n");
			arr_sql[2].append ("      ,SHIP_DMD_AMT = ?               \n");
			arr_sql[2].append ("      ,COST_GB = ?                    \n");
			arr_sql[2].append ("      ,CUST_GB = ?                    \n");
			arr_sql[2].append ("      ,UPDATE_ID = ?                  \n");
			arr_sql[2].append ("      ,UPDATE_DATE =CURRENT_TIMESTAMP \n");
			arr_sql[2].append (" WHERE CA_SID =?                      \n");
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
		
		//String strLogis_sts		= HDUtil.nullCheckStr(greq.getParameter("v_logis_sts"));
		String strUser_id		= HDUtil.nullCheckStr(greq.getParameter("v_user_id"));
				 
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
					
				int colNm_CA_SID               = ds1.indexOfColumn("CA_SID"); 	
				int colNm_CA_MONTH             = ds1.indexOfColumn("CA_MONTH"); 	
				int colNm_INOUT_DATE           = ds1.indexOfColumn("INOUT_DATE"); 	
				int colNm_LOGIS_GB             = ds1.indexOfColumn("LOGIS_GB"); 	
				int colNm_INOUT_GB             = ds1.indexOfColumn("INOUT_GB"); 	
				int colNm_ITEM_NAME            = ds1.indexOfColumn("ITEM_NAME"); 	
				int colNm_CAR_KIND             = ds1.indexOfColumn("CAR_KIND"); 	
				int colNm_CAR_NO               = ds1.indexOfColumn("CAR_NO"); 	
				int colNm_DRV_ID               = ds1.indexOfColumn("DRV_ID"); 	
				int colNm_START_ADDR           = ds1.indexOfColumn("START_ADDR"); 	
				int colNm_START_NAME           = ds1.indexOfColumn("START_NAME"); 	
				int colNm_END_ADDR             = ds1.indexOfColumn("END_ADDR"); 	
				int colNm_END_NAME             = ds1.indexOfColumn("END_NAME"); 	
				int colNm_OUT_TIME             = ds1.indexOfColumn("OUT_TIME"); 	
				int colNm_IN_TIME              = ds1.indexOfColumn("IN_TIME"); 	
				int colNm_UNIT                 = ds1.indexOfColumn("UNIT"); 	
				int colNm_QTY                  = ds1.indexOfColumn("QTY"); 	
				int colNm_UNIT_PRICE           = ds1.indexOfColumn("UNIT_PRICE"); 	
				int colNm_SUP_AMT              = ds1.indexOfColumn("SUP_AMT"); 	
				int colNm_SHIP_CRNO            = ds1.indexOfColumn("SHIP_CRNO"); 	
				int colNm_SHIP_COMPANY         = ds1.indexOfColumn("SHIP_COMPANY"); 	
				int colNm_REMARK               = ds1.indexOfColumn("REMARK"); 	
				int colNm_SHIP_UNIT_PRICE      = ds1.indexOfColumn("SHIP_UNIT_PRICE"); 	
				int colNm_SHIP_SUP_AMT         = ds1.indexOfColumn("SHIP_SUP_AMT"); 	
				int colNm_SHIP_SUP_VAT         = ds1.indexOfColumn("SHIP_SUP_VAT"); 	
				int colNm_SHIP_DMD_AMT         = ds1.indexOfColumn("SHIP_DMD_AMT"); 	
				int colNm_CA_STS               = ds1.indexOfColumn("CA_STS"); 	
				int colNm_WORK_CD              = ds1.indexOfColumn("WORK_CD"); 	
				int colNm_COST_GB              = ds1.indexOfColumn("COST_GB"); 	
				int colNm_CUST_GB              = ds1.indexOfColumn("CUST_GB"); 	
				int colNm_CREATE_ID            = ds1.indexOfColumn("CREATE_ID"); 	
				int colNm_CREATE_DATE          = ds1.indexOfColumn("CREATE_DATE"); 	
				int colNm_UPDATE_ID            = ds1.indexOfColumn("UPDATE_ID"); 	
				int colNm_UPDATE_DATE          = ds1.indexOfColumn("UPDATE_DATE"); 
				
				
				
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
							/*									
							System.out.println("arr_sql[2].toString()"+arr_sql[2].toString());
							
							System.out.println("colNm_SHIP_SUP_AMT::"+rows[i].getDouble(colNm_SHIP_SUP_AMT));
							System.out.println("colNm_SHIP_SUP_VAT::"+rows[i].getDouble(colNm_SHIP_SUP_VAT));
							System.out.println("colNm_SHIP_DMD_AMT::"+rows[i].getDouble(colNm_SHIP_DMD_AMT));
							System.out.println("colNm_COST_GB::"+rows[i].getString(colNm_COST_GB));
							System.out.println("colNm_CUST_GB::"+rows[i].getString(colNm_CUST_GB));
							System.out.println("strUser_id::"+strUser_id);
							System.out.println("colNm_CA_SID::"+rows[i].getString(colNm_CA_SID));
							*/
							
							cstmt = conn.prepareCall(arr_sql[2].toString());
						
							cstmt.setDouble(1, rows[i].getDouble(colNm_SHIP_SUP_AMT));
							cstmt.setDouble(2, rows[i].getDouble(colNm_SHIP_SUP_VAT));
							cstmt.setDouble(3, rows[i].getDouble(colNm_SHIP_DMD_AMT));
							cstmt.setString(4, rows[i].getString(colNm_COST_GB));
							cstmt.setString(5, rows[i].getString(colNm_CUST_GB));
							cstmt.setString(6, strUser_id);
							cstmt.setString(7, rows[i].getString(colNm_CA_SID));
							
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
						
			String v_parm1	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm1")); //정산년월 fr
			String v_parm3	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm3")); //실화주사업자번호
			String v_parm4	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm4")); //실화주명
			String v_parm6	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm6")); //사업명
			String v_parm7	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm7")); //반출입구분
						
			if(!v_parm1.equals(""))    arr_sql[0].append (" AND  CA_MONTH = ?  \n");			
			if(!v_parm3.equals(""))    arr_sql[0].append (" AND  SHIP_CRNO = ?  \n");
			if(!v_parm4.equals(""))    arr_sql[0].append (" AND  SHIP_COMPANY LIKE ? \n");
			if(!v_parm6.equals(""))    arr_sql[0].append (" AND  WORK_CD=? \n");
			if(!v_parm7.equals(""))    arr_sql[0].append (" AND  INOUT_GB=? \n");
						
			//arr_sql[0].append (" ORDER BY A.SHIP_COMPANY, A.INOUT_GB, A.INOUT_DATE  \n");
			/*
			System.out.println("v_keyword"+v_keyword); 
			System.out.println("v_parm1"+v_parm1); 
			System.out.println("v_parm3"+v_parm3); 
			System.out.println("v_parm4"+v_parm4); 
			System.out.println("v_parm6"+v_parm6); 
			System.out.println("v_parm7"+v_parm7); 
			*/
			
			switch(dsType) {
				case 1: //detail이 공백이 아닌 공통코드 검색
				
					// 쿼리 실행
					//System.out.println("arr_sql[0].toString()"+arr_sql[0].toString());
					cstmt = conn.prepareCall(arr_sql[0].toString());
										
					cstmt.setString(1, v_keyword);
					int i_cnt=0;
					if(!v_parm1.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, v_parm1);}
					if(!v_parm3.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, v_parm3);}
					if(!v_parm4.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, "%"+v_parm4+"%");}	
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
