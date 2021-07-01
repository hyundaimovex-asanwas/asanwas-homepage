package sales.menu.rv;

import oracle.jdbc.OracleTypes;

import java.util.*;
import java.sql.*;
import java.io.*;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.SuperServlet;
import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;

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
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import com.gauce.GauceException;//[20151016][심동현] 사용자 예외처리 추가

public class Rv200I_N_biz extends SuperServlet {
   
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		//신청서 번호 조회시....
//		arr_sql[0].append ("SELECT R1.ACCEPT_SID,                                    /*  신청서 SID		 */	\n")                               
//				  .append ("       R1.ACCEPT_NO,                                     /*  신청서 번호     */	\n")                                 
//				  .append ("       R1.DEPART_DATE,                                   /*  출발일자        */	\n")                                 
//				  .append ("       R2.DEPART_TIME,                                   /*  출발시간        */	\n")                                 
//				  .append ("       R2.NIGHTS,                                        /*  박수            */	\n")                                 
//				  .append ("       R1.GOODS_SID,                                     /*  상품SID         */	\n")                                 
//				  .append ("	   SALES.FN_GOODS_NM(R1.GOODS_SID, '') AS GOODS_NM,  /*  상품명		*/	\n")                                         
//				  .append ("       R2.ARRIVE_DATE,                                   /*  복귀일자        */	\n")                                 
//				  .append ("       R2.ARRIVE_TIME,                                   /*  복귀시간        */	\n")                                 
//				  .append ("       IFNULL(R15.BOUND_GU,'NONE') AS BOUND_GU,          /*  바운드          */	\n")                                 
//				  .append ("       IFNULL(R15.BOUND_SEQ,1) AS BOUND_SEQ,             /*  바운드순번      */	\n")                                 
//				  .append ("       (SELECT COUNT(BOUND_SID) FROM SALES.TRV015 WHERE ACCEPT_SID=R1.ACCEPT_SID) AS BOUND_TOTAL, /*바운드토탈*/ \n")
//				  .append ("       R1.SAUP_SID,                                      /*  사업소          */	\n")                                 
//				  .append ("       R1.CLIENT_SID,                                    /*  매출처/대리점   */	\n")                                 
//				  .append ("       SALES.FN_CLIENT_NM(CLIENT_SID, '') AS CLIENT_NM,  /*  매출처명        */	\n")                                 
//				  .append ("       R1.EVENT_SID,                                     /*  행사SID         */	\n")                                 
//				  .append ("       R3.EVENT_NO,                                      /*  행사번호        */	\n")                                 
//				  .append ("       R3.EVENT_NM                                       /*  행사명          */	\n")                                 
//				  .append ("  FROM SALES.TRV010 R1 LEFT OUTER JOIN SALES.TRV015 R15 ON (R1.ACCEPT_SID=R15.ACCEPT_SID) 	\n")                     
//				  .append ("  LEFT OUTER JOIN SALES.TRM220 R2  ON R2.GOODS_SID = R1.GOODS_SID            	\n")                                   
//				  .append ("   AND  R2.DEPART_DATE = R1.DEPART_DATE                                      	\n")                                   
//				  .append ("  LEFT OUTER JOIN SALES.TRV060 R3  ON R3.EVENT_SID = R1.EVENT_SID            	\n")                                   
//				  .append (" WHERE R1.ACCEPT_NO  =  ?													 	\n");                                                            

		arr_sql[0].append ("Select                                                                                            \n")
							 .append("         X.ACCEPT_SID																				/*  신청서 SID      */                \n")
							 .append("        ,X.ACCEPT_NO                                        /*  신청서 번호     */                \n")
							 .append("        ,X.DEPART_DATE																			/*  출발일자        */                \n")
							 .append("        ,R2.DEPART_TIME                                  		/*  출발시간        */                \n")
							 .append("        ,R2.NIGHTS                                        	/*  박수            */                \n")
							 .append("        ,X.GOODS_SID																				/*  상품SID         */                \n")
							 .append("        ,SALES.FN_GOODS_NM(X.GOODS_SID, '') AS GOODS_NM  		/*  상품명     			*/                \n")
							 .append("        ,R2.ARRIVE_DATE       															/*  복귀일자        */                \n")
							 .append("        ,R2.ARRIVE_TIME                                                                           \n")
							 .append("        ,X.BOUND_GU																					/*  바운드          */                \n")
							 .append("        ,X.BOUND_SEQ                                        /*  바운드순번      */                \n")
							 .append("        ,X.BOUND_TOTAL																			/*  바운드토탈			*/                \n")
							 .append("        ,X.SAUP_SID																					/*  사업소          */                \n")
							 .append("        ,X.CLIENT_SID                                       /*  매출처/대리점   */                \n")
							 .append("        ,X.EVENT_SID                                        /*  행사SID         */                \n")
							 .append("        ,R3.EVENT_NO                                      	/*  행사번호        */                \n")
							 .append("        ,R3.EVENT_NM                                       	/*  행사명          */                \n")
							 .append("        ,SALES.FN_CLIENT_NM(X.CLIENT_SID, '') AS CLIENT_NM  /*  매출처명        */                \n")
							 .append("FROM                                                                                              \n")
							 .append("(SELECT R1.ACCEPT_SID,                                                                            \n")
							 .append("       R1.ACCEPT_NO,                                                                              \n")
							 .append("       (SELECT NVL(MAX(DEPART_DATE),null) AS D1 FROM SALES.TRV020                                \n")
							 .append("        WHERE ACCEPT_SID=R1.ACCEPT_SID AND BOUND_SEQ=R15.BOUND_SEQ) AS DEPART_DATE,               \n")
							 .append("       R15.GOODS_SID,                                                                             \n")
							 .append("       NVL(R15.BOUND_GU,'NONE') AS BOUND_GU,                                                   \n")
							 .append("       NVL(R15.BOUND_SEQ,1) AS BOUND_SEQ,                                                      \n")
							 .append("       (SELECT COUNT(BOUND_SID) FROM SALES.TRV015 WHERE ACCEPT_SID=R1.ACCEPT_SID) AS BOUND_TOTAL, \n")
							 .append("       R1.SAUP_SID,                                                                               \n")
							 .append("       R1.CLIENT_SID,                                                                             \n")
							 .append("       R1.EVENT_SID                                                                               \n")
							 .append("  FROM SALES.TRV010 R1 LEFT OUTER JOIN SALES.TRV015 R15 ON (R1.ACCEPT_SID=R15.ACCEPT_SID)         \n")
							 .append(" WHERE R1.ACCEPT_NO = ?                                                           \n");

		
		//상품정보 조회시....
		arr_sql[1].append ("SELECT R1.GOODS_SID,     /* 상품SID     */		\n")
				  .append ("       R1.GOODS_NM,      /* 상품명      */      \n")
				  .append ("       R2.DEPART_DATE,   /* 출발일자    */      \n")
				  .append ("       R2.DEPART_TIME,   /* 출발시간    */      \n")
				  .append ("       R2.NIGHTS,        /* 박수        */      \n")
				  .append ("       R2.ARRIVE_DATE,   /* 복귀일자    */      \n")
				  .append ("       R2.ARRIVE_TIME,   /* 복귀시간	*/      \n")
				  .append ("       R1.SAUP_SID,       /* 지역SID	*/      \n")
				  .append ("       R3.BOUND_GU,		  /* BOUND		*/      \n")
				  .append ("       1 AS BOUND_SEQ	  /* BOUND_SEQ  */      \n")
				  .append ("  FROM SALES.TRM200 R1 JOIN SALES.TRM220 R2 ON R2.GOODS_SID = R1.GOODS_SID  \n")
				  .append ("    				   JOIN SALES.TSY200 R3 ON R1.SAUP_SID  = R3.SAUP_SID  \n")
				  .append (" WHERE R1.SAUP_SID     =  ?						\n")
				  .append ("   AND R2.DEPART_DATE  =  ?						\n")
				  .append ("   AND R1.USE_YN       = 'Y'					\n")
				  .append (" ORDER BY R1.GOODS_NM, R2.DEPART_TIME			\n");

		//객실 타입 / 변경가능 객실
		arr_sql[2].append ("{call SALES.PR_RV200I_22(?,?,?,?,?,   ?,?,?,?,?) }");
		
		//투숙객 명단 조회
		arr_sql[3].append ("{call SALES.PR_RV200I_23_biz(?,?,?,?,?,   ?,?,?)}");
		
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
		arr_sql[7].append ("{call SALES.PR_RV200I_21(?,?,?,?,?,    ?,?,?) }");
		
		//관광객 명단
		arr_sql[8].append ("{call SALES.PR_RV200I_20(?,?,?) }");
		
		//관광객 추가시 사전체크
		arr_sql[9].append ("{call SALES.PR_DC_MAIN(?,?,?,?,?,  	?,?,?,?,?,	 ?,?,?,?,?, 	?,?,?,?,?, 		?,?,?,?,?, 		?,?,?,?,?, 		?,?) }");
		
		//투숙객 정보 저장
		arr_sql[10].append ("{call SALES.PR_RV200I_01_biz(?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,   ?,?,?,?,?,   ?,?,?,?,?,   ?,?,?,?,?,  ?,?,?,?,?  ,?,?)}");
		
		//Option 요금 저장
		arr_sql[11].append ("{call SALES.PR_RV200I_02(?,?,?,?,?,   ?,?,?,?,?,     ?,?,?,?,?) }");
		
		//객실변경 저장
		arr_sql[12].append ("{call SALES.PR_RV200I_05(?, ?, ?, ?, ?, ?, ?, ?) }");
		
		//판매가 계산 저장
		arr_sql[13].append ("{call SALES.PR_RV200I_06(?,?,?,?,?,    ?,?,?,?,?) }");
		
		//포캐스팅 정보 조회
		arr_sql[14].append ("{call SALES.PR_RV200I_24(?,?,?,?,?,    ?,?) }");
		
		//차량 명단 조회(2개)
		arr_sql[15].append ("{call SALES.PR_RV200I_40(?,?,?) }");

		//차량 명단 저장(18개)
		arr_sql[16].append ("{call SALES.PR_RV200I_41(?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?) }");		
		
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}

	/**
	 * 기본적인 조회 처리 담당
	 * 기타 분기할 수 있다면... 이곳에서 처리하여 넘겨준다.
	 */
	 public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;

		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		
		try{
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			int    v_business    = HDUtil.nullCheckNum(greq.getParameter("v_business")); 	//사업소
			String v_accept_check= HDUtil.nullCheckStr(greq.getParameter("v_accept_check")); //체크박스
			String v_accept_no   = HDUtil.nullCheckStr(greq.getParameter("v_accept_no"));	//신청서번호
			String v_depart_date = HDUtil.nullCheckStr(greq.getParameter("v_depart_date"));	//출발일자
			String v_depart_time = HDUtil.nullCheckStr(greq.getParameter("v_depart_time"));	//출발시간
			String v_arrive_date = HDUtil.nullCheckStr(greq.getParameter("v_arrive_date"));	//도착일자
			String v_arrive_time = HDUtil.nullCheckStr(greq.getParameter("v_arrive_time"));	//도착시간
			String v_blockType   = HDUtil.nullCheckStr(greq.getParameter("v_blockType")); 	//블록/일반 예약 정보
			
			String v_fr_date 	 = HDUtil.nullCheckStr(greq.getParameter("v_fr_date"));	//도착일자
			String v_to_date 	 = HDUtil.nullCheckStr(greq.getParameter("v_to_date"));	//도착일자

			int    v_accept_sid  = HDUtil.nullCheckNum(greq.getParameter("v_accept_sid"));	//예약 SID
			int    v_client_sid  = HDUtil.nullCheckNum(greq.getParameter("v_client_sid"));	//매출처코드
			int    v_goods_sid   = HDUtil.nullCheckNum(greq.getParameter("v_goods_sid"));	//상품 SID
			int    v_roomType    = HDUtil.nullCheckNum(greq.getParameter("v_roomType"));		//ROOMTYPE SID
			//StringUtil.printMsg("v_roomType sid 받아온 것?????==", v_roomType, this);
			int    v_room_sid    = HDUtil.nullCheckNum(greq.getParameter("v_room_sid"));		//ROOM SID
			int    v_block_sid    = HDUtil.nullCheckNum(greq.getParameter("v_block_sid"));	//BLOCK SID
			int    v_event_sid   = HDUtil.nullCheckNum(greq.getParameter("v_event_sid"));	//단체행사SID
			int    v_nights      = HDUtil.nullCheckNum(greq.getParameter("v_nights"));		//박수
			int    v_m_rsv_sid   = HDUtil.nullCheckNum(greq.getParameter("v_m_rsv_sid"));	//예약 SID
			int    v_rsv_sid     = HDUtil.nullCheckNum(greq.getParameter("v_rsv_sid"));		//예약 SID
			int    v_bound_seq	 = HDUtil.nullCheckNum(greq.getParameter("v_bound_seq"));	//넘겨받는 bound_seq
			/*
			StringUtil.printMsg("v_business[Rv200I_N_biz.java] ==", v_business, this);
			StringUtil.printMsg("v_accept_check[Rv200I_N_biz.java] ==", v_accept_check, this);
			StringUtil.printMsg("v_accept_no[Rv200I_N_biz.java] ==", v_accept_no, this);
			StringUtil.printMsg("v_depart_date[Rv200I_N_biz.java] ==", v_depart_date, this);
			StringUtil.printMsg("v_depart_time[Rv200I_N_biz.java] ==", v_depart_time, this);
			StringUtil.printMsg("v_arrive_date[Rv200I_N_biz.java] ==", v_arrive_date, this);
			StringUtil.printMsg("v_arrive_time[Rv200I_N_biz.java] ==", v_arrive_time, this);
			StringUtil.printMsg("v_blockType[Rv200I_N_biz.java] ==", v_blockType, this);
			StringUtil.printMsg("v_fr_date[Rv200I_N_biz.java] ==", v_fr_date, this);
			StringUtil.printMsg("v_to_date[Rv200I_N_biz.java] ==", v_to_date, this);
			StringUtil.printMsg("v_accept_sid[Rv200I_N_biz.java] ==", v_accept_sid, this);
			StringUtil.printMsg("v_client_sid[Rv200I_N_biz.java] ==", v_client_sid, this);
			StringUtil.printMsg("v_goods_sid[Rv200I_N_biz.java] ==", v_goods_sid, this);
			StringUtil.printMsg("v_roomType[Rv200I_N_biz.java] ==", v_roomType, this);
			StringUtil.printMsg("v_room_sid[Rv200I_N_biz.java] ==", v_room_sid, this);
			StringUtil.printMsg("v_block_sid[Rv200I_N_biz.java] ==", v_block_sid, this);
			StringUtil.printMsg("v_event_sid[Rv200I_N_biz.java] ==", v_event_sid, this);
			StringUtil.printMsg("v_nights[Rv200I_N_biz.java] ==", v_nights, this);
			StringUtil.printMsg("v_m_rsv_sid[Rv200I_N_biz.java] ==", v_m_rsv_sid, this);
			StringUtil.printMsg("v_rsv_sid[Rv200I_N_biz.java] ==", v_rsv_sid, this);
			StringUtil.printMsg("v_bound_seq[Rv200I_N_biz.java] ==", v_bound_seq, this);
			*/
			//관리번호로 투숙객 명단 조회
			String v_manage_no   = HDUtil.nullCheckStr(greq.getParameter("v_manage_no"));//고객 관리번호

			/* DataSet */
			/*
			GauceDataSet ds_search 		= req.getGauceDataSet("SEARCH");	//검색조건
			GauceDataSet ds_room   		= req.getGauceDataSet("ROOM");		//룸타입
			GauceDataSet ds_block  		= req.getGauceDataSet("BLOCK");		//블록/일반
			GauceDataSet ds_roomChange  = req.getGauceDataSet("ROOMCHANGE");//변경가능객실
			GauceDataSet ds_cust   		= req.getGauceDataSet("CUST");		//투숙객 명단
			GauceDataSet ds_tour   		= req.getGauceDataSet("TOUR");		//옵션 요금 내역
			GauceDataSet ds_forecasting = req.getGauceDataSet("FORECASTING");		//FORECASTING
			GauceDataSet ds_cust_temp   = req.getGauceDataSet("CUST_TEMP");	//사용자 조회
			GauceDataSet ds_cust_result = req.getGauceDataSet("CUST_RESULT");	//사용자 사전 결과
			GauceDataSet ds_car   		= req.getGauceDataSet("CAR");		//우측 차량 명단
			*/
			GauceDataSet ds_cust_result = gis.read("CUST_RESULT");
			Properties pt_cust_temp   = null;
			
			for(int i=0; i<dSets.length;i++){	
			//기본 검색 내역
				if(dSets[i].getName().equals("ds_search")){
					GauceDataSet ds1 = gis.read("SEARCH");
					int sCnt1 = 1;
					if((!v_accept_no.equals("")) && (v_accept_no != null)){
						//StringUtil.printMsg("신청서번호가 있을��","", this);
						if(v_client_sid!=0){
							arr_sql[0].append ("  AND R1.CLIENT_SID = ?			\n");
						}
						if(v_bound_seq>1){	//1보다 큰순번으로 이동할 때만
							arr_sql[0].append ("  AND R15.BOUND_SEQ = ?         \n");
						}
						
						arr_sql[0].append(" ORDER BY R15.BOUND_SEQ ASC \n") //FETCH FIRST 1 ROWS ONLY  	\n")					
			 					  .append(") X                                                                                            \n")
								  .append("  LEFT OUTER JOIN SALES.TRM220 R2  ON (R2.GOODS_SID=X.GOODS_SID AND R2.DEPART_DATE=X.DEPART_DATE) \n")
								  .append("  LEFT OUTER JOIN SALES.TRV060 R3  ON (R3.EVENT_SID = X.EVENT_SID)                                \n");
					
						cstmt = conn.prepareCall(arr_sql[0].toString());
						//System.out.println(arr_sql[0].toString());
						
						cstmt.setString(sCnt1++, v_accept_no);
						if(v_client_sid!=0){
							cstmt.setInt(sCnt1++, v_client_sid);
						}
						//StringUtil.printMsg("v_client_sid===", v_client_sid, this);
						if(v_bound_seq>1){	//1보다 큰순번으로 이동할 때만
							cstmt.setInt(sCnt1++, v_bound_seq);
						}					
						//StringUtil.printMsg("v_bound_seq===", v_bound_seq, this);
					} else if((!v_depart_date.equals("")) && (v_depart_date != null)){
						//StringUtil.printMsg("신청서번호가 없을 ��","",this);
						//StringUtil.printMsg("v_business===", v_business, this);
						//StringUtil.printMsg("v_depart_date===", v_depart_date, this);
						//System.out.println(arr_sql[1].toString());
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1, v_business);
						cstmt.setString(2, v_depart_date);
					}
					rs = cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
					}
			
				//룸타입
				if(dSets[i].getName().equals("ds_room")){
					GauceDataSet ds1 = gis.read("ROOM");
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
					cstmt.registerOutParameter(10, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(10);	//커서 OUT param. 			
					gos.write(getDataSet(rs, ds1));
				}
				
				//block info
				if(dSets[i].getName().equals("ds_block")){
					GauceDataSet ds1 = gis.read("BLOCK");
					/*
					StringUtil.printMsg("ds_block", "ds_block", this);
					StringUtil.printMsg("v_blockType", v_blockType, this);
					StringUtil.printMsg("v_client_sid", v_client_sid, this);
					StringUtil.printMsg("v_depart_date", v_depart_date, this);
					StringUtil.printMsg("v_goods_sid", v_goods_sid, this);
					StringUtil.printMsg("v_roomType", v_roomType, this);
					StringUtil.printMsg("v_accept_sid", v_accept_sid, this);
					StringUtil.printMsg("v_nights", v_nights, this);
					*/
					cstmt = conn.prepareCall(arr_sql[7].toString());
					cstmt.setString(1, v_blockType);
					cstmt.setInt   (2, v_client_sid);
					cstmt.setString(3, v_depart_date);
					cstmt.setInt   (4, v_goods_sid);
					cstmt.setInt   (5, v_roomType);
					cstmt.setInt   (6, v_accept_sid);
					cstmt.setInt   (7, v_nights);
					cstmt.registerOutParameter(8, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(8);	//커서 OUT param. 			
					gos.write(getDataSet(rs, ds1));
				}
				
				//변경가능객실
				if(dSets[i].getName().equals("ds_roomChange")){
					//StringUtil.printMsg("ds_roomChange", "ds_roomChange", this);
					GauceDataSet ds1 = gis.read("ROOMCHANGE");
					cstmt = conn.prepareCall(arr_sql[2].toString());
					/*
					StringUtil.printMsg("arr_sql[2].toString()", arr_sql[2].toString(), this);
					StringUtil.printMsg("v_blockType", v_blockType, this);
					StringUtil.printMsg("v_client_sid", v_client_sid, this);
					StringUtil.printMsg("v_depart_date", v_depart_date, this);
					StringUtil.printMsg("v_goods_sid", v_goods_sid, this);
					StringUtil.printMsg("v_goods_sid", v_goods_sid, this);
					StringUtil.printMsg("v_roomType", v_roomType, this);
					StringUtil.printMsg("v_accept_sid", v_accept_sid, this);
					StringUtil.printMsg("v_nights", v_nights, this);
					StringUtil.printMsg("v_business", v_business, this);
					*/
					cstmt.setString(1, v_blockType);
					cstmt.setString(2, "Y");
					cstmt.setInt   (3, v_client_sid);
					cstmt.setString(4, v_depart_date);
					cstmt.setInt   (5, v_goods_sid);
					cstmt.setInt   (6, v_roomType);
					cstmt.setInt   (7, v_accept_sid);
					cstmt.setInt   (8, v_nights);
					cstmt.setInt   (9, v_business);
					cstmt.registerOutParameter(10, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(10);	//커서 OUT param. 			
					gos.write(getDataSet(rs, ds1));
				}
				
				//투숙객 명단
				if(dSets[i].getName().equals("ds_cust")){
					GauceDataSet ds1 = gis.read("CUST");
					cstmt = conn.prepareCall(arr_sql[3].toString()); //ds_cust에서도 이걸 조회한다.SALES.PR_RV200I_23
					//StringUtil.printMsg("v_m_rsv_sid", v_m_rsv_sid, this);
					//StringUtil.printMsg("v_manage_no", v_manage_no, this);
					//StringUtil.printMsg("v_depart_date", v_depart_date, this);
					//StringUtil.printMsg("v_goods_sid", v_goods_sid, this);
					//StringUtil.printMsg("v_arrive_date", v_arrive_date, this);
					//StringUtil.printMsg("v_arrive_time", v_arrive_time, this);
					
					
					if(v_rsv_sid==0 || v_rsv_sid==' '){
						if((!v_manage_no.equals("")) && (v_manage_no != null)){
							//StringUtil.printMsg("1번조회", v_goods_sid, this);
							cstmt.setInt(1, 0);
							cstmt.setInt(2, 0);
							cstmt.setString(3, v_manage_no);
							cstmt.setString(4, v_depart_date);
							cstmt.setInt   (5, v_goods_sid);
							cstmt.setString(6, v_arrive_date);
							cstmt.setString(7, v_arrive_time);
							
						} else {
							//StringUtil.printMsg("2번조회", v_m_rsv_sid, this);
							cstmt.setInt(1, 0);
							cstmt.setInt(2, v_m_rsv_sid);
							cstmt.setString(3, "");
							cstmt.setString(4, v_depart_date);
							cstmt.setInt   (5, v_goods_sid);
							cstmt.setString(6, v_arrive_date);
							cstmt.setString(7, v_arrive_time);
							
						}
					} else {
						//StringUtil.printMsg("3번조회", v_goods_sid, this);
						cstmt.setInt(1, v_rsv_sid);
						cstmt.setInt(2, 0);
						cstmt.setString(3, v_manage_no);
						cstmt.setString(4, v_depart_date);
						cstmt.setInt   (5, v_goods_sid);
						cstmt.setString(6, v_arrive_date);
						cstmt.setString(7, v_arrive_time);					
					}
					cstmt.registerOutParameter(8, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(8);	//커서 OUT param. 			
					gos.write(getDataSet(rs, ds1));
					pt_cust_temp = getDataSet1(rs, ds1);
								
					if(pt_cust_temp!=null){
						cstmt = conn.prepareCall(arr_sql[9].toString());	//pr_dc_main. 그리고 여기..
						cstmt.setString (1, "G15");				//신청창구번호: 좌측 방그리드 클릭할 때, 사람 있으면
						//StringUtil.printMsg("304라인 pACCEPT_SEQ", "G15", this);	// 여긴 오류 아니네..
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
						//StringUtil.printMsg("MANAGE_NO==", pt_cust_temp.getProperty("MANAGE_NO"), this);
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
						cstmt.registerOutParameter(32, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(32);	//커서 OUT param. 			
						gos.write(getDataSet(rs, ds1));
						//StringUtil.printMsg("라인 : 355 ==================", cstmt.getString(29)+ "[]", this);
						
						if(cstmt.getString(29).equals("N")){	//-- 여기 같음..
							throw new Exception(cstmt.getString(31));
						}
						
						if(ds_cust_result!=null){
							ds_cust_result.addDataColumn(new GauceDataColumn("CUST_SID", GauceDataColumn.TB_NUMBER));
							ds_cust_result.addDataColumn(new GauceDataColumn("TOUR_AMT", GauceDataColumn.TB_NUMBER));
							ds_cust_result.addDataColumn(new GauceDataColumn("OPTION_AMT", GauceDataColumn.TB_NUMBER));
							ds_cust_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
							ds_cust_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
							ds_cust_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
							
							int r_cust__sid	=	cstmt.getInt(18);
							int r_tour_amt	=	cstmt.getInt(27);
							int r_option_amt	=	cstmt.getInt(28);
							String r_s_yn		= cstmt.getString(29);
							String r_msg_cd	 	= cstmt.getString(30);
							String r_msg		= cstmt.getString(31);
							
							ds_cust_result.put("CUST_SID", r_cust__sid, 10);
							ds_cust_result.put("TOUR_AMT", r_tour_amt, 10);
							ds_cust_result.put("OPTION_AMT", r_option_amt, 10);
							ds_cust_result.put("S_YN", r_s_yn, 1);
							ds_cust_result.put("MSG_CD", r_msg_cd, 4);
							ds_cust_result.put("MSG", r_msg, 200);
							ds_cust_result.heap();
							
							if(ds_cust_result!=null) gos.write(ds_cust_result);
							//ds_cust_result.flush();
						}
						if(cstmt!=null) cstmt.close();
					}
					//StringUtil.printMsg("ds_cust 구간 끝-------------------------", "", this);
				}
				
				//ForeCasting 정보 조회
				if(dSets[i].getName().equals("ds_forecasting")){
					GauceDataSet ds1 = gis.read("FORECASTING");
					cstmt = conn.prepareCall(arr_sql[14].toString());
					cstmt.setString(1, v_blockType);
					//StringUtil.printMsg("여기일까 ds_forecasting", v_blockType, this);//여기서 오류 발생.
					cstmt.setInt(2, v_client_sid);
					cstmt.setInt(3, v_goods_sid);
					cstmt.setInt(4, v_nights);
					cstmt.setString(5, v_fr_date);
					cstmt.setString(6, v_to_date);
					cstmt.registerOutParameter(7, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(7);	//커서 OUT param. 			
					gos.write(getDataSet(rs, ds1));
				}
				
				//관광객 명단 info
				if(dSets[i].getName().equals("ds_tour")){
					GauceDataSet ds1 = gis.read("TOUR");
					cstmt = conn.prepareCall(arr_sql[8].toString());
					cstmt.setInt   (1, v_accept_sid);
					cstmt.setString(2, v_accept_check);
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 			
					gos.write(getDataSet(rs, ds1));
				}
				
				if(dSets[i].getName().equals("ds_cust_temp")){
					GauceDataSet ds1 = gis.read("CUST_TEMP");
					cstmt = conn.prepareCall(arr_sql[3].toString()); //고객정보를 조회해와서 PR_RV200I_23(?, ?, ?, ?, ?)
					/*
					StringUtil.printMsg("ds_cust_temp ::::::::::::", arr_sql[3].toString(), this);				
					StringUtil.printMsg("arr_sql[3] v_manage_no", v_manage_no, this);
					StringUtil.printMsg("arr_sql[3] v_depart_date", v_depart_date, this);
					StringUtil.printMsg("arr_sql[3] v_goods_sid", v_goods_sid, this);
					StringUtil.printMsg("arr_sql[3] v_arrive_date", v_arrive_date, this);
					StringUtil.printMsg("arr_sql[3] v_arrive_time", v_arrive_time, this);
					*/
					cstmt.setInt(1, 0);
					cstmt.setInt(2, 0);
					cstmt.setString(3, v_manage_no);
					cstmt.setString(4, v_depart_date);	//추가 - 할인상세 펑션을 위한 파라미터.
					cstmt.setInt   (5, v_goods_sid);	//추가 
					cstmt.setString(6, v_arrive_date);
					cstmt.setString(7, v_arrive_time);
					cstmt.registerOutParameter(8, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(8);	//커서 OUT param. 			
					gos.write(getDataSet(rs, ds1));
					
					pt_cust_temp = getDataSet1(rs, ds1);
					
					if(pt_cust_temp!=null){
						cstmt = conn.prepareCall(arr_sql[9].toString());	//사전체크작업을 한다(PR_DC_MAIN)
						//StringUtil.printMsg("449라인 arr_sql[9] ::::::::::::", arr_sql[9].toString(), this);
						cstmt.setString (1, "G14");				//신청창구번호: 투숙객 추가버튼 클릭할 때. 이때만 중복체크
						//StringUtil.printMsg("451라인 pACCEPT_SEQ", "G14", this);	// 여긴 오류 아니네..
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
						//StringUtil.printMsg("ds_cust_temp:19", pt_cust_temp.getProperty("MANAGE_NO"), this);	//
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
						cstmt.registerOutParameter(32, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(32);	//커서 OUT param. 			
						gos.write(getDataSet(rs, ds1));
						
						//StringUtil.printMsg("실명확인체크 결과메세지?",cstmt.getString(29), this);
						//StringUtil.printMsg("실명확인체크 결과메세지?",cstmt.getString(31), this);
						if(cstmt.getString(29).equals("N"))
							throw new Exception(cstmt.getString(31));
						
						if(ds_cust_result!=null){
							ds_cust_result.addDataColumn(new GauceDataColumn("CUST_SID", GauceDataColumn.TB_NUMBER));
							ds_cust_result.addDataColumn(new GauceDataColumn("TOUR_AMT", GauceDataColumn.TB_NUMBER));
							ds_cust_result.addDataColumn(new GauceDataColumn("OPTION_AMT", GauceDataColumn.TB_NUMBER));
							ds_cust_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
							ds_cust_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
							ds_cust_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
							
							/*
							GauceDataRow row = ds_cust_result.newDataRow();
							
							row.addColumnValue(cstmt.getBigDecimal(18).intValue());
							row.addColumnValue(cstmt.getBigDecimal(27).intValue());
							row.addColumnValue(cstmt.getBigDecimal(28).intValue());
							row.addColumnValue(cstmt.getString(29));
							row.addColumnValue(cstmt.getString(30));
							row.addColumnValue(cstmt.getString(31));
							
							ds_cust_result.addDataRow(row);
							*/
							int r_cust__sid	=	cstmt.getInt(18);
							int r_tour_amt	=	cstmt.getInt(27);
							int r_option_amt	=	cstmt.getInt(28);
							String r_s_yn		= cstmt.getString(29);
							String r_msg_cd	 	= cstmt.getString(30);
							String r_msg		= cstmt.getString(31);
							
							ds_cust_result.put("CUST_SID", r_cust__sid, 10);
							ds_cust_result.put("TOUR_AMT", r_tour_amt, 10);
							ds_cust_result.put("OPTION_AMT", r_option_amt, 10);
							ds_cust_result.put("S_YN", r_s_yn, 1);
							ds_cust_result.put("MSG_CD", r_msg_cd, 4);
							ds_cust_result.put("MSG", r_msg, 200);
							ds_cust_result.heap();
							
							if(ds_cust_result!=null) gos.write(ds_cust_result);
							//ds_cust_result.flush();
						}
						if(cstmt!=null) cstmt.close();
					}
				}
				
				// 차량 명단 조회
				if(dSets[i].getName().equals("ds_car")){
					GauceDataSet ds1 = gis.read("CAR");
				
					//StringUtil.printMsg("v_accept_sid", v_accept_sid, this);
					//StringUtil.printMsg("v_bound_seq", v_bound_seq, this);
					
					cstmt = conn.prepareCall(arr_sql[15].toString());
					cstmt.setInt   (1, v_accept_sid);
					cstmt.setInt   (2, v_bound_seq);
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 			
					gos.write(getDataSet(rs, ds1));
				}
			 }

		}catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			((HttpGauceResponse) gres).addException(
					new GauceException("SrvERROR", sqle.getErrorCode()+"", sqle.getMessage())
			);
			throw sqle;
		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			((HttpGauceResponse) gres).addException(
					new GauceException("SrvERROR", " ", e.toString())
			);
			throw e;
		} finally {
			gos.close();
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
	
	/**
	 * CUD 작업 처리...
	 */
	 public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		CallableStatement cstmt = null;	
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();

		
		try{
			String v_accept_no   = HDUtil.nullCheckStr(greq.getParameter("v_accept_no"));	//신청서번호
			String v_depart_date = HDUtil.nullCheckStr(greq.getParameter("v_depart_date"));	//출발일자
			String v_depart_time = HDUtil.nullCheckStr(greq.getParameter("v_depart_time"));	//출발시간
			String v_arrive_date = HDUtil.nullCheckStr(greq.getParameter("v_arrive_date"));	//도착일자- 이걸 앞으로 따로 받아야
			String v_arrive_time = HDUtil.nullCheckStr(greq.getParameter("v_arrive_time"));	//도착시간- 이걸 앞으로 따로 받아야
			String v_blockType   = HDUtil.nullCheckStr(greq.getParameter("v_blockType")); 	//블록/일반 예약 정보
			int    v_accept_sid  = HDUtil.nullCheckNum(greq.getParameter("v_accept_sid"));	//예약 SID
			int    v_client_sid  = HDUtil.nullCheckNum(greq.getParameter("v_client_sid"));	//매출처코드
			int    v_goods_sid   = HDUtil.nullCheckNum(greq.getParameter("v_goods_sid"));	//상품 SID
			int    v_roomType    = HDUtil.nullCheckNum(greq.getParameter("v_roomType"));		//ROOMTYPE SID
			int    v_room_sid    = HDUtil.nullCheckNum(greq.getParameter("v_room_sid"));		//ROOM SID
			int    v_block_sid   = HDUtil.nullCheckNum(greq.getParameter("v_block_sid"));	//BLOCK SID
			int    v_event_sid   = HDUtil.nullCheckNum(greq.getParameter("v_event_sid"));	//단체행사SID
			int    v_nights      = HDUtil.nullCheckNum(greq.getParameter("v_nights"));		//박수 (신청서순번상의 상품)
			int    v_m_rsv_sid   = HDUtil.nullCheckNum(greq.getParameter("v_m_rsv_sid"));	//예약 SID
			int    v_rsv_sid     = HDUtil.nullCheckNum(greq.getParameter("v_rsv_sid"));		//예약 SID
			int    v_bound_seq   = HDUtil.nullCheckNum(greq.getParameter("v_bound_seq"));	//순번
			
			//ds_cust 에서 받을 변수 선언
			String r_manage_no 	= null;										//투숙객 주민번호
			int    r_rsv_sid 	= 0;										//투숙객 예약 번호
			int    r_cust_sid 	= 0;										//투숙 고객 일련 번호
			String r_saup_gu	= null;										//사업구분
			String r_cust_type	= null;										//할인유형
			String r_age_cd		= null;										//연령
			String r_join_cd	= null;										//동숙코드[RV006] 본인/배우자/...
			String r_mobile_no	= null;										//휴대전화번호
			String r_remark		= null;										//비고
			//할인상세용 4개 추가.
			String r_carowner_yn= null;										//자차여부
			String r_jeju_yn	= null;										//제주여부
			String r_weekend_yn	= null;										//주말여부
			String r_theme_cd	= null;										//테마여부
			//사업자용 변경사항 3개 추가	2010-02-23	심동
			String r_pay_pre	= null;	//정산담당
			String r_pay_saup	= null;	//정산시기
			String r_north_purpose = null;//방북목적
			//사업자 변경 3개 추가	2010-02-23	심동
			
			int    r_key_seq 	= 0;										//옵션 순서

			//내부 변수
			String v_edit_styatus = null;										//IN 편집상태     1: INSERT, 2: DELETE, 3: UPDATE
			String v_send_id 	= null;
			String r_s_yn		= null;
			String r_msg_cd		= null;
			String r_msg		= null;
			
			String iParamEmpno = fParamEmpno;
			String iParamIp = fParamIp;
							
			/* DataSet */
			GauceDataSet ds_cust 	= gis.read("REG_CUST");		//투숙객 정보
			GauceDataSet ds_option 	= gis.read("REG_OPTION");	//옵션 정보		
			GauceDataSet ds_amt 	= gis.read("REG_AMT");		//룸 정보 변경
			
			GauceDataSet ds_car 	= gis.read("REG_CAR");		//차량명단 저장
			GauceDataSet ds_result 	= gis.read("SAVE_RESULT");	//투숙객 정보 저장 결과	
			GauceDataSet ds_option_result 	= gis.read("OPTION_RESULT");	//옵션 정보 저장 결과
			GauceDataSet ds_amt_result 		= gis.read("AMT_RESULT");		//판매가 계산 결과
			GauceDataSet ds_room_result 	= gis.read("ROOM_RESULT");		//룸정보 변경 결과
			
			int v_row = 1;
			
			if(ds_cust!=null){
				if(ds_result!=null){
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
				GauceDataRow[] 		rows = ds_cust.getDataRows();
				
				for(int i=0; i<rows.length; i++){
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_INSERT){
						v_edit_styatus = "1";
						v_send_id = "G11";
					} else if(rows[i].getJobType()==GauceDataRow.TB_JOB_DELETE) {
						v_edit_styatus = "2";
						v_send_id = "G13";
					} if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
						v_edit_styatus = "3";
						v_send_id = "G12";
					}

					//여기서의 배열 순번은 PR_RV200I_23 에서 select 하는 ds_cust의 컬럼순서다. by 심동 2007-05-14
					// 그냥 힘들면 아래 입경일자|시간 처럼 컬럼인덱스를 받아서 다시 넣어주면 됨! 2010-02-18 
					r_rsv_sid 		= rows[i].getInt(0);							//투숙객 예약 번호
					r_cust_sid 		= rows[i].getInt(3);							//투숙 고객 일련 번호
					r_manage_no		= rows[i].getString(4);						//투숙객 주민번호
					r_saup_gu		= rows[i].getString(9);						//사업구분
					r_cust_type		= rows[i].getString(7);						//할인유형
					r_age_cd		= rows[i].getString(6);						//연령
					r_join_cd		= rows[i].getString(10);						//동숙코드[RV006] 본인/배우자/...
					r_mobile_no		= rows[i].getString(13);						//휴대전화번호
					r_remark		= rows[i].getString(ds_cust.indexOfColumn("REMARKS"));		//비고
					//할인상세용 4개 추가.
					r_carowner_yn	= rows[i].getString(28);						//자차여부
					r_jeju_yn		= rows[i].getString(29);						//제주여부
					r_weekend_yn	= rows[i].getString(30);						//주말여부
					r_theme_cd		= rows[i].getString(31);						//테마여부

					int colNm_ArriveDate    = ds_cust.indexOfColumn("ARRIVE_DATE");	/* 입경일자   16  */
					int colNm_ArriveTime    = ds_cust.indexOfColumn("ARRIVE_TIME");	/* 입경시간   17  */

					r_pay_pre		= rows[i].getString(ds_cust.indexOfColumn("PAY_PRE"));	//정산시기
					r_pay_saup		= rows[i].getString(ds_cust.indexOfColumn("PAY_SAUP"));	//정산담당
					r_north_purpose = rows[i].getString(ds_cust.indexOfColumn("NORTH_PURPOSE"));	//방북목적
					
					
					if(v_edit_styatus.equals("1")){
						if(r_rsv_sid!=0) v_edit_styatus = "3";
					}

				    v_row = 1;
				    cstmt = conn.prepareCall(arr_sql[10].toString());			// call SALES.PR_RV200I_01_biz()
				    /*
				    StringUtil.printMsg("v_accept_sid", v_accept_sid, this);
				    StringUtil.printMsg("v_accept_no setString", v_accept_no, this);
				    StringUtil.printMsg("v_depart_date setString", v_depart_date, this);
				    StringUtil.printMsg("상품sid", v_goods_sid, this);
				    StringUtil.printMsg("매출처sid", v_client_sid, this);
				    StringUtil.printMsg("이벤트 sid", v_event_sid, this);
				    StringUtil.printMsg("작업구분 setString", "1", this);
				    StringUtil.printMsg("예약sid ", r_rsv_sid, this);
				    StringUtil.printMsg("메인예약id ", v_m_rsv_sid, this);
				    StringUtil.printMsg("객실타입 sid", v_roomType, this);
				    StringUtil.printMsg("룸 sid ", v_room_sid, this);
				    StringUtil.printMsg("블록 sid ", v_block_sid, this);
				    StringUtil.printMsg("예약타입 setString ", v_blockType, this);
				    StringUtil.printMsg("v_depart_time setString ", v_depart_time, this);
				    StringUtil.printMsg("박수 ", v_nights, this);
					StringUtil.printMsg("복귀일자 setString ", rows[i].getString(colNm_ArriveDate), this);
					StringUtil.printMsg("복귀시간 setString ", rows[i].getString(colNm_ArriveTime), this);
					StringUtil.printMsg("r_cust_sid ", r_cust_sid, this);
					StringUtil.printMsg("r_cust_gu setString ", "2", this);
					StringUtil.printMsg("r_saup_gu setString", r_saup_gu, this);					
					StringUtil.printMsg("r_cust_type setString", r_cust_type, this);
					StringUtil.printMsg("r_age_cd setString", r_age_cd, this);
					StringUtil.printMsg("동숙구분 setString", r_join_cd, this);
					StringUtil.printMsg("r_mobile_no setString", r_mobile_no, this);					
					StringUtil.printMsg("유치자 setString", rows[i].getString(ds_cust.indexOfColumn("HOLD_EMPNO")), this);
					StringUtil.printMsg("예약방법 setString", "1", this);					
					StringUtil.printMsg("참고사항 setString", r_remark, this);
					StringUtil.printMsg("fParamEmpno setString", fParamEmpno, this);
					StringUtil.printMsg("fParamIp setString", fParamIp, this);
					StringUtil.printMsg("자차여부 setString", r_carowner_yn, this);
					StringUtil.printMsg("제주여부 setString", r_jeju_yn, this);
					StringUtil.printMsg("주말여부 setString", r_weekend_yn, this);
					StringUtil.printMsg("테마여부 setString ", r_theme_cd, this);
					StringUtil.printMsg("상품순번 ", v_bound_seq, this);
					StringUtil.printMsg("정산시기 setString ", r_pay_pre, this);
					StringUtil.printMsg("정산담담 setString", r_pay_saup, this);
					StringUtil.printMsg("방북목적 setString", r_north_purpose, this);
					StringUtil.printMsg("편집상태 setString ", v_edit_styatus, this);
					StringUtil.printMsg("v_send_id setString ", v_send_id, this);
				    */
				    cstmt.setInt	(v_row, v_accept_sid);						//신청서SID
					cstmt.registerOutParameter(v_row++, java.sql.Types.DECIMAL);
					cstmt.setString (v_row, v_accept_no);						//신청서NO
					cstmt.registerOutParameter(v_row++, OracleTypes.VARCHAR);
					cstmt.setString (v_row++, v_depart_date);					//출발일자
					cstmt.setInt	(v_row++, v_goods_sid);						//상품SID
					cstmt.setInt	(v_row++, v_client_sid);					//매출처SID
					cstmt.setInt	(v_row++, v_event_sid);						//단체행사SID
					cstmt.setString (v_row++, "1");								//작업구분[RM013] 관광예약/방북신청
					cstmt.setInt	(v_row, r_rsv_sid);							//예약SID
					cstmt.registerOutParameter(v_row++, java.sql.Types.DECIMAL);//예약SID
					cstmt.setInt	(v_row, v_m_rsv_sid);						//메인예약SID
					cstmt.registerOutParameter(v_row++, java.sql.Types.DECIMAL);//메인예약SID
					cstmt.setInt	(v_row++, v_roomType);						//객실SID
					cstmt.setInt	(v_row, v_room_sid);						//룸SID
					cstmt.registerOutParameter(v_row++, java.sql.Types.DECIMAL);//룸SID
					cstmt.setInt	(v_row++, v_block_sid);						//블록SID
					cstmt.setString (v_row++, v_blockType);						//예약타입 -- 블록/일반
					cstmt.setString (v_row++, v_depart_time);					//출발시간
					cstmt.setInt	(v_row++, v_nights);						//박수
					cstmt.setString (v_row++, rows[i].getString(colNm_ArriveDate));					//복귀일자
					cstmt.setString (v_row++, rows[i].getString(colNm_ArriveTime));					//복귀시간
					cstmt.setInt	(v_row++, r_cust_sid);						//고객SID
					cstmt.setString (v_row++, "2");								//고객구분[CU001] 관광객(1)/사업자('2')
					cstmt.setString (v_row++, r_saup_gu);						//사업구분
					cstmt.setString (v_row++, r_cust_type);						//할인유형
					cstmt.setString (v_row++, r_age_cd);						//연령
					cstmt.setString (v_row++, r_join_cd);						//동숙코드[RV006] 본인/배우자/...
					cstmt.setString (v_row++, r_mobile_no);						//휴대전화번호
					cstmt.setString(v_row++, rows[i].getString(ds_cust.indexOfColumn("HOLD_EMPNO")));
					cstmt.setString (v_row++, "1");								//예약신청방법[RV020] CS/WEB/...
					cstmt.setString (v_row++, r_remark);							//비고
					cstmt.setString (v_row++, iParamEmpno);							//최종수정자사번
					cstmt.setString (v_row++, iParamIp);							//29 최종수정IP

					/*---할인상세 파라미터 추가 2007-0514 by 심동현--------------------------------*/
					cstmt.setString (v_row++, r_carowner_yn);						//30 자차여부
					cstmt.setString (v_row++, r_jeju_yn);							//31 제주여부
					cstmt.setString (v_row++, r_weekend_yn);						//32 주말여부
					cstmt.setString (v_row++, r_theme_cd);							//33 테마여부[RM018] 외금/내금/골프
		 			
					/*---할인상세 파라미터 추가 2007-0514 by 심동현--------------------------------*/
					cstmt.setInt (v_row++, v_bound_seq);							//34 상품순번	20090331 추가 심동현
					cstmt.setString (v_row++, r_pay_pre);							//35 정산시기	20100223 추가 심동현
					cstmt.setString (v_row++, r_pay_saup);							//36 정산담담	20100223 추가 심동현
					cstmt.setString (v_row++, r_north_purpose);						//37 방북목적	20100223 추가 심동현
					cstmt.setString (v_row++, v_edit_styatus);						//38 편집상태     1: INSERT, 2: DELETE, 3: UPDATE
					cstmt.setString (v_row++, v_send_id);							//39 프로시저 호출 ID (41, 42, 43)
					cstmt.registerOutParameter(v_row++, OracleTypes.VARCHAR);	//40 성공여부
					cstmt.registerOutParameter(v_row++, OracleTypes.VARCHAR);	//41 메세지 코드
					cstmt.registerOutParameter(v_row++, OracleTypes.VARCHAR);	//42 메세지
					
					cstmt.executeUpdate();
					
					v_accept_sid = cstmt.getBigDecimal(1).intValue();
					v_accept_no	 = cstmt.getString(2);
					r_rsv_sid	 = cstmt.getBigDecimal(8).intValue();
					v_m_rsv_sid	 = cstmt.getBigDecimal(9).intValue();
					v_room_sid	 = cstmt.getBigDecimal(11).intValue();
					r_s_yn		 = cstmt.getString(40);
					r_msg_cd	 = cstmt.getString(41);
					r_msg		 = cstmt.getString(42);					
					/*
					StringUtil.printMsg("v_accept_sid ", v_accept_sid, this);
					StringUtil.printMsg("v_accept_no ", v_accept_no, this);
					StringUtil.printMsg("r_rsv_sid ", r_rsv_sid, this);
					StringUtil.printMsg("v_m_rsv_sid ", v_m_rsv_sid, this);
					StringUtil.printMsg("v_room_sid ", v_room_sid, this);
					StringUtil.printMsg("r_s_yn ", r_s_yn, this);
					StringUtil.printMsg("r_msg_cd ", r_msg_cd, this);
					StringUtil.printMsg("r_msg ", r_msg, this);
					*/
					StringUtil.printMsg("r_s_yn ", r_s_yn, this);
					StringUtil.printMsg("r_msg_cd ", r_msg_cd, this);
					StringUtil.printMsg("r_msg ", r_msg, this);
					
					if(!r_s_yn.equals("Y"))
						throw new Exception (r_msg);
					if(ds_result!=null){
						ds_result.put("MANAGE_NO", r_manage_no, 20);
						ds_result.put("ACCEPT_SID", v_accept_sid, 10);
						ds_result.put("ACCEPT_NO", v_accept_no, 14);
						ds_result.put("RSV_SID", r_rsv_sid, 10);
						ds_result.put("M_RSV_SID", v_m_rsv_sid, 10);
						ds_result.put("ROOM_SID", v_room_sid, 10);
						ds_result.put("S_YN", 	r_s_yn, 1);//커서 OUT param.
						ds_result.put("MSG_CD", r_msg_cd, 4);//커서 OUT param.
						ds_result.put("MSG", 	r_msg, 200);//커서 OUT param.
						ds_result.heap();
					}
					if(cstmt!=null) cstmt.close();
				}
				if(ds_result!=null) gos.write(ds_result);
			}
			
			if(ds_option!=null){
				if(ds_option_result!=null){
					ds_option_result.addDataColumn(new GauceDataColumn("KEY_SEQ", GauceDataColumn.TB_NUMBER));
					ds_option_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
					ds_option_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
					ds_option_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
				}
				GauceDataRow[] rows = ds_option.getDataRows();
				for(int i=0; i<rows.length; i++){
					r_key_seq = rows[i].getInt(0);
					
					cstmt = conn.prepareCall(arr_sql[11].toString());
					cstmt.setInt        (1, v_rsv_sid);
					if(r_key_seq==0)
						cstmt.setInt	    (2, rows[i].getInt(0));
					else
						cstmt.setInt	    (2, r_key_seq);
					cstmt.setString     (3, v_depart_date);
					cstmt.setInt		(4, rows[i].getInt(1));
					cstmt.registerOutParameter(4, java.sql.Types.DECIMAL);
					cstmt.setString     (5, rows[i].getString(2).equals("T") ? "Y" : "N");
					cstmt.setString     (6, rows[i].getString(3).equals("T") ? "Y" : "N");
					cstmt.setInt		(7, rows[i].getInt(5));
					cstmt.setInt		(8, rows[i].getInt(6));
					cstmt.setString		(9, rows[i].getString(8));
					
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
						ds_option_result.put("KEY_SEQ", r_key_seq, 30);//커서 OUT param.
						ds_option_result.put("S_YN", 	r_s_yn, 1);//커서 OUT param.
						ds_option_result.put("MSG_CD", r_msg_cd, 4);//커서 OUT param.
						ds_option_result.put("MSG", 	r_msg, 200);//커서 OUT param.
						ds_option_result.heap();
						
					}
					if(cstmt!=null) cstmt.close();
				}
				if(ds_option_result!=null) gos.write(ds_option_result);
			}

			//룸 정보 변경
			if(ds_room_result!=null){
				if(ds_room_result!=null){
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
					ds_room_result.put("S_YN", 	r_s_yn, 1);//커서 OUT param.
					ds_room_result.put("MSG_CD", r_msg_cd, 4);//커서 OUT param.
					ds_room_result.put("MSG", 	r_msg, 200);//커서 OUT param.
					ds_room_result.heap();
				}
				if(ds_room_result!=null) gos.write(ds_room_result);
			}
			
			//판매가 계산 정보 저장
			if(ds_amt!=null){
				if(ds_amt_result!=null){
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
						throw new Exception (r_msg);
					//	res.writeException("ERROR", r_msg_cd, r_msg);
					}
					
					if(ds_amt_result!=null){
						ds_amt_result.put("S_YN", 	r_s_yn, 1);//커서 OUT param.
						ds_amt_result.put("MSG_CD", r_msg_cd, 4);//커서 OUT param.
						ds_amt_result.put("MSG", 	r_msg, 200);//커서 OUT param.
						ds_amt_result.heap();
					}
				}
				if(ds_amt_result!=null) gos.write(ds_amt_result);
			}


			if(ds_car!=null){	//차량 저장(2010-02-18)
				//StringUtil.printMsg("데이터셋  =" , ds_car.getName() , this);	//해당 데이터셋 이름 확인
				GauceDataRow[] 		rows = ds_car.getDataRows();
				
				int colNm_CarRsv_sid	= ds_car.indexOfColumn("CAR_RSV_SID");	/* 차량예약SID 0 */
				int colNm_AcceptSid     = ds_car.indexOfColumn("ACCEPT_SID");	/* 신청SID     1 */
				int colNm_CarSid        = ds_car.indexOfColumn("CAR_SID");		/* 차량 SID    2 */
				int colNm_DepartDate    = ds_car.indexOfColumn("DEPART_DATE");	/* 출경일자    3 */
				int colNm_DepartTime    = ds_car.indexOfColumn("DEPART_TIME");	/* 출경시간    4 */
				int colNm_ArriveDate    = ds_car.indexOfColumn("ARRIVE_DATE");	/* 입경일자    5 */
				int colNm_ArriveTime    = ds_car.indexOfColumn("ARRIVE_TIME");	/* 입경시간    6 */
				int colNm_Cargo         = ds_car.indexOfColumn("CARGO");		/* 화물        7 */
				int colNm_LongStayYn	= ds_car.indexOfColumn("LONG_STAY_YN");/* 장기체류유무8 */
				int colNm_CarDesc		= ds_car.indexOfColumn("CAR_DESC");	/* 차량참고사항9 */
				int colNm_ClintSid		= ds_car.indexOfColumn("CLIENT_SID");	/* 매출처SID   10*/
				int colNm_BoundSeq		= ds_car.indexOfColumn("BOUND_SEQ");	/* 상품순번	   11*/
				
				for(int i = 0; i < rows.length; i++) {
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_INSERT){
						v_edit_styatus = "1";
					} else if(rows[i].getJobType()==GauceDataRow.TB_JOB_DELETE) {
						v_edit_styatus = "2";
					} if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
						v_edit_styatus = "3";
					}

					cstmt = conn.prepareCall(arr_sql[16].toString());
						
					cstmt.setInt(1, rows[i].getInt(colNm_CarRsv_sid));	// 차량예약 SID
					cstmt.registerOutParameter(1, java.sql.Types.DECIMAL);			
					cstmt.setLong(2, rows[i].getInt(colNm_AcceptSid));	// 신청 SID
					cstmt.setInt(3, rows[i].getInt(colNm_CarSid));		// 차량 SID
					cstmt.setString(4, rows[i].getString(colNm_DepartDate));	// 출경일자 
					cstmt.setString(5, rows[i].getString(colNm_DepartTime));	// 출경시간
					cstmt.setString(6, rows[i].getString(colNm_ArriveDate));	// 입경일자 
					cstmt.setString(7, rows[i].getString(colNm_ArriveTime));	// 입경시간
					cstmt.setString(8, rows[i].getString(colNm_Cargo));			// 화물        7
					cstmt.setString(9, rows[i].getString(colNm_LongStayYn)); // 장기체류유무8
					cstmt.setString(10, rows[i].getString(colNm_CarDesc));// 차량참고사항9
					cstmt.setInt(11, rows[i].getInt(colNm_ClintSid));			// 매출처SID
					cstmt.setInt(12, rows[i].getInt(colNm_BoundSeq));			// 상품순번	   11
					cstmt.setString(13, fParamEmpno);
					cstmt.setString(14, fParamIp);
					cstmt.setString(15, v_edit_styatus); 						//편집상태    14 1: INSERT, 2: DELETE, 3: UPDATE
					cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
						
					// 쿼리실행
					cstmt.executeUpdate();
					r_s_yn 		= cstmt.getString(16);	// 성공Y/N	   15
					r_msg_cd 	= cstmt.getString(17);	// 메세지 코드 16
					r_msg 		= cstmt.getString(18);	// 메세지  	   17

					// 에러코드 가 있는경우 
					if("N".equals(r_s_yn)) 
						throw new Exception (r_msg);
					// 에러메시지 표시
					if(ds_result!=null){
						ds_result.put("S_YN", 	r_s_yn, 1);//커서 OUT param.
						ds_result.put("MSG_CD", r_msg_cd, 4);//커서 OUT param.
						ds_result.put("MSG", 	r_msg, 200);//커서 OUT param.
						ds_result.heap();
					}
				}
				if(ds_result!=null) gos.write(ds_result);
			}

		} catch (SQLException sqle){
			((HttpGauceResponse) gres).addException(
					new GauceException("SrvERROR", sqle.getErrorCode()+"", sqle.getMessage())
			);

			throw sqle;
		} catch (Exception e) {
			gres.addException(e);
			((HttpGauceResponse) gres).addException(
					new GauceException("SrvERROR", "9010", e.toString())
			);
			throw e;
		} finally {
			gos.close();
			if(cstmt!=null) cstmt.close();
		//if( fail == true ) throw new Exception("");			
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
					row.addColumnValue(rs.getString(columnName[i])==null ? null : rs.getString(columnName[i]).trim());
					if(v_rowcnt==0) {
						pt.setProperty(columnName[i], rs.getString(columnName[i])==null ? null : rs.getString(columnName[i]).trim());
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
