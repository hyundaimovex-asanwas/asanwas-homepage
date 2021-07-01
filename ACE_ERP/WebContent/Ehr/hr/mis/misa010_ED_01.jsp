<!--
***********************************************************************
* @source      : misa010_ED_01.jsp
* @description : ���κ� �ο���Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/12      �̽¿�        �����ۼ�.
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
    String gbn_case   = request.getParameter("GBN_CASE");

    String sql = null;
    if (gbn_case.equals("HEAD_CD")){
        sql = XmlSqlUtils.getSQL("mis", "MISA010_SHR_01");
    } else if (gbn_case.equals("GBN2_TAG")){
        sql = XmlSqlUtils.getSQL("mis", "MISA010_SHR_02");
    } else if (gbn_case.equals("DPT_CD")){
        StringBuffer sb1 = new StringBuffer();
        sb1.append("");
        Object[] sqlParam = new Object[] {
			sb1.toString()
		};
        sql = XmlSqlUtils.getSQL("mis", "MISA010_SHR_03");
        sql = SqlUtils.replaceQuery(sql, sqlParam);
    }

  	Object[] bind = null;

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    
	hnwExtQuery.AddField("GBN_NM");
    hnwExtQuery.AddField("GBN_CD");
	hnwExtQuery.AddField("TOT_CNT");
	hnwExtQuery.AddField("SORT_NO");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("GBN_NM"));
            hnwExtQuery.AddData(vo.getString("GBN_CD"));
            hnwExtQuery.AddData(vo.getString("TOT_CNT"));
            hnwExtQuery.AddData(vo.getString("SORT_NO"));

            hnwExtQuery.SendData(response);
        }
    }
    		hnwExtQuery.EndData(response);

%>                           

