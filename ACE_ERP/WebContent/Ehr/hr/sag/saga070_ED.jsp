<!--
***********************************************************************
* @source        : saga070_ED.jsp
* @description   : ���κ��޿�������Ȳ PAGE.
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
    String PIS_YY = request.getParameter("PIS_YY");
    String ENO_NO = request.getParameter("ENO_NO");
//--------------------------------------------------------------- ���������ȸ
    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("sag", "SAGA070_SHR");

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
        ENO_NO
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

//    System.out.println("voList.size()="+voList.size());

    String OCC_VAL  = "";
    String OCC_CD   = "";
    String ENO_NM   = "";
    String JOB_NM   = "";
    String DPT_NM   = "";
    String HIRG_YMD = "";
    String CET_NO   = "";


    String SAL_GBN_VAL = "";

    if (voList.size() > 0)
    {
        DynamicValueObject vo = (DynamicValueObject)voList.get(0);

        OCC_CD   = vo.getString("OCC_CD");
        OCC_VAL  = vo.getString("OCC_CD") + "  " + vo.getString("OCC_NM");
        ENO_NM   = vo.getString("ENO_NM");
        JOB_NM   = vo.getString("JOB_NM");
        DPT_NM   = vo.getString("DPT_NM");
        HIRG_YMD = vo.getString("HIRG_YMD");
        CET_NO   = vo.getString("CET_NO");
    }
//-----------------------------------------------------------------------------

    String sql2 = XmlSqlUtils.getSQL("sag", "SAGA070_SHR_01");

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind2 = new Object[] {
        PIS_YY,
	    ENO_NO
    };

    AbstractDAO aaa2 = new AbstractDAO("default");
    DynamicValueObject voList2 = aaa2.selectProcessDvo(sql2, bind2);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("���޳⵵");
    hnwExtQuery.AddField("�����ȣ");
    hnwExtQuery.AddField("�ٷα���");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�Ҽ�");
    hnwExtQuery.AddField("�Ի���");
    hnwExtQuery.AddField("�ֹι�ȣ");

    hnwExtQuery.AddField("��");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�հ�");
    hnwExtQuery.AddField("�⺻��");
    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("�������");
    hnwExtQuery.AddField("�ð��ܼ���");
    hnwExtQuery.AddField("�ù����");

    hnwExtQuery.AddField("�ټӼ���");
    hnwExtQuery.AddField("�������");
    hnwExtQuery.AddField("�ڱⰳ�ߺ�");
    hnwExtQuery.AddField("��Ÿ����");
    hnwExtQuery.AddField("���ο���");
    hnwExtQuery.AddField("�ڵ����޼���");
    hnwExtQuery.AddField("�������޼���");

    hnwExtQuery.AddField("��Ÿ���Ҿ�");
    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());

    if (voList2.size() > 0)
    {
        for ( int i=0; i<voList2.size(); i++ )
        {
            DynamicValueObject vo2 = (DynamicValueObject)voList2.get(i);

            if ( vo2.getString("SAL_GBN").equals("0") ) {
                SAL_GBN_VAL = "�޿�";
            } else if ( vo2.getString("SAL_GBN").equals("1") ) {
                SAL_GBN_VAL = "��";
            } else if ( vo2.getString("SAL_GBN").equals("4") ) {
                SAL_GBN_VAL = "����";
            }
            hnwExtQuery.AddData("���޳⵵ : " +PIS_YY);
            hnwExtQuery.AddData("��� : " +ENO_NO);
            hnwExtQuery.AddData("�ٷα��� : " +OCC_VAL);
            hnwExtQuery.AddData("�� �� : " +ENO_NM);
            hnwExtQuery.AddData("���� : " +JOB_NM);
            hnwExtQuery.AddData("�Ҽ� : " +DPT_NM);
            hnwExtQuery.AddData("�Ի��� : " +HIRG_YMD);
            hnwExtQuery.AddData("�ֹι�ȣ : " +CET_NO);

            hnwExtQuery.AddData(vo2.getString("PIS_MM"));
            hnwExtQuery.AddData(SAL_GBN_VAL);
            hnwExtQuery.AddData(vo2.getString("SALT_AMT"));
            hnwExtQuery.AddData(vo2.getString("BAS_AMT"));
            hnwExtQuery.AddData(vo2.getString("WEL_AMT"));
            hnwExtQuery.AddData(vo2.getString("DUTY_AMT"));
            hnwExtQuery.AddData(vo2.getString("OT_AMT"));
            hnwExtQuery.AddData(vo2.getString("OSE_AMT"));
            hnwExtQuery.AddData(vo2.getString("LSEV_AMT"));
            hnwExtQuery.AddData(vo2.getString("RUN_AMT"));
            hnwExtQuery.AddData(vo2.getString("MH_AMT"));
            hnwExtQuery.AddData(vo2.getString("ETC_AMT"));
            hnwExtQuery.AddData(vo2.getString("PPEN_AMT"));
            hnwExtQuery.AddData(vo2.getString("SGF_AMT"));
            hnwExtQuery.AddData(vo2.getString("TB3_AMT"));
            hnwExtQuery.AddData(vo2.getString("OTH_AMT"));

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

            hnwExtQuery.SendData(response);
    }

%>