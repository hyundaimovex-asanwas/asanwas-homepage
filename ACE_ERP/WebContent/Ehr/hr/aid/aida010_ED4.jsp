<!--
***********************************************************************
* @source      : aida010_ED2.jsp
* @description : ���������� ��û��
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/14      �漮ȣ        �����ۼ�.
* 2007/05/08      ���м�
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

    String ENO_CD  = request.getParameter("ENO_CD");
	String REQ_NO  = request.getParameter("REQ_NO");

//----------------------------��������----------------------------------------------

	/** �ܺ� XML���� SQL�� �о� �´� **/
	String sql = XmlSqlUtils.getSQL("aid", "AIDA010_SHR_05_PRINT");
	/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	Object[] bind = new Object[] {
			REQ_NO
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);
    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("��û��");
	hnwExtQuery.AddField("��û����");
	hnwExtQuery.AddField("������");
	hnwExtQuery.AddField("��������");
	hnwExtQuery.AddField("������2");
	hnwExtQuery.AddField("��������2");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    int i = 0;
    int k = 0;
    int row_size = 0;
    row_size = 7 - (voList.size()%7);
    if ( row_size == 7 ) row_size = 0;

    if (voList.size() > 0)
    {
        for ( i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("NM1"));
            hnwExtQuery.AddData(vo.getString("APP_STATUS1"));
            hnwExtQuery.AddData(vo.getString("NM2"));
            hnwExtQuery.AddData(vo.getString("APP_STATUS2"));
            hnwExtQuery.AddData(vo.getString("NM3"));
            hnwExtQuery.AddData(vo.getString("APP_STATUS3"));

            hnwExtQuery.SendData(response);
        }

    } else {

            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");

            hnwExtQuery.SendData(response);

    }

%>