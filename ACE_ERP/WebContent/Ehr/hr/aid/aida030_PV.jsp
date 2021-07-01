<!--
***********************************************************************
* @source      : scha070_PV.jsp
* @description : 학자금 지급 현황
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/13      방석호        최초작성.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@ include file="/common/sessionCheck.jsp" %>
<%
String SPL_YMD_STDT_SHR = request.getParameter("SPL_YMD_STDT_SHR").replaceAll("-", "");
String SPL_YMD_ENDT_SHR = request.getParameter("SPL_YMD_ENDT_SHR").replaceAll("-", "");
String CEF_SEC_SHR = request.getParameter("CEF_SEC_SHR"); // 조회조건(경,공조)
String OCC_CD_SHR = request.getParameter("OCC_CD_SHR");   // 직종별
String JOB_CD_SHR = request.getParameter("JOB_CD_SHR");   // 직위별
String DPT_CD_SHR = request.getParameter("DPT_CD_SHR");   // 소속별
String AID_CD_SHR = request.getParameter("AID_CD_SHR");   // 신청내용별
String ORDER_TYPE = request.getParameter("ORDER_TYPE");   // 정렬순



%>

<html>
<head>
<title>미리보기</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>
<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>
<!--

/*  화면 종료(닫기)  */
function fnc_Exit() {
    window.close();
}

function goclick(x) {
	if( !document.form1.rptObject.RunButton(x) ) {
        alert("개체가 없습니다.");
	}
}
function winclose() {
    window.close();
}


//-->
</SCRIPT>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="form1">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="25">
<tr>
    <td bgcolor="#75B543" height="3"></td>
</tr><tr>
    <td bgcolor="#EAEAEA" valign="middle" align="right">
        <table border="1" cellspacing="0" cellpadding="0">
        <tr>

            <td width="">
				<!-- input type="button" name="btnREG_nxt_SHR" value="<<" onclick="goclick('firstPage');" style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'" -->
                <!-- input type="button" name="btnREG_nxt_SHR" value="<"  onclick="goclick('prePage');"   style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'" -->

                <!-- input type="button" name="btnREG_nxt_SHR" value=">"  onclick="goclick('nextPage');"  style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'" -->
                <!-- input type="button" name="btnREG_nxt_SHR" value=">>" onclick="goclick('lastPage');"  style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'"></td -->
            <!-- td width="8" align="center"></td -->
            <td width="">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_PrintOver.gif',1)">
                    <img src="/images/button/btn_PrintOn.gif"  name="Image6" width="60" height="20" border="0" align="absmiddle"  onclick="goclick('Print');"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">
                    <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle"  onclick="fnc_Exit()"></a></td>
        </tr>
        </table>
    </td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
<!--여기서부터 코딩입니다//-->
<javascript>

</javascript>
<comment id="__NSID__">
              <object id="rptObject" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="800" height="400" codebase="<%=hnwcodebase%>">
              <param name="hnwsrc"    VALUE="aida030.hnw">
              <param name="initvalue" VALUE="[:SPL_YMD_STDT_SHR]=<%=SPL_YMD_STDT_SHR%>[:SPL_YMD_ENDT_SHR]=<%=SPL_YMD_ENDT_SHR%>[:CEF_SEC_SHR]=<%=CEF_SEC_SHR%>[:OCC_CD_SHR]=<%=OCC_CD_SHR%>[:JOB_CD_SHR]=<%=JOB_CD_SHR%>[:DPT_CD_SHR]=<%=DPT_CD_SHR%>[:AID_CD_SHR]=<%=AID_CD_SHR%>[:ORDER_TYPE]=<%=ORDER_TYPE%>">
              <param name="hidewnd"   VALUE="N">
              <param name="initdns"   VALUE="[LocationDNS]=<%=LocationDNS%>">
              </object>
</comment><script> __ShowEmbedObject(__NSID__); </script>
<!--여기까지 코딩입니다//-->
			</td>
		</tr>
	</table>
</form>
</body>
</html>