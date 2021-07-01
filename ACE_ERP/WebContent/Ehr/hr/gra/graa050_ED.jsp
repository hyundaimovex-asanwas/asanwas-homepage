<!--
***********************************************************************
* @source      : graa050_ED.jsp
* @description : 직급,호봉별 임금조정현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/27      김학수        최초작성.
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
    String sql = XmlSqlUtils.getSQL("gra", "GRAA050_SHR");

    String SND_KIND = request.getParameter("SND_KIND");
    String OCC_CD   = request.getParameter("OCC_CD");
    String RAI_YMD  = request.getParameter("RAI_YMD");
    String HBA_YMD  = request.getParameter("HBA_YMD");
    String PIS_YM   = request.getParameter("PIS_YM");
    String DPT_CD1  = request.getParameter("DPT_CD1");
    String DPT_CD2  = request.getParameter("DPT_CD2");
    String JOB_CD1  = request.getParameter("JOB_CD1");
    String JOB_CD2  = request.getParameter("JOB_CD2");
    String GUBUN    = request.getParameter("GUBUN");
    String SEL      = request.getParameter("SEL");

    	/** 조회 조건(급/상여, 근로구분)에 따른 처리 **/
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT A.PJOB_CD        \n");
		sb.append("     , A.JOB_NM         \n");
		sb.append("     , A.HOB            \n");
        sb.append("     , A.CNT            \n");
        sb.append("     , A.AVR_SAL        \n");
        sb.append("     , A.AVR_AOW        \n");
        sb.append("     , A.ETC_AVR        \n");
        sb.append("     , A.SUM_SAL        \n");

        if(GUBUN.equals("FIN")){
            sb.append("     , B.FIN_HOB AS 	 	 	 HOB2           \n");
		}else{
	        sb.append("     , B.CON_HOB AS 	 	 	 HOB2           \n");
		}
        sb.append("     , B.CNT AS CNT2           	  \n");
        sb.append("     , B.AVR_SAL AS AVR_SAL2       \n");
        sb.append("     , B.AVR_AOW AS AVR_AOW2       \n");
        sb.append("     , B.ETC_AVR AS ETC_AVR2       \n");
        sb.append("     , B.SUM_SAL AS SUM_SAL2       \n");

	    sb.append("     , Round(decode(B.SUM_SAL-A.SUM_SAL,0,0,((B.SUM_SAL-A.SUM_SAL)/A.SUM_SAL*100)),1)       INC_PER           \n");
        sb.append("     , B.SUM_SAL-A.SUM_SAL	                 									  INC_AMT        \n");

        //sb.append("     , DECODE(SUM(B.SUM_SAL)-SUM(A.SUM_SAL),0,0,((SUM(B.SUM_SAL)-SUM(A.SUM_SAL))/SUM(A.SUM_SAL)*100))       INC_PER           \n");
        //sb.append("     , (SUM(B.SUM_SAL)-SUM(A.SUM_SAL))/1000                 INC_AMT        \n");
        //sb.append("     , MAX(INT)											 GUBUN          \n");

		sb.append("  FROM   ( SELECT AA.OCC_CD, AA.PJOB_CD, AA.JOB_NM, AA.HOB, AA.CNT, \n");
		sb.append("                  BB.TOT_AMT AS AVR_SAL, \n");
		sb.append("                  FLOOR(DECODE(NVL(AA.LSEV_SUM,0),0,0,AA.LSEV_SUM/AA.CNT)) AS AVR_AOW, \n");
		sb.append("                  FLOOR(DECODE(NVL(AA.ETC_SUM,0),0,0,AA.ETC_SUM/AA.CNT)) AS ETC_AVR, \n");
		sb.append("                  (BB.TOT_AMT*AA.CNT+NVL(AA.LSEV_SUM,0)+NVL(AA.ETC_SUM,0)) AS SUM_SAL \n");
		sb.append("           FROM   ( SELECT T1.OCC_CD, T1.PJOB_CD, MAX(COD1.COMM_NM) AS JOB_NM, \n");
		sb.append("                           T1.HOB, COUNT(T1.HOB) AS CNT, \n");
		sb.append("                           SUM(LSEV_AMT) AS LSEV_SUM, SUM(TB3_AMT+SGF_AMT) AS ETC_SUM, \n");
		sb.append("                           DECODE(T1.OCC_CD, 'A', \n");
		sb.append("                              CASE WHEN T1.PJOB_CD IN ('2A','2B') THEN '20' \n");
		sb.append("                                   WHEN T1.PJOB_CD IN ('3A','3B') THEN '30' \n");
		sb.append("                                   WHEN T1.PJOB_CD IN ('4A','4B') THEN '40' \n");
		sb.append("                                   WHEN T1.PJOB_CD IN ('5A','5B') THEN '50' \n");
		sb.append("                                   ELSE T1.PJOB_CD END, T1.PJOB_CD ) AS TEMP_JOB \n");
		sb.append("                    FROM   T_PM_GRADE T1, \n");
		sb.append("                           ( SELECT ENO_NO, LSEV_AMT, TB3_AMT, SGF_AMT \n");
		sb.append("                             FROM   T_CP_PAYMASTER  \n");
		sb.append("                             WHERE  OCC_CD LIKE '%'||'"+OCC_CD+"'||'%'  \n");
		sb.append("                             AND    PIS_YY = SUBSTR('"+PIS_YM.replaceAll("-", "")+"',1,4)  \n");
		sb.append("                             AND    PIS_MM = SUBSTR('"+PIS_YM.replaceAll("-", "")+"',5,2)  \n");
		sb.append("                             AND    SAL_GBN = '0' ) VIEW_1, \n");
		sb.append("                           ( SELECT COMM_CD, SORT_NO, COMM_NM \n");
		sb.append("                             FROM   T_CM_COMMON \n");
		sb.append("                             WHERE  CD_GBN='A2' AND (END_YMD IS NULL OR END_YMD >= SYSDATE)) COD1, \n");
		sb.append("                           ( SELECT COMM_CD, SORT_NO \n");
		sb.append("                             FROM   T_CM_COMMON \n");
		sb.append("                             WHERE  CD_GBN='A4' AND (END_YMD IS NULL OR END_YMD >= SYSDATE)) COD2 \n");
		sb.append("                    WHERE  T1.RAI_YMD = '"+RAI_YMD.replaceAll("-", "")+"' \n");
		sb.append("                    AND    T1.OCC_CD LIKE '%'||'"+OCC_CD+"'||'%' \n");
		sb.append("                    AND    T1.ENO_NO = VIEW_1.ENO_NO(+) \n");
		sb.append("                    AND    T1.PJOB_CD = COD1.COMM_CD(+) \n");
		sb.append("                    AND    T1.DPT_CD = COD2.COMM_CD(+) \n");

		if(SEL.equals("DPT")){
			sb.append("                    AND    COD2.SORT_NO BETWEEN '"+DPT_CD1+"' AND '"+DPT_CD2+"' \n");
		} else if(SEL.equals("JOB")){
			sb.append("                    AND    COD1.SORT_NO BETWEEN '"+JOB_CD1+"' AND '"+JOB_CD2+"' \n");
		}

		sb.append("                    GROUP BY T1.OCC_CD, T1.PJOB_CD, T1.HOB ) AA, \n");
		sb.append("                  ( SELECT OCC_CD, JOB_CD, HOB_CD, APY_YMD,  \n");

		if(SND_KIND.equals("BNS")){
			sb.append("                           DECODE(OCC_CD,'A',(BAS_AMT+DUTY_AMT+OT_AMT+WEL_AMT+OSE_AMT+RUN_AMT+MH_AMT),\n");
			sb.append("                           		                   (BAS_AMT+DUTY_AMT+OT_AMT+WEL_AMT+RUN_AMT)) AS TOT_AMT   \n");
		}else{
			sb.append("                           (BAS_AMT+DUTY_AMT+OT_AMT+WEL_AMT+OSE_AMT+RUN_AMT+MH_AMT) AS TOT_AMT   \n");
		}

		sb.append("                    FROM   T_CP_PAYTABLE ) BB \n");
		sb.append("           WHERE  BB.OCC_CD = AA.OCC_CD \n");
		sb.append("           AND    BB.JOB_CD = AA.TEMP_JOB  \n");
		sb.append("           AND    BB.HOB_CD = AA.HOB  \n");
		sb.append("           AND    BB.APY_YMD = ( SELECT MAX(APY_YMD)  \n");
		sb.append("                                 FROM   T_CP_PAYTABLE  \n");
		sb.append("                                 WHERE  OCC_CD = AA.OCC_CD  \n");
		sb.append("                                 AND    JOB_CD = AA.TEMP_JOB  \n");
		sb.append("                                 AND    HOB_CD = AA.HOB  \n");
		sb.append("                                 AND    APY_YMD <= '"+HBA_YMD.replaceAll("-", "")+"' ) ) A, \n");
		sb.append("         ( SELECT AA.OCC_CD, AA.PJOB_CD, AA.JOB_NM, AA.HOB, AA."+GUBUN+"_HOB, AA.CNT, \n");
		sb.append("                  BB.TOT_AMT AS AVR_SAL, \n");
		sb.append("                  FLOOR(DECODE(NVL(AA.LSEV_SUM,0),0,0,AA.LSEV_SUM/AA.CNT)) AS AVR_AOW, \n");
		sb.append("                  FLOOR(DECODE(NVL(AA.ETC_SUM,0),0,0,AA.ETC_SUM/AA.CNT)) AS ETC_AVR, \n");
		sb.append("                  (BB.TOT_AMT*AA.CNT+NVL(AA.LSEV_SUM,0)+NVL(AA.ETC_SUM,0)) AS SUM_SAL \n");
		sb.append("           FROM   ( SELECT T1.OCC_CD, T1.PJOB_CD, MAX(COD1.COMM_NM) AS JOB_NM, \n");
		sb.append("                           T1.HOB, T1."+GUBUN+"_HOB, COUNT(T1."+GUBUN+"_HOB) AS CNT,  \n");
		sb.append("                           SUM(LSEV_AMT) AS LSEV_SUM, SUM(TB3_AMT+SGF_AMT) AS ETC_SUM,  \n");
		sb.append("                           DECODE(T1.OCC_CD, 'A',   \n");
		sb.append("                              CASE WHEN T1.PJOB_CD IN ('2A','2B') THEN '20'   \n");
		sb.append("                                   WHEN T1.PJOB_CD IN ('3A','3B') THEN '30'   \n");
		sb.append("                                   WHEN T1.PJOB_CD IN ('4A','4B') THEN '40'   \n");
		sb.append("                                   WHEN T1.PJOB_CD IN ('5A','5B') THEN '50'   \n");
		sb.append("                                   ELSE T1.PJOB_CD END, T1.PJOB_CD ) AS TEMP_JOB  \n");
		sb.append("                    FROM   T_PM_GRADE T1,  \n");
		sb.append("                           ( SELECT ENO_NO, LSEV_AMT, TB3_AMT, SGF_AMT   \n");
		sb.append("                             FROM   T_CP_PAYMASTER   \n");
		sb.append("                             WHERE  OCC_CD LIKE '%'||'"+OCC_CD+"'||'%'   \n");
		sb.append("                             AND    PIS_YY = SUBSTR('"+PIS_YM.replaceAll("-", "")+"',1,4)   \n");
		sb.append("                             AND    PIS_MM = SUBSTR('"+PIS_YM.replaceAll("-", "")+"',5,2)   \n");
		sb.append("                             AND    SAL_GBN = '0' ) VIEW_1,  \n");
		sb.append("                           ( SELECT COMM_CD, SORT_NO, COMM_NM  \n");
		sb.append("                             FROM   T_CM_COMMON  \n");
		sb.append("                             WHERE  CD_GBN='A2' AND (END_YMD IS NULL OR END_YMD >= SYSDATE)) COD1,  \n");
		sb.append("                           ( SELECT COMM_CD, SORT_NO  \n");
		sb.append("                             FROM   T_CM_COMMON  \n");
		sb.append("                             WHERE  CD_GBN='A4' AND (END_YMD IS NULL OR END_YMD >= SYSDATE)) COD2  \n");
		sb.append("                    WHERE  T1.RAI_YMD = '"+RAI_YMD.replaceAll("-", "")+"'   \n");
		sb.append("                    AND    T1.OCC_CD LIKE '%'||'"+OCC_CD+"'||'%'  \n");
		sb.append("                    AND    T1.ENO_NO = VIEW_1.ENO_NO(+)  \n");
		sb.append("                    AND    T1.PJOB_CD = COD1.COMM_CD(+)  \n");
		sb.append("                    AND    T1.DPT_CD = COD2.COMM_CD(+)  \n");

		if(SEL.equals("DPT")){
			sb.append("                    AND    COD2.SORT_NO BETWEEN '"+DPT_CD1+"' AND '"+DPT_CD2+"' \n");
		} else if(SEL.equals("JOB")){
			sb.append("                    AND    COD1.SORT_NO BETWEEN '"+JOB_CD1 +"' AND '"+JOB_CD2+"' \n");
		}

		sb.append("                    GROUP BY T1.OCC_CD, T1.PJOB_CD, T1.HOB, T1."+GUBUN+"_HOB ) AA, \n");
		sb.append("                  ( SELECT OCC_CD, JOB_CD, HOB_CD, APY_YMD,   \n");

		if(SND_KIND.equals("BNS")){
			sb.append("                           DECODE(OCC_CD,'A',(BAS_AMT+DUTY_AMT+OT_AMT+WEL_AMT+OSE_AMT+RUN_AMT+MH_AMT),\n");
			sb.append("                           		                   (BAS_AMT+DUTY_AMT+OT_AMT+WEL_AMT+RUN_AMT)) AS TOT_AMT   \n");
		}else{
			sb.append("                           (BAS_AMT+DUTY_AMT+OT_AMT+WEL_AMT+OSE_AMT+RUN_AMT+MH_AMT) AS TOT_AMT   \n");
		}

		sb.append("                    FROM   T_CP_PAYTABLE ) BB \n");
		sb.append("           WHERE  BB.OCC_CD = AA.OCC_CD \n");
		sb.append("           AND    BB.JOB_CD = AA.TEMP_JOB   \n");
		sb.append("           AND    BB.HOB_CD = AA."+GUBUN+"_HOB   \n");
		sb.append("           AND    BB.APY_YMD = ( SELECT MAX(APY_YMD)   \n");
		sb.append("                                 FROM   T_CP_PAYTABLE   \n");
		sb.append("                                 WHERE  OCC_CD = AA.OCC_CD   \n");
		sb.append("                                 AND    JOB_CD = AA.TEMP_JOB   \n");
		sb.append("                                 AND    HOB_CD = AA."+GUBUN+"_HOB   \n");
		sb.append("                                 AND    APY_YMD <= '"+RAI_YMD.replaceAll("-", "")+"' ) ) B \n");

		//sb.append("     	( SELECT ROWNUM INT                                     \n");
        //sb.append("             FROM DICT                                           \n");
        //sb.append("            WHERE ROWNUM <=3                                     \n");
        //sb.append("     	) COPTY                                                 \n");

		sb.append("  WHERE A.PJOB_CD(+) = B.PJOB_CD \n");
		sb.append("  AND   A.JOB_NM(+)  = B.JOB_NM \n");
		sb.append("  AND   A.HOB(+)     = B.HOB \n");
        //sb.append(" GROUP BY DECODE(INT,1,'합계',A.PJOB_CD)                         \n");
        //sb.append("        , DECODE(INT,1,'합계',2,A.JOB_NM||'계',A.JOB_NM)         \n");
        //sb.append("        , DECODE(INT,1,'',2,'계',3,A.HOB)                        \n");
        //sb.append(" ORDER BY DECODE(INT,1,'합계',A.PJOB_CD)                         \n");
        //sb.append("        , DECODE(INT,1,'',2,'계',3,A.HOB)                        \n");

        sb.append("  ORDER BY A.PJOB_CD, A.HOB \n");

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

    hnwExtQuery.AddField("직위코드");
    hnwExtQuery.AddField("직위");
    hnwExtQuery.AddField("인상전호봉");
    hnwExtQuery.AddField("인상전인원");
    hnwExtQuery.AddField("인상전임금");
    hnwExtQuery.AddField("인상전근속");
    hnwExtQuery.AddField("인상전기타");
    hnwExtQuery.AddField("인상전계");
    hnwExtQuery.AddField("인상후호봉");
    hnwExtQuery.AddField("인상후인원");
    hnwExtQuery.AddField("인상후임금");
    hnwExtQuery.AddField("인상후근속");
    hnwExtQuery.AddField("인상후기타");
    hnwExtQuery.AddField("인상후계");
    hnwExtQuery.AddField("인상율");
    hnwExtQuery.AddField("소요재원");
//    hnwExtQuery.AddField("비고");
//    hnwExtQuery.AddField("구분");


    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    String pre_job = "";

    if (voList.size() > 0)
    {
        for ( int i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            
            hnwExtQuery.AddData(vo.getString("PJOB_CD"));
            //if ( pre_job.equals(vo.getString("JOB_NM")) || vo.getString("GUBUN").equals("2") ) {
            //    hnwExtQuery.AddData("");
            //} else {
                hnwExtQuery.AddData(vo.getString("JOB_NM"));
            //}

            hnwExtQuery.AddData(vo.getString("HOB"));
            hnwExtQuery.AddData(vo.getString("CNT"));
            hnwExtQuery.AddData(vo.getString("AVR_SAL"));
            hnwExtQuery.AddData(vo.getString("AVR_AOW"));
            hnwExtQuery.AddData(vo.getString("ETC_AVR"));
            hnwExtQuery.AddData(vo.getString("SUM_SAL"));
            hnwExtQuery.AddData(vo.getString("HOB2"));
            hnwExtQuery.AddData(vo.getString("CNT2"));
            hnwExtQuery.AddData(vo.getString("AVR_SAL2"));
            hnwExtQuery.AddData(vo.getString("AVR_AOW2"));
            hnwExtQuery.AddData(vo.getString("ETC_AVR2"));
            hnwExtQuery.AddData(vo.getString("SUM_SAL2"));


//            if ( vo.getString("GUBUN").equals("3") ) {
  //              hnwExtQuery.AddData("");
    //            hnwExtQuery.AddData("");
      //      } else {
                hnwExtQuery.AddData(vo.getString("INC_PER"));
                hnwExtQuery.AddData(vo.getString("INC_AMT"));
        //    }
        //    hnwExtQuery.AddData("");
       //     hnwExtQuery.AddData(vo.getString("GUBUN"));

			hnwExtQuery.SendData(response);

            pre_job = vo.getString("JOB_NM");
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
         //   hnwExtQuery.AddData("");
            //hnwExtQuery.AddData("");

            hnwExtQuery.SendData(response);
    }

%>