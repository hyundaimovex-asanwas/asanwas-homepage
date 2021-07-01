<!--
*****************************************************
* @source       : vlub120.jsp
* @description : 평가진행현황_역량 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/09/04      오대성        최초작성.
* 2007/03/16      박인이        수정. (직무평가업무내용 추가)
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>평가진행현황_역량(vlub120)</title>
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

        var btnList = 'TFFTFFFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var year = document.form1.txtEVL_YY_SHR.value;          //해당년도
            var frq  = document.form1.txtEVL_FRQ_SHR.value;         //회차

            var eno_no = document.form1.txtENO_NO_SHR.value;        //사번
            var dpt_cd = document.form1.txtDPT_CD_SHR.value;        //소속
            var group_cd = document.form1.cmbGROUP_CD_SHR.value;    //평가그룹
            var end_yn   = document.form1.chkEND_YN_SHR.checked;    //미완료자

            if(end_yn == true){
                checked = 'T';
            } else {
                checked = 'F';
            }

            cfCreateBar;

            //역량 평가 적용 결과 정보 조회
            trT_EV_EVLIST_HD.KeyValue = "SVL(O:dsT_EV_EVLIST_HD=dsT_EV_EVLIST_HD)";
            trT_EV_EVLIST_HD.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub120.cmd.VLUB120CMD&S_MODE=SHR_02&GUBUN="+GUBUN+"&EVL_YY="+year+"&EVL_FRQ="+frq+"&ENO_NO="+eno_no+"&DPT_CD="+dpt_cd+"&GROUP_CD="+group_cd+"&END_YN="+checked;
            trT_EV_EVLIST_HD.post();

            form1.grdT_EV_EVLIST_HD.Focus();

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
        function fnc_Save(s_mode) {

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

            //이곳에 해당 코딩을 입력 하세요

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_EV_EVLIST_HD.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_EV_EVLIST_HD.GridToExcel("역량평가진행현황_역량", '', 225);

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

            document.getElementById("txtENO_NO_SHR").value = '';
            document.getElementById("txtENO_NM_SHR").value = '';
            document.getElementById("txtDPT_CD_SHR").value = '';
            document.getElementById("txtDPT_NM_SHR").value = '';
            document.getElementById("cmbGROUP_CD_SHR").value = '';

            document.getElementById("resultMessage").innerText = ' ';
            dsT_EV_EVLIST_HD.ClearAll();

            // DataSet Clear
            dsT_EV_ESTINFO.ClearData();
            dsT_EV_TYPE.ClearData();

            document.form1.txtDPT_CD_SHR.focus();

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

            //Grid Style 적용
            cfStyleGrid(form1.grdT_EV_EVLIST_HD, 0, "false", "false");

            // 업무구분
            if (frameid == "vlub120") {
                // 인사평가
                GUBUN = "01";

                //평가그룹
                for( var i = 1; i <= dsCOMMON_EG.CountRow; i++ ) {

                    oOption       = document.createElement("OPTION");
                    oOption.value = dsCOMMON_EG.NameValue(i,"CODE");
                    oOption.text  = dsCOMMON_EG.NameValue(i,"CODE_NAME");
                    document.getElementById("cmbGROUP_CD_SHR").add(oOption);

                }

                document.getElementById("loctitle").innerText = "HOME/인사평가/역량평가/";

            }
            else {
                // 직무평가
                GUBUN = "02";

                var tempDS = fnc_GetDutyCd('DUTY2', '4');
                var oOption;

                for( i=1; i<=tempDS.CountRow; i++ ) {
                    oOption = document.createElement("OPTION");
                    oOption.value = tempDS.NameValue(i,"COMM_CD");
                    oOption.text = tempDS.NameValue(i,"COMM_NM");
                    document.getElementById("cmbGROUP_CD_SHR").add(oOption);
                }

                document.getElementById("loctitle").innerText = "HOME/교육관리/직무평가/역량평가/";

            }

            // 년도 및 회차를 조회하기 위해 COMMON의 YEARMONTHCMD를 사용
            dsT_EV_ESTINFO.dataid = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=1";
            dsT_EV_ESTINFO.reset();

        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /****************************************
         * 검색부의 필드 변경시 관련컬럼 초기화 *
         ***************************************/
        function fnc_FldChange() {

            if (document.getElementById("txtENO_NO_SHR").value == '') {
                document.getElementById("txtENO_NM_SHR").value = '';
            }

            if (document.getElementById("txtDPT_CD_SHR").value == '') {
                document.getElementById("txtDPT_NM_SHR").value = '';
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
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ESTINFO)   |
    | 3. 사용되는 Table List(T_EV_ESTINFO)          |
    +----------------------------------------------->
    <Object ID="dsT_EV_ESTINFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 조회용 DataSet                                 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_EV_TYPE)        |
    | 3. 사용되는 Table List(dsT_EV_TYPE,dsT_EV_ESTINFO)|
    +--------------------------------------------------->
    <Object ID="dsT_EV_TYPE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                           |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_EVLIST_HD)                       |
    | 3. 사용되는 Table List(T_EV_EVLIST_HD,) |
    +------------------------------------------------------------------>
    <Object ID="dsT_EV_EVLIST_HD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 평가그룹 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_EG"/>
       <jsp:param name="CODE_GUBUN"    value="EG"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_EV_EVLIST_HD                  |
    | 3. Table List : T_EV_EVLIST_HD              |
    +----------------------------------------------->
    <Object ID ="trT_EV_EVLIST_HD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
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

            //alert("연도별 평가 회차 정보 또는 평가 기준 구조 설정이\n 되어 있지 않습니다.");
            //document.getElementById("resultMessage").innerText = '* 연도별 평가 회차 정보 또는 평가 기준 구조 설정이 되어 있지 않습니다.';
            alert("평가적용기간이 아닙니다.");
            document.getElementById("resultMessage").innerText = '* 평가적용기간이 아닙니다.';

            dsT_EV_TYPE.ClearData();

            dsT_EV_ESTINFO.ClearData();
            dsT_EV_TYPE.ClearData();

        } else {

            form1.txtEVL_YY_SHR.value    = dsT_EV_ESTINFO.NameValue(1, "EVL_YY");
            form1.txtEVL_FRQ_SHR.value   = dsT_EV_ESTINFO.NameValue(1, "EVL_FRQ");

            dsT_EV_TYPE.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub120.cmd.VLUB120CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+form1.txtEVL_YY_SHR.value;
            dsT_EV_TYPE.reset();

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
    <Script For=dsT_EV_TYPE Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            alert("평가구조설정이 되어 있지 않습니다.");
            document.getElementById("resultMessage").innerText = '* 평가구조설정이 되어 있지 않습니다.';

        } else {

            //Grid Setting
            if(dsT_EV_TYPE.NameValue(1,"DOWN_YN") == '0') {

                grdT_EV_EVLIST_HD.ColumnProp('DOWN_01','Show') = false;
                grdT_EV_EVLIST_HD.ColumnProp('DOWN_02','Show') = false;
                grdT_EV_EVLIST_HD.ColumnProp('DOWN_03','Show') = false;

            } else {

                if(dsT_EV_TYPE.NameValue(1,"DOWN_CNT") == 1) {
                    grdT_EV_EVLIST_HD.ColumnProp('DOWN_01','Show') = true;
                    grdT_EV_EVLIST_HD.ColumnProp('DOWN_02','Show') = false;
                    grdT_EV_EVLIST_HD.ColumnProp('DOWN_03','Show') = false;
                } else if(dsT_EV_TYPE.NameValue(1,"DOWN_CNT") == 2) {
                    grdT_EV_EVLIST_HD.ColumnProp('DOWN_01','Show') = true;
                    grdT_EV_EVLIST_HD.ColumnProp('DOWN_02','Show') = true;
                    grdT_EV_EVLIST_HD.ColumnProp('DOWN_03','Show') = false;
                } else if(dsT_EV_TYPE.NameValue(1,"DOWN_CNT") == 3) {
                    grdT_EV_EVLIST_HD.ColumnProp('DOWN_01','Show') = true;
                    grdT_EV_EVLIST_HD.ColumnProp('DOWN_02','Show') = true;
                    grdT_EV_EVLIST_HD.ColumnProp('DOWN_03','Show') = true;
                }

            }

            if(dsT_EV_TYPE.NameValue(1,"UP_YN") == '0') {

                grdT_EV_EVLIST_HD.ColumnProp('UP_01','Show') = false;
                grdT_EV_EVLIST_HD.ColumnProp('UP_02','Show') = false;
                grdT_EV_EVLIST_HD.ColumnProp('UP_03','Show') = false;

            } else {
                if(dsT_EV_TYPE.NameValue(1,"UP_CNT") == 1) {

                    grdT_EV_EVLIST_HD.ColumnProp('UP_01','Show') = true;
                    grdT_EV_EVLIST_HD.ColumnProp('UP_02','Show') = false;
                    grdT_EV_EVLIST_HD.ColumnProp('UP_03','Show') = false;
                } else if(dsT_EV_TYPE.NameValue(1,"UP_CNT") == 2) {
                    grdT_EV_EVLIST_HD.ColumnProp('UP_01','Show') = true;
                    grdT_EV_EVLIST_HD.ColumnProp('UP_02','Show') = true;
                    grdT_EV_EVLIST_HD.ColumnProp('UP_03','Show') = false;
                } else if(dsT_EV_TYPE.NameValue(1,"UP_CNT") == 3) {
                    grdT_EV_EVLIST_HD.ColumnProp('UP_01','Show') = true;
                    grdT_EV_EVLIST_HD.ColumnProp('UP_02','Show') = true;
                    grdT_EV_EVLIST_HD.ColumnProp('UP_03','Show') = true;
                }

            }

            document.form1.txtDPT_CD_SHR.focus();
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

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_TYPE Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_EVLIST_HD Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_HD Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리      |
    +------------------------------>
    <script for=trT_EV_EVLIST_HD event="OnSuccess()">

    </script>

    <!--------------------------+
    | Transaction Failure 처리       |
    +--------------------------->
    <script for=trT_EV_EVLIST_HD event="OnFail()">

        cfErrorMsg(this);

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">평가진행현황_역량</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">평가진행현황_역량</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_CancelOver.gif',0)"><img src="/images/button/btn_CancelOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
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
                                <col width="35"></col>
                                <col width="35"></col>
                                <col width="25"></col>
                                <col width="20"></col>
                                <col width="55"></col>
                                <col width="90"></col>
                                <col width="30"></col>
                                <col width="125"></col>
                                <col width="30"></col>
                                <col width="145"></col>
                                <col width="5"></col>
                                <col width="50"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">년도</td>
                                <td class="padding2423"><input id=txtEVL_YY_SHR name=txtEVL_YY_SHR size="4" class="input_ReadOnly" readonly></td>
                                <td align="right" class="searchState">회차</td>
                                <td class="padding2423"><input id=txtEVL_FRQ_SHR name=txtEVL_FRQ_SHR size="2" class="input_ReadOnly" readonly></td>
                                <td align="right" class="searchState">평가그룹</td>
                                <td class="padding2423">
                                    <select id="cmbGROUP_CD_SHR" name="cmbGROUP_CD_SHR" style="WIDTH: 100%" onChange="fnc_SearchList()">
                                        <option value=''>전 체</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">소속</td>
                                <td class="padding2423"><input id=txtDPT_CD_SHR name=txtDPT_CD_SHR size="3"  maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
                                    <input id=txtDPT_NM_SHR name=txtDPT_NM_SHR size="10" class="input_ReadOnly" readonly> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image21','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image21" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')"></a>
                                </td>
                                <td align="right" class="searchState">사번</td>
                                <td class="padding2423"><input id=txtENO_NO_SHR name=txtENO_NO_SHR size="8" maxlength="10" style="ime-mode:disabled" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','1','1');">
                                    <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="10" class="input_ReadOnly" readonly> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image20" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
                                </td>
                                <td align="right" class="padding2423">
                                    <input type="checkbox" name="chkEND_YN_SHR" id=chkEND_YN_SHR style="border:0" align="absmiddle">
                                </td>
                                <td align="left" class="searchState">미완료자</td>
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
                    <td align="right">&nbsp;</td>
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
                        <object    id="grdT_EV_EVLIST_HD" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"                value="dsT_EV_EVLIST_HD">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"        value="false">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"            value=0>
                            <param name="Format"                value="
                                <FC> id='GROUP_NM'      width=90        name='평가그룹'       align=center Suppress=1 show=false</FC>
                                <FC> id='HEAD_NM'       width=90        name='본부'           align=center Suppress=1 </FC>
                                <FC> id='DPT_NM'        width=90        name='소속'           align=center Suppress=1 </FC>
                                <FC> id='JOB_NM'        width=49        name='직위'           align=center Suppress=1 </FC>
                                <FC> id='ENO_NO'        width=60        name='사번',          align=center Suppress=1 </FC>
                                <FC> id='ENO_NM'        width=50        name='성명'           align=center Suppress=1 </FC>
                                <C>  id='DOWN_01'       width=220       name='1차평가'        align=left   </C>
                                <C>  id='DOWN_02'       width=220       name='2차평가'        align=left   </C>
                                <C>  id='DOWN_03'       width=220       name='3차평가'        align=left   </C>
                                <C>  id='UP_01'         width=220       name='상향1차평가'    align=left   </C>
                                <C>  id='UP_02'         width=220       name='상향2차평가'    align=left   </C>
                                <C>  id='UP_03'         width=220       name='상향3차평가'    align=left   </C>
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