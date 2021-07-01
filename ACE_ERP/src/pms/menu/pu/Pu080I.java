package pms.menu.pu;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceStatement;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

import sales.common.HDUtil;
import sales.common.StringUtil;
import pms.common.SuperServlet;
import java.sql.Connection; 
import oracle.jdbc.OracleTypes;

public class Pu080I extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//마스터 조회
		arr_sql[0].append ("{call PMS.PR_PU080I_01(?,?,?,?) }" );
		//TENDER 조회
		arr_sql[1].append ("{call PMS.PR_PU080I_02(?,?,?) }" );
		//DETAIL 조회
		arr_sql[2].append ("{call PMS.PR_PU080I_03(?,?,?) }" );
		//DETAIL 저장(검수정산)
		arr_sql[5].append ("{call PMS.PR_PU080I_05(?,?,?,?,?		,?,?,?,?,?		,?,?,?,?,?		,?,?,?,?) }" );
   }
	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataSet */
		//StringUtil.printMsg("DS TYPE","선조회",this);
		CallableStatement cstmt = null;
		ResultSet rs = null;

		//StringUtil.printMsg("v_fr_bid_date",v_fr_bid_date,this);
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
		    //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
		    GauceDataSet[] dSets = gis.readAllOutput(); 

		    for(int i=0; i<dSets.length;i++){
			   	if(dSets[i].getName().equals("ds_default")){
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);
		   			GauceDataSet ds1 = gis.read("DS_DEFAULT");
						cstmt = conn.prepareCall(arr_sql[0].toString());
						//cstmt.setInt(1, 1);
						cstmt.setString(1, "19990101");
						cstmt.setString(2, "19990101");
						cstmt.setString(3, "2");
						cstmt.registerOutParameter(4, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(4);	//커서 OUT param. 			
						gos.write(getDataSet(rs, ds1));
			   	} else if(dSets[i].getName().equals("ds_tender")){
					//StringUtil.printMsg("Init:::::::::","ds_tender",this);
					//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);
					GauceDataSet ds1 = gis.read("DS_TENDER");
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1, 9999999);
						cstmt.setInt(2, 9999999);
						cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 			
						gos.write(getDataSet(rs, ds1));
			   	} else if(dSets[i].getName().equals("ds_detail")){
					//StringUtil.printMsg("Init:::::::::","ds_detail",this);
					//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);
					GauceDataSet ds1 = gis.read("DS_DETAIL");
					//StringUtil.printMsg("DS DS_TENDER","선조회",this);
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setInt(1, 0);
					cstmt.setString(2, "91");
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 			
					gos.write(getDataSet(rs, ds1));
				}
		    }
	     	gos.close();
	    }catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;

		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
					if(dSets[i].getName().equals("ds_default")){
						GauceDataSet ds1 = gis.read("DS_DEFAULT");
						//int v_site_sid 			= HDUtil.nullCheckNum(req.getParameter("v_site_sid"));			// 현장 SID
						String v_fr_con_date 	= HDUtil.nullCheckStr(greq.getParameter("v_fr_con_date")); 	// 품의일자 시작
						String v_to_con_date	= HDUtil.nullCheckStr(greq.getParameter("v_to_con_date")); 	// 품의일자 종료
						String v_rqst_status		= HDUtil.nullCheckStr(greq.getParameter("v_rqst_status")); 	// 요청상태
						/*
						StringUtil.printMsg("v_site_sid",v_site_sid,this);
						StringUtil.printMsg("v_fr_con_date",v_fr_con_date,this);
						StringUtil.printMsg("v_to_con_date",v_to_con_date,this);
						StringUtil.printMsg("v_rqst_status",v_rqst_status,this);
						*/
						cstmt = conn.prepareCall(arr_sql[0].toString());
						//cstmt.setInt(1, v_site_sid);
						cstmt.setString(1, v_fr_con_date);
						cstmt.setString(2, v_to_con_date);
						cstmt.setString(3, v_rqst_status);
						cstmt.registerOutParameter(4, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(4);	//커서 OUT param. 			
						gos.write(getDataSet(rs, ds1));
					} else if(dSets[i].getName().equals("ds_tender")){
						GauceDataSet ds1 = gis.read("DS_TENDER");
						int v_rqst_sid = HDUtil.nullCheckNum(greq.getParameter("v_rqst_sid"));			// 청구 SID
						int v_est_sid = HDUtil.nullCheckNum(greq.getParameter("v_est_sid"));				// 견적 SID
						//StringUtil.printMsg("v_rqst_sid",v_rqst_sid+"",this);
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1, v_rqst_sid);
						cstmt.setInt(2, v_est_sid);
						cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 			
						gos.write(getDataSet(rs, ds1));
					} else if(dSets[i].getName().equals("ds_detail")){
						GauceDataSet ds1 = gis.read("DS_DETAIL");
						int v_est_sid = HDUtil.nullCheckNum(greq.getParameter("v_est_sid"));				//견적 SID
						String v_vend_cd 	= HDUtil.nullCheckStr(greq.getParameter("v_vend_cd")); 	// 거래처코드
						
						//StringUtil.printMsg("v_est_sid",v_est_sid+"",this);
						//StringUtil.printMsg("v_item_sid",v_item_sid+"",this);
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setInt(1, v_est_sid);
						cstmt.setString(2, v_vend_cd);
						cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 			
						gos.write(getDataSet(rs, ds1));
					}
				 }
				 gos.close();
		}catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
	
	//apply method
		public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
			//StringUtil.printMsg("# Command","저장",this);
			//StringUtil.printMsg("# Command","저장",this);
			CallableStatement cstmt = null;	
			GauceStatement 	stmt 		= null;
			ResultSet 		rs 			= null;
					
			String iParamEmpno = fParamEmpno;
			String iParamIp = fParamIp;
							
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
					
		/* DataSet */
		//GauceDataSet ds1 = req.getGauceDataSet("DS_DEFAULT");
		//GauceDataSet ds2 = req.getGauceDataSet("DS_TENDER");
			GauceDataSet ds3 = gis.read("DS_DETAIL");
					
		//	int fSiteSid = 0;
		try{
			if (ds3 != null) {
				//StringUtil.printMsg("ds3","ds3",this);
				GauceDataRow[] 		rows = ds3.getDataRows();
				GauceDataColumn[] 	cols = ds3.getDataColumns();
				
				int colNm_RQST_SID      				= ds3.indexOfColumn("RQST_SID");       		// 청구SID
				int colNm_ITEM_SID      				= ds3.indexOfColumn("ITEM_SID");       		// 퓸목SID
				int colNm_EST_SID      				= ds3.indexOfColumn("EST_SID");	       		// 견적SID
				int colNm_CGC_SID      				= ds3.indexOfColumn("CGC_SID");       		// 검수SID
				int colNm_VEND_CD     		 		= ds3.indexOfColumn("VEND_CD");       		// 거래처코드
				int colNm_DATE_CGC     		 		= ds3.indexOfColumn("DATE_CGC");       		// 검수일자
				int colNm_CGC_NOTE      			= ds3.indexOfColumn("CGC_NOTE");       		// 검수특기사항
				int colNm_CGC_PRE_CNT     		= ds3.indexOfColumn("CGC_PRE_CNT");     	// 전회정산수량
				int colNm_CGC_PRE_AMT      		= ds3.indexOfColumn("CGC_PRE_AMT");     // 전회정산금액
				int colNm_CGC_NOW_CNT      	= ds3.indexOfColumn("CGC_NOW_CNT");   	// 금월정산수량
				int colNm_CGC_NOW_AMT      	= ds3.indexOfColumn("CGC_NOW_AMT"); 	// 금월정산금액
				int colNm_CGC_SUM_CNT     		= ds3.indexOfColumn("CGC_SUM_CNT");     // 누계정산수량
				int colNm_CGC_SUM_AMT     		= ds3.indexOfColumn("CGC_SUM_AMT");     // 누계정산금액
				int colNm_CGC_RES_CNT      		= ds3.indexOfColumn("CGC_RES_CNT");      // 잔여금정산수량
				int colNm_CGC_RES_AMT      		= ds3.indexOfColumn("CGC_RES_AMT");      // 잔여금정산금액
				int colNm_CON_SID      				= ds3.indexOfColumn("CON_SID");       		//  품의SID
				
				//StringUtil.printMsg("colNm_CoopSid",colNm_CoopSid,this);

				for(int i=0; i<rows.length; i++){
					
							int j=1;
							switch(rows[i].getJobType()){
									case GauceDataRow.TB_JOB_INSERT:
										/*
										StringUtil.printMsg("call","PMS.PR_INSERT",this);
										StringUtil.printMsg("colNm_RQST_SID",rows[i].getString(colNm_RQST_SID),this);
										StringUtil.printMsg("colNm_ITEM_SID",rows[i].getString(colNm_ITEM_SID),this);
										StringUtil.printMsg("colNm_EST_SID",rows[i].getString(colNm_EST_SID),this);
										StringUtil.printMsg("colNm_CGC_SID",rows[i].getString(colNm_CGC_SID),this);
										StringUtil.printMsg("colNm_VEND_CD",rows[i].getString(colNm_VEND_CD),this);
										StringUtil.printMsg("colNm_DATE_CGC",rows[i].getString(colNm_DATE_CGC),this);
										StringUtil.printMsg("colNm_CGC_NOTE",rows[i].getString(colNm_CGC_NOTE),this);
										StringUtil.printMsg("colNm_CGC_PRE_CNT",rows[i].getString(colNm_CGC_PRE_CNT),this);
										StringUtil.printMsg("colNm_CGC_PRE_AMT",rows[i].getString(colNm_CGC_PRE_AMT),this);
										StringUtil.printMsg("colNm_CGC_NOW_CNT",rows[i].getString(colNm_CGC_NOW_CNT),this);
										StringUtil.printMsg("colNm_CGC_NOW_AMT",rows[i].getString(colNm_CGC_NOW_AMT),this);
										StringUtil.printMsg("colNm_CGC_SUM_CNT",rows[i].getString(colNm_CGC_SUM_CNT),this);
										StringUtil.printMsg("colNm_CGC_SUM_AMT",rows[i].getString(colNm_CGC_SUM_AMT),this);
										StringUtil.printMsg("colNm_CGC_RES_CNT",rows[i].getString(colNm_CGC_RES_CNT),this);
										StringUtil.printMsg("colNm_CGC_RES_AMT",rows[i].getString(colNm_CGC_RES_AMT),this);
										*/
										cstmt = conn.prepareCall(arr_sql[5].toString());
									
										cstmt.setInt(1, rows[i].getInt(colNm_RQST_SID));	
										cstmt.setInt(2, rows[i].getInt(colNm_ITEM_SID));
										cstmt.setInt(3, rows[i].getInt(colNm_EST_SID));
										cstmt.setInt(4, rows[i].getInt(colNm_CGC_SID));
										cstmt.setString(5, rows[i].getString(colNm_VEND_CD));
										cstmt.setString(6, rows[i].getString(colNm_DATE_CGC));
										cstmt.setString(7, rows[i].getString(colNm_CGC_NOTE));
										cstmt.setInt(8, rows[i].getInt(colNm_CGC_PRE_CNT));
										cstmt.setInt(9, rows[i].getInt(colNm_CGC_PRE_AMT));
										cstmt.setInt(10, rows[i].getInt(colNm_CGC_NOW_CNT));
										cstmt.setInt(11, rows[i].getInt(colNm_CGC_NOW_AMT));
										cstmt.setInt(12, rows[i].getInt(colNm_CGC_SUM_CNT));
										cstmt.setInt(13, rows[i].getInt(colNm_CGC_SUM_AMT));
										cstmt.setInt(14, rows[i].getInt(colNm_CGC_RES_CNT));
										cstmt.setInt(15, rows[i].getInt(colNm_CGC_RES_AMT));
										cstmt.setInt(16, rows[i].getInt(colNm_CON_SID));
										cstmt.setString(17, iParamEmpno);
										cstmt.setString(18, iParamIp);
										cstmt.setString(19, "1");
													
										cstmt.executeUpdate();
										
										if(cstmt!=null) cstmt.close();						
										break;
									case GauceDataRow.TB_JOB_UPDATE:
										
										/*	
										StringUtil.printMsg("call","PMS.PR_UPDATE",this);
										StringUtil.printMsg("colNm_RQST_SID",rows[i].getString(colNm_RQST_SID),this);
										StringUtil.printMsg("colNm_ITEM_SID",rows[i].getString(colNm_ITEM_SID),this);
										StringUtil.printMsg("colNm_EST_SID",rows[i].getString(colNm_EST_SID),this);
										StringUtil.printMsg("colNm_CGC_SID",rows[i].getString(colNm_CGC_SID),this);
										StringUtil.printMsg("colNm_VEND_CD",rows[i].getString(colNm_VEND_CD),this);
										StringUtil.printMsg("colNm_DATE_CGC",rows[i].getString(colNm_DATE_CGC),this);
										StringUtil.printMsg("colNm_CGC_NOTE",rows[i].getString(colNm_CGC_NOTE),this);
										StringUtil.printMsg("colNm_CGC_PRE_CNT",rows[i].getString(colNm_CGC_PRE_CNT),this);
										StringUtil.printMsg("colNm_CGC_PRE_AMT",rows[i].getString(colNm_CGC_PRE_AMT),this);
										StringUtil.printMsg("colNm_CGC_NOW_CNT",rows[i].getString(colNm_CGC_NOW_CNT),this);
										StringUtil.printMsg("colNm_CGC_NOW_AMT",rows[i].getString(colNm_CGC_NOW_AMT),this);
										StringUtil.printMsg("colNm_CGC_SUM_CNT",rows[i].getString(colNm_CGC_SUM_CNT),this);
										StringUtil.printMsg("colNm_CGC_SUM_AMT",rows[i].getString(colNm_CGC_SUM_AMT),this);
										StringUtil.printMsg("colNm_CGC_RES_CNT",rows[i].getString(colNm_CGC_RES_CNT),this);
										StringUtil.printMsg("colNm_CGC_RES_AMT",rows[i].getString(colNm_CGC_RES_AMT),this);
										*/
																																		
										cstmt = conn.prepareCall(arr_sql[5].toString());
									
										cstmt.setInt(1, rows[i].getInt(colNm_RQST_SID));	
										cstmt.setInt(2, rows[i].getInt(colNm_ITEM_SID));
										cstmt.setInt(3, rows[i].getInt(colNm_EST_SID));
										cstmt.setInt(4, rows[i].getInt(colNm_CGC_SID));
										cstmt.setString(5, rows[i].getString(colNm_VEND_CD));
										cstmt.setString(6, rows[i].getString(colNm_DATE_CGC));
										cstmt.setString(7, rows[i].getString(colNm_CGC_NOTE));
										cstmt.setInt(8, rows[i].getInt(colNm_CGC_PRE_CNT));
										cstmt.setInt(9, rows[i].getInt(colNm_CGC_PRE_AMT));
										cstmt.setInt(10, rows[i].getInt(colNm_CGC_NOW_CNT));
										cstmt.setInt(11, rows[i].getInt(colNm_CGC_NOW_AMT));
										cstmt.setInt(12, rows[i].getInt(colNm_CGC_SUM_CNT));
										cstmt.setInt(13, rows[i].getInt(colNm_CGC_SUM_AMT));
										cstmt.setInt(14, rows[i].getInt(colNm_CGC_RES_CNT));
										cstmt.setInt(15, rows[i].getInt(colNm_CGC_RES_AMT));
										cstmt.setInt(16, rows[i].getInt(colNm_CON_SID));
										cstmt.setString(17, iParamEmpno);
										cstmt.setString(18, iParamIp);
										cstmt.setString(19, "3");
												
										cstmt.executeUpdate();
										
										if(cstmt!=null) cstmt.close();	
										break;
									case GauceDataRow.TB_JOB_DELETE:
										//StringUtil.printMsg("call","PMS.PR_CT010i_05-DELETE",this);
										cstmt = conn.prepareCall(arr_sql[5].toString());
									
										cstmt.setInt(1, rows[i].getInt(colNm_RQST_SID));	
										cstmt.setInt(2, rows[i].getInt(colNm_ITEM_SID));
										cstmt.setInt(3, rows[i].getInt(colNm_EST_SID));
										cstmt.setInt(4, rows[i].getInt(colNm_CGC_SID));
										cstmt.setString(5, rows[i].getString(colNm_VEND_CD));
										cstmt.setString(6, rows[i].getString(colNm_DATE_CGC));
										cstmt.setString(7, rows[i].getString(colNm_CGC_NOTE));
										cstmt.setInt(8, rows[i].getInt(colNm_CGC_PRE_CNT));
										cstmt.setInt(9, rows[i].getInt(colNm_CGC_PRE_AMT));
										cstmt.setInt(10, rows[i].getInt(colNm_CGC_NOW_CNT));
										cstmt.setInt(11, rows[i].getInt(colNm_CGC_NOW_AMT));
										cstmt.setInt(12, rows[i].getInt(colNm_CGC_SUM_CNT));
										cstmt.setInt(13, rows[i].getInt(colNm_CGC_SUM_AMT));
										cstmt.setInt(14, rows[i].getInt(colNm_CGC_RES_CNT));
										cstmt.setInt(15, rows[i].getInt(colNm_CGC_RES_AMT));
										cstmt.setInt(16, rows[i].getInt(colNm_CON_SID));
										cstmt.setString(17, iParamEmpno);
										cstmt.setString(18, iParamIp);
										cstmt.setString(19, "2");
										
										if(cstmt!=null) cstmt.close();	
										break;						
							}
				}
		}	//if (ds1 != null) {
			gos.close();
		} catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e) {
			gres.addException(e);
			throw e;
		} finally {
			//msgDS.flush();
			//if(stmt!=null) stmt.close();
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
		//if( fail == true ) throw new Exception("");			
		}
	}
}