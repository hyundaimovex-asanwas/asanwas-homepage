<!--
***********************************************************************
* @source      : misc250_ED.jsp
* @description : 일반관리비(급상여)인상내역 조회PAGE
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
    String cur_yy   = request.getParameter("CUR_YY");
    String pln_yy   = request.getParameter("PLN_YY");

    String sql = null;

    sql = XmlSqlUtils.getSQL("mis", "MISC250_SHR_02");

      Object[] bind = null;
      bind = new Object[] {
           pln_yy, pln_yy, cur_yy,
		   pln_yy, pln_yy, pln_yy,
		   pln_yy, pln_yy, pln_yy,
		   pln_yy, pln_yy, pln_yy,
		   pln_yy, pln_yy, pln_yy,
		   pln_yy, pln_yy, pln_yy
      };

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("HEAD_NM");
    hnwExtQuery.AddField("PAY_AMT");                                                                           
    hnwExtQuery.AddField("PAY_AMT2");                                                                          
    hnwExtQuery.AddField("PAY_AMT3");                                                                          
    hnwExtQuery.AddField("PAY_AMT4");                                                                          
    hnwExtQuery.AddField("NPAY_AMT");                                                                          
    hnwExtQuery.AddField("SUM_PAY");
    hnwExtQuery.AddField("BONUS_AMT");
    hnwExtQuery.AddField("BONUS_AMT2");
    hnwExtQuery.AddField("BONUS_AMT3");
    hnwExtQuery.AddField("BONUS_AMT4");
    hnwExtQuery.AddField("NBONUS_AMT");
    hnwExtQuery.AddField("SUM_BONUS");
    hnwExtQuery.AddField("HOL_AMT");                                                                           
    hnwExtQuery.AddField("SUM_AMT");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("HEAD_NM"));
            hnwExtQuery.AddData(vo.getString("PAY_AMT"));
            hnwExtQuery.AddData(vo.getString("PAY_AMT2"));
            hnwExtQuery.AddData(vo.getString("PAY_AMT3"));
            hnwExtQuery.AddData(vo.getString("PAY_AMT4"));
            hnwExtQuery.AddData(vo.getString("NPAY_AMT"));
            hnwExtQuery.AddData(vo.getString("SUM_PAY"));
            hnwExtQuery.AddData(vo.getString("BONUS_AMT"));
            hnwExtQuery.AddData(vo.getString("BONUS_AMT2"));
            hnwExtQuery.AddData(vo.getString("BONUS_AMT3"));
            hnwExtQuery.AddData(vo.getString("BONUS_AMT4"));
            hnwExtQuery.AddData(vo.getString("NBONUS_AMT"));
            hnwExtQuery.AddData(vo.getString("SUM_BONUS"));
            hnwExtQuery.AddData(vo.getString("HOL_AMT"));
            hnwExtQuery.AddData(vo.getString("SUM_AMT"));


            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);

%>
