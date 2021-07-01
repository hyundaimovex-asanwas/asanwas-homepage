<!--
    ************************************************************************************
    * @Source         : vlub040.jsp                                                    *
    * @Description    : 역량평가처리 PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/26  |  박인이   | 최초작성                                               *
    * 2007/03/16  |  박인이   | 수정. (직무평가업무내용 추가)                          *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>역량평가(vlub040)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

<%
    String GUBUN      = request.getParameter("GUBUN");          //업무구분
%>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'FFFFFFFT';
        var EVL_GBN = "1";

        //모달창으로 띄웠을 경우 구분하기 위해 사용 by DS
        var modal_yn = window.dialogArguments;

        var GUBUN   = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            // DATASET 초기화
            fnc_Clear();

            // 년도 및 회차를 조회하기 위해 COMMON의 YEARMONTHCMD를 사용
            dsT_EV_ESTINFO.dataid = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=1";
            dsT_EV_ESTINFO.reset();

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

            document.getElementById("resultMessage").innerText = ' ';

            dsT_EV_ESTINFO.ClearData();
            dsT_EV_SCHCHG.ClearData();
            dsT_EV_EVLIST_DT.ClearData();

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
            cfStyleGrid(form1.grdT_EV_EVLIST_DT,0,"false","right");

            if (modal_yn == null) {
                var frameid = window.external.GetFrame(window).FrameId;
            }

            // 업무구분
            if (frameid == "vlub040" || "<%=GUBUN%>" == "01") {
                // 인사평가
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/인사평가/역량평가/";

            }
            else {
                // 직무평가
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/교육관리/직무평가/역량평가/";
            }

            // 그리드에 개인별역량평가대상자설정 데이터 조회
            fnc_SearchList();

            form1.grdT_EV_EVLIST_DT.ColumnProp("{currow}", "Sort") = "false";
            form1.grdT_EV_EVLIST_DT.ColumnProp("DEGREE_GBN", "Sort") = "false";
            form1.grdT_EV_EVLIST_DT.ColumnProp("GROUP_CD", "Sort") = "false";
            form1.grdT_EV_EVLIST_DT.ColumnProp("HEAD_NM", "Sort") = "false";
            form1.grdT_EV_EVLIST_DT.ColumnProp("DPT_NM", "Sort") = "false";
            form1.grdT_EV_EVLIST_DT.ColumnProp("JOB_NM", "Sort") = "false";
            form1.grdT_EV_EVLIST_DT.ColumnProp("ENO_NO", "Sort") = "false";
            form1.grdT_EV_EVLIST_DT.ColumnProp("ENO_NM", "Sort") = "false";
            form1.grdT_EV_EVLIST_DT.ColumnProp("HIRG_YMD", "Sort") = "false";
            form1.grdT_EV_EVLIST_DT.ColumnProp("DPA_YMD", "Sort") = "false";

        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            if(modal_yn != null){
                window.close();
            } else {
                frame = window.external.GetFrame(window);
                frame.CloseFrame();
            }

        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

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
    | 2. 이름은 ds_ + 주요 테이블명(TEST_MAIN)      |
    | 3. 사용되는 Table List(TEST_MAIN)             |
    +----------------------------------------------->
    <Object ID="dsT_EV_ESTINFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_SCHCHG)    |
    | 3. 사용되는 Table List(T_EV_SCHCHG)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_SCHCHG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(TEST_MAIN)      |
    | 3. 사용되는 Table List(TEST_MAIN)             |
    +----------------------------------------------->
    <Object ID="dsT_EV_EVLIST_DT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">
        if ( iCount == 0 )    {

            alert("평가적용기간이 아닙니다.");
            document.getElementById("resultMessage").innerText = '* 평가적용기간이 아닙니다.';

        } else {

            form1.txtEVL_YY_SHR.value    = dsT_EV_ESTINFO.NameValue(1, "EVL_YY");
            form1.txtEVL_FRQ_SHR.value   = dsT_EV_ESTINFO.NameValue(1, "EVL_FRQ");
            form1.txtEVLENO_NO_SHR.value = '<%=box.get("SESSION_ENONO")%>';
            form1.txtEVLENO_NM_SHR.value = '<%=box.get("SESSION_ENONM")%>';
            form1.txtEVLDPT_NM_SHR.value = '<%=box.get("SESSION_DPTNM")%>';

            // 상단부 데이터 조회
            dsT_EV_SCHCHG.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub040.cmd.VLUB040CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+form1.txtEVL_YY_SHR.value+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+form1.txtEVL_FRQ_SHR.value+"&ENO_NO="+form1.txtEVLENO_NO_SHR.value;
            dsT_EV_SCHCHG.Reset();
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ESTINFO Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ESTINFO Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_SCHCHG Event="OnLoadCompleted(iCount)">

        var EVL_YY  = null;
        var EVL_FRQ = null;

        if ( iCount == 0 )    {

            form1.txtIPT_STDT_SHR.value = dsT_EV_ESTINFO.NameValue(1, "IPT_STDT");
            form1.txtIPT_ENDT_SHR.value = dsT_EV_ESTINFO.NameValue(1, "IPT_ENDT");

        } else {

            if (dsT_EV_SCHCHG.NameValue(1, "IPT_STDT") == "") {

                form1.txtIPT_STDT_SHR.value = dsT_EV_ESTINFO.NameValue(1, "IPT_STDT");
                form1.txtIPT_ENDT_SHR.value = dsT_EV_ESTINFO.NameValue(1, "IPT_ENDT");

            }
            else {

                form1.txtIPT_STDT_SHR.value = dsT_EV_SCHCHG.NameValue(1, "IPT_STDT");
                form1.txtIPT_ENDT_SHR.value = dsT_EV_SCHCHG.NameValue(1, "IPT_ENDT");
            }
        }


        EVL_YY  = form1.txtEVL_YY_SHR.value;
        EVL_FRQ = form1.txtEVL_FRQ_SHR.value;
        ENO_NO  = form1.txtEVLENO_NO_SHR.value;

        // 그리드 데이터 조회
        dsT_EV_EVLIST_DT.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub040.cmd.VLUB040CMD&S_MODE=SHR_02&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO;
        dsT_EV_EVLIST_DT.Reset();

        form1.grdT_EV_EVLIST_DT.Focus();

        // 오늘일자가 평가입력기간사이의 값이면 평가표 팝업 클릭 가능하도록 함
        if (form1.txtIPT_STDT_SHR.value <= getToday() &&
            form1.txtIPT_ENDT_SHR.value >= getToday()) {

            ;

        }
        else {

            alert('평가입력기간이 아닙니다.');
            document.getElementById("resultMessage").innerText = '* 평가입력기간이 아닙니다.';
            form1.txtFLAG.value = "1";

        }

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_EVLIST_DT Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_EV_EVLIST_DT.CountRow);

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_DT Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_DT Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-- 그리드의 팝업필드 클릭시 -->
    <script language="javascript" for=grdT_EV_EVLIST_DT event=OnDblClick(Row,Colid)>

        var EVL_YY     = form1.txtEVL_YY_SHR.value;
        var EVL_FRQ    = form1.txtEVL_FRQ_SHR.value;
        var IPT_STDT   = form1.txtIPT_STDT_SHR.value;
        var IPT_ENDT   = form1.txtIPT_ENDT_SHR.value;
        var EVLENO_NO  = form1.txtEVLENO_NO_SHR.value;
        var EVLENO_NM  = form1.txtEVLENO_NM_SHR.value;
        var GROUP_CD   = dsT_EV_EVLIST_DT.NameValue(Row, "GROUP_CD");
        var DEGREE_GBN = dsT_EV_EVLIST_DT.NameValue(Row, "DEGREE_GBN");
        var ENO_NO     = dsT_EV_EVLIST_DT.NameValue(Row, "ENO_NO");
        var ENO_NM     = dsT_EV_EVLIST_DT.NameValue(Row, "ENO_NM");
        var DPT_NM     = dsT_EV_EVLIST_DT.NameValue(Row, "DPT_NM");
        var UPDN_GBN   = dsT_EV_EVLIST_DT.NameValue(Row, "UPDN_GBN");

        var revck    = null;

        // 평가기간이 아닌 경우 팝업창 뜨지 않도록 함.
        if (form1.txtFLAG.value == "1") {
        }
        else {

            //modal폼으로 부터 받은 confirm의 평가자명을 받아 온다.
            url = "/hr/" + "vlu" + "/" + "vlub041.jsp?GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&IPT_STDT="+IPT_STDT+"&IPT_ENDT="+IPT_ENDT+
                                                              "&EVLENO_NO="+EVLENO_NO+"&EVLENO_NM="+EVLENO_NM+"&GROUP_CD="+GROUP_CD+"&DEGREE_GBN="+DEGREE_GBN+
                                                              "&ENO_NO="+ENO_NO+"&ENO_NM="+ENO_NM+"&DPT_NM="+DPT_NM+"&UPDN_GBN="+UPDN_GBN;

            // 역량평가표 화면 호출
            revck = window.showModalDialog(url, Colid, "dialogHeight:850px; dialogWidth:1080px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if (revck == -1 || revck == null) {
                ;
            }
            else {
                // 리턴한 역량평가표의 총점수를 해당 컬럼에 넣어줌
                dsT_EV_EVLIST_DT.NameValue(Row,"EVL_PNT") = revck;
            }

            dsT_EV_EVLIST_DT.RowPosition = Row;
            form1.grdT_EV_EVLIST_DT.focus();
        }

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">역량평가</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">역량평가</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image8" width="60" height="20" border="0" align="absmiddle"  onClick="fnc_Exit()"></a>
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
                                    <col width="60"></col>
                                    <col width="40 "></col>
                                    <col width="40 "></col>
                                    <col width="30 "></col>
                                    <col width="70 "></col>
                                    <col width="180"></col>
                                    <col width="40 "></col>
                                    <col width="80"></col>
                                    <col width="40 "></col>
                                    <col width="65 "></col>
                                    <col width="45 "></col>
                                    <col width="65 "></col>
                                </colgroup>
                            <tr>
                                <td align="center" class="searchState">평가년도</td>
                                <td class="padding2423"><input id=txtEVL_YY_SHR name=txtEVL_YY_SHR size="4" class="input_ReadOnly" readonly></td>
                                <td align="center" class="searchState">회차</td>
                                <td class="padding2423"><input id=txtEVL_FRQ_SHR name=txtEVL_FRQ_SHR size="2" class="input_ReadOnly" readonly></td>
                                <td align="center" class="searchState">평가기간</td>
                                <td class="padding2423">
                                    <input id=txtIPT_STDT_SHR name=txtIPT_STDT_SHR size="10" class="input_ReadOnly" readonly> ~
                                    <input id=txtIPT_ENDT_SHR name=txtIPT_ENDT_SHR size="10" class="input_ReadOnly" readonly></td>
                                <td align="center" class="searchState">소속</td>
                                <td class="padding2423"><input id=txtEVLDPT_NM_SHR name=txtEVLDPT_NM_SHR size="14" class="input_ReadOnly" readonly></td>
                                <td align="center" class="searchState">사번</td>
                                <td class="padding2423"><input id=txtEVLENO_NO_SHR name=txtEVLENO_NO_SHR size="8" class="input_ReadOnly" readonly></td>
                                <td align="center" class="searchState">평가자</td>
                                <td class="padding2423"><input id=txtEVLENO_NM_SHR name=txtEVLENO_NM_SHR size="8" class="input_ReadOnly" readonly></td>
                                <!-- Hidden Filed -->
                                <input type=hidden id=txtEVL_GBN_SHR  name=txtEVL_GBN_SHR>
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
                        <object    id="grdT_EV_EVLIST_DT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"                  value="dsT_EV_EVLIST_DT">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="ColSizing"               value="true">
                            <param name="IndWidth"                value=0>
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id={currow}       width=33    name='순번',         align=center </C>
                                <C> id='GROUP_NM'     width=75    name='평가그룹'      align=left   </C>
                                <C> id='HEAD_NM'      width=80    name='본부'          align=left   </C>
                                <C> id='DPT_NM'       width=80    name='소속'          align=left   </C>
                                <C> id='DEGREE_GBN'   width=60    name='차수구분'      align=center </C>
                                <C> id='JOB_NM'       width=75    name='직위'          align=center </C>
                                <C> id='ENO_NO'       width=75    name='사번'          align=center </C>
                                <C> id='ENO_NM'       width=75    name='성명'          align=center </C>
                                <C> id='HIRG_YMD'     width=75    name='입사일'        align=center </C>
                                <C> id='DPA_YMD'      width=75    name='소속발령일'    align=center </C>
                                <C> id='EVL_PNT'      width=75    name='평가점수'      align=right   sort='true'</C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td class="searchState"><br> * 해당 피평가자 항목을 더블클릭 하세요~! </td>
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