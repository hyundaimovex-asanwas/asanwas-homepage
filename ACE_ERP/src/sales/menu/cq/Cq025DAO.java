package sales.menu.cq;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.menu.cq.Cq025DTO;
import sales.org.application.common.CommonDAO;
import sales.org.common.BaseDataClass;
import sales.org.common.db.Connection;
import sales.org.common.db.PreparedStatement;
import sales.org.common.log.LogUtil;


public class Cq025DAO extends CommonDAO {
    public Cq025DAO() {
        super(); 
    }
    
    // 게시판 목록 불러오는 것...메소드는 2개만 필요한데. 셀렉트와 카운트~
    // 이 list 하나로 카운트도 커버 가능하니 걍 해보자:)
    public ArrayList list(Cq025DTO entity, Connection conn) throws SQLException {
        java.sql.PreparedStatement pstmt = null;
        ResultSet rs = null;
        StringBuffer sql = new StringBuffer();
        ArrayList arrBeans = new ArrayList();
        BaseDataClass data = null; 

       	int 	 	 sSaupSid	   ;	
    	String       sDepartDate   ;	
    	String       sDepartTime   ;	
    	int 		 sGoodsSid     ;	
    	String       sClass        ;	
    	String       sTeams        ;	
    	int 		 sPageNo       ; 
    	String		 sCustGu       ;
        
        sql.append ("")
			.append("  SELECT																														\n")
			.append("  t2.depart_date||t2.class||t4.goods_cd||DIGITS(t2.page_no) AS page_skip										\n")      /* PAGE를 넘기는 변수 */
		    .append("  ,CASE WHEN T1.SAUP_SID = 1 THEN '금강산 관광객 명단'				\n")
		    .append("        WHEN T1.SAUP_SID = 2 THEN '개성 관광객 명단'				\n")
		    .append("        END  AS DOC_TITLE    /* 문서 제목 (2007.08.10 심동현 추가)  */         			\n")
			.append("  ,t2.page_no AS page_no																								\n")        /* PAGE 번호 */
			.append("  ,t3.manage_no AS manage_no																							\n")      /* 관리번호(주민/여권)*/
			.append("  ,SUBSTRING(T3.MANAGE_NO,1,1)||'/'||T3.MANAGE_NO            AS PIC_ADDR												\n")	  /* [사진FILE명] */
			.append("  ,t4.goods_nm||'-'||sales.fn_detail_nm('RV017',t2.class)||'-'||SUBSTR(t2.teams,1,2) ||								\n")  
			.append("  '                    ( Page : '||varchar(t2.page_no)||' )' AS team_nm1												\n")      /* 관광단체명        */
			.append("  ,'( Page : '||varchar(t2.page_no)||' )'|| t4.goods_nm||'-'||sales.fn_detail_nm('RV017',t2.class)||					\n")  
			.append("  '-'||SUBSTR(t2.teams,1,2) AS skip																					\n")  
			.append("  ,t2.depart_date AS depart_date																						\n")      /* 관광기간:시작일자 */
			.append("  ,t2.arrive_date AS arrive_date																						\n")      /* 관광기간:종료일자 */
			.append("  ,CASE WHEN t4.nights = 0               THEN '('||RTRIM(CHAR(t4.days))||'일)'											\n")  
			.append("  ELSE '('||RTRIM(CHAR(t4.nights))||'박'||RTRIM(CHAR(t4.days))||'일)' END AS nights_days								\n")    /*  박수/일수       */
			.append("  ,t4.nights AS nights																									\n")   /* 박수            */
			.append("  ,t4.days AS days																										\n")   /* 일수            */
			.append("  ,t2.STATUS_CD AS STATUS_CD																							\n")   /* 예약상태            */
			
			.append("  ,t3.cust_nm AS cust_nm1																								\n")   /* 성명1        */
			.append("  ,CASE WHEN t3.country_gu IN('10') THEN '' ELSE t3.cust_nm END AS cust_nm2											\n")    /* 성명2        */
			.append("  ,CASE WHEN t3.country_gu IN('10') THEN '' ELSE t3.first_nm||' '||t3.last_nm END AS cust_enm 							\n")   /* 영문성명     */
			.append("  ,SUBSTR(t3.birthday,1,4)||'.'||SUBSTR(t3.birthday,5,2)||'.'||SUBSTR(t3.birthday,7,2) AS birthday						\n")             /* 생년월일     */
			.append("  ,t3.company_nm||t3.positions 																			AS comp_nm1	\n")    /* 직장/직위1   */
//			.append("  ,'=\"' ||SUBSTRING(t3.company_nm||t3.positions,1,13)||'\"&CHAR(10)&\"'||SUBSTRING(t3.company_nm||t3.positions,14,30) ||'\"' AS comp_nm1	\n")    /* 직장/직위1   */
			
			//.append("  ,CASE WHEN t3.country_gu IN('10') THEN '' ELSE t3.company_nm||' '||t3.positions END AS comp_nm2	 					\n")   /* 직장/직위2   */
			//.append("  ,CASE WHEN t3.country_gu IN('10') THEN '' ELSE t3.eng_company_nm||' '||t3.eng_position END AS comp_enm				\n")    /* 영문직장/직위*/
			.append("  ,CASE WHEN T3.COUNTRY_GU='10' THEN																\n")   
			.append("          RTRIM(T5.ADDRESS1) || SUBSTRING(RTRIM(T5.ADDRESS2),1, POSITION (' ' IN T5.ADDRESS2||' '))				\n")		
			.append("        WHEN T3.COUNTRY_GU='20' THEN																						\n")
			.append("            '[영주권]'|| T3.ADDRESS1																						\n")
			.append("        WHEN T3.COUNTRY_GU='30' THEN																						\n")
			.append("            '[시민권]'|| T3.ADDRESS1																						\n")
			.append("        WHEN T3.COUNTRY_GU='40' THEN																						\n")
			.append("            '[외국인]'|| T3.ADDRESS1																						\n")
			.append("       ELSE																												\n")   
			.append("            T3.ADDRESS1																									\n")   
			.append("       END                                            AS ADDRESS1															\n")    /* 사는 곳.내국인이 아니면 앞에 국적표시       */
			.append("      ,CASE WHEN T3.COUNTRY_GU ='10' THEN																				\n")   
			.append("            ''																														\n")   
			.append("       ELSE																														\n")   
			.append("           RTRIM(SALES.FN_DETAIL_NM ( 'SY005',T3.COUNTRY_CD)) || ' / ' || 				\n")
			.append("           RTRIM(SALES.FN_DETAIL_NM ( 'SY005',T3.NATION_CD ))									\n")
			.append("       END                                            AS COUNTRY_CD 												\n")   /* 국적/민족    */
			.append("  ,CASE WHEN t3.country_gu IN('10')THEN '' ELSE sales.fn_detail_nm('CU008',t3.pass_type) END AS pass_type		\n")   /* 여권종류:CU008  */
			.append("  ,CASE WHEN t3.country_gu IN('10')THEN '' ELSE t3.pass_no END AS pass_no														\n")    /* 여권번호    */
			.append("  ,CASE t2.cust_gu WHEN 1 THEN t4.goods_nm||'-'||sales.fn_detail_nm('RV017',t2.class)||'-'||SUBSTR(t2.teams,1,2)||'-'||t2.tour_no    \n")
			.append("                   WHEN 2 THEN sales.fn_detail_nm('RV017',t2.class)||'-'||SUBSTR(t2.teams,1,2) END AS tour_no	\n")   /* 관광번호   */
			
			.append("  ,CASE t3.sex WHEN 'M' THEN '남' WHEN 'F' THEN '여' END as gender_nm \n") //성별
			.append("  ,SUBSTR(t2.depart_date,5,2)||'.'||SUBSTR(t2.depart_date,7,2)||' 08:00' AS sn_datetime  \n") //입경일시
			.append("  ,SUBSTR(t2.depart_date,5,2)||'.'||SUBSTR(t2.depart_date,7,2)||' 17:00' AS ns_datetime  \n") //출경일시
			.append("  ,CASE t2.cust_gu WHEN '1' THEN '개성관광' \n")
			.append("                   WHEN '2' THEN '개성관광 안내보장 업무' END AS north_purpose \n") //출입목적
			.append("  ,'('||SUBSTR(t2.depart_date,1,4)||'.'||SUBSTR(t2.depart_date,5,2)||'.'||SUBSTR(t2.depart_date,7,2)||')' AS title_date  \n") //제목뒤에 날짜			
			.append("  ,sales.fn_detail_nm('RV017',t2.class)||' '||SUBSTR(t2.teams,1,2) ||'조' AS title_class \n") //제목뒤에 반조

			.append("  FROM sales.trv010 t1, sales.trv020 t2, sales.tcu010 t3 LEFT OUTER JOIN sales.tsy110 t5		\n")  
			.append("  ON t3.zip_sid=t5.zip_sid, sales.trm200 t4																				\n")  
			.append("  WHERE t1.accept_sid=t2.accept_sid																					\n")  
			.append("  AND t2.cust_sid=t3.cust_sid																								\n")  
			.append("  AND t1.goods_sid=t4.goods_sid																							\n")  
			.append("  AND T2.CONFIRM_YN='Y'      										\n")	/* 마감체크 */    
			.append("   AND ((T2.STATUS_CD   IN ('RA', 'RR' , 'DP' ,'AR'))  																				\n")    /* 예약자료상태(RR:예약/RC:취소/NS/DP:출경/AR:입경) */
			.append("    OR (T2.STATUS_CD IN('RC', 'NS') AND T2.TOUR_NO <> '')) 																	\n")
			.append("   AND T2.SAUP_GU     <> '65'																								\n");

        

		sSaupSid	= HDUtil.nullCheckNum(entity.getsSaupSid());
		sDepartDate = entity.getsDepartDate();
		sDepartTime = entity.getsDepartTime();
		sGoodsSid   = HDUtil.nullCheckNum(entity.getsGoodsSid());
		sClass      = entity.getsClass();
		sTeams      = entity.getsTeams();
		sPageNo     = HDUtil.nullCheckNum(entity.getsPageNo());
		sCustGu		= HDUtil.nullCheckStr(entity.getsCustGu());
		
		//StringUtil.printMsg("sGoodsSid",sGoodsSid,this);
		//StringUtil.printMsg("sDepartDate",sDepartDate,this);
		//StringUtil.printMsg("sSaupSid",sSaupSid,this);
		//StringUtil.printMsg("sDepartTime",sDepartTime,this);
		//StringUtil.printMsg("sClass",sClass,this);
		//StringUtil.printMsg("sTeams",sTeams,this);
		//StringUtil.printMsg("sPageNo",sPageNo,this);
		
		if (0 < sSaupSid) {
			sql.append ("  AND T1.SAUP_SID = ?     	\n"); /* 사업소 */
		}
		   
		if (!"".equals(sDepartDate)) {
			sql.append ("  AND T2.DEPART_DATE = ?   	\n");  /* 출경일자 */
		}
		
		if (!"".equals(sDepartTime)) {
			sql.append ("  AND T2.DEPART_TIME = ? 	\n");  /* 출경시간 */
		}
		if (0 < sGoodsSid) {
			sql.append ("   AND T1.GOODS_SID = ? 	\n"); /* 상품 */
		}
		
		if (!"".equals(sClass)) {
			sql.append ("  AND T2.CLASS = ? 			\n"); /* 반 코드 */
		}
		
		if (!"".equals(sTeams)) {
			sql.append (" AND T2.TEAMS  = ? 			\n"); /* 팀      */
		}
		
		if (0 < sPageNo) {
			sql.append ("AND T2.PAGE_NO    = ? 		\n");    /* 페이지 NO */
		}
		
		if (!"".equals(sCustGu)) {
			sql.append ("AND T2.CUST_GU    = ? 		\n");    /* 페이지 NO */
		}		

		
		sql.append (" ORDER BY T2.CLASS 				\n")
				.append (" ,T2.TEAMS 					\n")
				.append (" ,T2.TOUR_NO 					\n")
				.append (" ,T2.RSV_SID  				\n");

		
        
		try {
        	//sales.common.StringUtil.printMsg("쿼리",sql.toString(),this);
			int sCnt1 = 1;
        	pstmt =  new PreparedStatement(conn,sql.toString());
//        	pstmt.setString(1, entity.getBrd_gu());
			if (0 < sSaupSid) {
				pstmt.setInt(sCnt1++, sSaupSid);
			}
			   
			if (!"".equals(sDepartDate)) {
				pstmt.setString(sCnt1++, sDepartDate);		
			}
			
			if (!"".equals(sDepartTime)) {
				pstmt.setString(sCnt1++, sDepartTime);		
			}
			if (0 < sGoodsSid) {
				pstmt.setInt(sCnt1++, sGoodsSid);
			}
			
			if (!"".equals(sClass)) {
				pstmt.setString(sCnt1++, sClass);		
			}
			
			if (!"".equals(sTeams)) {
				pstmt.setString(sCnt1++, sTeams);
			}
			
			if (0 < sPageNo) {
				pstmt.setInt(sCnt1++, sPageNo);
			}        

			if (!"".equals(sCustGu)) {
				pstmt.setString(sCnt1++, sCustGu);
			}

	        rs = pstmt.executeQuery();
	        while(rs.next()) {
	            data = new BaseDataClass();
	            data.setValues(rs);
	            arrBeans.add(data);
	        }
	        
	        //System.out.println(sql.toString());

	    }catch(Exception e){
	    	e.printStackTrace();
	        LogUtil.error(e);
	    }finally{
	        if(rs    != null){try{   rs.close();}catch(SQLException e){}}
	        if(pstmt != null){try{pstmt.close();}catch(SQLException e){}}
	    }
    return arrBeans;
    }
}
    
    
    