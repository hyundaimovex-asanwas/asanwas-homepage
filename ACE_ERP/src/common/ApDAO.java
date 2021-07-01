/*
 * 페이징 처리 : 2008-01-18 심동현
 * 
 */
package common;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import kr.co.imjk.board.bean.Tbrd_board_ma_bean;

import common.ApDTO;
import sales.common.HDUtil;
import sales.common.PagingHelper;
import sales.org.application.common.CommonDAO;
import sales.org.common.BaseDataClass;
import sales.org.common.db.Connection;
import sales.org.common.db.PreparedStatement;
import sales.org.util.StringUtil;






public class ApDAO extends CommonDAO {
    public ApDAO() {
		super(); 
    }
    
    //게시물 리스트 조회시
    public ArrayList list(ApDTO entity, String where_sql,int requestedPage,int pageSize ,String v_login_id,String v_login_name,Connection conn) throws SQLException {
        
    	java.sql.PreparedStatement pstmt = null;
        ResultSet rs = null;
        StringBuffer sql = new StringBuffer();
        ArrayList arrBeans = new ArrayList();
        BaseDataClass data = null;


		//System.out.println("requestedPage!!!!!!--->" + requestedPage);
		//System.out.println("pageSize--->" + pageSize);
		//System.out.println("v_login_id!!!!!!--->" + v_login_id);
		//System.out.println("v_login_nm!!!!!!--->" + v_login_name);
		
        int chk_page = requestedPage - 1;
		
        try {
			/*PagingHelper helper = new PagingHelper(pageSize, 10);	// 여기는 타는데욤.
			helper.setCurpage(requestedPage);
			helper.setTotalcount(150);			//여기 데이터 전체의 행수가 들어가야 하는데..움..;
			helper.setPageNav();*/
        	
        	//sales.common.StringUtil.printMsg("쿼리",sql.toString(),this);

			// 결재 건수 조회- EHR 통합
        	sql.append(" SELECT '50' AS detail,'인사' AS detail_nm, count(*) AS cnt                                                                                                                                 ");
        	sql.append("   FROM (                                                                                                                                                            ");
        	sql.append("    SELECT APP_GBN, APP_GBN_NM, APP_TITLE, APP_YMD, PENO_NM, REQ_NO, GUN_YMD, GUN_DPT, ENO_NO, GUN_GBN, APP_TIME, APP_STATUS, APP_CMT, PENO_NO, SEQ_NO               ");
        	sql.append("        FROM (                                                                                                                                                       ");  
        	sql.append("				SELECT '0'  AS APP_GBN                                                                     ");
        	sql.append("				   ,'일일근태' AS APP_GBN_NM                                                                                                                         ");
        	sql.append("				   ,ASNHR.SF_GET_ENONAME('01',PENO_NO) AS PENO_NM                                                                                           ");
        	sql.append("				  ,TO_CHAR(IPT_YMD,'YYYY/MM/DD')||' '||ASNHR.SF_GET_DPTNAME('01','A4',GUN_DPT) AS APP_TITLE                                                          ");
        	sql.append("				  ,TO_CHAR(IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                                                                                          ");
        	sql.append("				                      , A.REQ_NO, GUN_YMD, GUN_DPT                                                                                                   ");
        	sql.append("				  ,ENO_NO                                                                                                                                            ");
        	sql.append("				  , GUN_GBN, APP_TIME                                                                                                                                ");
        	sql.append("				  ,'' AS APP_STATUS                                                                                                                                  ");
        	sql.append("				  ,'' AS APP_CMT                                                                                                                                     ");
        	sql.append("				  ,PENO_NO                                                                                                                                           ");
        	sql.append("				  ,SEQ_NO                                                                                                                                            ");
        	sql.append("				FROM ASNHR.T_DI_APPROVAL A,                                                                                                                          ");
        	sql.append("					 (SELECT REQ_NO,END_TAG  FROM ASNHR.T_DI_DILIGENCE_IND GROUP BY REQ_NO,END_TAG  ) B                                                              ");
        	sql.append("				WHERE 1=1                                                                                                                                            ");
        	sql.append("				AND    A.REQ_NO = B.REQ_NO																		                                                     ");
        	sql.append("				AND    GUN_GBN = 'C'                                                                                                                                 ");
        	sql.append("				AND    APP_YN IS NULL    AND END_TAG IS NULL													                                                     ");
        	sql.append("				AND    ENO_NO = ?                                                                                                                            ");
        	sql.append("				AND    A.REQ_NO IS NOT NULL                                                                                                                          ");
        	sql.append("				AND    A.REQ_NO NOT IN (SELECT C.REQ_NO													                                                             ");
        	sql.append("					FROM ASNHR.T_DI_APPROVAL C																		                                                 ");
        	sql.append("					WHERE C.REQ_NO = A.REQ_NO																                                                         ");
        	sql.append("					AND C.SEQ_NO < A.SEQ_NO																	                                                         ");
        	sql.append("					AND C.GUN_GBN = 'C'																			                                                     ");
        	sql.append("					AND (C.APP_YN IS NULL OR C.APP_YN != 'Y'))															                                             ");
        	sql.append("				UNION ALL                                                                                                                                            ");
        	sql.append("				SELECT '1'  AS APP_GBN                         ");
        	sql.append("					,'변경근태' AS APP_GBN_NM                                                                                                                        ");
        	sql.append("					,ASNHR.SF_GET_ENONAME('01',PENO_NO) AS PENO_NM                                                                                          ");
        	sql.append("					,TO_CHAR(IPT_YMD,'YYYY/MM/DD')||' '||ASNHR.SF_GET_DPTNAME('01','A4',GUN_DPT) AS APP_TITLE                                                        ");
        	sql.append("					,TO_CHAR(IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                                                                                        ");
        	sql.append("					, A.REQ_NO, GUN_YMD, GUN_DPT                                                                                                                     ");
        	sql.append("					, A.ENO_NO                                                                                                                                       ");
        	sql.append("					, GUN_GBN, APP_TIME                                                                                                                              ");
        	sql.append("					,'' AS APP_STATUS                                                                                                                                ");
        	sql.append("					,'' AS APP_CMT                                                                                                                                   ");
        	sql.append("					,PENO_NO                                                                                                                                         ");
        	sql.append("					,SEQ_NO                                                                                                                                          ");
        	sql.append("				FROM ASNHR.T_DI_APPROVAL A,                                                                                                                          ");
        	sql.append("				     (SELECT REQ_NO,END_TAG  FROM ASNHR.T_DI_CHANGE GROUP BY REQ_NO,END_TAG  ) B                                                                     ");
        	sql.append("				WHERE A.REQ_NO = B.REQ_NO                                                                                                                            ");
        	sql.append("				AND    GUN_GBN = 'U'                                                                                                                                 ");
        	sql.append("				AND    APP_YN IS NULL    AND END_TAG IS NULL													                                                     ");
        	sql.append("				AND    ENO_NO = ?                                                                                                                            ");
        	sql.append("				AND    A.REQ_NO IS NOT NULL                                                                                                                          ");
        	sql.append("				UNION ALL                                                                                                                                            ");
        	sql.append("				SELECT  '2' AS APP_GBN                                                                  ");
        	sql.append("			       ,'익월근태' AS APP_GBN_NM                                                                                                                         ");
        	sql.append("			       ,ASNHR.SF_GET_ENONAME('01',PENO_NO) AS PENO_NM                                                                                           ");
        	sql.append("			       ,TO_CHAR(TO_DATE(SUBSTR(A.REQ_NO,1,8),'YYYYMMDD'),'YYYY/MM/DD')||' '||ASNHR.SF_GET_DPTNAME('01','A4',GUN_DPT) AS APP_TITLE                        ");
        	sql.append("			       ,TO_CHAR(IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                                                                                         ");
        	sql.append("			       , A.REQ_NO, GUN_YMD, GUN_DPT                                                                                                                      ");
        	sql.append("			       , A.ENO_NO                                                                                                                                        ");
        	sql.append("			       , GUN_GBN, APP_TIME                                                                                                                               ");
        	sql.append("                    ,'' AS APP_STATUS                                                                                                                                ");
        	sql.append("                    ,'' AS APP_CMT                                                                                                                                   ");
        	sql.append("                    ,PENO_NO                                                                                                                                         ");
        	sql.append("                    ,SEQ_NO                                                                                                                                          ");
        	sql.append("				FROM ASNHR.T_DI_APPROVAL  A ,				                                                                                                         ");
        	sql.append("				       (SELECT REQ_NO,END_TAG FROM ASNHR.T_DI_PLAN GROUP BY REQ_NO,END_TAG ) B							                                             ");
        	sql.append("				WHERE  A.REQ_NO = B.REQ_NO																			                                                 ");
        	sql.append("				AND    GUN_GBN = 'P'																				                                                 ");
        	sql.append("				AND    APP_YN IS NULL      AND END_TAG IS NULL                                                                                                       ");
        	sql.append("				AND    ENO_NO = ?                                                                                                                            ");
        	sql.append("				UNION ALL                                                                                                                                                    ");
        	sql.append("				SELECT  '3' AS APP_GBN                                                                             ");
        	sql.append("				       ,'연차촉진제' AS APP_GBN_NM                                                                                                                           ");
        	sql.append("				       ,ASNHR.SF_GET_ENONAME('01',PENO_NO) AS PENO_NM                                                                                                ");
        	sql.append("				       ,TO_CHAR(TO_DATE(SUBSTR(A.REQ_NO,1,8),'YYYYMMDD'),'YYYY/MM/DD')||' '||ASNHR.SF_GET_DPTNAME('01','A4',GUN_DPT) AS APP_TITLE                            ");
        	sql.append("				       ,TO_CHAR(A.IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                                                                                           ");
        	sql.append("				       , A.REQ_NO, GUN_YMD, GUN_DPT                                                                                                                          ");
        	sql.append("				       , A.ENO_NO                                                                                                                                            ");
        	sql.append("				       , GUN_GBN, APP_TIME																		                                                                                               ");
        	sql.append("                     ,'' AS APP_STATUS																		                                                                                           ");
        	sql.append("                     ,'' AS APP_CMT                                                                                                                                  ");
        	sql.append("                     ,PENO_NO                                                                                                                                        ");
        	sql.append("                     ,SEQ_NO                                                                                                                                         ");
        	sql.append("				FROM ASNHR.T_DI_APPROVAL A	,																			                                                                                           ");
        	sql.append("									(SELECT REQ_NO,END_TAG FROM ASNHR.T_DI_ACCELERATE GROUP BY REQ_NO,END_TAG ) B				                                                               ");
        	sql.append("				WHERE  A.REQ_NO = B.REQ_NO																		                                                                                               ");
        	sql.append("				AND     GUN_GBN = 'A'                                                                                                                                        ");
        	sql.append("				AND    APP_YN IS NULL                                                                                                                       ");
        	sql.append("				AND    ENO_NO = ?                                                                                                                                    ");
        	sql.append("				AND    SUBSTR(A.REQ_NO, 1, 4) = TO_CHAR(SYSDATE, 'YYYY')                                                                                                     ");
        	sql.append("			UNION ALL                                                                                                                                                      ");
        	sql.append("       SELECT '4'  AS APP_GBN                                                                              ");
        	sql.append("          ,'파견관리' AS APP_GBN_NM                                                                                                                                  ");
        	sql.append("          ,ASNHR.SF_GET_ENONAME('01',PENO_NO) AS PENO_NM                                                                                                     ");
        	sql.append("          ,TO_CHAR(TO_DATE(B.DIS_FR_YMD,'YYYYMMDD'),'YYYY/MM/DD')||' ('||DIS_DAY||'일) '||B.DIS_OBJ AS APP_TITLE                                                     ");
        	sql.append("         ,TO_CHAR(A.IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                                                                                                 ");
        	sql.append("         , A.REQ_NO, GUN_YMD, GUN_DPT                                                                                                                                ");
        	sql.append("         , A.ENO_NO                                                                                                                                                  ");
        	sql.append("         , GUN_GBN, APP_TIME                                                                                                                                         ");
        	sql.append("					 ,B.APP_STATUS                                                                                                                                             ");
        	sql.append("					 ,B.APP_CMT AS APP_CMT                                                                                                                                     ");
        	sql.append("					 ,A.PENO_NO                                                                                                                                                ");
        	sql.append("                     ,SEQ_NO                                                                                                                                         ");
        	sql.append("       FROM ASNHR.T_DI_APPROVAL A,                                                                                                                                   ");
        	sql.append("            ASNHR.T_DI_DISPATCH B                                                                                                                                    ");
        	sql.append("       WHERE 1=1                                                                                                                                                     ");
        	sql.append("       AND    A.REQ_NO = B.ORD_NO                                                                                                                                    ");
        	sql.append("       AND    GUN_GBN = 'D'                                                                                                                                          ");
        	sql.append("       AND    APP_YN  = 'R'                                                                                                                                          ");
        	sql.append("       AND    A.ENO_NO = ?                                                                                                                                   ");
        	sql.append("       AND    A.REQ_NO IS NOT NULL                                                                                                                                   ");
        	sql.append("       AND    B.APP_STATUS IN ('2', '3')                                                                                                              ");
        	sql.append("       UNION ALL                                                                                                                                                     ");
        	sql.append("       SELECT '5'  AS APP_GBN                                                                              ");
        	sql.append("          ,'해외출장' AS APP_GBN_NM                                                                                                                                  ");
        	sql.append("          ,ASNHR.SF_GET_ENONAME('01',PENO_NO) AS PENO_NM                                                                                                    ");
        	sql.append("          ,TO_CHAR(TO_DATE(B.BUT_FR_YMD,'YYYYMMDD'),'YYYY/MM/DD')||' ('||BUT_DAY||'일) '||B.BUT_OBJ AS APP_TITLE                                                     ");
        	sql.append("         ,TO_CHAR(A.IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                                                                                                 ");
        	sql.append("         , A.REQ_NO, GUN_YMD, GUN_DPT                                                                                                                                ");
        	sql.append("         ,A.ENO_NO                                                                                                                                                   ");
        	sql.append("         , GUN_GBN, APP_TIME                                                                                                                                         ");
        	sql.append("		   ,B.APP_STATUS                                                                                                                                                 ");
        	sql.append("		   ,B.APP_CMT AS APP_CMT                                                                                                                                         ");
        	sql.append("		   ,A.PENO_NO                                                                                                                                                    ");
        	sql.append("         ,SEQ_NO                                                                                                                                                     ");
        	sql.append("       FROM ASNHR.T_DI_APPROVAL A,                                                                                                                                   ");
        	sql.append("            ASNHR.T_DI_OVERSEASTRIP B                                                                                                                                ");
        	sql.append("       WHERE 1=1                                                                                                                                                     ");
        	sql.append("       AND    A.REQ_NO = B.ORD_NO                                                                                                                                    ");
        	sql.append("       AND    GUN_GBN = 'E'                                                                                                                                          ");
        	sql.append("       AND    APP_YN  = 'R'                                                                                                                                          ");
        	sql.append("       AND    A.ENO_NO = ?                                                                                                                                   ");
        	sql.append("       AND    A.REQ_NO IS NOT NULL                                                                                                                                   ");
        	sql.append("       AND    B.APP_STATUS IN ('2', '3')    ");
        	sql.append("   UNION ALL                                                                                                                                                         ");
        	sql.append("	SELECT	'6'	AS APP_GBN                                                                                    ");
        	sql.append("			,'휴일수당정산' AS APP_GBN_NM                                                                                                                                  ");
        	sql.append("              ,ASNHR.SF_GET_ENONAME('01',PENO_NO) AS PENO_NM                                                                                                         ");
        	sql.append("              ,SUBSTR(GUN_YMD,1,4) ||'/' || SUBSTR(GUN_YMD,5,6) || ' 휴일근무수당 급여 반영'   AS APP_TITLE                                                          ");
        	sql.append("			,TO_CHAR(IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                                                                                                      ");
        	sql.append("			, REQ_NO, GUN_YMD, GUN_DPT                                                                                                                                     ");
        	sql.append("			,''                                                                                                                                                            ");
        	sql.append("			,''                                                                                                                                                            ");
        	sql.append("			,''                                                                                                                                                            ");
        	sql.append("			,'' AS APP_STATUS                                                                                                                                              ");
        	sql.append("			,'' AS APP_CMT                                                                                                                                                 ");
        	sql.append("			,'' AS PENO_NO                                                                                                                                                 ");
        	sql.append("			,'' AS SEQ_NO                                                                                                                                                  ");
        	sql.append("	FROM	ASNHR.T_DI_APPROVAL                                                                                                                                          ");
        	sql.append("	WHERE   GUN_GBN = 'J'                                                                                                                                              ");
        	sql.append("	  AND	APP_YN = 'R'                                                                                                                                                 ");
        	sql.append("	  AND	ENO_NO = ?                                                                                                                                           ");
        	sql.append("	UNION ALL                                                                                                                                                          ");
        	sql.append("	SELECT   DISTINCT '7'     AS APP_GBN                                                                      ");
        	sql.append("			,'휴일근무신청' AS APP_GBN_NM                                                                                                                                  ");
        	sql.append("			,ASNHR.SF_GET_ENONAME('01',PENO_NO) AS PENO_NM                                                                                                                 ");
        	sql.append("			,TO_CHAR(TO_DATE(GUN_YMD,'YYYYMMDD'),'YYYY/MM/DD')||' '||ASNHR.SF_GET_DPTNAME('01','A4',GUN_DPT) AS APP_TITLE                                                  ");
        	sql.append("			,TO_CHAR(A.IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                                                                                                    ");
        	sql.append("			, REQ_NO, GUN_YMD, GUN_DPT                                                                                                                                     ");
        	sql.append("			,''                                                                                                                                                            ");
        	sql.append("			,''                                                                                                                                                            ");
        	sql.append("			,''                                                                                                                                                            ");
        	sql.append("			,'' AS APP_STATUS                                                                                                                                              ");
        	sql.append("			,'' AS APP_CMT                                                                                                                                                 ");
        	sql.append("			,'' AS PENO_NO                                                                                                                                                 ");
        	sql.append("			,'' AS SEQ_NO                                                                                                                                                  ");
        	sql.append("	FROM    ASNHR.T_DI_APPROVAL A , ASNHR.T_DI_HOLIDAYWORK B                                                                                                           ");
        	sql.append("	WHERE  A.GUN_YMD = B.HOL_YMD															                                                                                                         ");
        	sql.append("	AND   SUBSTR(A.REQ_NO,10) = B.DPT_CD													                                                                                                     ");
        	sql.append("	AND   GUN_GBN = 'R'                                                                                                                                                ");
        	sql.append("	AND   APP_YN is null    AND   B.END_TAG = 'R'                                                                                                   ");
        	sql.append("	AND   GUN_YMD > TO_CHAR(SYSDATE-55, 'YYYYMMDD')                                                                                                 ");
        	sql.append("	AND   A.ENO_NO = ?                                                                                                                                         ");
        	sql.append("	UNION ALL                                                                                                                                                          ");
        	sql.append("	SELECT  DISTINCT '8'	 AS APP_GBN                                                                         ");
        	sql.append("			,'휴일결과보고' AS APP_GBN_NM                                                                                                                                  ");
        	sql.append("			,ASNHR.SF_GET_ENONAME('01',PENO_NO) AS PENO_NM                                                                                                                 ");
        	sql.append("			,TO_CHAR(TO_DATE(GUN_YMD,'YYYYMMDD'),'YYYY/MM/DD')||' '||ASNHR.SF_GET_DPTNAME('01','A4',GUN_DPT) AS APP_TITLE                                                  ");
        	sql.append("			,TO_CHAR(A.IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                                                                                                    ");
        	sql.append("			, REQ_NO, GUN_YMD, GUN_DPT                                                                                                                                     ");
        	sql.append("			,''                                                                                                                                                            ");
        	sql.append("			,''                                                                                                                                                            ");
        	sql.append("			,''                                                                                                                                                            ");
        	sql.append("		,'' AS APP_STATUS                                                                                                                                                ");
        	sql.append("		,'' AS APP_CMT                                                                                                                                                   ");
        	sql.append("		,'' AS PENO_NO                                                                                                                                                   ");
        	sql.append("		,'' AS SEQ_NO                                                                                                                                                    ");
        	sql.append("	FROM	ASNHR.T_DI_APPROVAL A , ASNHR.T_DI_HOLIDAYWORK B                                                                                                             ");
        	sql.append("	WHERE   A.GUN_YMD = B.HOL_YMD                                                                                                                                      ");
        	sql.append("	  AND  SUBSTR(A.REQ_NO,10) = B.DPT_CD                                                                                                                              ");
        	sql.append("	  AND   GUN_GBN = 'H'                                                                                                                                              ");
        	sql.append("	  AND	A.APP_YN is null		AND   B.SIGN_TAG = 'R'                                                                                                 ");
        	sql.append("	  AND	GUN_YMD BETWEEN TO_CHAR(SYSDATE-55,'YYYYMMDD') AND TO_CHAR(SYSDATE,'YYYYMMDD')                                                                               ");
        	sql.append("	  AND	A.ENO_NO = ?                                                                                                                                         ");
        	sql.append("   UNION ALL                                                                                                                                                         ");
        	sql.append("                                                                                                                                                                     ");
        	sql.append("                                                                                                                                                                     ");
        	sql.append("                                                                                                                                                                     ");
        	sql.append("                                                                                                                                                                     ");
        	sql.append("      SELECT '9'                                                AS APP_GBN,                                                                                          ");
        	sql.append("             '국내출장' AS APP_GBN_NM                                                                                                                                ");
        	sql.append("             ,ASNHR.SF_GET_ENONAME('01',A.PENO_NO) AS PENO_NM                                                                                                        ");
        	sql.append("             ,TO_CHAR(TO_DATE(C.BUT_FR_YMD,'YYYYMMDD'),'YYYY/MM/DD')||' ('||BUT_DAY||'일) '||C.BUT_OBJ AS APP_TITLE                                                  ");
        	sql.append("             ,TO_CHAR(C.IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                                                                                             ");
        	sql.append("             , A.REQ_NO  , B.ORD_YMD AS GUN_YMD, A.GUN_DPT						                                                                                               ");
        	sql.append("			,''                                                                                                                                                            ");
        	sql.append("			,''                                                                                                                                                            ");
        	sql.append("			,''                                                                                                                                                            ");
        	sql.append("		,B.APP_STATUS                                                                                                                                                    ");
        	sql.append("		,B.APP_CMT AS APP_CMT                                                                                                                                            ");
        	sql.append("		,B.ENO_NO PENO_NO                                                                                                                                                ");
        	sql.append("		,'' AS SEQ_NO                                                                                                                                                    ");
        	sql.append("        FROM ASNHR.T_DI_APPROVAL A, ASNHR.T_DI_BUSINESSTRIP C, ASNHR.T_DI_BUSINESSTRIP_STATE B     		                                                               ");
        	sql.append("       WHERE A.GUN_GBN  ='B'                                                       	                                                                                 ");
        	sql.append("         AND A.APP_YN IS NULL                                                       	                                                                               ");
        	sql.append("                                                                                                                                                                     ");
        	sql.append("	AND A.REQ_NO NOT IN ( SELECT D.REQ_NO FROM ASNHR.T_DI_APPROVAL D					                                                                                         ");
        	sql.append("	WHERE   ((SUBSTR(D.SEQ_NO,0,1) != '9' AND D.SEQ_NO = A.SEQ_NO)					                                                                                           ");
        	sql.append("	OR (SUBSTR(A.SEQ_NO,0,1) = '9' AND D.SEQ_NO < A.SEQ_NO))												                                                                                   ");
        	sql.append("	AND D.ENO_NO != ?													                                                                                                                 ");
        	sql.append("	AND (D.APP_YN IS NULL OR D.APP_YN NOT IN ('Y'))								                                                                                                     ");
        	sql.append("	AND D.REQ_NO =A.REQ_NO												                                                                                                                     ");
        	sql.append("	GROUP BY D.REQ_NO HAVING D.REQ_NO NOT IN (SELECT E.REQ_NO FROM ASNHR.T_DI_APPROVAL E	                                                                             ");
        	sql.append("	WHERE   ((SUBSTR(E.SEQ_NO,0,1) != '9' AND E.SEQ_NO > A.SEQ_NO))					                                                                                           ");
        	sql.append("	AND E.ENO_NO != ?													                                                                                                                 ");
        	sql.append("	AND (E.APP_YN IS NULL OR E.APP_YN NOT IN ('Y'))								                                                                                                     ");
        	sql.append("	AND E.REQ_NO =A.REQ_NO												                                                                                                                     ");
        	sql.append("	GROUP BY E.REQ_NO))													                                                                                                                       ");
        	sql.append("                                                                                                                                                                     ");
        	sql.append("         AND A.REQ_NO = C.ORD_NO                                                		                                                                                 ");
        	sql.append("         AND A.REQ_NO = B.ORD_NO                                               		                                                                                   ");
        	sql.append("         AND B.APP_CMT = '상신'                                       				                                                                                       ");
        	sql.append("         AND A.eno_no = ?                                                          	                                                                         ");
        	sql.append("                                                                                                                                                                     ");
        	sql.append("                 UNION ALL                                                                                                                                           ");
        	sql.append("                    SELECT '10'   AS APP_GBN,                                                                                                                        ");
        	sql.append("                           '경공조금' AS APP_GBN_NM                                                                                                                  ");
        	sql.append("                           ,ASNHR.SF_GET_ENONAME('01',B.ENO_NO) AS PENO_NM                                                                                           ");
        	sql.append("                           ,TO_CHAR(TO_DATE(AID_YMD,'YYYYMMDD'),'YYYY/MM/DD')||' '||ASNHR.SF_GET_COMMNAME('01','R1',B.AID_CD) AS APP_TITLE                           ");
        	sql.append("                           ,TO_CHAR(B.IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                                                                               ");
        	sql.append("                           , ORD_NO AS REQ_NO , '' AS GUN_YMD, A.DPT_CD  AS GUN_DPT                                                                                  ");
        	sql.append("							,''                                                                                                                                                    ");
        	sql.append("							,''                                                                                                                                                    ");
        	sql.append("							,''                                                                                                                                                    ");
        	sql.append("						,'' AS APP_STATUS                                                                                                                                        ");
        	sql.append("						,'' AS APP_CMT                                                                                                                                           ");
        	sql.append("						,'' AS PENO_NO                                                                                                                                           ");
        	sql.append("						,'' AS SEQ_NO                                                                                                                                            ");
        	sql.append("                      FROM ASNHR.T_AD_DECISION A, ASNHR.T_AD_AIDAPP B                                                                                                ");
        	sql.append("                     WHERE A.CK_TAG = 'K'                                                                                                                            ");
        	sql.append("                       AND A.ORD_NO = B.REQ_NO                                                                                                                       ");
        	sql.append("                       AND A.APP_YN <> 'Y'                                                                                                                            ");
        	sql.append("                       AND B.AID_STS NOT IN  ('A', 'R')                                                                                                                          ");
        	sql.append("                       AND B.REQ_YMD >= TO_CHAR(SYSDATE-90,'YYYYMMDD')                                                                                               ");
        	sql.append("                       AND A.ENO_NO = ?                                                                                                                      ");
        	sql.append(" UNION ALL                                                                                                                                                           ");
        	sql.append(" 	SELECT    '11'    AS APP_GBN        					                                                       ");
        	sql.append("            ,'교육신청' AS APP_GBN_NM                                                                											                                           ");
        	sql.append("            ,ASNHR.SF_GET_ENONAME('01',PENO_NO) AS PENO_NM                                                 							                                             ");
        	sql.append("            ,TO_CHAR(TO_DATE(B.STR_YMD,'YYYYMMDD'),'YYYY/MM/DD')||'~'||TO_CHAR(TO_DATE(B.END_YMD,'YYYYMMDD'),'YYYY/MM/DD')||' ['||B.EDU_NM||']' AS APP_TITLE         ");
        	sql.append("            ,TO_CHAR(A.IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                                						                                         ");
        	sql.append("            , A.REQ_NO, GUN_YMD, GUN_DPT                                                               									                             ");
        	sql.append("            ,A.ENO_NO                                                                                  											                     ");
        	sql.append("            ,A.GUN_GBN                                                                                	 										                     ");
        	sql.append("            ,''                                                                                        													             ");
        	sql.append("        ,'' AS APP_STATUS                                                                              											                     ");
        	sql.append("        ,'' AS APP_CMT                                                                                 											                     ");
        	sql.append("        ,A.PENO_NO   AS PENO_NO                                                                        									                             ");
        	sql.append("        ,A.SEQ_NO    AS SEQ_NO                                                                         										                         ");
        	sql.append("    FROM    ASNHR.T_DI_APPROVAL A, ASNHR.T_CM_EDUCATION B                                                          							                         ");
        	sql.append("    WHERE   A.REQ_NO = B.REQ_NO                                                                        									                             ");
        	sql.append("      AND   GUN_GBN = 'M'                                                                              										                         ");
        	sql.append("      AND   APP_YN IS NULL  AND B.DECISION_CD = 'A'  ");
        	sql.append("      AND   A.ENO_NO = ?                                                                               										                 ");
        	sql.append("                  AND A.REQ_NO NOT IN ( SELECT D.REQ_NO FROM ASNHR.T_DI_APPROVAL D											                                         ");
        	sql.append("                 WHERE   ((SUBSTR(D.SEQ_NO,0,1) != '9' AND D.SEQ_NO = A.SEQ_NO)											                                             ");
        	sql.append("                 OR (SUBSTR(A.SEQ_NO,0,1) = '9' AND D.SEQ_NO < A.SEQ_NO))													                                         ");
        	sql.append("                 AND D.ENO_NO != ?																												             ");
        	sql.append("                 AND (D.APP_YN IS NULL OR D.APP_YN NOT IN ('Y'))																	                                 ");
        	sql.append("                 AND D.REQ_NO =A.REQ_NO																									                             ");
        	sql.append("                 AND D.GUN_GBN = 'M'																									                             ");
        	sql.append("                     GROUP BY D.REQ_NO HAVING D.REQ_NO NOT IN (SELECT E.REQ_NO FROM ASNHR.T_DI_APPROVAL E		                                                     ");
        	sql.append("                             WHERE   ((SUBSTR(E.SEQ_NO,0,1) != '9' AND E.SEQ_NO > A.SEQ_NO))								                                         ");
        	sql.append("                             AND E.ENO_NO != ?																									             ");
        	sql.append("                             AND (E.APP_YN IS NULL OR E.APP_YN NOT IN ('Y'))														                                 ");
        	sql.append("                             AND E.REQ_NO =A.REQ_NO																						                             ");
        	sql.append("                             GROUP BY E.REQ_NO))     																						                         ");
        	sql.append("      AND NOT EXISTS (SELECT 'x' FROM ASNHR.T_ED_YEARPLAN WHERE TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN APP_STR_YMD AND APP_END_YMD)                                     ");      
        	sql.append(" UNION ALL                                                                                                                                                           ");
        	sql.append(" 	SELECT    '12'    AS APP_GBN                                                                     ");
        	sql.append("            ,'연간교육신청' AS APP_GBN_NM                                                                                                                            ");
        	sql.append("            ,ASNHR.SF_GET_ENONAME('01',PENO_NO) AS PENO_NM                                                                                                           ");      
        	sql.append("            ,TO_CHAR(TO_DATE(B.STR_YMD,'YYYYMMDD'),'YYYY/MM/DD')||'~'||TO_CHAR(TO_DATE(B.END_YMD,'YYYYMMDD'),'YYYY/MM/DD')||' ['||B.EDU_NM||']' AS APP_TITLE         ");
        	sql.append("            ,TO_CHAR(A.IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                                                                                              ");
        	sql.append("            , A.REQ_NO, GUN_YMD, GUN_DPT                                                                                                                             ");
        	sql.append("            ,A.ENO_NO                                                                                                                                                ");
        	sql.append("            ,A.GUN_GBN                                                                                                                                               ");
        	sql.append("            ,''                                                                                                                                                      ");
        	sql.append("        ,'' AS APP_STATUS                                                                                                                                            ");
        	sql.append("        ,'' AS APP_CMT                                                                                                                                               ");
        	sql.append("        ,A.PENO_NO   AS PENO_NO                                                                                                                                      ");
        	sql.append("        ,A.SEQ_NO    AS SEQ_NO                                                                                                                                       ");
        	sql.append("    FROM    ASNHR.T_DI_APPROVAL A, ASNHR.T_CM_EDUCATION B                                                                                                            ");
        	sql.append("    WHERE   A.REQ_NO = B.REQ_NO                                                                                                                                      ");
        	sql.append("      AND GUN_GBN = 'M'                                                                                                                                              ");
        	sql.append("      AND    APP_YN IS NULL                                                                                                                                          ");
        	sql.append("      AND    A.ENO_NO = ?                                                                                                                                    ");
        	sql.append("      AND EXISTS (SELECT 'x' FROM ASNHR.T_ED_YEARPLAN WHERE TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN APP_STR_YMD AND APP_END_YMD)                                         ");      
        	sql.append(" UNION ALL                                                                                                                                                           ");
        	sql.append(" 	SELECT    '13'    AS APP_GBN    ");
        	sql.append("            ,'교육결과보고' AS APP_GBN_NM                                                                                                                            ");
        	sql.append("            ,ASNHR.SF_GET_ENONAME('01',PENO_NO) AS PENO_NM                                                                                                           ");
        	sql.append("            ,TO_CHAR(TO_DATE(B.STR_YMD,'YYYYMMDD'),'YYYY/MM/DD')||'~'||TO_CHAR(TO_DATE(B.END_YMD,'YYYYMMDD'),'YYYY/MM/DD')||' ['||B.EDU_NM||']' AS APP_TITLE         ");
        	sql.append("            ,TO_CHAR(A.IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                                                                                              ");
        	sql.append("            , A.REQ_NO, GUN_YMD, GUN_DPT                                                                                                                             ");
        	sql.append("            ,A.ENO_NO                                                                                                                                                ");
        	sql.append("            ,A.GUN_GBN                                                                                                                                               ");
        	sql.append("            ,''                                                                                                                                                      ");
        	sql.append("        ,'' AS APP_STATUS                                                                                                                                            ");
        	sql.append("        ,'' AS APP_CMT                                                                                                                                               ");
        	sql.append("        ,A.PENO_NO   AS PENO_NO                                                                                                                                      ");
        	sql.append("        ,A.SEQ_NO    AS SEQ_NO                                                                                                                                       ");
        	sql.append("    FROM    ASNHR.T_DI_APPROVAL A, ASNHR.T_CM_EDUCATION B                                                                                                            ");
        	sql.append("    WHERE   A.REQ_NO = B.RPT_REQ_NO                                                                                                                                  ");
        	sql.append("      AND GUN_GBN = 'N'                                                                                                                                              ");
        	sql.append("      AND    APP_YN IS NULL                                                                                                                                          ");
        	sql.append("      AND    A.ENO_NO = ?                                                                                                                                    ");
        	sql.append(" UNION ALL                                                                                                                                                           ");
        	sql.append(" 	SELECT    '14'    AS APP_GBN    ");
        	sql.append("            ,'신입사원OJT' AS APP_GBN_NM                                                                                                                             ");
        	sql.append("            ,ASNHR.SF_GET_ENONAME('01',PENO_NO) AS PENO_NM                                                                                                           ");
        	sql.append("            ,ASNHR.SF_GET_ENONAME('01',A.PENO_NO)||' ['||(TO_CHAR(TO_DATE(A.GUN_YMD,'YYYYMMDD'),'YYYY-MM-DD'))||' OJT일지]' AS APP_TITLE                                                 ");
        	sql.append("            ,TO_CHAR(A.IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                                                                                              ");
        	sql.append("            , A.REQ_NO, GUN_YMD, GUN_DPT                                                                                                                             ");
        	sql.append("            ,A.ENO_NO                                                                                                                                                ");
        	sql.append("            ,A.GUN_GBN                                                                                                                                               ");
        	sql.append("            ,''                                                                                                                                                      ");
        	sql.append("        ,'' AS APP_STATUS                                                                                                                                            ");
        	sql.append("        ,'' AS APP_CMT                                                                                                                                               ");
        	sql.append("        ,A.PENO_NO   AS PENO_NO                                                                                                                                      ");
        	sql.append("        ,A.SEQ_NO    AS SEQ_NO                                                                                                                                       ");
        	sql.append("    FROM    ASNHR.T_DI_APPROVAL A                                                                                                               ");
        	sql.append("    WHERE                                                                                                                                        ");
        	sql.append("                GUN_GBN = 'L'                                                                                                                                              ");
        	sql.append("      AND    APP_YN IS NULL                                                                                                                                          ");
        	sql.append("      AND    A.ENO_NO = ?                                                                     							                                                 ");
        	sql.append(" UNION ALL																													                                                                                                 ");
        	sql.append(" SELECT    '15'    AS APP_GBN    					                                                                                 ");
        	sql.append(" ,'도서구입' AS APP_GBN_NM																							                                                                                             ");
        	sql.append(" ,ASNHR.SF_GET_ENONAME('01',PENO_NO) AS PENO_NM																                                                                                       ");
        	sql.append(" ,TO_CHAR(B.IPT_YMD,'YYYY/MM/DD') ||' ' ||ASNHR.SF_GET_ENONAME('01',B.IPT_MAN)||'  '  ||C.BOOK_NM||' / 용도:'|| B.RQST_REMARK AS APP_TITLE                           ");
        	sql.append(" ,TO_CHAR(A.IPT_YMD,'YYYY-MM-DD') AS APP_YMD															                                                                                           ");
        	sql.append(" , A.REQ_NO, GUN_YMD, GUN_DPT																					                                                                                               ");
        	sql.append(" ,A.ENO_NO																													                                                                                                 ");
        	sql.append(" ,A.GUN_GBN																												                                                                                                   ");
        	sql.append(" ,''																																                                                                                                 ");
        	sql.append(" ,'' AS APP_STATUS																										                                                                                               ");
        	sql.append(" ,'' AS APP_CMT																											                                                                                                 ");
        	sql.append(" ,A.PENO_NO   AS PENO_NO																							                                                                                               ");
        	sql.append(" ,A.SEQ_NO    AS SEQ_NO																								                                                                                               ");
        	sql.append(" FROM    ASNHR.T_DI_APPROVAL A, ASNHR.T_ED_BOOKM B, ASNHR.T_ED_BOOKD C												                                                                       ");
        	sql.append(" WHERE   A.REQ_NO = B.RQST_NO AND B.RQST_NO = C.RQST_NO AND C.RQST_SEQ = '1'			                                                                                   ");
        	sql.append("   AND GUN_GBN = 'Q'																									                                                                                               ");
        	sql.append("   AND (APP_YN IS NULL OR APP_YN = 'A')																		                                                                                           ");
        	sql.append("                       AND A.ENO_NO = ?																		                                                                                   ");
        	sql.append("    AND A.REQ_NO NOT IN ( SELECT D.REQ_NO FROM ASNHR.T_DI_APPROVAL D									                                                                               ");
        	sql.append("    WHERE   ((SUBSTR(D.SEQ_NO,0,1) != '9' AND D.SEQ_NO = A.SEQ_NO)								                                                                                   ");
        	sql.append("    OR (SUBSTR(A.SEQ_NO,0,1) = '9' AND D.SEQ_NO < A.SEQ_NO))										                                                                                     ");
        	sql.append("    AND D.ENO_NO != ?																									                                                                                       ");
        	sql.append("    AND (D.APP_YN IS NULL OR D.APP_YN NOT IN ('Y'))														                                                                                       ");
        	sql.append("    AND D.REQ_NO =A.REQ_NO																						                                                                                               ");
        	sql.append("        GROUP BY D.REQ_NO HAVING D.REQ_NO NOT IN (SELECT E.REQ_NO FROM ASNHR.T_DI_APPROVAL E		                                                                     ");
        	sql.append("                WHERE   ((SUBSTR(E.SEQ_NO,0,1) != '9' AND E.SEQ_NO > A.SEQ_NO))					                                                                             ");
        	sql.append("                AND E.ENO_NO != ?																						                                                                               ");
        	sql.append("                AND (E.APP_YN IS NULL OR E.APP_YN NOT IN ('Y'))											                                                                                 ");
        	sql.append("                AND E.REQ_NO =A.REQ_NO																			                                                                                         ");
        	sql.append("                GROUP BY E.REQ_NO))																					                                                                                         ");
        	sql.append("   AND B.END_TAG NOT IN ('N')																						                                                                                             ");
        	sql.append("   AND A.ENO_NO = ?																										                                                                                       ");
        	sql.append("                  ) 																											                                                                                           ");
        	sql.append(" UNION ALL																													                                                                                                 ");
        	sql.append("	SELECT    '17'    AS APP_GBN																						                                                                                           ");
        	sql.append("	,'시간외근무' AS APP_GBN_NM																					                                                                                             ");
        	sql.append("	,ASNHR.SF_GET_ENONAME('01',PENO_NO) AS PENO_NM															                                                                                       ");
        	sql.append("	,SUBSTR(A.GUN_YMD,1,4)||'년 '||SUBSTR(A.GUN_YMD,5,2)||'월 '||SUBSTR(A.GUN_YMD,7,2)||'일 '||' 시간외근무' AS  APP_TITLE	                                                                  ");
        	sql.append("	,TO_CHAR(A.IPT_YMD,'YYYY-MM-DD') AS APP_YMD															                                                                                           ");
        	sql.append("	, A.REQ_NO, GUN_YMD, GUN_DPT																					                                                                                             ");
        	sql.append("	,A.ENO_NO																													                                                                                                 ");
        	sql.append("	,A.GUN_GBN																												                                                                                                 ");
        	sql.append("	,''																																                                                                                                 ");
        	sql.append("	,'' AS APP_STATUS																										                                                                                               ");
        	sql.append("	,'' AS APP_CMT																											                                                                                               ");
        	sql.append("	,A.PENO_NO   AS PENO_NO																							                                                                                               ");
        	sql.append("	,A.SEQ_NO    AS SEQ_NO																								                                                                                             ");
        	sql.append("	FROM ASNHR.T_DI_APPROVAL A																								                                                                                         ");
        	sql.append("	WHERE																														                                                                                                   ");
        	sql.append("	A.GUN_GBN IN ('O','O2','O3')																											                                                                                               ");
        	sql.append("	AND A.ENO_NO = ?																										                                                                                       ");
        	sql.append("	AND (A.APP_YN IS NULL OR A.APP_YN = 'R')																		                                                                                       ");
        	sql.append("              )   	                                                                                                                                                 ");
        	

        	sql.append(" UNION ALL								");
        	sql.append(" SELECT									");  
        	sql.append("	'55' AS detail,						");       			
        	sql.append("	'Action PLAN' AS detail_nm,			");      
        	sql.append("	count(*) AS cnt						");      
        	sql.append("	 FROM ASNHR.T_ACT_APPROVAL A		");
        	sql.append("	 WHERE 1=1							");
        	sql.append("		AND    A.APP_YN IS NULL			");
        	sql.append("		AND    A.ENO_NO = ?				");
        	sql.append("		AND    A.REQ_GBN = 'G'		    ");        	
        	sql.append("		AND    A.REQ_NO IS NOT NULL		");
        	

        	sql.append("UNION ALL                                                                                                                                                            ");
        	sql.append("SELECT xx.detail, xx.detail_nm, xx.cnt FROM (                                                                                                                        ");
        	sql.append("  SELECT T1.DETAIL, T1.DETAIL_NM, NVL(X.CNT,0) AS CNT                                                                                                                ");
        	sql.append("    FROM SALES.TSY010 T1 LEFT OUTER JOIN                                                                                                                             ");
        	sql.append("     (SELECT V1.DOC_GU, COUNT(V1.AP_M_SID) AS CNT                                                                                                                    ");
        	sql.append("      FROM COMMON.V_APPROVE V1                                                                                                                                       ");
        	sql.append("     WHERE V1.NOW_EMPNO= ?                                                                                                                                   ");
        	sql.append("       AND V1.AP_STATUS_M < 4                                                                                                                                        ");
        	sql.append("     GROUP BY V1.DOC_GU) X ON (T1.DETAIL=X.DOC_GU)                                                                                                                   ");
        	sql.append("   WHERE T1.HEAD='AP001' AND T1.ITEM1='Y'                                                                                                                            ");
        	sql.append("   ORDER BY T1.ITEM15 ) XX                                                                                                                                           ");

        	
        	/*
			sql.append("SELECT T1.DETAIL, T1.DETAIL_NM, NVL(X.CNT,0) AS CNT ");
			sql.append("  FROM SALES.TSY010 T1 LEFT OUTER JOIN ");
			sql.append("   (SELECT V1.DOC_GU, COUNT(V1.AP_M_SID) AS CNT ");
			sql.append("	  FROM COMMON.V_APPROVE V1 ");
			sql.append("	 WHERE V1.NOW_EMPNO= ? ");
			sql.append("	   AND V1.AP_STATUS_M < 4 "); // 반려조건 제외 
			sql.append("	 GROUP BY V1.DOC_GU) X ON (T1.DETAIL=X.DOC_GU) ");
			sql.append(" WHERE T1.HEAD='AP001' AND T1.ITEM1='Y' ");
			sql.append(" ORDER BY T1.ITEM15 ");*/ 
			
			


			pstmt =  new PreparedStatement(conn,sql.toString());
			pstmt.setString(1, v_login_id);
			pstmt.setString(2, v_login_id);
			pstmt.setString(3, v_login_id);
			pstmt.setString(4, v_login_id);
			pstmt.setString(5, v_login_id);
			pstmt.setString(6, v_login_id);
			pstmt.setString(7, v_login_id);
			pstmt.setString(8, v_login_id);
			pstmt.setString(9, v_login_id);
			pstmt.setString(10, v_login_id);
			pstmt.setString(11, v_login_id);
			pstmt.setString(12, v_login_id);
			pstmt.setString(13, v_login_id);
			pstmt.setString(14, v_login_id);
			pstmt.setString(15, v_login_id);
			pstmt.setString(16, v_login_id);
			pstmt.setString(17, v_login_id);
			pstmt.setString(18, v_login_id);
			pstmt.setString(19, v_login_id);
			pstmt.setString(20, v_login_id);
			pstmt.setString(21, v_login_id);
			pstmt.setString(22, v_login_id);
			pstmt.setString(23, v_login_id);
			pstmt.setString(24, v_login_id);
			pstmt.setString(25, v_login_id);			
			pstmt.setString(26, v_login_id);

			System.out.println("쿼리--->" + sql.toString()  );

        	rs = pstmt.executeQuery();
	        while(rs.next()) {
	            data = new BaseDataClass();
	            data.setValues(rs);
	            arrBeans.add(data);
	        }
	        //System.out.println(sql.toString());

	    }catch(Exception e){
	    	e.printStackTrace();
	        //LogUtil.error(e);
	    }finally{
	        if(rs    != null){try{   rs.close();}catch(SQLException e){}}
	        if(pstmt != null){try{pstmt.close();}catch(SQLException e){}}
	    }
    return arrBeans;
    }


}
