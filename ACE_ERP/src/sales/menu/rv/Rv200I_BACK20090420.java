package sales.menu.rv;

import java.sql.*;
import java.util.*;

import javax.servlet.ServletException;
import java.math.BigDecimal;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.*;
import sales.common.HDUtil;
import sales.common.SuperServlet;

public class Rv200I_BACK20090420 extends SuperServlet {
   
	public void makeSql() {
		//신청서 번호 조회시....
		arr_sql[0].append ("SELECT R1.ACCEPT_SID,                                    /*  신청서 SID		 */	\n")
				  .append ("       R1.ACCEPT_NO,                                     /*  신청서 번호     */	\n")
				  .append ("       R1.DEPART_DATE,                                   /*  출발일자        */	\n")
				  .append ("       R2.DEPART_TIME,                                   /*  출발시간        */	\n")
				  .append ("       R2.NIGHTS,                                        /*  박수            */	\n")
				  .append ("       R1.GOODS_SID,                                     /*  상품SID         */	\n")
				  .append ("	   SALES.FN_GOODS_NM(R1.GOODS_SID, '') AS GOODS_NM,  /*  상품명		*/	\n")
				  .append ("       R2.ARRIVE_DATE,                                   /*  복귀일자        */	\n")
				  .append ("       R2.ARRIVE_TIME,                                   /*  복귀시간        */	\n")
				  .append ("       R1.SAUP_SID,                                      /*  사업소          */	\n")
				  .append ("       R1.CLIENT_SID,                                    /*  매출처/대리점   */	\n")
				  .append ("       SALES.FN_CLIENT_NM(CLIENT_SID, '') AS CLIENT_NM,  /*  매출처명        */	\n")
				  .append ("       R1.EVENT_SID,                                     /*  행사SID         */	\n")
				  .append ("       R3.EVENT_NO,                                      /*  행사번호        */	\n")
				  .append ("       R3.EVENT_NM                                       /*  행사명          */	\n")
				  .append ("  FROM SALES.TRV010 R1                                                       	\n")
				  .append ("  LEFT OUTER JOIN SALES.TRM220 R2  ON R2.GOODS_SID = R1.GOODS_SID            	\n")
				  .append ("   AND  R2.DEPART_DATE = R1.DEPART_DATE                                      	\n")
				  .append ("  LEFT OUTER JOIN SALES.TRV060 R3  ON R3.EVENT_SID = R1.EVENT_SID            	\n")
				  .append (" WHERE R1.ACCEPT_NO  =  ?													 	\n");
		
		//상품정보 조회시....
		arr_sql[1].append ("SELECT R1.GOODS_SID,     /* 상품SID     */		\n")
				  .append ("       R1.GOODS_NM,      /* 상품명      */      \n")
				  .append ("       R2.DEPART_DATE,   /* 출발일자    */      \n")
				  .append ("       R2.DEPART_TIME,   /* 출발시간    */      \n")
				  .append ("       R2.NIGHTS,        /* 박수        */      \n")
				  .append ("       R2.ARRIVE_DATE,   /* 복귀일자    */      \n")
				  .append ("       R2.ARRIVE_TIME    /* 복귀시간	*/      \n")
				  .append ("  FROM SALES.TRM200 R1 JOIN SALES.TRM220 R2     \n")
				  .append ("    ON R2.GOODS_SID = R1.GOODS_SID              \n")
				  .append (" WHERE R1.SAUP_SID     =  ?						\n")
				  .append ("   AND R2.DEPART_DATE  =  ?						\n")
				  .append (" ORDER BY R1.GOODS_NM, R2.DEPART_TIME			\n");

		//객실 타입 / 변경가능 객실
		arr_sql[2].append ("{call SALES.PR_RV200I_22(?, ?, ?, ?, ?, ?, ?, ?, ?) }");
		
		//투숙객 명단 조회
		arr_sql[3].append ("{call SALES.PR_RV200I_23(?, ?, ?, ?, ?)}");
		
		//옵션 요금내역 관리
		arr_sql[4].append ("SELECT R1.MENU_SID,                                                   /* 메뉴SID	*/	\n")
				  .append ("       R2.KEY_SEQ,                                                    /* 순번       */  \n")
				  .append ("       (CASE WHEN R2.SALE_QTY > 0 THEN 'T' ELSE 'F' END) AS USE_YN,   /* 선택       */  \n")
				  .append ("       (CASE WHEN R2.RSV_PAY_YN > 0 THEN 'T' ELSE 'F' END) AS RSV_PAY_YN, /* 예약시결제 */  \n")
				  .append ("       R1.MENU_NM,                                                    /* 항목       */  \n")
				  .append ("       COALESCE(R2.USE_AMT, R1.UNIT_AMT) AS USE_AMT,                  /* 금액       */  \n")
				  .append ("       R2.SALE_QTY,                                                   /* 판매수량   */  \n")
				  .append ("       R2.USE_AMT * R2.SALE_QTY          AS TOT_USE_AMT,              /* 합계       */  \n")
				  .append ("       R2.REMARKS                                                     /* 참고사항   */  \n")
				  .append ("  FROM SALES.TRV100 R1 LEFT OUTER JOIN SALES.TRV030 R2                                  \n")
				  .append ("    ON R2.MENU_SID    =  R1.MENU_SID AND R2.RSV_SID = ?			                        \n")
				  .append (" WHERE R1.BGN_DATE   <=  ?				                                                \n")
				  .append ("   AND R1.END_DATE   >=  ?				                                                \n")
				  .append ("   AND R1.OPTION_YN   =  'Y'                                                            \n");
				  //.append ("   AND R1.OPTION_VIEW_CD IN ('1', '2')													\n");

		//Block 정보: ds_block
		arr_sql[7].append ("{call SALES.PR_RV200I_21(?, ?, ?, ?, ?, ?, ?) }");
		
		//관광객 명단
		arr_sql[8].append ("{call SALES.PR_RV200I_20(?, ?) }");
		
		//관광객 추가시 사전체크
		arr_sql[9].append ("{call SALES.PR_DC_MAIN(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");
		
		//투숙객 정보 저장
		arr_sql[10].append ("{call SALES.PR_RV200I_01(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");
		
		//Option 요금 저장
		arr_sql[11].append ("{call SALES.PR_RV200I_02(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");
		
		//객실변경 저장
		arr_sql[12].append ("{call SALES.PR_RV200I_05(?, ?, ?, ?, ?, ?, ?, ?) }");
		
		//판매가 계산 저장
		arr_sql[13].append ("{call SALES.PR_RV200I_06(?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");

		//포캐스팅 정보 조회
		arr_sql[14].append ("{call SALES.PR_RV200I_24(?, ?, ?, ?, ?, ?) }");
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
	}

	/**
	 * 기본적인 조회 처리 담당
	 * 기타 분기할 수 있다면... 이곳에서 처리하여 넘겨준다.
	 */
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		GauceStatement stmt = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		try{
			int    v_business    = HDUtil.nullCheckNum(req.getParameter("v_business")); 	//사업소
			String v_accept_check= HDUtil.nullCheckStr(req.getParameter("v_accept_check")); //체크박스
			String v_accept_no   = HDUtil.nullCheckStr(req.getParameter("v_accept_no"));	//신청서번호
			String v_depart_date = HDUtil.nullCheckStr(req.getParameter("v_depart_date"));	//출발일자
			String v_depart_time = HDUtil.nullCheckStr(req.getParameter("v_depart_time"));	//출발시간
			String v_arrive_date = HDUtil.nullCheckStr(req.getParameter("v_arrive_date"));	//도착일자
			String v_arrive_time = HDUtil.nullCheckStr(req.getParameter("v_arrive_time"));	//도착시간
			String v_blockType   = HDUtil.nullCheckStr(req.getParameter("v_blockType")); 	//블록/일반 예약 정보
			
			String v_fr_date 	 = HDUtil.nullCheckStr(req.getParameter("v_fr_date"));	//도착일자
			String v_to_date 	 = HDUtil.nullCheckStr(req.getParameter("v_to_date"));	//도착일자

			int    v_accept_sid  = HDUtil.nullCheckNum(req.getParameter("v_accept_sid"));	//예약 SID
			int    v_client_sid  = HDUtil.nullCheckNum(req.getParameter("v_client_sid"));	//매출처코드
			int    v_goods_sid   = HDUtil.nullCheckNum(req.getParameter("v_goods_sid"));	//상품 SID
			int    v_roomType    = HDUtil.nullCheckNum(req.getParameter("v_roomType"));		//ROOMTYPE SID
			//StringUtil.printMsg("v_roomType sid 받아온 것?????==", v_roomType, this);
			int    v_room_sid    = HDUtil.nullCheckNum(req.getParameter("v_room_sid"));		//ROOM SID
			int    v_block_sid    = HDUtil.nullCheckNum(req.getParameter("v_block_sid"));	//BLOCK SID
			int    v_event_sid   = HDUtil.nullCheckNum(req.getParameter("v_event_sid"));	//단체행사SID
			int    v_nights      = HDUtil.nullCheckNum(req.getParameter("v_nights"));		//박수
			int    v_m_rsv_sid   = HDUtil.nullCheckNum(req.getParameter("v_m_rsv_sid"));	//예약 SID
			int    v_rsv_sid     = HDUtil.nullCheckNum(req.getParameter("v_rsv_sid"));		//예약 SID
			//StringUtil.printMsg("v_rsv_sid 받아온 것?????==", v_rsv_sid, this);

			//관리번호로 투숙객 명단 조회
			String v_manage_no   = HDUtil.nullCheckStr(req.getParameter("v_manage_no"));//고객 관리번호

			/* DataSet */
			GauceDataSet ds_search 		= req.getGauceDataSet("SEARCH");	//검색조건
			GauceDataSet ds_room   		= req.getGauceDataSet("ROOM");		//룸타입
			GauceDataSet ds_block  		= req.getGauceDataSet("BLOCK");		//블록/일반
			GauceDataSet ds_roomChange  = req.getGauceDataSet("ROOMCHANGE");//변경가능객실
			GauceDataSet ds_cust   		= req.getGauceDataSet("CUST");		//투숙객 명단
			GauceDataSet ds_tour   		= req.getGauceDataSet("TOUR");		//옵션 요금 내역
			GauceDataSet ds_forecasting = req.getGauceDataSet("FORECASTING");		//FORECASTING

			GauceDataSet ds_cust_temp   = req.getGauceDataSet("CUST_TEMP");	//사용자 조회
			GauceDataSet ds_cust_result = req.getGauceDataSet("CUST_RESULT");	//사용자 사전 결과

			Properties pt_cust_temp   = null;


			//기본 검색 내역
			if(ds_search!=null){
				res.enableFirstRow(ds_search);

				if(!v_accept_no.equals("")){
					if(v_client_sid!=0)
						arr_sql[0].append ("  AND R1.CLIENT_SID = ?			\n");
					stmt = conn.getGauceStatement(arr_sql[0].toString());
					stmt.setString(1, v_accept_no);
					if(v_client_sid!=0)
						stmt.setInt(2, v_client_sid);
				} else if(!v_depart_date.equals("")){
					stmt = conn.getGauceStatement(arr_sql[1].toString());
					stmt.setInt(1, v_business);
					stmt.setString(2, v_depart_date);
				}
				rs = stmt.executeQuery();
				
				getDataSet(rs, ds_search).flush();
				
				if(rs!=null) rs.close();
				if(stmt!=null) stmt.close();
			}
			
			//룸타입
			if(ds_room!=null){
				res.enableFirstRow(ds_room);
				cstmt = conn.prepareCall(arr_sql[2].toString());
				cstmt.setString(1, v_blockType);
				cstmt.setString(2, "N");
				cstmt.setInt   (3, v_client_sid);
				cstmt.setString(4, v_depart_date);
				cstmt.setInt   (5, v_goods_sid);
				cstmt.setInt   (6, 0);
				cstmt.setInt   (7, v_accept_sid);
				cstmt.setInt   (8, v_nights);
				cstmt.setInt   (9, v_business);
				
				rs = cstmt.executeQuery();

				getDataSet(rs, ds_room).flush();
				if(rs!=null) rs.close();
				if(cstmt!=null) cstmt.close();
			}
			
			//block info
			if(ds_block!=null){
				res.enableFirstRow(ds_block);
				cstmt = conn.prepareCall(arr_sql[7].toString());
				cstmt.setString(1, v_blockType);
				cstmt.setInt   (2, v_client_sid);
				cstmt.setString(3, v_depart_date);
				cstmt.setInt   (4, v_goods_sid);
				cstmt.setInt   (5, v_roomType);
				cstmt.setInt   (6, v_accept_sid);
				cstmt.setInt   (7, v_nights);
				
				
				//StringUtil.printMsg("블럭타입 - ", v_blockType, this);
				//StringUtil.printMsg("대리점SID - ", v_client_sid, this);
				//StringUtil.printMsg("출발일 - ", v_depart_date, this);
				//StringUtil.printMsg("상품SID - ", v_goods_sid, this);
				//StringUtil.printMsg("객실타입 - ", v_roomType, this);
				//StringUtil.printMsg("신청서SID - ", v_accept_sid, this);
				//StringUtil.printMsg("박수  - ", v_nights, this);
								
				
				
				rs = cstmt.executeQuery();
				getDataSet(rs, ds_block).flush();
				
				if(rs!=null) rs.close();
				if(cstmt!=null) cstmt.close();
			}
			
			//변경가능객실
			if(ds_roomChange!=null){
				res.enableFirstRow(ds_roomChange);

				cstmt = conn.prepareCall(arr_sql[2].toString());
				cstmt.setString(1, v_blockType);
				cstmt.setString(2, "Y");
				cstmt.setInt   (3, v_client_sid);
				cstmt.setString(4, v_depart_date);
				cstmt.setInt   (5, v_goods_sid);
				cstmt.setInt   (6, v_roomType);
				cstmt.setInt   (7, v_accept_sid);
				cstmt.setInt   (8, v_nights);
				cstmt.setInt   (9, v_business);
				
				rs = cstmt.executeQuery();
				getDataSet(rs, ds_roomChange).flush();
				
				if(rs!=null) rs.close();
				if(cstmt!=null) cstmt.close();
			}
			
			//투숙객 명단

		
			//StringUtil.printMsg("투숙객조회-출발일자.", v_depart_date, this);
			//StringUtil.printMsg("투숙객조회-상품.", v_goods_sid, this);
			//StringUtil.printMsg("투숙객조회-주민.", v_manage_no, this);
			
			if(ds_cust!=null){
				//StringUtil.printMsg("ds_cust일까요???", "", this);
				res.enableFirstRow(ds_cust);
				cstmt = conn.prepareCall(arr_sql[3].toString()); //ds_cust에서도 이걸 조회한다.SALES.PR_RV200I_23
				if(v_rsv_sid==0){
					if(!v_manage_no.equals("")){
						//StringUtil.printMsg("1번조회", v_goods_sid, this);
						cstmt.setInt(1, 0);
						cstmt.setInt(2, 0);
						cstmt.setString(3, v_manage_no);
						cstmt.setString(4, v_depart_date);
						cstmt.setInt   (5, v_goods_sid);
					} else {
						//StringUtil.printMsg("2번조회", v_m_rsv_sid, this);
						cstmt.setInt(1, 0);
						cstmt.setInt(2, v_m_rsv_sid);
						cstmt.setString(3, "");
						cstmt.setString(4, v_depart_date);
						cstmt.setInt   (5, v_goods_sid);
						
					}
				} else {
					//StringUtil.printMsg("3번조회", v_goods_sid, this);
					cstmt.setInt(1, v_rsv_sid);
					cstmt.setInt(2, 0);
					cstmt.setString(3, v_manage_no);
					cstmt.setString(4, v_depart_date);
					cstmt.setInt   (5, v_goods_sid);
				}
				
				rs = cstmt.executeQuery();
				pt_cust_temp = getDataSet1(rs, ds_cust);
							
				
				if(rs!=null) rs.close();
				if(cstmt!=null) cstmt.close();

				if(pt_cust_temp!=null){
					cstmt = conn.prepareCall(arr_sql[9].toString());	//pr_dc_main. 그리고 여기..
					cstmt.setString (1, "G15");				//신청창구번호: 좌측 방그리드 클릭할 때, 사람 있으면
					StringUtil.printMsg("304라인 pACCEPT_SEQ", "G15", this);	// 여긴 오류 아니네..
					cstmt.setInt	(2, v_accept_sid);		//신청서SID
					//StringUtil.printMsg("v_accept_sid==", v_accept_sid, this);
					cstmt.setString (3, v_depart_date);		//출발일자
					//StringUtil.printMsg("v_depart_date==", v_depart_date, this);
					cstmt.setInt	(4, v_goods_sid);		//상품SID
					//StringUtil.printMsg("v_goods_sid==", v_goods_sid, this);
					cstmt.setInt	(5, v_client_sid);		//매출처SID
					//StringUtil.printMsg("v_client_sid==", v_client_sid, this);
					cstmt.setInt	(6, v_event_sid);		//단체행사SID
					//StringUtil.printMsg("v_event_sid==", v_accept_sid, this);
					cstmt.setString (7, "1");				//작업구분[RM013] 관광예약/방북신청
					cstmt.setInt	(8, v_rsv_sid);			//예약SID
					//StringUtil.printMsg("v_rsv_sid==", v_rsv_sid, this);//0으로 던져진다.
					cstmt.setInt	(9, v_m_rsv_sid);		//메인예약SID
					//StringUtil.printMsg("v_m_rsv_sid==", v_m_rsv_sid, this);
					cstmt.setInt	(10, v_roomType);		//객실SID
					//StringUtil.printMsg("여기일까 ds_cust", v_roomType, this);//여기서 오류 발생.
					cstmt.setInt	(11, v_room_sid);		//룸SID
					//StringUtil.printMsg("v_room_sid==", v_room_sid, this);
					cstmt.setInt	(12, v_block_sid);		//블록SID
					//StringUtil.printMsg("v_block_sid==", v_block_sid, this);
					cstmt.setString (13, v_blockType);		//예약타입 -- 블록/일반
					//StringUtil.printMsg("v_blockType==", v_blockType, this);
					cstmt.setString (14, v_depart_time);	//출발시간
					//StringUtil.printMsg("v_depart_time==", v_depart_time, this);
					cstmt.setInt	(15, v_nights);			//박수
					//StringUtil.printMsg("v_nights==", v_nights, this);
					cstmt.setString (16, v_arrive_date);	//복귀일자
					//StringUtil.printMsg("v_arrive_date==", v_arrive_date, this);
					cstmt.setString (17, v_arrive_time);	//복귀시간
					//StringUtil.printMsg("v_arrive_time==", v_arrive_time, this);

					cstmt.setInt	(18, Integer.parseInt(pt_cust_temp.getProperty("CUST_SID")));//고객SID
					//StringUtil.printMsg("CUST_SID==", Integer.parseInt(pt_cust_temp.getProperty("CUST_SID")), this);
					cstmt.registerOutParameter(18, java.sql.Types.DECIMAL);	//고객SID
					cstmt.setString (19, pt_cust_temp.getProperty("MANAGE_NO"));	//고객관리번호
					StringUtil.printMsg("MANAGE_NO==", pt_cust_temp.getProperty("MANAGE_NO"), this);
					cstmt.setString (20, pt_cust_temp.getProperty("CUST_GU"));	//고객유형
					//StringUtil.printMsg("CUST_GU==", pt_cust_temp.getProperty("CUST_GU"), this);
					cstmt.setString (21, pt_cust_temp.getProperty("SAUP_GU"));	//사업구분
					//StringUtil.printMsg("SAUP_GU==", pt_cust_temp.getProperty("SAUP_GU"), this);
					cstmt.setString (22, pt_cust_temp.getProperty("CUST_TYPE"));	//고객구분
					//StringUtil.printMsg("CUST_TYPE==", pt_cust_temp.getProperty("CUST_TYPE"), this);
					cstmt.setString (23, pt_cust_temp.getProperty("AGE_CD"));	//연령구분
					//StringUtil.printMsg("AGE_CD==", pt_cust_temp.getProperty("AGE_CD"), this);
					cstmt.setString (24, pt_cust_temp.getProperty("JOIN_CD"));	//동숙코드[RV006] 본인/배우자/...
					//StringUtil.printMsg("JOIN_CD==", pt_cust_temp.getProperty("JOIN_CD"), this);
					cstmt.setString (25, "1");								//예약신청방법[RV020] CS/WEB/...
					cstmt.setString (26, fParamEmpno);							//최종수정자사번
					cstmt.registerOutParameter(27, java.sql.Types.DECIMAL);	//관광요금
					cstmt.registerOutParameter(28, java.sql.Types.DECIMAL);	//옵션요금
					cstmt.registerOutParameter(29, java.sql.Types.VARCHAR);	//성공여부 : 이게 제대로 안넘어온 듯한..
					cstmt.registerOutParameter(30, java.sql.Types.VARCHAR);	//메세지 코드
					cstmt.registerOutParameter(31, java.sql.Types.VARCHAR);	//메세지
					
					cstmt.executeUpdate();
					//StringUtil.printMsg("라인 : 355 ==================", cstmt.getString(29)+ "[]", this);
					
					if(cstmt.getString(29).equals("N")){	//-- 여기 같음..
						throw new Exception(cstmt.getString(31));
					}

					
					if(ds_cust_result!=null){
						res.enableFirstRow(ds_cust_result);
						ds_cust_result.addDataColumn(new GauceDataColumn("CUST_SID", GauceDataColumn.TB_NUMBER));
						ds_cust_result.addDataColumn(new GauceDataColumn("TOUR_AMT", GauceDataColumn.TB_NUMBER));
						ds_cust_result.addDataColumn(new GauceDataColumn("OPTION_AMT", GauceDataColumn.TB_NUMBER));
						ds_cust_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
						ds_cust_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
						ds_cust_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
						
						GauceDataRow row = ds_cust_result.newDataRow();
						
						row.addColumnValue(cstmt.getBigDecimal(18).intValue());
						row.addColumnValue(cstmt.getBigDecimal(27).intValue());
						row.addColumnValue(cstmt.getBigDecimal(28).intValue());
						row.addColumnValue(cstmt.getString(29));
						row.addColumnValue(cstmt.getString(30));
						row.addColumnValue(cstmt.getString(31));
						
						ds_cust_result.addDataRow(row);
						ds_cust_result.flush();
					}

					if(cstmt!=null) cstmt.close();
				}
				
				//StringUtil.printMsg("ds_cust 구간 끝-------------------------", "", this);
			}
			
			//ForeCasting 정보 조회
			if(ds_forecasting!=null){
				res.enableFirstRow(ds_forecasting);
				cstmt = conn.prepareCall(arr_sql[14].toString());
				
				cstmt.setString(1, v_blockType);
				//StringUtil.printMsg("여기일까 ds_forecasting", v_blockType, this);//여기서 오류 발생.
				cstmt.setInt(2, v_client_sid);
				cstmt.setInt(3, v_goods_sid);
				cstmt.setInt(4, v_nights);
				cstmt.setString(5, v_fr_date);
				cstmt.setString(6, v_to_date);
				
				rs = cstmt.executeQuery();
				getDataSet(rs, ds_forecasting).flush();
				
				if(rs!=null) rs.close();
				if(cstmt!=null) cstmt.close();
			}
			
			//관광객 명단 info
			if(ds_tour!=null){
				res.enableFirstRow(ds_tour);
				cstmt = conn.prepareCall(arr_sql[8].toString());
				cstmt.setInt   (1, v_accept_sid);
				cstmt.setString(2, v_accept_check);
				rs = cstmt.executeQuery();
				getDataSet(rs, ds_tour).flush();

				if(rs!=null) rs.close();
				if(cstmt!=null) cstmt.close();
			}
			
			if(ds_cust_temp!=null){
				//StringUtil.printMsg("ds_cust_temp일까요???", "", this);
				res.enableFirstRow(ds_cust_temp);

				cstmt = conn.prepareCall(arr_sql[3].toString()); //고객정보를 조회해와서 PR_RV200I_23(?, ?, ?, ?, ?)
				cstmt.setInt(1, 0);
				cstmt.setInt(2, 0);
				cstmt.setString(3, v_manage_no);
				cstmt.setString(4, v_depart_date);	//추가 - 할인상세 펑션을 위한 파라미터.
				cstmt.setInt   (5, v_goods_sid);	//추가 
				
				//StringUtil.printMsg("ds_cust_temp ::::::::::::", arr_sql[3].toString(), this);				
				//StringUtil.printMsg("arr_sql[3] v_manage_no", v_manage_no, this);
				rs = cstmt.executeQuery();
				pt_cust_temp = getDataSet1(rs, ds_cust_temp);
				
				if(rs!=null) rs.close();
				if(cstmt!=null) cstmt.close();

				if(pt_cust_temp!=null){
					cstmt = conn.prepareCall(arr_sql[9].toString());	//사전체크작업을 한다(PR_DC_MAIN)
					//StringUtil.printMsg("449라인 arr_sql[9] ::::::::::::", arr_sql[9].toString(), this);
					cstmt.setString (1, "G14");				//신청창구번호: 투숙객 추가버튼 클릭할 때. 이때만 중복체크
					StringUtil.printMsg("451라인 pACCEPT_SEQ", "G14", this);	// 여긴 오류 아니네..
					cstmt.setInt	(2, v_accept_sid);		//신청서SID
					cstmt.setString (3, v_depart_date);		//출발일자
					//StringUtil.printMsg("ds_cust_temp:3", v_depart_date, this);	// 여긴 오류 아니네..
					cstmt.setInt	(4, v_goods_sid);		//상품SID
					cstmt.setInt	(5, v_client_sid);		//매출처SID
					cstmt.setInt	(6, v_event_sid);		//단체행사SID
					cstmt.setString (7, "1");				//작업구분[RM013] 관광예약/방북신청
					cstmt.setInt	(8, v_rsv_sid);			//예약SID
					//StringUtil.printMsg("ds_cust_temp:8", v_rsv_sid, this);	// 여긴 오류 아니네..
					cstmt.setInt	(9, v_m_rsv_sid);		//메인예약SID
					cstmt.setInt	(10, v_roomType);		//객실SID
					//StringUtil.printMsg("여기일까 ds_cust_temp", v_roomType, this);	// 여긴 오류 아니네..
					cstmt.setInt	(11, v_room_sid);		//룸SID
					cstmt.setInt	(12, v_block_sid);		//블록SID
					cstmt.setString (13, v_blockType);		//예약타입 -- 블록/일반
					cstmt.setString (14, v_depart_time);	//출발시간
					cstmt.setInt	(15, v_nights);			//박수
					cstmt.setString (16, v_arrive_date);	//복귀일자
					//StringUtil.printMsg("ds_cust_temp:16", v_arrive_date, this);	// 여긴 오류 아니네..
					cstmt.setString (17, v_arrive_time);	//복귀시간

					cstmt.setInt	(18, Integer.parseInt(pt_cust_temp.getProperty("CUST_SID")));//고객SID
					cstmt.registerOutParameter(18, java.sql.Types.DECIMAL);	//고객SID
					//StringUtil.printMsg("ds_cust_temp:18", pt_cust_temp.getProperty("CUST_SID"), this);	//
					cstmt.setString (19, pt_cust_temp.getProperty("MANAGE_NO"));	//고객관리번호
					StringUtil.printMsg("ds_cust_temp:19", pt_cust_temp.getProperty("MANAGE_NO"), this);	//
					cstmt.setString (20, pt_cust_temp.getProperty("CUST_GU"));	//고객유형
					cstmt.setString (21, pt_cust_temp.getProperty("SAUP_GU"));	//사업구분
					cstmt.setString (22, pt_cust_temp.getProperty("CUST_TYPE"));	//고객구분
					cstmt.setString (23, pt_cust_temp.getProperty("AGE_CD"));	//연령구분
					cstmt.setString (24, pt_cust_temp.getProperty("JOIN_CD"));	//동숙코드[RV006] 본인/배우자/...
					cstmt.setString (25, "1");								//예약신청방법[RV020] CS/WEB/...
					cstmt.setString (26, fParamEmpno);							//최종수정자사번
					cstmt.registerOutParameter(27, java.sql.Types.DECIMAL);	//관광요금
					cstmt.registerOutParameter(28, java.sql.Types.DECIMAL);	//옵션요금
					cstmt.registerOutParameter(29, java.sql.Types.VARCHAR);	//성공여부
					cstmt.registerOutParameter(30, java.sql.Types.VARCHAR);	//메세지 코드
					cstmt.registerOutParameter(31, java.sql.Types.VARCHAR);	//메세지
					
					cstmt.executeUpdate();
					
					//StringUtil.printMsg("실명확인체크 결과메세지?",cstmt.getString(29), this);
					//StringUtil.printMsg("실명확인체크 결과메세지?",cstmt.getString(31), this);
					if(cstmt.getString(29).equals("N"))
						throw new Exception(cstmt.getString(31));
					
					if(ds_cust_result!=null){
						res.enableFirstRow(ds_cust_result);
						ds_cust_result.addDataColumn(new GauceDataColumn("CUST_SID", GauceDataColumn.TB_NUMBER));
						ds_cust_result.addDataColumn(new GauceDataColumn("TOUR_AMT", GauceDataColumn.TB_NUMBER));
						ds_cust_result.addDataColumn(new GauceDataColumn("OPTION_AMT", GauceDataColumn.TB_NUMBER));
						ds_cust_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
						ds_cust_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
						ds_cust_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
						
						GauceDataRow row = ds_cust_result.newDataRow();
						
						row.addColumnValue(cstmt.getBigDecimal(18).intValue());
						row.addColumnValue(cstmt.getBigDecimal(27).intValue());
						row.addColumnValue(cstmt.getBigDecimal(28).intValue());
						row.addColumnValue(cstmt.getString(29));
						row.addColumnValue(cstmt.getString(30));
						row.addColumnValue(cstmt.getString(31));
						
						ds_cust_result.addDataRow(row);
						ds_cust_result.flush();
					}

					if(cstmt!=null) cstmt.close();
				}
			}
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
			if(cstmt!=null) cstmt.close();
		}
	}
	
	/**
	 * CUD 작업 처리...
	 */
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res) throws ServletException, Exception {
		
		CallableStatement cstmt = null;
		
		try{
			String v_accept_no   = HDUtil.nullCheckStr(req.getParameter("v_accept_no"));	//신청서번호
			String v_depart_date = HDUtil.nullCheckStr(req.getParameter("v_depart_date"));	//출발일자
			String v_depart_time = HDUtil.nullCheckStr(req.getParameter("v_depart_time"));	//출발시간
			String v_arrive_date = HDUtil.nullCheckStr(req.getParameter("v_arrive_date"));	//도착일자
			String v_arrive_time = HDUtil.nullCheckStr(req.getParameter("v_arrive_time"));	//도착시간
			String v_blockType   = HDUtil.nullCheckStr(req.getParameter("v_blockType")); 	//블록/일반 예약 정보
			int    v_accept_sid  = HDUtil.nullCheckNum(req.getParameter("v_accept_sid"));	//예약 SID
			int    v_client_sid  = HDUtil.nullCheckNum(req.getParameter("v_client_sid"));	//매출처코드
			int    v_goods_sid   = HDUtil.nullCheckNum(req.getParameter("v_goods_sid"));	//상품 SID
			int    v_roomType    = HDUtil.nullCheckNum(req.getParameter("v_roomType"));		//ROOMTYPE SID
			int    v_room_sid    = HDUtil.nullCheckNum(req.getParameter("v_room_sid"));		//ROOM SID
			int    v_block_sid   = HDUtil.nullCheckNum(req.getParameter("v_block_sid"));	//BLOCK SID
			int    v_event_sid   = HDUtil.nullCheckNum(req.getParameter("v_event_sid"));	//단체행사SID
			int    v_nights      = HDUtil.nullCheckNum(req.getParameter("v_nights"));		//박수
			int    v_m_rsv_sid   = HDUtil.nullCheckNum(req.getParameter("v_m_rsv_sid"));	//예약 SID
			int    v_rsv_sid     = HDUtil.nullCheckNum(req.getParameter("v_rsv_sid"));		//예약 SID
			
			//ds_cust 에서 받을 변수 선언
			String r_manage_no 	= "";										//투숙객 주민번호
			int    r_rsv_sid 	= 0;										//투숙객 예약 번호
			int    r_cust_sid 	= 0;										//투숙 고객 일련 번호
			String r_saup_gu	= "";										//사업구분
			String r_cust_type	= "";										//할인유형
			String r_age_cd		= "";										//연령
			String r_join_cd	= "";										//동숙코드[RV006] 본인/배우자/...
			String r_mobile_no	= "";										//휴대전화번호
			String r_remark		= "";										//비고
				//할인상세용 4개 추가.
			String r_carowner_yn= "";										//자차여부
			String r_jeju_yn	= "";										//제주여부
			String r_weekend_yn	= "";										//주말여부
			String r_theme_cd	= "";										//테마여부
			
			
			int    r_key_seq 	= 0;										//옵션 순서

			//내부 변수
			String v_edit_styatus = "";										//IN 편집상태     1: INSERT, 2: DELETE, 3: UPDATE
			String v_send_id 	= "";
			String r_s_yn		= "";
			String r_msg_cd		= "";
			String r_msg		= "";
			
			//ds_option 
			GauceDataSet ds_cust 			= req.getGauceDataSet("REG_CUST");		//투숙객 정보
			GauceDataSet ds_option 			= req.getGauceDataSet("REG_OPTION");	//옵션 정보
			GauceDataSet ds_amt		 		= req.getGauceDataSet("REG_AMT");		//룸 정보 변경
			
			GauceDataSet ds_result 			= req.getGauceDataSet("SAVE_RESULT");	//투숙객 정보 저장 결과
			GauceDataSet ds_option_result 	= req.getGauceDataSet("OPTION_RESULT");	//옵션 정보 저장 결과
			GauceDataSet ds_amt_result 		= req.getGauceDataSet("AMT_RESULT");	//판매가 계산 결과
			GauceDataSet ds_room_result 	= req.getGauceDataSet("ROOM_RESULT");	//룸정보 변경 결과
			
			int v_row = 1;
			
			if(ds_cust!=null){
				if(ds_result!=null){
					res.enableFirstRow(ds_result);
					ds_result.addDataColumn(new GauceDataColumn("MANAGE_NO", GauceDataColumn.TB_STRING));
					ds_result.addDataColumn(new GauceDataColumn("ACCEPT_SID", GauceDataColumn.TB_NUMBER));
					ds_result.addDataColumn(new GauceDataColumn("ACCEPT_NO", GauceDataColumn.TB_STRING));
					ds_result.addDataColumn(new GauceDataColumn("RSV_SID", GauceDataColumn.TB_NUMBER));
					ds_result.addDataColumn(new GauceDataColumn("M_RSV_SID", GauceDataColumn.TB_NUMBER));
					ds_result.addDataColumn(new GauceDataColumn("ROOM_SID", GauceDataColumn.TB_NUMBER));
					ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
					ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
					ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
				}
				
				GauceDataRow[] row = ds_cust.getDataRows();

				for(int i=0; i<row.length; i++){
					if(row[i].getJobType()==GauceDataRow.TB_JOB_INSERT){
						v_edit_styatus = "1";
						v_send_id = "G11";
					} else if(row[i].getJobType()==GauceDataRow.TB_JOB_DELETE) {
						v_edit_styatus = "2";
						v_send_id = "G13";
					} if(row[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
						v_edit_styatus = "3";
						v_send_id = "G12";
					}

					//여기서의 배열 순번은 PR_RV200I_23 에서 select 하는 ds_cust의 컬럼순서다. by 심동 2007-05-14
					r_rsv_sid 		= row[i].getInt(0);							//투숙객 예약 번호
					r_cust_sid 		= row[i].getInt(3);							//투숙 고객 일련 번호
					r_manage_no		= row[i].getString(4);						//투숙객 주민번호
					r_saup_gu		= row[i].getString(9);						//사업구분
					r_cust_type		= row[i].getString(7);						//할인유형
					r_age_cd		= row[i].getString(6);						//연령
					r_join_cd		= row[i].getString(10);						//동숙코드[RV006] 본인/배우자/...
					r_mobile_no		= row[i].getString(13);						//휴대전화번호
					r_remark		= row[i].getString(14);						//비고
					//할인상세용 4개 추가.
					r_carowner_yn	= row[i].getString(28);						//자차여부
					r_jeju_yn		= row[i].getString(29);						//제주여부
					r_weekend_yn	= row[i].getString(30);						//주말여부
					r_theme_cd		= row[i].getString(31);						//테마여부

					
					if(v_edit_styatus.equals("1")){
						if(r_rsv_sid!=0) v_edit_styatus = "3";
					}
//StringUtil.printMsg("arr_sql[10].toString()", arr_sql[10].toString(), this);	// call SALES.PR_RV200I_01()

				    v_row = 1;
				    cstmt = conn.prepareCall(arr_sql[10].toString());
					cstmt.setInt	(v_row, v_accept_sid);						//신청서SID
					cstmt.registerOutParameter(v_row++, java.sql.Types.DECIMAL);
					cstmt.setString (v_row, v_accept_no);						//신청서NO
					cstmt.registerOutParameter(v_row++, java.sql.Types.DECIMAL);
					cstmt.setString (v_row++, v_depart_date);						//출발일자
					cstmt.setInt	(v_row++, v_goods_sid);						//상품SID
		//StringUtil.printMsg("상품sid", v_goods_sid, this);
					cstmt.setInt	(v_row++, v_client_sid);						//매출처SID
		//StringUtil.printMsg("매출처sid", v_client_sid, this);					
					cstmt.setInt	(v_row++, v_event_sid);						//단체행사SID
		//StringUtil.printMsg("이벤트 sid", v_event_sid, this);					
					cstmt.setString (v_row++, "1");								//작업구분[RM013] 관광예약/방북신청
		//StringUtil.printMsg("작업구분", "1", this);
					cstmt.setInt	(v_row, r_rsv_sid);							//예약SID
		//StringUtil.printMsg("예약sid ", r_rsv_sid, this);					
					cstmt.registerOutParameter(v_row++, java.sql.Types.DECIMAL);	//예약SID
					cstmt.setInt	(v_row, v_m_rsv_sid);						//메인예약SID
		//StringUtil.printMsg("메인예약id ", v_m_rsv_sid, this);					
					cstmt.registerOutParameter(v_row++, java.sql.Types.DECIMAL);	//메인예약SID
					cstmt.setInt	(v_row++, v_roomType);						//객실SID
		//StringUtil.printMsg("객실타입 sid", v_roomType, this);					
					cstmt.setInt	(v_row, v_room_sid);						//룸SID
		//StringUtil.printMsg("룸 sid ", v_room_sid, this);					
					cstmt.registerOutParameter(v_row++, java.sql.Types.DECIMAL);	//룸SID
					cstmt.setInt	(v_row++, v_block_sid);						//블록SID
		//StringUtil.printMsg("블록 sid ", v_block_sid, this);					
					cstmt.setString (v_row++, v_blockType);						//예약타입 -- 블록/일반
		//StringUtil.printMsg("예약타입 ", v_blockType, this);					
					cstmt.setString (v_row++, v_depart_time);					//출발시간
					cstmt.setInt	(v_row++, v_nights);							//박수
		//StringUtil.printMsg("박수 ", v_nights, this);					
					cstmt.setString (v_row++, v_arrive_date);					//복귀일자
		//StringUtil.printMsg("복귀일자 ", v_arrive_date, this);					
					cstmt.setString (v_row++, v_arrive_time);					//복귀시간
					cstmt.setInt	(v_row++, r_cust_sid);						//고객SID
					cstmt.setString (v_row++, "1");								//고객구분[CU001] 관광객/사업자       Defaul '1'
					cstmt.setString (v_row++, r_saup_gu);						//사업구분
					cstmt.setString (v_row++, r_cust_type);						//할인유형
					cstmt.setString (v_row++, r_age_cd);							//연령
					cstmt.setString (v_row++, r_join_cd);						//동숙코드[RV006] 본인/배우자/...
		//StringUtil.printMsg("동숙구분 ", r_join_cd, this);					
					cstmt.setString (v_row++, r_mobile_no);						//휴대전화번호
//StringUtil.printMsg("유치자", row[i].getString(ds_cust.indexOfColumn("HOLD_EMPNO")), this);
					cstmt.setString(v_row++, row[i].getString(ds_cust.indexOfColumn("HOLD_EMPNO")));
					cstmt.setString (v_row++, "1");								//예약신청방법[RV020] CS/WEB/...
		//StringUtil.printMsg("예약방법 ", "1", this);					
					cstmt.setString (v_row++, r_remark);							//비고
					cstmt.setString (v_row++, fParamEmpno);							//최종수정자사번
					cstmt.setString (v_row++, fParamIp);							//29 최종수정IP
					/*---할인상세 파라미터 추가 2007-0514 by 심동현--------------------------------*/
		//StringUtil.printMsg("자차여부 ", r_carowner_yn, this);
					cstmt.setString (v_row++, r_carowner_yn);						//30 자차여부
							
					cstmt.setString (v_row++, r_jeju_yn);							//31 제주여부
		//StringUtil.printMsg("제주여부 ", r_jeju_yn, this);
					cstmt.setString (v_row++, r_weekend_yn);						//32 주말여부
		//StringUtil.printMsg("주말여부 ", r_weekend_yn, this);
					cstmt.setString (v_row++, r_theme_cd);							//33 테마여부[RM018] 외금/내금/골프
		//StringUtil.printMsg("테마여부 ", r_theme_cd, this);
		 			/*---할인상세 파라미터 추가 2007-0514 by 심동현--------------------------------*/
					cstmt.setString (v_row++, v_edit_styatus);						//34 편집상태     1: INSERT, 2: DELETE, 3: UPDATE
		//StringUtil.printMsg("편집상태  ", v_edit_styatus, this);								
					cstmt.setString (v_row++, v_send_id);							//35 프로시저 호출 ID (41, 42, 43)
					cstmt.registerOutParameter(v_row++, java.sql.Types.VARCHAR);	//36 성공여부
					cstmt.registerOutParameter(v_row++, java.sql.Types.VARCHAR);	//37 메세지 코드
					cstmt.registerOutParameter(v_row++, java.sql.Types.VARCHAR);	//38 메세지

					cstmt.executeUpdate();
					
					v_accept_sid = cstmt.getBigDecimal(1).intValue();
					v_accept_no	 = cstmt.getString(2);
					r_rsv_sid	 = cstmt.getBigDecimal(8).intValue();
					v_m_rsv_sid	 = cstmt.getBigDecimal(9).intValue();
					v_room_sid	 = cstmt.getBigDecimal(11).intValue();
					r_s_yn		 = cstmt.getString(36);
					r_msg_cd	 = cstmt.getString(37);
					r_msg		 = cstmt.getString(38);					
					
					if(!r_s_yn.equals("Y"))
						throw new Exception (r_msg);
					
					if(ds_result!=null){
						GauceDataRow row1 = ds_result.newDataRow();
						row1.addColumnValue(r_manage_no);
						row1.addColumnValue(v_accept_sid);
						row1.addColumnValue(v_accept_no);
						row1.addColumnValue(r_rsv_sid);
						row1.addColumnValue(v_m_rsv_sid);
						row1.addColumnValue(v_room_sid);
						row1.addColumnValue(r_s_yn);
						row1.addColumnValue(r_msg_cd);
						row1.addColumnValue(r_msg);
						
						ds_result.addDataRow(row1);
					}
					if(cstmt!=null) cstmt.close();
				}
				
				if(ds_result!=null) ds_result.flush();
			}
			
			if(ds_option!=null){
				if(ds_option_result!=null){
					res.enableFirstRow(ds_option_result);
					ds_option_result.addDataColumn(new GauceDataColumn("KEY_SEQ", GauceDataColumn.TB_NUMBER));
					ds_option_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
					ds_option_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
					ds_option_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
				}
				
				GauceDataRow[] row = ds_option.getDataRows();
				
				for(int i=0; i<row.length; i++){
					r_key_seq = row[i].getInt(0);
					
					cstmt = conn.prepareCall(arr_sql[11].toString());
					cstmt.setInt        (1, v_rsv_sid);
					if(r_key_seq==0)
						cstmt.setInt	    (2, row[i].getInt(0));
					else
						cstmt.setInt	    (2, r_key_seq);
					cstmt.setString     (3, v_depart_date);
					cstmt.setInt		(4, row[i].getInt(1));
					cstmt.registerOutParameter(4, java.sql.Types.DECIMAL);
					cstmt.setString     (5, row[i].getString(2).equals("T") ? "Y" : "N");
					cstmt.setString     (6, row[i].getString(3).equals("T") ? "Y" : "N");
					cstmt.setInt		(7, row[i].getInt(5));
					cstmt.setInt		(8, row[i].getInt(6));
					cstmt.setString		(9, row[i].getString(8));
					
					cstmt.setString     (10, fParamEmpno);
					cstmt.setString     (11, fParamIp);
					cstmt.setString     (12, "3");
					cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);

					cstmt.executeUpdate();
					
					r_key_seq 	= cstmt.getBigDecimal(4).intValue();

					r_s_yn 		= cstmt.getString(13);
					r_msg_cd 	= cstmt.getString(14);
					r_msg 		= cstmt.getString(15);

					if(!r_s_yn.equals("Y"))
						throw new Exception (r_msg);
					
					if(ds_option_result!=null){
						GauceDataRow row1 = ds_option_result.newDataRow();
						row1.addColumnValue(r_key_seq);
						row1.addColumnValue(r_s_yn);
						row1.addColumnValue(r_msg_cd);
						row1.addColumnValue(r_msg);
						
						ds_option_result.addDataRow(row1);
					}

					if(cstmt!=null) cstmt.close();
				}
				
				if(ds_option_result!=null) ds_option_result.flush();
			}

			//룸 정보 변경
			if(ds_room_result!=null){
				if(ds_room_result!=null){
					res.enableFirstRow(ds_room_result);
					ds_room_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
					ds_room_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
					ds_room_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
				}

				cstmt = conn.prepareCall(arr_sql[12].toString());
				cstmt.setInt        (1, v_m_rsv_sid);
				cstmt.setInt        (2, v_roomType);
				cstmt.setString     (3, fParamEmpno);
				cstmt.setString     (4, fParamIp);
				cstmt.setString     (5, "3");
				cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
					
				cstmt.executeUpdate();
					
				r_s_yn 		= cstmt.getString(6);
				r_msg_cd 	= cstmt.getString(7);
				r_msg 		= cstmt.getString(8);
					
				if(!r_s_yn.equals("Y")){
					throw new Exception (r_msg);
				}
				
				if(ds_room_result!=null){
					GauceDataRow row1 = ds_room_result.newDataRow();
					row1.addColumnValue(r_s_yn);
					row1.addColumnValue(r_msg_cd);
					row1.addColumnValue(r_msg);
					
					ds_room_result.addDataRow(row1);
				}
				
				if(ds_room_result!=null) ds_room_result.flush();
			}

			//판매가 계산 정보 저장
			if(ds_amt!=null){
				if(ds_amt_result!=null){
					res.enableFirstRow(ds_amt_result);
					ds_amt_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
					ds_amt_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
					ds_amt_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
				}

				if(v_accept_sid!=0){
					cstmt = conn.prepareCall(arr_sql[13].toString());

					cstmt.setInt        (1,  v_accept_sid);
					cstmt.registerOutParameter(2, java.sql.Types.DECIMAL);
					cstmt.registerOutParameter(3, java.sql.Types.DECIMAL);
					cstmt.setString(	4, "RV200I");
					cstmt.setString     (5, fParamEmpno);
					cstmt.setString     (6, fParamIp);
					cstmt.setString     (7, v_edit_styatus);
					cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
					
					cstmt.executeUpdate();
					
					r_s_yn 		= cstmt.getString(8);
					r_msg_cd 	= cstmt.getString(9);
					r_msg 		= cstmt.getString(10);
					
					if(!r_s_yn.equals("Y")){
						res.writeException("ERROR", r_msg_cd, r_msg);
					}
					
					if(ds_amt_result!=null){
						GauceDataRow row1 = ds_amt_result.newDataRow();
						row1.addColumnValue(r_s_yn);
						row1.addColumnValue(r_msg_cd);
						row1.addColumnValue(r_msg);
						
						ds_amt_result.addDataRow(row1);
					}
				}
				
				if(ds_amt_result!=null) ds_amt_result.flush();
			}
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			if(cstmt!=null) cstmt.close();
		}
	}

    /**
     * 예약신청에서 사용하기 위하여 임의로 생성
     * DataSet flush 호출함
     * @param rs
     * @param ds
     * @return Vector
     * @throws ServletException
     * @throws Exception
     */
    public Properties getDataSet1(ResultSet rs, GauceDataSet ds) throws ServletException, Exception{
		int v_rowcnt = 0;
		Properties pt = new Properties();
		
		ResultSetMetaData rsmd = rs.getMetaData();
    	String columnName[] = new String[rsmd.getColumnCount()]; // 조회해온 컬럼 만큼 배열을 생성한다 
    	
    	//StringUtil.printMsg("데이터셋  =" , ds.getName() , this);	//해당 데이터셋 이름 확인 
    	
		
    	for (int i = 0; i < columnName.length; i++) {
			columnName[i] = rsmd.getColumnName(i+1); // 컬럼 이름
			//StringUtil.printMsg("컬럼이름-" + i +"==" , columnName[i], this);			//데이터셋의 컬럼 확인.
			
			if(rsmd.getColumnTypeName(i+1).equals("NUMERIC") || rsmd.getColumnTypeName(i+1).equals("INTEGER")) {
				ds.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(i+1)));
			} else {
				ds.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1)));
			}
		}
		
		// 생성된 DataSet에 결과를 넣는다
		while(rs.next()) {
			GauceDataRow row = ds.newDataRow();
			
			for(int i=0; i<columnName.length; i++) {
				if(rsmd.getColumnTypeName(i+1).equals("NUMERIC") || rsmd.getColumnTypeName(i+1).equals("INTEGER")){
					row.addColumnValue(rs.getInt(columnName[i]));
					if(v_rowcnt==0){
						pt.setProperty(columnName[i], rs.getInt(columnName[i])+"");
					}
				} else {
					row.addColumnValue(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]).trim());
					if(v_rowcnt==0) {
						pt.setProperty(columnName[i], rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]).trim());
					}
				}
			}

			ds.addDataRow(row);
			v_rowcnt++;
		}
//StringUtil.printMsg("getDataSet1 v_rowcnt", v_rowcnt+"", this);

		ds.flush();
		
		if(v_rowcnt>0) 	return pt;
		else return null;
    }
}
