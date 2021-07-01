<!--
    ************************************************************************************
    * @Source         : pira026.jsp                                                    		*
    * @Description    : 상벌사항 PAGE                                                  		*
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
<title>상벌사항</title>
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

            dsT_CM_REWARD.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira026.cmd.PIRA026CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_CM_REWARD.Reset();

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

                trT_CM_REWARD.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira026.cmd.PIRA026CMD&S_MODE=SAV";
                trT_CM_REWARD.post();

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
            if (dsT_CM_REWARD.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_CM_REWARD.RowStatus(dsT_CM_REWARD.RowPosition);

            //DataSet의 변경 여부 확인
            if (dsT_CM_REWARD.IsUpdated && status != 1) {
                alert("화면에 변경사항이 존재합니다.\n먼저 화면 내용을 저장하신 다음 작업하여 주십시오.");
                return false;
            }

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("상벌일자[" + dsT_CM_REWARD.NameValue(dsT_CM_REWARD.RowPosition,"REPU_YMD") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_CM_REWARD.DeleteRow(dsT_CM_REWARD.RowPosition);

            if (status != 1) {
                trT_CM_REWARD.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira026.cmd.PIRA026CMD&S_MODE=DEL";
                trT_CM_REWARD.post();
            }

            bnd.ActiveBind = false;

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_CM_REWARD.SetColumn(form1.grdT_CM_REWARD.GetColumnID(0));
            form1.grdT_CM_REWARD.Focus();

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
            if (dsT_CM_REWARD.CountColumn == 0) {
                dsT_CM_REWARD.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, REPU_YMD:STRING:KEYVALUETYPE, END_YMD:STRING, REPU_CD:STRING:KEYVALUETYPE, REPU_TAG:STRING:KEYVALUETYPE, SYC_NAM:STRING, REPU_RMK:STRING, REMARK1:STRING, REMARK2:STRING, REMARK3:STRING");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_CM_REWARD.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_CM_REWARD.setColumn(form1.grdT_CM_REWARD.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;
            document.getElementById("txtOCC_CD").value = parent.document.getElementById("txtOCC_CD").value;

            // KEY 필드는 신규시 입력 가능
            document.getElementById("txtREPU_YMD").disabled = false;
            document.getElementById("cmbREPU_CD").disabled  = false;
            document.getElementById("ImgRepuYmd").disabled  = false;
            document.getElementById("cmbREPU_CD").focus();
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

			dsT_CM_REWARD.ClearData();
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
            if (!dsT_CM_REWARD.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }

            for ( i = 1; i <= dsT_CM_REWARD.CountRow; i++ ) {
                if ( dsT_CM_REWARD.RowStatus(i) == 1 ||
                     dsT_CM_REWARD.RowStatus(i) == 3 ) {


                    // 상벌구분
                    if( dsT_CM_REWARD.NameValue(i, "REPU_CD") == '' ) {
                        alert("상벌구분은 필수 입력사항입니다.");
                        dsT_CM_REWARD.RowPosition = i;
                        document.getElementById("cmbREPU_CD").focus();
                        return false;
                    }

                    // 상벌종류
                    if( dsT_CM_REWARD.NameValue(i, "REPU_TAG") == '' ) {
                        alert("상벌종류는 필수 입력사항입니다.");
                        dsT_CM_REWARD.RowPosition = i;
                        document.getElementById("txtREPU_TAG").focus();
                        return false;
                    }

                    // 상벌종류
                    if (dsT_CM_REWARD.NameValue(i, "REPU_TAG") != "" &&
                        dsT_CM_REWARD.NameValue(i, "REPU_TNM") == "") {
                        alert("상벌종류코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_CM_REWARD.RowPosition = i;
                        document.getElementById("txtREPU_TAG").focus();
                        return;
                    }

                    // 상벌일자
                    if( dsT_CM_REWARD.NameValue(i, "REPU_YMD") == '' ) {
                        alert("상벌일자는 필수 입력사항입니다.");
                        dsT_CM_REWARD.RowPosition = i;
                        document.getElementById("txtREPU_YMD").focus();
                        return false;
                    }

                    // 상벌일자 CHECK
                    if (!fnc_CheckDate2(dsT_CM_REWARD.NameValue(i, "REPU_YMD"), "상벌일자") && dsT_CM_REWARD.NameValue(i, "REPU_YMD") != "") {
                        dsT_CM_REWARD.RowPosition = i;
                        document.getElementById("txtREPU_YMD").focus();
                        return false;
                    }

                    // 대물
                    if( dsT_CM_REWARD.NameValue(i, "REMARK1") == '' ) {
                        dsT_CM_REWARD.NameValue(i, "REMARK1") = "N";
                    }

                    // 대인
                    if( dsT_CM_REWARD.NameValue(i, "REMARK2") == '' ) {
                        dsT_CM_REWARD.NameValue(i, "REMARK2") = "N";
                    }

                    // 종료일자 CHECK
                    if (!fnc_CheckDate2(dsT_CM_REWARD.NameValue(i, "END_YMD"), "종료일") && dsT_CM_REWARD.NameValue(i, "END_YMD") != "") {
                        dsT_CM_REWARD.RowPosition = i;
                        document.getElementById("txtEND_YMD").focus();
                        return false;
                    }

                    // 상벌일자와 종료일자 비교
                    if( dsT_CM_REWARD.NameValue(i, "REPU_YMD") != '' && dsT_CM_REWARD.NameValue(i, "END_YMD") != '' ) {
                        if( cfDateDiff(dsT_CM_REWARD.NameValue(i, "REPU_YMD").replace(/\-/g,''),dsT_CM_REWARD.NameValue(i, "END_YMD").replace(/\-/g,'')) < 0 ) {
                            alert("시작일자가 종료일자보다 큽니다.");
                            dsT_CM_REWARD.RowPosition = i;
                            document.getElementById("txtREPU_YMD").focus();
                            return false;
                        }
                    }


                    if ( dsT_CM_REWARD.RowStatus(i) == 1) {
                        document.getElementById("txtREPU_YMD").disabled = true;
                        document.getElementById("cmbREPU_CD").disabled  = true;
                        document.getElementById("ImgRepuYmd").disabled  = true;
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
            cfStyleGrid_New(form1.grdT_CM_REWARD, 0,"false","false");

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

                document.getElementById("txtREPU_YMD").disabled = false;
                document.getElementById("cmbREPU_CD").disabled  = false;
                document.getElementById("txtREPU_TAG").disabled = false;
                document.getElementById("txtSYC_NAM").disabled  = false;
                document.getElementById("txtREPU_RMK").disabled = false;
                document.getElementById("txtEND_YMD").disabled  = false;
                document.getElementById("txtREMARK3").disabled  = false;
                document.getElementById("ImgRepuYmd").disabled  = false;
                document.getElementById("ImgRepuTag").disabled  = false;
                document.getElementById("ImgEndYmd").disabled   = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtREPU_YMD").disabled = true;
                document.getElementById("cmbREPU_CD").disabled  = true;
                document.getElementById("txtREPU_TAG").disabled = true;
                document.getElementById("txtSYC_NAM").disabled  = true;
                document.getElementById("txtREPU_RMK").disabled = true;
                document.getElementById("txtEND_YMD").disabled  = true;
                document.getElementById("txtREMARK3").disabled  = true;
                document.getElementById("ImgRepuYmd").disabled  = true;
                document.getElementById("ImgRepuTag").disabled  = true;
                document.getElementById("ImgEndYmd").disabled   = true;

            }
        }

        function fnc_ChkBox(obj) {
        	
            if (document.getElementById(obj).checked == true) {
            	
                if (obj == "chkREMARK1") {
                    document.getElementById("txtREMARK1").value = "Y";
                }
                else {
                    document.getElementById("txtREMARK2").value = "Y";
                }
            }
            else {
            	
                if (obj == "chkREMARK1") {
                    document.getElementById("txtREMARK1").value = "N";
                }
                else {
                    document.getElementById("txtREMARK2").value = "N";
                }
            }
        }

        function fnc_GetRepuTag() {

                fnc_GetCommNm('K1', 'txtREPU_TAG','txtREPU_TNM');

        }

        function fnc_RepuTagPopup() {

                fnc_commonCodePopup('txtREPU_TAG','txtREPU_TNM','상벌종류','K1');

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
    | 2. 이름 : dsT_CM_REWARD                       |
    | 3. Table List : T_CM_REWARD                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_REWARD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CM_REWARD                       |
    | 3. Table List : T_CM_REWARD                   |
    +----------------------------------------------->
    <Object ID ="trT_CM_REWARD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_REWARD)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_REWARD Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_REWARD.CountRow);

            document.getElementById("txtREPU_YMD").disabled = true;
            document.getElementById("cmbREPU_CD").disabled  = true;
            document.getElementById("ImgRepuYmd").disabled  = true;

        }

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_REWARD Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_REWARD Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018 ) {
            alert("해당 필수입력항목[상벌구분/상벌일자/상벌종류] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019 || this.ErrorCode == 50020) {
            alert("상벌구분/상벌일자/상벌종류에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CM_REWARD event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CM_REWARD event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_CM_REWARD Event="OnRowPosChanged(row)">

        var SysStatus = dsT_CM_REWARD.SysStatus(row);

        if (SysStatus == 1) {
            document.getElementById("txtREPU_YMD").disabled = false;
            document.getElementById("cmbREPU_CD").disabled  = false;
            document.getElementById("ImgRepuYmd").disabled  = false;

        }else {
            document.getElementById("txtREPU_YMD").disabled = true;
            document.getElementById("cmbREPU_CD").disabled  = true;
            document.getElementById("ImgRepuYmd").disabled  = true;

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
            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>상벌사항</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAdd','','../../images/button/btn_AddnewOver.gif',1)">   <img src="../../images/button/btn_AddnewOn.gif" name="imgAdd"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','../../images/button/btn_CancelOver.gif',1)"> <img src="../../images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
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
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">상벌구분</td>
                    <td class="padding2423">
                        <select id="cmbREPU_CD" style="width:100%" >
                            <option value="" >선택</option>
                            <option value="1" >포상(사내)</option>
                            <option value="2" >포상(사외)</option>
                            <option value="4" >포상(그룹)</option>                            
                            <option value="3" >징계(사내)</option>
                        </select>
                    </td>
                    <td align="center" class="blueBold">상벌일자</td>
                    <td class="padding2423" >
                        <input id="txtREPU_YMD" style="width:77%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '상벌일자');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRepuYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgRepuYmd" name="ImgRepuYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtREPU_YMD','','210','53');"></a>
                    </td>
                    <td align="center" class="blueBold">상벌종류</td>
                    <td class="padding2423">
                        <input id="txtREPU_TAG" style="width:15%" maxlength="2" onChange="fnc_GetRepuTag();"> <input id="txtREPU_TNM" style="width:57%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRepuTag','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgRepuTag" name="ImgRepuTag" width="21" height="20" border="0" align="absmiddle" onClick="fnc_RepuTagPopup();"></a>
                    </td>
                    <td align="center" class="blueBold">수 여 처</td>
                    <td class="padding2423"  colspan="3">
                        <input id="txtSYC_NAM" style="width:100%" maxlength="22">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">상벌내역</td>
                    <td class="padding2423"  colspan="3">
                        <input id="txtREPU_RMK" style="width:100%" maxlength="60">
                    </td>

                    <td align="center" class="blueBold">종 료 일</td>
                    <td class="padding2423" >
                        <input id="txtEND_YMD" style="width:77%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '종료일');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEndYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEndYmd" name="ImgEndYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','610','78');"></a>
                    </td>

                    <td align="center" class="blueBold">비&nbsp;&nbsp;&nbsp;&nbsp;고</td>
                    <td class="padding2423"  colspan="7">
                        <input id="txtREMARK3" style="width:100%" maxlength="120">
                    </td>
                    <input type=hidden   id="txtENO_NO" size="10">
                    <input type=hidden   id="txtOCC_CD" size="1">
                </tr>
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
                        <object id="grdT_CM_REWARD" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:994px;height:300px;">
                            <param name="DataID"                    value="dsT_CM_REWARD">
                            <param name="Format"                    value="
                                <C> id={currow}         width=40     name='순번'           align=center </C>
                                <C> id=REPU_YMD       width=100     name='상벌일자'       align=center </C>
                                <C> id=REPU_CD1        width=120     name='상벌구분'       align=center value={Decode(REPU_CD,'1','포상(사내)','2','포상(사외)','3','징계(사내)','4','포상(그룹)','')} </C>
                                <C> id=REPU_TNM        width=150     name='상벌종류'                    </C>
                                <C> id=SYC_NAM         width=120     name='수여처'                      </C>
                                <C> id=REPU_RMK        width=250    name='상벌내역'                    </C>
                                <C> id=END_YMD         width=75     name='종료일'        align=center </C>
                                <C> id=REMARK3         width=100    name='비고'                        </C>
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
<!-- 상벌사항 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_REWARD">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=REPU_YMD      Ctrl=txtREPU_YMD     Param=value </C>
        <C> Col=OCC_CD        Ctrl=txtOCC_CD       Param=value </C>
        <C> Col=REPU_CD       Ctrl=cmbREPU_CD      Param=value </C>
        <C> Col=REPU_TAG      Ctrl=txtREPU_TAG     Param=value </C>
        <C> Col=REPU_TNM      Ctrl=txtREPU_TNM     Param=value </C>
        <C> Col=SYC_NAM       Ctrl=txtSYC_NAM      Param=value </C>
        <C> Col=REPU_RMK      Ctrl=txtREPU_RMK     Param=value </C>
        <C> Col=REMARK1       Ctrl=txtREMARK1      Param=value </C>
        <C> Col=REMARK2       Ctrl=txtREMARK2      Param=value </C>
        <C> Col=END_YMD       Ctrl=txtEND_YMD      Param=value </C>
        <C> Col=REMARK3       Ctrl=txtREMARK3      Param=value </C>
    '>
</object>