<!--
***********************************************************************
* @source      : idta010_ED.jsp
* @description : 증명서발급처리
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/02      방석호        최초작성.
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

    String ENO_NO   = request.getParameter("ENO_NO");
	String CEF_SEC  = request.getParameter("CEF_SEC");
	String REQ_NO     = request.getParameter("REQ_NO");

    String sql = null;
    sql = XmlSqlUtils.getSQL("idt", "IDTA010_CAR_PRT1");
  	System.out.println(sql);

  	Object[] bind = null;
  	bind = new Object[] {
  			ENO_NO,
  			CEF_SEC,
  			REQ_NO
  	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("발급번호");
    hnwExtQuery.AddField("지점");
    hnwExtQuery.AddField("직위");
    hnwExtQuery.AddField("사번");
    hnwExtQuery.AddField("이름");

    hnwExtQuery.AddField("증명서명");
    hnwExtQuery.AddField("용도");
    hnwExtQuery.AddField("인쇄횟수");
    hnwExtQuery.AddField("출력일");
    hnwExtQuery.AddField("입사일");

    hnwExtQuery.AddField("퇴사일");
    hnwExtQuery.AddField("주소");
    hnwExtQuery.AddField("본적");
    hnwExtQuery.AddField("주민등록번호");
    hnwExtQuery.AddField("근속년월");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("CEF_NO"));
            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("JOB_NM"));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));

            hnwExtQuery.AddData(vo.getString("CEF_SEC"));
            hnwExtQuery.AddData(vo.getString("CEF_RSN"));
            hnwExtQuery.AddData(vo.getString("CEF_CNT"));
            hnwExtQuery.AddData(vo.getString("SPL_YMD"));
            hnwExtQuery.AddData(vo.getString("HIR_YMD"));

            hnwExtQuery.AddData(vo.getString("RET_YMD"));
            hnwExtQuery.AddData(vo.getString("ADDRESS1"));
            hnwExtQuery.AddData(vo.getString("ADDRESS2"));
            hnwExtQuery.AddData(vo.getString("CET_NO"));
            hnwExtQuery.AddData(vo.getString("LSE_YYMM"));


            hnwExtQuery.SendData(response);
        }
    }

    hnwExtQuery.EndData(response);
%>