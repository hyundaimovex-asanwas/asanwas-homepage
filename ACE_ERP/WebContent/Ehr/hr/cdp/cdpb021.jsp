<!--
*****************************************************
* @source       : cdpb020.jsp
* @description : HRMS PAGE :: ��å�����
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/03/21      ���м�        �����ۼ�.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<% String title = request.getParameter("TITLE"); %>
<% String resp_cd = request.getParameter("RESP_CD"); %>

<!-- ������ �ʱ�ȭ ���� -->
<script>
	//Potential�� ����� ����ϱ� ���ؼ��� �ݵ�� �������� ��� �κп� ���ǰ� �Ǿ��� �־�� �Ѵ�.
	//var frame; try {frame = window.external.GetFrame(window);}catch(e){alert(window.name);alert("frame �ʱ�ȭ ����");}
</script>
<!-- ������ �ʱ�ȭ �� -->

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