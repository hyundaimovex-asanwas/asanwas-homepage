<!--
***********************************************************************
* @source      : taxa040_ED.jsp 				                                                                                     *
* @description : �ٷμҵ�������Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/30      ���м�        �����ۼ�.
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
    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("tax", "TAXA040_SHR_PRT");

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
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
    hnwExtQuery.AddField("NO �Ҽ�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("����/���");

    hnwExtQuery.AddField("1)�����޿��Ѿ�");
    hnwExtQuery.AddField("2)�������Ѿ�");
    hnwExtQuery.AddField("3)�����޻��Ѿ�");
    hnwExtQuery.AddField("4)�����ؿܱ޿��Ѿ�");
    hnwExtQuery.AddField("5)�����ؿܻ��Ѿ�");
    hnwExtQuery.AddField("6)�����ؿܱ޻��Ѿ�");
    hnwExtQuery.AddField("7)�����޿��Ѿ�");
    hnwExtQuery.AddField("8)�������Ѿ�");
    hnwExtQuery.AddField("9)�����޻��Ѿ�");
    hnwExtQuery.AddField("10)�����ؿܱ޿��Ѿ�");
    hnwExtQuery.AddField("11)�����ؿܻ��Ѿ�");
    hnwExtQuery.AddField("12)�����ؿܱ޻��Ѿ�");
    hnwExtQuery.AddField("13)����������ҵ�");
    hnwExtQuery.AddField("14)����������ҵ�");
    hnwExtQuery.AddField("15)������ҵ��");
    hnwExtQuery.AddField("16)�ѱٷμҵ��");
    hnwExtQuery.AddField("17)�ٷμҵ������");
    hnwExtQuery.AddField("18)�ٷμҵ�ݾ�");
    hnwExtQuery.AddField("19)���ΰ�����");
    hnwExtQuery.AddField("20)����ڰ�����");
    hnwExtQuery.AddField("21)�ξ簡��������");
    hnwExtQuery.AddField("22)�ξ簡��������");
    hnwExtQuery.AddField("23)��ο�������");
    hnwExtQuery.AddField("24)��ο�������");
    hnwExtQuery.AddField("25)����ڰ�����");
    hnwExtQuery.AddField("26)����ڰ�����");
    hnwExtQuery.AddField("27)�γ��ڰ�����");
    hnwExtQuery.AddField("28)�ڳ����������");
    hnwExtQuery.AddField("29)�ڳ����������");
    hnwExtQuery.AddField("30)�Ҽ�����");
    hnwExtQuery.AddField("31)����������");
    hnwExtQuery.AddField("32)���ο��ݷ�");
    hnwExtQuery.AddField("33)���ݺ���������");
    hnwExtQuery.AddField("34)�ǰ������");
    hnwExtQuery.AddField("35)��뺸���");
    hnwExtQuery.AddField("36)���强�����");
    hnwExtQuery.AddField("37)���强����������");
    hnwExtQuery.AddField("38)��������뺸���");
    hnwExtQuery.AddField("39)����κ���������");
    hnwExtQuery.AddField("40)����������");
    hnwExtQuery.AddField("41)�Ϲ��Ƿ��");
    hnwExtQuery.AddField("42)����Ƿ��");
    hnwExtQuery.AddField("43)�Ƿ�������");
    hnwExtQuery.AddField("44)���α�����");
    hnwExtQuery.AddField("45)����������");
    hnwExtQuery.AddField("46)�����������");
    hnwExtQuery.AddField("47)�����ڱ�����");
    hnwExtQuery.AddField("48)���ÿ����ݻ�ȯ��");
    hnwExtQuery.AddField("49)��������������Ա��������޾�");
    hnwExtQuery.AddField("50)�����ڱݰ�����");
    hnwExtQuery.AddField("51)������α�");
    hnwExtQuery.AddField("52)������α�");
    hnwExtQuery.AddField("53)��αݰ�����");
    hnwExtQuery.AddField("54)Ư��������");
    hnwExtQuery.AddField("55)���ο��������");
    hnwExtQuery.AddField("56)���ο������������");
    hnwExtQuery.AddField("57)���������");
    hnwExtQuery.AddField("58)�������������");
    hnwExtQuery.AddField("59)�����������ھ�");
    hnwExtQuery.AddField("60)�����������ڰ�����");
    hnwExtQuery.AddField("61)�ſ�ī�����");
    hnwExtQuery.AddField("62)�ſ�ī�������");
    hnwExtQuery.AddField("63)��ġ�ڱ�");
    hnwExtQuery.AddField("64)��ġ�ڱݰ�����");
    hnwExtQuery.AddField("65)��Ư��������");
    hnwExtQuery.AddField("66)���հ���ǥ��");
    hnwExtQuery.AddField("67)���⼼��");
    hnwExtQuery.AddField("68)�ٷμҵ漼�װ���");
    hnwExtQuery.AddField("69)�������༼�װ���");
    hnwExtQuery.AddField("70)�����ڱ����ڼ��װ���");
    hnwExtQuery.AddField("71)�ܱ����μ��װ���");
    hnwExtQuery.AddField("72)�ٷ����ֽ����༼�װ���");
    hnwExtQuery.AddField("73)����ֽ����༼�װ���");
    hnwExtQuery.AddField("74)���װ�����");
    hnwExtQuery.AddField("75)����1");
    hnwExtQuery.AddField("76)����2");
    hnwExtQuery.AddField("77)����3");
    hnwExtQuery.AddField("78)����4");
    hnwExtQuery.AddField("79)����5");
    hnwExtQuery.AddField("80)���װ�����");
    hnwExtQuery.AddField("81)�����ҵ漼");
    hnwExtQuery.AddField("82)������Ư��");
    hnwExtQuery.AddField("83)�����ֹμ�");
    hnwExtQuery.AddField("84)�������װ�");
    hnwExtQuery.AddField("85)�������ҵ漼");
    hnwExtQuery.AddField("86)��������Ư��");
    hnwExtQuery.AddField("87)�������ֹμ�");
    hnwExtQuery.AddField("88)������");
    hnwExtQuery.AddField("89)�����ҵ漼");
    hnwExtQuery.AddField("90)������Ư��");
    hnwExtQuery.AddField("91)�����ֹμ�");
    hnwExtQuery.AddField("92)������");
    hnwExtQuery.AddField("93)¡���ҵ漼");
    hnwExtQuery.AddField("94)¡����Ư��");
    hnwExtQuery.AddField("95)¡���ֹμ�");
    hnwExtQuery.AddField("96)¡�����װ�");
    hnwExtQuery.AddField("97)ȯ�޼ҵ漼");
    hnwExtQuery.AddField("98)ȯ�޳�Ư��");
    hnwExtQuery.AddField("99)ȯ���ֹμ�");
    hnwExtQuery.AddField("100)ȯ�޼��װ�");

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