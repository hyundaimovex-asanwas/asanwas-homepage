<!--
    ************************************************************************************
    * @Source         : mema010.jsp                                                    *
    * @Description    : 인사기록정보 PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/01/16  |  박인이   | 최초작성                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ include file="/common/sessionCheck.jsp"%>


<html>
    <head>
    <title>인사기록정보</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

<%
    Configuration conf = Configuration.getInstance();

    String FILEURL = conf.get("framework.file.upload.pds");
%>

    <!--
    ******************************************************
    * 자바스크립트 함수 선언부분
    ******************************************************
    -->
    <script language="javascript" >

        var btnList = 'TTTTFFFT';
        var imgBox  = null;        // 업로드된 사진 보여주기

        //모달창으로 띄웠을 경우 구분하기 위해 사용
        var dsTemp = window.dialogArguments;

        var savflag = '';
        var ahiflag = '';

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            if (document.getElementById("txtENO_NO").value == "") {

                alert("사번/성명을 먼저 입력하신 다음 작업하여 주시기 바랍니다.");
                document.getElementById("txtENO_NM").focus();

                return;

            }

            dsT_ME_PERSON.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema010.cmd.MEMA010CMD&S_MODE=SHR&ENO_NO="+document.getElementById("txtENO_NO").value;
            dsT_ME_PERSON.Reset();

            if (document.getElementById("txtENO_NO").disabled == false) {
                document.getElementById("txtENO_NM").focus();
            }

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

                trT_ME_PERSON.KeyValue = "SVL(I:SAV=dsT_ME_PERSON)";
                trT_ME_PERSON.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema010.cmd.MEMA010CMD&S_MODE=SAV&ENO_NO="+document.getElementById("txtENO_NO").value+"&HEAD_CD="+document.getElementById("txtHEAD_CD").value+"&DPT_CD="+document.getElementById("txtDPT_CD").value;
                trT_ME_PERSON.post();

   				//입사후 경력 존재여부 확인
				ahiflag = 'SAV';
	            dsT_ME_AHISTORY.DataId = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema019.cmd.MEMA019CMD&S_MODE=SHR&ENO_NO="+document.getElementById("txtENO_NO").value;
	            dsT_ME_AHISTORY.Reset();

            }
            else {
                fnc_TabSave();
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
            var ENO_NO = document.getElementById('txtENO_NO').value;

            if (ENO_NO == "") {
                alert("사번을 입력하여 화면을 조회하신 후에 작업하시기 바랍니다.");
                return;
            }

            if (dsT_ME_PERSON.CountRow < 1) {
                alert("입력하신 사번으로 화면을 조회하신 후에 작업하시기 바랍니다.");
                return;
            }

            if (dsT_ME_PERSON.RowStatus(dsT_ME_PERSON.RowPosition) == 1) {
                alert("신규작업인 경우 화면을 먼저 저장하신 후에 작업하시기 바랍니다..");
                return;
            }

			//파견사원 인사정보출력 링크
			window.showModalDialog("/hr/pir/pird020.jsp", dsT_ME_PERSON, "dialogWidth:840px; dialogHeight:580px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

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
            if (dsT_ME_PERSON.CountColumn == 0) {
                dsT_ME_PERSON.setDataHeader("ENO_NO:STRING:NOTNULL, OCC_CD:STRING, ENO_NM:STRING:NOTNULL, NAM_ENG:STRING, NAM_CHI:STRING, MF_TAG:STRING, BIR_YMD:STRING, BIR_TAG:STRING, CET_NO:STRING, HEAD_CD:STRING, REG_CD:STRING, DPT_CD:STRING, JOB_CD:STRING, DUTY_CD:STRING, TEAM_CD:STRING, HIR_YMD:STRING, TERM1_YMD:STRING, TERM2_YMD:STRING");
            }

            if (dsT_ME_PERSON.IsUpdated ) {
                alert("해당 필수입력항목[사번/성명]을 입력하지 않으셨거나 변경사항이 존재합니다.\n해당 작업 종료한 후에 신규 작업을 하시기 바랍니다.");
                document.getElementById("txtENO_NM").focus();
                return;
            }

            fnc_Clear();
            dsT_ME_PERSON.ClearData();

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_ME_PERSON.AddRow();

            // 탭의 초기화면 호출
            fnc_ClickTab(1);

            // KEY 필드는 신규시 입력 가능
            document.getElementById("txtENO_NO").disabled = false;
            document.getElementById("cmbBIR_TAG").value = 'S';

            fnc_ColEnabled('E');

            form1.txtENO_NM.focus();
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

            document.getElementById("txtENO_NO").value    = '';
            document.getElementById("txtENO_NM").value    = '';
            document.getElementById("txtNAM_CHI").value   = '';
            document.getElementById("txtBIR_YMD").value   = '';
            document.getElementById("txtAGE").value       = '';
            document.getElementById("cmbBIR_TAG").value   = '';
            document.getElementById("txtNAM_ENG").value   = '';
            document.getElementById("txtCET_NO").value    = '';
            document.getElementById("cmbMF_TAG").value    = '';
            document.getElementById("txtHIR_YMD").value   = '';
            document.getElementById("txtHEAD_CD").value   = '';
            document.getElementById("txtHEAD_NM").value   = '';
            document.getElementById("txtOCC_CD").value    = '';
            document.getElementById("txtOCC_NM").value    = '';
            document.getElementById("txtTERM1_YMD").value = '';
            document.getElementById("txtTERM2_YMD").value = '';
            document.getElementById("txtDPT_CD").value    = '';
            document.getElementById("txtDPT_NM").value    = '';
            document.getElementById("txtJOB_CD").value    = '';
            document.getElementById("txtJOB_NM").value    = '';
            document.getElementById("txtTEAM_CD").value   = '';
            document.getElementById("txtTEAM_NM").value   = '';
            document.getElementById("txtDUTY_CD").value   = '';
            document.getElementById("txtDUTY_NM").value   = '';
            document.getElementById("txtREG_CD").value    = '';
            document.getElementById("txtREG_NM").value    = '';

            document.getElementById("resultMessage").innerText = ' ';

            dsT_ME_PERSON.ClearData();

            for (var i = 1; i <= 11; i++) {
                document.getElementById('view_'+i).style.display='none';
            }

            document.getElementById('view_1').style.display='inline';

            // 서브탭 초기화면 호출
            fnc_ViewFrame(1);
            fnc_ViewFrameTab(1);

            fnc_ColEnabled('D');

            // 이미지 초기화
            var ENO_NO = '';
            var FILEURL = "<%=FILEURL%>" + "/" + ENO_NO + ".jpg";

            imgBox.setImage(FILEURL);

            old_enono = "";

            document.getElementById("txtENO_NO").disabled = false;
            document.getElementById("txtENO_NM").focus();

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

            if (dsT_ME_PERSON.OrgNameString(dsT_ME_PERSON.RowPosition,"ENO_NO") != document.getElementById("txtENO_NO").value) {
                alert("사번은 변경할 수 없습니다!");
                document.getElementById("txtENO_NO").value = dsT_ME_PERSON.OrgNameString(dsT_ME_PERSON.RowPosition,"ENO_NO");
                document.getElementById("txtENO_NM").focus();
                return false;
            }

            //DataSet의 변경 여부 확인
            if (!dsT_ME_PERSON.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }

            // 사번 CHECK
            if (document.getElementById("txtENO_NO").value.substr(0,1) != '8' &&
                document.getElementById("txtENO_NO").value.substr(0,1) != '9') {
                alert("유효한 사번이 아닙니다. 확인바랍니다.");
                document.getElementById("txtENO_NO").focus();
                return false;
            }

            // 국문성명
            if (document.getElementById("txtENO_NM").value == "") {
                alert("국문성명은 필수 입력사항입니다.");
                document.getElementById("txtENO_NM").focus();
                return false;
            }

            // 생년월일
            if (document.getElementById("txtBIR_YMD").value == "") {
                alert("생년월일은 필수 입력사항입니다.");
                document.getElementById("txtBIR_YMD").focus();
                return false;
            }

            // 생년월일 CHECK
            if (!fnc_CheckDate(document.getElementById("txtBIR_YMD"), '생년월일')) {
                document.getElementById("txtBIR_YMD").focus();
                return false;
            }

            // 주민번호
            if (document.getElementById("txtCET_NO").value == "") {
                alert("주민번호는 필수 입력사항입니다.");
                document.getElementById("txtCET_NO").focus();
                return false;
            }

            // 주민번호 CHECK
            if (!fnc_SsnValid(document.getElementById("txtCET_NO"))) {
                document.getElementById("txtCET_NO").focus();
                return false;
            }

            // 성별 CHECK
            if ((document.getElementById("txtCET_NO").value.substr(7,1) == "1" &&  document.getElementById("cmbMF_TAG").value != "M") ||
                (document.getElementById("txtCET_NO").value.substr(7,1) == "2" &&  document.getElementById("cmbMF_TAG").value != "W")) {
                alert("잘못된 성별입니다. 확인하시기 바랍니다.");
                document.getElementById("cmbMF_TAG").focus();
                return false;
            }

            // 당사투입일
            if (document.getElementById("txtHIR_YMD").value == "") {
                alert("당사투입일은 필수 입력사항입니다.");
                document.getElementById("txtHIR_YMD").focus();
                return false;
            }

            // 당사투입일 CHECK
            if (!fnc_CheckDate(document.getElementById("txtHIR_YMD"), '당사투입일') && document.getElementById("txtHIR_YMD").value != "") {
                document.getElementById("txtHIR_YMD").focus();
                return false;
            }

            // 1차계약기간 CHECK
            if (!fnc_CheckDate(document.getElementById("txtTERM1_YMD"), '1차계약기간') && document.getElementById("txtTERM1_YMD").value != "") {
                document.getElementById("txtTERM1_YMD").focus();
                return false;
            }

            // 2차계약기간 CHECK
            if (!fnc_CheckDate(document.getElementById("txtTERM2_YMD"), '2차계약기간') && document.getElementById("txtTERM2_YMD").value != "") {
                document.getElementById("txtTERM2_YMD").focus();
                return false;
            }

            return true;
        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            imgBox = new Image(document.form1.viewImage);

            fnc_ColEnabled('D');

            // 탭의 초기화면 호출
            fnc_ClickTab(1);

            document.getElementById("txtENO_NO").disabled   = false;

            // 타화면으로부터 호출된 경우 해당 사번으로 파견사원 조회
            if (dsTemp != null) {
                document.getElementById("txtENO_NO").value = dsTemp.eno_no;

                document.getElementById("ImgAddNew").disabled = true;

                fnc_SearchList();
            }
            else {

                document.getElementById("ImgAddNew").disabled = false;

            }

            document.getElementById("txtENO_NM").focus();
        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            //이곳에 해당 코딩을 입력 하세요
            if (dsT_ME_PERSON.IsUpdated)  {
                if (!fnc_ExitQuestion()) return;
            }

            if (dsTemp != null) {
                window.close();
            }
            else {
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


        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

        var old_i = 0;                 // 탭 번호
        var old_u = 0;                 // 서브탭번호
        var old_enono = '';            // 사번(탭클릭시 현재 입력된 사번과 비교하기 위함)

        /***************************************
         * 입력부의 컬럼의 Disabled 속성 바꿈  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // 해당 컬럼의 속성을 Enabled로 변경
            if (prop == 'E') {

                document.getElementById("txtNAM_CHI").disabled  = false;
                document.getElementById("txtBIR_YMD").disabled  = false;
                document.getElementById("txtAGE").disabled      = false;
                document.getElementById("cmbBIR_TAG").disabled  = false;
                document.getElementById("txtNAM_ENG").disabled  = false;
                document.getElementById("txtCET_NO").disabled   = false;
                document.getElementById("cmbMF_TAG").disabled   = false;
                document.getElementById("txtHIR_YMD").disabled  = false;
                document.getElementById("txtHEAD_CD").disabled  = false;
                document.getElementById("txtOCC_CD").disabled   = false;
                document.getElementById("txtTERM1_YMD").disabled = false;
                document.getElementById("txtTERM2_YMD").disabled = false;
                document.getElementById("txtDPT_CD").disabled   = false;
                document.getElementById("txtJOB_CD").disabled   = false;
                document.getElementById("txtTEAM_CD").disabled  = false;
                document.getElementById("txtREG_CD").disabled   = false;

                document.getElementById("ImgBirYmd").disabled  = false;
                document.getElementById("ImgHirYmd").disabled  = false;
                document.getElementById("ImgTerm1Ymd").disabled = false;
                document.getElementById("ImgTerm2Ymd").disabled = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtNAM_CHI").disabled  = true;
                document.getElementById("txtBIR_YMD").disabled  = true;
                document.getElementById("txtAGE").disabled      = true;
                document.getElementById("cmbBIR_TAG").disabled  = true;
                document.getElementById("txtNAM_ENG").disabled  = true;
                document.getElementById("txtCET_NO").disabled   = true;
                document.getElementById("cmbMF_TAG").disabled   = true;
                document.getElementById("txtHIR_YMD").disabled  = true;
                document.getElementById("txtHEAD_CD").disabled  = true;
                document.getElementById("txtOCC_CD").disabled   = true;
                document.getElementById("txtTERM1_YMD").disabled = true;
                document.getElementById("txtTERM2_YMD").disabled = true;
                document.getElementById("txtDPT_CD").disabled   = true;
                document.getElementById("txtJOB_CD").disabled   = true;
                document.getElementById("txtTEAM_CD").disabled  = true;
                document.getElementById("txtREG_CD").disabled   = true;

                document.getElementById("ImgBirYmd").disabled  = true;
                document.getElementById("ImgHirYmd").disabled  = true;
                document.getElementById("ImgTerm1Ymd").disabled = true;
                document.getElementById("ImgTerm2Ymd").disabled = true;

            }

        }

        /*********************************
         * 탭버튼 클릭시 해당 화면 호출  *
         *********************************/
        function fnc_ClickTab(i) {
            var ENO_NO = document.getElementById('txtENO_NO').value;

            if (ENO_NO == "" && i != 1 && i != 11) {
                alert("사번을 입력하여 화면을 조회하신 후에 작업하시기 바랍니다.");
                return;
            }

            if (dsT_ME_PERSON.CountRow < 1 && i != 1 && i != 11) {
                alert("입력하신 사번으로 화면을 조회하신 후에 작업하시기 바랍니다.");
                return;
            }

            if (dsT_ME_PERSON.RowStatus(dsT_ME_PERSON.RowPosition) == 1 && i != 1) {
                alert("신규작업인 경우 화면을 먼저 저장하신 후에 작업하시기 바랍니다..");
                return;
            }

            fnc_ViewFrame(i);

        }

        /********************************************
         * 탭화면 호출시 관련 jsp 가져와 뿌려준다.  *
         ********************************************/
        function fnc_ViewFrame(i) {

            var ENO_NO = document.getElementById('txtENO_NO').value;
            var iframe = document.getElementById("iframe_"+i);

            // 이전과 다른 탭을 클릭한 경우 이전화면은 보이지 않고, 새로운 화면을 보임
            if (old_i != i && old_i != 0) {

                document.getElementById('view_'+old_i).style.display='none';
            }

            document.getElementById('view_'+i).style.display='inline';

            if (i != 1) {

                if (iframe.src == "about:blank") {

                    // 사번생성은 정규/파견사원구분위한 값 넘겨줌
                    if (i != 11) {
                        iframe.src = iframe.load_src + "?ENO_NO=" + ENO_NO;
                    }
                    else {
                        iframe.src = iframe.load_src + "?ENO_NO=" + ENO_NO+"&srcid=mema010";
                    }

                }
                else {

                    // 사번이 변경되는 경우 현재 보여지는 탭의 정보를 다시 가져오기 위함
                    //if (iframe.contentWindow.document.getElementById("ENO_NO").value != ENO_NO) {

                        iframe.contentWindow.document.getElementById("ENO_NO").value = ENO_NO;

                        if (i != 11) {
                            iframe.contentWindow.fnc_SearchList();
                        }

                    //}
                }
            }
            else {

                fnc_ViewFrameTab(1);

            }

            old_i=i;
            old_enono = ENO_NO;

        }

        /*******************************************************
         * 탭화면안의 서브탭 호출시 관련 jsp 가져와 뿌려준다.  *
         *******************************************************/
        function fnc_ViewFrameTab(u) {

            var ENO_NO = document.getElementById("txtENO_NO").value;
            var iframe = document.getElementById("iframe_tab_"+u);

            // 이전과 다른 탭을 클릭한 경우 이전화면은 보이지 않고, 새로운 화면을 보임
            if (old_u != u && old_u != 0) {

                document.getElementById('view_tab_'+old_u).style.display='none';
            }

            document.getElementById('view_tab_'+u).style.display='inline';

            if (iframe.src == "about:blank") {

              iframe.src = iframe.load_src + "?ENO_NO=" + ENO_NO;
            }
            else {

                // 사번이 변경되는 경우 현재 보여지는 탭의 정보를 다시 가져오기 위함
                if (iframe.contentWindow.document.getElementById("ENO_NO").value != ENO_NO) {

                    iframe.contentWindow.document.getElementById("ENO_NO").value = ENO_NO;
                    iframe.contentWindow.fnc_SearchList();


                }else if(u == "1"){//인사기본2는 파견정보 때문에 무조건 다시조회
					iframe.src = iframe.load_src + "?ENO_NO=" + ENO_NO;
                }
            }

            old_u=u;

            document.getElementById("resultMessage").innerText = ' ';

        }

        /*************************************************************************
         * 서버의 업로드 디렉토리의 이미지를 뿌려주는 User Defined Object
         * - usage : var obj = new Image(이미지테그의ID);
         *               obj.setImage("서버의 이미지파일의 위치및 파일명");
         *************************************************************************/
        function Image(imgTag) {
            var imgTag = imgTag;
            var action = "/servlet/JspChannelSVL?cmd=com.shift.gef.generic.cmd.RetrieveGenericImageCMD";
            var imgUrl = "";

            this.setImage = function(imgBox) {
                imgUrl = imgBox;
                imgTag.src = action + "&IMAGE=" +imgUrl;
            }

        }

        /********************************************************************
         * 조회된 화면에서 사번 변경시 변경된 사번에 대한 내용을 조회해옴
         ********************************************************************/
        function fnc_chkEnoNo() {

            if (dsT_ME_PERSON.CountRow > 0) {
                if (document.getElementById("txtENO_NO").value  == "") {
                    fnc_Clear();
                    return;
                }

                if (document.getElementById("txtENO_NO").value != dsT_ME_PERSON.OrgNameValue(1, "ENO_NO")) {
                    fnc_SearchList();
                }
            }
        }

        /********************************************************************
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         ********************************************************************/
        function fnc_ClickEmpPopup() {

            fnc_empl3Popup('txtENO_NO','txtENO_NM','','','','','2');

            if (document.getElementById("txtENO_NO").value  != "") {
                fnc_SearchList();
            }

        }

        function fnc_UsrGetEnoNo() {

            if (document.getElementById("txtENO_NM").value  == "") {

                fnc_Clear();
                return;
            }

            // 파견사원 전체
            fnc_GetEnoNo('txtENO_NM', 'txtENO_NO', '2');

            if (document.getElementById("txtENO_NO").value  == "") {

                fnc_Clear();
                return;
            }
            else {

                fnc_SearchList();
            }
        }


        function fnc_SsnValid(obj) {
            if (obj.value != "") {
                if (!covSsnValidator_validate(removeChar(obj.value,'-'))) {
                    alert("잘못된 주민번호입니다. 확인바랍니다.");
                    return false;
                }
            }

            return true;
        }

        function fnc_setMfTag() {

            // 성별이 남자인 경우
            if (document.getElementById("txtCET_NO").value.substr(7,1) == '1') {
                dsT_ME_PERSON.NameValue(1, "MF_TAG") = 'M';
            }
            // 성별이 여자인 경우
            else if (document.getElementById("txtCET_NO").value.substr(7,1) == '2') {
                dsT_ME_PERSON.NameValue(1, "MF_TAG") = 'W';
            }
        }

        function fnc_TabSave() {
            var ENO_NO = document.getElementById('txtENO_NO').value;
            var tmp_i = 0;
            var tmp_u = 0;
            var Msg = '';

            Msg = document.getElementById("resultMessage").innerText;

            tmp_i = old_i;
            tmp_u = old_u;

            if (old_i != 1) {

                fnc_ViewFrame(1);
            }

            // 인사기본2, 3, 4  변경사항 존재시 저장
            for (var k = 1; k <= 3; k++) {
                var iTabframe = document.getElementById('iframe_tab_'+k);

                if (iTabframe.src != "about:blank") {

                    if (iTabframe.contentWindow.document.getElementById("ENO_NO").value == ENO_NO) {

                        fnc_ViewFrameTab(k);

                        if (!iTabframe.contentWindow.fnc_Save()) {

                            old_u = k;
                            return;
                        }
                    }
                }
            }

            if (tmp_i != 1) {
                fnc_ViewFrame(tmp_i);
            }
            else {
                fnc_ViewFrameTab(tmp_u);
            }

            if (savflag == '1') {
                fnc_Message(document.getElementById("resultMessage"), "MSG_01");
                savflag = '';
            }
            else {
                document.getElementById("resultMessage").innerText = Msg;
            }

            old_i = tmp_i;
            old_u = tmp_u;
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
    | 2. 이름 : dsT_ME_PERSON                       |
    | 3. Table List : T_ME_PERSON                   |
    +----------------------------------------------->
    <Object ID="dsT_ME_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_ME_AHISTORY                     |
    | 3. Table List : T_ME_AHISTORY                   |
    +----------------------------------------------->
    <Object ID="dsT_ME_AHISTORY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_ME_PERSON                       |
    | 3. Table List : T_ME_PERSON                   |
    +----------------------------------------------->
    <Object ID ="trT_ME_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_ME_PERSON Event="OnLoadCompleted(iCount)">

        var ENO_NO  = "";
        var FILEURL = "";

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ME_PERSON.CountRow);

        }

        ENO_NO = dsT_ME_PERSON.NameValue(1, "ENO_NO");
        FILEURL = "<%=FILEURL%>" + "/" + ENO_NO + ".jpg";

        imgBox.setImage(FILEURL);

        document.getElementById("txtENO_NO").disabled = false;
        document.getElementById("txtENO_NM").focus();

        if (old_i == 0) {
            return;
        }

        // 현재 탭이 기본사항인 경우
        if (old_i == 1) {

            document.getElementById("iframe_tab_"+old_u).contentWindow.document.getElementById("ENO_NO").value = ENO_NO;
            document.getElementById("iframe_tab_"+old_u).contentWindow.fnc_SearchList();

            if (iCount > 0) {
                document.getElementById("resultMessage").innerText = '';
            }

            // 사번 초기화
            for (i = 1; i <= 3; i++) {

                if (i != old_u && document.getElementById("iframe_tab_"+i).src != "about:blank") {

                    document.getElementById("iframe_tab_"+i).contentWindow.document.getElementById("ENO_NO").value = "";

                }
            }

        }
        else {

            //if (old_enono != ENO_NO) {

                document.getElementById("iframe_"+old_i).contentWindow.document.getElementById("ENO_NO").value = ENO_NO;
                document.getElementById("iframe_"+old_i).contentWindow.fnc_SearchList();
            //}

        }

        if (old_enono != ENO_NO) {
            old_enono = ENO_NO;
        }

    </Script>

    <Script For=dsT_ME_AHISTORY Event="OnLoadCompleted(iCount)">

		if (iCount == 0) {

			if(ahiflag == "SAV"){
				alert("저장이 완료되었습니다. 입사후경력을 입력해주세요.");
			}else if(ahiflag == "SHR"){
				alert("입사후경력이 없습니다. 입사후경력을 입력해주세요.");
			}
			ahiflag = "";

			fnc_ClickTab(7);

		} else {

		}

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_ME_PERSON Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <Script For=dsT_ME_AHISTORY Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ME_PERSON Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018 ) {
            alert("해당 필수입력항목[사번] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
            alert("사번에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_ME_PERSON event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_TabSave();

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_ME_PERSON event="OnFail()">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">인사기록정보</td>
                    <td align="right" class="navigator">HOME/인사관리/파견사원/<font color="#000000">인사기록정보</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="below">
                <tr>
                    <td></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="vsides">
                <colgroup>
                    <col width="140"></col>
                    <col width="75 "></col>
                    <col width="140"></col>
                    <col width="75 "></col>
                    <col width="140"></col>
                    <col width="90 "></col>
                    <col width="140"></col>
                </colgroup>
                <tr>
                    <td class="padding2423" colspan="7">
                        <!-- 탭 버튼 테이블 시작 -->
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                            <tr>
                                <td>
                                    <input type=button id="btnMEMA011" value="기본사항"         style="width:80pt;" onclick="fnc_ClickTab(1)">
                                    <input type=button id="btnMEMA015" value="학력사항"         style="width:80pt;" onclick="fnc_ClickTab(2)">
                                    <!-- <input type=button id="btnMEMA023" value="병무사항"         style="width:49pt;" onclick="fnc_ClickTab(3)"> -->
                                    <!-- <input type=button id="btnMEMA016" value="가족사항"         style="width:49pt;" onclick="fnc_ClickTab(4)"> -->
                                    <!-- <input type=button id="btnMEMA017" value="자격면허"         style="width:49pt;" onclick="fnc_ClickTab(5)"> -->
                                    <!-- <input type=button id="btnMEMA018" value="입사전경력"       style="width:52pt;" onclick="fnc_ClickTab(6)"> -->
                                    <input type=button id="btnMEMA019" value="입사후경력"       style="width:80pt;" onclick="fnc_ClickTab(7)">
                                    <input type=button id="btnMEMA020" value="용역비변경"       style="width:80pt;" onclick="fnc_ClickTab(8)">
                                    <input type=button id="btnMEMA021" value="교육사항"         style="width:80pt;" onclick="fnc_ClickTab(9)">
                                    <input type=button id="btnMEMA022" value="계약변경"         style="width:80pt;" onclick="fnc_ClickTab(10)">
                                    <input type=button id="btnPIRA032" value="사번생성"         style="width:80pt;" onclick="fnc_ClickTab(11)">
                                </td>
                            <tr>
                        </table>
                        <!-- 탭 버튼 테이블 끝 -->
                    </td>
                </tr>
                <tr>
                    <td align="center" rowspan="7"><img id="viewImage" src="init" border="0" width="125" height="167" onerror="this.src='/images/common/none.jpg';"></td>
                    <td align="center" class="creamBold">사&nbsp;&nbsp;&nbsp;&nbsp;번</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" size="10" maxlength="8" style="width:100%;ime-mode:disabled" onChange="fnc_chkEnoNo();" onKeyPress="JavaScript: cfNumberCheck();if (event.keyCode == 13) {document.getElementById('btnMEMA011').focus(); fnc_SearchList();}">
                    </td>
                    <td align="center" class="creamBold">국문성명</td>
                    <td class="padding2423">
                        <input id="txtENO_NM" maxlength="12" style="width:78%; ime-mode: active" onKeyPress="JaveScript: if (event.keyCode == 13) {fnc_UsrGetEnoNo();}">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()"></a>
                    </td>
                    <td align="center" class="creamBold">한자성명</td>
                    <td class="padding2423">
                        <input id="txtNAM_CHI" maxlength="12" style="width:100%">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">생년월일</td>
                    <td class="padding2423">
                        <input id="txtBIR_YMD" style="width:51%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '생년월일');"  onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgBirYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgBirYmd" name="ImgBirYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtBIR_YMD','','145','125');"></a>
                        <input id="txtAge" style="width:14%" class="input_ReadOnly" readonly>세
                    </td>
                    <td align="center" class="creamBold">구&nbsp;&nbsp;&nbsp;&nbsp;분</td>
                    <td class="padding2423">
                        <select id="cmbBIR_TAG" style="width:100%" >
                            <option value="S">양력</option>
                            <option value="M" >음력</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">영문성명</td>
                    <td class="padding2423">
                        <input id="txtNAM_ENG" maxlength="20" style="width:100%">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">주민번호</td>
                    <td class="padding2423">    <input id="txtCET_NO" maxlength="14" style="width:100%;ime-mode:disabled" onKeyPress="JavaScript: cfCetNoHyphen(this);cfNumberCheck();" onChange="javascript : if (fnc_SsnValid(this) == true) {fnc_setMfTag();}"></td>
                    <td align="center" class="creamBold">성&nbsp;&nbsp;&nbsp;&nbsp;별</td>
                    <td class="padding2423">
                        <select id="cmbMF_TAG" style="width:100%" >
                            <option value="M">남자</option>
                            <option value="W" >여자</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">당사투입일</td>
                    <td class="padding2423">
                        <input id="txtHIR_YMD" style="width:78%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '당사투입일');" onkeypress="cfDateHyphen(this);cfCheckNumber();" onkeydown="if(event.keyCode==9){form1.txtTERM1_YMD.focus();event.returnValue=false;}">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHirYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgHirYmd" name="ImgHirYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtHIR_YMD','','630','150');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">본&nbsp;&nbsp;&nbsp;&nbsp;부</td>
                    <td class="padding2423">
                        <input id="txtHEAD_CD" style="width:15%" maxlength="2" class="input_ReadOnly"  readonly> <input id="txtHEAD_NM" style="width:80%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">직&nbsp;&nbsp;&nbsp;&nbsp;종</td>
                    <td class="padding2423">
                        <input id="txtOCC_CD" name="txtOCC_CD" style="width:15%" maxlength="2" class="input_ReadOnly"  readonly> <input id="txtOCC_NM" style="width:80%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">1차계약기간</td>
                    <td class="padding2423">
                        <input id="txtTERM1_YMD" style="width:78%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '1차계약기간');" onkeypress="cfDateHyphen(this);cfCheckNumber();" onkeydown="if(event.keyCode==9){form1.txtTERM2_YMD.focus();event.returnValue=false;}">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgTerm1Ymd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgTerm1Ymd" name="ImgTerm1Ymd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtTERM1_YMD','','630','175');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">소&nbsp;&nbsp;&nbsp;&nbsp;속</td>
                    <td class="padding2423">
                        <input id="txtDPT_CD" style="width:15%" maxlength="2" class="input_ReadOnly"  readonly> <input id="txtDPT_NM" style="width:80%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">직&nbsp;&nbsp;&nbsp;&nbsp;위</td>
                    <td class="padding2423">
                        <input id="txtJOB_CD" style="width:15%" maxlength="2" class="input_ReadOnly"  readonly> <input id="txtJOB_NM" style="width:80%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">2차계약기간</td>
                    <td class="padding2423">
                        <input id="txtTERM2_YMD" style="width:78%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '2차계약기간');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgTerm2Ymd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgTerm2Ymd" name="ImgTerm2Ymd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtTERM2_YMD','','630','205');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">&nbsp;&nbsp;&nbsp;팀&nbsp;&nbsp;&nbsp;</td>
                    <td class="padding2423">
                        <input id="txtTEAM_CD" style="width:15%" maxlength="2" class="input_ReadOnly"  readonly> <input id="txtTEAM_NM" style="width:80%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">직&nbsp;&nbsp;&nbsp;&nbsp;책</td>
                    <td class="padding2423">
                        <input id="txtDUTY_CD" style="width:15%" maxlength="2" class="input_ReadOnly"  readonly> <input id="txtDUTY_NM" style="width:80%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">지&nbsp;&nbsp;&nbsp;&nbsp;역</td>
                    <td class="padding2423">
                        <input id="txtREG_CD" style="width:15%" maxlength="2" class="input_ReadOnly"  readonly> <input id="txtREG_NM" style="width:80%" class="input_ReadOnly"  readonly>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 기본사항 시작 -->
<div id="view_1" style="border-style:solid;border-color:#999999;border-width:0;display:none">
<table width="800" height="285" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
    <tr><td align="center">
        <!-- 탭 버튼 테이블 시작 -->
        <table width="796" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="paddingTop5">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                        <tr>
                            <td align="left">
                                <input type=button id="btn1" value="인사기본2"      onclick="fnc_ViewFrameTab(1)">
                                <input type=button id="btn2" value="인사기본3"      onclick="fnc_ViewFrameTab(2)">
                                <input type=button id="btn3" value="인사기본4"      onclick="fnc_ViewFrameTab(3)">
                                <input type=hidden id="ENO_NO" size="10">
                            </td>
                        <tr>
                    </table>
                </td>
            </tr>
        </table>
        <!-- 탭 버튼 테이블 끝 -->

        <!-- 인사기본2 시작 -->
        <div id="view_tab_1" style="width:796;height:254;border-style:solid;border-color:#999999;border-width:1;display:none;">
        <iframe id="iframe_tab_1" src="about:blank" load_src="/hr/mem/mema011.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
        </div>
        <!-- 인사기본2 끝 -->

        <!-- 인사기본3 시작 -->
        <div id="view_tab_2" style="width:796;height:254;border-style:solid;border-color:#999999;border-width:1;display:none;">
        <iframe id="iframe_tab_2" src="about:blank" load_src="/hr/mem/mema012.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
        </div>
        <!-- 인사기본3 끝 -->

        <!-- 인사기본4 시작 -->
        <div id="view_tab_3" style="width:796;height:254;border-style:solid;border-color:#999999;border-width:1;display:none;">
        <iframe id="iframe_tab_3" src="about:blank" load_src="/hr/mem/mema013.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
        </div>
        <!-- 인사기본4 끝 -->

    </td></tr>
</table>
</div>
<!-- 인사기본2 끝 -->

<!-- 학력사항 시작 -->
<div id="view_2" style="width:800;height:285;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_2" src="about:blank" load_src="/hr/mem/mema014.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- 학력사항 끝 -->

<!-- 병무사항 시작 -->
<div id="view_3" style="width:800;height:100;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_3" src="about:blank" load_src="/hr/mem/mema015.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- 학력사항 끝 -->

<!-- 가족사항 시작 -->
<div id="view_4" style="width:800;height:285;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_4" src="about:blank" load_src="/hr/mem/mema016.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- 가족사항 끝 -->

<!-- 자격면허 시작 -->
<div id="view_5" style="width:800;height:285;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_5" src="about:blank" load_src="/hr/mem/mema017.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- 자격면허 끝 -->

<!-- 입사전경력 시작 -->
<div id="view_6" style="width:800;height:285;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_6" src="about:blank" load_src="/hr/mem/mema018.jsp" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- 입사전경력 끝 -->

<!-- 입사후경력 시작 -->
<div id="view_7" style="width:800;height:285;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_7" src="about:blank" load_src="/hr/mem/mema019.jsp" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- 입사후경력 끝 -->

<!-- 용역비변경내역 시작 -->
<div id="view_8" style="width:800;height:285;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_8" src="about:blank" load_src="/hr/mem/mema020.jsp" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- 용역비변경내역 끝 -->

<!-- 교육참여사항 시작 -->
<div id="view_9" style="width:800;height:285;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_9" src="about:blank" load_src="/hr/mem/mema021.jsp" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- 교육참여사항 끝 -->

<!-- 계약변경내역 시작 -->
<div id="view_10" style="width:800;height:285;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_10" src="about:blank" load_src="/hr/mem/mema022.jsp" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- 계약변경내역 끝 -->

<!-- 사번생성 시작 -->
<div id="view_11" style="width:800;height:294;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_11" src="about:blank" load_src="/hr/pir/pira032.jsp" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- 사번생성 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width=100%><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->

</form>
<!-- form 끝 -->

</body>
</html>

<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 달성도배점설정 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ME_PERSON">
    <Param Name="BindInfo", Value='
        <C>Col=ENO_NO         Ctrl=txtENO_NO      Param=value Disable=disabled</C>
        <C>Col=ENO_NM         Ctrl=txtENO_NM      Param=value </C>
        <C>Col=NAM_CHI        Ctrl=txtNAM_CHI     Param=value </C>
        <C>Col=BIR_YMD        Ctrl=txtBIR_YMD     Param=value </C>
        <C>Col=AGE            Ctrl=txtAGE         Param=value </C>
        <C>Col=BIR_TAG        Ctrl=cmbBIR_TAG     Param=value </C>
        <C>Col=NAM_ENG        Ctrl=txtNAM_ENG     Param=value </C>
        <C>Col=CET_NO         Ctrl=txtCET_NO      Param=value </C>
        <C>Col=MF_TAG         Ctrl=cmbMF_TAG      Param=value </C>
        <C>Col=HIR_YMD        Ctrl=txtHIR_YMD     Param=value </C>
        <C>Col=HEAD_CD        Ctrl=txtHEAD_CD     Param=value </C>
        <C>Col=HEAD_NM        Ctrl=txtHEAD_NM     Param=value </C>
        <C>Col=OCC_CD         Ctrl=txtOCC_CD      Param=value </C>
        <C>Col=OCC_NM         Ctrl=txtOCC_NM      Param=value </C>
        <C>Col=TERM1_YMD      Ctrl=txtTERM1_YMD   Param=value </C>
        <C>Col=TERM2_YMD      Ctrl=txtTERM2_YMD   Param=value </C>
        <C>Col=DPT_CD         Ctrl=txtDPT_CD      Param=value </C>
        <C>Col=DPT_NM         Ctrl=txtDPT_NM      Param=value </C>
        <C>Col=JOB_CD         Ctrl=txtJOB_CD      Param=value </C>
        <C>Col=JOB_NM         Ctrl=txtJOB_NM      Param=value </C>
        <C>Col=TEAM_CD        Ctrl=txtTEAM_CD     Param=value </C>
        <C>Col=TEAM_NM        Ctrl=txtTEAM_NM     Param=value </C>
        <C>Col=DUTY_CD        Ctrl=txtDUTY_CD     Param=value </C>
        <C>Col=DUTY_NM        Ctrl=txtDUTY_NM     Param=value </C>
        <C>Col=REG_CD         Ctrl=txtREG_CD      Param=value </C>
        <C>Col=REG_NM         Ctrl=txtREG_NM      Param=value </C>
    '>
</object>