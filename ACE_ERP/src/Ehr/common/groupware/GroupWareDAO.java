package common.groupware;

import java.sql.*;
import com.shift.gef.core.log.Log;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import common.util.DbManager;
public class GroupWareDAO{

	/**
     * GroupWare 쪽에 미결재 개수를 넘겨준다
     * @param p_box
     * @throws CException
     */
    public int  getAppCnt(String ENO_NO )  {
        PreparedStatement pstmt = null;
        StringBuffer query = new StringBuffer();
        Connection conn = null;
		int cnt = 0;
    	try {
			conn = DbManager.getMyConnection();
			query.append(" SELECT count(*) cnt                                                                                                     															\n");
			query.append("   FROM (                                                                                                                                             \n");
			query.append("    SELECT APP_GBN, APP_GBN_NM, APP_TITLE, APP_YMD, PENO_NM, REQ_NO, GUN_YMD, GUN_DPT, ENO_NO, GUN_GBN, APP_TIME, APP_STATUS, APP_CMT, PENO_NO, SEQ_NO               \n");
			query.append("        FROM (                                                                                                                                                         \n");
			query.append("				SELECT '0'  AS APP_GBN    -- 결재구분(0:일일근태,1:근태변경,2:익월근태,3:연차촉진제)               \n");
			query.append("				   ,'일일근태' AS APP_GBN_NM                                                                       \n");
			query.append("				   ,SF_GET_ENONAME('01',PENO_NO) AS PENO_NM   --상신자                                             \n");
			query.append("				  ,TO_CHAR(IPT_YMD,'YYYY/MM/DD')||' '||SF_GET_DPTNAME('01','A4',GUN_DPT) AS APP_TITLE              \n");
			query.append("				  ,TO_CHAR(IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                                        \n");
			query.append("				                      , A.REQ_NO, GUN_YMD, GUN_DPT                                                 \n");
			query.append("				  ,ENO_NO                                                                                          \n");
			query.append("				  , GUN_GBN, APP_TIME                                                                              \n");
			query.append("				  ,'' AS APP_STATUS                                                                                \n");
			query.append("				  ,'' AS APP_CMT                                                                                   \n");
			query.append("				  ,PENO_NO                                                                                         \n");
			query.append("				  ,SEQ_NO                                                                                          \n");
			query.append("				FROM T_DI_APPROVAL A,                                                                              \n");
			query.append("					 (SELECT REQ_NO,END_TAG  FROM T_DI_DILIGENCE_IND GROUP BY REQ_NO,END_TAG  ) B                  \n");
			query.append("				WHERE 1=1                                                                                          \n");
			query.append("				AND    A.REQ_NO = B.REQ_NO																		   \n");
			query.append("				AND    GUN_GBN = 'C'                                                                               \n");
			query.append("				AND    APP_YN IS NULL    AND END_TAG IS NULL													   \n");
			query.append("				AND    ENO_NO = ?                                                                                  \n");
			query.append("				AND    A.REQ_NO IS NOT NULL                                                                        \n");
			
			query.append("				AND    A.REQ_NO NOT IN (SELECT C.REQ_NO													\n");
			query.append("					FROM T_DI_APPROVAL C																		\n");
			query.append("					WHERE C.REQ_NO = A.REQ_NO																\n");
			query.append("					AND C.SEQ_NO < A.SEQ_NO																	\n");
			query.append("					AND C.GUN_GBN = 'C'																			\n");
			query.append("					AND (C.APP_YN IS NULL OR C.APP_YN != 'Y'))											\n");				
			
			query.append("				UNION ALL                                                                                          \n");
			query.append("				SELECT '1'  AS APP_GBN    -- 결재구분(0:일일근태,1:근태변경,2:익월근태,3:연차촉진제)               \n");
			query.append("					,'변경근태' AS APP_GBN_NM                                                                        \n");
			query.append("					,SF_GET_ENONAME('01',PENO_NO) AS PENO_NM   --상신자                                              \n");
			query.append("					,TO_CHAR(IPT_YMD,'YYYY/MM/DD')||' '||SF_GET_DPTNAME('01','A4',GUN_DPT) AS APP_TITLE              \n");
			query.append("					,TO_CHAR(IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                                        \n");
			query.append("					, A.REQ_NO, GUN_YMD, GUN_DPT                                                                     \n");
			query.append("					, A.ENO_NO                                                                                       \n");
			query.append("					, GUN_GBN, APP_TIME                                                                              \n");
			query.append("					,'' AS APP_STATUS                                                                                \n");
			query.append("					,'' AS APP_CMT                                                                                   \n");
			query.append("					,PENO_NO                                                                                         \n");
			query.append("					,SEQ_NO                                                                                          \n");
			query.append("				FROM T_DI_APPROVAL A,                                                                              \n");
			query.append("				     (SELECT REQ_NO,END_TAG  FROM T_DI_CHANGE GROUP BY REQ_NO,END_TAG  ) B                         \n");
			query.append("				WHERE A.REQ_NO = B.REQ_NO                                                                          \n");
			query.append("				AND    GUN_GBN = 'U'                                                                               \n");
			query.append("				AND    APP_YN IS NULL    AND END_TAG IS NULL													   \n");
			query.append("				AND    ENO_NO = ?                                                                                  \n");
			query.append("				AND    A.REQ_NO IS NOT NULL                                                                        \n");
			query.append("				UNION ALL                                                                                          \n");
			query.append("				SELECT  '2' AS APP_GBN    -- 결재구분(0:일일근태,1:근태변경,2:익월근태,3:연차촉진제)               \n");
			query.append("			       ,'익월근태' AS APP_GBN_NM                                                                       \n");
			query.append("			       ,SF_GET_ENONAME('01',PENO_NO) AS PENO_NM   --상신자                                             \n");
			query.append("			       ,TO_CHAR(TO_DATE(SUBSTR(A.REQ_NO,1,8),'YYYYMMDD'),'YYYY/MM/DD')||' '||SF_GET_DPTNAME('01','A4',GUN_DPT) AS APP_TITLE    \n");
			query.append("			       ,TO_CHAR(IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                                      \n");
			query.append("			       , A.REQ_NO, GUN_YMD, GUN_DPT                                                                   \n");
			query.append("			       , A.ENO_NO                                                                                     \n");
			query.append("			       , GUN_GBN, APP_TIME                                                                            \n");
			query.append("                    ,'' AS APP_STATUS                                                                         \n");
			query.append("                    ,'' AS APP_CMT                                                                            \n");
			query.append("                    ,PENO_NO                                                                                  \n");
			query.append("                    ,SEQ_NO                                                                                   \n");
			query.append("				FROM T_DI_APPROVAL  A ,				                                                              \n");
			query.append("				       (SELECT REQ_NO,END_TAG FROM T_DI_PLAN GROUP BY REQ_NO,END_TAG ) B							\n");
			query.append("				WHERE  A.REQ_NO = B.REQ_NO																			\n");
			query.append("				AND    GUN_GBN = 'P'																				\n");
			query.append("				AND    APP_YN IS NULL      AND END_TAG IS NULL                                                     \n");
			query.append("				AND    ENO_NO = ?                                                                                  \n");
			//query.append("				 AND    SUBSTR(REQ_NO, 1, 6) >= to_char(sysdate,'yyyymm')                                      \n");
			query.append("				UNION ALL                                                                                          \n");
			query.append("				SELECT  '3' AS APP_GBN    -- 결재구분(0:일일근태,1:근태변경,2:익월근태,3:연차촉진제)               \n");
			query.append("				       ,'연차촉진제' AS APP_GBN_NM                                                                 \n");
			query.append("				       ,SF_GET_ENONAME('01',PENO_NO) AS PENO_NM   --상신자                                         \n");
			query.append("				       ,TO_CHAR(TO_DATE(SUBSTR(A.REQ_NO,1,8),'YYYYMMDD'),'YYYY/MM/DD')||' '||SF_GET_DPTNAME('01','A4',GUN_DPT) AS APP_TITLE \n");
			query.append("				       ,TO_CHAR(A.IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                                \n");
			query.append("				       , A.REQ_NO, GUN_YMD, GUN_DPT                                                               \n");
			query.append("				       , A.ENO_NO                                                                                 \n");
			query.append("				       , GUN_GBN, APP_TIME																		 \n");
			query.append("                     ,'' AS APP_STATUS																		\n");
			query.append("                     ,'' AS APP_CMT                                                                         \n");
			query.append("                     ,PENO_NO                                                                               \n");
			query.append("                     ,SEQ_NO                                                                                \n");
			query.append("				FROM T_DI_APPROVAL A	,																			\n");
			query.append("									(SELECT REQ_NO,END_TAG FROM T_DI_ACCELERATE GROUP BY REQ_NO,END_TAG ) B				\n");
			query.append("				WHERE  A.REQ_NO = B.REQ_NO																		\n");
			query.append("				AND     GUN_GBN = 'A'                                                                           \n");
			query.append("				AND    APP_YN IS NULL   AND END_TAG = 'R'                                                       \n");
			query.append("				AND    ENO_NO = ?                                                                               \n");
			query.append("				AND    SUBSTR(A.REQ_NO, 1, 4) = TO_CHAR(SYSDATE, 'YYYY')                                        \n");
			query.append("			UNION ALL                                                                                          \n");
			query.append("       SELECT '4'  AS APP_GBN    -- 결재구분(0:일일근태,1:근태변경,2:익월근태,3:연차촉진제)                       \n");
			query.append("          ,'파견관리' AS APP_GBN_NM                                                                               \n");
			query.append("          ,SF_GET_ENONAME('01',PENO_NO) AS PENO_NM   --상신자                                                     \n");
			query.append("          ,TO_CHAR(TO_DATE(B.DIS_FR_YMD,'YYYYMMDD'),'YYYY/MM/DD')||' ('||DIS_DAY||'일) '||B.DIS_OBJ AS APP_TITLE  \n");
			query.append("         ,TO_CHAR(A.IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                                              \n");
			query.append("         , A.REQ_NO, GUN_YMD, GUN_DPT                                                                             \n");
			query.append("         , A.ENO_NO                                                                                                \n");
			query.append("         , GUN_GBN, APP_TIME                                                                                      \n");
			query.append("					 ,B.APP_STATUS                                                                                  \n");
			query.append("					 ,B.APP_CMT AS APP_CMT                                                                          \n");
			query.append("					 ,A.PENO_NO                                                                                     \n");
			query.append("                     ,SEQ_NO                                                                                      \n");
			query.append("       FROM T_DI_APPROVAL A,                                                                                      \n");
			query.append("            T_DI_DISPATCH B                                                                                       \n");
			query.append("       WHERE 1=1                                                                                                  \n");
			query.append("       AND    A.REQ_NO = B.ORD_NO                                                                                 \n");
			query.append("       AND    GUN_GBN = 'D'                                                                                       \n");
			query.append("       AND    APP_YN  = 'R'                                                                                       \n");
			query.append("       AND    A.ENO_NO = ?                                                                                        \n");
			query.append("       AND    A.REQ_NO IS NOT NULL                                                                                \n");
			query.append("       AND    B.APP_STATUS IN ('2', '3')    -- 상신, 결재중                                                       \n");
			query.append("       UNION ALL                                                                                                  \n");
			query.append("       SELECT '5'  AS APP_GBN    -- 결재구분(0:일일근태,1:근태변경,2:익월근태,3:연차촉진제)                       \n");
			query.append("          ,'해외출장' AS APP_GBN_NM                                                                               \n");
			query.append("          ,SF_GET_ENONAME('01',PENO_NO) AS PENO_NM   --상신자                                                     \n");
			query.append("          ,TO_CHAR(TO_DATE(B.BUT_FR_YMD,'YYYYMMDD'),'YYYY/MM/DD')||' ('||BUT_DAY||'일) '||B.BUT_OBJ AS APP_TITLE  \n");
			query.append("         ,TO_CHAR(A.IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                                              \n");
			query.append("         , A.REQ_NO, GUN_YMD, GUN_DPT                                                                             \n");
			query.append("         ,A.ENO_NO                                                                                                \n");
			query.append("         , GUN_GBN, APP_TIME                                                                                      \n");
			query.append("		   ,B.APP_STATUS                                                                                          \n");
			query.append("		   ,B.APP_CMT AS APP_CMT                                                                                  \n");
			query.append("		   ,A.PENO_NO                                                                                             \n");
			query.append("         ,SEQ_NO                                                                                                \n");
			query.append("       FROM T_DI_APPROVAL A,                                                                                      \n");
			query.append("            T_DI_OVERSEASTRIP B                                                                                   \n");
			query.append("       WHERE 1=1                                                                                                  \n");
			query.append("       AND    A.REQ_NO = B.ORD_NO                                                                                 \n");
			query.append("       AND    GUN_GBN = 'E'                                                                                       \n");
			query.append("       AND    APP_YN  = 'R'                                                                                       \n");
			query.append("       AND    A.ENO_NO = ?                                                                                        \n");
			query.append("       AND    A.REQ_NO IS NOT NULL                                                                                \n");
			query.append("       AND    B.APP_STATUS IN ('2', '3')    -- 상신, 결재중                                                       \n");
			query.append("   UNION ALL                                                                                    \n");
			query.append("	SELECT	'6'	AS APP_GBN    -- 결재구분(6:휴일수당정산,7:휴일근무신청,8:휴일결과보고)         \n");
			query.append("			,'휴일수당정산' AS APP_GBN_NM                                                       \n");
			query.append("              ,SF_GET_ENONAME('01',PENO_NO) AS PENO_NM                                          \n");
			query.append("              ,SUBSTR(GUN_YMD,1,4) ||'/' || SUBSTR(GUN_YMD,5,6) || ' 휴일근무수당 급여 반영'   AS APP_TITLE   \n");
			query.append("			,TO_CHAR(IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                           \n");
			query.append("			, REQ_NO, GUN_YMD, GUN_DPT                                                          \n");
			query.append("			,''                                                                                \n");
			query.append("			,''                                                                                \n");
			query.append("			,''                                                                                \n");
			query.append("			,'' AS APP_STATUS                                                                  \n");
			query.append("			,'' AS APP_CMT                                                                      \n");
			query.append("			,'' AS PENO_NO                                                                     \n");
			query.append("			,'' AS SEQ_NO                                                                      \n");
			query.append("	FROM	T_DI_APPROVAL                                                                      \n");
			query.append("	WHERE   GUN_GBN = 'J'                                                                      \n");
			query.append("	  AND	APP_YN = 'R'                                                                       \n");
			query.append("	  AND	ENO_NO = ?                                                                         \n");
			query.append("	UNION ALL                                                                                  \n");
			query.append("	SELECT   DISTINCT '7'     AS APP_GBN    -- 결재구분(6:휴일수당정산,7:휴일근무신청,8:휴일결과보고)    \n");
			query.append("			,'휴일근무신청' AS APP_GBN_NM                                                      \n");
			query.append("			,SF_GET_ENONAME('01',PENO_NO) AS PENO_NM                                           \n");
			query.append("			,TO_CHAR(TO_DATE(GUN_YMD,'YYYYMMDD'),'YYYY/MM/DD')||' '||SF_GET_DPTNAME('01','A4',GUN_DPT) AS APP_TITLE        \n");
			query.append("			,TO_CHAR(A.IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                        \n");
			query.append("			, REQ_NO, GUN_YMD, GUN_DPT                                                        \n");
			query.append("			,''                                                                               \n");
			query.append("			,''                                                                               \n");
			query.append("			,''                                                                               \n");
			query.append("			,'' AS APP_STATUS                                                                 \n");
			query.append("			,'' AS APP_CMT                                                                    \n");
			query.append("			,'' AS PENO_NO                                                                    \n");
			query.append("			,'' AS SEQ_NO                                                                     \n");
			query.append("	FROM    T_DI_APPROVAL A , T_DI_HOLIDAYWORK B                                              \n");
			query.append("	WHERE  A.GUN_YMD = B.HOL_YMD															\n");
			query.append("	AND   SUBSTR(A.REQ_NO,10) = B.DPT_CD													\n");
			query.append("	AND   GUN_GBN = 'R'                                                                      \n");
			query.append("	AND   APP_YN is null    AND   B.END_TAG = 'R'  --신청 상신상태만                          \n");
			query.append("	AND   GUN_YMD > TO_CHAR(SYSDATE-55, 'YYYYMMDD')   --원복요망 -14일            \n");
			query.append("	AND   A.ENO_NO = ?                                                              \n");
			query.append("	UNION ALL                                                                     \n");
			query.append("	SELECT  DISTINCT '8'	 AS APP_GBN    -- 결재구분(6:휴일수당정산,7:휴일근무신청,8:휴일결과보고)  \n");
			query.append("			,'휴일결과보고' AS APP_GBN_NM                                           \n");
			query.append("			,SF_GET_ENONAME('01',PENO_NO) AS PENO_NM                                \n");
			query.append("			,TO_CHAR(TO_DATE(GUN_YMD,'YYYYMMDD'),'YYYY/MM/DD')||' '||SF_GET_DPTNAME('01','A4',GUN_DPT) AS APP_TITLE       \n");
			query.append("			,TO_CHAR(A.IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                \n");
			query.append("			, REQ_NO, GUN_YMD, GUN_DPT                                               \n");
			query.append("			,''                                                                      \n");
			query.append("			,''                                                                      \n");
			query.append("			,''                                                                      \n");
			query.append("		,'' AS APP_STATUS                                                          \n");
			query.append("		,'' AS APP_CMT                                                             \n");
			query.append("		,'' AS PENO_NO                                                             \n");
			query.append("		,'' AS SEQ_NO                                                              \n");
			query.append("	FROM	T_DI_APPROVAL A , T_DI_HOLIDAYWORK B                         \n");
			query.append("	WHERE   A.GUN_YMD = B.HOL_YMD                                        \n");
			query.append("	  AND  SUBSTR(A.REQ_NO,10) = B.DPT_CD                                \n");
			query.append("	  AND   GUN_GBN = 'H'                                                \n");
			query.append("	  AND	A.APP_YN is null		AND   B.SIGN_TAG = 'R'  --결과 상신상태만 \n");
			query.append("	  AND	GUN_YMD BETWEEN TO_CHAR(SYSDATE-55,'YYYYMMDD') AND TO_CHAR(SYSDATE,'YYYYMMDD')    \n");
			query.append("	  AND	A.ENO_NO = ?                                                      \n");
			query.append("   UNION ALL                                                                  \n");




			query.append("      SELECT '9'                                                AS APP_GBN,   \n");
			query.append("             '국내출장' AS APP_GBN_NM                                         \n");
			query.append("             ,SF_GET_ENONAME('01',A.PENO_NO) AS PENO_NM                       \n");
			query.append("             ,TO_CHAR(TO_DATE(C.BUT_FR_YMD,'YYYYMMDD'),'YYYY/MM/DD')||' ('||BUT_DAY||'일) '||C.BUT_OBJ AS APP_TITLE    \n");
			query.append("             ,TO_CHAR(C.IPT_YMD,'YYYY-MM-DD') AS APP_YMD                         \n");
			query.append("             , A.REQ_NO  , B.ORD_YMD AS GUN_YMD, A.GUN_DPT						\n");
			query.append("			,''                                                                              \n");
			query.append("			,''                                                                              \n");
			query.append("			,''                                                                              \n");
			query.append("		,B.APP_STATUS                                                                      \n");
			query.append("		,B.APP_CMT AS APP_CMT                                                              \n");
			query.append("		,B.ENO_NO PENO_NO                                                                  \n");
			query.append("		,'' AS SEQ_NO                                                                      \n");
			query.append("        FROM T_DI_APPROVAL A, T_DI_BUSINESSTRIP C, T_DI_BUSINESSTRIP_STATE B     		\n");
			query.append("       WHERE A.GUN_GBN  ='B'                                                       	\n");
			query.append("         AND A.APP_YN IS NULL                                                       	\n");

			query.append("	AND A.REQ_NO NOT IN ( SELECT D.REQ_NO FROM T_DI_APPROVAL D					\n");
			query.append("	WHERE   ((SUBSTR(D.SEQ_NO,0,1) != '9' AND D.SEQ_NO = A.SEQ_NO)					\n");
			query.append("	OR (SUBSTR(A.SEQ_NO,0,1) = '9' AND D.SEQ_NO < A.SEQ_NO))												\n");
			query.append("	AND D.ENO_NO !=?													\n");
			query.append("	AND (D.APP_YN IS NULL OR D.APP_YN NOT IN ('Y'))								\n");
			query.append("	AND D.REQ_NO =A.REQ_NO												\n");
			query.append("	GROUP BY D.REQ_NO HAVING D.REQ_NO NOT IN (SELECT E.REQ_NO FROM T_DI_APPROVAL E	\n");
			query.append("	WHERE   ((SUBSTR(E.SEQ_NO,0,1) != '9' AND E.SEQ_NO > A.SEQ_NO))					\n");
			query.append("	AND E.ENO_NO != ?													\n");
			query.append("	AND (E.APP_YN IS NULL OR E.APP_YN NOT IN ('Y'))								\n");
			query.append("	AND E.REQ_NO =A.REQ_NO												\n");
			query.append("	GROUP BY E.REQ_NO))													\n");

			query.append("         AND A.REQ_NO = C.ORD_NO                                                		\n");
			query.append("         AND A.REQ_NO = B.ORD_NO                                               		\n");
			query.append("         AND B.APP_CMT = '상신'                                       				\n");
			query.append("         AND A.eno_no = ?                                                          	\n");

			query.append("                 UNION ALL                                                                       \n");
			query.append("                    SELECT '10'   AS APP_GBN,                                                    \n");
			query.append("                           '경공조금' AS APP_GBN_NM                                              \n");
			query.append("                           ,SF_GET_ENONAME('01',B.ENO_NO) AS PENO_NM                             \n");
			query.append("                           ,TO_CHAR(TO_DATE(AID_YMD,'YYYYMMDD'),'YYYY/MM/DD')||' '||SF_GET_COMMNAME('01','R1',B.AID_CD) AS APP_TITLE   \n");
			query.append("                           ,TO_CHAR(B.IPT_YMD,'YYYY-MM-DD') AS APP_YMD                     \n");
			query.append("                           , ORD_NO AS REQ_NO , '' AS GUN_YMD, A.DPT_CD  AS GUN_DPT         \n");
			query.append("							,''                                                                           \n");
			query.append("							,''                                                                           \n");
			query.append("							,''                                                                           \n");
			query.append("						,'' AS APP_STATUS                                                               \n");
			query.append("						,'' AS APP_CMT                                                                  \n");
			query.append("						,'' AS PENO_NO                                                                  \n");
			query.append("						,'' AS SEQ_NO                                                                   \n");
			query.append("                      FROM T_AD_DECISION A, T_AD_AIDAPP B                                   \n");
			query.append("                     WHERE A.CK_TAG = 'K'                                                   \n");
			query.append("         --              AND AUTHO_CD = 'A2'                                                \n");
			query.append("                       AND A.ORD_NO = B.REQ_NO                                              \n");
			query.append("                       AND A.APP_YN = 'N'                                                   \n");
			query.append("                       AND B.AID_STS <> 'A'                                                 \n");
			query.append("                       AND B.REQ_YMD >= TO_CHAR(SYSDATE-90,'YYYYMMDD')                      \n");
			query.append("                       AND A.ENO_NO = ?                                                   \n");
			query.append(" UNION ALL                                                                                           \n");
			query.append(" 	SELECT    '11'    AS APP_GBN    -- 결재구분(11.교육신청,12.연간교육신청,13.교육결과보고,14.OJT)    					\n");
			query.append("            ,'교육신청' AS APP_GBN_NM                                                                											\n");
			query.append("            ,SF_GET_ENONAME('01',PENO_NO) AS PENO_NM                                                 							\n");
			query.append("            ,TO_CHAR(TO_DATE(B.STR_YMD,'YYYYMMDD'),'YYYY/MM/DD')||'~'||TO_CHAR(TO_DATE(B.END_YMD,'YYYYMMDD'),'YYYY/MM/DD')||' ['||B.EDU_NM||']' AS APP_TITLE         \n");
			query.append("            ,TO_CHAR(A.IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                                						\n");
			query.append("            , A.REQ_NO, GUN_YMD, GUN_DPT                                                               									\n");
			query.append("            ,A.ENO_NO                                                                                  											\n");
			query.append("            ,A.GUN_GBN                                                                                	 										\n");
			query.append("            ,''                                                                                        													\n");
			query.append("        ,'' AS APP_STATUS                                                                              											\n");
			query.append("        ,'' AS APP_CMT                                                                                 											\n");
			query.append("        ,A.PENO_NO   AS PENO_NO                                                                        									\n");
			query.append("        ,A.SEQ_NO    AS SEQ_NO                                                                         										\n");
			query.append("    FROM    T_DI_APPROVAL A, T_CM_EDUCATION B                                                          							\n");
			query.append("    WHERE   A.REQ_NO = B.REQ_NO                                                                        									\n");
			query.append("      AND   GUN_GBN = 'M'                                                                              										\n");
			query.append("      AND   APP_YN IS NULL  AND B.DECISION_CD = 'A'  --교육신청결재상태 Q4                             						\n");
			query.append("      AND   A.ENO_NO = ?                                                                               										\n");
			query.append("                  AND A.REQ_NO NOT IN ( SELECT D.REQ_NO FROM T_DI_APPROVAL D											\n");
			query.append("                 WHERE   ((SUBSTR(D.SEQ_NO,0,1) != '9' AND D.SEQ_NO = A.SEQ_NO)											\n");
			query.append("                 OR (SUBSTR(A.SEQ_NO,0,1) = '9' AND D.SEQ_NO < A.SEQ_NO))													\n");
			query.append("                 AND D.ENO_NO != ?																												\n");
			query.append("                 AND (D.APP_YN IS NULL OR D.APP_YN NOT IN ('Y'))																	\n");
			query.append("                 AND D.REQ_NO =A.REQ_NO																									\n");
			query.append("                     GROUP BY D.REQ_NO HAVING D.REQ_NO NOT IN (SELECT E.REQ_NO FROM T_DI_APPROVAL E		\n");
			query.append("                             WHERE   ((SUBSTR(E.SEQ_NO,0,1) != '9' AND E.SEQ_NO > A.SEQ_NO))								\n");
			query.append("                             AND E.ENO_NO != ?																									\n");
			query.append("                             AND (E.APP_YN IS NULL OR E.APP_YN NOT IN ('Y'))														\n");
			query.append("                             AND E.REQ_NO =A.REQ_NO																						\n");
			query.append("                             GROUP BY E.REQ_NO))     																						\n");
			query.append("      AND NOT EXISTS (SELECT 'x' FROM T_ED_YEARPLAN WHERE TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN APP_STR_YMD AND APP_END_YMD)                                           \n");
			query.append(" UNION ALL                                                                                                                                                           \n");
			query.append(" 	SELECT    '12'    AS APP_GBN    -- 결재구분(11.교육신청,12.연간교육신청,13.교육결과보고,14.OJT)                                                                    \n");
			query.append("            ,'연간교육신청' AS APP_GBN_NM                                                                                                                            \n");
			query.append("            ,SF_GET_ENONAME('01',PENO_NO) AS PENO_NM                                                                                                                 \n");
			query.append("            ,TO_CHAR(TO_DATE(B.STR_YMD,'YYYYMMDD'),'YYYY/MM/DD')||'~'||TO_CHAR(TO_DATE(B.END_YMD,'YYYYMMDD'),'YYYY/MM/DD')||' ['||B.EDU_NM||']' AS APP_TITLE         \n");
			query.append("            ,TO_CHAR(A.IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                                 \n");
			query.append("            , A.REQ_NO, GUN_YMD, GUN_DPT                                                                \n");
			query.append("            ,A.ENO_NO                                                                                   \n");
			query.append("            ,A.GUN_GBN                                                                                  \n");
			query.append("            ,''                                                                                         \n");
			query.append("        ,'' AS APP_STATUS                                                                               \n");
			query.append("        ,'' AS APP_CMT                                                                                  \n");
			query.append("        ,A.PENO_NO   AS PENO_NO                                                                         \n");
			query.append("        ,A.SEQ_NO    AS SEQ_NO                                                                          \n");
			query.append("    FROM    T_DI_APPROVAL A, T_CM_EDUCATION B                                                           \n");
			query.append("    WHERE   A.REQ_NO = B.REQ_NO                                                                         \n");
			query.append("      AND GUN_GBN = 'M'                                                                                 \n");
			query.append("      AND    APP_YN IS NULL                                                                             \n");
			query.append("      AND    A.ENO_NO = ?                                                                               \n");
			query.append("      AND EXISTS (SELECT 'x' FROM T_ED_YEARPLAN WHERE TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN APP_STR_YMD AND APP_END_YMD)                                               \n");
			query.append(" UNION ALL                                                                                              \n");
			query.append(" 	SELECT    '13'    AS APP_GBN    -- 결재구분(11.교육신청,12.연간교육신청,13.교육결과보고,14.OJT)       \n");
			query.append("            ,'교육결과보고' AS APP_GBN_NM                                                               \n");
			query.append("            ,SF_GET_ENONAME('01',PENO_NO) AS PENO_NM                                                    \n");
			query.append("            ,TO_CHAR(TO_DATE(B.STR_YMD,'YYYYMMDD'),'YYYY/MM/DD')||'~'||TO_CHAR(TO_DATE(B.END_YMD,'YYYYMMDD'),'YYYY/MM/DD')||' ['||B.EDU_NM||']' AS APP_TITLE         \n");
			query.append("            ,TO_CHAR(A.IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                                 \n");
			query.append("            , A.REQ_NO, GUN_YMD, GUN_DPT                                                                \n");
			query.append("            ,A.ENO_NO                                                                                   \n");
			query.append("            ,A.GUN_GBN                                                                                  \n");
			query.append("            ,''                                                                                         \n");
			query.append("        ,'' AS APP_STATUS                                                                               \n");
			query.append("        ,'' AS APP_CMT                                                                                  \n");
			query.append("        ,A.PENO_NO   AS PENO_NO                                                                         \n");
			query.append("        ,A.SEQ_NO    AS SEQ_NO                                                                          \n");
			query.append("    FROM    T_DI_APPROVAL A, T_CM_EDUCATION B                                                           \n");
			query.append("    WHERE   A.REQ_NO = B.RPT_REQ_NO                                                                     \n");
			query.append("      AND GUN_GBN = 'N'                                                                                 \n");
			query.append("      AND    APP_YN IS NULL                                                                             \n");
			query.append("      AND    A.ENO_NO = ?                                                                               \n");
			query.append(" UNION ALL                                                                                              \n");
			query.append(" 	SELECT    '14'    AS APP_GBN    -- 결재구분(11.교육신청,12.연간교육신청,13.교육결과보고,14.OJT)       \n");
			query.append("            ,'신입사원OJT' AS APP_GBN_NM                                                                \n");
			query.append("            ,SF_GET_ENONAME('01',PENO_NO) AS PENO_NM                                                    \n");
			query.append("            ,SF_GET_ENONAME('01',B.ENO_NO)||' ['||SF_GET_DPTNAME('01','A4',TRA_DPT_CD)||']' AS APP_TITLE \n");
			query.append("            ,TO_CHAR(A.IPT_YMD,'YYYY-MM-DD') AS APP_YMD                                       \n");
			query.append("            , A.REQ_NO, GUN_YMD, GUN_DPT                                                      \n");
			query.append("            ,A.ENO_NO                                                                         \n");
			query.append("            ,A.GUN_GBN                                                                        \n");
			query.append("            ,''                                                                               \n");
			query.append("        ,'' AS APP_STATUS                                                                     \n");
			query.append("        ,'' AS APP_CMT                                                                        \n");
			query.append("        ,A.PENO_NO   AS PENO_NO                                                               \n");
			query.append("        ,A.SEQ_NO    AS SEQ_NO                                                                \n");
			query.append("    FROM    T_DI_APPROVAL A, T_CD_OJTMST B                                                    \n");
			query.append("    WHERE   A.REQ_NO = B.REQ_NO                                                               \n");
			query.append("      AND GUN_GBN = 'L'                                                                       \n");
			query.append("      AND    APP_YN IS NULL                                                                   \n");
			query.append("      AND    A.ENO_NO = ?                                                                     							\n");
			query.append(" UNION ALL																													\n");
			query.append(" SELECT    '15'    AS APP_GBN    -- 결재구분(15.도서구입)														\n");
			query.append(" ,'도서구입' AS APP_GBN_NM																							\n");
			query.append(" ,SF_GET_ENONAME('01',PENO_NO) AS PENO_NM																\n");
			query.append(" ,TO_CHAR(B.IPT_YMD,'YYYY/MM/DD') ||' ' ||SF_GET_ENONAME('01',B.IPT_MAN)||'  '  ||C.BOOK_NM||' / 용도:'|| B.RQST_REMARK AS APP_TITLE \n");
			query.append(" ,TO_CHAR(A.IPT_YMD,'YYYY-MM-DD') AS APP_YMD															\n");
			query.append(" , A.REQ_NO, GUN_YMD, GUN_DPT																					\n");
			query.append(" ,A.ENO_NO																													\n");
			query.append(" ,A.GUN_GBN																												\n");
			query.append(" ,''																																\n");
			query.append(" ,'' AS APP_STATUS																										\n");
			query.append(" ,'' AS APP_CMT																											\n");
			query.append(" ,A.PENO_NO   AS PENO_NO																							\n");
			query.append(" ,A.SEQ_NO    AS SEQ_NO																								\n");
			query.append(" FROM    T_DI_APPROVAL A, T_ED_BOOKM B, T_ED_BOOKD C												\n");
			query.append(" WHERE   A.REQ_NO = B.RQST_NO AND B.RQST_NO = C.RQST_NO AND C.RQST_SEQ = '1'			\n");
			query.append("   AND GUN_GBN = 'Q'																									\n");
			query.append("   AND (APP_YN IS NULL OR APP_YN = 'A')																		\n");
			query.append("                       AND A.ENO_NO = '6050006'																		\n");
			query.append("    AND A.REQ_NO NOT IN ( SELECT D.REQ_NO FROM T_DI_APPROVAL D									\n");
			query.append("    WHERE   ((SUBSTR(D.SEQ_NO,0,1) != '9' AND D.SEQ_NO = A.SEQ_NO)								\n");
			query.append("    OR (SUBSTR(A.SEQ_NO,0,1) = '9' AND D.SEQ_NO < A.SEQ_NO))										\n");
			query.append("    AND D.ENO_NO != ?																									\n");
			query.append("    AND (D.APP_YN IS NULL OR D.APP_YN NOT IN ('Y'))														\n");
			query.append("    AND D.REQ_NO =A.REQ_NO																						\n");
			query.append("        GROUP BY D.REQ_NO HAVING D.REQ_NO NOT IN (SELECT E.REQ_NO FROM T_DI_APPROVAL E		\n");
			query.append("                WHERE   ((SUBSTR(E.SEQ_NO,0,1) != '9' AND E.SEQ_NO > A.SEQ_NO))					\n");
			query.append("                AND E.ENO_NO !=  ?																						\n");
			query.append("                AND (E.APP_YN IS NULL OR E.APP_YN NOT IN ('Y'))											\n");
			query.append("                AND E.REQ_NO =A.REQ_NO																			\n");
			query.append("                GROUP BY E.REQ_NO))																					\n");
			query.append("   AND B.END_TAG NOT IN ('N')																						\n");
			query.append("   AND A.ENO_NO =?																										\n");
			query.append("                  ) 																											\n");
			query.append(" UNION ALL																													\n");
			query.append("	SELECT    '16'    AS APP_GBN																						\n");
			query.append("	,'일용직노무비' AS APP_GBN_NM																					\n");
			query.append("	,SF_GET_ENONAME('01',PENO_NO) AS PENO_NM															\n");
			query.append("	,TO_CHAR(IPT_YMD,'YYYY/MM/DD')||' '||SF_GET_COMMNAME('01', 'AY', SUBSTR(REQ_NO,7,4))||' '	\n");
			query.append("	||SUBSTR(REQ_NO,1,4)||'년도 '||SUBSTR(REQ_NO,5,2)||'월 '||' 일용직 노무비' AS  APP_TITLE		\n");
			query.append("	,TO_CHAR(A.IPT_YMD,'YYYY-MM-DD') AS APP_YMD															\n");
			query.append("	, A.REQ_NO, GUN_YMD, GUN_DPT																					\n");
			query.append("	,A.ENO_NO																													\n");
			query.append("	,A.GUN_GBN																												\n");
			query.append("	,''																																\n");
			query.append("	,'' AS APP_STATUS																										\n");
			query.append("	,'' AS APP_CMT																											\n");
			query.append("	,A.PENO_NO   AS PENO_NO																							\n");
			query.append("	,A.SEQ_NO    AS SEQ_NO																								\n");
			query.append("	FROM T_DI_APPROVAL A																								\n");
			query.append("	WHERE																														\n");
			query.append("	A.GUN_GBN = 'K'																											\n");
			query.append("	AND A.ENO_NO = ?																										\n");
			query.append("	AND (A.APP_YN IS NULL OR A.APP_YN = 'R')																		\n");
			query.append("              )   																												\n");
			
			
			//Log.main.println(query.toString());
    	  pstmt = conn.prepareStatement(query.toString());

    	  int colCnt = 0;

    	  pstmt.setString(++colCnt, ENO_NO);		//사원번호
    	  pstmt.setString(++colCnt, ENO_NO);		//사원번호
    	  pstmt.setString(++colCnt, ENO_NO);		//사원번호
    	  pstmt.setString(++colCnt, ENO_NO);		//사원번호
    	  pstmt.setString(++colCnt, ENO_NO);		//사원번호
    	  pstmt.setString(++colCnt, ENO_NO);		//사원번호
    	  pstmt.setString(++colCnt, ENO_NO);		//사원번호
    	  pstmt.setString(++colCnt, ENO_NO);		//사원번호
    	  pstmt.setString(++colCnt, ENO_NO);		//사원번호
    	  pstmt.setString(++colCnt, ENO_NO);		//사원번호
    	  pstmt.setString(++colCnt, ENO_NO);		//사원번호
    	  pstmt.setString(++colCnt, ENO_NO);		//사원번호
    	  pstmt.setString(++colCnt, ENO_NO);		//사원번호
    	  pstmt.setString(++colCnt, ENO_NO);		//사원번호
    	  pstmt.setString(++colCnt, ENO_NO);		//사원번호
    	  pstmt.setString(++colCnt, ENO_NO);		//사원번호
    	  pstmt.setString(++colCnt, ENO_NO);		//사원번호    	  
    	  pstmt.setString(++colCnt, ENO_NO);		//사원번호
    	  pstmt.setString(++colCnt, ENO_NO);		//사원번호
    	  pstmt.setString(++colCnt, ENO_NO);		//사원번호
    	  pstmt.setString(++colCnt, ENO_NO);		//사원번호
    	  pstmt.setString(++colCnt, ENO_NO);		//사원번호
    	  pstmt.setString(++colCnt, ENO_NO);		//사원번호    	  
    	  ResultSet rs = pstmt.executeQuery();
		  if(rs.next()){
			cnt = rs.getInt("cnt");//미결재수
		  }
        } catch (Exception e) {
    		e.printStackTrace();
        } finally {
          if (pstmt != null) {
            try {
    			pstmt.close();

    		} catch (Exception e) {}
          }
          if (conn != null) {
              try {
      			conn.close();

      		} catch (Exception e) {}
            }
        }
		return cnt;
    }
	public Connection getConn(){
		Connection con = null;
		try{
		    Context ctx = new InitialContext();  //Interface = new Class
		    DataSource ds = (javax.sql.DataSource)ctx.lookup("jdbc/ASNHR");
		    con = ds.getConnection();
		}catch(Exception e){
			e.printStackTrace();
		}
		return con;
	}

}