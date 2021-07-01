<!--
***********************************************************************
* @source      : edub010_PV.jsp									  	  *
* @description : 어학성적관리 PAGE 	
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/18      김학수        최초작성.        
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    String PRO_YMD_STDT_SHR = request.getParameter("PRO_YMD_STDT_SHR");
    String PRO_YMD_ENDT_SHR = request.getParameter("PRO_YMD_ENDT_SHR");
    String ENO_NO_SHR       = request.getParameter("ENO_NO_SHR");
    String SBJ_CD_SHR       = request.getParameter("SBJ_CD_SHR");
    String JOB_CD_SHR       = request.getParameter("JOB_CD_SHR");
    String DPT_CD_SHR       = request.getParameter("DPT_CD_SHR");
    String TTL_AVR_SHR      = request.getParameter("TTL_AVR_SHR");
    String CHECK4           = request.getParameter("CHECK4");

    String SORT_GUBUN       = "1";   //정렬 (임시사용)
    String title_val        = "";
    String PRO_YMD_VAL = "";

    if ( PRO_YMD_STDT_SHR.equals(null) || PRO_YMD_STDT_SHR.equals("") ) {
        PRO_YMD_VAL = "기간 - 전체";
    } else {
        PRO_YMD_VAL = PRO_YMD_STDT_SHR.replaceAll("-", "/") + " - " + PRO_YMD_ENDT_SHR.replaceAll("-", "/");
    }
    System.out.println("PRO_YMD_STDT_SHR="+PRO_YMD_STDT_SHR);
    if ( SORT_GUBUN.equals("1") ) {
        title_val = "TOEIC 시험성적(부서별)";
    } else if ( SORT_GUBUN.equals("2") ) {
        title_val = "TOEIC 시험성적(직위별)";
    } else {
        title_val = "TOEIC 시험성적(성적별)";
    }
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
				<input type="button" name="btnREG_nxt_SHR" value="<<" onclick="goclick('firstPage');" style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
                <input type="button" name="btnREG_nxt_SHR" value="<"  onclick="goclick('prePage');"   style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">

                <input type="button" name="btnREG_nxt_SHR" value=">"  onclick="goclick('nextPage');"  style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
                <input type="button" name="btnREG_nxt_SHR" value=">>" onclick="goclick('lastPage');"  style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'"></td>
            <td width="8" align="center"></td>
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
              <param name="hnwsrc"    VALUE="edub010.hnw">
              <param name="initvalue" VALUE="[:PRO_YMD_STDT_SHR]=<%=PRO_YMD_STDT_SHR%>[:PRO_YMD_ENDT_SHR]=<%=PRO_YMD_ENDT_SHR%>[:ENO_NO_SHR]=<%=ENO_NO_SHR%>[:SBJ_CD_SHR]=<%=SBJ_CD_SHR%>[:JOB_CD_SHR]=<%=JOB_CD_SHR%>[:DPT_CD_SHR]=<%=DPT_CD_SHR%>[:TTL_AVR_SHR]=<%=TTL_AVR_SHR%>[:CHECK4]=<%=CHECK4%>[:PRO_YMD_VAL]=<%=PRO_YMD_VAL%>[:title_val]=<%=title_val%>">
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
