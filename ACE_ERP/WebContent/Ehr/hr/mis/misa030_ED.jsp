<!--
***********************************************************************
* @source      : misa030_ED.jsp
* @description : 연도별 인원변동 추이 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/12      이승욱        최초작성.
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
    String pis_yy_fr   = request.getParameter("PIS_YY_FR");

    String sql = null;
    sql = XmlSqlUtils.getSQL("mis", "MISA030_SHR");

  	Object[] bind = null;
  	bind = new Object[] {
		  pis_yy_fr,
		  pis_yy_fr,
		  pis_yy_fr
  	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    
	hnwExtQuery.AddField("YYYY");
    hnwExtQuery.AddField("A_CNT");
	hnwExtQuery.AddField("M_CNT");
	hnwExtQuery.AddField("TOT_CNT");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("YYYY"));
            hnwExtQuery.AddData(vo.getString("A_CNT"));
            hnwExtQuery.AddData(vo.getString("M_CNT"));
            hnwExtQuery.AddData(vo.getString("TOT_CNT"));

            hnwExtQuery.SendData(response);
        }
    }
    		hnwExtQuery.EndData(response);

%>                           

