<!--
    ************************************************************************************
    * @Source         : pira012.jsp                                                    		*
    * @Description    : 인사기본2 PAGE                                                	 	*
    * @Developer Desc :                                                                		*
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            	*
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            이동훈            	ERP 이사											*
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>인사기본2</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

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

            if (form1.ENO_NO.value == "" || (parent.dsT_CM_PERSON.CountRow < 1 && parent.dsT_CM_PERSON.RowStatus(1) != 1)) {

                dsT_CM_PERSON.ClearData();
                fnc_ColEnabled('D');

                document.getElementById("resultMessage").innerText = '';
                if (parent.document.getElementById("txtENO_NO").disabled == false) {
                    parent.document.getElementById("txtENO_NM").focus();
                }

                return;
            }

            dsT_CM_PERSON.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira012.cmd.PIRA012CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_CM_PERSON.Reset();

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
            if (!dsT_CM_PERSON.IsUpdated ) {
//                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return true;
            }

            if(fnc_SaveItemCheck()) {

                trT_CM_PERSON.KeyValue = "SVL(I:SAV=dsT_CM_PERSON)";
                trT_CM_PERSON.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira012.cmd.PIRA012CMD&S_MODE=SAV";
                trT_CM_PERSON.post();

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

			dsT_CM_PERSON.ClearData();
			document.getElementById("ENO_NO").value = ENO_NO;
			document.getElementById("resultMessage").innerText = ' ';
			//document.form1.txtHIR_CD.focus();

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

            // 기존입사일 CHECK
            if (!fnc_CheckDate(document.getElementById("txtRHI_YMD"), "기존입사일") && document.getElementById("txtRHI_YMD").value != "") {
                document.getElementById("txtRHI_YMD").focus();
                return false;
            }

            // 추천인
            if (document.getElementById("txtOK_ENO").value != "" &&
                document.getElementById("txtOK_MAN").value == "") {
                alert("추천인사번에 입력하신 값은 존재하지 않는 사번입니다. 확인바랍니다.");
                document.getElementById("txtOK_ENO").focus();
                return false;
            }

            // 국적
            if (document.getElementById("txtNAT_CD").value != "" &&
                document.getElementById("txtNAT_NM").value == "") {
                alert("국적코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                document.getElementById("txtNAT_CD").focus();
                return false;
            }

            // 그룹사
            if (document.getElementById("txtGROUP_CD").value != "" &&
                document.getElementById("txtGROUP_NM").value == "") {
                alert("그룹사코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                document.getElementById("txtGROUP_CD").focus();
                return false;
            }

            // 출신도
            if (document.getElementById("txtBCT_CD").value != "" &&
                document.getElementById("txtBCT_NM").value == "") {
                alert("출신도코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                document.getElementById("txtBCT_CD").focus();
                return false;
            }

            // 본인과의관계
            if (document.getElementById("txtHFRE_CD").value != "" &&
                document.getElementById("txtHFRE_NM").value == "") {
                alert("관계코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                document.getElementById("txtHFRE_CD").focus();
                return false;
            }

            // 발급일 CHECK
            if (!fnc_CheckDate(document.getElementById("txtPISS_YMD"), "발급일") && document.getElementById("txtPISS_YMD").value != "") {
                document.getElementById("txtPISS_YMD").focus();
                return false;
            }

            // 갱신일 CHECK
            if (!fnc_CheckDate(document.getElementById("txtPCHG_YMD"), "갱신일") && document.getElementById("txtPCHG_YMD").value != "") {
                document.getElementById("txtPCHG_YMD").focus();
                return false;
            }

            // 만기일 CHECK
            if (!fnc_CheckDate(document.getElementById("txtPDUE_YMD"), "만기일") && document.getElementById("txtPDUE_YMD").value != "") {
                document.getElementById("txtPDUE_YMD").focus();
                return false;
            }

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
                document.getElementById("txtRHI_YMD").disabled    = false;
                document.getElementById("txtNAT_CD").disabled     = false;
                document.getElementById("txtGROUP_CD").disabled   = false;
                document.getElementById("txtOK_ENO").disabled     = false;
                document.getElementById("txtOK_MAN").disabled     = false;
                document.getElementById("txtEDGR_CD").disabled    = false;
                document.getElementById("txtSCH_CD").disabled     = false;
                document.getElementById("txtMAJ_CD").disabled     = false;
                document.getElementById("txtGRD_CD").disabled     = false;
                document.getElementById("txtGUR_YMD").disabled    = false;
                document.getElementById("txtBCT_CD").disabled     = false;
                document.getElementById("txtHF_NAM").disabled     = false;
                document.getElementById("txtHFRE_CD").disabled    = false;
                document.getElementById("txtPER_ADR").disabled    = false;
                document.getElementById("txtJAJ_YMD").disabled    = false;
                document.getElementById("txtFINJ_CD").disabled    = false;
                document.getElementById("txtTMR_YMD").disabled    = false;
                document.getElementById("txtTMR_DD").disabled     = false;
                document.getElementById("txtPAS_NO").disabled     = false;
                document.getElementById("txtPER_JOB").disabled    = false;
                document.getElementById("txtPISS_YMD").disabled   = false;
                document.getElementById("txtPCHG_YMD").disabled   = false;
                document.getElementById("txtPDUE_YMD").disabled   = false;

                document.getElementById("ImgHirCd").disabled      = false;
                document.getElementById("ImgRhiYmd").disabled     = false;
                document.getElementById("ImgNatCd").disabled      = false;
                document.getElementById("ImgGroupCd").disabled    = false;
                document.getElementById("ImgOkEno").disabled      = false;
                document.getElementById("ImgBctCd").disabled      = false;
                document.getElementById("ImgHfreCd").disabled     = false;
                document.getElementById("ImgPissYmd").disabled    = false;
                document.getElementById("ImgPchgYmd").disabled    = false;
                document.getElementById("ImgPdueYmd").disabled    = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtHIR_CD").disabled     = true;
                document.getElementById("txtRHI_YMD").disabled    = true;
                document.getElementById("txtNAT_CD").disabled     = true;
                document.getElementById("txtGROUP_CD").disabled   = true;
                document.getElementById("txtOK_ENO").disabled     = true;
                document.getElementById("txtOK_MAN").disabled     = true;
                document.getElementById("txtEDGR_CD").disabled    = true;
                document.getElementById("txtSCH_CD").disabled     = true;
                document.getElementById("txtMAJ_CD").disabled     = true;
                document.getElementById("txtGRD_CD").disabled     = true;
                document.getElementById("txtGUR_YMD").disabled    = true;
                document.getElementById("txtBCT_CD").disabled     = true;
                document.getElementById("txtHF_NAM").disabled     = true;
                document.getElementById("txtHFRE_CD").disabled    = true;
                document.getElementById("txtPER_ADR").disabled    = true;
                document.getElementById("txtJAJ_YMD").disabled    = true;
                document.getElementById("txtFINJ_CD").disabled    = true;
                document.getElementById("txtTMR_YMD").disabled    = true;
                document.getElementById("txtTMR_DD").disabled     = true;
                document.getElementById("txtPAS_NO").disabled     = true;
                document.getElementById("txtPER_JOB").disabled    = true;

                document.getElementById("txtPISS_YMD").disabled   = true;
                document.getElementById("txtPCHG_YMD").disabled   = true;
                document.getElementById("txtPDUE_YMD").disabled   = true;

                document.getElementById("ImgHirCd").disabled      = true;
                document.getElementById("ImgRhiYmd").disabled     = true;
                document.getElementById("ImgNatCd").disabled      = true;
                document.getElementById("ImgGroupCd").disabled    = true;
                document.getElementById("ImgOkEno").disabled      = true;
                document.getElementById("ImgBctCd").disabled      = true;
                document.getElementById("ImgHfreCd").disabled     = true;
                document.getElementById("ImgPissYmd").disabled    = true;
                document.getElementById("ImgPchgYmd").disabled    = true;
                document.getElementById("ImgPdueYmd").disabled    = true;

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
    | 2. 이름 : dsT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID ="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_PERSON.CountRow);
            document.getElementById("resultMessage").innerText = ' ';

        }

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">

        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CM_PERSON event="OnSuccess()">

//        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
          if (parent.savflag != '1') {
              parent.savflag = 1;
          }

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CM_PERSON event="OnFail()">

        cfErrorMsg(this);

    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body onload="fnc_OnLoadProcess();"> <!-- oncontextmenu="return false"-->

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
<table width="988" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>인사기본2</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="988" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="below">
                <tr>
                    <td></td>
                </tr>
            </table>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="vsides">
                <colgroup>
                    <col width="66 "></col>
                    <col width="80 "></col>
                    <col width="161"></col>
                    <col width="80 "></col>
                    <col width="161"></col>
                    <col width="79 "></col>
                    <col width="160"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold" rowspan="2">입사정보</td>
                    <td align="center" class="blueBold">채용구분</td>
                    <td class="padding2423">
                        <input id="txtHIR_CD" maxlength="3" style="width:17%" maxlength="2" onChange="fnc_GetCommNm('C1', 'txtHIR_CD','txtHIR_NM');"> <input id="txtHIR_NM" style="width:60%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHirCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgHirCd" name="ImgHirCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtHIR_CD','txtHIR_NM','채용구분','C1')"></a>
                    </td>
                    <td align="center" class="blueBold">기존입사일</td>
                    <td class="padding2423">
                        <input id="txtRHI_YMD" style="width:81%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '기존입사일');"  onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRhiYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgRhiYmd" name="ImgRhiYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtRHI_YMD','','360','55');"></a>
                    </td>
                    <td align="center" class="blueBold">국&nbsp;&nbsp;&nbsp;&nbsp;적</td>
                    <td class="padding2423">
                        <input id="txtNAT_CD" maxlength="3" style="width:17%" maxlength="2" onChange="fnc_GetCommNm('L2', 'txtNAT_CD','txtNAT_NM');"> <input id="txtNAT_NM" style="width:60%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgNatCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgNatCd" name="ImgNatCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtNAT_CD','txtNAT_NM','국적','L2')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">그룹사명</td>
                    <td class="padding2423">
                        <input id="txtGROUP_CD" maxlength="3" style="width:17%" maxlength="2" onChange="fnc_GetCommNm('B5', 'txtGROUP_CD','txtGROUP_NM');"> <input id="txtGROUP_NM" style="width:60%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgGroupCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgGroupCd" name="ImgGroupCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtGROUP_CD','txtGROUP_NM','그룹사','B5')"></a>
                    </td>
                    <td align="center" class="blueBold">추 천 인</td>
                    <td class="padding2423">
                        <input id="txtOK_ENO" maxlength="8" style="width:37%;ime-mode:disabled" onKeyPress="JavaScript: cfNumberCheck();"  onChange="fnc_GetEnoNm('txtOK_ENO','txtOK_MAN','1');"> <input id="txtOK_MAN" style="width:39%" onChange="fnc_GetEnoNo('txtOK_MAN','txtOK_ENO')">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgOkEno','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgOkEno" name="ImgOkEno" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtOK_ENO','txtOK_MAN', '1')"></a>
                    </td>
                    <td colspan="2">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold" rowspan="2">학력사항</td>
                    <td align="center" class="blueBold">학력구분</td>
                    <td class="padding2423">
                        <input id="txtEDGR_CD" maxlength="3" style="width:17%" maxlength="2" class="input_ReadOnly"  readonly> <input id="txtEDGR_NM" style="width:78%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">학 교 명</td>
                    <td class="padding2423">
                        <input id="txtSCH_CD" maxlength="3" style="width:17%" maxlength="2" class="input_ReadOnly"  readonly> <input id="txtSCH_NM" style="width:78%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">학&nbsp;&nbsp;&nbsp;&nbsp;과</td>
                    <td class="padding2423">
                        <input id="txtMAJ_CD" maxlength="3" style="width:17%" maxlength="2" class="input_ReadOnly"  readonly> <input id="txtMAJ_NM" style="width:78%" class="input_ReadOnly"  readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">졸업구분</td>
                    <td class="padding2423">
                        <input id="txtGRD_CD" maxlength="3" style="width:17%" maxlength="2" class="input_ReadOnly"  readonly> <input id="txtGRD_NM" style="width:78%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">졸 업 일</td>
                    <td class="padding2423">
                          <input id="txtGUR_YMD" style="width:100%;ime-mode:disabled" maxlength="10" onkeypress="cfDateHyphen(this);cfCheckNumber();" class="input_ReadOnly"  readonly>
                    <!--      <input id="txtGUR_YMD" style="width:100%;ime-mode:disabled" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" class="input_ReadOnly"  readonly> -->
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold" rowspan="2">신상정보</td>
                    <td align="center" class="blueBold">출 신 도</td>
                    <td class="padding2423">
                        <input id="txtBCT_CD" maxlength="3" style="width:17%" maxlength="2" onChange="fnc_GetCommNm('B4', 'txtBCT_CD','txtBCT_NM');"> <input id="txtBCT_NM" style="width:60%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgBctCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgBctCd" name="ImgBctCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtBCT_CD','txtBCT_NM','출신도','B4')"></a>
                    </td>
                    <td align="center" class="blueBold">호&nbsp;&nbsp;&nbsp;&nbsp;주</td>
                    <td class="padding2423">
                        <input id="txtHF_NAM" maxlength="12" style="width:100%"></td>
                    <td align="center" class="blueBold">관&nbsp;&nbsp;&nbsp;&nbsp;계</td>
                    <td class="padding2423">
                        <input id="txtHFRE_CD" maxlength="3" style="width:17%" maxlength="2" onChange="fnc_GetCommNm('G1', 'txtHFRE_CD','txtHFRE_NM');"> <input id="txtHFRE_NM" style="width:60%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHfreCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgHfreCd" name="ImgHfreCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtHFRE_CD','txtHFRE_NM','호주와의관계','G1')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">본&nbsp;&nbsp;&nbsp;&nbsp;적</td>
                    <td class="padding2423" colspan="5"><input id="txtPER_ADR" maxlength="60" style="width:100%"></td>
                </tr>
            </table>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="66 "></col>
                    <col width="83 "></col>
                    <col width="103"></col>
                    <col width="62 "></col>
                    <col width="142"></col>
                    <col width="62 "></col>
                    <col width="103"></col>
                    <col width="62 "></col>
                    <col width="100"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold" >발령사항</td>
                    <td align="center" class="blueBold">최종발령일</td>
                    <td class="padding2423">
                        <input id="txtJAJ_YMD" style="width:100%" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">재직구분</td>
                    <td class="padding2423">
                        <input id="txtFINJ_CD" maxlength="3" style="width:20%" maxlength="2" class="input_ReadOnly"  readonly> <input id="txtFINJ_NM" style="width:74%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">휴 직 일</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtTMR_YMD" style="width:26%" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" class="input_ReadOnly"  readonly>
                    </td>
                    <input type="hidden" id="txtTMR_DD" maxlength="5" style="width:100%"  class="input_ReadOnly"  readonly>
                </tr>
                <tr>
                    <td align="center" class="blueBold" >여권사항</td>
                    <td align="center" class="blueBold">여권번호</td>
                    <td class="padding2423"><input id="txtPAS_NO" maxlength="10" style="width:100%"></td>
                    <td align="center" class="blueBold">발 급 일</td>
                    <td class="padding2423">
                        <input id="txtPISS_YMD" style="width:78%" maxlength="10" onChange="fnc_CheckDate(this, '발급일');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPissYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgPissYmd" name="ImgPissYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPISS_YMD','','250','50');"></a>
                    </td>
                    <td align="center" class="blueBold">갱 신 일</td>
                    <td class="padding2423">
                        <input id="txtPCHG_YMD" style="width:69%" maxlength="10" onChange="fnc_CheckDate(this, '갱신일');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPchgYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgPchgYmd" name="ImgPchgYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPCHG_YMD','','430','50');"></a>
                    </td>
                    <td align="center" class="blueBold">만 기 일</td>
                    <td class="padding2423">
                        <input id="txtPDUE_YMD" style="width:69%" maxlength="10" onChange="fnc_CheckDate(this, '만기일');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPdueYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgPdueYmd" name="ImgPdueYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPDUE_YMD','','600','50');"></a>
                    </td>
                </tr>


                <tr>
                    <td align="center" class="blueBold">기타정보</td>
                    <td align="center" class="blueBold">담당업무</td>
                    <td class="padding2423" colspan="3"><input id="txtPER_JOB" maxlength="40" style="width:100%"></td>
                </tr>






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
    <Param Name="DataID",   Value="dsT_CM_PERSON">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=ENO_NO         Param=value Disable=disabled</C>
        <C> Col=HIR_CD        Ctrl=txtHIR_CD      Param=value </C>
        <C> Col=HIR_NM        Ctrl=txtHIR_NM      Param=value </C>
        <C> Col=RHI_YMD       Ctrl=txtRHI_YMD     Param=value </C>
        <C> Col=NAT_CD        Ctrl=txtNAT_CD      Param=value </C>
        <C> Col=NAT_NM        Ctrl=txtNAT_NM      Param=value </C>
        <C> Col=GROUP_CD      Ctrl=txtGROUP_CD    Param=value </C>
        <C> Col=GROUP_NM      Ctrl=txtGROUP_NM    Param=value </C>
        <C> Col=OK_ENO        Ctrl=txtOK_ENO      Param=value </C>
        <C> Col=OK_MAN        Ctrl=txtOK_MAN      Param=value </C>
        <C> Col=EDGR_CD       Ctrl=txtEDGR_CD     Param=value </C>
        <C> Col=EDGR_NM       Ctrl=txtEDGR_NM     Param=value </C>
        <C> Col=SCH_CD        Ctrl=txtSCH_CD      Param=value </C>
        <C> Col=SCH_NM        Ctrl=txtSCH_NM      Param=value </C>
        <C> Col=MAJ_CD        Ctrl=txtMAJ_CD      Param=value </C>
        <C> Col=MAJ_NM        Ctrl=txtMAJ_NM      Param=value </C>
        <C> Col=GRD_CD        Ctrl=txtGRD_CD      Param=value </C>
        <C> Col=GRD_NM        Ctrl=txtGRD_NM      Param=value </C>
        <C> Col=GUR_YMD       Ctrl=txtGUR_YMD     Param=value </C>
        <C> Col=BCT_CD        Ctrl=txtBCT_CD      Param=value </C>
        <C> Col=BCT_NM        Ctrl=txtBCT_NM      Param=value </C>
        <C> Col=HF_NAM        Ctrl=txtHF_NAM      Param=value </C>
        <C> Col=HFRE_CD       Ctrl=txtHFRE_CD     Param=value </C>
        <C> Col=HFRE_NM       Ctrl=txtHFRE_NM     Param=value </C>
        <C> Col=PER_ADR       Ctrl=txtPER_ADR     Param=value </C>
        <C> Col=JAJ_YMD       Ctrl=txtJAJ_YMD     Param=value </C>
        <C> Col=FINJ_CD       Ctrl=txtFINJ_CD     Param=value </C>
        <C> Col=FINJ_NM       Ctrl=txtFINJ_NM     Param=value </C>
        <C> Col=TMR_YMD       Ctrl=txtTMR_YMD     Param=value </C>
        <C> Col=TMR_DD        Ctrl=txtTMR_DD      Param=value </C>
        <C> Col=PAS_NO        Ctrl=txtPAS_NO      Param=value </C>
        <C> Col=PER_JOB       Ctrl=txtPER_JOB     Param=value </C>
        <C> Col=PISS_YMD      Ctrl=txtPISS_YMD    Param=value </C>
        <C> Col=PCHG_YMD      Ctrl=txtPCHG_YMD    Param=value </C>
        <C> Col=PDUE_YMD      Ctrl=txtPDUE_YMD    Param=value </C>
    '>
</object>