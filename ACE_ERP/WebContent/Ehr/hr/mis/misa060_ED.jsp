<!--
***********************************************************************
* @source      : misa060_ED.jsp
* @description : 입사지원현황 PAGE
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
    String reg_yy    = request.getParameter("REGYY");
    String reg_ch    = request.getParameter("REGCH");
    String gbn_cd    = request.getParameter("GBN_CD");

    String sql = null;
    StringBuffer sb1 = new StringBuffer();
    StringBuffer sb2 = new StringBuffer();

    if (gbn_cd.equals("SCNAME")){
	    sql = XmlSqlUtils.getSQL("mis", "MISA060_SHR_01");
	} else if (gbn_cd.equals("SIKUKN")){
	    sql = XmlSqlUtils.getSQL("mis", "MISA060_SHR_02");
	} else if (gbn_cd.equals("SEXGU")){
	    sql = XmlSqlUtils.getSQL("mis", "MISA060_SHR_03");
	}
    
    Object[] bind = null;
  	bind = new Object[] {
		  reg_yy,
		  reg_ch
  	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("GUBUN");
    hnwExtQuery.AddField("INWON");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("GUBUN"));
            hnwExtQuery.AddData(vo.getString("INWON"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);


%>                           
