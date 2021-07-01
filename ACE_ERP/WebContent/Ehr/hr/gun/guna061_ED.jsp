<!--
***********************************************************************
* @source      : guna061_ED.jsp
* @description : 근태변경신청현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/28      김학수        최초작성.
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
    String req_no  = request.getParameter("req_no");

    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("gun", "GUNA061_SHR");

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
            req_no
    };

    //System.out.println("7777 "+req_no+" 77");


    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();


    hnwExtQuery.AddField("부서");
    hnwExtQuery.AddField("직위");
    hnwExtQuery.AddField("사번");
    hnwExtQuery.AddField("성명");
    hnwExtQuery.AddField("전근태");
    hnwExtQuery.AddField("전비고");
    hnwExtQuery.AddField("근태");
    hnwExtQuery.AddField("비고");
    hnwExtQuery.AddField("사유");

    hnwExtQuery.SendField(response);

    //System.out.println("voList.size()="+voList.size());

    if (voList.size() > 0)
    {
        for ( int i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("BF_GUN_NM"));
            hnwExtQuery.AddData(vo.getString("BF_REMARK"));
            hnwExtQuery.AddData(vo.getString("GUN_NM"));
            hnwExtQuery.AddData(vo.getString("REMARK"));
            hnwExtQuery.AddData(vo.getString("REASON"));

            hnwExtQuery.SendData(response);

        }
    }

%>