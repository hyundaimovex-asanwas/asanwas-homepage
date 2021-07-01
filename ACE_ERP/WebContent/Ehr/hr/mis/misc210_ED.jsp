<!--
***********************************************************************
* @source      : misc210_ED.jsp
* @description : 직급별 인원충원 현황 조회PAGE
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
    String cur_yy   = request.getParameter("CUR_YY");
    String pln_yy   = request.getParameter("PLN_YY");

    String sql = null;
	StringBuffer sb1 = new StringBuffer();

    sql = XmlSqlUtils.getSQL("mis", "MISC210_SHR");

      Object[] bind = null;
      bind = new Object[] {
           pln_yy, pln_yy, cur_yy,
           pln_yy, pln_yy
      };

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

     
    hnwExtQuery.AddField("GUBUN");
    hnwExtQuery.AddField("PIS_YY");
    hnwExtQuery.AddField("PIS_MN");
    hnwExtQuery.AddField("E_CNT");
    hnwExtQuery.AddField("BJ");
    hnwExtQuery.AddField("BD");
    hnwExtQuery.AddField("CJ");
    hnwExtQuery.AddField("GJ");
    hnwExtQuery.AddField("DR");
    hnwExtQuery.AddField("S4");
    hnwExtQuery.AddField("S5M");
    hnwExtQuery.AddField("S5W");
    hnwExtQuery.AddField("CTM");
    hnwExtQuery.AddField("CTW");
    hnwExtQuery.AddField("SAL");
    hnwExtQuery.AddField("ETC");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            
            hnwExtQuery.AddData(vo.getString("GUBUN"));
            hnwExtQuery.AddData(vo.getString("PIS_YY"));
            hnwExtQuery.AddData(vo.getString("PIS_MN"));
            hnwExtQuery.AddData(vo.getString("E_CNT"));
            hnwExtQuery.AddData(vo.getString("BJ"));
            hnwExtQuery.AddData(vo.getString("BD"));
            hnwExtQuery.AddData(vo.getString("CJ"));
            hnwExtQuery.AddData(vo.getString("GJ"));
            hnwExtQuery.AddData(vo.getString("DR"));
            hnwExtQuery.AddData(vo.getString("S4"));
            hnwExtQuery.AddData(vo.getString("S5M"));
            hnwExtQuery.AddData(vo.getString("S5W"));
            hnwExtQuery.AddData(vo.getString("CTM"));
            hnwExtQuery.AddData(vo.getString("CTW"));
            hnwExtQuery.AddData(vo.getString("SAL"));
            hnwExtQuery.AddData(vo.getString("ETC"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);

%>
