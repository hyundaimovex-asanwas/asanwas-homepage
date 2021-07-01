<!--
***********************************************************************
* @source      : misc310_ED.jsp
* @description : 업무별월별예산(항세목별) 조회PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/28      이승욱        최초작성.
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
    String item_cd  = request.getParameter("ITEM_CD");
    String occ_cd   = request.getParameter("OCC_CD");
    String cur_yy   = request.getParameter("CUR_YY");
    String pln_yy   = request.getParameter("PLN_YY");

    String sql = null;

    sql = XmlSqlUtils.getSQL("mis", "MISC310_SHR_02");

      Object[] bind = null;
      bind = new Object[] {
            item_cd, occ_cd, item_cd, pln_yy, occ_cd, pln_yy, item_cd, pln_yy, occ_cd, pln_yy, item_cd
      };

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("HEAD_NM");
    hnwExtQuery.AddField("HEAD_CD");
    hnwExtQuery.AddField("AMT00");
    hnwExtQuery.AddField("AMT01");
    hnwExtQuery.AddField("AMT02");
    hnwExtQuery.AddField("AMT03");
    hnwExtQuery.AddField("AMT04");
    hnwExtQuery.AddField("AMT05");
    hnwExtQuery.AddField("AMT06");
    hnwExtQuery.AddField("AMT07");
    hnwExtQuery.AddField("AMT08");
    hnwExtQuery.AddField("AMT09");
    hnwExtQuery.AddField("AMT10");
    hnwExtQuery.AddField("AMT11");
    hnwExtQuery.AddField("AMT12");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("ITEM_NM"));
            hnwExtQuery.AddData(vo.getString("ITEM_NM"));
            hnwExtQuery.AddData(vo.getString("AMT00"));
            hnwExtQuery.AddData(vo.getString("AMT01"));
            hnwExtQuery.AddData(vo.getString("AMT02"));
            hnwExtQuery.AddData(vo.getString("AMT03"));
            hnwExtQuery.AddData(vo.getString("AMT04"));
            hnwExtQuery.AddData(vo.getString("AMT05"));
            hnwExtQuery.AddData(vo.getString("AMT06"));
            hnwExtQuery.AddData(vo.getString("AMT07"));
            hnwExtQuery.AddData(vo.getString("AMT08"));
            hnwExtQuery.AddData(vo.getString("AMT09"));
            hnwExtQuery.AddData(vo.getString("AMT10"));
            hnwExtQuery.AddData(vo.getString("AMT11"));
            hnwExtQuery.AddData(vo.getString("AMT12"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);

%>
