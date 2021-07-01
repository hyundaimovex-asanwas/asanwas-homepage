<!--
    ************************************************************************************
    * @Source         : vlua060.jsp                                                    *
    * @Description    : 평가일정관리                                                   *
    * @Font           : 굴림체, 9Font 사용하시고 Tab은 Space 4Byte로 처리 해 주세요!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/20  |  오대성   | 최초작성                                               *
    * 2007/03/15  |  박인이   | 수정. (직무평가업무내용 추가)                          *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>

<html>

    <head>
    <title>평가일정관리(vlua060)</title>
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
        var EVL_FRQ = '';        //회차

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";


        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            if( !fnc_SearchItemCheck() ) return;

            //데이터셋 전송
            dsT_EV_ESTINFO.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua060.cmd.VLUA060CMD&S_MODE=SHR&GUBUN="+GUBUN+"&EVL_YY_ST="+document.getElementById("cmbEVL_YY_ST_SHR").value+"&EVL_YY_EN="+document.getElementById("cmbEVL_YY_EN_SHR").value;
            dsT_EV_ESTINFO.Reset();

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //데이터셋 전송(평가구조설정정보 조회)
            dsT_EV_TYPE.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua060.cmd.VLUA060CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+document.getElementById("cmbEVL_YY").value;
            dsT_EV_TYPE.Reset();

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

            if( !fnc_SaveItemCheck() )    return;

            //트랜잭션 전송
            trT_EV_ESTINFO.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua060.cmd.VLUA060CMD&S_MODE=SAV";
            trT_EV_ESTINFO.Post();

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            fnc_Remove();

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_EV_ESTINFO.CountColumn == 0) {
                dsT_EV_ESTINFO.setDataHeader("GUBUN:STRING,EVL_YY:STRING:KEYVALUETYPE, EVL_GBN:STRING:KEYVALUETYPE, EVL_FRQ:INT:KEYVALUETYPE, EVL_NM:STRING, EVL_STDT:STRING, EVL_ENDT:STRING, IPT_STDT:STRING, IPT_ENDT:STRING, PROT_STDT:STRING, PROT_ENDT:STRING, OBJ_STDT:STRING, OBJ_ENDT:STRING, SELF_STDT:STRING, SELF_ENDT:STRING");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_EV_ESTINFO.AddRow();

            fnc_ColEnabled('E');

            //회차 콤보초기화
            for( i=0; i<=document.getElementById("cmbEVL_GBN").length; i++ ) {
                document.getElementById("cmbEVL_FRQ").remove(0);
                document.getElementById("cmbEVL_FRQ").remove(1);

            }

            form1.grdT_EV_ESTINFO.SetColumn("EVL_YY");
            form1.grdT_EV_ESTINFO.Focus();

            form1.txtGUBUN.value = GUBUN;
            form1.cmbEVL_YY[0].selected = true;
            form1.cmbEVL_GBN.disabled=false;
            form1.cmbEVL_FRQ.disabled=false;

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

            //Row상태값
            var status = 0;

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_EV_ESTINFO.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("삭제 할 자료가 없습니다!");
                return;
            }

            if (document.form1.cmbEVL_YY.value != year) {
                alert("해당년도 이외의 자료는 삭제 할 수 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_08');
                document.form1.grdT_EV_ESTINFO.focus();
                return;
            }

            // 특정 컬럼의 값으로 제거 여부를 물어 본다.(컬럼의 값만 바꿔서 사용하세요)
            if (confirm("[" + dsT_EV_ESTINFO.NameValue(dsT_EV_ESTINFO.RowPosition,"EVL_NM") + "] 자료를 삭제 하시겠습니까?") == false) return;

            status = dsT_EV_ESTINFO.RowStatus(dsT_EV_ESTINFO.RowPosition);
            dsT_EV_ESTINFO.DeleteRow(dsT_EV_ESTINFO.RowPosition);

            if( status != 1 ) {
                //트랜잭션 전송
                trT_EV_ESTINFO.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua060.cmd.VLUA060CMD&S_MODE=DEL";
                trT_EV_ESTINFO.Post();
            }

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_EV_ESTINFO.SetColumn(form1.grdT_EV_ESTINFO.GetColumnID(8));
            form1.grdT_EV_ESTINFO.Focus();

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

            document.getElementById("cmbEVL_YY")[0].selected = true;
            document.getElementById("cmbEVL_GBN").value      = '';
            document.getElementById("cmbEVL_FRQ").value      = '';
            document.getElementById("txtEVL_NM").value       = '';
            document.getElementById("txtEVL_STDT").value     = '';
            document.getElementById("txtEVL_ENDT").value     = '';
            document.getElementById("txtIPT_STDT").value     = '';
            document.getElementById("txtIPT_ENDT").value     = '';
            document.getElementById("txtPROT_STDT").value    = '';
            document.getElementById("txtPROT_ENDT").value    = '';
            document.getElementById("txtOBJ_STDT").value     = '';
            document.getElementById("txtOBJ_ENDT").value     = '';
            document.getElementById("txtSELF_STDT").value    = '';
            document.getElementById("txtSELF_ENDT").value    = '';

            document.getElementById("cmbEVL_YY_ST_SHR")[4].selected = true;
            document.getElementById("cmbEVL_YY_EN_SHR")[4].selected = true;

            document.getElementById("resultMessage").innerText = '';
            dsT_EV_ESTINFO.ClearAll();

            form1.cmbEVL_GBN.disabled=false;
            form1.cmbEVL_FRQ.disabled=false;

            form1.txtOBJ_STDT.disabled=false;
            document.getElementById("txtOBJ_STDT").style.backgroundColor = 'FFFFFF';
            form1.txtOBJ_ENDT.disabled=false;
            document.getElementById("txtOBJ_ENDT").style.backgroundColor = 'FFFFFF';
            form1.txtSELF_STDT.disabled=false;
            document.getElementById("txtSELF_STDT").style.backgroundColor = 'FFFFFF';
            form1.txtSELF_ENDT.disabled=false;
            document.getElementById("txtSELF_ENDT").style.backgroundColor = 'FFFFFF';

            fnc_ColEnabled('D');

            document.getElementById("image26").disabled = false;
            document.getElementById("image27").disabled = false;
            document.getElementById("image28").disabled = false;
            document.getElementById("image29").disabled = false;

        }


        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_ESTINFO.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            if( !cfCheckYearTerm('cmbEVL_YY_ST_SHR','cmbEVL_YY_ST_SHR','cmbEVL_YY_EN_SHR') ) {
                return false;
            }
            else {
                return true;
            }

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            if ( dsT_EV_ESTINFO.isUpdated ) {
                for( i=1; i<=dsT_EV_ESTINFO.CountRow; i++ ) {
                    if( dsT_EV_ESTINFO.RowStatus(i) == 1 || dsT_EV_ESTINFO.RowStatus(i) == 2 || dsT_EV_ESTINFO.RowStatus(i) == 3 ) {

                        if (dsT_EV_ESTINFO.RowStatus(i) == 1) {
                            for (var j = 1; j<=dsT_EV_ESTINFO.CountRow; j++) {
                                if (i != j &&
                                    dsT_EV_ESTINFO.NameValue(i, "EVL_YY") ==  dsT_EV_ESTINFO.NameValue(j, "EVL_YY") &&
                                    dsT_EV_ESTINFO.NameValue(i, "EVL_GBN") ==  dsT_EV_ESTINFO.NameValue(j, "EVL_GBN") &&
                                    dsT_EV_ESTINFO.NameValue(i, "EVL_FRQ") ==  dsT_EV_ESTINFO.NameValue(j, "EVL_FRQ") )  {

                                    alert("해당일자/구분/회차가 동일한 데이터가 존재합니다.");
                                    dsT_EV_ESTINFO.RowPosition = i;
                                    form1.grdT_EV_ESTINFO.SetColumn("EVL_YY");
                                    form1.grdT_EV_ESTINFO.focus();
                                    return false;
                                }
                            }
                        }

                        if( dsT_EV_ESTINFO.NameValue(i, "EVL_YY") != year ) {
                            alert("현재년도 이외의 자료는 저장 및 수정할 수 없습니다.");
                            fnc_Message(document.getElementById("resultMessage"), 'MSG_06');
                            dsT_EV_ESTINFO.RowPosition = i;
                            form1.grdT_EV_ESTINFO.SetColumn("EVL_YY");
                            form1.grdT_EV_ESTINFO.focus();
                            return false;
                        }

                        if( dsT_EV_ESTINFO.NameValue(i, "EVL_YY") == '' ) {
                            alert("해당년도는 필수입력사항입니다..");
                            dsT_EV_ESTINFO.RowPosition = i;
                            form1.grdT_EV_ESTINFO.SetColumn("EVL_YY");
                            form1.grdT_EV_ESTINFO.focus();
                            return false;
                        }

                        if( dsT_EV_ESTINFO.NameValue(i, "EVL_GBN") == '' ) {
                            alert("구분은 필수 입력사항입니다..");
                            dsT_EV_ESTINFO.RowPosition = i;
                            form1.grdT_EV_ESTINFO.SetColumn("EVL_GBN");
                            form1.grdT_EV_ESTINFO.focus();
                            return false;
                        }
                        if( dsT_EV_ESTINFO.NameValue(i, "EVL_FRQ") == '' ) {
                            alert("회차는 필수 입력사항입니다..");
                            dsT_EV_ESTINFO.RowPosition = i;
                            form1.grdT_EV_ESTINFO.SetColumn("EVL_FRQ");
                            form1.grdT_EV_ESTINFO.focus();
                            return false;
                        }

                        if( dsT_EV_ESTINFO.NameValue(i, "EVL_NM") == '' ) {
                            alert("평가명칭은 필수 입력사항입니다..");
                            dsT_EV_ESTINFO.RowPosition = i;
                            form1.grdT_EV_ESTINFO.SetColumn("EVL_NM");
                            form1.grdT_EV_ESTINFO.focus();
                            return false;
                        }

                        if( dsT_EV_ESTINFO.NameValue(i, "EVL_STDT") == '' || dsT_EV_ESTINFO.NameValue(i, "EVL_ENDT") == '' ) {
                            alert("평가적용기간은 필수 입력사항입니다..");
                            dsT_EV_ESTINFO.RowPosition = i;
                            form1.grdT_EV_ESTINFO.SetColumn("EVL_STDT");
                            form1.grdT_EV_ESTINFO.focus();
                            return false;
                        }

                        if( cfDateExpr(dsT_EV_ESTINFO.NameValue(i, "EVL_STDT")) == false  || cfDateExpr(dsT_EV_ESTINFO.NameValue(i, "EVL_ENDT")) == false ) {
                            alert("평가적용기간이 날짜형식에 맞지않습니다.");
                            dsT_EV_ESTINFO.RowPosition = i;
                            form1.grdT_EV_ESTINFO.SetColumn("EVL_STDT");
                            form1.grdT_EV_ESTINFO.focus();
                            return false;
                        }

                        if( dsT_EV_ESTINFO.NameValue(i, "IPT_STDT") == '' || dsT_EV_ESTINFO.NameValue(i, "IPT_ENDT") == '' ) {
                            alert("평가입력기간은 필수 입력사항입니다..");
                            dsT_EV_ESTINFO.RowPosition = i;
                            form1.grdT_EV_ESTINFO.SetColumn("IPT_STDT");
                            form1.grdT_EV_ESTINFO.focus();
                            return false;
                        }

                        if( cfDateExpr(dsT_EV_ESTINFO.NameValue(i, "IPT_STDT")) == false  || cfDateExpr(dsT_EV_ESTINFO.NameValue(i, "IPT_ENDT")) == false ) {
                            alert("평가입력기간이 날짜형식에 맞지않습니다.");
                            dsT_EV_ESTINFO.RowPosition = i;
                            form1.grdT_EV_ESTINFO.SetColumn("IPT_STDT");
                            form1.grdT_EV_ESTINFO.focus();
                            return false;
                        }

                        if( dsT_EV_ESTINFO.NameValue(i, "PROT_STDT") == '' || dsT_EV_ESTINFO.NameValue(i, "PROT_ENDT") == '' ) {
                            alert("이의신청기간은 필수 입력사항입니다..");
                            dsT_EV_ESTINFO.RowPosition = i;
                            form1.grdT_EV_ESTINFO.SetColumn("PROT_STDT");
                            form1.grdT_EV_ESTINFO.focus();
                            return false;
                        }

                        if( cfDateExpr(dsT_EV_ESTINFO.NameValue(i, "PROT_STDT")) == false  || cfDateExpr(dsT_EV_ESTINFO.NameValue(i, "PROT_ENDT")) == false ) {
                            alert("이의신청기간이 날짜형식에 맞지않습니다.");
                            dsT_EV_ESTINFO.RowPosition = i;
                            form1.grdT_EV_ESTINFO.SetColumn("PROT_STDT");
                            form1.grdT_EV_ESTINFO.focus();
                            return false;
                        }

                        if( (dsT_EV_ESTINFO.NameValue(i, "OBJ_STDT") != '' && cfDateExpr(dsT_EV_ESTINFO.NameValue(i, "OBJ_STDT")) == false)  || (dsT_EV_ESTINFO.NameValue(i, "OBJ_ENDT") != '' && cfDateExpr(dsT_EV_ESTINFO.NameValue(i, "OBJ_ENDT")) == false) ) {
                            alert("목표입력기간이 날짜형식에 맞지않습니다.");
                            dsT_EV_ESTINFO.RowPosition = i;
                            form1.grdT_EV_ESTINFO.SetColumn("OBJ_STDT");
                            form1.grdT_EV_ESTINFO.focus();
                            return false;
                        }

                        if( (dsT_EV_ESTINFO.NameValue(i, "SELF_STDT") != '' && cfDateExpr(dsT_EV_ESTINFO.NameValue(i, "SELF_STDT")) == false)  || (dsT_EV_ESTINFO.NameValue(i, "SELF_ENDT") != '' && cfDateExpr(dsT_EV_ESTINFO.NameValue(i, "SELF_ENDT")) == false) ) {
                            alert("본인평가기간이 날짜형식에 맞지않습니다.");
                            dsT_EV_ESTINFO.RowPosition = i;
                            form1.grdT_EV_ESTINFO.SetColumn("SELF_STDT");
                            form1.grdT_EV_ESTINFO.focus();
                            return false;
                        }

                        //성과평가의 경우 목표입력기간/본인평가기간 필수입력 체크  Modified by DS
                        if(dsT_EV_ESTINFO.NameValue(i, "EVL_GBN") == "2"){
                            if(dsT_EV_ESTINFO.NameValue(i, "OBJ_STDT") == '' || dsT_EV_ESTINFO.NameValue(i, "OBJ_ENDT") == ''){
                                alert("목표입력기간은 필수 입력사항입니다.");
                                dsT_EV_ESTINFO.RowPosition = i;
                                form1.grdT_EV_ESTINFO.SetColumn("OBJ_STDT");
                                form1.grdT_EV_ESTINFO.focus();
                                return false;
                            }

                            if( cfDateExpr(dsT_EV_ESTINFO.NameValue(i, "SELF_STDT")) == false  || cfDateExpr(dsT_EV_ESTINFO.NameValue(i, "SELF_ENDT")) == false ) {
                                alert("본인평가기간은 필수 입력사항입니다.");
                                dsT_EV_ESTINFO.RowPosition = i;
                                form1.grdT_EV_ESTINFO.SetColumn("SELF_STDT");
                                form1.grdT_EV_ESTINFO.focus();
                                return false;
                            }
                        }
                    }
                }
            } else {
                fnc_Message(document.getElementById("resultMessage"),"MSG_04");
                alert("저장 할 자료가 없습니다!");
                return false;
            }

            return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style 적용
            cfStyleGrid(form1.grdT_EV_ESTINFO, 15, "false", "false");

            getSelYy2('cmbEVL_YY');
            form1.cmbEVL_YY.disabled=true;
            getSelYy2('cmbEVL_YY_ST_SHR');
            getSelYy2('cmbEVL_YY_EN_SHR');

            // 업무구분
            if (frameid == "vlua060") {
                // 인사평가
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/인사평가/평가기준정보/";

            }
            else {
                // 직무평가
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/교육관리/직무평가/평가기준정보/";
            }

            fnc_ColEnabled('D');

            document.getElementById("cmbEVL_YY_ST_SHR").focus();//set focus

        }


        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

        /****************************************************
         * 15. 평가구분(역량,성과)에 따른 목표입력기간,        *
         *        본인평가기간의 입력 disable,                *
         *         그리드 show 여부를 조정 처리 부분              *
         ***************************************************/
        function fnc_EvlGbnSet() {

            //평가구분(역량,성과)에 따른 목표입력기간, 본인평가기간의 입력 disable
            if( form1.cmbEVL_GBN.value == '1'  || form1.cmbEVL_GBN.value == '3' ) {    //역량

                form1.txtOBJ_STDT.value='';
                form1.txtOBJ_ENDT.value='';
                form1.txtSELF_STDT.value='';
                form1.txtSELF_ENDT.value='';

                form1.txtOBJ_STDT.disabled=true;
                document.getElementById("txtOBJ_STDT").style.backgroundColor = 'EEEEEE';
                form1.txtOBJ_ENDT.disabled=true;
                document.getElementById("txtOBJ_ENDT").style.backgroundColor = 'EEEEEE';
                form1.txtSELF_STDT.disabled=true;
                document.getElementById("txtSELF_STDT").style.backgroundColor = 'EEEEEE';
                form1.txtSELF_ENDT.disabled=true;
                document.getElementById("txtSELF_ENDT").style.backgroundColor = 'EEEEEE';

                document.getElementById("image26").disabled=true;
                document.getElementById("image27").disabled=true;
                document.getElementById("image28").disabled=true;
                document.getElementById("image29").disabled=true;

            } else if( form1.cmbEVL_GBN.value == '2') {

                form1.txtOBJ_STDT.disabled=false;
                document.getElementById("txtOBJ_STDT").style.backgroundColor = 'FFFFFF';
                form1.txtOBJ_ENDT.disabled=false;
                document.getElementById("txtOBJ_ENDT").style.backgroundColor = 'FFFFFF';
                form1.txtSELF_STDT.disabled=false;
                document.getElementById("txtSELF_STDT").style.backgroundColor = 'FFFFFF';
                form1.txtSELF_ENDT.disabled=false;
                document.getElementById("txtSELF_ENDT").style.backgroundColor = 'FFFFFF';

                document.getElementById("image26").disabled=false;
                document.getElementById("image27").disabled=false;
                document.getElementById("image28").disabled=false;
                document.getElementById("image29").disabled=false;

            }

        }

        /********************
         * 16. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /***************************************
         * 입력부의 컬럼의 Disabled 속성 바꿈  *
         ***************************************/
        function fnc_ColEnabled(prop) {
            // 해당 컬럼의 속성을 Enabled로 변경
            if (prop == 'E') {
                form1.cmbEVL_GBN.disabled    = false;
                form1.cmbEVL_FRQ.disabled    = false;
                form1.txtEVL_NM.disabled     = false;
                form1.txtEVL_STDT.disabled   = false;
                form1.txtEVL_ENDT.disabled   = false;
                form1.txtIPT_STDT.disabled   = false;
                form1.txtIPT_ENDT.disabled   = false;
                form1.txtPROT_STDT.disabled  = false;
                form1.txtPROT_ENDT.disabled  = false;
                form1.txtOBJ_STDT.disabled   = false;
                form1.txtOBJ_ENDT.disabled   = false;
                form1.txtSELF_STDT.disabled  = false;
                form1.txtSELF_ENDT.disabled  = false;

                document.getElementById("image20").disabled = false;
                document.getElementById("image21").disabled = false;
                document.getElementById("image22").disabled = false;
                document.getElementById("image23").disabled = false;
                document.getElementById("image24").disabled = false;
                document.getElementById("image25").disabled = false;
                document.getElementById("image26").disabled = false;
                document.getElementById("image27").disabled = false;
                document.getElementById("image28").disabled = false;
                document.getElementById("image29").disabled = false;
            }
            // 해당 컬럼의 속성을 Disabled로 변경
            else if (prop == 'D') {
                form1.cmbEVL_GBN.disabled    = true;
                form1.cmbEVL_FRQ.disabled    = true;
                form1.txtEVL_NM.disabled     = true;
                form1.txtEVL_STDT.disabled   = true;
                form1.txtEVL_ENDT.disabled   = true;
                form1.txtIPT_STDT.disabled   = true;
                form1.txtIPT_ENDT.disabled   = true;
                form1.txtPROT_STDT.disabled  = true;
                form1.txtPROT_ENDT.disabled  = true;
                form1.txtOBJ_STDT.disabled   = true;
                form1.txtOBJ_ENDT.disabled   = true;
                form1.txtSELF_STDT.disabled  = true;
                form1.txtSELF_ENDT.disabled  = true;

                document.getElementById("image20").disabled = true;
                document.getElementById("image21").disabled = true;
                document.getElementById("image22").disabled = true;
                document.getElementById("image23").disabled = true;
                document.getElementById("image24").disabled = true;
                document.getElementById("image25").disabled = true;
                document.getElementById("image26").disabled = true;
                document.getElementById("image27").disabled = true;
                document.getElementById("image28").disabled = true;
                document.getElementById("image29").disabled = true;
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
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_GRDRATE)   |
    | 3. 사용되는 Table List(T_EV_GRDRATE)          |
    +----------------------------------------------->
    <Object ID="dsT_EV_ESTINFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_TYPE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_GRDRATE)   |
    | 3. 사용되는 Table List(T_EV_GRDRATE)          |
    +----------------------------------------------->
    <Object ID ="trT_EV_ESTINFO" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_ESTINFO)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <script language="javascript"  for=grdT_EV_ESTINFO event=OnClick(row,colid)>

        if (dsT_EV_ESTINFO.ErrorCode == 50018) {
            return;
        }

        if( row > 0 ) {
            EVL_FRQ = dsT_EV_ESTINFO.NameValue(row,"EVL_FRQ");

            //해당년도,구분,회차에 관한 키 수정 불가처리
            if( dsT_EV_ESTINFO.RowStatus(row) == 0 ) {

                var oOption;
                //회차콤보 셋팅
                for( i=0; i<=document.getElementById("cmbEVL_GBN").length; i++ ) {
                    document.getElementById("cmbEVL_FRQ").remove(0);
                    document.getElementById("cmbEVL_FRQ").remove(1);
                }
                oOption = document.createElement("OPTION");
                oOption.value = EVL_FRQ;
                oOption.text = EVL_FRQ;
                document.getElementById("cmbEVL_FRQ").add(oOption);
                dsT_EV_ESTINFO.NameValue(row,"EVL_FRQ")=EVL_FRQ;

                form1.cmbEVL_YY.disabled=true;
                form1.cmbEVL_GBN.disabled=true;
                form1.cmbEVL_FRQ.disabled=true;

                EVL_FRQ = '';    //EVL_FRQ 초기화
            } else {

                //회차콤보 셋팅
                fnc_SearchItem();

                form1.cmbEVL_GBN.disabled=false;
                form1.cmbEVL_FRQ.disabled=false;

            }

            //평가구분(역량,성과)에 따른 목표입력기간, 본인평가기간의 입력 disable
            fnc_EvlGbnSet();

            grdT_EV_ESTINFO.SetColumn("colid");
        }

    </script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            //alert("검색하신 조건의 자료가 없습니다!");

            fnc_ColEnabled('D');

        } else {

            //조회 자료가 1건 이상일 때 처리 할 내용 코딩
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_EV_ESTINFO.CountRow);

            EVL_FRQ = dsT_EV_ESTINFO.NameValue(dsT_EV_ESTINFO.RowPosition,"EVL_FRQ");
            //해당년도,구분,회차에 관한 키 수정 불가처리
            if( dsT_EV_ESTINFO.RowStatus(dsT_EV_ESTINFO.RowPosition) == 0 ) {
                var oOption;
                //회차콤보 셋팅
                for( i=0; i<=document.getElementById("cmbEVL_GBN").length; i++ ) {
                    document.getElementById("cmbEVL_FRQ").remove(0);
                    document.getElementById("cmbEVL_FRQ").remove(1);
                }
                oOption = document.createElement("OPTION");
                oOption.value = EVL_FRQ;
                oOption.text = EVL_FRQ;
                document.getElementById("cmbEVL_FRQ").add(oOption);

                fnc_ColEnabled('E');

                //해당년도,구분,회차에 관한 키 수정 불가처리
                form1.cmbEVL_YY.disabled=true;
                form1.cmbEVL_GBN.disabled=true;
                form1.cmbEVL_FRQ.disabled=true;

                EVL_FRQ = '';    //EVL_FRQ 초기화
            }

        }

        grdT_EV_ESTINFO.SetColumn("ABL_CD");//set focus
        fnc_EvlGbnSet();

    </Script>

    <Script For=dsT_EV_TYPE Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //회차콤보 모두삭제
            for( i=0; i<=document.getElementById("cmbEVL_GBN").length; i++ ) {
                document.getElementById("cmbEVL_FRQ").remove(0);
                document.getElementById("cmbEVL_FRQ").remove(1);
            }

        } else {

            //조회 자료가 1건 이상일 때 처리 할 내용 코딩
            //회차
            var oOption;
            //회차콤보 모두삭제
            for( i=0; i<=document.getElementById("cmbEVL_GBN").length; i++ ) {
                document.getElementById("cmbEVL_FRQ").remove(0);
                document.getElementById("cmbEVL_FRQ").remove(1);
            }

            if( document.getElementById("cmbEVL_GBN").value == '1' ) {        //역량
                for( i=1; i<=Number(dsT_EV_TYPE.NameValue(1,"ABL_CNT")); i++ ) {        //역량평가회수
                    oOption = document.createElement("OPTION");
                    oOption.value = i;
                    oOption.text = i;
                    document.getElementById("cmbEVL_FRQ").add(oOption);
                }
            }
            if( document.getElementById("cmbEVL_GBN").value == '2' ) {        //성과
                for( i=1; i<=dsT_EV_TYPE.NameValue(1,"ACH_CNT"); i++ ) {        //역량평가회수
                    oOption = document.createElement("OPTION");
                    oOption.value = i;
                    oOption.text = i;
                    document.getElementById("cmbEVL_FRQ").add(oOption);
                }
            }
            if( document.getElementById("cmbEVL_GBN").value == '3' ) {        //종합
                for( i=1; i<=1; i++ ) {        //역량평가회수
                    oOption = document.createElement("OPTION");
                    oOption.value = i;
                    oOption.text = i;
                    document.getElementById("cmbEVL_FRQ").add(oOption);
                }
            }
            //신규자료 OnClick시 회차 셋팅
            if( EVL_FRQ != '' ) {
                document.getElementById("cmbEVL_FRQ")[eval(EVL_FRQ-1)].selected = true;
            }

            EVL_FRQ = '';    //EVL_FRQ 초기화
        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ESTINFO Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ESTINFO Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018) {
            alert("해당 필수입력항목[해당년도/구분/회차] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
            alert("해당년도/구분/회차에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }


    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_ESTINFO event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"),"MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_ESTINFO event="OnFail()">

        document.getElementById("resultMessage").innerText = ' ';
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
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">평가일정관리</td>
                        <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">평가일정관리</td>
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
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save();"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image0','','/images/button/btn_CancelOver.gif',0)"><img src="/images/button/btn_CancelOn.gif" name="Image0" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                    <td align="right" width="1"></td>
                                    <td align="center" class="searchState">해당년도</td>
                                    <td><select id=cmbEVL_YY_ST_SHR name=cmbEVL_YY_ST_SHR onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="if(!cfCheckYearTerm('cmbEVL_YY_ST_SHR','cmbEVL_YY_ST_SHR','cmbEVL_YY_EN_SHR')) return; fnc_SearchList();"><select> 년 ~
                                        <select id=cmbEVL_YY_EN_SHR name=cmbEVL_YY_EN_SHR onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="if(!cfCheckYearTerm('cmbEVL_YY_EN_SHR','cmbEVL_YY_ST_SHR','cmbEVL_YY_EN_SHR')) return; fnc_SearchList();"><select> 년</td>
                                    <td align="left" width="500"></td>
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
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="133"></col>
                        <col width="133"></col>
                        <col width="133"></col>
                        <col width="133"></col>
                        <col width="133"></col>
                        <col width="133"></col>
                    </colgroup>
                    <tr>
                        <input type="hidden" name="txtGUBUN" id="txtGUBUN">
                        <td align="center" class="creamBold">해당년도</td>
                        <td class="padding2423"><select id=cmbEVL_YY  onChange="fnc_SearchItem();"><select></td>
                        <td align="center" class="creamBold">구분</td>
                        <td class="padding2423">
                            <select id="cmbEVL_GBN" style="WIDTH: 100%" onChange="fnc_EvlGbnSet();fnc_SearchItem();">
                                <option value="1">역량</option>
                                <option value="2">성과</option>
                                <option value="3">종합</option>
                            </select> </td>
                        <td align="center" class="creamBold">회차</td>
                        <td class="padding2423">
                            <select id="cmbEVL_FRQ" style="WIDTH: 100%">
                                <option value="1">상반기</option>
                                <option value="2">하반기</option>                       
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold">명칭</td>
                        <td class="padding2423" colspan="2"><input id=txtEVL_NM style="WIDTH: 100%" onBlur="cfCheckLength('txtEVL_NM','명칭','100');"></td>
                        <td align="center" class="creamBold">평가적용기간</td>
                        <td class="padding2423" colspan="2">
                            <input id="txtEVL_STDT" name="txtEVL_STDT" style="ime-mode:disabled" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; }  cfCheckDateTerm('txtEVL_STDT','txtEVL_STDT','txtEVL_ENDT'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOver.gif" id="Image20" name="Image20" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtEVL_STDT','','500','125');"></a>
                            ~
                            <input id="txtEVL_ENDT" style="ime-mode:disabled" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtEVL_ENDT','txtEVL_STDT','txtEVL_ENDT'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image21','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOver.gif" id="Image21" name="Image21" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEVL_ENDT','','615','125');"></a>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold">평가입력기간</td>
                        <td class="padding2423" colspan="2">
                            <input id="txtIPT_STDT" style="ime-mode:disabled"  size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtIPT_STDT','txtIPT_STDT','txtIPT_ENDT'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image22','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOver.gif" id="Image22" name="Image22" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtIPT_STDT','','95','150');"></a>
                            ~
                            <input id="txtIPT_ENDT" style="ime-mode:disabled" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtIPT_ENDT','txtIPT_STDT','txtIPT_ENDT'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image23','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOver.gif" id="Image23" name="Image23" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtIPT_ENDT','','210','150');"></a>
                        </td>
                        <td align="center" class="creamBold">이의신청기간</td>
                        <td class="padding2423" colspan="2">
                            <input id="txtPROT_STDT" style="ime-mode:disabled" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtPROT_STDT','txtPROT_STDT','txtPROT_ENDT'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image24','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOver.gif" id="Image24" name="Image24" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPROT_STDT','','500','150');"></a>
                            ~
                            <input id="txtPROT_ENDT" style="ime-mode:disabled" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtPROT_ENDT','txtPROT_STDT','txtPROT_ENDT'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image25','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOver.gif" id="Image25" name="Image25" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPROT_ENDT','','615','150');"></a>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold">목표입력기간</td>
                        <td class="padding2423" colspan="2">
                            <input id="txtOBJ_STDT" name="txtOBJ_STDT" style="ime-mode:disabled" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtOBJ_STDT','txtOBJ_STDT','txtOBJ_ENDT'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image26','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOver.gif" id="Image26" name="Image26" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtOBJ_STDT','','95','175');"></a>
                            ~
                            <input id="txtOBJ_ENDT" style="ime-mode:disabled" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtOBJ_ENDT','txtOBJ_STDT','txtOBJ_ENDT'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image27','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOver.gif" id="Image27" name="Image27" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtOBJ_ENDT','','210','175');"></a>
                        </td>
                        <td align="center" class="creamBold">본인평가기간</td>
                        <td class="padding2423" colspan="2">
                            <input id="txtSELF_STDT" style="ime-mode:disabled" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtSELF_STDT','txtSELF_STDT','txtSELF_ENDT'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image28','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOver.gif" id="Image28" name="Image28" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSELF_STDT','','500','175');"></a>
                            ~
                            <input id="txtSELF_ENDT" style="ime-mode:disabled" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value=''; } cfCheckDateTerm('txtSELF_ENDT','txtSELF_STDT','txtSELF_ENDT'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image29','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOver.gif" id="Image29" name="Image29 " width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSELF_ENDT','','615','175');"></a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- 조건 입력 테이블 끝 -->

    <!-- 조회 상태 테이블 시작 -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                        <td align="right">&nbsp;</td>
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
                            <object    id="grdT_EV_ESTINFO" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:240px;">
                                <param name="DataID"                     value="dsT_EV_ESTINFO">
                                <param name="EdiTABLE"                   value="false">
                                <param name="DragDropEnable"             value="true">
                                <param name="SortView"                   value="Left">
                                <param name="VIEWSUMMARY"                value=0>
                                <param name="FixSizing"                  value="true">
                                <param name="AutoReSizing"               value="true">
                                <param name=ColSizing  value="true">
                                <param name="Format"                     value="
                                    <FC> id='EVL_YY'        width=60     name='해당년도'   align=center    edit={IF(Status='N',none,'')} </FC>
                                    <FC> id='EVL_GBN'       width=40     name='구분'       align=center    editstyle=combo data='1:역량,2:성과,3:종합'  edit={IF(Status='N',none,'')} </FC>
                                    <FC> id='EVL_FRQ'       width=40     name='회차'       align=center    editstyle=combo data='1:1,2:2,3:3'    edit={IF(Status='N',none,'')} </FC>
                                    <FC> id='EVL_NM'        width=100    name='명칭'       align=left      editlimit=100 </FC>
                                    <G> name='평가적용기간' HeadBgColor='#F7DCBB'
                                        <C> id='EVL_STDT'   width=70     name='시작일'     align=center    editlimit=10 </C>
                                        <C> id='EVL_ENDT'   width=70     name='종료일'     align=center    editlimit=10  </C>
                                    </G>
                                    <G> name='평가입력기간' HeadBgColor='#F7DCBB'
                                        <C> id='IPT_STDT'   width=70     name='시작일'     align=center    editlimit=10 </C>
                                        <C> id='IPT_ENDT'   width=70     name='종료일'     align=center    editlimit=10 </C>
                                    </G>
                                    <G> name='이의신청기간' HeadBgColor='#F7DCBB'
                                        <C> id='PROT_STDT'  width=70     name='시작일'     align=center    editlimit=10 </C>
                                        <C> id='PROT_ENDT'  width=70     name='종료일'     align=center    editlimit=10 </C>
                                    </G>
                                    <G> name='목표입력기간' HeadBgColor='#F7DCBB'
                                        <C> id='OBJ_STDT'   width=70     name='시작일'     align=center    editlimit=10 </C>
                                        <C> id='OBJ_ENDT'   width=70     name='종료일'     align=center    editlimit=10 </C>
                                    </G>
                                    <G> name='본인평가기간' HeadBgColor='#F7DCBB'
                                        <C> id='SELF_STDT'  width=70     name='시작일'     align=center    editlimit=10 </C>
                                        <C> id='SELF_ENDT'  width=70     name='종료일'     align=center    editlimit=10 </C>
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

    <!--
    **************************************************************
    * 바인딩 컴포넌트
    **************************************************************
    -->
    <!-- KPI Pool 설정 테이블 -->
    <comment id="__NSID__">
    <object id="bndT_EV_ESTINFO" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
        <Param Name="DataID",    Value="dsT_EV_ESTINFO">
        <Param Name="ActiveBind" Value=true>
        <Param Name="BindInfo",  Value='
            <C>Col=GUBUN         Ctrl=txtGUBUN       Param=value</C>
            <C>Col=EVL_YY        Ctrl=cmbEVL_YY      Param=value</C>
            <C>Col=EVL_GBN       Ctrl=cmbEVL_GBN     Param=value</C>
            <C>Col=EVL_FRQ       Ctrl=cmbEVL_FRQ     Param=value</C>
            <C>Col=EVL_NM        Ctrl=txtEVL_NM      Param=value</C>
            <C>Col=EVL_STDT      Ctrl=txtEVL_STDT    Param=value</C>
            <C>Col=EVL_ENDT      Ctrl=txtEVL_ENDT    Param=value</C>
            <C>Col=IPT_STDT      Ctrl=txtIPT_STDT    Param=value</C>
            <C>Col=IPT_ENDT      Ctrl=txtIPT_ENDT    Param=value</C>
            <C>Col=PROT_STDT     Ctrl=txtPROT_STDT   Param=value</C>
            <C>Col=PROT_ENDT     Ctrl=txtPROT_ENDT   Param=value</C>
            <C>Col=OBJ_STDT      Ctrl=txtOBJ_STDT    Param=value</C>
            <C>Col=OBJ_ENDT      Ctrl=txtOBJ_ENDT    Param=value</C>
            <C>Col=SELF_STDT     Ctrl=txtSELF_STDT   Param=value</C>
            <C>Col=SELF_ENDT     Ctrl=txtSELF_ENDT   Param=value</C>
        '>
    </object>
    </comment><script> __ShowEmbedObject(__NSID__); </script>

