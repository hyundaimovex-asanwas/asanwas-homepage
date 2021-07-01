<!--
*****************************************************
* @source       : buta080_ED.jsp
* @description : 철도이용계약할인신청 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/08      김학수        최초작성.        
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
    hnwExtQuery.AddField("고유번호");
    hnwExtQuery.AddField("성명");
    hnwExtQuery.AddField("사번");
    hnwExtQuery.AddField("이용일자1");
    hnwExtQuery.AddField("이용일자2");
    hnwExtQuery.AddField("출발구간1");
    hnwExtQuery.AddField("도착구간1");
    hnwExtQuery.AddField("출발구간2");
    hnwExtQuery.AddField("도착구간2");
    hnwExtQuery.AddField("차종1");
    hnwExtQuery.AddField("차종2");
    hnwExtQuery.AddField("유효기간");
    hnwExtQuery.AddField("발행일");
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