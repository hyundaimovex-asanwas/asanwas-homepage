<!--
***********************************************************************
* @source      : memb110_ED.jsp
* @description : �İ߻�� �������� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/25      ���м�        �����ۼ�.        
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
    String eno_no  = request.getParameter("eno_no");
    String str_ymd_val = "";
    String str_y       = str_ymd.substring(0,4);
    String str_m       = str_ymd.substring(5,7);
    
    str_ymd_val = str_y + str_m;
    String title_val   = "( " + str_y + " ��   " + str_m + "�� )";

    /** �ܺ� XML���� SQL�� �о� �´� **/
    String sql = XmlSqlUtils.getSQL("mem", "MEMB110_SHR_03");

    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
    Object[] bind = new Object[] {
        eno_no, str_ymd
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);    

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("No");
    hnwExtQuery.AddField("�þ��ð�");
    hnwExtQuery.AddField("�����ð�");
    hnwExtQuery.AddField("�ٹ��ð�");
    hnwExtQuery.AddField("�޽Ľð�");
    hnwExtQuery.AddField("��������");
    hnwExtQuery.AddField("�İ�ȸ���");
    hnwExtQuery.AddField("�İ�������");
    hnwExtQuery.AddField("�ٹ����");
    hnwExtQuery.AddField("����������");
    hnwExtQuery.AddField("��¥");

    hnwExtQuery.SendField(response);
    
    String str_hms = "";
    String end_hms = "";
    String gun_hms = "";
    String rest_hms = "";
//    System.out.println("voList.size()="+voList.size());
    if (voList.size() > 0) 
    {
        for ( int i=0; i<voList.size(); i++ ) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            
            if ( ! vo.getString("STR_HMS").equals("") ) str_hms = vo.getString("STR_HMS").substring(0,2) + ":" + vo.getString("STR_HMS").substring(2,4);
            if ( ! vo.getString("END_HMS").equals("") ) end_hms = vo.getString("END_HMS").substring(0,2) + ":" + vo.getString("END_HMS").substring(2,4);
            if ( ! vo.getString("GUN_HMS").equals("") ) gun_hms = vo.getString("GUN_HMS").substring(0,2) + ":" + vo.getString("GUN_HMS").substring(2,4);
            if ( ! vo.getString("REST_HMS").equals("") )rest_hms = vo.getString("REST_HMS").substring(0,2) + ":" + vo.getString("REST_HMS").substring(2,4);

            hnwExtQuery.AddData(i + 1);
            hnwExtQuery.AddData(str_hms);
            hnwExtQuery.AddData(end_hms);
            hnwExtQuery.AddData(gun_hms);
            hnwExtQuery.AddData(rest_hms);
            hnwExtQuery.AddData(vo.getString("JOB_TAG"));
            hnwExtQuery.AddData(vo.getString("DISCOMP_CD"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("REG_CD"));
            hnwExtQuery.AddData(vo.getString("SYENO_NM"));
            hnwExtQuery.AddData(title_val);

            hnwExtQuery.SendData(response);

            str_hms = "";
            end_hms = "";
            gun_hms = "";
            rest_hms = "";
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
            
            hnwExtQuery.SendData(response);
    }

%>