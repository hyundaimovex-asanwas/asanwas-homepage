<!--
    ************************************************************************************
    * @Source         : vluc141.jsp                                                    *
    * @Description    : 참조평가입력 PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/06  |  오대성   | 최초작성                                               *
    * 2006/10/10  |  박인이   | 개발                                                   *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>참조평가입력(vluc141)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

<%
    String GUBUN     = request.getParameter("GUBUN");          //업무구분
    String EVL_YY    = request.getParameter("EVL_YY");         //해당년도
    String EVL_FRQ   = request.getParameter("EVL_FRQ");        //회차
    String ENO_NO    = request.getParameter("ENO_NO");         //사번
    String EVLENO_NO = request.getParameter("EVLENO_NO");      //평가자사번
    String REFENO_NO = request.getParameter("REFENO_NO");      //참조평가자사번
    String REF_GBN   = request.getParameter("REF_GBN");        //참조평가자차수
%>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        var EVL_GBN = "2";    // 성과평가
        var btnList = 'FFTFFFFT';

        var GUBUN = "";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var EVL_YY     = form1.txtEVL_YY_SHR.value.trim();
            var EVL_FRQ    = form1.txtEVL_FRQ_SHR.value.trim();
            var ENO_NO     = form1.txtENO_NO_SHR.value.trim();
            var EVLENO_NO  = form1.txtEVLENO_NO_SHR.value.trim();
            var REFENO_NO  = form1.txtREFENO_NO_SHR.value.trim();
            var GBN        = form1.txtGBN_SHR.value.trim();

            form1.txtFLAG.value = "1"; // 조회FLAG

            trT_EV_ACHTBL.KeyValue = "tr01(O:SHR=dsT_EV_EVLIST_HD,O:SHR2=dsT_EV_ACHTBL,O:SHR3=dsT_EV_ACHPNT)";
            trT_EV_ACHTBL.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc141.cmd.VLUC141CMD&S_MODE=SHR&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO+"&DEGREE_GBN=1"+"&EVLENO_NO="+EVLENO_NO+"&GBN="+GBN+"&REFENO_NO="+REFENO_NO;
            trT_EV_ACHTBL.post();

            if (dsT_EV_ACHTBL.CountRow == 0)    {

                form1.txtTOT_PNT.value  = 0;
                form1.txtTOT_PNT2.value = 0;

            } else {

                if (form1.txtREF_GBN_SHR.value == "1") {
                    form1.txtTOT_PNT.value  = dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("REF1_ACHCVT"),0,0) +
                                              dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("REF1_DIFCVT"),0,0);
                    form1.txtTOT_PNT2.value = dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("REF1_ACHCVT"),0,0) +
                                              dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("REF1_DIFCVT"),0,0);
                }
                else if (form1.txtREF_GBN_SHR.value == "2") {
                    form1.txtTOT_PNT.value  = dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("REF2_ACHCVT"),0,0) +
                                              dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("REF2_DIFCVT"),0,0);
                    form1.txtTOT_PNT2.value = dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("REF2_ACHCVT"),0,0) +
                                              dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("REF2_DIFCVT"),0,0);
                }
                else if (form1.txtREF_GBN_SHR.value == "3") {
                    form1.txtTOT_PNT.value  = dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("REF3_ACHCVT"),0,0) +
                                              dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("REF3_DIFCVT"),0,0);
                    form1.txtTOT_PNT2.value = dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("REF3_ACHCVT"),0,0) +
                                              dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("REF3_DIFCVT"),0,0);
                }
            }

            form1.grdT_EV_ACHTBL.Focus();

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

            // 저장시 각 필드의 유효성체크
            if (!fnc_SaveItemCheck()) {
                return;
            }

            form1.txtFLAG.value = "2"; // 조회FLAG

            trT_EV_ACHTBL.KeyValue = "tr01(I:SAV=dsT_EV_ACHTBL)";
            trT_EV_ACHTBL.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc141.cmd.VLUC141CMD&S_MODE=SAV";
            trT_EV_ACHTBL.post();

            dsT_EV_ACHTBL.UseChangeInfo = "true";

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

            if (dsT_EV_ACHTBL.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_EV_ACHTBL.GridToExcel("참조평가입력", '', 225);

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

            var REF_GBN = form1.txtREF_GBN_SHR.value;

            // DataSet의 변경 여부 확인
            if ( !dsT_EV_ACHTBL.IsUpdated ) {

                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;

            }

            // 달성율에 NULL 값이 존재하는지 CHECK
            if (REF_GBN == '1') {

                for (var i = 1; i <= dsT_EV_ACHTBL.CountRow; i++) {
                    if (dsT_EV_ACHTBL.NameValue(i, "REF1_ACHRAT").trim() == "") {
                        alert("달성율은 필수 입력항목입니다.");

                        form1.grdT_EV_ACHTBL.SetColumn("REF1_ACHRAT");
                        dsT_EV_ACHTBL.RowPosition = i;
                        form1.grdT_EV_ACHTBL.Focus();

                        return false;
                    }
                }
            }
            else if (REF_GBN == '2') {

                for (var i = 1; i <= dsT_EV_ACHTBL.CountRow; i++) {
                    if (dsT_EV_ACHTBL.NameValue(i, "REF2_ACHRAT").trim() == "")  {
                        alert("달성율은 필수 입력항목입니다.");

                        form1.grdT_EV_ACHTBL.SetColumn("REF2_ACHRAT");
                        dsT_EV_ACHTBL.RowPosition = i;
                        form1.grdT_EV_ACHTBL.Focus();

                        return false;
                    }
                }
            }
            else if (REF_GBN == '3') {

                for (var i = 1; i <= dsT_EV_ACHTBL.CountRow; i++) {
                    if (dsT_EV_ACHTBL.NameValue(i, "REF3_ACHRAT").trim() == "")  {
                        alert("달성율은 필수 입력항목입니다.");

                        form1.grdT_EV_ACHTBL.SetColumn("REF3_ACHRAT");
                        dsT_EV_ACHTBL.RowPosition = i;
                        form1.grdT_EV_ACHTBL.Focus();

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

            var REF_GBN = "<%=REF_GBN  %>";

            //Grid Style 적용
            cfStyleGrid(form1.grdT_EV_ACHTBL,0,"true","false");
            cfStyleGrid2(form1.grdT_EV_AIMSUB);

            Colid = window.dialogArguments;

            form1.txtEVL_YY_SHR.value    = "<%=EVL_YY   %>";
            form1.txtEVL_FRQ_SHR.value   = "<%=EVL_FRQ  %>";
            form1.txtENO_NO_SHR.value    = "<%=ENO_NO   %>";
            form1.txtEVLENO_NO_SHR.value = "<%=EVLENO_NO%>";
            form1.txtREFENO_NO_SHR.value = "<%=REFENO_NO%>";
            form1.txtREF_GBN_SHR.value   = "<%=REF_GBN  %>";

            // 업무구분
            if ("<%=GUBUN%>" == "01") {
                // 인사평가
                GUBUN = "01";

            }
            else {
                // 직무평가
                GUBUN = "02";

            }

            // 년도 및 회차를 조회하기 위해 COMMON의 YEARMONTHCMD를 사용
            dsT_EV_ESTINFO.dataid = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR01&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=2";
            dsT_EV_ESTINFO.reset();

            // 해당 참조평가자 차수에 따라 관련 컬럼 보여줌
            fnc_Disp_RefColumn(REF_GBN);

            // 그리드에 성과평가표정보 데이터 조회
            fnc_SearchList();

        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_EV_ACHTBL.IsUpdated)
            {
                if (!fnc_ExitQuestion()) return;
            }

            window.close();

        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /***************************************
         * 일괄반영버튼 클릭시 작업 처리 부분  *
         **************************************/
        function fnc_BatchBtn() {

            var REF_GBN = form1.txtREF_GBN_SHR.value;
            var ACHDEF = "";
            var ACHRAT = "";
            var ACHPNT = "";
            var ACHCVT = "";
            var DIFPNT = "";
            var DIFCVT = "";

            if (REF_GBN == "1") {
                ACHDEC = "REF1_ACHDEC";
                ACHRAT = "REF1_ACHRAT";
                ACHPNT = "REF1_ACHPNT";
                ACHCVT = "REF1_ACHCVT";
                DIFPNT = "REF1_DIFPNT";
                DIFCVT = "REF1_DIFCVT";
            }
            else if (REF_GBN == "2") {
                ACHDEC = "REF2_ACHDEC";
                ACHRAT = "REF2_ACHRAT";
                ACHPNT = "REF2_ACHPNT";
                ACHCVT = "REF2_ACHCVT";
                DIFPNT = "REF2_DIFPNT";
                DIFCVT = "REF2_DIFCVT";
            }
            else if (REF_GBN == "3") {
                ACHDEC = "REF3_ACHDEC";
                ACHRAT = "REF3_ACHRAT";
                ACHPNT = "REF3_ACHPNT";
                ACHCVT = "REF3_ACHCVT";
                DIFPNT = "REF3_DIFPNT";
                DIFCVT = "REF3_DIFCVT";
            }

            for (var i = 1; i <= dsT_EV_ACHTBL.CountRow; i++) {

                // 본인평가의 달성도 및 달성율을 해당 참조평가자평가의 달성도 및 달성율에 복사
                dsT_EV_ACHTBL.NameValue(i, ACHDEC) = dsT_EV_ACHTBL.NameValue(i, "SELF_ACHDEC");
                dsT_EV_ACHTBL.NameValue(i, ACHRAT) = dsT_EV_ACHTBL.NameValue(i, "SELF_ACHRAT");
                dsT_EV_ACHTBL.NameValue(i, ACHPNT) = dsT_EV_ACHTBL.NameValue(i, "SELF_ACHPNT");
                dsT_EV_ACHTBL.NameValue(i, ACHCVT) = dsT_EV_ACHTBL.NameValue(i, "SELF_ACHCVT");
                dsT_EV_ACHTBL.NameValue(i, DIFPNT) = dsT_EV_ACHTBL.NameValue(i, "SELF_DIFPNT");
                dsT_EV_ACHTBL.NameValue(i, DIFCVT) = dsT_EV_ACHTBL.NameValue(i, "SELF_DIFCVT");

            }

        }

        /*****************************************************
         * 구분필드 값 변경시 그리드 컬럼 SETTING 처리 부분  *
         ****************************************************/
        function fnc_Disp_RefColumn(REF_GBN) {

            // 참조평가차수에 따라 그리드에서 참조평가자컬럼 1, 2, 3를 보여주거나, 보이지 않게 막는다.
            // 참조평가 1차
            if (REF_GBN == '1') {

                // 1차
                form1.grdT_EV_ACHTBL.ColumnProp("REF1_ACHDEC", "Show") = "true";
                form1.grdT_EV_ACHTBL.ColumnProp("REF1_ACHRAT", "Show") = "true";
                form1.grdT_EV_ACHTBL.ColumnProp("REF1_ACHPNT", "Show") = "true";
                form1.grdT_EV_ACHTBL.ColumnProp("REF1_ACHCVT", "Show") = "true";
                form1.grdT_EV_ACHTBL.ColumnProp("REF1_DIFPNT", "Show") = "true";
                form1.grdT_EV_ACHTBL.ColumnProp("REF1_DIFCVT", "Show") = "true";
                form1.grdT_EV_ACHTBL.ColumnProp("REF1_PNT",    "Show") = "true";

                // 2차
                form1.grdT_EV_ACHTBL.ColumnProp("REF2_ACHDEC", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF2_ACHRAT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF2_ACHPNT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF2_ACHCVT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF2_DIFPNT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF2_DIFCVT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF2_PNT",    "Show") = "false";

                // 3차
                form1.grdT_EV_ACHTBL.ColumnProp("REF3_ACHDEC", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF3_ACHRAT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF3_ACHPNT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF3_ACHCVT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF3_DIFPNT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF3_DIFCVT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF3_PNT",    "Show") = "false";

            }
            // 참조평가 2차
            else if (REF_GBN == '2') {

                // 1차
                form1.grdT_EV_ACHTBL.ColumnProp("REF1_ACHDEC", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF1_ACHRAT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF1_ACHPNT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF1_ACHCVT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF1_DIFPNT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF1_DIFCVT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF1_PNT",    "Show") = "false";

                // 2차
                form1.grdT_EV_ACHTBL.ColumnProp("REF2_ACHDEC", "Show") = "true";
                form1.grdT_EV_ACHTBL.ColumnProp("REF2_ACHRAT", "Show") = "true";
                form1.grdT_EV_ACHTBL.ColumnProp("REF2_ACHPNT", "Show") = "true";
                form1.grdT_EV_ACHTBL.ColumnProp("REF2_ACHCVT", "Show") = "true";
                form1.grdT_EV_ACHTBL.ColumnProp("REF2_DIFPNT", "Show") = "true";
                form1.grdT_EV_ACHTBL.ColumnProp("REF2_DIFCVT", "Show") = "true";
                form1.grdT_EV_ACHTBL.ColumnProp("REF2_PNT",    "Show") = "true";

                // 3차
                form1.grdT_EV_ACHTBL.ColumnProp("REF3_ACHDEC", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF3_ACHRAT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF3_ACHPNT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF3_ACHCVT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF3_DIFPNT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF3_DIFCVT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF3_PNT",    "Show") = "false";

            }
            // 참조평가 3차
            else if (REF_GBN == '3') {

                // 1차
                form1.grdT_EV_ACHTBL.ColumnProp("REF1_ACHDEC", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF1_ACHRAT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF1_ACHPNT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF1_ACHCVT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF1_DIFPNT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF1_DIFCVT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF1_PNT",    "Show") = "false";

                // 2차
                form1.grdT_EV_ACHTBL.ColumnProp("REF2_ACHDEC", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF2_ACHRAT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF2_ACHPNT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF2_ACHCVT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF2_DIFPNT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF2_DIFCVT", "Show") = "false";
                form1.grdT_EV_ACHTBL.ColumnProp("REF2_PNT",    "Show") = "false";

                // 3차
                form1.grdT_EV_ACHTBL.ColumnProp("REF3_ACHDEC", "Show") = "true";
                form1.grdT_EV_ACHTBL.ColumnProp("REF3_ACHRAT", "Show") = "true";
                form1.grdT_EV_ACHTBL.ColumnProp("REF3_ACHPNT", "Show") = "true";
                form1.grdT_EV_ACHTBL.ColumnProp("REF3_ACHCVT", "Show") = "true";
                form1.grdT_EV_ACHTBL.ColumnProp("REF3_DIFPNT", "Show") = "true";
                form1.grdT_EV_ACHTBL.ColumnProp("REF3_DIFCVT", "Show") = "true";
                form1.grdT_EV_ACHTBL.ColumnProp("REF3_PNT",    "Show") = "true";

            }

        }

        function fnc_Disp_RefColumn2() {

            var str_ymd = dsT_EV_ESTINFO.NameValue(1, "EVL_STDT");
            var end_ymd = dsT_EV_ESTINFO.NameValue(1, "EVL_ENDT");
            var str_mm = Number(str_ymd.substring(5,7));
            var end_mm = Number(end_ymd.substring(5,7));

            for(var i=str_mm; i<=end_mm; i++){

                if(i == 1) {
                  form1.grdT_EV_AIMSUB.ColumnProp("JAN_UP", "Show") = "true";
                  form1.grdT_EV_AIMSUB.ColumnProp("JAN_DN", "Show") = "true";
                }

                if(i == 2) {
                  form1.grdT_EV_AIMSUB.ColumnProp("FEB_UP", "Show") = "true";
                  form1.grdT_EV_AIMSUB.ColumnProp("FEB_DN", "Show") = "true";
                }

                if(i == 3) {
                  form1.grdT_EV_AIMSUB.ColumnProp("MAR_UP", "Show") = "true";
                  form1.grdT_EV_AIMSUB.ColumnProp("MAR_DN", "Show") = "true";
                }

                if(i == 4) {
                  form1.grdT_EV_AIMSUB.ColumnProp("APR_UP", "Show") = "true";
                  form1.grdT_EV_AIMSUB.ColumnProp("APR_DN", "Show") = "true";
                }

                if(i == 5) {
                  form1.grdT_EV_AIMSUB.ColumnProp("MAY_UP", "Show") = "true";
                  form1.grdT_EV_AIMSUB.ColumnProp("MAY_DN", "Show") = "true";
                }

                if(i == 6) {
                  form1.grdT_EV_AIMSUB.ColumnProp("JUN_UP", "Show") = "true";
                  form1.grdT_EV_AIMSUB.ColumnProp("JUN_DN", "Show") = "true";
                }

                if(i == 7) {
                  form1.grdT_EV_AIMSUB.ColumnProp("JUL_UP", "Show") = "true";
                  form1.grdT_EV_AIMSUB.ColumnProp("JUL_DN", "Show") = "true";
                }

                if(i == 8) {
                  form1.grdT_EV_AIMSUB.ColumnProp("AUG_UP", "Show") = "true";
                  form1.grdT_EV_AIMSUB.ColumnProp("AUG_DN", "Show") = "true";
                }

                if(i == 9) {
                  form1.grdT_EV_AIMSUB.ColumnProp("SEP_UP", "Show") = "true";
                  form1.grdT_EV_AIMSUB.ColumnProp("SEP_DN", "Show") = "true";
                }

                if(i == 10) {
                  form1.grdT_EV_AIMSUB.ColumnProp("OCT_UP", "Show") = "true";
                  form1.grdT_EV_AIMSUB.ColumnProp("OCT_DN", "Show") = "true";
                }

                if(i == 11) {
                  form1.grdT_EV_AIMSUB.ColumnProp("NOV_UP", "Show") = "true";
                  form1.grdT_EV_AIMSUB.ColumnProp("NOV_DN", "Show") = "true";
                }

                if(i == 12) {
                  form1.grdT_EV_AIMSUB.ColumnProp("DEC_UP", "Show") = "true";
                  form1.grdT_EV_AIMSUB.ColumnProp("DEC_DN", "Show") = "true";
                }

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
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ACHTBL)    |
    | 3. 사용되는 Table List(T_EV_ACHTBL)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_ACHTBL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_AIMSUB)    |
    | 3. 사용되는 Table List(T_EV_AIMSUB)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_AIMSUB" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ACHPNT)    |
    | 3. 사용되는 Table List(T_EV_ACHPNT)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_ACHPNT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_ESTINFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_ACHTBL)    |
    | 3. 사용되는 Table List(T_EV_ACHTBL)           |
    +----------------------------------------------->
    <Object ID ="trT_EV_ACHTBL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EV_ACHTBL)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <script for=dsT_EV_ACHTBL Event=onColumnChanged(row,colid)>

        // 달성율 입력시 총계를 구한다.
        if (form1.txtREF_GBN_SHR.value == "1") {
            form1.txtTOT_PNT.value = dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("REF1_ACHCVT"),0,0) +
                                     dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("REF1_DIFCVT"),0,0);
        }
        else if (form1.txtREF_GBN_SHR.value == "2") {
            form1.txtTOT_PNT.value = dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("REF2_ACHCVT"),0,0) +
                                     dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("REF2_DIFCVT"),0,0);
        }
        else if (form1.txtREF_GBN_SHR.value == "3") {
            form1.txtTOT_PNT.value = dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("REF3_ACHCVT"),0,0) +
                                     dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("REF3_DIFCVT"),0,0);
        }

    </script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ACHTBL Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_EV_ACHTBL.CountRow);

            // 최초등록자가 없다면 데이터가 역량평가표에 없는 정보임을 flag 필드에 SETTING
            if (dsT_EV_ACHTBL.NameValue(1, "IPT_MAN").trim() == "") {

                dsT_EV_ACHTBL.UseChangeInfo = "false";
            }

        }

    </Script>

    <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">

        if (iCount > 0) {

            //평가적용기간에 따라 그리드 조정
            fnc_Disp_RefColumn2();

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ACHTBL Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ACHTBL Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_AIMSUB Event="OnLoadCompleted(iCount)">

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_AIMSUB Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_AIMSUB Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ACHPNT Event="OnLoadCompleted(iCount)">

        var i = 0;
        var ro = "";
        var ru = "";
        var ap = "";

        if (iCount > 0) {

            for (i = 1; i <= iCount; i++) {

                if (i > 5) {
                    return;
                }

                ro = "ro_" + i;
                ru = "ru_" + i;
                ap = "ap_" + i;

                document.getElementById(ro).innerText = dsT_EV_ACHPNT.NameValue(i, "RATE_OVER") + "% ~ ";
                document.getElementById(ru).innerText = dsT_EV_ACHPNT.NameValue(i, "RATE_UNDER") + "%";
                document.getElementById(ap).innerText = dsT_EV_ACHPNT.NameValue(i, "ACH_PNT") + " 점";
            }
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ACHPNT Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ACHPNT Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-- 트랜젝션 성공. -->
    <script for=trT_EV_ACHTBL event="OnSuccess()">

        if (form1.txtFLAG.value == "1") {
            dsT_EV_EVLIST_HD.RowPosition = 1;

            if (form1.txtREF_GBN_SHR.value == '1') {
                form1.txtREFENO_NM_SHR.value = dsT_EV_EVLIST_HD.NameValue(1, "REFENO_NM1");
            }
            else if (form1.txtREF_GBN_SHR.value == '2') {
                form1.txtREFENO_NM_SHR.value = dsT_EV_EVLIST_HD.NameValue(1, "REFENO_NM2");
            }
            else {
                form1.txtREFENO_NM_SHR.value = dsT_EV_EVLIST_HD.NameValue(1, "REFENO_NM3");
            }
        }
        else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_01");

            if (form1.txtREF_GBN_SHR.value == "1") {
                form1.txtTOT_PNT2.value = dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("REF1_ACHCVT"),0,0) +
                                          dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("REF1_DIFCVT"),0,0);
            }
            else if (form1.txtREF_GBN_SHR.value == "2") {
                form1.txtTOT_PNT2.value = dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("REF2_ACHCVT"),0,0) +
                                          dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("REF2_DIFCVT"),0,0);
            }
            else if (form1.txtREF_GBN_SHR.value == "3") {
                form1.txtTOT_PNT2.value = dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("REF3_ACHCVT"),0,0) +
                                          dsT_EV_ACHTBL.Sum(dsT_EV_ACHTBL.ColumnIndex("REF3_DIFCVT"),0,0);
            }

            window.returnValue = new Number(document.getElementById("txtTOT_PNT2").value).toFixed(2);

        }

    </script>

    <!--트랜젝션 실패 -->
    <script for=trT_EV_ACHTBL event="OnFail()">

        cfErrorMsg(this);

    </script>

    <!-----------------------------------------------------------------+
    | 그리드에서 달성율 입력시 평가점수, 환산점수 및 합계 자동 계산    |
    +------------------------------------------------------------------>
    <script language="javascript"  for=grdT_EV_ACHTBL event=OnExit(row,colid,olddata)>

        var flag = 0;

        if (colid == "REF1_ACHRAT" ||
            colid == "REF2_ACHRAT" ||
            colid == "REF3_ACHRAT" ) {

            if (dsT_EV_ACHTBL.NameValue(row, colid) == "") {
                if (colid == "REF1_ACHRAT") {

                    dsT_EV_ACHTBL.NameValue(row, "REF1_ACHPNT") = 0;
                    dsT_EV_ACHTBL.NameValue(row, "REF1_ACHCVT") = 0;
                    dsT_EV_ACHTBL.NameValue(row, "REF1_DIFPNT") = 0;
                    dsT_EV_ACHTBL.NameValue(row, "REF1_DIFCVT") = 0;

                }
                else if (colid == "REF2_ACHRAT") {

                    dsT_EV_ACHTBL.NameValue(row, "REF2_ACHPNT") = 0;
                    dsT_EV_ACHTBL.NameValue(row, "REF2_ACHCVT") = 0;
                    dsT_EV_ACHTBL.NameValue(row, "REF2_DIFPNT") = 0;
                    dsT_EV_ACHTBL.NameValue(row, "REF2_DIFCVT") = 0;

                }
                else if (colid == "REF3_ACHRAT") {

                    dsT_EV_ACHTBL.NameValue(row, "REF3_ACHPNT") = 0;
                    dsT_EV_ACHTBL.NameValue(row, "REF3_ACHCVT") = 0;
                    dsT_EV_ACHTBL.NameValue(row, "REF3_DIFPNT") = 0;
                    dsT_EV_ACHTBL.NameValue(row, "REF3_DIFCVT") = 0;

                }

                return;
            }

            if (dsT_EV_ACHTBL.NameValue(row, colid) < 0) {
                alert("정수로 입력하여 주십시오");
                dsT_EV_ACHTBL.NameValue(row, colid) = olddata;
                dsT_EV_ACHTBL.RowPosition = row;
                return;
            }

            for (var i = 1; i <= dsT_EV_ACHPNT.CountRow; i++) {

                // 입력한 달성율이 해당하는 달성율구간을 찾아 배점을 평가점수에 SET
                if (dsT_EV_ACHPNT.NameValue(i, "RATE_OVER") <= dsT_EV_ACHTBL.NameValue(row, colid) &&
                    dsT_EV_ACHPNT.NameValue(i, "RATE_UNDER") > dsT_EV_ACHTBL.NameValue(row, colid) ) {

                    if (colid == "REF1_ACHRAT") {

                        dsT_EV_ACHTBL.NameValue(row, "REF1_ACHPNT") = dsT_EV_ACHPNT.NameValue(i, "ACH_PNT");
                        dsT_EV_ACHTBL.NameValue(row, "REF1_ACHCVT") = dsT_EV_ACHPNT.NameValue(i, "ACH_PNT") * (dsT_EV_ACHTBL.NameValue(row, "ADDING_PCT") / 100);


                    }
                    else if (colid == "REF2_ACHRAT") {

                        dsT_EV_ACHTBL.NameValue(row, "REF2_ACHPNT") = dsT_EV_ACHPNT.NameValue(i, "ACH_PNT");
                        dsT_EV_ACHTBL.NameValue(row, "REF2_ACHCVT") = dsT_EV_ACHPNT.NameValue(i, "ACH_PNT") * (dsT_EV_ACHTBL.NameValue(row, "ADDING_PCT") / 100);

                    }
                    else if (colid == "REF3_ACHRAT") {

                        dsT_EV_ACHTBL.NameValue(row, "REF3_ACHPNT") = dsT_EV_ACHPNT.NameValue(i, "ACH_PNT");
                        dsT_EV_ACHTBL.NameValue(row, "REF3_ACHCVT") = dsT_EV_ACHPNT.NameValue(i, "ACH_PNT") * (dsT_EV_ACHTBL.NameValue(row, "ADDING_PCT") / 100);

                    }

                    flag = 1;
                    break;

                }
            }

            // 입력한 달성율이 해당하는 달성율구간을 찾지 못한 경우 달성율구간(미만)의 최대값보다 입력된 달성율이 크다면
            if (flag == 0) {
                if (dsT_EV_ACHPNT.NameValue(dsT_EV_ACHPNT.CountRow, "RATE_UNDER") <= dsT_EV_ACHTBL.NameValue(row, colid)) {

                    if (colid == "REF1_ACHRAT") {

                        dsT_EV_ACHTBL.NameValue(row, "REF1_ACHPNT") = dsT_EV_ACHPNT.NameValue(dsT_EV_ACHPNT.CountRow, "ACH_PNT");
                        dsT_EV_ACHTBL.NameValue(row, "REF1_ACHCVT") = dsT_EV_ACHPNT.NameValue(dsT_EV_ACHPNT.CountRow, "ACH_PNT") * (dsT_EV_ACHTBL.NameValue(row, "ADDING_PCT") / 100);

                    }
                    else if (colid == "REF2_ACHRAT") {

                        dsT_EV_ACHTBL.NameValue(row, "REF2_ACHPNT") = dsT_EV_ACHPNT.NameValue(dsT_EV_ACHPNT.CountRow, "ACH_PNT");
                        dsT_EV_ACHTBL.NameValue(row, "REF2_ACHCVT") = dsT_EV_ACHPNT.NameValue(dsT_EV_ACHPNT.CountRow, "ACH_PNT") * (dsT_EV_ACHTBL.NameValue(row, "ADDING_PCT") / 100);

                    }
                    else if (colid == "REF3_ACHRAT") {

                        dsT_EV_ACHTBL.NameValue(row, "REF3_ACHPNT") = dsT_EV_ACHPNT.NameValue(dsT_EV_ACHPNT.CountRow, "ACH_PNT");
                        dsT_EV_ACHTBL.NameValue(row, "REF3_ACHCVT") = dsT_EV_ACHPNT.NameValue(dsT_EV_ACHPNT.CountRow, "ACH_PNT") * (dsT_EV_ACHTBL.NameValue(row, "ADDING_PCT") / 100);

                    }

                }
            }

        }

    </script>

    <script language="javascript"  for=dsT_EV_ACHTBL event=OnRowPosChanged(row)>

        var EVL_YY    = form1.txtEVL_YY_SHR.value;
        var EVL_FRQ   = form1.txtEVL_FRQ_SHR.value;
        var ENO_NO    = form1.txtENO_NO_SHR.value;
        var EVLENO_NO = form1.txtEVLENO_NO_SHR.value;
        var AIM_YMD   = '';
        var AIM_SEQ   = '';

        if (row < 1) return;

        dsT_EV_AIMSUB.ClearData();

        AIM_YMD = dsT_EV_ACHTBL.NameValue(row, "AIM_YMD");
        AIM_SEQ = dsT_EV_ACHTBL.NameValue(row, "AIM_SEQ");

        //데이터셋 전송
        dsT_EV_AIMSUB.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc141.cmd.VLUC141CMD&S_MODE=SHR_02&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_FRQ="+EVL_FRQ+"&AIM_YMD="+AIM_YMD+"&ENO_NO="+ENO_NO+"&EVLENO_NO="+EVLENO_NO+"&AIM_SEQ="+AIM_SEQ;
        dsT_EV_AIMSUB.Reset();

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">참조평가입력</td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgadjust','','/images/button/BatchAdjustOver.gif',1)"><img src="/images/button/BatchAdjustOn.gif" id="imgadjust" name="imgadjust" width="80" height="20" border="0" align="absmiddle" onClick="fnc_BatchBtn()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image8" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="480">
        <table width="480" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="paddingTop3"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                    <strong>피평가자정보 </strong></td>
            </tr>
            <tr>
                <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td height="2" bgcolor="#A4A4A1"></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="480" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                        <colgroup>
                            <col width="90"></col>
                            <col width="380"></col>
                        </colgroup>
                        <tr>
                            <td align="center" height="25" class="creamBold">평가구분</td>
                            <td class="padding2423">
                                <input id=txtEVL_YY_SHR  name=txtEVL_YY_SHR size="4" class="input_ReadOnly" readonly> 년&nbsp;
                                <input id=txtEVL_FRQ_SHR name=txtEVL_FRQ_SHR size="2" class="input_ReadOnly" readonly> 회차
                            </td>
                        </tr>
                        <tr>
                            <td align="center" height="25" class="creamBold">피평가자</td>
                            <td class="padding2423">
                                소속 <input id=txtDPT_NM_SHR name=txtDPT_NM_SHR size="12" class="input_ReadOnly" readonly>&nbsp;&nbsp;
                                사번 <input id=txtENO_NO_SHR name=txtENO_NO_SHR size="10" class="input_ReadOnly" readonly>&nbsp;&nbsp;
                                성명 <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="14" class="input_ReadOnly" readonly>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" class="creamBold">평&nbsp;가&nbsp;자</td>
                            <td class="padding2423">
                                성명 <input id=txtEVLENO_NM_SHR size="12" class="input_ReadOnly" readonly>&nbsp;&nbsp;
                                참조평가자 <input id=txtREFENO_NM_SHR size="12" class="input_ReadOnly" readonly>
                            </td>
                            <!-- Hidden Filed (구분 : '1'이면 참조평가자가 조건임)-->
                            <input type=hidden name=txtGBN_SHR value="1">
                            <input type=hidden id=txtEVLENO_NO_SHR>
                            <input type=hidden name=txtREFENO_NO_SHR>
                            <input type=hidden name=txtREF_GBN_SHR>
                            <input type=hidden name=txtFLAG>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </td>
        <td width="10">&nbsp;</td>
        <td width="310">
        <table width="310" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="paddingTop3"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                    <strong>배점기준 </strong></td>
            </tr>
            <tr>
                <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td height="2" bgcolor="#A4A4A1"></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="310" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                        <colgroup>
                            <col width="105"></col>
                            <col width="50 "></col>
                            <col width="105"></col>
                            <col width="50 "></col>
                        </colgroup>
                        <tr>
                            <td height="25" class="creamBold" align="center"><span id=ro_1 style="width:45;text-align:right">&nbsp;</span>&nbsp;<span id=ru_1 style="width:25;text-align:right">&nbsp;</span>&nbsp;</td>
                            <td class="padding2423">&nbsp;<span id=ap_1>&nbsp;</span></td>
                            <td class="creamBold" align="center"><span id=ro_2 style="width:45;text-align:right">&nbsp;</span>&nbsp;<span id=ru_2 style="width:25;text-align:right">&nbsp;</span>&nbsp;</td>
                            <td class="padding2423">&nbsp;<span id=ap_2>&nbsp;</span></td>
                        </tr>
                        <tr>
                            <td height="25" class="creamBold" align="center"><span id=ro_3 style="width:45;text-align:right">&nbsp;</span>&nbsp;<span id=ru_3 style="width:25;text-align:right">&nbsp;</span>&nbsp;</td>
                            <td class="padding2423">&nbsp;<span id=ap_3>&nbsp;</span></td>
                            <td class="creamBold" align="center"><span id=ro_4 style="width:45;text-align:right">&nbsp;</span>&nbsp;<span id=ru_4 style="width:25;text-align:right">&nbsp;</span>&nbsp;</td>
                            <td class="padding2423">&nbsp;<span id=ap_4>&nbsp;</span></td>
                        </tr>
                        <tr>
                            <td height="25" class="creamBold" align="center"><span id=ro_5 style="width:45;text-align:right">&nbsp;</span>&nbsp;<span id=ru_5 style="width:25;text-align:right">&nbsp;</span>&nbsp;</td>
                            <td class="padding2423">&nbsp;<span id=ap_5>&nbsp;</span></td>
                            <td class="padding2423" colspan="2"><input type=button name=btnACHPNT value="배점상세정보" onClick="fnc_achpntPopup(form1.txtEVL_YY_SHR.value, GUBUN)">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </td>
    </tr>
<table>
<!-- 조건 입력 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width="50%" ><span id="resultMessage">&nbsp;</span></td>
                    <td class="searchState" valign="bottom" align="right">
                    &nbsp;평가점수 계&nbsp;<input id=txtTOT_PNT  name=txtTOT_PNT size="6" style="text-align:right;font-weight:bold;" readonly>
                    <input type=hidden id=txtTOT_PNT2 size="5">
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
                        <object    id="grdT_EV_ACHTBL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:230px;">
                            <param name="DataID"                  value="dsT_EV_ACHTBL">
                            <param name="EdiTABLE"                value="true">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="ColSizing"               value="true">
                            <param name="FixSizing"               value="true">
                            <param name="IndWidth"                value=0>
                            <param name="VIEWSUMMARY"             value=0>
                            <Param name="TranslateKeyDown"        value=1>
                            <param name="Format"                  value="
                                <FC> id='TASK_AIM'                width=125    name='주요핵심과제'   align=left   Edit='None' </FC>
                                <FC> id='TASK_CSF'                width=100    name='핵심성공요소'   align=left   Edit='None' </FC>
                                <FC> id='BASIC_PAR'               width=100    name='KPI(측정방법)'  align=left   Edit='None' </FC>
                                <FC> id='AIM_LEVEL'               width=70    name='목표;(Target)'   align=left   Edit='None' </FC>
                                <FC> id='ADDING_PCT'              width=40    name='가중치'          align=center Edit='None' </FC>
                                <G> name='본인평가' HeadBgColor='#F7DCBB'
                                    <C> id='SELF_ACHDEC'          width=70   name='달성도'           align=left   Edit='None' </C>
                                    <C> id='SELF_ACHRAT'          width=40    name='달성율'          align=right  Edit='None' </C>
                                    <C> id='SELF_PNT'             width=40    name='점수'            align=right  Edit='None' Dec=2 Value={(SELF_ACHCVT+SELF_DIFCVT)}</C>
                                </G>
                                <G> name='참조평가자평가 (1차)' HeadBgColor='#F7DCBB'
                                    <C> id='REF1_ACHDEC'          width=70   name='달성도'           align=left   Edit='true' </C>
                                    <C> id='REF1_ACHRAT'          width=40    name='달성율'          align=right  Edit='true' Edit='Numeric' EditLimit=3</C>
                                    <C> id='REF1_ACHPNT'      width=40    name='평가'            align=right  Edit='None' </C>
                                    <C> id='REF1_ACHCVT'      width=40    name='환산'            align=right  Edit='None' Dec=2 </C>
                                </G>
                                <G> name='참조평가자평가 (2차)' HeadBgColor='#F7DCBB'
                                    <C> id='REF2_ACHDEC'          width=70   name='달성도'           align=left   Edit='true' </C>
                                    <C> id='REF2_ACHRAT'          width=40    name='달성율'          align=right  Edit='true' Edit='Numeric' EditLimit=3</C>
                                    <C> id='REF2_ACHPNT'      width=40    name='평가'            align=right  Edit='None' </C>
                                    <C> id='REF2_ACHCVT'      width=40    name='환산'            align=right  Edit='None' Dec=2 </C>
                                <G> name='참조평가자평가 (3차)' HeadBgColor='#F7DCBB'
                                    <C> id='REF3_ACHDEC'          width=70   name='달성도'           align=left   Edit='true' </C>
                                    <C> id='REF3_ACHRAT'          width=40    name='달성율'          align=right  Edit='true' Edit='Numeric' EditLimit=3</C>
                                    <C> id='REF3_ACHPNT'      width=40    name='평가'            align=right  Edit='None' </C>
                                    <C> id='REF3_ACHCVT'      width=40    name='환산'            align=right  Edit='None' Dec=2 </C>
                                </G>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td class="paddingTop5">
                        <comment id="__NSID__">
                            <object    id="grdT_EV_AIMSUB" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:100px;">
                                <param name="DataID"                    value="dsT_EV_AIMSUB">
                                <param name="EdiTABLE"                  value="true">
                                <param name="DragDropEnable"            value="true">
                                <param name="SortView"                  value="Left">
                                <param name="VIEWSUMMARY"               value=0>
                                <param name="IndWidth"                  value=0>
                                <param name="UsingOneClick"             value="1">
                                <param name="AutoReSizing"              value="true">
                                <param name="ColSelect"                 value="true">
                                <param name="Format"                    value="
                        <C> id='ITEM_DEC'        width=100       name='주요추진항목'     align=Left show=false     color='#EC4A0D'   BgColor='#FEEFEF'       editlimit=200      </C>
                                  <G> name='평가지표(KPI)' HeadBgColor='#F7DCBB'
                                        <C> id='CRITR_S'    width=110        name='S - (110%이상)'      align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_A'    width=180        name='A - (100%~110%미만)' align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_B'    width=180        name='B - (95%~100%미만)'  align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_C'    width=180        name='C - (85%~95%미만)'   align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_D'    width=110        name='D - (85%미만)'       align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
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

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 평가대상자설정 테이블 -->
<object id="bndT_EV_EVLIST_HD" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_EV_EVLIST_HD">
    <Param Name="BindInfo", Value='
        <C>Col=EVL_YY       Ctrl=txtEVL_YY_SHR     Param=value </C>
        <C>Col=EVL_FRQ      Ctrl=txtEVL_FRQ_SHR    Param=value </C>
        <C>Col=ENO_NO       Ctrl=txtENO_NO_SHR     Param=value </C>
        <C>Col=ENO_NM       Ctrl=txtENO_NM_SHR     Param=value </C>
        <C>Col=DPT_NM       Ctrl=txtDPT_NM_SHR     Param=value </C>
        <C>Col=EVLENO_NM    Ctrl=txtEVLENO_NM_SHR  Param=value </C>
    '>
</object>