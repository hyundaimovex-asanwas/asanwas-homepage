package omsm.or;
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

public class m_or0020_s2 extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		    //주문조회
			arr_sql[0].append (" SELECT A.ORDER_SID,A.ORDER_SEQ,A.CAR_KIND,A.ITEM_NAME,A.START_ADDR    \n");
			arr_sql[0].append ("       ,A.START_NAME,A.START_INFO,A.END_ADDR,A.END_NAME,A.END_INFO     \n");
			arr_sql[0].append ("       ,A.PALLET_CNT,A.REMARK                                          \n");
			arr_sql[0].append ("       ,A.CREATE_ID,A.CREATE_DATE,A.UPDATE_ID,A.UPDATE_DATE            \n");
			arr_sql[0].append ("       ,B.INOUT_GB, B.ORDER_STS, B.WORK_CD, B.INOUT_DATE, B.PURPOSE    \n");
			arr_sql[0].append ("       ,B.APP_COMPANY,B.APP_CRNO, B.SHIP_COMPANY, 'F' CHK              \n");
			arr_sql[0].append ("  FROM OMS.T_OR0020 A, OMS.T_OR0010 B                                  \n");
			arr_sql[0].append (" WHERE A.ORDER_SID = B.ORDER_SID                                       \n");
			
			//주문내역 INSERT
			arr_sql[1].append (" INSERT INTO OMS.T_OR0040                                                                  \n");
			arr_sql[1].append (" SELECT A.ORDER_SID||A.ORDER_SEQ ACC_ORD_SID, B.WORK_CD,B.INOUT_GB,B.INOUT_DATE,A.CAR_KIND \n");
			arr_sql[1].append ("       ,A.ITEM_NAME,A.START_ADDR,A.START_NAME,A.START_INFO,A.END_ADDR                      \n");
			arr_sql[1].append ("       ,A.END_NAME,A.END_INFO,B.SHIP_CRNO,B.SHIP_COMPANY,A.PALLET_CNT                      \n");
			arr_sql[1].append ("       ,A.ORDER_SID,A.ORDER_SEQ,B.ORDER_STS,'1' LOGIS_STS,  B.ORDER_GB                     \n");
			arr_sql[1].append ("       ,'6070001',CURRENT_TIMESTAMP ,'6070001',CURRENT_TIMESTAMP                           \n");
			arr_sql[1].append ("   FROM OMS.T_OR0020 A, OMS.T_OR0010 B                                                     \n");
			arr_sql[1].append ("  WHERE A.ORDER_SID = B.ORDER_SID                                                          \n");
			//arr_sql[1].append ("    AND B.INOUT_GB ='O'                                                                    \n");
			arr_sql[1].append ("    AND A.ORDER_SID =?                                                                     \n");

						
			//주문MST UPDATE 
			arr_sql[3].append (" UPDATE OMS.T_OR0010 SET    \n");
			arr_sql[3].append ("  ORDER_STS=?    \n");
			arr_sql[3].append (" ,UPDATE_ID=?    \n");
			arr_sql[3].append (" ,UPDATE_DATE=CURRENT_TIMESTAMP \n");
			arr_sql[3].append (" WHERE ORDER_SID =? \n");
			
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
		String strOrder_sts		= HDUtil.nullCheckStr(greq.getParameter("v_order_sts"));
		
		Statement stmt1 = null;
		ResultSet rs1 = null;
		//System.out.println("strOrder_Sid0::"+strOrder_Sid);
		//ORDER_SID가 없을 경우 채번
		
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
					
				int colNm_ORDER_SID           = ds1.indexOfColumn("ORDER_SID");        //
				int colNm_ORDER_SEQ           = ds1.indexOfColumn("ORDER_SEQ");        //
				int colNm_ORDER_STS           = ds1.indexOfColumn("ORDER_STS");        //
				int colNm_UPDATE_ID           = ds1.indexOfColumn("UPDATE_ID");        //
								
				for(int i=0; i<rows.length; i++){
						
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:		
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							
						
							
							if(i>0){
								//System.out.println("rows[i-1]::"+rows[i-1].getString(colNm_ORDER_SID));
								if(rows[i-1].getString(colNm_ORDER_SID).equals(rows[i].getString(colNm_ORDER_SID))){
									break;
								}
							}
							
							//UPDATE 
							cstmt = conn.prepareCall(arr_sql[3].toString());
							
							cstmt.setString(1,strOrder_sts);
							cstmt.setString(2,strUserid);
							cstmt.setString(3,rows[i].getString(colNm_ORDER_SID));	
							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();
							
							
							//INSERT
							cstmt = conn.prepareCall(arr_sql[1].toString());	
							cstmt.setString(1,rows[i].getString(colNm_ORDER_SID));	
							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();	
								
							break;
							
						case GauceDataRow.TB_JOB_DELETE:
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
            //if(stmt!=null) stmt.close();			
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
			//System.out.println("1");
			
			int dsType 				= HDUtil.nullCheckNum(greq.getParameter("dsType"));
			String v_keyword		= HDUtil.nullCheckStr(greq.getParameter("v_keyword")); //반출 O, 반입 I
			String v_parm1	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm1")); //사업명
			String v_parm2	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm2")); //반출일자 FR
			String v_parm3	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm3")); //반출일자 TO 
			String v_parm4	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm4")); //주문상태
			String v_parm5	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm5")); //반출주문번호
			String v_parm6	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm6")); //신청업체명
			String v_parm7	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm7")); //실화주명 
			//String v_parm8	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm8")); //APP_CRNO -- 신청화주 사업자 번호 //해당 사업자 번호
			String v_parm9	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm9")); //권한 
			/*
			System.out.println("v_keyword::::::::::::::"+v_keyword+":::::");
			System.out.println("v_parm1::::::::::::::"+v_parm1+":::::");
			System.out.println("v_parm2::::::::::::::"+v_parm2+":::::");
			System.out.println("v_parm3::::::::::::::"+v_parm3+":::::");
			System.out.println("v_parm4::::::::::::::"+v_parm4+":::::");
			System.out.println("v_parm5::::::::::::::"+v_parm5+":::::");
			System.out.println("v_parm6::::::::::::::"+v_parm6+":::::");
			System.out.println("v_parm7::::::::::::::"+v_parm7+":::::");
			System.out.println("v_parm8::::::::::::::"+v_parm8+":::::");
			*/
			if(!v_keyword.equals(""))arr_sql[0].append (" AND  B.INOUT_GB=?\n");
			if(!v_parm1.equals(""))  arr_sql[0].append (" AND  B.WORK_CD=? \n");
			if(!v_parm4.equals(""))  arr_sql[0].append (" AND  B.ORDER_STS= ? \n");
			if(!v_parm5.equals(""))  arr_sql[0].append (" AND  B.ORDER_SID= ? \n");
			if(!v_parm6.equals(""))  arr_sql[0].append (" AND  A.APP_COMPANY LIKE ? \n");
			if(!v_parm7.equals(""))  arr_sql[0].append (" AND  A.SHIP_COMPANY LIKE ? \n");
			if(!v_parm2.equals("")&&!v_parm3.equals(""))arr_sql[0].append (" AND  B.INOUT_DATE BETWEEN ? AND ? \n");
			//if(!v_parm8.equals(""))  arr_sql[0].append (" AND  B.APP_CRNO = ? \n");
			
			if(!v_parm9.equals(""))  arr_sql[0].append (" AND  B.CREATE_ID = ? \n");
			arr_sql[0].append (" ORDER BY B.INOUT_DATE DESC, A.ORDER_SID, A.ORDER_SEQ \n");
			
			switch(dsType) {
				case 1: //주문 MST
					
					//System.out.println("arr_sql[0].toString()"+arr_sql[0].toString());
					//쿼리 실행
					cstmt = conn.prepareCall(arr_sql[0].toString());
					
					int i_cnt=0;
					
					if(!v_keyword.equals("")){i_cnt+=1;	cstmt.setString(i_cnt, v_keyword);}
					if(!v_parm1.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, v_parm1);}
					if(!v_parm4.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, v_parm4);}	
					if(!v_parm5.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, v_parm5);}
					if(!v_parm6.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, "%"+v_parm6+"%");}
					if(!v_parm7.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, "%"+v_parm7+"%");}			
					if(!v_parm2.equals("")&&!v_parm3.equals("")){	
						i_cnt+=1;	cstmt.setString(i_cnt, v_parm2);
						i_cnt+=1;	cstmt.setString(i_cnt, v_parm3);
					}					
					if(!v_parm9.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, v_parm9);}
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
