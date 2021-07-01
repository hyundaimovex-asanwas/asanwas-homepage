<!--
*************************************************************************
* @source           : crua010 ED04.jsp
* @description      : 입사지원서 전문교육 조회
*************************************************************************
* DATE                 AUTHOR                DESCRIPTION
*------------------------------------------------------------------------
* 2008/09/17           김경주                최초작성.
*************************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import="com.shift.gef.core.exception.CException"%>
<%@page import="com.shift.gef.dbms.utility.XmlSqlUtils"%>
<%@page import="com.shift.gef.gauce.utility.TrBox"%>
<%@page import="com.shift.gef.support.collection.CBox"%>

<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%

    String REG_NO     = request.getParameter("REG_NO");
    String EDU_TITLE    = request.getParameter("EDU_TITLE");
    String STR_END_YMD    = request.getParameter("STR_END_YMD");
    String CMP_NAM     = request.getParameter("CMP_NAM");

    String sql = null;
    sql = XmlSqlUtils.getSQL("cru", "CRUA010_PRO4");


    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/

    Object[] bind = new Object[] {
    		REG_NO
    };


    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("REG_NO");
    hnwExtQuery.AddField("EDU_TITLE");
    hnwExtQuery.AddField("STR_END_YMD");
    hnwExtQuery.AddField("CMP_NAM");


    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("REG_NO"));
            hnwExtQuery.AddData(vo.getString("EDU_TITLE"));
            hnwExtQuery.AddData(vo.getString("STR_END_YMD"));
            hnwExtQuery.AddData(vo.getString("CMP_NAM"));


            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);
%>
