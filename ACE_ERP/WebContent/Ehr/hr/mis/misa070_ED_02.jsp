<!--
***********************************************************************
* @source      : misa070_ED_02.jsp
* @description : 파견사원입퇴사자현황 부서별PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/13      이승욱        최초작성.
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
    String pis_ymd_fr   = request.getParameter("PIS_YMD_FR");
    String pis_ymd_to   = request.getParameter("PIS_YMD_TO");
    String head_cd      = request.getParameter("HEAD_CD");

    String sql = null;
    sql = XmlSqlUtils.getSQL("mis", "MISA070_SHR_02");

  	Object[] bind = null;
  	bind = new Object[] {
		  pis_ymd_fr,
		  pis_ymd_to,
		  pis_ymd_fr,
		  pis_ymd_to,
		  pis_ymd_to,
		  pis_ymd_to,
		  head_cd
  	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    
    hnwExtQuery.AddField("DPT_NM");
	hnwExtQuery.AddField("DPT_CD");
	hnwExtQuery.AddField("TOT_CNT");
	hnwExtQuery.AddField("HIR_CNT");
	hnwExtQuery.AddField("RET_CNT");
    hnwExtQuery.AddField("SORT_NO");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("DPT_CD"));
            hnwExtQuery.AddData(vo.getString("TOT_CNT"));
            hnwExtQuery.AddData(vo.getString("HIR_CNT"));
            hnwExtQuery.AddData(vo.getString("RET_CNT"));
            hnwExtQuery.AddData(vo.getString("SORT_NO"));

            hnwExtQuery.SendData(response);
        }
    }
    		hnwExtQuery.EndData(response);

%>                           
