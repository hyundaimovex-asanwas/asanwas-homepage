<!--
***********************************************************************
* @source      : pird010_PV.jsp
* @description : �λ���ī�� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2008/10/17      �����        �����ۼ�.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
    String OCC_CD       = request.getParameter("OCC_CD");
    String PRT_SELT     = request.getParameter("PRT_SELT");
    String NO_SHR       = request.getParameter("NO_SHR");

    String PRT_PAGE_01  = request.getParameter("PRT_PAGE_01");
    String PRT_PAGE_02  = request.getParameter("PRT_PAGE_02");
    String PRT_PAGE_03  = request.getParameter("PRT_PAGE_03");


    String QVAL_01  = request.getParameter("QVAL_01");
    String QVAL_02  = request.getParameter("QVAL_02");
    String QVAL_04  = request.getParameter("QVAL_04");
    String QVAL_07  = request.getParameter("QVAL_07");


    String param1 = "[:OCC_CD]="+OCC_CD+"[:PRT_SELT]="+PRT_SELT+"[:NO_SHR]="+NO_SHR;
    String param2 = "[:PRT_PAGE_01]="+PRT_PAGE_01+"[:PRT_PAGE_02]="+PRT_PAGE_02+"[:PRT_PAGE_03]="+PRT_PAGE_03;
    String param3 = "[:QVAL_01]="+QVAL_01+"[:QVAL_02]="+QVAL_02+"[:QVAL_04]="+QVAL_04+"[:QVAL_07]="+QVAL_07;
    String param  = param1 + param2 + param3;

    System.out.println(param);

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


  document.form1.aaa.RunButton("CommandPrint");


/*  ȭ�� ����(�ݱ�)  */
function fnc_Exit() {
    window.close();
}

function goclick(x) {
	if( !document.form1.aaa.RunButton(x) ) {
        alert("��ü�� �����ϴ�.");
	}
}
function winclose() {
    window.close();
}



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
            <!-- td width="8" align="center"></td -->
            <td width="">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_PrintOver.gif',1)">
                    <img src="/images/button/btn_PrintOn.gif"  name="Image6" width="60" height="20" border="0" align="absmiddle"  onclick="goclick('Print');"></a>
                <!-- a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_ExcelOver.gif',1)">
                    <img src="/images/button/btn_ExcelOn.gif"  name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="goclick('Excel')"></a  -->
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
<!--���⼭���� �ڵ��Դϴ�-->
<javascript>

</javascript>
<comment id="__NSID__">
              <object id="aaa" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="800" height="400" codebase="<%=hnwcodebase%>">
              <param name="hnwsrc"    VALUE="pird010_preview.hnw">
              <param name="initvalue" VALUE=<%=param%>>
              <param name="hidewnd"   VALUE="N">
              <param name="initdns"   VALUE="[LocationDNS]=<%=LocationDNS%>">
              </object>
</comment><script> __ShowEmbedObject(__NSID__); </script>
<!--������� �ڵ��Դϴ�-->
			</td>
		</tr>
	</table>
</form>
</body>
</html>
