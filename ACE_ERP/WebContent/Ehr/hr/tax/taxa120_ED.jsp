<!--
***********************************************************************
* @source      : taxa120_ED.jsp                                                *
* @description : ����۱ݸ��� PAGE  
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/03      ���м�        �����ۼ�.        
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
    String PIS_YM   = request.getParameter("PIS_YM");
    String OCC_CD   = request.getParameter("OCC_CD");
    String SAL_GBN  = request.getParameter("SAL_GBN");
    String LC_SEQ   = request.getParameter("LC_SEQ");
    String ABA_CD   = request.getParameter("ABA_CD");
   
    /** �ܺ� XML���� SQL�� �о� �´� **/
    String Query = "";

    // ��ȯ����, ��Ÿ���� ���
    if ( ABA_CD.equals("10") ) {
        Query = XmlSqlUtils.getSQL("tax", "TAXA120_SHR1");
    } else {
        Query = XmlSqlUtils.getSQL("tax", "TAXA120_SHR2");
    }

    //DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ�
    Object[] sqlParam = new Object[] {

    };
    
    //[1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� 
    Query = SqlUtils.replaceQuery(Query, sqlParam);

    //param binding �ϱ�
    Object[] bind = new Object[] {
             OCC_CD 
            ,SAL_GBN
            ,LC_SEQ    
            ,PIS_YM.replaceAll("-", "") 
            ,PIS_YM.replaceAll("-", "")
            ,OCC_CD 
            ,SAL_GBN
            ,LC_SEQ    
            ,PIS_YM.replaceAll("-", "") 
            ,PIS_YM.replaceAll("-", "") 
    };
   

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(Query, bind);    

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("�����");
    hnwExtQuery.AddField("�����ȣ");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("������");
    hnwExtQuery.AddField("���¹�ȣ");
    hnwExtQuery.AddField("�۱ݾ�");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    
    if (voList.size() > 0) 
    {
        for ( int i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
//            hnwExtQuery.AddData(i);
            hnwExtQuery.AddData(vo.getString("ABA"));
            hnwExtQuery.AddData(vo.getString("ENO"));
            hnwExtQuery.AddData(vo.getString("NAM"));
            hnwExtQuery.AddData(vo.getString("REC"));
            hnwExtQuery.AddData(vo.getString("ACC"));
            hnwExtQuery.AddData(vo.getString("PAY"));
            hnwExtQuery.SendData(response);
        }
    } else {
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.AddData("");
        hnwExtQuery.SendData(response);
    }

%>