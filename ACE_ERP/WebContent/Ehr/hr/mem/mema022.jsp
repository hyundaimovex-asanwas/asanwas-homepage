<!--
    ************************************************************************************
    * @Source         : mema022.jsp                                                    *
    * @Description    : 계약변경내역 PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/01/23  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>


<html>
    <head>
    <title>계약변경내역</title>
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

            dsT_ME_CONTRACT.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema022.cmd.MEMA022CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_ME_CONTRACT.Reset();

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

                trT_ME_CONTRACT.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema022.cmd.MEMA022CMD&S_MODE=SAV&ENO_NO_SHR="+document.getElementById("ENO_NO").value;
                trT_ME_CONTRACT.post();

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
            if (dsT_ME_CONTRACT.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_ME_CONTRACT.RowStatus(dsT_ME_CONTRACT.RowPosition);

            //DataSet의 변경 여부 확인
            if (dsT_ME_CONTRACT.IsUpdated && status != 1) {
                alert("화면에 변경사항이 존재합니다.\n먼저 화면 내용을 저장하신 다음 작업하여 주십시오.");
                return false;
            }

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("계약일자[" + dsT_ME_CONTRACT.NameValue(dsT_ME_CONTRACT.RowPosition,"CON_YMD") + "] 차수[" + dsT_ME_CONTRACT.NameValue(dsT_ME_CONTRACT.RowPosition,"DEGREE_GBN") + "], 업체명[" + dsT_ME_CONTRACT.NameValue(dsT_ME_CONTRACT.RowPosition,"DISCOMP_NM") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_ME_CONTRACT.DeleteRow(dsT_ME_CONTRACT.RowPosition);

            if (status != 1) {
                trT_ME_CONTRACT.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema022.cmd.MEMA022CMD&S_MODE=DEL";
                trT_ME_CONTRACT.post();
            }

            bnd.ActiveBind = false;

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_ME_CONTRACT.SetColumn(form1.grdT_ME_CONTRACT.GetColumnID(0));
            form1.grdT_ME_CONTRACT.Focus();

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
            if (dsT_ME_CONTRACT.CountColumn == 0) {
                dsT_ME_CONTRACT.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, CON_YMD:STRING:KEYVALUETYPE, CONS_YMD:STRING, CONS_YMD:STRING, DEGREE_GBN:STRING:KEYVALUETYPE, DISCOMP_CD:STRING:KEYVALUETYPE, REMARK:STRING");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_ME_CONTRACT.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_ME_CONTRACT.setColumn(form1.grdT_ME_CONTRACT.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;

            // KEY 필드는 신규시 입력 가능
            document.getElementById("txtCON_YMD").disabled = false;
            document.getElementById("ImgConYmd").disabled  = false;

            document.getElementById("txtCON_YMD").focus();
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

			dsT_ME_CONTRACT.ClearData();
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
            if (!dsT_ME_CONTRACT.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }

            for ( i = 1; i <= dsT_ME_CONTRACT.CountRow; i++ ) {
                if ( dsT_ME_CONTRACT.RowStatus(i) == 1 ||
                     dsT_ME_CONTRACT.RowStatus(i) == 3 ) {


                    // 계약일자
                    if( dsT_ME_CONTRACT.NameValue(i, "CON_YMD") == '' ) {
                        alert("계약일자는 필수 입력사항입니다.");
                        dsT_ME_CONTRACT.RowPosition = i;
                        document.getElementById("txtCON_YMD").focus();
                        return false;
                    }

                    // 계약일자 CHECK
                    if (!fnc_CheckDate2(dsT_ME_CONTRACT.NameValue(i, "CON_YMD"), "계약일자") && dsT_ME_CONTRACT.NameValue(i, "CON_YMD") != "") {
                        dsT_ME_CONTRACT.RowPosition = i;
                        document.getElementById("txtCON_YMD").focus();
                        return false;
                    }

                    // 차수
                    if( dsT_ME_CONTRACT.NameValue(i, "DEGREE_GBN") == '' ) {
                        alert("차수는 필수 입력사항입니다.");
                        dsT_ME_CONTRACT.RowPosition = i;
                        document.getElementById("cmbDEGREE_GBN").focus();
                        return false;
                    }

                    // 계약시작일자
                    if( dsT_ME_CONTRACT.NameValue(i, "CONS_YMD") == '' ) {
                        alert("계약시작일자는 필수 입력사항입니다.");
                        dsT_ME_CONTRACT.RowPosition = i;
                        document.getElementById("txtCONS_YMD").focus();
                        return false;
                    }

                    // 계약시작일자 CHECK
                    if (!fnc_CheckDate2(dsT_ME_CONTRACT.NameValue(i, "CONS_YMD"), "계약시작일자") && dsT_ME_CONTRACT.NameValue(i, "CONS_YMD") != "") {
                        dsT_ME_CONTRACT.RowPosition = i;
                        document.getElementById("txtCONS_YMD").focus();
                        return false;
                    }

                    // 계약종료일자
                    if( dsT_ME_CONTRACT.NameValue(i, "CONE_YMD") == '' ) {
                        alert("계약종료일자는 필수 입력사항입니다.");
                        dsT_ME_CONTRACT.RowPosition = i;
                        document.getElementById("txtCON_YMD").focus();
                        return false;
                    }

                    // 계약종료일자 CHECK
                    if (!fnc_CheckDate2(dsT_ME_CONTRACT.NameValue(i, "CONE_YMD"), "계약종료일자") && dsT_ME_CONTRACT.NameValue(i, "CONE_YMD") != "") {
                        dsT_ME_CONTRACT.RowPosition = i;
                        document.getElementById("txtCONE_YMD").focus();
                        return false;
                    }

                    // 계약일자와 계약시작일자 비교
                    if( dsT_ME_CONTRACT.NameValue(i, "CON_YMD") != '' && dsT_ME_CONTRACT.NameValue(i, "CONS_YMD") != '' ) {
                        if( cfDateDiff(dsT_ME_CONTRACT.NameValue(i, "CON_YMD").replace(/\-/g,''),dsT_ME_CONTRACT.NameValue(i, "CONS_YMD").replace(/\-/g,'')) < 0 ) {
                            alert("계약일자가 계약시작일자보다 큽니다.");
                            dsT_ME_CONTRACT.RowPosition = i;
                            document.getElementById("txtCONS_YMD").focus();
                            return false;
                        }
                    }

                    // 계약기간의 시작일자와 종료일자 비교
                    if( dsT_ME_CONTRACT.NameValue(i, "CONS_YMD") != '' && dsT_ME_CONTRACT.NameValue(i, "CONE_YMD") != '' ) {
                        if( cfDateDiff(dsT_ME_CONTRACT.NameValue(i, "CONS_YMD").replace(/\-/g,''),dsT_ME_CONTRACT.NameValue(i, "CONE_YMD").replace(/\-/g,'')) < 0 ) {
                            alert("시작일자가 종료일자보다 큽니다.");
                            dsT_ME_CONTRACT.RowPosition = i;
                            document.getElementById("txtCONS_YMD").focus();
                            return false;
                        }
                    }

                    // 파견업체
                    if( dsT_ME_CONTRACT.NameValue(i, "DISCOMP_CD") == '' ) {
                        alert("파견업체코드는 필수 입력사항입니다.");
                        dsT_ME_CONTRACT.RowPosition = i;
                        document.getElementById("txtDISCOMP_CD").focus();
                        return false;
                    }

                    // 파견업체
                    if (dsT_ME_CONTRACT.NameValue(i, "txtDISCOMP_CD") != "" &&
                        dsT_ME_CONTRACT.NameValue(i, "txtDISCOMP_NM") == "") {
                        alert("파견업체코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_ME_CONTRACT.RowPosition = i;
                        document.getElementById("txtDISCOMP_CD").focus();
                        return;
                    }

                    if ( dsT_ME_CONTRACT.RowStatus(i) == 1) {
                       document.getElementById("txtCON_YMD").disabled = true;
                       document.getElementById("ImgConYmd").disabled  = true;

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
            cfStyleGrid(form1.grdT_ME_CONTRACT, 0,"false","false");

            fnc_SearchList();

        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            //이곳에 해당 코딩을 입력 하세요
            if (dsT_ME_CONTRACT.IsUpdated)  {
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

                document.getElementById("txtCON_YMD").disabled    = false;
                document.getElementById("cmbDEGREE_GBN").disabled = false;
                document.getElementById("txtCONS_YMD").disabled   = false;
                document.getElementById("txtCONE_YMD").disabled   = false;
                document.getElementById("txtDISCOMP_CD").disabled = false;
                document.getElementById("txtREMARK").disabled     = false;

                document.getElementById("ImgConYmd").disabled    = false;
                document.getElementById("ImgConsYmd").disabled   = false;
                document.getElementById("ImgConeYmd").disabled   = false;
                document.getElementById("ImgDisCompCd").disabled = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtCON_YMD").disabled    = true;
                document.getElementById("cmbDEGREE_GBN").disabled = true;
                document.getElementById("txtCONS_YMD").disabled   = true;
                document.getElementById("txtCONE_YMD").disabled   = true;
                document.getElementById("txtDISCOMP_CD").disabled = true;
                document.getElementById("txtREMARK").disabled     = true;

                document.getElementById("ImgConYmd").disabled    = true;
                document.getElementById("ImgConsYmd").disabled   = true;
                document.getElementById("ImgConeYmd").disabled   = true;
                document.getElementById("ImgDisCompCd").disabled = true;

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
    | 2. 이름 : dsT_ME_CONTRACT                    |
    | 3. Table List : T_ME_CONTRACT                |
    +----------------------------------------------->
    <Object ID="dsT_ME_CONTRACT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_ME_CONTRACT                    |
    | 3. Table List : T_ME_CONTRACT                |
    +----------------------------------------------->
    <Object ID ="trT_ME_CONTRACT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ME_CONTRACT)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ME_CONTRACT Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ME_CONTRACT.CountRow);

            document.getElementById("txtCON_YMD").disabled = true;
            document.getElementById("ImgConYmd").disabled  = true;

        }


    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_ME_CONTRACT Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ME_CONTRACT Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018 ) {
            alert("해당 필수입력항목[계약일자/차수/업체코드] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50020) {
            alert("계약일자/차수/업체코드에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_ME_CONTRACT event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_ME_CONTRACT event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_ME_CONTRACT Event="OnRowPosChanged(row)">

        var SysStatus = dsT_ME_CONTRACT.SysStatus(row);

        if (SysStatus == 1) {
            document.getElementById("txtCON_YMD").disabled = false;
            document.getElementById("ImgConYmd").disabled  = false;

        }
        else {
            document.getElementById("txtCON_YMD").disabled = true;
            document.getElementById("ImgConYmd").disabled  = true;

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
            <strong>계약변경내역</strong>
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
                    <col width="80 "></col>
                    <col width="150"></col>
                    <col width="80 "></col>
                    <col width="100 "></col>
                    <col width="80 "></col>
                    <col width="* "></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">계약일자</td>
                    <td class="padding2423">
                        <input id="txtCON_YMD" style="width:80%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '계약일자');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgConYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgConYmd" name="ImgConYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtCON_YMD','','55','53');"></a>
                    </td>
                    <td align="center" class="creamBold">차&nbsp;&nbsp;&nbsp;&nbsp;수</td>
                    <td class="padding2423">
                        <select id="cmbDEGREE_GBN" style="width:100%" >
                            <option value="1" >1차</option>
                            <option value="2" >2차</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">계약기간</td>
                    <td class="padding2423">
                        <input id="txtCONS_YMD" style="width:34%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '계약시작일자');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgConsYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgConsYmd" name="ImgConsYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtCONS_YMD','','450','53');"></a> -
                        <input id="txtCONE_YMD" style="width:34%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '계약종료일자');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgConeYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgConeYmd" name="ImgConeYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtCONE_YMD','','590','53');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">파견업체</td>
                    <td class="padding2423">
                        <input id="txtDISCOMP_CD" style="width:20%" maxlength="5" onChange="fnc_GetCommNm('CA', 'txtDISCOMP_CD','txtDISCOMP_NM');"> <input id="txtDISCOMP_NM" style="width:55%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDisCompCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDisCompCd" name="ImgDisCompCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtDISCOMP_CD','txtDISCOMP_NM','파견업체','CA')"></a>
                    </td>
                    <td align="center" class="creamBold">비&nbsp;&nbsp;&nbsp;&nbsp;고</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtREMARK" maxlength="60" style="width:100%">
                    </td>
                    <input type=hidden   id="txtENO_NO" size="10">
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
                        <object id="grdT_ME_CONTRACT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:794px;height:178px;">
                            <param name="DataID"                  value="dsT_ME_CONTRACT">
                            <param name="Format"                  value="
                                <C> id={currow}        width=40   name='순번'         align=center </C>
                                <C> id=CON_YMD         width=100  name='계약일자'     align=center </C>
                                <C> id=DEGREE_GBN      width=100  name='차수'         align=center </C>
                                <C> id=CONS_YMD        width=100  name='계약시작일'   align=center </C>
                                <C> id=CONE_YMD        width=100  name='계약만료일'   align=center </C>
                                <C> id=DISCOMP_CD      width=100  name='업체코드'     align=center </C>
                                <C> id=DISCOMP_NM      width=100  name='업체명'                    </C>
                                <C> id=REMARK          width=130  name='비고'                      </C>
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
<!-- 계약변경내역 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ME_CONTRACT">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=CON_YMD       Ctrl=txtCON_YMD      Param=value </C>
        <C> Col=DEGREE_GBN    Ctrl=cmbDEGREE_GBN   Param=value </C>
        <C> Col=CONS_YMD      Ctrl=txtCONS_YMD     Param=value </C>
        <C> Col=CONE_YMD      Ctrl=txtCONE_YMD     Param=value </C>
        <C> Col=DISCOMP_CD    Ctrl=txtDISCOMP_CD   Param=value </C>
        <C> Col=DISCOMP_NM    Ctrl=txtDISCOMP_NM   Param=value </C>
        <C> Col=REMARK        Ctrl=txtREMARK       Param=value </C>
    '>
</object>