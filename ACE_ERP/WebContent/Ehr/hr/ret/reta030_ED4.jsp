<!--
***********************************************************************
* @source      : yaca030_ED.jsp
* @description : �����ݰ��ó��(���������ȸ) PAGE
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
    String eno_no = request.getParameter("eno_no");

//--------------------------------������� ��ȸ--------------------------------------------------------
    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("ret", "RETA030_SHR_PERSON");

    /** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
    Object[] sqlParam = new Object[] {
    };

    /** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
        eno_no
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);
//-----------------------------------------------------------------------------------------

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("�ֹε�Ϲ�ȣ");
    hnwExtQuery.AddField("����/���¹�ȣ");
    hnwExtQuery.AddField("�����ȣ");
    hnwExtQuery.AddField("�ּ�1");
    hnwExtQuery.AddField("�ּ�2");

    hnwExtQuery.SendField(response);
    
//    System.out.println("voList.size()="+voList.size());

    if (voList.size() > 0) {
        DynamicValueObject vo = (DynamicValueObject)voList.get(0);
        
        hnwExtQuery.AddData(vo.getString("CET_NO"));
        hnwExtQuery.AddData(vo.getString("ACC_NO"));
        hnwExtQuery.AddData(vo.getString("ZIP_NO"));
        hnwExtQuery.AddData(vo.getString("ADR_CT"));
        hnwExtQuery.AddData(vo.getString("ADDRESS"));

        hnwExtQuery.SendData(response);
    } else {
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");      
        hnwExtQuery.SendData(response);
    }

%>