<!--
***********************************************************************
* @source      : misc200_ED.jsp
* @description : 실적대비 인원충원계획 조회PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/25      이승욱        최초작성.
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
    String pln_yy   = request.getParameter("PLN_YY");

    String sql = null;
	StringBuffer sb1 = new StringBuffer();

    sql = XmlSqlUtils.getSQL("mis", "MISC200_SHR");

      Object[] bind = null;
      bind = new Object[] {
           pln_yy
      };

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("HEAD_NM");
    hnwExtQuery.AddField("GUBUN");
    hnwExtQuery.AddField("OCC_NM");
    hnwExtQuery.AddField("STR_YM");
    hnwExtQuery.AddField("EMP_SA_CNT");
    hnwExtQuery.AddField("EMP_SB_CNT");
    hnwExtQuery.AddField("EMP_PA_CNT");
    hnwExtQuery.AddField("EMP_PB_CNT");
//    hnwExtQuery.AddField("EMP_YA_CNT");
//    hnwExtQuery.AddField("EMP_YB_CNT");
    hnwExtQuery.AddField("EMP_MA_CNT");
    hnwExtQuery.AddField("EMP_MB_CNT");
    hnwExtQuery.AddField("EMP_TA_CNT");
    hnwExtQuery.AddField("EMP_TB_CNT");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("HEAD_NM"));
            hnwExtQuery.AddData(vo.getString("GUBUN"));
            hnwExtQuery.AddData(vo.getString("OCC_NM"));
            hnwExtQuery.AddData(vo.getString("STR_YM"));
            hnwExtQuery.AddData(vo.getString("EMP_SA_CNT"));
            hnwExtQuery.AddData(vo.getString("EMP_SB_CNT"));
            hnwExtQuery.AddData(vo.getString("EMP_PA_CNT"));
            hnwExtQuery.AddData(vo.getString("EMP_PB_CNT"));
//            hnwExtQuery.AddData(vo.getString("EMP_YA_CNT"));
//            hnwExtQuery.AddData(vo.getString("EMP_YB_CNT"));
            hnwExtQuery.AddData(vo.getString("EMP_MA_CNT"));
            hnwExtQuery.AddData(vo.getString("EMP_MB_CNT"));
            hnwExtQuery.AddData(vo.getString("EMP_TA_CNT"));
            hnwExtQuery.AddData(vo.getString("EMP_TB_CNT"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);

%>
