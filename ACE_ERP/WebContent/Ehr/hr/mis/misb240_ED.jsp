<!--
***********************************************************************
* @source      : misb240_ED.jsp
* @description : 직위별 입퇴사자현황 조회PAGE
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

    sql = XmlSqlUtils.getSQL("mis", "MISB240_SHR");
    
      Object[] bind = null;
      bind = new Object[] {
           str_ym, end_ym,
		   str_ym, end_ym
      };

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    
    hnwExtQuery.AddField("JOB_NM");
    hnwExtQuery.AddField("I_CNT");
    hnwExtQuery.AddField("I110");
    hnwExtQuery.AddField("I120");
    hnwExtQuery.AddField("I130");
    hnwExtQuery.AddField("I140");
    hnwExtQuery.AddField("O_CNT");
    hnwExtQuery.AddField("O110");
    hnwExtQuery.AddField("O120");
    hnwExtQuery.AddField("O130");
    hnwExtQuery.AddField("O140");
    hnwExtQuery.AddField("BIGO");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("I_CNT"));
            hnwExtQuery.AddData(vo.getString("I110"));
            hnwExtQuery.AddData(vo.getString("I120"));
            hnwExtQuery.AddData(vo.getString("I130"));
            hnwExtQuery.AddData(vo.getString("I140"));
            hnwExtQuery.AddData(vo.getString("O_CNT"));
            hnwExtQuery.AddData(vo.getString("O110"));
            hnwExtQuery.AddData(vo.getString("O120"));
            hnwExtQuery.AddData(vo.getString("O130"));
            hnwExtQuery.AddData(vo.getString("O140"));
            hnwExtQuery.AddData(vo.getString("BIGO"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);

%>
