<!--
*****************************************************
* @source       : bottom.jsp
* @description : BOTTOM PAGE :: bottom
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/08/29      ������        �����ۼ�.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>

<%@ include file="/common/sessionCheck.jsp" %>

<!-- Potential�� ����� ����ϱ� ���ؼ��� �ݵ�� �������� ��� �κп� ���ǰ� �Ǿ��� �־�� �Ѵ�. -->
<script>var frame; try {frame = window.external.GetFrame(window);}catch(e){alert(window.name);alert("frame �ʱ�ȭ ����");}</script>

<html>
<head>
<title>bottom</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>

<script language="JavaScript">

    var curFrame = frame.opener.frame.Provider("body");

</script>

</head>

<!--
**************************************************************
* BODY START
**************************************************************
-->
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="8" align="center" valign="middle" background="/images/common/copyrightBg.gif">
        </td>
    </tr>
    <tr>
        <td height="16" align="center" valign="middle" background="/images/common/copyright_huni.gif" style="background-repeat:no-repeat; background-position:50% 50%;" >
        </td>
    </tr>
</table>

</body>
</html>
