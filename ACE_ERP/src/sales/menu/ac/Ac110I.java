package sales.menu.ac;

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


import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Ac110I extends SuperServlet {
	
	private static final long serialVersionUID = 1L;


	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
	
		arr_sql[1].append("CALL SALES.PR_AC110I_01(?,?,?,?,?,?,?,?,  ?)");
		arr_sql[2].append("CALL SALES.PR_AC110I_03(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		arr_sql[3].append("CALL SALES.PR_RV200I_06(?,?,?,?,?,?,?,?,?,?)");
		arr_sql[4].append("CALL SALES.PR_RV201S_02(?) ");		
		arr_sql[5].append("CALL SALES.PR_RV201I_03(?,?,?,?,?  ,?)");	//--예약판매자 체크 버튼
	}
 		                                                                
	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {

	}
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		
		try {
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
            
			/* 검색시 필요한 조건 */
			String sSDate = HDUtil.nullCheckStr(greq.getParameter("sSDate"));
			String sAcceptNo = HDUtil.nullCheckStr(greq.getParameter("sAcceptNo"));
			String sRoomType = HDUtil.nullCheckStr(greq.getParameter("sRoomType"));
			String sPrice = HDUtil.nullCheckStr(greq.getParameter("sPrice"));
			String sCustNm = HDUtil.nullCheckStr(greq.getParameter("sCustNm"));
			String v_out_gubn = HDUtil.nullCheckStr(greq.getParameter("v_out_gubn"));
			int sGoods_sid = HDUtil.nullCheckNum(greq.getParameter("sGoods_sid"));
			int sClientSid = HDUtil.nullCheckNum(greq.getParameter("sClientSid"));
			
			/*StringUtil.printMsg("sSDate",sSDate,this);
			StringUtil.printMsg("sAcceptNo",sAcceptNo,this);
			StringUtil.printMsg("sRoomType",sRoomType,this);
			StringUtil.printMsg("sPrice",sPrice,this);
			StringUtil.printMsg("sCustNm",sCustNm,this);
			StringUtil.printMsg("v_out_gubn",v_out_gubn,this);
			StringUtil.printMsg("sGoods_sid",sGoods_sid,this);
			StringUtil.printMsg(" sClientSid",sClientSid,this);*/	
			
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//	DEFAULT=ds1
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DEFAULT");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, sSDate);						// 출발일자
					cstmt.setInt(2, sGoods_sid);					// 상품SID
					cstmt.setString(3, sAcceptNo);					// 신청서번호
					cstmt.setString(4, sRoomType.toUpperCase());		// 객실타입
					cstmt.setString(5, sPrice);						// 판매가
					cstmt.setString(6, sCustNm);					// 성명
					cstmt.setString(7, v_out_gubn);					// 출경구분
					cstmt.setInt(8,sClientSid);
					cstmt.registerOutParameter(9, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(9);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}			
			}
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
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		ResultSet 			rs 			= null;
		CallableStatement cstmt = null;

		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		/* DataSet */
		GauceDataSet ds1 		= gis.read("DS1");		//DS1=ds1	직접 수정 저장시
		GauceDataSet ds_result 	= gis.read("DS2");	//판매가 계산 결과		DS2=ds_result
		GauceDataSet ds3 		= gis.read("DS3");		//DS3=ds1	방문횟수 재계산  되려나.?
		
		//내부 변수
		String r_s_yn		= "";
		String r_msg_cd		= "";
		String r_msg		= "";
		

		
		try {
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();

				int colNm_RsvSid      	= ds1.indexOfColumn("RSV_SID"); 	// 예약SID
				int colNm_UseDate      	= ds1.indexOfColumn("USE_DATE");	// 사용일자
				int colNm_KeySeq		= ds1.indexOfColumn("KEY_SEQ");		// 순번
				int colNm_UseAmt		= ds1.indexOfColumn("USE_AMT");		// 판매가
				int colNm_StdAmt		= ds1.indexOfColumn("STD_AMT");		// 표준요금
				int colNm_CustType		= ds1.indexOfColumn("CUST_TYPE"); // 할인코드  
				int colNm_AgeCd		    = ds1.indexOfColumn("AGE_CD");		 // 연령코드

				int colNm_CAROWNER_YN	=	ds1.indexOfColumn("CAROWNER_YN");	//자차여부      
				int colNm_JEJU_YN	 	=	ds1.indexOfColumn("JEJU_YN");		//제주여부      
				int colNm_WEEKEND_YN 	=	ds1.indexOfColumn("WEEKEND_YN");	//주말여부      
				int colNm_THEME_CD	 	=	ds1.indexOfColumn("THEME_CD");		//테마코드      

				for(int i=0; i<rows.length; i++){
				switch(rows[i].getJobType()){
					case GauceDataRow.TB_JOB_UPDATE:
						
						cstmt = conn.prepareCall(arr_sql[2].toString());
						
						//StringUtil.printMsg("=============================== 마스터 신규 =========================",this);
						//StringUtil.printMsg("1", rows[i].getString(colNm_RsvSid),this);
						//StringUtil.printMsg("2", rows[i].getString(colNm_CustType),this);
						//StringUtil.printMsg("3", rows[i].getString(colNm_AgeCd),this);
						//StringUtil.printMsg("4", rows[i].getString(colNm_UseDate),this);
						//StringUtil.printMsg("5", rows[i].getString(colNm_KeySeq),this);
						//StringUtil.printMsg("6", rows[i].getString(colNm_UseAmt),this);
						//StringUtil.printMsg("7", rows[i].getString(colNm_StdAmt),this);
						
						cstmt.setInt(1, rows[i].getInt(colNm_RsvSid));
						cstmt.setString(2, rows[i].getString(colNm_CustType));
						cstmt.setString(3, rows[i].getString(colNm_AgeCd));
						cstmt.setString(4, rows[i].getString(colNm_UseDate));
						cstmt.setInt(5, rows[i].getInt(colNm_KeySeq));
						cstmt.setInt(6, rows[i].getInt(colNm_UseAmt));
						cstmt.setInt(7, rows[i].getInt(colNm_StdAmt));
						cstmt.setString(8, rows[i].getString(colNm_CAROWNER_YN));               
						cstmt.setString(9, rows[i].getString(colNm_JEJU_YN));                   
						cstmt.setString(10, rows[i].getString(colNm_WEEKEND_YN));                
						cstmt.setString(11, rows[i].getString(colNm_THEME_CD));                     
						cstmt.setString(12, fParamEmpno);
						cstmt.setString(13, fParamIp);
						cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
						// 쿼리실행
						cstmt.executeUpdate();
						
						//StringUtil.printMsg("실행 끝 ", "",this);
						break;
					}
				}
			}
					
			//판매가 계산
			if (ds_result != null) {
				GauceDataRow[] 		rows = ds_result.getDataRows();
				GauceDataColumn[] 	cols = ds_result.getDataColumns();
				//System.out.println("DS2");
				if(ds_result!=null){
					ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
					ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
					ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
				}
						
						
				int    v_accept_sid  = HDUtil.nullCheckNum(greq.getParameter("v_accept_sid"));	//신청서번호
				//StringUtil.printMsg("v_accept_sid",v_accept_sid,this);
				cstmt = conn.prepareCall(arr_sql[3].toString());

				cstmt.setInt        (1,  v_accept_sid);
				cstmt.registerOutParameter(2, java.sql.Types.DECIMAL);
				cstmt.registerOutParameter(3, java.sql.Types.DECIMAL);
				cstmt.setString		(4, "AC110I");
				cstmt.setString     (5, fParamEmpno);
				cstmt.setString     (6, fParamIp);
				cstmt.setString     (7, "3");
				cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
				cstmt.executeUpdate();
				
				//System.out.println("요기~~~~~");
				r_s_yn 		= cstmt.getString(8);
				r_msg_cd 	= cstmt.getString(9);
				r_msg 		= cstmt.getString(10);
				
				if(!r_s_yn.equals("Y")){
					//res.writeException("ERROR", r_msg_cd, r_msg);
				}
				
				if(ds_result!=null){
					GauceDataRow row1 = ds_result.newDataRow();
					row1.addColumnValue(r_s_yn);
					row1.addColumnValue(r_msg_cd);
					row1.addColumnValue(r_msg);
					
					ds_result.addDataRow(row1);
				}
				
				if(ds_result!=null) ds_result.flush();									
			}

			//개인 방문 내역 조회
			if (ds3 != null) {
				GauceDataRow[] 		rows = ds3.getDataRows();
				GauceDataColumn[] 	cols = ds3.getDataColumns();
						
				int colNm_ManageNo		= ds3.indexOfColumn("MANAGE_NO");		 // 주민/여권번호

				for(int i=0; i<rows.length; i++){
					//StringUtil.printMsg("v_accept_sid",v_accept_sid,this);
					cstmt = conn.prepareCall(arr_sql[4].toString());
					cstmt.setString(1, rows[i].getString(colNm_ManageNo));
					cstmt.executeUpdate();
					//System.out.println("요기~~~~~");
				}		
			}
					
			//예약판매 체크
			/*
			if ("DS4".equals(gauceName)) {
				//System.out.println("DS2");
				if(ds_result!=null){
					res.enableFirstRow(ds_result);
					ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
					ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
					ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
				}
				
				int    v_accept_sid  = HDUtil.nullCheckNum(req.getParameter("v_accept_sid"));	//신청서번호
				StringUtil.printMsg("v_accept_sid",v_accept_sid,this);
							
				cstmt = conn.prepareCall(arr_sql[5].toString());

				cstmt.setInt        (1,  v_accept_sid);
				cstmt.setString     (2, fParamEmpno);
				cstmt.setString     (3, fParamIp);
				cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
				cstmt.executeUpdate();
				
				//System.out.println("요기~~~~~");
				r_s_yn 		= cstmt.getString(4);
				r_msg_cd 	= cstmt.getString(5);
				r_msg 		= cstmt.getString(6);
				
				if(!r_s_yn.equals("Y")){
					res.writeException("ERROR", r_msg_cd, r_msg);
				}
				
				if(ds_result!=null){
					GauceDataRow row1 = ds_result.newDataRow();
					row1.addColumnValue(r_s_yn);
					row1.addColumnValue(r_msg_cd);
					row1.addColumnValue(r_msg);
					
					ds_result.addDataRow(row1);
				}
				
				if(ds_result!=null) ds_result.flush();									
						  
			}*/
					
					
				

			gos.close();
		}catch (SQLException sqle){
			sqle.printStackTrace();
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			e.printStackTrace();
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}


}
