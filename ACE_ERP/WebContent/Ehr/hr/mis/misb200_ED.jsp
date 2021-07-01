<!--
***********************************************************************
* @source      : misb200_ED.jsp
* @description : 직위별인원증감현황 조회PAGE
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
    String str_ymd   = request.getParameter("STR_YMD");
    String bfy_ymd   = request.getParameter("BFY_YMD");
    String fsy_ymd   = request.getParameter("FSY_YMD");
    String pln_yy    = request.getParameter("PLN_YY");

    String sql = null;
    StringBuffer sb1 = new StringBuffer();

    sql = XmlSqlUtils.getSQL("mis", "MISB200_SHR");
    
      Object[] bind = null;
      bind = new Object[] {
           str_ymd, str_ymd,
           bfy_ymd, bfy_ymd,
           fsy_ymd, fsy_ymd,
           pln_yy,  pln_yy
      };

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    
    hnwExtQuery.AddField("GRP_GBN");
    hnwExtQuery.AddField("GUBUN");
    hnwExtQuery.AddField("TOT_CNT");
    hnwExtQuery.AddField("BYR_CNT");
    hnwExtQuery.AddField("FYR_CNT");
    hnwExtQuery.AddField("PLN_CNT");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("GRP_GBN"));
            hnwExtQuery.AddData(vo.getString("GUBUN"));
            hnwExtQuery.AddData(vo.getString("TOT_CNT"));
            hnwExtQuery.AddData(vo.getString("BYR_CNT"));
            hnwExtQuery.AddData(vo.getString("FYR_CNT"));
            hnwExtQuery.AddData(vo.getString("PLN_CNT"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);

%>
