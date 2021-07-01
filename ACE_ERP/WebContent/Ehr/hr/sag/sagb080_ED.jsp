<!--
***********************************************************************
* @source      : sagb080_ED.jsp
* @description : ö�ߴ�������Ȳ PAGE 			 			          *
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/20      ���м�        �����ۼ�.
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
    String PIS_YM = request.getParameter("PIS_YM");
    String DPT_CD = request.getParameter("DPT_CD");

    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("sag", "SAGB080_SHR");

    /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
    Object[] sqlParam = new Object[] {

    };

    /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
        PIS_YM.substring(0, 4), PIS_YM.substring(5, 7), DPT_CD
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    hnwExtQuery.AddField("No");
    hnwExtQuery.AddField("No2");
    hnwExtQuery.AddField("�Ҽ�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�ϼ�");
    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("���");

    hnwExtQuery.SendField(response);

    int i = 0;
    int k = 0;
    String pre_dpt_nm = "";

    if (voList.size() > 0)
    {
        for ( i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            if ( pre_dpt_nm.equals(vo.getString("DPT_NM")) ) {

                    hnwExtQuery.AddData(Integer.toString(k));
                    hnwExtQuery.AddData("");
                    hnwExtQuery.AddData(vo.getString("DPT_NM"));

            } else {
                k = k + 1;
                hnwExtQuery.AddData(Integer.toString(k));
                hnwExtQuery.AddData(Integer.toString(k));
                hnwExtQuery.AddData(vo.getString("DPT_NM"));
            }
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("DUTY_CNT"));
            hnwExtQuery.AddData(Integer.toString(Integer.parseInt(vo.getString("DUTY_AMT"))));
            hnwExtQuery.AddData(vo.getString("REMARK"));

            hnwExtQuery.SendData(response);

            pre_dpt_nm = vo.getString("DPT_NM");
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