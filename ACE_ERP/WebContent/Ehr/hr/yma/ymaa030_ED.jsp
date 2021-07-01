<!--
***********************************************************************
* @source      : ymaa030.jsp
* @description : �����������޳��� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/27      ���м�        �����ۼ�.
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
    String PIS_YM = request.getParameter("PIS_YM");
    String OCC_CD = request.getParameter("OCC_CD");
    String GBN    = request.getParameter("GBN");
    String DPT_CD = request.getParameter("DPT_CD");
    String JOB_CD = request.getParameter("JOB_CD");

    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("yma", "YMAA030_SHR_PRT");

    StringBuffer sb = new StringBuffer();
    StringBuffer sb2 = new StringBuffer();

    if (GBN.equals("DPT_CD")) {
        sb2.append("       SF_GET_DPTNAME('01','A4',A.DPT_CD)   DPT_NM");
        sb2.append("      , C.JOB_NM   JOB_NM");
        sb2.append("      , B.DPT_SEQ  SEQ");
        sb.append(" AND    A.DPT_CD LIKE '%"+DPT_CD+"%'");
        sb.append(" ORDER BY B.DPT_SEQ,DPT_NM, C.JOB_SEQ, A.SALC_CD DESC, A.BSH_YMD, A.ENO_NO");
    }else if (GBN.equals("JOB_CD")) {
        sb2.append("       C.JOB_NM   DPT_NM");
        sb2.append("      , B.DPT_NM   JOB_NM");
        sb2.append("      , C.JOB_SEQ  SEQ");
        sb.append(" AND    A.JOB_CD LIKE '%"+JOB_CD+"%'");
        sb.append(" ORDER BY C.JOB_SEQ, B.DPT_SEQ, A.SALC_CD DESC, A.BSH_YMD, A.ENO_NO");
    }

    /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
    Object[] sqlParam = new Object[] {
            sb2.toString(), sb.toString()
    };

    /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
            "A4",
            "A2",
            PIS_YM.substring(0, 4),
            PIS_YM.substring(5, 7),
            OCC_CD
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("�Ҽ�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("���");
    hnwExtQuery.AddField("�Ի���");
    hnwExtQuery.AddField("�߻�");
    hnwExtQuery.AddField("���");
    hnwExtQuery.AddField("�̻��");
    hnwExtQuery.AddField("�����ް� �����ϼ�");
    hnwExtQuery.AddField("�̻�������ް����ϼ�");
    hnwExtQuery.AddField("��� �ӱ�");
    hnwExtQuery.AddField("�̻���ް� ����ݾ�");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());

    if (voList.size() > 0)
    {
        for ( int i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
//            hnwExtQuery.AddData(i);
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("SEQ"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("BSH_YMD"));
            hnwExtQuery.AddData(vo.getString("ANUO_MM"));
            hnwExtQuery.AddData(vo.getString("ANUU_MM"));
            hnwExtQuery.AddData(vo.getString("ANUN_MM"));
            hnwExtQuery.AddData(vo.getString("ADHL_CNT"));
            hnwExtQuery.AddData(vo.getString("TUN_DD"));
            hnwExtQuery.AddData(vo.getString("MNOR_WAG"));
            hnwExtQuery.AddData(vo.getString("PAY_AMT"));

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
    }

%>