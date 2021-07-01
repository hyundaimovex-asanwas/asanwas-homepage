<!--
    ************************************************************************************
    * @Source         : vluc140.jsp                                                    *
    * @Description    : 참조평가자평가 PAGE                                            *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/06  |  오대성   | 최초작성                                               *
    * 2006/10/10  |  박인이   | 개발                                                   *
    * 2007/03/18  |  박인이   | 수정. (직무평가업무내용 추가)                          *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>참조평가자평가(vluc140)</title>
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

        // 성과평가
        var EVL_GBN = "2";
        var btnList = 'FFFFFFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

           //이곳에 해당 코딩을 입력 하세요

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

            // DataSet Clear
            dsT_EV_ACHTBL.ClearData();

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

            //Grid Style 적용
            cfStyleGrid(form1.grdT_EV_ACHTBL,0,"false","false");

            // 업무구분
            if (frameid == "vluc140") {
                // 인사평가
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/인사평가/성과평가/";

            }
            else {
                // 직무평가
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/교육관리/직무평가/성과평가/";
            }

            // 년도 및 회차를 조회하기 위해 COMMON의 YEARMONTHCMD를 사용
            dsT_EV_ESTINFO.DataId = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR01&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=2";
            dsT_EV_ESTINFO.Reset();

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

        /****************************************
         * 검색부의 필드 변경시 DataSet 초기화  *
         ***************************************/
        function fnc_FldChange() {

            dsT_EV_EVLIST_HD.ClearData();

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
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ACHTBL)    |
    | 3. 사용되는 Table List(T_EV_ACHTBL)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_ACHTBL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ESTINFO)   |
    | 3. 사용되는 Table List(T_EV_ESTINFO)          |
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


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ACHTBL Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_EV_ACHTBL.CountRow);
            form1.grdT_EV_ACHTBL.Focus();

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ACHTBL Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ACHTBL Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">
        if ( iCount == 0 )    {

            alert("평가적용기간이 아닙니다.");
            document.getElementById("resultMessage").innerText = '* 평가적용기간이 아닙니다.';

            dsT_EV_SCHCHG.ClearData();
            dsT_EV_ACHTBL.ClearData();

        } else {

            form1.txtEVL_YY_SHR.value    = dsT_EV_ESTINFO.NameValue(1, "EVL_YY");
            form1.txtEVL_FRQ_SHR.value   = dsT_EV_ESTINFO.NameValue(1, "EVL_FRQ");
            form1.txtREFENO_NO_SHR.value = '<%=box.get("SESSION_ENONO")%>';
            form1.txtREFENO_NM_SHR.value = '<%=box.get("SESSION_ENONM")%>';
            form1.txtREFDPT_NM_SHR.value = '<%=box.get("SESSION_DPTNM")%>';

            // 상단부 데이터 조회
            dsT_EV_SCHCHG.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc140.cmd.VLUC140CMD&S_MODE=SHR_00&GUBUN="+GUBUN+"&EVL_YY="+form1.txtEVL_YY_SHR.value+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+form1.txtEVL_FRQ_SHR.value+"&ENO_NO="+form1.txtREFENO_NO_SHR.value;
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

        var IPT_STDT = '';
        var IPT_ENDT = '';

        if ( iCount == 0 )    {

            IPT_STDT = dsT_EV_ESTINFO.NameValue(1, "IPT_STDT");
            IPT_ENDT = dsT_EV_ESTINFO.NameValue(1, "IPT_ENDT");

        } else {

            if (dsT_EV_SCHCHG.NameValue(1, "IPT_STDT") == "") {

                IPT_STDT = dsT_EV_ESTINFO.NameValue(1, "IPT_STDT");
                IPT_ENDT = dsT_EV_ESTINFO.NameValue(1, "IPT_ENDT");

            }
            else {

                IPT_STDT = dsT_EV_SCHCHG.NameValue(1, "IPT_STDT");
                IPT_ENDT = dsT_EV_SCHCHG.NameValue(1, "IPT_ENDT");
            }
        }

        EVL_YY  = form1.txtEVL_YY_SHR.value;
        EVL_FRQ = form1.txtEVL_FRQ_SHR.value;
        GBN     = form1.txtGBN.value;

        // DATASET 초기화
        fnc_Clear();

        dsT_EV_ACHTBL.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc140.cmd.VLUC140CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_FRQ="+EVL_FRQ+"&GBN="+GBN;
        dsT_EV_ACHTBL.Reset();

        // 오늘일자가 평가입력기간사이의 값이면 평가표 팝업 클릭 가능하도록 함
        if (IPT_STDT <= getToday() && IPT_ENDT >= getToday()) {
            ;
        }
        else {

            alert('평가입력기간이 아닙니다.');
            document.getElementById("resultMessage").innerText = '* 평가입력기간이 아닙니다.';
            form1.txtFLAG.value = "1";

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_SCHCHG Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_SCHCHG Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


    <!-- 그리드의 팝업필드 클릭시 -->
    <script language="javascript" for=grdT_EV_ACHTBL event=OnDblClick(Row,Colid)>

        var EVL_YY    = dsT_EV_ACHTBL.NameValue(Row, "EVL_YY");      //해당년도
        var EVL_FRQ   = dsT_EV_ACHTBL.NameValue(Row, "EVL_FRQ");     //회차
        var ENO_NO    = dsT_EV_ACHTBL.NameValue(Row, "ENO_NO");      //사번
        var ENO_NM    = dsT_EV_ACHTBL.NameValue(Row, "ENO_NM");      //성명
        var DPT_NM    = dsT_EV_ACHTBL.NameValue(Row, "DPT_NM");      //소속명
        var EVLENO_NO = dsT_EV_ACHTBL.NameValue(Row, "EVLENO_NO");   //평가자사번
        var REFENO_NO = form1.txtREFENO_NO_SHR.value;                //참조평가자사번
        var REFENO_NM = form1.txtREFENO_NM_SHR.value;                //참조평가자명
        var REF_GBN   = "0";                                         //참조평가자차수

        var revck    = null;

        // 평가기간이 아닌 경우 팝업창 뜨지 않도록 함.
        if (form1.txtFLAG.value == "1") {
        }
        else {

            // 1차 참조평가자인지 비교
            if (dsT_EV_ACHTBL.NameValue(Row, "REFENO_NO1") == form1.txtREFENO_NO_SHR.value) {
                REF_GBN = "1";
            }
            // 2차 참조평가자인지 비교
            else if (dsT_EV_ACHTBL.NameValue(Row, "REFENO_NO2") == form1.txtREFENO_NO_SHR.value) {
                REF_GBN = "2";
            }
            // 3차 참조평가자인지 비교
            else if (dsT_EV_ACHTBL.NameValue(Row, "REFENO_NO3") == form1.txtREFENO_NO_SHR.value) {
                REF_GBN = "3";
            }

            //modal폼으로 부터 받은 confirm의 점수를 받아 온다.
            url = "/hr/" + "vlu" + "/" + "vluc141.jsp?GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO+"&ENO_NM="+ENO_NM+"&DPT_NM="+DPT_NM+
                                                    "&EVLENO_NO="+EVLENO_NO+"&REFENO_NO="+REFENO_NO+"&REFENO_NM="+REFENO_NM+"&REF_GBN="+REF_GBN;

            // 역량평가표 화면 호출
            revck = window.showModalDialog(url, Colid, "dialogHeight:550px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if (revck == -1 || revck == null) {
                ;
            }
            else {

                var firstList = new Array ();
                firstList = revck.split(";");

                // 리턴한 점수를 해당 컬럼에 넣어줌
                if (firstList[0] == 0) {

                    dsT_EV_ACHTBL.NameValue(Row,"REF_PNT") = '미평가';

                }
                else {

                    dsT_EV_ACHTBL.NameValue(Row,"REF_PNT") = firstList[0];

                }
            }

            dsT_EV_ACHTBL.RowPosition = Row;
            form1.grdT_EV_ACHTBL.Focus();
        }

    </script>



<!--
**************************************************************
* BODY START
**************************************************************
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">참조평가자평가</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">참조평가자평가</font></td>
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
                                <col width="80 "></col>
                                <col width="40 "></col>
                                <col width="60 "></col>
                                <col width="40 "></col>
                                <col width="50 "></col>
                                <col width="110"></col>
                                <col width="60 "></col>
                                <col width="80 "></col>
                                <col width="80 "></col>
                                <col width=" "></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">해당년도</td>
                                <td class="padding2423">
                                    <input id=txtEVL_YY_SHR size="4" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">회차</td>
                                <td class="padding2423">
                                    <input id=txtEVL_FRQ_SHR size="2" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">소속</td>
                                <td class="padding2423">
                                    <input id=txtREFDPT_NM_SHR size="14" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">사번</td>
                                <td class="padding2423">
                                    <input id=txtREFENO_NO_SHR size="10" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">평가자</td>
                                <td class="padding2423">
                                    <input id=txtREFENO_NM_SHR size="10" class="input_ReadOnly" readonly>
                                </td>
                                <!-- Hidden Filed (구분 : '2'이면 참조평가자가 조건임)-->
                                <input type=hidden name=txtGBN value="2">
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
                        <object    id="grdT_EV_ACHTBL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"                  value="dsT_EV_ACHTBL">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="IndWidth"                value=0>
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='GROUP_NM'     width=60    name='평가그룹'      align=left   </C>
                                <C> id='HEAD_NM'      width=82    name='본부'          align=left   </C>
                                <C> id='DPT_NM'       width=82    name='소속'          align=left   </C>
                                <C> id='JOB_NM'       width=55    name='직위'          align=center </C>
                                <C> id='ENO_NO'       width=55    name='사번'          align=center </C>
                                <C> id='ENO_NM'       width=55    name='성명'          align=center </C>
                                <C> id='HIRG_YMD'     width=70    name='입사일'        align=center </C>
                                <C> id='DPA_YMD'      width=70    name='소속발령일'    align=center </C>
                                <C> id='EVLENO_NO'    width=70    name='평가자사번'    align=center </C>
                                <C> id='EVLENO_NM'    width=70    name='평가자성명'    align=center </C>
                                <C> id='SELF_PNT'     width=55    name='본인;평가점수' align=right  </C>
                                <C> id='REF_PNT'      width=55    name='평가점수'      align=right  </C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td class="searchState"><br>&nbsp;※ <u>해당 평가대상자 항목을 더블클릭하면 참조평가입력을 하실 수 있습니다.<u></td>
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

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 평가회차설정 테이블 -->
<object id="bndT_EV_ESTINFO" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_EV_ESTINFO">
    <Param Name="BindInfo", Value='
        <C>Col=EVL_YY      Ctrl=txtEVL_YY_SHR     Param=value </C>
        <C>Col=EVL_FRQ     Ctrl=txtEVL_FRQ_SHR    Param=value </C>
        <C>Col=ENO_NO      Ctrl=txtREFENO_NO_SHR  Param=value </C>
        <C>Col=ENO_NM      Ctrl=txtREFENO_NM_SHR  Param=value </C>
        <C>Col=DPT_NM      Ctrl=txtREFDPT_NM_SHR  Param=value </C>
    '>
</object>