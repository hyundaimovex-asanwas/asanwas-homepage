<!--
    ************************************************************************************
    * @Source         : pira033.jsp                                                    *
    * @Description    : 겸직사항 PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/01/31  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>


<html>
    <head>
    <title>겸직사항</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

<%
    String ENO_NO = request.getParameter("ENO_NO");         //사번
%>

    <!--
    ******************************************************
    * 자바스크립트 함수 선언부분
    ******************************************************
    -->
    <script language="javascript" >

        var str_ymd = '';
        var seq_no  = '';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            dsT_CM_ADDJOB.DataId = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira033.cmd.PIRA033CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_CM_ADDJOB.Reset();

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

            if(fnc_SaveItemCheck()) {

                trT_CM_ADDJOB.action = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira033.cmd.PIRA033CMD&S_MODE=SAV";
                trT_CM_ADDJOB.post();

            } else {

                return;

            }

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            var status = 0;

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_CM_ADDJOB.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_CM_ADDJOB.RowStatus(dsT_CM_ADDJOB.RowPosition);

            //DataSet의 변경 여부 확인
            if (dsT_CM_ADDJOB.IsUpdated && status != 1) {
                alert("화면에 변경사항이 존재합니다.\n먼저 화면 내용을 저장하신 다음 작업하여 주십시오.");
                return false;
            }

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("시작일자[" + dsT_CM_ADDJOB.NameValue(dsT_CM_ADDJOB.RowPosition,"STR_YMD") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_CM_ADDJOB.DeleteRow(dsT_CM_ADDJOB.RowPosition);

            if (status != 1) {
                trT_CM_ADDJOB.action = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira033.cmd.PIRA033CMD&S_MODE=DEL";
                trT_CM_ADDJOB.post();
            }

            bnd.ActiveBind = false;

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_CM_ADDJOB.SetColumn(form1.grdT_CM_ADDJOB.GetColumnID(0));
            form1.grdT_CM_ADDJOB.Focus();

            bnd.ActiveBind = true;

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

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_CM_ADDJOB.CountColumn == 0) {
                dsT_CM_ADDJOB.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, STR_YMD:STRING:KEYVALUETYPE, SEQ_NO:STRING:KEYVALUETYPE, END_YMD:STRING, DPT_CD:STRING, DPT_NM:STRING");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_CM_ADDJOB.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_CM_ADDJOB.setColumn(form1.grdT_CM_ADDJOB.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;

            // KEY 필드는 신규시 입력 가능
            document.getElementById("txtSTR_YMD").disabled = false;
            document.getElementById("ImgStrYmd").disabled  = false;

            document.getElementById("txtSTR_YMD").focus();
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

        	//사번임시저장
			var ENO_NO = document.getElementById("ENO_NO").value;

			dsT_CM_ADDJOB.ClearData();
			document.getElementById("ENO_NO").value = ENO_NO;
			document.getElementById("resultMessage").innerText = ' ';

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

            var f = document.form1;
            var END_YMD = '';

            //DataSet의 변경 여부 확인
            if (!dsT_CM_ADDJOB.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }

            for ( i = 1; i <= dsT_CM_ADDJOB.CountRow; i++ ) {
                if ( dsT_CM_ADDJOB.RowStatus(i) == 1 ||
                     dsT_CM_ADDJOB.RowStatus(i) == 3 ) {


                    // 시작일자
                    if( dsT_CM_ADDJOB.NameValue(i, "STR_YMD") == '' ) {
                        alert("시작일자는 필수 입력사항입니다.");
                        dsT_CM_ADDJOB.RowPosition = i;
                        document.getElementById("txtSTR_YMD").focus();
                        return false;
                    }

                    // 시작일자 CHECK
                    if (!fnc_CheckDate2(dsT_CM_ADDJOB.NameValue(i, "STR_YMD"), "시작일") && dsT_CM_ADDJOB.NameValue(i, "STR_YMD") != "") {
                        dsT_CM_ADDJOB.RowPosition = i;
                        document.getElementById("txtSTR_YMD").focus();
                        return false;
                    }

                    // 종료일자 CHECK
                    if (!fnc_CheckDate2(dsT_CM_ADDJOB.NameValue(i, "END_YMD"), "종료일") && dsT_CM_ADDJOB.NameValue(i, "END_YMD") != "") {
                        dsT_CM_ADDJOB.RowPosition = i;
                        document.getElementById("txtEND_YMD").focus();
                        return false;
                    }

                    // 시작일자와 종료일자 비교
                    if( dsT_CM_ADDJOB.NameValue(i, "STR_YMD") != '' && dsT_CM_ADDJOB.NameValue(i, "END_YMD") != '' ) {
                        if( cfDateDiff(dsT_CM_ADDJOB.NameValue(i, "STR_YMD").replace(/\-/g,''),dsT_CM_ADDJOB.NameValue(i, "END_YMD").replace(/\-/g,'')) < 0 ) {
                            alert("종료일자가 시작일자보다 작습니다.");
                            dsT_CM_ADDJOB.RowPosition = i;
                            document.getElementById("txtEND_YMD").focus();
                            return false;
                        }
                    }


                    // 겸직본부/소속
                    if( dsT_CM_ADDJOB.NameValue(i, "DPT_CD") == '' && dsT_CM_ADDJOB.NameValue(i, "HEAD_CD") == '') {
                        alert("겸직본부, 소속 중 한가지는 필수 입력사항입니다.");
                        dsT_CM_ADDJOB.RowPosition = i;
                        document.getElementById("txtHEAD_CD").focus();
                        return false;
                    }

                    // 겸직본부
                    if (dsT_CM_ADDJOB.NameValue(i, "HEAD_CD") != "" &&
                        dsT_CM_ADDJOB.NameValue(i, "HEAD_NM") == "") {
                        alert("겸직본부코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_CM_ADDJOB.RowPosition = i;
                        document.getElementById("txtHEAD_CD").focus();
                        return;
                    }

                    // 겸직소속
                    if (dsT_CM_ADDJOB.NameValue(i, "DPT_CD") != "" &&
                        dsT_CM_ADDJOB.NameValue(i, "DPT_NM") == "") {
                        alert("겸직소속코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_CM_ADDJOB.RowPosition = i;
                        document.getElementById("txtDPT_CD").focus();
                        return;
                    }

                    // 시작일자와 소속 CHECK
                    for (var j = 1; j <= dsT_CM_ADDJOB.CountRow; j++ ) {

                        END_YMD1 = dsT_CM_ADDJOB.NameValue(j, "END_YMD");
                        END_YMD2 = dsT_CM_ADDJOB.NameValue(i, "END_YMD");

                        // 종료일자가 입력되어 있지 않다면
                        if (END_YMD1 == "") {
                            END_YMD1 = '9999-12-31';
                        }

                        if (END_YMD2 == "") {
                            END_YMD2 = '9999-12-31';
                        }

                        if (!(dsT_CM_ADDJOB.NameValue(i, "STR_YMD") > END_YMD1 ||
                              END_YMD2 < dsT_CM_ADDJOB.NameValue(j, "STR_YMD"))) {

                            if (i == j) {
                                continue;
                            }


                            if ( dsT_CM_ADDJOB.NameValue(i, "HEAD_CD") == dsT_CM_ADDJOB.NameValue(j, "HEAD_CD")  &&
                                dsT_CM_ADDJOB.NameValue(i, "HEAD_CD") != ''                             ) {
                                alert("해당 기간에 중복되는 겸직본부가 있습니다. 확인바랍니다.");
                                dsT_CM_ADDJOB.RowPosition = i;
                                document.getElementById("txtHEAD_CD").focus();
                                return;
                            }


                            if ( dsT_CM_ADDJOB.NameValue(i, "DPT_CD") == dsT_CM_ADDJOB.NameValue(j, "DPT_CD")  &&
                                dsT_CM_ADDJOB.NameValue(i, "DPT_CD") != ''                             ) {
                                alert("해당 기간에 중복되는 겸직소속이 있습니다. 확인바랍니다.");
                                dsT_CM_ADDJOB.RowPosition = i;
                                document.getElementById("txtDPT_CD").focus();
                                return;
                            }
                        }
                    }

                    // 겸직직책
                    if (dsT_CM_ADDJOB.NameValue(i, "DUTY_CD") == '' ) {
                        alert("겸직직책은 필수 입력사항입니다.");
                        dsT_CM_ADDJOB.RowPosition = i;
                        document.getElementById("txtDUTY_CD").focus();
                        return false;
                    }

                    // 겸직직책
                    if (dsT_CM_ADDJOB.NameValue(i, "DUTY_CD") != "" &&
                        dsT_CM_ADDJOB.NameValue(i, "DUTY_NM") == "") {
                        alert("겸직직책코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_CM_ADDJOB.RowPosition = i;
                        document.getElementById("txtDUTY_CD").focus();
                        return;
                    }

              /*      if (dsT_CM_ADDJOB.NameValue(i, "DPT_CD") == "" &&
                        dsT_CM_ADDJOB.NameValue(i, "DUTY_CD") == "" ) {
                        // 소속, 직책 모두 입력 안한 경우
                    }
                    else if (dsT_CM_ADDJOB.NameValue(i, "DPT_CD") != "" &&
                        dsT_CM_ADDJOB.NameValue(i, "DUTY_CD") != "" ) {
                        // 소속,직책 모두 입력한 경우
                    }
                    else {
                        // 소속,직책 중 하나라도 입력한 경우
                        alert("소속, 직책 모두 입력하셔야 합니다.");
                        dsT_CM_ADDJOB.RowPosition = i;
                        document.getElementById("txtDPT_CD").focus();
                        return;
                    } */

                    if ( dsT_CM_ADDJOB.RowStatus(i) == 1) {
                        document.getElementById("txtSTR_YMD").disabled = true;
                        document.getElementById("ImgStrYmd").disabled  = true;
                    }
                }
            }

            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("ENO_NO").value = "<%=ENO_NO%>";

            //Grid Style 적용
            cfStyleGrid(form1.grdT_CM_ADDJOB, 0,"false","false");

            fnc_SearchList();

        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            //이곳에 해당 코딩을 입력 하세요
            if (dsT_CM_PERSON.IsUpdated)  {
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

        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

        /***************************************
         * 입력부의 컬럼의 Disabled 속성 바꿈  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // 해당 컬럼의 속성을 Enabled로 변경
            if (prop == 'E') {

                document.getElementById("txtSTR_YMD").disabled  = false;
                document.getElementById("txtEND_YMD").disabled  = false;
                document.getElementById("txtDPT_CD").disabled   = false;
                document.getElementById("txtDUTY_CD").disabled  = false;

                document.getElementById("ImgStrYmd").disabled   = false;
                document.getElementById("ImgEndYmd").disabled   = false;
                document.getElementById("ImgDptCd").disabled    = false;
                document.getElementById("ImgDutyCd").disabled   = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtSTR_YMD").disabled  = true;
                document.getElementById("txtEND_YMD").disabled  = true;
                document.getElementById("txtDPT_CD").disabled   = true;
                document.getElementById("txtDUTY_CD").disabled  = true;

                document.getElementById("ImgStrYmd").disabled   = true;
                document.getElementById("ImgEndYmd").disabled   = true;
                document.getElementById("ImgDptCd").disabled    = true;
                document.getElementById("ImgDutyCd").disabled   = true;

            }
        }

        function fnc_getSeqNo(obj) {
            var SysStatus = dsT_CM_ADDJOB.SysStatus(dsT_CM_ADDJOB.RowPosition);
            var SeqNo = 0;

            if (SysStatus == 1) {

                document.getElementById("txtSEQ_NO").value = '';

                if (obj.value != '') {

                    for (var i = 1; i <= dsT_CM_ADDJOB.CountRow; i++) {

                        if (dsT_CM_ADDJOB.NameValue(i, "STR_YMD") == obj.value &&
                            dsT_CM_ADDJOB.NameValue(i, "SEQ_NO") >= SeqNo &&
                            i != dsT_CM_ADDJOB.RowPosition) {

                           SeqNo = new Number(dsT_CM_ADDJOB.NameValue(i, "SEQ_NO")) + 1;

                        }
                    }

                    if (SeqNo == 0) {
                        SeqNo = 1;
                    }

                    document.getElementById("txtSEQ_NO").value = SeqNo;
                }
            }

            str_ymd = document.getElementById("txtSTR_YMD").value;
            seq_no  = document.getElementById("txtSEQ_NO").value;
        }

        function fnc_BlurYmd() {
            if (str_ymd == document.getElementById("txtSTR_YMD").value &&
                seq_no  == document.getElementById("txtSEQ_NO").value) {
                return;
            }

            fnc_getSeqNo(document.getElementById("txtSTR_YMD"));

        }

    </script>
</head>


    <!--********************************************************************
    * 가우스 컴포넌트 선언 및 이벤트 (트랜젝션, 데이터셋) : (Visible : X)
    *********************************************************************-->

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_CM_ADDJOB                       |
    | 3. Table List : T_CM_ADDJOB                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_ADDJOB" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CM_ADDJOB                       |
    | 3. Table List : T_CM_ADDJOB                   |
    +----------------------------------------------->
    <Object ID ="trT_CM_ADDJOB" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_ADDJOB)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_ADDJOB Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_ADDJOB.CountRow);

            document.getElementById("txtSTR_YMD").disabled = true;
            document.getElementById("ImgStrYmd").disabled  = true;

        }

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_ADDJOB Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_ADDJOB Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018 ) {
            alert("해당 필수입력항목[시작일자] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50020) {
            alert("시작일자에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CM_ADDJOB event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CM_ADDJOB event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_CM_ADDJOB Event="OnRowPosChanged(row)">

        var SysStatus = dsT_CM_ADDJOB.SysStatus(row);

        if (SysStatus == 1) {
            document.getElementById("txtSTR_YMD").disabled = false;
            document.getElementById("ImgStrYmd").disabled  = false;

        }
        else {
            document.getElementById("txtSTR_YMD").disabled = true;
            document.getElementById("ImgStrYmd").disabled  = true;

        }

    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<body onload="fnc_OnLoadProcess();" oncontextmenu="return false">

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
<table width="794" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>겸직사항</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAdd','','/images/button/btn_AddnewOver.gif',1)">   <img src="/images/button/btn_AddnewOn.gif" name="imgAdd"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="794" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="52 "></col>
                    <col width="100"></col>
                    <col width="52 "></col>
                    <col width="105"></col>
                    <col width="40 "></col>
                    <col width="133"></col>
                    <col width="40 "></col>
                    <col width="133"></col>
                    <col width="40 "></col>
                    <col width="133"></col>
                </colgroup>
                <tr>
                    <input type=hidden   id="txtENO_NO" size="10">
                    <input type=hidden id="txtSEQ_NO">
                    <td align="center" class="creamBold">시작일</td>
                    <td class="padding2423" >
                        <input id="txtSTR_YMD" style="width:70%;ime-mode:disabled" maxlength="10" onBlur="fnc_BlurYmd();"  onChange="fnc_CheckDate(this, '시작일');fnc_getSeqNo(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStrYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgStrYmd" name="ImgStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD','','0','53');"></a>
                    </td>
                    <td align="center" class="creamBold">종료일</td>
                    <td class="padding2423" >
                        <input id="txtEND_YMD" style="width:70%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '종료일');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEndYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEndYmd" name="ImgEndYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','125','53');"></a>
                    </td>
                    <td align="center" class="creamBold">본부</td>
                    <td class="padding2423">
                        <input id="txtHEAD_CD" style="width:17%" maxlength="2" onChange="fnc_GetCommNm('B2', 'txtHEAD_CD','txtHEAD_NM');"> <input id="txtHEAD_NM" style="width:53%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHeadCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgHeadCd" name="ImgHeadCd" width="21" height="20" border="0" align="absmiddle" onClick=fnc_commnmPopup('txtHEAD_CD','txtHEAD_NM','본부','HEAD')></a>
                    </td>
                    <td align="center" class="creamBold">소속</td>
                    <td class="padding2423">
                        <input id="txtDPT_CD" style="width:17%"  maxlength="2" onChange="fnc_GetCommNm('A4', 'txtDPT_CD','txtDPT_NM');"> <input id="txtDPT_NM" style="width:53%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick=fnc_commnmPopup('txtDPT_CD','txtDPT_NM','소속','DEPT')></a>
                    </td>
                    <td align="center" class="creamBold">직책</td>
                    <td class="padding2423">
                        <input id="txtDUTY_CD" style="width:17%" maxlength="2" onChange="fnc_GetCommNm('A7', 'txtDUTY_CD','txtDUTY_NM');"> <input id="txtDUTY_NM" style="width:53%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDutyCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDutyCd" name="ImgDutyCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtDUTY_CD','txtDUTY_NM','직책','A7')"></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="794" border="0" cellspacing="0" cellpadding="0">
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
<table width="794" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object id="grdT_CM_ADDJOB" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:794px;height:210px;">
                            <param name="DataID"                  value="dsT_CM_ADDJOB">
                            <param name="Format"                  value="
                                <C> id={currow}        width=50   name='순번'         align=center </C>
                                <C> id=STR_YMD         width=120  name='시작일'       align=center </C>
                                <C> id=END_YMD         width=120  name='종료일'       align=center </C>
                                <C> id=HEAD_NM         width=161  name='겸직본부'     align=center </C>
                                <C> id=DPT_NM          width=161  name='겸직소속'     align=center </C>
                                <C> id=DUTY_NM         width=161  name='겸직직책'     align=center </C>
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

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 겸직사항 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_ADDJOB">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=STR_YMD       Ctrl=txtSTR_YMD      Param=value </C>
        <C> Col=SEQ_NO        Ctrl=txtSEQ_NO       Param=value </C>
        <C> Col=END_YMD       Ctrl=txtEND_YMD      Param=value </C>
        <C> Col=HEAD_CD       Ctrl=txtHEAD_CD      Param=value </C>
        <C> Col=HEAD_NM       Ctrl=txtHEAD_NM      Param=value </C>
        <C> Col=DPT_CD        Ctrl=txtDPT_CD       Param=value </C>
        <C> Col=DPT_NM        Ctrl=txtDPT_NM       Param=value </C>
        <C> Col=DUTY_CD       Ctrl=txtDUTY_CD      Param=value </C>
        <C> Col=DUTY_NM       Ctrl=txtDUTY_NM      Param=value </C>
    '>
</object>