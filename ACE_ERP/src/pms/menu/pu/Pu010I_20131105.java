package pms.menu.pu;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;

import sales.common.HDUtil;
import sales.common.SuperServlet;
import sales.common.StringUtil;

public class Pu010I_20131105 extends SuperServlet {

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//ë§ˆìŠ¤??ì¡°íšŒ
		arr_sql[0].append ("{call PMS.PR_PU010I_01(?,?,?,?,?) }" );

		//Detail ì¡°íšŒ
		arr_sql[1].append ("{call PMS.PR_PU010I_02(?) }" );

		//Main ??ž¥
		arr_sql[2].append ("{call PMS.PR_PU010I_03(?,?,?,?,?,   ?,?,?,?,?,   ?,?,?,?,?            ,?) }");
		//Detail ??ž¥
		arr_sql[3].append ("{call PMS.PR_PU010I_04(?,?,?,?,?,   ?,?,?,?,?,   ?,?,?,?,?  ,?,?,?) }");

   }

	//init method
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/* DataSet */
		//StringUtil.printMsg("DS TYPE","? ì¡°??,this);
		CallableStatement cstmt = null;
		ResultSet rs = null;

		//StringUtil.printMsg("v_fr_bid_date",v_fr_bid_date,this);
		try {
			Iterator it = req.getGauceDataSetKeys();
			while (it.hasNext()) {
				String gauceName = (String)it.next();

				GauceDataSet ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);

					if(gauceName.equals("DS_DEFAULT")){
						//StringUtil.printMsg("DS DS_DEFAULT","? ì¡°??,this);
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setString(1, "6080001");
						cstmt.setInt(2, 1);
						cstmt.setString(3, "19990101");
						cstmt.setString(4, "19990101");
						cstmt.setString(5, "2");
					} else if(gauceName.equals("DS_TENDER")){
						//StringUtil.printMsg("DS DS_TENDER","? ì¡°??,this);
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1, 0);
					}

					
					rs = cstmt.executeQuery();
					getDataSet(rs, ds1).flush();
					
				}
			}
		}catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}

	}	
	
	//select method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;

		try {
			Iterator it = req.getGauceDataSetKeys();
			while (it.hasNext()) {
				String gauceName = (String)it.next();

				GauceDataSet ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);

					if(gauceName.equals("DS_DEFAULT")){
						String sNowEmpno	= HDUtil.nullCheckStr(req.getParameter("v_empno"));	// ë¡œê¸´?¬ë²ˆ
						int v_site_sid 			= HDUtil.nullCheckNum(req.getParameter("v_site_sid"));			// ?„ìž¥ SID
						String v_fr_rqst_date 	= HDUtil.nullCheckStr(req.getParameter("v_fr_rqst_date")); 	// ?”ì²­?¼ìž ?œìž‘
						String v_to_rqst_date	= HDUtil.nullCheckStr(req.getParameter("v_to_rqst_date")); 	// ?”ì²­?¼ìž ì¢…ë£Œ
						String v_rqst_status		= HDUtil.nullCheckStr(req.getParameter("v_rqst_status")); 	// ?”ì²­?íƒœ

						/*
						StringUtil.printMsg("v_site_sid",v_site_sid,this);
						StringUtil.printMsg("v_fr_rqst_date",v_fr_rqst_date,this);
						StringUtil.printMsg("v_to_rqst_date",v_to_rqst_date,this);
						StringUtil.printMsg("v_rqst_status",v_rqst_status,this);
						*/
						
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setString(1, sNowEmpno);	
						cstmt.setInt(2, v_site_sid);
						cstmt.setString(3, v_fr_rqst_date);
						cstmt.setString(4, v_to_rqst_date);
						cstmt.setString(5, v_rqst_status);
					} else if(gauceName.equals("DS_TENDER")){
						int v_rqst_sid = HDUtil.nullCheckNum(req.getParameter("v_rqst_sid"));			// ?„ìž¥ SID
						StringUtil.printMsg("v_rqst_sid",v_rqst_sid+"",this);
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1, v_rqst_sid);
					}

					
					rs = cstmt.executeQuery();
					getDataSet(rs, ds1).flush();
					
				}
			}
		}catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
	
	//apply method
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		//StringUtil.printMsg("# Command","??ž¥",this);
		CallableStatement cstmt = null;	
		//GauceStatement 	stmt 		= null;
		ResultSet 			rs 			= null;
			
		/** 
		 * @Todo ?¬ë²ˆ , ì»´í“¨??IP???´ì—??ê°??ê³???•¼?œë‹¤ 
		 **/
		String iParamEmpno 	= fParamEmpno;
		String iParamIp 	= fParamIp;
					
		/* DataSet */
		GauceDataSet ds1 = req.getGauceDataSet("DS_DEFAULT");
		GauceDataSet ds2 = req.getGauceDataSet("DS_TENDER");
		GauceDataSet rqstNoDS = req.getGauceDataSet("rqstNoDS");	
					
//		int fSiteSid = 0;
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
					
					
				int colNm_RQST_STATUS    = ds1.indexOfColumn("RQST_STATUS");	//ì²?µ¬?íƒœ
				int colNm_RQST_DATE        = ds1.indexOfColumn("RQST_DATE"); 		//ì²?µ¬?¼ìž
				int colNm_RQST_NO      		= ds1.indexOfColumn("RQST_NO");  		// ì²?µ¬ë²ˆí˜¸
				int colNm_RQST_SID       	= ds1.indexOfColumn("RQST_SID"); 		//ì²?µ¬SID
				int colNm_SITE_CD    			= ds1.indexOfColumn("SITE_CD"); 			//?„ìž¥ì½”ë“œ
				int colNm_PU_EMPNO	    	= ds1.indexOfColumn("PU_EMPNO"); 		//?„ìž¥?´ë‹¹?ì‚¬ë²?
				int colNm_SITE_NM     		= ds1.indexOfColumn("SITE_NM");    		//?„ìž¥ëª?
				int colNm_SITE_SID       		= ds1.indexOfColumn("SITE_SID");     		//?„ìž¥SID
				int colNm_RQST_USE        	= ds1.indexOfColumn("RQST_USE");  		//?¬ìš©ì²?
				//int colNm_REAL_FILE        	= ds1.indexOfColumn("real_file");  			//real_file
				//int colNm_SYS_FILE        	= ds1.indexOfColumn("sys_file");  			//sys_file
				int colNm_RQST_MEMO 		= ds1.indexOfColumn("RQST_MEMO");  	// ì²?µ¬?¹ì´?¬í•­
				int colNm_PUT_WH    			= ds1.indexOfColumn("PUT_WH"); 			//?¬ìž…ì°½ê³ 
				String v_sys_file 	= HDUtil.nullCheckStr(req.getParameter("sSysFile")); 	// ì²¨ë??Œì¼system
				String v_real_file	= HDUtil.nullCheckStr(req.getParameter("sRealFile")); 	// ì²¨ë??Œì¼real
					
				//StringUtil.printMsg("colNm_SiteNm",colNm_SiteNm,this);
				//ì²?µ¬ë²ˆí˜¸
			    //res.enableFirstRow(rqstNoDS);
			    //rqstNoDS.addDataColumn(new GauceDataColumn("RQST_NO", GauceDataColumn.TB_STRING));

				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
						/*
						StringUtil.printMsg("call","PMS.PR_PU010i_04-INSERT",this);
						StringUtil.printMsg("colNm_RQST_STATUS",rows[i].getString(colNm_RQST_STATUS),this);
						StringUtil.printMsg("colNm_RQST_DATE",rows[i].getString(colNm_RQST_DATE),this);
						StringUtil.printMsg("colNm_RQST_NO",rows[i].getString(colNm_RQST_NO),this);
						StringUtil.printMsg("colNm_RQST_SID",rows[i].getString(colNm_RQST_SID),this);
						StringUtil.printMsg("colNm_SITE_CD",rows[i].getString(colNm_SITE_CD),this);
						StringUtil.printMsg("colNm_PU_EMPNO",rows[i].getString(colNm_PU_EMPNO),this);
						StringUtil.printMsg("colNm_SITE_NM",rows[i].getString(colNm_SITE_NM),this);
						StringUtil.printMsg("colNm_SITE_SID",rows[i].getString(colNm_SITE_SID),this);
						StringUtil.printMsg("colNm_RQST_USE",rows[i].getString(colNm_RQST_USE),this);
						StringUtil.printMsg("colNm_RQST_MEMO",rows[i].getString(colNm_RQST_MEMO),this);
						StringUtil.printMsg("colNm_PUT_WH",rows[i].getString(colNm_PUT_WH),this);
						StringUtil.printMsg("v_sys_file",v_sys_file,this);
						StringUtil.printMsg("v_real_file",v_real_file,this);
						*/
							cstmt = conn.prepareCall(arr_sql[2].toString());
							
							cstmt.setString(1, rows[i].getString(colNm_RQST_STATUS));
							cstmt.setString(2, rows[i].getString(colNm_RQST_DATE));
							cstmt.setString(3, rows[i].getString(colNm_RQST_NO));
							cstmt.setInt(4, rows[i].getInt(colNm_RQST_SID));
							cstmt.setString(5, rows[i].getString(colNm_SITE_CD));
							cstmt.setString(6, rows[i].getString(colNm_PU_EMPNO));
							cstmt.setString(7, rows[i].getString(colNm_SITE_NM));
							cstmt.setInt(8, rows[i].getInt(colNm_SITE_SID));
							cstmt.setString(9, rows[i].getString(colNm_RQST_USE));
							cstmt.setString(10, rows[i].getString(colNm_RQST_MEMO));
							cstmt.setString(11, rows[i].getString(colNm_PUT_WH));
							cstmt.setString(12, v_real_file);
							cstmt.setString(13, v_sys_file);
							cstmt.setString(14, iParamEmpno);
							cstmt.setString(15, iParamIp);
							cstmt.setString(16, "1");
								
							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();		
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							//StringUtil.printMsg("call","PMS.PR_CT010i_04-UPDATE",this);
							cstmt = conn.prepareCall(arr_sql[2].toString());
								
						cstmt.setString(1, rows[i].getString(colNm_RQST_STATUS));
					cstmt.setString(2, rows[i].getString(colNm_RQST_DATE));
					cstmt.setString(3, rows[i].getString(colNm_RQST_NO));
					cstmt.setInt(4, rows[i].getInt(colNm_RQST_SID));
					cstmt.setString(5, rows[i].getString(colNm_SITE_CD));
					cstmt.setString(6, rows[i].getString(colNm_PU_EMPNO));
					cstmt.setString(7, rows[i].getString(colNm_SITE_NM));
					cstmt.setInt(8, rows[i].getInt(colNm_SITE_SID));
					cstmt.setString(9, rows[i].getString(colNm_RQST_USE));
					cstmt.setString(10, rows[i].getString(colNm_RQST_MEMO));
					cstmt.setString(11, rows[i].getString(colNm_PUT_WH));
					cstmt.setString(12, v_real_file);
					cstmt.setString(13, v_sys_file);
					cstmt.setString(14, iParamEmpno);
					cstmt.setString(15, iParamIp);
					cstmt.setString(16, "3");
				
				
		
							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();	
							break;
						case GauceDataRow.TB_JOB_DELETE:
							//StringUtil.printMsg("call","PMS.PR_CT010i_04-DELETE",this);
							cstmt = conn.prepareCall(arr_sql[2].toString());
								
						cstmt.setString(1, rows[i].getString(colNm_RQST_STATUS));
						cstmt.setString(2, rows[i].getString(colNm_RQST_DATE));
						cstmt.setString(3, rows[i].getString(colNm_RQST_NO));
						cstmt.setInt(4, rows[i].getInt(colNm_RQST_SID));
						cstmt.setString(5, rows[i].getString(colNm_SITE_CD));
						cstmt.setString(6, rows[i].getString(colNm_PU_EMPNO));
						cstmt.setString(7, rows[i].getString(colNm_SITE_NM));
						cstmt.setInt(8, rows[i].getInt(colNm_SITE_SID));
						cstmt.setString(9, rows[i].getString(colNm_RQST_USE));
						cstmt.setString(10, rows[i].getString(colNm_RQST_MEMO));
						cstmt.setString(11, rows[i].getString(colNm_PUT_WH));
						cstmt.setString(12, v_real_file);
						cstmt.setString(13, v_sys_file);
						cstmt.setString(14, iParamEmpno);
						cstmt.setString(15, iParamIp);
						cstmt.setString(16, "2");
						
						
							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();	
							break;						
					}//switch(rows[i].getJobType()){
				}
			}//if (ds1 != null) {
			
			if (ds2 != null) {
				//StringUtil.printMsg("ds2","ds2",this);
				GauceDataRow[] 		rows = ds2.getDataRows();
				GauceDataColumn[] 	cols = ds2.getDataColumns();
					
			
				int colNm_RQST_SID	      	= ds2.indexOfColumn("RQST_SID");	       	// ì²?µ¬ SID
				int colNm_ITEM_SID      	= ds2.indexOfColumn("ITEM_SID");       	// ?ˆëª© SID
				int colNm_ITEM_NM        	= ds2.indexOfColumn("ITEM_NM");  			// ?ˆëª…
				int colNm_ITEM_SIZE			= ds2.indexOfColumn("ITEM_SIZE");			// ê·œê²©
				int colNm_ITEM_UNIT			= ds2.indexOfColumn("ITEM_UNIT");			// ?¨ìœ„
				int colNm_RQST_CNT  		= ds2.indexOfColumn("RQST_CNT");    	// ?˜ëŸ‰
				int colNm_DG_AMT  			= ds2.indexOfColumn("DG_AMT");    	// ?„ê¸‰?¨ê?
				int colNm_DG_SUM_AMT  		= ds2.indexOfColumn("DG_SUM_AMT");    	// ?„ê¸‰??
				int colNm_YS_AMT  			= ds2.indexOfColumn("YS_AMT");    	// ?ˆì‚°?¨ê?
				int colNm_YS_SUM_AMT  		= ds2.indexOfColumn("YS_SUM_AMT");    	// ?ˆì‚°??
				int colNm_RQST_USE      	= ds2.indexOfColumn("RQST_USE");       	// ?©ë„
				int colNm_DATE_USE 			= ds2.indexOfColumn("DATE_USE");   		// ?Œìš”??
				int colNm_RQST_NOTE 		= ds2.indexOfColumn("RQST_NOTE");   	// ì²?µ¬ë¹„ê³ 
				int colNm_DG_CNT  			= ds2.indexOfColumn("DG_CNT");    	// ?„ê¸‰?˜ëŸ‰
				int colNm_ITEM_SEQ 			= ds2.indexOfColumn("ITEM_SEQ");   	// ?ˆëª© ?œë²ˆ
				
				//StringUtil.printMsg("colNm_CoopSid",colNm_CoopSid,this);

				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
						
					case GauceDataRow.TB_JOB_INSERT:
						//StringUtil.printMsg("call","PMS.PR_CT010i_05-INSERT",this);
						/*
						//StringUtil.printMsg("call","PMS.PR_CT010i_04-INSERT",this);
						//StringUtil.printMsg("colNm_SiteNm",rows[i].getString(colNm_SiteNm),this);
						//StringUtil.printMsg("colNm_OrdererNm",rows[i].getString(colNm_OrdererNm),this);
						//StringUtil.printMsg("colNm_SiteSid",rows[i].getString(colNm_SiteSid),this);
						//StringUtil.printMsg("colNm_SiteJoint",rows[i].getString(colNm_SiteJoint),this);
						//StringUtil.printMsg("colNm_SiteMain",rows[i].getString(colNm_SiteMain),this);
						//StringUtil.printMsg("colNm_SiteAttr1",rows[i].getString(colNm_SiteAttr1),this);
						//StringUtil.printMsg("colNm_SiteAttr2",rows[i].getString(colNm_SiteAttr2),this);
						//StringUtil.printMsg("colNm_OrdererSid",rows[i].getString(colNm_OrdererSid),this);
						*/
						//StringUtil.printMsg("colNm_DG_CNT",rows[i].getInt(colNm_DG_CNT),this);
						//StringUtil.printMsg("colNm_ITEM_SEQ",rows[i].getInt(colNm_ITEM_SEQ),this);
						
						cstmt = conn.prepareCall(arr_sql[3].toString());
					
						cstmt.setInt(1, rows[i].getInt(colNm_RQST_SID));
						cstmt.setInt(2, rows[i].getInt(colNm_ITEM_SID));
						cstmt.setString(3, rows[i].getString(colNm_ITEM_NM));
						cstmt.setString(4, rows[i].getString(colNm_ITEM_SIZE));
						cstmt.setString(5, rows[i].getString(colNm_ITEM_UNIT));	
						cstmt.setInt(6, rows[i].getInt(colNm_RQST_CNT));	
						cstmt.setLong(7, rows[i].getLong(colNm_DG_AMT));
						cstmt.setLong(8, rows[i].getLong(colNm_DG_SUM_AMT));
						cstmt.setLong(9, rows[i].getLong(colNm_YS_AMT));
						cstmt.setLong(10, rows[i].getLong(colNm_YS_SUM_AMT));
						cstmt.setString(11, rows[i].getString(colNm_RQST_USE));
						cstmt.setString(12, rows[i].getString(colNm_DATE_USE));	
						cstmt.setString(13, rows[i].getString(colNm_RQST_NOTE));	
						cstmt.setString(14, iParamEmpno);
						cstmt.setString(15, iParamIp);
						cstmt.setString(16, "1");
						cstmt.setInt(17, rows[i].getInt(colNm_DG_CNT));
						cstmt.setInt(18, rows[i].getInt(colNm_ITEM_SEQ));
						
									
						cstmt.executeUpdate();
						
						if(cstmt!=null) cstmt.close();						
						break;
					case GauceDataRow.TB_JOB_UPDATE:
							
						//StringUtil.printMsg("call","PMS.PR_CT010i_05-UPDATE",this);
						cstmt = conn.prepareCall(arr_sql[3].toString());
					
						cstmt.setInt(1, rows[i].getInt(colNm_RQST_SID));
						cstmt.setInt(2, rows[i].getInt(colNm_ITEM_SID));
						cstmt.setString(3, rows[i].getString(colNm_ITEM_NM));
						cstmt.setString(4, rows[i].getString(colNm_ITEM_SIZE));
						cstmt.setString(5, rows[i].getString(colNm_ITEM_UNIT));	
						cstmt.setInt(6, rows[i].getInt(colNm_RQST_CNT));	
						cstmt.setLong(7, rows[i].getLong(colNm_DG_AMT));
						cstmt.setLong(8, rows[i].getLong(colNm_DG_SUM_AMT));
						cstmt.setLong(9, rows[i].getLong(colNm_YS_AMT));
						cstmt.setLong(10, rows[i].getLong(colNm_YS_SUM_AMT));
						cstmt.setString(11, rows[i].getString(colNm_RQST_USE));
						cstmt.setString(12, rows[i].getString(colNm_DATE_USE));	
						cstmt.setString(13, rows[i].getString(colNm_RQST_NOTE));	
						cstmt.setString(14, iParamEmpno);
						cstmt.setString(15, iParamIp);
						cstmt.setString(16, "3");
						cstmt.setInt(17, rows[i].getInt(colNm_DG_CNT));
						cstmt.setInt(18, rows[i].getInt(colNm_ITEM_SEQ));
						
						cstmt.executeUpdate();
						
						if(cstmt!=null) cstmt.close();	
						break;
					case GauceDataRow.TB_JOB_DELETE:
						//StringUtil.printMsg("call","PMS.PR_CT010i_05-DELETE",this);
						cstmt = conn.prepareCall(arr_sql[3].toString());
					
						cstmt.setInt(1, rows[i].getInt(colNm_RQST_SID));
						cstmt.setInt(2, rows[i].getInt(colNm_ITEM_SID));
						cstmt.setString(3, rows[i].getString(colNm_ITEM_NM));
						cstmt.setString(4, rows[i].getString(colNm_ITEM_SIZE));
						cstmt.setString(5, rows[i].getString(colNm_ITEM_UNIT));	
						cstmt.setInt(6, rows[i].getInt(colNm_RQST_CNT));	
						cstmt.setLong(7, rows[i].getLong(colNm_DG_AMT));
						cstmt.setLong(8, rows[i].getLong(colNm_DG_SUM_AMT));
						cstmt.setLong(9, rows[i].getLong(colNm_YS_AMT));
						cstmt.setLong(10, rows[i].getLong(colNm_YS_SUM_AMT));
						cstmt.setString(11, rows[i].getString(colNm_RQST_USE));
						cstmt.setString(12, rows[i].getString(colNm_DATE_USE));	
						cstmt.setString(13, rows[i].getString(colNm_RQST_NOTE));	
						cstmt.setString(14, iParamEmpno);
						cstmt.setString(15, iParamIp);
						cstmt.setString(16, "2");
						cstmt.setInt(17, rows[i].getInt(colNm_DG_CNT));
						cstmt.setInt(18, rows[i].getInt(colNm_ITEM_SEQ));				
						cstmt.executeUpdate();
			
						if(cstmt!=null) cstmt.close();	
						break;						
					}
				}
			}	//if (ds2 != null) {
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			//msgDS.flush();
			if(rs!=null) rs.close();
//				if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
			//if( fail == true ) throw new Exception("");			
		}
	}
}