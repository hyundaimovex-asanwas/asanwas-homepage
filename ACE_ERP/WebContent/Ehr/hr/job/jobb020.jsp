<!--
    ************************************************************************************
    * @Source         : jobb020.jsp                                                    *
    * @Description    : 자기신고서설문현황 PAGE                                        *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/11  |  오대성   | 최초작성                                               *
    * 2006/10/30  |  박인이   | 개발                                                   *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>자기신고서설문현황(jobb020)</title>
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

        //버튼순서  : 조회  신규  저장  취소  엑셀  인쇄  삭제  닫기
        var btnList = 'T' + 'F' + 'F' + 'T' + 'T' + 'T' + 'F' + 'T';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var PIS_YYMM = form1.txtPIS_YYMM_SHR.value;
            var OCC_CD   = form1.cmbOCC_CD_SHR.value;
            var CountRow = 0;

            if (!fncCheckDate()) {
                dsT_EV_QSTANS.ClearData();
                return;
            }

            dsT_EV_QSTANS.DataId = "/servlet/GauceChannelSVL?cmd=hr.job.b.jobb020.cmd.JOBB020CMD&S_MODE=SHR&PIS_YYMM="+PIS_YYMM+"&OCC_CD="+OCC_CD;
            dsT_EV_QSTANS.Reset();

            CountRow = dsGT_EV_QSTANS.CountRow;

            // GroupExpr용 DATASET Load
            if (dsGT_EV_QSTANS.CountRow == 0)    {

                fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            } else {

                fnc_Message(document.getElementById("resultMessage"), "MSG_03", CountRow - 1);

            }

            form1.grdT_EV_QSTANS.Focus();

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

            if (dsGT_EV_QSTANS.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdGT_EV_QSTANS.GridToExcel("자기신고서설문현황", '', 225)

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

            document.getElementById("resultMessage").innerText = ' ';
            form1.cmbOCC_CD_SHR.value = '';

            // DataSet Clear
            dsT_EV_QSTANS.ClearData();
            dsGT_EV_QSTANS.ClearData();

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

            var EVL_YY  = null;
            var oOption = null;

            // 현재년월
            form1.txtPIS_YYMM_SHR.value = getToday().substring(0,7);

            //Grid Style 적용
            cfStyleGrid(form1.grdGT_EV_QSTANS,0,"false","false");

            form1.txtPIS_YYMM_SHR.focus();

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

        /*****************************************************
         * 날짜 형식 유효성 체크                             *
         ****************************************************/
        function fncCheckDate() {
            if (form1.txtPIS_YYMM_SHR.value == '') {
                alert('날짜를 입력하시기 바랍니다.');
                form1.txtPIS_YYMM_SHR.focus();
                return false;
            }

            if(!cfDateExpr(form1.txtPIS_YYMM_SHR.value)) {
                alert('유효한 날짜가 아닙니다.');
                form1.txtPIS_YYMM_SHR.focus();
                return false;
            }

            return true;
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
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_QSTANS)    |
    | 3. 사용되는 Table List(T_EV_QSTANS)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_QSTANS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. GroupExpr용 DataSet                        |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_QSTANS)    |
    | 3. 사용되는 Table List(T_EV_QSTANS)           |
    +----------------------------------------------->
    <Object ID="dsGT_EV_QSTANS" Classid="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Logical"        Value="true">
        <Param Name="DataID"         Value="dsT_EV_QSTANS">
        <Param Name="GroupExpr"      Value="DPT_NM:TOT_CNT:DPT_CNT,QST_ITEM_SNM,ANS_PER1:ANS_PER2">
    </Object>



    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_QSTANS Event="OnLoadCompleted(iCount)">

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_QSTANS Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_QSTANS Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <Script For=dsGT_EV_QSTANS Event="OnLoadCompleted(iCount)">

    </script>




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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">자기신고서설문현황</td>
                    <td align="right" class="navigator">HOME/직무이동/직무이동현황/<font color="#000000">자기신고서설문현황</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
       <!--      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="Image6" width="60" height="20" border="0" align="absmiddle"></a>  -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image8" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<!-- 조건 입력 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="80"></col>
                                <col width="80"></col>
                                <col width="80"></col>
                                <col width="560"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">조사년월&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtPIS_YYMM_SHR" size="7" maxlength="7" onblur="cfCheckDate(this);" style="ime-mode:disabled"  onChange="fnc_SearchList()" onKeyPress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList()">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','150','138');"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle"></a>
                                </td>
                                <td align="right" class="searchState">근로구분&nbsp;</td>
                                <td class="">
                                    <select name="cmbOCC_CD_SHR" style="WIDTH: 15%" onChange="fnc_SearchList()" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                        <option value="">전 체</option>
                                        <option value="A">사무직</option>
                                        <option value="M">택배직</option>
                                    </select>
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
        <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdGT_EV_QSTANS" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"              value="dsGT_EV_QSTANS">
                            <param name="IndWidth"            value=0>
                            <param name="Format"              value="
                                <FC> id='DPT_NM'              width=120   name='구분'      align=left  HeadBgColor='#F7DCBB' </FC>
                                <FC> id='TOT_CNT'             width=60    name='대상인원'    align=right HeadBgColor='#F7DCBB' Value={Decode(TOT_CNT,'0','',TOT_CNT)} </FC>
                                <FC> id='DPT_CNT'             width=60    name='응답인원'  align=right HeadBgColor='#F7DCBB' Value={Decode(DPT_CNT,'0','',DPT_CNT)} </FC>
                                <R>
                                    <G> name=$xkeyname_$$  HeadBgColor='#F7DCBB'
                                        <C> id='ANS_PER1_$$'  width=55    name='적합'      align=right HeadBgColor='#F7DCBB' Value={Decode(ANS_PER1_$$,'0','',ANS_PER1_$$)} </C>
                                        <C> id='ANS_PER2_$$'  width=55    name='부적합'    align=right HeadBgColor='#F7DCBB' Value={Decode(ANS_PER2_$$,'0','',ANS_PER2_$$)} </C>
                                    </G>
                                </R>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 내용 조회 그리드 데이블 끝-->

<!-- 내용 조회 그리드 테이블 시작 (삭제예정)-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_EV_QSTANS" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:0px;">
                            <param name="DataID"           value="dsT_EV_QSTANS">
                            <param name="EdiTABLE"         value="true">
                            <param name="DragDropEnable"   value="true">
                            <param name="SortView"         value="Left">
                            <param name="VIEWSUMMARY"      value="0">
                            <param name="Format"           value="
                                <FC> id='DPT_NM'           width=120   name='구분'      align=left  </FC>
                                <FC> id='TOT_CNT'          width=60    name='대상인원'    align=right </FC>
                                <FC> id='DPT_CNT'          width=60    name='응답인원'  align=right </FC>
                                <G> name='응답률(%)'  HeadBgColor='#F7DCBB'
                                    <C> id='QST_ITEM_SNM'   width=70    name='A'        align=left  </C>
                                    <C> id='ANS_PER1'      width=70     name='B'        align=right </C>
                                    <C> id='ANS_PER2'      width=70     name='C'        align=right </C>
                                </G>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 내용 조회 그리드 데이블 끝-->

</form>
<!-- form 끝 -->

</body>
</html>