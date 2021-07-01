<!--
***********************************************************************
* @source      : misc320_ED.jsp
* @description : 정기승진자 인건비 인상현황 조회PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/27      이승욱        최초작성.
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
    String pis_ymd  = request.getParameter("PIS_YY")+"0101";
    String pis_yy   = request.getParameter("PIS_YY");
    String bfr_ym   = request.getParameter("BFR_YM");
    String hir_ym   = request.getParameter("HIR_YM");

    String sql = null;

    sql = XmlSqlUtils.getSQL("mis", "MISC320_SHR");

      Object[] bind = null;
      bind = new Object[] {
           pis_ymd,pis_ymd,pis_ymd,pis_ymd,pis_ymd,pis_ymd,pis_ymd,pis_yy, bfr_ym, hir_ym
      };

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("OCC_CD");
    hnwExtQuery.AddField("JOB_NM");
    hnwExtQuery.AddField("ENO_TCNT");
    hnwExtQuery.AddField("ENO_DCNT");
    hnwExtQuery.AddField("TOT_AMT");
    hnwExtQuery.AddField("BFR_AMT");
    hnwExtQuery.AddField("BUG_AMT");
    hnwExtQuery.AddField("ENO_BCNT");
    hnwExtQuery.AddField("STR_YMD");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("OCC_CD"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_TCNT"));
            hnwExtQuery.AddData(vo.getString("ENO_DCNT"));
            hnwExtQuery.AddData(vo.getString("TOT_AMT"));
            hnwExtQuery.AddData(vo.getString("BFR_AMT"));
            hnwExtQuery.AddData(vo.getString("BUG_AMT"));
            hnwExtQuery.AddData(vo.getString("ENO_BCNT"));
            hnwExtQuery.AddData(vo.getString("STR_YMD"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);

%>
