<!--
***********************************************************************
* @source      : taxa080_PV.jsp 				                                                                                     *
* @description : 소득자별근로소득원천징수부
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/28      방석호        최초작성.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    String ENO_NO  = request.getParameter("ENO_NO");
    String STR_YMD  = request.getParameter("STR_YMD");
    String DPT_CD  = request.getParameter("DPT_CD");
    String TYPE  = request.getParameter("TYPE");
    String CEF_CNT  = request.getParameter("CEF_CNT");
    String SEND_PARM  = request.getParameter("SEND_PARM");

    System.out.println(ENO_NO);
    System.out.println(STR_YMD);
    System.out.println(DPT_CD);
    System.out.println(TYPE);
    System.out.println(CEF_CNT);
    System.out.println(SEND_PARM);


    String PIS_YY = request.getParameter("PIS_YY").split("-")[0];
	//String PIS_MM = request.getParameter("PIS_YY").split("-")[1];

	String rpt_name = "";


    if(SEND_PARM.equals("1")){
      if (TYPE.equals("1"))
  	  {
  		 rpt_name = "taxa080_ing.hnw"; // 직인 찍힌 증명서
  	  }
  	  else
  	  {
  		 rpt_name = "taxa080.hnw"; // 않찍힌 증명서
  	  }
    }
    else
      if (TYPE.equals("1"))
      {
         rpt_name = "taxa250_080_ing.hnw"; // 직인 찍힌 증명서
      }
      else
      {
         rpt_name = "taxa250_080.hnw"; // 않찍힌 증명서
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
<%
    if(SEND_PARM.equals("1")){
%>
                 <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_PrintOver.gif',1)">
                    <img src="/images/button/btn_PrintOn.gif"  name="Image6" width="60" height="20" border="0" align="absmiddle"  onclick="goclick('Print');"></a>
<%
    }
%>
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
              <param name="hnwsrc"    VALUE="<%=rpt_name%>">
              <param name="initvalue" VALUE="[:ENO_NO]=<%=ENO_NO%>[:PIS_YY]=<%=PIS_YY%>[:STR_YMD]=<%=STR_YMD%>[:DPT_CD]=<%=DPT_CD%>[:TYPE]=<%=TYPE%>[:CEF_CNT]=<%=CEF_CNT%>">
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