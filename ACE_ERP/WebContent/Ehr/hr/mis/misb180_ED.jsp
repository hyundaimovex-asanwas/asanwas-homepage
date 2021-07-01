<!--
***********************************************************************
* @source      : misb180_ED.jsp
* @description : 퇴사자조치내역 조회PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/07      이승욱        최초작성.
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
    String end_ymd   = request.getParameter("END_YMD");

    String sql = null;

	sql = XmlSqlUtils.getSQL("mis", "MISB180_SHR");
    
  	Object[] bind = null;
  	bind = new Object[] {
		   str_ymd,
		   end_ymd
  	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    
    hnwExtQuery.AddField("DPT_NM");
	hnwExtQuery.AddField("JOB_NM");
	hnwExtQuery.AddField("ENO_NM");
	hnwExtQuery.AddField("RET_YMD");
	hnwExtQuery.AddField("CW");
    hnwExtQuery.AddField("PD");
    hnwExtQuery.AddField("JC");
    hnwExtQuery.AddField("JH");
    hnwExtQuery.AddField("JI");
    hnwExtQuery.AddField("BIGO");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("RET_YMD"));
            hnwExtQuery.AddData(vo.getString("CW"));
            hnwExtQuery.AddData(vo.getString("PD"));
            hnwExtQuery.AddData(vo.getString("JC"));
            hnwExtQuery.AddData(vo.getString("JH"));
            hnwExtQuery.AddData(vo.getString("JI"));
            hnwExtQuery.AddData(vo.getString("BIGO"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);

%>
