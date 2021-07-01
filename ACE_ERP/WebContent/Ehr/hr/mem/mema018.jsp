<!--
    ************************************************************************************
    * @Source         : mema018.jsp                                                    *
    * @Description    : 입사전경력 PAGE                                                *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/01/16  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>


<html>
    <head>
    <title>입사전경력</title>
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

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            dsT_ME_BHISTORY.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema018.cmd.MEMA018CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_ME_BHISTORY.Reset();

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

                trT_ME_BHISTORY.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema018.cmd.MEMA018CMD&S_MODE=SAV";
                trT_ME_BHISTORY.post();

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
            if (dsT_ME_BHISTORY.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_ME_BHISTORY.RowStatus(dsT_ME_BHISTORY.RowPosition);

            //DataSet의 변경 여부 확인
            if (dsT_ME_BHISTORY.IsUpdated && status != 1) {
                alert("화면에 변경사항이 존재합니다.\n먼저 화면 내용을 저장하신 다음 작업하여 주십시오.");
                return false;
            }

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("회사명[" + dsT_ME_BHISTORY.NameValue(dsT_ME_BHISTORY.RowPosition,"CMP_NAM") + "] 입사일[" + dsT_ME_BHISTORY.NameValue(dsT_ME_BHISTORY.RowPosition,"STR_YMD") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_ME_BHISTORY.DeleteRow(dsT_ME_BHISTORY.RowPosition);

            if (status != 1) {
                trT_ME_BHISTORY.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema018.cmd.MEMA018CMD&S_MODE=DEL";
                trT_ME_BHISTORY.post();
            }

            bnd.ActiveBind = false;

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_ME_BHISTORY.SetColumn(form1.grdT_ME_BHISTORY.GetColumnID(0));
            form1.grdT_ME_BHISTORY.Focus();

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
            if (dsT_ME_BHISTORY.CountColumn == 0) {
                dsT_ME_BHISTORY.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, STR_YMD:STRING:KEYVALUETYPE, END_YMD:STRING, CMP_NAM:STRING, GRP_CD:STRING, GRP_NM:STRING, DPT_NAM:STRING, JOB_CD:STRING, CHG_JOB:STRING, CAR_PCT:INT, CAR_YY:INT, CAR_MM:INT, SAL_AMT:INT, REMARK:STRING");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_ME_BHISTORY.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_ME_BHISTORY.setColumn(form1.grdT_ME_BHISTORY.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;

            // KEY 필드는 신규시 입력 가능
            document.getElementById("txtSTR_YMD").disabled = false;
            document.getElementById("txtEND_YMD").disabled = false;
            document.getElementById("ImgStrYmd").disabled  = false;
            document.getElementById("ImgEndYmd").disabled  = false;

            document.getElementById("txtCMP_NAM").focus();
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

			dsT_ME_BHISTORY.ClearData();
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

            //DataSet의 변경 여부 확인
            if (!dsT_ME_BHISTORY.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }

            for ( i = 1; i <= dsT_ME_BHISTORY.CountRow; i++ ) {
                if ( dsT_ME_BHISTORY.RowStatus(i) == 1 ||
                     dsT_ME_BHISTORY.RowStatus(i) == 3 ) {


                    // 입사일자
                    if( dsT_ME_BHISTORY.NameValue(i, "STR_YMD") == '' ) {
                        alert("입사일자는 필수 입력사항입니다.");
                        dsT_ME_BHISTORY.RowPosition = i;
                        document.getElementById("txtSTR_YMD").focus();
                        return false;
                    }

                    // 입사일자 CHECK
                    if (!fnc_CheckDate2(dsT_ME_BHISTORY.NameValue(i, "STR_YMD"), "입사일") && dsT_ME_BHISTORY.NameValue(i, "STR_YMD") != "") {
                        dsT_ME_BHISTORY.RowPosition = i;
                        document.getElementById("txtSTR_YMD").focus();
                        return false;
                    }

                    // 퇴사일자 CHECK
                    if (!fnc_CheckDate2(dsT_ME_BHISTORY.NameValue(i, "END_YMD"), "퇴사일") && dsT_ME_BHISTORY.NameValue(i, "END_YMD") != "") {
                        dsT_ME_BHISTORY.RowPosition = i;
                        document.getElementById("txtEND_YMD").focus();
                        return false;
                    }

                    // 입사일자와 퇴사일자 비교
                    if( dsT_ME_BHISTORY.NameValue(i, "STR_YMD") != '' && dsT_ME_BHISTORY.NameValue(i, "END_YMD") != '' ) {
                        if( cfDateDiff(dsT_ME_BHISTORY.NameValue(i, "STR_YMD").replace(/\-/g,''),dsT_ME_BHISTORY.NameValue(i, "END_YMD").replace(/\-/g,'')) < 0 ) {
                            alert("입사일자가 퇴사일자보다 큽니다.");
                            dsT_ME_BHISTORY.RowPosition = i;
                            document.getElementById("txtSTR_YMD").focus();
                            return false;
                        }
                    }

                    // 그룹사
                    if (dsT_ME_BHISTORY.NameValue(i, "GRP_CD") != "" &&
                        dsT_ME_BHISTORY.NameValue(i, "GRP_NM") == "") {
                        alert("그룹사코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_ME_BHISTORY.RowPosition = i;
                        document.getElementById("txtGRP_CD").focus();
                        return;
                    }

                    if ( dsT_ME_BHISTORY.RowStatus(i) == 1) {
                       document.getElementById("txtSTR_YMD").disabled = true;
                       document.getElementById("txtEND_YMD").disabled = false;
                       document.getElementById("ImgStrYmd").disabled  = true;
                       document.getElementById("ImgEndYmd").disabled  = false;
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
            cfStyleGrid(form1.grdT_ME_BHISTORY, 0,"false","false");

            fnc_SearchList();

        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            //이곳에 해당 코딩을 입력 하세요
            if (dsT_ME_BHISTORY.IsUpdated)  {
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
                document.getElementById("txtCMP_NAM").disabled = false;
                document.getElementById("txtSTR_YMD").disabled = false;
                document.getElementById("txtEND_YMD").disabled = false;
                document.getElementById("txtGRP_CD").disabled  = false;
                document.getElementById("txtDPT_NAM").disabled = false;
                document.getElementById("txtJOB_CD").disabled  = false;
                form1.medSAL_AMT.enable                        = true;
                document.getElementById("txtCHG_JOB").disabled = false;
                document.getElementById("txtCAR_PCT").disabled = false;
                document.getElementById("txtCAR_YY").disabled  = false;
                document.getElementById("txtCAR_MM").disabled  = false;
                document.getElementById("txtREMARK").disabled  = false;

                document.getElementById("ImgStrYmd").disabled  = false;
                document.getElementById("ImgEndYmd").disabled  = false;
                document.getElementById("ImgGrpCd").disabled   = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtCMP_NAM").disabled = true;
                document.getElementById("txtSTR_YMD").disabled = true;
                document.getElementById("txtEND_YMD").disabled = true;
                document.getElementById("txtGRP_CD").disabled  = true;
                document.getElementById("txtDPT_NAM").disabled = true;
                document.getElementById("txtJOB_CD").disabled  = true;
                form1.medSAL_AMT.enable                        = false;
                document.getElementById("txtCHG_JOB").disabled = true;
                document.getElementById("txtCAR_PCT").disabled = true;
                document.getElementById("txtCAR_YY").disabled  = true;
                document.getElementById("txtCAR_MM").disabled  = true;
                document.getElementById("txtREMARK").disabled  = true;

                document.getElementById("ImgStrYmd").disabled  = true;
                document.getElementById("ImgEndYmd").disabled  = true;
                document.getElementById("ImgGrpCd").disabled   = true;

            }
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
    | 2. 이름 : dsT_ME_BHISTORY                     |
    | 3. Table List : T_ME_BHISTORY                 |
    +----------------------------------------------->
    <Object ID="dsT_ME_BHISTORY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_ME_BHISTORY                     |
    | 3. Table List : T_ME_BHISTORY                 |
    +----------------------------------------------->
    <Object ID ="trT_ME_BHISTORY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ME_BHISTORY)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ME_BHISTORY Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ME_BHISTORY.CountRow);

            document.getElementById("txtSTR_YMD").disabled = true;
            document.getElementById("txtEND_YMD").disabled = true;
            document.getElementById("ImgStrYmd").disabled  = true;
            document.getElementById("ImgEndYmd").disabled  = true;

        }

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_ME_BHISTORY Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ME_BHISTORY Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018 ) {
            alert("해당 필수입력항목[입사일자] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50020) {
            alert("입사일자에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_ME_BHISTORY event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_ME_BHISTORY event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_ME_BHISTORY Event="OnRowPosChanged(row)">

        var SysStatus = dsT_ME_BHISTORY.SysStatus(row);

        if (SysStatus == 1) {
            document.getElementById("txtSTR_YMD").disabled = false;
            document.getElementById("txtEND_YMD").disabled = false;
            document.getElementById("ImgStrYmd").disabled  = false;
            document.getElementById("ImgEndYmd").disabled  = false;

        }
        else {
            document.getElementById("txtSTR_YMD").disabled = true;
            document.getElementById("txtEND_YMD").disabled = true;
            document.getElementById("ImgStrYmd").disabled  = true;
            document.getElementById("ImgEndYmd").disabled  = true;

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
            <strong>입사전경력</strong>
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
                    <col width="85 "></col>
                    <col width="100"></col>
                    <col width="85 "></col>
                    <col width="105"></col>
                    <col width="102 "></col>
                    <col width="105"></col>
                    <col width="60 "></col>
                    <col width="150"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">회 사 명</td>
                    <td class="padding2423" >
                        <input id="txtCMP_NAM" maxlength="22" style="width:100%">
                    </td>
                    <td align="center" class="creamBold">입 사 일</td>
                    <td class="padding2423" >
                        <input id="txtSTR_YMD" style="width:72%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '입사일');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStrYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgStrYmd" name="ImgStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD','','195','55');"></a>
                    </td>
                    <td align="center" class="creamBold">퇴 사 일</td>
                    <td class="padding2423" >
                        <input id="txtEND_YMD" style="width:72%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '퇴사일');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEndYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEndYmd" name="ImgEndYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','395','55');"></a>
                    </td>
                    <td align="center" class="creamBold">그룹코드</td>
                    <td class="padding2423">
                        <input id="txtGRP_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('B5', 'txtGRP_CD','txtGRP_NM');"> <input id="txtGRP_NM" style="width:60%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgGrpCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgGrpCd" name="ImgGrpCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtGRP_CD','txtGRP_NM','그룹사','B5')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">소&nbsp;&nbsp;&nbsp;&nbsp;속</td>
                    <td class="padding2423" >
                        <input id="txtDPT_NAM" maxlength="22" style="width:100%">
                    </td>
                    <td align="center" class="creamBold">직&nbsp;&nbsp;&nbsp;&nbsp;위</td>
                    <td class="padding2423" >
                        <input id="txtJOB_CD" maxlength="20" style="width:100%">
                    </td>
                    <td align="center" class="creamBold">급 여 액</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medSAL_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                            <param name=SelectAll            value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="creamBold">담당업무</td>
                    <td class="padding2423" >
                        <input id="txtCHG_JOB" maxlength="20" style="width:100%">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">경력인정비율</td>
                    <td class="padding2423" >
                        <input id="txtCAR_PCT" maxlength="3" style="width:100%;ime-mode:disabled;text-align:right;" onKeyPress="JavaScript: cfNumberCheck();">
                    </td>
                    <td align="center" class="creamBold">경력인정년수</td>
                    <td class="padding2423" >
                        <input id="txtCAR_YY" maxlength="2" style="width:100%;ime-mode:disabled;text-align:right;" onKeyPress="JavaScript: cfNumberCheck();">
                    </td>
                    <td align="center" class="creamBold">경력인정개월수</td>
                    <td class="padding2423" >
                        <input id="txtCAR_MM" maxlength="2" style="width:100%;ime-mode:disabled;text-align:right;" onKeyPress="JavaScript: cfNumberCheck();">
                    </td>
                    <td align="center" class="creamBold">비&nbsp;&nbsp;&nbsp;&nbsp;고</td>
                    <td class="padding2423" >
                        <input id="txtREMARK" maxlength="60" style="width:100%">
                    </td>
                    <input type=hidden  id="txtENO_NO" size="10">
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
                        <object id="grdT_ME_BHISTORY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:794px;height:153px;">
                            <param name="DataID"                  value="dsT_ME_BHISTORY">
                            <param name="Format"                  value="
                                <C> id={currow}        width=40   name='순번'         align=center </C>
                                <C> id=CMP_NAM         width=100  name='회사명'                    </C>
                                <C> id=STR_YMD         width=80   name='입사일'       align=center </C>
                                <C> id=END_YMD         width=80   name='퇴사일'       align=center </C>
                                <C> id=GRP_CD          width=70   name='그룹코드'     align=center </C>
                                <C> id=GRP_NM          width=90   name='그룹사명'                  </C>
                                <C> id=DPT_NAM         width=90   name='소속'                      </C>
                                <C> id=JOB_CD          width=70   name='직위'                      </C>
                                <C> id=SAL_AMT         width=90   name='급여액'                    </C>
                                <C> id=CHG_JOB         width=100  name='담당업무'                  </C>
                                <C> id=CAR_PCT         width=90   name='경력인정비율'              </C>
                                <C> id=CAR_YY          width=90   name='경력인정년수'              </C>
                                <C> id=CAR_MM          width=90   name='경력인정개월'              </C>
                                <C> id=REMARK          width=150  name='비고'                      </C>
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
<!-- 입사전경력 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ME_BHISTORY">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=CMP_NAM       Ctrl=txtCMP_NAM      Param=value </C>
        <C> Col=STR_YMD       Ctrl=txtSTR_YMD      Param=value </C>
        <C> Col=END_YMD       Ctrl=txtEND_YMD      Param=value </C>
        <C> Col=GRP_CD        Ctrl=txtGRP_CD       Param=value </C>
        <C> Col=GRP_NM        Ctrl=txtGRP_NM       Param=value </C>
        <C> Col=DPT_NAM       Ctrl=txtDPT_NAM      Param=value </C>
        <C> Col=JOB_CD        Ctrl=txtJOB_CD       Param=value </C>
        <C> Col=SAL_AMT       Ctrl=medSAL_AMT      Param=text  </C>
        <C> Col=CHG_JOB       Ctrl=txtCHG_JOB      Param=value </C>
        <C> Col=CAR_PCT       Ctrl=txtCAR_PCT      Param=value </C>
        <C> Col=CAR_YY        Ctrl=txtCAR_YY       Param=value </C>
        <C> Col=CAR_MM        Ctrl=txtCAR_MM       Param=value </C>
        <C> Col=REMARK        Ctrl=txtREMARK       Param=value </C>
    '>
</object>