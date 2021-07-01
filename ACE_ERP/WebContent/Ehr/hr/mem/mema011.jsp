<!--
    ************************************************************************************
    * @Source         : mema011.jsp                                                    *
    * @Description    : 인사기본2 PAGE                                                 *
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
    <title>인사기본2</title>
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

            if (form1.ENO_NO.value == "" || (parent.dsT_ME_PERSON.CountRow < 1 && parent.dsT_ME_PERSON.RowStatus(1) != 1)) {

                dsT_ME_PERSON.ClearData();
                fnc_ColEnabled('D');

                document.getElementById("resultMessage").innerText = '';
                if (parent.document.getElementById("txtENO_NO").disabled == false) {
                    parent.document.getElementById("txtENO_NM").focus();
                }

                return;
            }

            dsT_ME_PERSON.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema011.cmd.MEMA011CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_ME_PERSON.Reset();

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

            //DataSet의 변경 여부 확인
            if (!dsT_ME_PERSON.IsUpdated ) {
//                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return true;
            }

            if(fnc_SaveItemCheck()) {

                trT_ME_PERSON.KeyValue = "SVL(I:SAV=dsT_ME_PERSON)";
                trT_ME_PERSON.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema011.cmd.MEMA011CMD&S_MODE=SAV";
                trT_ME_PERSON.post();

            } else {

                return false;

            }

            return true;

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

        	//사번임시저장
			var ENO_NO = document.getElementById("ENO_NO").value;

			dsT_ME_PERSON.ClearData();
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

            // 채용구분
            if (document.getElementById("txtHIR_CD").value != "" &&
                document.getElementById("txtHIR_NM").value == "") {
                alert("채용구분코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                document.getElementById("txtHIR_CD").focus();
                return false;
            }

            // 추천인
            if (document.getElementById("txtOK_ENO").value != "" &&
                document.getElementById("txtOK_MAN").value == "") {
                alert("추천인사번에 입력하신 값은 존재하지 않는 사번입니다. 확인바랍니다.");
                document.getElementById("txtOK_ENO").focus();
                return false;
            }

            // 파견대상업무
            if (document.getElementById("txtDISJOB_CD").value != "" &&
                document.getElementById("txtDISJOB_NM").value == "") {
                alert("파견대상업무코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                document.getElementById("txtDISJOB_CD").focus();
                return false;
            }

            // 업무구분
            if (document.getElementById("txtDISDPT_CD").value != "" &&
                document.getElementById("txtDISDPT_NM").value == "") {
                alert("업무구분코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                document.getElementById("txtDISDPT_CD").focus();
                return false;
            }

            // 퇴직사유
            if (document.getElementById("txtRET_CD").value != "" &&
                document.getElementById("txtRET_NM").value == "") {
                alert("퇴직사유코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                document.getElementById("txtRET_CD").focus();
                return false;
            }
            
            // 퇴사일 CHECK
            if (!fnc_CheckDate(document.getElementById("txtRET_YMD"), "퇴사일") && document.getElementById("txtRET_YMD").value != "") {
                document.getElementById("txtRET_YMD").focus();
                return false;
            }

            // 계약직전환일 CHECK
            if (!fnc_CheckDate(document.getElementById("txtCHNG_YMD"), "계약직전환일") && document.getElementById("txtCHNG_YMD").value != "") {
                document.getElementById("txtCHNG_YMD").focus();
                return false;
            }

            // 출신도
            /*if (document.getElementById("txtBCT_CD").value != "" &&
                document.getElementById("txtBCT_NM").value == "") {
                alert("출신도코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                document.getElementById("txtBCT_CD").focus();
                return false;
            }*/

            // 본인과의관계
            /*if (document.getElementById("txtHFRE_CD").value != "" &&
                document.getElementById("txtHFRE_NM").value == "") {
                alert("관계코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                document.getElementById("txtHFRE_CD").focus();
                return false;
            }*/

            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("ENO_NO").value = "<%=ENO_NO%>";

            fnc_ColEnabled('D');

            fnc_SearchList();

        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            //이곳에 해당 코딩을 입력 하세요
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

                document.getElementById("txtHIR_CD").disabled     = false;
                document.getElementById("txtHIR_TAG").disabled     = false;
                document.getElementById("txtOK_ENO").disabled     = false;
                document.getElementById("txtOK_MAN").disabled     = false;
                document.getElementById("txtDISJOB_CD").disabled  = false;
                document.getElementById("txtDISDPT_CD").disabled  = false;
                document.getElementById("txtJOB_TAG").disabled    = false;
                document.getElementById("txtEDGR_CD").disabled    = false;
                document.getElementById("txtSCH_CD").disabled     = false;
                document.getElementById("txtMAJ_CD").disabled     = false;
                document.getElementById("txtGRD_CD").disabled     = false;
                document.getElementById("txtGUR_YMD").disabled    = false;
                
                document.getElementById("txtRET_CD").disabled      = false;
                document.getElementById("txtRET_YMD").disabled     = false;
                document.getElementById("txtCHNG_YMD").disabled    = false;
                document.getElementById("txtCOC_NAM").disabled     = false;
                document.getElementById("txtREMARK").disabled      = false;
                //document.getElementById("txtBCT_CD").disabled     = false;
                //document.getElementById("txtHF_NAM").disabled     = false;
                //document.getElementById("txtHFRE_CD").disabled    = false;
                //document.getElementById("txtPER_ADR").disabled    = false;

                document.getElementById("ImgHirCd").disabled      = false;
                document.getElementById("ImgOkEno").disabled      = false;
                document.getElementById("ImgDisJobCd").disabled   = false;
                document.getElementById("ImgDisDptCd").disabled   = false;
                
                document.getElementById("ImgRetCd").disabled       = false;
                document.getElementById("ImgRetYmd").disabled      = false;
                document.getElementById("ImgChngYmd").disabled     = false;
                //document.getElementById("ImgBctCd").disabled      = false;
                //document.getElementById("ImgHfreCd").disabled     = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtHIR_CD").disabled     = true;
                document.getElementById("txtHIR_TAG").disabled     = true;
                document.getElementById("txtOK_ENO").disabled     = true;
                document.getElementById("txtOK_MAN").disabled     = true;
                document.getElementById("txtDISJOB_CD").disabled  = true;
                document.getElementById("txtDISDPT_CD").disabled  = true;
                document.getElementById("txtJOB_TAG").disabled    = true;
                document.getElementById("txtEDGR_CD").disabled    = true;
                document.getElementById("txtSCH_CD").disabled     = true;
                document.getElementById("txtMAJ_CD").disabled     = true;
                document.getElementById("txtGRD_CD").disabled     = true;
                document.getElementById("txtGUR_YMD").disabled    = true;
                
                document.getElementById("txtRET_CD").disabled      = true;
                document.getElementById("txtRET_YMD").disabled     = true;
                document.getElementById("txtCHNG_YMD").disabled    = true;
                document.getElementById("txtCOC_NAM").disabled     = true;
                document.getElementById("txtREMARK").disabled      = true;
                //document.getElementById("txtBCT_CD").disabled     = true;
                //document.getElementById("txtHF_NAM").disabled     = true;
                //document.getElementById("txtHFRE_CD").disabled    = true;
                //document.getElementById("txtPER_ADR").disabled    = true;

                document.getElementById("ImgHirCd").disabled      = true;
                document.getElementById("ImgOkEno").disabled      = true;
                document.getElementById("ImgDisJobCd").disabled   = true;
                document.getElementById("ImgDisDptCd").disabled   = true;
                
                document.getElementById("ImgRetCd").disabled       = true;
                document.getElementById("ImgRetYmd").disabled      = true;
                document.getElementById("ImgChngYmd").disabled     = true;
                //document.getElementById("ImgBctCd").disabled      = true;
                //document.getElementById("ImgHfreCd").disabled     = true;

            }
        }

        function fnc_SchCd() {
            var EDGR_CD = document.getElementById("txtEDGR_CD").value;

            if (EDGR_CD == "") {
                alert("학력구분을 먼저 입력하여주시기 바랍니다.");
                document.getElementById("txtEDGR_CD").focus();
                return;
            }
            else if (EDGR_CD == "2") {
                fnc_commonCodePopup('txtSCH_CD','txtSCH_NM','중학교','E8');
            }
            else if (EDGR_CD == "3") {
                fnc_commonCodePopup('txtSCH_CD','txtSCH_NM','고등학교','E2');
            }
            else if (EDGR_CD == "4") {
                fnc_commonCodePopup('txtSCH_CD','txtSCH_NM','전문대','E3');
            }
            else if (EDGR_CD == "5") {
                fnc_commonCodePopup('txtSCH_CD','txtSCH_NM','대학교','E4');
            }
            else if (EDGR_CD == "6" ||
                     EDGR_CD == "7" ||
                     EDGR_CD == "8" ) {
                fnc_commonCodePopup('txtSCH_CD','txtSCH_NM','대학원','E5');
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
    | 2. 이름 : dsT_ME_PERSON                       |
    | 3. Table List : T_ME_PERSON                   |
    +----------------------------------------------->
    <Object ID="dsT_ME_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_ME_PERSON                       |
    | 3. Table List : T_ME_PERSON                   |
    +----------------------------------------------->
    <Object ID ="trT_ME_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_ME_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ME_PERSON.CountRow);
            document.getElementById("resultMessage").innerText = '';

        }

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_ME_PERSON Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ME_PERSON Event="OnDataError()">

        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_ME_PERSON event="OnSuccess()">

//        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        if (parent.savflag != '1') {
            parent.savflag = 1;
        }

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_ME_PERSON event="OnFail()">

        cfErrorMsg(this);

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
<table width="788" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>인사기본2</strong>
        </td>
        <td height="20" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <!--a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a-->
            <!--<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>-->
            <!--<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="ImgClear" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>-->
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="788" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="65"></col>
                    <col width="90"></col>
                    <col width="142"></col>
                    <col width="95"></col>
                    <col width="142"></col>
                    <col width="95"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold" rowspan="2">입사정보</td>
                    <td align="center" class="creamBold">채용구분</td>
                    <td class="padding2423">
                        <input id="txtHIR_CD" maxlength="3" style="width:17%"  onChange="fnc_GetCommNm('C1', 'txtHIR_CD','txtHIR_NM');"> <input id="txtHIR_NM" style="width:59%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHirCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgHirCd" name="ImgHirCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtHIR_CD','txtHIR_NM','채용구분','C1')"></a>
                    </td>
                    <td align="center" class="creamBold">추 천 인</td>
                    <td class="padding2423">
                        <input id="txtOK_ENO" maxlength="8" style="width:37%;ime-mode:disabled" onKeyPress="JavaScript: cfNumberCheck();" onChange="fnc_GetEnoNm('txtOK_ENO','txtOK_MAN','1');"> <input id="txtOK_MAN" style="width:39%" onChange="fnc_GetEnoNo('txtOK_MAN','txtOK_ENO')">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgOkEno','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgOkEno" name="ImgOkEno" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtOK_ENO','txtOK_MAN', '1')"></a>
                    </td>
                    <td align="center" class="creamBold">채용사유</td>
                    <td class="padding2423">
                        <input id="txtHIR_TAG" style="width:100%" maxlength="20">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">파견대상업무</td>
                    <td class="padding2423" >
                        <input id="txtDISJOB_CD" maxlength="5" style="width:25%" onChange="fnc_GetCommNm('C8', 'txtDISJOB_CD','txtDISJOB_NM');"> <input id="txtDISJOB_NM" style="width:51%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDisJobCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDisJobCd" name="ImgDisJobCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtDISJOB_CD','txtDISJOB_NM','근로자파견대상업무','C8')"></a>
                    <td align="center" class="creamBold">업무구분</td>
                    <td class="padding2423" >
                        <input id="txtDISDPT_CD" maxlength="2" style="width:17%" onChange="fnc_GetCommNm('C9', 'txtDISDPT_CD','txtDISDPT_NM');"> <input id="txtDISDPT_NM" style="width:59%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDisDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDisDptCd" name="ImgDisDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtDISDPT_CD','txtDISDPT_NM','파견사원업무구분','C9')"></a>
                    </td>
                    <td align="center" class="creamBold">담당업무</td>
                    <td class="padding2423" >
                        <input id="txtJOB_TAG" style="width:100%"  class="input_ReadOnly"  readonly>
                    </td>
                </tr>
                
                <tr>
                    <td align="center" class="creamBold" rowspan="3">파견정보</td>
                    <td align="center" class="creamBold">파견업체</td>
                    <td class="padding2423"><input id="txtDISCOMP_NM" style="width:100%" class="input_ReadOnly"  readonly></td>
                    <td align="center" class="creamBold">계약시작일</td>
                    <td class="padding2423"><input id="txtCONS_YMD" style="width:100%" class="input_ReadOnly"  readonly></td>
                    <td align="center" class="creamBold">계약만료일</td>
                    <td class="padding2423"><input id="txtCONE_YMD" style="width:100%" class="input_ReadOnly"  readonly></td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">파견단가</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medBAS_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=false>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                            <param name=SelectAll            value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="creamBold">기타수당</td>
                    <td class="padding2423" colspan="3">
                        <comment id="__NSID__"><object id="medLSEV_AMT1" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:38%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=false>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                            <param name=SelectAll            value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">근속장려금(6)</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medLSEV_AMT2" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=false>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                            <param name=SelectAll            value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="creamBold">근속장려금(12)</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medLSEV_AMT3" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=false>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                            <param name=SelectAll            value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="creamBold">근속장려금(18)</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medWEL_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=false>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                            <param name=SelectAll            value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                
                <tr>
                    <td align="center" class="creamBold" rowspan="2">퇴사정보</td>
                    <td align="center" class="creamBold">사&nbsp;&nbsp;&nbsp;&nbsp;유</td>
                    <td class="padding2423">
                        <input id="txtRET_CD" style="width:30%" maxlength="5" onChange="fnc_GetCommNm('C2', 'txtRET_CD','txtRET_NM');"> <input id="txtRET_NM" style="width:45%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRetCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgRetCd" name="ImgRetCd"  width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtRET_CD','txtRET_NM','퇴직사유','C2')"></a>
                    </td>
                    <td align="center" class="creamBold">퇴 사 일</td>
                    <td class="padding2423" >
                        <input id="txtRET_YMD" style="width:78%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '퇴사일');"  onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRetYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgRetYmd" name="ImgRetYmd"  width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtRET_YMD','','335','80');"></a>
                    </td>
                    <td align="center" class="creamBold">계약직전환일</td>
                    <td class="padding2423" >
                        <input id="txtCHNG_YMD" style="width:78%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '계약직전환일');"  onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgChngYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgChngYmd" name="ImgChngYmd"  width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtCHNG_YMD','','335','105');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">전 직 처</td>
                    <td class="padding2423" >
                        <input id="txtCOC_NAM" style="width:100%" maxlength="14">
                    </td>
                    <td align="center" class="creamBold">비&nbsp;&nbsp;&nbsp;&nbsp;고</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtREMARK" style="width:100%" maxlength="60">
                    </td>
                </tr>
                
                <tr>
                    <td align="center" class="creamBold" rowspan="2">학력사항</td>
                    <td align="center" class="creamBold">학력구분</td>
                    <td class="padding2423">
                        <input id="txtEDGR_CD" maxlength="3" style="width:17%" class="input_ReadOnly"  readonly> <input id="txtEDGR_NM" style="width:78%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">학 교 명</td>
                    <td class="padding2423">
                        <input id="txtSCH_CD" maxlength="3" style="width:17%"  class="input_ReadOnly"  readonly> <input id="txtSCH_NM" style="width:78%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">학&nbsp;&nbsp;&nbsp;&nbsp;과</td>
                    <td class="padding2423">
                        <input id="txtMAJ_CD" maxlength="3" style="width:17%" class="input_ReadOnly"  readonly> <input id="txtMAJ_NM" style="width:78%" class="input_ReadOnly"  readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">졸업구분</td>
                    <td class="padding2423">
                        <input id="txtGRD_CD" maxlength="3" style="width:17%" class="input_ReadOnly"  readonly> <input id="txtGRD_NM" style="width:78%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">졸 업 일</td>
                    <td class="padding2423">
                        <input id="txtGUR_YMD" style="width:100%;ime-mode:disabled" maxlength="10" onkeypress="cfDateHyphen(this);cfCheckNumber();" class="input_ReadOnly"  readonly>
                    </td>
                </tr>

                <!-- 
                <tr>
                    <td align="center" class="creamBold" rowspan="2">신상정보</td>
                    <td align="center" class="creamBold">출 신 도</td>
                    <td class="padding2423">
                        <input id="txtBCT_CD" maxlength="3" style="width:17%" onChange="fnc_GetCommNm('B4', 'txtBCT_CD','txtBCT_NM');"> <input id="txtBCT_NM" style="width:59%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgBctCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgBctCd" name="ImgBctCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtBCT_CD','txtBCT_NM','출신도','B4')"></a>
                    </td>
                    <td align="center" class="creamBold">호&nbsp;&nbsp;&nbsp;&nbsp;주</td>
                    <td class="padding2423">
                        <input id="txtHF_NAM" maxlength="12" style="width:100%"></td>
                    <td align="center" class="creamBold">관&nbsp;&nbsp;&nbsp;&nbsp;계</td>
                    <td class="padding2423">
                        <input id="txtHFRE_CD" maxlength="3" style="width:17%" onChange="fnc_GetCommNm('G1', 'txtHFRE_CD','txtHFRE_NM');"> <input id="txtHFRE_NM" style="width:56%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHfreCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgHfreCd" name="ImgHfreCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtHFRE_CD','txtHFRE_NM','호주와의관계','G1')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">본&nbsp;&nbsp;&nbsp;&nbsp;적</td>
                    <td class="padding2423" colspan="5"><input id="txtPER_ADR" maxlength="60" style="width:100%"></td>
                </tr>
                -->
                
           </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="788" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width=100%><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->

</form>
<!-- form 끝 -->

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 인사기록표 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ME_PERSON">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=ENO_NO         Param=value Disable=disabled</C>
        <C> Col=HIR_CD        Ctrl=txtHIR_CD      Param=value </C>
        <C> Col=HIR_NM        Ctrl=txtHIR_NM      Param=value </C>
        <C> Col=HIR_TAG       Ctrl=txtHIR_TAG     Param=value </C>
        <C> Col=OK_ENO        Ctrl=txtOK_ENO      Param=value </C>
        <C> Col=OK_MAN        Ctrl=txtOK_MAN      Param=value </C>
        <C> Col=DISJOB_CD     Ctrl=txtDISJOB_CD   Param=value </C>
        <C> Col=DISJOB_NM     Ctrl=txtDISJOB_NM   Param=value </C>
        <C> Col=DISDPT_CD     Ctrl=txtDISDPT_CD   Param=value </C>
        <C> Col=DISDPT_NM     Ctrl=txtDISDPT_NM   Param=value </C>
        <C> Col=JOB_TAG       Ctrl=txtJOB_TAG     Param=value </C>
        <C> Col=EDGR_CD       Ctrl=txtEDGR_CD     Param=value </C>
        <C> Col=EDGR_NM       Ctrl=txtEDGR_NM     Param=value </C>
        <C> Col=SCH_CD        Ctrl=txtSCH_CD      Param=value </C>
        <C> Col=SCH_NM        Ctrl=txtSCH_NM      Param=value </C>
        <C> Col=MAJ_CD        Ctrl=txtMAJ_CD      Param=value </C>
        <C> Col=MAJ_NM        Ctrl=txtMAJ_NM      Param=value </C>
        <C> Col=GRD_CD        Ctrl=txtGRD_CD      Param=value </C>
        <C> Col=GRD_NM        Ctrl=txtGRD_NM      Param=value </C>
        <C> Col=GUR_YMD       Ctrl=txtGUR_YMD     Param=value </C>

        <C> Col=RET_CD        Ctrl=txtRET_CD      Param=value </C>
        <C> Col=RET_NM        Ctrl=txtRET_NM      Param=value </C>
        <C> Col=RET_YMD       Ctrl=txtRET_YMD     Param=value </C>
        <C> Col=CHNG_YMD      Ctrl=txtCHNG_YMD    Param=value </C>
        <C> Col=COC_NAM       Ctrl=txtCOC_NAM     Param=value </C>
        <C> Col=REMARK        Ctrl=txtREMARK      Param=value </C>
        
        <C> Col=DISCOMP_NM    Ctrl=txtDISCOMP_NM  Param=value </C>
        <C> Col=CONS_YMD      Ctrl=txtCONS_YMD    Param=value </C>
        <C> Col=CONE_YMD      Ctrl=txtCONE_YMD    Param=value </C>

        <C> Col=BAS_AMT       Ctrl=medBAS_AMT     Param=text </C>
        <C> Col=LSEV_AMT1     Ctrl=medLSEV_AMT1   Param=text </C>
        <C> Col=LSEV_AMT2     Ctrl=medLSEV_AMT2   Param=text </C>
        <C> Col=LSEV_AMT3     Ctrl=medLSEV_AMT3   Param=text </C>
        <C> Col=WEL_AMT       Ctrl=medWEL_AMT     Param=text </C>
    '>
</object>
<!-- 
        <C> Col=BCT_CD        Ctrl=txtBCT_CD      Param=value </C>
        <C> Col=BCT_NM        Ctrl=txtBCT_NM      Param=value </C>
        <C> Col=HF_NAM        Ctrl=txtHF_NAM      Param=value </C>
        <C> Col=HFRE_CD       Ctrl=txtHFRE_CD     Param=value </C>
        <C> Col=HFRE_NM       Ctrl=txtHFRE_NM     Param=value </C>
        <C> Col=PER_ADR       Ctrl=txtPER_ADR     Param=value </C>
 -->