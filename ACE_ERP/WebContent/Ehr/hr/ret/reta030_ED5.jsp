<!--
***********************************************************************
* @source      : reta030_ED.jsp
* @description : �����ݰ��ó��(������ �Ⱥг����� ��ȸ) PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/11      ���м�        �����ۼ�.
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
    String eno_no   = request.getParameter("eno_no");
    String TYPE = request.getParameter("TYPE");

    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("ret", "RETA030_SHR_KUKMIN");

    /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
    Object[] sqlParam = new Object[] {
    };

    /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
        eno_no,
        TYPE
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);
    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("���");
    hnwExtQuery.AddField("����ȸ��");
    hnwExtQuery.AddField("��ȯ������");
    hnwExtQuery.AddField("��ȯ������");
    hnwExtQuery.AddField("��ȯ��");


    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for ( int i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("SEQ_NO"));
            hnwExtQuery.AddData(vo.getString("STR_YMD"));
            hnwExtQuery.AddData(vo.getString("END_YMD"));
            hnwExtQuery.AddData(vo.getString("CTZ_AMT"));

            hnwExtQuery.SendData(response);
        }
    } else {
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");

            hnwExtQuery.SendData(response);
    }

%>