<!--
*****************************************************
* @source       : buta080_ED.jsp
* @description : ö���̿������ν�û PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/08      ���м�        �����ۼ�.        
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
    String user_name     = request.getParameter("user_name");
    String user_no       = request.getParameter("user_no");
    String cd_gbn_val    = request.getParameter("cd_gbn_val");
    String cd_gbn        = request.getParameter("cd_gbn");
    String ymd_val       = request.getParameter("ymd_val");
    String today_ymd     = request.getParameter("today_ymd");
    String ymd1_ins      = request.getParameter("ymd1_ins");
    String str_city1     = request.getParameter("str_city1");
    String end_city1     = request.getParameter("end_city1");
    String kor_type1_val = request.getParameter("kor_type1_val");
    String ymd2_ins      = request.getParameter("ymd2_ins");
    String str_city2     = request.getParameter("str_city2");
    String end_city2     = request.getParameter("end_city2");
    String kor_type2_val = request.getParameter("kor_type2_val");

  
    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("No");
    hnwExtQuery.AddField("������ȣ");
    hnwExtQuery.AddField("����");
    hnwExtQuery.AddField("���");
    hnwExtQuery.AddField("�̿�����1");
    hnwExtQuery.AddField("�̿�����2");
    hnwExtQuery.AddField("��߱���1");
    hnwExtQuery.AddField("��������1");
    hnwExtQuery.AddField("��߱���2");
    hnwExtQuery.AddField("��������2");
    hnwExtQuery.AddField("����1");
    hnwExtQuery.AddField("����2");
    hnwExtQuery.AddField("��ȿ�Ⱓ");
    hnwExtQuery.AddField("������");
    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());


        hnwExtQuery.AddData(cd_gbn_val);
        hnwExtQuery.AddData(cd_gbn);
        hnwExtQuery.AddData(user_name);
        hnwExtQuery.AddData(user_no);
        hnwExtQuery.AddData(ymd1_ins);
        hnwExtQuery.AddData(ymd2_ins);
        hnwExtQuery.AddData(str_city1);
        hnwExtQuery.AddData(end_city1);
        hnwExtQuery.AddData(str_city2);
        hnwExtQuery.AddData(end_city2);
        hnwExtQuery.AddData(kor_type1_val);
        hnwExtQuery.AddData(kor_type2_val);
        hnwExtQuery.AddData(ymd_val);
        hnwExtQuery.AddData(today_ymd);

        hnwExtQuery.SendData(response);
    
%>