<!--
*****************************************************
* @source       : guna220.jsp
* @description : 월간근태현황통계 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2009/11/05      권혁수        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>월간근태현황통계(guna220)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >
    var nscp = (navigator.appName == "Netscape")

    var btnList = 'TFTTFFTT';

    var today = getToday();
    /***********************************
     * 01. 조회 함수_List 형태의 조회  *
     ***********************************/
    function fnc_SearchList() {

    }

    /***********************************
     * 02. 조회 함수_Item 형태의 조회  *
     ***********************************/
    function fnc_SearchItem() {

        //이곳에 해당 코딩을 입력 하세요

    }

    /******************
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
		var reg_ymd = document.getElementById("txtREG_YM_SHR").value;
		if(reg_ymd == ""){
			alert("날짜를 입력하세요");
		}
        //신규 모듈
        var param;

        param = "[@InitPage]=Page1[:reg_ymd]=" + reg_ymd;
        var url = "guna220_PV.jsp?reg_ymd="+reg_ymd;
        window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");

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
		document.getElementById("txtREG_YM_SHR").value = getToday().substring(0,7);

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

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->


    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>


    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>



    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->

    <!--------------------------+
    | Grid 이벤트 처리  |
    +--------------------------->

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
          <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">월간근태현황통계</td>
          <td align="right" class="navigator">HOME/근태관리/일일근태관리/<font color="#000000">월간근태현황통계</font></td>
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
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
    </td>
  </tr>
</table>
<!-- 버튼 테이블 끝 -->


<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
								<col width="80"></col>
								<col width=""></col>
							</colgroup>
                            <tr>
                                <td class="searchState" align="right">기준월&nbsp;</td>
                                <td class="padding2423" align="left" id="key1"  style="display:">
                                    <input type="text" id="txtREG_YM_SHR" name="txtREG_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" value="">
                               </td>
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

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="center" id="biz"  style="display:none">
            <input type="button" name="btnREG_nxt_SHR" value="<<" onclick="goclick('firstPage');" style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
            <input type="button" name="btnREG_nxt_SHR" value="<"  onclick="goclick('prePage');"   style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
            &nbsp;
            <input type="button" name="btnREG_nxt_SHR" value=">"  onclick="goclick('nextPage');"  style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
            <input type="button" name="btnREG_nxt_SHR" value=">>" onclick="goclick('lastPage');"  style="background:white;cursor:hand" onmouseover="this.style.background='#EFEFE9'" onmouseout="this.style.background='white'">
        </td>
    </tr>
</table>

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
