<!--
***********************************************************************
* @source      : edui010_PV.jsp
* @description : 교육사항
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/25     방석호        최초작성.
* 2007/05/09     김학수        수정.
***********************************************************료***********
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@ include file="/common/sessionCheck.jsp" %>
<%
	String STR_YMD_SHR = request.getParameter("STR_YMD_SHR");
	String END_YMD_SHR = request.getParameter("END_YMD_SHR");

    String OCC_CD_SHR  = request.getParameter("OCC_CD_SHR");

	String GBN_CD      = request.getParameter("GBN_CD");
	String DPT_CD_SHR  = request.getParameter("DPT_CD_SHR");
	String DPT_NM_SHR  = request.getParameter("DPT_NM_SHR");
    String EDU_CD_SHR  = request.getParameter("EDU_CD_SHR");
	String EDU_NM_SHR  = request.getParameter("EDU_NM_SHR");
    String JOB_CD_SHR  = request.getParameter("JOB_CD_SHR");
	String JOB_NM_SHR  = request.getParameter("JOB_NM_SHR");

    String GUBUN_VAL = "";
    String OCC_VAL   = "";
    String EDU_VAL   = "";

    if ( DPT_NM_SHR.equals("") || DPT_NM_SHR == null ) DPT_NM_SHR = "전 체";
    if ( JOB_NM_SHR.equals("") || JOB_NM_SHR == null ) JOB_NM_SHR = "전 체";
    if ( EDU_NM_SHR.equals("") || EDU_NM_SHR == null ) EDU_NM_SHR = "전 체";
    
    if ( GBN_CD.equals("1") ) {
        GUBUN_VAL = "구 분 : 직위별(" + JOB_NM_SHR + ")";
    } else {
        GUBUN_VAL = "구 분 : 소속별(" + DPT_NM_SHR + ")";
    }
    if ( OCC_CD_SHR.equals("0") ) {
        OCC_CD_SHR = "";
        OCC_VAL = "근로구분 : 전체";
    } else if ( OCC_CD_SHR.equals("A") ) {
        OCC_VAL = "근로구분 : 사무직";
    } else if ( OCC_CD_SHR.equals("M") ) {
        OCC_VAL = "근로구분 : 택배직";
    }
    EDU_VAL = "교육과정 : " + EDU_NM_SHR;

    String init_param  = "[:STR_YMD_SHR]=" + STR_YMD_SHR;
           init_param += "[:END_YMD_SHR]=" + END_YMD_SHR;
           init_param += "[:OCC_CD_SHR]="  + OCC_CD_SHR;
           init_param += "[:DPT_CD_SHR]="  + DPT_CD_SHR;
           init_param += "[:DPT_NM_SHR]="  + DPT_NM_SHR;
           init_param += "[:JOB_CD_SHR]="  + JOB_CD_SHR;
           init_param += "[:JOB_NM_SHR]="  + JOB_NM_SHR;
           init_param += "[:EDU_CD_SHR]="  + EDU_CD_SHR;
           init_param += "[:EDU_NM_SHR]="  + EDU_NM_SHR;
           init_param += "[:GUBUN_VAL]="   + GUBUN_VAL;
           init_param += "[:OCC_VAL]="     + OCC_VAL;
           init_param += "[:EDU_VAL]="     + EDU_VAL;
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
              <param name="hnwsrc"    VALUE="edui010.hnw">
              <param name="initvalue" VALUE="<%=init_param%>">
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
