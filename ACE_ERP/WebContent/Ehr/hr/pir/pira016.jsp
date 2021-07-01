<!--
    ************************************************************************************
    * @Source         : pira016.jsp                                                    *
    * @Description    : 학력사항 PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            이동훈            	ERP 이사											*
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>학력사항</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<%
      String ENO_NO = request.getParameter("ENO_NO");            //사번
%>

    <!--
    ******************************************************
    * 자바스크립트 함수 선언부분
    ******************************************************
    -->
    <script language="javascript" >

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            dsT_CM_SCHOOL.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira016.cmd.PIRA016CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_CM_SCHOOL.Reset();

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

                trT_CM_SCHOOL.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira016.cmd.PIRA016CMD&S_MODE=SAV";
                trT_CM_SCHOOL.post();

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
            if (dsT_CM_SCHOOL.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_CM_SCHOOL.RowStatus(dsT_CM_SCHOOL.RowPosition);

            //DataSet의 변경 여부 확인
            if (dsT_CM_SCHOOL.IsUpdated && status != 1) {
                alert("화면에 변경사항이 존재합니다.\n먼저 화면 내용을 저장하신 다음 작업하여 주십시오.");
                return false;
            }

            // 특정 컬럼의 값으로 삭제 여부를 물어 본다.
            if (confirm("학력구분[" + dsT_CM_SCHOOL.NameValue(dsT_CM_SCHOOL.RowPosition,"EDGR_NM") + "] 자료를 제거하시겠습니까?") == false) return;

            dsT_CM_SCHOOL.DeleteRow(dsT_CM_SCHOOL.RowPosition);

            if (status != 1) {

                trT_CM_SCHOOL.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira016.cmd.PIRA016CMD&S_MODE=DEL";
                trT_CM_SCHOOL.post();

            }

            bnd.ActiveBind = false;

            form1.grdT_CM_SCHOOL.SetColumn(form1.grdT_CM_SCHOOL.GetColumnID(0));
            form1.grdT_CM_SCHOOL.Focus();

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
            if (dsT_CM_SCHOOL.CountColumn == 0) {
                dsT_CM_SCHOOL.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, EDGR_CD:STRING:KEYVALUETYPE, EDGR_NM:STRING, GURS_YMD:STRING, GURE_YMD:STRING:KEYVALUETYPE, SCH_CD:STRING, SCH_NAM:STRING, MAJ_CD:STRING, MAJ_NM:STRING, MAJ_CD2:STRING, MAJ_NM2:STRING, GRD_CD:STRING:KEYVALUETYPE, GRD_NM:STRING");
            }

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_CM_SCHOOL.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_CM_SCHOOL.setColumn(form1.grdT_CM_SCHOOL.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;

            // KEY 필드는 신규시 입력 가능
            document.getElementById("txtEDGR_CD").disabled  = false;
            document.getElementById("txtGURE_YMD").disabled = false;
            document.getElementById("txtGRD_CD").disabled   = false;
            document.getElementById("ImgEdgrCd").disabled   = false;
            document.getElementById("ImgGrdCd").disabled    = false;
            document.getElementById("txtEDGR_CD").focus();

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

   			dsT_CM_SCHOOL.ClearData();
   			
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
            if (!dsT_CM_SCHOOL.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }

            for ( i = 1; i <= dsT_CM_SCHOOL.CountRow; i++ ) {
                if ( dsT_CM_SCHOOL.RowStatus(i) == 1 ||
                     dsT_CM_SCHOOL.RowStatus(i) == 3 ) {


                    // 학력구분
                    if( dsT_CM_SCHOOL.NameValue(i, "EDGR_CD") == '' ) {
                        alert("학력구분은 필수 입력사항입니다.");
                        dsT_CM_SCHOOL.RowPosition = i;
                        document.getElementById("txtEDGR_CD").focus();
                        return false;
                    }

                    // 학력구분
                    if (dsT_CM_SCHOOL.NameValue(i, "EDGR_CD") != "" &&
                        dsT_CM_SCHOOL.NameValue(i, "EDGR_NM") == "") {
                        alert("학교구분코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_CM_SCHOOL.RowPosition = i;
                        document.getElementById("txtEDGR_CD").focus();
                        return;
                    }

                    // 입학일 CHECK
                    if (dsT_CM_SCHOOL.NameValue(i, "GURS_YMD").length != 4 && dsT_CM_SCHOOL.NameValue(i, "GURS_YMD").length != 0) {
                        alert("입학년도는 숫자 4자리 입니다.");
                        dsT_CM_SCHOOL.RowPosition = i;
                        document.getElementById("txtGURS_YMD").focus();
                        return false;
                    }


                    if (dsT_CM_SCHOOL.NameValue(i, "GURE_YMD").length != 4) {
                    	alert("졸업년도(4자리)는 필수 입력사항입니다.");
                        dsT_CM_SCHOOL.RowPosition = i;
                        document.getElementById("txtGURE_YMD").focus();
                        return false;
                    }

					//학교명이 읽기전용이 아니라면 코드가 없이 이름만 있으면 저장이 된다.
					if(document.getElementById('txtSCH_NAM').readOnly == false){
						// 학력구분
	                    if( dsT_CM_SCHOOL.NameValue(i, "SCH_CD") == '' && dsT_CM_SCHOOL.NameValue(i, "SCH_NAM") == '') {
	                        alert("학교코드나 학교명은 필수 입력사항입니다.");
	                        dsT_CM_SCHOOL.RowPosition = i;
	                        document.getElementById("txtSCH_CD").focus();
	                        return false;
	                    }

	                    if(dsT_CM_SCHOOL.NameValue(i, "SCH_CD") != ""){
		                    if (dsT_CM_SCHOOL.NameValue(i, "SCH_CD") != "" &&
		                        dsT_CM_SCHOOL.NameValue(i, "SCH_NAM") == "") {
		                        alert("학교코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
		                        dsT_CM_SCHOOL.RowPosition = i;
		                        document.getElementById("txtSCH_CD").focus();
		                        return;
		                    }
	                    }

					}else{
						// 학력구분
	                    if( dsT_CM_SCHOOL.NameValue(i, "SCH_CD") == '' ) {
	                        alert("학교코드는 필수 입력사항입니다.");
	                        dsT_CM_SCHOOL.RowPosition = i;
	                        document.getElementById("txtSCH_CD").focus();
	                        return false;
	                    }

	                    // 학교코드
	                    if (dsT_CM_SCHOOL.NameValue(i, "SCH_CD") != "" &&
	                        dsT_CM_SCHOOL.NameValue(i, "SCH_NAM") == "") {
	                        alert("학교코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
	                        dsT_CM_SCHOOL.RowPosition = i;
	                        document.getElementById("txtSCH_CD").focus();
	                        return;
	                    }
					}

                    // 전공코드
                    if (dsT_CM_SCHOOL.NameValue(i, "MAJ_CD") != "" &&
                        dsT_CM_SCHOOL.NameValue(i, "MAJ_NM") == "") {
                        alert("전공코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_CM_SCHOOL.RowPosition = i;
                        document.getElementById("txtMAJ_CD").focus();
                        return;
                    }

                    // 복수전공코드
                    if (dsT_CM_SCHOOL.NameValue(i, "MAJ_CD2") != "" &&
                        dsT_CM_SCHOOL.NameValue(i, "MAJ_NM2") == "") {
                        alert("복수전공코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_CM_SCHOOL.RowPosition = i;
                        document.getElementById("txtMAJ_CD2").focus();
                        return;
                    }

                    // 졸업코드
                    if (dsT_CM_SCHOOL.NameValue(i, "GRD_CD") == "") {
                        alert("졸업코드는 필수 입력사항입니다.");
                        dsT_CM_SCHOOL.RowPosition = i;
                        document.getElementById("txtGRD_CD").focus();
                        return;
                    }

                    // 졸업코드
                    if (dsT_CM_SCHOOL.NameValue(i, "GRD_CD") != "" &&
                        dsT_CM_SCHOOL.NameValue(i, "GRD_NM") == "") {
                        alert("졸업코드에 입력하신 값은 존재하지 않는 코드입니다. 확인바랍니다.");
                        dsT_CM_SCHOOL.RowPosition = i;
                        document.getElementById("txtGRD_CD").focus();
                        return;
                    }

                    if ( dsT_CM_SCHOOL.RowStatus(i) == 1) {
                       document.getElementById("txtEDGR_CD").disabled  = true;
                       document.getElementById("txtGURE_YMD").disabled = true;
                       document.getElementById("txtGRD_CD").disabled   = true;
                       document.getElementById("ImgEdgrCd").disabled   = true;

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
            cfStyleGrid_New(form1.grdT_CM_SCHOOL, 15,"false","false");

            fnc_SearchList();

        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            //이곳에 해당 코딩을 입력 하세요
            if (dsT_CM_SCHOOL.IsUpdated)  {
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

        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

        /***************************************
         * 입력부의 컬럼의 Disabled 속성 바꿈  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            fnc_EdgrEnabled();

            // 해당 컬럼의 속성을 Enabled로 변경
            if (prop == 'E') {
                document.getElementById("txtEDGR_CD").disabled   = false;
                document.getElementById("txtGURS_YMD").disabled  = false;
                document.getElementById("txtGURE_YMD").disabled  = false;

                document.getElementById("ImgEdgrCd").disabled    = false;


            }
            else if (prop == 'D') {

                document.getElementById("txtEDGR_CD").disabled   = true;
                document.getElementById("txtGURS_YMD").disabled  = true;
                document.getElementById("txtGURE_YMD").disabled  = true;
                document.getElementById("txtSCH_CD").readonly    = true;
                document.getElementById("txtSCH_NAM").readonly   = true;
                document.getElementById("txtMAJ_CD").readonly    = true;
                document.getElementById("txtMAJ_CD2").readonly    = true;
                document.getElementById("txtGRD_CD").readonly    = true;

                document.getElementById("ImgEdgrCd").disabled    = true;
                document.getElementById("ImgSchCd").disabled     = true;
                document.getElementById("ImgMajCd").disabled     = true;


            }
        }

        function fnc_EdgrEnabled() {
            // 미입력시
            if (document.getElementById('txtEDGR_CD').value == "") {
                document.getElementById('txtSCH_CD').className  = '';
                document.getElementById('txtSCH_NAM').className = '';
                document.getElementById('txtSCH_CD').readOnly   = false;
                document.getElementById('txtSCH_NAM').readOnly  = false;
                document.getElementById('txtMAJ_CD').className  = '';
                document.getElementById('txtMAJ_CD').readOnly   = false;
                document.getElementById('txtMAJ_CD2').className  = '';
                document.getElementById('txtMAJ_CD2').readOnly   = false;
                document.getElementById('txtGRD_CD').className  = '';
                document.getElementById('txtGRD_CD').readOnly   = false;

                document.getElementById("ImgSchCd").disabled     = false;
                document.getElementById("ImgMajCd").disabled     = false;
                document.getElementById("ImgMajCd2").disabled     = false;
                document.getElementById("ImgGrdCd").disabled     = false;
            }
            // 미취학
            else if (document.getElementById('txtEDGR_CD').value == "0") {
                document.getElementById('txtSCH_CD').className  = 'input_ReadOnly';
                document.getElementById('txtSCH_NAM').className = 'input_ReadOnly';
                document.getElementById('txtSCH_CD').readOnly   = true;
                document.getElementById('txtSCH_NAM').readOnly  = true;
                document.getElementById('txtMAJ_CD').className  = 'input_ReadOnly';
                document.getElementById('txtMAJ_CD').readOnly   = true;
                document.getElementById('txtMAJ_CD2').className  = 'input_ReadOnly';
                document.getElementById('txtMAJ_CD2').readOnly   = true;
                document.getElementById('txtGRD_CD').className  = 'input_ReadOnly';
                document.getElementById('txtGRD_CD').readOnly   = true;

                document.getElementById("ImgSchCd").disabled     = true;
                document.getElementById("ImgMajCd").disabled     = true;
                document.getElementById("ImgMajCd2").disabled     = true;

            }
            // 초등학교, 중학교
            else if (document.getElementById('txtEDGR_CD').value == "1" ||
                       document.getElementById('txtEDGR_CD').value == "2") {
                document.getElementById('txtSCH_CD').className  = '';
                document.getElementById('txtSCH_NAM').className = '';
                document.getElementById('txtSCH_CD').readOnly   = false;
                document.getElementById('txtSCH_NAM').readOnly  = false;
                document.getElementById('txtMAJ_CD').className  = 'input_ReadOnly';
                document.getElementById('txtMAJ_CD').readOnly   = true;
                document.getElementById('txtMAJ_CD2').className  = 'input_ReadOnly';
                document.getElementById('txtMAJ_CD2').readOnly   = true;
                document.getElementById('txtGRD_CD').className  = '';
                document.getElementById('txtGRD_CD').readOnly   = false;

                document.getElementById("ImgSchCd").disabled     = false;
                document.getElementById("ImgMajCd").disabled     = true;
                document.getElementById("ImgMajCd2").disabled     = true;
                document.getElementById("ImgGrdCd").disabled     = false;
            }
            // 대학교
            else if (document.getElementById('txtEDGR_CD').value == "5" ||
                       document.getElementById('txtEDGR_CD').value == "6") {
                document.getElementById('txtSCH_CD').className  = '';
                document.getElementById('txtSCH_CD').readOnly   = false;
                document.getElementById('txtSCH_NAM').className = 'input_ReadOnly';
                document.getElementById('txtSCH_NAM').readOnly  = true;
                document.getElementById('txtMAJ_CD').className  = '';
                document.getElementById('txtMAJ_CD').readOnly   = false;
                document.getElementById('txtMAJ_CD2').className  = '';
                document.getElementById('txtMAJ_CD2').readOnly   = false;
                document.getElementById('txtGRD_CD').className  = '';
                document.getElementById('txtGRD_CD').readOnly   = false;

                document.getElementById("ImgSchCd").disabled     = false;
                document.getElementById("ImgMajCd").disabled     = false;
                document.getElementById("ImgMajCd2").disabled     = false;
                document.getElementById("ImgGrdCd").disabled     = false;
            }
            else {
                document.getElementById('txtSCH_CD').className  = '';
                document.getElementById('txtSCH_CD').readOnly   = false;
                document.getElementById('txtSCH_NAM').className = '';
                document.getElementById('txtSCH_NAM').readOnly  = false;
                document.getElementById('txtMAJ_CD').className  = '';
                document.getElementById('txtMAJ_CD').readOnly   = false;
                document.getElementById('txtMAJ_CD2').className  = '';
                document.getElementById('txtMAJ_CD2').readOnly   = false;
                document.getElementById('txtGRD_CD').className  = '';
                document.getElementById('txtGRD_CD').readOnly   = false;

                document.getElementById("ImgSchCd").disabled     = false;
                document.getElementById("ImgMajCd").disabled     = false;
                document.getElementById("ImgMajCd2").disabled     = false;
                document.getElementById("ImgGrdCd").disabled     = false;
            }
        }

        function fnc_EdgrCd() {
            fnc_commonCodePopup('txtEDGR_CD','txtEDGR_NM','학력구분','E1');

            document.getElementById('txtSCH_CD').value  = '';
            document.getElementById('txtSCH_NAM').value = '';
            document.getElementById('txtMAJ_CD').value  = '';
            document.getElementById('txtMAJ_NM').value  = '';
            document.getElementById('txtMAJ_CD2').value  = '';
            document.getElementById('txtMAJ_NM2').value  = '';
            document.getElementById('txtGRD_CD').value  = '';
            document.getElementById('txtGRD_NM').value  = '';

            fnc_EdgrEnabled();
        }

        function fnc_ChgEdgrCd() {

            fnc_GetCommNm('E1', 'txtEDGR_CD','txtEDGR_NM');

            document.getElementById('txtSCH_CD').value  = '';
            document.getElementById('txtSCH_NAM').value = '';
            document.getElementById('txtMAJ_CD').value  = '';
            document.getElementById('txtMAJ_NM').value  = '';
            document.getElementById('txtMAJ_CD2').value  = '';
            document.getElementById('txtMAJ_NM2').value  = '';
            document.getElementById('txtGRD_CD').value  = '';
            document.getElementById('txtGRD_NM').value  = '';

            fnc_EdgrEnabled();

        }

        function fnc_SchCd() {
            var EDGR_CD = document.getElementById("txtEDGR_CD").value;

            if (EDGR_CD == "") {
                alert("학력구분을 먼저 입력하여주시기 바랍니다.");
                document.getElementById("txtEDGR_CD").focus();
                return;
            }
            else if (EDGR_CD == "0") {
                return;
            }
            else if (EDGR_CD == "1") {
                fnc_commonCodePopup('txtSCH_CD','txtSCH_NAM','초등학교','E8');
            }
            else if (EDGR_CD == "2") {
                fnc_commonCodePopup('txtSCH_CD','txtSCH_NAM','중학교','E8');
            }
            else if (EDGR_CD == "3") {
                fnc_commonCodePopup('txtSCH_CD','txtSCH_NAM','고등학교','E2');
            }
            else if (EDGR_CD == "4") {
                fnc_commonCodePopup('txtSCH_CD','txtSCH_NAM','전문대','E3');
            }
            else if (EDGR_CD == "5") {
                fnc_commonCodePopup('txtSCH_CD','txtSCH_NAM','대학교','E4');
            }
            else if (EDGR_CD == "6" ||
                     EDGR_CD == "7" ||
                     EDGR_CD == "8" ) {
                fnc_commonCodePopup('txtSCH_CD','txtSCH_NAM','대학원','E5');
            }
        }

        function fnc_ChgSchCd() {
            var EDGR_CD = document.getElementById("txtEDGR_CD").value;

            if (EDGR_CD == "") {
                alert("학력구분을 먼저 입력하여주시기 바랍니다.");
                document.getElementById("txtEDGR_CD").focus();
                return;
            }
            else if (EDGR_CD == "0") {
                return;
            }
            else if (EDGR_CD == "1") {
                fnc_GetCommNm('E8', 'txtSCH_CD','txtSCH_NAM');
            }
            else if (EDGR_CD == "2") {
                fnc_GetCommNm('E8', 'txtSCH_CD','txtSCH_NAM');
            }
            else if (EDGR_CD == "3") {
                fnc_GetCommNm('E2', 'txtSCH_CD','txtSCH_NAM');
            }
            else if (EDGR_CD == "4") {
                fnc_GetCommNm('E3', 'txtSCH_CD','txtSCH_NAM');
            }
            else if (EDGR_CD == "5") {
                fnc_GetCommNm('E4', 'txtSCH_CD','txtSCH_NAM');
            }
            else if (EDGR_CD == "6" ||
                     EDGR_CD == "7" ||
                     EDGR_CD == "8" ) {
                fnc_GetCommNm('E5', 'txtSCH_CD','txtSCH_NAM');
            }
        }

        //학교명 수정시 학교코드 클리어
        function fnc_ClsSchCd(KeyCode) {

            if(KeyCode != 0  && KeyCode != 9  && KeyCode != 13 && KeyCode != 33 && KeyCode != 34 && KeyCode != 35 && KeyCode != 36 &&
               KeyCode != 37 && KeyCode != 39 && KeyCode != 38 && KeyCode != 40 && KeyCode != 45){
                document.getElementById('txtSCH_CD').value  = '';

            }


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
    | 2. 이름 : dsT_CM_SCHOOL                       |
    | 3. Table List : T_CM_SCHOOL                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_SCHOOL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CM_SCHOOL                       |
    | 3. Table List : T_CM_SCHOOL                   |
    +----------------------------------------------->
    <Object ID ="trT_CM_SCHOOL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_SCHOOL)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_SCHOOL Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_SCHOOL.CountRow);

            document.getElementById("txtEDGR_CD").disabled  = true;
            document.getElementById("txtGURE_YMD").disabled = true;
            document.getElementById("txtGRD_CD").disabled   = true;
            document.getElementById("ImgEdgrCd").disabled   = true;


        }

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_SCHOOL Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_SCHOOL Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018 ) {
            alert("해당 필수입력항목[학력구분/졸업일/졸업구분] 입력 후 다음 작업이 가능합니다.");
        }
        else if (this.ErrorCode == 50019) {
            alert("학력구분/입 학 일/졸업구분에 대한 중복값이 존재합니다. 확인바랍니다.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CM_SCHOOL event="OnSuccess()">

        var old_i = 0;

        // 재조회(인사기본2 를 재조회)
        old_i = parent.old_i;
        parent.old_i = 1;
        parent.fnc_SearchList();
        parent.old_i = old_i;

        fnc_SearchList();

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CM_SCHOOL event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_CM_SCHOOL Event="OnRowPosChanged(row)">

        var SysStatus = dsT_CM_SCHOOL.SysStatus(row);

        fnc_EdgrEnabled();

        if (SysStatus == 1) {
        	
            document.getElementById("txtEDGR_CD").disabled  = false;
            document.getElementById("txtGURE_YMD").disabled = false;
            document.getElementById("txtGRD_CD").disabled   = false;
            document.getElementById("ImgEdgrCd").disabled   = false;
            document.getElementById("ImgGrdCd").disabled    = false;

        }else {
        	
            document.getElementById("txtEDGR_CD").disabled  = true;
            document.getElementById("txtGURE_YMD").disabled = true;
            document.getElementById("txtGRD_CD").disabled   = true;
            document.getElementById("ImgEdgrCd").disabled   = true;

        }

    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body onload="fnc_OnLoadProcess();"> <!-- oncontextmenu="return false"-->

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>학력사항</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAdd','','../../images/button/btn_AddnewOver.gif',1)">  <img src="../../images/button/btn_AddnewOn.gif"  name="imgAdd"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">   <img src="../../images/button/btn_SaveOn.gif"    name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','../../images/button/btn_DeleteOver.gif',1)"><img src="../../images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="65 "></col>
                    <col width="140"></col>
                    <col width="65 "></col>
                    <col width="140"></col>
                    <col width="65 "></col>
                    <col width="120"></col>
                    <col width="65 "></col>
                    <col width="140"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">학력코드</td>
                    <td class="padding2423">
                        <input id="txtEDGR_CD" style="width:20%" maxlength="2" onChange="fnc_ChgEdgrCd();"> <input id="txtEDGR_NM" style="width:54%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEdgrCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEdgrCd" name="ImgEdgrCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_EdgrCd(); "></a>
                    </td>
                    <td align="center" class="blueBold">입학년도</td>
                    <td class="padding2423" >
                        <input id="txtGURS_YMD" style="width:78%;ime-mode:disabled" maxlength="4"  onkeypress="cfCheckNumber();">
                        <!--  //<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgGursYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgGursYmd" name="ImgGursYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtGURS_YMD','','335','53');"></a> -->
                    </td>
                    <td align="center" class="blueBold">졸업년도</td>
                    <td class="padding2423" >
                        <input id="txtGURE_YMD" style="width:78%;ime-mode:disabled" maxlength="4"  onkeypress="cfCheckNumber();">
                        <!--  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgGureYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgGureYmd" name="ImgGureYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtGURE_YMD','','600','53');"></a>  -->
                    </td>
                    <td align="center" class="blueBold">학교코드</td>
                    <td class="padding2423">
                        <input id="txtSCH_CD" style="width:20%" maxlength="3" onChange="fnc_ChgSchCd();"> <input id="txtSCH_NAM" style="width:54%" onkeydown="fnc_ClsSchCd(event.keyCode);">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSchCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgSchCd" name="ImgSchCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_SchCd()"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">전공코드</td>
                    <td class="padding2423">
                        <input id="txtMAJ_CD" style="width:20%" maxlength="3" onChange="fnc_GetCommNm('E6', 'txtMAJ_CD','txtMAJ_NM');"> <input id="txtMAJ_NM" style="width:54%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgMajCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgMajCd" name="ImgMajCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtMAJ_CD','txtMAJ_NM','전공','E6')"></a>
                    </td>
                    <td align="center" class="blueBold">복수전공</td>
                    <td class="padding2423">
                        <input id="txtMAJ_CD2" style="width:20%" maxlength="3" onChange="fnc_GetCommNm('E6', 'txtMAJ_CD2','txtMAJ_NM2');"> <input id="txtMAJ_NM2" style="width:54%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgMajCd2','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgMajCd2" name="ImgMajCd2" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtMAJ_CD2','txtMAJ_NM2','전공','E6')"></a>
                    </td>
                    <td align="center" class="blueBold">졸업코드</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtGRD_CD" style="width:25" maxlength="2" onChange="fnc_GetCommNm('E7', 'txtGRD_CD','txtGRD_NM');"> <input id="txtGRD_NM" style="width:69" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgGrdCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgGrdCd" name="ImgGrdCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtGRD_CD','txtGRD_NM','졸업구분','E7')"></a>
                    </td>
                    <input type=hidden   id="txtENO_NO" size="10">
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
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
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object id="grdT_CM_SCHOOL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:994px;height:300px;">
                            <param name="DataID"                  value="dsT_CM_SCHOOL">
                            <param name="Format"                  value="
                                <C> id={currow}        width=40   name='순번'         align=center show=false </C>
                                <C> id=EDGR_CD         width=40   name='코드'         align=center </C>
                                <C> id=EDGR_NM         width=80   name='학력구분'                  </C>
                                <C> id=GURS_YMD        width=80   name='입 학 일'     align=center </C>
                                <C> id=GURE_YMD        width=80   name='졸 업 일'     align=center </C>
                                <C> id=SCH_CD          width=40   name='코드'         align=center </C>
                                <C> id=SCH_NAM         width=120   name='학교'                      </C>
                                <C> id=MAJ_CD          width=40   name='코드'         align=center </C>
                                <C> id=MAJ_NM          width=120   name='전공'                      </C>
                                <C> id=MAJ_CD2         width=40   name='코드'         align=center </C>
                                <C> id=MAJ_NM2         width=120   name='복수전공'                  </C>
                                <C> id=GRD_CD          width=40  name='코드'         align=center </C>
                                <C> id=GRD_NM          width=120   name='졸업구분'                  </C>
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
<!-- 학력사항 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_SCHOOL">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=EDGR_CD       Ctrl=txtEDGR_CD      Param=value </C>
        <C> Col=EDGR_NM       Ctrl=txtEDGR_NM      Param=value </C>
        <C> Col=GURS_YMD      Ctrl=txtGURS_YMD     Param=value </C>
        <C> Col=GURE_YMD      Ctrl=txtGURE_YMD     Param=value </C>
        <C> Col=SCH_CD        Ctrl=txtSCH_CD       Param=value </C>
        <C> Col=SCH_NAM       Ctrl=txtSCH_NAM      Param=value </C>
        <C> Col=MAJ_CD        Ctrl=txtMAJ_CD       Param=value </C>
        <C> Col=MAJ_NM        Ctrl=txtMAJ_NM       Param=value </C>
        <C> Col=MAJ_CD2       Ctrl=txtMAJ_CD2      Param=value </C>
        <C> Col=MAJ_NM2       Ctrl=txtMAJ_NM2      Param=value </C>
        <C> Col=GRD_CD        Ctrl=txtGRD_CD       Param=value </C>
        <C> Col=GRD_NM        Ctrl=txtGRD_NM       Param=value </C>
    '>
</object>