<!--
***********************************************************************
* @source      : misb210_ED.jsp
* @description : 부서별인원증감현황 조회PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/16      이승욱        최초작성.
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
    String str_ym   = request.getParameter("STR_YM");
    String end_ym   = request.getParameter("END_YM");

    String sql = null;
    StringBuffer sb1 = new StringBuffer();

    sql = XmlSqlUtils.getSQL("mis", "MISB210_SHR");
    
      Object[] bind = null;
      bind = new Object[] {
           str_ym, str_ym, str_ym, str_ym,
           end_ym, end_ym, end_ym, end_ym,
           str_ym, end_ym, str_ym, end_ym,
           str_ym, end_ym, str_ym, end_ym,
           str_ym, end_ym, str_ym, end_ym,
           str_ym, end_ym, str_ym, end_ym
      };

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    
    hnwExtQuery.AddField("GRP_GBN");
    hnwExtQuery.AddField("GUBUN");
    hnwExtQuery.AddField("ST_YY");
    hnwExtQuery.AddField("CU_YY");
    hnwExtQuery.AddField("IN_HH");
    hnwExtQuery.AddField("IN_TS");
    hnwExtQuery.AddField("RT_HH");
    hnwExtQuery.AddField("RT_TS");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("GRP_GBN"));
            hnwExtQuery.AddData(vo.getString("GUBUN"));
            hnwExtQuery.AddData(vo.getString("ST_YY"));
            hnwExtQuery.AddData(vo.getString("CU_YY"));
            hnwExtQuery.AddData(vo.getString("IN_HH"));
            hnwExtQuery.AddData(vo.getString("IN_TS"));
            hnwExtQuery.AddData(vo.getString("RT_HH"));
            hnwExtQuery.AddData(vo.getString("RT_TS"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);

%>
