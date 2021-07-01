package sales.menu.cq;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
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

import sales.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.HDConstant;

public class Cq030S extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		// 조회 
		arr_sql[0].append("SELECT 		\n")
					.append("       SALES.FN_DETAIL_NM ( 'RM014',T2.DEPART_TIME)  AS  DEPART_TIME		\n")   /* 출경시간  */
					.append("		,SALES.FN_DETAIL_NM ( 'SY009',T3.SEX)  AS SEX 									\n")                       /* 성별 :SY009  */
					.append("      ,T4.GOODS_NM                                   AS  GOODS_NM		\n")      /* 상품      */
					.append("      ,SALES.FN_DETAIL_NM ( 'RV017',T2.CLASS)        AS  CLASS		\n")         /* 반        */
					.append("      ,SUBSTR(T2.TEAMS,1,2)                          AS  TEAMS		\n")         /* 조        */
					.append("      ,T2.TOUR_NO                                    AS  TOUR_NO		\n")       /* 순번      */
					.append("      ,T3.CUST_NM                                    AS  CUST_NM		\n")       /* 성명      */
					.append("      ,T3.BIRTHDAY                                   AS  BIRTHDAY		\n")      /* 생년월일  */
					.append("      ,T3.COMPANY_NM || ' ' ||T3.POSITIONS           AS  COMPANY_NM		\n")    /* 직장/직위 */
//					.append("      ,CASE WHEN T3.COUNTRY_GU IN ('10', '20') THEN		\n")
//					.append("            T5.ADDRESS1 ||' '||T5.ADDRESS2		\n") 
//					.append("       ELSE																					\n")
//					.append("            T3.ADDRESS1																		\n")
//					.append("       END                                         AS  ADDRESS1								\n")      /* 사는 곳   */
					.append ("     ,CASE WHEN T3.COUNTRY_GU IN ('10') THEN                                                          \n")
					//주소 부르는 부분 수정 by 20140206 심동현
					.append ("             SUBSTR(RTRIM(T3.ADDRESS1)||' '||T3.ADDRESS2||' ',1, INSTR(RTRIM(T3.ADDRESS1)||' '||T3.ADDRESS2||' ' , ' ',1,2)-1 )	\n")
					//.append("            SUBSTR(T5.ADDRESS1 ||' '||T5.ADDRESS2,1, LOCATE (' ',T5.ADDRESS1 ||' '||T5.ADDRESS2||' '))					\n")
					//.append("          ||SUBSTR(T5.ADDRESS1 ||' '||T5.ADDRESS2, LOCATE (' ',T5.ADDRESS1 ||' '||T5.ADDRESS2||' ') + 1 ,   				\n")
					//.append("          LOCATE (' ',T5.ADDRESS1 ||' '||T5.ADDRESS2||' ', LOCATE (' ',T5.ADDRESS1 ||' '||T5.ADDRESS2||' ') + 1  ))  	\n")  
					.append ("          ELSE                                                                                                  \n")
					.append ("               T3.ADDRESS1                                                                                      \n")
					.append ("          END                                            AS ADDRESS1                                            \n")
					.append("      ,CASE WHEN T3.COUNTRY_GU IN ('10') THEN											\n")
					.append("            ''																					\n")
					.append("       ELSE																					\n")
					.append("            SALES.FN_DETAIL_NM ( 'SY005',T3.COUNTRY_CD) || ' ' ||								\n") 
					.append("            SALES.FN_DETAIL_NM ( 'SY005',T3.NATION_CD )										\n")
					.append("       END                                            AS  COUNTRY_CD							\n")  /* 국적/민족    */
					.append("      ,CASE WHEN T3.COUNTRY_GU IN ('10') THEN											\n")
					.append("            ''																					\n")
					.append("       ELSE																					\n")
					.append("            T3.PASS_NO																			\n")
					.append("       END                                            AS  PASS_NO								\n")      /* 여권번호    */
					.append("      ,T4.GOODS_NM                               || '-' ||										\n")    
					.append("       SALES.FN_DETAIL_NM ( 'RV017',T2.CLASS) || '-' ||										\n")     
					.append("       SUBSTR(T2.TEAMS,1,2)                      || '-' ||										\n")     
					.append("       T2.TOUR_NO			AS TAG_NK																	\n") /* 관광번호   */
					.append("      ,CASE WHEN T2.STATUS_CD IN ('RC','NS') THEN                                             	\n")
					.append("  		    	  '취소'                                                                        \n")
					.append("		     END AS STATUS_CD 																	\n")
				  
					.append("  FROM SALES.TRV010 T1																			\n")    
					.append("      ,SALES.TRV020 T2																			\n")    
					.append("      ,SALES.TCU010 T3 LEFT OUTER JOIN  SALES.TSY110 T5 ON  T3.ZIP_SID    = T5.ZIP_SID			\n")    
					.append("      ,SALES.TRM200 T4																			\n")    
					.append(" WHERE T1.ACCEPT_SID  = T2.ACCEPT_SID															\n")    
					.append("   AND T2.CUST_SID    = T3.CUST_SID															\n")    
					.append("   AND T1.GOODS_SID   = T4.GOODS_SID															\n")    
					.append("   AND T2.SAUP_GU     <> '65'																								\n");
		
    	
		arr_sql[1].append (" SELECT																										    		\n")
					  .append ("    T2.CUST_SID AS CUST_SID,                   																			\n")
					  .append (" 	T4.GOODS_NM AS nights_days1,																						\n")
					  .append (" 	T4.SHORT_NM AS nights_days2,																						\n")
					  .append ("	'('||sales.fn_detail_nm('RV017',t2.class)||'/'||SUBSTR(t2.teams,1,2)||')' AS class_teams, 							\n")
					  .append ("	SUBSTR(t2.depart_date,1,4)||'.'||SUBSTR(t2.depart_date,5,2)||'.'||SUBSTR(t2.depart_date,7,2) AS depart_date, 		\n")
					  .append ("	SUBSTR(t2.arrive_date,1,4)||'.'||SUBSTR(t2.arrive_date,5,2)||'.'||SUBSTR(t2.arrive_date,7,2) AS arrive_date, 		\n")
					  .append ("	t3.cust_nm AS cust_nm,                     																			\n")
					  .append ("    RTRIM(t3.first_nm)||' '||RTRIM(t3.last_nm) AS cust_enm, 															\n")
					  .append ("	SUBSTR(t3.birthday,1,4)||'.'||SUBSTR(t3.birthday,5,2)||'.'||SUBSTR(t3.birthday,7,2) AS birthday, 					\n")
					  .append ("	SUBSTR(t3.birthday,1,4)||'.'||SUBSTR(t3.birthday,5,2)||'.'||SUBSTR(t3.birthday,7,2) || ' -' AS birthdayN,			\n")
					  .append ("    t6.upjang_nm AS upjang_eng_nm,             																			\n")
					  .append ("	sales.fn_room_type_cd(t2.room_type_sid) AS room_type, 																\n")
					  .append ("	t3.manage_no AS manage_no, 																							\n")
					  .append ("    SUBSTR(T3.MANAGE_NO,1,1)||'/'||T3.MANAGE_NO            AS PIC_ADDR,												\n")	  /* [사진FILE명] */					  
					  .append ("	CASE WHEN t8.dong_nm <> ''                																			\n")
					  .append ("         THEN RTRIM(t8.dong_nm)||'동'          																			\n")
					  .append ("         ELSE '' END AS dong_nm,               																			\n")
					  .append ("	CASE WHEN t7.floors <> ''                  																			\n")
					  .append ("         THEN RTRIM(t7.floors)||'층'          	 																		\n")
					  .append ("         ELSE '' END AS floors,                																			\n")
					  .append ("    RTRIM(t7.room_no)||'호' AS room_no,        																			\n")
					  .append ("    SUBSTR(t2.depart_date,3,6) AS bal_no,      																			\n")
					  .append ("    SUBSTR(t1.accept_no,1,5)||'-'||SUBSTR(t1.accept_no,6,6)||'-'||SUBSTR(t1.accept_no,12,3) AS accept_no, 				\n")
					  .append ("    CASE WHEN T2.CUST_GU ='1' THEN   																					\n")
					  .append ("    		CASE WHEN T3.COUNTRY_GU IN ('10','20') THEN t2.unity_no 													\n")
					  .append ("   				 ELSE								    t3.manage_no END												\n")
					  .append ("    	 WHEN T2.CUST_GU ='2' THEN																						\n")
					  .append ("  			(SELECT MAX(N_CARD_NO) FROM SALES.TCU072 WHERE CUST_SID=T3.CUST_SID) 										\n")
					  .append (" 		 END AS unity_no, 																								\n")
					  .append ("    CASE WHEN T2.CUST_GU ='1' THEN   																					\n")
					  .append ("    		CASE WHEN T3.COUNTRY_GU IN ('10','20') THEN '*'||t2.unity_no||'*'											\n")
					  .append ("   				 ELSE								    '*'||t3.manage_no||'*' END										\n")
					  .append ("    	 WHEN T2.CUST_GU ='2' THEN																						\n")
					  .append ("  			(SELECT '*'|| MAX(N_CARD_NO) ||'*' FROM SALES.TCU072 WHERE CUST_SID=T3.CUST_SID) 							\n")
					  .append (" 		 END AS unity_no1, 																								\n")
					  .append ("    sales.fn_detail_nm('SY009',t3.sex) AS sex, 																			\n")
					  .append ("    t3.company_nm||' '||t3.positions AS company_nm, 																	\n")
					  .append ("         CASE WHEN T3.COUNTRY_GU IN ('10') THEN                                                          				\n")
					  //주소 부르는 부분 수정 by 20140206 심동현
					  .append ("             SUBSTR(RTRIM(T3.ADDRESS1)||' '||T3.ADDRESS2||' ',1, INSTR(RTRIM(T3.ADDRESS1)||' '||T3.ADDRESS2||' ' , ' ',1,2)-1 )	\n")
					  
					  //.append ("           RTRIM(T5.ADDRESS1) ||' '|| SUBSTRING(RTRIM(T5.ADDRESS2),1, POSITION (' ' IN T5.ADDRESS2||' '))	\n")
					  //.append("            SUBSTR(T5.ADDRESS1 ||' '||T5.ADDRESS2,1, LOCATE (' ',T5.ADDRESS1 ||' '||T5.ADDRESS2||' '))					\n")
					  //.append("          ||SUBSTR(T5.ADDRESS1 ||' '||T5.ADDRESS2, LOCATE (' ',T5.ADDRESS1 ||' '||T5.ADDRESS2||' ') + 1 ,   				\n")
					  //.append("          LOCATE (' ',T5.ADDRESS1 ||' '||T5.ADDRESS2||' ', LOCATE (' ',T5.ADDRESS1 ||' '||T5.ADDRESS2||' ') + 1  ))  	\n")  
					  .append ("          ELSE                                                                                                  		\n")
					  .append ("               T3.ADDRESS1                                                                                      		\n")
					  .append ("          END                                            AS ADDRESS1,                                            		\n")

					  .append ("    	SUBSTR(t2.depart_date,1,4)||'년'||         																		\n")
					  .append ("    	SUBSTR(t2.depart_date,5,2)||'월'||         																		\n")
					  .append ("    	SUBSTR(t2.depart_date,7,2)||'일 ~ '||      																		\n")
					  .append ("    	SUBSTR(t2.arrive_date,1,4)||'년'||         																		\n")
					  .append ("    	SUBSTR(t2.arrive_date,5,2)||'월'||         																		\n")
					  .append ("    	SUBSTR(t2.arrive_date,7,2)||'일          '   																	\n")
					  .append ("         												AS fr_to_date1,  												\n")

		.append ("    CASE WHEN (T2.TEAMS = '88') THEN             																		\n")
		.append ("    	SUBSTR(t2.depart_date,1,4)||'년'||         																		\n")
		.append ("    	SUBSTR(t2.depart_date,5,2)||'월'||         																		\n")
		.append ("    	SUBSTR(t2.depart_date,7,2)||'일 ~ '||      																		\n")
		.append ("    	SUBSTR(t2.arrive_date,1,4)||'년'||         																		\n")
		.append ("    	SUBSTR(t2.arrive_date,5,2)||'월'||         																		\n")
		.append ("    	SUBSTR(t2.arrive_date,7,2)||'일          '   																	\n")
		.append ("    ELSE   																											\n")
		.append ("    	SUBSTR(t2.depart_date,1,4)||'년'||         																		\n")
		.append ("    	SUBSTR(t2.depart_date,5,2)||'월'||         																		\n")
		.append ("    	SUBSTR(t2.depart_date,7,2)||'일 ~ '||      																		\n")
		.append ("    	SUBSTR(t2.arrive_date,1,4)||'년12월31일          '  															\n")
		.append ("    END AS fr_to_date2,  																								\n")
					  
					  
					  
					  .append ("    CASE WHEN T2.CUST_GU ='1' AND T2.GOODS_SID=50 THEN             														\n")
					  .append ("         '내금'||'-'||RTRIM(sales.fn_detail_nm('RV017',t2.class))||'-'||SUBSTR(t2.teams,1,2)||'-'||TO_CHAR(TO_NUMBER(t2.tour_no)) \n")
					  .append ("         WHEN T2.CUST_GU ='1' AND T2.GOODS_SID=51 THEN             														\n")
					  .append ("         '골프'||'-'||RTRIM(sales.fn_detail_nm('RV017',t2.class))||'-'||SUBSTR(t2.teams,1,2)||'-'||TO_CHAR(TO_NUMBER(t2.tour_no)) \n")
					  .append ("         WHEN T2.CUST_GU ='1' AND T2.GOODS_SID IN(35,54) THEN             														\n")
					  .append ("         '개성'||'-'||RTRIM(sales.fn_detail_nm('RV017',t2.class))||'-'||SUBSTR(t2.teams,1,2)||'-'||TO_CHAR(TO_NUMBER(t2.tour_no)) \n")
					  .append ("         WHEN T2.CUST_GU ='1' AND T2.GOODS_SID<>50 THEN             														\n")
					  .append ("         '외금'||'-'||RTRIM(sales.fn_detail_nm('RV017',t2.class))||'-'||SUBSTR(t2.teams,1,2)||'-'||TO_CHAR(TO_NUMBER(t2.tour_no)) \n")
					  .append ("		 WHEN T2.CUST_GU = '2' AND T2.CLASS = '96' THEN 																		\n")
					  .append ("         '외금'||'-'||RTRIM(sales.fn_detail_nm('RV017',t2.class))||'-'||SUBSTR(t2.teams,1,2)||'-'||TO_CHAR(TO_NUMBER(t2.tour_no)) \n")
					  .append ("         ELSE '사업자폼으로 뽑아주세요' END AS work_no1,        						\n")
					  
		.append ("    CASE WHEN T2.TEAMS = '88' THEN '현대-인솔자' 													\n")
		.append ("         ELSE (SELECT WORK_NO FROM SALES.TCM010 WHERE CUST_SID=T3.CUST_SID) END AS work_no2,        						\n")
					  
					  
					  .append(" RTRIM(SALES.FN_DETAIL_NM ( 'SY005',T3.COUNTRY_CD))|| ' / ' || SALES.FN_DETAIL_NM ( 'SY005',T3.NATION_CD)  AS COUNTRY_NM      	\n")
					  .append(",SALES.FN_DETAIL_NM ( 'SY005',T3.NATION_CD )    AS NATION_NM                         									\n")
					  .append(",CASE WHEN T3.COUNTRY_GU <> '10' THEN SALES.FN_DETAIL_NM ( 'CU008',T3.PASS_TYPE)  END  									\n")
					  .append("                                              AS PASS_TYPE                           									\n")
					  .append(",CASE WHEN T3.COUNTRY_GU <> '10' THEN T3.PASS_NO END                                   									\n")
					  .append("                                              AS PASS_NO                             									\n")
					  .append(",SALES.FN_DETAIL_NM ( 'SY009',T3.SEX)           AS SEX_NM                            									\n")
					  .append(",T3.SEX                                         AS SEX_ENM                           									\n")
			
					  .append(",(SELECT RTRIM(ITEM15)                                                                        							\n")
					  .append("  FROM SALES.TSY010 T9                                                                 									\n")
					  .append(" WHERE HEAD = 'SY005'                                                                 	 								\n")
					  .append("   AND DETAIL  =  T3.COUNTRY_CD                                                       	 								\n")
					  .append("   AND DETAIL  >  ' ')                                                                 									\n")
					  .append("|| ' / ' ||                                                                                                              \n")
					  .append("(SELECT RTRIM(ITEM15)                                                                        							\n")	    
					  .append("FROM SALES.TSY010 T9                                                                 								    \n")
					  .append("WHERE HEAD = 'SY005'                                                                 	 							    \n")
					  .append("AND DETAIL  =  T3.NATION_CD                                                       	 							        \n")
					  .append("AND DETAIL  >  ' ')                       AS COUNTRY_EFNM                                                                \n")
					  .append(",(SELECT ITEM2                                                                         									\n")
					  .append("  FROM SALES.TSY010 T9                                                                 									\n")
					  .append(" WHERE HEAD = 'RV017'                                                                  									\n")
					  .append("   AND DETAIL  =  T2.CLASS                                                             									\n")
					  .append("   AND DETAIL  >  ' ')                        AS CLASS_ENM		    													\n")
					                                                                                                                                    
					  .append(",CASE WHEN T2.CUST_GU ='1' THEN             																			    \n")
					  .append("T4.ENG_NM ||'-'|| (SELECT RTRIM(ITEM2) FROM SALES.TSY010 WHERE HEAD='RV017' AND DETAIL=T2.CLASS AND DETAIL>' ')          \n")
					  .append("||'-'||SUBSTR(t2.teams,1,2)||'-'||TO_CHAR(TO_NUMBER(t2.tour_no))                                                           \n")
					  .append("WHEN T2.CUST_GU = '2' AND T2.TEAMS = '88' THEN '' 											                            \n")
					  .append("ELSE t3.work_no END AS WORK_ENO                                                                                          \n")
					  .append(", RTRIM(T3.ENG_COMPANY_NM) || ' ' ||RTRIM(T3.ENG_POSITION) AS COMPANY_ENM												\n")
					  .append(", RTRIM(T3.ENG_ADDR1) || ' ' ||RTRIM(T3.ENG_ADDR2) AS ADDRESS1ENM         												\n")
					  .append(", T2.REMARKS                                       AS REMARKS         													\n")
					  .append(",CASE WHEN (T1.SAUP_SID=1 AND T2.CUST_TYPE IN ('020','021','022','161') ) THEN 'AD'										\n")
					  .append("      WHEN (T2.CUST_GU='1' AND T2.GOODS_SID=51 AND T2.UPJANG_SID=73) THEN 'A'   											\n")
					  .append("      WHEN (T2.CUST_GU='1' AND T2.GOODS_SID=51 AND T2.UPJANG_SID<>73) THEN 'G'   										\n")
					  .append("	 	 ELSE T2.OLD_ROOM_NO END 					  AS SECRET_MARK					  									\n")
					  .append(", T9.GROUP_NM                                      AS GROUP_NM         													\n")
					  .append(", CASE T2.GOODS_SID WHEN 50 THEN 'http://erp.hdasan.com/services/Sales/images/naekum.jpg' 								\n")
					  .append("                    WHEN 54 THEN 'http://erp.hdasan.com/services/Sales/images/ks_pm.jpg'   ELSE '' END AS TAG_NK,  		\n")
					  //.append("                    WHEN 51 THEN 'http://erp.hdasan.com/services/Sales/images/mark_golf.jpg'  ELSE '' END AS TAG_NK,     \n")					  

					  .append ("    CASE WHEN (T2.CUST_GU ='2' OR (T2.CUST_GU ='1' AND T2.GOODS_SID IN (35,54)) ) THEN             						\n")
					  .append ("         '' 																											\n")
					  .append ("         ELSE '※ 재방문 고객께는 10% 할인혜택을 드립니다.' END AS COMMENT1,        												\n")
					  .append ("    CASE WHEN (T2.CUST_GU ='2' OR (T2.CUST_GU ='1' AND T2.GOODS_SID IN (35,54)) ) THEN             						\n")
					  .append ("         ''																												\n")
					  .append ("         ELSE '(동반 1인  포함, 중복할인 불가)' END AS COMMENT2        													\n")
					  
					  .append("    FROM sales.trv010 t1  	LEFT OUTER JOIN sales.tcu020 t9 ON (t1.event_sid=t9.group_sid), 								\n")
					  .append(" 		sales.trv020 t2  	LEFT OUTER JOIN sales.trm040 t7 ON (t2.room_sid=t7.room_sid) 									\n")
					  .append(" 						 	LEFT OUTER JOIN sales.trm020 t8 ON (t7.dong_sid=t8.dong_sid), 								\n")
					  .append("         sales.tcu010 t3 LEFT OUTER JOIN sales.tsy110 t5 ON (t3.zip_sid=t5.zip_sid), 										\n")
					  .append("         sales.trm200 t4, sales.trm010 t6      																			\n")
					  .append("    WHERE t1.accept_sid=t2.accept_sid          																			\n")
					  .append("    	AND t2.cust_sid=t3.cust_sid                																		\n")
					  .append("    	AND t1.goods_sid=t4.goods_sid              																		\n")
					  .append("    	AND t2.upjang_sid=t6.upjang_sid            																		\n")
					  .append("   	AND T2.SAUP_GU     <> '65'																							\n");

	}

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
	}	
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
//		System.out.println("# Command : 조회/리포팅");

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {
			// 검색시 조건
			int     sSaupSid = HDUtil.nullCheckNum(greq.getParameter("sSaupSid"));
			String  sCountryGu = HDUtil.nullCheckStr(greq.getParameter("sCountryGu"));
			String  sDepartDate = HDUtil.nullCheckStr(greq.getParameter("sDepartDate"));
			String  sDepartTime = HDUtil.nullCheckStr(greq.getParameter("sDepartTime"));
			int 	sGoodsSid = HDUtil.nullCheckNum(greq.getParameter("sGoodsSid"));
			String  sClass = HDUtil.nullCheckStr(greq.getParameter("sClass"));
			String  sTeams = HDUtil.nullCheckStr(greq.getParameter("sTeams"));
			String  sManageNo = HDUtil.nullCheckStr(greq.getParameter("sManageNo"));
			String  sStatusCd = HDUtil.nullCheckStr(greq.getParameter("sStatusCd"));


//			StringUtil.printMsg("sStatusCd ::", sStatusCd+"::", this);
			//System.out.println(sSaupSid+":"+sCountryGu+":"+sDepartDate+":"+sDepartTime+":"+sGoodsSid+":"+sClass+":"+sTeams+":"+sManageNo);
			

			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));

	            
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 


            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//DS1=ds1, 					DEFAULT=ds9 (리포트용)
            	int sCnt1 = 1;
            	
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
						
					if (0!=sSaupSid) {
						arr_sql[0].append("   AND T1.SAUP_SID    = ?		\n");               /* 사업소 */
					}
					if (!"".equals(sCountryGu)) {
						arr_sql[0].append("   AND T3.COUNTRY_GU  = ?		\n");             /* 국적구분      */
					}
					if (!"".equals(sDepartDate)) {
						arr_sql[0].append("   AND T2.DEPART_DATE = ?		\n");            /* 출경일자 */
					}
					if (!"".equals(sDepartTime)) {
						arr_sql[0].append("   AND T2.DEPART_TIME = ?		\n");            /* 출경시간 */
					}
					if (0!=sGoodsSid) {
						arr_sql[0].append("   AND T1.GOODS_SID   = ?		\n");              /* 상품SID  */
					}
					if (!"".equals(sClass)) {
						arr_sql[0].append("   AND T2.CLASS       = ?		\n");                  /* 반 코드 */
					}
					if (!"".equals(sTeams)) {
						arr_sql[0].append("   AND T2.TEAMS       = ?		\n");                  /* 조      */
					}
					if (!"".equals(sManageNo)) {
						arr_sql[0].append("   AND T3.MANAGE_NO   = ?		\n");              /* 주민/여권번호 */
					}
					if ("false".equals(sStatusCd)) {
						arr_sql[0].append("   AND T2.STATUS_CD   IN ('RA','RR' , 'DP' ,'AR')	\n");
					}
					
					arr_sql[0].append("ORDER BY T2.DEPART_TIME		\n")    
					.append("        ,T4.GOODS_CD		\n")    
					.append("        ,T2.CLASS		\n")    
					.append("        ,T2.TEAMS		\n")      
					.append("        ,T2.TOUR_NO		\n")    
					.append("        ,T2.RSV_SID 		\n");
					//StringUtil.printMsg("조회쿼리",arr_sql[0].toString(),this);
					cstmt = conn.prepareCall(arr_sql[0].toString());

					if (0 != sSaupSid) 
						cstmt.setInt(sCnt1++, sSaupSid);
					if (!"".equals(sCountryGu))
						cstmt.setString(sCnt1++, sCountryGu);
					if (!"".equals(sDepartDate))
						cstmt.setString(sCnt1++, sDepartDate);
					if (!"".equals(sDepartTime))
						cstmt.setString(sCnt1++, sDepartTime);							
					if (0 != sGoodsSid) 
						cstmt.setInt(sCnt1++, sGoodsSid);
					if (!"".equals(sClass))
						cstmt.setString(sCnt1++, sClass);
					if (!"".equals(sTeams))
						cstmt.setString(sCnt1++, sTeams);
					if (!"".equals(sManageNo))
						cstmt.setString(sCnt1++, sManageNo);							
					
					rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
				}
            	
            	if(dSets[i].getName().equals("ds9")){
					GauceDataSet ds1 = gis.read("DEFAULT");

					int sCnt2 = 1;
					
					if (0 !=sSaupSid)
						arr_sql[1].append (" AND t1.saup_sid = ? \n");
					if (!"".equals(sCountryGu))
						arr_sql[1].append (" AND t3.country_gu = ? \n");
					if (!"".equals(sDepartDate))
						arr_sql[1].append (" AND t2.depart_date = ? \n");
					if (!"".equals(sDepartTime))
						arr_sql[1].append (" AND t2.depart_time = ? \n");							
					if (0!=sGoodsSid)
						arr_sql[1].append (" AND t1.goods_sid = ? \n");
					if (!"".equals(sClass))
						arr_sql[1].append (" AND t2.class = ? \n");
					if (!"".equals(sTeams))
						arr_sql[1].append (" AND t2.teams = ? \n");
					if (!"".equals(sManageNo))
						arr_sql[1].append (" AND t3.manage_no = ? \n");
					if ("false".equals(sStatusCd)) {
						arr_sql[1].append (" AND T2.STATUS_CD   IN ('RA','RR' , 'DP' ,'AR')	\n");
					}

					arr_sql[1].append (" ORDER BY t2.depart_time,t4.goods_cd,t2.class,t2.teams,t2.tour_no,t2.rsv_sid \n");
					//System.out.println("# 명단 출력 쿼리  : " + arr_sql[1].toString());
					cstmt = conn.prepareCall(arr_sql[1].toString());

					if (0 != sSaupSid) 
						cstmt.setInt(sCnt2++, sSaupSid);
					if (!"".equals(sCountryGu))
						cstmt.setString(sCnt2++, sCountryGu);
					if (!"".equals(sDepartDate))
						cstmt.setString(sCnt2++, sDepartDate);
					if (!"".equals(sDepartTime))
						cstmt.setString(sCnt2++, sDepartTime);							
					if (0 != sGoodsSid) 
						cstmt.setInt(sCnt2++, sGoodsSid);
					if (!"".equals(sClass))
						cstmt.setString(sCnt2++, sClass);
					if (!"".equals(sTeams))
						cstmt.setString(sCnt2++, sTeams);
					if (!"".equals(sManageNo))
						cstmt.setString(sCnt2++, sManageNo);							

					rs = cstmt.executeQuery(); // DataSet set
					
					rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
					
					//위에서 실행한 결과를  불러서 데이터셋에 주욱 추가하고..
					for(int j=0; j<columnName.length; j++){
						columnName[j] = rsmd.getColumnName(j+1);
						if(rsmd.getColumnTypeName(j+1).equals("NUMERIC"))
							ds1.addDataColumn(new GauceDataColumn(columnName[j], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(j+1)));
						else
							ds1.addDataColumn(new GauceDataColumn(columnName[j], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(j+1)));
					}
					//마지막으로 사진정보를 데이터셋에 추가하고.
					ds1.addDataColumn(new GauceDataColumn("picture_info",GauceDataColumn.TB_STRING));
					ds1.addDataColumn(new GauceDataColumn("picture_url",GauceDataColumn.TB_URL,1024));						
					
					while ( rs.next()) {
						//GauceDataRow row = ds1.newDataRow();								
						for(int j=0; j<columnName.length; j++) {
//									System.out.println("ColumnType:"+i+rsmd.getColumnTypeName(i+1));
//									System.out.println("ColumnName:"+i+rsmd.getColumnName(i+1)+"끝");									
							if(rsmd.getColumnTypeName(j+1).equals("NUMERIC"))
								//row.addColumnValue(rs.getInt(columnName[j]));
								ds1.put(columnName[j], rs.getLong(columnName[j]), rsmd.getColumnDisplaySize(j+1));
							else
								//row.addColumnValue(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]));
								ds1.put(columnName[j], HDUtil.nullCheckStr(rs.getString(columnName[j])), rsmd.getColumnDisplaySize(j+1));
						}		
						//StringUtil.printMsg("사진경로",HDConstant.FILE_DOWNLOAD_PATH_COST+rs.getString("manage_no")+".JPG",this);
									
						//row.addColumnValue(HDConstant.FILE_DOWNLOAD_PATH_COST+rs.getString("manage_no")+".JPG");
						//row.addColumnValue(HDConstant.FILE_DOWNLOAD_PATH_COST+rs.getString("manage_no")+".JPG");
						//row.addColumnValue(HDConstant.PIC_NEW_PATH+rs.getString("PIC_ADDR")+".JPG");
						//row.addColumnValue(HDConstant.PIC_NEW_PATH+rs.getString("PIC_ADDR")+".JPG");
						ds1.put("picture_info",HDConstant.PIC_NEW_PATH+rs.getString("PIC_ADDR")+".JPG", rsmd.getColumnDisplaySize(i+1));
						ds1.put("picture_url",HDConstant.PIC_NEW_PATH+rs.getString("PIC_ADDR")+".JPG", rsmd.getColumnDisplaySize(i+1));
						ds1.heap();//put메소드를 통해 순차적으로 입력된 컬럼의 값을 하나의 행으로 인식하고 GauceDataSet에 적재 ds1.addDataRow(row);
					}//End of while
					gos.write(ds1);
					
					if(rs!=null) rs.close();
					if(cstmt!=null) cstmt.close();
				}
			}
			
			gos.close();
		} catch (SQLException sqle){
			sqle.printStackTrace();
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			e.printStackTrace();
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {

	}

}
