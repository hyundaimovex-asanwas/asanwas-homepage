<!--
***********************************************************************
* @source      : edui030_PV.jsp
* @description : �����������Ȳ
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/25     �漮ȣ        �����ۼ�.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@ include file="/common/sessionCheck.jsp" %>
<%
	String JPR_YMD_SHR = request.getParameter("JPR_YMD_SHR");

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

    if ( DPT_NM_SHR.equals("") || DPT_NM_SHR == null ) DPT_NM_SHR = "�� ü";
    if ( JOB_NM_SHR.equals("") || JOB_NM_SHR == null ) JOB_NM_SHR = "�� ü";
    if ( EDU_NM_SHR.equals("") || EDU_NM_SHR == null ) EDU_NM_SHR = "�� ü";
    
    if ( GBN_CD.equals("1") ) {
        GUBUN_VAL = "�� �� : ������(" + JOB_NM_SHR + ")";
    } else {
        GUBUN_VAL = "�� �� : �ҼӺ�(" + DPT_NM_SHR + ")";
    }
    if ( OCC_CD_SHR.equals("0") ) {
        OCC_CD_SHR = "";
        OCC_VAL = "�ٷα��� : ��ü";
    } else if ( OCC_CD_SHR.equals("A") ) {
        OCC_VAL = "�ٷα��� : �繫��";
    } else if ( OCC_CD_SHR.equals("M") ) {
        OCC_VAL = "�ٷα��� : �ù���";
    }
    EDU_VAL = "�������� : " + EDU_NM_SHR;
%>

<html>
<head>
<title>�̸�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>
<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>
<!--

/*  ȭ�� ����(�ݱ�)  */
function fnc_Exit() {
    window.close();
}

function goclick(x) {
	if( !document.form1.rptObject.RunButton(x) ) {
        alert("��ü�� �����ϴ�.");
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
<!--���⼭���� �ڵ��Դϴ�//-->
<javascript>

</javascript>
<comment id="__NSID__">
              <object id="rptObject" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="800" height="400" codebase="<%=hnwcodebase%>">
              <param name="hnwsrc"    VALUE="edui030.hnw">
              <param name="initvalue" VALUE="[:JPR_YMD_SHR]=<%=JPR_YMD_SHR%>[:OCC_CD_SHR]=<%=OCC_CD_SHR%>[:DPT_CD_SHR]=<%=DPT_CD_SHR%>[:DPT_NM_SHR]=<%=DPT_NM_SHR%>[:EDU_CD_SHR]=<%=EDU_CD_SHR%>[:EDU_NM_SHR]=<%=EDU_NM_SHR%>[:JOB_CD_SHR]=<%=JOB_CD_SHR%>[:JOB_NM_SHR]=<%=JOB_NM_SHR%>[:GUBUN_VAL]=<%=GUBUN_VAL%>[:OCC_VAL]=<%=OCC_VAL%>[:EDU_VAL]=<%=EDU_VAL%>[:GBN_CD]=<%=GBN_CD%>">
              <param name="hidewnd"   VALUE="N">
              <param name="initdns"   VALUE="[LocationDNS]=<%=LocationDNS%>">
              </object>
</comment><script> __ShowEmbedObject(__NSID__); </script>
<!--������� �ڵ��Դϴ�//-->
			</td>
		</tr>
	</table>
</form>
</body>
</html>