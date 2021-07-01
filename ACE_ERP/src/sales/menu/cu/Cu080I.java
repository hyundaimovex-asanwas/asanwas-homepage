package sales.menu.cu;


import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.CallableStatement;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;
//import sun.nio.cs.ext.SJIS;

import com.gauce.GauceContext;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.Logger;

public class Cu080I extends SuperServlet {

    public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		/*
		 * 메인조회
		 * //매출처 SID,한글성명,주민/여권번호, 교육일자, 방북목적코드, 사업소 SID, 방북증 승인번호, 방북교육신청번호   
		 */
		arr_sql[0].append("{call SALES.PR_CU080I_01( ?, ?, ?, ?, ?,   ?, ?, ? ) }");	 
		 
		arr_sql[1].append("{call SALES.PR_CU080I_02( ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?) }");
		
    }

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
	}	
	
	// 조회 method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		//StringUtil.printMsg("# Command : 조회","", this);

		/* DataBase */
		GauceDataSet ds1 = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;

		// 검색시 조건
		int	   sClientSid  	= HDUtil.nullCheckNum(req.getParameter("sClientSid"));	// 거래처 아이디
		String sCustNm    	= HDUtil.nullCheckStr(req.getParameter("sCustNm"));		// 고객명 
		String sManageNo 	= HDUtil.nullCheckStr(req.getParameter("sManageNo"));	// 주민/여권번호
		String sEducPlanDt	= HDUtil.nullCheckStr(req.getParameter("sEducPlanDt"));	// 교육일자
		String sVisitObjCd	= HDUtil.nullCheckStr(req.getParameter("sVisitObjCd"));// 방북목적코드
		int	   sSaupSid 	= HDUtil.nullCheckNum(req.getParameter("sSaupSid"));	// 사업소 SID
		String sEducNo    	= HDUtil.nullCheckStr(req.getParameter("sEducNo"));	// 방북증 승인번호
		String sEducReqNo   = HDUtil.nullCheckStr(req.getParameter("sEducReqNo"));		// 방북교육신청번호
		//String sNcardNo    	= HDUtil.nullCheckStr(req.getParameter("sNcardNo"));	// 검색조건: 방북증번호
		//String 	sNJobGu = HDUtil.nullCheckStr(req.getParameter("sNJobGu"));

		try {
/*			//StringUtil.printMsg("방북작업구분", sNJobGu, this);
			//StringUtil.printMsg("사업소SID", sNJobGu, this);
			//StringUtil.printMsg("교육예정일자", sNJobGu, this);
			//StringUtil.printMsg("성명", sNJobGu, this);
			//StringUtil.printMsg("관리번호", sNJobGu, this);*/
			
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));

			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				//StringUtil.printMsg("가우스명 - ", gauceName, this);
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if ("DEFAULT".equals(gauceName)) {
						//조회쿼리
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setInt   (1, sClientSid);		//IN 
						cstmt.setString(2, sCustNm);		//IN
						cstmt.setString(3, sManageNo);		//IN
						cstmt.setString(4, sEducPlanDt);		//IN
						cstmt.setString(5, sVisitObjCd);		//IN
						cstmt.setInt   (6, sSaupSid);		//IN 
						cstmt.setString(7, sEducNo);		//IN
						cstmt.setString(8, sEducReqNo);		//IN						
						
						rs = cstmt.executeQuery();
						
						//업뎃쿼리
						//cstmt = conn.prepareCall(arr_sql[1].toString());
						//cstmt.setString(1, s_manage_no);
						//cstmt.executeUpdate();						
					}
					getDataSet(rs, ds1).flush();

				}
			}
			

		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	/**
	 * 기능 :
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 *
	 */
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  
		throws ServletException, Exception {
		
		// TODO Auto-generated method stub
		CallableStatement 	cstmt 		= null;
		ResultSet 			rs 			= null;

		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		
		/* DataSet */
		GauceDataSet ds1		= req.getGauceDataSet("DS1");	
		GauceDataSet ds_result	= req.getGauceDataSet("RESULT");
		
		/*
		 * 변수선언
		 */
		int fVCnt = 0; //방북 신청 유무 확인용 카운트 변수 
		
		try{
			//내부 변수
			String v_edit_styatus = "";	//IN 편집상태     1: INSERT, 2: DELETE, 3: UPDATE
			String r_s_yn		= "";	//Return Status Yn
			String r_msg_cd		= "";	//Return Message Code
			String r_msg		= ""; 	//Return message
						
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				
				// DS 컬럼 정의
				int colNm_EDUC_CARD_SID	     = ds1.indexOfColumn("EDUC_CARD_SID");    // 01.교육 증 신청 sid 
				int colNm_CUST_SID		     = ds1.indexOfColumn("CUST_SID");         // 02.고객 sid         
				int colNm_EDUC_REQ_NO        = ds1.indexOfColumn("EDUC_REQ_NO");      // 03.방북교육신청번호 
				int colNm_N_EDUC_YN		     = ds1.indexOfColumn("N_EDUC_YN");        // 04.교육유무         
				int colNm_EDUC_NO		     = ds1.indexOfColumn("EDUC_NO");          // 05.신청승인번호     
				int colNm_N_CARD_YN		     = ds1.indexOfColumn("N_CARD_YN");        // 06.발급상태         
				int colNm_N_CARD_NO		     = ds1.indexOfColumn("N_CARD_NO");        // 07.증명서번호       
				int colNm_VISIT_OBJECT_CD    = ds1.indexOfColumn("VISIT_OBJECT_CD");  // 08.목적구분CU016    
				int colNm_VISIT_OBJECT	     = ds1.indexOfColumn("VISIT_OBJECT");     // 09.방북목적         
				int colNm_VISIT_FR_DT	     = ds1.indexOfColumn("VISIT_FR_DT");      // 10. 방문기간[시작일]
				int colNm_VISIT_TO_DT	     = ds1.indexOfColumn("VISIT_TO_DT");      // 11. 방문기간[종료일]
				int colNm_CREDIT_FR_DT	     = ds1.indexOfColumn("CREDIT_FR_DT");     // 12. 유효기간[시작일]
				int colNm_CREDIT_TO_DT	     = ds1.indexOfColumn("CREDIT_TO_DT");     // 13. 유효기간[종료일]
				
				for(int i = 0; i < rows.length; i++) {

					switch(rows[i].getJobType()){
				
						case GauceDataRow.TB_JOB_INSERT:
							break;
							
						case GauceDataRow.TB_JOB_UPDATE:
							/*
							 * [방북신청 정보 수정] 방북교육유무 코드가 9이면 
							 */

							cstmt = conn.prepareCall(arr_sql[1].toString()); //PR_CU080I_02
							cstmt.setInt        (1, rows[i].getInt(colNm_EDUC_CARD_SID));     // 01.교육 증 신청 sid 
							cstmt.setInt        (2, rows[i].getInt(colNm_CUST_SID));	        // 02.고객 sid         
							cstmt.setString     (3, rows[i].getString(colNm_EDUC_REQ_NO));// 03.방북교육신청번호 
							cstmt.setString     (4, rows[i].getString(colNm_N_EDUC_YN));// 04.교육유무         
							cstmt.setString     (5, rows[i].getString(colNm_EDUC_NO));// 05.신청승인번호     
							cstmt.setString     (6, rows[i].getString(colNm_N_CARD_YN));// 06.발급상태         
							cstmt.setString     (7, rows[i].getString(colNm_N_CARD_NO));// 07.증명서번호       
							cstmt.setString     (8, rows[i].getString(colNm_VISIT_OBJECT_CD));// 08.목적구분CU016    
							cstmt.setString     (9, rows[i].getString(colNm_VISIT_OBJECT));// 09.방북목적         
							cstmt.setString     (10,rows[i].getString(colNm_VISIT_FR_DT));// 10. 방문기간[시작일]
							cstmt.setString     (11,rows[i].getString(colNm_VISIT_TO_DT));// 11. 방문기간[종료일]
							cstmt.setString     (12,rows[i].getString(colNm_CREDIT_FR_DT));// 12. 유효기간[시작일]
							cstmt.setString     (13,rows[i].getString(colNm_CREDIT_TO_DT));// 13. 유효기간[종료일]
							cstmt.setString     (14, fParamEmpno);							//수정사번
							cstmt.setString     (15, fParamIp);								//수정ip
							cstmt.setString     (16, "3");						//편집상태
							cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);
		
							cstmt.executeUpdate();
		
							r_s_yn 		= cstmt.getString(17);
							r_msg_cd 	= cstmt.getString(18);
							r_msg 		= cstmt.getString(19);
							
							if(!r_s_yn.equals("Y")){
								throw new Exception (r_msg);
							}
						
							if(ds_result!=null){
								GauceDataRow row1 = ds_result.newDataRow();
								row1.addColumnValue(r_s_yn);
								row1.addColumnValue(r_msg_cd);
								row1.addColumnValue(r_msg);
							
								ds_result.addDataRow(row1);
							}

							
							break;
						case GauceDataRow.TB_JOB_DELETE:
							break;
					}
				
				}
			} 

		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			if(cstmt!=null) cstmt.close();
		}
	}

}
