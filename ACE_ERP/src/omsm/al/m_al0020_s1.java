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

public class m_al0020_s1 extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

			arr_sql[0].append (" SELECT A.AL_SID,     A.AL_SEQ,   A.INOUT_DATE,   A.LOGIS_GB,     A.INOUT_GB,    \n");
			arr_sql[0].append ("          A.ITEM_NAME,  A.CAR_KIND, A.CAR_NO,       A.DRV_ID,       A.WEIGHT,    \n");
			arr_sql[0].append ("          A.START_ADDR, C.DETAIL_NAME||' '||C.ITEM1 AS START_NAME,               \n");
			arr_sql[0].append ("          A.END_ADDR,   D.DETAIL_NAME||' '||D.ITEM1 AS END_NAME,                 \n");
			arr_sql[0].append ("          A.OUT_TIME,   A.IN_TIME,      A.REMARK,                                \n");
			arr_sql[0].append ("          A.STATUS,     A.ORDER_SID,A.ORDER_SEQ,  A.SHIP_COMPANY, A.SHIP_CRNO ,  \n");
			arr_sql[0].append ("          A.WORK_CD,                                                             \n");
			arr_sql[0].append ("          A.CREATE_ID,A.CREATE_DATE,A.UPDATE_ID, A.UPDATE_DATE, B.DRV_PHONE, A.AL_YN \n");
			arr_sql[0].append ("     FROM OMS.T_AL0020 A, OMS.T_AL0030 B, OMS.T_CO0030 C, OMS.T_CO0030 D         \n");
			arr_sql[0].append ("    WHERE 1=1                                                                    \n");
			arr_sql[0].append ("      AND A.DRV_ID = B.DRV_ID(+)                                                 \n");
			arr_sql[0].append ("      AND A.START_ADDR = C.DETAIL_CD(+) AND C.HEAD_CD(+) ='A016'                 \n");
			arr_sql[0].append ("      AND A.END_ADDR = D.DETAIL_CD(+) AND D.HEAD_CD(+) ='A016'                   \n");
					    
			
			
		    //UPDATE
			arr_sql[2].append ("  UPDATE OMS.T_AL0020 SET  \n");
			arr_sql[2].append ("   LOGIS_GB=?     \n");
			arr_sql[2].append ("  ,ITEM_NAME=?       \n");
			arr_sql[2].append ("  ,CAR_KIND=?       \n");
			arr_sql[2].append ("  ,DRV_ID=?       \n");
			arr_sql[2].append ("  ,START_ADDR=?   \n");
			arr_sql[2].append ("  ,END_ADDR=?     \n");
			arr_sql[2].append ("  ,SHIP_COMPANY=? \n");
			arr_sql[2].append ("  ,SHIP_CRNO=?    \n");
			arr_sql[2].append ("  ,REMARK =?    \n");
			arr_sql[2].append ("  ,AL_YN =?    \n");
			arr_sql[2].append ("  ,UPDATE_ID=?    \n");
			arr_sql[2].append ("  ,UPDATE_DATE=CURRENT_TIMESTAMP \n");
			arr_sql[2].append ("  WHERE AL_SID =? \n");
			arr_sql[2].append ("    AND AL_SEQ =? \n");
			
			
			
			arr_sql[3].append ("  INSERT INTO OMS.T_AL0010 (  \n");
			arr_sql[3].append ("   AL_SID, AL_SEQ, AL_HIS_SEQ,   \n");
			arr_sql[3].append ("   B_LOGIS_GB, B_ITEM_NAME, B_CAR_KIND, B_SHIP_COMPANY, B_START_ADDR, B_END_ADDR, B_DRV_ID, B_REMARK, B_AL_YN,  \n");
			arr_sql[3].append ("   A_LOGIS_GB, A_ITEM_NAME, A_CAR_KIND, A_SHIP_COMPANY, A_START_ADDR, A_END_ADDR, A_DRV_ID, A_REMARK, A_AL_YN,  \n");
			arr_sql[3].append ("   CREATE_ID, CREATE_DATE   \n");
			arr_sql[3].append ("  ) VALUES (    \n");
			arr_sql[3].append ("   ?,?,?, \n");
			arr_sql[3].append ("   ?,?,?,?,?,?,?,?,?,  \n");
			arr_sql[3].append ("   ?,?,?,?,?,?,?,?,?,  \n");
			arr_sql[3].append ("   ?,  CURRENT_TIMESTAMP    \n");
			arr_sql[3].append ("  )     \n");
			
			
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
		GauceDataSet ds1 = gis.read("DS_DEFAULT");  //배차관리
		GauceDataSet ds2 = gis.read("DS_DEFAULT2"); //이력관리
		
		Statement stmt1 = null;
		ResultSet rs1 = null;
		
		//String strLogis_sts		= HDUtil.nullCheckStr(greq.getParameter("v_logis_sts"));
		String strUser_id	= HDUtil.nullCheckStr(greq.getParameter("v_user_id"));
		//String strAl_Sid	= HDUtil.nullCheckStr(greq.getParameter("v_al_sid"));
		//String strAl_Seq	= HDUtil.nullCheckStr(greq.getParameter("v_al_seq"));
		
		int intAl_His_Seq =0;
		
			
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
																
														
							//System.out.println("arr_sql[2].toString()"+arr_sql[2].toString());
							
							//System.out.println("strLogis_sts"+strLogis_sts);  
							//System.out.println("strUser_id"+strUser_id);  
							//System.out.println("rows[i].getString(colNm_ACC_ORD_SID)"+rows[i].getString(colNm_ACC_ORD_SID));  
						
							cstmt = conn.prepareCall(arr_sql[2].toString());
							
							cstmt.setString(1, rows[i].getString(colNm_LOGIS_GB));
							cstmt.setString(2, rows[i].getString(colNm_ITEM_NAME));
							cstmt.setString(3, rows[i].getString(colNm_CAR_KIND));
							
							cstmt.setString(4, rows[i].getString(colNm_DRV_ID));
							cstmt.setString(5, rows[i].getString(colNm_START_ADDR));
							cstmt.setString(6, rows[i].getString(colNm_END_ADDR));
							cstmt.setString(7, rows[i].getString(colNm_SHIP_COMPANY));
							cstmt.setString(8, rows[i].getString(colNm_SHIP_CRNO));
							cstmt.setString(9, rows[i].getString(colNm_REMARK));
							cstmt.setString(10, rows[i].getString(colNm_AL_YN));
							cstmt.setString(11, strUser_id);
							cstmt.setString(12, rows[i].getString(colNm_AL_SID));
							cstmt.setDouble(13, rows[i].getDouble(colNm_AL_SEQ));

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
			
			
			if (ds2 != null) {  
				GauceDataRow[] 		rows2 = ds2.getDataRows();
					
				int colNm_AL_SID                             = ds2.indexOfColumn("AL_SID"); 	       //배차SID       
				int colNm_AL_SEQ                             = ds2.indexOfColumn("AL_SEQ"); 		   //순번          
				int colNm_AL_HIS_SEQ                         = ds2.indexOfColumn("AL_HIS_SEQ"); 	   //배차이력순번  
				int colNm_B_LOGIS_GB                         = ds2.indexOfColumn("B_LOGIS_GB"); 	   //수정전물류구분
				int colNm_B_ITEM_NAME                        = ds2.indexOfColumn("B_ITEM_NAME"); 	   //수정전대표품목
				int colNm_B_CAR_KIND                         = ds2.indexOfColumn("B_CAR_KIND"); 	   //수정전차량종류
				int colNm_B_SHIP_COMPANY                     = ds2.indexOfColumn("B_SHIP_COMPANY");    //수정전화주명  
				int colNm_B_START_ADDR                       = ds2.indexOfColumn("B_START_ADDR"); 	   //수정전상차지  
				int colNm_B_END_ADDR                         = ds2.indexOfColumn("B_END_ADDR"); 	   //수정전하차지  
				int colNm_B_DRV_ID                           = ds2.indexOfColumn("B_DRV_ID"); 		   //수정전운전자ID
				int colNm_B_REMARK                           = ds2.indexOfColumn("B_REMARK"); 		   //수정전비고내역
				int colNm_B_AL_YN                            = ds2.indexOfColumn("B_AL_YN"); 		   //수정전배차유무
				int colNm_A_LOGIS_GB                         = ds2.indexOfColumn("A_LOGIS_GB"); 	   //수정후물류구분
				int colNm_A_ITEM_NAME                        = ds2.indexOfColumn("A_ITEM_NAME"); 	   //수정후대표품목
				int colNm_A_CAR_KIND                         = ds2.indexOfColumn("A_CAR_KIND"); 	   //수정후차량종류
				int colNm_A_SHIP_COMPANY                     = ds2.indexOfColumn("A_SHIP_COMPANY");    //수정후화주명  
				int colNm_A_START_ADDR                       = ds2.indexOfColumn("A_START_ADDR"); 	   //수정후상차지  
				int colNm_A_END_ADDR                         = ds2.indexOfColumn("A_END_ADDR"); 	   //수정후하차지  
				int colNm_A_DRV_ID                           = ds2.indexOfColumn("A_DRV_ID"); 		   //수정후운전자ID
				int colNm_A_REMARK                           = ds2.indexOfColumn("A_REMARK"); 		   //수정후내역    
				int colNm_A_AL_YN                            = ds2.indexOfColumn("A_AL_YN"); 		   //수정후배차유무
				int colNm_CREATE_ID                          = ds2.indexOfColumn("CREATE_ID"); 		   //입력자ID      
				//int colNm_CREATE_DATE                        = ds2.indexOfColumn("CREATE_DATE"); 	   //입력일자      
				
				for(int i=0; i<rows2.length; i++){
					
					
					
					StringBuffer sql = new StringBuffer();
					
					sql.append( " SELECT NVL(MAX(AL_HIS_SEQ),0)+1 AS AL_HIS_SEQ \n");
					sql.append( "   FROM OMS.T_AL0010 	                        \n");
					sql.append( "  WHERE AL_SID='"+rows2[i].getString(colNm_AL_SID)+"'\n");
					sql.append( "    AND AL_SEQ="+ rows2[i].getDouble(colNm_AL_SEQ)+" \n");
					
					//System.out.println("sql::"+sql.toString());
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(sql.toString());

					while(rs1.next())	{
						intAl_His_Seq = rs1.getInt(1);
					}
					//System.out.println("strOrder_Sid00::"+strOrder_Sid);
					rs1.close();
					stmt1.close();
					
					
					//int j=1;
					switch(rows2[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							//System.out.println("arr_sql[3].toString()"+arr_sql[3].toString());
							
							cstmt = conn.prepareCall(arr_sql[3].toString());
							
							cstmt.setString(1, rows2[i].getString(colNm_AL_SID));
							cstmt.setString(2, rows2[i].getString(colNm_AL_SEQ));
							cstmt.setInt(3, intAl_His_Seq);
							cstmt.setString(4, rows2[i].getString(colNm_B_LOGIS_GB));
							cstmt.setString(5, rows2[i].getString(colNm_B_ITEM_NAME));
							cstmt.setString(6, rows2[i].getString(colNm_B_CAR_KIND));
							cstmt.setString(7, rows2[i].getString(colNm_B_SHIP_COMPANY));
							cstmt.setString(8, rows2[i].getString(colNm_B_START_ADDR));
							cstmt.setString(9, rows2[i].getString(colNm_B_END_ADDR));
							cstmt.setString(10, rows2[i].getString(colNm_B_DRV_ID));
							cstmt.setString(11, rows2[i].getString(colNm_B_REMARK));
							cstmt.setString(12, rows2[i].getString(colNm_B_AL_YN));
							cstmt.setString(13, rows2[i].getString(colNm_A_LOGIS_GB));
							cstmt.setString(14, rows2[i].getString(colNm_A_ITEM_NAME));
							cstmt.setString(15, rows2[i].getString(colNm_A_CAR_KIND));
							cstmt.setString(16, rows2[i].getString(colNm_A_SHIP_COMPANY));
							cstmt.setString(17, rows2[i].getString(colNm_A_START_ADDR));
							cstmt.setString(18, rows2[i].getString(colNm_A_END_ADDR));
							cstmt.setString(19, rows2[i].getString(colNm_A_DRV_ID));
							cstmt.setString(20, rows2[i].getString(colNm_A_REMARK));
							cstmt.setString(21, rows2[i].getString(colNm_A_AL_YN));
							cstmt.setString(22, strUser_id);
							
							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();		
							
							break;
							
						case GauceDataRow.TB_JOB_UPDATE:
																
														
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
			}//if (ds2 != null) {
			
				
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
			String v_parm2	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm2")); //정산년월 to
			String v_parm3	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm3")); //실화주사업자번호
			String v_parm4	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm4")); //실화주명
			String v_parm6	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm6")); //사업명
			String v_parm7	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm7")); //반출입구분
						
			if(!v_parm1.equals(""))    arr_sql[0].append (" AND  A.INOUT_DATE BETWEEN  ?  AND ?  \n");			
			if(!v_parm3.equals(""))    arr_sql[0].append (" AND  A.SHIP_CRNO = ?  \n");
			if(!v_parm4.equals(""))    arr_sql[0].append (" AND  A.SHIP_COMPANY LIKE ? \n");
			if(!v_parm6.equals(""))    arr_sql[0].append (" AND  A.WORK_CD=? \n");
			if(!v_parm7.equals(""))    arr_sql[0].append (" AND  A.INOUT_GB=? \n");
			
			arr_sql[0].append ("     ORDER BY  A.AL_SID, A.AL_SEQ  \n");
						
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
					if(!v_parm2.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, v_parm2);}
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
