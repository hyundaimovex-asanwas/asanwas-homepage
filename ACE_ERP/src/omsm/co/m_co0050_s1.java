package omsm.co;
/***********************************************************************
 * 	OMS 공지사항
************************************************************************/

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

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

public class m_co0050_s1 extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		    arr_sql[0].append (" SELECT CR_NO,COMPANY,REP_NAME,COR_NO,PHONE  \n");
		    arr_sql[0].append ("       ,POST_NO,ADDR1,ADDR2,BCND,BKND \n");
		    arr_sql[0].append ("       ,REMARK,VEND_CD,ATT_FILE_NAME,ATT_FILE_SYS_NAME \n");
		    arr_sql[0].append ("       ,CREATE_ID,CREATE_DATE,UPDATE_ID,UPDATE_DATE    \n");
		    arr_sql[0].append ("       ,CASE WHEN SUBSTR(PHONE,1,2)='02'  AND  LENGTH(PHONE)=9  THEN 1    \n");
		    arr_sql[0].append ("             WHEN SUBSTR(PHONE,1,2)='02'  AND  LENGTH(PHONE)=10 THEN 2   \n");
		    arr_sql[0].append ("             WHEN SUBSTR(PHONE,1,2)!='02' AND  LENGTH(PHONE)=10 THEN 3    \n");
		    arr_sql[0].append ("             WHEN SUBSTR(PHONE,1,2)!='02' AND  LENGTH(PHONE)=11 THEN 4   \n");
		    arr_sql[0].append ("             ELSE 9 END AS MASK_GB \n");
		    arr_sql[0].append ("   FROM OMS.T_CO0060  \n");
		    arr_sql[0].append ("  WHERE 1=1   \n");	
		    
		    		    
		    //INSERT
		    arr_sql[1].append (" INSERT INTO OMS.T_CO0060 (                       \n");
		    arr_sql[1].append ("  CR_NO,COMPANY,REP_NAME,COR_NO,PHONE             \n");
		    arr_sql[1].append (" ,POST_NO,ADDR1,ADDR2,BCND,BKND                   \n");
		    arr_sql[1].append (" ,REMARK,VEND_CD,ATT_FILE_NAME,ATT_FILE_SYS_NAME  \n");
		    arr_sql[1].append (" ,CREATE_ID,CREATE_DATE,UPDATE_ID,UPDATE_DATE     \n");
		    arr_sql[1].append (" )VALUES(                                         \n");
		    arr_sql[1].append (" ?,?,?,?,?,	                                      \n");
		    arr_sql[1].append (" ?,?,?,?,?,	                                      \n");
		    arr_sql[1].append (" ?,?,?,?,	                                      \n");
		    arr_sql[1].append (" ?,CURRENT_TIMESTAMP,?,CURRENT_TIMESTAMP          \n");
		    arr_sql[1].append (" )                                                \n");
		    
		    
		    arr_sql[3].append (" DELETE FROM OMS.T_CO0060 WHERE CR_NO =? \n");
		    
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
		
		//String strLogis_sts	= HDUtil.nullCheckStr(greq.getParameter("v_logis_sts"));
		String strUser_id		= HDUtil.nullCheckStr(greq.getParameter("v_user_id"));
		
		//System.out.println("strUser_id::"+strUser_id);	
				 
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
					
				int colNm_CR_NO                    = ds1.indexOfColumn("CR_NO"); 	
				int colNm_COMPANY                  = ds1.indexOfColumn("COMPANY"); 
				int colNm_REP_NAME                 = ds1.indexOfColumn("REP_NAME"); 
				int colNm_COR_NO                   = ds1.indexOfColumn("COR_NO"); 
				int colNm_PHONE                    = ds1.indexOfColumn("PHONE"); 	
				int colNm_POST_NO                  = ds1.indexOfColumn("POST_NO"); 
				int colNm_ADDR1                    = ds1.indexOfColumn("ADDR1"); 
				int colNm_ADDR2                    = ds1.indexOfColumn("ADDR2"); 
				int colNm_BCND                     = ds1.indexOfColumn("BCND"); 	
				int colNm_BKND                     = ds1.indexOfColumn("BKND"); 
				int colNm_REMARK                   = ds1.indexOfColumn("REMARK"); 
				int colNm_VEND_CD                  = ds1.indexOfColumn("VEND_CD"); 
				int colNm_ATT_FILE_NAME            = ds1.indexOfColumn("ATT_FILE_NAME"); 	
				int colNm_ATT_FILE_SYS_NAME        = ds1.indexOfColumn("ATT_FILE_SYS_NAME"); 
				int colNm_CREATE_ID                = ds1.indexOfColumn("CREATE_ID"); 
				int colNm_CREATE_DATE              = ds1.indexOfColumn("CREATE_DATE"); 
				int colNm_UPDATE_ID                = ds1.indexOfColumn("UPDATE_ID"); 	
				int colNm_UPDATE_DATE              = ds1.indexOfColumn("UPDATE_DATE"); 
				
				
				for(int i=0; i<rows.length; i++){
					
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							
							//System.out.println("arr_sql[1].toString()::"+arr_sql[1].toString());	
							
							cstmt = conn.prepareCall(arr_sql[1].toString());
							
							cstmt.setString(1, rows[i].getString(colNm_CR_NO));
							cstmt.setString(2, rows[i].getString(colNm_COMPANY));
							cstmt.setString(3, rows[i].getString(colNm_REP_NAME));
							cstmt.setString(4, rows[i].getString(colNm_COR_NO));
							cstmt.setString(5, rows[i].getString(colNm_PHONE));
							cstmt.setString(6, rows[i].getString(colNm_POST_NO));
							cstmt.setString(7, rows[i].getString(colNm_ADDR1));
							cstmt.setString(8, rows[i].getString(colNm_ADDR2));
							cstmt.setString(9, rows[i].getString(colNm_BCND));
							cstmt.setString(10, rows[i].getString(colNm_BKND));
							cstmt.setString(11, rows[i].getString(colNm_REMARK));
							cstmt.setString(12, rows[i].getString(colNm_VEND_CD));
							cstmt.setString(13, rows[i].getString(colNm_ATT_FILE_NAME));
							cstmt.setString(14, rows[i].getString(colNm_ATT_FILE_SYS_NAME));
							cstmt.setString(15, strUser_id); 
							cstmt.setString(16, strUser_id); 
							
							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();		
							
							break;
							
						case GauceDataRow.TB_JOB_UPDATE:
																
							/*							
							System.out.println("arr_sql[2].toString()"+arr_sql[2].toString());
							
							
							System.out.println("strUser_id"+strUser_id);  
							System.out.println("rows[i].getString(colNm_ACC_ORD_SID)"+rows[i].getString(colNm_ACC_ORD_SID));  
							
							cstmt = conn.prepareCall(arr_sql[2].toString());
						
							cstmt.setString(1, strLogis_sts); 
							cstmt.setString(2, strUser_id);
							cstmt.setString(3, rows[i].getString(colNm_ACC_ORD_SID));
							
							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();
						
							break;
							*/
							
						case GauceDataRow.TB_JOB_DELETE:
							
							cstmt = conn.prepareCall(arr_sql[3].toString());
		
							cstmt.setString(1,rows[i].getString(colNm_CR_NO));	
							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();
							
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
			String v_keyword		= HDUtil.nullCheckStr(greq.getParameter("v_keyword"));
			
			String v_parm1	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm1")); //사업자번호
			String v_parm2	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm2")); //화주명
			
			if(!v_parm1.equals(""))    arr_sql[0].append (" AND CR_NO = ?  \n");
			if(!v_parm2.equals(""))    arr_sql[0].append (" AND COMPANY LIKE ? \n");
			
			switch(dsType) {
				case 1: //detail이 공백이 아닌 공통코드 검색
					
					//System.out.println("arr_sql[0].toString()::"+arr_sql[0].toString());	
					// 쿼리 실행
					cstmt = conn.prepareCall(arr_sql[0].toString());
					
					int i_cnt=0;
					if(!v_parm1.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, v_parm1);}
					if(!v_parm2.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, "%"+v_parm2+"%");}	
										
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
