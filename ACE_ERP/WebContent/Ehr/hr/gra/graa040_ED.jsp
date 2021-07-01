<!--
***********************************************************************
* @source      : memb110_ED.jsp
* @description : 개인별 급,상여 현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/26      김학수        최초작성.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%
    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("gra", "GRAA040_SHR");

    String SND_KIND = request.getParameter("SND_KIND");
    String OCC_CD   = request.getParameter("OCC_CD");
    String RAI_YMD  = request.getParameter("RAI_YMD");
    String AOW_GBN  = request.getParameter("AOW_GBN");
    String AOW_YMD  = request.getParameter("AOW_YMD");
    String DPT_CD   = request.getParameter("DPT_CD");
    String JOB_CD   = request.getParameter("JOB_CD");
    String GBN      = request.getParameter("GBN");

    /** 조회 조건(급/상여, 근로구분)에 따른 처리 **/
    StringBuffer sb = new StringBuffer();
    if ( !SND_KIND.equals("BNS") || !OCC_CD.equals("M")) {
    if ( GBN.equals("DPT") ) {
        sb.append(" SELECT DECODE(INT,3,'합계',A.PJOB_CD)                                           PJOB_CD         \n");
        sb.append("  	 , DECODE(INT,3,'합계',1,SF_GET_COMMNAME('01', 'A2', PJOB_CD)||'계',2,SF_GET_COMMNAME('01', 'A2', PJOB_CD))     JOB_NM	  		\n");
        sb.append("  	 , MAX(DECODE(INT,3,'',1,'',2,A.DPT_CD))	                                DPT_CD	  		\n");
        sb.append("  	 , MAX(DECODE(INT,3,'합계',1,'직위계',2,SF_GET_DPTNAME('01','A4',A.DPT_CD)))    DPT_NM	  		\n");

    } else if ( GBN.equals("JOB") ) {
        sb.append(" SELECT DECODE(INT,3,'합계',A.DPT_CD)		                                     DPT_CD 		\n");
        sb.append("  	 , DECODE(INT,3,'합계',1,SF_GET_DPTNAME('01','A4',A.DPT_CD)||'계',2,SF_GET_DPTNAME('01','A4',A.DPT_CD))      DPT_NM 	  \n");
        sb.append("  	 , MAX(DECODE(INT,3,'',1,'',2,A.PJOB_CD))	 							     PJOB_CD	  		\n");
        sb.append("  	 , MAX(DECODE(INT,3,'',1,'',2,SF_GET_COMMNAME('01', 'A2', PJOB_CD)||'계',2,SF_GET_COMMNAME('01', 'A2', PJOB_CD)))    JOB_NM	  		\n");
    }

        sb.append("  	 , DECODE(INT,3,'',1,'',2,A.ENO_NO)                             ENO_NO	  		\n");
        sb.append("  	 , DECODE(INT,3,'',1,'',2,SF_GET_ENONAME('01',A.ENO_NO))        ENO_NM	  		\n");
        sb.append("  	 , TO_CHAR(To_Date(MAX(DECODE(INT,3,'',1,'',2,A.HIR_YMD)),'yyyy/mm/dd'),'YYYY/MM/DD')    HIR_YMD	  		\n");
        sb.append("  	 , TO_CHAR(TO_DATE(MAX(DECODE(INT,3,'',1,'',2,A.GHI_YMD)),'YYYY/MM/DD'),'YYYY/MM/DD')                       GHI_YMD	  		\n");
        sb.append("  	 , TO_CHAR(TO_DATE(MAX(DECODE(INT,3,'',1,'',2,A.FPRO_YMD)),'YYYY/MM/DD'),'YYYY/MM/DD')                      FPRO_YMD	    \n");
        sb.append("  	 , MAX(DECODE(INT,3,'',1,'',2,A.YRP_CNT))                       YRP_CNT	  		\n");
        sb.append("  	 , MAX(DECODE(INT,3,'',1,'',2,A.BAS_HOB))                       BAS_HOB	  		\n");
        sb.append("  	 , MAX(DECODE(INT,3,'',1,'',2,A.HOB))                           HOB	  		    \n");
        sb.append("  	 , SUM(A.SAL_AMT)                                               SAL_AMT	  		\n");
        sb.append("  	 , MAX(DECODE(INT,3,'',1,'',2,A.CON_HOB))                       CON_HOB	  		\n");
        sb.append("  	 , SUM(A.CON_SAL)                                               CON_SAL	  		\n");
        sb.append("  	 , MAX(DECODE(INT,3,'',1,'',2,A.FIN_HOB))                       FIN_HOB	  		\n");
        sb.append("  	 , SUM(A.FIN_SAL)                                               FIN_SAL	  		\n");
        sb.append("  	 , SUM((A.FIN_SAL)-(A.SAL_AMT))                                 INC_AMT	  		\n");
        sb.append("  	 , DECODE(SUM((A.FIN_SAL)-(A.SAL_AMT)), 0, 0,ROUND((SUM((A.FIN_SAL)-(A.SAL_AMT))/SUM(A.SAL_AMT))*100, 1))    INC_PER	  		\n");
        sb.append("  	 , SUM(CASE WHEN ( FLOOR(MONTHS_BETWEEN('"+AOW_YMD.replaceAll("-", "")+"',A.HIR_YMD)/12)) IN (0,1,2,3) THEN 0 		  		\n");
        sb.append("  		   ELSE FLOOR((FLOOR(MONTHS_BETWEEN('"+AOW_YMD.replaceAll("-", "")+"',A.HIR_YMD)/12))/2)*10000 END)        AOW_AMT   	\n");
        sb.append("  	 , MAX(DECODE(INT,3,'',1,'',2,A.REMARK))										        REMARK      \n");
        sb.append("      , MAX(INT)			                                            GUBUN           \n");
        sb.append(" FROM    T_PM_GRADE A,                                                                   \n");
        sb.append("        ( SELECT ROWNUM INT												\n");
        sb.append("            FROM DICT                                         		\n");
        sb.append("           WHERE ROWNUM <=3														\n");
        sb.append("        ) COPTY																	\n");
        sb.append(" WHERE  RAI_YMD = '"+RAI_YMD.replaceAll("-", "")+"'													\n");
        sb.append(" AND       OCC_CD = '"+OCC_CD+"' 																			\n");
        if(GBN.equals("DPT")) {
            sb.append(" AND       DPT_CD = '"+DPT_CD+"' 																			\n");
        } else if(GBN.equals("JOB")) {
            sb.append(" AND       PJOB_CD = '"+JOB_CD+"' 																		\n");
        }
    if ( GBN.equals("DPT") ) {
        sb.append("GROUP BY DECODE(INT,3,'합계',A.PJOB_CD)                                                   \n");
        sb.append("       , DECODE(INT,3,'합계',1,SF_GET_COMMNAME('01', 'A2', PJOB_CD)||'계',2,SF_GET_COMMNAME('01', 'A2', PJOB_CD))    \n");
        sb.append("       , DECODE(INT,3,'',1,'',2,A.ENO_NO)                                        \n");
        sb.append("       , DECODE(INT,3,'',1,'',2,SF_GET_ENONAME('01',A.ENO_NO))                   \n");
    } else if ( GBN.equals("JOB") ) {
        sb.append("GROUP BY DECODE(INT,3,'합계',A.DPT_CD)                                           \n");
        sb.append("       , DECODE(INT,3,'합계',1,SF_GET_DPTNAME('01','A4',A.DPT_CD)||'계',2,SF_GET_DPTNAME('01','A4',A.DPT_CD))        \n");
        sb.append("       , DECODE(INT,3,'',1,'',2,A.ENO_NO)                                        \n");
        sb.append("       , DECODE(INT,3,'',1,'',2,SF_GET_ENONAME('01',A.ENO_NO))                   \n");
    }
//        sb.append("ORDER BY DECODE(INT,3,'',1,'',2,A.ENO_NO)                  \n");


    //	택배직, 상여의 경우	T_PM_GRADE에서는 택배수당 및 자기개발비(택배)를 제외한 금액을 가져올 수 없으므로
    }else{
    if ( GBN.equals("DPT") ) {
        sb.append(" SELECT DECODE(INT,3,'합계',A.TEMP_JOB)                      TEMP_JOB      \n");
        sb.append("      , DECODE(INT,3,'합계',1,SF_GET_COMMNAME('01', 'A2', TEMP_JOB)||'계',2,SF_GET_COMMNAME('01', 'A2', TEMP_JOB))      JOB_NM        \n");
        sb.append("      , MAX(DECODE(INT,3,'',1,'',2,A.DPT_CD))                DPT_CD        \n");
        sb.append("      , MAX(DECODE(INT,3,'합계',1,'직위계',2,A.DPT_NM))      DPT_NM        \n");
    } else if ( GBN.equals("JOB") ) {
        sb.append(" SELECT DECODE(INT,3,'합계',A.DPT_CD)                        DPT_CD        \n");
        sb.append("      , DECODE(INT,3,'합계',1,DPT_NM||'계',2,A.DPT_NM)       DPT_NM        \n");
        sb.append("      , MAX(DECODE(INT,3,'',1,'',2,A.TEMP_JOB))              TEMP_JOB      \n");
        sb.append("      , MAX(DECODE(INT,3,'',1,'',2,SF_GET_COMMNAME('01', 'A2', TEMP_JOB)||'계',2,SF_GET_COMMNAME('01', 'A2', TEMP_JOB)))    JOB_NM      \n");
    }
        sb.append("      , DECODE(INT,3,'',1,'',2,A.ENO_NO)                ENO_NO        \n");
        sb.append("      , DECODE(INT,3,'',1,'',2,A.ENO_NM)                ENO_NM        \n");
        sb.append("      , TO_CHAR(TO_DATE(MAX(DECODE(INT,3,'',1,'',2,A.HIR_YMD)),'YYYY/MM/DD'),'YYYY/MM/DD')          HIR_YMD       \n");
        sb.append("      , TO_CHAR(To_Date(MAX(DECODE(INT,3,'',1,'',2,A.GHI_YMD)),'YYYY/MM/DD'),'YYYY/MM/DD')          GHI_YMD       \n");
        sb.append("      , TO_CHAR(To_Date(MAX(DECODE(INT,3,'',1,'',2,A.FPRO_YMD)),'YYYY/MM/DD'),'YYYY/MM/DD')         FPRO_YMD      \n");
        sb.append("      , MAX(DECODE(INT,3,'',1,'',2,A.YRP_CNT))          YRP_CNT       \n");
        sb.append("      , MAX(DECODE(INT,3,'',1,'',2,A.BAS_HOB))          BAS_HOB       \n");
        sb.append("      , MAX(DECODE(INT,3,'',1,'',2,A.HOB))			   HOB           \n");
        sb.append("      , MAX(DECODE(INT,3,'',1,'',2,A.CON_HOB))	       CON_HOB       \n");
        sb.append("      , MAX(DECODE(INT,3,'',1,'',2,A.FIN_HOB))	 	   FIN_HOB       \n");
        sb.append("      , MAX(DECODE(INT,3,'',1,'',2,A.REMARK))           REMARK        \n");
    if(AOW_GBN.equals("Y")) {
        sb.append("      , SUM(A.AOW_AMT)		                        AS AOW_AMT       \n");
    }
        sb.append("      , SUM(B.TOT_AMT)                               AS SAL_AMT       \n");
        sb.append("      , SUM(C.TOT_AMT)                               AS CON_SAL       \n");
        sb.append("      , SUM(D.TOT_AMT)                               AS FIN_SAL       \n");
        sb.append("      , SUM((D.TOT_AMT-B.TOT_AMT))                   AS INC_AMT       \n");
        sb.append("      , SUM((D.TOT_AMT)-(B.TOT_AMT))				                     \n");
        sb.append("      , MAX(0)					                                     \n");
        sb.append("      , MAX(0)			Y					                         \n");
        sb.append("      , DECODE(SUM((D.TOT_AMT)-(B.TOT_AMT)), 0, 0, ROUND((SUM((D.TOT_AMT)-(B.TOT_AMT))/SUM(B.TOT_AMT))*100, 1))    AS INC_PER   \n");
        sb.append("      , MAX(INT)			                               GUBUN         \n");


        sb.append(" FROM    ( SELECT AA.RAI_YMD, AA.OCC_CD, AA.PJOB_CD, AA.STTJ_CD, AA.HOB,									\n");
        sb.append(" 							 AA.DPT_CD, SF_GET_DPTNAME('01','A4',AA.DPT_CD) AS DPT_NM,							\n");
        sb.append(" 							 AA.ENO_NO, SF_GET_ENONAME('01',AA.ENO_NO) AS ENO_NM,									\n");
        sb.append(" 							 AA.HIR_YMD, AA.GHI_YMD, AA.FPRO_YMD, AA.YRP_CNT, AA.BAS_HOB,						\n");
        sb.append("								 AA.CON_HOB, AA.FIN_HOB, AA.REMARK,																		\n");
        sb.append("								 DECODE(AA.OCC_CD, 'A', 																							\n");
        sb.append("										DECODE(AA.STTJ_CD,'7A',AA.PJOB_CD,																\n");
        sb.append("											NVL(AA.STTJ_CD, AA.PJOB_CD)), AA.PJOB_CD ) AS TEMP_JOB,						\n");
        if(AOW_GBN.equals("Y")) {
            sb.append("							 CASE WHEN (																												\n");
            sb.append("                                     FLOOR(MONTHS_BETWEEN('"+AOW_YMD.replaceAll("-", "")+"', 	\n");
            sb.append("                                             HIR_YMD)/12)) IN (0,1,2,3) THEN 0															\n");
            sb.append("							 ELSE FLOOR((																												\n");
            sb.append("                                        FLOOR(MONTHS_BETWEEN('"+AOW_YMD.replaceAll("-", "")+"', \n");
            sb.append("                                             HIR_YMD)/12))/2)*10000 END AOW_AMT,													\n");
        }
        sb.append("								 ( SELECT MAX(APY_YMD)																							\n");
        sb.append(" 							   FROM   T_CP_PAYTABLE																							\n");
        sb.append("								   WHERE  OCC_CD = AA.OCC_CD																					\n");
        sb.append("								   AND    JOB_CD = DECODE(AA.OCC_CD, 'A', 																\n");
        sb.append(" 																DECODE(AA.STTJ_CD,'7A',AA.PJOB_CD,									\n");
        sb.append(" 																		NVL(AA.STTJ_CD, AA.PJOB_CD)), AA.PJOB_CD ) 				\n");
        sb.append(" 							   AND    AA.HOB = HOB_CD 																							\n");
        sb.append(" 							   AND    AA.RAI_YMD > APY_YMD ) AS APY_YMD, 														\n");
        sb.append(" 							 ( SELECT MAX(APY_YMD) 																							\n");
        sb.append(" 							   FROM   T_CP_PAYTABLE 																							\n");
        sb.append("  							   WHERE  OCC_CD = AA.OCC_CD 																				\n");
        sb.append("  							   AND    JOB_CD = DECODE(AA.OCC_CD, 'A',  																\n");
        sb.append("                     											DECODE(AA.STTJ_CD,'7A',AA.PJOB_CD, 									\n");
        sb.append("   																	NVL(AA.STTJ_CD, AA.PJOB_CD)), AA.PJOB_CD ) 					\n");
        sb.append("   							   AND    AA.HOB = HOB_CD 																							\n");
        sb.append("   							   AND    AA.RAI_YMD >= APY_YMD ) AS CON_YMD, 														\n");
        sb.append("   							 ( SELECT MAX(APY_YMD) 																							\n");
        sb.append("   							   FROM   T_CP_PAYTABLE 																							\n");
        sb.append("   							   WHERE  OCC_CD = AA.OCC_CD 																				\n");
        sb.append("   							   AND    JOB_CD = DECODE(AA.OCC_CD, 'A', 																\n");
        sb.append("   																DECODE(AA.STTJ_CD,'7A',AA.PJOB_CD, 									\n");
        sb.append("   																	NVL(AA.STTJ_CD, AA.PJOB_CD)), AA.PJOB_CD ) 					\n");
        sb.append("   							   AND    AA.FIN_HOB = HOB_CD 																					\n");
        sb.append("   							   AND    AA.RAI_YMD >= APY_YMD ) AS FIN_YMD															\n");
        sb.append(" 			       FROM   T_PM_GRADE AA 																										\n");
        sb.append(" 				   WHERE  AA.RAI_YMD = '"+RAI_YMD.replaceAll("-", "")+"' 										\n");
        sb.append(" 				   AND       AA.OCC_CD='"+OCC_CD+"' 																	\n");
        if(GBN.equals("DPT")) {
            sb.append(" 			   AND       AA.DPT_CD = '"+DPT_CD+"' 																	\n");
        } else if(GBN.equals("JOB")) {
            sb.append(" 			   AND       AA.PJOB_CD = '"+JOB_CD+"' 																\n");
        }
        sb.append(" 																							) A, 																\n");
        sb.append(" 				 ( SELECT OCC_CD, JOB_CD, HOB_CD, APY_YMD,  																	\n");
        sb.append("  								(BAS_AMT+DUTY_AMT+OT_AMT+WEL_AMT+RUN_AMT) AS TOT_AMT 						\n");
        sb.append(" 				   FROM   T_CP_PAYTABLE ) B, 																								\n");
        sb.append("  				 ( SELECT OCC_CD, JOB_CD, HOB_CD, APY_YMD,  																	\n");
        sb.append("        							 (BAS_AMT+DUTY_AMT+OT_AMT+WEL_AMT+RUN_AMT) AS TOT_AMT 					\n");
        sb.append("    				   FROM   T_CP_PAYTABLE ) C, 																								\n");
        sb.append("  				 ( SELECT OCC_CD, JOB_CD, HOB_CD, APY_YMD,  																	\n");
        sb.append("           						(BAS_AMT+DUTY_AMT+OT_AMT+WEL_AMT+RUN_AMT) AS TOT_AMT 						\n");
        sb.append("     			   FROM   T_CP_PAYTABLE ) D,																\n");
        sb.append("     			 ( SELECT ROWNUM INT												\n");
        sb.append("     			     FROM DICT                                         		\n");
        sb.append("     			    WHERE ROWNUM <=3														\n");
        sb.append("     			 ) COPTY																	\n");
        sb.append(" 				   WHERE  A.OCC_CD   = B.OCC_CD(+) 																					\n");
        sb.append(" AND    A.TEMP_JOB = B.JOB_CD(+) 																											\n");
        sb.append(" AND    A.HOB      = B.HOB_CD(+) 																												\n");
        sb.append(" AND    A.APY_YMD  = B.APY_YMD(+) 																										\n");
        sb.append(" AND    A.OCC_CD   = C.OCC_CD(+) 																											\n");
        sb.append(" AND    A.TEMP_JOB = C.JOB_CD(+) 																											\n");
        sb.append(" AND    A.CON_HOB  = C.HOB_CD(+) 																										\n");
        sb.append(" AND    A.CON_YMD  = C.APY_YMD(+) 																										\n");
        sb.append(" AND    A.OCC_CD   = D.OCC_CD(+) 																											\n");
        sb.append(" AND    A.TEMP_JOB = D.JOB_CD(+) 																											\n");
        sb.append(" AND    A.FIN_HOB  = D.HOB_CD(+) 																											\n");
        sb.append(" AND    A.FIN_YMD  = D.APY_YMD(+) 																											\n");
    if ( GBN.equals("DPT") ) {
        sb.append("GROUP BY DECODE(INT,3,'합계',A.TEMP_JOB)                         \n");
        sb.append("        ,DECODE(INT,3,'합계',1,SF_GET_COMMNAME('01', 'A2', TEMP_JOB)||'계',2,SF_GET_COMMNAME('01', 'A2', TEMP_JOB))       \n");
        sb.append("        ,DECODE(INT,3,'',1,'',2,A.ENO_NO)                             \n");
        sb.append("        ,DECODE(INT,3,'',1,'',2,A.ENO_NM)                             \n");
    } else if ( GBN.equals("JOB") ) {
        sb.append("GROUP BY DECODE(INT,3,'합계',A.DPT_CD)                           \n");
        sb.append("        ,DECODE(INT,3,'합계',1,DPT_NM||'계',2,A.DPT_NM)          \n");
        sb.append("        ,DECODE(INT,3,'',1,'',2,A.ENO_NO)                        \n");
        sb.append("        ,DECODE(INT,3,'',1,'',2,A.ENO_NM)                        \n");
    }
    }
    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {
            sb.toString()
    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** 검색 조건 Mapping(PrepareStatement ) **/
    Object[] bind = new Object[] {

    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("소속");
    hnwExtQuery.AddField("성명");
    hnwExtQuery.AddField("사번");
    hnwExtQuery.AddField("입사일");
    hnwExtQuery.AddField("그룹입사일");
    hnwExtQuery.AddField("최종승진일");
    hnwExtQuery.AddField("년차");
    hnwExtQuery.AddField("기준호봉");
    hnwExtQuery.AddField("현재호봉");
    hnwExtQuery.AddField("현금여");
    hnwExtQuery.AddField("조정호봉");
    hnwExtQuery.AddField("조정급여");
    hnwExtQuery.AddField("확정호봉");
    hnwExtQuery.AddField("확정급여");
    hnwExtQuery.AddField("근속수당");
    hnwExtQuery.AddField("인상액");
    hnwExtQuery.AddField("인상율 %");
    hnwExtQuery.AddField("비고");
    hnwExtQuery.AddField("구분");

    hnwExtQuery.SendField(response);

    int eno_cnt = -1;
    int tot_cnt = 0;
//    System.out.println("voList.size()="+voList.size());
    if (voList.size() > 0)
    {
        for ( int i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            eno_cnt = eno_cnt +1;
            hnwExtQuery.AddData(vo.getString("DPT_NM"));

            if ( vo.getString("GUBUN").equals("1") ) {
                hnwExtQuery.AddData(Integer.toString(eno_cnt) + " 명");
                hnwExtQuery.AddData("");
                eno_cnt = -1;
            } else if ( vo.getString("GUBUN").equals("3") ) {
                hnwExtQuery.AddData(Integer.toString(tot_cnt) + " 명");
                hnwExtQuery.AddData("");
            } else {
                hnwExtQuery.AddData(vo.getString("ENO_NM"));
                hnwExtQuery.AddData(vo.getString("ENO_NO"));
                tot_cnt = tot_cnt + 1;
            }

            hnwExtQuery.AddData(vo.getString("HIR_YMD"));
            hnwExtQuery.AddData(vo.getString("GHI_YMD"));
            hnwExtQuery.AddData(vo.getString("FPRO_YMD"));
            hnwExtQuery.AddData(vo.getString("YRP_CNT"));
            hnwExtQuery.AddData(vo.getString("BAS_HOB"));
            hnwExtQuery.AddData(vo.getString("HOB"));
            hnwExtQuery.AddData(vo.getString("SAL_AMT"));
            hnwExtQuery.AddData(vo.getString("CON_HOB"));
            hnwExtQuery.AddData(vo.getString("CON_SAL"));
            hnwExtQuery.AddData(vo.getString("FIN_HOB"));
            hnwExtQuery.AddData(vo.getString("FIN_SAL"));
            hnwExtQuery.AddData(vo.getString("AOW_AMT"));
            hnwExtQuery.AddData(vo.getString("INC_AMT"));
            hnwExtQuery.AddData(vo.getString("INC_PER"));
            hnwExtQuery.AddData(vo.getString("REMARK"));
            if ( GBN.equals("DPT") ) {
                hnwExtQuery.AddData(vo.getString("DPT_NM"));
            } else if ( GBN.equals("JOB") ) {
                hnwExtQuery.AddData(vo.getString("JOB_NM"));
            }
            hnwExtQuery.SendData(response);
        }
    } else {
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");

            hnwExtQuery.SendData(response);
    }

%>