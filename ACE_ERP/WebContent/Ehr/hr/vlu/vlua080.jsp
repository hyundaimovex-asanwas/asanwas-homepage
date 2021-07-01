<!--
    ************************************************************************************
    * @Source         : vlua080.jsp                                                    *
    * @Description    : 달성도배점설정 PAGE                                            *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/20  |  박인이   | 최초작성                                               *
    * 2007/03/15  |  박인이   | 수정. (직무평가업무내용 추가)                          *
    ************************************************************************************
-->
<%@ page contentType="text/html;charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>달성도배점설정(vlua080)</title>
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

        var btnList = 'TTTTFFTT';
        var year = getToday().substr(0, 4);

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            // DATASET  초기화
            fnc_Clear();

            dsT_EV_ACHPNT.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua080.cmd.VLUA080CMD&S_MODE=SHR&GUBUN="+GUBUN+"&EVL_YY="+form1.selEVL_YY_SHR.value;
            dsT_EV_ACHPNT.Reset();

            form1.grdT_EV_ACHPNT.Focus();

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

            // 저장시 각 필드의 유효성체크
            if (!fnc_SaveItemCheck()) {
                return;
            }

            trT_EV_ACHPNT.KeyValue = "tr01(I:SAV=dsT_EV_ACHPNT)";
            trT_EV_ACHPNT.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua080.cmd.VLUA080CMD&S_MODE=SAV";
            trT_EV_ACHPNT.post();

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

            if (form1.selEVL_YY_SHR.value != year) {
                alert("해당년도 이외의 자료는 신규 생성 할 수 없습니다!");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_07');
                document.form1.selEVL_YY_SHR.focus();
                return;
            }

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_EV_ACHPNT.CountColumn == 0) {
                dsT_EV_ACHPNT.setDataHeader("GUBUN:STRING, EVL_YY:STRING:KEYVALUETYPE:NORMALKEY, RATE_OVER:INT:KEYVALUETYPE:NORMALKEY, RATE_UNDER:INT, ACH_PNT:INT, GAUGE_THM:STRING, NONGAUGE_THM:STRING");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_EV_ACHPNT.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_EV_ACHPNT.setColumn(form1.grdT_EV_ACHPNT.getColumnID(0));

            // KEY 필드는 신규시 입력 가능
            form1.txtEVL_YY.readOnly    = true;
            form1.txtRATE_OVER.readOnly = false;

            form1.txtGUBUN.value  = GUBUN;
            form1.txtEVL_YY.value = form1.selEVL_YY_SHR.value;

            form1.txtRATE_OVER.focus();
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
            var status = 0;

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_EV_ACHPNT.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            if (form1.selEVL_YY_SHR.value != year) {
                alert("해당년도 이외의 자료는 삭제 할 수 없습니다!");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_08');
                document.form1.selEVL_YY_SHR.focus();
                return;
            }

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("달성율 [" + dsT_EV_ACHPNT.ColumnString(dsT_EV_ACHPNT.RowPosition,3) + "] ~ [" + dsT_EV_ACHPNT.ColumnString(dsT_EV_ACHPNT.RowPosition,4) + "] 자료를 제거하시겠습니까?") == false) return;

            status = dsT_EV_ACHPNT.RowStatus(dsT_EV_ACHPNT.RowPosition);

            dsT_EV_ACHPNT.DeleteRow(dsT_EV_ACHPNT.RowPosition);

            if (status != 1) {
                trT_EV_ACHPNT.KeyValue = "tr01(I:SAV=dsT_EV_ACHPNT)";
                trT_EV_ACHPNT.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua080.cmd.VLUA080CMD&S_MODE=DEL";
                trT_EV_ACHPNT.post();
            }

            bnd.ActiveBind = false;

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_EV_ACHPNT.SetColumn(form1.grdT_EV_ACHPNT.GetColumnID(0));
            form1.grdT_EV_ACHPNT.Focus();

            bnd.ActiveBind = true;

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

            document.getElementById("resultMessage").innerText = ' ';

            dsT_EV_ACHPNT.ClearData();

            fnc_ColEnabled('D');

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
            var i = 0;
            var j = 0;

            // DataSet의 변경 여부 확인
            if ( dsT_EV_ACHPNT.IsUpdated ) {

                if (form1.selEVL_YY_SHR.value != year) {
                    alert("해당 년도 이외의 자료는 저장 및 수정이 불가합니다!");
                    fnc_Message(document.getElementById("resultMessage"), 'MSG_06');
                    document.form1.selEVL_YY_SHR.focus();
                    return;
                }

                for( i = 1; i <= dsT_EV_ACHPNT.CountRow; i++ ) {
                    if ( dsT_EV_ACHPNT.RowStatus(i) == 1 ||
                         dsT_EV_ACHPNT.RowStatus(i) == 3 ) {

                        if ( dsT_EV_ACHPNT.RowStatus(i) == 1) {
                           form1.txtEVL_YY.readOnly    = false;
                           form1.txtRATE_OVER.readOnly = false;
                        }

                        // 해당년도
                        if( dsT_EV_ACHPNT.NameValue(i, "EVL_YY") == '' ) {
                            alert("해당년도는 필수 입력사항입니다.");
                            dsT_EV_ACHPNT.RowPosition = i;
                            form1.txtEVL_YY.focus();
                            return false;
                        }

                        // 달성율(이상)
                        if( dsT_EV_ACHPNT.NameValue(i, "RATE_OVER") < 0) {
                            alert("달성율(이상)은 필수 입력사항입니다.");
                            dsT_EV_ACHPNT.RowPosition = i;
                            form1.txtRATE_OVER.focus();
                            return false;
                        }

                        // 달성율(미만)
                        if( dsT_EV_ACHPNT.NameValue(i, "RATE_UNDER") <= 0) {
                            alert("달성율(미만)은 필수 입력사항입니다.");
                            dsT_EV_ACHPNT.RowPosition = i;
                            form1.txtRATE_UNDER.focus();
                            return false;
                        }

                        // 배점
                        if( dsT_EV_ACHPNT.NameValue(i, "ACH_PNT") <= 0) {
                            alert("배점은 필수 입력사항입니다..");
                            dsT_EV_ACHPNT.RowPosition = i;
                            form1.txtACH_PNT.focus();
                            return false;
                        }

                        // 달성율(이상)과 달성율(미만)의 From ~ To 체크
                        if (new Number(dsT_EV_ACHPNT.NameValue(i, "RATE_OVER")) > new Number(dsT_EV_ACHPNT.NameValue(i, "RATE_UNDER"))) {
                                    alert("해당 달성율(이상)의 값이 달성율(미만)보다 큰 값입니다.\n다시 입력하시기 바랍니다.");
                                    dsT_EV_ACHPNT.RowPosition = i;
                                    form1.txtRATE_OVER.focus();
                                    return false;
                        }

                        for ( j = 1;  j <= dsT_EV_ACHPNT.CountRow; j++ ) {
                            if (j != i) {
                                if (new Number(dsT_EV_ACHPNT.NameValue(j, "RATE_OVER")) <= new Number(dsT_EV_ACHPNT.NameValue(i, "RATE_OVER")) &&
                                    new Number(dsT_EV_ACHPNT.NameValue(j, "RATE_UNDER")) > new Number(dsT_EV_ACHPNT.NameValue(i, "RATE_OVER"))) {
                                    alert("해당 달성율(이상)의 값이 " + j + " 번째 레코드 달성율사이의 값입니다.\n다시 입력하시기 바랍니다.");
                                    dsT_EV_ACHPNT.RowPosition = i;
                                    form1.txtRATE_OVER.focus();
                                    return false;
                                }

                                if (new Number(dsT_EV_ACHPNT.NameValue(j, "RATE_OVER")) < new Number(dsT_EV_ACHPNT.NameValue(i, "RATE_UNDER")) &&
                                    new Number(dsT_EV_ACHPNT.NameValue(j, "RATE_UNDER")) >= new Number(dsT_EV_ACHPNT.NameValue(i, "RATE_UNDER"))) {
                                    alert("해당 달성율(미만)의 값이 " + j + " 번째 레코드 달성율사이의 값입니다.\n다시 입력하시기 바랍니다.");
                                    dsT_EV_ACHPNT.RowPosition = i;
                                    form1.txtRATE_UNDER.focus();
                                    return false;
                                }

                                if (new Number(dsT_EV_ACHPNT.NameValue(j, "RATE_OVER")) > new Number(dsT_EV_ACHPNT.NameValue(i, "RATE_OVER")) &&
                                    new Number(dsT_EV_ACHPNT.NameValue(j, "RATE_UNDER")) <= new Number(dsT_EV_ACHPNT.NameValue(i, "RATE_UNDER"))) {
                                    alert("해당 달성율(미만)의 값이 " + j + " 번째 레코드 달성율(미만)보다 큽니다.\n다시 입력하시기 바랍니다.");
                                    dsT_EV_ACHPNT.RowPosition = i;
                                    form1.txtRATE_UNDER.focus();
                                    return false;
                                }
                            }
                        }
                    }
                }
            }
            else {

                fnc_Message(document.getElementById("resultMessage"), "MSG_04");

                return false;

            }

            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style 적용
            cfStyleGrid(form1.grdT_EV_ACHPNT,15,"false","false");

            getSelYy2('selEVL_YY_SHR');

            form1.selEVL_YY_SHR.value = getToday().cut(4,6);

            fnc_ColEnabled('D');

            // 업무구분
            if (frameid == "vlua080") {
                // 인사평가
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/인사평가/평가기준정보/";

            }
            else {
                // 직무평가
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/교육관리/직무평가/평가기준정보/";
            }

            fnc_SearchList();

            form1.selEVL_YY_SHR.focus();

        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_EV_ACHPNT.IsUpdated)
            {
                if (!fnc_ExitQuestion()) return;
            }

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }



        /***************************************************
         * 달성율(이상)의 값이 ''일 때 0으로 인식하도록 함 *
         **************************************************/
        function fncInitRateOver() {

            if (form1.txtRATE_OVER.value == '')  {
                form1.txtRATE_OVER.value = 0;
                form1.txtRATE_UNDER.focus();
            }
        }

        /***************************************
         * 입력부의 컬럼의 Disabled 속성 바꿈  *
         ***************************************/
        function fnc_ColEnabled(prop) {
            // 해당 컬럼의 속성을 Enabled로 변경
            if (prop == 'E') {
                form1.txtRATE_UNDER.disabled   = false;
                form1.txtACH_PNT.disabled      = false;
                form1.txtGAUGE_THM.disabled    = false;
                form1.txtNONGAUGE_THM.disabled = false;
            }
            else if (prop == 'D') {
                form1.txtRATE_UNDER.disabled   = true;
                form1.txtACH_PNT.disabled      = true;
                form1.txtGAUGE_THM.disabled    = true;
                form1.txtNONGAUGE_THM.disabled = true;
            }
        }

        //전년도 기준 복사
        function fnc_Yearcopy(){

   			if( ! confirm("전년도 기준을 복사하시겠습니까?") ){
				return false;
			}

            //달성도배점 데이터 유무 조회
            dsT_EV_ACHPNT_01.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua080.cmd.VLUA080CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+form1.selEVL_YY_SHR.value;
            dsT_EV_ACHPNT_01.reset();

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
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ACHPNT)    |
    | 3. 사용되는 Table List(T_EV_ACHPNT)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_ACHPNT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_ACHPNT_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr + 주요 테이블명(T_EV_ACHPNT)     |
    | 3. 사용되는 Table List(T_EV_ACHPNT)           |
    +----------------------------------------------->
    <Object ID ="trT_EV_ACHPNT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EV_ACHPNT)">
    </Object>

    <Object ID ="trT_EV_ACHPNT_01" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <script  for=grdT_EV_ACHPNT event=OnClick(row,colid)>

        if (form1.selEVL_YY_SHR.value == year) {

            // 신규인 경우에만 해당년도, 달성율(이상) 수정 가능
            if( dsT_EV_ACHPNT.RowStatus(row) == 1 ) {

                // 해당년도, 달성율(이상)에 관한 키 수정 가능
                form1.txtEVL_YY.readOnly    = false;
                form1.txtRATE_OVER.readOnly = false;

            } else {

                // 신규가 아닌 경우 해당년도, 달성율(이상)에 관한 키 수정 불가
                form1.txtEVL_YY.readOnly    = true;
                form1.txtRATE_OVER.readOnly = true;
            }

        }

    </script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ACHPNT Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            // 조회시 해당년도, 달성율(이상)에 관한 키 수정 불가
            form1.txtEVL_YY.readOnly    = true;
            form1.txtRATE_OVER.readOnly = true;

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_EV_ACHPNT.CountRow);

            if (form1.selEVL_YY_SHR.value == year) {

                form1.txtEVL_YY.readOnly       = false;
                form1.txtRATE_OVER.readOnly    = false;
                form1.txtRATE_UNDER.readOnly   = false;
                form1.txtACH_PNT.readOnly      = false;
                form1.txtGAUGE_THM.readOnly    = false;
                form1.txtNONGAUGE_THM.readOnly = false;
            }
            else {

                form1.txtEVL_YY.readOnly       = true;
                form1.txtRATE_OVER.readOnly    = true;
                form1.txtRATE_UNDER.readOnly   = true;
                form1.txtACH_PNT.readOnly      = true;
                form1.txtGAUGE_THM.readOnly    = true;
                form1.txtNONGAUGE_THM.readOnly = true;
            }

        }

    </Script>

    <Script For=dsT_EV_ACHPNT_01 Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {

			if( ! confirm("기존데이터가 존재합니다. 계속 하시겠습니까?") ){
				return false;
			}

        }

		//트랜잭션 체크를 위해 임시생성
        dsT_EV_ACHPNT_01.AddRow();

		//트랜잭션 전송
		trT_EV_ACHPNT_01.KeyValue = "SVL(I:dsT_EV_ACHPNT_01=dsT_EV_ACHPNT_01)";
		trT_EV_ACHPNT_01.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua080.cmd.VLUA080CMD&S_MODE=SAV_01&GUBUN="+GUBUN+"&EVL_YY="+form1.selEVL_YY_SHR.value;
		trT_EV_ACHPNT_01.Post();

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ACHPNT Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <Script For=dsT_EV_ACHPNT_01 Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ACHPNT Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018 ) {
            alert("해당 필수입력항목[달성율(이상)/달성율(미만)] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("달성율(이상)/달성율(미만)에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-- 트랜젝션 성공. -->
    <script for=trT_EV_ACHPNT event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <script for=trT_EV_ACHPNT_01 event="OnSuccess()">

		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--트랜젝션 실패 -->
    <script for=trT_EV_ACHPNT event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script for=trT_EV_ACHPNT_01 event="OnFail()">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">달성도배점설정</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">달성도배점설정</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgYearcopy','','/images/button/btn_YearcopyOver.gif',1)"><img src="/images/button/btn_YearcopyOn.gif" name="imgYearcopy"    width="110" height="20" border="0" align="absmiddle" onClick="fnc_Yearcopy();"></a>
            &nbsp;&nbsp;
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image7" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove()"></a>
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
                                    <col width="720"></col>
                                </colgroup>
                            <tr>
                                <td align="right" class="searchState">해당년도&nbsp;</td>
                                <td class="padding2423">
                                    <select id="selEVL_YY_SHR" name="selEVL_YY_SHR" onChange="fnc_SearchList()" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                    </select>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- power Search테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="120"></col>
                    <col width="140"></col>
                    <col width="120"></col>
                    <col width="140"></col>
                    <col width="120"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <input type="hidden" name="txtGUBUN" id="txtGUBUN">
                    <td align="center" class="creamBold">해당년도</td>
                        <td class="padding2423"><input id=txtEVL_YY value="" size="4" maxlength="4" style="ime-mode:disabled"  onKeyPress="JavaScript: cfCheckNumber()" on> 년</td>
                    <td align="center" class="creamBold">달성율</td>
                    <td class="padding2423">
                        <input id=txtRATE_OVER size="3" maxlength="3" style="ime-mode:disabled" onKeyPress="JavaScript: cfCheckNumber()" onBlur="fncInitRateOver();"> % ~
                        <input id=txtRATE_UNDER size="3" maxlength="3" style="ime-mode:disabled" onKeyPress="JavaScript: cfCheckNumber()" > %</td>
                    <td align="center" class="creamBold">배점</td>
                    <td class="padding2423"><input id=txtACH_PNT size="3" maxlength="3" style="ime-mode:disabled" onKeyPress="cfCheckNumber()" >
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">계량지표</td>
                    <td class="padding2423" colspan="5"><input id=txtGAUGE_THM value="" style="WIDTH:100%" maxlength="200"> </td>

                </tr>
                <tr>
                    <td align="center" class="creamBold">비계량지표</td>
                    <td class="padding2423" colspan="5"><input id=txtNONGAUGE_THM value="" style="WIDTH:100%" maxlength="200"> </td>
               </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

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
                        <object id="grdT_EV_ACHPNT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:260px;">
                            <param name="DataID"                  value="dsT_EV_ACHPNT">
                            <param name="Format"                  value="
                                <C> id={currow}        width=30   name='순번'         align=center </C>
                                <G> name='달성율(%)' HeadBgColor='#F7DCBB'
                                    <C> id=RATE_OVER   width=33   name='이상'         align=right EditLimit=3 </C>
                                    <C> id=RATE_UNDER  width=33   name='미만'         align=right EditLimit=3 </C>
                                </G>
                                <C> id=GAUGE_THM       width=193  name='계량지표'                  </C>
                                <C> id=NONGAUGE_THM    width=442  name='비계량지표'                </C>
                                <C> id=ACH_PNT         width=33   name='배점'         EditLimit=3  </C>
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

    <!-- Validation Init  -->
    <jsp:include page="/common/CommonValid.jsp" flush="true">
       <jsp:param name="INIT"    value="false"/>
    </jsp:include>

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 달성도배점설정 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_EV_ACHPNT">
    <Param Name="BindInfo", Value='
        <C>Col=GUBUN        Ctrl=txtGUBUN          Param=value Disable=disabled</C>
        <C>Col=EVL_YY       Ctrl=txtEVL_YY         Param=value Disable=disabled</C>
        <C>Col=RATE_OVER    Ctrl=txtRATE_OVER      Param=value Disable=disabled</C>
        <C>Col=RATE_UNDER   Ctrl=txtRATE_UNDER     Param=value </C>
        <C>Col=ACH_PNT      Ctrl=txtACH_PNT        Param=value </C>
        <C>Col=GAUGE_THM    Ctrl=txtGAUGE_THM      Param=value </C>
        <C>Col=NONGAUGE_THM Ctrl=txtNONGAUGE_THM   Param=value </C>
    '>
</object>