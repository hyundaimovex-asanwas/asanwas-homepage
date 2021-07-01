<!--
    ************************************************************************************
    * @Source         : pira021.jsp                                                    *
    * @Description    : 보증인 PAGE                                                  *
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
    <title>보증인</title>
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

            dsT_CM_QUARANTOR.DataId = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira021.cmd.PIRA021CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_CM_QUARANTOR.Reset();

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

                trT_CM_QUARANTOR.action = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira021.cmd.PIRA021CMD&S_MODE=SAV";
                trT_CM_QUARANTOR.post();

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
            if (dsT_CM_QUARANTOR.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_CM_QUARANTOR.RowStatus(dsT_CM_QUARANTOR.RowPosition);

            //DataSet의 변경 여부 확인
            if (dsT_CM_QUARANTOR.IsUpdated && status != 1) {
                alert("화면에 변경사항이 존재합니다.\n먼저 화면 내용을 저장하신 다음 작업하여 주십시오.");
                return false;
            }

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("시작일자[" + dsT_CM_QUARANTOR.NameValue(dsT_CM_QUARANTOR.RowPosition,"GURS_YMD") + "] 보증인[" + dsT_CM_QUARANTOR.NameValue(dsT_CM_QUARANTOR.RowPosition,"GUR_NAM") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_CM_QUARANTOR.DeleteRow(dsT_CM_QUARANTOR.RowPosition);

            if (status != 1) {
                trT_CM_QUARANTOR.action = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira021.cmd.PIRA021CMD&S_MODE=DEL";
                trT_CM_QUARANTOR.post();
            }

            bnd.ActiveBind = false;

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_CM_QUARANTOR.SetColumn(form1.grdT_CM_QUARANTOR.GetColumnID(0));
            form1.grdT_CM_QUARANTOR.Focus();

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
            if (dsT_CM_QUARANTOR.CountColumn == 0) {
                dsT_CM_QUARANTOR.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, GUR_TAG:STRING, GURS_YMD:STRING:KEYVALUETYPE, GUR_NAM:STRING:KEYVALUETYPE, GURD_YMD:STRING, GUR_COM:STRING, GUR_CNM:STRING, GUR_NO:STRING, END_TAG:STRING, GURR_CD:STRING, GURR_NM:STRING, GUR_CMP:STRING, GURO:STRING, CET_NO:STRING, GUR_ADR:STRING");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_CM_QUARANTOR.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_CM_QUARANTOR.setColumn(form1.grdT_CM_QUARANTOR.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;
            document.getElementById("txtOCC_CD").value = parent.document.getElementById("txtOCC_CD").value;

            // KEY 필드는 신규시 입력 가능
            document.getElementById("cmbGUR_TAG").disabled  = false;
            document.getElementById("txtGURS_YMD").disabled = false;
            document.getElementById("txtGUR_NAM").disabled  = false;
            document.getElementById("ImgGursYmd").disabled  = false;

            document.getElementById("cmbGUR_TAG").focus();
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

			dsT_CM_QUARANTOR.ClearData();
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
            if (!dsT_CM_QUARANTOR.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }

            for ( i = 1; i <= dsT_CM_QUARANTOR.CountRow; i++ ) {
                if ( dsT_CM_QUARANTOR.RowStatus(i) == 1 ||
                     dsT_CM_QUARANTOR.RowStatus(i) == 3 ) {


                    // 보증구분
                    if( dsT_CM_QUARANTOR.NameValue(i, "GUR_TAG") == '' ) {
                        alert("보증구분은 필수 입력사항입니다.");
                        dsT_CM_QUARANTOR.RowPosition = i;
                        document.getElementById("cmbGUR_TAG").focus();
                        return false;
                    }

                    // 보증회사
                    if (dsT_CM_QUARANTOR.NameValue(i, "GUR_COM") != "" &&
                        dsT_CM_QUARANTOR.NameValue(i, "GUR_CNM") == "") {
                        alert("보증회사코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_CM_QUARANTOR.RowPosition = i;
                        document.getElementById("txtGUR_COM").focus();
                        return;
                    }

                    // 보증인과의관계
                    if (dsT_CM_QUARANTOR.NameValue(i, "GURR_CD") != "" &&
                        dsT_CM_QUARANTOR.NameValue(i, "GURR_NM") == "") {
                        alert("보증인관계코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_CM_QUARANTOR.RowPosition = i;
                        document.getElementById("txtGURR_CD").focus();
                        return;
                    }

                    // 보증시작일
                    if( dsT_CM_QUARANTOR.NameValue(i, "GURS_YMD") == '' ) {
                        alert("보증시작일은 필수 입력사항입니다.");
                        dsT_CM_QUARANTOR.RowPosition = i;
                        document.getElementById("txtGURS_YMD").focus();
                        return false;
                    }

                    // 보증시작일 CHECK
                    if (!fnc_CheckDate2(dsT_CM_QUARANTOR.NameValue(i, "GURS_YMD"), "보증시작일") && dsT_CM_QUARANTOR.NameValue(i, "GURS_YMD") != "") {
                        dsT_CM_QUARANTOR.RowPosition = i;
                        document.getElementById("txtGURS_YMD").focus();
                        return false;
                    }

                    // 보증인
                    if( dsT_CM_QUARANTOR.NameValue(i, "GUR_NAM") == '' ) {
                        alert("보증인은 필수 입력사항입니다.");
                        dsT_CM_QUARANTOR.RowPosition = i;
                        document.getElementById("txtGUR_NAM").focus();
                        return false;
                    }

                    // 보증만기일
                    if( dsT_CM_QUARANTOR.NameValue(i, "GURD_YMD") == '' ) {
                        alert("보증만기일은 필수 입력사항입니다.");
                        dsT_CM_QUARANTOR.RowPosition = i;
                        document.getElementById("txtGURD_YMD").focus();
                        return false;
                    }

                    // 보증만기일 CHECK
                    if (!fnc_CheckDate2(dsT_CM_QUARANTOR.NameValue(i, "GURD_YMD"), "보증만기일") && dsT_CM_QUARANTOR.NameValue(i, "GURD_YMD") != "") {
                        dsT_CM_QUARANTOR.RowPosition = i;
                        document.getElementById("txtGURD_YMD").focus();
                        return false;
                    }

                    // 보증시작일와 보증만기일 비교
                    if( dsT_CM_QUARANTOR.NameValue(i, "GURS_YMD") != '' && dsT_CM_QUARANTOR.NameValue(i, "GURD_YMD") != '' ) {
                        if( cfDateDiff(dsT_CM_QUARANTOR.NameValue(i, "GURS_YMD").replace(/\-/g,''),dsT_CM_QUARANTOR.NameValue(i, "GURD_YMD").replace(/\-/g,'')) < 0 ) {
                            alert("보증만기일자가 보증시작일자보다 작습니다.");
                            dsT_CM_QUARANTOR.RowPosition = i;
                            document.getElementById("txtGURD_YMD").focus();
                            return false;
                        }
                    }

                    // 종료여부
                    if( dsT_CM_QUARANTOR.NameValue(i, "END_TAG") == '' ) {
                        alert("종료여부는 필수 입력사항입니다.");
                        dsT_CM_QUARANTOR.RowPosition = i;
                        document.getElementById("cmbEND_TAG").focus();
                        return false;
                    }

                    // 주민번호 CHECK
                    if (!fnc_SsnValid(document.getElementById("txtCET_NO").value)) {
                        document.getElementById("txtCET_NO").focus();
                        return false;
                    }


                    if ( dsT_CM_QUARANTOR.RowStatus(i) == 1) {
                       document.getElementById("cmbGUR_TAG").disabled  = true;
                       document.getElementById("txtGURS_YMD").disabled = true;
                       document.getElementById("txtGUR_NAM").disabled  = true;
                       document.getElementById("ImgGursYmd").disabled  = true;
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
            cfStyleGrid(form1.grdT_CM_QUARANTOR, 0,"false","false");

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

                document.getElementById("cmbGUR_TAG").disabled  = false;
                document.getElementById("txtGURS_YMD").disabled = false;
                document.getElementById("txtGUR_NAM").disabled  = false;
                document.getElementById("txtGURD_YMD").disabled = false;
                document.getElementById("txtGUR_COM").disabled  = false;
                document.getElementById("txtGUR_NO").disabled   = false;
                document.getElementById("txtGURR_CD").disabled  = false;
                document.getElementById("txtGUR_CMP").disabled  = false;
                document.getElementById("txtGURO").disabled     = false;
                document.getElementById("txtCET_NO").disabled   = false;
                document.getElementById("txtGUR_ADR").disabled  = false;
                document.getElementById("cmbEND_TAG").disabled  = false;

                document.getElementById("ImgGursYmd").disabled  = false;
                document.getElementById("ImgGurdYmd").disabled  = false;
                document.getElementById("ImgGurCom").disabled   = false;
                document.getElementById("ImgGurrCd").disabled   = false;

            }
            else if (prop == 'D') {

                document.getElementById("cmbGUR_TAG").disabled  = true;
                document.getElementById("txtGURS_YMD").disabled = true;
                document.getElementById("txtGUR_NAM").disabled  = true;
                document.getElementById("txtGURD_YMD").disabled = true;
                document.getElementById("txtGUR_COM").disabled  = true;
                document.getElementById("txtGUR_NO").disabled   = true;
                document.getElementById("txtGURR_CD").disabled  = true;
                document.getElementById("txtGUR_CMP").disabled  = true;
                document.getElementById("txtGURO").disabled     = true;
                document.getElementById("txtCET_NO").disabled   = true;
                document.getElementById("txtGUR_ADR").disabled  = true;
                document.getElementById("cmbEND_TAG").disabled  = true;

                document.getElementById("ImgGursYmd").disabled  = true;
                document.getElementById("ImgGurdYmd").disabled  = true;
                document.getElementById("ImgGurCom").disabled   = true;
                document.getElementById("ImgGurrCd").disabled   = true;

            }
        }

        function fnc_SsnValid(val) {
            if (val != "") {
                if (!covSsnValidator_validate(removeChar(val,'-'))) {
                    alert("잘못된 주민번호입니다. 확인바랍니다.");
                    return true;//잘못되어도 저장 가능하게 수정(20070912, 김우태)
                }
            }

            return true;
        }

        function fnc_ChgGurTag() {

            if (document.getElementById("cmbGUR_TAG").value == 'I') {

                document.getElementById('txtGUR_NAM').value     = '보증보험';
                document.getElementById('txtGUR_COM').className = '';
                document.getElementById('txtGUR_COM').readOnly  = false;
                document.getElementById('txtGUR_NO').className  = '';
                document.getElementById('txtGUR_NO').readOnly   = false;

                document.getElementById("ImgGurCom").disabled   = false;

            }
            else if (document.getElementById("cmbGUR_TAG").value == 'M') {
                document.getElementById('txtGUR_NAM').value = '';
                document.getElementById('txtGUR_COM').className = 'input_ReadOnly';
                document.getElementById('txtGUR_COM').readOnly  = true;
                document.getElementById('txtGUR_NO').className  = 'input_ReadOnly';
                document.getElementById('txtGUR_NO').readOnly   = true;

                document.getElementById("ImgGurCom").disabled   = true;

            }
            else {

                document.getElementById('txtGUR_NAM').value     = '';
                document.getElementById('txtGUR_COM').className = '';
                document.getElementById('txtGUR_COM').readOnly  = false;
                document.getElementById('txtGUR_NO').className  = '';
                document.getElementById('txtGUR_NO').readOnly   = false;

                document.getElementById("ImgGurCom").disabled   = false;
            }
        }

        function fnc_EndYmd() {
            var year = null;
            var month = null;
            var day   = null;

            year = Number(document.getElementById("txtGURS_YMD").value.substr(0,4))+2;
            month = Number(document.getElementById("txtGURS_YMD").value.substr(5,2));
            day  = Number(document.getElementById("txtGURS_YMD").value.substr(8,2))-1;

            if (document.getElementById("txtGURS_YMD").value.substr(5,5) == "01-01"){
                year = Number(document.getElementById("txtGURS_YMD").value.substr(0,4))+1;
                month = "12";
            }
            if (document.getElementById("txtGURS_YMD").value.substr(8,2) == "01") {
              if (document.getElementById("txtGURS_YMD").value.substr(5,2) == "01")
                 month = "12";
              else
                 month = Number(document.getElementById("txtGURS_YMD").value.substr(5,2)) -1;
              if (document.getElementById("txtGURS_YMD").value.substr(5,2) == "01" ||
                  document.getElementById("txtGURS_YMD").value.substr(5,2) == "02" ||
                  document.getElementById("txtGURS_YMD").value.substr(5,2) == "04" ||
                  document.getElementById("txtGURS_YMD").value.substr(5,2) == "06" ||
                  document.getElementById("txtGURS_YMD").value.substr(5,2) == "08" ||
                  document.getElementById("txtGURS_YMD").value.substr(5,2) == "09" ||
                  document.getElementById("txtGURS_YMD").value.substr(5,2) == "11")
                  day = "31";
              else if (document.getElementById("txtGURS_YMD").value.substr(5,2) == "03")
                  day = "28";
              else day = "30";
            }

            if (month < 10) {
                month = "0" + month;
            }

            if (day < 10) {
                day = "0" + day;
            }

            if (document.getElementById("cmbGUR_TAG").value == 'M')
                document.getElementById("txtGURD_YMD").value = year + "-" + month + "-" + day;

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
    | 2. 이름 : dsT_CM_QUARANTOR                    |
    | 3. Table List : T_CM_QUARANTOR                |
    +----------------------------------------------->
    <Object ID="dsT_CM_QUARANTOR" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CM_QUARANTOR                    |
    | 3. Table List : T_CM_QUARANTOR                |
    +----------------------------------------------->
    <Object ID ="trT_CM_QUARANTOR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_QUARANTOR)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_QUARANTOR Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_QUARANTOR.CountRow);

            document.getElementById("cmbGUR_TAG").disabled  = true;
            document.getElementById("txtGURS_YMD").disabled = true;
            document.getElementById("txtGUR_NAM").disabled  = true;
            document.getElementById("ImgGursYmd").disabled  = true;

        }

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_QUARANTOR Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_QUARANTOR Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018 ) {

            document.getElementById("cmbGUR_TAG").disabled  = false;
            document.getElementById("txtGURS_YMD").disabled = false;
            document.getElementById("txtGUR_NAM").disabled  = false;
            document.getElementById("ImgGursYmd").disabled  = false;

            alert("해당 필수입력항목[보증시작일/보증인] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {

            document.getElementById("cmbGUR_TAG").disabled  = false;
            document.getElementById("txtGURS_YMD").disabled = false;
            document.getElementById("txtGUR_NAM").disabled  = false;
            document.getElementById("ImgGursYmd").disabled  = false;

            alert("보증시작일/보증인에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CM_QUARANTOR event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CM_QUARANTOR event="OnFail()">

        cfErrorMsg(this);

    </script>


    <script language=JavaScript for=dsT_CM_QUARANTOR Event="OnRowPosChanged(row)">

        var SysStatus = dsT_CM_QUARANTOR.SysStatus(row);

        if (document.getElementById("cmbGUR_TAG").value == 'I') {

            document.getElementById('txtGUR_COM').className = '';
            document.getElementById('txtGUR_COM').readOnly  = false;
            document.getElementById('txtGUR_NO').className  = '';
            document.getElementById('txtGUR_NO').readOnly   = false;

            document.getElementById("ImgGurCom").disabled   = false;

        } else if (document.getElementById("cmbGUR_TAG").value == 'M') {

            document.getElementById('txtGUR_COM').className = 'input_ReadOnly';
            document.getElementById('txtGUR_COM').readOnly  = true;
            document.getElementById('txtGUR_NO').className  = 'input_ReadOnly';
            document.getElementById('txtGUR_NO').readOnly   = true;

            document.getElementById("ImgGurCom").disabled   = true;

        }

        if (SysStatus == 1) {
            document.getElementById("cmbGUR_TAG").disabled  = false;
            document.getElementById("txtGURS_YMD").disabled = false;
            document.getElementById("txtGUR_NAM").disabled  = false;
            document.getElementById("ImgGursYmd").disabled  = false;

        } else {
            document.getElementById("cmbGUR_TAG").disabled  = true;
            document.getElementById("txtGURS_YMD").disabled = true;
            document.getElementById("txtGUR_NAM").disabled  = true;
            document.getElementById("ImgGursYmd").disabled  = true;
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
            <strong>보증인</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAdd','','/images/button/btn_AddnewOver.gif',1)">  <img src="/images/button/btn_AddnewOn.gif"  name="imgAdd"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">   <img src="/images/button/btn_SaveOn.gif"    name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif"  name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
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
                    <col width="60"></col>
                    <col width="115"></col>
                    <col width="60"></col>
                    <col width="130"></col>
                    <col width="60"></col>
                    <col width="104"></col>
                    <col width="60"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">보증구분</td>
                    <td class="padding2423">
                        <select id="cmbGUR_TAG" style="width:100%" onChange="fnc_ChgGurTag();">
                            <option value="" >선택</option>
                            <option value="M" >인보증</option>
                            <option value="I" >보증보험</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">시작일</td>
                    <td class="padding2423" >
                        <input id="txtGURS_YMD" style="width:70%" maxlength="10" onChange="fnc_CheckDate(this, '보증시작일');fnc_EndYmd();" onblur ="fnc_EndYmd();" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgGursYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgGursYmd" name="ImgGursYmd" width="21" height="20" border="0" align="absmiddle"  onclick="calendarBtn('datetype1','txtGURS_YMD','','215','53');"></a>
                    </td>
                    <td align="center" maxlength="12" class="creamBold">보증인</td>
                    <td class="padding2423" >
                        <input id="txtGUR_NAM" style="width:100%">
                    </td>
                    <td align="center" class="creamBold">보증회사</td>
                    <td class="padding2423">
                        <input id="txtGUR_COM" style="width:28%" maxlength="6" onChange="fnc_GetCommNm('BJ', 'txtGUR_COM','txtGUR_CNM');">
                        <input id="txtGUR_CNM" style="width:52%"  class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgGurCom','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgGurCom" name="ImgGurCom" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtGUR_COM','txtGUR_CNM','보증회사','BJ')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">만기일</td>
                    <td class="padding2423" >
                        <input id="txtGURD_YMD" style="width:70%" maxlength="10" onChange="JavaScript : fnc_CheckDate(this, '보증만기일');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgGurdYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgGurdYmd" name="ImgGurdYmd" width="21" height="20" border="0" align="absmiddle"  onclick="calendarBtn('datetype1','txtGURD_YMD','','25','77');"></a>
                    </td>
                    <td align="center" class="creamBold">증권번호</td>
                    <td class="padding2423" >
                        <input id="txtGUR_NO" maxlength="20" style="width:100%">
                    </td>
                    <td align="center" class="creamBold">종료여부</td>
                    <td class="padding2423">
                        <select id="cmbEND_TAG" style="width:100%">
                            <option value="" >선택</option>
                            <option value="Y" >Y</option>
                            <option value="N" >N</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">관&nbsp;&nbsp;&nbsp;계</td>
                    <td class="padding2423">
                        <input id="txtGURR_CD" style="width:28%" maxlength="2" onChange="fnc_GetCommNm('G1', 'txtGURR_CD','txtGURR_NM');">
                        <input id="txtGURR_NM" style="width:52%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgGurrCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgGurrCd" name="ImgGurrCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtGURR_CD','txtGURR_NM','관계','G1')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">연락처</td>
                    <td class="padding2423" >
                        <input id="txtGUR_CMP" maxlength="22" style="width:100%;ime-mode:disabled" onKeyPress="JavaScript: cfCheckNumber();">
                    </td>
                    <td align="center" class="creamBold">직&nbsp;&nbsp;&nbsp;업</td>
                    <td class="padding2423" >
                        <input id="txtGURO" maxlength="20" style="width:100%">
                    </td>
                    <td align="center" class="creamBold">주민번호</td>
                    <td class="padding2423" >
                        <input id="txtCET_NO" maxlength="14" style="width:100%;ime-mode:disabled"  onkeypress="cfCetNoHyphen(this);cfCheckNumber();" onChange="fnc_SsnValid(this.value);">
                    </td>
                    <td align="center" class="creamBold">주&nbsp;&nbsp;&nbsp;소</td>
                    <td class="padding2423" >
                        <input id="txtGUR_ADR" maxlength="60" style="width:100%">
                    </td>
                    <input type=hidden   id="txtENO_NO" size="10">
                    <input type=hidden   id="txtOCC_CD" size="1">
                </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="above">
                <tr>
                    <td></td>
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
                        <object id="grdT_CM_QUARANTOR" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:794px;height:161px;">
                            <param name="DataID"                  value="dsT_CM_QUARANTOR">
                            <param name="Format"                  value="
                                <C> id={currow}        width=29   name='순번'         align=center </C>
                                <C> id=GUR_TAG         width=40   name='코드'         align=center </C>
                                <C> id=GUR_TNM         width=70   name='보증구분'     align=center  value={Decode(GUR_TAG,'M','인보증','I','보증보험','')} </C>
                                <C> id=GURS_YMD        width=70   name='시작일'       align=center </C>
                                <C> id=GUR_NAM         width=70   name='보증인'                    </C>
                                <C> id=GUR_COM         width=45   name='코드'         align=center </C>
                                <C> id=GUR_CNM         width=90   name='보증회사'                  </C>
                                <C> id=GURD_YMD        width=70   name='만기일'       align=center </C>
                                <C> id=GUR_NO          width=90   name='증권번호'                  </C>
                                <C> id=END_TAG         width=60   name='종료여부'     align=center </C>
                                <C> id=GURR_CD         width=40   name='코드'         align=center </C>
                                <C> id=GURR_NM         width=70   name='관계'                      </C>
                                <C> id=GUR_CMP         width=95   name='연락처'                    </C>
                                <C> id=GURO            width=95   name='직업'                      </C>
                                <C> id=CET_NO          width=95   name='주민번호'                  </C>
                                <C> id=GUR_ADR         width=250  name='주소'                      </C>
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
<!-- 보증인 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_QUARANTOR">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=GUR_TAG       Ctrl=cmbGUR_TAG      Param=value </C>
        <C> Col=GURS_YMD      Ctrl=txtGURS_YMD     Param=value </C>
        <C> Col=GUR_NAM       Ctrl=txtGUR_NAM      Param=value </C>
        <C> Col=OCC_CD        Ctrl=txtOCC_CD       Param=value </C>
        <C> Col=GURD_YMD      Ctrl=txtGURD_YMD     Param=value </C>
        <C> Col=GUR_COM       Ctrl=txtGUR_COM      Param=value </C>
        <C> Col=GUR_CNM       Ctrl=txtGUR_CNM      Param=value </C>
        <C> Col=GUR_NO        Ctrl=txtGUR_NO       Param=value </C>
        <C> Col=GURR_CD       Ctrl=txtGURR_CD      Param=value </C>
        <C> Col=GURR_NM       Ctrl=txtGURR_NM      Param=value </C>
        <C> Col=GUR_CMP       Ctrl=txtGUR_CMP      Param=value </C>
        <C> Col=GURO          Ctrl=txtGURO         Param=value </C>
        <C> Col=CET_NO        Ctrl=txtCET_NO       Param=value </C>
        <C> Col=GUR_ADR       Ctrl=txtGUR_ADR      Param=value </C>
        <C> Col=END_TAG       Ctrl=cmbEND_TAG      Param=value </C>
    '>
</object>