	<!--*************************************************************************
	* @source      : scha011.jsp												*
	* @description : ���ڱ������ݾ׾ȳ�										    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/07/09            ����ȣ          	        �����ۼ�									    *
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>���ڱݽ�û��(scha011)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>
</head>

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto>

	<!-- form ���� -->
	<form name="form1" id="form1">

	<!-- Ÿ��Ʋ �� ���̺� ���� -->
	<table width="500" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���ڱ������ݾ׾ȳ�</td>
					<td align="right" class="navigator">HOME/�����Ļ�/���ڱ�����/<font color="#000000">���ڱ������ݾ׾ȳ�</font></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- Ÿ��Ʋ �� ���̺� �� -->

	<!-- ��ư ���̺� ���� -->
	<table width="500" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" align="right">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="window.close()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->


	<!-- ���� �Է� ���̺� ���� -->
	<table width="500" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<tr>
			<td align="center" class="creamBold" width="130" colspan="2"></td>
			<td align="center" class="creamBold" width="90">���б�</td>
			<td align="center" class="creamBold" width="90">������</td>
			<td align="center" class="creamBold" width="90">�⼺ȸ��</td>
			<td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
		</tr>
        <tr>
            <td align="center" class="creamBold" colspan="2">���б� 1,2,3�г�</td>
            <td align="right" class="padding2423">0</td>
            <td align="right" class="padding2423">0</td>
            <td align="right" class="padding2423">62,400</td>
            <td align="right" class="padding2423">62,400</td>
        </tr>
        <tr>
            <td align="center" class="creamBold" rowspan="2">����б�</td>
            <td align="center" class="creamBold">1�г�</td>
            <td align="right" class="padding2423">14,100</td>
            <td align="right" class="padding2423">362,700</td>
            <td align="right" class="padding2423">84,000</td>
            <td align="right" class="padding2423">460,800</td>
        </tr>
        <tr>
            <td align="center" class="creamBold">2,3�г�</td>
            <td align="right" class="padding2423">0</td>
            <td align="right" class="padding2423">362,700</td>
            <td align="right" class="padding2423">84,000</td>
            <td align="right" class="padding2423">446,700</td>
        </tr>
        <tr>
            <td align="center" class="creamBold" rowspan="4">���б�</td>
            <td align="center" class="creamBold">1�г�</td>
            <td align="right" class="padding2423">169,000</td>
            <td align="right" class="padding2423">370,000</td>
            <td align="right" class="padding2423">2,241,000</td>
            <td align="right" class="padding2423">2,780,000</td>
        </tr>
        <tr>
            <td align="center" class="creamBold">2�г�</td>
            <td align="right" class="padding2423">0</td>
            <td align="right" class="padding2423">370,000</td>
            <td align="right" class="padding2423">2,241,000</td>
            <td align="right" class="padding2423">2,611,000</td>
        </tr>
        <tr>
            <td align="center" class="creamBold">3�г�</td>
            <td align="right" class="padding2423">0</td>
            <td align="right" class="padding2423">370,000</td>
            <td align="right" class="padding2423">2,167,000</td>
            <td align="right" class="padding2423">2,537,000</td>
        </tr>
        <tr>
            <td align="center" class="creamBold">4�г�</td>
            <td align="right" class="padding2423">0</td>
            <td align="right" class="padding2423">370,000</td>
            <td align="right" class="padding2423">2,009,000</td>
            <td align="right" class="padding2423">2,379,000</td>
        </tr>
		</table>
		</td>
	</tr>
	</table>
	<!-- ���� �Է� ���̺� �� -->

	</form>
	<!-- form �� -->

</body>
</html>