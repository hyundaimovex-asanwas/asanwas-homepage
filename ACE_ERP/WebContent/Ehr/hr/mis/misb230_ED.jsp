<!--
***********************************************************************
* @source      : misb230_ED.jsp
* @description : 인력운용현황 조회PAGE
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

	sql = XmlSqlUtils.getSQL("mis", "MISB230_SHR");
    
  	Object[] bind = null;
  	bind = new Object[] {
		   str_ymd,
		   str_ymd,
		   str_ymd,
		   end_ymd,
		   str_ymd,
		   end_ymd,
		   str_ymd,
		   end_ymd
  	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();
    
	hnwExtQuery.AddField("JOB_NM");
	hnwExtQuery.AddField("MF_TAG");
    hnwExtQuery.AddField("GBN2_TAG");
	hnwExtQuery.AddField("R_CNT");
	hnwExtQuery.AddField("A_CNT");
    hnwExtQuery.AddField("B_CNT");
	hnwExtQuery.AddField("C_CNT");
    hnwExtQuery.AddField("D_CNT");
	hnwExtQuery.AddField("E_CNT");
    hnwExtQuery.AddField("O_CNT");
	hnwExtQuery.AddField("REM_CNT");
    hnwExtQuery.AddField("NW_I_CNT");
	hnwExtQuery.AddField("CET_CNT");
    hnwExtQuery.AddField("I_CNT");
    hnwExtQuery.AddField("BIGO");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("MF_TAG"));
            hnwExtQuery.AddData(vo.getString("GBN2_TAG"));
            hnwExtQuery.AddData(vo.getString("R_CNT"));
            hnwExtQuery.AddData(vo.getString("A_CNT"));
            hnwExtQuery.AddData(vo.getString("B_CNT"));
            hnwExtQuery.AddData(vo.getString("C_CNT"));
            hnwExtQuery.AddData(vo.getString("D_CNT"));
            hnwExtQuery.AddData(vo.getString("E_CNT"));
            hnwExtQuery.AddData(vo.getString("O_CNT"));
            hnwExtQuery.AddData(vo.getString("REM_CNT"));
            hnwExtQuery.AddData(vo.getString("NW_I_CNT"));
            hnwExtQuery.AddData(vo.getString("CET_CNT"));
            hnwExtQuery.AddData(vo.getString("I_CNT"));
            hnwExtQuery.AddData(vo.getString("BIGO"));

            hnwExtQuery.SendData(response);
        }
    }
            hnwExtQuery.EndData(response);

%>
