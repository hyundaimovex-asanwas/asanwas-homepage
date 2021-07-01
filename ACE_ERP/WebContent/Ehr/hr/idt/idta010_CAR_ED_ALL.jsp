<!--
***********************************************************************
* @source      : idta010_ED.jsp
* @description : �����߱�ó��
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/02      �漮ȣ        �����ۼ�.
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

    String ENO_NO   = request.getParameter("ENO_NO");
	String CEF_SEC  = request.getParameter("CEF_SEC");
	String REQ_NO     = request.getParameter("REQ_NO");

    String sql = null;
    sql = XmlSqlUtils.getSQL("idt", "IDTA010_CAR_PRT1");
  	System.out.println(sql);

  	Object[] bind = null;
  	bind = new Object[] {
  			ENO_NO,
  			CEF_SEC,
  			REQ_NO
  	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("�߱޹�ȣ");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("���");
    hnwExtQuery.AddField("�̸�");

    hnwExtQuery.AddField("������");
    hnwExtQuery.AddField("�뵵");
    hnwExtQuery.AddField("�μ�Ƚ��");
    hnwExtQuery.AddField("�����");
    hnwExtQuery.AddField("�Ի���");

    hnwExtQuery.AddField("�����");
    hnwExtQuery.AddField("�ּ�");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�ֹε�Ϲ�ȣ");
    hnwExtQuery.AddField("�ټӳ��");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("CEF_NO"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));

            hnwExtQuery.AddData(vo.getString("CEF_SEC"));
            hnwExtQuery.AddData(vo.getString("CEF_RSN"));
            hnwExtQuery.AddData(vo.getString("CEF_CNT"));
            hnwExtQuery.AddData(vo.getString("SPL_YMD"));
            hnwExtQuery.AddData(vo.getString("HIR_YMD"));

            hnwExtQuery.AddData(vo.getString("RET_YMD"));
            hnwExtQuery.AddData(vo.getString("ADDRESS1"));
            hnwExtQuery.AddData(vo.getString("ADDRESS2"));
            hnwExtQuery.AddData(vo.getString("CET_NO"));
            hnwExtQuery.AddData(vo.getString("LSE_YYMM"));


            hnwExtQuery.SendData(response);
        }
    }

    hnwExtQuery.EndData(response);
%>