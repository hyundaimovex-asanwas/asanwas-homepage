<!--
***********************************************************************
* @source      : graa050.jsp
* @description : 직급,호봉별 임금조정현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/27      김학수        최초작성.        
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
    String HBA_YMD  = request.getParameter("HBA_YMD");
    String PIS_YM   = request.getParameter("PIS_YM");	
    String DPT_CD1  = request.getParameter("DPT_CD1");
    String DPT_CD2  = request.getParameter("DPT_CD2");	
    String JOB_CD1  = request.getParameter("JOB_CD1");
    String JOB_CD2  = request.getParameter("JOB_CD2");
    String GUBUN    = request.getParameter("GUBUN");
    String SEL      = request.getParameter("SEL");
/*
    out.println("SND_KIND="+SND_KIND);
    out.println("OCC_CD="+OCC_CD);
    out.println("RAI_YMD="+RAI_YMD);
    out.println("HBA_YMD="+HBA_YMD);
    out.println("PIS_YM="+PIS_YM);
    out.println("DPT_CD1="+DPT_CD1);
    out.println("DPT_CD2="+DPT_CD2);
    out.println("JOB_CD1="+JOB_CD1);
    out.println("JOB_CD2="+JOB_CD2);
    out.println("GUBUN="+GUBUN);
    out.println("SEL="+SEL);
*/
    String snd_kind_val = "";
    String occ_cd_val   = "";
    String gbn_val      = "";

    if ( OCC_CD.equals("A") ) occ_cd_val = "사무직";
    else if ( OCC_CD.equals("M") ) occ_cd_val = "택배직";
    else occ_cd_val = "전 체";

    if ( GUBUN.equals("CON") ) {
        gbn_val = "조 정";
    }
    else if ( GUBUN.equals("FIN") ) {
        gbn_val = "확 정";
    }
    
    if   ( SND_KIND.equals("PAY") ) snd_kind_val = "급여";
    else  snd_kind_val = "상여";


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
              <param name="hnwsrc"    VALUE="graa050.hnw">
              <param name="initvalue" VALUE="[:SND_KIND]=<%=SND_KIND%>[:OCC_CD]=<%=OCC_CD%>[:RAI_YMD]=<%=RAI_YMD%>[:HBA_YMD]=<%=HBA_YMD%>[:PIS_YM]=<%=PIS_YM%>[:DPT_CD1]=<%=DPT_CD1%>[:DPT_CD2]=<%=DPT_CD2%>[:JOB_CD1]=<%=JOB_CD1%>[:JOB_CD2]=<%=JOB_CD2%>[:GUBUN]=<%=GUBUN%>[:SEL]=<%=SEL%>[:snd_kind_val]=<%=snd_kind_val%>[:occ_cd_val]=<%=occ_cd_val%>[:gbn_val]=<%=gbn_val%>"> 
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