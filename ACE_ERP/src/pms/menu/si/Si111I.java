package pms.menu.si;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import oracle.jdbc.OracleTypes;

import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import com.gauce.db.GauceStatement;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;

import pms.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;

public class Si111I extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//work Master 조회
		arr_sql[0].append ("{call PMS.PR_SI110I_01(?,?,?) }" );
		//work Detail 조회
		arr_sql[1].append ("{call PMS.PR_SI110I_11(?,?) }" );
		//detail1 조회
		arr_sql[2].append ("{call PMS.PR_SI110I_21(?,?) }" );
		//detail2 조회
		arr_sql[3].append ("{call PMS.PR_SI110I_31(?,?) }" );
		//detail3 조회
		arr_sql[4].append ("{call PMS.PR_SI110I_41(?,?) }" );
		
		//work Master 저장
		arr_sql[5].append ("{call PMS.PR_SI110I_02(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?) }" );
		//work Detail 저장
		arr_sql[6].append ("{call PMS.PR_SI110I_12(?,?,?,?,?, ?) }" );
		//detail1 저장
		arr_sql[7].append ("{call PMS.PR_SI110I_22(?,?,?,?,?, ?,?) }" );
		//detail2 저장
		arr_sql[8].append ("{call PMS.PR_SI110I_32(?,?,?,?,?) }" );
		//detail3 저장
		arr_sql[9].append ("{call PMS.PR_SI110I_42(?,?,?,?,? ) }" );

		//work Master 날짜 중복 체크
		arr_sql[10].append ("{call PMS.PR_SI110I_03(?,?,?,?,?) }" );

		
   }

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("초기화~!","",this);
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
            	if(dSets[i].getName().equals("ds_wm")){
					GauceDataSet ds1 = gis.read("DS_WM");
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setInt(1, 0);
					cstmt.setString(2, "20000101");
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_wd")){	//work detail 조회
					GauceDataSet ds1 = gis.read("DS_WD");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt(1, 0);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	
            	if(dSets[i].getName().equals("ds_detail1")){	//하단 detail 1 조회 : 인력
					GauceDataSet ds1 = gis.read("DS_DETAIL1");
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setInt(1, 0);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_detail2")){	//하단 detail 2 조회 : 주요 장비
					GauceDataSet ds1 = gis.read("DS_DETAIL2");
					cstmt = conn.prepareCall(arr_sql[3].toString());
					cstmt.setInt(1, 0);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_detail3")){	//하단 detail 3 조회 : 주요자재
					GauceDataSet ds1 = gis.read("DS_DETAIL3");
					cstmt = conn.prepareCall(arr_sql[4].toString());
					cstmt.setInt(1, 0);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            }
		}catch (SQLException sqle){
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
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		int v_site_sid 				= HDUtil.nullCheckNum(greq.getParameter("v_site_sid"));			// 현장sid
		String v_date 				= HDUtil.nullCheckStr(greq.getParameter("v_date"));				// 작업일자
		int v_dwr_sid 				= HDUtil.nullCheckNum(greq.getParameter("v_dwr_sid"));			// DWR_sid

		//내부 변수
		String r_s_yn		= null;
		String r_msg_cd		= null;
		String r_msg		= null;		
		//StringUtil.printMsg("v_site_sid",v_site_sid,this);
		//StringUtil.printMsg("v_date",v_date,this);
		//StringUtil.printMsg("v_dwr_sid",v_dwr_sid,this);

		try {
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
            	if(dSets[i].getName().equals("ds_wm")){
					GauceDataSet ds1 = gis.read("DS_WM");
					
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setInt(1, v_site_sid);
					cstmt.setString(2, v_date);
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 					
				
					//GAUCE 5.x버전 : OutputStream에 DS를 써보낸다.
					//	getDataSet(rs,ds1)을 호출하면 SuperServlet에서 rs를 ds1에 담아 ds1를 리턴~!
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_wd")){	//work detail 조회
					GauceDataSet ds1 = gis.read("DS_WD");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt(1, v_dwr_sid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	
            	if(dSets[i].getName().equals("ds_detail1")){	//하단 detail 1 조회 : 인력
					GauceDataSet ds1 = gis.read("DS_DETAIL1");
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setInt(1, v_dwr_sid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_detail2")){	//하단 detail 2 조회 : 주요 장비
					GauceDataSet ds1 = gis.read("DS_DETAIL2");
					cstmt = conn.prepareCall(arr_sql[3].toString());
					cstmt.setInt(1, v_dwr_sid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_detail3")){	//하단 detail 3 조회 : 주요자재
					GauceDataSet ds1 = gis.read("DS_DETAIL3");
					cstmt = conn.prepareCall(arr_sql[4].toString());
					cstmt.setInt(1, v_dwr_sid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            			
            	if(dSets[i].getName().equals("ds_wm_chk")){
					GauceDataSet ds_wm_chk = gis.read("DS_WM_CHK");	//일자 중복 체크 결과
					
					cstmt = conn.prepareCall(arr_sql[10].toString());
					cstmt.setInt(1, v_site_sid);
					cstmt.setString(2, v_date);
					cstmt.registerOutParameter(3, OracleTypes.VARCHAR);	//결과를 받을 
					cstmt.registerOutParameter(4, OracleTypes.VARCHAR);	//결과를 받을 
					cstmt.registerOutParameter(5, OracleTypes.VARCHAR);	//결과를 받을
					
					cstmt.executeQuery();
					r_s_yn		 = cstmt.getString(3);
					r_msg_cd	 = cstmt.getString(4);
					r_msg		 = cstmt.getString(5);
					
					//StringUtil.printMsg(" r_s_yn",cstmt.getString(3),this);
					
					//if(!r_s_yn.equals("Y"))
						//throw new Exception (r_msg);
					
					if(ds_wm_chk!=null){
						ds_wm_chk.put("S_YN", 	r_s_yn, 1);//커서 OUT param.
						ds_wm_chk.put("MSG_CD", r_msg_cd, 4);//커서 OUT param.
						ds_wm_chk.put("MSG", 	r_msg, 200);//커서 OUT param.
						ds_wm_chk.heap();
					}
					if(cstmt!=null) cstmt.close();
					if(ds_wm_chk!=null) gos.write(ds_wm_chk);
            	}
            }
		}catch (SQLException sqle){
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
	
	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("저장~!","",this);
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 			rs 			= null;
		
		String iParamEmpno 	= fParamEmpno;
		String iParamIp 	= fParamIp;
				
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
        GauceDataSet ds_wm= gis.read("DS_WM");
        GauceDataSet ds_wd= gis.read("DS_WD");
        GauceDataSet ds_detail1 = gis.read("DS_DETAIL1");
        GauceDataSet ds_detail2 = gis.read("DS_DETAIL2");
        GauceDataSet ds_detail3 = gis.read("DS_DETAIL3");
		try{
			if (ds_wm != null) {
				GauceDataRow[] 		rows = ds_wm.getDataRows();
				int colNm_dwr_sid      	= ds_wm.indexOfColumn("dwr_sid");
				int colNm_site_sid      = ds_wm.indexOfColumn("site_sid");
				int colNm_w_date		= ds_wm.indexOfColumn("w_date");                    
				int colNm_man_pre		= ds_wm.indexOfColumn("man_pre");
				int colNm_man_now    	= ds_wm.indexOfColumn("man_now");   
				int colNm_machine_pre   = ds_wm.indexOfColumn("machine_pre");           
				int colNm_machine_now   = ds_wm.indexOfColumn("machine_now");        
				int colNm_w_pre     	= ds_wm.indexOfColumn("w_pre");      
				int colNm_w_now    		= ds_wm.indexOfColumn("w_now");    
				int colNm_wed    		= ds_wm.indexOfColumn("wed");     
				int colNm_w_remark		= ds_wm.indexOfColumn("w_remark");
				int colNm_temp_max     	= ds_wm.indexOfColumn("temp_max");    
				int colNm_temp_min      = ds_wm.indexOfColumn("temp_min");         
				int colNm_rate_plan   	= ds_wm.indexOfColumn("rate_plan");   
				int colNm_rate_result   = ds_wm.indexOfColumn("rate_result");        
				int colNm_remark        = ds_wm.indexOfColumn("remark");
				
				//StringUtil.printMsg("colNm_OrdererNm",colNm_OrdererNm,this);
				for(int i=0; i<rows.length; i++){
			
					//StringUtil.printMsg("ds_wm "+i+"행 작업===",rows[i].getJobType(),this);
					// 가우스 행 JobType : 2=insert, 3=update, 4=delete
					/*StringUtil.printMsg("colNm_dwr_sid",rows[i].getInt(colNm_dwr_sid),this);
					StringUtil.printMsg("colNm_site_sid",rows[i].getInt(colNm_site_sid),this);
					StringUtil.printMsg("colNm_w_date",rows[i].getString(colNm_w_date),this);
					StringUtil.printMsg("colNm_man_pre",rows[i].getInt(colNm_man_pre),this);
					StringUtil.printMsg("colNm_man_now",rows[i].getInt(colNm_man_now),this);
					StringUtil.printMsg("colNm_machine_pre",rows[i].getInt(colNm_machine_pre),this);
					StringUtil.printMsg("colNm_machine_now",rows[i].getInt(colNm_machine_now),this);
					StringUtil.printMsg("colNm_w_pre",rows[i].getString(colNm_w_pre),this);
					StringUtil.printMsg("colNm_w_now",rows[i].getString(colNm_w_now),this);
					StringUtil.printMsg("colNm_w_remark",rows[i].getString(colNm_w_remark),this);
					StringUtil.printMsg("colNm_wed",rows[i].getString(colNm_wed),this);
					StringUtil.printMsg("colNm_temp_max",rows[i].getInt(colNm_temp_max),this);
					StringUtil.printMsg("colNm_temp_min",rows[i].getInt(colNm_temp_min),this);
					StringUtil.printMsg("colNm_rate_plan",rows[i].getString(colNm_rate_plan),this);
					StringUtil.printMsg("colNm_rate_result",rows[i].getString(colNm_rate_result),this);
					StringUtil.printMsg("colNm_remark",rows[i].getString(colNm_remark),this);
					StringUtil.printMsg("jobtype",rows[i].getJobType(),this);
					StringUtil.printMsg("iParamEmpno",iParamEmpno,this);
					StringUtil.printMsg("iParamIp",iParamIp,this);
					*/
					
					cstmt = conn.prepareCall(arr_sql[5].toString());
					cstmt.setInt(1, rows[i].getInt(colNm_dwr_sid) );
					cstmt.setInt(2, rows[i].getInt(colNm_site_sid) );
					cstmt.setString(3, rows[i].getString(colNm_w_date));
					cstmt.setInt(4, rows[i].getInt(colNm_man_pre) );
					cstmt.setInt(5, rows[i].getInt(colNm_man_now) );
					cstmt.setInt(6, rows[i].getInt(colNm_machine_pre) );
					cstmt.setInt(7, rows[i].getInt(colNm_machine_now) );
					cstmt.setString(8, rows[i].getString(colNm_w_pre));	
					cstmt.setString(9, rows[i].getString(colNm_w_now));	
					cstmt.setString(10, rows[i].getString(colNm_w_remark));
					cstmt.setString(11, rows[i].getString(colNm_wed));
					cstmt.setInt(12, rows[i].getInt(colNm_temp_max) );
					cstmt.setInt(13, rows[i].getInt(colNm_temp_min) );
					cstmt.setInt(14, rows[i].getInt(colNm_rate_plan) );
					cstmt.setInt(15, rows[i].getInt(colNm_rate_result) );
					cstmt.setString(16, rows[i].getString(colNm_remark));
					cstmt.setInt(17, rows[i].getJobType() );	//가우스행 작업 값
					cstmt.setString(18, iParamEmpno);
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();		
						
				}
			}
			if (ds_wd != null) {
				GauceDataRow[] 		rows = ds_wd.getDataRows();
				int colNm_dwr_sid   = ds_wd.indexOfColumn("dwr_sid");
				int colNm_wd_code	= ds_wd.indexOfColumn("wd_code");
				int colNm_wd_now	= ds_wd.indexOfColumn("wd_now");                    
				int colNm_wd_post	= ds_wd.indexOfColumn("wd_post");
				
				//StringUtil.printMsg("colNm_OrdererNm",colNm_OrdererNm,this);
				for(int i=0; i<rows.length; i++){
			
					//StringUtil.printMsg("ds_wd "+i+"행 작업===",rows[i].getJobType(),this);
					// 가우스 행 JobType : 2=insert, 3=update, 4=delete

					/*StringUtil.printMsg("colNm_dwr_sid",rows[i].getInt(colNm_dwr_sid),this);
					StringUtil.printMsg("colNm_wd_code",rows[i].getString(colNm_wd_code),this);
					StringUtil.printMsg("colNm_wd_now",rows[i].getString(colNm_wd_now),this);
					StringUtil.printMsg("colNm_wd_post",rows[i].getString(colNm_wd_post),this);
					StringUtil.printMsg("jobtype",rows[i].getJobType(),this);
					StringUtil.printMsg("iParamEmpno",iParamEmpno,this);
					*/
					//StringUtil.printMsg("iParamIp",iParamIp,this);
					
					cstmt = conn.prepareCall(arr_sql[6].toString());
					cstmt.setInt(1, rows[i].getInt(colNm_dwr_sid) );
					cstmt.setString(2, rows[i].getString(colNm_wd_code));
					cstmt.setString(3, rows[i].getString(colNm_wd_now));
					cstmt.setString(4, rows[i].getString(colNm_wd_post));
					cstmt.setInt(5, rows[i].getJobType() );	//가우스행 작업 값
					cstmt.setString(6, iParamEmpno);
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();		
						
				}
			}
			if (ds_detail1 != null) {
				GauceDataRow[] 		rows = ds_detail1.getDataRows();
				int v_dwr_sid 			= HDUtil.nullCheckNum(greq.getParameter("v_dwr_sid"));			// DWR_sid					
				int colNm_bp_sid		= ds_detail1.indexOfColumn("bp_sid");
				int colNm_bid_site_kind	= ds_detail1.indexOfColumn("bid_site_kind");
				int colNm_bid_sid		= ds_detail1.indexOfColumn("bid_sid");
				int colNm_commit_cnt	= ds_detail1.indexOfColumn("now_commit");

				for(int i=0; i<rows.length; i++){
			
					//StringUtil.printMsg("ds_detail1의 "+i+"행 작업===",rows[i].getJobType(),this);
					// 가우스 행 JoibType : 2=insert, 3=update, 4=delete
					//StringUtil.printMsg("v_dwr_sid",v_dwr_sid,this);
					//StringUtil.printMsg("colNm_bp_sid",rows[i].getString(colNm_bp_sid),this);
					//StringUtil.printMsg("colNm_bid_site_kind",rows[i].getString(colNm_bid_site_kind),this);
					//StringUtil.printMsg("colNm_bid_sid",rows[i].getString(colNm_bid_sid),this);
					//StringUtil.printMsg("colNm_commit_cnt",rows[i].getString(colNm_commit_cnt),this);
					
					cstmt = conn.prepareCall(arr_sql[7].toString());
					cstmt.setInt(1, v_dwr_sid);
					cstmt.setInt(2, rows[i].getInt(colNm_bp_sid));
					cstmt.setString(3, rows[i].getString(colNm_bid_site_kind));		//연도
					cstmt.setInt(4, rows[i].getInt(colNm_bid_sid));
					cstmt.setInt(5, rows[i].getInt(colNm_commit_cnt));
					cstmt.setInt(6, rows[i].getJobType());	//가우스행 작업 값
					cstmt.setString(7, iParamEmpno);
					
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();		
					
			
				}
			}
			if (ds_detail2 != null) {
				GauceDataRow[] 		rows = ds_detail2.getDataRows();
				int v_dwr_sid 			= HDUtil.nullCheckNum(greq.getParameter("v_dwr_sid"));			// DWR_sid					
				int colNm_item_sid		= ds_detail2.indexOfColumn("item_sid");
				int colNm_commit_cnt	= ds_detail2.indexOfColumn("now_commit");

				for(int i=0; i<rows.length; i++){
			
					//StringUtil.printMsg("ds_detail2의 "+i+"행 작업===",rows[i].getJobType(),this);
					// 가우스 행 JoibType : 2=insert, 3=update, 4=delete
					//StringUtil.printMsg("v_dwr_sid",v_dwr_sid,this);
					//StringUtil.printMsg("colNm_item_sid",rows[i].getString(colNm_item_sid),this);
					//StringUtil.printMsg("colNm_commit_cnt",rows[i].getString(colNm_commit_cnt),this);
					
					cstmt = conn.prepareCall(arr_sql[8].toString());
					cstmt.setInt(1, v_dwr_sid);
					cstmt.setInt(2, rows[i].getInt(colNm_item_sid));
					cstmt.setInt(3, rows[i].getInt(colNm_commit_cnt));
					cstmt.setInt(4, rows[i].getJobType());	//가우스행 작업 값
					cstmt.setString(5, iParamEmpno);
					
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();		
					
			
				}
			}
			if (ds_detail3 != null) {
				GauceDataRow[] 		rows = ds_detail3.getDataRows();
				int v_dwr_sid 			= HDUtil.nullCheckNum(greq.getParameter("v_dwr_sid"));			// DWR_sid					
				int colNm_item_sid		= ds_detail3.indexOfColumn("item_sid");
				int colNm_commit_cnt	= ds_detail3.indexOfColumn("now_commit");

				for(int i=0; i<rows.length; i++){
			
					//StringUtil.printMsg("ds_detail3의 "+i+"행 작업===",rows[i].getJobType(),this);
					// 가우스 행 JoibType : 2=insert, 3=update, 4=delete
					//StringUtil.printMsg("v_dwr_sid",v_dwr_sid,this);
					//StringUtil.printMsg("colNm_item_sid",rows[i].getString(colNm_item_sid),this);
					//StringUtil.printMsg("colNm_commit_cnt",rows[i].getString(colNm_commit_cnt),this);
					
					cstmt = conn.prepareCall(arr_sql[9].toString());
					cstmt.setInt(1, v_dwr_sid);
					cstmt.setInt(2, rows[i].getInt(colNm_item_sid));
					cstmt.setInt(3, rows[i].getInt(colNm_commit_cnt));
					cstmt.setInt(4, rows[i].getJobType());	//가우스행 작업 값
					cstmt.setString(5, iParamEmpno);
					
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();		
					
			
				}
			}


			gos.close();
		} catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e) {
			gres.addException(e);
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
		}        
	}
}