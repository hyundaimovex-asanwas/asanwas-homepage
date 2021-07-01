<!--
***********************************************************************
* @source        : taxa110_PV.jsp 				                      *
* @description   : ����Ҽ�(��������)���⳻�� PAGE.                   *
***********************************************************************
* DATE            AUTHOR        DESCRIPTION                           *
*----------------------------------------------------------------------
* 2007/05/04      �̽¿�        �����ۼ�.                             *
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    String hnwParm      = "[@InitPage]="     + request.getParameter("prn_from");
           hnwParm     += "[:HEAD_TAG]="     + request.getParameter("head_tag");
           hnwParm     += "[:PIS_YYMM_A0]="  + request.getParameter("pis_yymm_a0").replaceAll("-","");
           hnwParm     += "[:PIS_YYMM_A1F]=" + request.getParameter("pis_yymm_a1f").replaceAll("-","");
           hnwParm     += "[:PIS_YYMM_A1T]=" + request.getParameter("pis_yymm_a1t").replaceAll("-","");
           hnwParm     += "[:PIS_YYMM_M0]="  + request.getParameter("pis_yymm_m0").replaceAll("-","");
           hnwParm     += "[:PIS_YYMM_M1F]=" + request.getParameter("pis_yymm_m1f").replaceAll("-","");
           hnwParm     += "[:PIS_YYMM_M1T]=" + request.getParameter("pis_yymm_m1t").replaceAll("-","");
           hnwParm     += "[:PIS_YYMM_Y3]="  + request.getParameter("pis_yymm_y3").replaceAll("-","");
           hnwParm     += "[:PIS_YYMM_Y0]="  + request.getParameter("pis_yymm_y0").replaceAll("-","");
           hnwParm     += "[:PIS_YYMM_Y1]="  + request.getParameter("pis_yymm_y1").replaceAll("-","");
    
	String rpt_name = "";

 	if (request.getParameter("head_tag").equals("3"))
   	{
   		rpt_name = "taxa110.hnw"; // ��ü
   	}
   	else if (request.getParameter("head_tag").equals("2")) //����
   	{
   		rpt_name = "taxa110_branch.hnw"; // ��ü
   	}
   	else
   	{
   		rpt_name = "taxa110_1.hnw"; // ���빮/���λ��
   	}
           
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
	if( !document.form1.aaa.RunButton(x) ) {
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
				<input type="button" name="btnREG_nxt_SHR" value="<<" onclick="goclick('firstPage');" style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
                <input type="button" name="btnREG_nxt_SHR" value="<"  onclick="goclick('prePage');"   style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">

                <input type="button" name="btnREG_nxt_SHR" value=">"  onclick="goclick('nextPage');"  style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
                <input type="button" name="btnREG_nxt_SHR" value=">>" onclick="goclick('lastPage');"  style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'"></td>
            <td width="8" align="center"></td>
            <td width="">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_PrintOver.gif',1)">
                    <img src="/images/button/btn_PrintOn.gif"  name="Image6" width="60" height="20" border="0" align="absmiddle"  onclick="goclick('Print');"></a>
<!--
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_ExcelOver.gif',1)"> 
                    <img src="/images/button/btn_ExcelOn.gif"  name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="goclick('Excel')"></a>
-->
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
<comment id="__NSID__">
              <object id="aaa" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="800" height="400" codebase="<%=hnwcodebase%>">
              <param name="hnwsrc"    VALUE="<%=rpt_name%>">
              <param name="initvalue" VALUE="<%=hnwParm%>">
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
