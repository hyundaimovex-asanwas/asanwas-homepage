package omsm.co;
/***********************************************************************
 * 	OMS 사용자등록
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

public class m_co0060_s1 extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		    arr_sql[0].append (" SELECT A.USER_ID, A.USER_NAME, A.CR_NO, A.PHONE, A.HP  \n");
		    arr_sql[0].append ("       ,A.FAX, A.EMAIL, A.WORK_CD, A.WORK_GB, A.REMARK, A.USER_PW, A.DUP_CHK  \n");
		    arr_sql[0].append ("       ,A.CREATE_ID, A.CREATE_DATE, A.UPDATE_ID, A.UPDATE_DATE, 'F' CHK ,  C.EMPID, B.COMPANY  \n");
		    arr_sql[0].append ("       ,CASE WHEN SUBSTR(A.PHONE,1,2)='02'  AND  LENGTH(A.PHONE)=9  THEN 1    \n");
		    arr_sql[0].append ("             WHEN SUBSTR(A.PHONE,1,2)='02'  AND  LENGTH(A.PHONE)=10 THEN 2   \n");
		    arr_sql[0].append ("             WHEN SUBSTR(A.PHONE,1,2)!='02' AND  LENGTH(A.PHONE)=10 THEN 3    \n");
		    arr_sql[0].append ("             WHEN SUBSTR(A.PHONE,1,2)!='02' AND  LENGTH(A.PHONE)=11 THEN 4   \n");
		    arr_sql[0].append ("             ELSE 9 END AS MASK_GB \n");
		    arr_sql[0].append ("  FROM OMS.T_CO0050 A , OMS.T_CO0060 B  , COMMON.GD0080 C \n");
		    arr_sql[0].append (" WHERE A.CR_NO=B.CR_NO(+)   \n");	
		    arr_sql[0].append ("   AND A.USER_ID=C.AED(+)   \n");	
		    
		    		    
		    //INSERT
		    arr_sql[1].append (" INSERT INTO OMS.T_CO0050 (                    \n");
		    arr_sql[1].append ("  USER_ID,USER_NAME,CR_NO,PHONE,HP             \n");
		    arr_sql[1].append (" ,FAX,EMAIL,WORK_CD,WORK_GB,REMARK,USER_PW,DUP_CHK \n");
		    arr_sql[1].append (" ,CREATE_ID,CREATE_DATE,UPDATE_ID,UPDATE_DATE  \n");
		    arr_sql[1].append (" )VALUES(                                      \n");
		    arr_sql[1].append (" ?,?,?,?,?,	                                   \n");
		    arr_sql[1].append (" ?,?,?,?,?,?,?,                                \n");
		    arr_sql[1].append (" ?,CURRENT_TIMESTAMP,?,CURRENT_TIMESTAMP       \n");
		    arr_sql[1].append (" )                                             \n");
		    
		    arr_sql[2].append ("  UPDATE OMS.T_CO0050 SET  \n");
			arr_sql[2].append ("  PHONE=?    \n");
			arr_sql[2].append (" ,HP=?   \n");
			arr_sql[2].append (" ,FAX=?  \n");
			arr_sql[2].append (" ,EMAIL=?      \n");
			arr_sql[2].append (" ,WORK_GB=?     \n");
			arr_sql[2].append (" ,UPDATE_ID=?   \n");
			arr_sql[2].append (" ,UPDATE_DATE=CURRENT_TIMESTAMP \n");
			arr_sql[2].append ("  WHERE USER_ID =? \n");
			
		    
		    arr_sql[3].append (" DELETE FROM OMS.T_CO0050 WHERE USER_ID =? \n");
		    
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
		
		String strUser_id	= HDUtil.nullCheckStr(greq.getParameter("v_user_id"));
				
		//System.out.println("strUser_id::"+strUser_id);	
		//System.out.println("strCr_no::"+strCr_no);	
				 
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				
				int colNm_USER_ID           = ds1.indexOfColumn("USER_ID");
				int colNm_USER_NAME         = ds1.indexOfColumn("USER_NAME");
				int colNm_CR_NO             = ds1.indexOfColumn("CR_NO");
				int colNm_PHONE             = ds1.indexOfColumn("PHONE");
				int colNm_HP                = ds1.indexOfColumn("HP");
				int colNm_FAX               = ds1.indexOfColumn("FAX");
				int colNm_EMAIL             = ds1.indexOfColumn("EMAIL");
				int colNm_WORK_CD           = ds1.indexOfColumn("WORK_CD");
				int colNm_WORK_GB           = ds1.indexOfColumn("WORK_GB");
				int colNm_REMARK            = ds1.indexOfColumn("REMARK");
				int colNm_USER_PW           = ds1.indexOfColumn("USER_PW");
				int colNm_DUP_CHK           = ds1.indexOfColumn("DUP_CHK");
				int colNm_CREATE_ID         = ds1.indexOfColumn("CREATE_ID"); 
				int colNm_CREATE_DATE       = ds1.indexOfColumn("CREATE_DATE"); 
				int colNm_UPDATE_ID         = ds1.indexOfColumn("UPDATE_ID"); 	
				int colNm_UPDATE_DATE       = ds1.indexOfColumn("UPDATE_DATE"); 
				
				
				//System.out.println("rows.length::"+rows.length);
								
				for(int i=0; i<rows.length; i++){
				
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							//System.out.println("arr_sql[1].toString()::"+arr_sql[1].toString());	
							
							cstmt = conn.prepareCall(arr_sql[1].toString());
							
							cstmt.setString(1, rows[i].getString(colNm_USER_ID));
							cstmt.setString(2, rows[i].getString(colNm_USER_NAME));
							cstmt.setString(3, rows[i].getString(colNm_CR_NO));						
							cstmt.setString(4, rows[i].getString(colNm_PHONE));
							cstmt.setString(5, rows[i].getString(colNm_HP));
							cstmt.setString(6, rows[i].getString(colNm_FAX));
							cstmt.setString(7, rows[i].getString(colNm_EMAIL));
							cstmt.setString(8, rows[i].getString(colNm_WORK_CD));
							cstmt.setString(9, rows[i].getString(colNm_WORK_GB));
							cstmt.setString(10, rows[i].getString(colNm_REMARK));
							cstmt.setString(11, rows[i].getString(colNm_USER_PW));
							cstmt.setString(12, rows[i].getString(colNm_DUP_CHK));
							cstmt.setString(13, strUser_id); 
							cstmt.setString(14, strUser_id); 
							
							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();		
							
							break;
							
						case GauceDataRow.TB_JOB_UPDATE:
							
							cstmt = conn.prepareCall(arr_sql[2].toString());
							cstmt.setString(1, rows[i].getString(colNm_PHONE)); 
							cstmt.setString(2, rows[i].getString(colNm_HP));
							cstmt.setString(3, rows[i].getString(colNm_FAX));
							cstmt.setString(4, rows[i].getString(colNm_EMAIL));
							cstmt.setString(5, rows[i].getString(colNm_WORK_GB));
							cstmt.setString(6, strUser_id);
							cstmt.setString(7, rows[i].getString(colNm_USER_ID));
							
							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();
						    
							break;
							
							
						case GauceDataRow.TB_JOB_DELETE:
							cstmt = conn.prepareCall(arr_sql[3].toString());
							
							//System.out.println("arr_sql[1].toString()::"+arr_sql[3].toString());	
							
							cstmt.setString(1,rows[i].getString(colNm_USER_ID));	
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
			String v_parm1	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm1")); //사용자명
			String v_parm2	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm2")); //사업자번호
			String v_parm3	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm3")); //회사명
			
			
			if(!v_keyword.equals("")) arr_sql[0].append (" AND  A.USER_ID = ?  \n");
			if(!v_parm1.equals(""))   arr_sql[0].append (" AND  A.USER_NAME LIKE ?  \n");
			if(!v_parm2.equals(""))   arr_sql[0].append (" AND  A.CR_NO = ?  \n");
			if(!v_parm3.equals(""))   arr_sql[0].append (" AND  B.COMPANY LIKE ?  \n");
			
			switch(dsType) {
				case 1: //detail이 공백이 아닌 공통코드 검색
					
					System.out.println("arr_sql[0].toString()::"+arr_sql[0].toString());	
					// 쿼리 실행
					cstmt = conn.prepareCall(arr_sql[0].toString());
					int i_cnt=0;
					
					if(!v_keyword.equals("")){i_cnt+=1;	cstmt.setString(i_cnt, v_keyword);}	
					if(!v_parm1.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, "%"+v_parm1+"%");}	
					if(!v_parm2.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, v_parm2);}	
					if(!v_parm3.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, "%"+v_parm3+"%");}	
										
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
