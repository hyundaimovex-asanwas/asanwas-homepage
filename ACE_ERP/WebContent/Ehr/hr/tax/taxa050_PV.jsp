<!--
***********************************************************************
* @source         : ymaa040_PV.jsp 				                                                                                     *
* @description   : 공제항목별 현황 PAGE.  
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/28      김학수        최초작성.        
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    String PIS_YM      = request.getParameter("PIS_YM");
    String PIS_YY      = request.getParameter("PIS_YY");
    String PIS_MM      = request.getParameter("PIS_MM");
    String DED_CD      = request.getParameter("DED_CD");
    String SAL_GBN     = request.getParameter("SAL_GBN");
    String OCC_CD      = request.getParameter("OCC_CD");
    String DTP_CD      = request.getParameter("DTP_CD");
    String DPT_NM      = request.getParameter("DPT_NM");
    String ORDER_TYPE  = request.getParameter("ORDER_TYPE");
    String DED_NM      = request.getParameter("DED_NM");

    String DPT_NM_VAL = "";
    String TITLE_VAL  = PIS_YY + "년 " + PIS_MM + "연 년말정산";
    String OCC_VAL = "";
    String DED_NM_VAL = "";

    if ( DPT_NM.equals("") || DPT_NM == null ) {
        DPT_NM_VAL = "소  속 : All";
    } else {
        DPT_NM_VAL = "소  속 : " + DPT_NM;
    }    
    
    if ( OCC_CD.equals("A") ) {
        OCC_VAL = "근로구분 : 사무직";
    } else if ( OCC_CD.equals("M") ) {
        OCC_VAL = "근로구분 : 택배직";
    } else {
        OCC_VAL = "근로구분 : 전 체";
    }
    
    if ( DED_NM.equals("") || DED_NM == null ) {
        DED_NM_VAL = "전체";
    } else {
        DED_NM_VAL = "공제항목 : " + DED_NM;
    }
    System.out.println("DPT_NM_VAL="+DPT_NM_VAL);
    System.out.println("OCC_VAL="+OCC_VAL);
    
/*
    System.out.println("PIS_YM     ="+PIS_YM     );
    System.out.println("PIS_YY     ="+PIS_YY     );
    System.out.println("PIS_MM     ="+PIS_MM     );
    System.out.println("DED_CD     ="+DED_CD     );
    System.out.println("SAL_GBN    ="+SAL_GBN    );
    System.out.println("OCC_CD     ="+OCC_CD     );
    System.out.println("DTP_CD     ="+DTP_CD     );
    System.out.println("ORDER_TYPE ="+ORDER_TYPE );
*/
/*

    String GBN_VAL    = "";
    String GBN_HEADER = "";
    String OCC_CD_VAL = "";
    String TITLE_VAL  = PIS_YYMM_SHR.substring(0,4) + "년 연월차수당 지급총괄";
    
    if ( SORT_SHR.equals("1") ) {
        GBN_VAL    = "(부서별)";
        GBN_HEADER = "부     서";
    } else {
        GBN_VAL    = "(직위별)";
        GBN_HEADER = "직     위";
    }

    if ( OCC_CD_SHR.equals("A") ) {
        OCC_CD_VAL = "근로구분 : 사무직";
    } else if ( OCC_CD_SHR.equals("M") ) {
        OCC_CD_VAL = "근로구분 : 택배직";
    } else {
        OCC_CD_VAL = "근로구분 : 전체";
    }
   */ 
/*
    System.out.println("PIS_YYMM_SHR ="+PIS_YYMM_SHR );
    System.out.println("OCC_CD_SHR ="+OCC_CD_SHR );
    System.out.println("SORT_SHR    ="+SORT_SHR    );
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
                <!--a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_ExcelOver.gif',1)"> 
                    <img src="/images/button/btn_ExcelOn.gif"  name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="goclick('Excel')"></a -->
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
              <param name="hnwsrc"    VALUE="taxa050.hnw">
              <param name="initvalue" VALUE="[:PIS_YM]=<%=PIS_YM%>[:PIS_YY]=<%=PIS_YY%>[:PIS_MM]=<%=PIS_MM%>[:DED_CD]=<%=DED_CD%>[:SAL_GBN]=<%=SAL_GBN%>[:OCC_CD]=<%=OCC_CD%>[:DTP_CD]=<%=DTP_CD%>[:ORDER_TYPE]=<%=ORDER_TYPE%>[:DPT_NM]=<%=DPT_NM%>[:DPT_NM_VAL]=<%=DPT_NM_VAL%>[:OCC_VAL]=<%=OCC_VAL%>[:TITLE_VAL]=<%=TITLE_VAL%>[:DED_NM_VAL]=<%=DED_NM_VAL%>">
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