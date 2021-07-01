<!--
    ************************************************************************************
    * @Source         : vlud090.jsp                                                    *
    * @Description    : 개인별평가결과현황 PAGE                                        *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/12/05  |  박인이   | 최초작성                                               *
    * 2007/03/19  |  박인이   | 수정. (직무평가업무내용 추가)                          *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>개인별평가결과현황(vlud090)</title>
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

        var btnList = 'TFFTFFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var EVL_YY1 = form1.txtEVL_YY1_SHR.value;
            var EVL_YY2 = form1.txtEVL_YY2_SHR.value;
            var ENO_NO  = form1.txtENO_NO_SHR.value;

            // 조회시 각 필드의 유효성체크
            if (!fnc_SearchItemCheck()) {
                return;
            }

            // 그리드 데이터 조회 시
            form1.txtFLAG.value = "1";

            dsT_EV_TYPE.ClearData();

            dsT_EV_TYPE.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.d.vlud090.cmd.VLUD090CMD&S_MODE=SHR_00&GUBUN="+GUBUN+"&EVL_YY1="+EVL_YY1+"&EVL_YY2="+EVL_YY2;
            dsT_EV_TYPE.Reset();

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

 			var EVL_YY1 = form1.txtEVL_YY1_SHR.value;
            var EVL_YY2 = form1.txtEVL_YY2_SHR.value;
            var ENO_NO  = form1.txtENO_NO_SHR.value;

			params = "GUBUN=" + GUBUN + "&EVL_YY1="+EVL_YY1 + "&EVL_YY2="+EVL_YY2+"&ENO_NO="+ENO_NO;

			var url = "vlud090_PV.jsp?"+params;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            //이곳에 해당 코딩을 입력 하세요

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

            form1.txtEVL_YY1_SHR.value = getToday().substr(0,4);
            form1.txtEVL_YY2_SHR.value = getToday().substr(0,4);

            document.getElementById("txtENO_NO_SHR").value = '';
            document.getElementById("txtENO_NM_SHR").value = '';
            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_EV_TYPE.ClearData();
            dsT_EV_ABLRST.ClearData();

            document.form1.txtENO_NO_SHR.focus();

        }

        /******************************
         * 11. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            if (form1.txtEVL_YY1_SHR.value == "") {
                alert("시작년도는 필수입력사항입니다.");
                form1.txtEVL_YY1_SHR.focus();
                return false;
            }

            if (form1.txtEVL_YY2_SHR.value == "") {
                alert("종료년도는 필수입력사항입니다.");
                form1.txtEVL_YY2_SHR.focus();
                return false;
            }


            if (form1.txtENO_NO_SHR.value == "") {
                alert("사번은 필수입력사항입니다.");
                form1.txtENO_NO_SHR.focus();
                return false;
            }

            if( !cfCheckYearTerm('txtEVL_YY1_SHR','txtEVL_YY1_SHR','txtEVL_YY2_SHR') )
                return false;
            else
                return true;

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

            var EVL_YY1  = null;
            var EVL_YY2  = null;

            //Grid Style 적용
            cfStyleGrid(form1.grdT_EV_ABLRST,15,"false","false");

            form1.txtEVL_YY1_SHR.value = getToday().substr(0,4);
            form1.txtEVL_YY2_SHR.value = getToday().substr(0,4);

            EVL_YY1 = form1.txtEVL_YY1_SHR.value;
            EVL_YY2 = form1.txtEVL_YY2_SHR.value;

            // Form Load 시
            form1.txtFLAG.value = "0";

            // 업무구분
            if (frameid == "vlud090") {
                // 인사평가
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/인사평가/평가정보/";

            }
            else {
                // 직무평가
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/교육관리/직무평가/평가정보/";
            }

            // DATASET 초기화
            fnc_Clear();

            dsT_EV_TYPE.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.d.vlud090.cmd.VLUD090CMD&S_MODE=SHR_00&GUBUN="+GUBUN+"&EVL_YY1="+EVL_YY1+"&EVL_YY2="+EVL_YY2;
            dsT_EV_TYPE.Reset();

            form1.txtEVL_YY1_SHR.focus();

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
         * 구분필드 값 변경시 그리드 컬럼 SETTING 처리 부분  *
         ****************************************************/
        function fnc_ChangeColumn() {

            var ABL_CNT = dsT_EV_TYPE.NameValue(1, "ABL_CNT");
            var ACH_CNT = dsT_EV_TYPE.NameValue(1, "ACH_CNT");

            // 역량평가
            // 그리드에서 역량평가 차수만큼 역량평가 관련컬럼을 보여준다.
            if (ABL_CNT == '1') {

                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD11", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD12", "Show") = "false";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD13", "Show") = "false";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD14", "Show") = "false";

            }
            else if (ABL_CNT == '2') {

                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD11", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD12", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD13", "Show") = "false";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD14", "Show") = "false";

            }
            else if (ABL_CNT == '3') {

                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD11", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD12", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD13", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD14", "Show") = "false";

            }
            else if (ABL_CNT == '4') {

                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD11", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD12", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD13", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD14", "Show") = "true";

            }

            // 성과평가
            // 그리드에서 성과평가 차수만큼 성과평가 관련컬럼을 보여준다.
            if (ACH_CNT == '1') {

                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD21", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD22", "Show") = "false";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD23", "Show") = "false";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD24", "Show") = "false";

            }
            else if (ACH_CNT == '2') {

                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD21", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD22", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD23", "Show") = "false";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD24", "Show") = "false";

            }
            else if (ACH_CNT == '3') {

                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD21", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD22", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD23", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD24", "Show") = "false";

            }
            else if (ACH_CNT == '4') {

                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD21", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD22", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD23", "Show") = "true";
                form1.grdT_EV_ABLRST.ColumnProp("FINAL_GRD24", "Show") = "true";

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
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ABLRST)    |
    | 3. 사용되는 Table List(T_EV_ABLRST)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_ABLRST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_TYPE)      |
    | 3. 사용되는 Table List(T_EV_TYPE)             |
    +----------------------------------------------->
    <Object ID="dsT_EV_TYPE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_EV_ABLRST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_EV_ABLRST.CountRow);

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_TYPE Event="OnLoadCompleted(iCount)">

        var EVL_YY1 = form1.txtEVL_YY1_SHR.value;
        var EVL_YY2 = form1.txtEVL_YY2_SHR.value;
        var ENO_NO  = form1.txtENO_NO_SHR.value;

        if (iCount < 1) {

            alert("평가구조설정이 되어 있지 않습니다.");
            document.getElementById("resultMessage").innerText = '* 평가구조설정이 되어 있지 않습니다.';

            dsT_EV_TYPE.ClearData();
            dsT_EV_ABLRST.ClearData();

        }
        else {

            // 구분값에 따라 그리드에 역량평가/성과평가 관련 컬럼이 보여진다.
            fnc_ChangeColumn();

            if (form1.txtFLAG.value == "1") {

                dsT_EV_ABLRST.ClearData();

                dsT_EV_ABLRST.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.d.vlud090.cmd.VLUD090CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY1="+EVL_YY1+"&EVL_YY2="+EVL_YY2+"&ENO_NO="+ENO_NO;
                dsT_EV_ABLRST.Reset();

                form1.grdT_EV_ABLRST.Focus();
            }
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_TYPE Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">개인별평가결과현황</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">개인별평가결과현황</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image8" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

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
                                <col width="150"></col>
                                <col width="50"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">해당년도&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtEVL_YY1_SHR" name="txtEVL_YY1_SHR" size="4" maxlength="4" style="ime-mode:disabled" onKeyPress="cfNumberCheck();" onChange="if(!cfCheckYearTerm('txtEVL_YY1_SHR','txtEVL_YY1_SHR','txtEVL_YY2_SHR')) return;">년 ~ <input id="txtEVL_YY2_SHR" name="txtEVL_YY2_SHR" size="4" maxlength="4" style="ime-mode:disabled" onKeyPress="cfNumberCheck();" onChange="if(!cfCheckYearTerm('txtEVL_YY2_SHR','txtEVL_YY1_SHR','txtEVL_YY2_SHR')) return;">년
                                </td>
                                <td align="right" class="searchState">사번&nbsp;</td>
                                <td class="padding2423"><input id=txtENO_NO_SHR name=txtENO_NO_SHR size="9" maxlength="9" style="ime-mode:disabled" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();  cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');"> <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="16" class="input_ReadOnly" readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image20" width="21" height="20" border="0" align="absmiddle"   onclick="fnc_empl2Popup('txtENO_NO_SHR','txtENO_NM_SHR', '1')"></a>
                                <input type=hidden name=txtFLAG>
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
                        <object    id="grdT_EV_ABLRST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"               value="dsT_EV_ABLRST">
                            <param name="EdiTABLE"             value="false">
                            <param name="DragDropEnable"       value="true">
                            <param name="SortView"             value="Left">
                            <param name="ColSizing"            value="true">
                            <param name="FixSizing"            value="true">
                            <param name="VIEWSUMMARY"          value=0>
                            <param name="Format"               value="
                                <FC> id='EVL_YY'               width=95    name='년도'     align=center </FC>
                                <G> name='역량평가'   HeadBgColor='#F7DCBB'
                                    <C> id='FINAL_GRD11'       width=95    name='1회차'    align=center </C>
                                    <C> id='FINAL_GRD12'       width=95    name='2회차'    align=center </C>
                                    <C> id='FINAL_GRD13'       width=95    name='3회차'    align=center show=false </C>
                                    <C> id='FINAL_GRD14'       width=95    name='4회차'    align=center show=false </C>
                                </G>
                                <G> name='성과평가'   HeadBgColor='#F7DCBB'
                                    <C> id='FINAL_GRD21'       width=95    name='1회차'     align=center </C>
                                    <C> id='FINAL_GRD22'       width=95    name='2회차'     align=center show=false </C>
                                    <C> id='FINAL_GRD23'       width=95    name='3회차'     align=center show=false </C>
                                    <C> id='FINAL_GRD24'       width=95    name='4회차'     align=center show=false </C>
                                </G>
                                <G> name='종합평가'   HeadBgColor='#F7DCBB'
                                    <C> id='FINAL_GRD31'       width=95    name='1회차'     align=center </C>
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
<!-- 내용 조회 그리드 테이블 끝-->

</form>
<!-- form 끝 -->

</body>
</html>