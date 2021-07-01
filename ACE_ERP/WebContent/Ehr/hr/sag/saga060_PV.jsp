<!--
***********************************************************************
* @source         : saga060_PV.jsp 				                                                                                     *
* @description   : 급상여지급현황 PAGE.
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/24      김학수        최초작성.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    String STR_YYMM_SHR = request.getParameter("STR_YYMM_SHR");
    String END_YYMM_SHR = request.getParameter("END_YYMM_SHR");
    String OCC_CD_SHR   = request.getParameter("OCC_CD_SHR");
    String SAL_GBN_SHR  = request.getParameter("SAL_GBN_SHR");
    String SEQ_SHR      = request.getParameter("SEQ_SHR");
    String SORT_SHR     = request.getParameter("SORT_SHR");
/*
    System.out.println("STR_YYMM_SHR="+STR_YYMM_SHR);
    System.out.println("END_YYMM_SHR="+END_YYMM_SHR);
    System.out.println("OCC_CD_SHR="+OCC_CD_SHR);
    System.out.println("SAL_GBN_SHR="+SAL_GBN_SHR);
    System.out.println("SEQ_SHR="+SEQ_SHR);
    System.out.println("SORT_SHR="+SORT_SHR);
*/
    String titl_val = "";
    String ymd_val  = "";
    String occ_val = "";

    if ( SORT_SHR.equals("1") ) {
        titl_val = "부서별 급상여지급현황";
    } else if ( SORT_SHR.equals("2") ) {
        titl_val = "직위별 급상여지급현황";
    } else {
        titl_val = "기준직위별 급상여지급현황";
    }

    ymd_val = "기   간 : " + STR_YYMM_SHR.substring(0,4) + "/" + STR_YYMM_SHR.substring(5,7) + "  ~  " + END_YYMM_SHR.substring(0,4) + "/" + END_YYMM_SHR.substring(5,7);

    if ( OCC_CD_SHR.equals("A") ) {
        occ_val = "근로구분구분 : " + "사무직";
    } else {
        occ_val = "근로구분구분 : " + "택배직";
    }


    String header_01 = "직급/부서";
    String header_02 = "인원";
    String header_03 = "기본급";
    String header_04 = "";
    String header_05 = "";
    String header_06 = "";
    String header_07 = "";
    String header_08 = "";
    String header_09 = "";

    String header_10 = "근속수당";
    String header_11 = "기타수당";
    String header_12 = "기타지불액";
    String header_13 = "급여계";
    String header_14 = "건강보험";
    String header_15 = "국민연금";
    String header_16 = "고용보험";
    String header_17 = "개인연금";

    if ( OCC_CD_SHR.equals("A") ) {
        header_04 = "직책수당";
        header_05 = "시간외수당";
        header_06 = "복지수당";
        header_07 = "자기개발비";
        header_08 = "야근수당";
        header_09 = "전산수당";
    } else {
        header_04 = "복지수당";
        header_05 = "시간외수당";
        header_06 = "기술수당";
        header_07 = "택배수당";
        header_08 = "운행/작업수당";
        header_09 = "자기개발비";
    }
    String param_header = "";
    param_header += "[:header_01]="+header_01+"[:header_02]="+header_02+"[:header_03]="+header_03+"[:header_04]="+header_04;
    param_header += "[:header_05]="+header_05+"[:header_06]="+header_06+"[:header_07]="+header_07+"[:header_08]="+header_08;
    param_header += "[:header_09]="+header_09+"[:header_10]="+header_10+"[:header_11]="+header_11+"[:header_12]="+header_12;
    param_header += "[:header_13]="+header_13+"[:header_14]="+header_14+"[:header_15]="+header_15+"[:header_16]="+header_16+"[:header_17]="+header_17;
    param_header += "[:titl_val]="+titl_val+"[:ymd_val]="+ymd_val+"[:occ_val]="+occ_val;
        // 직위, 부서
/*
    out.println("ENO_NO="+ENO_NO);
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
            <td width="8" align="center"></td -->
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
              <param name="hnwsrc"    VALUE="saga060.hnw">
              <param name="initvalue" VALUE="[:STR_YYMM_SHR]=<%=STR_YYMM_SHR%>[:END_YYMM_SHR]=<%=END_YYMM_SHR%>[:OCC_CD_SHR]=<%=OCC_CD_SHR%>[:SAL_GBN_SHR]=<%=SAL_GBN_SHR%>[:SEQ_SHR]=<%=SEQ_SHR%>[:SORT_SHR]=<%=SORT_SHR%><%=param_header%>">
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