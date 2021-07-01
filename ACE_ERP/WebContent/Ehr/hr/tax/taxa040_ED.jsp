<!--
***********************************************************************
* @source      : taxa040_ED.jsp 				                                                                                     *
* @description : 근로소득정산현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/30      김학수        최초작성.
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
    String PIS_YM  = request.getParameter("PIS_YM");
    String PIS_YY  = request.getParameter("PIS_YY");
    String PIS_MM  = request.getParameter("PIS_MM");
    String OCC_CD  = request.getParameter("OCC_CD");
    String SAL_GBN = request.getParameter("SAL_GBN");
    String ENO_NO  = request.getParameter("ENO_NO");
    String DTP_CD  = request.getParameter("DTP_CD");
    String MID_HIR = request.getParameter("MID_HIR");

    System.out.println("PIS_YM ="+PIS_YM );
    System.out.println("PIS_YY ="+PIS_YY );
    System.out.println("PIS_MM ="+PIS_MM );
    System.out.println("OCC_CD ="+OCC_CD );
    System.out.println("SAL_GBN="+SAL_GBN);
    System.out.println("ENO_NO ="+ENO_NO );
    System.out.println("DTP_CD ="+DTP_CD );
    System.out.println("MID_HIR="+MID_HIR);
    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("tax", "TAXA040_SHR_PRT");

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
             PIS_YY
            ,PIS_YY
            ,PIS_MM
            ,SAL_GBN
            ,OCC_CD
            ,DTP_CD
            ,ENO_NO
            ,MID_HIR
            ,PIS_YY
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("NO");
    hnwExtQuery.AddField("NO 소속");
    hnwExtQuery.AddField("직위");
    hnwExtQuery.AddField("성명/사번");

    hnwExtQuery.AddField("1)주현급여총액");
    hnwExtQuery.AddField("2)주현상여총액");
    hnwExtQuery.AddField("3)주현급상여총액");
    hnwExtQuery.AddField("4)주현해외급여총액");
    hnwExtQuery.AddField("5)주현해외상여총액");
    hnwExtQuery.AddField("6)주현해외급상여총액");
    hnwExtQuery.AddField("7)종전급여총액");
    hnwExtQuery.AddField("8)종전상여총액");
    hnwExtQuery.AddField("9)종전급상여총액");
    hnwExtQuery.AddField("10)종전해외급여총액");
    hnwExtQuery.AddField("11)종전해외상여총액");
    hnwExtQuery.AddField("12)종전해외급상여총액");
    hnwExtQuery.AddField("13)주현비과세소득");
    hnwExtQuery.AddField("14)종전비과세소득");
    hnwExtQuery.AddField("15)비과세소득계");
    hnwExtQuery.AddField("16)총근로소득계");
    hnwExtQuery.AddField("17)근로소득공제액");
    hnwExtQuery.AddField("18)근로소득금액");
    hnwExtQuery.AddField("19)본인공제액");
    hnwExtQuery.AddField("20)배우자공제액");
    hnwExtQuery.AddField("21)부양가족공제수");
    hnwExtQuery.AddField("22)부양가족공제액");
    hnwExtQuery.AddField("23)경로우대공제수");
    hnwExtQuery.AddField("24)경로우대공제액");
    hnwExtQuery.AddField("25)장애자공제수");
    hnwExtQuery.AddField("26)장애자공제액");
    hnwExtQuery.AddField("27)부녀자공제액");
    hnwExtQuery.AddField("28)자녀양육공제수");
    hnwExtQuery.AddField("29)자녀양육공제액");
    hnwExtQuery.AddField("30)소수공제");
    hnwExtQuery.AddField("31)인적공제계");
    hnwExtQuery.AddField("32)국민연금료");
    hnwExtQuery.AddField("33)연금보험료공제계");
    hnwExtQuery.AddField("34)건강보험료");
    hnwExtQuery.AddField("35)고용보험료");
    hnwExtQuery.AddField("36)보장성보험료");
    hnwExtQuery.AddField("37)보장성보험료공제액");
    hnwExtQuery.AddField("38)장애인전용보험료");
    hnwExtQuery.AddField("39)장애인보험료공제액");
    hnwExtQuery.AddField("40)보험료공제액");
    hnwExtQuery.AddField("41)일반의료비");
    hnwExtQuery.AddField("42)장경의료비");
    hnwExtQuery.AddField("43)의료비공제액");
    hnwExtQuery.AddField("44)본인교육비");
    hnwExtQuery.AddField("45)가족교육비");
    hnwExtQuery.AddField("46)교육비공제액");
    hnwExtQuery.AddField("47)주택자금저축");
    hnwExtQuery.AddField("48)주택원리금상환액");
    hnwExtQuery.AddField("49)장기주택저당차입금이자지급액");
    hnwExtQuery.AddField("50)주택자금공제액");
    hnwExtQuery.AddField("51)법정기부금");
    hnwExtQuery.AddField("52)지정기부금");
    hnwExtQuery.AddField("53)기부금공제액");
    hnwExtQuery.AddField("54)특별공제계");
    hnwExtQuery.AddField("55)개인연금저축액");
    hnwExtQuery.AddField("56)개인연금저축공제액");
    hnwExtQuery.AddField("57)연금저축액");
    hnwExtQuery.AddField("58)연금저축공제액");
    hnwExtQuery.AddField("59)투자조합출자액");
    hnwExtQuery.AddField("60)투자조합출자공제액");
    hnwExtQuery.AddField("61)신용카드사용액");
    hnwExtQuery.AddField("62)신용카드공제액");
    hnwExtQuery.AddField("63)정치자금");
    hnwExtQuery.AddField("64)정치자금공제액");
    hnwExtQuery.AddField("65)조특법공제합");
    hnwExtQuery.AddField("66)종합과세표준");
    hnwExtQuery.AddField("67)산출세액");
    hnwExtQuery.AddField("68)근로소득세액공제");
    hnwExtQuery.AddField("69)재형저축세액공제");
    hnwExtQuery.AddField("70)주택자금이자세액공제");
    hnwExtQuery.AddField("71)외국납부세액공제");
    hnwExtQuery.AddField("72)근로자주식저축세액공제");
    hnwExtQuery.AddField("73)장기주식저축세액공제");
    hnwExtQuery.AddField("74)세액공제합");
    hnwExtQuery.AddField("75)공란1");
    hnwExtQuery.AddField("76)공란2");
    hnwExtQuery.AddField("77)공란3");
    hnwExtQuery.AddField("78)공란4");
    hnwExtQuery.AddField("79)공란5");
    hnwExtQuery.AddField("80)세액감면합");
    hnwExtQuery.AddField("81)결정소득세");
    hnwExtQuery.AddField("82)결정농특세");
    hnwExtQuery.AddField("83)결정주민세");
    hnwExtQuery.AddField("84)결정세액계");
    hnwExtQuery.AddField("85)종전납소득세");
    hnwExtQuery.AddField("86)종전납농특세");
    hnwExtQuery.AddField("87)종전납주민세");
    hnwExtQuery.AddField("88)종전계");
    hnwExtQuery.AddField("89)주현소득세");
    hnwExtQuery.AddField("90)주현농특세");
    hnwExtQuery.AddField("91)주현주민세");
    hnwExtQuery.AddField("92)주현계");
    hnwExtQuery.AddField("93)징수소득세");
    hnwExtQuery.AddField("94)징수농특세");
    hnwExtQuery.AddField("95)징수주민세");
    hnwExtQuery.AddField("96)징수세액계");
    hnwExtQuery.AddField("97)환급소득세");
    hnwExtQuery.AddField("98)환급농특세");
    hnwExtQuery.AddField("99)환급주민세");
    hnwExtQuery.AddField("100)환급세액계");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());

    if (voList.size() > 0)
    {
        for ( int i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(Integer.toString(i+1));
            hnwExtQuery.AddData(Integer.toString(i+1) + "  " +vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NO") + "/" + vo.getString("ENO_NM"));

            hnwExtQuery.AddData(vo.getString("PAYD_AMTS"));
            hnwExtQuery.AddData(vo.getString("PAYD_AMTB"));
            hnwExtQuery.AddData(vo.getString("PAYD_TOT"));
            hnwExtQuery.AddData(vo.getString("OUTT_AMTS"));
            hnwExtQuery.AddData(vo.getString("OUTT_AMTB"));
            hnwExtQuery.AddData(vo.getString("OUTT_TOT"));
            hnwExtQuery.AddData(vo.getString("JAA_AMT"));
            hnwExtQuery.AddData(vo.getString("JAC_AMT"));
            hnwExtQuery.AddData(vo.getString("JA1_AMT"));
            hnwExtQuery.AddData(vo.getString("JAB_AMT"));
            hnwExtQuery.AddData(vo.getString("JAD_AMT"));
            hnwExtQuery.AddData(vo.getString("JA2_AMT"));
            hnwExtQuery.AddData(vo.getString("FREE_INCOME"));
            hnwExtQuery.AddData(vo.getString("JAG_AMT"));
            hnwExtQuery.AddData(vo.getString("FREE_IN1"));
            hnwExtQuery.AddData(vo.getString("TAX_INCOME"));
            hnwExtQuery.AddData(vo.getString("MGR_AMT"));
            hnwExtQuery.AddData(vo.getString("MNI_AMT"));
            hnwExtQuery.AddData(vo.getString("BADD_AMT"));
            hnwExtQuery.AddData(vo.getString("SPSB_AMT"));
            hnwExtQuery.AddData(vo.getString("DFM_CNT"));
            hnwExtQuery.AddData(vo.getString("GDED_AMT"));
            hnwExtQuery.AddData(vo.getString("GOL_CNT"));
            hnwExtQuery.AddData(vo.getString("GOL_AMT"));
            hnwExtQuery.AddData(vo.getString("TRB_CNT"));
            hnwExtQuery.AddData(vo.getString("TBL_DED"));
            hnwExtQuery.AddData(vo.getString("WDD_AMT"));
            hnwExtQuery.AddData(vo.getString("RCH_CNT"));
            hnwExtQuery.AddData(vo.getString("RCH_AMT"));
            hnwExtQuery.AddData(vo.getString("SMD_AMT"));
            hnwExtQuery.AddData(vo.getString("PER_TOT"));
            hnwExtQuery.AddData(vo.getString("NPEN_AMT"));
            hnwExtQuery.AddData(vo.getString("NPEN_DED"));
            hnwExtQuery.AddData(vo.getString("HINU_AMT"));
            hnwExtQuery.AddData(vo.getString("HINS_AMT"));
            hnwExtQuery.AddData(vo.getString("LIN_AMT"));
            hnwExtQuery.AddData(vo.getString("LIN_DED"));
            hnwExtQuery.AddData(vo.getString("LIH_AMT"));
            hnwExtQuery.AddData(vo.getString("LIH_DED"));
            hnwExtQuery.AddData(vo.getString("MIN_DED"));
            hnwExtQuery.AddData(vo.getString("LMA_AMT"));
            hnwExtQuery.AddData(vo.getString("LF2_AMT"));
            hnwExtQuery.AddData(vo.getString("MMA_DED"));
            hnwExtQuery.AddData(vo.getString("LED_AMT"));
            hnwExtQuery.AddData(vo.getString("LEF_AMT"));
            hnwExtQuery.AddData(vo.getString("EDU_DED"));
            hnwExtQuery.AddData(vo.getString("LHO_AMT"));
            hnwExtQuery.AddData(vo.getString("LH1_AMT"));
            hnwExtQuery.AddData(vo.getString("LH2_AMT"));
            hnwExtQuery.AddData(vo.getString("HOS_DED"));
            hnwExtQuery.AddData(vo.getString("LC3_AMT"));
            hnwExtQuery.AddData(vo.getString("LC2_AMT"));
            hnwExtQuery.AddData(vo.getString("CPC_DED"));
            hnwExtQuery.AddData(vo.getString("NSE_TOT"));
            hnwExtQuery.AddData(vo.getString("LF1_AMT"));
            hnwExtQuery.AddData(vo.getString("PER_SAV"));
            hnwExtQuery.AddData(vo.getString("ANN_AMT"));
            hnwExtQuery.AddData(vo.getString("ANN_DED"));
            hnwExtQuery.AddData(vo.getString("VEN_AMT"));
            hnwExtQuery.AddData(vo.getString("VEN_DED"));
            hnwExtQuery.AddData(vo.getString("CARD_AMT"));
            hnwExtQuery.AddData(vo.getString("CARD_DED"));
            hnwExtQuery.AddData(vo.getString("GOV_AMT"));
            hnwExtQuery.AddData(vo.getString("GOV_DED"));
            hnwExtQuery.AddData(vo.getString("SPC_TOT"));
            hnwExtQuery.AddData(vo.getString("TTAX_STD"));
            hnwExtQuery.AddData(vo.getString("TAX_AMT"));
            hnwExtQuery.AddData(vo.getString("HGR_DED"));
            hnwExtQuery.AddData(vo.getString("STX_DED"));
            hnwExtQuery.AddData(vo.getString("HTX_DED"));
            hnwExtQuery.AddData(vo.getString("OTX_DED"));
            hnwExtQuery.AddData(vo.getString("HSX_DED"));
            hnwExtQuery.AddData(vo.getString("LSX_DED"));
            hnwExtQuery.AddData(vo.getString("TDED_TOT"));
            hnwExtQuery.AddData(vo.getString("EMPTY1"));
            hnwExtQuery.AddData(vo.getString("EMPTY2"));
            hnwExtQuery.AddData(vo.getString("EMPTY3"));
            hnwExtQuery.AddData(vo.getString("EMPTY4"));
            hnwExtQuery.AddData(vo.getString("EMPTY5"));
            hnwExtQuery.AddData(vo.getString("TAX_DED"));
            hnwExtQuery.AddData(vo.getString("DGG_TAX"));
            hnwExtQuery.AddData(vo.getString("DBW_TAX"));
            hnwExtQuery.AddData(vo.getString("DJM_TAX"));
            hnwExtQuery.AddData(vo.getString("AAA_TOT"));
            hnwExtQuery.AddData(vo.getString("JAL_AMT"));
            hnwExtQuery.AddData(vo.getString("JAM_AMT"));
            hnwExtQuery.AddData(vo.getString("JAN_AMT"));
            hnwExtQuery.AddData(vo.getString("BBB_TOT"));
            hnwExtQuery.AddData(vo.getString("INCM_TAX"));
            hnwExtQuery.AddData(vo.getString("CONT_TAX"));
            hnwExtQuery.AddData(vo.getString("CITI_TAX"));
            hnwExtQuery.AddData(vo.getString("CCC_TOT"));
            hnwExtQuery.AddData(vo.getString("DRE_INTX1"));
            hnwExtQuery.AddData(vo.getString("DRE_DFTX1"));
            hnwExtQuery.AddData(vo.getString("DRE_CTTX1"));
            hnwExtQuery.AddData(vo.getString("DDD_TOT"));
            hnwExtQuery.AddData(vo.getString("DRE_INTX2"));
            hnwExtQuery.AddData(vo.getString("DRE_DFTX2"));
            hnwExtQuery.AddData(vo.getString("DRE_CTTX2"));
            hnwExtQuery.AddData(vo.getString("EEE_TOT"));

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