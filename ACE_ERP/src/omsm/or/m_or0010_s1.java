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

public class m_or0010_s1 extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		    //주문MST SELECT
			arr_sql[0].append (" SELECT ORDER_SID,INOUT_GB,ORDER_STS,WORK_CD,INOUT_DATE,PURPOSE,REMARK  \n");
			arr_sql[0].append ("       ,APP_VENDCD,APP_COMPANY,APP_CRNO,APP_PERSON,APP_PHONE,APP_HP     \n");
			arr_sql[0].append ("       ,SHIP_VENDCD,SHIP_COMPANY,SHIP_CRNO                              \n");
			arr_sql[0].append ("       ,SHIP_PERSON,SHIP_PHONE,SHIP_HP,ORDER_GB                         \n");
			arr_sql[0].append ("       ,CREATE_ID,CREATE_DATE,UPDATE_ID,UPDATE_DATE                     \n");
			arr_sql[0].append ("   FROM OMS.T_OR0010                                                    \n");
			arr_sql[0].append ("  WHERE ORDER_SID = ?                                                   \n");
			
			
			//주문DTL SELECT 
			arr_sql[1].append (" SELECT ORDER_SID,ORDER_SEQ,CAR_KIND,ITEM_NAME,START_ADDR    \n");
			arr_sql[1].append (" 	   ,START_NAME,START_INFO,END_ADDR,END_NAME,END_INFO     \n");
			arr_sql[1].append ("       ,PALLET_CNT,REMARK                                    \n");
			arr_sql[1].append ("       ,CREATE_ID,CREATE_DATE,UPDATE_ID,UPDATE_DATE          \n");
			arr_sql[1].append ("       ,CASE WHEN CAR_KIND='10' THEN '#9FF781' ELSE '' END COLOR1  \n");
			arr_sql[1].append ("   FROM OMS.T_OR0020                                         \n");
			arr_sql[1].append ("  WHERE ORDER_SID = ?                                        \n");
			
			
			//주문MST INSERT
			arr_sql[2].append (" INSERT INTO OMS.T_OR0010(                                             \n");
			arr_sql[2].append ("  ORDER_SID,INOUT_GB,ORDER_STS,WORK_CD,INOUT_DATE,PURPOSE,REMARK       \n");
			arr_sql[2].append (" ,APP_VENDCD,APP_COMPANY,APP_CRNO,APP_PERSON,APP_PHONE,APP_HP          \n");
			arr_sql[2].append (" ,SHIP_VENDCD,SHIP_COMPANY,SHIP_CRNO,SHIP_PERSON,SHIP_PHONE,SHIP_HP,ORDER_GB    \n");
			arr_sql[2].append (" ,CREATE_ID,CREATE_DATE,UPDATE_ID,UPDATE_DATE                          \n");
			arr_sql[2].append (" )VALUES(                                                              \n");
			arr_sql[2].append (" ?,?,?,?,?,?,?,	                                                       \n");
			arr_sql[2].append (" ?,?,?,?,?,?,	                                                       \n");
			arr_sql[2].append (" ?,?,?,?,?,?,?,	                                                       \n");
			arr_sql[2].append (" ?,CURRENT_TIMESTAMP,?,CURRENT_TIMESTAMP                               \n");
			arr_sql[2].append (" )                                                                     \n");
			
			//주문MST UPDATE 
			arr_sql[3].append ("  UPDATE OMS.T_OR0010 SET    \n");
			arr_sql[3].append ("  ORDER_STS=?    \n");
			arr_sql[3].append (" ,WORK_CD=?      \n");
			arr_sql[3].append (" ,INOUT_DATE=?   \n");
			arr_sql[3].append (" ,PURPOSE=?      \n");
			arr_sql[3].append (" ,REMARK=?       \n");
			arr_sql[3].append (" ,APP_VENDCD=?   \n");
			arr_sql[3].append (" ,APP_COMPANY=?  \n");
			arr_sql[3].append (" ,APP_CRNO=?     \n");
			arr_sql[3].append (" ,APP_PERSON=?   \n");
			arr_sql[3].append (" ,APP_PHONE=?    \n");
			arr_sql[3].append (" ,APP_HP=?       \n");
			arr_sql[3].append (" ,SHIP_VENDCD=?  \n");
			arr_sql[3].append (" ,SHIP_COMPANY=? \n");
			arr_sql[3].append (" ,SHIP_CRNO=?    \n");
			arr_sql[3].append (" ,SHIP_PERSON=?  \n");
			arr_sql[3].append (" ,SHIP_PHONE=?   \n");
			arr_sql[3].append (" ,SHIP_HP=?      \n");
			arr_sql[3].append (" ,UPDATE_ID=?    \n");
			arr_sql[3].append (" ,UPDATE_DATE=CURRENT_TIMESTAMP \n");
			arr_sql[3].append (" WHERE ORDER_SID =? \n");
			
			//주문MST DELETE
			arr_sql[4].append (" DELETE FROM OMS.T_OR0010  \n");
			arr_sql[4].append (" WHERE ORDER_SID =?        \n");
						
			//주문DTL INSERT
			arr_sql[5].append (" INSERT INTO OMS.T_OR0020(   \n");
			arr_sql[5].append (" ORDER_SID,ORDER_SEQ,CAR_KIND,ITEM_NAME,START_ADDR\n");
			arr_sql[5].append (",START_NAME,START_INFO,END_ADDR,END_NAME,END_INFO \n");
			arr_sql[5].append (",PALLET_CNT,REMARK   \n");
			arr_sql[5].append (",CREATE_ID,CREATE_DATE,UPDATE_ID,UPDATE_DATE  \n");
			arr_sql[5].append (" )VALUES(\n");
			arr_sql[5].append (" ?,?,?,?,?,\n");
			arr_sql[5].append (" ?,?,?,?,?,\n");
			arr_sql[5].append (" ?,?,?,CURRENT_TIMESTAMP,?,CURRENT_TIMESTAMP\n");
			arr_sql[5].append (") \n");
			
			//주문DTL UPDATE 
			arr_sql[6].append (" UPDATE OMS.T_OR0020 SET   \n");
			arr_sql[6].append (" CAR_KIND=?      \n");
			arr_sql[6].append (",ITEM_NAME=?     \n");
			arr_sql[6].append (",START_ADDR=?    \n");
			arr_sql[6].append (",START_NAME=?    \n");
			arr_sql[6].append (",START_INFO=?    \n");
			arr_sql[6].append (",END_ADDR=?      \n");
			arr_sql[6].append (",END_NAME=?      \n");
			arr_sql[6].append (",END_INFO=?      \n");
			arr_sql[6].append (",PALLET_CNT=?    \n");
			arr_sql[6].append (",REMARK=?        \n");
			arr_sql[6].append (",UPDATE_ID=?     \n");
			arr_sql[6].append (",UPDATE_DATE=CURRENT_TIMESTAMP   \n");
			arr_sql[6].append (" WHERE ORDER_SID =? \n");
			arr_sql[6].append ("   AND ORDER_SEQ=?  \n");
			
			//주문DTL DELETE
			arr_sql[7].append (" DELETE FROM OMS.T_OR0020 \n");
			arr_sql[7].append ("  WHERE ORDER_SID =? \n");
			arr_sql[7].append ("    AND ORDER_SEQ =? \n");
			
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
		GauceDataSet ds2 = gis.read("DS_DEFAULT2");
		GauceDataSet ds3 = gis.read("DS_RETURN");
		
		//System.out.println("ds1::"+ds1);
		//System.out.println("ds2::"+ds2);
		//System.out.println("ds3::"+ds3);

		String strOrder_Sid		= HDUtil.nullCheckStr(greq.getParameter("v_order_sid"));
		String strIO        	= HDUtil.nullCheckStr(greq.getParameter("v_io"));
		String strUser_id      	= HDUtil.nullCheckStr(greq.getParameter("v_user_id"));
		
		Statement stmt1 = null;
		ResultSet rs1 = null;
		//System.out.println("strOrder_Sid0::"+strOrder_Sid);
		//ORDER_SID가 없을 경우 채번
		if(strOrder_Sid.equals("")){
			StringBuffer sql = new StringBuffer();
			
			sql.append( " SELECT '"+strIO+"'||TO_CHAR(CURRENT_DATE,'YYYYMMDD')||LPAD(TO_NUMBER(NVL(MAX(SUBSTR(ORDER_SID,10)),0))+1,4,'0') \n");
			sql.append( "   FROM OMS.T_OR0010 	                                                     \n");
			sql.append( "  WHERE ORDER_SID LIKE '"+strIO+"'||TO_CHAR(CURRENT_DATE,'YYYYMMDD')||'%'   \n");
			sql.append( "    AND INOUT_GB ='"+strIO+"'                                               \n");
			
			//System.out.println("sql::"+sql.toString());
			stmt1 = conn.createStatement();
			rs1 = stmt1.executeQuery(sql.toString());

			while(rs1.next())	{
				strOrder_Sid = rs1.getString(1);
			}
			//System.out.println("strOrder_Sid00::"+strOrder_Sid);
			rs1.close();
			stmt1.close();
		}
		
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
					
				int colNm_ORDER_SID           = ds1.indexOfColumn("ORDER_SID");        //
				int colNm_INOUT_GB            = ds1.indexOfColumn("INOUT_GB");         //
				int colNm_ORDER_STS           = ds1.indexOfColumn("ORDER_STS");        //
				int colNm_WORK_CD             = ds1.indexOfColumn("WORK_CD");          //
				int colNm_INOUT_DATE          = ds1.indexOfColumn("INOUT_DATE");       //
				int colNm_PURPOSE             = ds1.indexOfColumn("PURPOSE");          //
				int colNm_REMARK              = ds1.indexOfColumn("REMARK");           //
				int colNm_APP_VENDCD          = ds1.indexOfColumn("APP_VENDCD");       //
				int colNm_APP_COMPANY         = ds1.indexOfColumn("APP_COMPANY");      //
				int colNm_APP_CRNO            = ds1.indexOfColumn("APP_CRNO");         //
				int colNm_APP_PERSON          = ds1.indexOfColumn("APP_PERSON");       //
				int colNm_APP_PHONE           = ds1.indexOfColumn("APP_PHONE");        //
				int colNm_APP_HP              = ds1.indexOfColumn("APP_HP");           //
				int colNm_SHIP_VENDCD         = ds1.indexOfColumn("SHIP_VENDCD");      //
				int colNm_SHIP_COMPANY        = ds1.indexOfColumn("SHIP_COMPANY");     //
				int colNm_SHIP_CRNO           = ds1.indexOfColumn("SHIP_CRNO");        //
				int colNm_SHIP_PERSON         = ds1.indexOfColumn("SHIP_PERSON");      //
				int colNm_SHIP_PHONE          = ds1.indexOfColumn("SHIP_PHONE");       //
				int colNm_SHIP_HP             = ds1.indexOfColumn("SHIP_HP");          //
				int colNm_ORDER_GB            = ds1.indexOfColumn("ORDER_GB");         //
				int colNm_CREATE_ID           = ds1.indexOfColumn("CREATE_ID");        //
				int colNm_CREATE_DATE         = ds1.indexOfColumn("CREATE_DATE");      //
				int colNm_UPDATE_ID           = ds1.indexOfColumn("UPDATE_ID");        //
				int colNm_UPDATE_DATE         = ds1.indexOfColumn("UPDATE_DATE");      //

				
				for(int i=0; i<rows.length; i++){
					//int j=1;
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							cstmt = conn.prepareCall(arr_sql[2].toString());
							cstmt.setString(1, strOrder_Sid);
							cstmt.setString(2, rows[i].getString(colNm_INOUT_GB));
							cstmt.setString(3, rows[i].getString(colNm_ORDER_STS));
							cstmt.setString(4, rows[i].getString(colNm_WORK_CD));
							cstmt.setString(5, rows[i].getString(colNm_INOUT_DATE));
							cstmt.setString(6, rows[i].getString(colNm_PURPOSE));
							cstmt.setString(7, rows[i].getString(colNm_REMARK));
							cstmt.setString(8, rows[i].getString(colNm_APP_VENDCD));
							cstmt.setString(9, rows[i].getString(colNm_APP_COMPANY));
							cstmt.setString(10,rows[i].getString(colNm_APP_CRNO));
							cstmt.setString(11,rows[i].getString(colNm_APP_PERSON));
							cstmt.setString(12,rows[i].getString(colNm_APP_PHONE));
							cstmt.setString(13,rows[i].getString(colNm_APP_HP));
							cstmt.setString(14,rows[i].getString(colNm_SHIP_VENDCD));
							cstmt.setString(15,rows[i].getString(colNm_SHIP_COMPANY));
							cstmt.setString(16,rows[i].getString(colNm_SHIP_CRNO));
							cstmt.setString(17,rows[i].getString(colNm_SHIP_PERSON));
							cstmt.setString(18,rows[i].getString(colNm_SHIP_PHONE));
							cstmt.setString(19,rows[i].getString(colNm_SHIP_HP));
							cstmt.setString(20,rows[i].getString(colNm_ORDER_GB));
							cstmt.setString(21,strUser_id);
							cstmt.setString(22,strUser_id);	
							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();		
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							
							cstmt = conn.prepareCall(arr_sql[3].toString());
							
							cstmt.setString(1, rows[i].getString(colNm_ORDER_STS));
							cstmt.setString(2, rows[i].getString(colNm_WORK_CD));
							cstmt.setString(3, rows[i].getString(colNm_INOUT_DATE));
							cstmt.setString(4, rows[i].getString(colNm_PURPOSE));
							cstmt.setString(5, rows[i].getString(colNm_REMARK));
							cstmt.setString(6, rows[i].getString(colNm_APP_VENDCD));
							cstmt.setString(7, rows[i].getString(colNm_APP_COMPANY));
							cstmt.setString(8, rows[i].getString(colNm_APP_CRNO));
							cstmt.setString(9, rows[i].getString(colNm_APP_PERSON));
							cstmt.setString(10,rows[i].getString(colNm_APP_PHONE));
							cstmt.setString(11,rows[i].getString(colNm_APP_HP));
							cstmt.setString(12,rows[i].getString(colNm_SHIP_VENDCD));
							cstmt.setString(13,rows[i].getString(colNm_SHIP_COMPANY));
							cstmt.setString(14,rows[i].getString(colNm_SHIP_CRNO));
							cstmt.setString(15,rows[i].getString(colNm_SHIP_PERSON));
							cstmt.setString(16,rows[i].getString(colNm_SHIP_PHONE));
							cstmt.setString(17,rows[i].getString(colNm_SHIP_HP));
							cstmt.setString(18,strUser_id);
							cstmt.setString(19,rows[i].getString(colNm_ORDER_SID));	
							cstmt.executeUpdate();
								
							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();	
							break;
							
						case GauceDataRow.TB_JOB_DELETE:
							cstmt = conn.prepareCall(arr_sql[4].toString());
		
							cstmt.setString(1,rows[i].getString(colNm_ORDER_SID));	
							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();	
							break;
					}//switch(rows[i].getJobType()){
				}
			}//if (ds1 != null) {
			
			if (ds2 != null) {
				
				GauceDataRow[] 		rows2 = ds2.getDataRows();
				GauceDataColumn[] 	cols2 = ds2.getDataColumns();
					
				int colNm_ORDER_SID             = ds2.indexOfColumn("ORDER_SID");        //
				int colNm_ORDER_SEQ             = ds2.indexOfColumn("ORDER_SEQ");        //
				int colNm_CAR_KIND              = ds2.indexOfColumn("CAR_KIND");         //
				int colNm_ITEM_NAME             = ds2.indexOfColumn("ITEM_NAME");        //
				int colNm_START_ADDR            = ds2.indexOfColumn("START_ADDR");       //
				int colNm_START_NAME            = ds2.indexOfColumn("START_NAME");       //
				int colNm_START_INFO            = ds2.indexOfColumn("START_INFO");       //
				int colNm_END_ADDR              = ds2.indexOfColumn("END_ADDR");         //
				int colNm_END_NAME              = ds2.indexOfColumn("END_NAME");         //
				int colNm_END_INFO              = ds2.indexOfColumn("END_INFO");         //
				int colNm_PALLET_CNT            = ds2.indexOfColumn("PALLET_CNT");       //
				int colNm_REMARK                = ds2.indexOfColumn("REMARK");           //
				int colNm_CREATE_ID             = ds2.indexOfColumn("CREATE_ID");        //
				int colNm_CREATE_DATE           = ds2.indexOfColumn("CREATE_DATE");      //
				int colNm_UPDATE_ID             = ds2.indexOfColumn("UPDATE_ID");        //
				int colNm_UPDATE_DATE           = ds2.indexOfColumn("UPDATE_DATE");      //

				for(int i=0; i<rows2.length; i++){
					//int j=1;
					switch(rows2[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
						 					   
							 cstmt = conn.prepareCall(arr_sql[5].toString());
							 cstmt.setString(1, strOrder_Sid);
							 cstmt.setInt(2, rows2[i].getInt(colNm_ORDER_SEQ));
							 cstmt.setString(3, rows2[i].getString(colNm_CAR_KIND));
							 cstmt.setString(4, rows2[i].getString(colNm_ITEM_NAME));
							 cstmt.setString(5, rows2[i].getString(colNm_START_ADDR));
							 cstmt.setString(6, rows2[i].getString(colNm_START_NAME));
							 cstmt.setString(7, rows2[i].getString(colNm_START_INFO));
							 cstmt.setString(8, rows2[i].getString(colNm_END_ADDR));
							 cstmt.setString(9, rows2[i].getString(colNm_END_NAME));
							 cstmt.setString(10, rows2[i].getString(colNm_END_INFO));
							 cstmt.setInt(11, rows2[i].getInt(colNm_PALLET_CNT));
							 cstmt.setString(12, rows2[i].getString(colNm_REMARK));
							 cstmt.setString(13, strUser_id);
							 cstmt.setString(14, strUser_id);
							 
							 cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();		
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							 cstmt = conn.prepareCall(arr_sql[6].toString());
							 
							 cstmt.setString(1, rows2[i].getString(colNm_CAR_KIND));
							 cstmt.setString(2, rows2[i].getString(colNm_ITEM_NAME));
							 cstmt.setString(3, rows2[i].getString(colNm_START_ADDR));
							 cstmt.setString(4, rows2[i].getString(colNm_START_NAME));
							 cstmt.setString(5, rows2[i].getString(colNm_START_INFO));
							 cstmt.setString(6, rows2[i].getString(colNm_END_ADDR));
							 cstmt.setString(7, rows2[i].getString(colNm_END_NAME));
							 cstmt.setString(8, rows2[i].getString(colNm_END_INFO));
							 cstmt.setInt(9, rows2[i].getInt(colNm_PALLET_CNT));
							 cstmt.setString(10, rows2[i].getString(colNm_REMARK));
							 cstmt.setString(11, strUser_id);
							 cstmt.setString(12, rows2[i].getString(colNm_ORDER_SID));
							 cstmt.setInt(13, rows2[i].getInt(colNm_ORDER_SEQ));
							 
							 cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();		
							break;
							
						case GauceDataRow.TB_JOB_DELETE:
							 cstmt = conn.prepareCall(arr_sql[7].toString());
							 cstmt.setString(1,rows2[i].getString(colNm_ORDER_SID));	
							 cstmt.setInt(2, rows2[i].getInt(colNm_ORDER_SEQ));
							 cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();		
							break;
					}//switch(rows[i].getJobType()){
				}
			}//if (ds2 != null) {
			
			//신규생성일 경우 RETURN 
			if (ds3 != null) {
				//System.out.println("strOrder_Sid99::"+strOrder_Sid);
				ds3.addIDataColumn(new GauceDataColumn("ORDER_SID",GauceDataColumn.TB_STRING,13));
				GauceDataRow rows3 = ds3.newDataRow();
				rows3.addColumnValue(strOrder_Sid);
				ds3.addDataRow(rows3);
				gos.write(ds3);
			}//if (ds3 != null) {
			
			
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
			String v_parm1	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm1"));
			String v_parm2	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm2"));
			
			if(!v_parm2.equals(""))  arr_sql[0].append (" AND  CREATE_ID=? \n");
			if(!v_parm2.equals(""))  arr_sql[1].append (" AND  CREATE_ID=? \n");
			arr_sql[1].append ("  ORDER BY ORDER_SEQ         \n");
			
			switch(dsType) {
				case 1: //주문 MST
				
					//쿼리 실행
					//System.out.println("arr_sql[0].toString()::" +arr_sql[0].toString());
					//System.out.println("v_parm1::" +v_parm1);
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, v_parm1);
					
					if(!v_parm2.equals(""))  {	cstmt.setString(2, v_parm2);}	
					
					rs = cstmt.executeQuery();     //DataSet set
					gos.write(getDataSet(rs, ds1));
					break;
					
				case 2: //주문 DTL
					
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, v_parm1);
					
					if(!v_parm2.equals(""))  {	cstmt.setString(2, v_parm2);}
					
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
