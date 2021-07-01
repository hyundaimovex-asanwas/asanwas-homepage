package sales.menu.help;

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

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Rv005H extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
        for(int i=0; i<arr_sql.length; i++)
            arr_sql[i] = new StringBuffer();

        
		// TODO Auto-generated method stub
		
		//상품권번호에 해당하는 매수 및 금액 산출
		arr_sql[0].append ("SELECT COUNT(*)       AS PAY_QTY			/* 매수 */                           	\n")
				  .append ("    ,SUM(T1.AMT)/1000 AS PAY_AMT			/* 건수 */                           	\n")
				  .append ("FROM SALES.TAC070 T1                                                        \n")
				  .append ("WHERE T1.GIFT_STATE    = '6'			/* 상품권상태 :AC004 6:판매*/        	\n")
//				  .append ("  AND T1.EFFICACY_DAY  >= TO_CHAR(CURRENT_DATE,'YYYYMMDD') 	        	\n")
				  .append ("  AND T1.GIFT_TYPE     = ?				/* 상품권권종 */                     	\n")
				  .append ("  AND T1.GIFT_SEQ BETWEEN ? AND ?											\n");
		
		//상품권번호에 해당하는 내역조회
		arr_sql[1].append ("SELECT 																							\n")
				  .append ("       T1.GIFT_TYPE||'-'||T1.GIFT_SEQ              AS GIFT_SEQ        /* 상품권 일련번호   */   \n")
				  .append ("      ,SALES.FN_DETAIL_NM ('AC004',T1.GIFT_STATE)  AS GIFT_STATE      /* 상품권상태 :AC004 */   \n")
				  .append ("      ,T1.EFFICACY_DAY                             AS EFFICACY_DAY    /* 유효기간          */   \n")
				  .append ("      ,CEIL(CEIL(T1.AMT)/1000)                     AS PAY_AMT         /* 금액              */   \n")
				  .append (" FROM SALES.TAC070 T1                                                                           \n")
				  .append ("WHERE T1.GIFT_TYPE     = ? 											                            \n")
				  .append ("  AND T1.GIFT_STATE    = '6'							/* 상품권상태 :AC004 6:판매*/        	\n")
				  .append ("  AND T1.GIFT_SEQ BETWEEN ? AND ?													        \n");

		//상품권Master 저장
		arr_sql[2].append ("INSERT INTO SALES.TRV230											\n")
				  .append ("(GIFT_CD, PAY_DATE, PAY_QTY, PAY_AMT, U_EMPNO, U_DATE, U_IP )       \n")
				  .append ("VALUES (?, TO_CHAR(CURRENT_DATE,'YYYYMMDD'), ?, ?, ?, SYSTIMESTAMP, ?)                        \n");

		//상품권Detail 저장
		arr_sql[3].append ("INSERT INTO SALES.TRV231                                            \n")
				  .append ("(GIFT_CD, GIFT_TYPE, FR_GIFT_SEQ, TO_GIFT_SEQ, PAY_QTY, PAY_AMT,    \n")
				  .append ("	U_EMPNO, U_DATE, U_IP)                                          \n")
				  .append ("VALUES (?, ?, ?, ?, ?, ?, ?, SYSTIMESTAMP, ?)                  \n");

		//상품권이력정보 저장
		arr_sql[4].append ("UPDATE SALES.TAC070												 \n")
				  .append ("   SET GIFT_STATE   = '7'                                        \n")
				  .append ("       , BACK_DATE    = TO_CHAR(CURRENT_DATE,'YYYYMMDD') 			\n")
				  .append ("       , BACK_EMPNO   = ?                                        \n")
				  .append ("       , BACK_AMT     = AMT                                      \n")
				  .append ("       , BACK_GU      = 'Y'                                      \n")
				  .append ("       , BACK_VEND_CD = ?                                        \n")
				  .append ("WHERE  GIFT_STATE   = '6'                                        \n")
		//		  .append ("  AND  EFFICACY_DAY >= TO_CHAR(CURRENT_DATE,'YYYYMMDD') \n")
				  .append ("  AND  GIFT_TYPE    = ?                                          \n")
				  .append ("  AND  GIFT_SEQ     BETWEEN ? AND ?                              \n");

		//결재 관리번호 채번
		arr_sql[5].append ("{CALL SALES.PR_PAY_MANAGE_NO_ALL(?,?,?,?,?)}");
		
		//카드결제 조회
		arr_sql[6].append ("SELECT																	\n")
				  .append ("	PAY_MANAGE_NO, 	PAY_CD, 								            \n")
				  .append ("	PAY_AMT, 		CARD_NO, 		VALID_TERMS, 	HALBU_TERMS,        \n")
				  .append ("	TERMINAL_YN,	CARD_WAY_CD, 	VAN_CD, 		VAN_IDX_NO,         \n")
				  .append ("	TERMINAL_ID,	CARD_JOIN_NO, 	AGREE_YN, 		AGREE_TIME,         \n")
				  .append ("	AGREE_NO,		ORG_AGREE_DATE, CARD_COMPANY_NM,ISSUE_COMPANY_CD,	\n")
				  .append ("	ISSUE_COMPANY_NM, CLIENT_SID									    \n")
				  .append ("FROM SALES.TRV220                                                       \n")
				  .append (" WHERE  card_sid=0                                                      \n");
		
		//가상계좌 및 계좌이체 조회
		arr_sql[7].append ("SELECT                                                                  \n")
				  .append ("	PAY_MANAGE_NO,	PAY_CD,									            \n")
				  .append ("	ORDER_NM,		ORDER_TEL_NO,	ORDER_E_MAIL,	PAY_AMT,            \n")
				  .append ("	TERMINAL_ID,	VAN_IDX_NO,		ACCT_JOIN_NO,	AGREE_TIME,			\n")
				  .append ("	AGREE_CUST_NM,  AGREE_AMT,		BANK_CD,		BANK_NM,			\n")
				  .append ("	BANK_ACCT, 		CLIENT_SID											\n")
				  .append ("  FROM SALES.TRV210                                                     \n")
				  .append (" WHERE virtual_sid=0                                                    \n");

		//신용카드 결제 인서트
		arr_sql[8].append ("INSERT INTO SALES.TRV220  												\n")
				  .append ("(	CARD_SID, PAY_MANAGE_NO, 	PAY_CD, 		PAY_DATE, 		PAY_TIME,           \n")
				  .append ("	PAY_AMT, 		CARD_NO, 		VALID_TERMS, 	HALBU_TERMS,        \n")
				  .append ("	TERMINAL_YN,	CARD_WAY_CD, 	VAN_CD, 		VAN_IDX_NO,         \n")
				  .append ("	TERMINAL_ID,	CARD_JOIN_NO, 	AGREE_YN, 		AGREE_TIME,         \n")
				  .append ("	AGREE_NO,		ORG_AGREE_DATE, CARD_COMPANY_NM,ISSUE_COMPANY_CD,	\n")
				  .append ("	ISSUE_COMPANY_NM, CLIENT_SID,										\n")
				  .append ("	U_EMPNO,		U_DATE,			U_IP							 	\n")
				  .append (") VALUES (sales.SWS_TRV220_ID.nextVal, ?, 		?, 				TO_CHAR(CURRENT_DATE,'YYYYMMDD'), TO_CHAR(CURRENT_DATE,'HH24MI'),\n")
				  .append ("	?,				?,				?,				?,					\n")
				  .append ("	?,				?,				?,				?,					\n")
				  .append ("	?,				?,				?,				?,					\n")
				  .append ("	?,				?,				?,				?,					\n")
				  .append ("	?,				?,													\n")
				  .append ("	?,				SYSTIMESTAMP,				?)					\n");
		
		//가상계좌
		arr_sql[9].append ("INSERT INTO SALES.TRV210  												\n")
				  .append ("(	virtual_sid, PAY_MANAGE_NO,	PAY_CD,			PAY_DATE,		PAY_TIME,           \n")
				  .append ("	ORDER_NM,		ORDER_TEL_NO,	ORDER_E_MAIL,	PAY_AMT,            \n")
				  .append ("	TERMINAL_ID,	VAN_IDX_NO,		ACCT_JOIN_NO,	AGREE_TIME,			\n")
				  .append ("	AGREE_CUST_NM,  AGREE_AMT,		BANK_CD,		BANK_NM,			\n")
				  .append ("	BANK_ACCT,		CLIENT_SID,		U_EMPNO,		U_DATE,			U_IP\n")
				  .append (") VALUES (sales.SWS_TRV210_ID.nextVal,   ?, 	?,	TO_CHAR(CURRENT_DATE,'YYYYMMDD'), TO_CHAR(CURRENT_DATE,'HH24MI'),\n")
				  .append ("	?,				?,				?,				?,					\n")
				  .append ("	?,				?,				?,				?,					\n")
				  .append ("	?,				?,				?,				?,					\n")
				  .append ("	?,				?,				?,		SYSTIMESTAMP,	?)		\n");
		
		arr_sql[10].append("SELECT S_ISSUE_COMPANY_NM ISSUE_COMPANY_NM,			\n")
				  .append ("       S_CARD_COMPANY_NM CARD_COMPANY_NM,			\n")
				  .append ("       S_RESP_MSG1 RESP_MSG							\n")
				  .append ("FROM SALES.LOG_EDI									\n")
				  .append ("WHERE C_PAY_MANAGE_NO = ?							\n");

		arr_sql[11].append("SELECT R_ORDER_NM ORDER_NM,							\n")
				  .append ("       S_ORDER_NM AGREE_CUST_NM,					\n")
				  .append ("       R_BANK_NAME BANK_NM,							\n")
				  .append ("       S_RESP_MSG1 RESP_MSG							\n")
				  .append ("FROM SALES.LOG_CASH									\n")
				  .append ("WHERE C_PAY_MANAGE_NO = ?							\n");

		arr_sql[12].append("UPDATE SALES.TRV200 								\n")
				  .append ("   SET PAY_DATE = TO_CHAR(CURRENT_DATE,'YYYYMMDD'),	\n")
				  .append ("	   PAY_YN = 'Y'									\n")
				  .append (" WHERE PAY_MANAGE_NO = ?							\n");

		arr_sql[13].append("UPDATE SALES.TRV210 								\n")
				  .append ("   SET PAY_DATE = TO_CHAR(CURRENT_DATE,'YYYYMMDD'),	\n")
				  .append ("	   AGREE_AMT = ?,								\n")
				  .append ("	   PAY_YN = 'Y'									\n")
				  .append (" WHERE PAY_MANAGE_NO = ?							\n");
		
		//기타대체 처리
		arr_sql[15].append("SELECT PAY_MANAGE_NO, PAY_CD, ACC_CD, \n")
				  .append("		PAY_DATE, PAY_EMPNMK, PAY_AMT, CLIENT_SID		\n")
				  .append("   FROM SALES.TRV250			\n")
				  .append (" WHERE acc_sid=0                                    \n");
		arr_sql[16].append ("INSERT INTO SALES.TRV250 (					\n")
				  .append  ("	 acc_sid, PAY_MANAGE_NO , PAY_CD        ,ACC_CD   \n")     
				  .append  ("	,PAY_DATE      ,PAY_EMPNMK    ,PAY_AMT, CLIENT_SID  \n")     
				  .append  ("	,U_EMPNO       ,U_DATE        ,U_IP     \n")     
				  .append  (") VALUES                                   \n")
				  .append  ("(sales.SWS_TRV250_ID.nextVal, ?, ?, ?, ?, ?, ?, ?, ?, SYSTIMESTAMP, ?)                \n");

		
		//무통장 따로 2007-01-03 심동현 (입금일자때문에)
		arr_sql[17].append ("INSERT INTO SALES.TRV210  												\n")
		  .append ("(	VIRTUAL_SID,     PAY_MANAGE_NO,	PAY_CD,			PAY_DATE,		PAY_TIME,           \n")
		  .append ("	ORDER_NM,		ORDER_TEL_NO,	ORDER_E_MAIL,	PAY_AMT,            \n")
		  .append ("	TERMINAL_ID,	VAN_IDX_NO,		ACCT_JOIN_NO,	AGREE_TIME,			\n")
		  .append ("	AGREE_CUST_NM,  AGREE_AMT,		BANK_CD,		BANK_NM,			\n")
		  .append ("	BANK_ACCT,		CLIENT_SID,		U_EMPNO,		U_DATE,			U_IP,	TR_SID \n")
		  .append (") VALUES (sales.SWS_TRV210_ID.nextVal,	?, 		?, 		?,      TO_CHAR(CURRENT_DATE,'HH24MI'), \n")
		  .append ("	?,				?,				?,				?,					\n")
		  .append ("	?,				?,				?,				?,					\n")
		  .append ("	?,				?,				?,				?,					\n")
		  .append ("	?,				?,				?,		SYSTIMESTAMP,		?,			?)	\n");

		//상품권 20140121 심동현
		arr_sql[18].append("select GIFT_TYPE, FR_GIFT_SEQ, TO_GIFT_SEQ,PAY_QTY, PAY_AMT ,GIFT_CD \n")
				  .append("   FROM SALES.TRV231			\n")
				  .append (" WHERE gift_type='0'                                    \n");
		
	}

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		try{
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
			

            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:CARD=ds_card,O:ACCOUNT=ds_account,O:NOACCOUNT=ds_noaccount,O:TONGJANG=ds_tongjang,O:ETC=ds_etc,O:GIFT=ds_gift)",            
            	if(dSets[i].getName().equals("ds_card")){
					GauceDataSet ds1 = gis.read("CARD");
					cstmt = conn.prepareCall(arr_sql[6].toString());
					rs=cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds_account")){
					GauceDataSet ds1 = gis.read("ACCOUNT");
					cstmt = conn.prepareCall(arr_sql[7].toString());
					rs=cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds_noaccount")){
					GauceDataSet ds1 = gis.read("NOACCOUNT");
					cstmt = conn.prepareCall(arr_sql[7].toString());
					rs=cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds_tongjang")){
					GauceDataSet ds1 = gis.read("TONGJANG");
					cstmt = conn.prepareCall(arr_sql[7].toString());
					rs=cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds_etc")){
					GauceDataSet ds1 = gis.read("ETC");
					cstmt = conn.prepareCall(arr_sql[15].toString());
					rs=cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds_gift")){
					GauceDataSet ds1 = gis.read("GIFT");
					cstmt = conn.prepareCall(arr_sql[18].toString());
					rs=cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}            	
            }
					/* if(gauceName.equals("GIFT")){
						ds1.addDataColumn(new GauceDataColumn("GIFT_TYPE", 		GauceDataColumn.TB_STRING, 50));
						ds1.addDataColumn(new GauceDataColumn("FR_GIFT_SEQ", 	GauceDataColumn.TB_STRING, 50));
						ds1.addDataColumn(new GauceDataColumn("TO_GIFT_SEQ", 	GauceDataColumn.TB_STRING, 50));
						ds1.addDataColumn(new GauceDataColumn("PAY_QTY", 		GauceDataColumn.TB_NUMBER));
						ds1.addDataColumn(new GauceDataColumn("PAY_AMT", 		GauceDataColumn.TB_NUMBER));
						ds1.flush();
					}*/
					
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		} catch (Exception e) {
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

		//상품권 리스트에 필요한 입력 파라미터 정의
		String v_gift_type 		= HDUtil.nullCheckStr(greq.getParameter("v_gift_type"));
		String v_fr_gift_seq 	= HDUtil.nullCheckStr(greq.getParameter("v_fr_gift_seq"));
		String v_to_gift_seq 	= HDUtil.nullCheckStr(greq.getParameter("v_to_gift_seq"));
		String v_client_cd 		= HDUtil.nullCheckStr(greq.getParameter("v_client_cd"));
		String v_pay_manage_no	= HDUtil.nullCheckStr(greq.getParameter("v_pay_manage_no"));			

		StringUtil.printMsg(" v_gift_type ",v_gift_type,this);
		StringUtil.printMsg(" v_fr_gift_seq ",v_fr_gift_seq,this);
		StringUtil.printMsg(" v_to_gift_seq ",v_to_gift_seq,this);
		
		//결제관리번호 취득에 필요
		String v_pay_cd 		= HDUtil.nullCheckStr(greq.getParameter("v_pay_cd"));
		int    v_pay_amt	 	= HDUtil.nullCheckNum(greq.getParameter("v_pay_amt"));

		try{
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
            
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//"JSP(O:GIFTAMT=ds_giftAmt,O:GIFTLIST=ds_giftList)",
            	//"JSP(O:CARD_TEMP=ds_card_temp)","JSP(O:NOACCOUNT_TEMP=ds_noaccount_temp)","JSP(O:ACCOUNT_TEMP=ds_account_temp)",
            	//"JSP(O:PAY_MANAGE_NO=ds_manage_no)" 이건 결제관리번호를 따서 전달하는 것
            	
            	if(dSets[i].getName().equals("ds_giftAmt")){
					GauceDataSet ds1 = gis.read("GIFTAMT");
					StringUtil.printMsg(" arr_sql[0].toString() ",arr_sql[0].toString(),this);
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, v_gift_type);
					cstmt.setString(2, v_fr_gift_seq);
					cstmt.setString(3, v_to_gift_seq);
					rs=cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds_giftList")){
					GauceDataSet ds1 = gis.read("GIFTLIST");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, v_gift_type);
					cstmt.setString(2, v_fr_gift_seq);
					cstmt.setString(3, v_to_gift_seq);
					rs=cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds_manage_no")){
					GauceDataSet ds1 = gis.read("PAY_MANAGE_NO");
					ds1.addDataColumn(new GauceDataColumn("PAY_MANAGE_NO", GauceDataColumn.TB_STRING));
										
					//StringUtil.printMsg("결제금액==",v_pay_amt,this);
					//StringUtil.printMsg("결제코드==",v_pay_cd,this);
					//StringUtil.printMsg("최종수정자사번==",fParamEmpno,this);
					
					
					cstmt = conn.prepareCall(arr_sql[5].toString());
					cstmt.registerOutParameter(1, OracleTypes.VARCHAR);	//결과를 받을
					cstmt.setInt(2, v_pay_amt);	//결제금액
					cstmt.setString(3, v_pay_cd);	//결제코드: AC001. 010현금, 020가상,030이체,040카드,050인터넷카,060상품권, 070외상,080무통, 090대체,100보증금대체,110보증금환불,120온라인다이렉트,130카드단말
					cstmt.setString(4, "01");	//영업매출구분: PU001. 01관광요금, 02현지매출, 03유통
					cstmt.setString(5, fParamEmpno);	//최종수정자사번
					cstmt.executeQuery();
					//cstmt.getObject(1);	 	
					ds1.put("PAY_MANAGE_NO", (String)cstmt.getObject(1), 20);//커서 OUT param.
					ds1.heap();
					gos.write(ds1);
					//StringUtil.printMsg("결제관리번호","heap",this);
				}
            	if(dSets[i].getName().equals("ds_card_temp")){
					GauceDataSet ds1 = gis.read("CARD_TEMP");
					cstmt = conn.prepareCall(arr_sql[10].toString());
					cstmt.setString(1, v_pay_manage_no);
					rs=cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds_account_temp")){
					GauceDataSet ds1 = gis.read("ACCOUNT_TEMP");
					cstmt = conn.prepareCall(arr_sql[11].toString());
					cstmt.setString(1, v_pay_manage_no);
					rs=cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds_noaccount_temp")){
					GauceDataSet ds1 = gis.read("NOACCOUNT_TEMP");
					cstmt = conn.prepareCall(arr_sql[11].toString());
					cstmt.setString(1, v_pay_manage_no);
					rs=cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}            	
            	
            }
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("# Command","저장",this);
		CallableStatement cstmt = null;	
		ResultSet 			rs 			= null;
		
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
				
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        

		int    v_pay_amt	 	= HDUtil.nullCheckNum(greq.getParameter("v_pay_amt"));
		int    v_agree_amt	 	= 0;
		int    v_gift_qty	 	= HDUtil.nullCheckNum(greq.getParameter("v_gift_qty"));
		String v_pay_manage_no 	= HDUtil.nullCheckStr(greq.getParameter("v_pay_manage_no"));
		String v_pay_cd 		= HDUtil.nullCheckStr(greq.getParameter("v_pay_cd"));
		String v_pay_date 		= HDUtil.nullCheckStr(greq.getParameter("v_pay_date"));
		String v_pay_time 		= HDUtil.nullCheckStr(greq.getParameter("v_pay_time"));
		int    v_client_sid 	= HDUtil.nullCheckNum(greq.getParameter("v_client_sid"));
		String v_client_cd 		= HDUtil.nullCheckStr(greq.getParameter("v_client_cd"));
		String v_order_tel_no 	= "";
		String v_order_e_mail 	= "";
		String v_terminal_id 	= "";
		String v_van_idx_no		= "";
		String v_acct_join_no	= "";
		String v_agree_time 	= "";
		String v_agree_cust_nm	= "";
		
		/* DataSet */
		GauceDataSet ds_tongjang = gis.read("TONGJANG");
		GauceDataSet ds_card = gis.read("CARD");
		GauceDataSet ds_account = gis.read("ACCOUNT");
		GauceDataSet ds_noaccount = gis.read("NOACCOUNT");
		GauceDataSet ds_etc = gis.read("ETC");
		GauceDataSet ds_gift = gis.read("GIFT");
		GauceDataSet ds_master = gis.read("NOACCOUNT_REPLY");

		
		try{
			// 신용카드 I: CARD=ds_card)",
			if (ds_card != null) {
				GauceDataRow[] 		rows = ds_card.getDataRows();
				GauceDataColumn[] 	cols = ds_card.getDataColumns();
				
			  	for(int i=0; i<rows.length; i++){
			  		cstmt = conn.prepareCall(arr_sql[8].toString());
					StringUtil.printMsg("신용카드 ","저장",this);
			  		cstmt.setString(1, rows[i].getString(0));		//PAY_MANAGE_NO 
			  		cstmt.setString(2, rows[i].getString(1));		//PAY_CD
					if(rows[i].getString(ds_card.indexOfColumn("AGREE_YN")).equals("N")){
						cstmt.setInt(3, rows[i].getInt(2)*(-1) );	//PAY_AMT
					} else {
						cstmt.setInt(3, rows[i].getInt(2));			//PAY_AMT
					}
			  		cstmt.setString(4, rows[i].getString(3));		//card_no  
			  		cstmt.setString(5, rows[i].getString(4));		//VALID_TERMS  
			  		cstmt.setString(6, rows[i].getString(5));		//HALBU_TERMS       
			  		cstmt.setString(7, rows[i].getString(6));		//TERMINAL_YN   
			  		cstmt.setString(8, rows[i].getString(7));		//CARD_WAY_CD
			  		cstmt.setString(9, rows[i].getString(8));		//VAN_CD
			  		cstmt.setString(10, rows[i].getString(9));		//VAN_IDX_NO
			  		cstmt.setString(11, rows[i].getString(10));		//TERMINAL_ID
			  		cstmt.setString(12, rows[i].getString(11));		//CARD_JOIN_NO    
			  		cstmt.setString(13, rows[i].getString(12));		//AGREE_YN
			  		cstmt.setString(14, rows[i].getString(13));		//AGREE_TIME 
			  		cstmt.setString(15, rows[i].getString(14));		//AGREE_NO     
			  		cstmt.setString(16, rows[i].getString(15));		//ORG_AGREE_DATE       
			  		cstmt.setString(17, rows[i].getString(16));		//CARD_COMPANY_NM       
			  		cstmt.setString(18, rows[i].getString(17));		//ISSUE_COMPANY_CD     
			  		cstmt.setString(19, rows[i].getString(18));		//ISSUE_COMPANY_NM    
			  		cstmt.setInt(20, rows[i].getInt(19));			//CLIENT_SID
					cstmt.setString(21, fParamEmpno);
					cstmt.setString(22, fParamIp);

					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();
				}
			}

			
			//가상계좌 ACCOUNT=ds_account
			if (ds_account != null) {
				GauceDataRow[] 		rows = ds_account.getDataRows();
				GauceDataColumn[] 	cols = ds_account.getDataColumns();
				
			  	for(int i=0; i<rows.length; i++){
			  		cstmt = conn.prepareCall(arr_sql[9].toString());
			  		cstmt.setString(1, rows[i].getString(0));		//PAY_MANAGE_NO 
			  		cstmt.setString(2, rows[i].getString(1));		//PAY_CD
					cstmt.setString(3, rows[i].getString(2));		//PAY_DATE					
					cstmt.setString(4, rows[i].getString(3));		//PAY_TIME
					cstmt.setString(5, rows[i].getString(4));		//ORDER_NM  
					cstmt.setString(6, rows[i].getString(5));		//ORDER_TEL_NO  
					cstmt.setString(7, rows[i].getString(6));		//ORDER_E_MAIL       
					cstmt.setInt(8, rows[i].getInt(7));				//PAY_AMT   
					cstmt.setString(9, rows[i].getString(8));		//TERMINAL_ID    
					cstmt.setString(10, rows[i].getString(9));		//VAN_IDX_NO	  
					cstmt.setString(11, rows[i].getString(10));		//ACCT_JOIN_NO    
					cstmt.setString(12, rows[i].getString(11));		//AGREE_TIME 
					cstmt.setString(13, rows[i].getString(12));		//AGREE_CUST_NM     
					cstmt.setInt(14, rows[i].getInt(13));			//AGREE_AMT       
					cstmt.setString(15, rows[i].getString(14));		//BANK_CD       
					cstmt.setString(16, rows[i].getString(15));		//BANK_NM     
					cstmt.setString(17, rows[i].getString(16));		//BANK_ACCT    
					cstmt.setInt(18, rows[i].getInt(17));			//CLIENT_SID
					cstmt.setString(19, fParamEmpno);
					cstmt.setString(20, fParamIp);
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();
				}				
			}
			//가상계좌 :NOACCOUNT=ds_noaccount
			if (ds_noaccount != null) {
				GauceDataRow[] 		rows = ds_noaccount.getDataRows();
				GauceDataColumn[] 	cols = ds_noaccount.getDataColumns();
				
			  	for(int i=0; i<rows.length; i++){
			  		cstmt = conn.prepareCall(arr_sql[9].toString());
			  		cstmt.setString(1, rows[i].getString(0));		//PAY_MANAGE_NO 
			  		cstmt.setString(2, rows[i].getString(1));		//PAY_CD
					cstmt.setString(3, rows[i].getString(2));		//PAY_DATE					
					cstmt.setString(4, rows[i].getString(3));		//PAY_TIME
					cstmt.setString(5, rows[i].getString(4));		//ORDER_NM  
					cstmt.setString(6, rows[i].getString(5));		//ORDER_TEL_NO  
					cstmt.setString(7, rows[i].getString(6));		//ORDER_E_MAIL       
					cstmt.setInt(8, rows[i].getInt(7));				//PAY_AMT   
					cstmt.setString(9, rows[i].getString(8));		//TERMINAL_ID    
					cstmt.setString(10, rows[i].getString(9));		//VAN_IDX_NO	  
					cstmt.setString(11, rows[i].getString(10));		//ACCT_JOIN_NO    
					cstmt.setString(12, rows[i].getString(11));		//AGREE_TIME 
					cstmt.setString(13, rows[i].getString(12));		//AGREE_CUST_NM     
					cstmt.setInt(14, rows[i].getInt(13));			//AGREE_AMT       
					cstmt.setString(15, rows[i].getString(14));		//BANK_CD       
					cstmt.setString(16, rows[i].getString(15));		//BANK_NM     
					cstmt.setString(17, rows[i].getString(16));		//BANK_ACCT    
					cstmt.setInt(18, rows[i].getInt(17));			//CLIENT_SID
					cstmt.setString(19, fParamEmpno);
					cstmt.setString(20, fParamIp);
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();
				}				
			}
			//기타대체	I:ETC=ds_etc
			if (ds_etc != null ) {
				GauceDataRow[] 		rows = ds_etc.getDataRows();
				GauceDataColumn[] 	cols = ds_etc.getDataColumns();
				
			  	for(int i=0; i<rows.length; i++){
			  		cstmt = conn.prepareCall(arr_sql[16].toString());
			  		cstmt.setString(1, rows[i].getString(0));		//PAY_MANAGE_NO 
			  		cstmt.setString(2, rows[i].getString(1));		//PAY_CD
					cstmt.setString(3, rows[i].getString(2));		//ACC_CD					
					cstmt.setString(4, rows[i].getString(3));		//PAY_DATE
					cstmt.setString(5, rows[i].getString(4));		//PAY_EMPNMK  
					cstmt.setInt(6, rows[i].getInt(5));				//PAY_AMT   
					cstmt.setInt(7, rows[i].getInt(6));				//CLIENT_SID
					cstmt.setString(8, fParamEmpno);
					cstmt.setString(9, fParamIp);
					
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();
				}				
			}
			

			//상품권 I:GIFT=ds_gift
			if (ds_gift != null ) {
				GauceDataRow[] 		rows = ds_gift.getDataRows();
				GauceDataColumn[] 	cols = ds_gift.getDataColumns();
				for(int i=0; i<rows.length; i++){
					if(i==0){
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setString(1, v_pay_manage_no);
						cstmt.setInt(2, v_gift_qty);
						cstmt.setInt(3, v_pay_amt);
						cstmt.setString(4, fParamEmpno);
						cstmt.setString(5, fParamIp);
						cstmt.executeUpdate();
						if(cstmt!=null) cstmt.close();
					}
					cstmt = conn.prepareCall(arr_sql[3].toString());
					cstmt.setString(1, v_pay_manage_no);
					cstmt.setString(2, rows[i].getString(0));	//GIFT_TYPE
					cstmt.setString(3, rows[i].getString(1));	//FR_GIFT_SEQ
					cstmt.setString(4, rows[i].getString(2));	//TO_GIFT_SEQ
					cstmt.setInt(5, rows[i].getInt(3));			//PAY_QTY
					cstmt.setInt(6, rows[i].getInt(4)*1000);	//PAY_AMT
					cstmt.setString(7, fParamEmpno);
					cstmt.setString(8, fParamIp);
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();
	
					cstmt = conn.prepareCall(arr_sql[4].toString());
					cstmt.setString(1, fParamEmpno);
					cstmt.setString(2, v_client_cd);
					cstmt.setString(3, rows[i].getString(0));
					cstmt.setString(4, rows[i].getString(1));
					cstmt.setString(5, rows[i].getString(2));
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();
				}
			}			
			
			
			//무통장인 경우I:TONGJANG=ds_tongjang
			if (ds_tongjang != null) {
				GauceDataRow[] 		rows = ds_tongjang.getDataRows();
				GauceDataColumn[] 	cols = ds_tongjang.getDataColumns();
				
				/*int colNm_SiteNm	  		        = ds_tongjang.indexOfColumn("site_nm");
				int colNm_OrdererNm                 = ds_tongjang.indexOfColumn("orderer_nm");
				int colNm_SiteSid  		            = ds_tongjang.indexOfColumn("site_sid");
				int colNm_SiteJoint              	= ds_tongjang.indexOfColumn("site_joint");
				int colNm_SiteMain              	= ds_tongjang.indexOfColumn("site_main");
				int colNm_SiteAttr1                	= ds_tongjang.indexOfColumn("site_attr1");
				int colNm_SiteAttr2                 = ds_tongjang.indexOfColumn("site_attr2");
				int colNm_OrdererSid                = ds_tongjang.indexOfColumn("orderer_sid");*/
			
				
				//StringUtil.printMsg("동현: 무통장", "start", this);
			  	for(int i=0; i<rows.length; i++){
				  /*						
				  StringUtil.printMsg("v_pay_manage_no", v_pay_manage_no, this);
				  StringUtil.printMsg("v_pay_cd", v_pay_cd, this);
				  StringUtil.printMsg("v_pay_date", v_pay_date, this);
				  StringUtil.printMsg("v_pay_time", v_pay_time, this);
				  StringUtil.printMsg("v_clent_sid", v_client_sid, this);
				  StringUtil.printMsg("v_pay_amt", v_pay_amt, this);
				  StringUtil.printMsg("row[i].getString(0)", rows[i].getString(0), this);
				  StringUtil.printMsg("row[i].getString(1)", rows[i].getString(1), this);
				  StringUtil.printMsg("row[i].getString(2)", rows[i].getString(2), this);
				  StringUtil.printMsg("row[i].getString(3)", rows[i].getString(3), this);
				  StringUtil.printMsg("row[i].getString(4)", rows[i].getString(4), this);
				  StringUtil.printMsg("row[i].getString(5)", rows[i].getString(5), this);
				  StringUtil.printMsg("row[i].getString(6)", rows[i].getString(6), this);
				  StringUtil.printMsg("row[i].getString(7)", rows[i].getString(7), this);
				  StringUtil.printMsg("row[i].getString(8)", rows[i].getString(8), this);
				  StringUtil.printMsg("row[i].getString(9)", rows[i].getString(9), this);
				  StringUtil.printMsg("row[i].getString(10)", rows[i].getString(10), this);
				  StringUtil.printMsg("row[i].getString(11)", rows[i].getString(11), this);
				  StringUtil.printMsg("쿼리==",arr_sql[17].toString(), this);
				  */
			  		cstmt = conn.prepareCall(arr_sql[17].toString());
					
					  cstmt.setString(1, v_pay_manage_no);			//PAY_MANAGE_NO 
					  cstmt.setString(2, v_pay_cd);					//PAY_CD
					  cstmt.setString(3, v_pay_date);				//PAY_DATE
					  cstmt.setString(4, rows[i].getString(4));		//ORDER_NM  
					  cstmt.setString(5, v_order_tel_no);			//ORDER_TEL_NO  
					  cstmt.setString(6, v_order_e_mail);			//ORDER_E_MAIL       
					  cstmt.setInt(7, v_pay_amt);					//PAY_AMT   
					  cstmt.setString(8, v_terminal_id);				//TERMINAL_ID    
					  cstmt.setString(9, v_van_idx_no);				//VAN_IDX_NO	  
					  cstmt.setString(10, v_acct_join_no);			//ACCT_JOIN_NO    
					  cstmt.setString(11, v_agree_time);				//AGREE_TIME 
					  cstmt.setString(12, v_agree_cust_nm);			//AGREE_CUST_NM     
					  cstmt.setInt(13, v_agree_amt);					//AGREE_AMT       
					  cstmt.setString(14, rows[i].getString(10));		//BANK_CD       
					  cstmt.setString(15, rows[i].getString(9));		//BANK_NM     
					  cstmt.setString(16, rows[i].getString(1));		//BANK_ACCT    
					  cstmt.setInt(17, v_client_sid);				//CLIENT_SID
					  cstmt.setString(18, fParamEmpno);
					  cstmt.setString(19, fParamIp);
					  cstmt.setString(20, rows[i].getString(11));			//TR_SID
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();
			  	}
			}
				
			// NOACCOUNT_REPLY=ds_master		@ rv005hs.jsp
			if (ds_master != null) {
				GauceDataRow[] 		rows = ds_master.getDataRows();
				GauceDataColumn[] 	cols = ds_master.getDataColumns();
				cstmt = conn.prepareCall(arr_sql[12].toString());
				cstmt.setString(1, v_pay_manage_no);
				cstmt.executeUpdate();
				if(cstmt!=null) cstmt.close();
				
				cstmt = conn.prepareCall(arr_sql[13].toString());
				cstmt.setInt(1, v_pay_amt);
				cstmt.setString(2, v_pay_manage_no);
				cstmt.executeUpdate();
				if(cstmt!=null) cstmt.close();
			}
						

			gos.close();
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
}
