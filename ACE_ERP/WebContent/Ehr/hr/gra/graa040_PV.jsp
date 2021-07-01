<!--
***********************************************************************
* @source      : graa040.jsp
* @description : 개인별급상여현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/26      김학수        최초작성.        
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    String SND_KIND = request.getParameter("SND_KIND");	
    String OCC_CD   = request.getParameter("OCC_CD");	
    String RAI_YMD  = request.getParameter("RAI_YMD");	
    String AOW_GBN  = request.getParameter("AOW_GBN");
    String AOW_YMD  = request.getParameter("AOW_YMD");	
    String DPT_CD   = request.getParameter("DPT_CD");
    String JOB_CD   = request.getParameter("JOB_CD");	
    String GBN      = request.getParameter("GBN");

    String snd_kind_val = "";
    String occ_cd_val   = "";
    String gbn_val1     = "";
    String gbn_val2     = "";

    if ( OCC_CD.equals("A") ) occ_cd_val = "사무직";
    else if ( OCC_CD.equals("M") ) occ_cd_val = "택배직";

    if ( GBN.equals("DPT") ) {
        gbn_val1 = "소 속 :";
        gbn_val2 = DPT_CD;
    }
    else if ( GBN.equals("JOB") ) {
        gbn_val1 = "직 위 :";
        gbn_val2 = JOB_CD;
    }
    
    if   ( SND_KIND.equals("PAY") ) snd_kind_val = "개인별 급여 현황";
    else  snd_kind_val = "개인별 상여 현황";

/*
    out.println("SND_KIND="+SND_KIND);
    out.println("OCC_CD="+OCC_CD);
    out.println("RAI_YMD="+RAI_YMD);
    out.println("AOW_GBN="+AOW_GBN);
    out.println("AOW_YMD="+AOW_YMD);
    out.println("DPT_CD="+DPT_CD);
    out.println("JOB_CD="+JOB_CD);
    out.println("GBN="+GBN);
*/
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
              <param name="hnwsrc"    VALUE="graa040.hnw">
              <param name="initvalue" VALUE="[:SND_KIND]=<%=SND_KIND%>[:OCC_CD]=<%=OCC_CD%>[:RAI_YMD]=<%=RAI_YMD%>[:AOW_GBN]=<%=AOW_GBN%>[:AOW_YMD]=<%=AOW_YMD%>[:DPT_CD]=<%=DPT_CD%>[:JOB_CD]=<%=JOB_CD%>[:GBN]=<%=GBN%>[:occ_cd_val]=<%=occ_cd_val%>[:gbn_val1]=<%=gbn_val1%>[:gbn_val2]=<%=gbn_val2%>[:snd_kind_val]=<%=snd_kind_val%>">
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