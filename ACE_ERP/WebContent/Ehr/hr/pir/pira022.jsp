<!--
    ************************************************************************************
    * @Source         : pira022.jsp                                                    *
    * @Description    : VISA PAGE                                                      *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/12/20  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>


<html>
    <head>
    <title>VISA</title>
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
        
            var radio = document.form1.rdoTMEN_TAG_SHR;
            var TMEN_TAG_SHR = "";
            
            for(i=0;i<radio.length;i++){
                if(radio[i].checked){
                     TMEN_TAG_SHR = radio[i].value;
                }
            }

            dsT_CM_VISA.DataId = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira022.cmd.PIRA022CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value+"&TMEN_TAG_SHR="+TMEN_TAG_SHR;
            dsT_CM_VISA.Reset();

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

                trT_CM_VISA.action = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira022.cmd.PIRA022CMD&S_MODE=SAV";
                trT_CM_VISA.post();

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
            if (dsT_CM_VISA.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_CM_VISA.RowStatus(dsT_CM_VISA.RowPosition);

            //DataSet의 변경 여부 확인
            if (dsT_CM_VISA.IsUpdated && status != 1) {
                alert("화면에 변경사항이 존재합니다.\n먼저 화면 내용을 저장하신 다음 작업하여 주십시오.");
                return false;
            }

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("발급국가[" + dsT_CM_VISA.NameValue(dsT_CM_VISA.RowPosition,"NAT_NM") + "] 발급일[" + dsT_CM_VISA.NameValue(dsT_CM_VISA.RowPosition,"ISS_YMD") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_CM_VISA.DeleteRow(dsT_CM_VISA.RowPosition);

            if (status != 1) {
                trT_CM_VISA.action = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira022.cmd.PIRA022CMD&S_MODE=DEL";
                trT_CM_VISA.post();
            }

            bnd.ActiveBind = false;

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_CM_VISA.SetColumn(form1.grdT_CM_VISA.GetColumnID(0));
            form1.grdT_CM_VISA.Focus();

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
            if (dsT_CM_VISA.CountColumn == 0) {
                dsT_CM_VISA.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, NAT_CD:STRING:KEYVALUETYPE, NAT_NM:STRING:KEYVALUETYPE, VISA_NO:STRING, ISS_YMD:STRING, DUE_YMD:STRING, TYPE_CD:STRING, TYPE_NM:STRING, TMEN_TAG:STRING, REMARK:STRING");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_CM_VISA.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_CM_VISA.setColumn(form1.grdT_CM_VISA.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;

            // KEY 필드는 신규시 입력 가능
            document.getElementById("txtNAT_CD").disabled  = false;
            document.getElementById("txtISS_YMD").disabled = false;
            document.getElementById("ImgNatCd").disabled   = false;
            document.getElementById("ImgIssYmd").disabled  = false;

            document.getElementById("txtNAT_CD").focus();
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

			dsT_CM_VISA.ClearData();
			document.getElementById("ENO_NO").value = ENO_NO;
			document.getElementById("resultMessage").innerText = ' ';
			//document.form1.txtGET_RSN.focus();

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
            if (!dsT_CM_VISA.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }

            for ( i = 1; i <= dsT_CM_VISA.CountRow; i++ ) {
                if ( dsT_CM_VISA.RowStatus(i) == 1 ||
                     dsT_CM_VISA.RowStatus(i) == 3 ) {


                    // 국가코드
                    if( dsT_CM_VISA.NameValue(i, "NAT_CD") == '' ) {
                        alert("국가코드는 필수 입력사항입니다.");
                        dsT_CM_VISA.RowPosition = i;
                        document.getElementById("txtNAT_CD").focus();
                        return false;
                    }

                    // 국가코드
                    if (dsT_CM_VISA.NameValue(i, "NAT_CD") != "" &&
                        dsT_CM_VISA.NameValue(i, "NAT_NM") == "") {
                        alert("국가코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_CM_VISA.RowPosition = i;
                        document.getElementById("txtNAT_CD").focus();
                        return;
                    }

                    // 비자종류
                    if (dsT_CM_VISA.NameValue(i, "TYPE_CD") != "" &&
                        dsT_CM_VISA.NameValue(i, "TYPE_NM") == "") {
                        alert("비자종류코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_CM_VISA.RowPosition = i;
                        document.getElementById("txtTYPE_CD").focus();
                        return;
                    }

                    // 발급일
                    if( dsT_CM_VISA.NameValue(i, "ISS_YMD") == '' ) {
                        alert("발급일은 필수 입력사항입니다.");
                        dsT_CM_VISA.RowPosition = i;
                        document.getElementById("txtISS_YMD").focus();
                        return false;
                    }

                    // 발급일 CHECK
                    if (!fnc_CheckDate2(dsT_CM_VISA.NameValue(i, "ISS_YMD"), "발급일") && dsT_CM_VISA.NameValue(i, "ISS_YMD") != "") {
                        dsT_CM_VISA.RowPosition = i;
                        document.getElementById("txtISS_YMD").focus();
                        return false;
                    }

                    // 만기일 CHECK
                    if (!fnc_CheckDate2(dsT_CM_VISA.NameValue(i, "DUE_YMD"), "만기일") && dsT_CM_VISA.NameValue(i, "DUE_YMD") != "") {
                        dsT_CM_VISA.RowPosition = i;
                        document.getElementById("txtDUE_YMD").focus();
                        return false;
                    }

                    // 발급일자와 만기일자 비교
                    if( dsT_CM_VISA.NameValue(i, "ISS_YMD") != '' && dsT_CM_VISA.NameValue(i, "DUE_YMD") != '' ) {
                        if( cfDateDiff(dsT_CM_VISA.NameValue(i, "ISS_YMD").replace(/\-/g,''),dsT_CM_VISA.NameValue(i, "DUE_YMD").replace(/\-/g,'')) < 0 ) {
                            alert("만기일자가 발급일자보다 작습니다.");
                            dsT_CM_VISA.RowPosition = i;
                            document.getElementById("txtDUE_YMD").focus();
                            return false;
                        }
                    }

                    if ( dsT_CM_VISA.RowStatus(i) == 1) {
                       document.getElementById("txtNAT_CD").disabled  = true;
                       document.getElementById("txtISS_YMD").disabled = true;
                       document.getElementById("ImgNatCd").disabled   = true;
                       document.getElementById("ImgIssYmd").disabled  = true;
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
            cfStyleGrid(form1.grdT_CM_VISA, 0,"false","false");

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
                document.getElementById("txtNAT_CD").disabled   = false;
                document.getElementById("txtVISA_NO").disabled  = false;
                document.getElementById("txtISS_YMD").disabled  = false;
                document.getElementById("txtDUE_YMD").disabled  = false;
                document.getElementById("txtTYPE_CD").disabled  = false;
                document.getElementById("txtREMARK").disabled   = false;

                document.getElementById("ImgNatCd").disabled   = false;
                document.getElementById("ImgIssYmd").disabled  = false;
                document.getElementById("ImgDueYmd").disabled  = false;
                document.getElementById("ImgTypeCd").disabled  = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtNAT_CD").disabled   = true;
                document.getElementById("txtVISA_NO").disabled  = true;
                document.getElementById("txtISS_YMD").disabled  = true;
                document.getElementById("txtDUE_YMD").disabled  = true;
                document.getElementById("txtTYPE_CD").disabled  = true;
                document.getElementById("txtREMARK").disabled   = true;

                document.getElementById("ImgNatCd").disabled   = true;
                document.getElementById("ImgIssYmd").disabled  = true;
                document.getElementById("ImgDueYmd").disabled  = true;
                document.getElementById("ImgTypeCd").disabled  = true;

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
    | 2. 이름 : dsT_CM_VISA                         |
    | 3. Table List : T_CM_VISA                     |
    +----------------------------------------------->
    <Object ID="dsT_CM_VISA" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CM_VISA                         |
    | 3. Table List : T_CM_VISA                     |
    +----------------------------------------------->
    <Object ID ="trT_CM_VISA" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_VISA)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_VISA Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_VISA.CountRow);

            document.getElementById("txtNAT_CD").disabled  = true;
            document.getElementById("txtISS_YMD").disabled = true;
            document.getElementById("ImgNatCd").disabled   = true;
            document.getElementById("ImgIssYmd").disabled  = true;

        }

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_VISA Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_VISA Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018 ) {
            alert("해당 필수입력항목[국가코드/발급일] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
            alert("국가코드/발급일에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CM_VISA event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CM_VISA event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_CM_VISA Event="OnRowPosChanged(row)">

        var SysStatus = dsT_CM_VISA.SysStatus(row);

        if (SysStatus == 1) {
            document.getElementById("txtNAT_CD").disabled  = false;
            document.getElementById("txtISS_YMD").disabled = false;
            document.getElementById("ImgNatCd").disabled   = false;
            document.getElementById("ImgIssYmd").disabled  = false;

        }
        else {
            document.getElementById("txtNAT_CD").disabled  = true;
            document.getElementById("txtISS_YMD").disabled = true;
            document.getElementById("ImgNatCd").disabled   = true;
            document.getElementById("ImgIssYmd").disabled  = true;

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
            <strong>VISA</strong>
        </td>
        <td align="right">
	        <input type="radio" id="rdoTMEN_TAG_SHR" name="rdoTMEN_TAG_SHR" style="border:none" value=""  onClick="fnc_SearchList()" checked>전체
	        <input type="radio" id="rdoTMEN_TAG_SHR" name="rdoTMEN_TAG_SHR" style="border:none" value="Y" onClick="fnc_SearchList()">경과
	        <input type="radio" id="rdoTMEN_TAG_SHR" name="rdoTMEN_TAG_SHR" style="border:none" value="N" onClick="fnc_SearchList()">미경과
        </td>
        <td width="340" height="25" align="right">
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
                    <col width="70 "></col>
                    <col width="140"></col>
                    <col width="70 "></col>
                    <col width="140"></col>
                    <col width="70 "></col>
                    <col width="120"></col>
                    <col width="70 "></col>
                    <col width="120"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">국가코드</td>
                    <td class="padding2423">
                        <input id="txtNAT_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('L2', 'txtNAT_CD','txtNAT_NM');"> <input id="txtNAT_NM" style="width:57%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgNatCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgNatCd" name="ImgNatCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtNAT_CD','txtNAT_NM','국가','L2')"></a>
                    </td>
                    <td align="center" class="creamBold">비자번호</td>
                    <td class="padding2423" >
                        <input id="txtVISA_NO" maxlength="15" style="width:100%">
                    </td>
                    <td align="center" class="creamBold">발 급 일</td>
                    <td class="padding2423" >
                        <input id="txtISS_YMD" style="width:73%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '발급일');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgIssYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgIssYmd" name="ImgIssYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtISS_YMD','','410','55');"></a>
                    </td>
                    <td align="center" class="creamBold">만 기 일</td>
                    <td class="padding2423" >
                        <input id="txtDUE_YMD" style="width:73%;ime-mode:disabled" maxlength="10" onChange="JavaScript : fnc_CheckDate(this, '만기일');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDueYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDueYmd" name="ImgDueYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtDUE_YMD','','610','55');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">비자종류</td>
                    <td class="padding2423">
                        <input id="txtTYPE_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('L5', 'txtTYPE_CD','txtTYPE_NM');"> <input id="txtTYPE_NM" style="width:57%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgTypeCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgTypeCd" name="ImgTypeCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtTYPE_CD','txtTYPE_NM','비자종류','L5')"></a>
                    </td>
                    <td align="center" class="creamBold">비&nbsp;&nbsp;&nbsp;&nbsp;고</td>
                    <td class="padding2423" colspan="5">
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
                        <object id="grdT_CM_VISA" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:794px;height:190px;">
                            <param name="DataID"                  value="dsT_CM_VISA">
                            <param name="Format"                  value="
                                <C> id={currow}        width=40   name='순번'         align=center </C>
                                <C> id=NAT_CD          width=75   name='국가코드'     align=center </C>
                                <C> id=NAT_NM          width=75   name='발급국가'                  </C>
                                <C> id=VISA_NO         width=75   name='비자번호'                  </C>
                                <C> id=ISS_YMD         width=75   name='발급일'       align=center </C>
                                <C> id=DUE_YMD         width=75   name='만기일'       align=center </C>
                                <C> id=TYPE_CD         width=80   name='비자종류코드' align=center </C>
                                <C> id=TYPE_NM         width=75   name='비자종류'                  </C>
                                <C> id=TMEN_TAG        width=60   name='기한경과'     align=center </C>
                                <C> id=REMARK          width=143  name='비고'                      </C>
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
<!-- VISA 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_VISA">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=NAT_CD        Ctrl=txtNAT_CD       Param=value </C>
        <C> Col=NAT_NM        Ctrl=txtNAT_NM       Param=value </C>
        <C> Col=VISA_NO       Ctrl=txtVISA_NO      Param=value </C>
        <C> Col=ISS_YMD       Ctrl=txtISS_YMD      Param=value </C>
        <C> Col=DUE_YMD       Ctrl=txtDUE_YMD      Param=value </C>
        <C> Col=TYPE_CD       Ctrl=txtTYPE_CD      Param=value </C>
        <C> Col=TYPE_NM       Ctrl=txtTYPE_NM      Param=value </C>
        <C> Col=REMARK        Ctrl=txtREMARK       Param=value </C>
    '>
</object>