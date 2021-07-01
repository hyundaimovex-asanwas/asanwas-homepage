<!--
***********************************************************************
* @source      : cdpc050_ED.jsp
* @description : �İ��κ�����Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/17      ���м�        �����ۼ�.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import ="com.shift.gef.core.exception.CException"%>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"%>
<%@page import ="com.shift.gef.gauce.utility.TrBox"%>
<%@page import ="com.shift.gef.support.collection.CBox"%>

<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%
    String MNT_GBN  = request.getParameter("MNT_GBN");
    String ENO_NO  = request.getParameter("ENO_NO").replaceAll("null", "");
    String STR_YMD = request.getParameter("STR_YMD").replaceAll("-", "");
    String END_YMD = request.getParameter("END_YMD").replaceAll("-", "");

    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("cdp", "CDPC050_SHR_PRINT");

    /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
    StringBuffer sb = new StringBuffer();


    if(MNT_GBN.equals("P")) {
    	sb.append("AND ENO_NO LIKE '"+ENO_NO+"'||'%'");
    } else if(MNT_GBN.equals("M")) {
    	sb.append("AND MENO_NO LIKE '"+ENO_NO+"'||'%'");
    } else {
    	sb.append("AND (ENO_NO LIKE '"+ENO_NO+"'||'%'");
    	sb.append(" OR  MENO_NO LIKE '"+ENO_NO+"'||'%')");
    }

    Object[] sqlParam = new Object[] {
    		sb.toString()
    };

    /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
        STR_YMD,
        END_YMD
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("���İ��λ��");
    hnwExtQuery.AddField("���İ��μ���");
    hnwExtQuery.AddField("���İ��μҼ�");
    hnwExtQuery.AddField("���İ�������");
    hnwExtQuery.AddField("�İ��λ��");
    hnwExtQuery.AddField("�İ��μ���");
    hnwExtQuery.AddField("�İ��μҼ�");
    hnwExtQuery.AddField("�İ�������");
    hnwExtQuery.AddField("�İ߽�������");
    hnwExtQuery.AddField("�İ���������");
    hnwExtQuery.AddField("�ۼ�����");
    hnwExtQuery.AddField("����");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    int i = 0;

    if (voList.size() > 0)
    {
        for ( i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(Integer.toString(i+1));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("MENO_NO"));
            hnwExtQuery.AddData(vo.getString("MENO_NM"));
            hnwExtQuery.AddData(vo.getString("MDPT_NM"));
            hnwExtQuery.AddData(vo.getString("MJOB_NM"));
            hnwExtQuery.AddData(vo.getString("STR_YMD"));
            hnwExtQuery.AddData(vo.getString("END_YMD"));
            hnwExtQuery.AddData(vo.getString("IPT_YMD"));
            hnwExtQuery.AddData(vo.getString("OBJ_TXT"));

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