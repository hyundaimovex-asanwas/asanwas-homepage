<!--
***********************************************************************
* @source      : saga040.jsp
* @description : 급여집계표 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/05/07      김학수        최초작성.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    String pis_ym = request.getParameter("pis_ym");
	String GBN_CD_SHR = request.getParameter("gbn_cd");
	String SAL_GBN_SHR = request.getParameter("sal_gbn");
    String title_val = "급여 총괄표 (" + pis_ym.substring(2,4) + "년 " + pis_ym.substring(5,7) + "월)";

	String PIS_YM_SHR     	= pis_ym.replaceAll("-","");
	String PIS_YY_SHR		= PIS_YM_SHR.substring(0,4);
	String PIS_MM_SHR		= PIS_YM_SHR.substring(4);
	String SAL_GBN_NM = "급여 ";

	if ( SAL_GBN_SHR.equals("1") ) {
		SAL_GBN_NM = "상여 ";
	}

	if ( GBN_CD_SHR.equals("0") ) {
    	title_val = SAL_GBN_NM+"총괄표 (" + pis_ym.substring(2,4) + "년 " + pis_ym.substring(5,7) + "월 - 국내)";
    } else if ( GBN_CD_SHR.equals("1") ) {
    	title_val = SAL_GBN_NM+"총괄표 (" + pis_ym.substring(2,4) + "년 " + pis_ym.substring(5,7) + "월 - 해외)";
    } else {
    	title_val = SAL_GBN_NM+"총괄표 (" + pis_ym.substring(2,4) + "년 " + pis_ym.substring(5,7) + "월 - 전체)";
    }

	System.out.println("년도 [" + PIS_YY_SHR + "]");
	System.out.println("월도 [" + PIS_MM_SHR + "]");
	System.out.println("gbn_cd구분_PV GBN_CD_SHR -----[" + GBN_CD_SHR + "]");
	System.out.println("SAL_GBN_SHR 구분_PV SAL_GBN_SHR -----[" + SAL_GBN_SHR + "]");


	//String param = "[:PIS_YY_SHR]="+PIS_YY_SHR+"[:PIS_MM_SHR]="+PIS_MM_SHR+"[:title_val]="+title_val+"[:GBN_CD_SHR]="+GBN_CD_SHR;
    //System.out.println(param);
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
            <td width="">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_PrintOver.gif',1)">
                    <img src="/images/button/btn_PrintOn.gif"  name="Image6" width="60" height="20" border="0" align="absmiddle"  onclick="goclick('Print');"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_ExcelOver.gif',1)">
                    <img src="/images/button/btn_ExcelOn.gif"  name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="goclick('Excel')"></a>
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
              <param name="hnwsrc"    VALUE="saga040.hnw">
              <param name="initvalue" VALUE="[:PIS_YY_SHR]=<%=PIS_YY_SHR%>[:PIS_MM_SHR]=<%=PIS_MM_SHR%>[:SAL_GBN_SHR]=<%=SAL_GBN_SHR%>[:GBN_CD_SHR]=<%=GBN_CD_SHR%>[:title_val]=<%=title_val%>">
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