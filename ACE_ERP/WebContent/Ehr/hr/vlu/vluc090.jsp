<!--
    ************************************************************************************
    * @Source         : vluc090.jsp                                                    *
    * @Description    : 목표수정 PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/12/12  |  박인이   | 최초작성                                               *
    * 2007/03/17  |  박인이   | 수정. (직무평가업무내용 추가)                          *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>목표수정(vluc090)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

<%
    String MOD       = request.getParameter("MOD");           //자기평가진행정보 구분
    String GUBUN     = request.getParameter("GUBUN");         //업무구분
    String ENO_NO    = request.getParameter("ENO_NO");        //평가자사번
%>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        // 성과평가
        var EVL_GBN = "2";
        var btnList = 'TFTFFFFT';
        var aim_gbn = '';

        //모달창으로 띄웠을 경우 구분하기 위해 사용 by DS
        var modal_yn = window.dialogArguments;

        var GUBUN   = "";
        var OBJ_STDT = '';
        var OBJ_ENDT = '';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var EVL_YY    = form1.txtEVL_YY_SHR.value;
            var EVL_FRQ   = form1.txtEVL_FRQ_SHR.value;
            var ENO_NO    = form1.txtENO_NO_SHR.value;
            var EVLENO_NO = form1.cmbEVLENO_NO_SHR.value;

            // DATASET 초기화
            fnc_Clear();

            // 이전목표 조회
            dsT_EV_AIMLST_ORG.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc090.cmd.VLUC090CMD&S_MODE=SHR&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO+"&EVLENO_NO="+EVLENO_NO;
            dsT_EV_AIMLST_ORG.Reset();

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
            var EVL_YY    = form1.txtEVL_YY_SHR.value;
            var EVL_FRQ   = form1.txtEVL_FRQ_SHR.value;
            var ENO_NO    = form1.txtENO_NO_SHR.value;
            var EVLENO_NO = form1.cmbEVLENO_NO_SHR.value;
            var AIM_YMD   = form1.txtAIM_YMD.value;

            // 저장시 각 필드의 유효성체크
            if (!fnc_SaveItemCheck()) {
                return;
            }

            trT_EV_AIMLST.KeyValue = "tr01(I:SAV=dsT_EV_AIMLST)";
            trT_EV_AIMLST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc090.cmd.VLUC090CMD&S_MODE=SAV&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO+"&EVLENO_NO="+EVLENO_NO;
            trT_EV_AIMLST.post();

            dsT_EV_AIMLST.UseChangeInfo = "true";

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

            if (dsT_EV_AIMLST.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_EV_AIMLST.GridToExcel("목표수정", '', 225);

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

            document.getElementById("resultMessage").innerText = ' ';

            form1.txtAIM_YMD.value    = '';
            form1.txtRETURN_DEC.value = '';
            form1.txtMODIFY_DEC.value = '';
            form1.txtTOT_ADDING_PCT.value = '';

            // DataSet Clear
            dsT_EV_AIMLST.ClearData();
            dsT_EV_AIMLST_ORG.ClearData();

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
            var aim_seq  = 0;
            var item_seq = 0;

            // DataSet의 변경 여부 확인
            if ( !dsT_EV_AIMLST.IsUpdated ) {

                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;

            }

            if (dsT_EV_AIMLST.CountRow != 0 && form1.txtTOT_ADDING_PCT.value != 100) {
                document.getElementById("resultMessage").innerText = "* 가중치의 합계가 100 이어야 합니다!!!";
                alert("가중치의 합계가 100 이어야 합니다!!!");
                return false;
            }

            if (form1.txtAIM_YMD.value == "") {
                alert("수정일자는 필수입력항목입니다.");

                form1.txtAIM_YMD.focus();
                return false;
            }

            if (form1.txtMODIFY_DEC.value == "") {
                alert("수정사유는 필수입력항목입니다.");

                form1.txtMODIFY_DEC.focus();
                return false;
            }

            // 변경사항이 존재하면 모든 row 상태를 insert로 변경함
            dsT_EV_AIMLST.UseChangeInfo = "false";

            for (var i = 1; i <= dsT_EV_AIMLST.CountRow; i++) {

                if (dsT_EV_AIMLST.NameValue(i, "AIM_GBN") == 'L') {
                    aim_seq  = aim_seq + 1;
                    item_seq = 1;
                }

                dsT_EV_AIMLST.NameValue(i, "AIM_SEQ") = aim_seq;

                if (dsT_EV_AIMLST.NameValue(i, "ITEM_DEC") != '') {
                    dsT_EV_AIMLST.NameValue(i, "ITEM_SEQ") = item_seq;
                    item_seq = item_seq + 1;

                }

                if( dsT_EV_AIMLST.RowStatus(i) == 1 || dsT_EV_AIMLST.RowStatus(i) == 3 ) {
                  if( dsT_EV_AIMLST.NameValue(i,"GAUGE_GB") == '1' ) {
                    if( dsT_EV_AIMLST.NameValue(i,"CRITR_S") == '' )
                        dsT_EV_AIMLST.NameValue(i,"CRITR_S") = '110% 이상';
                    if( dsT_EV_AIMLST.NameValue(i,"CRITR_A") == '' )
                        dsT_EV_AIMLST.NameValue(i,"CRITR_A") = '100% 이상 ~110% 미만';
                    if( dsT_EV_AIMLST.NameValue(i,"CRITR_B") == '' )
                        dsT_EV_AIMLST.NameValue(i,"CRITR_B") = '95% 이상 ~100% 미만';
                    if( dsT_EV_AIMLST.NameValue(i,"CRITR_C") == '' )
                        dsT_EV_AIMLST.NameValue(i,"CRITR_C") = '85% 이상 ~ 95% 미만';
                    if( dsT_EV_AIMLST.NameValue(i,"CRITR_D") == '' )
                        dsT_EV_AIMLST.NameValue(i,"CRITR_D") = '85% 미만';
				 } else {
                    if( dsT_EV_AIMLST.NameValue(i,"CRITR_S") == '' )
                        dsT_EV_AIMLST.NameValue(i,"CRITR_S") = '기대치를 매우 상회 / 유사한 업무와 실적비교시 탁월';
                    if( dsT_EV_AIMLST.NameValue(i,"CRITR_A") == '' )
                        dsT_EV_AIMLST.NameValue(i,"CRITR_A") = '기대치를 상회 / 유사한 업무와 실적비교시 우수';
                    if( dsT_EV_AIMLST.NameValue(i,"CRITR_B") == '' )
                        dsT_EV_AIMLST.NameValue(i,"CRITR_B") = '기대치를 만족.충족 / 유사한 업무와 실적비교시 보통';
                    if( dsT_EV_AIMLST.NameValue(i,"CRITR_C") == '' )
                        dsT_EV_AIMLST.NameValue(i,"CRITR_C") = '기대치를 약간 미달 / 유사한 업무와 실적비교시 미흡';
                    if( dsT_EV_AIMLST.NameValue(i,"CRITR_D") == '' )
                        dsT_EV_AIMLST.NameValue(i,"CRITR_D") = '기대치를 매우 미달 / 유사한 업무와 실적비교시 부족';
				 }
                }

                dsT_EV_AIMLST.NameValue(i, "AIM_YMD") = form1.txtAIM_YMD.value;
                dsT_EV_AIMLST.NameValue(i, "MODIFY_DEC") = form1.txtMODIFY_DEC.value;
            }

            return true;

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            var EVL_YY  = null;

            //Grid Style 적용
            cfStyleGrid2(form1.grdT_EV_AIMLST_ORG);
            form1.grdT_EV_AIMLST_ORG.Editable = 'false';
            form1.grdT_EV_AIMLST_ORG.ColSelect = true;
            form1.grdT_EV_AIMLST_ORG.IndWidth  = 0;

            cfStyleGrid2(form1.grdT_EV_AIMLST);
            form1.grdT_EV_AIMLST.ColSelect = true;
            form1.grdT_EV_AIMLST.IndWidth  = 0;

            if (modal_yn == null) {
                var frameid = window.external.GetFrame(window).FrameId;
            }

            // 업무구분
            if (frameid == "vluc090" || "<%=GUBUN%>" == "01") {
                // 인사평가
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/인사평가/성과평가/";

            }
            else {
                // 직무평가
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/교육관리/직무평가/성과평가/";
            }

            // 년도 및 회차를 조회하기 위해 COMMON의 YEARMONTHCMD를 사용
            dsT_EV_ESTINFO.dataid = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=2";
            dsT_EV_ESTINFO.reset();

        }


        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_EV_AIMLST.IsUpdated)
            {
                if (!fnc_ExitQuestion()) return;
            }

            if(modal_yn != null){
                window.close();
            } else {
                frame = window.external.GetFrame(window);
                frame.CloseFrame();
            }

        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }


        /************************
         * 목표추가 버튼 클릭시 *
         ************************/
        function fnc_InsertAimLst() {
            var TASK_AIM      = '';
            var BASIC_PAR     = '';
            var GAUGE_GB      = '';
            var AIM_LEVEL     = '';
            var ADDING_PCT    = '';
            var TASK_CSF = '';
            var ITEM_DEC      = '';
            var CountRow = dsT_EV_AIMLST.CountRow + 1;

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_EV_AIMLST.CountColumn == 0) {

                alert("먼저 평가자를 선택, 조회작업을 하신 다음에 목표추가 작업을 하시기 바랍니다.");
                return;
            }
            else {
                TASK_AIM      = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_AIM");
                BASIC_PAR     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "BASIC_PAR");
                GAUGE_GB      = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "GAUGE_GB");
                AIM_LEVEL     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_LEVEL");
                ADDING_PCT    = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ADDING_PCT");
                TASK_CSF = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_CSF");

                for (var i = dsT_EV_AIMLST.RowPosition + 1; i <= CountRow; i++) {

                    if (TASK_AIM      != dsT_EV_AIMLST.NameValue(i, "TASK_AIM")      ||
                        BASIC_PAR     != dsT_EV_AIMLST.NameValue(i, "BASIC_PAR")     ||
                        GAUGE_GB      != dsT_EV_AIMLST.NameValue(i, "GAUGE_GB")      ||
                        AIM_LEVEL     != dsT_EV_AIMLST.NameValue(i, "AIM_LEVEL")     ||
                        ADDING_PCT    != dsT_EV_AIMLST.NameValue(i, "ADDING_PCT")    ||
                        TASK_CSF != dsT_EV_AIMLST.NameValue(i, "TASK_CSF") ) {

                        aim_gbn = 'L';

                        // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
                        dsT_EV_AIMLST.InsertRow(i);
                        dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_GBN") = 'L';      // 목표
                        dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ACCEPT_GBN") = '0';

                        break;

                    }
                }

                if (CountRow == 1) {
                    // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
                    dsT_EV_AIMLST.InsertRow(1);
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_GBN") = 'L';      // 목표
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ACCEPT_GBN") = '0';

                }
            }

            form1.grdT_EV_AIMLST.SetColumn("TASK_AIM");
            form1.grdT_EV_AIMLST.Focus();

            fnc_DisableFld(dsT_EV_AIMLST.RowPosition);

        }

        /************************
         * 목표삭제 버튼 클릭시 *
         ***********************/
        function fnc_DeleteAimLst() {
            var TASK_AIM      = '';
            var BASIC_PAR     = '';
            var GAUGE_GB      = '';
            var AIM_LEVEL     = '';
            var ADDING_PCT    = '';
            var TASK_CSF = '';
            var ITEM_DEC      = '';
            var CNT = 0;
            var TOT_ADDING_PCT = 0;
            var CountRow      = dsT_EV_AIMLST.CountRow;

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_EV_AIMLST.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            if (dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_GBN") != 'L') {
                alert("삭제하고자 하는 목표 레코드를 선택하여 주시기 바랍니다.");
                return;
            }

            TASK_AIM      = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_AIM");
            BASIC_PAR     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "BASIC_PAR");
            GAUGE_GB      = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "GAUGE_GB");
            AIM_LEVEL     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_LEVEL");
            ADDING_PCT    = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ADDING_PCT");
            TASK_CSF = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_CSF");

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("[" + TASK_AIM + "][" + BASIC_PAR + "] 자료를 제거하시겠습니까?") == false) return;

            //dsT_EV_AIMLST.RowPosition = 1;

            for (var i = dsT_EV_AIMLST.RowPosition; i <= CountRow; i++) {

                if (TASK_AIM      == dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_AIM")      &&
                    BASIC_PAR     == dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "BASIC_PAR")     &&
                    GAUGE_GB      == dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "GAUGE_GB")      &&
                    AIM_LEVEL     == dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_LEVEL")     &&
                    ADDING_PCT    == dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ADDING_PCT")    &&
                    TASK_CSF == dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_CSF") ) {

                    dsT_EV_AIMLST.DeleteRow(dsT_EV_AIMLST.RowPosition);
                    CNT = 1;

                }
                else {
                    if (CNT == 1) {

                        break;
                    }

                    dsT_EV_AIMLST.RowPosition = dsT_EV_AIMLST.RowPosition + 1;
                }
            }

            // 가중치합계
            for (var i = 1; i <= dsT_EV_AIMLST.CountRow; i++) {

                if (dsT_EV_AIMLST.NameValue(i, "AIM_GBN") == 'L') {

                    TOT_ADDING_PCT = TOT_ADDING_PCT + dsT_EV_AIMLST.NameValue(i, "ADDING_PCT");
                }
            }

            form1.txtTOT_ADDING_PCT.value = TOT_ADDING_PCT;

            if (dsT_EV_AIMLST.CountRow < 1) {
                fnc_Save();
            }
            else {
                // 삭제 후 해당 그리드로 Focus 이동
                form1.grdT_EV_AIMLST.SetColumn("TASK_AIM");
                form1.grdT_EV_AIMLST.Focus();
            }

        }

        /****************************
         * 세부계획추가 버튼 클릭시 *
         ***************************/
        function fnc_InsertAimSub() {
            var TASK_AIM      = '';
            var BASIC_PAR     = '';
            var GAUGE_GB      = '';
            var AIM_LEVEL     = '';
            var ADDING_PCT    = '';
            var TASK_CSF = '';
            var ITEM_DEC      = '';
            var ACCEPT_GBN    = '';
            var RETURN_DEC    = '';

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_EV_AIMLST.CountRow == 0) {

                alert("목표추가를 먼저 하시고, 추진항목 추가작업을 하시기 바랍니다.");

                form1.grdT_EV_AIMLST.focus();
                return;

            }
            else {

                TASK_AIM      = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_AIM");
                BASIC_PAR     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "BASIC_PAR");
                GAUGE_GB      = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "GAUGE_GB");
                AIM_LEVEL     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_LEVEL");
                ADDING_PCT    = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ADDING_PCT");
                TASK_CSF = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_CSF");
                ACCEPT_GBN    = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ACCEPT_GBN");
                RETURN_DEC    = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "RETURN_DEC");

            }

            aim_gbn = 'S';

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_EV_AIMLST.InsertRow(dsT_EV_AIMLST.RowPosition + 1);

            if (dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_GBN") != 'L') {
                dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_GBN")   = 'S';      // 세부
            }
            else {
                return;
            }

            dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_AIM")      = TASK_AIM;
            dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "BASIC_PAR")     = BASIC_PAR;
            dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "GAUGE_GB")      = GAUGE_GB;
            dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_LEVEL")     = AIM_LEVEL;
            dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ADDING_PCT")    = ADDING_PCT;
            dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_CSF") = TASK_CSF;
            dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ACCEPT_GBN")    = ACCEPT_GBN;
            dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "RETURN_DEC")    = RETURN_DEC;

            fnc_DisableFld(dsT_EV_AIMLST.RowPosition);

            form1.grdT_EV_AIMLST.SetColumn("ITEM_DEC");
            form1.grdT_EV_AIMLST.Focus();

        }

        /****************************
         * 세부계획삭제 버튼 클릭시 *
         ***************************/
        function fnc_DeleteAimSub() {
            var TASK_AIM      = '';
            var BASIC_PAR     = '';
            var GAUGE_GB      = '';
            var AIM_LEVEL     = '';
            var ADDING_PCT    = '';
            var TASK_CSF = '';
            var ITEM_DEC      = '';
            var CNT = 0;

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_EV_AIMLST.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            TASK_AIM      = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_AIM");
            BASIC_PAR     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "BASIC_PAR");
            GAUGE_GB      = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "GAUGE_GB");
            AIM_LEVEL     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_LEVEL");
            ADDING_PCT    = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ADDING_PCT");
            TASK_CSF = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_CSF");
            ITEM_DEC      = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ITEM_DEC");

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("[" + TASK_AIM + "][" + BASIC_PAR + "] 목표의 [" + ITEM_DEC + "] 자료를 제거하시겠습니까?") == false) return;

            if (dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_GBN") == 'L') {

                if (dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition + 1, "AIM_GBN") == 'S') {
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition + 1, "AIM_GBN") = 'L';
                    dsT_EV_AIMLST.DeleteRow(dsT_EV_AIMLST.RowPosition);
                }
                else {

                }
            }
            else {
                dsT_EV_AIMLST.DeleteRow(dsT_EV_AIMLST.RowPosition);
            }

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_EV_AIMLST.SetColumn("TASK_AIM");
            form1.grdT_EV_AIMLST.Focus();
        }

        function fnc_DisableFld(Row) {

            // 목표구분이 '목표' 일 때, 입력 가능하도록 함
            if (dsT_EV_AIMLST.NameValue(Row, "AIM_GBN") == 'L') {
                form1.grdT_EV_AIMLST.ColumnProp('TASK_AIM', 'Edit')      = 'true';
                form1.grdT_EV_AIMLST.ColumnProp('BASIC_PAR', 'Edit')     = 'true';
                form1.grdT_EV_AIMLST.ColumnProp('GAUGE_GB', 'Edit')      = 'true';
                form1.grdT_EV_AIMLST.ColumnProp('AIM_LEVEL', 'Edit')     = 'true';
                form1.grdT_EV_AIMLST.ColumnProp('ADDING_PCT', 'Edit')    = 'true';
                form1.grdT_EV_AIMLST.ColumnProp('TASK_CSF', 'Edit') = 'true';

            }
            // 목표구분이 '세부' 일 때, 입력 불가능하도록 함
            else if (dsT_EV_AIMLST.NameValue(Row, "AIM_GBN") == 'S') {
                form1.grdT_EV_AIMLST.ColumnProp('TASK_AIM', 'Edit')      = 'None';
                form1.grdT_EV_AIMLST.ColumnProp('BASIC_PAR', 'Edit')     = 'None';
                form1.grdT_EV_AIMLST.ColumnProp('GAUGE_GB', 'Edit')      = 'None';
                form1.grdT_EV_AIMLST.ColumnProp('AIM_LEVEL', 'Edit')     = 'None';
                form1.grdT_EV_AIMLST.ColumnProp('ADDING_PCT', 'Edit')    = 'None';
                form1.grdT_EV_AIMLST.ColumnProp('TASK_CSF', 'Edit') = 'None';

            }
        }

        function fnc_CopyGrid() {
            var ADDING_PCT = 0;

            // 수정목표 데이터가 존재하면
            if (dsT_EV_AIMLST.CountRow > 0) {
                if(!confirm("목표수정하신 내용이 존재하면 모두 초기화됩니다.\n\n그래도 적용 하시겠습니까?")) return;
            }

            /** 데이터셋 복사 **/
            cfCopyDataSet(dsT_EV_AIMLST_ORG, dsT_EV_AIMLST, "copyHeader=yes");

            if (dsT_EV_AIMLST.CountRow > 0) {

                for (var i = 1; i <= dsT_EV_AIMLST.CountRow; i++) {
                    // 목표설정일자
                    dsT_EV_AIMLST.NameValue(i, "AIM_YMD") = getToday();
                    dsT_EV_AIMLST.NameValue(i, "ACCEPT_GBN") = "0";
                    dsT_EV_AIMLST.NameValue(i, "RETURN_DEC") = "";
                    dsT_EV_AIMLST.NameValue(i, "MODIFY_DEC") = "";

                    // 가중치합계
                    if (dsT_EV_AIMLST.NameValue(i, "AIM_GBN") == 'L') {
                        ADDING_PCT = ADDING_PCT + dsT_EV_AIMLST.NameValue(i, "ADDING_PCT");
                    }
                }

                form1.txtTOT_ADDING_PCT.value = ADDING_PCT;

                document.getElementById("txtAIM_YMD").value = getToday();
                document.getElementById("resultMessage").innerText = '* 일괄반영되었습니다.';
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
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_AIMLST)    |
    | 3. 사용되는 Table List(T_EV_AIMLST)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_AIMLST_ORG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_AIMLST)    |
    | 3. 사용되는 Table List(T_EV_AIMLST)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_AIMLST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_AIMLST)    |
    | 3. 사용되는 Table List(T_EV_AIMLST)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_AIMLST_ORG_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_SCHCHG)    |
    | 3. 사용되는 Table List(T_EV_SCHCHG)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_SCHCHG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

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
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_EVLIST_DT) |
    | 3. 사용되는 Table List(T_EV_EVLIST_DT)        |
    +----------------------------------------------->
    <Object ID="dsT_EV_EVLIST_DT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_AIMLST)    |
    | 3. 사용되는 Table List(T_EV_AIMLST)           |
    +----------------------------------------------->
    <Object ID ="trT_EV_AIMLST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EV_AIMLST)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <script for=dsT_EV_AIMLST Event=onColumnChanged(row,colid)>

        var ADDING_PCT = 0;

        // 가중치합계
        if (colid == 'ADDING_PCT' && dsT_EV_AIMLST.NameValue(row, "AIM_GBN") == 'L') {
            for (var i = 1; i <= dsT_EV_AIMLST.CountRow; i++) {

                if (dsT_EV_AIMLST.NameValue(i, "AIM_GBN") == 'L') {
                    ADDING_PCT = ADDING_PCT + dsT_EV_AIMLST.NameValue(i, "ADDING_PCT");
                }
            }

            form1.txtTOT_ADDING_PCT.value = ADDING_PCT;
        }


        if ((colid == 'GAUGE_GB' || colid == 'AIM_LEVEL') && dsT_EV_AIMLST.NameValue(row, "GAUGE_GB") == '1') {

                 var StrFrom, sufix, StrTo;

                 var EXT_NUM = 0;

			var colStr = dsT_EV_AIMLST.NameValue(row, "AIM_LEVEL");
			var values = colStr.split(" ");

              for( x = 0; x < values.length; x++ ){

					if (values[x] >= "1" && values[x] <= "9"){
						EXT_NUM = values[x].toUnComma();
						//alert("EXT_NUM = "+EXT_NUM);
						break;
				    }
			  }
			if(EXT_NUM == 0){
			   alert("KPI(측정방법) 구분이 '계량'일때 숫자를 공백으로 분리하여 입력 바랍니다.");
               form1.grdT_EV_AIMLST.SetColumn("AIM_LEVEL");
               form1.grdT_EV_AIMLST.Focus();
			}


			if(x+1 < values.length){
            	sufix = values[x+1];
            }else{
                sufix = "";
			}

			StrFrom = "";
			StrTo = String(EXT_NUM * 1.10);
			dsT_EV_AIMLST.NameValue(row, "CRITR_S") = StrTo.toRound(2) + sufix + "이상";

			StrFrom = String(EXT_NUM * 1.00);
			dsT_EV_AIMLST.NameValue(row, "CRITR_A") = StrFrom.toRound(2) + sufix + "이상" +"~"+ StrTo.toRound(2)  + sufix + "미만";

			StrTo   = String(EXT_NUM * 1.00);
			StrFrom = String(EXT_NUM * 0.95);
			dsT_EV_AIMLST.NameValue(row, "CRITR_B") = StrFrom.toRound(2) + sufix + "이상" +"~"+ StrTo.toRound(2)  + sufix + "미만";

			StrTo   = String(EXT_NUM * 0.95);
			StrFrom = String(EXT_NUM * 0.85);
			dsT_EV_AIMLST.NameValue(row, "CRITR_C") = StrFrom.toRound(2) + sufix + "이상" +"~"+ StrTo.toRound(2)  + sufix + "미만";

			dsT_EV_AIMLST.NameValue(row, "CRITR_D") = StrFrom.toRound(2) + sufix + "미만";

        }
    </script>

    <script language=JavaScript for=grdT_EV_AIMLST event=OnClick(row,colid)>
        var T_CHECK = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"T_CHECK");

        // 전체 컬럼 checkbox 클릭시 해당 값이 추진일정 chekbox에 반영
        if( grdT_EV_AIMLST.Editable == true) {
            if (colid == 'T_CHECK' ) {

            }

        }

    </script>

<script language=JavaScript for=grdT_EV_AIMLST event=OnDblClick(row,colid)>

        var colid_1 = '';

        // 추진일정 chekbox를 더블클릭하여 해당 값을 반영
        if( grdT_EV_AIMLST.Editable == true) {

        }

    </script>

    <!-- 그리드의 팝업필드 클릭시 -->
    <script language="javascript" for=grdT_EV_AIMLST event=OnPopup(Row,Colid,data)>

        // KPI POOL 조회
        if ( Colid == 'BASIC_PAR') {

            var obj = new String();

            obj.title = "KPI POOL";
            obj.gbn = "KPI";

            window.showModalDialog("/common/popup/codenm.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            dsT_EV_AIMLST.NameValue(Row,'BASIC_PAR') = obj.comm_nm;

            for (var i = Row + 1; i <= dsT_EV_AIMLST.CountRow; i++) {

                if (dsT_EV_AIMLST.NameValue(i, "AIM_GBN") == 'S') {
                  dsT_EV_AIMLST.NameValue(i, 'BASIC_PAR') = obj.comm_nm;
                }
                else {
                    break;
                }
            }

        }
    </script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_AIMLST Event="OnLoadCompleted(iCount)">

        var ADDING_PCT = 0;

        if (iCount > 0)  {

            form1.txtAIM_YMD.value    = dsT_EV_AIMLST.NameValue(1, "AIM_YMD");
            form1.txtRETURN_DEC.value = dsT_EV_AIMLST.NameValue(1, "RETURN_DEC");
            form1.txtMODIFY_DEC.value = dsT_EV_AIMLST.NameValue(1, "MODIFY_DEC");

            // 가중치합계
            for (var i = 1; i <= iCount; i++) {

                if (dsT_EV_AIMLST.NameValue(i, "AIM_GBN") == 'L') {
                    ADDING_PCT = ADDING_PCT + dsT_EV_AIMLST.NameValue(i, "ADDING_PCT");
                }
            }

            form1.txtTOT_ADDING_PCT.value = ADDING_PCT;

        }

        if (dsT_EV_AIMLST_ORG_02.CountRow > 0)    {

            document.getElementById("resultMessage").innerText = '* 평가작업이 진행중이거나 완료되었습니다.';
            alert("평가작업이 진행중이거나 완료되었습니다.");

            form1.grdT_EV_AIMLST.Editable = 'false';

            document.getElementById("btnINSLST").disabled = true;
            document.getElementById("btnDELLST").disabled = true;

            document.getElementById("image30").disabled   = true;

            document.getElementById("txtAIM_YMD").disabled    = true;
            document.getElementById("image20").disabled       = true;
            document.getElementById("txtMODIFY_DEC").disabled = true;

        }
        else {
            form1.grdT_EV_AIMLST.Editable = 'true';

            document.getElementById("btnINSLST").disabled = false;
            document.getElementById("btnDELLST").disabled = false;

            if (iCount > 0)  {
                document.getElementById("txtAIM_YMD").disabled = true;
                document.getElementById("image20").disabled = true;
                document.getElementById("image30").disabled = true;
            }
            else {
                document.getElementById("txtAIM_YMD").disabled = false;
                document.getElementById("image20").disabled = false;
                document.getElementById("image30").disabled = false;
            }

            // 오늘일자가 목표수정기간사이의 값이면 달성도 및 달성율 입력가능하도록 함
            if (OBJ_STDT <= getToday() && OBJ_ENDT >= getToday()) {
                ;
            }
            else {

                document.getElementById("resultMessage").innerText = '* 목표입력 기간이 아닙니다.';
                form1.grdT_EV_AIMLST.Editable = 'false';

                document.getElementById("btnINSLST").disabled = true;
                document.getElementById("btnDELLST").disabled = true;
                document.getElementById("image30").disabled   = true;

                document.getElementById("txtAIM_YMD").disabled    = true;
                document.getElementById("image20").disabled       = true;
                document.getElementById("txtMODIFY_DEC").disabled = true;

            }

            document.getElementById("txtMODIFY_DEC").disabled = false;
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_AIMLST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_AIMLST Event="OnDataError()">
            var TASK_AIM      = '';
            var BASIC_PAR     = '';
            var GAUGE_GB      = '';
            var AIM_LEVEL     = '';
            var ADDING_PCT    = '';
            var TASK_CSF = '';

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
            if (aim_gbn == 'S' && dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_GBN") == 'L') {
                if (dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_AIM")      != ""  ||
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "BASIC_PAR")     != ""  ||
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "GAUGE_GB")      != ""  ||
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_LEVEL")     != ""  ||
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ADDING_PCT")    != ""  ||
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_CSF") != ""  ||
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ITEM_DEC")      != "" ) {
                    alert("해당 필수입력항목[주요업무목표/성과평가지표/계량구분/목표수준/가중치/난이도/추진항목] 입력 후 다음 작업이 가능합니다.");
                }
                else {
                    alert("목표를 먼저 입력하시고 세부추진계획을 입력하시기 바랍니다.");
                }
            }
            else {

                alert("해당 필수입력항목[주요업무목표/성과평가지표/계량구분/목표수준/가중치/난이도/추진항목] 입력 후 다음 작업이 가능합니다.");
            }
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_AIMLST_ORG Event="OnLoadCompleted(iCount)">
        var ADDING_PCT = 0;

        if (iCount == 0)    {

            document.getElementById("resultMessage").innerText = '* 최종승인된 목표가 없습니다. 목표수정은 최종승인된 자료가 있어야 가능합니다.';
            alert("최종승인된 목표가 없습니다.\n\n목표수정은 최종승인된 자료가 있어야 가능합니다.");

            form1.grdT_EV_AIMLST.Editable = 'false';

            document.getElementById("btnINSLST").disabled = true;
            document.getElementById("btnDELLST").disabled = true;

            document.getElementById("image30").disabled   = true;

            document.getElementById("txtAIM_YMD").disabled    = true;
            document.getElementById("image20").disabled       = true;
            document.getElementById("txtMODIFY_DEC").disabled = true;

        } else {

            // 평가진행여부(평가표자료존재여부) 조회
            dsT_EV_AIMLST_ORG_02.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc090.cmd.VLUC090CMD&S_MODE=SHR_02&GUBUN="+GUBUN+"&EVL_YY="+document.getElementById("txtEVL_YY_SHR").value+"&EVL_FRQ="+document.getElementById("txtEVL_FRQ_SHR").value+"&AIM_YMD=1900-01-01&ENO_NO="+document.getElementById("txtENO_NO_SHR").value+"&EVLENO_NO="+document.getElementById("cmbEVLENO_NO_SHR").value;
            dsT_EV_AIMLST_ORG_02.Reset();
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_AIMLST_ORG Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_AIMLST_ORG Event="OnDataError()">
            var TASK_AIM      = '';
            var BASIC_PAR     = '';
            var GAUGE_GB      = '';
            var AIM_LEVEL     = '';
            var ADDING_PCT    = '';
            var TASK_CSF = '';

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
            if (aim_gbn == 'S' && dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_GBN") == 'L') {
                if (dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_AIM")      != ""  ||
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "BASIC_PAR")     != ""  ||
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "GAUGE_GB")      != ""  ||
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_LEVEL")     != ""  ||
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ADDING_PCT")    != ""  ||
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_CSF") != ""  ||
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ITEM_DEC")      != "" ) {
                    alert("해당 필수입력항목[주요업무목표/성과평가지표/계량구분/목표수준/가중치/난이도/추진항목] 입력 후 다음 작업이 가능합니다.");
                }
                else {
                    alert("목표를 먼저 입력하시고 세부추진계획을 입력하시기 바랍니다.");
                }
            }
            else {

                alert("해당 필수입력항목[주요업무목표/성과평가지표/계량구분/목표수준/가중치/난이도/추진항목] 입력 후 다음 작업이 가능합니다.");
            }
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_AIMLST_ORG_02 Event="OnLoadCompleted(iCount)">

        var EVL_YY    = form1.txtEVL_YY_SHR.value;
        var EVL_FRQ   = form1.txtEVL_FRQ_SHR.value;
        var ENO_NO    = form1.txtENO_NO_SHR.value;
        var EVLENO_NO = form1.cmbEVLENO_NO_SHR.value;
        var AIM_YMD   = '';

        if (iCount > 0) {
            AIM_YMD = dsT_EV_AIMLST_ORG.NameValue(1, "AIM_YMD");
        }
        else {
            AIM_YMD = '1900-01-01';
        }

        // 수정목표 조회
        dsT_EV_AIMLST.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc090.cmd.VLUC090CMD&S_MODE=SHR_03&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_FRQ="+EVL_FRQ+"&AIM_YMD="+AIM_YMD+"&ENO_NO="+ENO_NO+"&EVLENO_NO="+EVLENO_NO;
        dsT_EV_AIMLST.Reset();

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_AIMLST_ORG_02 Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_AIMLST_ORG_02 Event="OnDataError()">

            cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">
        if ( iCount == 0 )    {

            alert("평가적용기간이 아닙니다.");
            document.getElementById("resultMessage").innerText = '* 평가적용기간이 아닙니다.';

            dsT_EV_EVLIST_HD.ClearData();
            dsT_EV_EVLIST_DT.ClearData();
            dsT_EV_AIMLST.ClearData();

        } else {

            form1.txtEVL_YY_SHR.value  = dsT_EV_ESTINFO.NameValue(1, "EVL_YY");
            form1.txtEVL_FRQ_SHR.value = dsT_EV_ESTINFO.NameValue(1, "EVL_FRQ");
            form1.txtENO_NO_SHR.value   = '<%=box.get("SESSION_ENONO")%>';
            form1.txtENO_NM_SHR.value   = '<%=box.get("SESSION_ENONM")%>';
            form1.txtDPT_NM_SHR.value   = '<%=box.get("SESSION_DPTNM")%>';


            // 평가대상자인지 조회
            dsT_EV_EVLIST_HD.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc090.cmd.VLUC090CMD&S_MODE=SHR_04&GUBUN="+GUBUN+"&EVL_YY="+form1.txtEVL_YY_SHR.value+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+form1.txtEVL_FRQ_SHR.value+"&ENO_NO="+form1.txtENO_NO_SHR.value;
            dsT_EV_EVLIST_HD.Reset();
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

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ESTINFO Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_EVLIST_HD Event="OnLoadCompleted(iCount)">

        if ( iCount == 0 )    {

            alert('평가대상자가 아니므로 입력 불가합니다.');
            document.getElementById("resultMessage").innerText = '* 평가대상자가 아니므로 입력 불가합니다.';
            form1.grdT_EV_AIMLST.Editable = 'false';

            document.getElementById("btnINSLST").disabled = true;
            document.getElementById("btnDELLST").disabled = true;

            document.getElementById("image30").disabled   = true;

            document.getElementById("txtAIM_YMD").disabled    = true;
            document.getElementById("image20").disabled       = true;
            document.getElementById("txtMODIFY_DEC").disabled = true;

            dsT_EV_EVLIST_DT.ClearData();
            dsT_EV_AIMLST.ClearData();

        } else {

            // 상단부 데이터 조회
            dsT_EV_SCHCHG.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc090.cmd.VLUC090CMD&S_MODE=SHR_00&GUBUN="+GUBUN+"&EVL_YY="+form1.txtEVL_YY_SHR.value+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+form1.txtEVL_FRQ_SHR.value+"&ENO_NO="+form1.txtENO_NO_SHR.value;
            dsT_EV_SCHCHG.Reset();
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

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_HD Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_SCHCHG Event="OnLoadCompleted(iCount)">

        if ( iCount == 0 )    {

            OBJ_STDT = dsT_EV_ESTINFO.NameValue(1, "OBJ_STDT");
            OBJ_ENDT = dsT_EV_ESTINFO.NameValue(1, "OBJ_ENDT");

        } else {

            if (dsT_EV_SCHCHG.NameValue(1, "OBJ_STDT") == "") {

                OBJ_STDT = dsT_EV_ESTINFO.NameValue(1, "OBJ_STDT");
                OBJ_ENDT = dsT_EV_ESTINFO.NameValue(1, "OBJ_ENDT");

            }
            else {

                OBJ_STDT = dsT_EV_SCHCHG.NameValue(1, "OBJ_STDT");
                OBJ_ENDT = dsT_EV_SCHCHG.NameValue(1, "OBJ_ENDT");
            }
        }

        EVL_YY  = form1.txtEVL_YY_SHR.value;
        EVL_FRQ = form1.txtEVL_FRQ_SHR.value;
        ENO_NO  = form1.txtENO_NO_SHR.value;

        // 평가자명 조회
        dsT_EV_EVLIST_DT.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc090.cmd.VLUC090CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO;
        dsT_EV_EVLIST_DT.Reset();

        // 오늘일자가 목표수정기간사이의 값이면 달성도 및 달성율 입력가능하도록 함
        if (OBJ_STDT <= getToday() && OBJ_ENDT >= getToday()) {

            form1.grdT_EV_AIMLST.Editable = 'true';

            document.getElementById("btnINSLST").disabled = false;
            document.getElementById("btnDELLST").disabled = false;


            fnc_SearchList();

        }
        else {

            // 목표수정은 입력기간과 관계없이 언제든지 입력가능하므로
            // 아래 부분을 막음...
            //alert('목표입력 기간이 아닙니다.');
            //document.getElementById("resultMessage").innerText = '* 목표입력 기간이 아닙니다.';
            //form1.grdT_EV_AIMLST.Editable = 'false';

            //document.getElementById("btnINSLST").disabled = true;
            //document.getElementById("btnDELLST").disabled = true;
            //document.getElementById("btnINSSUB").disabled = true;
            //document.getElementById("btnDELSUB").disabled = true;
            //document.getElementById("image30").disabled   = true;

            //document.getElementById("txtAIM_YMD").disabled    = true;
            //document.getElementById("image20").disabled       = true;
            //document.getElementById("txtMODIFY_DEC").disabled = true;

            fnc_SearchList();

        }


    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_SCHCHG Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_SCHCHG Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_EVLIST_DT Event="OnLoadCompleted(iCount)">

        var oOption;

        if ( iCount != 0 )    {

            for(var i = 0 ; i < iCount ; i++) {

                oOption = document.createElement("OPTION");
                oOption.text  = dsT_EV_EVLIST_DT.NameValue(i + 1, "EVLENO_NM");
                oOption.value = dsT_EV_EVLIST_DT.NameValue(i + 1, "EVLENO_NO");

                document.getElementById("cmbEVLENO_NO_SHR").add(oOption);
            }

            //자기평가진행정보에서 들어왔을경우..
            if( '<%=MOD%>' == '1' ) {

                document.getElementById("cmbEVLENO_NO_SHR").value = "<%=ENO_NO%>";
                document.getElementById("cmbEVLENO_NO_SHR").readOnly = true;
            }
            else {
                document.getElementById("cmbEVLENO_NO_SHR")[0].selected = true;
            }

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_DT Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_DT Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


    <!-- 트랜젝션 성공. (저장) -->
    <script for=trT_EV_AIMLST event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--트랜젝션 실패 -->
    <script for=trT_EV_AIMLST event="OnFail()">

        cfErrorMsg(this);

    </script>


    <script language="javascript"  for=dsT_EV_AIMLST event=OnRowPosChanged(Row)>

        fnc_DisableFld(Row);

     </script>


     <script language="javascript"  for=grdT_EV_AIMLST  event=OnColumnPosChanged(Row,Colid)>

        fnc_DisableFld(Row);

     </script>

    <!---------------------------------------------------------------------------------------------------+
    | 그리드에서 목표 추가시 이미 입력된 값인지 체크 또는 수정시 suppress된 컬럼과 동일하게 하도록 함    |
    +---------------------------------------------------------------------------------------------------->
    <script language="javascript"  for=grdT_EV_AIMLST event=OnExit(row,colid,olddata)>

        if (dsT_EV_AIMLST.NameValue(row, "AIM_GBN") == 'L') {

            if (colid == 'TASK_AIM'      ||
                colid == 'BASIC_PAR'     ||
                colid == 'GAUGE_GB'      ||
                colid == 'AIM_LEVEL'     ||
                colid == 'ADDING_PCT'    ||
                colid == 'TASK_CSF') {

                for (var i = row + 1; i <= dsT_EV_AIMLST.CountRow; i++) {

                    if (dsT_EV_AIMLST.NameValue(i, "AIM_GBN") == 'S') {
                        dsT_EV_AIMLST.NameValue(i, colid) = dsT_EV_AIMLST.NameValue(row, colid);
                    }
                    else {
                        break;
                    }
                }
            }
        }

        dsT_EV_AIMLST.RowPosition = row;

    </script>


    <!---------------------------------------------------------------------------------------------------+
    | 그리드에서 목표 추가시 이미 입력된 값인지 체크 또는 수정시 suppress된 컬럼과 동일하게 하도록 함    |
    +---------------------------------------------------------------------------------------------------->
    <script language=JavaScript for=grdT_EV_AIMLST event=OnCloseUp(row,colid)>

        // 컬럼이 콤보인 경우
        if (dsT_EV_AIMLST.NameValue(row, "AIM_GBN") == 'L') {

            if (colid == 'TASK_AIM'      ||
                colid == 'BASIC_PAR'     ||
                colid == 'GAUGE_GB'      ||
                colid == 'AIM_LEVEL'     ||
                colid == 'ADDING_PCT'    ||
                colid == 'TASK_CSF') {

                for (var i = row + 1; i <= dsT_EV_AIMLST.CountRow; i++) {

                    if (dsT_EV_AIMLST.NameValue(i, "AIM_GBN") == 'S') {
                      dsT_EV_AIMLST.NameValue(i, colid) = dsT_EV_AIMLST.NameValue(row, colid);
                    }
                    else {
                        break;
                    }
                }
            }
        }

        dsT_EV_AIMLST.RowPosition = row;

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">목표수정</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">목표수정</font></td>
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
                                <col width="80 "></col>
                                <col width="40 "></col>
                                <col width="40 "></col>
                                <col width="30 "></col>
                                <col width="40 "></col>
                                <col width="65 "></col>
                                <col width="120 "></col>
                                <col width="75 "></col>
                                <col width="40 "></col>
                                <col width="75 "></col>
                                <col width="65 "></col>
                                <col width="65 "></col>
                                <col width="10"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">해당년도 </td>
                                <td class="padding2423">
                                    <input id=txtEVL_YY_SHR size="4" class="input_ReadOnly" readonly valid='key=true' field='해당년도'>
                                </td>
                                <td align="right" class="searchState">회차 </td>
                                <td class="padding2423">
                                    <input id=txtEVL_FRQ_SHR size="2" class="input_ReadOnly" readonly valid='key=true' field='회차'>
                                </td>
                                <td align="right" class="searchState">소속 </td>
                                <td class="padding2423">
                                    <input id=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">피평가자 사번 </td>
                                <td class="padding2423">
                                    <input id=txtENO_NO_SHR size="10" class="input_ReadOnly" readonly valid='key=true' field='사번'>
                                </td>
                                <td align="right" class="searchState">성명 </td>
                                <td class="padding2423">
                                    <input id=txtENO_NM_SHR size="10" class="input_ReadOnly" readonly>
                                </td>

                                <td align="right" class="searchState">평가자 </td>
                                <td class="padding2423">
                                    <select id=cmbEVLENO_NO_SHR style="width:100" valid='key=true' field='평가자' onChange="fnc_SearchList();" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                    </select>
                                </td>
                                <td align="center" class="padding2423"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- power Search테이블 끝 -->

<!-- 내용 조회 그리드 테이블 시작-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15" width="800" ><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>이전목표 </strong>
        </td>
    </tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_EV_AIMLST_ORG" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:219px;">
                            <param name="DataID"                    value="dsT_EV_AIMLST_ORG">
                            <param name="EdiTABLE"                  value="true">
                            <param name="DragDropEnable"            value="true">
                            <param name="SortView"                  value="Left">
                            <param name="ColSizing"                 value="true">
                            <param name="FixSizing"                 value="true">
                            <param name="IndWidth"                  value=0>
                            <param name="VIEWSUMMARY"               value=0>
                            <Param name="TranslateKeyDown"          value=1>
                            <param name="Format"                    value="
                                <FC> id='AIM_GBN'         width=40       name='목표;구분'        	  align=center    show=false        </FC>
                                <FC> id='EVL_YY'          width=40        name='해당년도'         	  align=center    show=false        </FC>
                                <FC> id='EVL_FRQ'         width=40        name='평가회차'          	  align=center    show=false        </FC>
                                <FC> id='AIM_YMD'         width=40       name='목표설정일자'     	  align=center    show=false        </FC>
                                <FC> id='ENO_NO'          width=40        name='피평가자사번'     	  align=center    show=false        </FC>
                                <FC> id='EVLENO_NO'       width=40        name='평가자사번'       	  align=center    show=false        </FC>
                                <FC> id='AIM_SEQ'         width=50        name='순번'             	  align=center    show=false        value={String(AIM_SEQ)} </FC>
                                <FC> id='TASK_AIM'        width=130       name='주요 핵심과제(업무)'  align=left      color='#087F01'   BgColor='#EEFBEE'       suppress= 5       editlimit=200    </FC>
                                <FC> id='TASK_CSF'        width=130       name='핵심성공 요소(CSF)'   align=left      color='#087F01'   BgColor='#EEFBEE'       suppress= 4       editlimit=200    </FC>
                                <FC> id='BASIC_PAR'       width=130       name='KPI (측정방법)'       align=left      color='#087F01'   BgColor='#EEFBEE'       suppress= 3       editlimit=200 editStyle=Popup   </FC>
                                <FC> id='AIM_LEVEL'        width=100       name='목표 (Target)'       align=left      color='#087F01'   BgColor='#EEFBEE'       suppress= 2       editlimit=100    </FC>
                                <C> id='GAUGE_GB'         width=55        name='계량;구분'        	  align=center    color='#087F01'   BgColor='#EEFBEE'       suppress= 1       editstyle=combo  data='1:계량,2:비계량'   </C>
                                <C> id='ACCEPT_GBN'       width=80        name='목표승인여부'         align=center    show=false        </C>
                                <C> id='ITEM_SEQ'         width=40        name='순번'                 align=center    show=false        edit=none        value={String(ITEM_SEQ)} </C>
                                <C> id='ITEM_DEC'        width=100       name='주요추진항목'     align=Left show=false     color='#EC4A0D'   BgColor='#FEEFEF'       editlimit=200      </C>
                                  <G> name='평가지표(KPI)' HeadBgColor='#F7DCBB'
                                        <C> id='CRITR_S'    width=130        name='S - (110%이상)'      align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_A'    width=130        name='A - (100%~110%미만)' align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_B'    width=130        name='B - (95%~100%미만)'  align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_C'    width=130        name='C - (85%~95%미만)'   align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_D'    width=130        name='D - (85%미만)'       align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
    							   </G>
                                <C> id='ACT_TIM'          width=100       name='실행시기'        	  align=center    color='#087F01'   BgColor='#EEFBEE'       editlimit=50     </C>
                                <C> id='ADDING_PCT'       width=40        name='가중치;(100%)'           	  align=right     color='#087F01'   BgColor='#EEFBEE'           </C>
                                <C> id='HLP_REQ'          width=100       name='협조요청사항'     	  align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>

                    ">
                </object>
            </comment><script> __ShowEmbedObject(__NSID__); </script>
        </td>
    </tr>
</table>
<!-- 내용 조회 그리드 데이블 끝-->

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15" width="800" ><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>수정목표 </strong>
        </td>
        <td>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image30','','/images/button/BatchAdjustOver.gif',1)"><img src="/images/button/BatchAdjustOn.gif" id="Image30" name="Image30" width="80" height="20" border="0" align="left" onClick="fnc_CopyGrid()"></a>
        </td>
 <!--         <td width="10%" align="right" valign="bottom">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image30','','/images/button/BatchAdjustOver.gif',1)"><img src="/images/button/BatchAdjustOn.gif" id="Image30" name="Image30" width="80" height="20" border="0" align="absmiddle" onClick="fnc_CopyGrid()"></a>
        </td>  -->
    </tr>
 </table>
 <table>
    <tr>
        <td width="800" >
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <colgroup>
                        <col width="60"></col>
                        <col width="100"></col>
                        <col width="60"></col>
                        <col width="*"></col>
                        <col width="113"></col>
                    </colgroup>
                    <td align="center" class="searchState">수정일자</td>
                    <td class="padding2423">
                        <input id=txtAIM_YMD size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="Image20" name="Image20" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtAIM_YMD','','30','360');"></a>
                    </td>
                    <td align="center" class="searchState">수정사유</td>
                    <td class="padding2423">
                        <input id=txtMODIFY_DEC size="74" maxlength="100" >
                    </td>
                    <td class="searchState" align="center">
                        <font color="red">가중치합계:</font><input type=text id=txtTOT_ADDING_PCT  name=txtTOT_ADDING_PCT size="3" style="text-align:left;font-weight:bold;" readonly>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td >
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <colgroup>
                        <col width=""></col>
                        <col width="100"></col>
                        <col width="83"></col>
                        <col width="112"></col>
                        <col width="103"></col>
                    </colgroup>
                    <td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                    <td align="right">
                        <img id="btnINSLST" width="80" height="20" src="/images/button/GoalAppend.gif" style="border:0px;padding:0 0 0 0;cursor:hand" align="absmiddle" onclick="fnc_InsertAimLst();">
                    </td>
                    <td align="right">
                        <img id="btnDELLST" width="80" height="20" src="/images/button/GoalRemove.gif" style="border:0px;padding:0 0 0 0;cursor:hand" align="absmiddle"  onclick="fnc_DeleteAimLst();">
                    </td>
                 <!--   <td align="right">
                        <img id="btnINSSUB" width="100" height="20" src="/images/button/SubAppend.gif" style="border:0px;padding:0 0 0 0;cursor:hand" align="absmiddle"  onclick="fnc_InsertAimSub();">
                    </td>
                    <td align="right">
                        <img id="btnDELSUB" width="100" height="20" src="/images/button/SubRemove.gif" style="border:0px;padding:0 0 0 0;cursor:hand" align="absmiddle"  onclick="fnc_DeleteAimSub();">
                    </td> -->
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
                        <object    id="grdT_EV_AIMLST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:219px;">
                            <param name="DataID"                    value="dsT_EV_AIMLST">
                            <param name="EdiTABLE"                  value="true">
                            <param name="DragDropEnable"            value="true">
                            <param name="SortView"                  value="Left">
                            <param name="ColSizing"                 value="true">
                            <param name="FixSizing"                 value="true">
                            <param name="IndWidth"                  value=0>
                            <param name="VIEWSUMMARY"               value=0>
                            <Param name="TranslateKeyDown"          value=1>
                            <param name="Format"                    value="
                                <FC> id='AIM_GBN'         width=40       name='목표;구분'        	  align=center    show=false        </FC>
                                <FC> id='EVL_YY'          width=40        name='해당년도'         	  align=center    show=false        </FC>
                                <FC> id='EVL_FRQ'         width=40        name='평가회차'          	  align=center    show=false        </FC>
                                <FC> id='AIM_YMD'         width=40       name='목표설정일자'     	  align=center    show=false        </FC>
                                <FC> id='ENO_NO'          width=40        name='피평가자사번'     	  align=center    show=false        </FC>
                                <FC> id='EVLENO_NO'       width=40        name='평가자사번'       	  align=center    show=false        </FC>
                                <FC> id='AIM_SEQ'         width=50        name='순번'             	  align=center    show=false        value={String(AIM_SEQ)} </FC>
                                <FC> id='TASK_AIM'        width=130       name='주요 핵심과제(업무)'  align=left      color='#087F01'   BgColor='#EEFBEE'       suppress= 5       editlimit=200    </FC>
                                <FC> id='TASK_CSF'        width=130       name='핵심성공 요소(CSF)'   align=left      color='#087F01'   BgColor='#EEFBEE'       suppress= 4       editlimit=200    </FC>
                                <FC> id='BASIC_PAR'       width=130       name='KPI (측정방법)'       align=left      color='#087F01'   BgColor='#EEFBEE'       suppress= 3       editlimit=200 editStyle=Popup   </FC>
                                <FC> id='AIM_LEVEL'        width=100       name='목표 (Target)'       align=left      color='#087F01'   BgColor='#EEFBEE'       suppress= 2       editlimit=100    </FC>
                                <C> id='GAUGE_GB'         width=55        name='계량;구분'        	  align=center    color='#087F01'   BgColor='#EEFBEE'       suppress= 1       editstyle=combo  data='1:계량,2:비계량'   </C>
                                <C> id='ACCEPT_GBN'       width=80        name='목표승인여부'         align=center    show=false        </C>
                                <C> id='ITEM_SEQ'         width=40        name='순번'                 align=center    show=false        edit=none        value={String(ITEM_SEQ)} </C>
                                <C> id='ITEM_DEC'        width=100       name='주요추진항목'     align=Left show=false     color='#EC4A0D'   BgColor='#FEEFEF'       editlimit=200      </C>
                                  <G> name='평가지표(KPI)' HeadBgColor='#F7DCBB'
                                        <C> id='CRITR_S'    width=130        name='S - (110%이상)'      align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_A'    width=130        name='A - (100%~110%미만)' align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_B'    width=130        name='B - (95%~100%미만)'  align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_C'    width=130        name='C - (85%~95%미만)'   align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_D'    width=130        name='D - (85%미만)'       align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
    							   </G>
                                <C> id='ACT_TIM'          width=100       name='실행시기'        	  align=center    color='#087F01'   BgColor='#EEFBEE'       editlimit=50     </C>
                                <C> id='ADDING_PCT'       width=40        name='가중치;(100%)'           	  align=right     color='#087F01'   BgColor='#EEFBEE'           </C>
                                <C> id='HLP_REQ'          width=100       name='협조요청사항'     	  align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>

                    ">
                </object>
            </comment><script> __ShowEmbedObject(__NSID__); </script>
        </td>
    </tr>
    <tr>
        <td class="paddingTop3">
            <STRONG>반려사유</STRONG>&nbsp;<input id=txtRETURN_DEC size="122" class="input_ReadOnly" readonly>
        </td>
    </tr>
</table>
<!-- 내용 조회 그리드 데이블 끝-->

</form>
<!-- form 끝 -->

</body>
</html>
