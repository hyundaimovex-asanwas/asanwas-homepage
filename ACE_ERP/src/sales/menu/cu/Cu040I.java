package sales.menu.cu;

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


public class Cu040I extends SuperServlet {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		/*
		 * 공통코드 쿼리
		 * 대리점구분 : CU006
		 * 직판구분 : CU012
		 * 지역 : SY006
		 * 계약상태 : CU013
		 * 사용유무 : SY011
		 * 보증보험회사 : CU010
		 * 하위대리점여부 : CU011
		 */
		arr_sql[0].append ("SELECT										\n")
				  .append ("	' ' head, ' ' detail, '전체' detail_nm    \n")
				  .append ("FROM DUAL                       \n")
				  .append ("UNION ALL                                   \n")
				  .append ("SELECT                                      \n")
				  .append ("	B.head, B.detail, B.detail_nm           \n")
				  .append ("FROM                                        \n")
				  .append ("	SALES.TSY011 A,                         \n")
				  .append ("	SALES.TSY010 B                          \n")
				  .append ("WHERE 1=1                                   \n")
				  .append (" AND A.head = B.head                        \n")
				  .append (" AND B.head = ?                             \n")
				  .append (" AND LENGTH (rtrim(B.detail)) > 0                  \n");
		
		/*
		 * 대리점 조회
		 */
		arr_sql[1].append("SELECT T1.client_sid			    													\n")	/* 매출처SID                	*/
	      		  .append("		 ,T1.vend_cd        												 				\n")	/* [회계]거래처 코드          	*/
	      		  .append("		 ,T1.client_cd      												 				\n")	/* 매출처 코드                	*/
	      		  .append("		 ,T1.client_nm     												 				\n")	/* 매출처 명                  	*/
	      		  .append("		 ,T1.client_gu      												 				\n")	/* 매출처구분 :CU005         	*/
	      		  
	      		  .append("		 ,T1.agen_gu        																\n")	/* 대리점구분 :CU006         	*/
	      		  .append("		 ,T1.dir_yn         												 				\n")	/* 직판여부   :CU012         	*/
	      		  .append("		 ,T1.area_cd        																\n")	/* 지역코드   :SY006         	*/
	      		  .append("		 ,T1.sal_dam_sid    																\n")	/* 영업담당자코드[TSY410]     */
	      		  .append("		 ,T1.client_dam_nm  																\n")	/* 매출처담당자               	*/
	      		  
	      		  .append("		 ,T1.tel_no         																\n")	/* 전화번호                   	*/
	      		  .append("		 ,T1.mobile_no      																\n")	/* 휴대전화                   	*/
	      		  .append("		 ,T1.fax_no         																\n")	/* FAX번호                    	*/
	      		  .append("		 ,T1.e_mail         																\n")	/* 이메일                     	*/
	      		  .append("		 ,T1.zip_cd         																\n")	/* 우편번호[TSY110]          */
	      		  
	      		  .append("		 ,T1.address1       																\n")	/* 주소1                    	*/
	      		  .append("		 ,T1.address2        																\n")	/* 주소2                    	*/
	      		  .append("		 ,T1.commi_rate      																\n")	/* 수수료율                   	*/
	      		  .append("		 ,T1.cunt_status     																\n")	/* 계약상태   :CU013         	*/
	      		  .append("		 ,T1.bancod          																\n")	/* 은행코드    [BANKCODE]     */
	      		  
	      		  .append("		 ,T1.bank_acc_no     																\n")	/* 은행계좌번호               	*/
	      		  .append("		 ,T1.bank_acct_nm    																\n")	/* 예금주                     	*/
	      		  .append("		 ,T1.use_yn         																\n")	/* 사용여부   :SY011      	*/ 
	      		  .append("		 ,T1.client_url																		\n")	/* 홈페이지 URL				*/
	      		  .append("		 ,T2.sal_dam_nm    																	\n")	/* 영업담당자명               	*/
	      		  .append("		 ,T3.vend_nm        												 				\n")	/* 거래처명                   	*/
	      		  
	      		  .append("		 ,T4.bannam          																\n")	/* 은행명                     	*/
	      		  .append("		 ,SALES.FN_DETAIL_NM ( 'CU006',T1.agen_gu)    AS agen_gu_name    					\n")	/* 대리점구분명 				*/ 
	      		  .append("		 ,SALES.FN_DETAIL_NM ( 'CU012',T1.dir_yn)     AS dir_yn_name     					\n")	/* 직판여부명   				*/ 
	      		  .append("		 ,SALES.FN_DETAIL_NM ( 'SY006',T1.area_cd)    AS area_nm							\n")	/* 지역명       				*/
	      		  .append("		 ,SALES.FN_DETAIL_NM ( 'CU013',T1.cunt_status)     AS cunt_status_name    			\n")	/* 계약상태명   				*/

	      		  .append("		 ,SALES.FN_DETAIL_NM ( 'SY011',T1.use_yn)         AS use_yn_name          			\n")	/* 사용여부명  			 	*/

	      		  .append("FROM SALES.TCU030 T1 LEFT OUTER JOIN SALES.TSY410 T2 ON T1.SAL_DAM_SID  = T2.SAL_DAM_SID \n")
	      		  .append("		 LEFT OUTER JOIN ACCOUNT.GCZM_VENDER T3 ON T1.VEND_CD = T3.VEND_CD 					\n")
	      		  .append("		 LEFT OUTER JOIN ACCOUNT.BANKCODE    T4 ON T1.BANCOD = T4.BANCOD 					\n")
	      		  .append("WHERE 1 = 1 																				\n")
	      		  .append("		 AND T1.client_GU  = '1' 															\n");
		/*
		 * 계약정보 조회
		 */
		arr_sql[2].append("SELECT T1.client_sid												\n")	/* 매출처SID           	*/
				  .append("		 ,T1.cont_date																	\n") 	/* 계약일자            	*/
				  .append("		 ,T1.expire_date																\n")	/* 만기일자            	*/
				  .append("		 ,TO_NUMBER(T1.insur_amt) AS insur_amt																	\n")	/* 보험료              	*/
				  .append("		 ,T1.insur_comp_cd																\n")	/* 보증보험회사:CU010  	*/
				  .append("		 ,SALES.FN_DETAIL_NM ('CU010',T1.insur_comp_cd)     AS insur_comp_cd_name		\n") 	/* 보증보험회사명   		*/   
				  .append("FROM SALES.TCU031  T1 																\n")
				  .append("WHERE 1=1																			\n");
		  
	
		/*
		 * 지점정보 조회
		 */
		arr_sql[3].append("SELECT T1.client_sid												\n") 	/* 매출처SID      		*/
				  .append("		 ,T1.branch_cd																	\n")	/* 지점코드       			*/
				  .append("		 ,T1.branch_nm 																	\n") 	/* 지점명         			*/
				  .append("		 ,T1.area_cd																	\n") 	/* 지역코드:SY006 		*/
				  .append("		 ,T1.client_down_yn  															\n")	/* 하위대리점여부:CU011 	*/
				  .append("		 ,T1.empno 																		\n")	/* 담당자         			*/
				  .append("		 ,T1.tel_no  																	\n")	/* 전화번호       			*/
				  .append("		 ,T1.mobile_no 																	\n")	/* 휴대폰         			*/
				  .append("		 ,T1.fax_no 																	\n")	/* 팩스번호       			*/
				  .append("		 ,T1.branch_url  																\n")	/* 지점홈페이지   			*/
				  .append("		 ,SALES.FN_DETAIL_NM ( 'SY006', T1.area_cd) AS area_nm							\n") 	/* 지역명:SY006 		*/
				  .append("		 ,SALES.FN_DETAIL_NM ( 'CU011',T1.client_down_yn)     AS client_down_yn_name 	\n")	/* 하위대리점여부명   		*/
				  .append("FROM SALES.TCU032  T1																\n");
		
		
		/*
		 * 대리점 등록
		 */

		arr_sql[4].append("INSERT INTO SALES.TCU030 (")
				  .append("				 client_sid        \n")	
				  .append("				,vend_cd        \n")	/* [회계]거래처 코드          	*/
				  .append("				,client_cd      \n")	/* 매출처 코드                	*/
				  .append("				,client_nm      \n")	/* 매출처 명                  	*/
				  .append("				,client_gu      \n")	/* 매출처구분 :CU005         	*/
				  .append("				,agen_gu        \n")	/* 대리점구분 :CU006         	*/
				  
				  .append("				,dir_yn         \n")	/* 직판여부   :CU012         	*/
				  .append("				,area_cd        \n")	/* 지역코드   :SY006         	*/
				  .append("				,sal_dam_sid    \n")	/* 영업담당자코드[TSY410]    	*/
				  .append("				,client_dam_nm  \n")	/* 매출처담당자               	*/
				  .append("				,tel_no         \n")	/* 전화번호                   	*/
				  
				  .append("				,mobile_no      \n")	/* 핸드폰                     	*/
				  .append("				,fax_no         \n")	/* FAX번호                   	*/
				  .append("				,e_mail         \n")	/* 이메일                     	*/
				  .append("				,zip_cd         \n")	/* 소재지우편번호[TSY110]     */
				  .append("				,address1       \n")	/* 소재지주소1               	*/
				  
				  .append("				,address2       \n")	/* 소재지주소2               	*/
				  .append("				,commi_rate   	\n") 	/* 수수료율                   	*/
				  .append("				,cunt_status    \n")	/* 계약상태   :CU013         	*/
				  .append("				,bancod			\n") 	/* 은행코드 					*/
				  .append("				,bank_acc_no    \n")	/* 은행계좌번호[BANKCODE]    	*/
				  
				  .append("				,bank_acct_nm	\n")	/* 예금주 					*/
				  .append("				,use_yn			\n")	/* 사용여부 					*/
				
				  .append("		 		,u_date       	\n") 	/* 최종수정일자               	*/
	      		  .append("		 		,u_empno       	\n")	/* 최종수정자사번             	*/
	      		  .append("		 		,u_ip          \n")	/* 최종수정IP                */			
	      		  .append("				,client_url		\n")	/* 홈페이지 */
				  .append("			)					\n")
				  
				  .append("VALUES						\n")
				  .append("			(	    			\n")
				  .append("				SALES.SWS_TCU030_ID.NEXTVAL,?,?,?,?,?,		\n")	
				  .append("				?,?,?,?,?,		\n")
				  .append("				?,?,?,?,?,		\n")
				  .append("				?,?,?,?,?,		\n")
				  .append("				?,?,SYSTIMESTAMP,?,?,?	\n")
				  .append("			)");
		
	
		
		/*
		 * 계약정보 등록
		 */
		arr_sql[5].append("INSERT INTO SALES.TCU031 ( 	\n")
				  .append(" 	  client_SID			\n")	/* 매출처SID           	*/
				  .append("		 ,cont_date				\n") 	/* 계약일자            	*/
				  .append("		 ,expire_date			\n")	/* 만기일자            	*/
				  .append("		 ,insur_amt				\n")	/* 보험료              	*/
				  .append("		 ,insur_comp_cd			\n")	/* 보증보험회사:CU010  	*/
				  
				  .append("		 ,u_date				\n")	/* 최종수정일자        	*/
				  .append("		 ,u_empno 				\n") 	/* 최종수정자사번      	*/
				  .append("		 ,u_ip					\n")	/* 최종수정IP         	*/
				  .append("		)						\n")
				  
				  .append("VALUES						\n")
				  .append("			(	    			\n")
				  .append("				?,?,?,?,?,		\n")	
				  .append("				SYSTIMESTAMP,?,?			\n")
				  .append("			)");
					
		/*
		 * 지점정보 등록
		 */
		
		arr_sql[6].append("INSERT INTO SALES.TCU032 ( 	\n")
				  .append("		  client_SID			\n") 	/* 매출처SID      		*/
				  .append("		 ,branch_cd				\n")	/* 지점코드       			*/
				  .append("		 ,branch_nm 			\n") 	/* 지점명         			*/
				  .append("		 ,area_cd				\n") 	/* 지역코드:SY006 		*/
				  .append("		 ,client_down_yn  		\n")	/* 하위대리점여부:CU011 	*/
				  
				  .append("		 ,empno 				\n")	/* 담당자         			*/
				  .append("		 ,tel_no  				\n")	/* 전화번호       			*/
				  .append("		 ,mobile_no 			\n")	/* 휴대폰         			*/
				  .append("		 ,fax_no 				\n")	/* 팩스번호       			*/
				  .append("		 ,branch_url  			\n")	/* 지점홈페이지   			*/
				  
				  .append("		 ,u_date 				\n")	/* 최종수정일자   			*/
				  .append("		 ,u_empno 				\n")	/* 최종수정자사번 			*/
				  .append("		 ,u_ip  				\n")	/* 최종수정IP     		*/
				   .append("	)						\n")
				  .append("VALUES						\n")
				  .append("			(	    			\n")
				  .append("				?,?,?,?,?,		\n")	
				  .append("				?,?,?,?,?,		\n")
				  .append("				SYSTIMESTAMP,?,?			\n")
				  .append("			)");
		
		/*
		 * 대리점 수정
		 */

		arr_sql[7].append("UPDATE SALES.TCU030 SET 						\n")
				  .append("		 vend_cd		= ?     				\n")	/* [회계]거래처 코드          	*/
				  .append("		,client_nm		= ?     				\n")	/* 매출처 명                  	*/
				  .append("		,agen_gu		= ?    				 	\n")	/* 대리점구분 :CU006         	*/
				  .append("		,dir_yn			= ?     				\n")	/* 직판여부   :CU012         	*/
				  .append("		,area_cd      	= ?  					\n")	/* 지역코드   :SY006         	*/

				  .append("		,sal_dam_sid	= ?    					\n")	/* 영업담당자코드[TSY410]     */
				  .append("		,client_dam_nm	= ?  					\n")	/* 매출처담당자               	*/
				  .append("		,tel_no         = ?						\n")	/* 전화번호                   	*/
				  .append("		,mobile_no      = ?						\n")	/* 핸드폰                    	*/
				  .append("		,fax_no         = ?						\n")	/* FAX번호                    	*/

				  .append("		,e_mail         = ?						\n")	/* 이메일                   	*/
				  .append("		,zip_cd         = ?						\n")	/* 소재지우편번호[TSY110]   	*/
				  .append("		,address1       = ?						\n")	/* 소재지주소1             	*/
				  .append("		,address2       = ?						\n")	/* 소재지주소2               	*/
				  .append("		,commi_rate    	= ?						\n") 	/* 수수료율                  	*/

				  .append("		,cunt_status    = ?						\n")	/* 계약상태   :CU013         	*/
				  .append("		,bancod			= ?						\n") 	/* 은행코드	 				*/
				  .append("		,bank_acc_no    = ?						\n")	/* 은행계좌번호[BANKCODE]		*/
				  .append("		,bank_acct_nm	= ?						\n")	/* 예금주 					*/
				  .append("		,use_yn			= ?						\n")	/* 사용여부 					*/

				  .append("		,u_date        	= SYSTIMESTAMP		\n") 	/* 최종수정일자               	*/
	      		  .append("		,u_empno       	= ?						\n")	/* 최종수정자사번             	*/
	      		  .append("		,u_ip           = ?						\n")	/* 최종수정IP                */
	      		   .append("	,client_url           = ?						\n")	/* 홈페이지                */
				 .append ("WHERE   client_sid 	= ?       				\n");
				  
		/*
		 * 계약정보 수정
		 */
		arr_sql[8].append("UPDATE SALES.TCU031 SET						\n")
				  .append("		  cont_date			= ?					\n") 	/* 계약일자            	*/
				  .append("		 ,expire_date		= ?					\n")	/* 만기일자            	*/
				  .append("		 ,insur_amt			= ?					\n")	/* 보험료              	*/
				  .append("		 ,insur_comp_cd		= ?					\n")	/* 보증보험회사:CU010  	*/
				  
				  .append("		 ,u_date			= SYSTIMESTAMP	\n")	/* 최종수정일자        	*/
				  .append("		 ,u_empno 			= ?					\n") 	/* 최종수정자사번      	*/
				  .append("		 ,u_ip				= ?					\n")	/* 최종수정IP         	*/
				  .append ("WHERE   client_sid 		= ? AND cont_date = ? \n");
				
				  
					
		/*
		 * 지점정보 수정
		 */
		
		arr_sql[9].append("UPDATE SALES.TCU032 SET 							\n")
				  .append("		  branch_nm 		= ?						\n") 	/* 지점명         			*/
				  .append("		 ,area_cd			= ?						\n") 	/* 지역코드:SY006 		*/
				  .append("		 ,client_down_yn  	= ?						\n")	/* 하위대리점여부:CU011 	*/
				  
				  .append("		 ,empno 			= ?						\n")	/* 담당자         			*/
				  .append("		 ,tel_no  			= ?						\n")	/* 전화번호       			*/
				  .append("		 ,mobile_no 		= ?						\n")	/* 휴대폰         			*/
				  .append("		 ,fax_no 			= ?						\n")	/* 팩스번호       			*/
				  .append("		 ,branch_url  		= ?						\n")	/* 지점홈페이지   			*/
				  
				  .append("		 ,u_date 			= SYSTIMESTAMP						\n")	/* 최종수정일자   			*/
				  .append("		 ,u_empno 			= ?		\n")	/* 최종수정자사번 			*/
				  .append("		 ,u_ip  			= ?						\n")	/* 최종수정IP     		*/
				  .append ("WHERE   client_sid = ? AND branch_cd 	= ?		\n");
		
		 arr_sql[10].append("DELETE FROM SALES.TCU030 WHERE client_sid = ?");	
		 arr_sql[11].append("DELETE FROM SALES.TCU031 WHERE client_sid = ? AND cont_date = ?");
		 arr_sql[12].append("DELETE FROM SALES.TCU032 WHERE client_sid = ? AND branch_cd = ?");
		 
		 
		 /*
		  * Client SID 얻어오기
		  */
			
			arr_sql[13].append("SELECT client_sid FROM SALES.TCU030 WHERE client_cd = ?\n");
			
		/*
		 * 수수료율 조회
		 */
			arr_sql[14].append("SELECT								\n")
						.append("   T1.CLIENT_SID  AS CLIENT_SID	\n") /* 매출처SID           */
						.append("  ,T1.FR_DATE     AS FR_DATE   	\n") /* 시작일자            */
						.append("  ,T1.TO_DATE     AS TO_DATE   	\n") /* 종료일자            */
						.append("  ,T1.WEEKEND_YN  AS WEEKEND_YN  	\n") /* 주말여부            */
						.append("  ,T1.COMMI_RATE  AS COMMI_RATE	\n") /* 수수료율            */
						.append("FROM SALES.TCU033 T1           	\n")
						.append("WHERE 1=1 							\n");
						
		/*
		 * 수수료율 등록
		 */
			
			arr_sql[15].append("INSERT INTO SALES.TCU033 ( 	\n")
						  .append(" 	  CLIENT_SID			\n")	/* 매출처SID           	*/
						  .append("		 ,FR_DATE				\n") 	/* 시작일자            	*/
						  .append("		 ,TO_DATE			\n")	/* 종료일자            	*/
						  .append("		 ,COMMI_RATE				\n")	/* 수수료율              	*/
						  .append("		 ,WEEKEND_YN			\n")	/* 주말여부              	*/
						  .append("		 ,I_DATE				\n")	/* 최종입력일자        	*/
						  .append("		 ,I_EMPNO 				\n") 	/* 최종입력자사번      	*/
						  .append("		 ,I_IP					\n")	/* 최종입력IP         	*/						  
						  .append("		 ,u_date				\n")	/* 최종수정일자        	*/
						  .append("		 ,u_empno 				\n") 	/* 최종수정자사번      	*/
						  .append("		 ,u_ip					\n")	/* 최종수정IP         	*/
						  .append("		)						\n")
						  
						  .append("VALUES						\n")
						  .append("			(	    			\n")
						  .append("				?,?,?,?, ?,		\n")	
						  .append("				SYSTIMESTAMP,?,?, SYSTIMESTAMP,?,?	\n")
						  .append("			)");
		/*
		 * 수수료율 수정
		 */
			arr_sql[16].append("UPDATE SALES.TCU033 SET						\n")                                      
					  .append("		  TO_DATE			= ?					\n")	/* 종료일자              	*/																																																																				
					  .append("		 ,COMMI_RATE		= ?					\n")	/* 수수료율  	*/
					  .append("		 ,WEEKEND_YN		= ?					\n")	/* 주말여부  	*/
					  
					                                                                                           																																																																				
					  .append("		 ,u_date			= SYSTIMESTAMP	\n")	/* 최종수정일자        	*/																																																																				
					  .append("		 ,u_empno 			= ?					\n") 	/* 최종수정자사번      	*/																																																																				
					  .append("		 ,u_ip				= ?					\n")	/* 최종수정IP         	*/																																																																				
					  .append ("WHERE   client_sid 		= ? AND FR_DATE = ? AND WEEKEND_YN=? \n");        
		/*
		 * 수수료율 삭제
		 */
		arr_sql[17].append("DELETE FROM SALES.TCU033 WHERE client_sid = ? AND fr_date = ?  AND WEEKEND_YN=? ");	        
			        

	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","선조회",this);
		//StringUtil.printMsg("DS TYPE","이거 왜 안찍힘?",this);		
		/* DataSet */
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		CallableStatement cstmt = null;
		
		int v_rowcnt = 0;
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
		    //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
		    GauceDataSet[] dSets = gis.readAllOutput(); 
			
		    for(int i=0; i<dSets.length;i++){
		   		if(dSets[i].getName().equals("codeDs1")){//고객구분
		    		GauceDataSet ds1 = gis.read("AGENGU");
		    		cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, "CU006");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];	
		   		
		   		} else if(dSets[i].getName().equals("codeDs2")){//직판구분
		    		GauceDataSet ds1 = gis.read("DIRYN");
		    		cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, "CU012");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];	
		   		} else if(dSets[i].getName().equals("codeDs3")){//지역
		    		GauceDataSet ds1 = gis.read("AREACD");
		    		cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, "SY006");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];	
		   		} else if(dSets[i].getName().equals("codeDs4")){//계약상태
		    		GauceDataSet ds1 = gis.read("CUNTSTATUS"); 
		    		cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, "CU013");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];			
		   		} else if(dSets[i].getName().equals("codeDs5")){//사용유무
		    		GauceDataSet ds1 = gis.read("USEYN"); 		
		    		cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, "SY011");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];	
		   		} else if(dSets[i].getName().equals("sCodeDs1")){//사용유무
		    		GauceDataSet ds1 = gis.read("S_USEYN"); 		
		    		cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, "SY011");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];	
		   		} else if(dSets[i].getName().equals("codeDs6")){//보증보험회사
		    		GauceDataSet ds1 = gis.read("INSURCOMPCD"); 		
		    		cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, "CU010");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];			
		   		} else if(dSets[i].getName().equals("codeDs7")){//하위대리점 여부 (구분)
		    		GauceDataSet ds1 = gis.read("CLIENTDOWNYN"); 		
		    		cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, "CU011");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];	
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

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		
		int v_rowcnt = 0;

		/*
		 * 검색시 필요한 조건
		 */
		
		String sClient_sid = HDUtil.nullCheckStr(greq.getParameter("sClient_sid"));	// 매출처 SID
		String sClient_nm = HDUtil.nullCheckStr(greq.getParameter("sClient_nm")); 	// LIKE
		String sSal_dam_sid = HDUtil.nullCheckStr(greq.getParameter("sSal_dam_sid")); 	// 영업담당자 코드 
		String sUse_yn = HDUtil.nullCheckStr(greq.getParameter("sUse_yn"));			// 사용유무 
		
		//StringUtil.printMsg("대리점 이름",sClient_nm,this);
		//StringUtil.printMsg("영업담당자 코드 ",sSal_dam_sid,this);
		//StringUtil.printMsg("사용유무 ",sUse_yn,this);
		try {
			int sCnt1 = 1;
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput();
			
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
				if(dSets[i].getName().equals("ds1")){
		    		GauceDataSet ds1 = gis.read("DS1");
					if (!"".equals(sClient_nm)) { // 대리점코드/명
				  		 arr_sql[1].append("		 AND (T1.client_cd    LIKE ? OR T1.client_nm LIKE ?)	\n");	//매출처코드
					}
					if (!"".equals(sSal_dam_sid)) { // 영업담당자명/코드
				  		 arr_sql[1].append("		 AND T2.sal_dam_sid = ?      						\n");	// 영업담당자 
					}
					if (!"".equals(sUse_yn)) { // 사용유무 
				  		 arr_sql[1].append("		 AND T1.use_yn     = ?          					\n");	// 사용여부 
					}
			  		 arr_sql[1].append("		 ORDER BY T1.client_nm, T1.client_cd					\n");
	
			  		cstmt = conn.prepareCall(arr_sql[1].toString()); 
			  		 	
				  	// 조건
			  		if (!"".equals(sClient_nm)) {
				  		cstmt.setString(sCnt1++, sClient_nm + "%");		// 매출처코드
				  		cstmt.setString(sCnt1++, sClient_nm + "%");		// 매출처명
				  		 
					}
					if (!"".equals(sSal_dam_sid)) { 
						cstmt.setString(sCnt1++, sSal_dam_sid );			// 영업담당자 
					}
					if (!"".equals(sUse_yn)) { 
				  		 cstmt.setString(sCnt1++, sUse_yn);				// 사용여부 
					}
					
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
				}
					
				/*
				 * 계약정보
				 */
				if(dSets[i].getName().equals("ds2")){
		    		GauceDataSet ds1 = gis.read("DS2");
					 
					if (!"".equals(sClient_sid)) { 
						arr_sql[2].append("		AND T1.client_sid = ?	\n");	// 대리점SID
				  		 
					} else if ("".equals(sClient_sid)) {
						arr_sql[2].append("		AND T1.client_sid = 0 \n");
					}
			  		 arr_sql[2].append("		ORDER BY T1.cont_date");	
	
			  		 // 쿼리 실행
			  		//StringUtil.printMsg("QUERY",arr_sql[2].toString(),this);
			  		cstmt = conn.prepareCall(arr_sql[2].toString());  
			  		
			  		// 조건
			  		if (!"".equals(sClient_sid)) { 
				  		cstmt.setString(sCnt1++, sClient_sid);			// 대리점 SID
					}
			  		
			  		rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
				}
				
			
				/*
				 * 지점정보
				 */
				if(dSets[i].getName().equals("ds3")){
		    		GauceDataSet ds1 = gis.read("DS3");
					if (!"".equals(sClient_sid)) { // 대리점코드/명
				  		 arr_sql[3].append("WHERE T1.client_sid = ?		\n");	// 매출처코드
				  		 
					} else if ("".equals(sClient_sid)) {
						arr_sql[3].append("WHERE T1.client_sid = 0		\n");	// 매출처코드
					}
			  		 arr_sql[3] .append("ORDER BY T1.branch_cd			\n");
		
			  		cstmt = conn.prepareCall(arr_sql[3].toString());  
				  		
			  		// 조건
			  		if (!"".equals(sClient_sid)) {
			  			cstmt.setString(sCnt1++, sClient_sid);			// 대리점 SID
					}
			  		
			  		rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
				}
					
				/*
				 * 수수료율
				 */
				if(dSets[i].getName().equals("ds4")){
		    		GauceDataSet ds1 = gis.read("DS4");
						  
					if (!"".equals(sClient_sid)) { // 대리점코드/명
				  		arr_sql[14].append("	AND T1.CLIENT_SID = ?			\n");
				  		 
					} else if ("".equals(sClient_sid)) {
						arr_sql[14].append("WHERE T1.client_sid = 0		\n");	// 매출처코드
					}
			  		 arr_sql[14] .append("ORDER BY T1.FR_DATE			\n");
	
			  		cstmt = conn.prepareCall(arr_sql[14].toString());
			  		
			  		// 조건
			  		if (!"".equals(sClient_sid)) {
			  			cstmt.setString(sCnt1++, sClient_sid);			// 대리점 SID
					}
			  		
			  		rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
				}
					sCnt1 = 1;
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


	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;	
		ResultSet 		rs 			= null;
				
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
						
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		
		/* DataSet */
		GauceDataSet ds1 = gis.read("DS1");
		GauceDataSet ds2 = gis.read("DS2");		
		GauceDataSet ds3 = gis.read("DS3");
		GauceDataSet ds4 = gis.read("DS4");
		
		int fClientSid = 0;
		
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				
				int colNm_ClientSid             = ds1.indexOfColumn("client_sid".toUpperCase());
				int colNm_VendCd                = ds1.indexOfColumn("vend_cd".toUpperCase());
				int colNm_ClientCd              = ds1.indexOfColumn("client_cd".toUpperCase());
				int colNm_ClientNm              = ds1.indexOfColumn("client_nm".toUpperCase());
				int colNm_ClientGu              = ds1.indexOfColumn("client_gu".toUpperCase());
				int colNm_AgenGu                = ds1.indexOfColumn("agen_gu".toUpperCase());
				int colNm_DirYn                 = ds1.indexOfColumn("dir_yn".toUpperCase());
				int colNm_AreaCd                = ds1.indexOfColumn("area_cd".toUpperCase());
				int colNm_SalDam_sid            = ds1.indexOfColumn("sal_dam_sid".toUpperCase());
				int colNm_ClientDam_nm          = ds1.indexOfColumn("client_dam_nm".toUpperCase());
				int colNm_TelNo                 = ds1.indexOfColumn("tel_no".toUpperCase());
				int colNm_MobileNo              = ds1.indexOfColumn("mobile_no".toUpperCase());
				int colNm_FaxNo                 = ds1.indexOfColumn("fax_no".toUpperCase());
				int colNm_EMail                 = ds1.indexOfColumn("e_mail".toUpperCase());
				int colNm_ZipCd                 = ds1.indexOfColumn("zip_cd".toUpperCase());
				int colNm_Address1              = ds1.indexOfColumn("address1".toUpperCase());
				int colNm_Address2              = ds1.indexOfColumn("address2".toUpperCase());
				int colNm_CommiRate             = ds1.indexOfColumn("commi_rate".toUpperCase());
				int colNm_CuntStatus            = ds1.indexOfColumn("cunt_status".toUpperCase());
				int colNm_Bancod                = ds1.indexOfColumn("bancod".toUpperCase());
				int colNm_BankAcc_no            = ds1.indexOfColumn("bank_acc_no".toUpperCase());
				int colNm_BankAcct_nm           = ds1.indexOfColumn("bank_acct_nm".toUpperCase());
				int colNm_UseYn                 = ds1.indexOfColumn("use_yn".toUpperCase());
				int colNm_ClientUrl                 = ds1.indexOfColumn("client_url".toUpperCase());
				
				for(int i = 0; i < rows.length; i++) {

					int iCnt = 1;
					int dCnt = 1;
					int uCnt = 1;
					
					int colNum = 0;
					
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							cstmt = conn.prepareCall(arr_sql[4].toString());
							
							cstmt.setString(1, rows[i].getString(colNm_VendCd));
							cstmt.setString(2, rows[i].getString(colNm_ClientCd));
							cstmt.setString(3, rows[i].getString(colNm_ClientNm));
							cstmt.setString(4, rows[i].getString(colNm_ClientGu));
							cstmt.setString(5, rows[i].getString(colNm_AgenGu));
							cstmt.setString(6, rows[i].getString(colNm_DirYn));
							cstmt.setString(7, rows[i].getString(colNm_AreaCd));
							cstmt.setString(8, rows[i].getString(colNm_SalDam_sid));
							cstmt.setString(9, rows[i].getString(colNm_ClientDam_nm));
							cstmt.setString(10, rows[i].getString(colNm_TelNo));
							cstmt.setString(11, rows[i].getString(colNm_MobileNo));
							cstmt.setString(12, rows[i].getString(colNm_FaxNo));
							cstmt.setString(13, rows[i].getString(colNm_EMail));
							cstmt.setString(14, rows[i].getString(colNm_ZipCd));
							cstmt.setString(15, rows[i].getString(colNm_Address1));
							cstmt.setString(16, rows[i].getString(colNm_Address2));
							cstmt.setString(17, rows[i].getString(colNm_CommiRate));
							cstmt.setString(18, rows[i].getString(colNm_CuntStatus));
							cstmt.setString(19, rows[i].getString(colNm_Bancod));
							cstmt.setString(20, rows[i].getString(colNm_BankAcc_no));
							cstmt.setString(21, rows[i].getString(colNm_BankAcct_nm));
							cstmt.setString(22, rows[i].getString(colNm_UseYn));
							cstmt.setString(23, iParamEmpno);
							cstmt.setString(24, iParamIp);
							cstmt.setString(25, rows[i].getString(colNm_ClientUrl));
							/*
							stmt.bindColumn(iCnt++, colNm_VendCd);
							stmt.bindColumn(iCnt++, colNm_ClientCd);
							stmt.bindColumn(iCnt++, colNm_ClientNm);
							stmt.bindColumn(iCnt++, colNm_ClientGu);
							stmt.bindColumn(iCnt++, colNm_AgenGu);
							stmt.bindColumn(iCnt++, colNm_DirYn);
							stmt.bindColumn(iCnt++, colNm_AreaCd);
							stmt.bindColumn(iCnt++, colNm_SalDam_sid);
							stmt.bindColumn(iCnt++, colNm_ClientDam_nm);
							stmt.bindColumn(iCnt++, colNm_TelNo);
							stmt.bindColumn(iCnt++, colNm_MobileNo);
							stmt.bindColumn(iCnt++, colNm_FaxNo);
							stmt.bindColumn(iCnt++, colNm_EMail);
							stmt.bindColumn(iCnt++, colNm_ZipCd);
							stmt.bindColumn(iCnt++, colNm_Address1);
							stmt.bindColumn(iCnt++, colNm_Address2);
							stmt.bindColumn(iCnt++, colNm_CommiRate);
							stmt.bindColumn(iCnt++, colNm_CuntStatus);
							stmt.bindColumn(iCnt++, colNm_Bancod);
							stmt.bindColumn(iCnt++, colNm_BankAcc_no);
							stmt.bindColumn(iCnt++, colNm_BankAcct_nm);
							stmt.bindColumn(iCnt++, colNm_UseYn);
							stmt.setString(iCnt++, iParamEmpno);
							stmt.setString(iCnt++, iParamIp);
							stmt.bindColumn(iCnt++, colNm_ClientUrl);
							*/
							// 쿼리실행
							cstmt.executeUpdate();
							if(cstmt!=null) cstmt.close();	
							
							cstmt = conn.prepareCall(arr_sql[13].toString());
						
							cstmt.setString(1, rows[i].getColumnValue(colNm_ClientCd)+"");
							rs = cstmt.executeQuery();
							
							if(rs.next()) {
								fClientSid = rs.getInt(1);
							}
							
							rs.close();
							cstmt.close();
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							
							cstmt = conn.prepareCall(arr_sql[7].toString());
							//stmt.setGauceDataRow(rows[i]);
							cstmt.setString(1, rows[i].getString(colNm_VendCd));
							cstmt.setString(2, rows[i].getString(colNm_ClientNm));
							cstmt.setString(3, rows[i].getString(colNm_AgenGu));
							cstmt.setString(4, rows[i].getString(colNm_DirYn));
							cstmt.setString(5, rows[i].getString(colNm_AreaCd));
							cstmt.setString(6, rows[i].getString(colNm_SalDam_sid));
							cstmt.setString(7, rows[i].getString(colNm_ClientDam_nm));
							cstmt.setString(8, rows[i].getString(colNm_TelNo));
							cstmt.setString(9, rows[i].getString(colNm_MobileNo));
							cstmt.setString(10, rows[i].getString(colNm_FaxNo));
							cstmt.setString(11, rows[i].getString(colNm_EMail));
							cstmt.setString(12, rows[i].getString(colNm_ZipCd));
							cstmt.setString(13, rows[i].getString(colNm_Address1));
							cstmt.setString(14, rows[i].getString(colNm_Address2));
							cstmt.setString(15, rows[i].getString(colNm_CommiRate));
							cstmt.setString(16, rows[i].getString(colNm_CuntStatus));
							cstmt.setString(17, rows[i].getString(colNm_Bancod));
							cstmt.setString(18, rows[i].getString(colNm_BankAcc_no));
							cstmt.setString(19, rows[i].getString(colNm_BankAcct_nm));
							cstmt.setString(20, rows[i].getString(colNm_UseYn));
							cstmt.setString(21, iParamEmpno);
							cstmt.setString(22, iParamIp);
							cstmt.setString(23, rows[i].getString(colNm_ClientUrl));
							cstmt.setString(24, rows[i].getString(colNm_ClientSid));
							/*
							stmt.bindColumn(uCnt++, colNm_VendCd);
							stmt.bindColumn(uCnt++, colNm_ClientNm);
							stmt.bindColumn(uCnt++, colNm_AgenGu);
							stmt.bindColumn(uCnt++, colNm_DirYn);
							stmt.bindColumn(uCnt++, colNm_AreaCd);
							
							stmt.bindColumn(uCnt++, colNm_SalDam_sid);
							stmt.bindColumn(uCnt++, colNm_ClientDam_nm);
							stmt.bindColumn(uCnt++, colNm_TelNo);
							stmt.bindColumn(uCnt++, colNm_MobileNo);
							stmt.bindColumn(uCnt++, colNm_FaxNo);

							stmt.bindColumn(uCnt++, colNm_EMail);
							stmt.bindColumn(uCnt++, colNm_ZipCd);
							stmt.bindColumn(uCnt++, colNm_Address1);
							stmt.bindColumn(uCnt++, colNm_Address2);
							stmt.bindColumn(uCnt++, colNm_CommiRate);

							stmt.bindColumn(uCnt++, colNm_CuntStatus);
							stmt.bindColumn(uCnt++, colNm_Bancod);
							stmt.bindColumn(uCnt++, colNm_BankAcc_no);
							stmt.bindColumn(uCnt++, colNm_BankAcct_nm);
							stmt.bindColumn(uCnt++, colNm_UseYn);

							stmt.setString(uCnt++, iParamEmpno);
							stmt.setString(uCnt++, iParamIp);
							stmt.bindColumn(uCnt++, colNm_ClientUrl);
							
							stmt.bindColumn(uCnt++, colNm_ClientSid);
							*/
							// 쿼리실행
							cstmt.executeUpdate();
							if(cstmt!=null) cstmt.close();	
							break;
						
						case GauceDataRow.TB_JOB_DELETE:
							cstmt = conn.prepareCall(arr_sql[10].toString());
							//cstmt.setGauceDataRow(rows[i]);
							//StringUtil.printMsg("CL SID " , colNm_ClientSid+"",this);
							cstmt.setString(1, rows[i].getString(colNm_ClientSid));
							//stmt.bindColumn(dCnt++, colNm_ClientSid);
							
							// 쿼리실행
							cstmt.executeUpdate();
							if(cstmt!=null) cstmt.close();	
							break;
					}
				}
				
				
			}  if (ds2 != null) {
				
				GauceDataRow[] 		rows = ds2.getDataRows();
				GauceDataColumn[] 	cols = ds2.getDataColumns();
				
				int colNm_ClientSid             = ds2.indexOfColumn("CLIENT_SID");
				int colNm_ContDate              = ds2.indexOfColumn("CONT_DATE");
				int colNm_ExpireDate            = ds2.indexOfColumn("EXPIRE_DATE");
				int colNm_InsurAmt              = ds2.indexOfColumn("INSUR_AMT");
				int colNm_InsurComp_cd          = ds2.indexOfColumn("INSUR_COMP_CD");
				
				//StringUtil.printMsg("1",colNm_ClientSid,this);
				//StringUtil.printMsg("2",colNm_ContDate,this);
				//StringUtil.printMsg("3",colNm_ExpireDate,this);
				//StringUtil.printMsg("4",colNm_InsurAmt,this);
				//StringUtil.printMsg("5",colNm_InsurComp_cd,this);
				
				
				int iCnt = 1;
				int dCnt = 1;
				int uCnt = 1;
				
				for(int i = 0; i < rows.length; i++) {
					switch(rows[i].getJobType()){
					case GauceDataRow.TB_JOB_INSERT:
						//StringUtil.printMsg("계약정보 등록 ,,,,,,,,,,,,,,,,,,,,",this);
						cstmt = conn.prepareCall(arr_sql[5].toString());	// 계약 정보 등록
						//stmt.setGauceDataRow(rows[i]);

						//StringUtil.printMsg("클라이언트 SiD DS2", fClientSid, this);
						if (fClientSid == 0) {
							//StringUtil.printMsg("클라이언트 SiD DS2 0 일경우", rows[i].getString(colNm_ClientSid), this);
							cstmt.setString(iCnt++, rows[i].getString(colNm_ClientSid));
							//stmt.bindColumn(iCnt++, colNm_ClientSid);
						} else {
							cstmt.setString(iCnt++, rows[i].getString(fClientSid));
							//stmt.setInt(iCnt++, fClientSid);
						}
						cstmt.setString(iCnt++, rows[i].getString(colNm_ContDate));
						cstmt.setString(iCnt++, rows[i].getString(colNm_ExpireDate));
						cstmt.setString(iCnt++, rows[i].getString(colNm_InsurAmt));
						cstmt.setString(iCnt++, rows[i].getString(colNm_InsurComp_cd));
						cstmt.setString(iCnt++, iParamEmpno);
						cstmt.setString(iCnt++, iParamIp);
						/*
						stmt.bindColumn(iCnt++, colNm_ContDate);
						stmt.bindColumn(iCnt++, colNm_ExpireDate);
						stmt.bindColumn(iCnt++, colNm_InsurAmt);
						stmt.bindColumn(iCnt++, colNm_InsurComp_cd);
						stmt.setString(iCnt++, iParamEmpno);
						stmt.setString(iCnt++, iParamIp);
						*/
						cstmt.executeUpdate();
						if(cstmt!=null) cstmt.close();	
						break;
					case GauceDataRow.TB_JOB_UPDATE:
						cstmt = conn.prepareCall(arr_sql[8].toString());	// 계약 정보 등록
						//StringUtil.printMsg("수정쿼리",arr_sql[8].toString(),this);
						
						//stmt.setGauceDataRow(rows[i]);
						cstmt.setString(uCnt++, rows[i].getString(colNm_ContDate));
						cstmt.setString(uCnt++, rows[i].getString(colNm_ExpireDate));
						cstmt.setString(uCnt++, rows[i].getString(colNm_InsurAmt));
						cstmt.setString(uCnt++, rows[i].getString(colNm_InsurComp_cd));
						cstmt.setString(uCnt++, iParamEmpno);
						cstmt.setString(uCnt++, iParamIp);
						cstmt.setString(uCnt++, rows[i].getString(colNm_ClientSid));
						cstmt.setString(uCnt++, rows[i].getString(colNm_ContDate));
						/*
						stmt.bindColumn(uCnt++, colNm_ContDate);
						stmt.bindColumn(uCnt++, colNm_ExpireDate);
						stmt.bindColumn(uCnt++, colNm_InsurAmt);
						stmt.bindColumn(uCnt++, colNm_InsurComp_cd);	
						stmt.setString(uCnt++, iParamEmpno);
						stmt.setString(uCnt++, iParamIp);
						stmt.bindColumn(uCnt++, colNm_ClientSid);
						stmt.bindColumn(uCnt++, colNm_ContDate);
						*/
						cstmt.executeUpdate();
						if(cstmt!=null) cstmt.close();	
						break;
					
					case GauceDataRow.TB_JOB_DELETE:
						cstmt = conn.prepareCall(arr_sql[11].toString());	// 계약 정보 등록
						
						//stmt.setGauceDataRow(rows[i]);
						cstmt.setString(dCnt++, rows[i].getString(colNm_ClientSid));
						cstmt.setString(dCnt++, rows[i].getString(colNm_ContDate));
						/*
						stmt.bindColumn(dCnt++, colNm_ClientSid);
						stmt.bindColumn(dCnt++, colNm_ContDate);
						*/
						cstmt.executeUpdate();
						if(cstmt!=null) cstmt.close();
						break;
					}
				}
			}  if (ds3 != null) {
				GauceDataRow[] 		rows = ds3.getDataRows();
				GauceDataColumn[] 	cols = ds3.getDataColumns();
				
				//StringUtil.printMsg("DS3 ROW",ds3.getDataRowCnt()+"",this);
				//StringUtil.printMsg("DS3 ROW",ds3.getDataColCnt()+"",this);
				
				int colNm_ClientSid             = ds3.indexOfColumn("CLIENT_SID");
				int colNm_BranchCd              = ds3.indexOfColumn("BRANCH_CD");
				int colNm_BranchNm              = ds3.indexOfColumn("BRANCH_NM");
				int colNm_AreaCd                = ds3.indexOfColumn("AREA_CD");
				int colNm_ClientDown_yn         = ds3.indexOfColumn("CLIENT_DOWN_YN");
				int colNm_Empno                 = ds3.indexOfColumn("EMPNO");
				int colNm_TelNo                 = ds3.indexOfColumn("TEL_NO");
				int colNm_MobileNo              = ds3.indexOfColumn("MOBILE_NO");
				int colNm_FaxNo                 = ds3.indexOfColumn("FAX_NO");
				int colNm_BranchUrl             = ds3.indexOfColumn("BRANCH_URL");
				 
				
				int iCnt = 1;
				int dCnt = 1;
				int uCnt = 1;
				
				for(int i = 0; i < rows.length; i++) {
					
					switch(rows[i].getJobType()){
					case GauceDataRow.TB_JOB_INSERT:
						
						cstmt = conn.prepareCall(arr_sql[6].toString());	// 지점 정보 등록 
						//StringUtil.printMsg("클라이언트 SiD DS3", fClientSid, this);
						//stmt.setGauceDataRow(rows[i]);
						if (fClientSid == 0) {
							//StringUtil.printMsg("클라이언트 SiD DS3", fClientSid, this);
							cstmt.setString(iCnt++, rows[i].getString(colNm_ClientSid));
							//stmt.bindColumn(iCnt++, colNm_ClientSid);
						} else {
							//StringUtil.printMsg("클라이언트 SiD DS3", fClientSid, this);
							cstmt.setString(iCnt++, rows[i].getString(fClientSid));
							//stmt.setInt(iCnt++, fClientSid);
						}
						cstmt.setString(iCnt++, rows[i].getString(colNm_BranchCd));
						cstmt.setString(iCnt++, rows[i].getString(colNm_BranchNm));
						cstmt.setString(iCnt++, rows[i].getString(colNm_AreaCd));
						cstmt.setString(iCnt++, rows[i].getString(colNm_ClientDown_yn));
						cstmt.setString(iCnt++, rows[i].getString(colNm_Empno));
						cstmt.setString(iCnt++, rows[i].getString(colNm_TelNo));
						cstmt.setString(iCnt++, rows[i].getString(colNm_MobileNo));
						cstmt.setString(iCnt++, rows[i].getString(colNm_FaxNo));
						cstmt.setString(iCnt++, rows[i].getString(colNm_BranchUrl));
						cstmt.setString(iCnt++, iParamEmpno);
						cstmt.setString(iCnt++, iParamIp);
						/*
						stmt.bindColumn(iCnt++, colNm_BranchCd);
						stmt.bindColumn(iCnt++, colNm_BranchNm);
						stmt.bindColumn(iCnt++, colNm_AreaCd);
						stmt.bindColumn(iCnt++, colNm_ClientDown_yn);
						stmt.bindColumn(iCnt++, colNm_Empno);
						stmt.bindColumn(iCnt++, colNm_TelNo);
						stmt.bindColumn(iCnt++, colNm_MobileNo);
						stmt.bindColumn(iCnt++, colNm_FaxNo);
						stmt.bindColumn(iCnt++, colNm_BranchUrl);
						stmt.setString(iCnt++, iParamEmpno);
						stmt.setString(iCnt++, iParamIp);
						*/
						cstmt.executeUpdate();
						if(cstmt!=null) cstmt.close();	
						
						break;
					case GauceDataRow.TB_JOB_UPDATE:
						cstmt = conn.prepareCall(arr_sql[9].toString());	// 지점 정보 등록 
						
						//stmt.setGauceDataRow(rows[i]);
						cstmt.setString(uCnt++, rows[i].getString(colNm_BranchNm));
						cstmt.setString(uCnt++, rows[i].getString(colNm_AreaCd));
						cstmt.setString(uCnt++, rows[i].getString(colNm_ClientDown_yn));
						cstmt.setString(uCnt++, rows[i].getString(colNm_Empno));
						cstmt.setString(uCnt++, rows[i].getString(colNm_TelNo));
						cstmt.setString(uCnt++, rows[i].getString(colNm_MobileNo));
						cstmt.setString(uCnt++, rows[i].getString(colNm_FaxNo));
						cstmt.setString(uCnt++, rows[i].getString(colNm_BranchUrl));
						cstmt.setString(uCnt++, iParamEmpno);
						cstmt.setString(uCnt++, iParamIp);
						cstmt.setString(uCnt++, rows[i].getString(colNm_ClientSid));
						cstmt.setString(uCnt++, rows[i].getString(colNm_BranchCd));
						/*
						stmt.bindColumn(uCnt++, colNm_BranchNm);
						stmt.bindColumn(uCnt++, colNm_AreaCd);
						stmt.bindColumn(uCnt++, colNm_ClientDown_yn);
						stmt.bindColumn(uCnt++, colNm_Empno);
						stmt.bindColumn(uCnt++, colNm_TelNo);
						stmt.bindColumn(uCnt++, colNm_MobileNo);
						stmt.bindColumn(uCnt++, colNm_FaxNo);
						stmt.bindColumn(uCnt++, colNm_BranchUrl);	
						stmt.setString(uCnt++, iParamEmpno);
						stmt.setString(uCnt++, iParamIp);
						stmt.bindColumn(uCnt++, colNm_ClientSid);
						stmt.bindColumn(uCnt++, colNm_BranchCd);
						*/
						cstmt.executeUpdate();
						if(cstmt!=null) cstmt.close();	
						break;
					
					case GauceDataRow.TB_JOB_DELETE:
						cstmt = conn.prepareCall(arr_sql[12].toString());	// 지점 정보 등록 
						
						//stmt.setGauceDataRow(rows[i]);
						cstmt.setString(dCnt++, rows[i].getString(colNm_ClientSid));
						cstmt.setString(dCnt++, rows[i].getString(colNm_BranchCd));
						/*
						stmt.bindColumn(dCnt++, colNm_ClientSid);
						stmt.bindColumn(dCnt++, colNm_BranchCd);
						*/
						cstmt.executeUpdate();
						if(cstmt!=null) cstmt.close();	
						break;
					}
				}
			}  if (ds4 != null) {
				
				GauceDataRow[] 		rows = ds4.getDataRows();
				GauceDataColumn[] 	cols = ds4.getDataColumns();
				

				int colNm_ClientSid             = ds4.indexOfColumn("CLIENT_SID");
				int colNm_FrDate                = ds4.indexOfColumn("FR_DATE");
				int colNm_ToDate                = ds4.indexOfColumn("TO_DATE");
				int colNm_CommiRate             = ds4.indexOfColumn("COMMI_RATE");
				int colNm_Weekend_yn            = ds4.indexOfColumn("WEEKEND_YN");				
				
				int iCnt = 1;
				int dCnt = 1;
				int uCnt = 1;
				
				for(int i = 0; i < rows.length; i++) {
					switch(rows[i].getJobType()){
					case GauceDataRow.TB_JOB_INSERT:
						//StringUtil.printMsg("수수료율 등록 ,,,,,,,,,,,,,,,,,,,,",this);
						cstmt = conn.prepareCall(arr_sql[15].toString());	// 수수료율 등록
						//StringUtil.printMsg("쿼리 = ", arr_sql[15].toString() ,this);
						
						//stmt.setGauceDataRow(rows[i]);

						//StringUtil.printMsg("클라이언트 SiD DS4", fClientSid, this);
						if (fClientSid == 0) {
							//StringUtil.printMsg("클라이언트 SiD DS4 0 일경우 client_sid", rows[i].getString(colNm_ClientSid), this);
							cstmt.setString(iCnt++, rows[i].getString(colNm_ClientSid));
							//stmt.bindColumn(iCnt++, colNm_ClientSid);
						} else {
							cstmt.setString(iCnt++, rows[i].getString(fClientSid));
							//stmt.setInt(iCnt++, fClientSid);
						}

						//StringUtil.printMsg("시작일자 = ", rows[i].getString(colNm_FrDate) ,this);
						//StringUtil.printMsg("종료일자 = ", rows[i].getString(colNm_ToDate) ,this);
						//StringUtil.printMsg("할인율    = ", rows[i].getString(colNm_CommiRate) ,this);
						//StringUtil.printMsg("주말        = ", rows[i].getString(colNm_Weekend_yn) ,this);
						cstmt.setString(iCnt++, rows[i].getString(colNm_FrDate));
						cstmt.setString(iCnt++, rows[i].getString(colNm_ToDate));
						cstmt.setString(iCnt++, rows[i].getString(colNm_CommiRate));
						cstmt.setString(iCnt++, rows[i].getString(colNm_Weekend_yn));
						cstmt.setString(iCnt++, iParamEmpno);
						cstmt.setString(iCnt++, iParamIp);
						cstmt.setString(iCnt++, iParamEmpno);
						cstmt.setString(iCnt++, iParamIp);
						/*
						stmt.bindColumn(iCnt++, colNm_FrDate);
						stmt.bindColumn(iCnt++, colNm_ToDate);
						stmt.bindColumn(iCnt++, colNm_CommiRate);
						stmt.bindColumn(iCnt++, colNm_Weekend_yn);
						stmt.setString(iCnt++, iParamEmpno);
						stmt.setString(iCnt++, iParamIp);
						stmt.setString(iCnt++, iParamEmpno);
						stmt.setString(iCnt++, iParamIp);
						*/
						cstmt.executeUpdate();
						if(cstmt!=null) cstmt.close();	
						break;
					case GauceDataRow.TB_JOB_UPDATE:
						cstmt = conn.prepareCall(arr_sql[16].toString());	// 수수료 수정
						//StringUtil.printMsg("수정쿼리",arr_sql[16].toString(),this);
						
						//stmt.setGauceDataRow(rows[i]);
						cstmt.setString(uCnt++, rows[i].getString(colNm_ToDate));
						cstmt.setString(uCnt++, rows[i].getString(colNm_CommiRate));
						cstmt.setString(uCnt++, rows[i].getString(colNm_Weekend_yn));
						cstmt.setString(uCnt++, iParamEmpno);
						cstmt.setString(uCnt++, iParamIp);
						cstmt.setString(uCnt++, iParamEmpno);
						cstmt.setString(uCnt++, iParamIp);
						cstmt.setString(uCnt++, rows[i].getString(colNm_ClientSid));
						cstmt.setString(uCnt++, rows[i].getString(colNm_FrDate));
						cstmt.setString(uCnt++, rows[i].getString(colNm_Weekend_yn));
						/*
						stmt.bindColumn(uCnt++, colNm_ToDate);
						stmt.bindColumn(uCnt++, colNm_CommiRate);
						stmt.bindColumn(uCnt++, colNm_Weekend_yn);						
						stmt.setString(uCnt++, iParamEmpno);
						stmt.setString(uCnt++, iParamIp);
						stmt.bindColumn(uCnt++, colNm_ClientSid);
						stmt.bindColumn(uCnt++, colNm_FrDate);
						stmt.bindColumn(uCnt++, colNm_Weekend_yn);
						*/
						cstmt.executeUpdate();
						if(cstmt!=null) cstmt.close();	
						break;
					
					case GauceDataRow.TB_JOB_DELETE:
						cstmt = conn.prepareCall(arr_sql[17].toString());	// 수수료 삭제
						
						//stmt.setGauceDataRow(rows[i]);
						cstmt.setString(dCnt++, rows[i].getString(colNm_ClientSid));
						cstmt.setString(dCnt++, rows[i].getString(colNm_FrDate));
						cstmt.setString(dCnt++, rows[i].getString(colNm_Weekend_yn));
						/*
						stmt.bindColumn(dCnt++, colNm_ClientSid);
						stmt.bindColumn(dCnt++, colNm_FrDate);
						stmt.bindColumn(dCnt++, colNm_Weekend_yn);
						*/
						cstmt.executeUpdate();
						if(cstmt!=null) cstmt.close();	
						break;
					}
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
			if(cstmt!=null) cstmt.close();
		}		
	}
}
