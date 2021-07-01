<!--
    ************************************************************************************
    * @Source         : pird030.jsp                                                    *
    * @Description    : 여권발급현황 PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/01/05  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>여권발급현황(pird030)</title>
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

        var btnList = 'TFFTTFFT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var OCC_CD   = document.getElementById("cmbOCC_CD_SHR").value;
            var PRT_GBN  = document.getElementById("cmbPRT_GBN_SHR").value;
            var DUE_YMD  = document.getElementById("txtDUE_YMD_SHR").value;

            if (PRT_GBN == "2" || PRT_GBN == "3") {
                if (DUE_YMD == "") {
                    alert("만기기준일은 필수입력항목입니다.");
                    document.getElementById("txtDUE_YMD_SHR").focus();
                    return;
                }

                // 만기기준일 CHECK
                if (!fnc_CheckDate(document.getElementById("txtDUE_YMD_SHR"), '만기기준일')) {
                    document.getElementById("txtDUE_YMD_SHR").focus();
                    return;
                }
            }

            dsT_CM_VISA.ClearData();

            dsT_CM_VISA.DataId = "/servlet/GauceChannelSVL?cmd=hr.pir.d.pird030.cmd.PIRD030CMD&S_MODE=SHR&OCC_CD="+OCC_CD+"&PRT_GBN="+PRT_GBN+"&DUE_YMD="+DUE_YMD;
            dsT_CM_VISA.Reset();

            form1.grdT_CM_VISA.Focus();

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

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_CM_VISA.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_CM_VISA.GridToExcel("여권발급현황", '', 225);

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

            document.getElementById("cmbOCC_CD_SHR").value  = '';
            document.getElementById("cmbPRT_GBN_SHR").value = '1';
            document.getElementById("txtDUE_YMD_SHR").value = '';

            document.getElementById("txtDUE_YMD_SHR").disabled = true;
            document.getElementById("ImgDueYmd").disabled = true;

            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_CM_VISA.ClearData();

            document.getElementById("cmbOCC_CD_SHR").focus();

        }

        /******************************
         * 11. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 12. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style 적용
            cfStyleGrid(form1.grdT_CM_VISA,0,"false","false");

            document.getElementById("txtDUE_YMD_SHR").disabled = true;
            document.getElementById("ImgDueYmd").disabled = true;

            document.getElementById("cmbOCC_CD_SHR").focus();

        }


        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }


        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

        function fnc_FldChange() {
            document.getElementById("txtDUE_YMD_SHR").value = "";

            if (document.getElementById("cmbPRT_GBN_SHR").value == "1") {
                document.getElementById("txtDUE_YMD_SHR").disabled = true;
                document.getElementById("ImgDueYmd").disabled = true;

                document.getElementById("txtDUE_YMD_SHR").value = '';
            }
            else {
                document.getElementById("txtDUE_YMD_SHR").disabled = false;
                document.getElementById("ImgDueYmd").disabled = false;

                document.getElementById("txtDUE_YMD_SHR").value = getToday().substr(0,7);
                document.getElementById("txtDUE_YMD_SHR").focus();
            }
        }

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_VISA)      |
    | 3. 사용되는 Table List(T_CM_VISA)             |
    +----------------------------------------------->
    <Object ID="dsT_CM_VISA" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_VISA Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_VISA.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_VISA Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_VISA Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">여권발급현황</td>
                    <td align="right" class="navigator">HOME/인사관리/인사정보출력/<font color="#000000">여권발급현황</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="80"></col>
                                <col width="140"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">근로구분&nbsp;</td>
                                <td class="padding2423">
                                    <select id="cmbOCC_CD_SHR" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                        <option value="">전  체</option>
                                        <option value="A">사무직</option>
                                        <option value="M">택배직</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">구분&nbsp;</td>
                                <td class="padding2423">
                                    <select id=cmbPRT_GBN_SHR onBlur="fnc_FldChange()"  onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                        <option value="1">부서별</option>
                                        <option value="2">여권만기일기준</option>
                                        <option value="3">비자만기일기준</option>
                                    </select>
                                    <input id="txtDUE_YMD_SHR" style="ime-mode:disabled" size="7" maxlength="7" onChange="fnc_CheckDate(this, '만기기준일');"  onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDueYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDueYmd" name="ImgDueYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtDUE_YMD_SHR','','380','115');"></a>
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

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_CM_VISA" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:390px;">
                            <param name="DataID"                  value="dsT_CM_VISA">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     width=40    name='순번'         align=center </C>
                                <C> id='OCC_NM'       width=60    name='근로구분'         align=center suppress = '1'</C>
                                <C> id='DPT_NM'       width=100   name='소속'         align=left   suppress = '1'</C>
                                <C> id='JOB_NM'       width=70    name='직위'         align=left   suppress = '1'</C>
                                <C> id='ENO_NO'       width=70    name='사번'         align=center suppress = '1'</C>
                                <C> id='ENO_NM'       width=70    name='성명'         align=center suppress = '1'</C>
                                <C> id='PAS_NO'       width=80    name='여권번호'     align=center </C>
                                <C> id='ISS_YMD'      width=70    name='발급일'       align=center </C>
                                <C> id='DUE_YMD'      width=70    name='만료일'       align=center </C>
                                <C> id='NAT_NM'       width=70    name='국적'         align=center </C>
                                <C> id='VISA_NO'      width=80    name='VISA번호'     align=center </C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 내용 조회 그리드 테이블 끝-->

</form>
<!-- form 끝 -->

</body>
</html>