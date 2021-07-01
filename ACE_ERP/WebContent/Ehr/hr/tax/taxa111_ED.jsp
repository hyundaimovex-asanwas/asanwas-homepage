<!--
***********************************************************************
* @source      : taxa111_ED.jsp
* @description : ����� ���� ��ȸ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/04      �̽¿�        �����ۼ�.        
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

    /** �ܺ� XML���� SQL�� �о� �´� **/
    String Query = XmlSqlUtils.getSQL("tax", "TAXA110_CORP");

    //param binding �ϱ�
      Object[] bind = null;

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(Query, bind);    

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("COMP_NM");
    hnwExtQuery.AddField("ADDRESS_HD");
    hnwExtQuery.AddField("PRESIDENT_NM");
    hnwExtQuery.AddField("TEL_NO");
    hnwExtQuery.AddField("TAX_NO");
    hnwExtQuery.AddField("CORP_NO");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    
    if (voList.size() > 0) 
    {
        for ( int i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("COMP_NM"));
            hnwExtQuery.AddData(vo.getString("ADDRESS_HD"));
            hnwExtQuery.AddData(vo.getString("PRESIDENT_NM"));
            hnwExtQuery.AddData(vo.getString("TEL_NO"));
            hnwExtQuery.AddData(vo.getString("TAX_NO"));
            hnwExtQuery.AddData(vo.getString("CORP_NO"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);

%>
