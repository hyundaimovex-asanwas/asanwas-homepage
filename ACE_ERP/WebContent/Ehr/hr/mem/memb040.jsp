<!--
    ************************************************************************************
    * @Source         : memb040.jsp                                                    *
    * @Description    : 파견사원급여처리 PAGE                                          *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/02/01  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>파견사원급여처리(memb040)</title>
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

        var btnList = 'TFTTTTFT';
        var Month   = getToday().substr(0,7);

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            var PIS_YM     = document.getElementById("txtPIS_YM_SHR").value;

            if (PIS_YM == "") {
                alert("년월은 필수입력항목입니다.");
                document.getElementById("txtPIS_YM_SHR").focus();
                return;
            }

            // 년월 CHECK
            if (!fnc_CheckDate(document.getElementById("txtPIS_YM_SHR"), '년월')) {
                document.getElementById("txtPIS_YM_SHR").focus();
                return;
            }

            // 급여처리 작업로그 데이터 조회
            dsT_CP_WORKLOG.ClearData();

            dsT_CP_WORKLOG.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb040.cmd.MEMB040CMD&S_MODE=SHR_00&PIS_YM="+PIS_YM;
            dsT_CP_WORKLOG.Reset();

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

                trT_ME_APYMST.action = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb040.cmd.MEMB040CMD&S_MODE=SAV";
                trT_ME_APYMST.post();

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
            if (dsT_ME_APYMST.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_ME_APYMST.RowStatus(dsT_ME_APYMST.RowPosition);

            //DataSet의 변경 여부 확인
            if (dsT_ME_APYMST.IsUpdated && status != 1) {
                alert("화면에 변경사항이 존재합니다.\n먼저 화면 내용을 저장하신 다음 작업하여 주십시오.");
                return false;
            }

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("사번[" + dsT_ME_APYMST.NameValue(dsT_ME_APYMST.RowPosition,"ENO_NO") + "] 성명[" + dsT_ME_APYMST.NameValue(dsT_ME_APYMST.RowPosition,"ENO_NM") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_ME_APYMST.DeleteRow(dsT_ME_APYMST.RowPosition);

            if (status != 1) {
                trT_ME_APYMST.action = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb040.cmd.MEMB040CMD&S_MODE=DEL";
                trT_ME_APYMST.post();
            }

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_ME_APYMST.SetColumn(form1.grdT_ME_APYMST.GetColumnID(0));
            form1.grdT_ME_APYMST.Focus();

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

            if (dsT_ME_APYMST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_ME_APYMST.GridToExcel("파견사원급여처리", '', 225);


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

            document.getElementById("txtPIS_YM_SHR").value  = '';
            document.getElementById("txtDISCOMP_CD_SHR").value  = '';
            document.getElementById("txtDISCOMP_NM_SHR").value  = '';
            document.getElementById("txtENO_NO_SHR").value  = '';
            document.getElementById("txtENO_NM_SHR").value  = '';

            // 버튼 비활성화
            document.getElementById("btnMEMB01").disabled = true;
            document.getElementById("btnMEMB02").disabled = true;
            document.getElementById("btnMEMB03").disabled = true;
            document.getElementById("btnMEMB04").disabled = true;
            document.getElementById("btnMEMB05").disabled = true;

            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_CP_WORKLOG.ClearData();
            dsT_ME_APYMST.ClearData();

            document.getElementById("txtPIS_YM_SHR").value = Month;
            document.getElementById("txtPIS_YM_SHR").focus();

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

            if (dsT_CP_WORKLOG.NameValue(1, "PRO_STS") != "2") {
                return false;
            }

            //DataSet의 변경 여부 확인
            if (!dsT_ME_APYMST.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }

            for ( i = 1; i <= dsT_ME_APYMST.CountRow; i++ ) {
                if ( dsT_ME_APYMST.RowStatus(i) == 1 ||
                     dsT_ME_APYMST.RowStatus(i) == 3 ) {

                    // 근무일수
                    if( dsT_ME_APYMST.NameValue(i, "GUN_CNT") == 0 ) {
                        alert("근무일수는 필수 입력사항입니다.");
                        form1.grdT_ME_APYMST.focus();
                        form1.grdT_ME_APYMST.setColumn("GUN_CNT");
                        dsT_ME_APYMST.RowPosition = i;

                        return false;
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
            cfStyleGrid(form1.grdT_ME_APYMST,0,"false","false");

            // 버튼 비활성화
            document.getElementById("btnMEMB01").disabled = true;
            document.getElementById("btnMEMB02").disabled = true;
            document.getElementById("btnMEMB03").disabled = true;
            document.getElementById("btnMEMB04").disabled = true;
            document.getElementById("btnMEMB05").disabled = true;

            document.getElementById("txtPIS_YM_SHR").value = Month;
            document.getElementById("txtPIS_YM_SHR").focus();

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


        /********************************************
         * 작업OPEN 버튼 클릭시 처리                *
         *******************************************/
        function fnc_PROSTS_01() {

            // 작업로그 데이터 생성
            var PIS_YM = document.getElementById("txtPIS_YM_SHR").value;
            var PIS_YY = document.getElementById("txtPIS_YM_SHR").value.substr(0,4);
            var PIS_MM = document.getElementById("txtPIS_YM_SHR").value.substr(5,2);
            var OCC_CD = ' ';
            var SAL_GBN = ' ';

            if (PIS_YM == "") {
                alert("년월은 필수입력항목입니다.");
                document.getElementById("txtPIS_YM_SHR").focus();
                return;
            }

            // 급여처리 작업로그 데이터 조회
            dsT_CP_WORKLOG.ClearData();

            dsT_CP_WORKLOG.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb040.cmd.MEMB040CMD&S_MODE=SHR_02&PIS_YM="+PIS_YM+"&PIS_YY="+PIS_YY+"&PIS_MM="+PIS_MM+"&OCC_CD="+OCC_CD+"&SAL_GBN="+SAL_GBN;
            dsT_CP_WORKLOG.Reset();

        }

        /********************************************
         * 대상자선정 버튼 클릭시 처리              *
         *******************************************/
        function fnc_PROSTS_02() {

            // 파견사원급여처리 데이터 생성
            // 작업로그 데이터 생성
            var PIS_YM = document.getElementById("txtPIS_YM_SHR").value;
            var PIS_YY = document.getElementById("txtPIS_YM_SHR").value.substr(0,4);
            var PIS_MM = document.getElementById("txtPIS_YM_SHR").value.substr(5,2);
            var OCC_CD = ' ';
            var SAL_GBN = ' ';

            if (PIS_YM == "") {
                alert("년월은 필수입력항목입니다.");
                document.getElementById("txtPIS_YM_SHR").focus();
                return;
            }

            // 급여처리 작업로그 데이터 조회
            dsT_CP_WORKLOG.ClearData();

            dsT_CP_WORKLOG.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb040.cmd.MEMB040CMD&S_MODE=SHR_03&PIS_YM="+PIS_YM+"&PIS_YY="+PIS_YY+"&PIS_MM="+PIS_MM+"&OCC_CD="+OCC_CD+"&SAL_GBN="+SAL_GBN;
            dsT_CP_WORKLOG.Reset();

        }

        /********************************************
         * 급여계산 버튼 클릭시 처리                *
         *******************************************/
        function fnc_PROSTS_03() {

            // 계산된 급여에 대한 파견사원급여처리 반영
            // 작업로그 데이터 생성
            var PIS_YM = document.getElementById("txtPIS_YM_SHR").value;
            var PIS_YY = document.getElementById("txtPIS_YM_SHR").value.substr(0,4);
            var PIS_MM = document.getElementById("txtPIS_YM_SHR").value.substr(5,2);
            var OCC_CD = ' ';
            var SAL_GBN = ' ';

            if (PIS_YM == "") {
                alert("년월은 필수입력항목입니다.");
                document.getElementById("txtPIS_YM_SHR").focus();
                return;
            }

            //DataSet의 변경 여부 확인
            if (dsT_ME_APYMST.IsUpdated ) {
                alert("변경사항이 존재합니다.\n저장한 후 작업하시기 바랍니다.");
                return false;
            }

            // 급여처리 작업로그 데이터 조회
            dsT_CP_WORKLOG.ClearData();

            dsT_CP_WORKLOG.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb040.cmd.MEMB040CMD&S_MODE=SHR_04&PIS_YM="+PIS_YM+"&PIS_YY="+PIS_YY+"&PIS_MM="+PIS_MM+"&OCC_CD="+OCC_CD+"&SAL_GBN="+SAL_GBN;
            dsT_CP_WORKLOG.Reset();

        }

        /********************************************
         * 작업완료 버튼 클릭시 처리                *
         *******************************************/
        function fnc_PROSTS_04() {

            // 작업로그에 작업완료 상태 반영
            // 작업로그 데이터 생성
            var PIS_YM = document.getElementById("txtPIS_YM_SHR").value;
            var PIS_YY = document.getElementById("txtPIS_YM_SHR").value.substr(0,4);
            var PIS_MM = document.getElementById("txtPIS_YM_SHR").value.substr(5,2);
            var OCC_CD = ' ';
            var SAL_GBN = ' ';

            if (PIS_YM == "") {
                alert("년월은 필수입력항목입니다.");
                document.getElementById("txtPIS_YM_SHR").focus();
                return;
            }

            // 급여처리 작업로그 데이터 조회
            dsT_CP_WORKLOG.ClearData();

            dsT_CP_WORKLOG.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb040.cmd.MEMB040CMD&S_MODE=SHR_05&PIS_YM="+PIS_YM+"&PIS_YY="+PIS_YY+"&PIS_MM="+PIS_MM+"&OCC_CD="+OCC_CD+"&SAL_GBN="+SAL_GBN;
            dsT_CP_WORKLOG.Reset();

        }

        /********************************************
         * 재작업 버튼 클릭시 처리                  *
         *******************************************/
        function fnc_PROSTS_05() {

            // 작업로그에 작업완료 상태 반영
            // 작업로그 데이터 생성
            var PIS_YM = document.getElementById("txtPIS_YM_SHR").value;
            var PIS_YY = document.getElementById("txtPIS_YM_SHR").value.substr(0,4);
            var PIS_MM = document.getElementById("txtPIS_YM_SHR").value.substr(5,2);
            var OCC_CD = ' ';
            var SAL_GBN = ' ';

            if (PIS_YM == "") {
                alert("년월은 필수입력항목입니다.");
                document.getElementById("txtPIS_YM_SHR").focus();
                return;
            }

            document.getElementById("resultMessage").innerText = ' ';

            // 급여계산 버튼이 활성화된 경우 대상자선정이 완료되었으므로
            // 대상자선정 재작업할 수 있게 함
            if (document.getElementById("btnMEMB03").disabled == false) {

                if(!confirm("이전에 생성된 대상자 정보를 삭제하게 됩니다..\n\n그래도 적용 하시겠습니까?")) return;

                // 급여처리 작업로그 데이터 조회
                dsT_CP_WORKLOG.ClearData();

                dsT_CP_WORKLOG.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb040.cmd.MEMB040CMD&S_MODE=SHR_06&PIS_YM="+PIS_YM+"&PIS_YY="+PIS_YY+"&PIS_MM="+PIS_MM+"&OCC_CD="+OCC_CD+"&SAL_GBN="+SAL_GBN;
                dsT_CP_WORKLOG.Reset();
            }
            // 작업완료 버튼이 활성화된 경우 급여계산완료됐으므로
            // 급여계산 재작업할 수 있도록 함
            else if (document.getElementById("btnMEMB04").disabled == false) {

                if(!confirm("이전에 계산된 급여정보를 초기화하게 됩니다..\n\n그래도 적용 하시겠습니까?")) return;

                // 급여처리 작업로그 데이터 조회
                dsT_CP_WORKLOG.ClearData();

                dsT_CP_WORKLOG.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb040.cmd.MEMB040CMD&S_MODE=SHR_07&PIS_YM="+PIS_YM+"&PIS_YY="+PIS_YY+"&PIS_MM="+PIS_MM+"&OCC_CD="+OCC_CD+"&SAL_GBN="+SAL_GBN;
                dsT_CP_WORKLOG.Reset();
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
    | 2. 이름은 ds_ + 주요 테이블명(T_ME_APYMST)    |
    | 3. 사용되는 Table List(T_ME_APYMST)           |
    +----------------------------------------------->
    <Object ID="dsT_ME_APYMST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_CP_WORKLOG)   |
    | 3. 사용되는 Table List(T_CP_WORKLOG)          |
    +----------------------------------------------->
    <Object ID="dsT_CP_WORKLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_ME_APY                          |
    | 3. Table List : T_ME_APY                      |
    +----------------------------------------------->
    <Object ID ="trT_ME_APYMST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ME_APYMST)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">

        var PIS_YM     = document.getElementById("txtPIS_YM_SHR").value;
        var DISCOMP_CD = document.getElementById("txtDISCOMP_CD_SHR").value;
        var ENO_NO     = document.getElementById("txtENO_NO_SHR").value;

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            // 데이터가 미존재하는 경우 작업OPEN 버튼 활성화
            document.getElementById("btnMEMB01").disabled = false;
            document.getElementById("btnMEMB02").disabled = true;
            document.getElementById("btnMEMB03").disabled = true;
            document.getElementById("btnMEMB04").disabled = true;
            document.getElementById("btnMEMB05").disabled = true;

            // 파견사원급여처리 GRID 초기화
            dsT_ME_APYMST.ClearData();

        } else {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CP_WORKLOG.CountRow );

            switch (dsT_CP_WORKLOG.NameValue(1, "PRO_STS")) {
                case "1" :  // 작업OPEN 완료상태
                    // 대상자선정 버튼 활성화
                    document.getElementById("btnMEMB01").disabled = true;
                    document.getElementById("btnMEMB02").disabled = false;
                    document.getElementById("btnMEMB03").disabled = true;
                    document.getElementById("btnMEMB04").disabled = true;
                    document.getElementById("btnMEMB05").disabled = true;

                    form1.grdT_ME_APYMST.Editable = "false";

                    break;
                case "2" :  // 대상자선정 완료상태
                    // 급여계산 버튼 활성화
                    document.getElementById("btnMEMB01").disabled = true;
                    document.getElementById("btnMEMB02").disabled = true;
                    document.getElementById("btnMEMB03").disabled = false;
                    document.getElementById("btnMEMB04").disabled = true;
                    document.getElementById("btnMEMB05").disabled = false;

                    form1.grdT_ME_APYMST.Editable = "true";

                    break;
                case "3" :  // 급여계산 완료상태
                    // 작업완료 버튼 활성화
                    document.getElementById("btnMEMB01").disabled = true;
                    document.getElementById("btnMEMB02").disabled = true;
                    document.getElementById("btnMEMB03").disabled = true;
                    document.getElementById("btnMEMB04").disabled = false;
                    document.getElementById("btnMEMB05").disabled = false;

                    form1.grdT_ME_APYMST.Editable = "false";

                    break;
                case "4" :  // 작업완료상태
                    // 모든 버튼 비활성화
                    document.getElementById("btnMEMB01").disabled = true;
                    document.getElementById("btnMEMB02").disabled = true;
                    document.getElementById("btnMEMB03").disabled = true;
                    document.getElementById("btnMEMB04").disabled = true;
                    document.getElementById("btnMEMB05").disabled = true;


                    form1.grdT_ME_APYMST.Editable = "false";

                    break;
            }

            // 파견사원급여처리 GRID 초기화
            dsT_ME_APYMST.ClearData();

            // 작업OPEN 활성화인 경우 아직 대상자가 없으므로
            // 파견사원급여처리 데이터를 조회하지 않음
            if (dsT_CP_WORKLOG.NameValue(1, "PRO_STS") == "1") {
                return;
            }

            document.getElementById("resultMessage").innerText = ' ';

            // 파견사원급여처리 데이터 조회
            dsT_ME_APYMST.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.b.memb040.cmd.MEMB040CMD&S_MODE=SHR_01&PIS_YM="+PIS_YM+"&DISCOMP_CD="+DISCOMP_CD+"&ENO_NO="+ENO_NO;
            dsT_ME_APYMST.Reset();

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CP_WORKLOG Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CP_WORKLOG Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ME_APYMST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ME_APYMST.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ME_APYMST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ME_APYMST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_ME_APYMST event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_ME_APYMST event="OnFail()">

        cfErrorMsg(this);

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">파견사원급여처리</td>
                    <td align="right" class="navigator">HOME/인사관리/파견사원/<font color="#000000">파견사원급여처리</font></td>
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
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="50"></col>
                                <col width="80"></col>
                                <col width="50"></col>
                                <col width="160"></col>
                                <col width="50"></col>
                                <col width="*"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState"> 년월&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtPIS_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onChange="fnc_CheckDate(this, '년월');"  onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPisYm','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgPisYm" name="ImgPisYm" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','5','120');"></a>
                                </td>
                                <td align="right" class="searchState">업체 </td>
                                <td class="padding2423">
                                    <input id=txtDISCOMP_CD_SHR name=txtDISCOMP_CD_SHR size="5"  maxlength="5" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();" onChange="fnc_GetCommNm('CA', 'txtDISCOMP_CD_SHR','txtDISCOMP_NM_SHR');"> <input id=txtDISCOMP_NM_SHR name=txtDISCOMP_NM_SHR size="12" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDiscompCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDiscompCd" name="ImgDiscompCd" width="21" height="20" border="0" align="absmiddle"  onClick="fnc_commonCodePopup('txtDISCOMP_CD_SHR','txtDISCOMP_NM_SHR','파견업체','CA')"></a>
                                </td>
                                <td align="right" class="searchState">사번 </td>
                                <td class="padding2423">
                                    <input id=txtENO_NO_SHR name=txtENO_NO_SHR size="10"  maxlength="10" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();" onChange="fnc_GetEnoNm('txtENO_NO_SHR')"> <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="12" onKeyPress="JaveScript: if (event.keyCode == 13) {fnc_GetEnoNo('txtENO_NM_SHR', 'txtENO_NO_SHR', '2');}">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl3Popup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table width="800" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="paddingTop8">
                        <table width="800" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                            <colgroup>
                                <col width="150"></col>
                                <col width="150"></col>
                                <col width="150"></col>
                                <col width="150"></col>
                                <col width=""></col>
                            </colgroup>
                            <tr>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnMEMB01"  style="cursor:hand" value=" 작업 OPEN "  style="width:70pt;"  onclick="fnc_PROSTS_01();">
                                </td>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnMEMB02"  style="cursor:hand" value=" 대상자선정 " style="width:70pt;"  onclick="fnc_PROSTS_02();">
                                </td>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnMEMB03" style="cursor:hand" value=" 급여계산 "    style="width:70pt;"  onclick="fnc_PROSTS_03();">
                                </td>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnMEMB04" style="cursor:hand" value="작업완료"      style="width:70pt;"  onclick="fnc_PROSTS_04();">
                                </td>
                                <td align="center" class="padding2423">
                                    <input type="button" id="btnMEMB05" style="cursor:hand" value="재작업"        style="width:70pt;"  onclick="fnc_PROSTS_05();">
                                </td>
                            </tr>
                        </table>
                    <td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</table>
<!-- power Search테이블 끝 -->

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
        <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_ME_APYMST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:370px;">
                            <param name="DataID"                  value="dsT_ME_APYMST">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <FC> id='{currow}'     width=39    name='순번'           Edit='None'    align=center </FC>
                                <FC> id='DISCOMP_NM'   width=100   name='업체명'         Edit='None'    align=left   </FC>
                                <FC> id='DPT_NM'       width=100   name='소속'           Edit='None'    align=left   </FC>
                                <FC> id='ENO_NO'       width=70    name='사번'           Edit='None'    align=center </FC>
                                <FC> id='ENO_NM'       width=70    name='성명'           Edit='None'    align=center </FC>
                                <C> id='HIR_YMD'      width=70    name='입사일'         Edit='None'    align=center </C>
                                <C> id='RET_YMD'      width=70    name='퇴사일'         Edit='None'    align=center </C>
                                <C> id='GUN_CNT'      width=60    name='근무일수'       Edit='Numeric' align=right  </C>
                                <C> id='BAS_AMT'      width=90    name='파견단가'       Edit='None'    align=right </C>
                                <C> id='LSEV_AMT'     width=90    name='근속장려금'     Edit='None'    align=right </C>
                                <C> id='WEL_AMT'      width=90    name='기타수당'       Edit='None'    align=right </C>
                                <C> id='SUM_AMT'      width=90    name='용역비 계'      Edit='None'    align=right </C>
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