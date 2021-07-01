<!--
***********************************************************************
* @source      : misc220_ED.jsp
* @description : 충원사유별 인원내역 조회PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/26      이승욱        최초작성.
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
    String cur_yy   = request.getParameter("CUR_YY");
    String pln_yy   = request.getParameter("PLN_YY");

    String sql = null;
	StringBuffer sb1 = new StringBuffer();

    sql = XmlSqlUtils.getSQL("mis", "MISC220_SHR");

      Object[] bind = null;
      bind = new Object[] {
           pln_yy, cur_yy, pln_yy,
           pln_yy, cur_yy, pln_yy
      };

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("LEVY_CD");
    hnwExtQuery.AddField("OCC_CD");
    hnwExtQuery.AddField("DPT_CD");
    hnwExtQuery.AddField("HIR_YY");
    hnwExtQuery.AddField("LEVY_NM");
    hnwExtQuery.AddField("OCC_NM");
    hnwExtQuery.AddField("DPT_NM");
    hnwExtQuery.AddField("DPT_SEQ");
    hnwExtQuery.AddField("JOB_CD");
    hnwExtQuery.AddField("JOB_NM");
    hnwExtQuery.AddField("ENO_CNT");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("LEVY_CD"));
            hnwExtQuery.AddData(vo.getString("OCC_CD"));
            hnwExtQuery.AddData(vo.getString("DPT_CD"));
            hnwExtQuery.AddData(vo.getString("HIR_YY"));
            hnwExtQuery.AddData(vo.getString("LEVY_NM"));
            hnwExtQuery.AddData(vo.getString("OCC_NM"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("DPT_SEQ"));
            hnwExtQuery.AddData(vo.getString("JOB_CD"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_CNT"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);

%>
