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

public class Pu110S extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//마스터 조회
		arr_sql[0].append ("{call PMS.PR_Pu110S_01(?,?,?,?,?,     ?,?) }" );

		//Detail 조회
		arr_sql[1].append ("{call PMS.PR_Pu110S_02(?,?) }" );

		//Main 저장
		arr_sql[2].append ("{call PMS.PR_Pu110S_03(?,?,?,?,?,   ?,?,?,?,?,   ?,?,?,?) }");
		//Detail 저장
		arr_sql[3].append ("{call PMS.PR_Pu110S_04(?,?,?,?,?,   ?,?,?,?,?,   ?,?,?,?,?                ,?) }");

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
			   		//StringUtil.printMsg("O:DS_DEFAULT TYPE","선조회",this);
		   			GauceDataSet ds1 = gis.read("DS_DEFAULT");
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setString(1, "6080001");
						cstmt.setInt(2, 1);
						cstmt.setString(3, "19990101");
						cstmt.setString(4, "19990101");
						cstmt.setString(5, "2");cstmt.registerOutParameter(6, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(6);	//커서 OUT param. 			
						//GAUCE 5.x버전 : OutputStream에 DS를 써보낸다.
						//getDataSet(rs,ds1)을 호출하면 SuperServlet에서 rs를 ds1에 담아 ds1를 리턴~!
						gos.write(getDataSet(rs, ds1));
					} else if(dSets[i].getName().equals("ds_tender")){
						//StringUtil.printMsg("DS_TENDER TYPE","선조회",this);
						GauceDataSet ds1 = gis.read("DS_TENDER");
						//StringUtil.printMsg("DS DS_TENDER","선조회",this);
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1, 0);
						cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
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
						String sNowEmpno	= HDUtil.nullCheckStr(greq.getParameter("v_empno"));	// 로긴사번
						int v_site_sid 			= HDUtil.nullCheckNum(greq.getParameter("v_site_sid"));			// 현장 SID
						String v_fr_rqst_date 	= HDUtil.nullCheckStr(greq.getParameter("v_fr_rqst_date")); 	// 요청일자 시작
						String v_to_rqst_date	= HDUtil.nullCheckStr(greq.getParameter("v_to_rqst_date")); 	// 요청일자 종료
						String v_rqst_status		= HDUtil.nullCheckStr(greq.getParameter("v_rqst_status")); 	// 요청상태
						String sRqstNo			= HDUtil.nullCheckStr(greq.getParameter("v_rqst_no"));			// 청구번호

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
						cstmt.setString(6, sRqstNo);
						cstmt.registerOutParameter(7, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(7);	//커서 OUT param. 			
						//GAUCE 5.x버전 : OutputStream에 DS를 써보낸다.
						//getDataSet(rs,ds1)을 호출하면 SuperServlet에서 rs를 ds1에 담아 ds1를 리턴~!
						gos.write(getDataSet(rs, ds1));
					} else if(dSets[i].getName().equals("ds_tender")){
						int v_rqst_sid = HDUtil.nullCheckNum(greq.getParameter("v_rqst_sid"));			// 현장 SID
						GauceDataSet ds1 = gis.read("DS_TENDER");
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1, v_rqst_sid);
						cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
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
		GauceDataSet ds1 = gis.read("DS_DEFAULT");
		GauceDataSet ds2 = gis.read("DS_TENDER");
		GauceDataSet rqstNoDS = gis.read("rqstNoDS");
					
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
					
					
				int colNm_RQST_STATUS    = ds1.indexOfColumn("RQST_STATUS");	//청구상태
				int colNm_RQST_DATE        = ds1.indexOfColumn("RQST_DATE"); 		//청구일자
				int colNm_RQST_NO      		= ds1.indexOfColumn("RQST_NO");  		// 청구번호
				int colNm_RQST_SID       	= ds1.indexOfColumn("RQST_SID"); 		//청구SID
				int colNm_SITE_CD    			= ds1.indexOfColumn("SITE_CD"); 			//현장코드
				int colNm_PU_EMPNO	    	= ds1.indexOfColumn("PU_EMPNO"); 		//현장담당자사번
				int colNm_SITE_NM     		= ds1.indexOfColumn("SITE_NM");    		//현장명
				int colNm_SITE_SID       		= ds1.indexOfColumn("SITE_SID");     		//현장SID
				int colNm_RQST_USE        	= ds1.indexOfColumn("RQST_USE");  		//사용처
				//int colNm_REAL_FILE        	= ds1.indexOfColumn("real_file");  			//real_file
				//int colNm_SYS_FILE        	= ds1.indexOfColumn("sys_file");  			//sys_file
				String v_sys_file 	= HDUtil.nullCheckStr(greq.getParameter("sSysFile")); 	// 첨부파일system
				String v_real_file	= HDUtil.nullCheckStr(greq.getParameter("sRealFile")); 	// 첨부파일real
					
				//StringUtil.printMsg("colNm_SiteNm",colNm_SiteNm,this);
				//청구번호
				//res.enableFirstRow(rqstNoDS);
				//rqstNoDS.addDataColumn(new GauceDataColumn("RQST_NO", GauceDataColumn.TB_STRING));

				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
						
						StringUtil.printMsg("call","PMS.PR_CT010i_04-INSERT",this);
						StringUtil.printMsg("colNm_RQST_STATUS",rows[i].getString(colNm_RQST_STATUS),this);
						StringUtil.printMsg("colNm_RQST_DATE",rows[i].getString(colNm_RQST_DATE),this);
						StringUtil.printMsg("colNm_RQST_NO",rows[i].getString(colNm_RQST_NO),this);
						StringUtil.printMsg("colNm_RQST_SID",rows[i].getString(colNm_RQST_SID),this);
						StringUtil.printMsg("colNm_SITE_CD",rows[i].getString(colNm_SITE_CD),this);
						StringUtil.printMsg("colNm_PU_EMPNO",rows[i].getString(colNm_PU_EMPNO),this);
						StringUtil.printMsg("colNm_SITE_NM",rows[i].getString(colNm_SITE_NM),this);
						StringUtil.printMsg("colNm_SITE_SID",rows[i].getString(colNm_SITE_SID),this);
						StringUtil.printMsg("colNm_RQST_USE",rows[i].getString(colNm_RQST_USE),this);
						StringUtil.printMsg("colNm_RQST_USE",rows[i].getString(colNm_RQST_USE),this);
						StringUtil.printMsg("v_sys_file",v_sys_file,this);
						StringUtil.printMsg("v_real_file",v_real_file,this);
						
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
							cstmt.setString(10, v_real_file);
							cstmt.setString(11, v_sys_file);
							cstmt.setString(12, iParamEmpno);
							cstmt.setString(13, iParamIp);
							cstmt.setString(14, "1");
								
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
							cstmt.setString(10, v_real_file);
							cstmt.setString(11, v_sys_file);
							cstmt.setString(12, iParamEmpno);
							cstmt.setString(13, iParamIp);
							cstmt.setString(14, "3");
							
							
					
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
							cstmt.setString(10, v_real_file);
							cstmt.setString(11, v_sys_file);
							cstmt.setString(12, iParamEmpno);
							cstmt.setString(13, iParamIp);
							cstmt.setString(14, "2");
							
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
					
			
				int colNm_RQST_SID	      	= ds2.indexOfColumn("RQST_SID");	       	// 청구 SID
				int colNm_ITEM_SID      		= ds2.indexOfColumn("ITEM_SID");       	// 품목 SID
				int colNm_ITEM_NM        		= ds2.indexOfColumn("ITEM_NM");  			// 품명
				int colNm_ITEM_SIZE			= ds2.indexOfColumn("ITEM_SIZE");			// 규격
				int colNm_ITEM_UNIT			= ds2.indexOfColumn("ITEM_UNIT");			// 단위
				int colNm_RQST_CNT  		= ds2.indexOfColumn("RQST_CNT");    	// 수량
				int colNm_DG_AMT  		= ds2.indexOfColumn("DG_AMT");    	// 도급단가
				int colNm_DG_SUM_AMT  		= ds2.indexOfColumn("DG_SUM_AMT");    	// 도급액
				int colNm_YS_AMT  		= ds2.indexOfColumn("YS_AMT");    	// 예산단가
				int colNm_YS_SUM_AMT  		= ds2.indexOfColumn("YS_SUM_AMT");    	// 예산액
				int colNm_RQST_USE      	= ds2.indexOfColumn("RQST_USE");       	// 용도
				int colNm_DATE_USE 			= ds2.indexOfColumn("DATE_USE");   		// 소요일
				int colNm_RQST_NOTE 		= ds2.indexOfColumn("RQST_NOTE");   	// 청구비고
				
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
						
						cstmt = conn.prepareCall(arr_sql[3].toString());
					
						cstmt.setInt(1, rows[i].getInt(colNm_RQST_SID));
						cstmt.setInt(2, rows[i].getInt(colNm_ITEM_SID));
						cstmt.setString(3, rows[i].getString(colNm_ITEM_NM));
						cstmt.setString(4, rows[i].getString(colNm_ITEM_SIZE));
						cstmt.setString(5, rows[i].getString(colNm_ITEM_UNIT));	
						cstmt.setInt(6, rows[i].getInt(colNm_RQST_CNT));	
						cstmt.setInt(7, rows[i].getInt(colNm_DG_AMT));
						cstmt.setInt(8, rows[i].getInt(colNm_DG_SUM_AMT));
						cstmt.setInt(9, rows[i].getInt(colNm_YS_AMT));
						cstmt.setInt(10, rows[i].getInt(colNm_YS_SUM_AMT));
						cstmt.setString(11, rows[i].getString(colNm_RQST_USE));
						cstmt.setString(12, rows[i].getString(colNm_DATE_USE));	
						cstmt.setString(13, rows[i].getString(colNm_RQST_NOTE));	
						cstmt.setString(14, iParamEmpno);
						cstmt.setString(15, iParamIp);
						cstmt.setString(16, "1");
									
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
						cstmt.setInt(7, rows[i].getInt(colNm_DG_AMT));
						cstmt.setInt(8, rows[i].getInt(colNm_DG_SUM_AMT));
						cstmt.setInt(9, rows[i].getInt(colNm_YS_AMT));
						cstmt.setInt(10, rows[i].getInt(colNm_YS_SUM_AMT));
						cstmt.setString(11, rows[i].getString(colNm_RQST_USE));
						cstmt.setString(12, rows[i].getString(colNm_DATE_USE));	
						cstmt.setString(13, rows[i].getString(colNm_RQST_NOTE));	
						cstmt.setString(14, iParamEmpno);
						cstmt.setString(15, iParamIp);
						cstmt.setString(16, "3");

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
						cstmt.setInt(7, rows[i].getInt(colNm_DG_AMT));
						cstmt.setInt(8, rows[i].getInt(colNm_DG_SUM_AMT));
						cstmt.setInt(9, rows[i].getInt(colNm_YS_AMT));
						cstmt.setInt(10, rows[i].getInt(colNm_YS_SUM_AMT));
						cstmt.setString(11, rows[i].getString(colNm_RQST_USE));
						cstmt.setString(12, rows[i].getString(colNm_DATE_USE));	
						cstmt.setString(13, rows[i].getString(colNm_RQST_NOTE));	
						cstmt.setString(14, iParamEmpno);
						cstmt.setString(15, iParamIp);
						cstmt.setString(16, "2");
						cstmt.executeUpdate();
			
						if(cstmt!=null) cstmt.close();	
						break;						
					}
				}
			}	//if (ds2 != null) {
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