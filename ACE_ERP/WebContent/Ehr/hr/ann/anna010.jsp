<!--
*****************************************************
* @source      : anna010.jsp
* @description : 복리후생/개인연금/개인연금관리
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/03/06      조정호                   최초작성
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>개인연금관리</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >
        //단축키 순서
        var btnList = "T"   //조회
                    + "F"   //신규
                    + "F"   //저장
                    + "T"   //취소
                    + "T"   //엑셀
                    + "T"   //인쇄
                    + "F"   //삭제
                    + "T";  //닫기

        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ann.a.anna010.cmd.ANNA010CMD";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/

        /**
         * 사원정보를 조회 한다.
         */
        function fnc_SearchEmp() {
        	//검색조건
			var oENO_NO = document.getElementById("txtENO_NO_SHR").value;

			dsT_CM_PERSON.dataid = dataClassName+"&S_MODE=SHR_EMP&ENO_NO="+oENO_NO;
			dsT_CM_PERSON.reset();

        }

        /**
         * 검색한 사원을 가지고 개인 연금 관리 리스트를 가져온다.
         */
        function fnc_SearchList() {
            //검색조건
            var oENO_NO = document.getElementById("txtENO_NO_SHR").value;
            fncClearInputField();
            changeMode();

            if(oENO_NO != "") {
                dsT_SV_SAVELIST.dataid = dataClassName+"&S_MODE=SHR&ENO_NO="+oENO_NO;
                dsT_SV_SAVELIST.reset();
            } else {
                alert("사번을 선택해 주세요");
            }
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

			if(!fnc_SaveItemCheck()) return;

			var oENO_NO = document.getElementById("txtENO_NO_SHR").value;

			trT_SV_SAVELIST.KeyValue = "tr01(I:dsT_SV_SAVELIST=dsT_SV_SAVELIST)";
			trT_SV_SAVELIST.action = dataClassName+"&S_MODE=SAV&ENO_NO="+oENO_NO;
			trT_SV_SAVELIST.post();
        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {
            // 삭제 할 자료가 있는지 체크하고
            if (dsT_SV_SAVELIST.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            var oENO_NO = document.getElementById("txtENO_NO_SHR").value;

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("구좌번호 [" + dsT_SV_SAVELIST.ColumnString(dsT_SV_SAVELIST.RowPosition,19) + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_SV_SAVELIST.DeleteRow(dsT_SV_SAVELIST.RowPosition);

			trT_SV_SAVELIST.KeyValue = "SVL(I:dsT_SV_SAVELIST=dsT_SV_SAVELIST)";
			trT_SV_SAVELIST.Action = dataClassName+"&S_MODE=DEL&ENO_NO="+oENO_NO;
			trT_SV_SAVELIST.post();
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

            if (dsT_SV_SAVELIST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_SV_SAVELIST.GridToExcel("개인연금관리", '', 225);

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {
            // 해당 Dataset의 Header가 없으면 검색이 되지 않았다는 것으로 간주하고 종료
            if (dsT_SV_SAVELIST.CountColumn == 0) {
                alert("개인연금리스트를 조회하지 않았습니다.");
                return;
            }

            dsT_SV_SAVELIST.AddRow();
            fncClearInputField();
            changeMode("insert");
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
            fncClearInputField();
            changeMode();
			dsT_SV_SAVELIST.ClearData();
			dsT_CM_PERSON.ClearData();
	        fnc_OnLoadProcess();
			document.getElementById("resultMessage").innerText = ' ';
        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_SV_SAVELIST.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck(year) {

			//이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

			if (!dsT_SV_SAVELIST.IsUpdated) {
                alert("저장할 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
			}

			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
            var oSelect = document.getElementById("cmbSAV_CD2");
            var oOption = null;

            //첫번째 라인을 제외한 모든 option 삭제
            for(i=oSelect.options.length-1; i>0; i--) {
                oSelect.remove(i);
            }

            // 근로구분 구분 검색 콤보박스 생성
            for(i = 1; i <= dsT_CM_COMMON_V2.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_V2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_V2.NameValue(i,"CODE_NAME");
                oSelect.add(oOption);
            }

            var elementList = new Array( "txtTOTAL_SAV_SHR"
                                        ,"txtDSC_AMT"
                                        ,"txtWOL_AMT"
                                        ,"txtOTHP_AMT"
                                        ,"txtOTH_AMT"
                                        ,"txtSUM_SAV");

            fnc_DisableElementAll(elementList);

            changeMode("onload");

			cfStyleGrid(form1.grdT_SV_SAVELIST,15,"false","false")      // Grid Style 적용
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}


        /**
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         */
        function fnc_ClickEmpPopup() {

            fnc_emplPopup('txtENO_NO_SHR');

            if (document.getElementById("txtENO_NO_SHR").value  != "") {
                fnc_SearchEmp();
            }
        }

        /**
         * 사원 정보를 조회 한다.
         * 사원명으로 검색
         */
        function fnc_SearchEmpNm() {
            //사번을 찾아오고 상세 내역 가져오기
            fnc_GetEnoNo('txtENO_NM_SHR', 'txtENO_NO_SHR');
            fnc_SearchEmp();
        }

        /**
         * 날짜 형식 유효성 체크
         */
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('유효한 날짜가 아닙니다.');
                obj.focus();
            }
        }

        /**
         * 기존의 입력 필드의 초기화
         */
        function fncClearInputField() {
            //초기화 시킬 입력창
            var inputFields = new Array( "cmbSAV_CD2"
                                        ,"txtCON_YMD"
                                        ,"txtDUE_YMD"
                                        ,"txtSUM_SAV"
                                        ,"txtSUMP_CNT"
                                        ,"txtFAPP_YMD"
                                        ,"cmbCAN_TAG"
                                        ,"txtCAN_YMD");
            //초기화 시킬 입력창 중 숫자 형식 초기화를 "0" 으로
            var inputAmtFields = new Array("txtCONM_AMT"
                                        ,"txtDSC_PCT"
                                        ,"txtDSC_AMT"
                                        ,"txtWOL_AMT"
                                        ,"txtOTHP_AMT"
                                        ,"txtOTH_AMT"
                                        ,"txtSUM_SAV");

            fnc_ClearInputElement(inputFields);
            fnc_ClearInputElement(inputAmtFields, new Array(), "0");
        }

        /**
         * 입력 모드일때
         */
        function changeMode(mode) {
            var inputFields = new Array( "cmbSAV_CD2"
                                        ,"txtCON_YMD"
                               //         ,"txtDUE_YMD"
                                        ,"txtCONM_AMT"
                                        ,"txtDSC_PCT"
                                        ,"cmbCAN_TAG"
                                        ,"txtCAN_YMD"
                                        ,"imgCON_YMD"
                                //        ,"imgDUE_YMD"
                                        ,"imgCAN_YMD");

            fnc_EnableElementAll(inputFields);
            if(mode == "insert") {

            } else if(mode == "onload") {
                fnc_DisableElementAll(inputFields);
            } else {
                fnc_DisableElementAll(inputFields, new Array("cmbCAN_TAG" ,"txtCAN_YMD", "imgCAN_YMD"));
            }
            //2010.1.17 월불입액/실월불입액은 수정가능토록 변경
            //권차장님.
            changeCustomMode("use");
        }

        /**
         * 월불입액,실월불입액,기타불입액,기타공제액 풀기
         */
        function changeCustomMode(mode) {
            var inputFields = new Array( "txtWOL_AMT"
                                        ,"txtCONM_AMT"
                                        ,"txtDSC_PCT"
                                        ,"txtOTHP_AMT"
                                        ,"txtOTH_AMT" );

            if(mode == "use") {
            	fnc_EnableElementAll(inputFields);
            } else if(mode == "notuse") {
                fnc_DisableElementAll(inputFields);
            }
        }

        /**
         * 할인율을 계산
         */
        function calcDscAmt(conmAmtName, dscAmtName, dscPctName, wolAmtName) {
            var conmAmt = document.getElementById(conmAmtName);
            var dscAmt = document.getElementById(dscAmtName);
            var dscPct = document.getElementById(dscPctName);
            var wolAmt = document.getElementById(wolAmtName);

            var amt = (parseFloat(conmAmt.text)*parseFloat(dscPct.value)/100);

            if(isNaN(amt)) {
                dscAmt.text = 0;
                wolAmt.text = 0;
            } else {
                dscAmt.text = amt;
                wolAmt.text = conmAmt.text - dscAmt.text;
            }

            document.getElementById("txtOTHP_AMT").text = conmAmt.text/2;
        	document.getElementById("txtOTH_AMT").text = document.getElementById("txtWOL_AMT").text;
        }

        function calcDscAmt2(conmAmtName, dscAmtName, dscPctName, wolAmtName) {
            var conmAmt = document.getElementById(conmAmtName);
            var dscAmt = document.getElementById(dscAmtName);
            var dscPct = document.getElementById(dscPctName);
            var wolAmt = document.getElementById(wolAmtName);

            var rate = Math.round(((parseFloat(conmAmt.text)-parseFloat(wolAmt.text))/parseFloat(conmAmt.text))*100 * Math.pow(10,1)) / Math.pow(10,1);
            if(isNaN(rate)) {
                dscAmt.text = 0;
                dscPct.value = 0;
            } else {
                dscAmt.text = conmAmt.text -wolAmt.text;
                dscPct.value = rate;
            }

            document.getElementById("txtOTHP_AMT").text = conmAmt.text/2;
        	document.getElementById("txtOTH_AMT").text = document.getElementById("txtWOL_AMT").text;

        }
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                         |
    | 2. 이름 : dsT_SV_SAVELIST                       |
    | 3. Table List : T_SV_SAVELIST                 |
    +----------------------------------------------->
    <Object ID="dsT_SV_SAVELIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. 조회용 DataSet                                       |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_PERSON)                |
    | 3. 사용되는 Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			                  |
    | 2. 이름은 tr_ + 주요 테이블명(dsT_SV_SAVELIST)		  |
    | 3. 사용되는 Table List(T_SV_SAVELIST)	                  |
    +--------------------------------------------------->
    <Object ID ="trT_SV_SAVELIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!-----------------------------------------------------+
    | 1. 공통 콤보를 위한 DataSet                               |
    +------------------------------------------------------>
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_V2"/>
       <jsp:param name="CODE_GUBUN"    value="V2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_SV_SAVELIST Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
            alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_SV_SAVELIST Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_SV_SAVELIST Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_SV_SAVELIST event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');

        fnc_SearchList();
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_SV_SAVELIST event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!-- 데이타 그리드를 더블 클릭할때 -->
    <script for=grdT_SV_SAVELIST event=OnDblClick(Row,Colid)>
		if(Row < 1) {
			return;
		} else {
            var oENO_NO = document.getElementById("txtENO_NO_SHR").value;
            var oACC_NO = dsT_SV_SAVELIST.NameValue(Row, "ACC_NO");
            var oSAV_CD = dsT_SV_SAVELIST.NameValue(Row, "SAV_CD2");
            var oBNK_CD = dsT_SV_SAVELIST.NameValue(Row, "BNK_CD");

			window.showModalDialog("/hr/ann/anna011.jsp?ENO_NO="+oENO_NO+"&ACC_NO="+oACC_NO+"&SAV_CD="+oSAV_CD+"&BNK_CD="+oBNK_CD, "", "dialogWidth:670px; dialogHeight:530px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
		}
    </script>

    <!-- 데이타 그리드를 한번 선택할때 -->


    <!-- 월불입액에서 커서가 날아갈 때 계산 수 -->
    <script language=JavaScript for=txtCONM_AMT event=onKillFocus()>
        calcDscAmt('txtCONM_AMT', 'txtDSC_AMT', 'txtDSC_PCT', 'txtWOL_AMT');
    </script>

    <!-- 실월불입액에서 커서가 날아갈 때 계산 수 -->
    <script language=JavaScript for=txtWOL_AMT event=onKillFocus()>
        calcDscAmt2('txtCONM_AMT', 'txtDSC_AMT', 'txtDSC_PCT', 'txtWOL_AMT');
    </script>


    <!-- 값들이 들어있는지 여부를 검증함 -->
    <script for=dsT_SV_SAVELIST event=CanRowPosChange(row)>
        var element;

        element = dsT_SV_SAVELIST.NameString(dsT_SV_SAVELIST.RowPosition, "SAV_CD2");
        if(element.trim().length == 0 || element == "0"){
            alert("저축종류를 입력하세요.");
            document.getElementById("cmbSAV_CD2").focus();
            return false;
        }

        element = dsT_SV_SAVELIST.NameString(dsT_SV_SAVELIST.RowPosition, "CON_YMD");
        if(element.trim().length == 0){
            alert("계약일자를 입력하세요.");
            document.getElementById("txtCON_YMD").focus();
            return false;
        }
        if(element.trim().length != 10){
            alert("계약일자가 잘못되었습니다.");
            document.getElementById("txtCON_YMD").focus();
            return false;
        }

        element = dsT_SV_SAVELIST.NameString(dsT_SV_SAVELIST.RowPosition, "DUE_YMD");
        if(element.trim().length == 0){
            alert("만기일자를 입력하세요.");
            document.getElementById("txtDUE_YMD").focus();
            return false;
        }
        if(element.trim().length != 10){
            alert("만기일자가 잘못되었습니다.");
            document.getElementById("txtDUE_YMD").focus();
            return false;
        }

        element = dsT_SV_SAVELIST.NameString(dsT_SV_SAVELIST.RowPosition, "CONM_AMT");
        if(element.trim().length == 0 || element == "0"){
            alert("월불입액을 선택하세요.");
            document.getElementById("txtCONM_AMT").Focus();
            return false;
        }

    </script>

    <!-- disable 시킬것인지 여부 검증 -->
    <script language=JavaScript for=dsT_SV_SAVELIST event=OnRowPosChanged(row)>
        if(row > 0) {
            //입력모드면 입력상태로
            if(dsT_SV_SAVELIST.RowStatus(row) == "1") {
                changeMode("insert");
            } else {
                changeMode();
            }
        }
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">개인연금관리</td>
					<td align="right" class="navigator">HOME/복리후생/개인연금/<font color="#000000">개인연금관리</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="100"></col>
                                <col width="140"></col>
                                <col width="100"></col>
                                <col width="140"></col>
                                <col width="100"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">사원번호</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" maxlength="12" style="width:70%" onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmp()" onfocusout="fnc_SearchEmp()">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()"></a>
                                </td>
                                <td align="right" class="searchState">성&nbsp;&nbsp;&nbsp;명</td>
                                <td class="padding2423">
                                    <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="14" onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                                </td>
                                <td align="right" class="searchState">소&nbsp;&nbsp;&nbsp;속</td>
                                <td class="padding2423">
                                    <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="searchState">직&nbsp;&nbsp;&nbsp;위</td>
                                <td class="padding2423">
                                    <input id="txtJOB_NM_SHR" name="txtJOB_NM_SHR" size="14" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">주민등록번호</td>
                                <td class="padding2423">
                                    <input id="txtCET_NO_SHR" name="txtCET_NO_SHR" size="14" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">입사일</td>
                                <td class="padding2423">
                                    <input id="txtHIRG_YMD_SHR" name="txtHIRG_YMD_SHR" size="14" class="input_ReadOnly" readonly>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="searchState">직&nbsp;&nbsp;&nbsp;종</td>
                                <td class="padding2423" colspan="3">
                                    <input id="txtOCC_NM_SHR" name="txtOCC_NM_SHR" size="14" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">총불입누계</td>
                                <td class="padding2423">
                                    <comment id="__NSID__"><object id="txtTOTAL_SAV_SHR" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                                        <param name=Alignment               value=2>
                                        <param name=Border                  value=true>
                                        <param name=ClipMode                value=true>
                                        <param name=DisabledBackColor       value="#EEEEEE">
                                        <param name=Enable                  value=true>
                                        <param name=IsComma                 value=true>
                                        <param name=Language                value=0>
                                        <param name=MaxLength               value=8>
                                        <param name=Numeric                 value=true>
                                        <param name=NumericRange            value=0~+:0>
                                        <param name=ShowLiteral             value=false>
                                        <param name=Visible                 value=true>
                                    </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
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

<!-- 계약사항 -->
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="60"></col>
                    <col width="90"></col>
                    <col width="140"></col>
                    <col width="90"></col>
                    <col width="140"></col>
                    <col width="90"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td class="creamBold" align="center" rowspan="3">계약사항</td>
                    <td class="creamBold" align="center">계약 종류</td>
                    <td class="padding2423">
                        <select id="cmbSAV_CD2" name="cmbSAV_CD2" style="width:130;">
                            <option value="0">모두</option>
                        </select>
                    </td>
                    <td class="creamBold" align="center">계 약 일</td>
                    <td class="padding2423">
                        <input type="text" id="txtCON_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <img src="/images/button/btn_HelpOn.gif" name="imgCON_YMD" width="21" height="20" border="0" align="absmiddle" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCON_YMD','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtCON_YMD','','360','200');" style="cursor:hand;">
                    </td>
                    <td class="creamBold" align="center">만 기 일</td>
                    <td class="padding2423">
                        <input type="text" id="txtDUE_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <img src="/images/button/btn_HelpOn.gif" name="imgDUE_YMD" width="21" height="20" border="0" align="absmiddle"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDUE_YMD','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtDUE_YMD','','610','200');" style="cursor:hand;">
                    </td>
                </tr>

                <tr>
                    <td class="creamBold" align="center">월불입액</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="txtCONM_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="creamBold" align="center">할 인 율</td>
                    <td class="padding2423">
                        <input id="txtDSC_PCT" name="txtDSC_PCT" size="8" style="text-align:right" value="0" maxlength="4" style="ime-mode:disabled"  onkeypress="cfCheckNumber3();">
                        %
                        <a href="#" onclick="javascript:calcDscAmt('txtCONM_AMT', 'txtDSC_AMT', 'txtDSC_PCT', 'txtWOL_AMT');">계산</a>
                    </td>
                    <td class="creamBold" align="center">할 인 액</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="txtDSC_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>

                <tr>
                    <td class="creamBold" align="center">실월불입액</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="txtWOL_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="creamBold" align="center">기타불입액</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="txtOTHP_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="creamBold" align="center">기타공제액</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="txtOTH_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
<!-- 계약사항 -->

<!-- 누적사항 -->
                <tr>
                    <td class="creamBold" align="center">누적사항</td>
                    <td class="creamBold" align="center">누적불입액</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="txtSUM_SAV" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                            <param name=Alignment               value=2>
                            <param name=Border                  value=true>
                            <param name=ClipMode                value=true>
                            <param name=DisabledBackColor       value="#EEEEEE">
                            <param name=Enable                  value=true>
                            <param name=IsComma                 value=true>
                            <param name=Language                value=0>
                            <param name=MaxLength               value=8>
                            <param name=Numeric                 value=true>
                            <param name=NumericRange            value=0~+:0>
                            <param name=ShowLiteral             value=false>
                            <param name=Visible                 value=true>
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td class="creamBold" align="center">불입횟수</td>
                    <td class="padding2423">
                        <input id="txtSUMP_CNT" name="txtSUMP_CNT" size="14" style="text-align:right" value="0" class="input_ReadOnly" readonly>
                    </td>
                    <td class="creamBold" align="center">최종불입일</td>
                    <td class="padding2423">
                        <input id="txtFAPP_YMD" name="txtFAPP_YMD" size="10" class="input_ReadOnly" readonly>
                    </td>
                </tr>
<!-- 누적사항 -->

<!-- 해약사항 -->
                <tr>
                    <td class="creamBold" align="center">해약사항</td>
                    <td class="creamBold" align="center">해약여부</td>
                    <td class="padding2423">
                        <select id="cmbCAN_TAG" name="cmbCAN_TAG" style="width:50">
                            <option></option>
                            <option value="Y">만기</option>
                            <option value="C">중도</option>
                        </select>
                    </td>
                    <td class="creamBold" align="center">해 약 일</td>
                    <td class="padding2423" colspan="3">
                        <input type="text" id="txtCAN_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <img src="/images/button/btn_HelpOn.gif" name="imgCAN_YMD" width="21" height="20" border="0" align="absmiddle"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCAN_YMD','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtCAN_YMD','','360','300');" style="cursor:hand;">
                    </td>
                </tr>
            </table>
<!-- 해약사항 -->

        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="520" border="0" cellspacing="0" cellpadding="0">
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
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_SV_SAVELIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:260px;">
							<param name="DataID"				value="dsT_SV_SAVELIST">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
                                <C> id='{currow}'       width=39    name='NO'           align=center    Edit=none   SubBgColor='#99FFCC'</C>
                                <C> id=SAV_NM2      width=130       align=center        name=저축종류       </C>
                                <C> id=PYM_AMT      width=80        align=center        name=누적저축액       </C>
                                <C> id=CON_YMD      width=80        align=center        name=계약일            </C>
                                <C> id=DUE_YMD      width=80        align=center        name=만기일            </C>
                                <C> id=CONM_AMT     width=80        align=center        name=계약월불입액   </C>
                                <C> id=DSC_PCT      width=80        align=center        name=할인율            </C>
                                <C> id=DSC_AMT      width=80        align=center        name=할인액            </C>
                                <C> id=WOL_AMT      width=80        align=center        name=실질월불입액   </C>
                                <C> id=OTHP_AMT     width=80        align=center        name=기타지불금액   </C>
                                <C> id=OTH_AMT      width=80        align=center        name=기타공제금액   </C>
                                <C> id=SUM_SAV      width=80        align=center        name=누적저축액      </C>
                                <C> id=SUMP_CNT     width=80        align=center        name=누적불입횟수   </C>
                                <C> id=FAPP_YMD     width=80        align=center        name=최종불입일     </C>
                                <C> id=CAN_TAG      width=80        align=center        name=해약구분        value={Decode(CAN_TAG,'Y','만기','C','중도')}</C>
                                <C> id=CAN_YMD      width=80        align=center        name=해약일            </C>
                                <C> id=ACC_NO       width=100       align=center        name=구좌번호     Show=false      </C>
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
<!-- T_CM_PERSON 조회해온 사원 정보를 창에 뿌려줌 -->
<object id="bndT_CM_PERSON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CM_PERSON">
	<Param Name="BindInfo", Value='
        <C>Col=ENO_NO               Ctrl=txtENO_NO_SHR              Param=value     </C>
        <C>Col=ENO_NM               Ctrl=txtENO_NM_SHR              Param=value     </C>
		<C>Col=DPT_NM      			Ctrl=txtDPT_NM_SHR 		     	Param=value     </C>
		<C>Col=JOB_NM				Ctrl=txtJOB_NM_SHR	   		   	Param=value		</C>
		<C>Col=CET_NO				Ctrl=txtCET_NO_SHR				Param=value		</C>
		<C>Col=HIRG_YMD			    Ctrl=txtHIRG_YMD_SHR			Param=value		</C>
		<C>Col=OCC_NM				Ctrl=txtOCC_NM_SHR			    Param=value	    </C>
		<C>Col=TOTAL_SAV			Ctrl=txtTOTAL_SAV_SHR			Param=Text 		</C>
    '>
</object>


<!-- T_SV_SAVELIST 개인연금관리의 바인딩을 위해 -->
<object id="bndT_SV_SAVELIST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_SV_SAVELIST">
    <Param Name="BindInfo", Value='
        <C>Col=SAV_CD2              Ctrl=cmbSAV_CD2               Param=value   </C>
        <C>Col=CON_YMD              Ctrl=txtCON_YMD               Param=value   </C>
        <C>Col=DUE_YMD              Ctrl=txtDUE_YMD               Param=value   </C>
        <C>Col=CONM_AMT             Ctrl=txtCONM_AMT              Param=text     </C>
        <C>Col=DSC_PCT              Ctrl=txtDSC_PCT               Param=value   DEC=1</C>
        <C>Col=DSC_AMT              Ctrl=txtDSC_AMT               Param=text    </C>
        <C>Col=WOL_AMT              Ctrl=txtWOL_AMT               Param=text    </C>
        <C>Col=OTHP_AMT             Ctrl=txtOTHP_AMT              Param=text    </C>
        <C>Col=OTH_AMT              Ctrl=txtOTH_AMT               Param=text    </C>
        <C>Col=SUM_SAV              Ctrl=txtSUM_SAV               Param=text    </C>
        <C>Col=SUMP_CNT             Ctrl=txtSUMP_CNT              Param=value   </C>
        <C>Col=FAPP_YMD             Ctrl=txtFAPP_YMD              Param=value   </C>
        <C>Col=CAN_TAG              Ctrl=cmbCAN_TAG               Param=value   </C>
        <C>Col=CAN_YMD              Ctrl=txtCAN_YMD               Param=value   </C>
    '>
</object>
