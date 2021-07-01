<!--
***********************************************************************
* @source      : proa090_ED.jsp
* @description : 특별승진 현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/31      김학수        최초작성.        
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
    int REC_YMD_SHR =  Integer.parseInt(request.getParameter("REC_YMD_SHR"));

    String title_occ = "";
    StringBuffer sb = new StringBuffer();
    String sql = "";
    String title_val = "특별승진 현황(" + Integer.toString(REC_YMD_SHR - 5) + " ~ " + Integer.toString(REC_YMD_SHR - 1) + ")";
/*
    if( OCC_CD_SHR.equals("A") ){ 
        title_occ = "◈ 2006년 승진대상자 명단(사무직/직급별)";
    } else if ( OCC_CD_SHR.equals("M") ){ 
        title_occ = "◈ 2006년 승진대상자 명단(택배직/직급별)";
    } else if ( OCC_CD_SHR.equals("0") ){ 
        title_occ = "◈ 2006년 승진대상자 명단(전체/직급별)";
    }
*/		
		    sql = "    SELECT GBN_NM                                                                           \n";
		   sql += "          ,DECODE(NO, 1, MAX(REC_01), DECODE(SUM(CNT_01),0,'', SUM(CNT_01))) AS REC_01  \n";
		   sql += "          ,DECODE(NO, 1, MAX(REC_02), DECODE(SUM(CNT_02),0,'', SUM(CNT_02))) AS REC_02  \n";
		   sql += "          ,DECODE(NO, 1, MAX(REC_03), DECODE(SUM(CNT_03),0,'', SUM(CNT_03))) AS REC_03  \n";
		   sql += "          ,DECODE(NO, 1, MAX(REC_04), DECODE(SUM(CNT_04),0,'', SUM(CNT_04))) AS REC_04  \n";
		   sql += "          ,DECODE(NO, 1, MAX(REC_05), DECODE(SUM(CNT_05),0,'', SUM(CNT_05))) AS REC_05  \n";
		   sql += "          ,DECODE(SUM(REC_TOT),0,'', SUM(REC_TOT)) AS REC_TOT  \n";
		   sql += "    FROM (   \n";
		   sql += "           SELECT  NO   \n";
		   sql += "                  ,DECODE(NO, 1, GBN_NM , '계' ) AS GBN_NM   \n";
		   sql += "                  ,DECODE(NO, 1, SORT_NO, '999') AS SORT_NO   \n";
		   sql += "                  ,DECODE(NO, 1, DECODE(TO_CHAR(REC_01),NULL,'',REC_01), '') AS REC_01   \n";
		   sql += "                  ,DECODE(NO, 1, DECODE(TO_CHAR(REC_02),NULL,'',REC_02), '') AS REC_02   \n";
		   sql += "                  ,DECODE(NO, 1, DECODE(TO_CHAR(REC_03),NULL,'',REC_03), '') AS REC_03   \n";
		   sql += "                  ,DECODE(NO, 1, DECODE(TO_CHAR(REC_04),NULL,'',REC_04), '') AS REC_04   \n";
		   sql += "                  ,DECODE(NO, 1, DECODE(TO_CHAR(REC_05),NULL,'',REC_05), '') AS REC_05   \n";
		   sql += "                  ,NVL(CNT_01, 0) CNT_01   \n";
		   sql += "                  ,NVL(CNT_02, 0) CNT_02   \n";
		   sql += "                  ,NVL(CNT_03, 0) CNT_03   \n";
		   sql += "                  ,NVL(CNT_04, 0) CNT_04   \n";
		   sql += "                  ,NVL(CNT_05, 0) CNT_05   \n";
		   sql += "                  ,NVL(CNT_01, 0) + NVL(CNT_02, 0) + NVL(CNT_03, 0) + NVL(CNT_04, 0) + NVL(CNT_05, 0) AS REC_TOT   \n";
		   sql += "            FROM (   \n";
		   sql += "                  SELECT  AA.SORT_NO, AA.GBN_NM, T01.REC_01, T02.REC_02, T03.REC_03, T04.REC_04, T05.REC_05   \n";
		   sql += "                         ,T01.CNT_01, T02.CNT_02, T03.CNT_03, T04.CNT_04, T05.CNT_05   \n";
		   sql += "                  FROM (  SELECT  PJOB_CD  \n";
		   sql += "                                ,(SF_GET_COMMNAME('01','A2',PJOB_CD)||' → '||SF_GET_COMMNAME('01','A2',FJOB_CD)) AS GBN_NM   \n";
		   sql += "                                ,(SELECT SORT_NO FROM T_CM_COMMON WHERE COMM_CD = K.PJOB_CD AND CD_GBN = 'A2') AS SORT_NO   \n";
		   sql += "                          FROM    T_PM_PMTALLOT K   \n";
		   sql += "                          WHERE   OCC_CD  = 'A'   \n";
		   sql += "                        ) AA,   \n";

		for(int i=5; i>0; i--){
		   sql += "                       (  SELECT  PMT_YY, PJOB_CD, LTRIM(MAX(SYS_CONNECT_BY_PATH(ENO_NM,',')), ',') AS REC_0"+(6-i)+", COUNT(ENO_NM) AS CNT_0"+(6-i)+"  \n";
		   sql += "                          FROM (  SELECT  PMT_YY, PJOB_CD, ENO_NM   \n";
		   sql += "                                         ,ROW_NUMBER() OVER(PARTITION BY PMT_YY,PJOB_CD ORDER BY ENO_NM) PART_RANK  \n";
		   sql += "                                  FROM (  SELECT PMT_YY, PJOB_CD, (SELECT ENO_NM FROM T_CM_PERSON WHERE ENO_NO = X.ENO_NO) AS ENO_NM  \n";
		   sql += "                                          FROM   T_PM_PROMOTION X  \n";
		   sql += "                                          WHERE  PMT_YY  = '"+(REC_YMD_SHR-i+"")+"'  \n";
		   sql += "                                          AND    PMT_GBN = '2'  -- 특별승진    \n";
		   sql += "                                          AND    EST_CD  = 'Y'  -- 승진된 자   \n";
		   sql += "                                          AND    OCC_CD  = 'A'  -- 사무직       \n";
		   sql += "                                          GROUP  BY PMT_YY, ENO_NO, PJOB_CD)  \n";
		   sql += "                                        )   \n";
		   sql += "                          START   WITH PART_RANK = 1   \n";
		   sql += "                          CONNECT BY  PRIOR PMT_YY = PMT_YY   \n";
		   sql += "                                  AND PRIOR PJOB_CD = PJOB_CD   \n";
		   sql += "                                  AND PRIOR PART_RANK = PART_RANK - 1   \n";
		   sql += "                          GROUP   BY PMT_YY, PJOB_CD   \n";
		   sql += "                       ) T0"+(6-i)+"  \n";
			   
		   if( i!=1 ){
			   sql += "                  ,  \n";
		   }
		}
		
		   sql += "            WHERE  AA.PJOB_CD = T01.PJOB_CD(+)  \n";
		   sql += "            AND    AA.PJOB_CD = T02.PJOB_CD(+)  \n";
		   sql += "            AND    AA.PJOB_CD = T03.PJOB_CD(+)  \n";
		   sql += "            AND    AA.PJOB_CD = T04.PJOB_CD(+)  \n";
		   sql += "            AND    AA.PJOB_CD = T05.PJOB_CD(+)  \n";
		   sql += "            ) XA,  \n";
		   sql += "          ( SELECT '1' AS NO FROM DUAL UNION ALL \n";
		   sql += "            SELECT '2' AS NO FROM DUAL  \n";
		   sql += "            ) XB  \n";
		   sql += "       )  \n";
		   sql += "    GROUP BY  SORT_NO, GBN_NM, NO  \n";
		   
		   
    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {};

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("구분");  
    hnwExtQuery.AddField("2001년");
    hnwExtQuery.AddField("2002년");
    hnwExtQuery.AddField("2003년");
    hnwExtQuery.AddField("2004년");
    hnwExtQuery.AddField("2005년");
    hnwExtQuery.AddField("계");  
    
    hnwExtQuery.AddField("년도1");
    hnwExtQuery.AddField("년도2");
    hnwExtQuery.AddField("년도3");
    hnwExtQuery.AddField("년도4");
    hnwExtQuery.AddField("년도5"); 

    hnwExtQuery.AddField("title"); 

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    String pre_JOBNM = "";
    String r_val     = "";
    String gubun_val = "";

    if (voList.size() > 0) 
    {
        for ( int i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            
            hnwExtQuery.AddData(vo.getString("GBN_NM"));
            hnwExtQuery.AddData(vo.getString("REC_01"));
            hnwExtQuery.AddData(vo.getString("REC_02"));
            hnwExtQuery.AddData(vo.getString("REC_03"));
            hnwExtQuery.AddData(vo.getString("REC_04"));
            hnwExtQuery.AddData(vo.getString("REC_05"));
            hnwExtQuery.AddData(vo.getString("REC_TOT"));

            hnwExtQuery.AddData(Integer.toString(REC_YMD_SHR-5));
            hnwExtQuery.AddData(Integer.toString(REC_YMD_SHR-4));
            hnwExtQuery.AddData(Integer.toString(REC_YMD_SHR-3));
            hnwExtQuery.AddData(Integer.toString(REC_YMD_SHR-2));
            hnwExtQuery.AddData(Integer.toString(REC_YMD_SHR-1));

            hnwExtQuery.AddData(title_val);

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
            
            hnwExtQuery.SendData(response);
    }

%>