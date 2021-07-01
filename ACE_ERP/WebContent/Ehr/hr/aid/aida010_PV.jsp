<!--
***********************************************************************
* @source      : scha070_PV.jsp
* @description : 학자금 지급 현황
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/13      방석호        최초작성.
* 2007/05/08      김학수
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@ include file="/common/sessionCheck.jsp" %>
<%



String REQ_NO  = request.getParameter("REQ_NO");
String ENO_NO  = request.getParameter("ENO_NO");



/*
String SORT_GBN = request.getParameter("SORTGBN");
String STR_YM   = request.getParameter("STR_YM");
String END_YM   = request.getParameter("END_YM");
String OCC_CD   = request.getParameter("OCC_CD");
String TODAY_VAL = request.getParameter("TODAY_VAL");
String WORK_NO1 = request.getParameter("WORK_NO1");
String HLP1_AMT = request.getParameter("HLP1_AMT");
String HLP2_AMT = request.getParameter("HLP2_AMT");

String AID_YMD = request.getParameter("AID_YMD");
String HIR_YMD = request.getParameter("HIR_YMD");
String DPT_NM  = request.getParameter("DPT_NM");
String JOB_NM  = request.getParameter("JOB_NM");
String ENO_CD  = request.getParameter("ENO_CD");
String ENO_NM  = request.getParameter("ENO_NM");
String AID_CD  = request.getParameter("AID_CD");
String AID_NM  = request.getParameter("AID_NM");
String LSE_YY  = request.getParameter("LSE_YY");
String LSE_MM  = request.getParameter("LSE_MM");
String ABA_CD  = request.getParameter("ABA_CD");
String ACC_NO  = request.getParameter("ACC_NO");
String REC_NM  = request.getParameter("REC_NM");


String param = "";
String param1 = "";
String param2 = "";
String param3 = "";

param1 = "[:REQ_NO]=" + REQ_NO + "[:AID_YMD]=" + AID_YMD + "[:HIR_YMD]=" + HIR_YMD + "[:DPT_NM]=" + DPT_NM + "[:JOB_NM]=" + JOB_NM + "[:ENO_CD]=" + ENO_CD + "[:ENO_NM]=" + ENO_NM;
param2 = "[:AID_CD]=" + AID_CD + "[:AID_NM]=" + AID_NM + "[:LSE_YY]=" + LSE_YY + "[:LSE_MM]=" + LSE_MM + "[:ABA_CD]=" + ABA_CD + "[:ACC_NO]=" + ACC_NO + "[:REC_NM]=" + REC_NM;
param3 = "[:REQ_YMD_STDT_SHR]=" + REQ_YMD_STDT_SHR + "[:REQ_YMD_ENDT_SHR]=" + REQ_YMD_ENDT_SHR + "[:WORK_NO1]=" + WORK_NO1 + "[:HLP1_AMT]=" + HLP1_AMT + "[:HLP2_AMT]=" + HLP2_AMT + "[:TODAY_VAL]=" + TODAY_VAL;
param = param1 + param2 + param3;
*/

String param  = "[:REQ_NO]=" + REQ_NO + "[:ENO_CD]=" + ENO_NO;

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
    <td bgcolor="#EAEAEA" valign="middle" align="left">
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
              <param name="hnwsrc"    VALUE="aida010.hnw">
              <param name="initvalue" VALUE="<%=param%>">
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