<!--
***********************************************************************
* @source      : stoa010_ED.jsp
* @description : ���ָ���Ʈ ���
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
	String BASIC_YMD_SHR     	= request.getParameter("BASIC_YMD_SHR");
	String cmbEMP_GBN_SHR   = request.getParameter("cmbEMP_GBN_SHR");

	/** �ܺ� XML���� SQL�� �о� �´� **/
	String sql = XmlSqlUtils.getSQL("sto", "STOA010_SHR");


	/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	Object[] bind = new Object[] {
			BASIC_YMD_SHR,
			BASIC_YMD_SHR,
			cmbEMP_GBN_SHR,
	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("��������");
     hnwExtQuery.AddField("���ֹ�ȣ");
    hnwExtQuery.AddField("�̸�");
    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("�Ի���");

    hnwExtQuery.AddField("�����");
    hnwExtQuery.AddField("������");
    hnwExtQuery.AddField("�켱��");
    hnwExtQuery.AddField("����1");
    hnwExtQuery.AddField("����2");

    hnwExtQuery.AddField("�����ȣ");
    hnwExtQuery.AddField("�ּ�");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);


            hnwExtQuery.AddData(vo.getString("BASIC_YMD"));
            hnwExtQuery.AddData(vo.getString("SH_NO"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("EMP_GB"));
            hnwExtQuery.AddData(vo.getString("HIR_YMD"));

            hnwExtQuery.AddData(vo.getString("RET_YMD"));
            hnwExtQuery.AddData(vo.getString("COM_STK"));
            hnwExtQuery.AddData(vo.getString("PRE_STK"));
            hnwExtQuery.AddData(vo.getString("NEW_STK1"));
            hnwExtQuery.AddData(vo.getString("NEW_STK2"));

            hnwExtQuery.AddData(vo.getString("POST_NO"));
            hnwExtQuery.AddData(vo.getString("ADDRESS"));


            hnwExtQuery.SendData(response);
        }
    }
%>