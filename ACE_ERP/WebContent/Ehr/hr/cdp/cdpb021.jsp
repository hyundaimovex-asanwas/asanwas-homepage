<!--
*****************************************************
* @source       : cdpb020.jsp
* @description : HRMS PAGE :: 직책기술서
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/03/21      김학수        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<% String title = request.getParameter("TITLE"); %>
<% String resp_cd = request.getParameter("RESP_CD"); %>

<!-- 페이지 초기화 시작 -->
<script>
	//Potential의 기능을 사용하기 위해서는 반드시 페이지의 상단 부분에 정의가 되어져 있어야 한다.
	//var frame; try {frame = window.external.GetFrame(window);}catch(e){alert(window.name);alert("frame 초기화 실패");}
</script>
<!-- 페이지 초기화 끝 -->

<html>
<head>
<title><%=title%>(cdpb021)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<iframe name="cdpb030" width="870" height="700" src="/hr/cdp/cdpb030.jsp?RESP_CD=<%=resp_cd %>&TITLE=<%=title %>" scrolling="No" noresize frameborder="0" marginwidth="0">