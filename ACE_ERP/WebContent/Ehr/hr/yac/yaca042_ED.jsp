<!--
***********************************************************************
* @source      : taxa100_ED.jsp                                                *
* @description : �������μ���������Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/05      ���м�        �����ۼ�.
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
    String pis_yy = request.getParameter("pis_yy");
    String eno_no = request.getParameter("eno_no");

    String Query =  XmlSqlUtils.getSQL("yac", "YACA040_SHR_04");

    //param binding �ϱ�
    Object[] bind = new Object[] {
    		pis_yy,
    		pis_yy,
    		pis_yy,
    		pis_yy,
    		pis_yy,
    		eno_no
    };

//    Log.debug.println("ORDER_TYPE:"+orderType);



    //DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ�
    Object[] sqlParam = new Object[] {
    		pis_yy,
    		pis_yy,
    		pis_yy,
    		pis_yy,
    		pis_yy,
    		eno_no

    };

    //[1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ�
    Query = SqlUtils.replaceQuery(Query, sqlParam);

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(Query, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("��α��ڵ�");
    hnwExtQuery.AddField("��ο���");
    hnwExtQuery.AddField("��αݾ�");
    hnwExtQuery.AddField("������������ȱݾ�");
    hnwExtQuery.AddField("�������ݾ�");
    hnwExtQuery.AddField("�ش翬�������ݾ�");
    hnwExtQuery.AddField("�Ҹ�ݾ�");
    hnwExtQuery.AddField("�̿��ݾ�");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());

    if (voList.size() > 0)
    {
        for ( int i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("REL_CD"));
            hnwExtQuery.AddData(vo.getString("DON_YY"));
            hnwExtQuery.AddData(vo.getString("ACC_DON_AMT"));
            hnwExtQuery.AddData(vo.getString("ACC_DON_DED"));
            hnwExtQuery.AddData(vo.getString("ACC_DON_DIF"));
            hnwExtQuery.AddData(vo.getString("DON_DED"));
            hnwExtQuery.AddData(vo.getString("EXH_AMT"));
            hnwExtQuery.AddData(vo.getString("VAL_AMT"));
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
        hnwExtQuery.SendData(response);
    }

%>