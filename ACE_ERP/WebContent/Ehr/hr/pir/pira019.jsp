<!--
    ************************************************************************************
    * @Source         : pira019.jsp                                                    *
    * @Description    : 건강검진 PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            이동훈            	ERP 이사											*
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>건강검진</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<%
    String ENO_NO  = request.getParameter("ENO_NO");         //사번
    String p_mode  = request.getParameter("mode")  != null ? request.getParameter("mode") : "";
    String p_srcid = request.getParameter("srcid") != null ? request.getParameter("srcid") : "";
%>

    <!--
    ******************************************************
    * 자바스크립트 함수 선언부분
    ******************************************************
    -->
    <script language="javascript" >
        var p_mode  = "<%=p_mode %>";
        var p_srcid = "<%=p_srcid %>";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            dsT_CM_BODY.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira019.cmd.PIRA019CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_CM_BODY.Reset();

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

                trT_CM_BODY.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira019.cmd.PIRA019CMD&S_MODE=SAV";
                trT_CM_BODY.post();

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
            if (dsT_CM_BODY.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_CM_BODY.RowStatus(dsT_CM_BODY.RowPosition);

            //DataSet의 변경 여부 확인
            if (dsT_CM_BODY.IsUpdated && status != 1) {
                alert("화면에 변경사항이 존재합니다.\n먼저 화면 내용을 저장하신 다음 작업하여 주십시오.");
                return false;
            }

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("실시일자[" + dsT_CM_BODY.NameValue(dsT_CM_BODY.RowPosition,"PRO_YMD") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_CM_BODY.DeleteRow(dsT_CM_BODY.RowPosition);

            if (status != 1) {
                trT_CM_BODY.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira019.cmd.PIRA019CMD&S_MODE=DEL";
                trT_CM_BODY.post();
            }

            bnd.ActiveBind = false;

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_CM_BODY.SetColumn(form1.grdT_CM_BODY.GetColumnID(0));
            form1.grdT_CM_BODY.Focus();

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
            if (dsT_CM_BODY.CountColumn == 0) {
                dsT_CM_BODY.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, PRO_YMD:STRING:KEYVALUETYPE, EYE_LEF:DECIMAL, EYE_RHT:DECIMAL, HEIGHT:DECIMAL, WEIGHT:DECIMAL, AB_HGT:DECIMAL, CBLD_CD:STRING, CBLD_NM:STRING, BLD_TYP:STRING, XRY_RMK:STRING, BLD_PRE:STRING, BLD_DAN:STRING, PH:STRING, EXM_HSP:STRING, DECISION:STRING, SPEC:STRING");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_CM_BODY.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_CM_BODY.setColumn(form1.grdT_CM_BODY.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;

            document.getElementById("txtOCC_CD").value = parent.document.getElementById("txtOCC_CD").value;

            // KEY 필드는 신규시 입력 가능
            document.getElementById("txtPRO_YMD").disabled = false;
            document.getElementById("ImgProYmd").disabled  = false;
            document.getElementById("txtPRO_YMD").focus();
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

   			dsT_CM_BODY.ClearData();
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
            if (!dsT_CM_BODY.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }

            for ( i = 1; i <= dsT_CM_BODY.CountRow; i++ ) {
                if ( dsT_CM_BODY.RowStatus(i) == 1 ||
                     dsT_CM_BODY.RowStatus(i) == 3 ) {


                    // 실시일
                    if( dsT_CM_BODY.NameValue(i, "txtPRO_YMD") == '' ) {
                        alert("실시일자는 필수 입력사항입니다.");
                        dsT_CM_BODY.RowPosition = i;
                        document.getElementById("txtPRO_YMD").focus();
                        return false;
                    }

                    // 실시일 CHECK
                    if (!fnc_CheckDate2(dsT_CM_BODY.NameValue(i, "PRO_YMD"), "실시일") && dsT_CM_BODY.NameValue(i, "PRO_YMD") != "") {
                        dsT_CM_BODY.RowPosition = i;
                        document.getElementById("txtPRO_YMD").focus();
                        return false;
                    }

                    // 색맹
                    if (dsT_CM_BODY.NameValue(i, "CBLD_CD") != "" &&
                        dsT_CM_BODY.NameValue(i, "CBLD_NM") == "") {
                        alert("색맹코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_CM_BODY.RowPosition = i;
                        document.getElementById("txtCBLD_CD").focus();
                        return;
                    }

                    if ( dsT_CM_BODY.RowStatus(i) == 1) {
                       document.getElementById("txtPRO_YMD").disabled = true;
                       document.getElementById("ImgProYmd").disabled  = true;
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
            cfStyleGrid_New(form1.grdT_CM_BODY, 0,"false","false");

            fnc_SearchList();

            //개인정보 조회시 처리
            if(p_mode == "read" || p_srcid == 'pirc010') {
                document.getElementById("txtEYE_LEF").className = "input_ReadOnly";
                document.getElementById("txtEYE_LEF").readOnly     = true;
                document.getElementById("txtEYE_RHT").className = "input_ReadOnly";
                document.getElementById("txtEYE_RHT").readOnly     = true;
                document.getElementById("txtHEIGHT").className = "input_ReadOnly";
                document.getElementById("txtHEIGHT").readOnly     = true;
                document.getElementById("txtWEIGHT").className = "input_ReadOnly";
                document.getElementById("txtWEIGHT").readOnly     = true;
                document.getElementById("txtAB_HGT").className = "input_ReadOnly";
                document.getElementById("txtAB_HGT").readOnly     = true;
                document.getElementById("txtCBLD_CD").className = "input_ReadOnly";
                document.getElementById("txtCBLD_CD").readOnly     = true;
                document.getElementById("txtBLD_TYP").className = "input_ReadOnly";
                document.getElementById("txtBLD_TYP").readOnly     = true;
                document.getElementById("txtXRY_RMK").className = "input_ReadOnly";
                document.getElementById("txtXRY_RMK").readOnly     = true;
                document.getElementById("txtBLD_PRE").className = "input_ReadOnly";
                document.getElementById("txtBLD_PRE").readOnly     = true;
                document.getElementById("txtBLD_DAN").className = "input_ReadOnly";
                document.getElementById("txtBLD_DAN").readOnly     = true;
                document.getElementById("txtPH").className = "input_ReadOnly";
                document.getElementById("txtPH").readOnly     = true;
                document.getElementById("txtEXM_HSP").className = "input_ReadOnly";
                document.getElementById("txtEXM_HSP").readOnly     = true;
                document.getElementById("txtDECISION").className = "input_ReadOnly";
                document.getElementById("txtDECISION").readOnly     = true;
                document.getElementById("txtSPEC").className = "input_ReadOnly";
                document.getElementById("txtSPEC").readOnly     = true;
                form1.medCHIT_AMT.enabled                       = false;

                document.getElementById("ImgProYmd").style.display = "none";
                document.getElementById("ImgCbldCd").style.display = "none";
                document.getElementById("ImgAdd").style.display = "none";
                document.getElementById("imgSave").style.display = "none";
                document.getElementById("imgClear").style.display = "none";
                document.getElementById("imgDelete").style.display = "none";

                //비용 숨기기
                form1.medCHIT_AMT.Visible = "false";
                document.getElementById("txtCHIT_AMT").style.display = "none";
                form1.grdT_CM_BODY.ColumnProp("CHIT_AMT","Show") = false;
            }
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

                document.getElementById("txtENO_NO").disabled   = false;
                document.getElementById("txtPRO_YMD").disabled  = false;
                document.getElementById("txtEYE_LEF").disabled  = false;
                document.getElementById("txtEYE_RHT").disabled  = false;
                document.getElementById("txtHEIGHT").disabled   = false;
                document.getElementById("txtWEIGHT").disabled   = false;
                document.getElementById("txtAB_HGT").disabled   = false;
                document.getElementById("txtCBLD_CD").disabled  = false;
                document.getElementById("txtCBLD_NM").disabled  = false;
                document.getElementById("txtBLD_TYP").disabled  = false;
                document.getElementById("txtXRY_RMK").disabled  = false;
                document.getElementById("txtBLD_PRE").disabled  = false;
                document.getElementById("txtBLD_DAN").disabled  = false;
                document.getElementById("txtPH").disabled       = false;
                document.getElementById("txtEXM_HSP").disabled  = false;
                document.getElementById("txtDECISION").disabled = false;
                document.getElementById("txtSPEC").disabled     = false;
                form1.medCHIT_AMT.enabled                       = true;
                document.getElementById("ImgProYmd").disabled   = false;
                document.getElementById("ImgCbldCd").disabled   = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtENO_NO").disabled   = true;
                document.getElementById("txtPRO_YMD").disabled  = true;
                document.getElementById("txtEYE_LEF").disabled  = true;
                document.getElementById("txtEYE_RHT").disabled  = true;
                document.getElementById("txtHEIGHT").disabled   = true;
                document.getElementById("txtWEIGHT").disabled   = true;
                document.getElementById("txtAB_HGT").disabled   = true;
                document.getElementById("txtCBLD_CD").disabled  = true;
                document.getElementById("txtCBLD_NM").disabled  = true;
                document.getElementById("txtBLD_TYP").disabled  = true;
                document.getElementById("txtXRY_RMK").disabled  = true;
                document.getElementById("txtBLD_PRE").disabled  = true;
                document.getElementById("txtBLD_DAN").disabled  = true;
                document.getElementById("txtPH").disabled       = true;
                document.getElementById("txtEXM_HSP").disabled  = true;
                document.getElementById("txtDECISION").disabled = true;
                document.getElementById("txtSPEC").disabled     = true;
                form1.medCHIT_AMT.enabled                       = false;
                document.getElementById("ImgProYmd").disabled   = true;
                document.getElementById("ImgCbldCd").disabled   = true;

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
    | 2. 이름 : dsT_CM_BODY                         |
    | 3. Table List : T_CM_BODY                     |
    +----------------------------------------------->
    <Object ID="dsT_CM_BODY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CM_BODY                         |
    | 3. Table List : T_CM_BODY                     |
    +----------------------------------------------->
    <Object ID ="trT_CM_BODY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_BODY)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_BODY Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_BODY.CountRow);

            document.getElementById("txtPRO_YMD").disabled = true;
            document.getElementById("ImgProYmd").disabled  = true;

        }

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_BODY Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_BODY Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018 ) {
            alert("해당 필수입력항목[실시일자] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
            alert("실시일자에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CM_BODY event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CM_BODY event="OnFail()">

        cfErrorMsg(this);

    </script>


    <script language=JavaScript for=dsT_CM_BODY Event="OnRowPosChanged(row)">

        var SysStatus = dsT_CM_BODY.SysStatus(row);

        if (SysStatus == 1) {
            document.getElementById("txtPRO_YMD").disabled = false;
            document.getElementById("ImgProYmd").disabled  = false;

        }
        else {
            document.getElementById("txtPRO_YMD").disabled = true;
            document.getElementById("ImgProYmd").disabled  = true;

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
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="../../images/button/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>건강검진</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAdd','','../../images/button/btn_AddnewOver.gif',1)">  <img src="../../images/button/btn_AddnewOn.gif"  name="imgAdd"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">   <img src="../../images/button/btn_SaveOn.gif"    name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','../../images/button/btn_DeleteOver.gif',1)"><img src="../../images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100 "></col>
                    <col width="150"></col>
                    <col width="100 "></col>
                    <col width="150"></col>
                    <col width="100 "></col>
                    <col width="150"></col>
                    <col width="100 "></col>
                    <col width="150"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">실 시 일</td>
                    <td class="padding2423" >
                        <input id="txtPRO_YMD" style="width:75%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '실시일');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgProYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgProYmd" name="ImgProYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPRO_YMD','','10','52');"></a>
                    </td>
                    <td align="center" class="blueBold">시&nbsp;&nbsp;&nbsp;&nbsp;력</td>
                    <td class="padding2423" >
                        좌 <input id="txtEYE_LEF" maxlength="4" size="4" style="text-align:right;ime-mode:disabled;" onKeyPress="JavaScript: cfCheckNumber3();">&nbsp;&nbsp;&nbsp;우 <input id="txtEYE_RHT" maxlength="4" size="4" style="text-align:right;"onKeyPress="JavaScript: cfCheckNumber3();">
                    </td>
                    <td align="center" class="blueBold">신&nbsp;&nbsp;&nbsp;&nbsp;장</td>
                    <td class="padding2423" >
                        <input id="txtHEIGHT" maxlength="5" style="width:80%;text-align:right;ime-mode:disabled;" onKeyPress="JavaScript: cfCheckNumber3();"> cm
                    </td>
                    <td align="center" class="blueBold">체&nbsp;&nbsp;&nbsp;&nbsp;중</td>
                    <td class="padding2423" >
                        <input id="txtWEIGHT" maxlength="5" style="width:80%;text-align:right;ime-mode:disabled;" onKeyPress="JavaScript: cfCheckNumber3();"> Kg
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">흉&nbsp;&nbsp;&nbsp;&nbsp;위</td>
                    <td class="padding2423" >
                        <input id="txtAB_HGT" maxlength="5" style="width:80%;text-align:right;ime-mode:disabled;" onKeyPress="JavaScript: cfCheckNumber3();"> cm
                    </td>
                    <td align="center" class="blueBold">색&nbsp;&nbsp;&nbsp;&nbsp;맹</td>
                    <td class="padding2423">
                        <input id="txtCBLD_CD" style="width:22%" maxlength="2" onChange="fnc_GetCommNm('D4', 'txtCBLD_CD','txtCBLD_NM');"> <input id="txtCBLD_NM" style="width:50%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgCbldCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgCbldCd" name="ImgCbldCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtCBLD_CD','txtCBLD_NM','색맹','D4')"></a>
                    </td>
                    <td align="center" class="blueBold">혈 액 형</td>
                    <td class="padding2423" >
                        <input id="txtBLD_TYP" maxlength="5" style="width:100%">
                    </td>
                    <td align="center" class="blueBold">혈&nbsp;&nbsp;&nbsp;&nbsp;압</td>
                    <td class="padding2423" >
                        <input id="txtBLD_PRE" maxlength="8" style="width:100%;ime-mode:disabled" onKeyPress="JavaScript: cfCheckNumber4();">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">혈&nbsp;&nbsp;&nbsp;&nbsp;당</td>
                    <td class="padding2423" >
                        <input id="txtBLD_DAN" maxlength="8" style="width:100%;text-align:right;">
                    </td>
                    <td align="center" class="blueBold">pH</td>
                    <td class="padding2423" >
                        <input id="txtPH" maxlength="8" style="width:100%;ime-mode:disabled;text-align:right;" onKeyPress="JavaScript: cfCheckNumber3();">
                    </td>
                    <td align="center" class="blueBold">X선 소견</td>
                    <td class="padding2423" >
                        <input id="txtXRY_RMK" maxlength="10" style="width:100%">
                    </td>
                    <td align="center" class="blueBold">검사병원</td>
                    <td class="padding2423" >
                        <input id="txtEXM_HSP" maxlength="10" style="width:100%">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">판&nbsp;&nbsp;&nbsp;&nbsp;정</td>
                    <td class="padding2423" >
                        <input id="txtDECISION" maxlength="6" style="width:100%">
                    </td>
                    <td align="center" class="blueBold">특기사항</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtSPEC" maxlength="40" style="width:100%">
                    </td>
                    <td align="center" class="blueBold"><span id="txtCHIT_AMT">비&nbsp;&nbsp;&nbsp;&nbsp;용</span></td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medCHIT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
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
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <input type=hidden   id="txtENO_NO" size="10">
                    <input type=hidden   id="txtOCC_CD" size="1">
            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
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
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object id="grdT_CM_BODY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:994px;height:300px;">
                            <param name="DataID"                  value="dsT_CM_BODY">
                            <param name="Format"                  value="
                                <C> id={currow}        width=40   name='순번'         align=center </C>
                                <C> id=PRO_YMD         width=80   name='실시일'                    </C>
                                <C> id=EYE_LEF         width=50   name='좌시력'                    </C>
                                <C> id=EYE_RHT         width=60   name='우시력'                    </C>
                                <C> id=HEIGHT          width=60   name='신장'                      </C>
                                <C> id=WEIGHT          width=60   name='체중'                      </C>
                                <C> id=AB_HGT          width=60   name='흉위'                      </C>
                                <C> id=CBLD_NM         width=60   name='색맹'                      </C>
                                <C> id=BLD_TYP         width=60   name='혈액형'                    </C>
                                <C> id=BLD_PRE         width=60   name='혈압'                      </C>
                                <C> id=BLD_DAN         width=60   name='혈당'                      </C>
                                <C> id=PH              		width=60   name='pH'                        </C>
                                <C> id=XRY_RMK         width=70   name='X선소견'                   </C>
                                <C> id=EXM_HSP         width=70   name='검사병원'                  </C>
                                <C> id=DECISION        width=50   name='판정'                      </C>
                                <C> id=SPEC            width=70  name='특기사항'                  </C>

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
<!-- 건강검진 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_BODY">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=PRO_YMD       Ctrl=txtPRO_YMD      Param=value </C>
        <C> Col=OCC_CD        Ctrl=txtOCC_CD       Param=value </C>
        <C> Col=EYE_LEF       Ctrl=txtEYE_LEF      Param=value </C>
        <C> Col=EYE_RHT       Ctrl=txtEYE_RHT      Param=value </C>
        <C> Col=HEIGHT        Ctrl=txtHEIGHT       Param=value </C>
        <C> Col=WEIGHT        Ctrl=txtWEIGHT       Param=value </C>
        <C> Col=AB_HGT        Ctrl=txtAB_HGT       Param=value </C>
        <C> Col=CBLD_CD       Ctrl=txtCBLD_CD      Param=value </C>
        <C> Col=CBLD_NM       Ctrl=txtCBLD_NM      Param=value </C>
        <C> Col=BLD_TYP       Ctrl=txtBLD_TYP      Param=value </C>
        <C> Col=XRY_RMK       Ctrl=txtXRY_RMK      Param=value </C>
        <C> Col=BLD_PRE       Ctrl=txtBLD_PRE      Param=value </C>
        <C> Col=BLD_DAN       Ctrl=txtBLD_DAN      Param=value </C>
        <C> Col=PH            Ctrl=txtPH           Param=value </C>
        <C> Col=EXM_HSP       Ctrl=txtEXM_HSP      Param=value </C>
        <C> Col=DECISION      Ctrl=txtDECISION     Param=value </C>
        <C> Col=SPEC          Ctrl=txtSPEC         Param=value </C>
        <C> Col=CHIT_AMT      Ctrl=medCHIT_AMT     Param=text  </C>
    '>
</object>