<!--
    ************************************************************************************
    * @Source         : vlug070.jsp                                                    *
    * @Description    : 다면평가대상설정 PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/04  |  오대성   | 최초작성                                               *
    * 2006/09/20  |  박인이   | 개발                                                   *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>다면평가대상설정(vlug070)</title>
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

        var year = getToday().substring(0,4);
        var btnList = 'TTTTFFTT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "01";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

        var EVL_YY    = form1.cmbEVL_YY_SHR.value;
        var EVL_GBN = form1.cmbEVL_GBN_SHR.value;
        var EVL_FRQ = form1.cmbEVL_FRQ_SHR.value;
        var ENO_NO  = form1.txtENO_NO_SHR.value;
        var DPT_CD  = form1.txtDPT_CD_SHR.value;

        if (document.form1.cmbEVL_YY_SHR.value != year) {

            form1.imgCreate.disabled = true;
            form1.imgInforcopy.disabled   = true;
        }
        else {

            form1.imgCreate.disabled = false;
            form1.imgInforcopy.disabled   = false;
        }

        // 그리드 데이터 조회시


            dsT_EV_EVLIST_HD.ClearData();

            dsT_EV_EVLIST_HD.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlug070.cmd.VLUG070CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO+"&DPT_CD="+DPT_CD;
            dsT_EV_EVLIST_HD.Reset();



        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            var EVL_YY  = form1.cmbEVL_YY_SHR.value;

            // 그리드 데이터 조회시
            form1.txtFLAG.value = "1";

            dsT_EV_TYPE.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua070.cmd.VLUA070CMD&S_MODE=SHR_00&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY;
            dsT_EV_TYPE.Reset();

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

            // 저장시 각 필드의 유효성체크
            if (!fnc_SaveItemCheck()) {
                return;
            }

            trT_EV_EVLIST_HD.KeyValue = "tr01(I:SAV=dsT_EV_EVLIST_HD)";
            trT_EV_EVLIST_HD.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlug070.cmd.VLUG070CMD&S_MODE=SAV";
            trT_EV_EVLIST_HD.post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_EV_EVLIST_HD.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            if (form1.cmbEVL_YY_SHR.value != year) {
                alert("해당년도 이외의 자료는 삭제 할 수 없습니다!");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_08');
                document.form1.cmbEVL_YY_SHR.focus();
                return;
            }

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("[" + dsT_EV_EVLIST_HD.NameValue(dsT_EV_EVLIST_HD.RowPosition,"ENO_NO") + "][" + dsT_EV_EVLIST_HD.NameValue(dsT_EV_EVLIST_HD.RowPosition,"ENO_NM") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_EV_EVLIST_HD.DeleteRow(dsT_EV_EVLIST_HD.RowPosition);

            trT_EV_EVLIST_HD.KeyValue = "tr01(I:SAV=dsT_EV_EVLIST_HD)";
            trT_EV_EVLIST_HD.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlug070.cmd.VLUG070CMD&S_MODE=DEL";
            trT_EV_EVLIST_HD.post();

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_EV_EVLIST_HD.SetColumn(form1.grdT_EV_EVLIST_HD.GetColumnID(0));
            form1.grdT_EV_EVLIST_HD.Focus();

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

            if (dsT_EV_EVLIST_HD.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_EV_EVLIST_HD.GridToExcel("평가대상자설정", '', 225);

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            // 평가대상자등록및수정 팝업창을 신규화면으로 띄움
            //fnc_openPopup('I', '');

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

            document.getElementById("txtENO_NO_SHR").value     = '';
            document.getElementById("txtENO_NM_SHR").value     = '';
            document.getElementById("txtDPT_CD_SHR").value     = '';
            document.getElementById("txtDPT_NM_SHR").value     = '';
            document.getElementById("txtKIJUN_YMD_SHR").value  = '';

            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_EV_EVLIST_HD.ClearData();
            dsT_EV_EVLIST_HD2.ClearData();

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

            if (document.getElementById("cmbEVL_YY_SHR").value != year) {
                alert("현재년도 이외의 자료는 저장 및 수정할 수 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_06');
                document.form1.cmbEVL_YY_SHR.focus();
                return false;
            }

            // DataSet의 변경 여부 확인
            if ( !dsT_EV_EVLIST_HD.IsUpdated ) {

                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;

            }

            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            var EVL_YY  = null;

            //Grid Style 적용
            cfStyleGrid(form1.grdT_EV_EVLIST_HD, 0,"true","false");

            // DATASET 초기화
            fnc_Clear();

            getSelYy2('cmbEVL_YY_SHR');

            EVL_YY = form1.cmbEVL_YY_SHR.value;

            // Form Load시
            form1.txtFLAG.value = "1";

            // 업무구분
            if (frameid == "vlug070") {
                // 인사평가
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/인사평가/평가기준정보/";

            }
            else {
                // 직무평가
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/교육관리/직무평가/평가기준정보/";
            }

            dsT_EV_TYPE.ClearData();

            dsT_EV_TYPE.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua070.cmd.VLUA070CMD&S_MODE=SHR_00&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY;
            dsT_EV_TYPE.Reset();


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


        /***************************************
         * 이전복사버튼 클릭시 작업 처리 부분  *
         **************************************/
        function fnc_CopyBatch() {

            // 바로 전 데이터를 복사하여 만듬
            var EVL_YY    = form1.cmbEVL_YY_SHR.value;
            var EVL_GBN   = form1.cmbEVL_GBN_SHR.value;
            var EVL_FRQ   = form1.cmbEVL_FRQ_SHR.value;
            var KIJUN_YMD = form1.txtKIJUN_YMD_SHR.value;

            // 평가대상기준일 유효성 체크 (차후 평가대상기준일 기준이 정해지면 아래부분 풀어서 사용할 것)
            if( form1.txtKIJUN_YMD_SHR.value == '' ) {
                alert("평가대상기준일은 필수 입력사항입니다.");
                form1.txtKIJUN_YMD_SHR.focus();
                return;
            }

            if(!confirm("기존에 생성된 다면평가대상설정 정보는 모두 초기화 됩니다.\n\n그래도 적용 하시겠습니까?")) return;

            dsT_EV_EVLIST_HD.ClearData();

            dsT_EV_EVLIST_HD.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlug070.cmd.VLUG070CMD&S_MODE=SHR_04&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&KIJUN_YMD="+KIJUN_YMD;
            dsT_EV_EVLIST_HD.Reset();

        }


        /***************************************
         * 일괄생성버튼 클릭시 작업 처리 부분  *
         **************************************/
        function fnc_CreateBatch() {

            var EVL_YY    = form1.cmbEVL_YY_SHR.value;
            var EVL_GBN   = form1.cmbEVL_GBN_SHR.value;
            var EVL_FRQ   = form1.cmbEVL_FRQ_SHR.value;
            var KIJUN_YMD = form1.txtKIJUN_YMD_SHR.value;

            // 평가대상기준일 유효성 체크 (차후 평가대상기준일 기준이 정해지면 아래부분 풀어서 사용할 것)
            if( form1.txtKIJUN_YMD_SHR.value == '' ) {
                alert("평가대상기준일은 필수 입력사항입니다.");
                form1.txtKIJUN_YMD_SHR.focus();
                return;
            }

            if(!confirm("기존에 생성된 다면평가대상설정 정보는 모두 초기화 됩니다.\n\n그래도 적용 하시겠습니까?")) return;

            dsT_EV_EVLIST_HD.ClearData();

            dsT_EV_EVLIST_HD.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlug070.cmd.VLUG070CMD&S_MODE=SHR_02&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&KIJUN_YMD="+KIJUN_YMD;
            dsT_EV_EVLIST_HD.Reset();

        }



        /*****************************************************
         * 날짜 형식 유효성 체크                             *
         ****************************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;

            if(!cfDateExpr(obj.value)) {
                alert('유효한 날짜가 아닙니다.');
                obj.focus();
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
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_EVLIST_HD) |
    | 3. 사용되는 Table List(T_EV_EVLIST_HD)        |
    +----------------------------------------------->
    <Object ID="dsT_EV_EVLIST_HD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_EVLIST_HD) |
    | 3. 사용되는 Table List(T_EV_EVLIST_HD)        |
    +----------------------------------------------->
    <Object ID="dsT_EV_EVLIST_HD2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_EVLIST_HD) |
    | 3. 사용되는 Table List(T_EV_EVLIST_HD)        |
    +----------------------------------------------->
    <Object ID="dsT_EV_EVLIST_HD3" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_TYPE)      |
    | 3. 사용되는 Table List(T_EV_TYPE)             |
    +----------------------------------------------->
    <Object ID="dsT_EV_TYPE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_EVLIST_HD) |
    | 3. 사용되는 Table List(T_EV_EVLIST_HD)        |
    +----------------------------------------------->
    <Object ID ="trT_EV_EVLIST_HD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EV_EVLIST_HD)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_EVLIST_HD Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");


        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_EV_EVLIST_HD.CountRow);

        }

        if (document.form1.cmbEVL_YY_SHR.value != year) {
            form1.grdT_EV_EVLIST_HD.Editable = "false";
        }
        else {
            form1.grdT_EV_EVLIST_HD.Editable = "true";
        }

    </Script>

    <Script For=dsT_EV_EVLIST_HD2 Event="OnLoadCompleted(iCount)">

        var EVL_YY  = form1.cmbEVL_YY_SHR.value;
        var EVL_GBN = form1.cmbEVL_GBN_SHR.value;
        var EVL_FRQ = form1.cmbEVL_FRQ_SHR.value;
        var ENO_NO  = form1.txtENO_NO_SHR.value;
        var DPT_CD  = form1.txtDPT_CD_SHR.value;

        if (document.form1.cmbEVL_YY_SHR.value != year) {

            form1.imgCreate.disabled = true;
            form1.imgInforcopy.disabled   = true;
        }
        else {

            form1.imgCreate.disabled = false;
            form1.imgInforcopy.disabled   = false;
        }

        // 그리드 데이터 조회시
        if (form1.txtFLAG.value == "1") {

            dsT_EV_EVLIST_HD.ClearData();

            dsT_EV_EVLIST_HD.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlug070.cmd.VLUG070CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO+"&DPT_CD="+DPT_CD;
            dsT_EV_EVLIST_HD.Reset();

        }

    </Script>

    <Script For=dsT_EV_EVLIST_HD3 Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_02");


        } else {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_EV_EVLIST_HD3.CountRow);

        }

    </Script>


    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_HD Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <Script For=dsT_EV_EVLIST_HD2 Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <Script For=dsT_EV_EVLIST_HD3 Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <Script For=dsT_EV_TYPE Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_HD Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_EVLIST_HD2 Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


    <!-- 트랜젝션 성공. -->
    <script for=trT_EV_EVLIST_HD event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--트랜젝션 실패 -->
    <script for=trT_EV_EVLIST_HD event="OnFail()">

        cfErrorMsg(this);

    </script>





    <script language="javascript" for=grdT_EV_EVLIST_HD event=OnKeyPress(kcode)>

        var row = dsT_EV_EVLIST_HD.RowPosition;
        var column1 = grdT_EV_EVLIST_HD.GetColumn();
        var column2 = "";
        var column3 = "";
        var degree_gbn = "";
        var apply_rate = "";
        var rate = "";
        var obj = new String;

        if ((column1 == 'IEVLENO_NM11' ||
             column1 == 'IEVLENO_NM12' ||
             column1 == 'IEVLENO_NM13' )
            && kcode == "13"){

            if(column1 == 'IEVLENO_NM11'){//다면 1차평가자
                column2 = "IEVLENO_NO11";
                column3 = "EVLENO_NO1";

            }else if(column1 == 'IEVLENO_NM12'){//다면 2차평가자
                column2 = "IEVLENO_NO12";
                column3 = "EVLENO_NO2";

            }else if(column1 == 'IEVLENO_NM13'){//다면 3차평가자
                column2 = "IEVLENO_NO13";
                column3 = "EVLENO_NO3";

            }



            document.getElementById("txtENO_NM").value = dsT_EV_EVLIST_HD.NameValue(row, column1);

	        //성명으로 사번을 찾아오고 상세 내역 가져오기
            fnc_GetCommonEnoNo("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD");



            //사번으로 사원정보검색
            obj = fnc_GetCommonEnoNm("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD");

            if(obj != null && obj.eno_no != "") {
                dsT_EV_EVLIST_HD.NameValue(row, column2) = obj.eno_no;
                dsT_EV_EVLIST_HD.NameValue(row, column1) = obj.eno_nm;


                dsT_EV_EVLIST_HD.NameValue(row, column3) = obj.eno_nm;

                //초기화
                dsT_EV_EVLIST_HD.NameValue(row, column2) = "";
                dsT_EV_EVLIST_HD.NameValue(row, column1) = "";

                //바로 저장 하기
                dsT_EV_EVLIST_HD3.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlug070.cmd.VLUG070CMD&S_MODE=SAV_01"+
                                          "&EVLENO_NO_COL="+column3+
                                          "&EVL_YY="+dsT_EV_EVLIST_HD.NameValue(row, "EVL_YY")+
                                          "&EVL_FRQ="+dsT_EV_EVLIST_HD.NameValue(row, "EVL_FRQ")+
                                          "&ENO_NO="+dsT_EV_EVLIST_HD.NameValue(row, "ENO_NO")+
                                          "&EVLENO_NO="+obj.eno_no;
                dsT_EV_EVLIST_HD3.reset();

            }else{
	            //사번이 없으면 초기화
	            dsT_EV_EVLIST_HD.NameValue(row, column2) = "";
	            dsT_EV_EVLIST_HD.NameValue(row, column1) = "";
	        }

         }

     </script>

<!--
**************************************************************
* BODY START
**************************************************************
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">다면평가대상설정</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">다면평가대상설정</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
   <!--          <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>   -->
   <!--         <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>   -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image7" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image8" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="50"></col>
                                <col width="50"></col>
                                <col width="30"></col>
                                <col width="40"></col>
                                <col width="30"></col>
                                <col width="40"></col>
                                <col width="30"></col>
                                <col width="160"></col>
                                <col width="30"></col>
                                <col width="160"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">해당년도</td>
                                <td class="padding2423">
                                    <select id="cmbEVL_YY_SHR" name="cmbEVL_YY_SHR" onChange="JavaScript: fnc_SearchItem();" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                    </select>
                                </td>
                                <td align="right" class="searchState">구분</td>
                                <td class="padding2423">
                                    <select id=cmbEVL_GBN_SHR >
                                        <option value="1">다면</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">회차</td>
                                <td class="padding2423">
                                    <select id=cmbEVL_FRQ_SHR >
                                        <option value="1">1</option>
                                    </select> </td>
                                </td>
                                <td align="right" class="searchState">소속</td>
                                <td class="padding2423"><input name=txtDPT_CD_SHR size="10"  maxlength="6" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');"> <input name=txtDPT_NM_SHR size="12" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image11" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')"></a>
                                </td>

                                <td align="right" class="searchState">사번</td>
                                <td class="padding2423"><input name=txtENO_NO_SHR size="10"  maxlength="10" style="ime-mode:disabled" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList(); cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','0','0');"> <input name=txtENO_NM_SHR size="12" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtENO_NO_SHR','txtENO_NM_SHR', '1');"></a>

                                <!-- Hidden Filed -->
                                <input type=hidden name=txtDOWN_RATE1>
                                <input type=hidden name=txtDOWN_RATE2>
                                <input type=hidden name=txtDOWN_RATE3>
                                <input type=hidden name=txtACH_RATE1>
                                <input type=hidden name=txtFLAG>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- power Search테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width=50%><span id="resultMessage">&nbsp;</span></td>
                    <td align="left" class="searchState">평가대상기준일</td>
                    <td class="padding2423">
                        <input type=text id=txtKIJUN_YMD_SHR style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','/images/button/btn_HelpOver.gif',1)"  onclick="calendarBtn('datetype1','txtKIJUN_YMD_SHR','','500','125');"><img src="/images/button/btn_HelpOn.gif" name="Image12" width="21" height="20" border="0" align="absmiddle"></a>
                    </td>
                    <td align="right">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgInforcopy','','/images/button/btn_InforcopyOver.gif',1)"><img src="/images/button/btn_InforcopyOn.gif" id="imgInforcopy" name="imgInforcopy" width="100" height="20" border="0" align="absmiddle" onClick="fnc_CopyBatch()"></a>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCreate','','/images/button/BatchCreateOver.gif',1)"><img src="/images/button/BatchCreateOn.gif" id="imgCreate" name="imgCreate" width="80" height="20" border="0" align="absmiddle" onClick="fnc_CreateBatch()"></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>

	                    <!-- 사번 검색을 위해 임시 숨김 개체 -->
	                    <input type="hidden" name="txtENO_NO">
	                    <input type="hidden" name="txtENO_NM">
	                    <input type="hidden" name="hidEMPL_DPT_CD">

                        <comment id="__NSID__">
                        <object    id="grdT_EV_EVLIST_HD" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"                  value="dsT_EV_EVLIST_HD">
                            <param name="Editable"                value="true">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="ColSizing"               value="true">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <FC> id=HEAD_NM         width=75   name='본부'        align=center Edit=None </FC>
                                <FC> id=DPT_NM          width=80   name='소속'        align=center Edit=None </FC>
                                <FC> id=JOB_NM          width=44   name='직위',       align=center Edit=None </FC>
                                <FC> id=ENO_NO          width=54   name='사번'        align=center Edit=None </FC>
                                <FC> id=ENO_NM          width=48   name='성명'        align=center Edit=None </FC>
                                <G>  name='다면평가' HeadBgColor='#F7DCBB'
                                     <C> id=IEVLENO_NM11 width=54   name='입력'        align=left   EditLimit=10       </C>
                                     <C> id=EVLENO_NO1  width=90   name='1차평가자'   align=left   Edit=None </C>
                                     <C> id=IEVLENO_NM12 width=54   name='입력'        align=left   EditLimit=10       </C>
                                     <C> id=EVLENO_NO2  width=90   name='2차평가자'   align=left   Edit=None </C>
                                     <C> id=IEVLENO_NM13 width=54   name='입력'        align=left   EditLimit=10       </C>
                                     <C> id=EVLENO_NO3  width=90   name='3차평가자'   align=left   Edit=None </C>
                                </G>

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

    <!-- Validation Init  -->
    <jsp:include page="/common/CommonValid.jsp" flush="true">
       <jsp:param name="INIT"    value="false"/>
    </jsp:include>

</body>
</html>
