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

public class m_ca0010_s1 extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		    arr_sql[0].append (" SELECT  A.CA_SID,A.CA_MONTH,A.INOUT_DATE,A.LOGIS_GB,B.DETAIL_NAME AS LOGIS_NM  \n");
		    arr_sql[0].append ("        ,A.INOUT_GB, C.DETAIL_NAME AS INOUT_NM ,A.ITEM_NAME,A.CAR_KIND \n");
		    arr_sql[0].append ("        ,D.DETAIL_NAME AS CAR_KIND_NM, A.CAR_NO, A.DRV_ID, E.DRV_NAME, A.START_ADDR \n");
		    arr_sql[0].append ("        ,A.START_NAME,A.END_ADDR,A.END_NAME,A.OUT_TIME,A.IN_TIME,A.START_NAME||'/'||A.END_NAME AS START_END_NAME   \n");
		    arr_sql[0].append ("        ,A.UNIT,A.QTY,UNIT_PRICE,A.SUP_AMT,A.SHIP_CRNO \n");
		    arr_sql[0].append ("        ,A.SHIP_COMPANY,A.REMARK,A.SHIP_UNIT_PRICE,A.SHIP_SUP_AMT,A.SHIP_SUP_VAT\n");
		    arr_sql[0].append ("        ,A.SHIP_DMD_AMT,A.CA_STS\n");
		    arr_sql[0].append ("        ,A.CREATE_ID,A.CREATE_DATE,A.UPDATE_ID,A.UPDATE_DATE \n");
		    arr_sql[0].append ("   FROM OMS.T_CA0010 A, OMS.T_CO0030 B, OMS.T_CO0030 C, OMS.T_CO0030 D, OMS.T_AL0030 E \n");
		    arr_sql[0].append ("  WHERE B.DETAIL_CD(+) = A.LOGIS_GB AND B.HEAD_CD(+) = 'A013' \n");	
		    arr_sql[0].append ("    AND C.DETAIL_CD(+) = A.INOUT_GB AND C.HEAD_CD(+) = 'A009' \n");	
		    arr_sql[0].append ("    AND D.DETAIL_CD(+) = A.CAR_KIND AND D.HEAD_CD(+) = 'A015' \n");	
		    arr_sql[0].append ("    AND E.DRV_ID(+) = A.DRV_ID  \n");	
		    arr_sql[0].append ("    AND A.CA_MONTH =?  \n");
		    
		    //UPDATE
			arr_sql[2].append ("  UPDATE OMS.T_CA0010 SET  \n");
			arr_sql[2].append ("  CA_STS=?    \n");
			arr_sql[2].append (" ,UPDATE_ID=?   \n");
			arr_sql[2].append (" ,UPDATE_DATE=CURRENT_TIMESTAMP \n");
			arr_sql[2].append ("  WHERE CA_MONTH =? \n");
			arr_sql[2].append ("    AND SHIP_CRNO =? \n");
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
		
		String strCa_month		= HDUtil.nullCheckStr(greq.getParameter("v_ca_month"));
		String strShip_crno		= HDUtil.nullCheckStr(greq.getParameter("v_ship_crno"));
		String strInout_gb		= HDUtil.nullCheckStr(greq.getParameter("v_inout_gb"));
		
		if(!strInout_gb.equals(""))  arr_sql[2].append (" AND  INOUT_GB=? \n");
				 
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
					
				int colNm_CA_STS            = ds1.indexOfColumn("CA_STS"); 
				
				int colNm_CREATE_ID         = ds1.indexOfColumn("CREATE_ID"); 
				int colNm_CREATE_DATE       = ds1.indexOfColumn("CREATE_DATE"); 
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
							cstmt = conn.prepareCall(arr_sql[2].toString());
						
							cstmt.setString(1, rows[i].getString(colNm_CA_STS));
							cstmt.setString(2, rows[i].getString(colNm_UPDATE_ID));
							cstmt.setString(3, strCa_month);
							cstmt.setString(4, strShip_crno);
	
							int i_cnt=4;
							if(!strInout_gb.equals("")){i_cnt+=1; cstmt.setString(i_cnt, strInout_gb);}	
								
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
			String v_keyword		= HDUtil.nullCheckStr(greq.getParameter("v_keyword")); //ca_sts 상태값
						
			String v_parm1	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm1")); //정산년월
			String v_parm2	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm2")); //실화주 사업자번호
			String v_parm3	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm3")); //실화주명
			String v_parm4	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm4")); //반입 반출 
						
			if(!v_parm2.equals(""))    arr_sql[0].append (" AND  A.SHIP_CRNO=? \n");
			if(!v_parm3.equals(""))    arr_sql[0].append (" AND  A.SHIP_COMPANY LIKE ?  \n");
			if(!v_parm4.equals(""))    arr_sql[0].append (" AND  A.INOUT_GB=? \n");
			if(!v_keyword.equals(""))  arr_sql[0].append (" AND  A.CA_STS=? \n");
			
			arr_sql[0].append (" ORDER BY A.SHIP_COMPANY, A.INOUT_GB, A.INOUT_DATE  \n");
			
			switch(dsType) {
				case 1: //detail이 공백이 아닌 공통코드 검색
				
					// 쿼리 실행
					//System.out.println("arr_sql[0].toString()"+arr_sql[0].toString());
					cstmt = conn.prepareCall(arr_sql[0].toString());
										
					cstmt.setString(1, v_parm1);
					int i_cnt=1;
					if(!v_parm2.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, v_parm2);}	
					if(!v_parm3.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, "%"+v_parm3+"%");}	
					if(!v_parm4.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, v_parm4);}	
					if(!v_keyword.equals("")){i_cnt+=1;	cstmt.setString(i_cnt, v_keyword);}	
					
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
