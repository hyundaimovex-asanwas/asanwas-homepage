<!--
*****************************************************
* @source       : memb010.jsp
* @description : 파견사원 개인별근태현황 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/03/12      김학수        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>파견사원 개인별근태현황(memb010)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >
    var nscp = (navigator.appName == "Netscape")

    var btnList = 'TFTTFFTT';
    /***********************************
     * 01. 조회 함수_List 형태의 조회  *
     ***********************************/
    function fnc_SearchList() {
        var f = document.form1;

        var eno_no     = f.txtENO_NO_SHR.value;
        var pis_yy     = f.txtPIS_YY_SHR.value;
        var pis_mm_str = f.txtPIS_MM_STR.value;
        var pis_mm_end = f.txtPIS_MM_END.value;

        var param;

        if ( eno_no == "" ||  eno_no == null )
        {
            alert("사번을 입력하십시오.");
            f.txtENO_NO_SHR.focus();
            return false;
        }
        if ( pis_yy == "" ||  pis_yy == null )
        {
            alert("기간 년도를 입력하십시오.");
            f.txtPIS_YY_SHR.focus();
            return false;
        }
        if ( pis_mm_str == "" ||  pis_mm_str == null )
        {
            alert("시작월을 입력하십시오.");
            f.txtPIS_MM_STR.focus();
            return false;
        }
        if ( pis_mm_str > 12 || pis_mm_end > 12 || pis_mm_str > pis_mm_end )
        {
            alert("월의 범위를 잘못 입력하셨습니다.");
            f.txtPIS_MM_STR.focus();
            return false;
        }

        param = "[@InitPage]=Page1[:eno_no]=" + eno_no + "[:pis_yy]=" + pis_yy + "[:pis_mm_str]=" + pis_mm_str + "[:pis_mm_end]=" + pis_mm_end;

        document.form1.aaa.OpenHnw("/hr/mem/memb010.hnw",param);
//        biz.style.display = "";
        f.flag.value = "Y";   // 인쇄조건.
    }

    /***********************************
     * 02. 조회 함수_Item 형태의 조회  *
     ***********************************/
    function fnc_SearchItem() {

        //이곳에 해당 코딩을 입력 하세요

    }

    /******************"C:/project000/MASA(back_up)/소스/data2/htdocs2/PMSL/js/comFunction.js"
     * 03. 저장 함수  *
     ******************/
    function fnc_Save() {

    }

    /******************
     * 04. 삭제 함수  *
     ******************/
    function fnc_Delete() {

    }

    /******************
     * 05. 인쇄 함수  *
     ******************/
    function fnc_Print() {
        var f = document.form1;
        if ( f.flag.value == "Y" )
        {
 //           form1.aaa.SetValue('eee','rrrrrrrrrrr');
            form1.aaa.RunButton('print_go');
        }
        else alert("문서조회 후 인쇄 하시기 바랍니다.");
    }

    /***********************
     * 06. 엑셀 저장 함수  *
     ***********************/
    function fnc_ToExcel() {

  // 엑셀로 변환 할 자료가 있는지 체크하고
  // 자료를 엑셀로 저장(시트 명만 바꿔 주세요)

    }

    /******************
     * 07. 신규 함수  *
     ******************/
    function fnc_AddNew() {

  //이곳에 해당 코딩을 입력 하세요

    }

    /******************
     * 08. 추가 함수  *
     ******************/
    function fnc_Append() {

  //이곳에 해당 코딩을 입력 하세요

    }

    /******************
     * 09. 제거 함수  *
     ******************/
    function fnc_Remove() {

  //이곳에 해당 코딩을 입력 하세요

    }

    /********************
     * 10. 초기화 함수  *
     ********************/
    function fnc_Clear() {

    }

    /************************
     * 11. 화면 종료(닫기)  *
     ***********************/
    function fnc_Exit() {

      frame = window.external.GetFrame(window);
      frame.CloseFrame();

   }

    /******************************
     * 12. 검색 조건 유효성 검사  *
     ******************************/
    function fnc_SearchItemCheck(year) {

  //이곳에 해당 코딩을 입력 하세요

    }

    /*************************
     * 13. 저장 유효성 체크  *
     *************************/
    function fnc_SaveItemCheck() {

    }

    /********************************************
     * 14. Form Load 시 Default 작업 처리 부분  *
     *******************************************/
    function fnc_OnLoadProcess() {
        document.getElementById("txtPIS_YY_SHR").value = getTodayArray()[0];
        document.getElementById("txtPIS_MM_STR").value = "01";
        document.getElementById("txtPIS_MM_END").value = "12";
     }

    /********************
    * 15. 단축키 처리  *
    *******************/
    function fnc_HotKey() {

      fnc_HotKey_Process(btnList, event.keyCode);

    }

    /********************************************
    * 날짜 형식 유효성 체크                     *
    ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('유효한 날짜가 아닙니다.');
                obj.focus();
            }
        }

    /********************************************
    * ez-gen 버튼 클릭 이벤트                   *
    ********************************************/
    function winclose()
    {
        window.close();
    }
    function goclick(x)
    {
        if( !document.form1.aaa.RunButton(x)) alert("개체가 없습니다.");
    }

    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
  <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 타이틀 바 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="25" background="/images/common/barBg.gif">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
          <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">개인별근태현황</td>
          <td align="right" class="navigator">HOME/인사관리/파견사원/<font color="#000000">개인별근태현황</font></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<!-- 타이틀 바 테이블 끝 -->

<!-- 버튼 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="35" class="paddingTop5" align="right">
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
      <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a> -->
      <!-- a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a -->
      <!-- a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();" --></a>
      <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>-->
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
    </td>
  </tr>
</table>
<!-- 버튼 테이블 끝 -->


<!-- power Search테이블 시작 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td align="right" class="searchState">사번 </td>
                                <td class="padding2423">
                                    <input id=txtENO_NO_SHR name=txtENO_NO_SHR size="10"  maxlength="10" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();" onChange="fnc_GetEnoNm('txtENO_NO_SHR')"> <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="12" onKeyPress="JaveScript: if (event.keyCode == 13) {fnc_GetEnoNo('txtENO_NM_SHR', 'txtENO_NO_SHR', '2');}">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl3Popup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
                                </td>
                                <td align="right" class="searchState">기 간&nbsp;</td>
								<td class="padding2423">
                                    <input id="txtPIS_YY_SHR" size="4" maxlength="4" onkeypress="cfNumberCheck();" style="ime-mode:disabled">년
                                    <input id="txtPIS_MM_STR" size="2" maxlength="2" onkeypress="cfNumberCheck();" style="ime-mode:disabled">월 ~
                                    <input id="txtPIS_MM_END" size="2" maxlength="2" onkeypress="cfNumberCheck();" style="ime-mode:disabled">월</td>
							</tr>
                            </tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- power Search테이블 끝 -->

<table border="0"><tr><td height="5"></td></tr></table>

<!--************************************************************** ezgen -->
<table border=0>
    <tr height="150">
        <td width="800">
            <table border="00" bordercolordark="white" bordercolorlight="gray" bordercolor="gray">
                <comment id="__NSID__">
                    <object id="aaa" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="800" height="400" codebase="<%=hnwcodebase%>">
                    <!-- param name="hnwsrc"    VALUE="memb010.hnw" -->
                    <param name="initvalue" VALUE="[:flag]=N">
                    <param name="hidewnd"   VALUE="N">
                    <param name="initdns"   VALUE="[LocationDNS]=<%=LocationDNS%>">
                    </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>
           </table>
        </td>
    </tr>
</table>
<!--************************************************************** ezgen -->
<!-- table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="center" id="biz"  style="display:none">
            <input type="button" name="btnREG_nxt_SHR" value="<<" onclick="goclick('firstPage');" style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
            <input type="button" name="btnREG_nxt_SHR" value="<"  onclick="goclick('prePage');"   style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
            &nbsp;
            <input type="button" name="btnREG_nxt_SHR" value=">"  onclick="goclick('nextPage');"  style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
            <input type="button" name="btnREG_nxt_SHR" value=">>" onclick="goclick('lastPage');"  style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
        </td>
    </tr>
</table -->
<!-- 조회 상태 테이블 시작 -->
<!-- table width="800" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="paddingTop8">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
        </tr>
      </table>
    </td>
  </tr>
</table -->
<!-- 조회 상태 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->

<!-- 내용 조회 그리드 데이블 끝-->
<input type="hidden" name="txtDOC_AUTHO" value="1">
<input type="hidden" name="flag">
</form>
<!-- form 끝 -->

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
