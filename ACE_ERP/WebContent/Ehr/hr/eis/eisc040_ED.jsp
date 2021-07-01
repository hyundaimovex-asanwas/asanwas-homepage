<!--
***********************************************************************
* @source      : eisc040_ED.jsp
* @description : 직위/전공/지역/학력별 현황 조회PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/09      이승욱        최초작성.
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
    String pis_ym  = request.getParameter("PIS_YM");
    String cd_case = request.getParameter("CD_CASE");

    String sql = null;
    if (cd_case.equals("JOB")) {
        sql = XmlSqlUtils.getSQL("eis","EISC040_SHR_01");
    } else if (cd_case.equals("MAJ")) {
        sql = XmlSqlUtils.getSQL("eis","EISC040_SHR_02");
    } else if (cd_case.equals("AREA")) {
        sql = XmlSqlUtils.getSQL("eis","EISC040_SHR_03");
    } else if (cd_case.equals("EDGR")) {
        sql = XmlSqlUtils.getSQL("eis","EISC040_SHR_04");
    }

  	Object[] bind = null;
    if (cd_case.equals("MAJ")) {
  	    bind = new Object[] {
		  pis_ym,
		  pis_ym,
		  pis_ym,
		  pis_ym
        };
    } else {
  	    bind = new Object[] {
		  pis_ym,
		  pis_ym
        };
    }

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    
	hnwExtQuery.AddField("H_NAME");
    hnwExtQuery.AddField("TOT_CNT");
	hnwExtQuery.AddField("SORT_NO");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("H_NAME"));
            hnwExtQuery.AddData(vo.getString("TOT_CNT"));
            hnwExtQuery.AddData(vo.getString("SORT_NO"));

            hnwExtQuery.SendData(response);
        }
    }
    		hnwExtQuery.EndData(response);

%>                           

