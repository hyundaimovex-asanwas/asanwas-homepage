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

    String eno_no   = request.getParameter("eno_no");
	String gubun  = request.getParameter("gubun");
	String useContent     = request.getParameter("use");
	String CEF_STS     = request.getParameter("CEF_STS");
	String REQ_NO     = request.getParameter("REQ_NO");

    String sql = null;
    sql = XmlSqlUtils.getSQL("idt", "IDTA010_CAR_PRT");
  	System.out.println(sql);

  	Object[] bind = null;
  	bind = new Object[] {
  			eno_no,
  			gubun,
  			CEF_STS,
  			REQ_NO
  	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("�߱޹�ȣ");
    hnwExtQuery.AddField("�̸�");
    hnwExtQuery.AddField("�������");
    hnwExtQuery.AddField("��");
    hnwExtQuery.AddField("�ֹι�ȣ");

    hnwExtQuery.AddField("ȸ���");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("���ּ�");
    hnwExtQuery.AddField("�Ի���");


    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData("Issue No. : " + vo.getString("CEF_NO"));
            hnwExtQuery.AddData(vo.getString("NAM_ENG"));
            hnwExtQuery.AddData(vo.getString("ENG_BIR_YMD"));
            hnwExtQuery.AddData(vo.getString("ENG_MF_NM"));
            hnwExtQuery.AddData(vo.getString("CET_NO"));

            hnwExtQuery.AddData(vo.getString("COMP_ENM"));
			hnwExtQuery.AddData(vo.getString("ENG_JOB_NM"));
            hnwExtQuery.AddData(vo.getString("ENG_PER_ADR"));
            hnwExtQuery.AddData(vo.getString("ENG_ADDRESS"));
            hnwExtQuery.AddData(vo.getString("HIR_YMD") + " - At present");
            hnwExtQuery.SendData(response);
        }
    }

    hnwExtQuery.EndData(response);
%>