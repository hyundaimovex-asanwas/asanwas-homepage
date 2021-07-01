<!--
***********************************************************************
* @source      : misb220_ED.jsp
* @description : 부서별인원증감현황(본사/지방별) 조회PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/18      이승욱        최초작성.
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

    sql = XmlSqlUtils.getSQL("mis", "MISB220_SHR");

      Object[] bind = null;
      bind = new Object[] {
           end_ym, end_ym,
           str_ym, end_ym,
		   str_ym, end_ym,
		   str_ym, end_ym,
		   str_ym, end_ym,
      };

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("A_TAG");
    hnwExtQuery.AddField("HEAD_NM");
    hnwExtQuery.AddField("DPT_NM");
    hnwExtQuery.AddField("HSORT_NO");
    hnwExtQuery.AddField("DSORT_NO");
    hnwExtQuery.AddField("ENO_IN");
    hnwExtQuery.AddField("AHIS_IN");
    hnwExtQuery.AddField("LH1_IN");
    hnwExtQuery.AddField("ENO_OUT");
    hnwExtQuery.AddField("AHIS_OUT");
    hnwExtQuery.AddField("LH1_OUT");
    hnwExtQuery.AddField("TOT_CNT");
    hnwExtQuery.AddField("OCCA_CNT");
    hnwExtQuery.AddField("A2");
    hnwExtQuery.AddField("A4");
    hnwExtQuery.AddField("A5");
    hnwExtQuery.AddField("AB");
    hnwExtQuery.AddField("C1");
    hnwExtQuery.AddField("D1");
    hnwExtQuery.AddField("E1");
    hnwExtQuery.AddField("S2");
    hnwExtQuery.AddField("S3");
    hnwExtQuery.AddField("S4M");
    hnwExtQuery.AddField("S4F");
    hnwExtQuery.AddField("S5M");
    hnwExtQuery.AddField("S5F");

    hnwExtQuery.AddField("S7");
    hnwExtQuery.AddField("Z");
    hnwExtQuery.AddField("OCCM_CNT");
    hnwExtQuery.AddField("S_CNT");
    hnwExtQuery.AddField("Z_CNT");
    hnwExtQuery.AddField("M_CNT");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("A_TAG"));
            hnwExtQuery.AddData(vo.getString("HEAD_NM"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("HSORT_NO"));
            hnwExtQuery.AddData(vo.getString("DSORT_NO"));
            hnwExtQuery.AddData(vo.getString("ENO_IN"));
            hnwExtQuery.AddData(vo.getString("AHIS_IN"));
            hnwExtQuery.AddData(vo.getString("LH1_IN"));
            hnwExtQuery.AddData(vo.getString("ENO_OUT"));
            hnwExtQuery.AddData(vo.getString("AHIS_OUT"));
            hnwExtQuery.AddData(vo.getString("LH1_OUT"));
            hnwExtQuery.AddData(vo.getString("TOT_CNT"));
            hnwExtQuery.AddData(vo.getString("OCCA_CNT"));
            hnwExtQuery.AddData(vo.getString("A2"));
            hnwExtQuery.AddData(vo.getString("A4"));
            hnwExtQuery.AddData(vo.getString("A5"));
            hnwExtQuery.AddData(vo.getString("AB"));
            hnwExtQuery.AddData(vo.getString("C1"));
            hnwExtQuery.AddData(vo.getString("D1"));
            hnwExtQuery.AddData(vo.getString("E1"));
            hnwExtQuery.AddData(vo.getString("S2"));
            hnwExtQuery.AddData(vo.getString("S3"));
            hnwExtQuery.AddData(vo.getString("S4M"));
            hnwExtQuery.AddData(vo.getString("S4F"));
            hnwExtQuery.AddData(vo.getString("S5M"));
            hnwExtQuery.AddData(vo.getString("S5F"));

            hnwExtQuery.AddData(vo.getString("S7"));
            hnwExtQuery.AddData(vo.getString("Z"));
            hnwExtQuery.AddData(vo.getString("OCCM_CNT"));
            hnwExtQuery.AddData(vo.getString("S_CNT"));
            hnwExtQuery.AddData(vo.getString("Z_CNT"));
            hnwExtQuery.AddData(vo.getString("M_CNT"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);

%>
