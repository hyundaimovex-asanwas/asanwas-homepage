<!--
    ************************************************************************************
    * @Source         : vlub050.jsp                                                    *
    * @Description    : 등급조정_역량 PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/29  |  박인이   | 최초작성                                               *
    * 2007/03/16  |  박인이   | 수정. (직무평가업무내용 추가)                          *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>등급조정_역량(vlub050)</title>
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

        // 역량평가
        var EVL_GBN = "1";
        var btnList = 'TFTTTFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var EVL_YY   = form1.cmbEVL_YY_SHR.value;
            var EVL_FRQ  = form1.cmbEVL_FRQ_SHR.value;
            var ENO_NO   = form1.txtENO_NO_SHR.value;
            var DPT_CD   = form1.txtDPT_CD_SHR.value;
            var HEAD_CD  = form1.cmbHEAD_CD_SHR.value;
            var GROUP_CD = form1.cmbGROUP_CD_SHR.value;
            var CHG_CHK  = "0";

            if(form1.chkCHG_CHK_SHR.checked){
                CHG_CHK = "1";
            } else {
                CHG_CHK = "0";
            }

            // 그리드 데이터 조회 시
            form1.txtFLAG.value = "1";

            // 그리드 데이터 조회시
            dsT_EV_ABLRST.ClearData();

            dsT_EV_ABLRST.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub050.cmd.VLUB050CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO+"&DPT_CD="+DPT_CD+"&HEAD_CD="+HEAD_CD+"&GROUP_CD="+GROUP_CD+"&CHG_CHK="+CHG_CHK;
            dsT_EV_ABLRST.Reset();

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            var EVL_YY   = form1.cmbEVL_YY_SHR.value;

            // 그리드 데이터 조회 시
            form1.txtFLAG.value = "1";

            dsT_EV_TYPE.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub050.cmd.VLUB050CMD&S_MODE=SHR_00&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY;
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

            trT_EV_ABLRST.KeyValue = "tr01(I:SAV=dsT_EV_ABLRST)";
            trT_EV_ABLRST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub050.cmd.VLUB050CMD&S_MODE=SAV";
            trT_EV_ABLRST.post();

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

            if (dsT_EV_ABLRST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_EV_ABLRST.GridToExcel("등급조정_역량", '', 225);

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

            var f = document.form1;
            f.txtENO_NO_SHR.value = '';
            f.txtENO_NM_SHR.value = '';
            f.txtDPT_CD_SHR.value = '';
            f.txtDPT_NM_SHR.value = '';
            f.cmbHEAD_CD_SHR.value = '';
            f.cmbGROUP_CD_SHR.value = '';
            document.getElementById("resultMessage").innerText = ' ';
            document.getElementById("Image30").disabled = false;

            // DataSet Clear
            dsT_EV_ABLRST.ClearData();
            dsT_EV_ABLRST2.ClearData();

            document.form1.txtDPT_CD_SHR.focus();

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

            // DataSet의 변경 여부 확인
            if ( !dsT_EV_ABLRST.IsUpdated ) {

                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;

            }

            for( i = 1; i <= dsT_EV_ABLRST.CountRow; i++ ) {
                if( dsT_EV_ABLRST.RowStatus(i) == 1 ||
                    dsT_EV_ABLRST.RowStatus(i) == 3 ) {
                    // 등급
                    if( dsT_EV_ABLRST.NameValue(i, "CHANGE_GRD") == '' ) {
                        alert("등급은 필수 입력사항입니다.");
                        dsT_EV_ABLRST.RowPosition = i;
                        form1.grdT_EV_ABLRST.SetColumn("CHANGE_GRD");
                        form1.grdT_EV_ABLRST.focus();
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
            cfStyleGrid(form1.grdT_EV_ABLRST,15,"true","false");

            // DATASET 초기화
            fnc_Clear();

            getSelYy('cmbEVL_YY_SHR');

            //본부코드
            for( var i = 1; i <= dsCOMMON_B2.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_B2.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_B2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbHEAD_CD_SHR").add(oOption);

            }

            // 업무구분
            if (frameid == "vlub050") {
                // 인사평가
                GUBUN = "01";

                //평가그룹
                for( var i = 1; i <= dsCOMMON_EG.CountRow; i++ ) {

                    oOption       = document.createElement("OPTION");
                    oOption.value = dsCOMMON_EG.NameValue(i,"CODE");
                    oOption.text  = dsCOMMON_EG.NameValue(i,"CODE_NAME");
                    document.getElementById("cmbGROUP_CD_SHR").add(oOption);

                }

                document.getElementById("loctitle").innerText = "HOME/인사평가/역량평가/";

            }
            else {
                // 직무평가
                GUBUN = "02";

                var tempDS = fnc_GetDutyCd('DUTY2', '4');
                var oOption;

                for( i=1; i<=tempDS.CountRow; i++ ) {
                    oOption = document.createElement("OPTION");
                    oOption.value = tempDS.NameValue(i,"COMM_CD");
                    oOption.text = tempDS.NameValue(i,"COMM_NM");
                    document.getElementById("cmbGROUP_CD_SHR").add(oOption);
                }

                document.getElementById("loctitle").innerText = "HOME/교육관리/직무평가/역량평가/";

            }


            // Form Load 시
            form1.txtFLAG.value = "0";

            dsT_EV_ESTINFO.ClearData();

            // 년도 및 회차를 조회하기 위해 COMMON의 YEARMONTHCMD를 사용
            dsT_EV_ESTINFO.dataid = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=1";
            dsT_EV_ESTINFO.reset();

        }


        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {
            if (dsT_EV_ABLRST.IsUpdated)
            {
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


        /***************************************
         * 조정점수적용버튼 클릭시 작업 처리 부분  *
         **************************************/
        function fnc_CreateBatch() {

            var EVL_YY   = form1.cmbEVL_YY_SHR.value;
            var EVL_FRQ  = form1.cmbEVL_FRQ_SHR.value;

            form1.txtFLAG.value = "2";

            if(!confirm("기존에 적용된 등급 조정 자료는 모두 초기화 됩니다.\n\n그래도 적용 하시겠습니까?")) return;

            dsT_EV_ABLRST2.ClearData();

            // 역량평가표의 존재여부 체크
            dsT_EV_ABLRST2.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub050.cmd.VLUB050CMD&S_MODE=SHR_03&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_FRQ="+EVL_FRQ;
            dsT_EV_ABLRST2.Reset();


        }

        /****************************************
         * 검색부의 필드 변경시 관련컬럼 초기화 *
         ***************************************/
        function fnc_FldChange() {

            if (document.getElementById("txtENO_NO_SHR").value == '') {
                document.getElementById("txtENO_NM_SHR").value = '';
            }

            if (document.getElementById("txtDPT_CD_SHR").value == '') {
                document.getElementById("txtDPT_NM_SHR").value = '';
            }

        }

        /*****************************************************
         * 구분필드 값 변경시 그리드 컬럼 SETTING 처리 부분  *
         ****************************************************/
        function fnc_ChangeDEGREE_GBN() {

            UP_YN    = dsT_EV_TYPE.NameValue(1, "UP_YN");
            DOWN_YN  = dsT_EV_TYPE.NameValue(1, "DOWN_YN");
            UP_CNT   = dsT_EV_TYPE.NameValue(1, "UP_CNT");
            DOWN_CNT = dsT_EV_TYPE.NameValue(1, "DOWN_CNT");

            if (DOWN_YN == 1) {
                // 하향평가차수 만큼 컬럼을 보여줌
                if (DOWN_CNT == 1) {
                    form1.grdT_EV_ABLRST.ColumnProp("DNPNT_01", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("DNCVT_01", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("DNPNT_02", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("DNCVT_02", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("DNPNT_03", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("DNCVT_03", "Show") = "false";
                }
                else if (DOWN_CNT == 2) {
                    form1.grdT_EV_ABLRST.ColumnProp("DNPNT_01", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("DNCVT_01", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("DNPNT_02", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("DNCVT_02", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("DNPNT_03", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("DNCVT_03", "Show") = "false";
                }
                else if (DOWN_CNT == 3) {
                    form1.grdT_EV_ABLRST.ColumnProp("DNPNT_01", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("DNCVT_01", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("DNPNT_02", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("DNCVT_02", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("DNPNT_03", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("DNCVT_03", "Show") = "true";
                }
            }
            else {

                if (dsT_EV_TYPE.CountRow > 0) {
                    form1.grdT_EV_ABLRST.ColumnProp("DNPNT_01", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("DNCVT_01", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("DNPNT_02", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("DNCVT_02", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("DNPNT_03", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("DNCVT_03", "Show") = "false";
                }
                else {
                    form1.grdT_EV_ABLRST.ColumnProp("DNPNT_01", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("DNCVT_01", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("DNPNT_02", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("DNCVT_02", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("DNPNT_03", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("DNCVT_03", "Show") = "false";
                }

            }

            if (UP_YN == 1) {
                // 상향평가차수 만큼 컬럼을 보여줌
                if (UP_CNT == 1) {
                    form1.grdT_EV_ABLRST.ColumnProp("UPPNT_01", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("UPCVT_01", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("UPPNT_02", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("UPCVT_02", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("UPPNT_03", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("UPCVT_03", "Show") = "false";
                }
                else if (UP_CNT == 2) {
                    form1.grdT_EV_ABLRST.ColumnProp("UPPNT_01", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("UPCVT_01", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("UPPNT_02", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("UPCVT_02", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("UPPNT_03", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("UPCVT_03", "Show") = "false";
                }
                else if (UP_CNT == 3) {
                    form1.grdT_EV_ABLRST.ColumnProp("UPPNT_01", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("UPCVT_01", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("UPPNT_02", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("UPCVT_02", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("UPPNT_03", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("UPCVT_03", "Show") = "true";
                }
            }
            else {
                if (dsT_EV_TYPE.CountRow > 0) {
                    form1.grdT_EV_ABLRST.ColumnProp("UPPNT_01", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("UPCVT_01", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("UPPNT_02", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("UPCVT_02", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("UPPNT_03", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("UPCVT_03", "Show") = "false";
                }
                else {
                    form1.grdT_EV_ABLRST.ColumnProp("UPPNT_01", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("UPCVT_01", "Show") = "true";
                    form1.grdT_EV_ABLRST.ColumnProp("UPPNT_02", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("UPCVT_02", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("UPPNT_03", "Show") = "false";
                    form1.grdT_EV_ABLRST.ColumnProp("UPCVT_03", "Show") = "false";
                }
            }

            form1.txtDOWN_YN.value = DOWN_YN;
            form1.txtUP_YN.value   = UP_YN;

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
    <Object ID="dsT_EV_ABLRST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_EVLIST_HD) |
    | 3. 사용되는 Table List(T_EV_EVLIST_HD)        |
    +----------------------------------------------->
    <Object ID="dsT_EV_ABLRST2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ESTINFO)   |
    | 3. 사용되는 Table List(T_EV_ESTINFO)          |
    +----------------------------------------------->
    <Object ID="dsT_EV_ESTINFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_EVLIST_HD) |
    | 3. 사용되는 Table List(T_EV_EVLIST_HD)        |
    +----------------------------------------------->
    <Object ID ="trT_EV_ABLRST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EV_ABLRST)">
    </Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 본부코드 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_B2"/>
       <jsp:param name="CODE_GUBUN"    value="B2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 평가그룹 -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_EG"/>
       <jsp:param name="CODE_GUBUN"    value="EG"/>
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
    <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            alert("평가기간 및 평가회차설정이\n되어있지 않습니다.");
            document.getElementById("resultMessage").innerText = '* 평가기간 및 평가회차설정이 되어있지 않습니다.';

            dsT_EV_TYPE.ClearData();
            dsT_EV_ABLRST.ClearData();
            dsT_EV_ABLRST2.ClearData();
        }
        else {

            form1.cmbEVL_YY_SHR.value = dsT_EV_ESTINFO.NameValue(1, "EVL_YY");

            dsT_EV_TYPE.ClearData();

            dsT_EV_TYPE.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub050.cmd.VLUB050CMD&S_MODE=SHR_00&GUBUN="+GUBUN+"&EVL_YY="+form1.cmbEVL_YY_SHR.value;
            dsT_EV_TYPE.Reset();

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ESTINFO Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>


    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_TYPE Event="OnLoadCompleted(iCount)">

        var oOption;
        var Index = document.getElementById("cmbEVL_FRQ_SHR").length;

        if (iCount == 0)    {

            //조회 자료가 1건 이상일 때 처리 할 내용 코딩
            //회차
            //기존의 회차콤보 데이터 모두삭제
            for( var i = Index; i >= 0; i--){

                form1.cmbEVL_FRQ_SHR.options.remove(i);

            }

            oOption = document.createElement("OPTION");
            oOption.value = 1;
            oOption.text  = '1회';
            document.getElementById("cmbEVL_FRQ_SHR").add(oOption);

        }
        else {

            //조회 자료가 1건 이상일 때 처리 할 내용 코딩
            //회차
            //기존의 회차콤보 데이터 모두삭제
            for( var i = Index; i >= 0; i--){

                form1.cmbEVL_FRQ_SHR.options.remove(i);

            }

            //역량평가회수
            for( i = 1; i<= Number(dsT_EV_TYPE.NameValue(1,"ABL_CNT")); i++ ) {
                oOption = document.createElement("OPTION");
                oOption.value = i;
                oOption.text  = i+'회';
                document.getElementById("cmbEVL_FRQ_SHR").add(oOption);
            }

            form1.cmbEVL_FRQ_SHR.value = dsT_EV_ESTINFO.NameValue(1, "EVL_FRQ");

        }

        // 구분값에 따라 그리드에 역량평가/성과평가 관련 컬럼이 보여진다.
        fnc_ChangeDEGREE_GBN();

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_TYPE Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ABLRST Event="OnLoadCompleted(iCount)">

        var CHIEP_GRD  = dsT_EV_ABLRST.NameValue(1, "CHIEP_GRD");
        var FEEDBK_GBN = dsT_EV_ABLRST.NameValue(1, "FEEDBK_GBN");

        if (iCount == 0)    {

            if (form1.txtFLAG.value == "2") {
                document.getElementById("resultMessage").innerText = '* 조정점수 반영이 실패하였습니다.';
                alert('조정점수 반영이 실패하였습니다.\n평가자료가 존재하는지 확인바랍니다.');
            }
            else {
                fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            }

            form1.cmbEVL_YY_SHR.focus();

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_EV_ABLRST.CountRow);

            // 본부장등급조정_역량된 경우
            if (CHIEP_GRD.trim() != "") {

                form1.grdT_EV_ABLRST.ColumnProp('CHANGE_GRD', 'Edit') = 'None';
                form1.grdT_EV_ABLRST.Editable = "false";
                document.getElementById("Image30").disabled = true;

                // 본부장등급확정된 경우
                if (FEEDBK_GBN.trim() == "T") {

                    alert("본부장 등급 조정이 확정되었으므로 수정 불가합니다.");
                }
                else {

                    alert("본부장 등급 조정이 되었으므로 수정 불가합니다.");
                }
            }
            else {

                form1.grdT_EV_ABLRST.ColumnProp('CHANGE_GRD', 'Edit') = 'true';
                form1.grdT_EV_ABLRST.Editable = "true";
                document.getElementById("Image30").disabled = false;
            }

            if (form1.txtFLAG.value == "2") {

                // 본부장등급조정_역량된 경우
                if (CHIEP_GRD.trim() == "") {
                    document.getElementById("resultMessage").innerText = '* 조정점수 반영이 완료되었습니다.';
                }

            }

            form1.grdT_EV_ABLRST.Focus();
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ABLRST2 Event="OnLoadCompleted(iCount)">

        var EVL_YY   = form1.cmbEVL_YY_SHR.value;
        var EVL_FRQ  = form1.cmbEVL_FRQ_SHR.value;
        var GROUP_CD = form1.cmbGROUP_CD_SHR.value;

        if (iCount > 0) {
            for (var i = 1; i <= iCount; i++) {
                // 구분 '1'(비율에 대한 등급별비율 여부)이면
                if (dsT_EV_ABLRST2.NameValue(i, "GBN") == "1"  && dsT_EV_ABLRST2.NameValue(i, "VAL") == "0") {
                    alert("비율에 대한 등급별배분율이 미존재합니다.\n등급별배분율설정 데이터를 확인하신 후 작업하시기 바랍니다.");
                    return;
                }
                // 구분 '2'(역량평가작성표)이면
                else if (dsT_EV_ABLRST2.NameValue(i, "GBN") == "2" && dsT_EV_ABLRST2.NameValue(i, "VAL") == "0") {
                    alert("역량평가를 작성한 데이터가 미존재합니다.\n역량평가 데이터를 확인하신 후 작업하시기 바랍니다.");
                    return;
                }
            }

            dsT_EV_ABLRST.ClearData();

            // 조정점수반영
            dsT_EV_ABLRST.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub050.cmd.VLUB050CMD&S_MODE=SHR_02&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&GROUP_CD="+GROUP_CD;
            dsT_EV_ABLRST.Reset();

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLRST2 Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ABLRST2 Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


    <!-- 트랜젝션 성공. -->
    <script for=trT_EV_ABLRST event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--트랜젝션 실패 -->
    <script for=trT_EV_ABLRST event="OnFail()">

        cfErrorMsg(this);

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">등급조정_역량</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">등급조정_역량</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
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
                                <col width="35"></col>
                                <col width="20"></col>
                                <col width="30"></col>
                                <col width="20"></col>
                                <col width="55"></col>
                                <col width="110"></col>
                                <col width="30"></col>
                                <col width="100"></col>
                                <col width="30"></col>
                                <col width="110"></col>
                                <col width="27"></col>
                                <col width="142"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">년도</td>
                                <td class="padding2423">
                                    <select id="cmbEVL_YY_SHR" name="cmbEVL_YY_SHR" onChange="JavaScript: fnc_SearchItem();" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                    </select>
                                </td>
                                <td align="right" class="searchState">회차</td>
                                <td class="padding2423">
                                    <select id=cmbEVL_FRQ_SHR onChange="fnc_SearchList()" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                    </select> </td>
                                </td>
                                <td align="right" class="searchState">평가그룹</td>
                                <td class="padding2423">
                                    <select id="cmbGROUP_CD_SHR" name="cmbGROUP_CD_SHR" style="WIDTH: 100%" onChange="fnc_SearchList()" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                        <option value="">전 체</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">본부</td>
                                <td class="padding2423">
                                    <select name="cmbHEAD_CD_SHR" style="WIDTH: 100%" onChange="fnc_SearchList()" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                        <option value="">전 체</option>
                                    </select> </td>
                                </td>
                                <td align="right" class="searchState">소속</td>
                                <td class="padding2423"><input name=txtDPT_CD_SHR size="2"  maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_FldChange()"> <input name=txtDPT_NM_SHR size="6" class="input_ReadOnly" readonly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image20" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')"></a>
                                </td>
                                <td align="right" class="searchState">사번</td>
                                <td class="padding2423"><input name=txtENO_NO_SHR size="8"  maxlength="10" style="ime-mode:disabled" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList(); cfNumberCheck();" onChange="fnc_FldChange()"> <input name=txtENO_NM_SHR size="6" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
                                </td>
                            <!-- Hidden Filed -->
                            <input type=hidden name=txtDOWN_YN>
                            <input type=hidden name=txtUP_YN>
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
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width="77%"><span id="resultMessage">&nbsp;</span></td>
                    <td align="right" class="searchState">
                        <input type="checkbox" name="chkCHG_CHK_SHR" id=chkCHG_CHK_SHR style="border:0" align="absmiddle" onClick="fnc_SearchList()">조정인원
                    </td>
                    <td align="right">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image30','','/images/button/AdjustApplyOver.gif',1)"><img src="/images/button/AdjustApplyOn.gif" id="Image30" name="Image30" width="100" height="20" border="0" align="absmiddle" onClick="fnc_CreateBatch()"></a>
                    </td>
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
                        <object    id="grdT_EV_ABLRST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"                  value="dsT_EV_ABLRST">
                            <param name="EdiTABLE"                value="true">
                            <param name="DragDropEnable"          value="true">
                            <param name="ColSizing"               value="true">
                            <param name="FixSizing"               value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <FC> id='GROUP_NM'    width=70    name='평가그룹'     sort=true align=left   Edit=None </FC>
                                <FC> id='HEAD_NM'     width=80    name='본부'         sort=true align=left   Edit=None </FC>
                                <FC> id='DPT_NM'      width=70    name='소속'         sort=true align=left   Edit=None </FC>
                                <FC> id='JOB_NM'      width=40    name='직위'         sort=true align=left   Edit=None </FC>
                                <FC> id='ENO_NO'      width=60    name='사번'         sort=true align=center Edit=None </FC>
                                <FC> id='ENO_NM'      width=55    name='성명'         sort=true align=center Edit=None </FC>
                                <G> name='역량 1차평가' HeadBgColor='#F7DCBB'
                                    <C> id='DNPNT_01' width=60    name='원점수'       align=right Edit=None</C>
                                    <C> id='DNCVT_01' width=60    name='환산점수'     align=right Edit=None</C>
                                </G>
                                <G> name='역량 2차평가' HeadBgColor='#F7DCBB'
                                    <C> id='DNPNT_02' width=60    name='원점수'       align=right Edit=None</C>
                                    <C> id='DNCVT_02' width=60    name='환산점수'     align=right Edit=None</C>
                                </G>
                                <G> name='역량 3차평가' HeadBgColor='#F7DCBB'
                                    <C> id='DNPNT_03' width=60    name='원점수'       align=right Edit=None</C>
                                    <C> id='DNCVT_03' width=60    name='환산점수'     align=right Edit=None</C>
                                </G>
                                <G> name='상향 1차평가' HeadBgColor='#F7DCBB'
                                    <C> id='UPPNT_01' width=60    name='원점수'       align=right Edit=None</C>
                                    <C> id='UPCVT_01' width=60    name='환산점수'     align=right Edit=None</C>
                                </G>
                                <G> name='상향 2차평가' HeadBgColor='#F7DCBB'
                                    <C> id='UPPNT_02' width=60    name='원점수'       align=right Edit=None</C>
                                    <C> id='UPCVT_02' width=60    name='환산점수'     align=right Edit=None</C>
                                </G>
                                <G> name='상향 3차평가' HeadBgColor='#F7DCBB'
                                    <C> id='UPPNT_03' width=60    name='원점수'       align=right Edit=None</C>
                                    <C> id='UPCVT_03' width=60    name='환산점수'     align=right Edit=None</C>
                                </G>
                                <C> id='FINAL_PNT'    width=40    name='최종;점수'    sort=true align=right  Edit=None </C>
                                <C> id='RNUM'         width=30    name='순위'         sort=true align=center Edit=None </C>
                                <C> id='ORIGINAL_GRD' width=40    name='등급'         sort=true align=center Edit=None EditStyle=Combo Data='S,A,B,C,D'</C>
                                <C> id='CHANGE_GRD'   width=39    name='조정;등급'    sort=true align=center Edit=true EditStyle=Combo Data='S,A,B,C,D' bgcolor={Decode(CHANGE_GRD,ORIGINAL_GRD,'#FFFFFF',NULL,'#FFFFFF','#F2AC47')}</C>
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