<!--
    ************************************************************************************
    * @Source         : mema019.jsp                                                    *
    * @Description    : 입사후경력 PAGE                                                *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/01/16  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>


<html>
    <head>
    <title>입사후경력</title>
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

        var str_ymd = '';
        var seq_no  = '';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            dsT_ME_AHISTORY.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema019.cmd.MEMA019CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_ME_AHISTORY.Reset();

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

                trT_ME_AHISTORY.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema019.cmd.MEMA019CMD&S_MODE=SAV";
                trT_ME_AHISTORY.post();

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
            if (dsT_ME_AHISTORY.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_ME_AHISTORY.RowStatus(dsT_ME_AHISTORY.RowPosition);

            //DataSet의 변경 여부 확인
            if (dsT_ME_AHISTORY.IsUpdated && status != 1) {
                alert("화면에 변경사항이 존재합니다.\n먼저 화면 내용을 저장하신 다음 작업하여 주십시오.");
                return false;
            }
            
            //첫번째 로우(시작일이 과 SEQ가 가장큰거만 삭제 가능)부터 차례대로 삭제 가능(아니면 데이터 꼬인다)
            if(dsT_ME_AHISTORY.RowPosition != 1){
                alert("최근 입력 데이터부터 삭제가 가능합니다. ");
                return false;
            }             

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("시작일자[" + dsT_ME_AHISTORY.NameValue(dsT_ME_AHISTORY.RowPosition,"STR_YMD") + "] [" + dsT_ME_AHISTORY.NameValue(dsT_ME_AHISTORY.RowPosition,"SEQ_NO") + "] 자료를 제거하시겠습니까?") == false) return;
            dsT_ME_AHISTORY.DeleteRow(dsT_ME_AHISTORY.RowPosition);

            if (status != 1) {
                trT_ME_AHISTORY.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema019.cmd.MEMA019CMD&S_MODE=DEL";
                trT_ME_AHISTORY.post();
            }

            bnd.ActiveBind = false;

            // 삭제 후 해당 그리드로 Focus 이동
            form1.grdT_ME_AHISTORY.SetColumn(form1.grdT_ME_AHISTORY.GetColumnID(0));
            form1.grdT_ME_AHISTORY.Focus();

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
            if (dsT_ME_AHISTORY.CountColumn == 0) {
                dsT_ME_AHISTORY.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, STR_YMD:STRING:KEYVALUETYPE, SEQ_NO:STRING:KEYVALUETYPE, OCC_CD:STRING, OCC_NM:STRING, END_YMD:STRING, APP_CD:STRING, APP_NM:STRING, HEAD_CD:STRING, HEAD_NM:STRING, DPT_CD:STRING, DPT_NM:STRING, TEAM_CD:STRING, TEAM_NM:STRING, JOB_CD:STRING, JOB_NM:STRING, DUTY_CD:STRING, DUTY_NM:STRING, PART_CD:STRING, PART_NM:STRING, JCD_CD:STRING, JCD_NM:STRING, APP_YMD:STRING, REMARK:STRING, TAX_DPT:STRING, TAX_DPTNM:STRING");
            }
            
            //신규를 하기전 기존신규의 필수항목이 전부 들어가 있지 않으면 추가 불가
            if(dsT_ME_AHISTORY.SysStatus(1) ==  "1" ){
                            
                if(dsT_ME_AHISTORY.NameValue(1,"STR_YMD").trim() == "" || // 시작
                   dsT_ME_AHISTORY.NameValue(1,"DPT_CD" ).trim() == "" || // 소속
                   //dsT_ME_AHISTORY.NameValue(1,"OCC_CD" ).trim() == "" || // 근로구분
                   //dsT_ME_AHISTORY.NameValue(1,"JOB_CD" ).trim() == "" || // 직위
                   //dsT_ME_AHISTORY.NameValue(1,"HOB_CD" ).trim() == "" || // 호봉
                   dsT_ME_AHISTORY.NameValue(1,"DUTY_CD").trim() == "" || // 직책
                   dsT_ME_AHISTORY.NameValue(1,"APP_CD" ).trim() == "" || // 발령
                   dsT_ME_AHISTORY.NameValue(1,"JCD_CD" ).trim() == "" || // 재직
                   dsT_ME_AHISTORY.NameValue(1,"TAX_DPT").trim() == "" || // 회계
                   dsT_ME_AHISTORY.NameValue(1,"APP_YMD").trim() == ""){  // 인사발령
                   
                    alert("신규데이터의 필수항목을 모두 입력해야 추가가 가능합니다.");
                    return false;
                    
                }
                
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_ME_AHISTORY.InsertRow(1);

            fnc_ColEnabled('E');

            form1.grdT_ME_AHISTORY.setColumn(form1.grdT_ME_AHISTORY.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;

            // KEY 필드는 신규시 입력 가능
            document.getElementById("txtSTR_YMD").disabled = false;
            document.getElementById("ImgStrYmd").disabled  = false;

            //파견사원은 근로구분 및 직위가 고정되어 있다.
            document.getElementById("txtJOB_CD").value = '6B';
            fnc_GetCommNm('A2', 'txtJOB_CD','txtJOB_NM');

//            if (document.getElementById("txtJOB_NM").value == '') {
//                document.getElementById("txtJOB_NM").value = '사원';
//            }

            document.getElementById("txtOCC_CD").value = 'A';
            fnc_GetCommNm('A1', 'txtOCC_CD','txtOCC_NM');

			//이전 입사후경력에 종료일이 있으면 그다음 날짜를 가져 오고 없으면 오늘 날짜를 가져온다.
			//최초입력시 undefined 나온다.
			var END_YMD = dsT_ME_AHISTORY.NameValue(dsT_ME_AHISTORY.RowPosition+1,"END_YMD");

			if(END_YMD != undefined && END_YMD.trim().length > 0){
	            document.getElementById("txtSTR_YMD").value = addDate("D",END_YMD, 1);
	            document.getElementById("txtAPP_YMD").value = addDate("D",END_YMD, 1);//인사발령일도 같이 넣어준다.
			}else{
	            document.getElementById("txtSTR_YMD").value = getToday();
	            document.getElementById("txtAPP_YMD").value = getToday();//인사발령일도 같이 넣어준다.
            }
            document.getElementById("txtSTR_YMD").focus();
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

			dsT_ME_AHISTORY.ClearData();
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
            if (!dsT_ME_AHISTORY.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }

            for ( i = 1; i <= dsT_ME_AHISTORY.CountRow; i++ ) {
                if ( dsT_ME_AHISTORY.RowStatus(i) == 1 ||
                     dsT_ME_AHISTORY.RowStatus(i) == 3 ) {


                    // 시작일자
                    if( dsT_ME_AHISTORY.NameValue(i, "STR_YMD") == '' ) {
                        alert("시작일자는 필수 입력사항입니다.");
                        dsT_ME_AHISTORY.RowPosition = i;
                        document.getElementById("txtSTR_YMD").focus();
                        return false;
                    }

                    // 시작일자 CHECK
                    if (!fnc_CheckDate2(dsT_ME_AHISTORY.NameValue(i, "STR_YMD"), "시작일") && dsT_ME_AHISTORY.NameValue(i, "STR_YMD") != "") {
                        dsT_ME_AHISTORY.RowPosition = i;
                        document.getElementById("txtSTR_YMD").focus();
                        return false;
                    }

                    // 종료일자 CHECK
                    if (!fnc_CheckDate2(dsT_ME_AHISTORY.NameValue(i, "END_YMD"), "종료일") && dsT_ME_AHISTORY.NameValue(i, "END_YMD") != "") {
                        dsT_ME_AHISTORY.RowPosition = i;
                        document.getElementById("txtEND_YMD").focus();
                        return false;
                    }

                    // 시작일자와 종료일자 비교
                    if( dsT_ME_AHISTORY.NameValue(i, "STR_YMD") != '' && dsT_ME_AHISTORY.NameValue(i, "END_YMD") != '' ) {
                        if( cfDateDiff(dsT_ME_AHISTORY.NameValue(i, "STR_YMD").replace(/\-/g,''),dsT_ME_AHISTORY.NameValue(i, "END_YMD").replace(/\-/g,'')) < 0 ) {
                            alert("시작일자가 종료일자보다 큽니다.");
                            dsT_ME_AHISTORY.RowPosition = i;
                            document.getElementById("txtSTR_YMD").focus();
                            return false;
                        }
                    }

                    // 소속
                    if( dsT_ME_AHISTORY.NameValue(i, "DPT_CD") == '' ) {
                        alert("소속은 필수 입력사항입니다.");
                        dsT_ME_AHISTORY.RowPosition = i;
                        document.getElementById("txtDPT_CD").focus();
                        return false;
                    }

                    // 소속
                    if (dsT_ME_AHISTORY.NameValue(i, "DPT_CD") != "" &&
                        dsT_ME_AHISTORY.NameValue(i, "DPT_NM") == "") {
                        alert("소속코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_ME_AHISTORY.RowPosition = i;
                        document.getElementById("txtDPT_CD").focus();
                        return;
                    }

                    // 팀
                    if (dsT_ME_AHISTORY.NameValue(i, "TEAM_CD") != "" &&
                        dsT_ME_AHISTORY.NameValue(i, "TEAM_NM") == "") {
                        alert("팀코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_ME_AHISTORY.RowPosition = i;
                        document.getElementById("txtTEAM_CD").focus();
                        return;
                    }

                    // 직위
                    if( dsT_ME_AHISTORY.NameValue(i, "JOB_CD") == '' ) {
                        alert("직위는 필수 입력사항입니다.");
                        dsT_ME_AHISTORY.RowPosition = i;
                        document.getElementById("txtJOB_CD").focus();
                        return false;
                    }

                    // 직위
                    if (dsT_ME_AHISTORY.NameValue(i, "JOB_CD") != "" &&
                        dsT_ME_AHISTORY.NameValue(i, "JOB_NM") == "") {
                        alert("직위코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_ME_AHISTORY.RowPosition = i;
                        document.getElementById("txtJOB_CD").focus();
                        return;
                    }

                    // 직책
                    if (dsT_ME_AHISTORY.NameValue(i, "DUTY_CD") != "" &&
                        dsT_ME_AHISTORY.NameValue(i, "DUTY_NM") == "") {
                        alert("직책코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_ME_AHISTORY.RowPosition = i;
                        document.getElementById("txtDUTY_CD").focus();
                        return;
                    }

                    // 직무
                    if (dsT_ME_AHISTORY.NameValue(i, "SRV_CD") != "" &&
                        dsT_ME_AHISTORY.NameValue(i, "SRV_NM") == "") {
                        alert("직무코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_ME_AHISTORY.RowPosition = i;
                        document.getElementById("txtSRV_CD").focus();
                        return;
                    }

                    // 부문
                    if (dsT_ME_AHISTORY.NameValue(i, "PART_CD") != "" &&
                        dsT_ME_AHISTORY.NameValue(i, "PART_NM") == "") {
                        alert("부문코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_ME_AHISTORY.RowPosition = i;
                        document.getElementById("txtPART_CD").focus();
                        return;
                    }

                    // 발령
                    if( dsT_ME_AHISTORY.NameValue(i, "APP_CD") == '' ) {
                        alert("발령은 필수 입력사항입니다.");
                        dsT_ME_AHISTORY.RowPosition = i;
                        document.getElementById("txtAPP_CD").focus();
                        return false;
                    }

                    // 발령
                    if (dsT_ME_AHISTORY.NameValue(i, "APP_CD") != "" &&
                        dsT_ME_AHISTORY.NameValue(i, "APP_NM") == "") {
                        alert("발령코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_ME_AHISTORY.RowPosition = i;
                        document.getElementById("txtAPP_CD").focus();
                        return;
                    }

                    // 재직
                    if( dsT_ME_AHISTORY.NameValue(i, "JCD_CD") == '' ) {
                        alert("재직은 필수 입력사항입니다.");
                        dsT_ME_AHISTORY.RowPosition = i;
                        document.getElementById("txtJCD_CD").focus();
                        return false;
                    }

                    // 재직
                    if (dsT_ME_AHISTORY.NameValue(i, "JCD_CD") != "" &&
                        dsT_ME_AHISTORY.NameValue(i, "JCD_NM") == "") {
                        alert("재직코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_ME_AHISTORY.RowPosition = i;
                        document.getElementById("txtJCD_CD").focus();
                        return;
                    }

                    // 근로구분
                    if( dsT_ME_AHISTORY.NameValue(i, "OCC_CD") == '' ) {
                        alert("근로구분은 필수 입력사항입니다.");
                        dsT_ME_AHISTORY.RowPosition = i;
                        document.getElementById("txtOCC_CD").focus();
                        return false;
                    }

                    // 근로구분
                    if (dsT_ME_AHISTORY.NameValue(i, "OCC_CD") != "" &&
                        dsT_ME_AHISTORY.NameValue(i, "OCC_NM") == "") {
                        alert("근로구분코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_ME_AHISTORY.RowPosition = i;
                        document.getElementById("txtOCC_CD").focus();
                        return;
                    }

                    // 회계소속
                    if( dsT_ME_AHISTORY.NameValue(i, "TAX_DPT") == '' ) {
                        alert("회계소속는 필수 입력사항입니다.");
                        dsT_ME_AHISTORY.RowPosition = i;
                        document.getElementById("txtTAX_DPT").focus();
                        return false;
                    }

                    // 회계소속
                    if (dsT_ME_AHISTORY.NameValue(i, "TAX_DPT") != "" &&
                        dsT_ME_AHISTORY.NameValue(i, "TAX_DPTNM") == "") {
                        alert("회계소속코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_ME_AHISTORY.RowPosition = i;
                        document.getElementById("txtTAX_DPT").focus();
                        return;
                    }

                    // 인사발령일 CHECK
                    if (!fnc_CheckDate2(dsT_ME_AHISTORY.NameValue(i, "APP_YMD"), "인사발령일") && dsT_ME_AHISTORY.NameValue(i, "APP_YMD") != "") {
                        dsT_ME_AHISTORY.RowPosition = i;
                        document.getElementById("txtAPP_YMD").focus();
                        return false;
                    }

                    if ( dsT_ME_AHISTORY.RowStatus(i) == 1) {
                        document.getElementById("txtSTR_YMD").disabled = true;
                        document.getElementById("ImgStrYmd").disabled  = true;
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
            cfStyleGrid(form1.grdT_ME_AHISTORY, 0,"false","false");

            fnc_SearchList();

        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            //이곳에 해당 코딩을 입력 하세요
            if (dsT_ME_AHISTORY.IsUpdated)  {
                if (!fnc_ExitQuestion()) return;
            }

            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            //fnc_HotKey_Process(btnList, event.keyCode);
            
            fnc_MEMA019_HotKey(event.ctrlKey, event.keyCode);            
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

                document.getElementById("txtSTR_YMD").disabled  = false;
                document.getElementById("txtSEQ_NO").disabled   = true;
                document.getElementById("txtEND_YMD").disabled  = false;
                document.getElementById("txtDPT_CD").disabled   = false;
                document.getElementById("txtTEAM_CD").disabled  = false;
                document.getElementById("txtDUTY_CD").disabled  = false;
                document.getElementById("txtPART_CD").disabled  = false;
                document.getElementById("txtAPP_CD").disabled   = false;
                document.getElementById("txtJCD_CD").disabled   = false;
                document.getElementById("txtAPP_YMD").disabled  = false;
                document.getElementById("txtREMARK").disabled   = false;
                document.getElementById("txtTAX_DPT").disabled  = false;

                document.getElementById("ImgStrYmd").disabled   = false;
                document.getElementById("ImgEndYmd").disabled   = false;
                document.getElementById("ImgDptCd").disabled    = false;
                document.getElementById("ImgTeamCd").disabled   = false;
                document.getElementById("ImgDutyCd").disabled   = false;
                document.getElementById("ImgPartCd").disabled   = false;
                document.getElementById("ImgAppCd").disabled    = false;
                document.getElementById("ImgJcdCd").disabled    = false;
                document.getElementById("ImgAppYmd").disabled   = false;
                document.getElementById("ImgTaxDpt").disabled   = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtSTR_YMD").disabled  = true;
                document.getElementById("txtSEQ_NO").disabled   = true;
                document.getElementById("txtEND_YMD").disabled  = true;
                document.getElementById("txtDPT_CD").disabled   = true;
                document.getElementById("txtTEAM_CD").disabled  = true;
                document.getElementById("txtDUTY_CD").disabled  = true;
                document.getElementById("txtPART_CD").disabled  = true;
                document.getElementById("txtAPP_CD").disabled   = true;
                document.getElementById("txtJCD_CD").disabled   = true;
                document.getElementById("txtAPP_YMD").disabled  = true;
                document.getElementById("txtREMARK").disabled   = true;
                document.getElementById("txtTAX_DPT").disabled  = true;

                document.getElementById("ImgStrYmd").disabled   = true;
                document.getElementById("ImgEndYmd").disabled   = true;
                document.getElementById("ImgDptCd").disabled    = true;
                document.getElementById("ImgTeamCd").disabled   = true;
                document.getElementById("ImgDutyCd").disabled   = true;
                document.getElementById("ImgPartCd").disabled   = true;
                document.getElementById("ImgAppCd").disabled    = true;
                document.getElementById("ImgJcdCd").disabled    = true;
                document.getElementById("ImgAppYmd").disabled   = true;
                document.getElementById("ImgTaxDpt").disabled   = true;

            }
        }


        function fnc_getSeqNo(obj) {
            var SysStatus = dsT_ME_AHISTORY.SysStatus(dsT_ME_AHISTORY.RowPosition);
            var SeqNo = 0;

            if (SysStatus == 1) {

                document.getElementById("txtSEQ_NO").value = '';

                if (obj.value != '') {

                    for (var i = 1; i <= dsT_ME_AHISTORY.CountRow; i++) {

                        if (dsT_ME_AHISTORY.NameValue(i, "STR_YMD") == obj.value &&
                            dsT_ME_AHISTORY.NameValue(i, "SEQ_NO") >= SeqNo &&
                            i != dsT_ME_AHISTORY.RowPosition) {

                           SeqNo = new Number(dsT_ME_AHISTORY.NameValue(i, "SEQ_NO")) + 1;

                        }
                    }

                    if (SeqNo == 0) {
                        SeqNo = 1;
                    }

                    document.getElementById("txtSEQ_NO").value = SeqNo;
                }
            }

            str_ymd = document.getElementById("txtSTR_YMD").value;
            seq_no  = document.getElementById("txtSEQ_NO").value;
        }

        function fnc_BlurYmd() {
            if (str_ymd == document.getElementById("txtSTR_YMD").value &&
                seq_no  == document.getElementById("txtSEQ_NO").value) {
                return;
            }

            fnc_getSeqNo(document.getElementById("txtSTR_YMD"));

        }

        function fnc_ChgBlurYmd() {

            fnc_getSeqNo(document.getElementById("txtSTR_YMD"));
            document.getElementById("txtAPP_YMD").value = document.getElementById("txtSTR_YMD").value;
        }

        /************************************************
         * 본부 및 소속코드 팝업창 처리                 *
         ************************************************/
        function fnc_DptNmPopup(gbn) {

            var obj = new String();

            if (gbn == 'DEPT') {
                obj.title = '소속';
                obj.gbn   = 'DEPT2';

                window.showModalDialog("/common/popup/codenm.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

                if(obj.comm_cd != '' && obj.comm_nm != '') {
                    document.getElementById('txtDPT_CD').value  = obj.comm_cd;
                    document.getElementById('txtDPT_NM').value  = obj.comm_nm;
                    document.getElementById('txtTEAM_CD').value = '';
                    document.getElementById('txtTEAM_NM').value = '';

                    // 해당 소속의 부문을 가져온다.
                    fnc_GetPartNm('txtDPT_CD','txtPART_CD','txtPART_NM');

                    // 선택한 코드의 구분이 본부이면
                    if (obj.cd_gbn == 'B2') {
                        document.getElementById('txtHEAD_CD').value = obj.comm_cd;
                        document.getElementById('txtHEAD_NM').value = obj.comm_nm;
                    }
                    else {

                        // 해당소속의 본부 찾아오기
                        // 소속코드
                        fnc_GetCommNm('A4', 'txtDPT_CD','txtDPT_NM', 'txtHEAD_CD');

                        // 본부코드명 찾아오기
                        fnc_GetCommNm('B2', 'txtHEAD_CD','txtHEAD_NM');

                    }
                }

                // 회계소속 입력
                document.getElementById('txtTAX_DPT').value = document.getElementById('txtDPT_CD').value;
                document.getElementById('txtTAX_DPTNM').value = document.getElementById('txtDPT_NM').value;

            }
            else if (gbn == 'TEAM') {
                if (document.getElementById("txtDPT_CD").value == "") {
                    alert("소속코드를 먼저 입력하신 후 팀코드 팝업창을 선택하여 주십시오.");
                    return;
                }
                else {
                    fnc_commnmPopup('txtTEAM_CD','txtTEAM_NM','팀','TEAM','txtDPT_CD');
                }
            }
        }

        /*************************************************
         * 직군, 직렬, 직무 및 직무코드 조회용 팝업      *
         ************************************************/
        function fnc_dutyPopup(ctrl_01, ctrl_02) {

            var obj = new String();

            window.showModalDialog("/common/popup/duty.jsp", obj, "dialogWidth:368px; dialogHeight:520px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if(obj.duty_cd != ''){

                document.getElementById(ctrl_01).value = obj.duty_cd;
                document.getElementById(ctrl_02).value = obj.duty_nm;
            }

        }

        /*************************************************
         * 소속 및 팀코드 입력시 해당 명 DISPLAY         *
         ************************************************/
        function fnc_CommNm(gbn) {
            var DEPT_CD = '';

            // 소속코드
            if (gbn == 'DEPT') {
                document.getElementById('txtHEAD_CD').value = "";
                document.getElementById('txtHEAD_NM').value = "";
                document.getElementById('txtTEAM_CD').value = "";
                document.getElementById('txtTEAM_NM').value = "";

                // 소속코드
                fnc_GetCommNm('A4', 'txtDPT_CD','txtDPT_NM', 'txtHEAD_CD');
				// 해당 소속의 부문을 가져온다.
                fnc_GetPartNm('txtDPT_CD','txtPART_CD','txtPART_NM');

				// 코드만 있고 코드명이 없으면 본부다 (소속에 본부도 입력 가능)
                if (document.getElementById('txtDPT_CD').value != "" && document.getElementById('txtDPT_NM').value == "") {
                    fnc_GetCommNm('B2', 'txtDPT_CD','txtDPT_NM');

                }

                // 상위본부코드 존재하면 해당 코드는 소속
                if (document.getElementById('txtHEAD_CD').value != "") {
                    // 본부코드
                    fnc_GetCommNm('B2', 'txtHEAD_CD','txtHEAD_NM');
                }
                // 상위본부코드 존재하지 않고 소속코드가 존재하면 소속코드 자체가 본부코드가 됨
                else {

                    if (document.getElementById('txtDPT_CD').value != "" && document.getElementById('txtDPT_NM').value != "") {
                        document.getElementById('txtHEAD_CD').value = document.getElementById('txtDPT_CD').value;
                        document.getElementById('txtHEAD_NM').value = document.getElementById('txtDPT_NM').value;
                    }
                    else {
                        document.getElementById('txtHEAD_CD').value = "";
                        document.getElementById('txtHEAD_NM').value = "";
                    }
                }

                // 회계소속 입력
                document.getElementById('txtTAX_DPT').value = document.getElementById('txtDPT_CD').value;
                document.getElementById('txtTAX_DPTNM').value = document.getElementById('txtDPT_NM').value;
            }
            // 팀코드
            else if (gbn == 'TEAM') {
                if (document.getElementById('txtDPT_CD').value != "" && document.getElementById('txtDPT_NM').value != "") {
                    if (document.getElementById('txtDPT_CD').value != document.getElementById('txtHEAD_CD').value) {

                        DEPT_CD = document.getElementById('txtDPT_CD').value;
                        fnc_GetCommNm('A6', 'txtTEAM_CD','txtTEAM_NM', 'txtDPT_CD');
                    }
                }
                else {
                    alert("소속코드를 먼저 입력하신 후 팀코드를 입력하여 주십시오.");
                    document.getElementById('txtTEAM_CD').value = "";
                    document.getElementById('txtTEAM_NM').value = "";
                    return;
                }
            }
        }

        function fnc_ClickBtn() {

            var StrYmd    = '';
            var SeqNo     = '';
            var iRow      = 0;
            var Row       = dsT_ME_AHISTORY.RowPosition;

            if (dsT_ME_AHISTORY.RowStatus(dsT_ME_AHISTORY.RowPosition) != 1) {
                // 해당 ROW가 신규가 아닌 경우 리턴
                alert("신규작업시만 최종정보를 복사할 수 있습니다.");
                return;
            }

            for (var i = 1; i <= dsT_ME_AHISTORY.CountRow; i++ ) {
                if (Row != i) {

                    if( dsT_ME_AHISTORY.NameValue(i, "STR_YMD") > StrYmd) {
                        StrYmd = dsT_ME_AHISTORY.NameValue(i, "STR_YMD");
                        SeqNo  = dsT_ME_AHISTORY.NameValue(i, "SEQ_NO");
                        iRow   = i;
                    }
                    else if (dsT_ME_AHISTORY.NameValue(i, "STR_YMD") == StrYmd &&
                             dsT_ME_AHISTORY.NameValue(i, "SEQ_NO") > SeqNo) {
                        StrYmd = dsT_ME_AHISTORY.NameValue(i, "STR_YMD");
                        SeqNo  = dsT_ME_AHISTORY.NameValue(i, "SEQ_NO");
                        iRow   = i;
                    }
                }
            }

            // 최종정보 담긴 Row 정보를 신규건에 저장
            if (iRow != 0) {
                // 본부코드
                dsT_ME_AHISTORY.NameValue(Row, "HEAD_CD") = dsT_ME_AHISTORY.NameValue(iRow, "HEAD_CD");
                dsT_ME_AHISTORY.NameValue(Row, "HEAD_NM") = dsT_ME_AHISTORY.NameValue(iRow, "HEAD_NM");

                // 소속코드
                dsT_ME_AHISTORY.NameValue(Row, "DPT_CD") = dsT_ME_AHISTORY.NameValue(iRow, "DPT_CD");
                dsT_ME_AHISTORY.NameValue(Row, "DPT_NM") = dsT_ME_AHISTORY.NameValue(iRow, "DPT_NM");

                // 팀코드
                dsT_ME_AHISTORY.NameValue(Row, "TEAM_CD") = dsT_ME_AHISTORY.NameValue(iRow, "TEAM_CD");
                dsT_ME_AHISTORY.NameValue(Row, "TEAM_NM") = dsT_ME_AHISTORY.NameValue(iRow, "TEAM_NM");

                // 직책코드
                dsT_ME_AHISTORY.NameValue(Row, "DUTY_CD") = dsT_ME_AHISTORY.NameValue(iRow, "DUTY_CD");
                dsT_ME_AHISTORY.NameValue(Row, "DUTY_NM") = dsT_ME_AHISTORY.NameValue(iRow, "DUTY_NM");

                // 부문코드
                dsT_ME_AHISTORY.NameValue(Row, "PART_CD") = dsT_ME_AHISTORY.NameValue(iRow, "PART_CD");
                dsT_ME_AHISTORY.NameValue(Row, "PART_NM") = dsT_ME_AHISTORY.NameValue(iRow, "PART_NM");

                // 재직코드
                dsT_ME_AHISTORY.NameValue(Row, "JCD_CD") = dsT_ME_AHISTORY.NameValue(iRow, "JCD_CD");
                dsT_ME_AHISTORY.NameValue(Row, "JCD_NM") = dsT_ME_AHISTORY.NameValue(iRow, "JCD_NM");

                // 회계소속
                dsT_ME_AHISTORY.NameValue(Row, "TAX_DPT")   = dsT_ME_AHISTORY.NameValue(iRow, "TAX_DPT");
                dsT_ME_AHISTORY.NameValue(Row, "TAX_DPTNM") = dsT_ME_AHISTORY.NameValue(iRow, "TAX_DPTNM");

                // 담당업무
                dsT_ME_AHISTORY.NameValue(Row, "REMARK") = dsT_ME_AHISTORY.NameValue(iRow, "REMARK");

            }
        }
        
        //각 폼의 단축키 처리
        function fnc_MEMA019_HotKey(CtrlKey, KeyCode) {

            //ctrl+L(각 입력단별 코드 조회)
            if(CtrlKey && KeyCode == 76){
                //alert("ctrl : "+CtrlKey + ",  key: " + KeyCode+", id : "+event.srcElement.id);
                var FocusId = event.srcElement.id;

                //document.getElementById(event.srcElement.id).value="";

                if(FocusId == "txtDPT_CD"){//소속
                    fnc_DptNmPopup('DEPT');

                }else if(FocusId == "txtTEAM_CD"){//팀
                    fnc_DptNmPopup('TEAM');

                //}else if(FocusId == "txtOCC_CD"){//근로구분
                //    fnc_commonCodePopup('txtOCC_CD','txtOCC_NM','근로구분','A1')

                //}else if(FocusId == "txtJOB_CD"){//직위
                //    fnc_ChkJobCd();

                //}else if(FocusId == "txtHOB_CD"){//호봉
                //    fnc_commonCodePopup('txtHOB_CD','txtHOB_NM','호봉','A3');

                }else if(FocusId == "txtDUTY_CD"){//직책
                    fnc_commonCodePopup('txtDUTY_CD','txtDUTY_NM','직책','A7');

                //}else if(FocusId == "txtSRV_CD"){//직무
                //    fnc_dutyPopup('txtSRV_CD','txtSRV_NM');

                }else if(FocusId == "txtPART_CD"){//부문
                    fnc_commonCodePopup('txtPART_CD','txtPART_NM','부문','B1');

                }else if(FocusId == "txtAPP_CD"){//발령
                    fnc_commonCodePopup('txtAPP_CD','txtAPP_NM','발령구분','J2');
                    fnc_GetHIR_YMD();

                }else if(FocusId == "txtJCD_CD"){//재직
                    fnc_commonCodePopup('txtJCD_CD','txtJCD_NM','재직구분','J3');

                }else if(FocusId == "txtTAX_DPT"){//회계
                    fnc_commnmPopup('txtTAX_DPT','txtTAX_DPTNM','소속','DEPT');
                }

            }


        }
        
        //자동으로 대문자로 변환
        function fnc_UpperCase(obj){
        
            obj.value = obj.value.toUpperCase();
                
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
    | 2. 이름 : dsT_ME_AHISTORY                     |
    | 3. Table List : T_ME_AHISTORY                 |
    +----------------------------------------------->
    <Object ID="dsT_ME_AHISTORY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_ME_AHISTORY                       |
    | 3. Table List : T_ME_AHISTORY                   |
    +----------------------------------------------->
    <Object ID ="trT_ME_AHISTORY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ME_AHISTORY)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ME_AHISTORY Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            //fnc_ColEnabled('D');

            //입사후 경력이 없으면 반드시 입력이 되어야 한다.
            document.getElementById("resultMessage").innerText = " ";
            fnc_AddNew();

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ME_AHISTORY.CountRow);

            document.getElementById("txtSTR_YMD").disabled = true;
            document.getElementById("ImgStrYmd").disabled  = true;

        }

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_ME_AHISTORY Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ME_AHISTORY Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018 ) {
            alert("해당 필수입력항목[시작일자/SEQ번호] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50020) {
            alert("시작일자/SEQ번호에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_ME_AHISTORY event="OnSuccess()">

        // 재조회
        parent.fnc_SearchList();
        fnc_SearchList();

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_ME_AHISTORY event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_ME_AHISTORY Event="OnRowPosChanged(row)">

        var SysStatus = dsT_ME_AHISTORY.SysStatus(row);

        if (SysStatus == 1) {
            document.getElementById("txtSTR_YMD").disabled = false;
            document.getElementById("ImgStrYmd").disabled  = false;

        }
        else {
            document.getElementById("txtSTR_YMD").disabled = true;
            document.getElementById("ImgStrYmd").disabled  = true;

        }

    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<body onkeyup="fnc_HotKey()" onload="fnc_OnLoadProcess();" oncontextmenu="return false">

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
            <strong>입사후경력</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgInforcopy','','/images/button/btn_InforcopyOver.gif',1)"><img src="/images/button/btn_InforcopyOn.gif" name="imgInforcopy"    width="100" height="20" border="0" align="absmiddle" onClick="fnc_ClickBtn();"></a>
            &nbsp;&nbsp;
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAdd','','/images/button/btn_AddnewOver.gif',1)">   <img src="/images/button/btn_AddnewOn.gif" name="imgAdd"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
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
                    <col width="70 "></col>
                    <col width="130"></col>
                    <col width="70 "></col>
                    <col width="130"></col>
                    <col width="70 "></col>
                    <col width="130"></col>
                    <col width="70 "></col>
                    <col width="130"></col>
                </colgroup>
                <tr>
                    <input type=hidden id="txtHEAD_CD">
                    <input type=hidden id="txtHEAD_NM">
                    <td align="center" class="creamBold">시 작 일</td>
                    <td class="padding2423" >
                        <input id="txtSTR_YMD" style="width:77%;ime-mode:disabled" maxlength="10" onBlur="fnc_BlurYmd();" onChange="if (fnc_CheckDate(this, '시작일')) {fnc_ChgBlurYmd();}" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStrYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgStrYmd" name="ImgStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD','','10','53');"></a>
                    </td>
                    <td align="center" class="creamBold">종 료 일</td>
                    <td class="padding2423" >
                        <input id="txtEND_YMD" style="width:77%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '종료일');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEndYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEndYmd" name="ImgEndYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','410','53');"></a>
                    </td>
                    <input type=hidden id="txtSEQ_NO" style="width:100%;ime-mode:disabled;text-align:right;">
                    <td align="center" class="creamBold">소속코드</td>
                    <td class="padding2423">
                        <input id="txtDPT_CD" style="width:20%;ime-mode:inactive" maxlength="2" onChange="fnc_CommNm('DEPT');"> <input id="txtDPT_NM" style="width:52%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_DptNmPopup('DEPT');"></a>
                    </td>
                    <td align="center" class="creamBold">팀 코 드</td>
                    <td class="padding2423">
                        <input id="txtTEAM_CD" style="width:20%;ime-mode:inactive" maxlength="2" onChange="fnc_CommNm('TEAM');"> <input id="txtTEAM_NM" style="width:52%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgTeamCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgTeamCd" name="ImgTeamCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_DptNmPopup('TEAM');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">근로구분코드</td>
                    <td class="padding2423">
                        <input id="txtOCC_CD" style="width:20%" maxlength="2" onChange="fnc_GetCommNm('A1', 'txtOCC_CD','txtOCC_NM')" class="input_ReadOnly"  readonly> <input id="txtOCC_NM" style="width:74%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">직위코드</td>
                    <td class="padding2423">
                        <input id="txtJOB_CD" style="width:20%" maxlength="2" onChange="fnc_GetCommNm('A2', 'txtJOB_CD','txtJOB_NM')" class="input_ReadOnly"  readonly> <input id="txtJOB_NM" style="width:74%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">직책코드</td>
                    <td class="padding2423">
                        <input id="txtDUTY_CD" style="width:20%;ime-mode:inactive" maxlength="2" onChange="fnc_GetCommNm('A7', 'txtDUTY_CD', 'txtDUTY_NM')"> <input id="txtDUTY_NM" style="width:52%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDutyCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDutyCd" name="ImgDutyCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtDUTY_CD','txtDUTY_NM','직책','A7')"></a>
                    </td>

                    <td align="center" class="creamBold">부문코드</td>
                    <td class="padding2423">
                        <input id="txtPART_CD" style="width:20%;ime-mode:inactive" maxlength="2" onChange="fnc_GetCommNm('B1', 'txtPART_CD','txtPART_NM')"> <input id="txtPART_NM" style="width:52%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPartCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgPartCd" name="ImgPartCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtPART_CD','txtPART_NM','부문','B1')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">발령코드</td>
                    <td class="padding2423">
                        <input id="txtAPP_CD" style="width:20%;ime-mode:inactive" maxlength="3" onChange="fnc_GetCommNm('J2', 'txtAPP_CD','txtAPP_NM')"> <input id="txtAPP_NM" style="width:52%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgAppCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgAppCd" name="ImgAppCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtAPP_CD','txtAPP_NM','발령구분','J2')"></a>
                    </td>
                    <td align="center" class="creamBold">재직코드</td>
                    <td class="padding2423">
                        <input id="txtJCD_CD" style="width:20%;ime-mode:inactive" maxlength="3" onChange="fnc_GetCommNm('J3', 'txtJCD_CD','txtJCD_NM')"> <input id="txtJCD_NM" style="width:52%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgJcdCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgJcdCd" name="ImgJcdCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtJCD_CD','txtJCD_NM','재직구분','J3')"></a>
                    </td>
                    <td align="center" class="creamBold">회계소속</td>
                    <td class="padding2423">
                        <input id="txtTAX_DPT" style="width:20%;ime-mode:inactive" maxlength="2" onChange="fnc_GetCommNm('A4','txtTAX_DPT','txtTAX_DPTNM');"> <input id="txtTAX_DPTNM" style="width:52%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgTaxDpt','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgTaxDpt" name="ImgTaxDpt" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtTAX_DPT','txtTAX_DPTNM','소속','DEPT');"></a>
                    </td>
                    <td align="center" class="creamBold">인사발령일</td>
                    <td class="padding2423" >
                        <input id="txtAPP_YMD" style="width:77%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '인사발령일');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgAppYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgAppYmd" name="ImgAppYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtAPP_YMD','','220','103');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">담당업무</td>
                    <td class="padding2423">
                        <input id="txtREMARK" style="width:100%" maxlength="60">
                    </td>
                    <input type=hidden   id="txtENO_NO" size="10">
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
                        <object id="grdT_ME_AHISTORY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:794px;height:130px;">
                            <param name="DataID"                  value="dsT_ME_AHISTORY">
                            <param name="Format"                  value="
                                <C> id={currow}        width=30   name='순번'         align=center </C>
                                <C> id=STR_YMD         width=70   name='시작일'       align=center </C>
                                <C> id=SEQ_NO          width=30   name='SEQ'          align=center </C>
                                <C> id=END_YMD         width=70   name='종료일'       align=center </C>
                                <C> id=HEAD_CD         width=50   name='본부코드'     align=center </C>
                                <C> id=HEAD_NM         width=100  name='본부'                      </C>
                                <C> id=DPT_CD          width=50   name='소속코드'     align=center </C>
                                <C> id=DPT_NM          width=100  name='소속'                      </C>
                                <C> id=TEAM_CD         width=50   name='팀코드'       align=center </C>
                                <C> id=TEAM_NM         width=70   name='팀'                        </C>
                                <C> id=JOB_CD          width=50   name='직위코드'     align=center </C>
                                <C> id=JOB_NM          width=70   name='직위'                      </C>
                                <C> id=DUTY_CD         width=50   name='직책코드'     align=center </C>
                                <C> id=DUTY_NM         width=70   name='직책'                      </C>
                                <C> id=PART_CD         width=50   name='부문코드'     align=center </C>
                                <C> id=PART_NM         width=100  name='부문'                      </C>
                                <C> id=APP_CD          width=50   name='발령코드'     align=center </C>
                                <C> id=APP_NM          width=100  name='발령구분'                  </C>
                                <C> id=JCD_CD          width=50   name='재직코드'     align=center </C>
                                <C> id=JCD_NM          width=70   name='재직구분'                  </C>
                                <C> id=OCC_CD          width=50   name='근로구분코드'     align=center </C>
                                <C> id=OCC_NM          width=70   name='근로구분구분'                  </C>
                                <C> id=APP_YMD         width=70   name='인사발령일'   align=center </C>
                                <C> id=REMARK          width=160  name='담당업무'                  </C>
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
<!-- 입사후경력 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ME_AHISTORY">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=STR_YMD       Ctrl=txtSTR_YMD      Param=value </C>
        <C> Col=SEQ_NO        Ctrl=txtSEQ_NO       Param=value </C>
        <C> Col=END_YMD       Ctrl=txtEND_YMD      Param=value </C>
        <C> Col=HEAD_CD       Ctrl=txtHEAD_CD      Param=value </C>
        <C> Col=HEAD_NM       Ctrl=txtHEAD_NM      Param=value </C>
        <C> Col=DPT_CD        Ctrl=txtDPT_CD       Param=value </C>
        <C> Col=DPT_NM        Ctrl=txtDPT_NM       Param=value </C>
        <C> Col=TEAM_CD       Ctrl=txtTEAM_CD      Param=value </C>
        <C> Col=TEAM_NM       Ctrl=txtTEAM_NM      Param=value </C>
        <C> Col=JOB_CD        Ctrl=txtJOB_CD       Param=value </C>
        <C> Col=JOB_NM        Ctrl=txtJOB_NM       Param=value </C>
        <C> Col=DUTY_CD       Ctrl=txtDUTY_CD      Param=value </C>
        <C> Col=DUTY_NM       Ctrl=txtDUTY_NM      Param=value </C>
        <C> Col=PART_CD       Ctrl=txtPART_CD      Param=value </C>
        <C> Col=PART_NM       Ctrl=txtPART_NM      Param=value </C>
        <C> Col=APP_CD        Ctrl=txtAPP_CD       Param=value </C>
        <C> Col=APP_NM        Ctrl=txtAPP_NM       Param=value </C>
        <C> Col=JCD_CD        Ctrl=txtJCD_CD       Param=value </C>
        <C> Col=JCD_NM        Ctrl=txtJCD_NM       Param=value </C>
        <C> Col=OCC_CD        Ctrl=txtOCC_CD       Param=value </C>
        <C> Col=OCC_NM        Ctrl=txtOCC_NM       Param=value </C>
        <C> Col=APP_YMD       Ctrl=txtAPP_YMD      Param=value </C>
        <C> Col=REMARK        Ctrl=txtREMARK       Param=value </C>
        <C> Col=TAX_DPT       Ctrl=txtTAX_DPT      Param=value </C>
        <C> Col=TAX_DPTNM     Ctrl=txtTAX_DPTNM    Param=value </C>
    '>
</object>