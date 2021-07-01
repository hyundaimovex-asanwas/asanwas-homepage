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

public class m_co0090_s1 extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		    //주문조회
			arr_sql[0].append (" SELECT CAR_NO,INOUT_GB,CAR_KIND,START_ADDR,START_NAME         \n");
			arr_sql[0].append ("       ,START_INFO,END_ADDR,END_NAME,END_INFO,REMARK,TEMP_USE, WORK_CD  \n");
			arr_sql[0].append ("       ,APP_VENDCD,APP_COMPANY,APP_CRNO,APP_PERSON,APP_PHONE,APP_HP\n");
			arr_sql[0].append ("       ,SHIP_VENDCD,SHIP_COMPANY,SHIP_CRNO,SHIP_PERSON,SHIP_PHONE,SHIP_HP\n");
			arr_sql[0].append ("       ,CREATE_ID,CREATE_DATE,UPDATE_ID,UPDATE_DATE, 'F' CHK   \n");
			arr_sql[0].append ("   FROM OMS.T_OR0030                                           \n");
			arr_sql[0].append ("  WHERE WORK_CD= ?                                            \n");
			
			//INSERT
			arr_sql[1].append (" INSERT INTO OMS.T_OR0030(                               \n");
			arr_sql[1].append ("   CAR_NO,INOUT_GB,CAR_KIND,START_ADDR,START_NAME        \n");
			arr_sql[1].append ("  ,START_INFO,END_ADDR,END_NAME,END_INFO,REMARK,TEMP_USE, WORK_CD \n");
			arr_sql[1].append ("  ,APP_VENDCD,APP_COMPANY,APP_CRNO,APP_PERSON,APP_PHONE,APP_HP\n");
			arr_sql[1].append ("  ,SHIP_VENDCD,SHIP_COMPANY,SHIP_CRNO,SHIP_PERSON,SHIP_PHONE,SHIP_HP\n");
			arr_sql[1].append ("  ,CREATE_ID,CREATE_DATE,UPDATE_ID,UPDATE_DATE           \n");
			arr_sql[1].append (" )VALUES(                                          \n");
			arr_sql[1].append (" ?,?,?,?,?,  	                                   \n");
			arr_sql[1].append (" ?,?,?,?,?,?,?,  	                               \n");
			arr_sql[1].append (" ?,?,?,?,?,?,   	                               \n");
			arr_sql[1].append (" ?,?,?,?,?,?,   	                               \n");
			arr_sql[1].append (" ?,CURRENT_TIMESTAMP,?,CURRENT_TIMESTAMP           \n");
			arr_sql[1].append (" )                                                 \n");
			                                                                                     
			//UPDATE
			arr_sql[2].append ("  UPDATE OMS.T_OR0030 SET  \n");
			arr_sql[2].append ("  CAR_KIND=?    \n");
			arr_sql[2].append (" ,START_ADDR=?  \n");
			arr_sql[2].append (" ,START_NAME=?  \n");
			arr_sql[2].append (" ,START_INFO=?  \n");
			arr_sql[2].append (" ,END_ADDR=?    \n");
			arr_sql[2].append (" ,END_NAME=?    \n");
			arr_sql[2].append (" ,END_INFO=?    \n");
			arr_sql[2].append (" ,REMARK=?      \n");
			arr_sql[2].append (" ,TEMP_USE=?    \n");
			arr_sql[2].append (" ,WORK_CD=?     \n");
			arr_sql[2].append (" ,APP_VENDCD=?  \n");
			arr_sql[2].append (" ,APP_COMPANY=? \n");
			arr_sql[2].append (" ,APP_CRNO=?    \n");
			arr_sql[2].append (" ,APP_PERSON=?  \n");
			arr_sql[2].append (" ,APP_PHONE=?   \n");
			arr_sql[2].append (" ,APP_HP=?      \n");
			arr_sql[2].append (" ,SHIP_VENDCD=? \n");
			arr_sql[2].append (" ,SHIP_COMPANY=?\n");
			arr_sql[2].append (" ,SHIP_CRNO=?   \n");
			arr_sql[2].append (" ,SHIP_PERSON=? \n");
			arr_sql[2].append (" ,SHIP_PHONE=?  \n");
			arr_sql[2].append (" ,SHIP_HP=?     \n");
			arr_sql[2].append (" ,UPDATE_ID=?   \n");
			arr_sql[2].append (" ,UPDATE_DATE=CURRENT_TIMESTAMP \n");
			arr_sql[2].append ("  WHERE CAR_NO =? \n");
			arr_sql[2].append ("    AND INOUT_GB =? \n");
						
			//DELETE
			arr_sql[3].append (" DELETE FROM OMS.T_OR0030  \n");
			arr_sql[3].append ("  WHERE CAR_NO =?          \n");
			arr_sql[3].append ("    AND INOUT_GB =?        \n");
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
		
		String strUserid		= HDUtil.nullCheckStr(greq.getParameter("v_user_id"));
		
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
					
				int colNm_CAR_NO            = ds1.indexOfColumn("CAR_NO"); 
				int colNm_INOUT_GB          = ds1.indexOfColumn("INOUT_GB"); 
				int colNm_CAR_KIND          = ds1.indexOfColumn("CAR_KIND"); 
				int colNm_START_ADDR        = ds1.indexOfColumn("START_ADDR"); 
				int colNm_START_NAME        = ds1.indexOfColumn("START_NAME"); 
				int colNm_START_INFO        = ds1.indexOfColumn("START_INFO"); 
				int colNm_END_ADDR          = ds1.indexOfColumn("END_ADDR"); 
				int colNm_END_NAME          = ds1.indexOfColumn("END_NAME"); 
				int colNm_END_INFO          = ds1.indexOfColumn("END_INFO"); 
				int colNm_REMARK            = ds1.indexOfColumn("REMARK"); 
				int colNm_TEMP_USE          = ds1.indexOfColumn("TEMP_USE"); 
				int colNm_WORK_CD           = ds1.indexOfColumn("WORK_CD"); 
				int colNm_APP_VENDCD        = ds1.indexOfColumn("APP_VENDCD"); 
				int colNm_APP_COMPANY       = ds1.indexOfColumn("APP_COMPANY"); 
				int colNm_APP_CRNO          = ds1.indexOfColumn("APP_CRNO"); 
				int colNm_APP_PERSON        = ds1.indexOfColumn("APP_PERSON"); 
				int colNm_APP_PHONE         = ds1.indexOfColumn("APP_PHONE"); 
				int colNm_APP_HP            = ds1.indexOfColumn("APP_HP"); 
				int colNm_SHIP_VENDCD       = ds1.indexOfColumn("SHIP_VENDCD"); 
				int colNm_SHIP_COMPANY      = ds1.indexOfColumn("SHIP_COMPANY"); 
				int colNm_SHIP_CRNO         = ds1.indexOfColumn("SHIP_CRNO"); 
				int colNm_SHIP_PERSON       = ds1.indexOfColumn("SHIP_PERSON"); 
				int colNm_SHIP_PHONE        = ds1.indexOfColumn("SHIP_PHONE"); 
				int colNm_SHIP_HP           = ds1.indexOfColumn("SHIP_HP"); 
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
							cstmt.setString(2, rows[i].getString(colNm_INOUT_GB));
							cstmt.setString(3, rows[i].getString(colNm_CAR_KIND));
							cstmt.setString(4, rows[i].getString(colNm_START_ADDR));
							cstmt.setString(5, rows[i].getString(colNm_START_NAME));
							cstmt.setString(6, rows[i].getString(colNm_START_INFO));
							cstmt.setString(7, rows[i].getString(colNm_END_ADDR));
							cstmt.setString(8, rows[i].getString(colNm_END_NAME));
							cstmt.setString(9, rows[i].getString(colNm_END_INFO));
							cstmt.setString(10,rows[i].getString(colNm_REMARK));
							cstmt.setString(11,rows[i].getString(colNm_TEMP_USE));
							cstmt.setString(12,rows[i].getString(colNm_WORK_CD));
							cstmt.setString(13,rows[i].getString(colNm_APP_VENDCD));
							cstmt.setString(14,rows[i].getString(colNm_APP_COMPANY));
							cstmt.setString(15,rows[i].getString(colNm_APP_CRNO));
							cstmt.setString(16,rows[i].getString(colNm_APP_PERSON));
							cstmt.setString(17,rows[i].getString(colNm_APP_PHONE));
							cstmt.setString(18,rows[i].getString(colNm_APP_HP));
							cstmt.setString(19,rows[i].getString(colNm_SHIP_VENDCD));
							cstmt.setString(20,rows[i].getString(colNm_SHIP_COMPANY));
							cstmt.setString(21,rows[i].getString(colNm_SHIP_CRNO));
							cstmt.setString(22,rows[i].getString(colNm_SHIP_PERSON));
							cstmt.setString(23,rows[i].getString(colNm_SHIP_PHONE));
							cstmt.setString(24,rows[i].getString(colNm_SHIP_HP));
							cstmt.setString(25,strUserid);
							cstmt.setString(26,strUserid);
							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();		
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							
							cstmt = conn.prepareCall(arr_sql[2].toString());
							
							cstmt.setString(1, rows[i].getString(colNm_CAR_KIND));
							cstmt.setString(2, rows[i].getString(colNm_START_ADDR));
							cstmt.setString(3, rows[i].getString(colNm_START_NAME));
							cstmt.setString(4, rows[i].getString(colNm_START_INFO));
							cstmt.setString(5, rows[i].getString(colNm_END_ADDR));
							cstmt.setString(6, rows[i].getString(colNm_END_NAME));
							cstmt.setString(7, rows[i].getString(colNm_END_INFO));
							cstmt.setString(8, rows[i].getString(colNm_REMARK));
							cstmt.setString(9, rows[i].getString(colNm_TEMP_USE));
							cstmt.setString(10,rows[i].getString(colNm_WORK_CD));
							cstmt.setString(11,rows[i].getString(colNm_APP_VENDCD));
							cstmt.setString(12,rows[i].getString(colNm_APP_COMPANY));
							cstmt.setString(13,rows[i].getString(colNm_APP_CRNO));
							cstmt.setString(14,rows[i].getString(colNm_APP_PERSON));
							cstmt.setString(15,rows[i].getString(colNm_APP_PHONE));
							cstmt.setString(16,rows[i].getString(colNm_APP_HP));
							cstmt.setString(17,rows[i].getString(colNm_SHIP_VENDCD));
							cstmt.setString(18,rows[i].getString(colNm_SHIP_COMPANY));
							cstmt.setString(19,rows[i].getString(colNm_SHIP_CRNO));
							cstmt.setString(20,rows[i].getString(colNm_SHIP_PERSON));
							cstmt.setString(21,rows[i].getString(colNm_SHIP_PHONE));
							cstmt.setString(22,rows[i].getString(colNm_SHIP_HP));
							cstmt.setString(23,strUserid);
							cstmt.setString(24,rows[i].getString(colNm_CAR_NO));
							cstmt.setString(25,rows[i].getString(colNm_INOUT_GB));
															
							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();	
							break;
							
						case GauceDataRow.TB_JOB_DELETE:
							cstmt = conn.prepareCall(arr_sql[3].toString());
		
							cstmt.setString(1,rows[i].getString(colNm_CAR_NO));
							cstmt.setString(2,rows[i].getString(colNm_INOUT_GB));
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
			String v_keyword		= HDUtil.nullCheckStr(greq.getParameter("v_keyword"));//사업명
			String v_parm1	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm1")); //차량번호
			String v_parm2	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm2")); //반출 O, 반입 I
			String v_parm3	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm3")); //사용유무
		
			//System.out.println("v_keyword::::::::::::::"+v_keyword+":::::");
			//System.out.println("v_parm1::::::::::::::"+v_parm1+":::::");
			//System.out.println("v_parm2::::::::::::::"+v_parm2+":::::");
			//System.out.println("v_parm3::::::::::::::"+v_parm3+":::::");
			
			
			if(!v_parm1.equals(""))  arr_sql[0].append (" AND  CAR_NO LIKE ?  \n");
			if(!v_parm2.equals(""))  arr_sql[0].append (" AND  INOUT_GB = ?  \n");
			if(!v_parm3.equals(""))  arr_sql[0].append (" AND  TEMP_USE = ?  \n");
			
					
			switch(dsType) {
				case 1: //주문 MST
					
					//System.out.println("arr_sql[0].toString()"+arr_sql[0].toString());
					//쿼리 실행
					cstmt = conn.prepareCall(arr_sql[0].toString());
					
					cstmt.setString(1, v_keyword);
			
					int i_cnt=1;
					
					if(!v_parm1.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, "%"+v_parm1+"%");}
					if(!v_parm2.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, v_parm2);}	
					if(!v_parm3.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, v_parm3);}	
		
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
