<!--
***********************************************************************
* @source      : vlua030.jsp
* @description : 평가반영비율설정 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/09/22      오대성        최초작성.
* 2007/03/15      박인이        수정. (직무평가업무내용 추가)
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<!-- Potential의 기능을 사용하기 위해서는 반드시 페이지의 상단 부분에 정의가 되어져 있어야 한다. -->
<script>var frame; try {frame = window.external.GetFrame(window);}catch(e){alert(window.name);alert("frame 초기화 실패");}</script>

<html>
<head>
<title>평가반영비율설정(vlua030)</title>
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

        var insert_flag;                                 //상태를 입력으로 수정하기 위한 Flag
        frame.SetEvent("onwinstat", fnc_FormActive);     // 본 Form이 Active되는 시점을 찾아서 Event를 발생한다.

        var frameid = window.external.GetFrame(window).FrameId;
        var year    = getToday().substring(0,4);
        var btnList = 'TFTFFFFT';
        var GUBUN   = '';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //평가 구조 설정 정보 조회
            dsT_EV_TYPE.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua030.cmd.VLUA030CMD&S_MODE=SHR_01&GUBUN="+document.form1.txtGUBUN.value+"&EVL_YY="+document.getElementById("selEVL_YY_SHR").value;
            dsT_EV_TYPE.reset();

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

                //DateSet의 EVL_YY에 검색년도를 Setting
                for (i=0;i<dsT_EV_ADJRATE.CountRow;i++){

                    if (dsT_EV_ADJRATE.NameValue(i+1,"EVL_YY") == '') {
                        dsT_EV_ADJRATE.NameValue(i+1,"GUBUN")  = GUBUN;
                        dsT_EV_ADJRATE.NameValue(i+1,"EVL_YY") = document.form1.selEVL_YY_SHR.value;

                    }
                }

                trT_EV_ADJRATE.KeyValue = "tr01(I:dsT_EV_ADJRATE=dsT_EV_ADJRATE)";
                trT_EV_ADJRATE.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua030.cmd.VLUA030CMD&S_MODE=SAV";
                trT_EV_ADJRATE.post();

            } else {
                return;
            }

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

            // 엑셀로 변환 할 자료가 있는지 체크하고
            // 자료를 엑셀로 저장(시트 명만 바꿔 주세요)

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

            //이곳에 해당 코딩을 입력 하세요

        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_ADJRATE.IsUpdated)  {
                if (!fnc_ExitQuestion()) return;
            }

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            if (document.form1.selEVL_YY_SHR.value != year) {
                alert("현재년도 이외의 자료는 저장 및 수정할 수 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_06');
                document.form1.selEVL_YY_SHR.focus();
                return false;
            }

            if (!dsT_EV_ADJRATE.IsUpdated) {
                alert("저장할 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
            }

            var temp;

            //합계가 100인지 여부 체크
            for (i=1;i<=dsT_EV_ADJRATE.CountRow;i++){
                temp = 0;

                // 성과
                for (j=1; j<=4; j++){

                    temp = temp + eval("dsT_EV_ADJRATE.NameValue("+i+", 'ACH_0"+j+"')");
                }

                // 역량
                for (j=1; j<=4; j++){

                    temp = temp + eval("dsT_EV_ADJRATE.NameValue("+i+", 'ABL_0"+j+"')");

                }

                if(temp != 0 && temp != 100){
                    alert(dsT_EV_ADJRATE.NameValue(i,"COMM_NM")+" 그룹의 합이 100이 아닙니다.");
                    document.form1.grdT_EV_ADJRATE.SetColumn("ACH_01");//set focus
                    return false;
                } else if(temp == 100){
                    dsT_EV_ADJRATE.NameValue(i,"TOTAL") = 100;
                } else if(temp == 0){
                    dsT_EV_ADJRATE.NameValue(i,"TOTAL") = 0;
                }
            }

            return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            cfStyleGrid(form1.grdT_EV_ADJRATE,0,"true","false");      // Grid Style 적용

            getSelYy2('selEVL_YY_SHR');                //SelectBox년도 Setting

            // 업무구분
            if (frameid == "vlua030") {
                // 인사평가
                GUBUN = "01";
                document.getElementById("loctitle").innerText = "HOME/인사평가/평가기준정보/";
            }
            else {
                // 직무평가
                GUBUN = "02";
                document.getElementById("loctitle").innerText = "HOME/교육관리/직무평가/평가기준정보/";
            }

            document.form1.txtGUBUN.value = GUBUN;

            fnc_SearchList();                          //기본으로 조회
            document.form1.grdT_EV_ADJRATE.SetColumn("ACH_01");

        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }

        /***************************************
         * 16. Form이 Active 될 때 처리 할 일  *
         **************************************/
        function fnc_FormActive(strID, winstat) {

            if (winstat == "activate") {
                fnc_SearchList();
            }   //Form이 Active 될 때 마다 재조회 처리

        }

		//전년도 기준 복사
        function fnc_Yearcopy(){

   			if( ! confirm("전년도 기준을 복사하시겠습니까?") ){
				return false;
			}

	        var tempYear = document.form1.selEVL_YY_SHR.value;

            //평가 반영 비율 데이터 유무 조회
            dsT_EV_ADJRATE_01.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua030.cmd.VLUA030CMD&S_MODE=SHR_04&GUBUN="+GUBUN+"&EVL_YY="+tempYear;
            dsT_EV_ADJRATE_01.reset();

        }

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회용 DataSet                             |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_TYPE)      |
    | 3. 사용되는 Table List(T_EV_TYPE)             |
    +----------------------------------------------->
    <Object ID="dsT_EV_TYPE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 조회 및 저장용 DataSet                         |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ADJRATE)       |
    | 3. 사용되는 Table List(T_CM_COMMON, T_EV_ADJRATE) |
    +--------------------------------------------------->
    <Object ID="dsT_EV_ADJRATE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 조회 및 저장용 DataSet                         |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ADJRATE)       |
    | 3. 사용되는 Table List(T_CM_COMMON, T_EV_ADJRATE) |
    +--------------------------------------------------->
    <Object ID="dsT_EV_ADJRATE_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton            |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_ADJRATE)       |
    | 3. 사용되는 Table List(T_EV_ADJRATE, T_EV_TYPE)   |
    +--------------------------------------------------->
    <Object ID ="trT_EV_ADJRATE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="sample_tr01(O:VLUA010=dsT_EV_TYPE,O:VLUA030=dsT_EV_ADJRATE,I:VLUA030=dsT_EV_ADJRATE)">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_EV_ADJRATE_01                   |
    | 3. Table List : T_EV_ADJRATE                  |
    +----------------------------------------------->
    <Object ID ="trT_EV_ADJRATE_01" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_EV_TYPE Event="OnLoadCompleted(iCount)">

        var tempYear = document.form1.selEVL_YY_SHR.value;
        if (iCount < 1)    {

            alert(tempYear+"년도 평가구조설정을 완료하신 후에\n\n평가반영비율설정이 가능합니다.");
            dsT_EV_ADJRATE.ClearAll();
            document.getElementById("resultMessage").innerText = "* "+tempYear+"년도 평가구조설정 후 작업하세요.";

        } else {

            if(dsT_EV_TYPE.NameValue(1,"ABL_CNT") == 1) {
                grdT_EV_ADJRATE.ColumnProp('ABL_02','Show') = false;
                grdT_EV_ADJRATE.ColumnProp('ABL_03','Show') = false;
                grdT_EV_ADJRATE.ColumnProp('ABL_04','Show') = false;
            } else if(dsT_EV_TYPE.NameValue(1,"ABL_CNT") == 2) {
                grdT_EV_ADJRATE.ColumnProp('ABL_02','Show') = true;
                grdT_EV_ADJRATE.ColumnProp('ABL_03','Show') = false;
                grdT_EV_ADJRATE.ColumnProp('ABL_04','Show') = false;
            } else if(dsT_EV_TYPE.NameValue(1,"ABL_CNT") == 3) {
                grdT_EV_ADJRATE.ColumnProp('ABL_02','Show') = true;
                grdT_EV_ADJRATE.ColumnProp('ABL_03','Show') = true;
                grdT_EV_ADJRATE.ColumnProp('ABL_04','Show') = false;
            } else if(dsT_EV_TYPE.NameValue(1,"ABL_CNT") == 4) {
                grdT_EV_ADJRATE.ColumnProp('ABL_02','Show') = true;
                grdT_EV_ADJRATE.ColumnProp('ABL_03','Show') = true;
                grdT_EV_ADJRATE.ColumnProp('ABL_04','Show') = true;
            }

            if(dsT_EV_TYPE.NameValue(1,"ACH_CNT") == 1) {
                grdT_EV_ADJRATE.ColumnProp('ACH_02','Show') = false;
                grdT_EV_ADJRATE.ColumnProp('ACH_03','Show') = false;
                grdT_EV_ADJRATE.ColumnProp('ACH_04','Show') = false;
            } else if(dsT_EV_TYPE.NameValue(1,"ACH_CNT") == 2) {
                grdT_EV_ADJRATE.ColumnProp('ACH_02','Show') = true;
                grdT_EV_ADJRATE.ColumnProp('ACH_03','Show') = false;
                grdT_EV_ADJRATE.ColumnProp('ACH_04','Show') = false;
            } else if(dsT_EV_TYPE.NameValue(1,"ACH_CNT") == 3) {
                grdT_EV_ADJRATE.ColumnProp('ACH_02','Show') = true;
                grdT_EV_ADJRATE.ColumnProp('ACH_03','Show') = true;
                grdT_EV_ADJRATE.ColumnProp('ACH_04','Show') = false;
            } else if(dsT_EV_TYPE.NameValue(1,"ACH_CNT") == 4) {
                grdT_EV_ADJRATE.ColumnProp('ACH_02','Show') = true;
                grdT_EV_ADJRATE.ColumnProp('ACH_03','Show') = true;
                grdT_EV_ADJRATE.ColumnProp('ACH_04','Show') = true;
            }

            //평가 구조 설정 그리드 Setting 후 해당 자료 조회
            dsT_EV_ADJRATE.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua030.cmd.VLUA030CMD&S_MODE=SHR_02&GUBUN="+GUBUN+"&EVL_YY="+tempYear;
            dsT_EV_ADJRATE.reset();

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_TYPE Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_TYPE Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ADJRATE Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            alert("평가 그룹 정보 설정 후 해당 작업을 실행 하세요.");


        } else {

            //해당년도에 대한 데이터가 없을경우
            if (dsT_EV_ADJRATE.NameValue(1,"EVL_YY") == '') {
                fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
            }
            else {    //해당년도에 대한 데이터가 있을경우

                if(dsT_EV_TYPE.NameValue(1,"ABL_CNT") == 1) {
                    for(i=1;i<dsT_EV_ADJRATE.CountRow+1;i++) {
                        if(dsT_EV_ADJRATE.NameValue(i,'ABL_02') != 0) dsT_EV_ADJRATE.NameValue(i,'ABL_02') = 0;
                        if(dsT_EV_ADJRATE.NameValue(i,'ABL_03') != 0) dsT_EV_ADJRATE.NameValue(i,'ABL_03') = 0;
                        if(dsT_EV_ADJRATE.NameValue(i,'ABL_04') != 0) dsT_EV_ADJRATE.NameValue(i,'ABL_04') = 0;
                    }
                } else if(dsT_EV_TYPE.NameValue(1,"ABL_CNT") == 2) {
                    for(i=1;i<dsT_EV_ADJRATE.CountRow+1;i++) {
                        if(dsT_EV_ADJRATE.NameValue(i,'ABL_03') != 0) dsT_EV_ADJRATE.NameValue(i,'ABL_03') = 0;
                        if(dsT_EV_ADJRATE.NameValue(i,'ABL_04') != 0) dsT_EV_ADJRATE.NameValue(i,'ABL_04') = 0;
                    }
                } else if(dsT_EV_TYPE.NameValue(1,"ABL_CNT") == 3) {
                    for(i=1;i<dsT_EV_ADJRATE.CountRow+1;i++) {
                        if(dsT_EV_ADJRATE.NameValue(i,'ABL_04') != 0) dsT_EV_ADJRATE.NameValue(i,'ABL_04') = 0;
                    }
                }

                if(dsT_EV_TYPE.NameValue(1,"ACH_CNT") == 1) {
                    for(i=1;i<dsT_EV_ADJRATE.CountRow+1;i++) {
                        if(dsT_EV_ADJRATE.NameValue(i,'ACH_02') != 0) dsT_EV_ADJRATE.NameValue(i,'ACH_02') = 0;
                        if(dsT_EV_ADJRATE.NameValue(i,'ACH_03') != 0) dsT_EV_ADJRATE.NameValue(i,'ACH_03') = 0;
                        if(dsT_EV_ADJRATE.NameValue(i,'ACH_04') != 0) dsT_EV_ADJRATE.NameValue(i,'ACH_04') = 0;
                    }
                }
                else if(dsT_EV_TYPE.NameValue(1,"ACH_CNT") == 2) {
                    for(i=1;i<dsT_EV_ADJRATE.CountRow+1;i++) {
                        if(dsT_EV_ADJRATE.NameValue(i,'ACH_03') != 0) dsT_EV_ADJRATE.NameValue(i,'ACH_03') = 0;
                        if(dsT_EV_ADJRATE.NameValue(i,'ACH_04') != 0) dsT_EV_ADJRATE.NameValue(i,'ACH_04') = 0;
                    }
                }
                else if(dsT_EV_TYPE.NameValue(1,"ACH_CNT") == 3) {
                    for(i=1;i<dsT_EV_ADJRATE.CountRow+1;i++) {
                        if(dsT_EV_ADJRATE.NameValue(i,'ACH_04') != 0) dsT_EV_ADJRATE.NameValue(i,'ACH_04') = 0;
                    }
                }


                fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
            }
            document.form1.grdT_EV_ADJRATE.focus();

        }

    </Script>

    <Script For=dsT_EV_ADJRATE_01 Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {

			if( ! confirm("기존데이터가 존재합니다. 계속 하시겠습니까?") ){
				return false;
			}

        }

        var tempYear = document.form1.selEVL_YY_SHR.value;

		//트랜잭션 체크를 위해 임시생성
        dsT_EV_ADJRATE_01.AddRow();

		//트랜잭션 전송
		trT_EV_ADJRATE_01.KeyValue = "SVL(I:dsT_EV_ADJRATE_01=dsT_EV_ADJRATE_01)";
		trT_EV_ADJRATE_01.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua030.cmd.VLUA030CMD&S_MODE=SAV_01&GUBUN="+GUBUN+"&EVL_YY="+tempYear;
		trT_EV_ADJRATE_01.Post();

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ADJRATE Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <Script For=dsT_EV_ADJRATE_01 Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ADJRATE Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_ADJRATE_01 Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_ADJRATE event="OnSuccess()">

        //저장 후 해당 자료 재 조회
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');

    </script>

    <script for=trT_EV_ADJRATE_01 event="OnSuccess()">

        //저장 후 해당 자료 재 조회
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_ADJRATE event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=trT_EV_ADJRATE_01 event="OnFail()">
        cfErrorMsg(this);
    </script>


<!--
***********************************************************************
* BODY START
***********************************************************************
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">평가반영비율설정</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">평가반영비율설정</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgYearcopy','','/images/button/btn_YearcopyOver.gif',1)"><img src="/images/button/btn_YearcopyOn.gif" name="imgYearcopy"    width="110" height="20" border="0" align="absmiddle" onClick="fnc_Yearcopy();"></a>
            &nbsp;&nbsp;
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                            <tr>
                                <input type="hidden" name="txtGUBUN" id="txtGUBUN">
                                <td align="center" class="searchBold">해당년도</td>
                                <td>
                                    <select id="selEVL_YY_SHR" name="selEVL_YY_SHR" onChange="fnc_SearchList();" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                    </select>
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
                        <object id="grdT_EV_ADJRATE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"                  value="dsT_EV_ADJRATE">
                            <param name="Format"                  value="
                                <C> id='COMM_NM'      width=150   name='평가그룹'   align=left    Edit=none</C>
                                <G> name='성과평가' HeadBgColor='#F7DCBB'>
                                    <C> id='ACH_01'   width=70    name='1회'        align=right   EditLimit=3</C>
                                    <C> id='ACH_02'   width=70    name='2회'        align=right   EditLimit=3</C>
                                    <C> id='ACH_03'   width=70    name='3회'        align=right   EditLimit=3    Show=false</C>
                                    <C> id='ACH_04'   width=70    name='4회'        align=right   EditLimit=3    Show=false</C>
                                </G>
                                <G> name='역량평가' HeadBgColor='#F7DCBB'>
                                    <C> id='ABL_01'   width=70    name='1회'        align=right   EditLimit=3</C>
                                    <C> id='ABL_02'   width=70    name='2회'        align=right   EditLimit=3    Show=false</C>
                                    <C> id='ABL_03'   width=70    name='3회'        align=right   EditLimit=3    Show=false</C>
                                    <C> id='ABL_04'   width=70    name='4회'        align=right   EditLimit=3    Show=false</C>
                                </G>
                                <C> id='TOTAL'        width=70    name='합계(%)'    Value={(ACH_01+ACH_02+ACH_03+ACH_04+ABL_01+ABL_02+ABL_03+ABL_04)} align=right  Edit=none</C>
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