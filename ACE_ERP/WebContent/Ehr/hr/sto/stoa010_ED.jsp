<!--
***********************************************************************
* @source      : stoa010_ED.jsp
* @description : 주주리스트 출력
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
	String BASIC_YMD_SHR     	= request.getParameter("BASIC_YMD_SHR");
	String cmbEMP_GBN_SHR   = request.getParameter("cmbEMP_GBN_SHR");

	/** 외부 XML에서 SQL을 읽어 온다 **/
	String sql = XmlSqlUtils.getSQL("sto", "STOA010_SHR");


	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	Object[] bind = new Object[] {
			BASIC_YMD_SHR,
			BASIC_YMD_SHR,
			cmbEMP_GBN_SHR,
	};

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("기준일자");
     hnwExtQuery.AddField("주주번호");
    hnwExtQuery.AddField("이름");
    hnwExtQuery.AddField("재직구분");
    hnwExtQuery.AddField("입사일");

    hnwExtQuery.AddField("퇴사일");
    hnwExtQuery.AddField("보통주");
    hnwExtQuery.AddField("우선주");
    hnwExtQuery.AddField("신주1");
    hnwExtQuery.AddField("신주2");

    hnwExtQuery.AddField("우편번호");
    hnwExtQuery.AddField("주소");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);


            hnwExtQuery.AddData(vo.getString("BASIC_YMD"));
            hnwExtQuery.AddData(vo.getString("SH_NO"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("EMP_GB"));
            hnwExtQuery.AddData(vo.getString("HIR_YMD"));

            hnwExtQuery.AddData(vo.getString("RET_YMD"));
            hnwExtQuery.AddData(vo.getString("COM_STK"));
            hnwExtQuery.AddData(vo.getString("PRE_STK"));
            hnwExtQuery.AddData(vo.getString("NEW_STK1"));
            hnwExtQuery.AddData(vo.getString("NEW_STK2"));

            hnwExtQuery.AddData(vo.getString("POST_NO"));
            hnwExtQuery.AddData(vo.getString("ADDRESS"));


            hnwExtQuery.SendData(response);
        }
    }
%>