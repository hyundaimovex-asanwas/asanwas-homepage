<!--
***********************************************************************
* @source      : memb120_ED.jsp
* @description : ���� �İ߻�� ������� ��Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/17      ���м�        �����ۼ�.        
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
    String str_ymd = request.getParameter("str_ymd");
    
    String str_ymd_val = "";
    String str_y       = str_ymd.substring(0,4);
    String str_m       = str_ymd.substring(5,7);

    String title_val   = "";
    String title_m     = "";
    String title_m_val = str_ymd.substring(5,6);
    if ( title_m_val.equals("0") ) {
        title_m = str_ymd.substring(6,7);
    } else {
        title_m = str_ymd.substring(5,7);
    }
    str_ymd_val = str_y + str_m;
    title_val   = str_y + "�� " + title_m + "�� �İ߻�� ��,����� ��Ȳ";
    System.out.println(title_val);
    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("mem", "MEMB090_SHR");

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
        str_ymd_val, str_ymd_val, str_ymd_val, str_ymd_val, str_ymd_val
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("����1");
    hnwExtQuery.AddField("����2");
    hnwExtQuery.AddField("������������");
    hnwExtQuery.AddField("�Ի�1");
    hnwExtQuery.AddField("���1");
    hnwExtQuery.AddField("������������");
    hnwExtQuery.AddField("�Ի�2");
    hnwExtQuery.AddField("���2");
    hnwExtQuery.AddField("������&�繫");
    hnwExtQuery.AddField("�Ի�3");
    hnwExtQuery.AddField("���3");
    hnwExtQuery.AddField("TM");
    hnwExtQuery.AddField("�Ի�4");
    hnwExtQuery.AddField("���4");
    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("�Ի�5");
    hnwExtQuery.AddField("���5");
    hnwExtQuery.AddField("B/L");
    hnwExtQuery.AddField("�Ի�6");
    hnwExtQuery.AddField("���6");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("�Ի�7");
    hnwExtQuery.AddField("���7");
    hnwExtQuery.AddField("��");
    hnwExtQuery.AddField("�Ի��");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("����κ�");  
    
    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    
    String pre_GUBUN = "";
    String gubun  = "";

    if (voList.size() > 0) 
    {
        for ( int i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            if ( vo.getString("GUBUN").equals("0") ) {
                gubun = "�Ѱ�";
            } else if ( vo.getString("GUBUN").equals("1") ) {
                gubun = "����";                
            } else {
                gubun = "����";
            }
            
            if ( vo.getString("GUBUN").equals(pre_GUBUN) ) {  
                hnwExtQuery.AddData("");
            } else {
                hnwExtQuery.AddData(gubun);
            }

            hnwExtQuery.AddData(vo.getString("COMM_NM"));
            hnwExtQuery.AddData(vo.getString("1_DIF"));
            hnwExtQuery.AddData(vo.getString("1_HIR"));
            hnwExtQuery.AddData(vo.getString("1_RET"));
            hnwExtQuery.AddData(vo.getString("2_DIF"));
            hnwExtQuery.AddData(vo.getString("2_HIR"));
            hnwExtQuery.AddData(vo.getString("2_RET"));
            hnwExtQuery.AddData(vo.getString("3_DIF"));
            hnwExtQuery.AddData(vo.getString("3_HIR"));
            hnwExtQuery.AddData(vo.getString("3_RET"));
            hnwExtQuery.AddData(vo.getString("4_DIF"));
            hnwExtQuery.AddData(vo.getString("4_HIR"));
            hnwExtQuery.AddData(vo.getString("4_RET"));
            hnwExtQuery.AddData(vo.getString("5_DIF"));
            hnwExtQuery.AddData(vo.getString("5_HIR"));
            hnwExtQuery.AddData(vo.getString("5_RET"));
            hnwExtQuery.AddData(vo.getString("6_DIF"));
            hnwExtQuery.AddData(vo.getString("6_HIR"));
            hnwExtQuery.AddData(vo.getString("6_RET"));
            hnwExtQuery.AddData(vo.getString("7_DIF"));
            hnwExtQuery.AddData(vo.getString("7_HIR"));
            hnwExtQuery.AddData(vo.getString("7_RET"));
            hnwExtQuery.AddData(vo.getString("DIF_TOT"));
            hnwExtQuery.AddData(vo.getString("HIR_TOT"));
            hnwExtQuery.AddData(vo.getString("RET_TOT"));
            hnwExtQuery.AddData(title_val);

            hnwExtQuery.SendData(response);

            pre_GUBUN = vo.getString("GUBUN");
            gubun  = "";
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
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
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