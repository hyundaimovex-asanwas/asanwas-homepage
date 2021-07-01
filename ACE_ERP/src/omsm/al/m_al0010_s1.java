package omsm.al;
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


public class m_al0010_s1 extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

			arr_sql[0].append ("  SELECT A.AL_SID,    A.AL_SEQ,   A.INOUT_DATE, A.LOGIS_GB,     A.INOUT_GB, \n");
			arr_sql[0].append ("         A.ITEM_NAME, A.CAR_KIND, A.CAR_NO,     A.DRV_ID,       A.WEIGHT,   \n");
			arr_sql[0].append ("         A.START_ADDR,A.END_ADDR, A.OUT_TIME,   A.IN_TIME,      A.REMARK,   \n");
			arr_sql[0].append ("         A.STATUS,    A.ORDER_SID,A.ORDER_SEQ,  A.SHIP_COMPANY, A.SHIP_CRNO, \n");
			arr_sql[0].append ("         A.WORK_CD,   A.AL_YN,                                               \n");
			arr_sql[0].append ("         A.CREATE_ID,A.CREATE_DATE,A.UPDATE_ID,A.UPDATE_DATE , B.DRV_PHONE\n");
			arr_sql[0].append ("    FROM OMS.T_AL0020 A,  OMS.T_AL0030 B                          \n");
			arr_sql[0].append ("   WHERE A.DRV_ID = B.DRV_ID(+)                                   \n");
					    
		    
			arr_sql[1].append ("INSERT INTO OMS.T_AL0020 (                                     \n");
			arr_sql[1].append ("  AL_SID,    AL_SEQ,   INOUT_DATE, LOGIS_GB,     INOUT_GB,     \n");
			arr_sql[1].append ("  ITEM_NAME, CAR_KIND,  CAR_NO,     DRV_ID,       WEIGHT,      \n");
			arr_sql[1].append ("  START_ADDR,END_ADDR,  OUT_TIME,   IN_TIME,      REMARK,      \n");
			arr_sql[1].append ("  STATUS,    ORDER_SID, ORDER_SEQ,  SHIP_COMPANY, SHIP_CRNO,   \n");
			arr_sql[1].append ("  WORK_CD,   AL_YN,   \n");
			arr_sql[1].append ("  CREATE_ID,     CREATE_DATE,    UPDATE_ID,   UPDATE_DATE     \n");
			arr_sql[1].append (" )VALUES(                                                     \n");
			arr_sql[1].append ("  ?,?,?,?,?,          \n");
			arr_sql[1].append ("  ?,?,?,?,?,          \n");
			arr_sql[1].append ("  ?,?,?,?,?,          \n");
			arr_sql[1].append ("  ?,?,?,?,?,          \n");
			arr_sql[1].append ("  ?,?,                \n");
			arr_sql[1].append ("  ?,CURRENT_TIMESTAMP,?,CURRENT_TIMESTAMP  \n");
			arr_sql[1].append (") \n");
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
		
		Statement stmt1 = null;
		ResultSet rs1 = null;
		
		//String strLogis_sts		= HDUtil.nullCheckStr(greq.getParameter("v_logis_sts"));
		String strUser_id	= HDUtil.nullCheckStr(greq.getParameter("v_user_id"));
		String strAl_Sid	= HDUtil.nullCheckStr(greq.getParameter("v_al_sid"));
		String strStatus ="0";
		
		if(strAl_Sid.equals("")){
			StringBuffer sql = new StringBuffer();
			
			sql.append( " SELECT 'B'||TO_CHAR(CURRENT_DATE,'YYYYMMDD')||LPAD(TO_NUMBER(NVL(MAX(SUBSTR(AL_SID,10)),0))+1,4,'0') \n");
			sql.append( "   FROM OMS.T_AL0020 	                                                     \n");
			sql.append( "  WHERE AL_SID LIKE 'B'||TO_CHAR(CURRENT_DATE,'YYYYMMDD')||'%'   \n");
			
			
			//System.out.println("sql::"+sql.toString());
			stmt1 = conn.createStatement();
			rs1 = stmt1.executeQuery(sql.toString());

			while(rs1.next())	{
				strAl_Sid = rs1.getString(1);
			}
			//System.out.println("strOrder_Sid00::"+strOrder_Sid);
			rs1.close();
			stmt1.close();
		}
		
		
				 
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
					
				int colNm_AL_SID                     = ds1.indexOfColumn("AL_SID"); 	
				int colNm_AL_SEQ                     = ds1.indexOfColumn("AL_SEQ"); 	
				int colNm_INOUT_DATE                 = ds1.indexOfColumn("INOUT_DATE"); 	
				int colNm_LOGIS_GB                   = ds1.indexOfColumn("LOGIS_GB"); 	
				int colNm_INOUT_GB                   = ds1.indexOfColumn("INOUT_GB"); 	
				int colNm_ITEM_NAME                  = ds1.indexOfColumn("ITEM_NAME"); 	
				int colNm_CAR_KIND                   = ds1.indexOfColumn("CAR_KIND"); 	
				int colNm_CAR_NO                     = ds1.indexOfColumn("CAR_NO"); 	
				int colNm_DRV_ID                     = ds1.indexOfColumn("DRV_ID"); 	
				int colNm_WEIGHT                     = ds1.indexOfColumn("WEIGHT"); 	
				int colNm_START_ADDR                 = ds1.indexOfColumn("START_ADDR"); 	
				int colNm_END_ADDR                   = ds1.indexOfColumn("END_ADDR"); 	
				int colNm_OUT_TIME                   = ds1.indexOfColumn("OUT_TIME"); 	
				int colNm_IN_TIME                    = ds1.indexOfColumn("IN_TIME"); 	
				int colNm_REMARK                     = ds1.indexOfColumn("REMARK"); 	
				int colNm_STATUS                     = ds1.indexOfColumn("STATUS"); 	
				int colNm_ORDER_SID                  = ds1.indexOfColumn("ORDER_SID"); 	
				int colNm_ORDER_SEQ                  = ds1.indexOfColumn("ORDER_SEQ"); 	
				int colNm_SHIP_COMPANY               = ds1.indexOfColumn("SHIP_COMPANY"); 	
				int colNm_SHIP_CRNO                  = ds1.indexOfColumn("SHIP_CRNO"); 	
				int colNm_WORK_CD                    = ds1.indexOfColumn("WORK_CD"); 
				int colNm_AL_YN                      = ds1.indexOfColumn("AL_YN");
				int colNm_CREATE_ID                  = ds1.indexOfColumn("CREATE_ID"); 	
				int colNm_CREATE_DATE                = ds1.indexOfColumn("CREATE_DATE"); 	
				int colNm_UPDATE_ID                  = ds1.indexOfColumn("UPDATE_ID"); 	
				int colNm_UPDATE_DATE                = ds1.indexOfColumn("UPDATE_DATE"); 	
				
				
				
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
																
														
							//System.out.println("arr_sql[2].toString()"+arr_sql[1].toString());
							
							//System.out.println("strLogis_sts"+strLogis_sts);  
							//System.out.println("strUser_id"+strUser_id);  
							//System.out.println("rows[i].getString(colNm_ACC_ORD_SID)"+rows[i].getString(colNm_ACC_ORD_SID));  
							
							cstmt = conn.prepareCall(arr_sql[1].toString());
							cstmt.setString(1, strAl_Sid);
							cstmt.setDouble(2,  i+1);
							cstmt.setString(3,  rows[i].getString(colNm_INOUT_DATE));
							cstmt.setString(4,  rows[i].getString(colNm_LOGIS_GB));
							cstmt.setString(5,  rows[i].getString(colNm_INOUT_GB));
							cstmt.setString(6,  rows[i].getString(colNm_ITEM_NAME));
							cstmt.setString(7,  rows[i].getString(colNm_CAR_KIND));
							cstmt.setString(8,  rows[i].getString(colNm_CAR_NO));
							cstmt.setString(9,  rows[i].getString(colNm_DRV_ID));
							cstmt.setString(10, rows[i].getString(colNm_WEIGHT));
							cstmt.setString(11, rows[i].getString(colNm_START_ADDR));
							cstmt.setString(12, rows[i].getString(colNm_END_ADDR));
							cstmt.setString(13, rows[i].getString(colNm_OUT_TIME));
							cstmt.setString(14, rows[i].getString(colNm_IN_TIME));
							cstmt.setString(15, rows[i].getString(colNm_REMARK));
							cstmt.setString(16, strStatus);
							cstmt.setString(17, rows[i].getString(colNm_ORDER_SID));
							cstmt.setDouble(18, rows[i].getDouble(colNm_ORDER_SEQ));
							cstmt.setString(19, rows[i].getString(colNm_SHIP_COMPANY));
							cstmt.setString(20, rows[i].getString(colNm_SHIP_CRNO));
							cstmt.setString(21, rows[i].getString(colNm_WORK_CD));
							cstmt.setString(22, rows[i].getString(colNm_AL_YN));
							cstmt.setString(23, strUser_id);
							cstmt.setString(24, strUser_id);

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
						
			if(!v_parm1.equals(""))    arr_sql[0].append (" AND  A.INOUT_DATE BETWEEN  ?  AND ?  \n");			
			if(!v_parm3.equals(""))    arr_sql[0].append (" AND  A.SHIP_CRNO = ?  \n");
			if(!v_parm4.equals(""))    arr_sql[0].append (" AND  A.SHIP_COMPANY LIKE ? \n");
			if(!v_parm6.equals(""))    arr_sql[0].append (" AND  A.WORK_CD=? \n");
			if(!v_parm7.equals(""))    arr_sql[0].append (" AND  A.INOUT_GB=? \n");
						
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
					
					if(!v_parm1.equals(""))  {
						i_cnt+=1;	cstmt.setString(i_cnt, v_parm1+"01");
						i_cnt+=1;	cstmt.setString(i_cnt, v_parm1+"31");
					}
					
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
