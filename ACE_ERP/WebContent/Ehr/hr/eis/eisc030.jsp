<!--
*****************************************************
* @source       : eisc030.jsp
* @description : 사업부별직위별학력현황 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/04/06      이승욱        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
//************************************************************** ezgen
String a1 = "";
String b1 = "";
//************************************************************** ezgen
%>



<html>
<head>
<title>사업부별/직위별학력현황(eisc030)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>
<SCRIPT ID=clientHnwActivEvent LANGUAGE=javascript FOR="rptObject" EVENT="FireEvent(nParam1,nParam2,strParam)">
<!-- //EZgen에 FireEvent 버튼 실행시 발생됨 -->
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
</SCRIPT>

<script language="javascript">

   function fnc_OnLoadProcess() {

            frame = window.external.GetFrame(window);

            if (frame.FrameID == "heqa040") {
               document.getElementById("title1").innerText = "사업본부학력현황"
               document.getElementById("title2").innerText = "사업본부학력현황"
               document.getElementById("dir").innerText = "HOME/경영정보/사업본부정보/"
            }
            else {document.getElementById("title1").innerText = "사업부별/직위별학력현황"
                  document.getElementById("title2").innerText = "사업부별/직위별학력현황"
                  document.getElementById("dir").innerText = "HOME/인원현황/"
            }
   }

</script>

</head>
<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll="auto" onload="fnc_OnLoadProcess();">
	<!-- form 시작 -->
	<form name="form1">

	<!-- 타이틀 바 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle"><span id="title1"></span></td>
					<td align="right" class="navigator"><span id="dir"></span><font color="#000000"><span id="title2"></span></font></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- 타이틀 바 테이블 끝 -->

        <comment id="__NSID__">
              <object id="rptObject" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="800" height="400" codebase="<%=hnwcodebase%>">
              <param name="hnwsrc"    VALUE="eisc030.hnw">
              <param name="initvalue" VALUE="">
              <param name="hidewnd"   VALUE="N">
              <param name="initdns"   VALUE="[LocationDNS]=<%=LocationDNS%>">
              </object>
        </comment>
		<script> __ShowEmbedObject(__NSID__); </script>
	</form>


</body>
</html>
