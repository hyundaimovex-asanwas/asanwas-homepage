<!--
***********************************************************************
* @source      : taxa130_ED.jsp
* @description : 근로소득원천징수영수증
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/03      방석호        최초작성.
***********************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr"
	import="javax.naming.*,elsoft.extquery.*"%>
<%@page import="com.shift.gef.support.vo.*"%>
<%@page import="com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import="com.shift.gef.support.vo.DynamicValueObject"%>
<%@page import="com.shift.gef.dbms.utility.XmlSqlUtils"%>
<%@page import="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import="com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import="common.util.DateUtil"%>

<%
	String PIS_YYMM = request.getParameter("PIS_YYMM");

	String sql = XmlSqlUtils.getSQL("tax2", "TAXA230_PRT3");

	//param binding 하기
	Object[] bind = new Object[] {
			PIS_YYMM,
			PIS_YYMM
	};

	AbstractDAO aaa = new AbstractDAO("default");
	DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

	extquery hnwExtQuery = new extquery();

	/** 필드값 세팅 **/
	String colStr = "T,A,B,P,NOTIN,SALT_AMT,LUN_AMT";
	String[] values = colStr.split(",");
	for (int x = 0; x < values.length; x++) {
		hnwExtQuery.AddField(values[x]);
	}

	hnwExtQuery.SendField(response);

	if (voList.size() > 0) {
		for (int i = 0; i < voList.size(); i++) {
			DynamicValueObject vo = (DynamicValueObject) voList.get(i);

			for (int x = 0; x < values.length; x++) {
		hnwExtQuery.AddData(vo.getString(values[x]));
			}
			hnwExtQuery.SendData(response);
		}
	} else {
		// hnwExtQuery.AddData("데이터가 존재하지 않습니다.");
		for (int x = 0; x < values.length; x++) {
			hnwExtQuery.AddData("");
		}
		hnwExtQuery.SendData(response);

	}
%>
