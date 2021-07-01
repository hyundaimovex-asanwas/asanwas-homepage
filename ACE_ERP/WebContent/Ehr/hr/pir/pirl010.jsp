<!--
    ************************************************************************************
    * @Source         : pirl010.jsp                                                    *
    * @Description    : 파견발령 PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/02/06  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>파견관리(pirl010)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'TFFTFTFT';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var STR_YMD   = document.getElementById("txtSTR_YMD_SHR").value;
            var END_YMD   = document.getElementById("txtEND_YMD_SHR").value;
            var DPC_GBN   = document.getElementById("cmbDPC_GBN_SHR").value;
            var ENO_NO    = document.getElementById("txtENO_NO_SHR").value;
            var checkList = document.all('chkGBN_SHR');
            var CHK1      = '';
            var CHK2      = '';

            for(var i = 0 ; i < checkList.length; i++){
                if(checkList[i].checked == true){
                    eval("CHK"+(i+1)+" = '1'");
                }
                else {
                    eval("CHK"+(i+1)+" = '0'");
                }
            }

            if (CHK1 == "0" && CHK2 == "0") {
                alert("선택에서 '파견중' 또는 '파견완료'를 하나이상 선택해야 합니다.");
                document.getElementById("chkGBN_SHR").focus();
                return;
            }

            if (STR_YMD == "") {
                alert("파견기간 FROM일자는 필수입력항목입니다.");
                document.getElementById("txtSTR_YMD_SHR").focus();
                return;
            }

            // 파견기간 시작일자 CHECK
            if (!fnc_CheckDate(document.getElementById("txtSTR_YMD_SHR"), "FROM일자") && document.getElementById("txtSTR_YMD_SHR").value != "") {
                document.getElementById("txtSTR_YMD_SHR").focus();
                return false;
            }

            if (END_YMD == "") {
                alert("파견기간 TO일자는 필수입력항목입니다.");
                document.getElementById("txtEND_YMD_SHR").focus();
                return;
            }

            // 파견기간 TO일자 CHECK
            if (!fnc_CheckDate(document.getElementById("txtEND_YMD_SHR"), "TO일자") && document.getElementById("txtEND_YMD_SHR").value != "") {
                document.getElementById("txtEND_YMD_SHR").focus();
                return false;
            }

            if(removeChar(STR_YMD,'-') > removeChar(END_YMD,'-')) {
                alert("시작일자는 종료일자보다 큽니다!");
                document.getElementById("txtSTR_YMD_SHR").focus();
                return;
            }

            dsT_CM_DISPATCH.ClearData();

            dsT_CM_DISPATCH.DataId = "/servlet/GauceChannelSVL?cmd=hr.pir.l.pirl010.cmd.PIRL010CMD&S_MODE=SHR&STR_YMD="+STR_YMD+"&END_YMD="+END_YMD+"&DPC_GBN="+DPC_GBN+"&ENO_NO="+ENO_NO+"&CHK1="+CHK1+"&CHK2="+CHK2;
            dsT_CM_DISPATCH.Reset();

            form1.grdT_CM_DISPATCH.Focus();

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

                trT_CM_DISPATCH.action = "/servlet/GauceChannelSVL?cmd=hr.pir.l.pirl010.cmd.PIRL010CMD&S_MODE=SAV";
                trT_CM_DISPATCH.post();

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
            if (dsT_CM_DISPATCH.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_CM_DISPATCH.RowStatus(dsT_CM_DISPATCH.RowPosition);

            //DataSet의 변경 여부 확인
            if (dsT_CM_DISPATCH.IsUpdated && status != 1) {
                alert("화면에 변경사항이 존재합니다.\n먼저 화면 내용을 저장하신 다음 작업하여 주십시오.");
                return false;
            }

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("시작일자[" + dsT_CM_DISPATCH.NameValue(dsT_CM_DISPATCH.RowPosition,"STR_YMD") + "] 파견소속[" + dsT_CM_DISPATCH.NameValue(dsT_CM_DISPATCH.RowPosition,"DPC_DPT_NM") + "] [" + dsT_CM_DISPATCH.NameValue(dsT_CM_DISPATCH.RowPosition,"ENO_NO") + "] [" + dsT_CM_DISPATCH.NameValue(dsT_CM_DISPATCH.RowPosition,"ENO_NM") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_CM_DISPATCH.DeleteRow(dsT_CM_DISPATCH.RowPosition);

            if (status != 1) {
                trT_CM_DISPATCH.action = "/servlet/GauceChannelSVL?cmd=hr.pir.l.pirl010.cmd.PIRL010CMD&S_MODE=DEL";
                trT_CM_DISPATCH.post();
            }

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_CM_DISPATCH.SetColumn(form1.grdT_CM_DISPATCH.GetColumnID(0));
            form1.grdT_CM_DISPATCH.Focus();

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

            if (dsT_CM_DISPATCH.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_CM_DISPATCH.GridToExcel("파견발령", '', 225);

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_CM_DISPATCH.CountColumn == 0) {
                dsT_CM_DISPATCH.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, ENO_NM:STRING, DPT_NM:STRING, JOB_NM:STRING, STR_YMD:STRING:KEYVALUETYPE, END_YMD:STRING, DPC_GBN:STRING, DPC_DPT_CD:STRING:KEYVALUETYPE, DPC_DPT_NM:STRING");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_CM_DISPATCH.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_CM_DISPATCH.setColumn(form1.grdT_CM_DISPATCH.getColumnID(0));

            // KEY 필드는 신규시 입력 가능
            document.getElementById("txtENO_NO").disabled     = false;
            document.getElementById("txtENO_NM").disabled     = false;
            document.getElementById("txtSTR_YMD").disabled    = false;
            document.getElementById("txtDPC_DPT_CD").disabled = false;
            document.getElementById("ImgEnoNo").disabled      = false;
            document.getElementById("ImgStrYmd").disabled     = false;
            document.getElementById("ImgDpcDptCd").disabled   = false;
            document.getElementById("cmbDPC_GBN").disabled    = false;

            document.getElementById("cmbDPC_GBN").value = "1";
            document.getElementById("txtENO_NO").focus();


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

            //document.getElementById("txtSTR_YMD_SHR").value = '';
            //document.getElementById("txtEND_YMD_SHR").value = '';
            document.getElementById("cmbDPC_GBN_SHR").value = '';
            document.getElementById("txtENO_NO_SHR").value = '';
            document.getElementById("txtENO_NM_SHR").value = '';
            form1.chkGBN_SHR[0].checked = true;
            form1.chkGBN_SHR[1].checked = true;

            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_CM_DISPATCH.ClearData();

            fnc_ColEnabled('D');

            //fnc_SetDateTerm();

            document.getElementById("txtSTR_YMD_SHR").focus();

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
            if (!dsT_CM_DISPATCH.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }

            for ( i = 1; i <= dsT_CM_DISPATCH.CountRow; i++ ) {
                if ( dsT_CM_DISPATCH.RowStatus(i) == 1 ||
                     dsT_CM_DISPATCH.RowStatus(i) == 3 ) {

                    // 사번
                    if( dsT_CM_DISPATCH.NameValue(i, "ENO_NO") == '' ) {
                        alert("사번은 필수 입력사항입니다.");
                        dsT_CM_DISPATCH.RowPosition = i;
                        document.getElementById("txtENO_NO").focus();
                        return false;
                    }

                    // 사번
                    if( dsT_CM_DISPATCH.NameValue(i, "ENO_NO") != '' && dsT_CM_DISPATCH.NameValue(i, "ENO_NM") == '') {
                        alert("입력하신 사번은 존재하지 않는 사번입니다. 확인바랍니다.");
                        dsT_CM_DISPATCH.RowPosition = i;
                        document.getElementById("txtENO_NO").focus();
                        return false;
                    }

                    // 시작일자
                    if( dsT_CM_DISPATCH.NameValue(i, "STR_YMD") == '' ) {
                        alert("시작일자는 필수 입력사항입니다.");
                        dsT_CM_DISPATCH.RowPosition = i;
                        document.getElementById("txtSTR_YMD").focus();
                        return false;
                    }

                    // 시작일자 CHECK
                    if (!fnc_CheckDate2(dsT_CM_DISPATCH.NameValue(i, "STR_YMD"), "시작일자") && dsT_CM_DISPATCH.NameValue(i, "STR_YMD") != "") {
                        dsT_CM_DISPATCH.RowPosition = i;
                        document.getElementById("txtSTR_YMD").focus();
                        return false;
                    }

                    // 종료일자 CHECK
                    if (!fnc_CheckDate2(dsT_CM_DISPATCH.NameValue(i, "END_YMD"), "종료일자") && dsT_CM_DISPATCH.NameValue(i, "END_YMD") != "") {
                        dsT_CM_DISPATCH.RowPosition = i;
                        document.getElementById("txtEND_YMD").focus();
                        return false;
                    }

                    // 시작일자와 종료일자 비교
                    if( dsT_CM_DISPATCH.NameValue(i, "STR_YMD") != '' && dsT_CM_DISPATCH.NameValue(i, "END_YMD") != '' ) {
                        if( cfDateDiff(dsT_CM_DISPATCH.NameValue(i, "STR_YMD").replace(/\-/g,''),dsT_CM_DISPATCH.NameValue(i, "END_YMD").replace(/\-/g,'')) < 0 ) {
                            alert("파견기간 종료일자가 시작일자보다 작습니다.");
                            dsT_CM_DISPATCH.RowPosition = i;
                            document.getElementById("txtEND_YMD").focus();
                            return false;
                        }
                    }

                    // 파견소속
                    if( dsT_CM_DISPATCH.NameValue(i, "DPC_DPT_CD") == '' ) {
                        alert("파견소속는 필수 입력사항입니다.");
                        dsT_CM_DISPATCH.RowPosition = i;
                        document.getElementById("txtDPC_DPT_CD").focus();
                        return false;
                    }

                    // 파견소속
                    if (dsT_CM_DISPATCH.NameValue(i, "DPC_DPT_CD") != "" &&
                        dsT_CM_DISPATCH.NameValue(i, "DPC_DPT_NM") == "") {
                        alert("파견소속코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_CM_DISPATCH.RowPosition = i;
                        document.getElementById("txtDPC_DPT_CD").focus();
                        return;
                    }

                    if ( dsT_CM_DISPATCH.RowStatus(i) == 1) {
                       document.getElementById("txtENO_NO").disabled     = false;
                       document.getElementById("txtENO_NM").disabled     = false;
                       document.getElementById("txtSTR_YMD").disabled    = false;
                       document.getElementById("txtDPC_DPT_CD").disabled = false;
                       document.getElementById("ImgEnoNo").disabled      = false;
                       document.getElementById("ImgStrYmd").disabled     = false;
                       document.getElementById("ImgDpcDptCd").disabled   = false;
                       document.getElementById("cmbDPC_GBN").disabled    = false;

                    }

                }
            }

            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style 적용
            cfStyleGrid(form1.grdT_CM_DISPATCH,0,"false","false");

            fnc_SetDateTerm();

            fnc_ColEnabled('D');

            document.getElementById("txtSTR_YMD_SHR").focus();

        }


        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

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

        // 파견기간 SET
        function fnc_SetDateTerm() {
            var dateinfo = getToday().split("-");

            //from - to 날짜값 설정하기
            var schDate  = new Date(dateinfo[0], dateinfo[1]-1, dateinfo[2]);
            var fromDate = null;
            var toDate   = null;

            fromDate = new Date(schDate.getFullYear(), schDate.getMonth(), "01");
            toDate   = new Date(schDate.getFullYear(), schDate.getMonth(), fnc_Lastday(schDate.getFullYear(), schDate.getMonth()+1));

            // FROM 일자
            document.getElementById("txtSTR_YMD_SHR").value = fnc_MakeDateString(fromDate);

            // TO 일자
            document.getElementById("txtEND_YMD_SHR").value = fnc_MakeDateString(toDate);

        }

        // DATE형을 STRING(YYYY-MM-DD)형태 일자로 변환
        function fnc_MakeDateString(date) {
            var year  = date.getYear();
            var month = date.getMonth() + 1;
            var date  = date.getDate();

            if (month < 10) {
                month = "0" + month;
            }

            if (date < 10) {
                date = "0" + date;
            }

            return year + "-" + month + "-" + date
        }


        /***************************************
         * 입력부의 컬럼의 Disabled 속성 바꿈  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // 해당 컬럼의 속성을 Enabled로 변경
            if (prop == 'E') {

                document.getElementById("txtENO_NO").disabled     = false;
                document.getElementById("txtENO_NM").disabled     = false;
                document.getElementById("txtSTR_YMD").disabled    = false;
                document.getElementById("txtEND_YMD").disabled    = false;
                document.getElementById("cmbDPC_GBN").disabled    = false;
                document.getElementById("txtDPC_DPT_CD").disabled = false;

                document.getElementById("ImgEnoNo").disabled      = false;
                document.getElementById("ImgStrYmd").disabled     = false;
                document.getElementById("ImgEndYmd").disabled     = false;
                document.getElementById("ImgDpcDptCd").disabled   = false;


            }
            else if (prop == 'D') {

                document.getElementById("txtENO_NO").disabled     = true;
                document.getElementById("txtENO_NM").disabled     = true;
                document.getElementById("txtSTR_YMD").disabled    = true;
                document.getElementById("txtEND_YMD").disabled    = true;
                document.getElementById("cmbDPC_GBN").disabled    = true;
                document.getElementById("txtDPC_DPT_CD").disabled = true;

                document.getElementById("ImgEnoNo").disabled      = true;
                document.getElementById("ImgStrYmd").disabled     = true;
                document.getElementById("ImgEndYmd").disabled     = true;
                document.getElementById("ImgDpcDptCd").disabled   = true;

            }
        }

        function fnc_EnoPopup() {

            var obj = new String();

            obj = fnc_emplPopup('txtENO_NO', 'txtENO_NM');

            if (obj.eno_no != null) {
                document.getElementById("txtENO_NO").value = obj.eno_no;
                document.getElementById("txtENO_NM").value = obj.eno_nm;
                document.getElementById("txtDPT_NM").value = obj.dpt_nm;
                document.getElementById("txtJOB_NM").value = obj.job_nm;
            }

        }

        // 파견소속 팝업창
        function fnc_DpcDptPopup() {

            // 사내
            if (document.getElementById("cmbDPC_GBN").value == "1") {

                fnc_commnmPopup('txtDPC_DPT_CD','txtDPC_DPT_NM','파견소속','DEPT');

            }
            // 사외
            else if (document.getElementById("cmbDPC_GBN").value == "2") {

                fnc_commonCodePopup('txtDPC_DPT_CD','txtDPC_DPT_NM','그룹사','B5');

            }
            // 해외
            else if (document.getElementById("cmbDPC_GBN").value == "3") {

                fnc_commonCodePopup('txtDPC_DPT_CD','txtDPC_DPT_NM','해외지사','AL');

            }
        }

        // 파견소속코드 입력시 파견소속명 가져오기
        function fnc_DpcDptNm() {

            // 사내
            if (document.getElementById("cmbDPC_GBN").value == "1") {

                fnc_GetCommNm('A4', 'txtDPC_DPT_CD','txtDPC_DPT_NM');

            }
            // 사외
            else if (document.getElementById("cmbDPC_GBN").value == "2") {

                fnc_GetCommNm('B8', 'txtDPC_DPT_CD','txtDPC_DPT_NM');

            }
            // 해외
            else if (document.getElementById("cmbDPC_GBN").value == "3") {

                fnc_GetCommNm('AL', 'txtDPC_DPT_CD','txtDPC_DPT_NM');

            }

        }

        // 사번으로 성명 가져오기
        function fnc_UsrGetEnoNm() {
            var obj = new String();

            document.getElementById("txtENO_NM").value = '';
            document.getElementById("txtDPT_NM").value = '';
            document.getElementById("txtJOB_NM").value = '';

            if (document.getElementById("txtENO_NO").value  == "") {

                return;
            }

            // 정규직 재직자
            obj = fnc_GetEnoNm('txtENO_NO','','0','1');

            if (obj.eno_nm  == "") {

                return;
            }
            else {

                document.getElementById("txtENO_NM").value = obj.eno_nm;
                document.getElementById("txtDPT_NM").value = obj.dpt_nm;
                document.getElementById("txtJOB_NM").value = obj.job_nm;
            }
        }

        // 성명으로 사번 가져오기
        function fnc_UsrGetEnoNo() {
            var obj = new String();

            document.getElementById("txtENO_NO").value = '';
            document.getElementById("txtDPT_NM").value = '';
            document.getElementById("txtJOB_NM").value = '';

            if (document.getElementById("txtENO_NM").value  == "") {

                return;
            }

            // 정규직 재직자
            obj = fnc_GetEnoNo('txtENO_NM', 'txtENO_NO', '0', '1','Y');

            if (obj.eno_no  == "") {

                return;
            }
            else {

                document.getElementById("txtENO_NO").value = obj.eno_no;
                document.getElementById("txtDPT_NM").value = obj.dpt_nm;
                document.getElementById("txtJOB_NM").value = obj.job_nm;
            }

        }


    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_CM_DISPATCH) |
    | 3. 사용되는 Table List(T_CM_DISPATCH)        |
    +----------------------------------------------->
    <Object ID="dsT_CM_DISPATCH" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CM_DISPATCH                    |
    | 3. Table List : T_CM_DISPATCH                |
    +----------------------------------------------->
    <Object ID ="trT_CM_DISPATCH" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_DISPATCH)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_DISPATCH Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_DISPATCH.CountRow );

            fnc_ColEnabled('E');

            document.getElementById("txtENO_NO").disabled     = true;
            document.getElementById("txtENO_NM").disabled     = true;
            document.getElementById("txtSTR_YMD").disabled    = true;
            document.getElementById("txtDPC_DPT_CD").disabled = true;
            document.getElementById("ImgEnoNo").disabled      = true;
            document.getElementById("ImgStrYmd").disabled     = true;
            document.getElementById("ImgDpcDptCd").disabled   = true;
            document.getElementById("cmbDPC_GBN").disabled    = true;

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_DISPATCH Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_DISPATCH Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018 ) {

            document.getElementById("txtENO_NO").disabled     = false;
            document.getElementById("txtENO_NM").disabled     = false;
            document.getElementById("txtSTR_YMD").disabled    = false;
            document.getElementById("txtDPC_DPT_CD").disabled = false;
            document.getElementById("ImgEnoNo").disabled      = false;
            document.getElementById("ImgStrYmd").disabled     = false;
            document.getElementById("ImgDpcDptCd").disabled   = false;
            document.getElementById("cmbDPC_GBN").disabled    = false;

            alert("해당 필수입력항목[사번/담당업무/시작일자] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50020) {

            document.getElementById("txtENO_NO").disabled     = false;
            document.getElementById("txtENO_NM").disabled     = false;
            document.getElementById("txtSTR_YMD").disabled    = false;
            document.getElementById("txtDPC_DPT_CD").disabled = false;
            document.getElementById("ImgEnoNo").disabled      = false;
            document.getElementById("ImgStrYmd").disabled     = false;
            document.getElementById("ImgDpcDptCd").disabled   = false;
            document.getElementById("cmbDPC_GBN").disabled    = false;

            alert("사번/담당업무/시작일자에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CM_DISPATCH event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CM_DISPATCH event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_CM_DISPATCH event=OnRowPosChanged(row)>
        var SysStatus = dsT_CM_DISPATCH.SysStatus(row);

        if (dsT_CM_DISPATCH.NameValue(row, 'DPC_GBN') == "2") {
            document.getElementById("name").innerText = '그 룹 사';
        }
        else {
            document.getElementById("name").innerText = '파견소속';
        }

        if (SysStatus == 1) {
            document.getElementById("txtENO_NO").disabled     = false;
            document.getElementById("txtENO_NM").disabled     = false;
            document.getElementById("txtSTR_YMD").disabled    = false;
            document.getElementById("txtDPC_DPT_CD").disabled = false;
            document.getElementById("ImgEnoNo").disabled      = false;
            document.getElementById("ImgStrYmd").disabled     = false;
            document.getElementById("ImgDpcDptCd").disabled   = false;
            document.getElementById("cmbDPC_GBN").disabled    = false;

        }
        else {
            document.getElementById("txtENO_NO").disabled     = true;
            document.getElementById("txtENO_NM").disabled     = true;
            document.getElementById("txtSTR_YMD").disabled    = true;
            document.getElementById("txtDPC_DPT_CD").disabled = true;
            document.getElementById("ImgEnoNo").disabled      = true;
            document.getElementById("ImgStrYmd").disabled     = true;
            document.getElementById("ImgDpcDptCd").disabled   = true;
            document.getElementById("cmbDPC_GBN").disabled    = true;

        }

    </script>


<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">파견관리</td>
                    <td align="right" class="navigator">HOME/인사관리/인사정보/<font color="#000000">파견관리</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete();"></a>
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
                                <col width="60"></col>
                                <col width="215"></col>
                                <col width="40"></col>
                                <col width="50"></col>
                                <col width="40"></col>
                                <col width="190"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">파견기간 </td>
                                <td class="padding2423">
                                    <input id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, 'FROM일자');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStrYmd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgStrYmd1" name="ImgStrYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','20','120');"></a> -
                                    <input id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, 'TO일자');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEndYmd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEndYmd1" name="ImgEndYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','20','120');"></a>
                                </td>
                                <td align="right" class="searchState">구분 </td>
                                <td class="padding2423">
                                    <select id="cmbDPC_GBN_SHR" style="width:100%"  onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                        <option value="">전체</option>
                                        <option value="1">사내</option>
                                        <option value="2">사외</option>
                                        <option value="3">해외</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">사번 </td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');cfNumberCheck();" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" style="ime-mode:disabled">
                                    <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgENO_NO_SHR" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtENO_NO_SHR','txtENO_NM_SHR', '1');"></a>

                                </td>
                                <td class="padding2423" align="left">
                                    <fieldset style="width:150px">
                                        <input type="checkbox" name="chkGBN_SHR" id="chkGBN_SHR" checked style="margin-bottom:-2px;border:0;">파견중
                                        <input type="checkbox" name="chkGBN_SHR" id="chkGBN_SHR" checked style="margin-bottom:-2px;border:0;">파견완료
                                    </fieldset>
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

<!-- 조회 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="80"></col>
                    <col width="100"></col>
                    <col width="80"></col>
                    <col width="100"></col>
                    <col width="80"></col>
                    <col width="140"></col>
                    <col width="80"></col>
                    <col width="140"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">사원번호</td>
                    <td class="padding2423">
                        <input name=txtENO_NO id=txtENO_NO style="width:70%;ime-mode:disabled" maxlength="10" onChange="fnc_UsrGetEnoNm();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_EnoPopup()"></a>
                    </td>
                    <td align="center" class="creamBold">성&nbsp;&nbsp;&nbsp;&nbsp;명</td>
                    <td class="padding2423">
                        <input name=txtENO_NM id=txtENO_NM style="width:100%" onKeyPress="JaveScript: if (event.keyCode == 13) {fnc_UsrGetEnoNo();}" onChange="fnc_UsrGetEnoNo();">
                    </td>
                    <td align="center" class="creamBold">소&nbsp;&nbsp;&nbsp;&nbsp;속</td>
                    <td class="padding2423">
                        <input name=txtDPT_NM id=txtDPT_NM style="width:100%" class="input_ReadOnly" readOnly>
                    </td>
                    <td align="center" class="creamBold">직&nbsp;&nbsp;&nbsp;&nbsp;위</td>
                    <td class="padding2423">
                        <input name=txtJOB_NM id=txtJOB_NM style="width:100%" class="input_ReadOnly" readOnly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">파견기간</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtSTR_YMD" name="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStrYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgStrYmd" name="ImgStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD','','20','120');"></a> -
                        <input id="txtEND_YMD" name="txtEND_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEndYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEndYmd" name="ImgEndYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','20','120');"></a>
                    </td>
                    <td align="center" class="creamBold">구&nbsp;&nbsp;&nbsp;&nbsp;분</td>
                    <td class="padding2423">
                        <select id="cmbDPC_GBN" style="width:100%" onChange="javascript : document.getElementById('txtDPC_DPT_CD').value = ''; document.getElementById('txtDPC_DPT_NM').value = '';">
                            <option value="1">사내</option>
                            <option value="2">사외</option>
                            <option value="3">해외</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold"><span id="name">파견소속</span></td>
                    <td class="padding2423">
                        <input name=txtDPC_DPT_CD id=txtDPC_DPT_CD style="width:20%;ime-mode:disabled" maxlength="3" onChange="fnc_DpcDptNm();"> <input name=txtDPC_DPT_NM id=txtDPC_DPT_NM style="width:53%" class="input_ReadOnly" readOnly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDpcDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDpcDptCd" name="ImgDpcDptCd" width="21" height="20" border="0" align="absmiddle" onclick="fnc_DpcDptPopup()"></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
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
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_CM_DISPATCH" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:280px;">
                            <param name="DataID"                  value="dsT_CM_DISPATCH">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'       width=40    name='NO'           align=center </C>
                                <C> id='DPT_NM'         width=90    name='소속'           align=left   </C>
                                <C> id='JOB_NM'         width=90    name='직위'           align=center </C>
                                <C> id='ENO_NO'         width=70    name='사번'           align=center </C>
                                <C> id='ENO_NM'         width=80    name='성명'           align=center </C>
                                <C> id='STR_YMD'        width=80    name='파견일'         align=center </C>
                                <C> id='END_YMD'        width=80    name='복귀일'         align=center </C>
                                <C> id='DPC_GBN_NM'     width=90    name='구분'           align=center value={DECODE(DPC_GBN,1,'사내',2,'사외',3,'해외')}</C>
                                <C> id='DPC_DPT_CD'     width=67    name='파견소속;코드'  align=center </C>
                                <C> id='DPC_DPT_NM'     width=90    name='파견소속'       align=left   </C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 내용 조회 그리드 테이블 끝-->

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
    <Param Name="DataID",   Value="dsT_CM_DISPATCH">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=DPT_NM        Ctrl=txtDPT_NM       Param=value </C>
        <C> Col=JOB_NM        Ctrl=txtJOB_NM       Param=value </C>
        <C> Col=ENO_NM        Ctrl=txtENO_NM       Param=value </C>
        <C> Col=STR_YMD       Ctrl=txtSTR_YMD      Param=value </C>
        <C> Col=END_YMD       Ctrl=txtEND_YMD      Param=value </C>
        <C> Col=DPC_GBN       Ctrl=cmbDPC_GBN      Param=value </C>
        <C> Col=DPC_DPT_CD    Ctrl=txtDPC_DPT_CD   Param=value </C>
        <C> Col=DPC_DPT_NM    Ctrl=txtDPC_DPT_NM   Param=value </C>
    '>
</object>
