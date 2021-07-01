<!--
***********************************************************************
* @source      : insc010_PV.jsp
* @description : 최근5년간산재발생현황
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/15  방석호        최초작성.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@ include file="/common/sessionCheck.jsp" %>
<%
String APY_YMD_SHR  = request.getParameter("APY_YMD_SHR").replaceAll("-","");
String ENO_NO_SHR = request.getParameter("ENO_NO_SHR");
String DATE_TERM  = request.getParameter("DATE_TERM");
String OCC_NM_SHR = request.getParameter("OCC_NM_SHR");

String PAST_DAY1 = request.getParameter("PAST_DAY1");
String PAST_DAY2 = request.getParameter("PAST_DAY2");
String PAST_DAY3 = request.getParameter("PAST_DAY3");
String PAST_DAY4 = request.getParameter("PAST_DAY4");

String ETC_AMT11 = request.getParameter("ETC_AMT11");
String ETC_AMT12 = request.getParameter("ETC_AMT12");
String ETC_AMT13 = request.getParameter("ETC_AMT13");
String ETC_AMT14 = request.getParameter("ETC_AMT14");
String ETC_ROWSUM1 = request.getParameter("ETC_ROWSUM1");

String ETC_AMT21 = request.getParameter("ETC_AMT21");
String ETC_AMT22 = request.getParameter("ETC_AMT22");
String ETC_AMT23 = request.getParameter("ETC_AMT23");
String ETC_AMT24 = request.getParameter("ETC_AMT24");
String ETC_ROWSUM2 = request.getParameter("ETC_ROWSUM2");

String ETC_AMT31 = request.getParameter("ETC_AMT31");
String ETC_AMT32 = request.getParameter("ETC_AMT32");
String ETC_AMT33 = request.getParameter("ETC_AMT33");
String ETC_AMT34 = request.getParameter("ETC_AMT34");
String ETC_ROWSUM3 = request.getParameter("ETC_ROWSUM3");

String ETC_AMT41 = request.getParameter("ETC_AMT41");
String ETC_AMT42 = request.getParameter("ETC_AMT42");
String ETC_AMT43 = request.getParameter("ETC_AMT43");
String ETC_AMT44 = request.getParameter("ETC_AMT44");
String ETC_ROWSUM4 = request.getParameter("ETC_ROWSUM4");

String ETC_COLSUM1 = request.getParameter("ETC_COLSUM1");
String ETC_COLSUM2 = request.getParameter("ETC_COLSUM2");
String ETC_COLSUM3 = request.getParameter("ETC_COLSUM3");
String ETC_COLSUM4 = request.getParameter("ETC_COLSUM4");
String ETC_TOTSUM = request.getParameter("ETC_TOTSUM");

String SUB_COLSUM1 = request.getParameter("SUB_COLSUM1");
String SUB_COLSUM2 = request.getParameter("SUB_COLSUM2");
String SUB_COLSUM3 = request.getParameter("SUB_COLSUM3");
String SUB_COLSUM4 = request.getParameter("SUB_COLSUM4");
String SUB_TOTSUM = request.getParameter("SUB_TOTSUM");

String TOTAL = request.getParameter("TOTAL");

String HNW = "";

if (OCC_NM_SHR.equals("사무직"))
	HNW = "insc010_A.hnw";
else
	HNW = "insc010_M.hnw";


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

	if( !document.form1.aaa.RunButton(x) ) {
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
<!--
            <td width="">

				<input type="button" name="btnREG_nxt_SHR" value="<<" onclick="goclick('firstPage');" style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
                <input type="button" name="btnREG_nxt_SHR" value="<"  onclick="goclick('prePage');"   style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">

                <input type="button" name="btnREG_nxt_SHR" value=">"  onclick="goclick('nextPage');"  style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
                <input type="button" name="btnREG_nxt_SHR" value=">>" onclick="goclick('lastPage');"  style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'"></td>
                -->
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
<comment id="__NSID__">
              <object id="aaa" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="800" height="400" codebase="<%=hnwcodebase%>">
              <param name="hnwsrc"    VALUE="<%=HNW%>">
              <param name="initvalue" VALUE="[:ENO_NO_SHR]=<%=ENO_NO_SHR%>[:APY_YMD_SHR]=<%=APY_YMD_SHR%>[:DATE_TERM]=<%=DATE_TERM%>[:PAST_DAY1]=<%=PAST_DAY1%>[:PAST_DAY2]=<%=PAST_DAY2%>[:PAST_DAY3]=<%=PAST_DAY3%>[:PAST_DAY4]=<%=PAST_DAY4%>[:ETC_AMT11]=<%=ETC_AMT11%>[:ETC_AMT12]=<%=ETC_AMT12%>[:ETC_AMT13]=<%=ETC_AMT13%>[:ETC_AMT14]=<%=ETC_AMT14%>[:ETC_ROWSUM1]=<%=ETC_ROWSUM1%>[:ETC_AMT21]=<%=ETC_AMT21%>[:ETC_AMT22]=<%=ETC_AMT22%>[:ETC_AMT23]=<%=ETC_AMT23%>[:ETC_AMT24]=<%=ETC_AMT24%>[:ETC_ROWSUM2]=<%=ETC_ROWSUM2%>[:ETC_AMT31]=<%=ETC_AMT31%>[:ETC_AMT32]=<%=ETC_AMT32%>[:ETC_AMT33]=<%=ETC_AMT33%>[:ETC_AMT34]=<%=ETC_AMT34%>[:ETC_ROWSUM3]=<%=ETC_ROWSUM3%>[:ETC_AMT41]=<%=ETC_AMT41%>[:ETC_AMT42]=<%=ETC_AMT42%>[:ETC_AMT43]=<%=ETC_AMT43%>[:ETC_AMT44]=<%=ETC_AMT44%>[:ETC_ROWSUM4]=<%=ETC_ROWSUM4%>[:ETC_COLSUM1]=<%=ETC_COLSUM1%>[:ETC_COLSUM2]=<%=ETC_COLSUM2%>[:ETC_COLSUM3]=<%=ETC_COLSUM3%>[:ETC_COLSUM4]=<%=ETC_COLSUM4%>[:ETC_TOTSUM]=<%=ETC_TOTSUM%>[:SUB_COLSUM1]=<%=SUB_COLSUM1%>[:SUB_COLSUM2]=<%=SUB_COLSUM2%>[:SUB_COLSUM3]=<%=SUB_COLSUM3%>[:SUB_COLSUM4]=<%=SUB_COLSUM4%>[:SUB_TOTSUM]=<%=SUB_TOTSUM%>[:TOTAL]=<%=TOTAL%>">
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