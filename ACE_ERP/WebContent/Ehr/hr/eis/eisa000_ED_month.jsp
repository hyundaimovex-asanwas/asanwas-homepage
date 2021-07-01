<!--
***********************************************************************
* @source      : eisa010_ED.jsp
* @description : 년간월별근태현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/03      이승욱        최초작성.
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
	String sql = null;
	sql = XmlSqlUtils.getSQL("eis", "EISA010_SHR_yyyy");

	Object[] bind = null;

	AbstractDAO aaa= new AbstractDAO("default");

	DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

	extquery hnwExtQuery = new extquery();

	hnwExtQuery.AddField("PIS_YY");

	hnwExtQuery.SendField(response);

	if (voList.size() > 0)
	{
	    for (int i=0; i<voList.size(); i++)
	    {
	        DynamicValueObject vo = (DynamicValueObject)voList.get(i);
	        hnwExtQuery.AddData(vo.getString("PIS_YY"));

	        hnwExtQuery.SendData(response);
	    }
	}
			hnwExtQuery.EndData(response);

%>
